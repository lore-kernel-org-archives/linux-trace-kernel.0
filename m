Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3AD3D6473;
	Wed,  8 Jul 2026 20:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783543360; cv=none; b=X8h0RY9lNhn53zQ9A+ITZYukA9TDy/M9jeNeu70g9VamI7B+iednKV5czBAmDXCdp9shq73Q1R+DCGBDSn8yU6nYa+l7DsJbO/4A6dB+04BrV/xXW4cXLu87xyw0/3wc38OlEzjxfmvTy1pJUDNaRC5xydNQu5zUrQAXJQi+8S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783543360; c=relaxed/simple;
	bh=vk+YVqcgxcYoURaEUZIxvxfcYr8Yk1S7oKXTyiT7ces=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=CXUfR/O0DdawJcm0xladCNGtwmNuFMKopG2DBpcN014reXPMnZOwX/zaNS6W9NiEI2ZIH1mHriTq3hk0UXCQgBf1pqz7z6SmC1ZdXmioqjExFjPJb6cB4TtSDwGDt6tBmwJebFGgqB7JlKtS+JKOXs1Y8bTh6621FwpZuPWHLYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 9638B168CFA;
	Wed,  8 Jul 2026 20:34:33 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id A4A3E30;
	Wed,  8 Jul 2026 20:34:31 +0000 (UTC)
Date: Wed, 8 Jul 2026 16:34:36 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, linux-kselftest@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Shuah Khan <shuah@kernel.org>, Shuah Khan
 <skhan@linuxfoundation.org>
Subject: [PATCH] selftests/tracing: Have trigger-hist-poll.tc use
 sched_process_exit
Message-ID: <20260708163436.058cc3df@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A4A3E30
X-Stat-Signature: b7bxkzef7yqn7rr7fgty4nwso6wfyr9w
X-Rspamd-Server: rspamout07
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+L+wMC1IQj3v+ySeqReGCOIJPD6rZ9ujU=
X-HE-Tag: 1783542871-905460
X-HE-Meta: U2FsdGVkX1/bQWWQlg/cZ0hASeiDwnDiEzQGTMlz3vz99T9NIvG2tCzyUC245LYHNmQpgUOzGNQVT9rw0xiFagQ2qwGW6zaBNPv8C9lEqB75VPrACocKuOnmLcy4BFxGT5m1nB0S7/jczRLNwxfRfEmSRym9UePb8xOAFE/tAss1KClTGl//4h9OpDfBW361JllldPQTxVJ6IBafFhgHA5JbDSM119Up5qRin9GKY4QSS3hPv1zic97bpmaC4DuHHhGlaA/Q8+A6lh8N2UUrb5TQab65tavj8H8Z6kr97X/+caj7/f2h3xCqXMA6G7+IYcljKVeakbEqMlNjSm1WJhqQESVXupaPaN9Xz45Q2KIH1LpKiaZrOVRtN8Kn4nLA

From: Steven Rostedt <rostedt@goodmis.org>

Currently trigger-hist-poll.tc uses sched_process_free to test the polling
of the histogram file. The way it does that is to run sleep, then execute
the poll.c code that polls on the sched_process_free for up to 4 seconds
to test that when sleep triggers the sched_process_free trace event, it
will update the histogram and wake the poll.c code up.

The issue is that sched_process_free trace event is called by
delayed_put_task_struct() which is called after a RCU grace period has
ended. If CONFIG_RCU_LAZY is enabled, RCU callbacks are batched together
and do not execute right away. This causes the delayed_put_task_struct()
to be called after the poll.c function finishes and it will report an
error that it did not wake up on the event. That's because the event
didn't trigger during its wait time.

Use sched_process_exit instead, which is called when a process exits and
doesn't depend on RCU callbacks that may be delayed.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 .../selftests/ftrace/test.d/trigger/trigger-hist-poll.tc      | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-poll.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-poll.tc
index 8d275e3238d9..04eb8546fc07 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-poll.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-poll.tc
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test poll wait on histogram
-# requires: set_event events/sched/sched_process_free/trigger events/sched/sched_process_free/hist
+# requires: set_event events/sched/sched_process_exit/trigger events/sched/sched_process_exit/hist
 # flags: instance
 
 POLL=${FTRACETEST_ROOT}/poll
@@ -11,7 +11,7 @@ if [ ! -x ${POLL} ]; then
   exit_unresolved
 fi
 
-EVENT=events/sched/sched_process_free/
+EVENT=events/sched/sched_process_exit/
 
 # Check poll ops is supported. Before implementing poll on hist file, it
 # returns soon with POLLIN | POLLOUT, but not POLLPRI.
-- 
2.53.0

