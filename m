Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793672287;
	b=XiOhfRRcFINWfYCYK2dd/2qRQpJkR3hs4uUD7kYKkMVTi8+FTqgGNJDnGR6Vi0Ugj97l
	 wdDbIlFimPiVPHh/l5PHWn2e5M/AY4HRUsKFtLC0+P+nradoqGAundhi5JXLLMEcoP5MY
	 wmYZ3OtbbPHhRiPT4oPLf7aieO+aNqsnEsurA4MvHYzlrTXtIH7haY5WJTPuXnBq99z0P
	 nKnbqcp33ZkdAjdbxZDlaXKCdlHWxlkOoCv2VnlecFFx6U+2sc4XwLiLR8ZyxG057kEM5
	 d9vB0XqiOB14ukmJnXEmvKrspvShlxdjRic4/mZDSaxeoCO2jPnx7svUFy94NjegHcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793672287;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=M4z8Ipp15q1GTFEnkWKfH1F56jyyNHyKcy46SbraDkA=;
	b=L+pLfbP0vkFp57KnDULmVwJtjdnZjYFuqCtQ4TuSkntDr2k7Qh8UfM1VDxEmxh1tDINH
	 Dw/LyNtFv45yaMs9y4Hmto2BQSeaId+fULpHyepaMeIZlBEvHKXaEG0PAVyvcebZ7xVXI
	 AzcBH0N/oObTsgtAtsW6q9RWyTjxjp0scM+/Mv2mgU9693SgQX31p74JeN62TkKAT4Xek
	 XSQI1l4Tb6Ea4ulUJoNnYXwxg1StdkyoLvnIsICGA5lwBlLHWhBYBZfC0UIxrD1ZzAneN
	 B48YA/Satd5MLfxw4Vw/ZNV8+pryZFIJ/A6CiR1a3Gemo+1fPvuOmagyI1cCYd+vwRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XIsWMlac;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F593606A324;
	Tue,  3 Nov 2026 02:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XIsWMlac
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B22D01F000C1;
	Tue,  3 Nov 2026 02:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793672286;
	bh=M4z8Ipp15q1GTFEnkWKfH1F56jyyNHyKcy46SbraDkA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XIsWMlackiQ8b8I/6J/ATNZ+jMajzPnf73wyiUKRTs2sH60IfdqIh16ukwNZcKwjZ
	 yR09x6nDwnz22PKsZEIa0KXLE1jV+U+7lIliuhpzcJdKk8kHvu/DCzSGE6rxhJwY25
	 SLDz3JDToHZEswgwGLChhGNITPUViWEP8i+rLf7dpHp0wtGr7Rs3aRnOYPtrGlrA+H
	 tVTLnZJWl2gq5lTkDUS9aMMsoGnPv/50Dyw+abD4VOfP0Vy/KvjjllcM2pJNkfjrLm
	 +UAUj7q4rHX9uZp8jmK0bXZ9lI2qojZN0XDQzRbsmgft5jnzsPebiO0BXxxMjsmoi1
	 xqNj32lT7deHg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Anubhav Shelat <ashelat@redhat.com>
