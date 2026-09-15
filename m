Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14604A483C
	for <linux-trace-kernel@vger.kernel.org>; Tue, 15 Sep 2026 13:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789478297; cv=none; b=oNASqiHpGTZRted2TA8/HyPG8+ggJVpATM/EmROilS3PPEob12k4BFar+sxt8cPSaKthojiT2fSFSTbd0A6NO0p5/R5amJrCdb8+9OcxgB+w9/Ov2pIkRAgPDyopOvlQJx6UiO3KLTxrgz14S6XEtxnSsJY8UUl2/M/yaCrgrxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789478297; c=relaxed/simple;
	bh=R9t47tbzDpBlKabnqSyLf9h+YtCy+mgQn2kYE1SNKlg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TlOjE1T7X4c9N7GJlGFyiwhmjXDypaOqI/ZnVfI++c2URndZrFvfCfGoppwl06Z6/qYbDvfGfxEIX39AlrkCd3hTZ8fY3H5cL1CmzKerX8w6HBaya8bv7QX+5ayOyMIZsID8yKyWEB+2PVXG9ZViXiNirjf4ofnJCtngdFdYmLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=kFiJqUSa; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="kFiJqUSa"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-52fb767cc7fso1726311cf.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 15 Sep 2026 06:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1789478293; x=1790083093; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dyunHw12Wk9XaltfwN7bGL3PCRgKnyr3LfmugMg8Gj0=;
        b=kFiJqUSaNikHJYMEPzTggnxBXpK7rMLLDNVTmH1cC8JJgb50CIn5TUSeyjhJ1sVxbQ
         HlljZCvMm+WAQnYp/kmz7GlfD6ldCHEHR8bR4cXdw2m68qnh9Dh+am+IbmjhFXNGBy45
         /z904sk2ET0G3cHwElQ9qgld2s0lHe3024NR1ChhyMYhEP5iDaUAgmPYO9RonbnyvK3Z
         FEN7dy+GKhQyPFRQphHubVi0XlNm9KSUBpf654zm5kdWKHuRvC1El5gA66hfbYNf9OFm
         4dC1d7wCKm2msW5gsFkYkt5npCQ1lbQnQVD44iKvLoytjd4CSv1dn5I1zdxZKymWBd+P
         h/XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789478293; x=1790083093;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dyunHw12Wk9XaltfwN7bGL3PCRgKnyr3LfmugMg8Gj0=;
        b=btXc2XJo3qdYBsSo8bBKkEgXfdoesRFJ9fB1vUiSeEI0irptE/ixgTfmFa4WfH6YtZ
         vWENXQYYPXKFe7GmkjYHc/B3VA3PBzIEkWQifrL19+sCY4qEykuJP/HIJ77/1Jx7FI24
         FrZSEghk7TacBc63tg8VG5DFs5nT4IkeSA51Zhy//97bJoEvqhPGinjD6/9zZWJkWZXv
         eqhkJQQ1v0NvdPAeeFRk6tARJtkTBMz+rpOFS5cHMmta1oZbZIM0yTV4EFy+gTQnSILh
         74oimtI8UvbrMcU7t/usRYDPwJu8aWhNgGJK1Ec+xrTy/kRhnej9oKCUkQlvlBUlLCnf
         uHuw==
X-Forwarded-Encrypted: i=1; AKwUvByfo+ze/h++FR9PwHuApb/QpD82n79yjJVUUpec4Q081Ql25LY0ykMbBFuZ5cWcweIM2I6dAjaEdT45RoAvCTEaDBM=@vger.kernel.org
X-Gm-Message-State: AFuF++nAMt/AHVbvxiaqlS6y7g3MMBRYvoe8GlJ1+DmtjXQAQpld1agU
	BAAXM1pdfkVcZy1JV960HnIcweQGwVTRmXYn2YLPfzAs+LDksvU0sdmsfoA4mgTvnws=
