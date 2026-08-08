Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D0E346E63;
	Sat,  8 Aug 2026 17:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786209072; cv=none; b=mLekj5zuQyUtoGikNUZUJC2hNX4QsehRdt0CVu0QQNm+fHHfApeQiQhcNFXZB04q+lydQ30YBrimv0GTAs04hcR5+9ujd+ckN0dPrqD4uc3fle38skLazZ2RmXICCQKWkv1POYLykBUWymHjvpeaDHe+pDmwNFXpEgLpVuT2b38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786209072; c=relaxed/simple;
	bh=VyG3QffEE3C3pLx8f0Dti/PIwAicjsH4Watn6F1N3GM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=in9OuMAhOdgy5wVqSwqhvoZe8hxagRvjGx/qsi1Y3RWC4P3p7sHxYE1mGQSgo+PWpKYQlhuONIiHwYGS/C/TXSaMDqyyh9cbR2dJoJPEpakllQwUq8qntgIC6hIxiVwdwkyunnCMxGAM3tF9a5VYkDiojeqO5iKLBTQDFXv4jU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id AF6EE80340;
	Sat,  8 Aug 2026 17:11:07 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id A20762000E;
	Sat,  8 Aug 2026 17:11:05 +0000 (UTC)
Date: Sat, 8 Aug 2026 13:11:04 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Anubhav Shelat <ashelat@redhat.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Shivank Garg <shivankg@amd.com>, Ackerley Tng
 <ackerleytng@google.com>, Fuad Tabba <tabba@google.com>, Christian Brauner
 <brauner@kernel.org>, Sean Christopherson <seanjc@google.com>
Subject: [PATCH v2] tracefs: Add read-only eventfs filesystem at
 /sys/kernel/events
Message-ID: <20260808131104.2ad18f65@robin>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: aquf96kyhfhqpwogedusd8xkw4rnzdbd
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: A20762000E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+Rncc2dFZ2SJO/eYVbqX/Lz0otYW8m2Go=
X-HE-Tag: 1786209065-833990
X-HE-Meta: U2FsdGVkX19a3nFWe4qVjQC1XAADDsGRj9gf3/2LrRpaufGI0ehH4k93ElUNtERjAfV0VmCtjm4Hhba1HMYXsBwGA3sPUF33xqKpQiJuvWJGCjrub/9rgmO5pbTT6m/26vzk9hRfY+Nc5Wvi+jKnTWrwvDnW6eUMwcok9cPlFfViXOVQGD6hoNdQRqEmbC0e6NcwnEmMNZb8eUf2YXaai0ky34PXFV3P6cSAuzdhidabPhjVigPlzQhqO+T7D69vAMl79RqjjwXxyqJ6ia2ypzusHuxFzElabqT5eMVCT4ggctvEWIP/Y9bjzbRLVLzvZN83ykhoYfep1qVBzDAySrTs1SVfuN2QwX16gVBwp4uwwcnBmHWHP4ZzV9JwbPGciSb1qodd2VTHNgHLzNJ6FSpRYSfpZ0quM/11ZfRswjLBw+9ljRmHlTzmStR/vxE31A0XLAV6aoIQV1cOU2GxnuzkVRfnWuBUkhatkYe3hP4=

From: Anubhav Shelat <ashelat@redhat.com>

Introduce a new read-only pseudo-filesystem "eventfs" mounted at
/sys/kernel/events that exposes trace event format and id files
(mode 0444) to unprivileged users. This allows tools like perf to
discover event formats without requiring access to the full
tracefs/debugfs mount.

The eventfs file system reuses the existing eventfs_inode lazy-lookup
infrastructure. A new set of super_operations
(eventfs_ro_super_operations) shares the tracefs inode allocator so
that eventfs_get_inode() and get_tracefs() work on the RO superblock.
The superblock is manually initialized to ensure the root inode is
allocated with tracefs_alloc_inode, allowing the root to serve
directly as the events directory without another events subdirectory.

Each qualifying event gets a subsystem directory containing format
and id files. The top-level events directory also exposes header_page
and header_event. Similar to tracefs, a change will need to be made in
systemd to mount this filesystem automatically.

