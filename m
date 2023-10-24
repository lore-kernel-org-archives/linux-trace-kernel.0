Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1BD24212
	for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Oct 2023 17:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5435C433C8;
	Tue, 24 Oct 2023 17:10:25 +0000 (UTC)
Date: Tue, 24 Oct 2023 13:10:24 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>
Subject: [PATCH] eventfs: Fix typo in eventfs_inode union comment
Message-ID: <20231024131024.5634c743@gandalf.local.home>
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

It's eventfs_inode not eventfs_indoe. There's no deer involved!

Fixes: 5790b1fb3d672 ("eventfs: Remove eventfs_file and just use eventfs_inode")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
index 298d3ecaf621..64fde9490f52 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -37,7 +37,7 @@ struct eventfs_inode {
 	/*
 	 * Union - used for deletion
 	 * @del_list:	list of eventfs_inode to delete
-	 * @rcu:	eventfs_indoe to delete in RCU
+	 * @rcu:	eventfs_inode to delete in RCU
 	 * @is_freed:	node is freed if one of the above is set
 	 */
 	union {
-- 
2.42.0

