Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF91C678DA
	for <linux-trace-kernel@archiver.kernel.org>; Tue, 17 Jan 2023 04:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235436AbjAQElQ (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 16 Jan 2023 23:41:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235368AbjAQElL (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 23:41:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947D523101;
        Mon, 16 Jan 2023 20:41:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CF50611B7;
        Tue, 17 Jan 2023 04:41:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95312C433EF;
        Tue, 17 Jan 2023 04:41:03 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1pHdmP-001rtc-1q;
        Mon, 16 Jan 2023 23:41:01 -0500
Message-ID: <20230117044101.434296637@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 16 Jan 2023 23:40:15 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ross Zwisler <zwisler@google.com>
Subject: [PATCH 5/5] tracing/histogram: Add simple tests for stacktrace usage of synthetic
 events
References: <20230117044010.838685230@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Update the selftests to include a test of passing a stacktrace between the
events of a synthetic event.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c                          |  2 +-
 .../trigger-synthetic-event-stack.tc          | 24 +++++++++++++++++++
 .../trigger-synthetic-event-syntax.tc         |  6 +++++
 3 files changed, 31 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-stack.tc

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index d445789dc247..beb7b0e77874 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5803,7 +5803,7 @@ static const char readme_msg[] =
 #ifdef CONFIG_SYNTH_EVENTS
 	"  events/synthetic_events\t- Create/append/remove/show synthetic events\n"
 	"\t  Write into this file to define/undefine new synthetic events.\n"
-	"\t     example: echo 'myevent u64 lat; char name[]' >> synthetic_events\n"
+	"\t     example: echo 'myevent u64 lat; char name[]; long[] stack' >> synthetic_events\n"
 #endif
 #endif
 ;
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-stack.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-stack.tc
new file mode 100644
index 000000000000..755dbe94ccf4
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-stack.tc
@@ -0,0 +1,24 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: event trigger - test inter-event histogram trigger trace action with dynamic string param
+# requires: set_event synthetic_events events/sched/sched_process_exec/hist "long[]' >> synthetic_events":README
+
+fail() { #msg
+    echo $1
+    exit_fail
+}
+
+echo "Test create synthetic event with stack"
+
+
+echo 's:wake_lat pid_t pid; u64 delta; unsigned long[] stack;' > dynamic_events
+echo 'hist:keys=next_pid:ts=common_timestamp.usecs,st=stacktrace  if prev_state == 1||prev_state == 2' >> events/sched/sched_switch/trigger
+echo 'hist:keys=prev_pid:delta=common_timestamp.usecs-$ts,s=$st:onmax($delta).trace(wake_lat,prev_pid,$delta,$s)' >> events/sched/sched_switch/trigger
+echo 1 > events/synthetic/wake_lat/enable
+sleep 1
+
+if ! grep -q "=>.*sched" trace; then
+    fail "Failed to create synthetic event with stack"
+fi
+
+exit 0
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-syntax.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-syntax.tc
index 2968cdc7df30..366f1f3ad906 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-syntax.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-syntax.tc
@@ -70,6 +70,12 @@ grep "myevent[[:space:]]unsigned long var" synthetic_events
 echo "myevent char var[10]" > synthetic_events
 grep "myevent[[:space:]]char\[10\] var" synthetic_events
 
+if grep -q 'long\[\]' README; then
+  # test stacktrace type
+  echo "myevent unsigned long[] var" > synthetic_events
+  grep "myevent[[:space:]]unsigned long\[\] var" synthetic_events
+fi
+
 do_reset
 
 exit 0
-- 
2.39.0