Subject: Re: [PATCH v4] tracefs: Add read-only eventfs filesystem at /sys/kernel/events
Date: Tue, 03 Nov 2026 11:18:03 +0900
Message-ID: <undine-1793672283667563124-a33a39e2a7561653@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <20261102152748.614ddc8f@gandalf.local.home>
References: <20261102152748.614ddc8f@gandalf.local.home>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Mon, 2 Nov 2026 15:27:48 -0500, Steven Rostedt <rostedt@goodmis.org> wrote:
> From: Anubhav Shelat <ashelat@redhat.com>
> 
> Introduce a new read-only pseudo-filesystem "eventfs" mounted at
> /sys/kernel/events that exposes trace event format and id files
> (mode 0444) to unprivileged users. This allows tools like perf to
> discover event formats without requiring access to the full
> tracefs/debugfs mount.
> 
> The eventfs file system reuses the existing eventfs_inode lazy-lookup
> infrastructure. A new set of super_operations
> (eventfs_ro_super_operations) shares the tracefs inode allocator so
> that eventfs_get_inode() and get_tracefs() work on the RO superblock.
> The superblock is manually initialized to ensure the root inode is
> allocated with tracefs_alloc_inode, allowing the root to serve
> directly as the events directory without another events subdirectory.
> 
> Each qualifying event gets a subsystem directory containing format
> and id files. The top-level events directory also exposes header_page
> and header_event. Similar to tracefs, a change will need to be made in
> systemd to mount this filesystem automatically.
> 
> [
>   Steven Rostedt rewrote to use the lookup functions to determine read
>   only files to show. The struct eventfs_entry now has a "readonly" field
>   and if it is set, it will be displayed in the read only file system.
>   The original code [1] duplicated the eventfs_inodes for every event and
>   subsystem. The new approach uses the existing eventfs_inodes (without
>   requiring more memory to store them) and uses the eventfs_entry arrays to
>   show which files are allowed to be read readonly or not.
> 
>   [1] https://patch.msgid.link/20260715135231.338535-4-ashelat@redhat.com
> ]

Thanks for the work! As we talked offline, I think we can use this for
the backup instance (an instance copied from another instance at boot)
because that backup instance is also read only. See trace_array_is_readonly()
and TRACE_ARRAY_FL_RDONLY[1].

[1] https://lore.kernel.org/all/177502546939.1311542.1826814401724828930.stgit@mhiramat.tok.corp.google.com/

> 
> Assisted-by: CLAUDE:claude-opus-4 Apogee