[
  Steven Rostedt rewrote to use the lookup functions to determine read
  only files to show. The struct eventfs_entry now has a "readonly" field
  and if it is set, it will be displayed in the read only file system.
  The original code [1] duplicated the eventfs_inodes for every event and
  subsystem. The new approach uses the existing eventfs_inodes (without
  requiring more memory to store them) and uses the eventfs_entry arrays to
  show which files are allowed to be read readonly or not.

  [1] https://patch.msgid.link/20260715135231.338535-4-ashelat@redhat.com
]

Assisted-by: CLAUDE:claude-opus-4 Apogee
Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
Changes since v1: (the above link)

- Rewrote to reuse the evnetfs_inodes with lookup functions.
  I kept Anubhav as author as there's still code unmodified from
  the original patch.

 fs/tracefs/event_inode.c    | 110 +++++++++++++++++++++++++++++++++---
 fs/tracefs/inode.c          |  95 ++++++++++++++++++++++++++++++-
 fs/tracefs/internal.h       |   3 +
 include/linux/tracefs.h     |   3 +
 include/uapi/linux/magic.h  |   1 +
 kernel/trace/trace_events.c |  12 ++++
 6 files changed, 214 insertions(+), 10 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 39c7a34531e8..007cdf1a67f3 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -151,7 +151,11 @@ static inline struct eventfs_inode *get_ei(struct eventfs_inode *ei)
 static struct dentry *eventfs_root_lookup(struct inode *dir,
 					  struct dentry *dentry,
 					  unsigned int flags);
+static struct dentry *eventfs_root_lookup_ro(struct inode *dir,
+					     struct dentry *dentry,
+					     unsigned int flags);
 static int eventfs_iterate(struct file *file, struct dir_context *ctx);
