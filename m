Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793730923;
	b=dKOi21Jjht5bjG+1hlrfm2GIhc38r2HG8X5Ws3q9HgfJhCiDI+xfZtlHNoSeDmNI/oCa
	 0pdfglFbxCCVELuIyIHiMOa4SM+maojW92C34lXV+mszranUBzy8/wXJBHoQC6HFZaxXg
	 xaLEv5kh0OivQ/YigSH9fovNIaR0cT6ABa2/SYq1qyP63pGh+hOpr1xSCMe+eCrJfuY9Z
	 z6Xd4hDxCNBiYOXAnXIj+ak24Q5HYxHPPpMRNMwn/t5nltVBPKYFP4fMbhIAojIouZIkE
	 1SoeMWEwzbHI26Q4Dd2Off8NmRGED61CyDZ9DZ9KTSWJjvvPc5lliNL3qWx12B1loyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793730923;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Rspamd-Queue-Id:X-Stat-Signature:X-Spam-Status:X-Rspamd-Server:
	 X-Session-Marker:X-Session-ID:DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=yr796P6/Cg7vr59iOSqoWYrbEd9e+NctTWAMH9cGZQs=;
	b=Hn3cYMzR9q4bhjMenL6ncABdl+/A+rZ7/4JgkgCN4CvIfj+sjiz+0i96tnE7zOUC0bNQ
	 POTQhGTEwRhZkPwqzBH3WAYO2Fz60IqlbFRLxa/tQwCi9citR8jERR3OQ7PCjGlhctAV5
	 kwMgjKaLSwjKb6ik4ynjhNO9YgghD7UBJ8ofEzFyxgCaXKQkl+32gjlweLYW/mbBbZ2/D
	 PK1YWRhhwv0inHRRvSly9x7/UkgKP1R3EllPrG5MBtls0JxCK7OPnvptSppF4FJmJglR1
	 B5uH/AvEHkWZGU48qDnkQTEBV+YC1RW+E4ShG6fR651DgigjMpfuae+6n23mv7t4/xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	arc=none smtp.remote-ip=216.40.44.13
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F608606A324;
	Tue,  3 Nov 2026 18:35:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F608606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id AA18240509;
	Tue,  3 Nov 2026 18:35:20 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id 07E9A2F;
	Tue,  3 Nov 2026 18:35:18 +0000 (UTC)
Date: Tue, 3 Nov 2026 13:35:17 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH v5] tracefs: Add read-only eventfs filesystem at
 /sys/kernel/events
Message-ID: <20261103133517.6e54a8db@gandalf.local.home>
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
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 07E9A2F
X-Stat-Signature: 3h7ih7f6itp344r5qwixeozsnyy4ypum
X-Rspamd-Server: rspamout08
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/0Xkhwqvd4bPHPLn+Lt1Q7/b+27S4M+8g=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=yr796P6/Cg7vr59iOSqoWYrbEd9e+NctTWAMH9cGZQs=; b=FG9tk5BLko0pjS1NII/L38zBteS94+SaZabuzpsW+2oP6pjKCPMqEJRPVVlhwQU0Oy8ZrvKq0pY2aEXHKqL3hPHdEuNOjugxTlxZ7bYtiXLYUoMltlkxgSSe1SRrorKRU8Tv1/pycIbm0u62DBMWAh1sqtv6FVEaZOXPw6VpFWw=
X-HE-Tag: 1793730918-721010
X-HE-Meta: U2FsdGVkX18ni6VTshpmEfXkFUbA5rtRxIVPy3sHFrrXzPP29r7ctbO4XXYaQ4sA1mfEa0/ezy876OqAMFFSJmoQLrhVwa7FjL7GZE/6VUCsFyCXXk7PmDkWcRkjIERdYz/SvwVeL3DY+LYCfEB/aIfVhv7h6GW43IfZllwklu30lIdiPvkhWA5T56BEzYmL5BW8q0w4v+a5p+3gwvlI4PDXVf6GgFNY/yu5Ltw1fMBpOo/+tk9KUbioHg/bKUSMJi6PDGsymjB/UcF7PRAejfuEtOfzyxYmUykyXmbcIK/QJm/80oRYqC4rnD0JnL9Cp8oXbzhT/XD/n6Q0HtNJc9COg/iyGS0oM1XciStn3gNWnvTmfLLNEjov0krpY2nUQq53XT+yTlE27taRPO6ububm4CfHnle1GCLHdw7OP1s20ceeSvTNbPIIABIEePiITwtrqavmj41ynQooJ5ME+HNtgelO3X1WRq8dhboS420PNEpgl0G5fVuzXYhFlPJF

