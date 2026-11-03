Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793746541;
	b=aon/xOxCUkbP+nn7E3mbvv/a4vo/mUz+mxnO2Bh7rhyDxAt2IvSGiHz8blJ/781CQHId
	 5yp5rdwEh6rySvC4dcSR4pvdrLKHLaaFzI9RPKt+IeXi++oH7YLO+qfKsmsC5N1dGO6h5
	 XtXoAiSnvmLSzys1DAWSlwjZ566qgeaCUMFL5kh/dv/aLZ92uhnAtwTPJEJferBni6gln
	 FQ7Yv0eXt/KnudRM2KPMQVPK8QyfYSWeTj06Pi/kZbGHFCCAOQ8MmQlZHLrIPNBbywPPF
	 AFm4710jzduIoHxx4F6XN+bM9JgYZH+HMXQX4WB68X3Ve0rNa8t8L445WHVtuIu4U7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793746541;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Rspamd-Server:X-Rspamd-Queue-Id:X-Stat-Signature:X-Spam-Status:
	 X-Session-Marker:X-Session-ID:DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=PTXXITZFCXQnqEcymCNTvty4TKFcMfPz5quz2yyhDOw=;
	b=ZI07pVk6OAiiBsxv/s49/JjbXahSaMmqaEA+pE8XOQiGNIEJOlwMD01fPVEk2CpSOTkp
	 5fEvrXMnZo9POcgi6stw2vPK48N86YCMendR0NuF2bB04RbNLn1OC6qVyaUFgpgyLllll
	 pTHnRamKdz03slL3BrXvDjfxJCfqQRMiei/JfFPeGhn0On4bmMsL3LbeTXE5Z/ULawZSb
	 Rww8H7UmDuJdpPG17eKxi38vPVrcvvEcQlUWEodcjXy9kifGqunrbBRMShkmzUbbH62pH
	 DK3WYSmRdsrieiG9p11qzo0ewXmFt/7XuSRjYt2xMg+Jhf+PJH67j8CdJm8D1ikMepg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=DMg1Xdaj;
	arc=none smtp.remote-ip=216.40.44.15
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8150D606A324;
	Tue,  3 Nov 2026 22:55:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8150D606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=DMg1Xdaj
Received: from omf14.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id DC99080398;
	Tue,  3 Nov 2026 22:55:37 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 1F78E33;
	Tue,  3 Nov 2026 22:55:36 +0000 (UTC)
Date: Tue, 3 Nov 2026 17:55:34 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH v8] tracefs: Add read-only eventfs filesystem at
 /sys/kernel/events
Message-ID: <20261103175534.6bd94b13@gandalf.local.home>
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
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 1F78E33
X-Stat-Signature: 8zcanteut8np68jqbsjkh6skqf3qg451
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/u5AnEHJ4gMsnhjHEtQMcj6RQUX0vnpeM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=PTXXITZFCXQnqEcymCNTvty4TKFcMfPz5quz2yyhDOw=; b=DMg1Xdaj2xuRoFDcb26gULCtvGV+qIXtutIsoKbmxvWzR1HyUW0BI8GMKRhblSkYSem6atkTQlAxsgZ6jciiqi5DuYggz0TKhom5e4EytUK4YOsv4Zc5jlEz2+ZOSL3Bkr58sbHDYlxuF62BfBaz4evhrZupGc92XRyk41UMxZ8=
X-HE-Tag: 1793746536-716905
X-HE-Meta: U2FsdGVkX1/pe0Hty7CEx/DfEPf4vkg681mSL+DRvEjk/a8i4iyWkIRTIWWSX+dqyQ/dcTWOigHe0bMrbo2TEnn6rPso3XGVf50B9RKHnryDjGlGVCKTr3INNzbeNqGOuKgYRRFHdhsWAMKmZtVHWElTzvMlxYHoOZUta8LxSBOYyXd82Qpkb1kL9FyMICXNU9Bbx5JZFrbw0kEI7LshikHP48FgiUq3AkVHZYo5uAGtTL5NXaxceG3SvpdPplTvY+TVmx3c2ZTt+qYhkNUt25cqM3I5nEXdQ4xvOKrRPeiYD+rrKPKDD8TsDNsXQROPe96N+rpm5Sl0dJyIjBolpj0plJNrZ2XLMX3mo4/IstWqUwZv3uUOT//ZXb7hFoykRHdANDY1ftUBpS51vMBkZTd5dgiU1WyogaRelverrWstUanm9jbS4dteSosabvynHrWWTN8TwPNR/PURDKU48tlKq+fav8MLUodkQBSERSA=

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
Changes since v7: https://patch.msgid.link/20261103163803.77170132@gandalf.local.home