+static int eventfs_ro_iterate(struct file *file, struct dir_context *ctx);
 
 static void update_attr(struct eventfs_attr *attr, struct iattr *iattr)
 {
@@ -229,6 +233,10 @@ static const struct inode_operations eventfs_dir_inode_operations = {
 	.setattr	= eventfs_set_attr,
 };
 
+static const struct inode_operations eventfs_ro_dir_inode_operations = {
+	.lookup		= eventfs_root_lookup_ro,
+};
+
 static const struct inode_operations eventfs_file_inode_operations = {
 	.setattr	= eventfs_set_attr,
 };
@@ -239,6 +247,12 @@ static const struct file_operations eventfs_file_operations = {
 	.llseek		= generic_file_llseek,
 };
 
+static const struct file_operations eventfs_ro_file_operations = {
+	.read		= generic_read_dir,
+	.iterate_shared	= eventfs_ro_iterate,
+	.llseek		= generic_file_llseek,
+};
+
 static void eventfs_set_attrs(struct eventfs_inode *ei, bool update_uid, kuid_t uid,
 			      bool update_gid, kgid_t gid, int level)
 {
@@ -402,7 +416,7 @@ static struct dentry *lookup_file(struct eventfs_inode *parent_ei,
  * a eventfs_inode.
  */
 static struct dentry *lookup_dir_entry(struct dentry *dentry,
-	struct eventfs_inode *pei, struct eventfs_inode *ei)
+	struct eventfs_inode *pei, struct eventfs_inode *ei, bool ro)
 {
 	struct inode *inode;
 	umode_t mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
@@ -411,8 +425,13 @@ static struct dentry *lookup_dir_entry(struct dentry *dentry,
 	if (unlikely(!inode))
 		return ERR_PTR(-ENOMEM);
 
-	inode->i_op = &eventfs_dir_inode_operations;
-	inode->i_fop = &eventfs_file_operations;
+	if (ro) {
+		inode->i_op = &eventfs_ro_dir_inode_operations;
+		inode->i_fop = &eventfs_ro_file_operations;
+	} else {
+		inode->i_op = &eventfs_dir_inode_operations;
+		inode->i_fop = &eventfs_file_operations;
+	}
 
 	/* All directories will have the same inode number */
 	inode->i_ino = eventfs_dir_ino(ei);
@@ -514,9 +533,10 @@ lookup_file_dentry(struct dentry *dentry,
  * list, if @dentry found go ahead and create the file/dir
  */
 
-static struct dentry *eventfs_root_lookup(struct inode *dir,
-					  struct dentry *dentry,
-					  unsigned int flags)
+static struct dentry *__eventfs_root_lookup(struct inode *dir,
+					    struct dentry *dentry,
+					    unsigned int flags,
+					    bool ro)
 {
 	struct eventfs_inode *ei_child;
 	struct tracefs_inode *ti;
@@ -539,7 +559,7 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
 		/* A child is freed and removed from the list at the same time */
 		if (WARN_ON_ONCE(ei_child->is_freed))
 			return NULL;
-		return lookup_dir_entry(dentry, ei, ei_child);
+		return lookup_dir_entry(dentry, ei, ei_child, ro);
 	}
 
 	for (int i = 0; i < ei->nr_entries; i++) {
@@ -551,20 +571,40 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
 		if (strcmp(name, entry->name) != 0)
 			continue;
 
+		if (ro && !entry->read_only)
+			return NULL;
+
 		data = ei->data;
 		if (entry->callback(name, &mode, &data, &fops) <= 0)
 			return NULL;
 
+		if (ro)
+			mode |= 0444;
+
 		return lookup_file_dentry(dentry, ei, i, mode, data, fops);
 
 	}
 	return NULL;
 }
 
+static struct dentry *eventfs_root_lookup(struct inode *dir,
+					  struct dentry *dentry,
+					  unsigned int flags)
+{
+	return __eventfs_root_lookup(dir, dentry, flags, false);
+}
+
+static struct dentry *eventfs_root_lookup_ro(struct inode *dir,
+					     struct dentry *dentry,
+					     unsigned int flags)
+{
+	return __eventfs_root_lookup(dir, dentry, flags, true);
+}
+
 /*
  * Walk the children of a eventfs_inode to fill in getdents().
  */
-static int eventfs_iterate(struct file *file, struct dir_context *ctx)
+static int __eventfs_iterate(struct file *file, struct dir_context *ctx, bool ro)
 {
 	const struct file_operations *fops;
 	struct inode *f_inode = file_inode(file);
@@ -606,6 +646,9 @@ static int eventfs_iterate(struct file *file, struct dir_context *ctx)
 		entry = &ei->entries[i];
 		name = entry->name;
 
+		if (ro && !entry->read_only)
+			continue;
+
 		/* If ei->is_freed then just bail here, nothing more to do */
 		scoped_guard(mutex, &eventfs_mutex) {
 			if (ei->is_freed)
@@ -650,6 +693,16 @@ static int eventfs_iterate(struct file *file, struct dir_context *ctx)
 	return 1;
 }
 
+static int eventfs_iterate(struct file *file, struct dir_context *ctx)
+{
+	return __eventfs_iterate(file, ctx, false);
+}
+
+static int eventfs_ro_iterate(struct file *file, struct dir_context *ctx)
+{
+	return __eventfs_iterate(file, ctx, true);
+}
+
 /**
  * eventfs_create_dir - Create the eventfs_inode for this directory
  * @name: The name of the directory to create.
@@ -812,6 +865,47 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
 	return ERR_PTR(-ENOMEM);
 }
 
+/**
+ * eventfs_create_events_dir_ro - create a read-only events directory
+ * @name: The name of the top level directory to create.
+ * @entries: A list of entries that represent the files under this directory
+ * @size: The number of @entries
+ * @data: The default data to pass to the files (an entry may override it).
+ *
+ * This function configures the eventfs filesystem root as a read-only
+ * trace event directory using the existing eventfs_inode lazy-lookup
+ * infrastructure.
+ *
+ * See eventfs_create_dir() for use of @entries.
+ */
+int eventfs_create_events_ro_copy(const char *name, struct eventfs_inode *ei)
+{
+	struct dentry *dentry;
+	struct tracefs_inode *ti;
+	struct inode *inode;
+
+	dentry = eventfs_ro_get_root();
+	if (IS_ERR(dentry))
+		return PTR_ERR(dentry);
+
+	inode = d_inode(dentry);
+
+	INIT_LIST_HEAD(&ei->children);
+	INIT_LIST_HEAD(&ei->list);
+
+	ti = get_tracefs(inode);
+	ti->flags |= TRACEFS_EVENT_INODE;
+	ti->private = ei;
+
+	inode->i_op = &eventfs_ro_dir_inode_operations;
+	inode->i_fop = &eventfs_ro_file_operations;
+
+	/* This is never freed */
+	dentry->d_fsdata = get_ei(ei);
+
+	return 0;
+}
+
 /**
  * eventfs_remove_rec - remove eventfs dir or file from list
  * @ei: eventfs_inode to be removed.
diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index f3d6188a3b7b..fd064d79d940 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -30,6 +30,9 @@ static struct vfsmount *tracefs_mount;
 static int tracefs_mount_count;
 static bool tracefs_registered;
 
+static struct vfsmount *eventfs_ro_mount;
+static int eventfs_ro_mount_count;
+
 /*
  * Keep track of all tracefs_inodes in order to update their
  * flags if necessary on a remount.
@@ -423,6 +426,14 @@ static const struct super_operations tracefs_super_operations = {
 	.show_options	= tracefs_show_options,
 };
 
+static const struct super_operations eventfs_ro_super_operations = {
+	.alloc_inode    = tracefs_alloc_inode,
+	.free_inode     = tracefs_free_inode,
+	.destroy_inode  = tracefs_destroy_inode,
+	.drop_inode     = tracefs_drop_inode,
+	.statfs		= simple_statfs,
+};
+
 /*
  * It would be cleaner if eventfs had its own dentry ops.
  *
@@ -523,6 +534,79 @@ static struct file_system_type trace_fs_type = {
 };
 MODULE_ALIAS_FS("tracefs");
 
+static int eventfs_ro_fill_super(struct super_block *sb, struct fs_context *fc)
+{
+	struct inode *inode;
+	struct dentry *root;
+
+	sb->s_blocksize = PAGE_SIZE;
+	sb->s_blocksize_bits = PAGE_SHIFT;
+	sb->s_magic = EVENTFS_SUPER_MAGIC;
+	sb->s_op = &eventfs_ro_super_operations;
+	sb->s_time_gran = 1;
+	sb->s_flags |= SB_RDONLY;
+
+	inode = new_inode(sb);
+	if (!inode)
+		return -ENOMEM;
+
+	inode->i_ino = 1;
+	inode->i_mode = S_IFDIR | 0555;
+	simple_inode_init_ts(inode);
+	inode->i_op = &simple_dir_inode_operations;
+	inode->i_fop = &simple_dir_operations;
+	set_nlink(inode, 2);
+
+	set_default_d_op(sb, &tracefs_dentry_operations);
+
+	root = d_make_root(inode);
+	if (!root)
+		return -ENOMEM;
+
+	sb->s_root = root;
+
+	return 0;
+}
+
+static int eventfs_ro_get_tree(struct fs_context *fc)
+{
+	return get_tree_single(fc, eventfs_ro_fill_super);
+}
+
+static const struct fs_context_operations eventfs_ro_context_ops = {
+	.get_tree	= eventfs_ro_get_tree,
+};
+
+static int eventfs_ro_init_fs_context(struct fs_context *fc)
+{
+	fc->ops = &eventfs_ro_context_ops;
+	return 0;
+}
+
+static struct file_system_type eventfs_ro_fs_type = {
+	.owner =	THIS_MODULE,
+	.name =		"eventfs",
+	.init_fs_context = eventfs_ro_init_fs_context,
+	.kill_sb =	kill_anon_super,
+};
+
+struct dentry *eventfs_ro_get_root(void)
+{
+	int error;
+
+	error = simple_pin_fs(&eventfs_ro_fs_type, &eventfs_ro_mount,
+			      &eventfs_ro_mount_count);
+	if (error)
+		return ERR_PTR(error);
+
+	return dget(eventfs_ro_mount->mnt_root);
+}
+
+void eventfs_ro_put_root(void)
+{
+	simple_release_fs(&eventfs_ro_mount, &eventfs_ro_mount_count);
+}
+
 struct dentry *tracefs_start_creating(const char *name, struct dentry *parent)
 {
 	struct dentry *dentry;
@@ -801,8 +885,15 @@ static int __init tracefs_init(void)
 		return -EINVAL;
 
 	retval = register_filesystem(&trace_fs_type);
-	if (!retval)
-		tracefs_registered = true;
+	if (retval)
+		return retval;
+	tracefs_registered = true;
+
+	retval = sysfs_create_mount_point(kernel_kobj, "events");
+	if (retval)
+		return retval;
+
+	retval = register_filesystem(&eventfs_ro_fs_type);
 
 	return retval;
 }
diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
index a4a7f8431aff..0440413f959b 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -73,6 +73,9 @@ struct dentry *tracefs_end_creating(struct dentry *dentry);
 struct dentry *tracefs_failed_creating(struct dentry *dentry);
 struct inode *tracefs_get_inode(struct super_block *sb);
 
+struct dentry *eventfs_ro_get_root(void);
+void eventfs_ro_put_root(void);
+
 void eventfs_remount(struct tracefs_inode *ti, bool update_uid, bool update_gid);
 void eventfs_d_release(struct dentry *dentry);
 
diff --git a/include/linux/tracefs.h b/include/linux/tracefs.h
index bc354d340046..41e97a6bd69a 100644
--- a/include/linux/tracefs.h
+++ b/include/linux/tracefs.h
@@ -75,6 +75,7 @@ struct eventfs_entry {
 	const char			*name;
 	eventfs_callback		callback;
 	eventfs_release			release;
+	bool				read_only;
 };
 
 struct eventfs_inode;
@@ -87,6 +88,8 @@ struct eventfs_inode *eventfs_create_dir(const char *name, struct eventfs_inode
 					 const struct eventfs_entry *entries,
 					 int size, void *data);
 
+int eventfs_create_events_ro_copy(const char *name, struct eventfs_inode *ei);
+
 void eventfs_remove_events_dir(struct eventfs_inode *ei);
 void eventfs_remove_dir(struct eventfs_inode *ei);
 
diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
index 4f2da935a76c..7cf8f1a1ae38 100644
--- a/include/uapi/linux/magic.h
+++ b/include/uapi/linux/magic.h
@@ -75,6 +75,7 @@
 #define STACK_END_MAGIC		0x57AC6E9D
 
 #define TRACEFS_MAGIC          0x74726163
+#define EVENTFS_SUPER_MAGIC    0x65766673
 
 #define V9FS_MAGIC		0x01021997
 
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index ea608519f4b1..a3734e6c3cc7 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -3142,11 +3142,13 @@ event_create_dir(struct eventfs_inode *parent, struct trace_event_file *file)
 		{
 			.name		= "format",
 			.callback	= event_callback,
+			.read_only	= true,
 		},
 #ifdef CONFIG_PERF_EVENTS
 		{
 			.name		= "id",
 			.callback	= event_callback,
+			.read_only	= true,
 		},
 #endif
 #define NR_RO_EVENT_ENTRIES	(1 + IS_ENABLED(CONFIG_PERF_EVENTS))
@@ -4545,6 +4547,7 @@ static int events_callback(const char *name, umode_t *mode, void **data,
 static int
 create_event_toplevel_files(struct dentry *parent, struct trace_array *tr)
 {
+	static bool event_dir_ro_created;
 	struct eventfs_inode *e_events;
 	struct dentry *entry;
 	int nr_entries;
@@ -4552,10 +4555,12 @@ create_event_toplevel_files(struct dentry *parent, struct trace_array *tr)
 		{
 			.name		= "header_page",
 			.callback	= events_callback,
+			.read_only	= true,
 		},
 		{
 			.name		= "header_event",
 			.callback	= events_callback,
+			.read_only	= true,
 		},
 #define NR_RO_TOP_ENTRIES	2
 /* Readonly files must be above this line and counted by NR_RO_TOP_ENTRIES. */
@@ -4598,6 +4603,13 @@ create_event_toplevel_files(struct dentry *parent, struct trace_array *tr)
 
 	tr->event_dir = e_events;
 
+	if (!event_dir_ro_created && (tr->flags & TRACE_ARRAY_FL_GLOBAL)) {
+		int ret;
+
+		ret = eventfs_create_events_ro_copy("events", e_events);
+		if (!ret)
+			event_dir_ro_created = true;
+	}
 	return 0;
 }
 
-- 
2.53.0

