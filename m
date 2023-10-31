Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F2319BB1
	for <linux-trace-kernel@vger.kernel.org>; Tue, 31 Oct 2023 18:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B737C433C7;
	Tue, 31 Oct 2023 18:47:08 +0000 (UTC)
Date: Tue, 31 Oct 2023 14:47:03 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Ajay Kaher <akaher@vmware.com>
Subject: [PATCH] eventfs: Process deletion of dentry more thoroughly
Message-ID: <20231031144703.71eef3a0@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Looking at how dentry is removed via the tracefs system, I found that
eventfs does not do everything that it did under tracefs. The tracefs
removal of a dentry calls simple_recursive_removal() that does a lot more
than a simple d_invalidate().

Have the same done on eventfs dentry:

 1. Set S_DEAD for directories
 2. Call clear_nlink() on the dentry inode
 3. Call any notifiers about the dentry removal

Cc: stable@vger.kernel.org
Fixes: 5bdcd5f5331a2 ("eventfs: Implement removal of meta data from eventfs")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 4d2da7480e5f..ab807edaf538 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -856,6 +856,7 @@ static void unhook_dentry(struct dentry **dentry, struct dentry **list)
 		*dentry = NULL;
 	}
 }
+
 /**
  * eventfs_remove_dir - remove eventfs dir or file from list
  * @ei: eventfs_inode to be removed.
@@ -868,6 +869,7 @@ void eventfs_remove_dir(struct eventfs_inode *ei)
 	LIST_HEAD(ei_del_list);
 	struct dentry *dentry_list = NULL;
 	struct dentry *dentry;
+	struct inode *inode;
 	int i;
 
 	if (!ei)
@@ -891,7 +893,28 @@ void eventfs_remove_dir(struct eventfs_inode *ei)
 		ptr = (unsigned long)dentry->d_fsdata & ~1UL;
 		dentry_list = (struct dentry *)ptr;
 		dentry->d_fsdata = NULL;
+
+		inode = dentry->d_inode;
+		inode_lock(inode);
+		if (d_is_dir(dentry))
+			inode->i_flags |= S_DEAD;
+		clear_nlink(inode);
+		inode_unlock(inode);
+
+		inode = dentry->d_parent->d_inode;
+		inode_lock(inode);
+
+		/* Remove its visibility */
 		d_invalidate(dentry);
+		if (d_is_dir(dentry))
+			fsnotify_rmdir(inode, dentry);
+		else
+			fsnotify_unlink(inode, dentry);
+
+		if (d_is_dir(dentry))
+			drop_nlink(inode);
+		inode_unlock(inode);
+
 		mutex_lock(&eventfs_mutex);
 		/* dentry should now have at least a single reference */
 		WARN_ONCE((int)d_count(dentry) < 1,
-- 
2.42.0

