Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB37A4FC8E8
	for <linux-trace-kernel@vger.kernel.org>; Fri, 18 Sep 2026 14:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789743031; cv=none; b=LYvkiax3acDNuoC2MK5u0VaqswXRA0hXIQCbNpwygepqXQDCteO5bTjeZwzRN3GYMP8nCZKUyrWOumUOyR5UVZXren4fgGzNp1BPLtGRGcLVPYliRvXNV7K1A0q7rXXyyivSsm6I1z6ly+qVcyg9/72dPIK+5Zkbbt5N5DL5c98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789743031; c=relaxed/simple;
	bh=FRa7j81kn+FZifN+tU/RXt2NlHMQaOXWqjJvWoyULIE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oau6LuM4rFzhns4OKUDbUH6Y2OHqbZV6GeWdCujduRArh4xMcNcJ+3EX2h7uIHKipwQVsQCqGEz9w4BmbiBjUsphrN/++oF87w4h36kIBAS9q6Rd6qeBhlDYW1F7CH8ioAanDoOgjGwsQmGnqfMU7aXrmBRtNcEwSrD+jX2S3sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=eaAruMPi; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="eaAruMPi"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90ce6d5271dso4554266d6.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 18 Sep 2026 07:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1789743009; x=1790347809; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z+PbvTl7j6crAVqwwSi1N6wOs6bBuNm88XPaAXlYwG4=;
        b=eaAruMPiqNCETlndUIMEsTI8wwe4IyMYRp7IY+Jq1Pz5C6glptp6M48r3gAtXl3R3o
         o0mk+4/fYf/RyVbjMLlqirV3r0k7aLq8D3SJBS9TnmTyroJxI1lWFXcCmVmMQh49977z
         6BQCEXpuZs7auPVq7cO2mxTj47CQGQVRNaycwaX/MxEuIHuS5LluhN/YiJkMHk4Mwv2V
         o7U9rfACfUocBZcnkxbCCUpznnuADY5zCOTAOYF19t0uxRlYXEoRTgNXQZgU5edp5tMF
         Ls0N2NnNmCjfe2UterERkyBV/iPZwAwtdi7ArbkvvGykip2Bk11CMa7dpDOgmU7PrcuI
         bjfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789743009; x=1790347809;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z+PbvTl7j6crAVqwwSi1N6wOs6bBuNm88XPaAXlYwG4=;
        b=lue8a6ZPPIMaPmud8ci7C/XqbonYOcv0eMOYjUJV8a9GVpYAD2NnryB7EvZOkMQQfG
         h7QYGIuug7pgsM/IUDIFDB62jkXITK7ZayJNZ5Bb1yGpc3o0N7xtUrcr9UQLX/e00QRg
         PdES4ZBJxu3atNaeTra0dMY5+KaPYNcp3ljU1iydxjAm7OndoVcXsI4+63uKbCfhHyUA
         wc4atv9oADHONXy2OvA3zbfc2QD3QA5Ydd4KPbofv2iRlNMKhg5d+EZ47upzqjdg7aCB
         GE8upT0UX4NbPfYUa4fs9RNXaAvC7GBL5N44esPS/536O2HGaxH7IJ+FHcW6Dpq9IbPG
         ewcQ==
X-Forwarded-Encrypted: i=1; AKwUvByXN1/CyJeAza7qIBTgnlo9l0EXSuiAY10S7Uoa0+2fcf3sb9JCvKGTTlbOl+aQVpPZCO9H2qrJ2pjtMF5Yd2i/t8A=@vger.kernel.org
X-Gm-Message-State: AFuF++mV5Fa+aCAZE8//0ArWPC+frc/evhoaQtcAwX1gXqi+CPz0u1nE
	+8pHAjecybHbDGjfK8Q+9pnLgfaJwFt4Q1W5273KARguAwO7Nf2aBrNpujE7EQ9GA1s=
X-Gm-Gg: AYBFou1VlaI+dIEqtcBoDEJVSow1+0gLfPDX6VbfSy6DZBAV1FswtEcN1yfPct07jO0
	tZUnqPMEZ9nv5WpSaVEzAI90CoqxK9FT+1UBoWj+5xfV20S1w3SQ3vuLNHHZ7nUGW/p7/E58sat
	cEMguIEa6Fm+PbCvRlwKiXJFiAg7bSFgrmm2eK22bxSRdwNCIDn4RdcVwe1ZOLrw6hWcVmwMdnL
	USaplCVv6kbgSJ1cfyRYzXsqhwQwZvkzhPivhHT5ShiRolBv9xLWmBveddn52Z14kHL593koO2o
	AYDwbqZHPwva1WdFyxPdtrMuelAQE54XERewDeahLZeB53OuEUVhhq1R4fXQTznAiQWG7jJmn/a
	agYJxLF+PQLUx1wK4ZIZ52/JrOlwcXwnvgj6B1fGSDD3dWRLinHc2wMlNKHo6WbUVBr7J50nP3p
	FVfA1zz1yENmkNmQO2BQcXc7t6lBf8Era/lKxqWP6VJtvNS3DucGcKDqM19ZoCFi5SuIVtC7Vf5
	IHOkqFQuhw7gyfk2W8XbWQ+m9VCO1+rlCbNSKyp9bgz6sVlesLwchTZ9Q==
