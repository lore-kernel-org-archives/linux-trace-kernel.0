Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1C2353A69;
	Tue, 11 Aug 2026 01:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786412185; cv=none; b=M6fFJESaz9fa1VwV9mYxUwRUdQQOVTv/z1LkRyyeFTVWChLITgSqUF2XB/NFXM+UZXK9ZZKYN7+GjmymKGgbLW7UkxTwT5Ty2vpBn/AS3iH+yNugXLqgTZIm17tjkCUknaAOshs4aclcT09ofeS8yv+kKIe8C9yYlGLvPoaYkiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786412185; c=relaxed/simple;
	bh=m/VPbdO07Z3jekwG4XMIfiYts5V1NZOiHwTEUcbAjW8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GP6i/XMSrEk7tx7zk+X7ssCbBGr42pLCsagNuxyee7NrmZlQzeqn6km4m4MZinZFFs66awfTLTWF4XU1cU0QDWKpXdt0ETlNUashvpQFAu1g9kr2BsgTT/s3uEq3UNChDZhc+TVic3w1epdmuMepay2RR1FIJ0799TKxTzAi36A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rostedt.org; spf=pass smtp.mailfrom=rostedt.org; dkim=pass (2048-bit key) header.d=rostedt.org header.i=@rostedt.org header.b=rBwpq+Ve; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kQaiwHLd; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rostedt.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rostedt.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rostedt.org header.i=@rostedt.org header.b="rBwpq+Ve";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kQaiwHLd"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id A1079EC020B;
	Mon, 10 Aug 2026 21:36:13 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 10 Aug 2026 21:36:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rostedt.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1786412173;
	 x=1786498573; bh=tKDc013ly+p8+ush74Rr3TPRjkqkX9vSjkn4nORqMJs=; b=
	rBwpq+VeVvDASN7S1ZdE4jG8GgC270Mjof3XRSK8iyYFNDAWWC7rs7s0RQ1fWub6
	RojE4ByQ/oZb+W3/Ds2i7rHnqur95WXX1SQialROXf3zo1RcllSF9koS3q6DrZtc
	J5OhDxUgoyRdf98P0WfaklpS/gEdZUGnX/O50f71FLaHi7YPdiU+9u+9cQCwS2TP
	b+YGEV0uIvmAMbbytlDfU2sNXBr8etTJfd5nXvaNPUKn+j3xEj5vD0SVrf2fXMu5
	7UM8NlhuwWagbbRI2sVVgouoIHvi/53mP1KdYDRdrp5rMZELe+PCVqalkgLxtMwE
	AugfCIlpp/oAn2I5UGJoqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786412173; x=
	1786498573; bh=tKDc013ly+p8+ush74Rr3TPRjkqkX9vSjkn4nORqMJs=; b=k
	QaiwHLd/xBp/xOS48vo88JicsWZy4v1T5Rq2bakF/46rj0oUZhqSWOJ8Wir63FaJ
	FynmCinulk6vV4hpcIRfWdqqJuGSxwAFktLQCJiH4IXnwV6f5ogZqPudIjI4+uvT
	p2LPFhiKd72yTa7SS9HcWG7+iij4xIe1IoXvxOkbCL4YAC/QaSeqtqhzH75FMY6K
	8iNsynesMC7KlduQuOVzJWdYil9BuC3xNQNIGIU78MMICDGefp0skVfKzXJwDO+g
	YQVgY8TMWBEW79mW7j19Zem5QFn/3TcutxUytEFs4dHfTTRb2GPtZ7ZeHWnzk1LB
	fhHFonLbtkz8RLep2d5Kw==
X-ME-Sender: <xms:jXx6agPzsQMhSaSvoNsvUwVyipuj8r35GYBkHQaOuUw3VicGrlNicw>
    <xme:jXx6ar7faSHdC-AXqqvVpUoLwQ3i-mNEO5DG2zaPJ2kXUkO8uZLmfxtZCbnuCKMtO
    IdX-Lgvhf8Yb4Va6-G0qZ92bWKT4NaJXSGPa-bLyg-mnHly-U8LIFA>
X-ME-Received: <xmr:jXx6argnweFFfrKTv_HzvSx1hOAr6MjYlSFuAybcxqPBNP9adOM1-UQ>
X-ME-Proxy-Cause: dmFkZTGE3T6Pbh98+sS3J9kX/F9hqhHQnYJZJ8otf13jn2Z3qm8JiZXQKFfQW8Uxol1aSW
    mEZxoeN7UsretqcljxiiPWggEq7C3QsJtWXmZPTFQ8imtI6q2qRQpDm6al9AIpsD1cW/wZ
    3vWyIOqGYmUG1h6cAZCaOFCDcgjqw+poHoL2E6MPcN2v7p08Vm+2lOri7QsElnWcBKMZi9
    TyV+Z1D6MxkZaZ08SjdCFVoaDcJDTUIlFXO1oO/m4eeLYvz7ixwPAGSfZ6dNF/zVFcr0LL
    BgASWsF/2p2fo391ujA7affawiHZuLr9kSW1ie3jv7eZ2dxosM00m2HocA4zkZMIqLaApJ
    pZSamtLF+Zg5ywkMhE3c0ROrQ7Zs6Rc8biFWw+a2TBQdBk8HAr45HXlrPGUBALeHJcNnxe
    xrVq3SWcW1Dwmt7pWOKq63PNKlvu1OwF3xkL5Kf/gwV9yHPfkxjmQcQ/Ho/99GymNsK9jb
    5+fmA4WC2AUwKmL/EWhW3W0moEuG55DAFUsyBAX1JGlXMAHhR5nnMoVFOhdJPu+Shu34ws
    XRIpz/otlQXnr5MFEFcjb+Tmw6Yl2go/EJgILFlUrLJNC+wO1hXBP7xFbDjHps5KTFVr0w
    q0P42Z/jiSbjQGKaA/Pgr8+Ks3tnI6x122DLj4gam2XklOOSqkbIe3pRr78w