X-Gm-Gg: AYBFou3ZrgIHcQUHFJm63QhVBHSNZjL0dBhruOK+BS/kgUQ8LAP1ehoRQpsUeNZmd+y
	u6pOafkMqUixIv6pWxhwKSBL+NzjSPRgL/228rezUthQvFheT15mnFh3LNL9QknNkrfTt6u/TAI
	xYhEij7ikRFi073x1qhrDRtmG4weA1Yor80myV3XeEPbQCbMh7DIuH1WOwfUA/xKfYlDlmjXvCD
	HynlOtpDWBrHT797mFzXLHSD14iVI+Rx3vYt+39sb5hEntniEPJqIxFMJxOkUaH+nS/vVt+yswh
	k76ZqTS6yT0v8AjKUXvk74Jqes010riAmF3hBdaoLLhd8hfDcCv7iX03RfIlClasZnoabvtpIPo
	Fa51dRC+/mlyiY0k2YYSOSHXYM9VFJtY48YeJvdBhRRLi5GVT+gzvG/io+k1gSj7YZnv1SImh2a
	z6iuzUvggKldEUB27QcxugDfqEVj9j+QFIY8JEjg9v1QNng6ksyc8pPrW8jXHnhbMUghA+q7Vdv
	vvuqAg8LJ15UOlzSx29h3/ZnoD50I+rrBf3PkR9XZlMc0Xq7yr+n1wg
X-Received: by 2002:ad4:594b:0:b0:910:4c56:76d8 with SMTP id 6a1803df08f44-9123a42ec8fmr14508336d6.1.1789478292499;
        Tue, 15 Sep 2026 06:18:12 -0700 (PDT)
Received: from toxicpanda.com (ec2-34-228-114-98.compute-1.amazonaws.com. [34.228.114.98])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f45cb06sm120943296d6.11.2026.09.15.06.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 06:18:11 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 15 Sep 2026 13:17:40 +0000
Subject: [PATCH RFC v3 13/13] x86, arm64: Build Tasks RCU on Tasks Trace
 readers in trampolines
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-b4-rcu-tasks-preempt-qs-v3-13-0ad30c4c5ee7@toxicpanda.com>
References: <20260915-b4-rcu-tasks-preempt-qs-v3-0-0ad30c4c5ee7@toxicpanda.com>
In-Reply-To: <20260915-b4-rcu-tasks-preempt-qs-v3-0-0ad30c4c5ee7@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1789478262; l=5993;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=R9t47tbzDpBlKabnqSyLf9h+YtCy+mgQn2kYE1SNKlg=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QLrYYFTmT4yc2HnPNOm135tMG3u8qPYsi+9GRPNIPdwz0QfAjvOD+lsxTwptmj0sG65nDpJ4ULX
 TbSFHTaStyQI=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

With the preceding patches every trampoline whose lifetime Tasks RCU
guards on x86-64 and arm64 -- ftrace_caller and its copies, the optprobe
template, BPF trampolines via their glue, and the sample direct-call
trampolines -- is a Tasks Trace RCU reader around its call-out, and the
text outside that reader is known to rcu_tasks_trampoline_text().
Select HAVE_RCU_TRAMPOLINE_READERS on both (x86-64 with SMP for Tree
SRCU and DYNAMIC_FTRACE, which is where its ftrace_caller changes and
arch_rcu_tasks_trampoline_text() live; arm64 with
DYNAMIC_FTRACE_WITH_ARGS likewise), which switches CONFIG_TASKS_RCU to the
implementation added earlier in the series: a Tasks RCU grace period
becomes a per-CPU pass over context switches and irq-exit reschedules
outside trampoline text plus a Tasks Trace grace period, bounded by a
few jiffies and preempt-off latency instead of by the longest stretch
any task runs without sleeping.

Other architectures keep the classic implementation.  Update
Documentation/RCU and the FORCE_TASKS_RCU help text to describe the
variant and the obligation it places on trampolines.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 .../RCU/Design/Requirements/Requirements.rst         | 20 ++++++++++++++++++++
 Documentation/RCU/checklist.rst                      |  7 ++++++-
 arch/arm64/Kconfig                                   |  1 +
 arch/x86/Kconfig                                     |  1 +
 kernel/rcu/Kconfig                                   |  6 ++++--
 5 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index 8101fe6229d5..34b81512cc5f 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -2756,6 +2756,26 @@ synchronize_rcu(), and rcu_barrier(), respectively. In
 three APIs are therefore implemented by separate functions that check
 for voluntary context switches.
 
