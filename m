Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102929474
	for <linux-trace-kernel@vger.kernel.org>; Sat, 30 Sep 2023 13:01:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6AA5C433C7;
	Sat, 30 Sep 2023 13:01:32 +0000 (UTC)
Date: Sat, 30 Sep 2023 09:01:06 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux trace kernel <linux-trace-kernel@vger.kernel.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH] eventfs: Test for dentries array allocated in
 eventfs_release()
Message-ID: <20230930090106.1c3164e9@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The dcache_dir_open_wrapper() could be called when a dynamic event is
being deleted leaving a dentry with no children. In this case the
dlist->dentries array will never be allocated. This needs to be checked
for in eventfs_release(), otherwise it will trigger a NULL pointer
dereference.

Fixes: ef36b4f92868 ("eventfs: Remember what dentries were created on dir open")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 5f1714089884..8c8d64e76103 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -421,7 +421,7 @@ static int eventfs_release(struct inode *inode, struct file *file)
 	if (WARN_ON_ONCE(!dlist))
 		return -EINVAL;
 
-	for (i = 0; dlist->dentries[i]; i++) {
+	for (i = 0; dlist->dentries && dlist->dentries[i]; i++) {
 		dput(dlist->dentries[i]);
 	}
 
-- 
2.40.1

