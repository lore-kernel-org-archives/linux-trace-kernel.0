Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793652293;
	b=XEVk9TS8waSbavP//y0/83MbUonLf1sOq2I7ldSLxdNFIS2ydQEdFTrYBvJHV4wqW28X
	 91+plE2Fax/scH1nQ3L6TbQPmVtfwIrppbB7wDBLwON/lvzN71senbMUrlscXpXHqEfB8
	 7fg/jzNSlIRYf9RsgX5jffVXTTqnFHm7vjwrwNY+a7mx8uVUf6CFsLjOSOkvy1+oCEecH
	 hLqdIPGjYfXkFWpPsQP+AI7J9bove2nXcasXsynkfGUBXt7/JusUiWW//BxNEE1yA2Gz3
	 56AEHRhIF+CRNxdLXkuk6t6ekU25z7or7oBypNc1wpVUnEiNMgeKp8uch6SukPTRjlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793652293;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dsoGB178AxVobK/g5UihpMGDT7eFOjxtcCMbwTWgqTA=;
	b=hN+rTjmj/vS6vFpSuo3enQO9jKS0jtGjAg8sL/HeSGchpLvk+pGI5/3wm9sWMM8DEgiB
	 kaxh9aGKzC9Q9RdSTMHJKQsy7R8t29Uekhn1eaX4ClFLPh1P8iwcX0PwCtjvkmJZp8h03
	 PLDCBCDvCLM5Tk9P4AA7yoSj5cM0y8xSs72edpsg5DM/g5kur3uqHosfD6HXeEY5t08zm
	 qiJWWf9se7uIjk2gyAfP0l7zR74ys8WDEY0ki1dtki+oITSBSn0RxiFeyplSFl/yBSPF/
	 aJdUZTJbMQnIK/Ltk1SXUCmD9bjynzzrWe9oYETjNm/VjP/+wkOOQOeUt4TCtLlkcoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CvRIvqng;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26CD606A326
	for <linux-trace-kernel@vger.kernel.org>; Mon,  2 Nov 2026 20:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CvRIvqng
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D7E91F00A1A;
	Mon,  2 Nov 2026 20:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793652292;
	bh=dsoGB178AxVobK/g5UihpMGDT7eFOjxtcCMbwTWgqTA=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=CvRIvqngC0TCDQ1NBqAuSFaG1mRNnSZ+Eevj9Y/GfXolS8NlbwJ8kwkCDqrG60ebL
	 /aYyXh0qz/dLtFbR+5yh0GqFpl3Ul0ezsLEHR2MiYMbyP0LP0XTwFE78dVg1W+NzrS
	 JZc+qglCpsx2PjxhtsXIcQAAQOFAk9UfB9gwZMq59mIzDRPGoT+vMSr5ReDW06AYK/
	 TSONbU4QGnnTmYrBGUmZYS0n8gpeHs3oQRspBmzQ0yN7QITdepvzu7qbDW2DMM/fyi
	 X3jmXUM+PEJa0+7+QWREgRp/PZ/8AaTcqw6tgD+zoz7eaSFNPUrkqmejSt2nIHaCx2
	 rB9OCJpAedAKg==
Message-ID: <sashiko-outbox-194145@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] tracefs: Add read-only eventfs filesystem at
 /sys/kernel/events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steven Rostedt" <rostedt@goodmis.org>, "Linux Trace Kernel" <linux-trace-kernel@vger.kernel.org>
In-Reply-To: <20261102152748.614ddc8f@gandalf.local.home>
References: <20261102152748.614ddc8f@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 20:44:51 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] tracefs: NULL dereference in eventfs_create_events_ro_copy() on lo=
ckdown
- [Medium] tracefs: bitwise OR-assignment in __eventfs_root_lookup() keeps =
write bits
- [Medium] tracefs: shared eventfs_attr and tracefs_inodes leak tracefs per=
missions
- [Medium] tracefs: missing reconfigure op on eventfs allows clearing SB_RD=
ONLY
- [Medium] tracefs: unlocked list re-init in eventfs_create_events_ro_copy()
- [Low] tracefs: kernel-doc mismatches in eventfs_create_events_ro_copy()
--