=46rom b6193345c877f0b5a4d326aee0a25b3cd54ae9b6 Mon Sep 17 00:00:00 2001
From: Anubhav Shelat <ashelat@redhat.com>
Date: Mon, 2 Nov 2026 15:27:48 -0500
Subject: [PATCH] tracefs: Add read-only eventfs filesystem at
 /sys/kernel/events

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
Changes since v4: https://patch.msgid.link/20261102152748.614ddc8f@gandalf.=
local.home

- Added eventfs_ro_reconfigure to prevent remounting to anything other
  than read-only. (sashiko)

- Updated kerneldocs to add missing arguments (sashiko)

- Fixed updating of mode variable (sashiko)

- Made updating tracefs not affect eventfs (sashiko)

- Remove unused name parameter from eventfs_create_events_ro_copy()
  (sashiko)

- Remove duplicate INIT_LIST_HEAD() (again) (sashiko)

- Set the dentry to NULL on error in copy function (sashiko)

- Handle the case of eventfs_create_events_dir() from returning NULL due
  to lockdown (sashiko)

 fs/tracefs/event_inode.c    | 235 ++++++++++++++++++++++++++++++++----
 fs/tracefs/inode.c          |  21 +++-
 fs/tracefs/internal.h       |   6 +
 include/linux/tracefs.h     |   5 +
 include/uapi/linux/magic.h  |   1 +
 kernel/trace/trace_events.c |  17 +++
 6 files changed, 261 insertions(+), 24 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 6457df72173d..f7edf9c58d11 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -16,14 +16,96 @@
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
=20
+static struct vfsmount *eventfs_ro_mount;
+static int eventfs_ro_mount_count;
+
+static int eventfs_ro_fill_super(struct super_block *sb, struct fs_context=
 *fc)
