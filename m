Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C9131581
	for <linux-trace-kernel@vger.kernel.org>; Mon, 20 Nov 2023 23:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25666C433C8;
	Mon, 20 Nov 2023 23:51:39 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97-RC3)
	(envelope-from <rostedt@goodmis.org>)
	id 1r5E3W-00000002Po8-2Nff;
	Mon, 20 Nov 2023 18:51:54 -0500
Message-ID: <20231120235154.422970988@goodmis.org>
User-Agent: quilt/0.67
Date: Mon, 20 Nov 2023 18:51:07 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Naresh Kamboju <naresh.kamboju@linaro.org>,
 Linux Kernel Functional Testing <lkft@linaro.org>
Subject: [PATCH 2/2] eventfs: Do not invalidate dentry in create_file/dir_dentry()
References: <20231120235105.834774147@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

With the call to simple_recursive_removal() on the entire eventfs sub
system when the directory is removed, it performs the d_invalidate on all
the dentries when it is removed. There's no need to do clean ups when a
dentry is being created while the directory is being deleted.

As dentries are cleaned up by the simpler_recursive_removal(), trying to
do d_invalidate() in these functions will cause the dentry to be
invalidated twice, and crash the kernel.

Link: https://lore.kernel.org/all/20231116123016.140576-1-naresh.kamboju@linaro.org/

Fixes: 407c6726ca71 ("eventfs: Use simple_recursive_removal() to clean up dentries")
Reported-by: Mark Rutland <mark.rutland@arm.com>
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index f239b2b507a4..3eb6c622a74d 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -326,7 +326,6 @@ create_file_dentry(struct eventfs_inode *ei, int idx,
 	struct eventfs_attr *attr = NULL;
 	struct dentry **e_dentry = &ei->d_children[idx];
 	struct dentry *dentry;
-	bool invalidate = false;
 
 	mutex_lock(&eventfs_mutex);
 	if (ei->is_freed) {
@@ -389,17 +388,14 @@ create_file_dentry(struct eventfs_inode *ei, int idx,
 		 * Otherwise it means two dentries exist with the same name.
 		 */
 		WARN_ON_ONCE(!ei->is_freed);
-		invalidate = true;
+		dentry = NULL;
 	}
 	mutex_unlock(&eventfs_mutex);
 
-	if (invalidate)
-		d_invalidate(dentry);
-
-	if (lookup || invalidate)
+	if (lookup)
 		dput(dentry);
 
-	return invalidate ? NULL : dentry;
+	return dentry;
 }
 
 /**
@@ -439,7 +435,6 @@ static struct dentry *
 create_dir_dentry(struct eventfs_inode *pei, struct eventfs_inode *ei,
 		  struct dentry *parent, bool lookup)
 {
-	bool invalidate = false;
 	struct dentry *dentry = NULL;
 
 	mutex_lock(&eventfs_mutex);
@@ -495,16 +490,14 @@ create_dir_dentry(struct eventfs_inode *pei, struct eventfs_inode *ei,
 		 * Otherwise it means two dentries exist with the same name.
 		 */
 		WARN_ON_ONCE(!ei->is_freed);
-		invalidate = true;
+		dentry = NULL;
 	}
 	mutex_unlock(&eventfs_mutex);
-	if (invalidate)
-		d_invalidate(dentry);
 
-	if (lookup || invalidate)
+	if (lookup)
 		dput(dentry);
 
-	return invalidate ? NULL : dentry;
+	return dentry;
 }
 
 /**
-- 
2.42.0


