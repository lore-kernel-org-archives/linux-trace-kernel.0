Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FAD2E6CCD;
	Mon, 10 Aug 2026 20:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786392423; cv=none; b=mPRDkkgg8925FnWQkye5IDoN+O7zLSD6Hlu+KRk/JVJCcSZDoTlSrkmbi7qEkD7DC0D1YkytncavxcJOBZZGmy/S3DC/+tB6bf0T+uHtLQsKSvGF0/ao45yPfQAwiGaO15wjN386MjO3FDidAibj2ERJGi5J9SDQRAIxU5XoC8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786392423; c=relaxed/simple;
	bh=Yl/gSw8Cbm9FxW5Wou8MUgvtrcm79wiTZxcAkNkCQRc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=CLXl83rA5AHXFTdyou46kCjX4EnbDroZcInE/GXBRCjBDizpGTUkpI0HtuFBGeY1GAuCtVCSkpbmD0nOrliDH4IP65tqfPunJfvhiq+p5U6MUfCjRtngdzWuuWULlhZoCnOmDpLinPhJARa+DhL0sXMdYxiS8Jela7s+gBoIjHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rostedt.org; spf=pass smtp.mailfrom=rostedt.org; dkim=pass (2048-bit key) header.d=rostedt.org header.i=@rostedt.org header.b=XFLCdlru; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K8s79ifB; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rostedt.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rostedt.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rostedt.org header.i=@rostedt.org header.b="XFLCdlru";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K8s79ifB"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 8699A1D0012D;
	Mon, 10 Aug 2026 16:06:59 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 10 Aug 2026 16:06:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rostedt.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1786392419; x=1786478819; bh=z6
	i+u1hiSEUBpYzoOdSkMMu1Zbn8WB0y8787bViXZYI=; b=XFLCdlru7pfaD8e0+f
	H6WXAiF5y89A7YG2jF1I80Xk+us8u89mKmJvCuy5PG9jncvCcQRyLXqRrL7UoX1L
	xKdfX0YOA1paeNfEyTGdMDn1BtfT7cse2TcwX6lTwG4NI7nLCxa3g1M8b4XUwadA
	HN7Le6O848wv8jXpGD4/FS3XCUhMTjQ3yyQZ8PU6H7VgsZqhONFo/EV4/PoTHygE
	lweV3Pvw6nD65c+MmTG8I8NJ8OHXCgRfB0vJcyLhihXKq/+wdS8XiHnmL90c2vdM
	A46Ld9d0aJ+wQQsbmi+lbd2NXSpxWggLH5QEBZh1NWy1XNJKFqBanc1iE8PTj1eh
	M1zQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1786392419; x=1786478819; bh=z6i+u1hiSEUBpYzoOdSkMMu1Zbn8
	WB0y8787bViXZYI=; b=K8s79ifB4CJjGP/YeIFlzGuvgdQ48p9EtZW/pdZySAW4
	UT9AE5cDGf0MeFRInTMDOxBgee6rUUq3YabzV6LnqILmh92ayLWkIFG54t+ipWgA
	EFNO16TlJz7n5iHDb5cDIc205Ipr/j06VVELS4F6XRZLj7dvjc8Yit1XodeJX0WQ
	IhQYazV3uD6d0iOsYUFQZC2A5ctnZVEYROluizX0rDd1LKwTfiEezqVW9oRbnmJe
	dl/rOUTBnYeHxhab2nY9W815dVHZcUAP1eaaf8qQco5czPyEAjzlL+Bcg52x9XpA
	3OICyK6qYbHlIUVvzvuHV4QnMzgbGpB5O3wPey3mDQ==
X-ME-Sender: <xms:Yy96ag_YLu0xzTyrkGY8KpUF2m_cKoV-Te-bnzDa7uhzHhVYtF0EPQ>
    <xme:Yy96atotcFA1YQtqza6mL0uhEsJO-PYWleCduMrtOcEib0BzjReaKUHU8l-spiZ5Q
    x8YG0iwdZDApfixZqAG3WeBxs9iJTGbCDXsFr0Cb8KHu_04AVH07Q>