commit c35b9718567e39dd0e81499c75ebb85b51e94ca3
Author: Anubhav Shelat <ashelat@redhat.com>

tracefs: Add read-only eventfs filesystem at /sys/kernel/events

This commit introduces a read-only eventfs pseudo-filesystem mounted at
/sys/kernel/events to expose trace event format, id, and header files to
unprivileged users by reusing the existing eventfs_inode infrastructure.

> diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
> index 6e3513b13cfa2..2a80eca136bd6 100644
> --- a/fs/tracefs/event_inode.c
> +++ b/fs/tracefs/event_inode.c
> @@ -16,14 +16,87 @@

[ ... ]

> +static int eventfs_ro_get_tree(struct fs_context *fc)
> +{
> +	return get_tree_single(fc, eventfs_ro_fill_super);
> +}
> +
> +static const struct fs_context_operations eventfs_ro_context_ops =3D {
> +	.get_tree	=3D eventfs_ro_get_tree,
> +};

[Severity: Medium]
Can a remount clear SB_RDONLY on the eventfs superblock?

eventfs_ro_fill_super() sets sb->s_flags |=3D SB_RDONLY, but
eventfs_ro_context_ops does not define a .reconfigure callback. In
reconfigure_super(), when fc->ops->reconfigure is NULL, VFS updates
sb->s_flags directly from fc->sb_flags and fc->sb_flags_mask, so running
mount -o remount,rw /sys/kernel/events will clear SB_RDONLY.

Because lookup_file() assigns eventfs_file_inode_operations (with
.setattr =3D eventfs_set_attr) to regular files in eventfs, clearing
SB_RDONLY allows chmod/chown on /sys/kernel/events files to mutate the
shared ei->entry_attrs used by tracefs. Should eventfs_ro_context_ops
provide a .reconfigure callback that rejects clearing SB_RDONLY (or should
read-only file inodes omit .setattr)?

[ ... ]

