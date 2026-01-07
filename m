Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1D427602C;
	Wed,  7 Jan 2026 21:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767820492; cv=none; b=RvtZ8SqJXV4V5Z1ZIDdB9Hys+wjLsNii+WeFxCwBWTREmVIo315yF83ecJmGj59t7Y1ufjwzPEJ3mt8JTmIVCkmwbukyYEWaDt4Xcqy7rhunK5ASBOWTKZMxKopC+d7ZUb1FPrgefsUnFprJvqo/r7l7DoNy9rbhdGAMtkYro00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767820492; c=relaxed/simple;
	bh=/aev3IonLbxxYminO0KvmPzvOxAEBZQtvx2NCi4/kBA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=In0kyZ6J6yQdWg3FHTmMmJYds7Sy1bgpbwR6jPE3m2fFroSBSc8pvId5Va+2DmRrLWC6MfJPNhoKcFWnpPIbJX5b09JHyng2oHquknYDzbis8geRjtWZYNvDzlFa0yfgDk1CwvZX7u7nviSVa06K9ksWgvGewOWvEBTeSspvcjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 6BC3413B149;
	Wed,  7 Jan 2026 21:14:45 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id B422560018;
	Wed,  7 Jan 2026 21:14:43 +0000 (UTC)
Date: Wed, 7 Jan 2026 16:15:10 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Li Zhong <floridsleeves@gmail.com>
Subject: [PATCH] tracing: Check the return value of tracing_update_buffers()
Message-ID: <20260107161510.4dc98b15@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: B422560018
X-Stat-Signature: 6pfsua9r9jxzhsxdiouzgxg5anjryjm6
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/f55tTmV1Xy4l+DdhrT5ge3qHpGGva3tk=
X-HE-Tag: 1767820483-340451
X-HE-Meta: U2FsdGVkX1/ehJVROlcBb8BLpw8kjhULhxp8Sh2iTNa7TKrb7lZ/7kBurn88m0goR6hptSE9E+lsyGaXcUfJAk1LfN7YIM2M1AaowVLI4KMuitrKq+omwT+IBGDebWeKTONU9MLB2EZKIB1/MEmIrrxQnmQyGqy3o2fHQ2yZa3YEsI7Y60gwifg0nrKN4zGgH7ehGRNa0jTHTij4iYy3NDqykNvO5vR2TrWJBexJCBtbCh7dTUyMR/r8IdT4XoO8vZ4tRyt1qpxwVsTa5tE6WsG9B81Djb1sj4O0ZuMBx2Mwzynb08bije8xUlrKH4QI9WTCeHcvaasIhUFErxASlUgbEVfVXdFAF2J/LeKHp8rPEfOUErszFGKs9TY4jxIpBciZV7U9J/GHGSJqA8p4mk3BLmYsyVpB1nG9YCBNjNQ=

From: Steven Rostedt <rostedt@goodmis.org>

In the very unlikely event that tracing_update_buffers() fails in
trace_printk_init_buffers(), report the failure so that it is known.

Link: https://lore.kernel.org/all/20220917020353.3836285-1-floridsleeves@gmail.com/

Suggested-by: Li Zhong <floridsleeves@gmail.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 2d387d56dcd4..1722e01e2238 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3418,9 +3418,10 @@ void trace_printk_init_buffers(void)
 	pr_warn("**********************************************************\n");
 
 	/* Expand the buffers to set size */
-	tracing_update_buffers(&global_trace);
-
-	buffers_allocated = 1;
+	if (tracing_update_buffers(&global_trace) < 0)
+		pr_err("Failed to expand tracing buffers for trace_printk() calls\n");
+	else
+		buffers_allocated = 1;
 
 	/*
 	 * trace_printk_init_buffers() can be called by modules.
-- 
2.51.0