+Architectures that select ``CONFIG_HAVE_RCU_TRAMPOLINE_READERS`` keep the
+same three APIs but implement the grace period differently
+(``CONFIG_TASKS_RCU_TRAMPOLINE_READERS``).  There, every trampoline whose
+lifetime Tasks RCU guards enters a Tasks Trace RCU read-side critical
+section (rcu_read_lock_trace() or its assembly equivalent) before calling
+out and leaves it before returning, so a task anywhere inside such a
+call-out is an ordinary Tasks Trace reader whether or not it is
+preempted.  The few trampoline instructions outside that reader can only
+be occupied by a task that was interrupted there, so the grace period
+additionally waits for each CPU to pass through a context switch, and the
+irq-exit preemption path, the only switch that can catch a task inside
+such text (rcu_tasks_trampoline_text()), briefly makes such a task a
+holdout until it is next seen elsewhere.  On such kernels an involuntary
+context switch outside trampoline text *is* a Tasks-RCU quiescent state,
+a Tasks RCU grace period no longer depends on how long any task runs
+without sleeping, cond_resched_tasks_rcu_qs() is unnecessary, and the
+obligation moves to the trampolines: anything that relies on
+synchronize_rcu_tasks() to protect code a task may be preempted in must
+take the Tasks Trace reader (see register_ftrace_direct()).
+
 Tasks Rude RCU
 ~~~~~~~~~~~~~~
 
diff --git a/Documentation/RCU/checklist.rst b/Documentation/RCU/checklist.rst
index 4b30f701225f..7082686cbd66 100644
--- a/Documentation/RCU/checklist.rst
+++ b/Documentation/RCU/checklist.rst
@@ -252,7 +252,12 @@ over a rather long period of time, but improvements are always welcome!
 	a.	If the updater uses synchronize_rcu_tasks() or
 		call_rcu_tasks(), then the readers must refrain from
 		executing voluntary context switches, that is, from
-		blocking.
+		blocking.  On architectures that select
+		CONFIG_HAVE_RCU_TRAMPOLINE_READERS a reader must in
+		addition be a Tasks Trace RCU reader (that is what the
+		trampolines there do around their call-outs); an
+		arbitrary stretch of preemptible kernel code is not
+		protected.
 
 	b.	If the updater uses call_rcu_tasks_trace()
 		or synchronize_rcu_tasks_trace(), then the
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b5a51b0ef944..bf0e56006863 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -218,6 +218,7 @@ config ARM64
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_PREEMPT_DYNAMIC_KEY
+	select HAVE_RCU_TRAMPOLINE_READERS if DYNAMIC_FTRACE_WITH_ARGS
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RELIABLE_STACKTRACE
 	select HAVE_POSIX_CPU_TIMERS_TASK_WORK
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 15fd9ec5ecac..64c3814eb745 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -288,6 +288,7 @@ config X86
 	select MMU_GATHER_RCU_TABLE_FREE
 	select MMU_GATHER_MERGE_VMAS
 	select HAVE_POSIX_CPU_TIMERS_TASK_WORK
+	select HAVE_RCU_TRAMPOLINE_READERS	if X86_64 && SMP && DYNAMIC_FTRACE
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RELIABLE_STACKTRACE		if UNWINDER_ORC || STACK_VALIDATION
 	select HAVE_FUNCTION_ARG_ACCESS_API
diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index bbab14bc14c3..341b68b972ef 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -95,8 +95,10 @@ config FORCE_TASKS_RCU
 	help
 	  This option force-enables a task-based RCU implementation
 	  that uses only voluntary context switch (not preemption!),
-	  idle, and user-mode execution as quiescent states.  Not for
-	  manual selection in most cases.
+	  idle, and user-mode execution as quiescent states, or, on
+	  HAVE_RCU_TRAMPOLINE_READERS architectures, the variant built on
+	  Tasks Trace RCU readers in trampolines.  Not for manual
+	  selection in most cases.
 
 config NEED_TASKS_RCU
 	bool

-- 
2.55.0

