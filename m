Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12DA4E7801
	for <linux-trace-kernel@vger.kernel.org>; Fri, 18 Sep 2026 14:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789743003; cv=none; b=uJkn8P+1aoV0myZ0JK7pl+RLoq3QjeCSNYSog8QOVHnwaCTvnYxV1bkv94rUGGJqIMIB6i0ardEGfe/pluhaJ/IKsKnpu2qqbvySL6ylUh+pqw6+ht2aJrNxw/c0YKCIitXA/Bur7Ob7HJFWklA86yHLYVJHiiY0UDRg360Q7/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789743003; c=relaxed/simple;
	bh=cyOEpv7E+99KbsYBQF12i4qmiz/SB2W5CJ1v6BiG3CI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m9xFxnqfGqMLgdp+54/PdKZrI6LH0xewFAbMhv8Dm7FvAg+kNKsnBx7jHyDFIdLC82ngOYcV/5iono4Q+IkGMTBBAc2Y9KEh/jEuiGfynEdapfucA4pApHk564WzCLfh9yYykeGtxIsVZQxc0qPwcDejHmsxEswe3FELsuWdHCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=UN6+QXa8; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="UN6+QXa8"
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-93a2dea320fso87071185a.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 18 Sep 2026 07:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1789742995; x=1790347795; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9lDajmUPmaz8BTxhPEk6XaACKGtk0v9RwI05AN+Obys=;
        b=UN6+QXa8+0Aq4MX4kFKwncvhEDnPYCHb5/Mc9gFPQBvE12SU+Skaj7P1TggTxQz+34
         /c6udRv5lIZ44YzuViwDB7oZwqxzOcBPYyrBALjRHi30uCZXTT80OOEAKgM43cQoyyOo
         LJ9QPS6bl1jQX95AUtx8DkIHu9sI1gyFDJi0hdZ9jInkzoHlrXcwohAXg08e9yQLlbhL
         VercL54+gyr7xREBjL4lHPo+aYgMPdD04mp5Q0+63sTvR5KIveprTzDPVNVk9guSxHin
         nGdCMchxre6BNO8q1aB7pdRNtMZ4eFuysKjGq15Jw7RB/aij4zr8vgKhGjR0a4ClCEmo
         4YsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789742995; x=1790347795;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9lDajmUPmaz8BTxhPEk6XaACKGtk0v9RwI05AN+Obys=;
        b=fhjXruBfZA96TRNY2F0HubRFD5/h5TZpzYIRSk6YHZ/MuuvH2hZ/BXNVBvXUIKa4eV
         uZp5VzSOsGHL8/lLmLyfl7l+E+vsjQrNPpjoMkIVja4Pk5gQ2aCN8/v65QoQTLBjb4Ic
         5SXur1F5YMBh/Zj8Rw2M1JP0ilLj6s1Yf4qX4kcjdly3mHvp1L60+99GU/m3jeUtUAVV
         +KXaNg8A07MFYOaj9SoXX6lbr4YVNVJmq+oRRNvcxjHhRxlgJQsF4lf4DW+cmNDucNog
         J1vWYhyrAZvpTTiZmyPMZQylUqV/lL+rPTI0naYk2UU43pWPY8Q+swjFkWOwLCrCGGHe
         Y+4g==
X-Forwarded-Encrypted: i=1; AKwUvBzaVckdwrMc1T7cG2HynGo60TfdDuwKPHpa/kJukppPzyIHbvb+Ewqz4o49B1OigySwBezbxr+T42WjQGTInuRXiJs=@vger.kernel.org
X-Gm-Message-State: AFuF++kEKtMYMzj/YrvdTD/XMcNuz9r70g6Di2/2EANjwHE6BBhr9CEv
	x8ZF+EJ3U3ydaZDpL7b/go28xYRqyObTd0Emgb/rDdYZonlfhMhh59wYKaDWjAHNsRs=