BTW, this tag seems removed by commit 1e035297ffda ("docs: remove 
Assisted-by references")

Thanks,

> Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> ---
> Changes since v3: https://patch.msgid.link/20260810160708.3460a2fd@gandalf.local.home
> 
> - Fixed kernel doc name for eventfs_create_events_ro_copy() (Masami Hiramatsu)
> 
> - Removed duplicate initialization of ei in that function. (Masami Hiramatsu)
> 
> - Added include of linux/magic.h as it failed to build on some
>   architectures. (kernel test robot)
> 
>  fs/tracefs/event_inode.c    | 192 ++++++++++++++++++++++++++++++++++--
>  fs/tracefs/inode.c          |  21 +++-
>  fs/tracefs/internal.h       |   6 ++
>  include/linux/tracefs.h     |   3 +
>  include/uapi/linux/magic.h  |   1 +
>  kernel/trace/trace_events.c |  13 +++
>  6 files changed, 225 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
> index 6457df72173d..8a4125cd0d48 100644
> --- a/fs/tracefs/event_inode.c
> +++ b/fs/tracefs/event_inode.c
> @@ -16,14 +16,87 @@
>   */
>  #include <linux/fsnotify.h>
>  #include <linux/fs.h>
> +#include <linux/fs_context.h>
>  #include <linux/namei.h>
>  #include <linux/workqueue.h>
>  #include <linux/security.h>
>  #include <linux/tracefs.h>
> +#include <linux/magic.h>
>  #include <linux/kref.h>
>  #include <linux/delay.h>
>  #include "internal.h"
>  
> +static struct vfsmount *eventfs_ro_mount;
> +static int eventfs_ro_mount_count;
> +
> +static int eventfs_ro_fill_super(struct super_block *sb, struct fs_context *fc)
> +{
> +	struct inode *inode;
> +	struct dentry *root;
> +
> +	sb->s_blocksize = PAGE_SIZE;
> +	sb->s_blocksize_bits = PAGE_SHIFT;
> +	sb->s_magic = EVENTFS_SUPER_MAGIC;
> +	sb->s_op = &eventfs_ro_super_operations;
> +	sb->s_time_gran = 1;
> +	sb->s_flags |= SB_RDONLY;
> +
> +	inode = new_inode(sb);
> +	if (!inode)
> +		return -ENOMEM;
> +
> +	inode->i_ino = 1;
> +	inode->i_mode = S_IFDIR | 0555;
> +	simple_inode_init_ts(inode);
> +	inode->i_op = &simple_dir_inode_operations;
> +	inode->i_fop = &simple_dir_operations;
> +	set_nlink(inode, 2);
> +
> +	set_default_d_op(sb, &tracefs_dentry_operations);
> +
> +	root = d_make_root(inode);
> +	if (!root)
> +		return -ENOMEM;
> +
> +	sb->s_root = root;
> +
> +	return 0;
> +}
> +
> +static int eventfs_ro_get_tree(struct fs_context *fc)
> +{
> +	return get_tree_single(fc, eventfs_ro_fill_super);
> +}
> +
> +static const struct fs_context_operations eventfs_ro_context_ops = {
> +	.get_tree	= eventfs_ro_get_tree,
> +};
> +
> +static int eventfs_ro_init_fs_context(struct fs_context *fc)
> +{
> +	fc->ops = &eventfs_ro_context_ops;
> +	return 0;
> +}
> +
> +struct file_system_type eventfs_ro_fs_type = {
> +	.owner =	THIS_MODULE,
> +	.name =		"eventfs",
> +	.init_fs_context = eventfs_ro_init_fs_context,
> +	.kill_sb =	kill_anon_super,
> +};
> +
> +struct dentry *eventfs_ro_get_root(void)
> +{
> +	int error;
> +
> +	error = simple_pin_fs(&eventfs_ro_fs_type, &eventfs_ro_mount,
> +			      &eventfs_ro_mount_count);
> +	if (error)
> +		return ERR_PTR(error);
> +
> +	return dget(eventfs_ro_mount->mnt_root);
> +}
> +
>  /*
>   * eventfs_mutex protects the eventfs_inode (ei) dentry. Any access
>   * to the ei->dentry must be done under this mutex and after checking
> @@ -169,7 +242,11 @@ static inline struct eventfs_inode *get_ei(struct eventfs_inode *ei)
>  static struct dentry *eventfs_root_lookup(struct inode *dir,
>  					  struct dentry *dentry,
>  					  unsigned int flags);
> +static struct dentry *eventfs_root_lookup_ro(struct inode *dir,
> +					     struct dentry *dentry,
> +					     unsigned int flags);
>  static int eventfs_iterate(struct file *file, struct dir_context *ctx);
> +static int eventfs_ro_iterate(struct file *file, struct dir_context *ctx);
>  
>  static void update_attr(struct eventfs_attr *attr, struct iattr *iattr)
>  {
> @@ -247,6 +324,10 @@ static const struct inode_operations eventfs_dir_inode_operations = {
>  	.setattr	= eventfs_set_attr,
>  };
>  
> +static const struct inode_operations eventfs_ro_dir_inode_operations = {
> +	.lookup		= eventfs_root_lookup_ro,
> +};
> +
>  static const struct inode_operations eventfs_file_inode_operations = {
>  	.setattr	= eventfs_set_attr,
>  };
> @@ -257,6 +338,12 @@ static const struct file_operations eventfs_file_operations = {
>  	.llseek		= generic_file_llseek,
>  };
>  
> +static const struct file_operations eventfs_ro_file_operations = {
> +	.read		= generic_read_dir,
> +	.iterate_shared	= eventfs_ro_iterate,
> +	.llseek		= generic_file_llseek,
> +};
> +
>  static void eventfs_set_attrs(struct eventfs_inode *ei, bool update_uid, kuid_t uid,
>  			      bool update_gid, kgid_t gid, int level)
>  {
> @@ -420,7 +507,7 @@ static struct dentry *lookup_file(struct eventfs_inode *parent_ei,
>   * a eventfs_inode.
>   */
>  static struct dentry *lookup_dir_entry(struct dentry *dentry,
> -	struct eventfs_inode *pei, struct eventfs_inode *ei)
> +	struct eventfs_inode *pei, struct eventfs_inode *ei, bool ro)
>  {
>  	struct inode *inode;
>  	umode_t mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
> @@ -429,8 +516,13 @@ static struct dentry *lookup_dir_entry(struct dentry *dentry,
>  	if (unlikely(!inode))
>  		return ERR_PTR(-ENOMEM);
>  
> -	inode->i_op = &eventfs_dir_inode_operations;
> -	inode->i_fop = &eventfs_file_operations;
> +	if (ro) {
> +		inode->i_op = &eventfs_ro_dir_inode_operations;
> +		inode->i_fop = &eventfs_ro_file_operations;
> +	} else {
> +		inode->i_op = &eventfs_dir_inode_operations;
> +		inode->i_fop = &eventfs_file_operations;
> +	}
>  
>  	/* All directories will have the same inode number */
>  	inode->i_ino = eventfs_dir_ino(ei);
> @@ -534,9 +626,10 @@ lookup_file_dentry(struct dentry *dentry,
>   * list, if @dentry found go ahead and create the file/dir
>   */
>  
> -static struct dentry *eventfs_root_lookup(struct inode *dir,
> -					  struct dentry *dentry,
> -					  unsigned int flags)
> +static struct dentry *__eventfs_root_lookup(struct inode *dir,
> +					    struct dentry *dentry,
> +					    unsigned int flags,
> +					    bool ro)
>  {
>  	struct eventfs_inode *ei_child;
>  	struct tracefs_inode *ti;
> @@ -559,7 +652,7 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
>  		/* A child is freed and removed from the list at the same time */
>  		if (WARN_ON_ONCE(ei_child->is_freed))
>  			return NULL;
> -		return lookup_dir_entry(dentry, ei, ei_child);
> +		return lookup_dir_entry(dentry, ei, ei_child, ro);
>  	}
>  
>  	for (int i = 0; i < ei->nr_entries; i++) {
> @@ -571,20 +664,44 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
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
> +		/*
> +		 * Read-only files gets all users read access,
> +		 * but also should make sure this is not writable.
> +		 */
> +		if (ro)
> +			mode |= (mode & ~0222) | 0444;
> +
>  		return lookup_file_dentry(dentry, ei, i, mode, data, fops);
>  
>  	}
>  	return NULL;
>  }
>  
> +static struct dentry *eventfs_root_lookup(struct inode *dir,
> +					  struct dentry *dentry,
> +					  unsigned int flags)
> +{
> +	return __eventfs_root_lookup(dir, dentry, flags, false);
> +}
> +
> +static struct dentry *eventfs_root_lookup_ro(struct inode *dir,
> +					     struct dentry *dentry,
> +					     unsigned int flags)
> +{
> +	return __eventfs_root_lookup(dir, dentry, flags, true);
> +}
> +
>  /*
>   * Walk the children of a eventfs_inode to fill in getdents().
>   */
> -static int eventfs_iterate(struct file *file, struct dir_context *ctx)
> +static int __eventfs_iterate(struct file *file, struct dir_context *ctx, bool ro)
>  {
>  	const struct file_operations *fops;
>  	struct inode *f_inode = file_inode(file);
> @@ -630,6 +747,9 @@ static int eventfs_iterate(struct file *file, struct dir_context *ctx)
>  		entry = &ei->entries[i];
>  		name = entry->name;
>  
> +		if (ro && !entry->read_only)
> +			continue;
> +
>  		/* If ei->is_freed then just bail here, nothing more to do */
>  		scoped_guard(mutex, &eventfs_mutex) {
>  			if (ei->is_freed)
> @@ -688,6 +808,16 @@ static int eventfs_iterate(struct file *file, struct dir_context *ctx)
>  	return 1;
>  }
>  
> +static int eventfs_iterate(struct file *file, struct dir_context *ctx)
> +{
> +	return __eventfs_iterate(file, ctx, false);
> +}
> +
> +static int eventfs_ro_iterate(struct file *file, struct dir_context *ctx)
> +{
> +	return __eventfs_iterate(file, ctx, true);
> +}
> +
>  /**
>   * eventfs_create_dir - Create the eventfs_inode for this directory
>   * @name: The name of the directory to create.
> @@ -845,6 +975,52 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
>  	return ERR_PTR(-ENOMEM);
>  }
>  
> +/**
> + * eventfs_create_events_ro_copy - create a read-only events directory
> + * @name: The name of the top level directory to create.
> + * @entries: A list of entries that represent the files under this directory
> + * @size: The number of @entries
> + * @data: The default data to pass to the files (an entry may override it).
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
> +
>  /**
>   * eventfs_remove_rec - remove eventfs dir or file from list
>   * @ei: eventfs_inode to be removed.
> diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
> index 5020365ca704..555af5402adc 100644
> --- a/fs/tracefs/inode.c
> +++ b/fs/tracefs/inode.c
> @@ -423,6 +423,14 @@ static const struct super_operations tracefs_super_operations = {
>  	.show_options	= tracefs_show_options,
>  };
>  
> +const struct super_operations eventfs_ro_super_operations = {
> +	.alloc_inode    = tracefs_alloc_inode,
> +	.free_inode     = tracefs_free_inode,
> +	.destroy_inode  = tracefs_destroy_inode,
> +	.drop_inode     = tracefs_drop_inode,
> +	.statfs		= simple_statfs,
> +};
> +
>  /*
>   * It would be cleaner if eventfs had its own dentry ops.
>   *
> @@ -455,7 +463,7 @@ static int tracefs_d_delete(const struct dentry *dentry)
>  	return dentry->d_fsdata == NULL;
>  }
>  
> -static const struct dentry_operations tracefs_dentry_operations = {
> +const struct dentry_operations tracefs_dentry_operations = {
>  	.d_revalidate = tracefs_d_revalidate,
>  	.d_release = tracefs_d_release,
>  	.d_delete = tracefs_d_delete,
> @@ -801,8 +809,15 @@ static int __init tracefs_init(void)
>  		return -EINVAL;
>  
>  	retval = register_filesystem(&trace_fs_type);
> -	if (!retval)
> -		tracefs_registered = true;
> +	if (retval)
> +		return retval;
> +	tracefs_registered = true;
> +
> +	retval = sysfs_create_mount_point(kernel_kobj, "events");
> +	if (retval)
> +		return retval;
> +
> +	retval = register_filesystem(&eventfs_ro_fs_type);
>  
>  	return retval;
>  }
> diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
> index c61481d04c8e..c92376bc3121 100644
> --- a/fs/tracefs/internal.h
> +++ b/fs/tracefs/internal.h
> @@ -2,6 +2,10 @@
>  #ifndef _TRACEFS_INTERNAL_H
>  #define _TRACEFS_INTERNAL_H
>  
> +extern const struct dentry_operations tracefs_dentry_operations;
> +extern const struct super_operations eventfs_ro_super_operations;
> +extern struct file_system_type eventfs_ro_fs_type;
> +
>  enum {
>  	TRACEFS_EVENT_INODE		= BIT(1),
>  	TRACEFS_GID_PERM_SET		= BIT(2),
> @@ -73,6 +77,8 @@ struct dentry *tracefs_end_creating(struct dentry *dentry);
>  struct dentry *tracefs_failed_creating(struct dentry *dentry);
>  struct inode *tracefs_get_inode(struct super_block *sb);
>  
> +struct dentry *eventfs_ro_get_root(void);
> +
>  void eventfs_remount(struct tracefs_inode *ti, bool update_uid, bool update_gid);
>  void eventfs_d_release(struct dentry *dentry);
>  
> diff --git a/include/linux/tracefs.h b/include/linux/tracefs.h
> index bc354d340046..41e97a6bd69a 100644
> --- a/include/linux/tracefs.h
> +++ b/include/linux/tracefs.h
> @@ -75,6 +75,7 @@ struct eventfs_entry {
>  	const char			*name;
>  	eventfs_callback		callback;
>  	eventfs_release			release;
> +	bool				read_only;
>  };
>  
>  struct eventfs_inode;
> @@ -87,6 +88,8 @@ struct eventfs_inode *eventfs_create_dir(const char *name, struct eventfs_inode
>  					 const struct eventfs_entry *entries,
>  					 int size, void *data);
>  
> +int eventfs_create_events_ro_copy(const char *name, struct eventfs_inode *ei);
> +
>  void eventfs_remove_events_dir(struct eventfs_inode *ei);
>  void eventfs_remove_dir(struct eventfs_inode *ei);
>  
> diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
> index 66a91c8b1cb9..521916f64dee 100644
> --- a/include/uapi/linux/magic.h
> +++ b/include/uapi/linux/magic.h
> @@ -76,6 +76,7 @@
>  #define STACK_END_MAGIC		0x57AC6E9D
>  
>  #define TRACEFS_MAGIC          0x74726163
> +#define EVENTFS_SUPER_MAGIC    0x65766673
>  
>  #define V9FS_MAGIC		0x01021997
>  
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 49d135bc2fbf..1976920beb1a 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -3298,17 +3298,20 @@ event_create_dir(struct eventfs_inode *parent, struct trace_event_file *file)
>  		{
>  			.name		= "format",
>  			.callback	= event_callback,
> +			.read_only	= true,
>  		},
>  #ifdef CONFIG_PERF_EVENTS
>  		{
>  			.name		= "id",
>  			.callback	= event_callback,
> +			.read_only	= true,
>  		},
>  #endif
>  #ifdef CONFIG_BPF_EVENTS
>  		{
>  			.name		= "btf_ids",
>  			.callback	= event_callback,
> +			.read_only	= true,
>  		},
>  #endif
>  #define NR_RO_EVENT_ENTRIES	(1 + IS_ENABLED(CONFIG_PERF_EVENTS) + \
> @@ -4722,6 +4725,7 @@ static int events_callback(const char *name, umode_t *mode, void **data,
>  static int
>  create_event_toplevel_files(struct dentry *parent, struct trace_array *tr)
>  {
> +	static bool event_dir_ro_created;
>  	struct eventfs_inode *e_events;
>  	struct dentry *entry;
>  	int nr_entries;
> @@ -4729,10 +4733,12 @@ create_event_toplevel_files(struct dentry *parent, struct trace_array *tr)
>  		{
>  			.name		= "header_page",
>  			.callback	= events_callback,
> +			.read_only	= true,
>  		},
>  		{
>  			.name		= "header_event",
>  			.callback	= events_callback,
> +			.read_only	= true,
>  		},
>  #define NR_RO_TOP_ENTRIES	2
>  /* Readonly files must be above this line and counted by NR_RO_TOP_ENTRIES. */
> @@ -4775,6 +4781,13 @@ create_event_toplevel_files(struct dentry *parent, struct trace_array *tr)
>  
>  	tr->event_dir = e_events;
>  
> +	if (!event_dir_ro_created && (tr->flags & TRACE_ARRAY_FL_GLOBAL)) {
> +		int ret;
> +
> +		ret = eventfs_create_events_ro_copy("events", e_events);
> +		if (!ret)
> +			event_dir_ro_created = true;
> +	}
>  	return 0;
>  }
>  
> -- 
> 2.53.0
> 
>

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
