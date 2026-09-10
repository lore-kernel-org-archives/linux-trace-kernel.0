Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C35858E2AE
	for <linux-trace-kernel@vger.kernel.org>; Thu, 10 Sep 2026 18:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789066281; cv=none; b=oV1IpMYoV95zs0vR5tCQ3LeDu1/muI5cjb97d1u1rwgJWCDIFnn2RrVHLKhnsMclecKUztD6KHOx3iE4mJJC+Et9IXVgSL68NdKZSN+YLBrdaee0lUkAhch7rgettnvaNnzO+ZKnXQ2nvu/y8GUBMsCy4Hi7ifFv9vE72iTDOyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789066281; c=relaxed/simple;
	bh=8cFDFeD2IXPN8Vlj1EymtW9Bi32PSZwsbXS468MRSTs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZNIA/bVWRImy706zulS61zq8c+VSF/gXKPZPiHrVAv6XOgrvxa+C4bppvbIhhkoY+Bw/GBetFKuMhlwS6Ciip3/aVu7fS2SDX5U1Buup6CS+PjhdNu0OImLkGhWxKb33At26ydFcZVYNkykphaoxAQEyZX6XNj0yU0Tx7YJRylo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=ehbjn6mY; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="ehbjn6mY"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-90cc372d6b2so117746d6.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 10 Sep 2026 11:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1789066265; x=1789671065; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hbVlQmHCpb9zv+5BDFsE+SK081jwlXFhk4tZhnaWY5k=;
        b=ehbjn6mYtcBg8mNyRQH+t/fYE9SohwGyL8Mo8L1tIBx6mmp5yb45VS9ARDx12XCcix
         uc64x62YEmeNW+FQ+6c3jIZHZs9pe3T90qt1eNdqLe+EelRNajjCzem5zcLdzNFShe3m
         8tRHF1I3Smci0PI92F1BQXxM7q5DHN9gEVA45eNZq0m9iXFBG5lbwY09ZGAIA2cJrmGV
         BzkJ/7XPDVOeSWi8LiqfEaAnlr597shVbFjxQsgedSZhh1l6LmwZvgGSwCe/f9nK7iGb
         2vb+fGzcu991miIr24F5PK8hURXk04m7i1ILcozSvsZBIt2Sv2LFbWblbpRRrHWTGQG5
         jrgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789066265; x=1789671065;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hbVlQmHCpb9zv+5BDFsE+SK081jwlXFhk4tZhnaWY5k=;
        b=BChDzRmkWXUBRuB05lsPvj1yoBTDhta1pEIQBtfU4cn6fIZ/izhLSCogzrQDSRv+CF
         txK+uH+6+1qbLXgQiA/UOgcSAGX9Ev/bHL1CWU0PsAFZKtFDB6FD9LPjvp275Lu2mShp
         mgfvG4HT8WXCVbUvqpi76zZmwJcKdvL7ReQpZs0STYgpgzcrOZ5LO+/NGH9zP6Sdc0WR
         wycQpfBM9oX0omBdRvH8wXYsQpj3L3g3U5yuOL3k/xnt+xxHTOQCcDEh+0h+PnB+v6Mv
         C7tJwQqDHncqqYTUcCLnqwn6qcwJAAVnV5xHtsNk4VQNy5S3Bb2ZTGh/5HU/NcNE8gnC
         Wo9w==
X-Forwarded-Encrypted: i=1; AKwUvBx1cjZ8sAKv5aP+sa+fu6mbrM4DNvq07ageoX8m8ppFz2ChC0vXF8HuyQMFxBes6qg+iDvLeBYQENcEBUm28CXEmEs=@vger.kernel.org
X-Gm-Message-State: AFuF++nOlVVowGL5NLNsqrDmjH9swYzjF/fVUjZISrlIQzBX6NfIvv4c
	6rwj8+hTcTIMDQY8VtRGOQs5LXH/tHcsYsFnIVYXJ8GKdKJ2wgrJA4Zxt8I8Go2+fYg=
X-Gm-Gg: AYBFou0ccwbcNp0ktOtqJhSC5xqHdP2UHaQdYApucKrO44uFbhoqf13GHsPmFSDeGP6
	6LJgZT1su0Yl/0VZra4c3YNoV80OFuFjxaVBWWwr/k1lH0gLPM0VQecbxbLUfubnioqXYKgN3oB
	gPyWniTkZFyIScIPRvJgnCqVfXBu9eGxUyUqCsyYIbZ+HdRvMQa2h+/Cnr2esPdGjbWwZcwlvhX
	QssZyJmUS1KlAy1U+ZGzsQhNzhADfhMbnk1RQqG2lU/wn8nmfMW1L1xaJep1yY6xDUmfDJRQ6Z9
	rjubIU03mLesGCU6VsK5th5DVh40Dw+XGhiph4IQycv0zU13Aup0y3BqAHrq7R843KhwkXa+S4X
	ORgGXeq8rzDmvp4g7xb+BxWSK6xolcp0bq2GaG5hpqvjf1R0B2hSZNabFApv85iAaW4oiuqLZ+r
	iYlZMIYIvC1CvVUNElyTPh24jF3TL1eV2trZXLDLCpqd5Lwp+7s0HO1MU5argY9WWE5iRchaKC4
	DU28QuFUyJjaKwSgzl4fJ5WN1lr4jPNK46poGCNnO+U8H7vgFV+0jk4
