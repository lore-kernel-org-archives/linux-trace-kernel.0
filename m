Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B273B2BF
	for <linux-trace-kernel@vger.kernel.org>; Mon, 20 Nov 2023 23:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BB41C433CA;
	Mon, 20 Nov 2023 23:51:39 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97-RC3)
	(envelope-from <rostedt@goodmis.org>)
	id 1r5E3W-00000002PnN-1h4t;
	Mon, 20 Nov 2023 18:51:54 -0500
Message-ID: <20231120235154.265826243@goodmis.org>
User-Agent: quilt/0.67
Date: Mon, 20 Nov 2023 18:51:06 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 1/2] eventfs: Remove expectation that ei->is_freed means ei->dentry ==
 NULL
References: <20231120235105.834774147@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The logic to free the eventfs_inode (ei) use to set is_freed and clear the
"dentry" field under the eventfs_mutex. But that changed when a race was
found where the ei->dentry needed to be cleared when the last dput() was
called on it. But there was still logic that checked if ei->dentry was not
NULL and is_freed is set, and would warn if it was.

But since that situation was changed and the ei->dentry isn't cleared
until the last dput() is called on it while the ei->is_freed is set, do
not test for that condition anymore, and change the comments to reflect
that.

Fixes: 020010fbfa20 ("eventfs: Delete eventfs_inode when the last dentry is freed")
Reported-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index f8a594a50ae6..f239b2b507a4 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -27,16 +27,16 @@
 /*
  * eventfs_mutex protects the eventfs_inode (ei) dentry. Any access
  * to the ei->dentry must be done under this mutex and after checking
- * if ei->is_freed is not set. The ei->dentry is released under the
- * mutex at the same time ei->is_freed is set. If ei->is_freed is set
- * then the ei->dentry is invalid.
+ * if ei->is_freed is not set. When ei->is_freed is set, the dentry
+ * is on its way to being freed after the last dput() is made on it.
  */
 static DEFINE_MUTEX(eventfs_mutex);
 
 /*
  * The eventfs_inode (ei) itself is protected by SRCU. It is released from
  * its parent's list and will have is_freed set (under eventfs_mutex).
- * After the SRCU grace period is over, the ei may be freed.
+ * After the SRCU grace period is over and the last dput() is called
+ * the ei is freed.
  */
 DEFINE_STATIC_SRCU(eventfs_srcu);
 
@@ -365,12 +365,14 @@ create_file_dentry(struct eventfs_inode *ei, int idx,
 		 * created the dentry for this e_dentry. In which case
 		 * use that one.
 		 *
-		 * Note, with the mutex held, the e_dentry cannot have content
-		 * and the ei->is_freed be true at the same time.
+		 * If ei->is_freed is set, the e_dentry is currently on its
+		 * way to being freed, don't return it. If e_dentry is NULL
+		 * it means it was already freed.
 		 */
-		dentry = *e_dentry;
-		if (WARN_ON_ONCE(dentry && ei->is_freed))
+		if (ei->is_freed)
 			dentry = NULL;
+		else
+			dentry = *e_dentry;
 		/* The lookup does not need to up the dentry refcount */
 		if (dentry && !lookup)
 			dget(dentry);
@@ -473,8 +475,8 @@ create_dir_dentry(struct eventfs_inode *pei, struct eventfs_inode *ei,
 		 * created the dentry for this e_dentry. In which case
 		 * use that one.
 		 *
-		 * Note, with the mutex held, the e_dentry cannot have content
-		 * and the ei->is_freed be true at the same time.
+		 * If ei->is_freed is set, the e_dentry is currently on its
+		 * way to being freed.
 		 */
 		dentry = ei->dentry;
 		if (dentry && !lookup)
-- 
2.42.0


