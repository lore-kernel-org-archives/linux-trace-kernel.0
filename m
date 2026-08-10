Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F96D3F5BF5;
	Mon, 10 Aug 2026 17:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786384126; cv=none; b=q8YlvIZ8tRONcbzFD2UGkBSVF5cUOWD1Vr5jlRYiN8CONGZj1qOpEL6zZMhW6II5MFPzGfvCTJgHDaDijSGt4JaMw1hz0r3OJ7k6yKE2zOENZaJO3Q5XmiLnvo7h1tDY657o9kW3fTPCy7Bqt/NiQIHi3OMnqotbcF1m+eJ6qDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786384126; c=relaxed/simple;
	bh=8BzmtoyKMpx/MxyEulLqE0qaEqoigc1rMy34B23uRBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZwVLzEpqOrkkJdHoz6DXm9nET9zvoQCwlMixo8PZctoJw4gh305CjUNvsQp4xdForMbD/32G0VTq2jcLTewJLlslicBPctlQ0na1BRGhxQKIKe71kUhhcQlrpaBsjC6hua74vCpF5+BxzrT/eLGugjagDaxhMzPyKZxDy99Tn4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 90943A1CF8;
	Mon, 10 Aug 2026 17:48:41 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 0F8922F;
	Mon, 10 Aug 2026 17:48:38 +0000 (UTC)
Date: Mon, 10 Aug 2026 13:48:48 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Anubhav Shelat <ashelat@redhat.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Shivank Garg <shivankg@amd.com>, Ackerley Tng
 <ackerleytng@google.com>, Fuad Tabba <tabba@google.com>, Christian Brauner
 <brauner@kernel.org>, Sean Christopherson <seanjc@google.com>,
 "sashiko-bot@kernel.org" <sashiko-bot@kernel.org>
Subject: Re: [PATCH v2] tracefs: Add read-only eventfs filesystem at
 /sys/kernel/events
Message-ID: <20260810134848.791096af@gandalf.local.home>
In-Reply-To: <20260808131104.2ad18f65@robin>
References: <20260808131104.2ad18f65@robin>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: xm6yknt7o1zdt9j6fhbr5mndeh58n6wb
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 0F8922F
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/35QDQRe/Z6KJX3f3weKe9tErqSpBRWKs=
X-HE-Tag: 1786384118-867948
X-HE-Meta: U2FsdGVkX1+aLo701dK3WKw1eyWzd/G7ZK7PY2Z+g1fzoZzLvuzcm0jZ6NnEb10fjams8zsH3BwtSvWBvORhpEXzgLSz0rK1LiVh2JvcnjAv7bGb+TWYQeIAAyAogumji7luqkLZnny/gWeVLz5Z4WJ6aeEkYtXBbAAF3vShfdqtfDTcRMbFY4YcbABklzq3aif2Ar/stw3NfY/VvZ8FgYsPn+S8Jakxs6Xb8DEYVqwdESF8oqtILA076frKKDdOmjWWwkDD3TYlr4uLGVSTpH1eg+4+dMqMrNuIYR7XucBPgsQ2saruG5/XgBYcfaDFiNg0owrSteUFQghhHovXZAYKQeHMB+dAOnR7A71fGM9fLvg3bwKhsHxpzI+yRAC8TxVjpjSI5IZVyl+9RBwZyRCAhm1ePUHDfJPneMKE4BewSxczYz19XKA+S248ofhWfhbJR3I7pJjqSn0LNH8XTZOr84/340Icro5DI6TaDZ8=


Replying to Sashiko: https://sashiko.dev/#/patchset/20260808131104.2ad18f65%40robin

> --- Patch [1]: [PATCH v2] tracefs: Add read-only eventfs filesystem at /sys/kernel/events ---
> commit 29ceffbc05b0ff3121930ed049314a6007ea355b
> Author: Anubhav Shelat <ashelat@redhat.com>
> 
> tracefs: Add read-only eventfs filesystem at /sys/kernel/events
> 
> This commit introduces a new read-only pseudo-filesystem "eventfs" mounted
> at /sys/kernel/events that exposes trace event format and id files to
> unprivileged users. The eventfs file system reuses the existing
> eventfs_inode lazy-lookup infrastructure.
> 
> Link: https://patch.msgid.link/20260715135231.338535-4-ashelat@redhat.com
> 
> > diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
> > index 39c7a34531e8a..007cdf1a67f30 100644
> > --- a/fs/tracefs/event_inode.c
> > +++ b/fs/tracefs/event_inode.c
> 
> [ ... ]
> 
> > +int eventfs_create_events_ro_copy(const char *name, struct eventfs_inode *ei)
> > +{
> > +	struct dentry *dentry;
> > +	struct tracefs_inode *ti;
> > +	struct inode *inode;
> > +
> > +	dentry = eventfs_ro_get_root();
> > +	if (IS_ERR(dentry))
> > +		return PTR_ERR(dentry);
> > +
> > +	inode = d_inode(dentry);
> > +
> > +	INIT_LIST_HEAD(&ei->children);
> > +	INIT_LIST_HEAD(&ei->list);
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
> Does this code leak the dentry reference returned by eventfs_ro_get_root()?
> 
> Looking at eventfs_ro_get_root() in fs/tracefs/inode.c, it returns the dentry 
> using dget(eventfs_ro_mount->mnt_root). However, eventfs_create_events_ro_copy() 
> never calls dput(dentry) to balance the reference count, nor does it save the 
> dentry pointer to a global variable for later cleanup.

It's not really a leak. Yes it is not freed, but once allocated, it is never freed.
That's fine because it lasts for the remander of the boot and has only a
single instance.

The comment above assigning d_fsdata states this. I could add another
comment bave the eventfs_ro_get_root(). (I wonder if Sashiko will
understand it?)

> 
> > diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
> > index f3d6188a3b7b2..fd064d79d940e 100644
> > --- a/fs/tracefs/inode.c
> > +++ b/fs/tracefs/inode.c
> 
> [ ... ]
> 
> > +void eventfs_ro_put_root(void)
> > +{
> > +	simple_release_fs(&eventfs_ro_mount, &eventfs_ro_mount_count);
> > +}
> 
> Is eventfs_ro_put_root() ever called? 
> 
> This teardown function appears to be explicitly introduced to balance the 
> internal mount pin created by simple_pin_fs() in eventfs_ro_get_root(), but it 
> seems to remain completely unreferenced in the codebase.

Hmm, right. This was leftover from Anubhav's first patch that could fail
after the eventfs_ro_get_root(). This version does not fail so it doesn't
need this function. I'll remove it.

-- Steve