- Add comment stating that it's OK to set TRACEFS_RO_EVENT_INODE in
  eventfs_create_events_ro_copy() to shut sashiko up!

- Clear TRACEFS_RO_EVENT_INODE in tracefs_drop_inode() to make sure reused
  inodes in tracefs do not have that set. (sashiko)

 fs/tracefs/event_inode.c    | 245 ++++++++++++++++++++++++++++++++----
 fs/tracefs/inode.c          |  31 ++++-
 fs/tracefs/internal.h       |   7 ++
 include/linux/tracefs.h     |   5 +
 include/uapi/linux/magic.h  |   1 +
 kernel/trace/trace_events.c |  17 +++
 6 files changed, 281 insertions(+), 25 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 6457df72173d..e57c962ca441 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -16,14 +16,100 @@
  */
 #include <linux/fsnotify.h>
 #include <linux/fs.h>
+#include <linux/fs_context.h>
 #include <linux/namei.h>
 #include <linux/workqueue.h>
 #include <linux/security.h>
 #include <linux/tracefs.h>
+#include <linux/magic.h>
 #include <linux/kref.h>
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
+
+	/*
+	 * All eventfs directories have i_nlink == 1
+	 * (See eventfs_create_events_dir)
+	 */
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
+/* The eventfs_ro is always read-only */
+static int eventfs_ro_reconfigure(struct fs_context *fc)
+{
+	sync_filesystem(fc->root->d_sb);
+	fc->sb_flags |= SB_RDONLY;
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
+	.reconfigure	= eventfs_ro_reconfigure,
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
@@ -169,7 +255,11 @@ static inline struct eventfs_inode *get_ei(struct eventfs_inode *ei)
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
@@ -247,6 +337,10 @@ static const struct inode_operations eventfs_dir_inode_operations = {
 	.setattr	= eventfs_set_attr,
 };
 
+static const struct inode_operations eventfs_ro_dir_inode_operations = {
+	.lookup		= eventfs_root_lookup_ro,
+};
+
 static const struct inode_operations eventfs_file_inode_operations = {
 	.setattr	= eventfs_set_attr,
 };
@@ -257,6 +351,12 @@ static const struct file_operations eventfs_file_operations = {
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
@@ -316,12 +416,17 @@ void eventfs_remount(struct tracefs_inode *ti, bool update_uid, bool update_gid)
 }
 
 static void update_inode_attr(struct inode *inode, umode_t mode,
-			      struct eventfs_attr *attr, struct eventfs_root_inode *rei)
+			      struct eventfs_attr *attr, struct eventfs_root_inode *rei,
+			      bool ro)
 {
+	inode->i_mode = mode;
+
+	/* The read-only version does not allow updates to owership or permissions */
+	if (ro)
+		return;
+
 	if (attr && attr->mode & EVENTFS_SAVE_MODE)
 		inode->i_mode = attr->mode & EVENTFS_MODE_MASK;
-	else
-		inode->i_mode = mode;
 
 	if (attr && attr->mode & EVENTFS_SAVE_UID)
 		inode->i_uid = attr->uid;
@@ -335,7 +440,7 @@ static void update_inode_attr(struct inode *inode, umode_t mode,
 }
 
 static struct inode *eventfs_get_inode(struct dentry *dentry, struct eventfs_attr *attr,
-				       umode_t mode,  struct eventfs_inode *ei)
+				       umode_t mode,  struct eventfs_inode *ei, bool ro)
 {
 	struct eventfs_root_inode *rei;
 	struct eventfs_inode *pei;
@@ -350,6 +455,9 @@ static struct inode *eventfs_get_inode(struct dentry *dentry, struct eventfs_att
 	ti->private = ei;
 	ti->flags |= TRACEFS_EVENT_INODE;
 
+	if (ro)
+		ti->flags |= TRACEFS_RO_EVENT_INODE;
+
 	/* Find the top dentry that holds the "events" directory */
 	do {
 		dentry = dentry->d_parent;
@@ -359,7 +467,7 @@ static struct inode *eventfs_get_inode(struct dentry *dentry, struct eventfs_att
 
 	rei = get_root_inode(pei);
 
-	update_inode_attr(inode, mode, attr, rei);
+	update_inode_attr(inode, mode, attr, rei, ro);
 
 	return inode;
 }
@@ -372,6 +480,7 @@ static struct inode *eventfs_get_inode(struct dentry *dentry, struct eventfs_att
  * @attr: saved attributes changed by user
  * @data: something that the caller will want to get to later on.
  * @fop: struct file_operations that should be used for this file.
+ * @ro: Denote if this lookup is for the read-only version.
  *
  * This function creates a dentry that represents a file in the eventsfs_inode
  * directory. The inode.i_private pointer will point to @data in the open()
@@ -382,7 +491,8 @@ static struct dentry *lookup_file(struct eventfs_inode *parent_ei,
 				  umode_t mode,
 				  struct eventfs_attr *attr,
 				  void *data,
-				  const struct file_operations *fop)
+				  const struct file_operations *fop,
+				  bool ro)
 {
 	struct inode *inode;
 
@@ -393,11 +503,13 @@ static struct dentry *lookup_file(struct eventfs_inode *parent_ei,
 		return ERR_PTR(-EIO);
 
 	/* Only directories have ti->private set to an ei, not files */
-	inode = eventfs_get_inode(dentry, attr, mode, NULL);
+	inode = eventfs_get_inode(dentry, attr, mode, NULL, ro);
 	if (unlikely(!inode))
 		return ERR_PTR(-ENOMEM);
 
-	inode->i_op = &eventfs_file_inode_operations;
+	/* Read only does not allow setting of attributes */
+	if (!ro)
+		inode->i_op = &eventfs_file_inode_operations;
 	inode->i_fop = fop;
 	inode->i_private = data;
 
@@ -415,22 +527,28 @@ static struct dentry *lookup_file(struct eventfs_inode *parent_ei,
  * @dentry: the directory to look up
  * @pei: Pointer to the parent eventfs_inode if available
  * @ei: the eventfs_inode that represents the directory to create
+ * @ro: boolean to denote if this lookup is for the read-only version
  *
  * This function will look up a dentry for a directory represented by
  * a eventfs_inode.
  */
 static struct dentry *lookup_dir_entry(struct dentry *dentry,
-	struct eventfs_inode *pei, struct eventfs_inode *ei)
+	struct eventfs_inode *pei, struct eventfs_inode *ei, bool ro)
 {
 	struct inode *inode;
 	umode_t mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
 
-	inode = eventfs_get_inode(dentry, &ei->attr, mode, ei);
+	inode = eventfs_get_inode(dentry, &ei->attr, mode, ei, ro);
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
@@ -501,6 +619,7 @@ void eventfs_d_release(struct dentry *dentry)
  * @mode: The mode of the file.
  * @data: The data to use to set the inode of the file with on open()
  * @fops: The fops of the file to be created.
+ * @ro: Denote if this lookup is for the read-only version
  *
  * This function creates a dentry for a file associated with an
  * eventfs_inode @ei. It uses the entry attributes specified by @idx,
@@ -514,14 +633,21 @@ static struct dentry *
 lookup_file_dentry(struct dentry *dentry,
 		   struct eventfs_inode *ei, int idx,
 		   umode_t mode, void *data,
-		   const struct file_operations *fops)
+		   const struct file_operations *fops, bool ro)
 {
 	struct eventfs_attr *attr = NULL;
 
-	if (ei->entry_attrs)
+	/*
+	 * Read-only files gives all users read access,
+	 * but also should make sure this is not writable.
+	 * Read-only also does not allow modified attributes.
+	 */
+	if (ro)
+		mode = (mode & ~0222) | 0444;
+	else if (ei->entry_attrs)
 		attr = &ei->entry_attrs[idx];
 
-	return lookup_file(ei, dentry, mode, attr, data, fops);
+	return lookup_file(ei, dentry, mode, attr, data, fops, ro);
 }
 
 /**
@@ -529,14 +655,16 @@ lookup_file_dentry(struct dentry *dentry,
  * @dir: in which a lookup is being done
  * @dentry: file/dir dentry
  * @flags: Just passed to simple_lookup()
+ * @ro: Denote if this is from a read-only eventfs
  *
  * Used to create dynamic file/dir with-in @dir, search with-in @ei
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
@@ -559,7 +687,7 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
 		/* A child is freed and removed from the list at the same time */
 		if (WARN_ON_ONCE(ei_child->is_freed))
 			return NULL;
-		return lookup_dir_entry(dentry, ei, ei_child);
+		return lookup_dir_entry(dentry, ei, ei_child, ro);
 	}
 
 	for (int i = 0; i < ei->nr_entries; i++) {
@@ -571,20 +699,37 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
 		if (strcmp(name, entry->name) != 0)
 			continue;
 
+		if (ro && !entry->read_only)
+			return NULL;
+
 		data = ei->data;
 		if (entry->callback(name, &mode, &data, &fops) <= 0)
 			return NULL;
 
-		return lookup_file_dentry(dentry, ei, i, mode, data, fops);
+		return lookup_file_dentry(dentry, ei, i, mode, data, fops, ro);
 
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
@@ -630,6 +775,9 @@ static int eventfs_iterate(struct file *file, struct dir_context *ctx)
 		entry = &ei->entries[i];
 		name = entry->name;
 
+		if (ro && !entry->read_only)
+			continue;
+
 		/* If ei->is_freed then just bail here, nothing more to do */
 		scoped_guard(mutex, &eventfs_mutex) {
 			if (ei->is_freed)
@@ -688,6 +836,16 @@ static int eventfs_iterate(struct file *file, struct dir_context *ctx)
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
@@ -845,6 +1003,51 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
 	return ERR_PTR(-ENOMEM);
 }
 
+/**
+ * eventfs_create_events_ro_copy - create a read-only events directory
+ * @ei: The eventfs_inode to use to create a read-only copy from
+ *
+ * This function configures the eventfs filesystem root as a read-only
+ * trace event directory using the existing eventfs_inode lazy-lookup
+ * infrastructure.
+ */
+int eventfs_create_events_ro_copy(struct eventfs_inode *ei)
+{
+	static struct dentry *dentry;
+	struct tracefs_inode *ti;
+	struct inode *inode;
+	int ret;
+
+	/* Can only be called once. */
+	if (dentry)
+		return -EBUSY;
+
+	/* Reference acquired but never freed */
+	dentry = eventfs_ro_get_root();
+	if (IS_ERR(dentry)) {
+		ret = PTR_ERR(dentry);
+		dentry = NULL;
+		return ret;
+	}
+
+	inode = d_inode(dentry);
+
+	ti = get_tracefs(inode);
+
+	/* This gets called at boot up, so it's safe to do here */
+	ti->flags |= TRACEFS_EVENT_INODE | TRACEFS_RO_EVENT_INODE;
+
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
index 5020365ca704..8412a661a147 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -341,6 +341,14 @@ static int tracefs_apply_options(struct super_block *sb, bool remount)
 		srcu_idx = eventfs_remount_lock();
 		rcu_read_lock();
 		list_for_each_entry_rcu(ti, &tracefs_inodes, list) {
+
+			/*
+			 * Ignore read-only eventfs inodes as they are not
+			 * part of tracefs.
+			 */
+			if (ti->flags & TRACEFS_RO_EVENT_INODE)
+				continue;
+
 			if (update_uid) {
 				ti->flags &= ~TRACEFS_UID_PERM_SET;
 				ti->vfs_inode.i_uid = fsi->uid;
@@ -409,7 +417,7 @@ static int tracefs_drop_inode(struct inode *inode)
 	 * gets freed after an SRCU cycle, so the content will still
 	 * be safe if the iteration is going on now.
 	 */
-	ti->flags &= ~TRACEFS_EVENT_INODE;
+	ti->flags &= ~(TRACEFS_EVENT_INODE | TRACEFS_RO_EVENT_INODE);
 
 	return 1;
 }
@@ -423,6 +431,14 @@ static const struct super_operations tracefs_super_operations = {
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
@@ -455,7 +471,7 @@ static int tracefs_d_delete(const struct dentry *dentry)
 	return dentry->d_fsdata == NULL;
 }
 
-static const struct dentry_operations tracefs_dentry_operations = {
+const struct dentry_operations tracefs_dentry_operations = {
 	.d_revalidate = tracefs_d_revalidate,
 	.d_release = tracefs_d_release,
 	.d_delete = tracefs_d_delete,
@@ -801,8 +817,15 @@ static int __init tracefs_init(void)
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
index c61481d04c8e..5e87d6d45549 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -2,11 +2,16 @@
 #ifndef _TRACEFS_INTERNAL_H
 #define _TRACEFS_INTERNAL_H
 
+extern const struct dentry_operations tracefs_dentry_operations;
+extern const struct super_operations eventfs_ro_super_operations;
+extern struct file_system_type eventfs_ro_fs_type;
+
 enum {
 	TRACEFS_EVENT_INODE		= BIT(1),
 	TRACEFS_GID_PERM_SET		= BIT(2),
 	TRACEFS_UID_PERM_SET		= BIT(3),
 	TRACEFS_INSTANCE_INODE		= BIT(4),
+	TRACEFS_RO_EVENT_INODE		= BIT(5),
 };
 
 struct tracefs_inode {
@@ -73,6 +78,8 @@ struct dentry *tracefs_end_creating(struct dentry *dentry);
 struct dentry *tracefs_failed_creating(struct dentry *dentry);
 struct inode *tracefs_get_inode(struct super_block *sb);
 
+struct dentry *eventfs_ro_get_root(void);
+
 void eventfs_remount(struct tracefs_inode *ti, bool update_uid, bool update_gid);
 void eventfs_d_release(struct dentry *dentry);
 
diff --git a/include/linux/tracefs.h b/include/linux/tracefs.h
index bc354d340046..61b0ef3a5efd 100644
--- a/include/linux/tracefs.h
+++ b/include/linux/tracefs.h
@@ -68,6 +68,8 @@ typedef void (*eventfs_release)(const char *name, void *data);
  * struct eventfs_entry - dynamically created eventfs file call back handler
  * @name:	Then name of the dynamic file in an eventfs directory
  * @callback:	The callback to get the fops of the file when it is created
+ * @release:	The callback when the fops of the file is released
+ * @read_only:	Set if this file can be part of the read-only eventfs file system
  *
  * See evenfs_callback() typedef for how to set up @callback.
  */
@@ -75,6 +77,7 @@ struct eventfs_entry {
 	const char			*name;
 	eventfs_callback		callback;
 	eventfs_release			release;
+	bool				read_only;
 };
 
 struct eventfs_inode;
@@ -87,6 +90,8 @@ struct eventfs_inode *eventfs_create_dir(const char *name, struct eventfs_inode
 					 const struct eventfs_entry *entries,
 					 int size, void *data);
 
+int eventfs_create_events_ro_copy(struct eventfs_inode *ei);
+
 void eventfs_remove_events_dir(struct eventfs_inode *ei);
 void eventfs_remove_dir(struct eventfs_inode *ei);
 
diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
index 66a91c8b1cb9..521916f64dee 100644
--- a/include/uapi/linux/magic.h
+++ b/include/uapi/linux/magic.h
@@ -76,6 +76,7 @@
 #define STACK_END_MAGIC		0x57AC6E9D
 
 #define TRACEFS_MAGIC          0x74726163
+#define EVENTFS_SUPER_MAGIC    0x65766673
 
 #define V9FS_MAGIC		0x01021997
 
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 49d135bc2fbf..1d2bd2a9580f 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -3298,17 +3298,20 @@ event_create_dir(struct eventfs_inode *parent, struct trace_event_file *file)
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
 #ifdef CONFIG_BPF_EVENTS
 		{
 			.name		= "btf_ids",
 			.callback	= event_callback,
+			.read_only	= true,
 		},
 #endif
 #define NR_RO_EVENT_ENTRIES	(1 + IS_ENABLED(CONFIG_PERF_EVENTS) + \
@@ -4722,6 +4725,7 @@ static int events_callback(const char *name, umode_t *mode, void **data,
 static int
 create_event_toplevel_files(struct dentry *parent, struct trace_array *tr)
 {
+	static bool event_dir_ro_created;
 	struct eventfs_inode *e_events;
 	struct dentry *entry;
 	int nr_entries;
@@ -4729,10 +4733,12 @@ create_event_toplevel_files(struct dentry *parent, struct trace_array *tr)
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
@@ -4773,8 +4779,19 @@ create_event_toplevel_files(struct dentry *parent, struct trace_array *tr)
 		return -ENOMEM;
 	}
 
+	/* Lockdown causes e_events to be NULL*/
+	if (!e_events)
+		return -EPERM;
+
 	tr->event_dir = e_events;
 
+	if (!event_dir_ro_created && (tr->flags & TRACE_ARRAY_FL_GLOBAL)) {
+		int ret;
+
+		ret = eventfs_create_events_ro_copy(e_events);
+		if (!ret)
+			event_dir_ro_created = true;
+	}
 	return 0;
 }
 
-- 
2.53.0

