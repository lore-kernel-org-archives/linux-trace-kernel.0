Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565BC257435;
	Tue, 14 Apr 2026 15:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776179033; cv=none; b=faObD8lO4qiDrync71Hqknf2UrH8bW+aDUOZq01h6jjlJs+iplzTV+rkAhynx29TVu3PvwejNElHRyOK4uDgFttqmPuvHUk3/sw8cQR7sYgsR5RMdLJnCSCIPTX4L+olOVCAYsJ0ldtHPTe9OtN3tqVsYY6Cw6F9VQjMtinnRzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776179033; c=relaxed/simple;
	bh=Ie9BelQsOPZrrtWuP8MPrx4E7PQ6A/dLElKECjGRgck=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Bi5nxFXqcDyIfoxRpX4SF2M0L/juGjQ2ap1QJLP8t+flNlbtKQez7XqryI/tGmLkr9a6UFQQKuXHjS+8GV2KImGGNjSJPmDylTTDD+mGgjtfXv+30aeZZz8JkKCdqdWHtpBNsaMi2MHXs79268RNDJ99K3cEzhzw0b5EUMsxkd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 05CBC14013A;
	Tue, 14 Apr 2026 15:03:49 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id B8FA180012;
	Tue, 14 Apr 2026 15:03:47 +0000 (UTC)
Date: Tue, 14 Apr 2026 11:03:44 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [PATCH] tracefs: Removed unused 'ret' variable in eventfs_iterate()
Message-ID: <20260414110344.75c0663f@robin>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: d3ef4gxixzbner36rrd1b1nuzwu6jkrs
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: B8FA180012
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/Zs57I5AxBgkSrB7358gv+wDpjpRCCBPE=
X-HE-Tag: 1776179027-678549
X-HE-Meta: U2FsdGVkX18BnVlf6cAzhCQFzX9tGd7jL8gGGjGjnHClk6R7x59Ik0xVqXVq1NwQge7++sGYa/ctD8Pd3MR69PhnupbJa9ocl0zqGkTY8L+wuwA8DCwOMDoY0rAMaHGzITiCZijISFAVwWOdRgM0RtAQfONZ9fCA3y6aKHjNXE9nEDt+1g10Vwh9kNgSn9/9AwVoWnV6psj1MkOpGhpFe11Re6wOS4J0NKbqRvA3URquFHsLht6G0pAZmyuUKfbO0CSjs9sUDq2m6xyKZ7PhHXbAfXFstKzGAsN0YJ+pCsnm+LJKDwWkFN8wRP/coH4e4GXAiqv5YEcWohk1vc3jtZ6cT6ZXj6XEAQBacbecAIGENca/rBxNlnfcnFI8xCuJgeFYvCqOmkNTrHjiO3lr7H5jWmM/iA/koZjxy1dzWO8=

From: Steven Rostedt <rostedt@goodmis.org>

Moving to guard() usage removed the need of using the 'ret' variable but
it wasn't removed. As it was set to zero, the compiler in use didn't warn
(although some compilers do).

Fixes: 4d9b262031f ("eventfs: Simplify code using guard()s")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202604100111.AAlbQKmK-lkp@intel.com/
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index af8d05df2726..81df94038f2e 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -574,7 +574,6 @@ static int eventfs_iterate(struct file *file, struct dir_context *ctx)
 	struct eventfs_inode *ei;
 	const char *name;
 	umode_t mode;
-	int ret = -EINVAL;
 	int ino;
 	int i, r, c;
 
@@ -599,7 +598,6 @@ static int eventfs_iterate(struct file *file, struct dir_context *ctx)
 	 * Need to create the dentries and inodes to have a consistent
 	 * inode number.
 	 */
-	ret = 0;
 
 	/* Start at 'c' to jump over already read entries */
 	for (i = c; i < ei->nr_entries; i++, ctx->pos++) {
-- 
2.51.0