+{
+	struct inode *inode;
+	struct dentry *root;
+
+	sb->s_blocksize =3D PAGE_SIZE;
+	sb->s_blocksize_bits =3D PAGE_SHIFT;
+	sb->s_magic =3D EVENTFS_SUPER_MAGIC;
+	sb->s_op =3D &eventfs_ro_super_operations;
+	sb->s_time_gran =3D 1;
+	sb->s_flags |=3D SB_RDONLY;
+
+	inode =3D new_inode(sb);
+	if (!inode)
+		return -ENOMEM;
+
+	inode->i_ino =3D 1;
+	inode->i_mode =3D S_IFDIR | 0555;
+	simple_inode_init_ts(inode);
+	inode->i_op =3D &simple_dir_inode_operations;
+	inode->i_fop =3D &simple_dir_operations;
+	set_nlink(inode, 2);
+
+	set_default_d_op(sb, &tracefs_dentry_operations);
+
+	root =3D d_make_root(inode);
+	if (!root)
+		return -ENOMEM;
+
+	sb->s_root =3D root;
+
+	return 0;
+}
+
+/* The eventfs_ro is always read-only */
+static int eventfs_ro_reconfigure(struct fs_context *fc)
+{
+	sync_filesystem(fc->root->d_sb);
+	fc->sb_flags |=3D SB_RDONLY;
+	return 0;
+}
+
+static int eventfs_ro_get_tree(struct fs_context *fc)
+{
+	return get_tree_single(fc, eventfs_ro_fill_super);
+}
+
+static const struct fs_context_operations eventfs_ro_context_ops =3D {
+	.get_tree	=3D eventfs_ro_get_tree,
+	.reconfigure	=3D eventfs_ro_reconfigure,
+};
+
+static int eventfs_ro_init_fs_context(struct fs_context *fc)
+{
+	fc->ops =3D &eventfs_ro_context_ops;
+	return 0;
+}
+
+struct file_system_type eventfs_ro_fs_type =3D {
+	.owner =3D	THIS_MODULE,
+	.name =3D		"eventfs",
+	.init_fs_context =3D eventfs_ro_init_fs_context,
+	.kill_sb =3D	kill_anon_super,
+};
+
+struct dentry *eventfs_ro_get_root(void)
+{
+	int error;
+
+	error =3D simple_pin_fs(&eventfs_ro_fs_type, &eventfs_ro_mount,
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
@@ -169,7 +251,11 @@ static inline struct eventfs_inode *get_ei(struct even=
tfs_inode *ei)
 static struct dentry *eventfs_root_lookup(struct inode *dir,
 					  struct dentry *dentry,
 					  unsigned int flags);
+static struct dentry *eventfs_root_lookup_ro(struct inode *dir,
+					     struct dentry *dentry,
+					     unsigned int flags);
 static int eventfs_iterate(struct file *file, struct dir_context *ctx);
+static int eventfs_ro_iterate(struct file *file, struct dir_context *ctx);
=20
 static void update_attr(struct eventfs_attr *attr, struct iattr *iattr)
 {
@@ -247,6 +333,10 @@ static const struct inode_operations eventfs_dir_inode=
_operations =3D {
 	.setattr	=3D eventfs_set_attr,
 };
=20
+static const struct inode_operations eventfs_ro_dir_inode_operations =3D {
+	.lookup		=3D eventfs_root_lookup_ro,
+};
+
 static const struct inode_operations eventfs_file_inode_operations =3D {
 	.setattr	=3D eventfs_set_attr,
 };
@@ -257,6 +347,12 @@ static const struct file_operations eventfs_file_opera=
tions =3D {
 	.llseek		=3D generic_file_llseek,
 };
=20
+static const struct file_operations eventfs_ro_file_operations =3D {
+	.read		=3D generic_read_dir,
+	.iterate_shared	=3D eventfs_ro_iterate,
+	.llseek		=3D generic_file_llseek,
+};
+
 static void eventfs_set_attrs(struct eventfs_inode *ei, bool update_uid, k=
uid_t uid,
 			      bool update_gid, kgid_t gid, int level)
 {
@@ -316,12 +412,17 @@ void eventfs_remount(struct tracefs_inode *ti, bool u=
pdate_uid, bool update_gid)
 }
=20
 static void update_inode_attr(struct inode *inode, umode_t mode,
-			      struct eventfs_attr *attr, struct eventfs_root_inode *rei)
+			      struct eventfs_attr *attr, struct eventfs_root_inode *rei,
+			      bool ro)
 {
+	inode->i_mode =3D mode;
+
+	/* The read-only version does not allow updates to owership or permission=
s */
+	if (ro)
+		return;
+
 	if (attr && attr->mode & EVENTFS_SAVE_MODE)
 		inode->i_mode =3D attr->mode & EVENTFS_MODE_MASK;
-	else
-		inode->i_mode =3D mode;
=20
 	if (attr && attr->mode & EVENTFS_SAVE_UID)
 		inode->i_uid =3D attr->uid;
@@ -335,7 +436,7 @@ static void update_inode_attr(struct inode *inode, umod=
e_t mode,
 }
=20
 static struct inode *eventfs_get_inode(struct dentry *dentry, struct event=
fs_attr *attr,
-				       umode_t mode,  struct eventfs_inode *ei)
+				       umode_t mode,  struct eventfs_inode *ei, bool ro)
 {
 	struct eventfs_root_inode *rei;
 	struct eventfs_inode *pei;
@@ -359,7 +460,7 @@ static struct inode *eventfs_get_inode(struct dentry *d=
entry, struct eventfs_att
=20
 	rei =3D get_root_inode(pei);
=20
-	update_inode_attr(inode, mode, attr, rei);
+	update_inode_attr(inode, mode, attr, rei, ro);
=20
 	return inode;
 }
@@ -372,6 +473,7 @@ static struct inode *eventfs_get_inode(struct dentry *d=
entry, struct eventfs_att
  * @attr: saved attributes changed by user
  * @data: something that the caller will want to get to later on.
  * @fop: struct file_operations that should be used for this file.
+ * @ro: Denote if this lookup is for the read-only version.
  *
  * This function creates a dentry that represents a file in the eventsfs_i=
node
  * directory. The inode.i_private pointer will point to @data in the open()
@@ -382,7 +484,8 @@ static struct dentry *lookup_file(struct eventfs_inode =
*parent_ei,
 				  umode_t mode,
 				  struct eventfs_attr *attr,
 				  void *data,
-				  const struct file_operations *fop)
+				  const struct file_operations *fop,
+				  bool ro)
 {
 	struct inode *inode;
=20
@@ -393,11 +496,13 @@ static struct dentry *lookup_file(struct eventfs_inod=
e *parent_ei,
 		return ERR_PTR(-EIO);
=20
 	/* Only directories have ti->private set to an ei, not files */
-	inode =3D eventfs_get_inode(dentry, attr, mode, NULL);
+	inode =3D eventfs_get_inode(dentry, attr, mode, NULL, ro);
 	if (unlikely(!inode))
 		return ERR_PTR(-ENOMEM);
=20
-	inode->i_op =3D &eventfs_file_inode_operations;
+	/* Read only does not allow setting of attributes */
+	if (!ro)
+		inode->i_op =3D &eventfs_file_inode_operations;
 	inode->i_fop =3D fop;
 	inode->i_private =3D data;
=20
@@ -415,22 +520,28 @@ static struct dentry *lookup_file(struct eventfs_inod=
e *parent_ei,
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
 	umode_t mode =3D S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
=20
-	inode =3D eventfs_get_inode(dentry, &ei->attr, mode, ei);
+	inode =3D eventfs_get_inode(dentry, &ei->attr, mode, ei, ro);
 	if (unlikely(!inode))
 		return ERR_PTR(-ENOMEM);
=20
-	inode->i_op =3D &eventfs_dir_inode_operations;
-	inode->i_fop =3D &eventfs_file_operations;
+	if (ro) {
+		inode->i_op =3D &eventfs_ro_dir_inode_operations;
+		inode->i_fop =3D &eventfs_ro_file_operations;
+	} else {
+		inode->i_op =3D &eventfs_dir_inode_operations;
+		inode->i_fop =3D &eventfs_file_operations;
+	}
=20
 	/* All directories will have the same inode number */
 	inode->i_ino =3D eventfs_dir_ino(ei);
@@ -501,6 +612,7 @@ void eventfs_d_release(struct dentry *dentry)
  * @mode: The mode of the file.
  * @data: The data to use to set the inode of the file with on open()
  * @fops: The fops of the file to be created.
+ * @ro: Denote if this lookup is for the read-only version
  *
  * This function creates a dentry for a file associated with an
  * eventfs_inode @ei. It uses the entry attributes specified by @idx,
@@ -514,14 +626,21 @@ static struct dentry *
 lookup_file_dentry(struct dentry *dentry,
 		   struct eventfs_inode *ei, int idx,
 		   umode_t mode, void *data,
-		   const struct file_operations *fops)
+		   const struct file_operations *fops, bool ro)
 {
 	struct eventfs_attr *attr =3D NULL;
=20
-	if (ei->entry_attrs)
+	/*
+	 * Read-only files gives all users read access,
+	 * but also should make sure this is not writable.
+	 * Read-only also does not allow modified attributes.
+	 */
+	if (ro)
+		mode =3D (mode & ~0222) | 0444;
+	else if (ei->entry_attrs)
 		attr =3D &ei->entry_attrs[idx];
=20
-	return lookup_file(ei, dentry, mode, attr, data, fops);
+	return lookup_file(ei, dentry, mode, attr, data, fops, ro);
 }
=20
 /**
@@ -529,14 +648,16 @@ lookup_file_dentry(struct dentry *dentry,
  * @dir: in which a lookup is being done
  * @dentry: file/dir dentry
  * @flags: Just passed to simple_lookup()
+ * @ro: Denote if this is from a read-only eventfs
  *
  * Used to create dynamic file/dir with-in @dir, search with-in @ei
  * list, if @dentry found go ahead and create the file/dir
  */
=20
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
@@ -559,7 +680,7 @@ static struct dentry *eventfs_root_lookup(struct inode =
*dir,
 		/* A child is freed and removed from the list at the same time */
 		if (WARN_ON_ONCE(ei_child->is_freed))
 			return NULL;
-		return lookup_dir_entry(dentry, ei, ei_child);
+		return lookup_dir_entry(dentry, ei, ei_child, ro);
 	}
=20
 	for (int i =3D 0; i < ei->nr_entries; i++) {
@@ -571,20 +692,37 @@ static struct dentry *eventfs_root_lookup(struct inod=
e *dir,
 		if (strcmp(name, entry->name) !=3D 0)
 			continue;
=20
+		if (ro && !entry->read_only)
+			return NULL;
+
 		data =3D ei->data;
 		if (entry->callback(name, &mode, &data, &fops) <=3D 0)
 			return NULL;
=20
-		return lookup_file_dentry(dentry, ei, i, mode, data, fops);
+		return lookup_file_dentry(dentry, ei, i, mode, data, fops, ro);
=20
 	}
 	return NULL;
 }
=20
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
+static int __eventfs_iterate(struct file *file, struct dir_context *ctx, b=
ool ro)
 {
 	const struct file_operations *fops;
 	struct inode *f_inode =3D file_inode(file);
@@ -630,6 +768,9 @@ static int eventfs_iterate(struct file *file, struct di=
r_context *ctx)
 		entry =3D &ei->entries[i];
 		name =3D entry->name;
=20
+		if (ro && !entry->read_only)
+			continue;
+
 		/* If ei->is_freed then just bail here, nothing more to do */
 		scoped_guard(mutex, &eventfs_mutex) {
 			if (ei->is_freed)
@@ -688,6 +829,16 @@ static int eventfs_iterate(struct file *file, struct d=
ir_context *ctx)
 	return 1;
 }
=20
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
@@ -845,6 +996,48 @@ struct eventfs_inode *eventfs_create_events_dir(const =
char *name, struct dentry
 	return ERR_PTR(-ENOMEM);
 }
=20
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
+	dentry =3D eventfs_ro_get_root();
+	if (IS_ERR(dentry)) {
+		ret =3D PTR_ERR(dentry);
+		dentry =3D NULL;
+		return ret;
+	}
+
+	inode =3D d_inode(dentry);
+
+	ti =3D get_tracefs(inode);
+	ti->flags |=3D TRACEFS_EVENT_INODE;
+	ti->private =3D ei;
+
+	inode->i_op =3D &eventfs_ro_dir_inode_operations;
+	inode->i_fop =3D &eventfs_ro_file_operations;
+
+	/* This is never freed */
+	dentry->d_fsdata =3D get_ei(ei);
+
+	return 0;
+}
+
 /**
  * eventfs_remove_rec - remove eventfs dir or file from list
  * @ei: eventfs_inode to be removed.
diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 5020365ca704..555af5402adc 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -423,6 +423,14 @@ static const struct super_operations tracefs_super_ope=
rations =3D {
 	.show_options	=3D tracefs_show_options,
 };
=20
+const struct super_operations eventfs_ro_super_operations =3D {
+	.alloc_inode    =3D tracefs_alloc_inode,
+	.free_inode     =3D tracefs_free_inode,
+	.destroy_inode  =3D tracefs_destroy_inode,
+	.drop_inode     =3D tracefs_drop_inode,
+	.statfs		=3D simple_statfs,
+};
+
 /*
  * It would be cleaner if eventfs had its own dentry ops.
  *
@@ -455,7 +463,7 @@ static int tracefs_d_delete(const struct dentry *dentry)
 	return dentry->d_fsdata =3D=3D NULL;
 }
=20
-static const struct dentry_operations tracefs_dentry_operations =3D {
+const struct dentry_operations tracefs_dentry_operations =3D {
 	.d_revalidate =3D tracefs_d_revalidate,
 	.d_release =3D tracefs_d_release,
 	.d_delete =3D tracefs_d_delete,
@@ -801,8 +809,15 @@ static int __init tracefs_init(void)
 		return -EINVAL;
=20
 	retval =3D register_filesystem(&trace_fs_type);
-	if (!retval)
-		tracefs_registered =3D true;
+	if (retval)
+		return retval;
+	tracefs_registered =3D true;
+
+	retval =3D sysfs_create_mount_point(kernel_kobj, "events");
+	if (retval)
+		return retval;
+
+	retval =3D register_filesystem(&eventfs_ro_fs_type);
=20
 	return retval;
 }
diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
index c61481d04c8e..c92376bc3121 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -2,6 +2,10 @@
 #ifndef _TRACEFS_INTERNAL_H
 #define _TRACEFS_INTERNAL_H
=20
+extern const struct dentry_operations tracefs_dentry_operations;
+extern const struct super_operations eventfs_ro_super_operations;
+extern struct file_system_type eventfs_ro_fs_type;
+
 enum {
 	TRACEFS_EVENT_INODE		=3D BIT(1),
 	TRACEFS_GID_PERM_SET		=3D BIT(2),
@@ -73,6 +77,8 @@ struct dentry *tracefs_end_creating(struct dentry *dentry=
);
 struct dentry *tracefs_failed_creating(struct dentry *dentry);
 struct inode *tracefs_get_inode(struct super_block *sb);
=20
+struct dentry *eventfs_ro_get_root(void);
+
 void eventfs_remount(struct tracefs_inode *ti, bool update_uid, bool updat=
e_gid);
 void eventfs_d_release(struct dentry *dentry);
=20
diff --git a/include/linux/tracefs.h b/include/linux/tracefs.h
index bc354d340046..61b0ef3a5efd 100644
--- a/include/linux/tracefs.h
+++ b/include/linux/tracefs.h
@@ -68,6 +68,8 @@ typedef void (*eventfs_release)(const char *name, void *d=
ata);
  * struct eventfs_entry - dynamically created eventfs file call back handl=
er
  * @name:	Then name of the dynamic file in an eventfs directory
  * @callback:	The callback to get the fops of the file when it is created
+ * @release:	The callback when the fops of the file is released
+ * @read_only:	Set if this file can be part of the read-only eventfs file =
system
  *
  * See evenfs_callback() typedef for how to set up @callback.
  */
@@ -75,6 +77,7 @@ struct eventfs_entry {
 	const char			*name;
 	eventfs_callback		callback;
 	eventfs_release			release;
+	bool				read_only;
 };
=20
 struct eventfs_inode;
@@ -87,6 +90,8 @@ struct eventfs_inode *eventfs_create_dir(const char *name=
, struct eventfs_inode
 					 const struct eventfs_entry *entries,
 					 int size, void *data);
=20
+int eventfs_create_events_ro_copy(struct eventfs_inode *ei);
+
 void eventfs_remove_events_dir(struct eventfs_inode *ei);
 void eventfs_remove_dir(struct eventfs_inode *ei);
=20
diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
index 66a91c8b1cb9..521916f64dee 100644
--- a/include/uapi/linux/magic.h
+++ b/include/uapi/linux/magic.h
@@ -76,6 +76,7 @@
 #define STACK_END_MAGIC		0x57AC6E9D
=20
 #define TRACEFS_MAGIC          0x74726163
+#define EVENTFS_SUPER_MAGIC    0x65766673
=20
 #define V9FS_MAGIC		0x01021997
=20
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 49d135bc2fbf..1d2bd2a9580f 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -3298,17 +3298,20 @@ event_create_dir(struct eventfs_inode *parent, stru=
ct trace_event_file *file)
 		{
 			.name		=3D "format",
 			.callback	=3D event_callback,
+			.read_only	=3D true,
 		},
 #ifdef CONFIG_PERF_EVENTS
 		{
 			.name		=3D "id",
 			.callback	=3D event_callback,
+			.read_only	=3D true,
 		},
 #endif
 #ifdef CONFIG_BPF_EVENTS
 		{
 			.name		=3D "btf_ids",
 			.callback	=3D event_callback,
+			.read_only	=3D true,
 		},
 #endif
 #define NR_RO_EVENT_ENTRIES	(1 + IS_ENABLED(CONFIG_PERF_EVENTS) + \
@@ -4722,6 +4725,7 @@ static int events_callback(const char *name, umode_t =
*mode, void **data,
 static int
 create_event_toplevel_files(struct dentry *parent, struct trace_array *tr)
 {
+	static bool event_dir_ro_created;
 	struct eventfs_inode *e_events;
 	struct dentry *entry;
 	int nr_entries;
@@ -4729,10 +4733,12 @@ create_event_toplevel_files(struct dentry *parent, =
struct trace_array *tr)
 		{
 			.name		=3D "header_page",
 			.callback	=3D events_callback,
+			.read_only	=3D true,
 		},
 		{
 			.name		=3D "header_event",
 			.callback	=3D events_callback,
+			.read_only	=3D true,
 		},
 #define NR_RO_TOP_ENTRIES	2
 /* Readonly files must be above this line and counted by NR_RO_TOP_ENTRIES=
. */
@@ -4773,8 +4779,19 @@ create_event_toplevel_files(struct dentry *parent, s=
truct trace_array *tr)
 		return -ENOMEM;
 	}
=20
+	/* Lockdown causes e_events to be NULL*/
+	if (!e_events)
+		return -EPERM;
+
 	tr->event_dir =3D e_events;
=20
+	if (!event_dir_ro_created && (tr->flags & TRACE_ARRAY_FL_GLOBAL)) {
+		int ret;
+
+		ret =3D eventfs_create_events_ro_copy(e_events);
+		if (!ret)
+			event_dir_ro_created =3D true;
+	}
 	return 0;
 }
=20
--=20
2.53.0

