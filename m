Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A5218E00
	for <linux-trace-kernel@vger.kernel.org>; Mon, 30 Oct 2023 16:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7391CC433C7;
	Mon, 30 Oct 2023 16:15:25 +0000 (UTC)
Date: Mon, 30 Oct 2023 12:15:23 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>
Subject: [PATCH] eventfs: Fix kerneldoc of eventfs_remove_rec()
Message-ID: <20231030121523.0b2225a7@gandalf.local.home>
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

The eventfs_remove_rec() had some missing parameters in the kerneldoc
comment above it. Also, rephrase the description a bit more to have a bit
more correct grammar.

Fixes: 5790b1fb3d672 ("eventfs: Remove eventfs_file and just use eventfs_inode");
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202310052216.4SgqasWo-lkp@intel.com/
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 5a3cc5394294..1c28e013201f 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -977,9 +977,11 @@ static void free_rcu_ei(struct rcu_head *head)
 /**
  * eventfs_remove_rec - remove eventfs dir or file from list
  * @ei: eventfs_inode to be removed.
+ * @head: the list head to place the deleted @ei and children
+ * @level: prevent recursion from going more than 3 levels deep.
  *
- * This function recursively remove eventfs_inode which
- * contains info of file or dir.
+ * This function recursively removes eventfs_inodes which
+ * contains info of files and/or directories.
  */
 static void eventfs_remove_rec(struct eventfs_inode *ei, struct list_head *head, int level)
 {
-- 
2.42.0

