Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0999637F727;
	Tue, 11 Aug 2026 01:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786411705; cv=none; b=ctukbYvOOqZOP822fY7Ie77ig9EbJPOeCuni7Ya1cvzdhj5e+lXBe+3IE3jAyAtI0+wssoN+hDUbH7HHZ95IMwEev+zYEV+euoPHD6zfI2iNvgLuWKHn8d4mpeI5H556s5TmiboNTXtfWwwMGZaFZJEuLUYUroCbque4KWb2Ze8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786411705; c=relaxed/simple;
	bh=zMjVcXG6aLAwZVvNbudHDGL0eEfC16VhUg4ZNw944O0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Fi+BxWmPCiPB2pdx3Gn2/aTDVBdR3XTp/BXS4CX2hyb6BkdBOiUdc81eeNuxWD02Vmp/5b6P0HlZF3PsAXuJF9afRHGhpDaR/oVgUhlXznlnbQCu3gAd2itZZvCevnivnQtPoe5Djw4VWfJAe3L/nwS7K1iIlGRTKbrNfH7c1rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hsMasOE4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hsMasOE4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE0DA1F000E9;
	Tue, 11 Aug 2026 01:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786411703;
	bh=8vDV3Dt58+dfUjVAnu8/a36uMZSLIKmboTCAP+k6ulw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hsMasOE48y07ywYq/O7ZxQKeehRFM0VcL2AvJ8lm/Vr++//sVHdikGzbq6ZL9mk6x
	 ogRu5eYuWLqCt/UHUT/GSuhmjdDcKMg9nFm+nSNG9TLsWEtas2zj36muBQAbGlDyqg
	 qxR1aw9Z4MY2uOtEJatX3/6I0C8TFtULjTUxt9H4iOWs56/5QzNlcUhw5apyz9bTVf
	 8cfIMsgbeti49hL2RM101oL0nN4OrZqa3RTsJ7fMYiTy/PeqS5a4FP1ul7+Azy8p/C
	 w7bQf3xAlW36yDRzh28MGenpsGZjbe7d+Xw+yTRnGdQNqMfq5KGiFI/ndfPeL9Esib
	 rCjJJOLI9xcmg==
Date: Tue, 11 Aug 2026 10:28:18 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <steven@rostedt.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Anubhav Shelat <ashelat@redhat.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Shivank Garg <shivankg@amd.com>,
 Ackerley Tng <ackerleytng@google.com>, Fuad Tabba <tabba@google.com>,
 Christian Brauner <brauner@kernel.org>, Sean Christopherson
 <seanjc@google.com>
Subject: Re: [PATCH v3] tracefs: Add read-only eventfs filesystem at
 /sys/kernel/events
Message-Id: <20260811102818.1f2f51a6c9277d2f1c054e7a@kernel.org>
In-Reply-To: <20260810160708.3460a2fd@gandalf.local.home>
References: <20260810160708.3460a2fd@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Steve,

I have some comments on this.

On Mon, 10 Aug 2026 16:07:08 -0400
Steven Rostedt <steven@rostedt.org> wrote:

> @@ -551,20 +643,40 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
>  		if (strcmp(name, entry->name) != 0)
>  			continue;
>  
> +		if (ro && !entry->read_only)
> +			return NULL;
> +
>  		data = ei->data;
>  		if (entry->callback(name, &mode, &data, &fops) <= 0)
>  			return NULL;
>  
> +		if (ro)
> +			mode |= 0444;

Don't we need to clear writable bits? e.g.

	mode = (mode & ~0222) | 0444;

[...]
> @@ -812,6 +937,52 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
>  	return ERR_PTR(-ENOMEM);
>  }
>  
> +/**
> + * eventfs_create_events_dir_ro - create a read-only events directory
> + * @name: The name of the top level directory to create.
> + * @entries: A list of entries that represent the files under this directory
> + * @size: The number of @entries
> + * @data: The default data to pass to the files (an entry may override it).

This document need to be updated too. It should be "eventfs_create_events_ro_copy"
and only takes @name and @ei.

> + *
> + * This function configures the eventfs filesystem root as a read-only
> + * trace event directory using the existing eventfs_inode lazy-lookup
> + * infrastructure.
> + *
> + * See eventfs_create_dir() for use of @entries.
> + */
> +int eventfs_create_events_ro_copy(const char *name, struct eventfs_inode *ei)
> +{
> +	static struct dentry *dentry;
> +	struct tracefs_inode *ti;
> +	struct inode *inode;
> +
> +	/* Can only be called once. */
> +	if (dentry)
> +		return -EBUSY;
> +
> +	/* Reference acquired but never freed */
> +	dentry = eventfs_ro_get_root();
> +	if (IS_ERR(dentry))
> +		return PTR_ERR(dentry);
> +
> +	inode = d_inode(dentry);
> +
> +	INIT_LIST_HEAD(&ei->children);
> +	INIT_LIST_HEAD(&ei->list);

Nit: This seems redundant because those lists are initialized in
event_create_events_dir() already, and here we initialize again.
Currently, there is no chance to add anything on these lists.
(But if we add something on these lists, re-initializing will
make the items orphaned silently.)

> +
> +	ti = get_tracefs(inode);
> +	ti->flags |= TRACEFS_EVENT_INODE;
> +	ti->private = ei;
> +
> +	inode->i_op = &eventfs_ro_dir_inode_operations;
> +	inode->i_fop = &eventfs_ro_file_operations;
> +
> +	/* This is never freed */
> +	dentry->d_fsdata = get_ei(ei);
> +
> +	return 0;
> +}

Thanks,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
