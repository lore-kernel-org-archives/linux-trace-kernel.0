Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D167BC77B60
	for <linux-trace-kernel@archiver.kernel.org>; Tue, 21 Mar 2023 14:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbjCUOEy (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 21 Mar 2023 10:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbjCUOEr (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 10:04:47 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B508821283
        for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Mar 2023 07:04:44 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id m35so9636118wms.4
        for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Mar 2023 07:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679407484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zMn2X0pVjGcM1Rx/07U3BIPDRphxQJGYTZujBYSKg+w=;
        b=HLZ5sQjmOqrjsnENpiaSjqUEi456nEtduJQ882MMeRNijbPddYhHjR8mqzKm3w9/4f
         ETn7KJPqPkgdAu2giUIzAR9LjvsmpPzceuWL2W55d6QmZUMAfj2jX/litSDOuQEUDGSI
         CWO+xbE/oxA1mEiEoT856ysWYIpOe768kHYqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679407484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zMn2X0pVjGcM1Rx/07U3BIPDRphxQJGYTZujBYSKg+w=;
        b=Ya0z5n97No/aWzGzSjfiewUIQJBJsrvWxZqM3YHHSVlSC3258Ye1acnxNtZ1euhdDV
         +X/t5jCj1H6S+nthxzJ14Mi/ihR0LGxT9FvuFE+GE0QIK9BhzvTmaJNgJW2vl5HeYxmj
         b5N5+gVp5lrikAbRBtNV84Gsj/ZunlIyp3oxNiQNmfVxWpAf8RKMfak0YKI4YH5QXEl2
         KZcew5pkYKZAcfV6dqhEOLD96zEKW+vZ89yrRZvIn7A1A1zFgROAh5caN7IT0IHYsWwg
         RSo/kw9opZSwt8Ij97bxXP3kd94xJXULVXbvCKihSXpV1U3JBUyoFbZhIBwRSCYiyjKH
         GBJQ==
X-Gm-Message-State: AO0yUKWgn+66JsA5RAzzwMrwPIHw1RWCaNMd1jZ9V9HqfH7XQShj8AYA
        mVgFvjk9INfAGJLX12nBG4UwJQ==
X-Google-Smtp-Source: AK7set8zpYdPiRGJUBiy5V/lg8EmDrXGFxeZWCBkOBI+45C9J35jYL8//mqU9H7q8k4e3z6NIe9J5A==
X-Received: by 2002:a1c:6a16:0:b0:3ed:a45d:aee9 with SMTP id f22-20020a1c6a16000000b003eda45daee9mr2377902wmc.39.1679407484111;
        Tue, 21 Mar 2023 07:04:44 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:4b8c:8b16:90d:8d9a])
        by smtp.gmail.com with ESMTPSA id f12-20020a1cc90c000000b003e20cf0408esm13620896wmb.40.2023.03.21.07.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 07:04:43 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com,
        ast@kernel.org, daniel@iogearbox.net, kpsingh@kernel.org,
        revest@chromium.org, jolsa@kernel.org,
        Li Huafei <lihuafei1@huawei.com>,
        Xu Kuohai <xukuohai@huawei.com>
Subject: [PATCH v2 7/7] ftrace: selftest: remove broken trace_direct_tramp
Date:   Tue, 21 Mar 2023 15:04:24 +0100
Message-Id: <20230321140424.345218-8-revest@chromium.org>
X-Mailer: git-send-email 2.40.0.rc2.332.ga46443480c-goog
In-Reply-To: <20230321140424.345218-1-revest@chromium.org>
References: <20230321140424.345218-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

From: Mark Rutland <mark.rutland@arm.com>

The ftrace selftest code has a trace_direct_tramp() function which it
uses as a direct call trampoline. This happens to work on x86, since the
direct call's return address is in the usual place, and can be returned
to via a RET, but in general the calling convention for direct calls is
different from regular function calls, and requires a trampoline written
in assembly.

On s390, regular function calls place the return address in %r14, and an
ftrace patch-site in an instrumented function places the trampoline's
return address (which is within the instrumented function) in %r0,
preserving the original %r14 value in-place. As a regular C function
will return to the address in %r14, using a C function as the trampoline
results in the trampoline returning to the caller of the instrumented
function, skipping the body of the instrumented function.

Note that the s390 issue is not detcted by the ftrace selftest code, as
the instrumented function is trivial, and returning back into the caller
happens to be equivalent.

On arm64, regular function calls place the return address in x30, and
an ftrace patch-site in an instrumented function saves this into r9
and places the trampoline's return address (within the instrumented
function) in x30. A regular C function will return to the address in
x30, but will not restore x9 into x30. Consequently, using a C function
as the trampoline results in returning to the trampoline's return
address having corrupted x30, such that when the instrumented function
returns, it will return back into itself.

