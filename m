Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515C330FC3D;
	Tue, 23 Sep 2025 13:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758632754; cv=none; b=uHIvn16HKbJRzVCqdyWYfBFHGAyF7ArfWRZA7UOG097NsP0O1aCz239dbGIC8wuL3E33EpUVVO0K4uoW9cZB5tisfVmeFY78SbIH5h+BYi69sHDBvnL87mgQayg5gPsWxIKjDtOnDFfyvEllIf+uKgFvRDZAiXmMqtNXWBySuYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758632754; c=relaxed/simple;
	bh=txOR/egCsh57GZfAXHNisq1KB0ET6MZ/gLsLbqj4Ck8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=q5xcEcdC4wdPwxcN3duaV7epfsPWXUcIGvIjQTvHZfKD1ANrIiB2Gv8jRTnuCwcLRTRxOGp5zIRHzpwhfHQcq1WWuD3x/qkezTFAUGqAl1Rsg/Er7vbGd0fCd/bnRX3LsGFjIiUZc7+8CibGmjcCRlv7AOMMV8mXn1H6+n0Bv5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PgFpVxRi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PgFpVxRi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF462C113D0;
	Tue, 23 Sep 2025 13:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758632754;
	bh=txOR/egCsh57GZfAXHNisq1KB0ET6MZ/gLsLbqj4Ck8=;
	h=Date:From:To:Cc:Subject:References:From;
	b=PgFpVxRi5gnK2KZLq4QbtEGvm1eef3QblRmJFbLDKsCmc7By/OO9uoSr+nBEdvWRz
	 PFN60eyzvhTJmdf1QyxEVuyvkVzVSE7PV8cRumuuWiQsfxQ2DBbEGmE3c+Fg5R+Mym
	 8qDWF9geibUR7nyahBd6dC1nE5TsCwtwIAF44m1WExE9Vt3AOFDgE9vNSA6KeFdovn
	 +nk4h3W6f0FwaaubKg9lCvubjb79cOlzo98URNsWhUnQcwCKur4N+T0iAtAvfgzVwD
	 mKFj6DtlBMoa+SzBHzm6fir4XYwr4BRshQz1+7NKr7BPqUpxmyu4+P3xVTYuD37MBb
	 C03iwcMHPmWFA==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1v12jh-0000000Cop9-37nB;
	Tue, 23 Sep 2025 09:07:13 -0400
Message-ID: <20250923130713.594320290@kernel.org>
User-Agent: quilt/0.68
Date: Tue, 23 Sep 2025 09:04:58 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Takaya Saeki <takayas@google.com>,
 Tom Zanussi <zanussi@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Ian Rogers <irogers@google.com>,
 Douglas Raillard <douglas.raillard@arm.com>,
 "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 1/8] tracing: Replace syscall RCU pointer assignment with
 READ/WRITE_ONCE()
References: <20250923130457.901085554@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The syscall events are pseudo events that hook to the raw syscalls. The
ftrace_syscall_enter/exit() callback is called by the raw_syscall
enter/exit tracepoints respectively whenever any of the syscall events are
enabled.

The trace_array has an array of syscall "files" that correspond to the
system calls based on their __NR_SYSCALL number. The array is read and if
there's a pointer to a trace_event_file then it is considered enabled and
if it is NULL that syscall event is considered disabled.

Currently it uses an rcu_dereference_sched() to get this pointer and a
rcu_assign_ptr() or RCU_INIT_POINTER() to write to it. This is unnecessary
as the file pointer will not go away outside the synchronization of the
tracepoint logic itself. And this code adds no extra RCU synchronization
that uses this.

Replace these functions with a simple READ_ONCE() and WRITE_ONCE() which
is all they need. This will also allow this code to not depend on
preemption being disabled as system call tracepoints are now allowed to
fault.

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://lore.kernel.org/20250805193234.745705874@kernel.org

