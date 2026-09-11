Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C887D35B63F
	for <linux-trace-kernel@vger.kernel.org>; Fri, 11 Sep 2026 14:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789135808; cv=none; b=UiKPQHxQ1G9DxtVVabz0MDolaVFFSmetPIte5tb5+uTJOmPYTqfWJJXwU7tykWajssusuYIInDwmZrk91J2DLYlOcuxmJUapFSbmRBMtbu97C7SeNKbxs038bnnibvODvJuVmRCezRQCAw0I0GC7b+OcI4/Wr8dg/70t4UCkqOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789135808; c=relaxed/simple;
	bh=8cFDFeD2IXPN8Vlj1EymtW9Bi32PSZwsbXS468MRSTs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uzyT/YiHkx5iX1wyhaVon5/QH7hP/u7ln//en12uQxqOZD/baorjsBZeGnR32y+hLjx5GYYM7u/s4W0ifWhGe2pGDBhBPAaGiHgDZ7xcEoHlfwQpW8KXFaCWhRbIt19bxSRYke9MckTzSusMFqNFfMd0DBS5fjlEJkYXbO/kl1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=AO0u/AX8; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="AO0u/AX8"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-92f0b5ed131so121693985a.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 11 Sep 2026 07:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1789135804; x=1789740604; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hbVlQmHCpb9zv+5BDFsE+SK081jwlXFhk4tZhnaWY5k=;
        b=AO0u/AX8T2KO9cUT21S8NZRAtESkc/8lg+v96HISVkTT7B10Mjmvm8BmfwPFrST/Ea
         eHAw7XB0udEm4icZnkQxCqHzVeES3CSJFA/jmnILW85HT4C+GozarSvEh+N3OPILfXNn
         Hb2DXQGzHE07x0W/wCsgPkopcf60quSzzFv7BjvxE9CQ29+58ttPSF+RleZKLtOAvJL5
         xDjsow38dudkVjd+2EjMtOniOpMgAJ6gvOdCW6m+1L8UD8/XeCmjM9IQNUVeoLFPBUjI
         +2qLeWf9wL+LL1De3OC7dOk9Rek4M4/hZTsrTcsUl520tXWy37O4+V/SmPQZ9SGRmGsU
         WdAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789135804; x=1789740604;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hbVlQmHCpb9zv+5BDFsE+SK081jwlXFhk4tZhnaWY5k=;
        b=U95wEdSLUF0RDJ0FA711270RdtWXfjp9nxREHlxbYFd93B6nA2ZlD0OHoFAPKIwOyq
         VjzXSaYwxM5BFxrYwdBX8kcVhywAHmUMugPxFye8WDSgGzbULX0U8Kq7X8VwBekd2zpB
         RcxCDpjTPvpuL0wiQ/3Nq5SY4FrXeklrFy4gJ1ubt6XVjhCAzN/w6eaTExpElw0Mks9D
         NjgEux+RFMBgvcyiH5KpRnmk7NZ79jVJGRAPnPLlGwSvzI7wWRaCoHp1Dux/Qy/riqIU
         9RZhexJMbQ2en9uI0E1NIOy3wdNgs+Ump3HmmciFE7KBYSdRoxgxOi3Raf1ALVoo21xd
         eUmg==
X-Forwarded-Encrypted: i=1; AKwUvByt6c+JTKmt4fWx70DsojEB+Zzxe4WpICakhFP6QZNzN7FHMBKjIMm7y1ZG2aOlf+zNMJ9QXCs8ZI3pH5hyzKsE7Fk=@vger.kernel.org
X-Gm-Message-State: AFuF++nQMNlDc9Ah6G2gI6zzr3gdhLQ2LLcVztDTV1ort6Tw9a2kWKfI
	Del9smsw5sn5afZkkgz+5dq5+G3IomPVn2RjTJF9fnZ8Z6w4K6Qqg8AWzG14KNXIMrg=
X-Gm-Gg: AYBFou2u+7udTN8U0p/5fuvPHnZtpq1en1lUDw5kRi1w6Ht0e7uSjDgX8u4Zd+3Hwad
	ML2vYZJOijAR/ajU493xerGlsNuP4z2TqK2jAWhnTvjXGPwU2cnayHm1oEv5PfaQ/xl1Lrjf8jD
	mERUKH0fjh8uTZ+Jy6c/JJHWThRrgWzk5rOVtzQTLYDOwxEjHNGm1KCzyUv1X70Uuf6ITCJ1hi5
	jYVJenK6mRaKe+mrF6D05ql/EUXHwAFmz/jWolFYuJ4mrkiVbJyYlrdnAijqCVnII1sn10iJvrs
	n3C19d+Db8TNqU1CqkGI0HtJ5zyqsA1f9YqIpEQS/8GxX9R0OENv5b26ZFPO2iz11O8i5sTsMZK
	1vh3a0YM6gO8BbQ+kpLAtHMUYB4LmHcDPUPBHOqnlGWKypYU0Q2usSKxo63uIYUn/pMYOBXi6Hj
	4EHAfst3/K2qOLmisdcN5YVRNHxswIDgdGuLaY46ZyOi0XoCWdPpPJNAcPKSfhDOaLK0gCxZtqW
	2hL9//XOLDWpqA5fT+PVwEds/T5S+tdIMf60S6nIldOwkpCqIqJDd6Z
X-Received: by 2002:a05:620a:198d:b0:939:3a81:326 with SMTP id af79cd13be357-939ea18c166mr526461185a.37.1789135803738;
        Fri, 11 Sep 2026 07:10:03 -0700 (PDT)
Received: from toxicpanda.com (ec2-34-228-114-98.compute-1.amazonaws.com. [34.228.114.98])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939f1dd527asm125166385a.16.2026.09.11.07.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 07:10:01 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Fri, 11 Sep 2026 14:08:45 +0000
Subject: [PATCH RFC v2 07/15] x86/kprobes: Maintain Tasks RCU trampoline
 nesting in the optprobe template
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-b4-rcu-tasks-preempt-qs-v2-7-eaaa61ed2da4@toxicpanda.com>
References: <20260911-b4-rcu-tasks-preempt-qs-v2-0-eaaa61ed2da4@toxicpanda.com>
In-Reply-To: <20260911-b4-rcu-tasks-preempt-qs-v2-0-eaaa61ed2da4@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1789135736; l=2636;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=8cFDFeD2IXPN8Vlj1EymtW9Bi32PSZwsbXS468MRSTs=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QE88Fo4D8KnMZviii3UcxtNsSOWitctfeeqTUeKrfDl5ze3tUkJnL+Us2LrW6ea29znHZAO8PVa
 SQS9QIpNv5Ao=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

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