X-ME-Proxy: <xmx:jXx6aofvLugnv5vgVsA8DXh4lZJihtuB9ncleLLvqFQvjbo9a2ELZw>
    <xmx:jXx6arxCqrK3p_TMSArksvbe_5mXErusBcZ7mmza4jZmKb9p7pg5sw>
    <xmx:jXx6av04jw_X9h68oQFBIn4iTy7P3vV7M0LcQBnBcYNZJgVKvba_ZQ>
    <xmx:jXx6apzKELBBa4AJynneVu9eiIrUzftFQOYzCt8Ho5WObDEiQ4-ngg>
    <xmx:jXx6atfTFK3aM1p_HUPyDVPCBrC8vgrVlOsXLhfY3B-YXwhy4vym0OGW>
Feedback-ID: id06e481b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Aug 2026 21:36:12 -0400 (EDT)
Date: Mon, 10 Aug 2026 21:36:11 -0400
From: Steven Rostedt <steven@rostedt.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Anubhav Shelat <ashelat@redhat.com>,
 Shivank Garg <shivankg@amd.com>, Ackerley Tng <ackerleytng@google.com>,
 Fuad Tabba <tabba@google.com>, Christian Brauner <brauner@kernel.org>, Sean
 Christopherson <seanjc@google.com>
Subject: Re: [PATCH v3] tracefs: Add read-only eventfs filesystem at
 /sys/kernel/events
Message-ID: <20260810213611.5e6f3d13@robin>
In-Reply-To: <20260811102818.1f2f51a6c9277d2f1c054e7a@kernel.org>
References: <20260810160708.3460a2fd@gandalf.local.home>
	<20260811102818.1f2f51a6c9277d2f1c054e7a@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Aug 2026 10:28:18 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Hi Steve,
> 
> I have some comments on this.
> 
> On Mon, 10 Aug 2026 16:07:08 -0400
> Steven Rostedt <steven@rostedt.org> wrote:
> 
> > @@ -551,20 +643,40 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
> >  		if (strcmp(name, entry->name) != 0)
> >  			continue;
> >  
> > +		if (ro && !entry->read_only)
> > +			return NULL;
> > +
> >  		data = ei->data;
> >  		if (entry->callback(name, &mode, &data, &fops) <= 0)
> >  			return NULL;
> >  
> > +		if (ro)
> > +			mode |= 0444;  
> 
> Don't we need to clear writable bits? e.g.
> 
> 	mode = (mode & ~0222) | 0444;

Sure.

> 
> [...]
> > @@ -812,6 +937,52 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
> >  	return ERR_PTR(-ENOMEM);
> >  }
> >  
> > +/**
> > + * eventfs_create_events_dir_ro - create a read-only events directory
> > + * @name: The name of the top level directory to create.
> > + * @entries: A list of entries that represent the files under this directory
> > + * @size: The number of @entries
> > + * @data: The default data to pass to the files (an entry may override it).  
> 
> This document need to be updated too. It should be "eventfs_create_events_ro_copy"
> and only takes @name and @ei.

Bah, I thought I fixed that. I may have but lost the changes in a rebase.

> 
> > + *
> > + * This function configures the eventfs filesystem root as a read-only
> > + * trace event directory using the existing eventfs_inode lazy-lookup
> > + * infrastructure.
> > + *
> > + * See eventfs_create_dir() for use of @entries.
> > + */
> > +int eventfs_create_events_ro_copy(const char *name, struct eventfs_inode *ei)
> > +{
> > +	static struct dentry *dentry;
> > +	struct tracefs_inode *ti;
> > +	struct inode *inode;
> > +
> > +	/* Can only be called once. */
> > +	if (dentry)
> > +		return -EBUSY;
> > +
> > +	/* Reference acquired but never freed */
> > +	dentry = eventfs_ro_get_root();
> > +	if (IS_ERR(dentry))
> > +		return PTR_ERR(dentry);
> > +
> > +	inode = d_inode(dentry);
> > +
> > +	INIT_LIST_HEAD(&ei->children);
> > +	INIT_LIST_HEAD(&ei->list);  
> 
> Nit: This seems redundant because those lists are initialized in
> event_create_events_dir() already, and here we initialize again.
> Currently, there is no chance to add anything on these lists.
> (But if we add something on these lists, re-initializing will
> make the items orphaned silently.)

Nice catch. I'll fix it.

I also found some other issues with the superblock setup. This isn't
going to go into the next merge window as it's too late.

Thanks for looking at it,

-- Steve


> 
> > +
> > +	ti = get_tracefs(inode);
> > +	ti->flags |= TRACEFS_EVENT_INODE;
> > +	ti->private = ei;
> > +
> > +	inode->i_op = &eventfs_ro_dir_inode_operations;
> > +	inode->i_fop = &eventfs_ro_file_operations;
> > +
> > +	/* This is never freed */
> > +	dentry->d_fsdata = get_ei(ei);
> > +
> > +	return 0;
> > +}  
> 
> Thanks,
> 

