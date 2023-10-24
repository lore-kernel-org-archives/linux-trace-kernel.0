Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB103A28E
	for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Oct 2023 16:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BE2AC433C9;
	Tue, 24 Oct 2023 16:36:30 +0000 (UTC)
Date: Tue, 24 Oct 2023 12:36:28 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>
Subject: [PATCH] eventfs: Fix WARN_ON() in create_file_dentry()
Message-ID: <20231024123628.62b88755@gandalf.local.home>
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

As the comment right above a WARN_ON() in create_file_dentry() states:

  * Note, with the mutex held, the e_dentry cannot have content
  * and the ei->is_freed be true at the same time.

But the WARN_ON() only has:

  WARN_ON_ONCE(ei->is_free);

Where to match the comment (and what it should actually do) is:

  dentry = *e_dentry;
  WARN_ON_ONCE(dentry && ei->is_free)

Also in that case, set dentry to NULL (although it should never happen).

Fixes: 5790b1fb3d672 ("eventfs: Remove eventfs_file and just use eventfs_inode")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 09ab93357957..4d2da7480e5f 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -264,8 +264,9 @@ create_file_dentry(struct eventfs_inode *ei, struct dentry **e_dentry,
 		 * Note, with the mutex held, the e_dentry cannot have content
 		 * and the ei->is_freed be true at the same time.
 		 */
-		WARN_ON_ONCE(ei->is_freed);
 		dentry = *e_dentry;
+		if (WARN_ON_ONCE(dentry && ei->is_freed))
+			dentry = NULL;
 		/* The lookup does not need to up the dentry refcount */
 		if (dentry && !lookup)
 			dget(dentry);
-- 
2.42.0