X-Received: by 2002:a05:6214:ca6:b0:912:3d05:eb11 with SMTP id 6a1803df08f44-91254e4feadmr40041586d6.5.1789743008667;
        Fri, 18 Sep 2026 07:50:08 -0700 (PDT)
Received: from toxicpanda.com (ec2-34-228-114-98.compute-1.amazonaws.com. [34.228.114.98])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9125802d79bsm13900886d6.24.2026.09.18.07.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 07:50:06 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Fri, 18 Sep 2026 14:49:31 +0000
Subject: [PATCH RFC v4 12/13] rcu-tasks-trace: Assert no reader is held on
 return to userspace
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-b4-rcu-tasks-preempt-qs-v4-12-63f0e9d69661@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1789742980; l=2581;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=FRa7j81kn+FZifN+tU/RXt2NlHMQaOXWqjJvWoyULIE=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QAsi6H715Q7GMOS9YXNtKesBwx2lesjeCIIWVvPLg8W7bMTSPfSKqF2zG8KnHJqpv18BR10X5Rc
 7g2eq40cmPAk=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

With trampolines now taking rcu_read_lock_trace() open-coded from
assembly and JIT-emitted code, an unbalanced reader would silently
turn every later Tasks Trace grace period on that task into a stall.
No task can legitimately reach userspace with current->trc_reader_nesting
non-zero, so under CONFIG_PROVE_RCU check it in the generic entry
code's return-to-user validation, next to the existing kmap and lockdep
assertions.  Compiles away otherwise.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/irq-entry-common.h | 2 ++
 include/linux/rcupdate_trace.h   | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/include/linux/irq-entry-common.h b/include/linux/irq-entry-common.h
index e19b41ee6b18..d42568a488a7 100644
--- a/include/linux/irq-entry-common.h
+++ b/include/linux/irq-entry-common.h
@@ -5,6 +5,7 @@
 #include <linux/context_tracking.h>
 #include <linux/hrtimer_rearm.h>
 #include <linux/kmsan.h>
+#include <linux/rcupdate_trace.h>
 #include <linux/rseq_entry.h>
 #include <linux/static_call_types.h>
 #include <linux/syscalls.h>
@@ -214,6 +215,7 @@ static __always_inline void __exit_to_user_mode_validate(void)
 {
 	/* Ensure that kernel state is sane for a return to userspace */
 	kmap_assert_nomap();
+	rcu_tasks_trace_assert_idle();
 	lockdep_assert_irqs_disabled();
 	lockdep_sys_exit();
 }
diff --git a/include/linux/rcupdate_trace.h b/include/linux/rcupdate_trace.h
index 273c59a03251..6034c6b19479 100644
--- a/include/linux/rcupdate_trace.h
+++ b/include/linux/rcupdate_trace.h
@@ -211,6 +211,12 @@ unsigned long rcu_tasks_trace_batches_completed(void);
 // Placeholders to enable stepwise transition.
 void __init rcu_tasks_trace_suppress_unused(void);
 
+/* A task must never reach userspace inside an rcu_read_lock_trace() reader. */
+static inline void rcu_tasks_trace_assert_idle(void)
+{
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && READ_ONCE(current->trc_reader_nesting));
+}
+
 #else
 static inline unsigned long rcu_tasks_trace_batches_completed(void) { return 0; }
 /*
@@ -220,6 +226,7 @@ static inline unsigned long rcu_tasks_trace_batches_completed(void) { return 0;
 static inline void call_rcu_tasks_trace(struct rcu_head *rhp, rcu_callback_t func) { BUG(); }
 static inline void rcu_read_lock_trace(void) { BUG(); }
 static inline void rcu_read_unlock_trace(void) { BUG(); }
+static inline void rcu_tasks_trace_assert_idle(void) { }
 #endif /* #ifdef CONFIG_TASKS_TRACE_RCU */
 
 DEFINE_LOCK_GUARD_0(rcu_tasks_trace,

-- 
2.55.0

