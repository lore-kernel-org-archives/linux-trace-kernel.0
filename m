Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4AB1D522
	for <linux-trace-kernel@vger.kernel.org>; Tue, 31 Oct 2023 16:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3F57C433C7;
	Tue, 31 Oct 2023 16:42:30 +0000 (UTC)
Date: Tue, 31 Oct 2023 12:42:29 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>
Subject: [PATCH] eventfs: Remove extra dget() in eventfs_create_events_dir()
Message-ID: <20231031124229.4f2e3fa1@gandalf.local.home>
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

The creation of the top events directory does a dget() at the end of the
creation in eventfs_create_events_dir() with a comment saying the final
dput() will happen when it is removed. The problem is that a dget() is
already done on the dentry when it was created with tracefs_start_creating()!
The dget() now just causes a memory leak of that dentry.

Remove the extra dget() as the final dput() in the deletion of the events
directory actually matches the one in tracefs_start_creating().

Fixes: 5790b1fb3d672 ("eventfs: Remove eventfs_file and just use eventfs_inode")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index ae2172814bdc..d051b889147d 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -952,9 +952,6 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
 	fsnotify_mkdir(dentry->d_parent->d_inode, dentry);
 	tracefs_end_creating(dentry);
 
-	/* Will call dput when the directory is removed */
-	dget(dentry);
-
 	return ei;
 
  fail:
-- 
2.42.0