X-Received: by 2002:a05:622a:1309:b0:530:42e4:effc with SMTP id d75a77b69052e-530c87566f0mr10949261cf.41.1789066264886;
        Thu, 10 Sep 2026 11:51:04 -0700 (PDT)
Received: from toxicpanda.com (ec2-34-228-114-98.compute-1.amazonaws.com. [34.228.114.98])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530ca47efa2sm216291cf.11.2026.09.10.11.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 11:51:04 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 10 Sep 2026 18:50:30 +0000
Subject: [PATCH RFC 07/13] x86/kprobes: Maintain Tasks RCU trampoline
 nesting in the optprobe template
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-b4-rcu-tasks-preempt-qs-v1-7-d4469f4cc101@toxicpanda.com>
References: <20260910-b4-rcu-tasks-preempt-qs-v1-0-d4469f4cc101@toxicpanda.com>
In-Reply-To: <20260910-b4-rcu-tasks-preempt-qs-v1-0-d4469f4cc101@toxicpanda.com>
To: "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Boqun Feng <boqun@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 x86@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
 Xu Kuohai <xukuohai@huaweicloud.com>
Cc: Andy Lutomirski <luto@kernel.org>, 
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
 Juergen Gross <jgross@suse.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, linux-kernel@vger.kernel.org, 
 rcu@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 xen-devel@lists.xenproject.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2

The jump-optimized kprobe template calls optimized_callback() with
preemption still enabled for its first few instructions, so bracket the
call with an increment/decrement of current->rcu_tramp_nesting.  The
template lives in .rodata and is memcpy()d into each optinsn slot without
relocation processing, so the per-CPU reference to current_task must be
an absolute %gs: address (R_X86_64_32S, relocated for KASLR like any
other) rather than %rip-relative.  %rax has already been saved by
SAVE_REGS_STRING and is dead after the call.

The slot itself is dynamically allocated text, so the instructions before
the increment and after the decrement are covered by the irq-exit IP
check.  64-bit only; 32-bit x86 does not take part.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 arch/x86/kernel/kprobes/opt.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index 3f8fea52619f..f722520bb989 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -31,6 +31,7 @@
 #include <asm/set_memory.h>
 #include <asm/sections.h>
 #include <asm/nospec-branch.h>
+#include <asm/asm-offsets.h>
 
 #include "common.h"
 
@@ -101,6 +102,23 @@ static void synthesize_set_arg1(kprobe_opcode_t *addr, unsigned long val)
 	*(unsigned long *)addr = val;
 }
 
+/*
+ * Tasks RCU trampoline nesting, see rcu_tasks_trampoline_enter().  The
+ * template is memcpy()d into the slot without relocation processing, so the
+ * per-CPU reference must be absolute, not %rip-relative.
+ */
+#if defined(CONFIG_TASKS_RCU) && defined(CONFIG_X86_64)
+#define OPTPROBE_RCU_TASKS_ENTER					\
+			"	movq %gs:current_task, %rax\n"		\
+			"	incl " __stringify(TASK_rcu_tramp_nesting) "(%rax)\n"
+#define OPTPROBE_RCU_TASKS_EXIT					\
+			"	movq %gs:current_task, %rax\n"		\
+			"	decl " __stringify(TASK_rcu_tramp_nesting) "(%rax)\n"
+#else
+#define OPTPROBE_RCU_TASKS_ENTER
+#define OPTPROBE_RCU_TASKS_EXIT
+#endif
+
 asm (
 			".pushsection .rodata\n"
 			".global optprobe_template_entry\n"
@@ -114,6 +132,7 @@ asm (
 			"optprobe_template_clac:\n"
 			ASM_NOP3
 			SAVE_REGS_STRING
+			OPTPROBE_RCU_TASKS_ENTER
 			"	movq %rsp, %rsi\n"
 			".global optprobe_template_val\n"
 			"optprobe_template_val:\n"
@@ -122,6 +141,7 @@ asm (
 			".global optprobe_template_call\n"
 			"optprobe_template_call:\n"
 			ASM_NOP5
+			OPTPROBE_RCU_TASKS_EXIT
 			/* Copy 'regs->flags' into 'regs->ss'. */
 			"	movq 18*8(%rsp), %rdx\n"
 			"	movq %rdx, 20*8(%rsp)\n"

-- 
2.55.0