X-Gm-Gg: AYBFou1lD7+sBNkbFes3s0ZOq71aNXBT6l5nVl6ebuyggUdNhaviYfvGOFGEaeyvt+i
	bQ04ZDDJAM8xlujrtvLouZdolswIfCHB8O5tWFSgp4zsFY216tznEx1RRAilC973UgCQ23IgrYy
	rip4zgkZ28aTFu0emlPYoc0bUzocHWOQ36u5vt9yMR5fwOi1FKNL/sK1BZcl4NxjSpHXk1OigdQ
	MwQCf3BGq4cI5ZRApcE/tK1rF4Xwlp1z4w12rMLp7j9tCBfuhgav3dfnjRuKPSsFzt4LG1jApJh
	bdpaa8DTYNJphk3fHpHBeLEqlaYjhUmIBcIDN0uNbq8RMLJMZVmKNTtFkpicbfNRflGWIg7RMhe
	yerMIHpWMRnmwHnivCqWc1W/504Il3nrBAcZaYvwpDh0+oKV8eHmwqO0z5HdnQgHFixRdOOUcTY
	c8mxsnawT2AcrQwa47/K+QNjZE4ol8BS0XG4PhzqRQPM19RNeDReyG4n996oJeUdtmLtMcTvhdV
	xzGX3Ehmq9YyB0432zIZtL/2t699ibjbROjJCxdUOpWPNMpaJ7BLDyG
X-Received: by 2002:a05:620a:2591:b0:939:3626:558b with SMTP id af79cd13be357-93bdc6e9664mr386099885a.5.1789742995331;
        Fri, 18 Sep 2026 07:49:55 -0700 (PDT)
Received: from toxicpanda.com (ec2-34-228-114-98.compute-1.amazonaws.com. [34.228.114.98])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9125808d8fcsm14099356d6.45.2026.09.18.07.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 07:49:54 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Fri, 18 Sep 2026 14:49:25 +0000
Subject: [PATCH RFC v4 06/13] x86/kprobes: Take a Tasks Trace reader in the
 optprobe template
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-b4-rcu-tasks-preempt-qs-v4-6-63f0e9d69661@toxicpanda.com>
References: <20260918-b4-rcu-tasks-preempt-qs-v4-0-63f0e9d69661@toxicpanda.com>
In-Reply-To: <20260918-b4-rcu-tasks-preempt-qs-v4-0-63f0e9d69661@toxicpanda.com>
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
 Xu Kuohai <xukuohai@huaweicloud.com>, 
 "Paul E. McKenney" <paulmck@kernel.org>, 
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
 xen-devel@lists.xenproject.org, Andy Lutomirski <luto@kernel.org>, 
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
 Juergen Gross <jgross@suse.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, linux-kernel@vger.kernel.org, 
 rcu@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 xen-devel@lists.xenproject.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1789742980; l=3977;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=cyOEpv7E+99KbsYBQF12i4qmiz/SB2W5CJ1v6BiG3CI=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QEjEDkoMCTK8/SkEBNPAmAQa/DHNGXCcOq6l1exqCfOV/HOva5SRV+bPucef9uXdDcfTxk/sgpw
 4F0zavhp0AA0=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

The jump-optimized kprobe template calls optimized_callback() from a
dynamically allocated slot with preemption enabled, and only Tasks RCU
keeps that slot alive under a task preempted in the callback.  For
HAVE_RCU_TRAMPOLINE_READERS that means the template must be a Tasks
Trace reader across the call, so open-code rcu_read_lock_trace() and
rcu_read_unlock_trace() around it as ftrace_64.S does.  The template
lives in .rodata and is memcpy()d into each slot without relocation
processing, so the references to current_task and
rcu_tasks_trace_srcu_struct are absolute (R_X86_64_32S, relocated for
KASLR like any other) rather than %rip-relative.  %rax and %rcx have
already been saved by SAVE_REGS_STRING and are dead after the call.

The slot itself is dynamically allocated text, so the instructions
before the lock and after the unlock are covered by the irq-exit check.
64-bit only; 32-bit x86 does not take part.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 arch/x86/kernel/kprobes/opt.c | 44 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index 3f8fea52619f..68a5de6cdabe 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -31,6 +31,7 @@
 #include <asm/set_memory.h>
 #include <asm/sections.h>
 #include <asm/nospec-branch.h>
