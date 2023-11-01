Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8475B179B5
	for <linux-trace-kernel@vger.kernel.org>; Wed,  1 Nov 2023 17:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71028C433AB;
	Wed,  1 Nov 2023 17:26:51 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
	(envelope-from <rostedt@goodmis.org>)
	id 1qyEzS-00EZvQ-1i;
	Wed, 01 Nov 2023 13:26:50 -0400
Message-ID: <20231101172650.340876747@goodmis.org>
User-Agent: quilt/0.66
Date: Wed, 01 Nov 2023 13:25:48 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Ajay Kaher <akaher@vmware.com>
Subject: [PATCH v6 7/8] eventfs: Remove special processing of dput() of events directory
References: <20231101172541.971928390@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The top level events directory is no longer special with regards to how it
should be delete. Remove the extra processing for it in
eventfs_set_ei_status_free().

Cc: Ajay Kaher <akaher@vmware.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v5: https://lkml.kernel.org/r/20231031223421.185413077@goodmis.org

- Resynced to this patch series

 fs/tracefs/event_inode.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 0a04ae0ca8c8..0087a3f455f1 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -274,28 +274,11 @@ static void free_ei(struct eventfs_inode *ei)
  */
 void eventfs_set_ei_status_free(struct tracefs_inode *ti, struct dentry *dentry)
 {
-	struct tracefs_inode *ti_parent;
 	struct eventfs_inode *ei;
 	int i;
 
-	/* The top level events directory may be freed by this */
-	if (unlikely(ti->flags & TRACEFS_EVENT_TOP_INODE)) {
-		mutex_lock(&eventfs_mutex);
-		ei = ti->private;
-		/* Nothing should access this, but just in case! */
-		ti->private = NULL;
-		mutex_unlock(&eventfs_mutex);
-
-		free_ei(ei);
-		return;
-	}
-
 	mutex_lock(&eventfs_mutex);
 
-	ti_parent = get_tracefs(dentry->d_parent->d_inode);
-	if (!ti_parent || !(ti_parent->flags & TRACEFS_EVENT_INODE))
-		goto out;
-
 	ei = dentry->d_fsdata;
 	if (!ei)
 		goto out;
@@ -920,6 +903,8 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
 	inode->i_op = &eventfs_root_dir_inode_operations;
 	inode->i_fop = &eventfs_file_operations;
 
+	dentry->d_fsdata = ei;
+
 	/* directory inodes start off with i_nlink == 2 (for "." entry) */
 	inc_nlink(inode);
 	d_instantiate(dentry, inode);
-- 
2.42.0
