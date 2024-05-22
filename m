Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D35D1411E0;
	Wed, 22 May 2024 16:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716396263; cv=none; b=XgzAB8PAPSkZYgseBTJYbogCfEEsQiMlquiIEF6kYzgfeStg405nyAywJW/hkkClhqg0gB3gpAp3Gk1Err2k6uaJmZiITzspT8JqUEowK8gaTHIqdFk/OlQ8wjuLoW5xEdK1o9rIx4hDeig7z3nllX8tvLZkOnIFglX8KjkICRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716396263; c=relaxed/simple;
	bh=m0KMP47n39r0blvYu76srRaZafMY7Z9XIDGSzufey60=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=fxd9aV9nQ9T87w0bwfji+OpHJ49aNT1CJU0sRiHbTx8VbL/lU34wNpN94YLsYfkr9IzHrp+kL4NJdhlydtjkqmpXAL/E2GbdRo2MfcfToGXwrzGYSD/E0Mm3wZAx40WLzI4qjVRPZ6YazwABngZKanPdgNH2lFdgPDaNBUJ2vuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3941C2BBFC;
	Wed, 22 May 2024 16:44:21 +0000 (UTC)
Date: Wed, 22 May 2024 12:45:04 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] tracefs: Remove unneeded buggy tracefs iput callback
Message-ID: <20240522124504.28982867@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The iput callback was added because the remount could call into the
eventfs code and touch the ei->entry_attrs array, which could have been
freed when an eventfs directory is freed (via a synthetic event). But the
entry_attrs was freed incorrectly and since been fixed to be freed after
the last reference of the ei is done.

The iput clears the TRACEFS_EVENT_INODE flag of the tracefs_inode
preventing it from calling the eventfs_remount() function. But the iput
can be called after the last reference to the inode is done but the
eventfs_inode still exists, causing the eventfs_remount() not to be called
on an tracefs_inode when it should be.

Link: https://lore.kernel.org/all/CAK7LNARXgaWw3kH9JgrnH4vK6fr8LDkNKf3wq8NhMWJrVwJyVQ@mail.gmail.com/

Cc: stable@vger.kernel.org
Reported-by: Masahiro Yamada <masahiroy@kernel.org>
Fixes: ee4e0379475e4 ("eventfs: Free all of the eventfs_inode after RCU")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/inode.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 9252e0d78ea2..62ca9c23b93c 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -455,22 +455,7 @@ static int tracefs_d_revalidate(struct dentry *dentry, unsigned int flags)
 	return !(ei && ei->is_freed);
 }
 
-static void tracefs_d_iput(struct dentry *dentry, struct inode *inode)
-{
-	struct tracefs_inode *ti = get_tracefs(inode);
-
-	/*
-	 * This inode is being freed and cannot be used for
-	 * eventfs. Clear the flag so that it doesn't call into
-	 * eventfs during the remount flag updates. The eventfs_inode
-	 * gets freed after an RCU cycle, so the content will still
-	 * be safe if the iteration is going on now.
-	 */
-	ti->flags &= ~TRACEFS_EVENT_INODE;
-}
-
 static const struct dentry_operations tracefs_dentry_operations = {
-	.d_iput = tracefs_d_iput,
 	.d_revalidate = tracefs_d_revalidate,
 	.d_release = tracefs_d_release,
 };
-- 
2.43.0

