Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA811C77B60
	for <linux-trace-kernel@archiver.kernel.org>; Fri, 28 Apr 2023 09:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345778AbjD1JzA (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Fri, 28 Apr 2023 05:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345886AbjD1Jyv (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 05:54:51 -0400
Received: from out187-3.us.a.mail.aliyun.com (out187-3.us.a.mail.aliyun.com [47.90.187.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E0D5593;
        Fri, 28 Apr 2023 02:54:24 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047201;MF=houwenlong.hwl@antgroup.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---.STDfs4A_1682675577;
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.STDfs4A_1682675577)
          by smtp.aliyun-inc.com;
          Fri, 28 Apr 2023 17:52:58 +0800
From:   "Hou Wenlong" <houwenlong.hwl@antgroup.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Thomas Garnier" <thgarnie@chromium.org>,
        "Lai Jiangshan" <jiangshan.ljs@antgroup.com>,
        "Kees Cook" <keescook@chromium.org>,
        "Hou Wenlong" <houwenlong.hwl@antgroup.com>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        "Masami Hiramatsu" <mhiramat@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        <linux-trace-kernel@vger.kernel.org>
Subject: [PATCH RFC 21/43] x86/ftrace: Adapt assembly for PIE support
Date:   Fri, 28 Apr 2023 17:51:01 +0800
Message-Id: <0092ce94b325ad8eb47ff4f95e012f9af1a127de.1682673543.git.houwenlong.hwl@antgroup.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1682673542.git.houwenlong.hwl@antgroup.com>
References: <cover.1682673542.git.houwenlong.hwl@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Change the assembly code to use only relative references of symbols for
the kernel to be PIE compatible.

Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
Cc: Thomas Garnier <thgarnie@chromium.org>
Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>
Cc: Kees Cook <keescook@chromium.org>
---
 arch/x86/kernel/ftrace_64.S | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index eddb4fabc16f..411fa4148e18 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -315,7 +315,14 @@ STACK_FRAME_NON_STANDARD_FP(ftrace_regs_caller)
 SYM_FUNC_START(__fentry__)
 	CALL_DEPTH_ACCOUNT
 
+#ifdef CONFIG_X86_PIE
+	pushq %r8
+	leaq ftrace_stub(%rip), %r8
+	cmpq %r8, ftrace_trace_function(%rip)
+	popq %r8
+#else
 	cmpq $ftrace_stub, ftrace_trace_function
+#endif
 	jnz trace
 	RET
 
@@ -329,7 +336,7 @@ trace:
 	 * ip and parent ip are used and the list function is called when
 	 * function tracing is enabled.
 	 */
-	movq ftrace_trace_function, %r8
+	movq ftrace_trace_function(%rip), %r8
 	CALL_NOSPEC r8
 	restore_mcount_regs
 
-- 
2.31.1

