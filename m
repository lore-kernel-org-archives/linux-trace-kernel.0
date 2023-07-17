Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27C6EB64DC
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 17 Jul 2023 20:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjGQUjw (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 17 Jul 2023 16:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjGQUjv (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 16:39:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81302103;
        Mon, 17 Jul 2023 13:39:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 204666125F;
        Mon, 17 Jul 2023 20:39:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1518EC433C7;
        Mon, 17 Jul 2023 20:39:48 +0000 (UTC)
Date:   Mon, 17 Jul 2023 16:39:47 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH] tracing/probes: Differentiate BTF support from start of
 function
Message-ID: <20230717163947.4969316a@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Having a typo in the function name to trace one of the arguments using
BTF, gave me an error message that BTF was not supported by this kernel:

~# echo 'p:lock __raw_spin_lock lock=lock' > /sys/kernel/tracing/kprobe_events
-bash: echo: write error: Invalid argument
~# cat /sys/kernel/tracing/error_log
[   34.382149] trace_kprobe: error: BTF is not available or not supported
  Command: p:lock __raw_spin_lock lock=lock
                                       ^

I added two underscores instead of one underscore for the function
_raw_spin_lock(). But I spent too much time trying to figure out why BTF
was not supported, because in reality it was! The problem was that the
function wasn't found (this could happen if a function offset is used as
well).

Instead, add a new error message that gives a better description of the
problem.

~# echo 'p:lock __raw_spin_lock lock=lock' > /sys/kernel/tracing/kprobe_events
-bash: echo: write error: Invalid argument
~# cat /sys/kernel/tracing/error_log
[   45.922742] trace_kprobe: error: BTF arg can be used only on function entry
  Command: p:lock __raw_spin_lock lock=lock
                                       ^
Fixes: b576e09701c7d ("tracing/probes: Support function parameters if BTF is available")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_probe.c | 2 +-
 kernel/trace/trace_probe.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index cf504efd0694..328a51b1d068 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1023,7 +1023,7 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
 	default:
 		if (isalpha(arg[0]) || arg[0] == '_') {	/* BTF variable */
 			if (!tparg_is_function_entry(ctx->flags)) {
-				trace_probe_log_err(ctx->offset, NOSUP_BTFARG);
+				trace_probe_log_err(ctx->offset, NOFENTRY_BTFARG);
 				return -EINVAL;
 			}
 			ret = parse_btf_arg(arg, pcode, end, ctx);
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 604d6fb9c5ff..554fe2995ca1 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -493,6 +493,7 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 	C(BAD_ATTACH_ARG,	"Attached event does not have this field"),\
 	C(NO_EP_FILTER,		"No filter rule after 'if'"),		\
 	C(NOSUP_BTFARG,		"BTF is not available or not supported"),	\
+	C(NOFENTRY_BTFARG,	"BTF arg can be used only on function entry"),	\
 	C(NO_BTFARG,		"This variable is not found at this probe point"),\
 	C(NO_BTF_ENTRY,		"No BTF entry for this probe point"),	\
 	C(BAD_VAR_ARGS,		"$arg* must be an independent parameter without name etc."),\
-- 
2.40.1