To avoid future issues in this area, remove the trace_direct_tramp()
function, and require that each architecture with direct calls provides
a stub trampoline, named ftrace_stub_direct_tramp. This can be written
to handle the architecture's trampoline calling convention, and in
future could be used elsewhere (e.g. in the ftrace ops sample, to
measure the overhead of direct calls), so we may as well always build it
in.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Li Huafei <lihuafei1@huawei.com>
Cc: Xu Kuohai <xukuohai@huawei.com>
Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
Cc: Florent Revest <revest@chromium.org>
Signed-off-by: Florent Revest <revest@chromium.org>
---
 arch/s390/kernel/mcount.S     |  5 +++++
 arch/x86/kernel/ftrace_32.S   |  5 +++++
 arch/x86/kernel/ftrace_64.S   |  4 ++++
 include/linux/ftrace.h        |  2 ++
 kernel/trace/trace_selftest.c | 12 ++----------
 5 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/arch/s390/kernel/mcount.S b/arch/s390/kernel/mcount.S
index 43ff91073d2a..6c10da43b538 100644
--- a/arch/s390/kernel/mcount.S
+++ b/arch/s390/kernel/mcount.S
@@ -32,6 +32,11 @@ ENTRY(ftrace_stub)
 	BR_EX	%r14
 ENDPROC(ftrace_stub)
 
+SYM_CODE_START(ftrace_stub_direct_tramp)
+	lgr	%r1, %r0
+	BR_EX	%r1
+SYM_CODE_END(ftrace_stub_direct_tramp)
+
 	.macro	ftrace_regs_entry, allregs=0
 	stg	%r14,(__SF_GPRS+8*8)(%r15)	# save traced function caller
 
diff --git a/arch/x86/kernel/ftrace_32.S b/arch/x86/kernel/ftrace_32.S
index a0ed0e4a2c0c..0d9a14528176 100644
--- a/arch/x86/kernel/ftrace_32.S
+++ b/arch/x86/kernel/ftrace_32.S
@@ -163,6 +163,11 @@ SYM_INNER_LABEL(ftrace_regs_call, SYM_L_GLOBAL)
 	jmp	.Lftrace_ret
 SYM_CODE_END(ftrace_regs_caller)
 
+SYM_FUNC_START(ftrace_stub_direct_tramp)
+	CALL_DEPTH_ACCOUNT
+	RET
+SYM_FUNC_END(ftrace_stub_direct_tramp)
+
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 SYM_CODE_START(ftrace_graph_caller)
 	pushl	%eax
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index 1265ad519249..8fc77e3e039c 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -307,6 +307,10 @@ SYM_INNER_LABEL(ftrace_regs_caller_end, SYM_L_GLOBAL)
 SYM_FUNC_END(ftrace_regs_caller)
 STACK_FRAME_NON_STANDARD_FP(ftrace_regs_caller)
 
+SYM_FUNC_START(ftrace_stub_direct_tramp)
+	CALL_DEPTH_ACCOUNT
+	RET
+SYM_FUNC_END(ftrace_stub_direct_tramp)
 
 #else /* ! CONFIG_DYNAMIC_FTRACE */
 
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 31f1e1df2af3..931f3d904529 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -413,6 +413,8 @@ int unregister_ftrace_direct(struct ftrace_ops *ops, unsigned long addr,
 int modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr);
 int modify_ftrace_direct_nolock(struct ftrace_ops *ops, unsigned long addr);
 
+void ftrace_stub_direct_tramp(void);
+
 #else
 struct ftrace_ops;
 # define ftrace_direct_func_count 0
diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
index 84cd7ba31d27..a931d9aaea26 100644
--- a/kernel/trace/trace_selftest.c
+++ b/kernel/trace/trace_selftest.c
@@ -786,14 +786,6 @@ static struct fgraph_ops fgraph_ops __initdata  = {
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 static struct ftrace_ops direct;
-#ifndef CALL_DEPTH_ACCOUNT
-#define CALL_DEPTH_ACCOUNT ""
-#endif
-
-noinline __noclone static void trace_direct_tramp(void)
-{
-	asm(CALL_DEPTH_ACCOUNT);
-}
 #endif
 
 /*
@@ -873,7 +865,7 @@ trace_selftest_startup_function_graph(struct tracer *trace,
 	 */
 	ftrace_set_filter_ip(&direct, (unsigned long)DYN_FTRACE_TEST_NAME, 0, 0);
 	ret = register_ftrace_direct(&direct,
-				     (unsigned long)trace_direct_tramp);
+				     (unsigned long)ftrace_stub_direct_tramp);
 	if (ret)
 		goto out;
 
@@ -894,7 +886,7 @@ trace_selftest_startup_function_graph(struct tracer *trace,
 	unregister_ftrace_graph(&fgraph_ops);
 
 	ret = unregister_ftrace_direct(&direct,
-				       (unsigned long) trace_direct_tramp,
+				       (unsigned long)ftrace_stub_direct_tramp,
 				       true);
 	if (ret)
 		goto out;
-- 
2.40.0.rc2.332.ga46443480c-goog