> @@ -412,7 +499,7 @@ static struct dentry *lookup_file(struct eventfs_inod=
e *parent_ei,
>   * a eventfs_inode.
>   */
>  static struct dentry *lookup_dir_entry(struct dentry *dentry,
> -	struct eventfs_inode *pei, struct eventfs_inode *ei)
> +	struct eventfs_inode *pei, struct eventfs_inode *ei, bool ro)
>  {
>  	struct inode *inode;
>  	umode_t mode =3D S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
> @@ -421,8 +508,13 @@ static struct dentry *lookup_dir_entry(struct dentry=
 *dentry,
>  	if (unlikely(!inode))
>  		return ERR_PTR(-ENOMEM);
> =20
> -	inode->i_op =3D &eventfs_dir_inode_operations;
> -	inode->i_fop =3D &eventfs_file_operations;
> +	if (ro) {
> +		inode->i_op =3D &eventfs_ro_dir_inode_operations;
> +		inode->i_fop =3D &eventfs_ro_file_operations;
> +	} else {
> +		inode->i_op =3D &eventfs_dir_inode_operations;
> +		inode->i_fop =3D &eventfs_file_operations;
> +	}

[Severity: Low]
This isn't a bug, but lookup_dir_entry() gained the @ro argument without a
matching entry in its kernel-doc comment above.

[ ... ]

> @@ -563,20 +656,44 @@ static struct dentry *eventfs_root_lookup(struct in=
ode *dir,
>  		if (strcmp(name, entry->name) !=3D 0)
>  			continue;
> =20
> +		if (ro && !entry->read_only)
> +			return NULL;
> +
>  		data =3D ei->data;
>  		if (entry->callback(name, &mode, &data, &fops) <=3D 0)
>  			return NULL;
> =20
> +		/*
> +		 * Read-only files gets all users read access,
> +		 * but also should make sure this is not writable.
> +		 */
> +		if (ro)
> +			mode |=3D (mode & ~0222) | 0444;

[Severity: Medium]
Should this use =3D instead of |=3D when updating mode?

Because |=3D ORs the right-hand side with the original value of mode,
mode | (mode & ~0222) | 0444 simplifies to mode | 0444, leaving any write
permission bits returned by entry->callback() intact.

> +
>  		return lookup_file_dentry(dentry, ei, i, mode, data, fops);

[Severity: Medium]
Will permission or ownership changes in tracefs leak into the read-only
eventfs mount through shared eventfs_attr and tracefs_inodes state?

In __eventfs_root_lookup(), both lookup_dir_entry() and lookup_file_dentry()
pass the shared &ei->attr and &ei->entry_attrs[idx] into eventfs_get_inode()
-> update_inode_attr() even when ro is true:

fs/tracefs/event_inode.c:update_inode_attr() {
	...
	if (attr && attr->mode & EVENTFS_SAVE_MODE)
		inode->i_mode =3D attr->mode & EVENTFS_MODE_MASK;
	else
		inode->i_mode =3D mode;

	if (attr && attr->mode & EVENTFS_SAVE_UID)
		inode->i_uid =3D attr->uid;
	else
		inode->i_uid =3D rei->ei.attr.uid;
	...
}

If an administrator runs chmod or chown on files or directories under
/sys/kernel/tracing/events, or mounts tracefs with uid=3D/gid=3D options,
update_inode_attr() will override the 0444 file mode (and directory
permissions/ownership) in /sys/kernel/events with the saved tracefs
attributes, potentially revoking unprivileged read access or re-enabling
write bits. In addition, lookup_dir_entry() passes S_IFDIR | S_IRWXU |
S_IRUGO | S_IXUGO (0755) instead of 0555 when ro is true.

Similarly, because eventfs_ro_super_operations uses tracefs_alloc_inode,
eventfs inodes are added to the global tracefs_inodes list. When tracefs is
remounted with uid=3D or gid=3D, tracefs_apply_options() walks tracefs_inod=
es
without checking ti->vfs_inode.i_sb =3D=3D sb and overwrites i_uid and i_gi=
d on
live eventfs inodes as well:

fs/tracefs/inode.c:tracefs_apply_options() {
	...
	list_for_each_entry_rcu(ti, &tracefs_inodes, list) {
		if (update_uid) {
			ti->flags &=3D ~TRACEFS_UID_PERM_SET;
			ti->vfs_inode.i_uid =3D fsi->uid;
		}
	...
}

Should ro lookups ignore ei->attr / ei->entry_attrs (or should
eventfs_get_inode() bypass saved tracefs attributes when on the read-only
superblock), and should tracefs_apply_options() filter by superblock?

[ ... ]

> @@ -837,6 +967,52 @@ struct eventfs_inode *eventfs_create_events_dir(cons=
t char *name, struct dentry
>  	return ERR_PTR(-ENOMEM);
>  }
> =20
> +/**
> + * eventfs_create_events_ro_copy - create a read-only events directory
> + * @name: The name of the top level directory to create.
> + * @entries: A list of entries that represent the files under this direc=
tory
> + * @size: The number of @entries
> + * @data: The default data to pass to the files (an entry may override i=
t).
> + *
> + * This function configures the eventfs filesystem root as a read-only
> + * trace event directory using the existing eventfs_inode lazy-lookup
> + * infrastructure.
> + *
> + * See eventfs_create_dir() for use of @entries.
> + */
> +int eventfs_create_events_ro_copy(const char *name, struct eventfs_inode=
 *ei)

[Severity: Low]
This isn't a bug, but the kernel-doc comment for
eventfs_create_events_ro_copy() still lists @entries, @size, and @data from
eventfs_create_events_dir() instead of @ei, and the @name parameter is
unused in the function body.

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
> +	dentry =3D eventfs_ro_get_root();
> +	if (IS_ERR(dentry))
> +		return PTR_ERR(dentry);
> +
> +	inode =3D d_inode(dentry);
> +
> +	INIT_LIST_HEAD(&ei->children);
> +	INIT_LIST_HEAD(&ei->list);
> +
> +	ti =3D get_tracefs(inode);
> +	ti->flags |=3D TRACEFS_EVENT_INODE;
> +	ti->private =3D ei;
> +
> +	inode->i_op =3D &eventfs_ro_dir_inode_operations;
> +	inode->i_fop =3D &eventfs_ro_file_operations;
> +
> +	/* This is never freed */
> +	dentry->d_fsdata =3D get_ei(ei);
> +
> +	return 0;
> +}

[Severity: Medium]
Is it safe to re-initialize ei->children and ei->list here?

In create_event_toplevel_files(), e_events has already been allocated and
initialized by eventfs_create_events_dir() -> alloc_root_ei() -> init_ei(),
and published via tracefs_end_creating(). Calling
INIT_LIST_HEAD(&ei->children) and INIT_LIST_HEAD(&ei->list) again without
holding eventfs_mutex risks resetting an already-live list.

Also, should dentry->d_fsdata and ti->private be set before setting
ti->flags |=3D TRACEFS_EVENT_INODE and switching inode->i_op to
eventfs_ro_dir_inode_operations, and should dentry be reset to NULL (or only
assigned after checking IS_ERR) if eventfs_ro_get_root() fails so static
dentry does not hold an ERR_PTR?

[ ... ]

> diff --git a/include/linux/tracefs.h b/include/linux/tracefs.h
> index bc354d3400464..41e97a6bd69a3 100644
> --- a/include/linux/tracefs.h
> +++ b/include/linux/tracefs.h
> @@ -75,6 +75,7 @@ struct eventfs_entry {
>  	const char			*name;
>  	eventfs_callback		callback;
>  	eventfs_release			release;
> +	bool				read_only;
>  };

[Severity: Low]
This isn't a bug, but struct eventfs_entry has a kernel-doc comment just
above this definition where @read_only (and @release) are not documented.

[ ... ]

> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 6afed2091e19c..968fdbca8054f 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c

[ ... ]

> @@ -4775,6 +4781,13 @@ create_event_toplevel_files(struct dentry *parent,=
 struct trace_array *tr)
> =20
>  	tr->event_dir =3D e_events;
> =20
> +	if (!event_dir_ro_created && (tr->flags & TRACE_ARRAY_FL_GLOBAL)) {
> +		int ret;
> +
> +		ret =3D eventfs_create_events_ro_copy("events", e_events);
> +		if (!ret)
> +			event_dir_ro_created =3D true;
> +	}
>  	return 0;
>  }

[Severity: High]
What happens here when the kernel is booted with lockdown=3Dconfidentiality
(LOCKDOWN_TRACEFS)?

In eventfs_create_events_dir():

fs/tracefs/event_inode.c:eventfs_create_events_dir() {
	...
	if (security_locked_down(LOCKDOWN_TRACEFS))
		return NULL;
	...
}

When LOCKDOWN_TRACEFS is active, eventfs_create_events_dir() returns NULL
rather than an ERR_PTR. In create_event_toplevel_files(), IS_ERR(e_events)
evaluates to false for NULL, so e_events =3D NULL is passed to
eventfs_create_events_ro_copy("events", e_events), which dereferences ei
without a NULL check and crashes the kernel during boot.

Should create_event_toplevel_files() or eventfs_create_events_ro_copy()
check for !e_events (and security_locked_down(LOCKDOWN_TRACEFS)) before
dereferencing ei?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102152748.614d=
dc8f@gandalf.local.home?part=3D1
