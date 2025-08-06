Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EDB29C323;
	Wed,  6 Aug 2025 18:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754505598; cv=none; b=rMdz7S6pS6ctRGRgmjuuHfs6qkSTqwBbe838vS8FNT85Eg4+7qL5nZC7jpkr5sX1LuT8D3dFuqFT4tWqDPzmepPT/S31h70Cqhj7f4ASLQ6Ap2L8+fKbCz1HiRF5QbGXmL63qOVkQP9cw8UfpD+pFe13R+Wp8YYh8R0VVfJLgy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754505598; c=relaxed/simple;
	bh=d7Bl7TrXyt0Q0yHObz/hELF1PyktgW5FCbNF4BH3SYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=orfiX0xHueevwPe70/5MSj+onmo3gjL3Wimn4hEg3Z8ajUSei22swwvg0qgcyy/efDLMxR1MUBpEX2e074xu7nfu26oe+rkI8ttA0mvzygJ6R4mmHqADXanqzGeClpAod0nXjOnPtgM62div54mP0VH1e0oOjfo55Tnc3QL13IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kvDuxsJh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvDuxsJh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF1E9C4CEE7;
	Wed,  6 Aug 2025 18:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754505597;
	bh=d7Bl7TrXyt0Q0yHObz/hELF1PyktgW5FCbNF4BH3SYY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=kvDuxsJhx+YOuzT/ECnUUh2JETA9Tpp69xhwKVcuReLpDEvV2sgstyP5iIuLzndYU
	 uV5GwlxidZWbr/FdDakTnm4kMfMddy6Xcq9swtIbURhoQJ7umN2R8i6dFIVCzPJ+aP
	 AE5Fnp7vPzGxhnb7uhPD8SIk+x84C5oWVnhXEdl3jxyUabmAgrGSQQqteqCFxgjge1
	 x/vNYz/FgXUDktAFroGO/XuRf3YT3+ay1GB5mEIzoq0FJUk7tGUcphGMly/W++Vzsg
	 +HleuIRebciuWJYDQuOGwjxUpBfF8rNxIOrNqVdNF3+s0V+9OOEt90ikSb2agviNyi
	 DD877AuvLfjOw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 63C1ACE0C35; Wed,  6 Aug 2025 11:39:57 -0700 (PDT)
Date: Wed, 6 Aug 2025 11:39:57 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Takaya Saeki <takayas@google.com>, Tom Zanussi <zanussi@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ian Rogers <irogers@google.com>, aahringo@redhat.com,
	Douglas Raillard <douglas.raillard@arm.com>
Subject: Re: [PATCH 1/7] tracing: Replace syscall RCU pointer assignment with
 READ/WRITE_ONCE()
Message-ID: <e7d9ecb7-8bdb-4c91-b727-375a2c5a190e@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250805192646.328291790@kernel.org>
 <20250805193234.745705874@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805193234.745705874@kernel.org>

On Tue, Aug 05, 2025 at 03:26:47PM -0400, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> The syscall events are pseudo events that hook to the raw syscalls. The
> ftrace_syscall_enter/exit() callback is called by the raw_syscall
> enter/exit tracepoints respectively whenever any of the syscall events are
> enabled.
> 
> The trace_array has an array of syscall "files" that correspond to the
> system calls based on their __NR_SYSCALL number. The array is read and if
> there's a pointer to a trace_event_file then it is considered enabled and
> if it is NULL that syscall event is considered disabled.
> 
> Currently it uses an rcu_dereference_sched() to get this pointer and a
> rcu_assign_ptr() or RCU_INIT_POINTER() to write to it. This is unnecessary
> as the file pointer will not go away outside the synchronization of the
> tracepoint logic itself. And this code adds no extra RCU synchronization
> that uses this.
> 
> Replace these functions with a simple READ_ONCE() and WRITE_ONCE() which
> is all they need. This will also allow this code to not depend on
> preemption being disabled as system call tracepoints are now allowed to
> fault.
> 
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

