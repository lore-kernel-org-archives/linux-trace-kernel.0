Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33EE86359;
	Tue,  5 Aug 2025 19:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754422324; cv=none; b=CDl5DGU+17Y8fAJwRpgJxYJYm5UpVlLcYG/bok8WujXTJk3DOJELl7xqqDoyrbLGykD4Cho6/j3yQnpgg5O8ORUzNSNoVr4FLWkHpeIvjwb2VjqHLnH7xuM7XGKeasRgMSVMGMFs0bq9rysovLqx4tGUCXarEKH3eyK59fkJlY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754422324; c=relaxed/simple;
	bh=4AkM51O9t52LV93GaMQqtuKxgvAUDqvsVEmRSOXpSvg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=CWYWEYLe0vYV8kNyeA3ngGDibEW4/7nIdJIb/aSmQQ920/m1TlnG9gPuBhxA9FTQOb6AakNYkcdEKH+dP7Q75bLzwuk0ivZryBFd0UsQtzedagqBJ/vn8iKqTvb3bJYINsJtpNEXj4eTxRS2ZF3yXawumyrQ/bwThcmay4HJIbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C7Jk1NyF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C7Jk1NyF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6671AC4CEF7;
	Tue,  5 Aug 2025 19:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754422324;
	bh=4AkM51O9t52LV93GaMQqtuKxgvAUDqvsVEmRSOXpSvg=;
	h=Date:From:To:Cc:Subject:References:From;
	b=C7Jk1NyFfntk4Lqdl1qvDd0rN+/erBotiPVR4LQKYxKVz9IzRe8ds1BoYfFG+5B2I
	 ONzFUQvVyQank3gwsK/U8olP0714xod7QTqc06NKxPCjrGjffmC9doHCCf2+qE3Aox
	 wHGbQUJDeZrn4a4lTnoZHXpZ1BNsuvA42znnl3gKzLKxlo9r39VncidgBRW+m+obqE
	 oZMPa4LUvrhVUaXwzceLpAXrTFVf7RqDysoqdv3hVYvrjnmttzJ22JWZaUhztEbore
	 eIQtxkLZWErscIvAzb7+Qj4XozvVND5g4TfD5N67McpIK1c8Qee/ZTJQH65exyM56J
	 yJIDP84B/n98w==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ujNOk-0000000AtCf-3l5S;
	Tue, 05 Aug 2025 15:32:34 -0400
Message-ID: <20250805193234.745705874@kernel.org>
User-Agent: quilt/0.68
Date: Tue, 05 Aug 2025 15:26:47 -0400
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
 aahringo@redhat.com,
 Douglas Raillard <douglas.raillard@arm.com>,
 "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 1/7] tracing: Replace syscall RCU pointer assignment with
 READ/WRITE_ONCE()
References: <20250805192646.328291790@kernel.org>
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

Cc: "Paul E. McKenney" <paulmck@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_syscalls.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

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
2.47.2


