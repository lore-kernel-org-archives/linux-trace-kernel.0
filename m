Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793653463;
	b=pCTZlBYQo+Z9YAPX+fAd6L8p8R0L258BdlTV0MmMp6HEHNOdev5v8q13+96iiHclRKq6
	 oi94qH0XTGYKQtDcBcmF8T6cd3o0mGZc+QT9a9/QeIH2oVHfOHQogclJZVv0wj6EUTTsh
	 gkV/8JjnwvSK3sUappJ6q0QFy9UrHIdfpWdAZNXamBvffDk4Zn9J4qEf2jlCapeDplLBx
	 8WF7u5aMk89twq78Or4rz737b11V0nMKn6cbPHLgX/l7yyzkzFSSzlKSpArDBPtS66RYC
	 hfjy2H///eIl78Gjc1ZYdel3OgAJa5BuOjiCrc9o8FWDFeUTeHKMQz9HI8uA+dgydfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793653463;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id:X-Stat-Signature:
	 X-Spam-Status:X-Rspamd-Server:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=Lu/Edk/hEeIWELnkpeK8o79z0XChxvhzC8tYyyWT3uY=;
	b=ydn4EemRZx48CzlxLFsXRdU8tIqhxGvaWz1ZPaisU3Z2w5FWDfhh2hlLysOYU6PCzDqO
	 dllFHSNLmJkH9jebh8gsGpkR33PQts1TfqubPcnwvq/JSKbyL6Bz9/RFE5D6hVP/arM8b
	 gKRwlYxss7Gnj1WFnE9uDaV5UIetmOlTXG7vyU+ZSckDqPAISBsk0M62wVN6sQlzWb2SX
	 EGh3PNZz7gOXQ/kzIoowuX8UYhu4GxMwyei0pKRSYK2N+QCX3x4BaTgl9KnFwMA39Z79c
	 2pxwLhinazvDcssvtHCTinIYBpoQCr8H4fuhl/yKnu2CfsiE1Yp8FXZLxL0SYweYtCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=YkeOZMtC;
	arc=none smtp.remote-ip=216.40.44.11
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E451B606A327
	for <linux-trace-kernel@vger.kernel.org>; Mon,  2 Nov 2026 21:04:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E451B606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=YkeOZMtC
Received: from omf13.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id B014B1601E6;
	Mon,  2 Nov 2026 21:04:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id 24E7420011;
	Mon,  2 Nov 2026 21:04:20 +0000 (UTC)
Date: Mon, 2 Nov 2026 16:04:18 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev, "Linux Trace Kernel"
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] tracefs: Add read-only eventfs filesystem at
 /sys/kernel/events
Message-ID: <20261102160418.37659944@gandalf.local.home>
In-Reply-To: <sashiko-outbox-194145@kernel.org>
References: <20261102152748.614ddc8f@gandalf.local.home>
	<sashiko-outbox-194145@kernel.org>
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
X-Rspamd-Queue-Id: 24E7420011
X-Stat-Signature: hn9gimzddbrj1m643rrfpzsk4edkjueg
X-Rspamd-Server: rspamout08
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/an2PhxoYZBHR9JK7yBowawPipqRDY9v4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=Lu/Edk/hEeIWELnkpeK8o79z0XChxvhzC8tYyyWT3uY=; b=YkeOZMtC6oo6y1BSMJOsZSmkZGhdONHKlqhO6C8EmLDnq8J+RDuRhsd2OLX29G5DeR09wkQM7BWvsTpYCaQE6iK+KbqmjigqDQ9bcwFkrr+qp95093CfbsreBSKfcPqI5vCiXz5Y2a/sdaP0IQAUXDBitp3ROp+Uls22yTm2XpU=
X-HE-Tag: 1793653460-416114
X-HE-Meta: U2FsdGVkX18RCXJdbsan6eNFPeL+DYNiYyX6+mCLpldx/pgwtPiLYKb0lzzvKIfF5RSXeqIHlgZeCBVE9kdE6dexXJxE8+zy359J10LsFa2+wVAARPpF2nITKYTS80iZBFnVcRsi/qqEzvbdyiuYvn/bkFDcy6cepOf0d/lcOKhyYovHNHoamlO6WiOhw15KKTUkGdoVbE/0wXGRW2L8PW7KQdZ/4zz6Ebo4umVJiU0T0gx6AqBq6Bjn2YYdpn6Zw5Go8+uXj1vCmZPEE0T7s6enGfpfyfHGCDnv3wEhW42KUC0StEpMXu0tPtddWU3dkqqeqoDLz7Qzv1PLUj7QVWCB5urNL6hX