From an RCU-removal viewpoint:

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

But is it possible to give some sort of warning just in case some creative
future developer figures out how to make the file pointer go away outside
of the synchronization of the tracepoint logic itself?

							Thanx, Paul

> ---
>  kernel/trace/trace_syscalls.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
> index 46aab0ab9350..3a0b65f89130 100644
> --- a/kernel/trace/trace_syscalls.c
> +++ b/kernel/trace/trace_syscalls.c
> @@ -310,8 +310,7 @@ static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
>  	if (syscall_nr < 0 || syscall_nr >= NR_syscalls)
>  		return;
>  
> -	/* Here we're inside tp handler's rcu_read_lock_sched (__DO_TRACE) */
> -	trace_file = rcu_dereference_sched(tr->enter_syscall_files[syscall_nr]);
> +	trace_file = READ_ONCE(tr->enter_syscall_files[syscall_nr]);
>  	if (!trace_file)
>  		return;
>  
> @@ -356,8 +355,7 @@ static void ftrace_syscall_exit(void *data, struct pt_regs *regs, long ret)
>  	if (syscall_nr < 0 || syscall_nr >= NR_syscalls)
>  		return;
>  
> -	/* Here we're inside tp handler's rcu_read_lock_sched (__DO_TRACE()) */
> -	trace_file = rcu_dereference_sched(tr->exit_syscall_files[syscall_nr]);
> +	trace_file = READ_ONCE(tr->exit_syscall_files[syscall_nr]);
>  	if (!trace_file)
>  		return;
>  
> @@ -393,7 +391,7 @@ static int reg_event_syscall_enter(struct trace_event_file *file,
>  	if (!tr->sys_refcount_enter)
>  		ret = register_trace_sys_enter(ftrace_syscall_enter, tr);
>  	if (!ret) {
> -		rcu_assign_pointer(tr->enter_syscall_files[num], file);
> +		WRITE_ONCE(tr->enter_syscall_files[num], file);
>  		tr->sys_refcount_enter++;
>  	}
>  	mutex_unlock(&syscall_trace_lock);
> @@ -411,7 +409,7 @@ static void unreg_event_syscall_enter(struct trace_event_file *file,
>  		return;
>  	mutex_lock(&syscall_trace_lock);
>  	tr->sys_refcount_enter--;
> -	RCU_INIT_POINTER(tr->enter_syscall_files[num], NULL);
> +	WRITE_ONCE(tr->enter_syscall_files[num], NULL);
>  	if (!tr->sys_refcount_enter)
>  		unregister_trace_sys_enter(ftrace_syscall_enter, tr);
>  	mutex_unlock(&syscall_trace_lock);
> @@ -431,7 +429,7 @@ static int reg_event_syscall_exit(struct trace_event_file *file,
>  	if (!tr->sys_refcount_exit)
>  		ret = register_trace_sys_exit(ftrace_syscall_exit, tr);
>  	if (!ret) {
> -		rcu_assign_pointer(tr->exit_syscall_files[num], file);
> +		WRITE_ONCE(tr->exit_syscall_files[num], file);
>  		tr->sys_refcount_exit++;
>  	}
>  	mutex_unlock(&syscall_trace_lock);
> @@ -449,7 +447,7 @@ static void unreg_event_syscall_exit(struct trace_event_file *file,
>  		return;
>  	mutex_lock(&syscall_trace_lock);
>  	tr->sys_refcount_exit--;
> -	RCU_INIT_POINTER(tr->exit_syscall_files[num], NULL);
> +	WRITE_ONCE(tr->exit_syscall_files[num], NULL);
>  	if (!tr->sys_refcount_exit)
>  		unregister_trace_sys_exit(ftrace_syscall_exit, tr);
>  	mutex_unlock(&syscall_trace_lock);
> -- 
> 2.47.2
> 
> 
