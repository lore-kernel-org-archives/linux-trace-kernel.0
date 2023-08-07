Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBBCC001DB
	for <linux-trace-kernel@archiver.kernel.org>; Mon,  7 Aug 2023 06:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjHGGs7 (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 7 Aug 2023 02:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbjHGGs5 (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 02:48:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919301737;
        Sun,  6 Aug 2023 23:48:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E30261588;
        Mon,  7 Aug 2023 06:48:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB7DDC433C7;
        Mon,  7 Aug 2023 06:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691390933;
        bh=5Wat1ZN9LgqYvlI6WEEnwpes5oBMUfxBgWSRXiQLnnA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hP/8bBicWbi8v+hSGI+k4BO2VcLNAotrk4dOJVMcab817b0zRzX8ypsqYLRHJvw7N
         YO5nrEEe6iHYBxxWCwI06qGbcGuRbU9ZQZN3XHtF0kO0a3Fhamq8F1FcCXoTlAFIHz
         tKujFeyRbmGt1bYF28QMbBFASfdf6cJaGFAJ/8FHoXZBL20SpO3+Cd/WINNVRJrudF
         gOdWqXERv5b27aNjbSQlrf+plT8X69i9oHgC8SgsIfZLXx1yKxHdUw+GBc5m1upmHT
         7YM2kwz6rHs0O593GxtXHM+55P47G9bbS/uqrV+I2PsAok5p7I0VXPhoKUapsFddOZ
         EGntGjnWBk7Ow==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Florent Revest <revest@chromium.org>
Cc:     linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        bpf <bpf@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alan Maguire <alan.maguire@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [RFC PATCH v2 2/6] tracing: Expose ftrace_regs regardless of CONFIG_FUNCTION_TRACER
Date:   Mon,  7 Aug 2023 15:48:47 +0900
Message-Id: <169139092722.324433.16681957760325391475.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <169139090386.324433.6412259486776991296.stgit@devnote2>
References: <169139090386.324433.6412259486776991296.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

In order to be able to use ftrace_regs even from features unrelated to
function tracer (e.g. kretprobe), expose ftrace_regs structures and
APIs even if the CONFIG_FUNCTION_TRACER=n.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 include/linux/ftrace.h |   45 ++++++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index ce156c7704ee..3fb94a1a2461 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -112,11 +112,11 @@ static inline int ftrace_mod_get_kallsym(unsigned int symnum, unsigned long *val
 }
 #endif
 
-#ifdef CONFIG_FUNCTION_TRACER
-
-extern int ftrace_enabled;
-
-#ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
+/*
+ * If the architecture doesn't support FTRACE_WITH_ARGS or disable function
+ * tracer, define the default(pt_regs compatible) ftrace_regs.
+ */
+#if !defined(CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS) || !defined(CONFIG_FUNCTION_TRACER)
 
 struct ftrace_regs {
 	struct pt_regs		regs;
@@ -129,6 +129,22 @@ struct ftrace_regs {
  * HAVE_DYNAMIC_FTRACE_WITH_ARGS is set and it supports live kernel patching.
  */
 #define ftrace_regs_set_instruction_pointer(fregs, ip) do { } while (0)
+
+#define ftrace_regs_get_instruction_pointer(fregs) \
+	instruction_pointer(ftrace_get_regs(fregs))
+#define ftrace_regs_get_argument(fregs, n) \
+	regs_get_kernel_argument(ftrace_get_regs(fregs), n)
+#define ftrace_regs_get_stack_pointer(fregs) \
+	kernel_stack_pointer(ftrace_get_regs(fregs))
+#define ftrace_regs_return_value(fregs) \
+	regs_return_value(ftrace_get_regs(fregs))
+#define ftrace_regs_set_return_value(fregs, ret) \
+	regs_set_return_value(ftrace_get_regs(fregs), ret)
+#define ftrace_override_function_with_return(fregs) \
+	override_function_with_return(ftrace_get_regs(fregs))
+#define ftrace_regs_query_register_offset(name) \
+	regs_query_register_offset(name)
+
 #endif /* CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS */
 
 static __always_inline struct pt_regs *ftrace_get_regs(struct ftrace_regs *fregs)
@@ -151,22 +167,9 @@ static __always_inline bool ftrace_regs_has_args(struct ftrace_regs *fregs)
 	return ftrace_get_regs(fregs) != NULL;
 }
 
-#ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
-#define ftrace_regs_get_instruction_pointer(fregs) \
-	instruction_pointer(ftrace_get_regs(fregs))
-#define ftrace_regs_get_argument(fregs, n) \
-	regs_get_kernel_argument(ftrace_get_regs(fregs), n)
-#define ftrace_regs_get_stack_pointer(fregs) \
-	kernel_stack_pointer(ftrace_get_regs(fregs))
-#define ftrace_regs_return_value(fregs) \
-	regs_return_value(ftrace_get_regs(fregs))
-#define ftrace_regs_set_return_value(fregs, ret) \
-	regs_set_return_value(ftrace_get_regs(fregs), ret)
-#define ftrace_override_function_with_return(fregs) \
-	override_function_with_return(ftrace_get_regs(fregs))
-#define ftrace_regs_query_register_offset(name) \
-	regs_query_register_offset(name)
-#endif
+#ifdef CONFIG_FUNCTION_TRACER
+
+extern int ftrace_enabled;
 
 typedef void (*ftrace_func_t)(unsigned long ip, unsigned long parent_ip,
 			      struct ftrace_ops *op, struct ftrace_regs *fregs);

