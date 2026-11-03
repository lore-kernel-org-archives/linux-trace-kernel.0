Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793740787;
	b=XcPrQ5zu0XV2YdsIuNRdvqzi1B7JOUsLdzniS6sqFqjZ3Ip23Bd49hEVsp1VRKoygaNd
	 UVWRA6SbVEXM2WRQ/rf7PNtJQHrCvGMQrgcavqFhe4apJKT69WOlOXSJCLkao4wjjKHyo
	 Ma7Mt8xOszuvW/Hu1bCMYpmWn5qTJQ8lTt88zdgPlCy0JwkU+u3lXFlhUEdguRB80ioll
	 ESW3ju9NgQVdVs0C7svWOJaJOkRMjHK5SD4xRUq1ReZwkULpG2cB3L8DyZfdryF8sP2t4
	 vsgO6dYLy55q03/hM9EV7UYnw4D5DkRAmEA94A+aY8HNbhP3R5L6sOGeIIqijusqY4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793740787;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=cgiKafzwmYihiNEwwhuQW5e3Hs9aNQicS5r4I1jky/g=;
	b=gwx3Frd6v6nQqh4yFtCv4N9S4MOacIca+rF3VDoFZcuq3MsXijF3zfUOAdkUCi0Z89p3
	 u/wu/fkpDR8dFUcOTN9/0d+JgVAg51p/wZ3bQ31J/pGjCe7y4dFHqF76DfuLZhE2kTLTO
	 o7d28l1JRH4SYgit5pePw8Pj7zfGPzQNjnCjXxBSJounzOYa0cFWHg/ELylfXwmNEH/m9
	 7lwAL43f2RaDiNzr0v/MsbG+eFLaHbvUN1WgNU/HCjeVxiGk2tUdEkuGQkKZUoE0lxLwg
	 eZCJeo5PdraxD6MW6Qb8t8578U2pZ2B9vaCu8DaT023qesTZPngEJAde9Bbz1i4pczA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=RF9p6ibw;
	arc=none smtp.remote-ip=216.40.44.12
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4362606A31B
	for <linux-trace-kernel@vger.kernel.org>; Tue,  3 Nov 2026 21:19:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4362606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=RF9p6ibw
Received: from omf17.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 4BCAEA0544;
	Tue,  3 Nov 2026 21:19:44 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id 9DBF417;
	Tue,  3 Nov 2026 21:19:42 +0000 (UTC)
Date: Tue, 3 Nov 2026 16:19:41 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev, "Linux Trace Kernel"
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v6] tracefs: Add read-only eventfs filesystem at
 /sys/kernel/events
Message-ID: <20261103161941.21149df1@gandalf.local.home>
In-Reply-To: <sashiko-outbox-196018@kernel.org>
References: <20261103154159.1467e7b5@gandalf.local.home>
	<sashiko-outbox-196018@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 9DBF417
X-Stat-Signature: 8funx3m5dk1oiqfcxm5r5ycp5weqchf7
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/XnR1+LQgKkbIgS4FYIoGmVGU6Hz6PvJs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=cgiKafzwmYihiNEwwhuQW5e3Hs9aNQicS5r4I1jky/g=; b=RF9p6ibwrfDL3l9BUXF69Z0Ame9aBbKfZK4btoTbA9iKf3CWttk+uJ/biRzdaG9Y7I4SPKF4t034NYNXEQ1DMqsTV+zTkD3yYBA/Cb+eELM0brfl75Jh5EIBfppugDxtNZQ1s7ZdnZ14TAkiUwDKgb8Wb9ShdFA+l3Ib9B7IvGA=
X-HE-Tag: 1793740782-897667
X-HE-Meta: U2FsdGVkX1/mOHQKMrxxDO04Ep/Q9wxRPYj5M8bpDF1ptW3QcxpzvEfVM9TIXSTpQg8VpfAooDC8CVpM8WKMhEHqXnAFkp045kHCGbYTA24ifDc5H/qcn9CerSkhFSiVFBw+OwQbch2jUqyK0ytU5/6pWXCm+1CIS9U2I4U1tU2xcUdXS/Dc9v8G6u1rsLAFUZ39vAyrjelFHioBezfXrJDet1dnW1yttIgK/2J8TPp73FAajo8vhoRrYYWSgL2hNRHJungnkDtJOtNbaj5JGxZXcWbEaqXdB4W0mJ6ShQClkLtLGRYA8iww5mHPMzHFtqpnMM41UunHt5V0NnBuF7n9Iw/fb6O/