- Removed __rcu annotation to the fields that do not need RCU to protect
  them.

 kernel/trace/trace.h          |  4 ++--
 kernel/trace/trace_syscalls.c | 14 ++++++--------
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 5f4bed5842f9..85eabb454bee 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -380,8 +380,8 @@ struct trace_array {
 #ifdef CONFIG_FTRACE_SYSCALLS
 	int			sys_refcount_enter;
 	int			sys_refcount_exit;
-	struct trace_event_file __rcu *enter_syscall_files[NR_syscalls];
-	struct trace_event_file __rcu *exit_syscall_files[NR_syscalls];
+	struct trace_event_file	*enter_syscall_files[NR_syscalls];
+	struct trace_event_file	*exit_syscall_files[NR_syscalls];
 #endif
 	int			stop_count;
 	int			clock_id;
diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index 46aab0ab9350..3a0b65f89130 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -310,8 +310,7 @@ static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
 	if (syscall_nr < 0 || syscall_nr >= NR_syscalls)
 		return;
 
-	/* Here we're inside tp handler's rcu_read_lock_sched (__DO_TRACE) */
-	trace_file = rcu_dereference_sched(tr->enter_syscall_files[syscall_nr]);
+	trace_file = READ_ONCE(tr->enter_syscall_files[syscall_nr]);
 	if (!trace_file)
 		return;
 
@@ -356,8 +355,7 @@ static void ftrace_syscall_exit(void *data, struct pt_regs *regs, long ret)
 	if (syscall_nr < 0 || syscall_nr >= NR_syscalls)
 		return;
 
-	/* Here we're inside tp handler's rcu_read_lock_sched (__DO_TRACE()) */
-	trace_file = rcu_dereference_sched(tr->exit_syscall_files[syscall_nr]);
+	trace_file = READ_ONCE(tr->exit_syscall_files[syscall_nr]);
 	if (!trace_file)
 		return;
 
@@ -393,7 +391,7 @@ static int reg_event_syscall_enter(struct trace_event_file *file,
 	if (!tr->sys_refcount_enter)
 		ret = register_trace_sys_enter(ftrace_syscall_enter, tr);
 	if (!ret) {
-		rcu_assign_pointer(tr->enter_syscall_files[num], file);
+		WRITE_ONCE(tr->enter_syscall_files[num], file);
 		tr->sys_refcount_enter++;
 	}
 	mutex_unlock(&syscall_trace_lock);
@@ -411,7 +409,7 @@ static void unreg_event_syscall_enter(struct trace_event_file *file,
 		return;
 	mutex_lock(&syscall_trace_lock);
 	tr->sys_refcount_enter--;
-	RCU_INIT_POINTER(tr->enter_syscall_files[num], NULL);
+	WRITE_ONCE(tr->enter_syscall_files[num], NULL);
 	if (!tr->sys_refcount_enter)
 		unregister_trace_sys_enter(ftrace_syscall_enter, tr);
 	mutex_unlock(&syscall_trace_lock);
@@ -431,7 +429,7 @@ static int reg_event_syscall_exit(struct trace_event_file *file,
 	if (!tr->sys_refcount_exit)
 		ret = register_trace_sys_exit(ftrace_syscall_exit, tr);
 	if (!ret) {
-		rcu_assign_pointer(tr->exit_syscall_files[num], file);
+		WRITE_ONCE(tr->exit_syscall_files[num], file);
 		tr->sys_refcount_exit++;
 	}
 	mutex_unlock(&syscall_trace_lock);
@@ -449,7 +447,7 @@ static void unreg_event_syscall_exit(struct trace_event_file *file,
 		return;
 	mutex_lock(&syscall_trace_lock);
 	tr->sys_refcount_exit--;
-	RCU_INIT_POINTER(tr->exit_syscall_files[num], NULL);
+	WRITE_ONCE(tr->exit_syscall_files[num], NULL);
 	if (!tr->sys_refcount_exit)
 		unregister_trace_sys_exit(ftrace_syscall_exit, tr);
 	mutex_unlock(&syscall_trace_lock);
-- 
2.50.1