On Mon, 02 Nov 2026 20:44:51 +0000
sashiko-bot@kernel.org wrote:


> 
> > +static int eventfs_ro_get_tree(struct fs_context *fc)
> > +{
> > +	return get_tree_single(fc, eventfs_ro_fill_super);
> > +}
> > +
> > +static const struct fs_context_operations eventfs_ro_context_ops = {
> > +	.get_tree	= eventfs_ro_get_tree,
> > +};  
> 
> [Severity: Medium]
> Can a remount clear SB_RDONLY on the eventfs superblock?
> 
> eventfs_ro_fill_super() sets sb->s_flags |= SB_RDONLY, but
> eventfs_ro_context_ops does not define a .reconfigure callback. In
> reconfigure_super(), when fc->ops->reconfigure is NULL, VFS updates
> sb->s_flags directly from fc->sb_flags and fc->sb_flags_mask, so running
> mount -o remount,rw /sys/kernel/events will clear SB_RDONLY.
> 
> Because lookup_file() assigns eventfs_file_inode_operations (with
> .setattr = eventfs_set_attr) to regular files in eventfs, clearing
> SB_RDONLY allows chmod/chown on /sys/kernel/events files to mutate the
> shared ei->entry_attrs used by tracefs. Should eventfs_ro_context_ops
> provide a .reconfigure callback that rejects clearing SB_RDONLY (or should
> read-only file inodes omit .setattr)?

Ha! I wanted to handle this but wasn't sure how. Thank you Sashiko for
telling me about the .reconfigure() method that lets me prevent the
SB_RDONLY from being changed.


