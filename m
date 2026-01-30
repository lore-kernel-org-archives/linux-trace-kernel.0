Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D09E35295C;
	Fri, 30 Jan 2026 20:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769806537; cv=none; b=OTsh19f6ys8bKcjhLF3ubgW/FsSxjmuuO0u/BNug0mD9z9ioTkbZIgYWZ3ZxVxxcWQ68QgYjJQhQAcbCUZzJ+EpTtUqkvNiwjGC1gqyEvcWcsQ9Cf622rxPAKfXqfFgboEiMB2UYjMLgZGBBqQG4UtWkC32Pwz/l441LqQo/1KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769806537; c=relaxed/simple;
	bh=ym3dGwIHs7oBNY9RM6bdKmF+Ba1dotlMSYD1eulS7n0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BNOSDkBg8OoMY0M2lc+qmOj8rC0sdLX1D/eQtcE8ff9Jg+lXd2OGloLweyKRp8FFHU4eJPbItEKSejCo7BwIbS3Q/lngX5AWJq4rUlj3nMA5kiMynzdbfqhkzRpTnknhuG58hvdgN8Tm+nZ6VGGCHq9bz3p9t+vNvPYh8efsNX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 3EACC1A06DA;
	Fri, 30 Jan 2026 20:55:34 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id 73CAE2002F;
	Fri, 30 Jan 2026 20:55:32 +0000 (UTC)
Date: Fri, 30 Jan 2026 15:55:48 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "jempty.liang" <imntjempty@163.com>
Cc: mhiramat@kernel.org, mark.rutland@arm.com,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Fix duration calculation bug (rettime -
 calltime) on ARM architecture
Message-ID: <20260130155548.0673f1f3@gandalf.local.home>
In-Reply-To: <20260130015740.212343-1-imntjempty@163.com>
References: <20260130015740.212343-1-imntjempty@163.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: rz4wgspybq3eceezca5xc7h59xgpsitn
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 73CAE2002F
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+FdbNVPqOG8hW28BcDwVl85zjKk9T1cSI=
X-HE-Tag: 1769806532-918560
X-HE-Meta: U2FsdGVkX18UbhGXsZv1YeZ3nHz2HL9fiJd8fcLqkCDdHpXVm5p0ImnHSXInaV20qtNhBJtdbO006vWUDvWD5eC2h5cBs2NFWTDM5NHKe3r36CPZM87TyXEpXTmqnVF0vX3qO0JAFVgGbtsvXo7uTdPlhXjJg8Hh+FniVzqiJ9fecwleaqfp+RiHeGYuNJNHi7FSwDgjpUvUhfAAVRKE0BS0SGVHY50UvAgqNVf5NIRK1j5YntzzDtywwygltzvJHPLmNbzZzjcVCcnZWPehGLsyX1OLBFJoAT/8F3IrfuKyKX2Zo9V82LHKSC4/+JZlS46JGKJC+brcQ1uroA1unMbw/zLY3Tp6

On Fri, 30 Jan 2026 01:57:40 +0000
"jempty.liang" <imntjempty@163.com> wrote:

> This issue is reproducible on the QEMU vexpress-a9 platform with the
> following steps:
> 
> Step 1: Launch the QEMU vexpress-a9 VM

How is this unique to arm? I'm not able to duplicate this on x86, but the
code here is all generic code. What's different?

> 
> ~# qemu-system-arm -M vexpress-a9 -smp 1 -m 256 -kernel zImage -dtb \
> 	vexpress-v2p-ca9.dtb -drive file=rootfs.ext2,if=sd,format=raw \
> 	-append "console=ttyAMA0,115200 rootwait" -net nic,model=lan9118 \
> 	-net user -serial stdio
> 
> Step 2: Capture and view the trace with trace-cmd
> 
> ~# trace-cmd record -p function_graph -g do_open_execat \
> 	--max-graph-depth 1 dd if=/dev/zero of=/tmp/1.bin \
> 	bs=1M count=1
> ~# trace-cmd report

Note, you are using trace-cmd that records the raw data directly thus some
of the updates to the prints below wouldn't affect this.

> 
> Step 3: Observed behavior
> 
> Before:
> 
> dd-89 ... 5.764026: funcgraph_entry:   $ 2757369004 us |  do_open_execat()
> dd-89 ... 5.765222: funcgraph_entry:   $ 2034790547 us |  do_open_execat();
> 
> After:
> 
> dd-91 ... 891.945577: funcgraph_entry:   ! 185.542 us |  do_open_execat();
> dd-91 ... 891.946840: funcgraph_entry:   + 98.625 us  |  do_open_execat();

You show what the wrong output is and the correct output, but you don't
mention what was the bug and how this fixes it. From the change log, it
looks like you just tried something and it worked, but do not know why it
worked.

I'd like to know what the bug was and how this fixes it. It's not obvious.