X-ME-Received: <xmr:Yy96aqSRbdvDLsU8ufmunnGMNAmv9ItArgaAUjfSOgYeTEMfOTX07nBZ0s8PrRQ_6fSxY1SS>
X-ME-Proxy-Cause: dmFkZTGwk4K9R8ic6YlpG+MYYMfRgczWTcNOA5ABDnKE9gGBJCvDrUXmQnOcrgMyakla4V
    TEfroIXZiBQTdjMCpBjfb4HeDolTcqm8HxyhSCdQC0dKIhPwowpPud3vU4kY21KVLSaJ9R
    qYZ6LB5YbXauAVnlbkn8HNzKDYTrl7eEBKQWBFBAKvx9WCpcjSMdod6/4A8ry+9YIWy2PO
    2ahrT/hqhcQd9UKAsKFKLfDIuI+G3Fdl+JSvKdAcqaBZ5XDmSU366ufQyu+d1/jYeGoJ9E
    zXsxqDo6DDco2Hakd++MEzMOVDEheUAag2QqVZQtyQFKJhF3uRzgvVTGT2TE7ZIQ2shhQh
    qTCfOqV9RjV2ZFsaUzocGIqHC4snXqpnKO2eJzOEgnzhdQCNqp0KB8SHrWniKCMWPkKD29
    W7j7fzBjxUuLxZZJCzabWWpfdlMumjmpD0VaYSrjXz8hbmLvfi0LROPTMt9n9WuXcln2Nw
    eZG1UZ7M04D1TGy9LMOH7mDon4Icqw84qH8x2+f6WAnjbFrOob0q6neS9strFc0VTUyTYK
    d/OommUNN9iJ13+utxflADdDYPBX8VO5yo+cDSR/Z2z7I7tLLZb4uwUYOtq96t9ImIscVd
    bANx1qtJhdD+u7WJZCg/6/ftpdVv+pYsb2FAP7jZgl+gZJ5TjyxduSFHzyWA
X-ME-Proxy: <xmx:Yy96agMRUmswNkWVDWiygaypWukmgMrCUNCNza5ci8C89ZvooKcrvw>
    <xmx:Yy96aojsBH-cVMJx6_kbYhd91YFa43k70ZNQ3K0it--dDIxRoP4SDg>
    <xmx:Yy96atnMxvaAIhnC-hn0Om18oWVCKrNaJ3P7c-cFnmb9gchHvh3QpA>
    <xmx:Yy96akhnYihyKTADmgSyB2fBwTQ80O-rffR3SbzYDF4cbXDAVy-tpQ>
    <xmx:Yy96anNFea9M-4_NGogkgUoxB7wpAnjeoTTxpC7sQg6Slax6Zb_cpxDK>
Feedback-ID: id06e481b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Aug 2026 16:06:58 -0400 (EDT)
Date: Mon, 10 Aug 2026 16:07:08 -0400
From: Steven Rostedt <steven@rostedt.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Anubhav Shelat <ashelat@redhat.com>, Masami Hiramatsu 
 <mhiramat@kernel.org>, Shivank Garg <shivankg@amd.com>, Ackerley Tng 
 <ackerleytng@google.com>, Fuad Tabba <tabba@google.com>, Christian Brauner
  <brauner@kernel.org>, Sean Christopherson <seanjc@google.com>
Subject: [PATCH v3] tracefs: Add read-only eventfs filesystem at
 /sys/kernel/events
Message-ID: <20260810160708.3460a2fd@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

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
Changes since v2: https://patch.msgid.link/20260808131104.2ad18f65@robin

- Removed eventfs_ro_put_root() as it wasn't used (Sashiko)

- Commented about the dentry not being freed (Sashiko)

- Made the eventfs root dentry static (only one is allowed)

- Moved most the eventfs mounting code to eventfs_inode.c file.

 fs/tracefs/event_inode.c    | 187 ++++++++++++++++++++++++++++++++++--
 fs/tracefs/inode.c          |  21 +++-
 fs/tracefs/internal.h       |   6 ++
 include/linux/tracefs.h     |   3 +
 include/uapi/linux/magic.h  |   1 +
 kernel/trace/trace_events.c |  12 +++
 6 files changed, 219 insertions(+), 11 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 39c7a34531e8..be21b8510c14 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -16,6 +16,7 @@
  */
 #include <linux/fsnotify.h>
 #include <linux/fs.h>
+#include <linux/fs_context.h>
 #include <linux/namei.h>
 #include <linux/workqueue.h>
 #include <linux/security.h>
@@ -24,6 +25,77 @@
 #include <linux/delay.h>
 #include "internal.h"
 
