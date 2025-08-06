Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B2F215F4A;
	Wed,  6 Aug 2025 10:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754477413; cv=none; b=HGMU4kaVlfvo13yHiA7L0OBYX4k6LgLPH3PfYUzhFsqwQfNXPI86ponoa5xhtQoRekgF0w9gteOUM1/jOTZQBf4P3yyxeR1DAw3d0qRDoFuFO22zNUAp5ZE+PK3C1YAVDfLpmixh6UH/OUJyfdbigo9zJRygIXTiI9CZKAr99pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754477413; c=relaxed/simple;
	bh=s5nc6+3RBi2PwtQ/t7YtmN8+ePC0BZ8DVwJjtwdtR6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WgN00BJfFWEUEDV0D2x6ePr5KvkIOTSkcmRkuUFBcx3Z6GsK1fawfuX6boBAxzwWwfBAURLqqwAUrhMxJi7l+MOcYOKZF9xL1R/gk53nB2zDDPQq9Ulwm0qk1cF+WfjV0ucAbx/eFxTSrk5tEhHziVMkJEWc2bbnta+tYgeINQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A99461E8D;
	Wed,  6 Aug 2025 03:50:02 -0700 (PDT)
Received: from [192.168.1.127] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5D7E13F738;
	Wed,  6 Aug 2025 03:50:07 -0700 (PDT)
Message-ID: <91cd9924-aaff-404a-8be7-79a6c7452a89@arm.com>
Date: Wed, 6 Aug 2025 11:50:06 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] tracing: Add syscall_user_buf_size to limit amount
 written
To: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Namhyung Kim <namhyung@kernel.org>,
 Takaya Saeki <takayas@google.com>, Tom Zanussi <zanussi@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ian Rogers <irogers@google.com>,
 aahringo@redhat.com
References: <20250805192646.328291790@kernel.org>
 <20250805193235.747004484@kernel.org>
Content-Language: en-US
From: Douglas Raillard <douglas.raillard@arm.com>
In-Reply-To: <20250805193235.747004484@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05-08-2025 20:26, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> When a system call that reads user space addresses copy it to the ring
> buffer, it can copy up to 511 bytes of data. This can waste precious ring
> buffer space if the user isn't interested in the output. Add a new file
> "syscall_user_buf_size" that gets initialized to a new config
> CONFIG_SYSCALL_BUF_SIZE_DEFAULT that defaults to 128.

Have you considered dynamically removing some event fields ? We routinely hit
the same problem with some of our events that have rarely-used large fields.

If we could have a "fields" file in /sys/kernel/tracing/events/*/*/fields
that allowed selecting what field is needed that would be amazing. I had plans
to build something like that in our kernel module based on the synthetic events API,
but did not proceed as that API is not exported in a useful way.

> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>   Documentation/trace/ftrace.rst |  7 +++++
>   kernel/trace/Kconfig           | 13 +++++++++
>   kernel/trace/trace.c           | 52 ++++++++++++++++++++++++++++++++++
>   kernel/trace/trace.h           |  3 ++
>   kernel/trace/trace_syscalls.c  | 22 ++++++++------
>   5 files changed, 88 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
> index af66a05e18cc..4712bbfcfd08 100644
> --- a/Documentation/trace/ftrace.rst
> +++ b/Documentation/trace/ftrace.rst
> @@ -366,6 +366,13 @@ of ftrace. Here is a list of some of the key files:
>   	for each function. The displayed address is the patch-site address
>   	and can differ from /proc/kallsyms address.
>   
> +  syscall_user_buf_size:
> +
> +	Some system call trace events will record the data from a user
> +	space address that one of the parameters point to. The amount of
> +	data per event is limited. This file holds the max number of bytes
> +	that will be recorded into the ring buffer to hold this data.
> +
>     dyn_ftrace_total_info:
>   
>   	This file is for debugging purposes. The number of functions that
> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index f80298e6aa16..aa28d7ca3e31 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -574,6 +574,19 @@ config FTRACE_SYSCALLS
>   	help
>   	  Basic tracer to catch the syscall entry and exit events.
>   
> +config TRACE_SYSCALL_BUF_SIZE_DEFAULT
> +	int "System call user read max size"
> +	range 0 128
> +	default 128
> +	depends on FTRACE_SYSCALLS
> +	help
> +	 Some system call trace events will record the data from a user
> +	 space address that one of the parameters point to. The amount of
> +	 data per event is limited. It may be further limited by this
> +	 config and later changed by writing an ASCII number into:
> +
> +	   /sys/kernel/tracing/syscall_user_buf_size
> +
>   config TRACER_SNAPSHOT
>   	bool "Create a snapshot trace buffer"
>   	select TRACER_MAX_TRACE
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index d0b1964648c1..1db708ed0625 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -6913,6 +6913,43 @@ static ssize_t tracing_splice_read_pipe(struct file *filp,
>   	goto out;
>   }
>   
> +static ssize_t
> +tracing_syscall_buf_read(struct file *filp, char __user *ubuf,
> +			 size_t cnt, loff_t *ppos)
> +{
> +	struct inode *inode = file_inode(filp);
> +	struct trace_array *tr = inode->i_private;
> +	char buf[64];
> +	int r;
> +
> +	r = snprintf(buf, 64, "%d\n", tr->syscall_buf_sz);
> +
> +	return simple_read_from_buffer(ubuf, cnt, ppos, buf, r);
> +}
> +
> +static ssize_t
> +tracing_syscall_buf_write(struct file *filp, const char __user *ubuf,
> +			  size_t cnt, loff_t *ppos)
> +{
> +	struct inode *inode = file_inode(filp);
> +	struct trace_array *tr = inode->i_private;
> +	unsigned long val;
> +	int ret;
> +
> +	ret = kstrtoul_from_user(ubuf, cnt, 10, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val > SYSCALL_FAULT_USER_MAX)
> +		val = SYSCALL_FAULT_USER_MAX;
> +
> +	tr->syscall_buf_sz = val;
> +
> +	*ppos += cnt;
> +
> +	return cnt;
> +}
> +
>   static ssize_t
>   tracing_entries_read(struct file *filp, char __user *ubuf,
>   		     size_t cnt, loff_t *ppos)
> @@ -7737,6 +7774,14 @@ static const struct file_operations tracing_entries_fops = {
>   	.release	= tracing_release_generic_tr,
>   };
>   
> +static const struct file_operations tracing_syscall_buf_fops = {
> +	.open		= tracing_open_generic_tr,
> +	.read		= tracing_syscall_buf_read,
> +	.write		= tracing_syscall_buf_write,
> +	.llseek		= generic_file_llseek,
> +	.release	= tracing_release_generic_tr,
> +};
> +
>   static const struct file_operations tracing_buffer_meta_fops = {
>   	.open		= tracing_buffer_meta_open,
>   	.read		= seq_read,
> @@ -9839,6 +9884,8 @@ trace_array_create_systems(const char *name, const char *systems,
>   
>   	raw_spin_lock_init(&tr->start_lock);
>   
> +	tr->syscall_buf_sz = global_trace.syscall_buf_sz;
> +
>   	tr->max_lock = (arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED;
>   #ifdef CONFIG_TRACER_MAX_TRACE
>   	spin_lock_init(&tr->snapshot_trigger_lock);
> @@ -10155,6 +10202,9 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
>   	trace_create_file("buffer_subbuf_size_kb", TRACE_MODE_WRITE, d_tracer,
>   			  tr, &buffer_subbuf_size_fops);
>   
> +	trace_create_file("syscall_user_buf_size", TRACE_MODE_WRITE, d_tracer,
> +			 tr, &tracing_syscall_buf_fops);
> +
>   	create_trace_options_dir(tr);
>   
>   #ifdef CONFIG_TRACER_MAX_TRACE
> @@ -11081,6 +11131,8 @@ __init static int tracer_alloc_buffers(void)
>   
>   	global_trace.flags = TRACE_ARRAY_FL_GLOBAL;
>   
> +	global_trace.syscall_buf_sz = CONFIG_TRACE_SYSCALL_BUF_SIZE_DEFAULT;
> +
>   	INIT_LIST_HEAD(&global_trace.systems);
>   	INIT_LIST_HEAD(&global_trace.events);
>   	INIT_LIST_HEAD(&global_trace.hist_vars);
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index 1dbf1d3cf2f1..1b3e464619f0 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -131,6 +131,8 @@ enum trace_type {
>   #define HIST_STACKTRACE_SIZE	(HIST_STACKTRACE_DEPTH * sizeof(unsigned long))
>   #define HIST_STACKTRACE_SKIP	5
>   
> +#define SYSCALL_FAULT_USER_MAX 128
> +
>   /*
>    * syscalls are special, and need special handling, this is why
>    * they are not included in trace_entries.h
> @@ -430,6 +432,7 @@ struct trace_array {
>   	int			function_enabled;
>   #endif
>   	int			no_filter_buffering_ref;
> +	unsigned int		syscall_buf_sz;
>   	struct list_head	hist_vars;
>   #ifdef CONFIG_TRACER_SNAPSHOT
>   	struct cond_snapshot	*cond_snapshot;
> diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
> index b39fa9dd1067..e9162165c4d2 100644
> --- a/kernel/trace/trace_syscalls.c
> +++ b/kernel/trace/trace_syscalls.c
> @@ -407,17 +407,16 @@ struct syscall_buf_info {
>    * SYSCALL_FAULT_USER_MAX is the amount to copy into the ring buffer.
>    *  It's slightly smaller than SYSCALL_FAULT_ARG_SZ to know if it
>    *  needs to append the EXTRA or not.
> + *  (defined in kernel/trace/trace.h)
>    *
>    * This only allows up to 3 args from system calls.
>    */
>   #define SYSCALL_FAULT_BUF_SZ 512
>   #define SYSCALL_FAULT_ARG_SZ 168
> -#define SYSCALL_FAULT_USER_MAX 128
>   #define SYSCALL_FAULT_MAX_CNT 3
>   
>   static struct syscall_buf_info *syscall_buffer;
>   static DEFINE_PER_CPU(unsigned long, sched_switch_cnt);
> -
>   static int syscall_fault_buffer_cnt;
>   
>   static void syscall_fault_buffer_free(struct syscall_buf_info *sinfo)
> @@ -524,7 +523,7 @@ static void syscall_fault_buffer_disable(void)
>   	call_rcu_tasks_trace(&sinfo->rcu, rcu_free_syscall_buffer);
>   }
>   
> -static char *sys_fault_user(struct syscall_metadata *sys_data,
> +static char *sys_fault_user(struct trace_array *tr, struct syscall_metadata *sys_data,
>   			    struct syscall_buf_info *sinfo,
>   			    unsigned long *args,
>   			    unsigned int data_size[SYSCALL_FAULT_MAX_CNT])
> @@ -576,6 +575,10 @@ static char *sys_fault_user(struct syscall_metadata *sys_data,
>   		data_size[i] = -1; /* Denotes no pointer */
>   	}
>   
> +	/* A zero size means do not even try */
> +	if (!tr->syscall_buf_sz)
> +		return buffer;
> +
>    again:
>   	/*
>   	 * If this task is preempted by another user space task, it
> @@ -659,19 +662,20 @@ static char *sys_fault_user(struct syscall_metadata *sys_data,
>   					buf[x] = '.';
>   			}
>   
> +			size = min(tr->syscall_buf_sz, SYSCALL_FAULT_USER_MAX);
> +
>   			/*
>   			 * If the text was truncated due to our max limit,
>   			 * add "..." to the string.
>   			 */
> -			if (ret > SYSCALL_FAULT_USER_MAX) {
> -				strscpy(buf + SYSCALL_FAULT_USER_MAX, EXTRA,
> -					sizeof(EXTRA));
> -				ret = SYSCALL_FAULT_USER_MAX + sizeof(EXTRA);
> +			if (ret > size) {
> +				strscpy(buf + size, EXTRA, sizeof(EXTRA));
> +				ret = size + sizeof(EXTRA);
>   			} else {
>   				buf[ret++] = '\0';
>   			}
>   		} else {
> -			ret = min(ret, SYSCALL_FAULT_USER_MAX);
> +			ret = min((unsigned int)ret, tr->syscall_buf_sz);
>   		}
>   		data_size[i] = ret;
>   	}
> @@ -731,7 +735,7 @@ static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
>   		if (!sinfo)
>   			return;
>   
> -		user_ptr = sys_fault_user(sys_data, sinfo, args, user_sizes);
> +		user_ptr = sys_fault_user(tr, sys_data, sinfo, args, user_sizes);
>   		/*
>   		 * user_size is the amount of data to append.
>   		 * Need to add 4 for the meta field that points to

--
Douglas