> 
> Signed-off-by: jempty.liang <imntjempty@163.com>
> ---
>  include/linux/ftrace.h               |  2 ++
>  kernel/trace/trace_entries.h         |  8 ++++----
>  kernel/trace/trace_functions_graph.c | 19 +++++++++----------
>  3 files changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index a3a8989e3268..52727a342273 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -1191,6 +1191,8 @@ struct ftrace_graph_ret {
>  	int depth;
>  	/* Number of functions that overran the depth limit for current task */
>  	unsigned int overrun;
> +	unsigned long long calltime;
> +	unsigned long long rettime;
>  } __packed;
>  
>  struct fgraph_ops;
> diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
> index f6a8d29c0d76..362a757e65a2 100644
> --- a/kernel/trace/trace_entries.h
> +++ b/kernel/trace/trace_entries.h
> @@ -127,8 +127,8 @@ FTRACE_ENTRY_PACKED(funcgraph_exit, ftrace_graph_ret_entry,
>  		__field_packed(	unsigned long,	ret,		retval	)
>  		__field_packed(	unsigned int,	ret,		depth	)
>  		__field_packed(	unsigned int,	ret,		overrun	)
> -		__field(unsigned long long,	calltime		)
> -		__field(unsigned long long,	rettime			)
> +		__field_packed(unsigned long long,	ret,	calltime)
> +		__field_packed(unsigned long long,	ret,	rettime)
>  	),
>  
>  	F_printk("<-- %ps (%u) (start: %llx  end: %llx) over: %u retval: %lx",
> @@ -149,8 +149,8 @@ FTRACE_ENTRY_PACKED(funcgraph_exit, ftrace_graph_ret_entry,
>  		__field_packed(	unsigned long,	ret,		func	)
>  		__field_packed(	unsigned int,	ret,		depth	)
>  		__field_packed(	unsigned int,	ret,		overrun	)
> -		__field(unsigned long long,	calltime		)
> -		__field(unsigned long long,	rettime			)
> +		__field_packed(unsigned long long,	ret,	calltime)
> +		__field_packed(unsigned long long,	ret,	rettime)
>  	),
>  
>  	F_printk("<-- %ps (%u) (start: %llx  end: %llx) over: %u",
> diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
> index 1de6f1573621..5798aeb31f05 100644
> --- a/kernel/trace/trace_functions_graph.c
> +++ b/kernel/trace/trace_functions_graph.c
> @@ -317,6 +317,8 @@ __trace_graph_function(struct trace_array *tr,
>  	struct ftrace_graph_ret ret = {
>  		.func     = ip,
>  		.depth    = 0,
> +		.calltime = time,
> +		.rettime = time,

If you assign here, then you should change the line below this code.

>  	};
>  
>  	__trace_graph_entry(tr, &ent, trace_ctx);

The next line is this:

	__trace_graph_return(tr, &ret, trace_ctx, time, time);

Where that function has:

	entry->ret				= *trace;
	entry->ret.calltime				= calltime;
	entry->ret.rettime				= rettime;

That is, ret is assigned "*trace" which includes the calltime and rettime,
and now it's doing more work to override it with the current data?

> @@ -346,8 +348,8 @@ void __trace_graph_return(struct trace_array *tr,
>  		return;
>  	entry	= ring_buffer_event_data(event);
>  	entry->ret				= *trace;
> -	entry->calltime				= calltime;
> -	entry->rettime				= rettime;
> +	entry->ret.calltime				= calltime;
> +	entry->ret.rettime				= rettime;
>  	trace_buffer_unlock_commit_nostack(buffer, event);
>  }
>  
> @@ -372,10 +374,9 @@ void trace_graph_return(struct ftrace_graph_ret *trace,
>  	struct trace_array *tr = gops->private;
>  	struct fgraph_times *ftimes;
>  	unsigned int trace_ctx;
> -	u64 calltime, rettime;
>  	int size;
>  
> -	rettime = trace_clock_local();
> +	trace->rettime = trace_clock_local();
>  
>  	ftrace_graph_addr_finish(gops, trace);
>  
> @@ -390,10 +391,10 @@ void trace_graph_return(struct ftrace_graph_ret *trace,
>  
>  	handle_nosleeptime(tr, trace, ftimes, size);
>  
> -	calltime = ftimes->calltime;
> +	trace->calltime = ftimes->calltime;
>  
>  	trace_ctx = tracing_gen_ctx();
> -	__trace_graph_return(tr, trace, trace_ctx, calltime, rettime);
> +	__trace_graph_return(tr, trace, trace_ctx, trace->calltime, trace->rettime);

And here again, the passed in calltime and rettime is just being
overwritten.


>  }
>  
>  static void trace_graph_thresh_return(struct ftrace_graph_ret *trace,
> @@ -956,7 +957,7 @@ print_graph_entry_leaf(struct trace_iterator *iter,
>  
>  	graph_ret = &ret_entry->ret;
>  	call = &entry->graph_ent;
> -	duration = ret_entry->rettime - ret_entry->calltime;
> +	duration = graph_ret->rettime - graph_ret->calltime;
>  
>  	if (data) {
>  		struct fgraph_cpu_data *cpu_data;
> @@ -1280,9 +1281,7 @@ print_graph_return(struct ftrace_graph_ret_entry *retentry, struct trace_seq *s,
>  		   u32 flags)
>  {
>  	struct ftrace_graph_ret *trace = &retentry->ret;
> -	u64 calltime = retentry->calltime;
> -	u64 rettime = retentry->rettime;
> -	unsigned long long duration = rettime - calltime;
> +	unsigned long long duration = trace->rettime - trace->calltime;
>  	struct fgraph_data *data = iter->private;
>  	struct trace_array *tr = iter->tr;
>  	unsigned long func;

Now moving rettime and calltime into ftrace_graph_ret may be a nice
cleanup, but you are saying this is a fix. What was the bug, and what did
this fix?

-- Steve