+#include <asm/asm-offsets.h>
 
 #include "common.h"
 
@@ -101,6 +102,47 @@ static void synthesize_set_arg1(kprobe_opcode_t *addr, unsigned long val)
 	*(unsigned long *)addr = val;
 }
 
+/*
+ * Open-coded rcu_read_lock_trace() / rcu_read_unlock_trace() around the call
+ * to optimized_callback(), see CONFIG_HAVE_RCU_TRAMPOLINE_READERS and the
+ * equivalent macros in ftrace_64.S.  The template is memcpy()d into the slot
+ * without relocation processing, so memory references must be absolute
+ * rather than %rip-relative.  %rax and %rcx are free at both points.
+ */
+#ifdef CONFIG_TASKS_RCU_TRAMPOLINE_READERS
+#ifndef CONFIG_TASKS_TRACE_RCU_NO_MB
+#define OPTPROBE_TRACE_RCU_MB	"	lock addl $0, -4(%rsp)\n"
+#else
+#define OPTPROBE_TRACE_RCU_MB
+#endif
+#define OPTPROBE_TRACE_RCU_READ_LOCK						\
+		"	movq %gs:current_task, %rcx\n"				\
+		"	movl " __stringify(TASK_trc_reader_nesting) "(%rcx), %eax\n"	\
+		"	incl " __stringify(TASK_trc_reader_nesting) "(%rcx)\n"	\
+		"	testl %eax, %eax\n"						\
+		"	jnz 1f\n"							\
+		"	movq rcu_tasks_trace_srcu_struct+" __stringify(SRCU_srcu_ctrp) ", %rax\n" \
+		"	incq %gs:" __stringify(SRCU_CTR_srcu_locks) "(%rax)\n"		\
+		"	movq %rax, " __stringify(TASK_trc_reader_scp) "(%rcx)\n"	\
+		OPTPROBE_TRACE_RCU_MB						\
+		"1:\n"
+#define OPTPROBE_TRACE_RCU_READ_UNLOCK						\
+		"	movq %gs:current_task, %rcx\n"				\
+		"	movl " __stringify(TASK_trc_reader_nesting) "(%rcx), %eax\n"	\
+		"	subl $1, %eax\n"						\
+		"	jnz 2f\n"							\
+		"	movq " __stringify(TASK_trc_reader_scp) "(%rcx), %rax\n"	\
+		"	movl $0, " __stringify(TASK_trc_reader_nesting) "(%rcx)\n"	\
+		OPTPROBE_TRACE_RCU_MB						\
+		"	incq %gs:" __stringify(SRCU_CTR_srcu_unlocks) "(%rax)\n"	\
+		"	jmp 3f\n"							\
+		"2:	movl %eax, " __stringify(TASK_trc_reader_nesting) "(%rcx)\n"	\
+		"3:\n"
+#else
+#define OPTPROBE_TRACE_RCU_READ_LOCK
+#define OPTPROBE_TRACE_RCU_READ_UNLOCK
+#endif
+
 asm (
 			".pushsection .rodata\n"
 			".global optprobe_template_entry\n"
@@ -114,6 +156,7 @@ asm (
 			"optprobe_template_clac:\n"
 			ASM_NOP3
 			SAVE_REGS_STRING
+			OPTPROBE_TRACE_RCU_READ_LOCK
 			"	movq %rsp, %rsi\n"
 			".global optprobe_template_val\n"
 			"optprobe_template_val:\n"
@@ -122,6 +165,7 @@ asm (
 			".global optprobe_template_call\n"
 			"optprobe_template_call:\n"
 			ASM_NOP5
+			OPTPROBE_TRACE_RCU_READ_UNLOCK
 			/* Copy 'regs->flags' into 'regs->ss'. */
 			"	movq 18*8(%rsp), %rdx\n"
 			"	movq %rdx, 20*8(%rsp)\n"

-- 
2.55.0