+static struct vfsmount *eventfs_ro_mount;
+static int eventfs_ro_mount_count;
+
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
+struct file_system_type eventfs_ro_fs_type = {
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
 /*
  * eventfs_mutex protects the eventfs_inode (ei) dentry. Any access
  * to the ei->dentry must be done under this mutex and after checking
@@ -151,7 +223,11 @@ static inline struct eventfs_inode *get_ei(struct eventfs_inode *ei)
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
@@ -229,6 +305,10 @@ static const struct inode_operations eventfs_dir_inode_operations = {
 	.setattr	= eventfs_set_attr,
 };
 
+static const struct inode_operations eventfs_ro_dir_inode_operations = {
+	.lookup		= eventfs_root_lookup_ro,
+};
+
 static const struct inode_operations eventfs_file_inode_operations = {
 	.setattr	= eventfs_set_attr,
 };
@@ -239,6 +319,12 @@ static const struct file_operations eventfs_file_operations = {
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
@@ -402,7 +488,7 @@ static struct dentry *lookup_file(struct eventfs_inode *parent_ei,
  * a eventfs_inode.
  */
 static struct dentry *lookup_dir_entry(struct dentry *dentry,
-	struct eventfs_inode *pei, struct eventfs_inode *ei)
+	struct eventfs_inode *pei, struct eventfs_inode *ei, bool ro)
 {
 	struct inode *inode;
 	umode_t mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
@@ -411,8 +497,13 @@ static struct dentry *lookup_dir_entry(struct dentry *dentry,
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
@@ -514,9 +605,10 @@ lookup_file_dentry(struct dentry *dentry,
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
@@ -539,7 +631,7 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
 		/* A child is freed and removed from the list at the same time */
 		if (WARN_ON_ONCE(ei_child->is_freed))
 			return NULL;
-		return lookup_dir_entry(dentry, ei, ei_child);
+		return lookup_dir_entry(dentry, ei, ei_child, ro);
 	}
 
 	for (int i = 0; i < ei->nr_entries; i++) {
@@ -551,20 +643,40 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
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
@@ -606,6 +718,9 @@ static int eventfs_iterate(struct file *file, struct dir_context *ctx)
 		entry = &ei->entries[i];
 		name = entry->name;
 
+		if (ro && !entry->read_only)
+			continue;
+
 		/* If ei->is_freed then just bail here, nothing more to do */
 		scoped_guard(mutex, &eventfs_mutex) {
 			if (ei->is_freed)
@@ -650,6 +765,16 @@ static int eventfs_iterate(struct file *file, struct dir_context *ctx)
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
@@ -812,6 +937,52 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
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
+	static struct dentry *dentry;
+	struct tracefs_inode *ti;
+	struct inode *inode;
+
+	/* Can only be called once. */
+	if (dentry)
+		return -EBUSY;
+
+	/* Reference acquired but never freed */
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
index f3d6188a3b7b..dafa0d587f04 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -423,6 +423,14 @@ static const struct super_operations tracefs_super_operations = {
 	.show_options	= tracefs_show_options,
 };
 
+const struct super_operations eventfs_ro_super_operations = {
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
@@ -455,7 +463,7 @@ static int tracefs_d_delete(const struct dentry *dentry)
 	return dentry->d_fsdata == NULL;
 }
 
-static const struct dentry_operations tracefs_dentry_operations = {
+const struct dentry_operations tracefs_dentry_operations = {
 	.d_revalidate = tracefs_d_revalidate,
 	.d_release = tracefs_d_release,
 	.d_delete = tracefs_d_delete,
@@ -801,8 +809,15 @@ static int __init tracefs_init(void)
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
index a4a7f8431aff..068bee7b9e72 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -2,6 +2,10 @@
 #ifndef _TRACEFS_INTERNAL_H
 #define _TRACEFS_INTERNAL_H
 
+extern const struct dentry_operations tracefs_dentry_operations;
+extern const struct super_operations eventfs_ro_super_operations;
+extern struct file_system_type eventfs_ro_fs_type;
+
 enum {
 	TRACEFS_EVENT_INODE		= BIT(1),
 	TRACEFS_GID_PERM_SET		= BIT(2),
@@ -73,6 +77,8 @@ struct dentry *tracefs_end_creating(struct dentry *dentry);
 struct dentry *tracefs_failed_creating(struct dentry *dentry);
 struct inode *tracefs_get_inode(struct super_block *sb);
 
+struct dentry *eventfs_ro_get_root(void);
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
index c01b10b99f67..46fb3ac57a8e 100644
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
@@ -4544,6 +4546,7 @@ static int events_callback(const char *name, umode_t *mode, void **data,
 static int
 create_event_toplevel_files(struct dentry *parent, struct trace_array *tr)
 {
+	static bool event_dir_ro_created;
 	struct eventfs_inode *e_events;
 	struct dentry *entry;
 	int nr_entries;
@@ -4551,10 +4554,12 @@ create_event_toplevel_files(struct dentry *parent, struct trace_array *tr)
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
@@ -4597,6 +4602,13 @@ create_event_toplevel_files(struct dentry *parent, struct trace_array *tr)
 
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

