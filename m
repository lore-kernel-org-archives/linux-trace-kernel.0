Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB95210E7;
	Mon, 10 Jun 2024 20:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718051753; cv=none; b=Kxrlc1T/zmcHMLclzDFmCO+hmsGC9tgwEhGO1cTtqHV32or062SxVrd3Mh2v6mJUS5knF4Kxe/1bnxM+gfYND/6l/CZzfwd1rpMNrqkmVpezfeygd5rD28sM1aqfMvKyWsRgozJl9nSMPu2b9+RsQ4ZptFb6AR6Di28+6hJYqMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718051753; c=relaxed/simple;
	bh=8h+HeseX3jlzuJIdwlgBh0FhC5FsZDxHURzF2CXuxKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QCAYzCCg/9wCQ+of/uo4sf4UKDoZVvFqQM84GUu8s9Q4QcewtOUg72rQHyC8jdFmHoHylbCiv3LkIXSMjBO5UcpdwLiaZBEn5825q9w/aOawTy1z4axpdFQ2SvtYuojPIOLUhhCeMa9oFlPYUqV8r/fW2XtfY3kW7CFgO8peq18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C0AC2BBFC;
	Mon, 10 Jun 2024 20:35:52 +0000 (UTC)
Date: Mon, 10 Jun 2024 16:36:06 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Julia Lawall <Julia.Lawall@inria.fr>, kernel-janitors@vger.kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 05/14] tracefs: replace call_rcu by kfree_rcu for simple
 kmem_cache_free callback
Message-ID: <20240610163606.069d552a@gandalf.local.home>
In-Reply-To: <b647eacd-f6f3-4960-acfd-36c30f376995@paulmck-laptop>
References: <20240609082726.32742-1-Julia.Lawall@inria.fr>
	<20240609082726.32742-6-Julia.Lawall@inria.fr>
	<20240610112223.151faf65@rorschach.local.home>
	<b647eacd-f6f3-4960-acfd-36c30f376995@paulmck-laptop>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Jun 2024 08:46:42 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> > > index 7c29f4afc23d..338c52168e61 100644
> > > --- a/fs/tracefs/inode.c
> > > +++ b/fs/tracefs/inode.c
> > > @@ -53,14 +53,6 @@ static struct inode *tracefs_alloc_inode(struct super_block *sb)
> > >  	return &ti->vfs_inode;
> > >  }
> > >  
> > > -static void tracefs_free_inode_rcu(struct rcu_head *rcu)
> > > -{
> > > -	struct tracefs_inode *ti;
> > > -
> > > -	ti = container_of(rcu, struct tracefs_inode, rcu);
> > > -	kmem_cache_free(tracefs_inode_cachep, ti);  
> > 
> > Does this work?
> > 
> > tracefs needs to be freed via the tracefs_inode_cachep. Does
> > kfree_rcu() handle specific frees for objects that were not allocated
> > via kmalloc()?  
> 
> A recent change to kfree() allows it to correctly handle memory allocated
> via kmem_cache_alloc().  News to me as of a few weeks ago.  ;-)

If that's the case then:

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Do we have a way to add a "Depends-on" tag so that anyone backporting this
will know that it requires the change to whatever allowed that to happen?

Or we need to update the change log to explicitly state that this should
*not* be backported.

-- Steve