On Tue, 03 Nov 2026 20:55:22 +0000
sashiko-bot@kernel.org wrote:

> >  
> >  /**
> > @@ -521,14 +647,16 @@ lookup_file_dentry(struct dentry *dentry,
> >   * @dir: in which a lookup is being done
> >   * @dentry: file/dir dentry
> >   * @flags: Just passed to simple_lookup()
> > + * @ro: Denote if this is from a read-only eventfs
> >   *
> >   * Used to create dynamic file/dir with-in @dir, search with-in @ei
> >   * list, if @dentry found go ahead and create the file/dir
> >   */
> >  
> > -static struct dentry *eventfs_root_lookup(struct inode *dir,
> > -					  struct dentry *dentry,
> > -					  unsigned int flags)
> > +static struct dentry *__eventfs_root_lookup(struct inode *dir,
> > +					    struct dentry *dentry,
> > +					    unsigned int flags,
> > +					    bool ro)  
> 
> [Severity: Low]
> As reported by Sashiko on v5 [1], this isn't a bug, but since
> eventfs_root_lookup() was renamed to __eventfs_root_lookup(), should the
> function name in the kernel-doc comment header above it also be updated to
> __eventfs_root_lookup to avoid a W=1 kernel-doc warning?
> 

As I replied then, I'm going to keep it as is for now.

> [ ... ]
> 
> > @@ -837,6 +995,48 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
> >  	return ERR_PTR(-ENOMEM);
> >  }
> >  
> > +/**
> > + * eventfs_create_events_ro_copy - create a read-only events directory
> > + * @ei: The eventfs_inode to use to create a read-only copy from
> > + *
> > + * This function configures the eventfs filesystem root as a read-only
> > + * trace event directory using the existing eventfs_inode lazy-lookup
> > + * infrastructure.
> > + */
> > +int eventfs_create_events_ro_copy(struct eventfs_inode *ei)
> > +{
> > +	static struct dentry *dentry;
> > +	struct tracefs_inode *ti;
> > +	struct inode *inode;
> > +	int ret;
> > +
> > +	/* Can only be called once. */
> > +	if (dentry)
> > +		return -EBUSY;
> > +
> > +	/* Reference acquired but never freed */
> > +	dentry = eventfs_ro_get_root();
> > +	if (IS_ERR(dentry)) {
> > +		ret = PTR_ERR(dentry);
> > +		dentry = NULL;
> > +		return ret;
> > +	}
> > +
> > +	inode = d_inode(dentry);
> > +
> > +	ti = get_tracefs(inode);
> > +	ti->flags |= TRACEFS_EVENT_INODE;
> > +	ti->private = ei;  
> 
> [Severity: Medium]
> As reported by Sashiko on v4 [2], should eventfs_create_events_ro_copy()
> also set TRACEFS_RO_EVENT_INODE in ti->flags on the root inode?

Well, it couldn't have been reported in v4 as that flag was just added in v6 ;-)

> 
> In eventfs_ro_fill_super(), the root inode is allocated via new_inode(sb),
> which calls tracefs_alloc_inode() and places the root tracefs_inode on the
> global tracefs_inodes list. Because TRACEFS_RO_EVENT_INODE is only set on
> child inodes in eventfs_get_inode(), remounting tracefs with uid= or gid=
> mount options (once the bitwise check in tracefs_apply_options() is fixed)
> will still match the pinned /sys/kernel/events root inode, overwrite its
> i_uid and i_gid, and redundantly call eventfs_remount() on the global
> events tree.

But sure. I'll add it to the root inode too.


> 
> > diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
> > index f3d6188a3b7b2..f895ee9ed4540 100644
> > --- a/fs/tracefs/inode.c
> > +++ b/fs/tracefs/inode.c
> > @@ -341,6 +341,14 @@ static int tracefs_apply_options(struct super_block *sb, bool remount)
> >  		srcu_idx = eventfs_remount_lock();
> >  		rcu_read_lock();
> >  		list_for_each_entry_rcu(ti, &tracefs_inodes, list) {
> > +
> > +			/*
> > +			 * Ignore read-only eventfs inodes as they are not
> > +			 * part of tracefs.
> > +			 */
> > +			if (ti->flags | TRACEFS_RO_EVENT_INODE)
> > +				continue;  
> 
> [Severity: Medium]
> Should this check in tracefs_apply_options() use a bitwise AND (&) instead
> of a bitwise OR (|)?

Ug! My mind said '&' but my fingers typed '|' :-p

OK, v7 coming up.

-- Steve
