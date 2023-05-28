Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F64C77B7C
	for <linux-trace-kernel@archiver.kernel.org>; Sun, 28 May 2023 05:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjE1F0w (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Sun, 28 May 2023 01:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjE1F0s (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Sun, 28 May 2023 01:26:48 -0400
Received: from mammoth.local.home (cpe-172-100-189-27.stny.res.rr.com [172.100.189.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D4235E4;
        Sat, 27 May 2023 22:26:45 -0700 (PDT)
Received: by mammoth.local.home (Postfix, from userid 5657)
        id B95EB300A58; Sun, 28 May 2023 01:17:53 -0400 (EDT)
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux trace kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 1/5] tracing: Move setting of tracing_selftest_running out of register_tracer()
Date:   Sun, 28 May 2023 01:17:38 -0400
Message-Id: <20230528051742.1325503-2-rostedt@goodmis.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230528051742.1325503-1-rostedt@goodmis.org>
References: <20230528051742.1325503-1-rostedt@goodmis.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The variables tracing_selftest_running and tracing_selftest_disabled are
only used for when CONFIG_FTRACE_STARTUP_TEST is enabled. Make them only
visible within the selftest code. The setting of those variables are in
the register_tracer() call, and set in a location where they do not need
to be. Create a wrapper around run_tracer_selftest() called
do_run_tracer_selftest() which sets those variables, and have
register_tracer() call that instead.

Having those variables only set within the CONFIG_FTRACE_STARTUP_TEST
scope gets rid of them (and also the ability to remove testing against
them) when the startup tests are not enabled (most cases).

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 81801dc31784..87e5920b141f 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2041,6 +2041,17 @@ static int run_tracer_selftest(struct tracer *type)
 	return 0;
 }
 
+static int do_run_tracer_selftest(struct tracer *type)
+{
+	int ret;
+
+	tracing_selftest_running = true;
+	ret = run_tracer_selftest(type);
+	tracing_selftest_running = false;
+
+	return ret;
+}
+
 static __init int init_trace_selftests(void)
 {
 	struct trace_selftests *p, *n;
@@ -2092,6 +2103,10 @@ static inline int run_tracer_selftest(struct tracer *type)
 {
 	return 0;
 }
+static inline int do_run_tracer_selftest(struct tracer *type)
+{
+	return 0;
+}
 #endif /* CONFIG_FTRACE_STARTUP_TEST */
 
 static void add_tracer_options(struct trace_array *tr, struct tracer *t);
@@ -2127,8 +2142,6 @@ int __init register_tracer(struct tracer *type)
 
 	mutex_lock(&trace_types_lock);
 
-	tracing_selftest_running = true;
-
 	for (t = trace_types; t; t = t->next) {
 		if (strcmp(type->name, t->name) == 0) {
 			/* already found */
@@ -2157,7 +2170,7 @@ int __init register_tracer(struct tracer *type)
 	/* store the tracer for __set_tracer_option */
 	type->flags->trace = type;
 
-	ret = run_tracer_selftest(type);
+	ret = do_run_tracer_selftest(type);
 	if (ret < 0)
 		goto out;
 
@@ -2166,7 +2179,6 @@ int __init register_tracer(struct tracer *type)
 	add_tracer_options(&global_trace, type);
 
  out:
-	tracing_selftest_running = false;
 	mutex_unlock(&trace_types_lock);
 
 	if (ret || !default_bootup_tracer)
-- 
2.39.2

