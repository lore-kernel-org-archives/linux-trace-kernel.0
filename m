Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAF6361
	for <linux-trace-kernel@vger.kernel.org>; Fri, 20 Oct 2023 00:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEFF9C433C7;
	Fri, 20 Oct 2023 00:41:34 +0000 (UTC)
Date: Thu, 19 Oct 2023 20:41:32 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Julia Lawall <julia.lawall@inria.fr>
Subject: [PATCH] eventfs: Fix failure path in eventfs_create_events_dir()
Message-ID: <20231019204132.6662fef0@gandalf.local.home>
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

The failure path of allocating ei goes to a path that dereferences ei.
Add another label that skips over the ei dereferences to do the rest of
the clean up.

Link: https://lore.kernel.org/all/70e7bace-561c-95f-1117-706c2c220bc@inria.fr/

Fixes: 5790b1fb3d67 ("eventfs: Remove eventfs_file and just use eventfs_inode")
Reported-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 9f19b6608954..1885f1f1f339 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -735,7 +735,7 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
 
 	ei = kzalloc(sizeof(*ei), GFP_KERNEL);
 	if (!ei)
-		goto fail;
+		goto fail_ei;
 
 	inode = tracefs_get_inode(dentry->d_sb);
 	if (unlikely(!inode))
@@ -781,6 +781,7 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
  fail:
 	kfree(ei->d_children);
 	kfree(ei);
+ fail_ei:
 	tracefs_failed_creating(dentry);
 	return ERR_PTR(-ENOMEM);
 }
-- 
2.42.0