> 
> [ ... ]
> 
> > @@ -412,7 +499,7 @@ static struct dentry *lookup_file(struct eventfs_inode *parent_ei,
> >   * a eventfs_inode.
> >   */
> >  static struct dentry *lookup_dir_entry(struct dentry *dentry,
> > -	struct eventfs_inode *pei, struct eventfs_inode *ei)
> > +	struct eventfs_inode *pei, struct eventfs_inode *ei, bool ro)
> >  {
> >  	struct inode *inode;
> >  	umode_t mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
> > @@ -421,8 +508,13 @@ static struct dentry *lookup_dir_entry(struct dentry *dentry,
> >  	if (unlikely(!inode))
> >  		return ERR_PTR(-ENOMEM);
> >  
> > -	inode->i_op = &eventfs_dir_inode_operations;
> > -	inode->i_fop = &eventfs_file_operations;
> > +	if (ro) {
> > +		inode->i_op = &eventfs_ro_dir_inode_operations;
> > +		inode->i_fop = &eventfs_ro_file_operations;
> > +	} else {
> > +		inode->i_op = &eventfs_dir_inode_operations;
> > +		inode->i_fop = &eventfs_file_operations;
> > +	}  
> 
> [Severity: Low]
> This isn't a bug, but lookup_dir_entry() gained the @ro argument without a
> matching entry in its kernel-doc comment above.

Oops, I'll fix that in v5.

> 
> [ ... ]
> 
> > @@ -563,20 +656,44 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
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
> > +		/*
> > +		 * Read-only files gets all users read access,
> > +		 * but also should make sure this is not writable.
> > +		 */
> > +		if (ro)
> > +			mode |= (mode & ~0222) | 0444;  
> 
> [Severity: Medium]
> Should this use = instead of |= when updating mode?

Oops! Duh. Yeah that was a cut-and-paste bug.

> 
> Because |= ORs the right-hand side with the original value of mode,
> mode | (mode & ~0222) | 0444 simplifies to mode | 0444, leaving any write
> permission bits returned by entry->callback() intact.
> 
> > +
> >  		return lookup_file_dentry(dentry, ei, i, mode, data, fops);  
> 
> [Severity: Medium]
> Will permission or ownership changes in tracefs leak into the read-only
> eventfs mount through shared eventfs_attr and tracefs_inodes state?
> 
> In __eventfs_root_lookup(), both lookup_dir_entry() and lookup_file_dentry()
> pass the shared &ei->attr and &ei->entry_attrs[idx] into eventfs_get_inode()
> -> update_inode_attr() even when ro is true:  
> 
> fs/tracefs/event_inode.c:update_inode_attr() {
> 	...
> 	if (attr && attr->mode & EVENTFS_SAVE_MODE)
> 		inode->i_mode = attr->mode & EVENTFS_MODE_MASK;
> 	else
> 		inode->i_mode = mode;
> 
> 	if (attr && attr->mode & EVENTFS_SAVE_UID)
> 		inode->i_uid = attr->uid;
> 	else
> 		inode->i_uid = rei->ei.attr.uid;
> 	...
> }
> 
> If an administrator runs chmod or chown on files or directories under
> /sys/kernel/tracing/events, or mounts tracefs with uid=/gid= options,
> update_inode_attr() will override the 0444 file mode (and directory
> permissions/ownership) in /sys/kernel/events with the saved tracefs
> attributes, potentially revoking unprivileged read access or re-enabling
> write bits. In addition, lookup_dir_entry() passes S_IFDIR | S_IRWXU |
> S_IRUGO | S_IXUGO (0755) instead of 0555 when ro is true.
> 
> Similarly, because eventfs_ro_super_operations uses tracefs_alloc_inode,
> eventfs inodes are added to the global tracefs_inodes list. When tracefs is
> remounted with uid= or gid=, tracefs_apply_options() walks tracefs_inodes
> without checking ti->vfs_inode.i_sb == sb and overwrites i_uid and i_gid on
> live eventfs inodes as well:
> 
> fs/tracefs/inode.c:tracefs_apply_options() {
> 	...
> 	list_for_each_entry_rcu(ti, &tracefs_inodes, list) {
> 		if (update_uid) {
> 			ti->flags &= ~TRACEFS_UID_PERM_SET;
> 			ti->vfs_inode.i_uid = fsi->uid;
> 		}
> 	...
> }
> 
> Should ro lookups ignore ei->attr / ei->entry_attrs (or should
> eventfs_get_inode() bypass saved tracefs attributes when on the read-only
> superblock), and should tracefs_apply_options() filter by superblock?

I probably should do that to be more robust. Currently all the files that
are marked as read only do not even have a write method, so they can never
be written to. The important thing is only these read-only files are
exposed in eventfs. But for correctness, modifications to permissions
should be prevented.

> 
> [ ... ]
> 
> > @@ -837,6 +967,52 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
> >  	return ERR_PTR(-ENOMEM);
> >  }
> >  
> > +/**
> > + * eventfs_create_events_ro_copy - create a read-only events directory
> > + * @name: The name of the top level directory to create.
> > + * @entries: A list of entries that represent the files under this directory
> > + * @size: The number of @entries
> > + * @data: The default data to pass to the files (an entry may override it).
> > + *
> > + * This function configures the eventfs filesystem root as a read-only
> > + * trace event directory using the existing eventfs_inode lazy-lookup
> > + * infrastructure.
> > + *
> > + * See eventfs_create_dir() for use of @entries.
> > + */
> > +int eventfs_create_events_ro_copy(const char *name, struct eventfs_inode *ei)  
> 
> [Severity: Low]
> This isn't a bug, but the kernel-doc comment for
> eventfs_create_events_ro_copy() still lists @entries, @size, and @data from
> eventfs_create_events_dir() instead of @ei, and the @name parameter is
> unused in the function body.

Will fix.

> 
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
> [Severity: Medium]
> Is it safe to re-initialize ei->children and ei->list here?
> 
> In create_event_toplevel_files(), e_events has already been allocated and
> initialized by eventfs_create_events_dir() -> alloc_root_ei() -> init_ei(),
> and published via tracefs_end_creating(). Calling
> INIT_LIST_HEAD(&ei->children) and INIT_LIST_HEAD(&ei->list) again without
> holding eventfs_mutex risks resetting an already-live list.

Hmm, I thought I fixed that. It's one of the things that Masami mentioned.
Hmm, did I not commit the changes?

> 
> Also, should dentry->d_fsdata and ti->private be set before setting
> ti->flags |= TRACEFS_EVENT_INODE and switching inode->i_op to
> eventfs_ro_dir_inode_operations, and should dentry be reset to NULL (or only
> assigned after checking IS_ERR) if eventfs_ro_get_root() fails so static
> dentry does not hold an ERR_PTR?
> 
> [ ... ]
> 
> > diff --git a/include/linux/tracefs.h b/include/linux/tracefs.h
> > index bc354d3400464..41e97a6bd69a3 100644
> > --- a/include/linux/tracefs.h
> > +++ b/include/linux/tracefs.h
> > @@ -75,6 +75,7 @@ struct eventfs_entry {
> >  	const char			*name;
> >  	eventfs_callback		callback;
> >  	eventfs_release			release;
> > +	bool				read_only;
> >  };  
> 
> [Severity: Low]
> This isn't a bug, but struct eventfs_entry has a kernel-doc comment just
> above this definition where @read_only (and @release) are not documented.

Will fix.

> 
> [ ... ]
> 
> > diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> > index 6afed2091e19c..968fdbca8054f 100644
> > --- a/kernel/trace/trace_events.c
> > +++ b/kernel/trace/trace_events.c  
> 
> [ ... ]
> 
> > @@ -4775,6 +4781,13 @@ create_event_toplevel_files(struct dentry *parent, struct trace_array *tr)
> >  
> >  	tr->event_dir = e_events;
> >  
> > +	if (!event_dir_ro_created && (tr->flags & TRACE_ARRAY_FL_GLOBAL)) {
> > +		int ret;
> > +
> > +		ret = eventfs_create_events_ro_copy("events", e_events);
> > +		if (!ret)
> > +			event_dir_ro_created = true;
> > +	}
> >  	return 0;
> >  }  
> 
> [Severity: High]
> What happens here when the kernel is booted with lockdown=confidentiality
> (LOCKDOWN_TRACEFS)?
> 
> In eventfs_create_events_dir():
> 
> fs/tracefs/event_inode.c:eventfs_create_events_dir() {
> 	...
> 	if (security_locked_down(LOCKDOWN_TRACEFS))
> 		return NULL;
> 	...
> }
> 
> When LOCKDOWN_TRACEFS is active, eventfs_create_events_dir() returns NULL
> rather than an ERR_PTR. In create_event_toplevel_files(), IS_ERR(e_events)
> evaluates to false for NULL, so e_events = NULL is passed to
> eventfs_create_events_ro_copy("events", e_events), which dereferences ei
> without a NULL check and crashes the kernel during boot.
> 
> Should create_event_toplevel_files() or eventfs_create_events_ro_copy()
> check for !e_events (and security_locked_down(LOCKDOWN_TRACEFS)) before
> dereferencing ei?
> 

Oops, will fix.

Thanks,

-- Steve

