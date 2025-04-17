Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808062517AF;
	Thu, 17 Apr 2025 14:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744900721; cv=none; b=hwKJxIfVsKVCCKYd2iBBI7F+gDZ7R4Y/tiacju7Dxc/K91MuGCZ+n1PygIUpdAgLRKbwwE/pLCMeq8gVahMIAHA3HsOhbKKrhcTGU3K/KUtWjlbl7frV/DpXoUxKCos1c8rZEcMVqZBQVLjJ0Pn9rObsbPqpwpe8uSFyzIomv5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744900721; c=relaxed/simple;
	bh=YmtnUeaLSZxV53krlcgNrrwtiIIegedBkZV17BMHwfA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=DM4wyLZQwEid50Gb+Z9fnetI2zhH6m50KqjzJIG26o1lMkr2t63WmLPTpXz0NRp1xHfQzpdaIvYaAIJwD08r711gbvNkAAfE+Vjp1x3LMR8HswDgRdzmnpmlSsi34Y38GffIAV81KeU2fHHkNqpc68+uwnCsEgCupn99oonX7sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A014C4CEE4;
	Thu, 17 Apr 2025 14:38:39 +0000 (UTC)
Date: Thu, 17 Apr 2025 10:40:17 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [PATCH] ftrace: Initialize variables for
 ftrace_startup/shutdown_subops()
Message-ID: <20250417104017.3aea66c2@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Steven Rostedt <rostedt@goodmis.org>

The reworking to fix and simplify the ftrace_startup_subops() and the
ftrace_shutdown_subops() made it possible for the filter_hash and
notrace_hash variables to be used uninitialized in a way that the compiler
did not catch it.

Initialize both filter_hash and notrace_hash to the EMPTY_HASH as that is
what they should be if they never are used.

Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Fixes: 0ae6b8ce200d ("ftrace: Fix accounting of subop hashes")
Closes: https://lore.kernel.org/all/1db64a42-626d-4b3a-be08-c65e47333ce2@linux.ibm.com/
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 19b902b8de2b..66bf4512ec04 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -3490,8 +3490,8 @@ static int add_next_hash(struct ftrace_hash **filter_hash, struct ftrace_hash **
  */
 int ftrace_startup_subops(struct ftrace_ops *ops, struct ftrace_ops *subops, int command)
 {
-	struct ftrace_hash *filter_hash;
-	struct ftrace_hash *notrace_hash;
+	struct ftrace_hash *filter_hash = EMPTY_HASH;
+	struct ftrace_hash *notrace_hash = EMPTY_HASH;
 	struct ftrace_hash *save_filter_hash;
 	struct ftrace_hash *save_notrace_hash;
 	int ret;
@@ -3625,8 +3625,8 @@ static int rebuild_hashes(struct ftrace_hash **filter_hash, struct ftrace_hash *
  */
 int ftrace_shutdown_subops(struct ftrace_ops *ops, struct ftrace_ops *subops, int command)
 {
-	struct ftrace_hash *filter_hash;
-	struct ftrace_hash *notrace_hash;
+	struct ftrace_hash *filter_hash = EMPTY_HASH;
+	struct ftrace_hash *notrace_hash = EMPTY_HASH;
 	int ret;
 
 	if (unlikely(ftrace_disabled))
-- 
2.47.2

