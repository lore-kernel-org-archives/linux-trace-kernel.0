Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE49E11CA9;
	Wed, 25 Dec 2024 14:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735136347; cv=none; b=JFJSv2dB3ASI8EwV3GOOzOY7CjlVvC+i3wL5VBKHawIkqbn8mdTHPAqNKX/FN8ygEB36GjU99tU5y+YkzZFKDOwl37JhVhq5xtPx8e6uJkaDagfqhgn8Zl8gS9UrydXrNZ6Z38GJi/qTnrtdcWIOta/U17Y1uW5AledcUOvq6IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735136347; c=relaxed/simple;
	bh=mn4T9iIw8VDiMWmaqxrGeFc2EjpU3SQznbFCG0rs37g=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=f0EWhHzL8dgUlachDhcQYqZ00zaLlVlRoiMx2qm+pbsDU1S8/N+Sl2TtIZPuTYlD8sTC6bUyYqU5Tj5GD+tl8+a108LLIGRtu9uV4vtzYS2bDdXqnJamfRNE5A3Ew9AyEeFIdE+LREv/yWLN7whNofoIvUTOemMXf4i7aI5gHG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nL3Yh8v9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nL3Yh8v9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2697C4CECD;
	Wed, 25 Dec 2024 14:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735136347;
	bh=mn4T9iIw8VDiMWmaqxrGeFc2EjpU3SQznbFCG0rs37g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nL3Yh8v9bIW2nRIq8TfiBHkz6D0bcNM4oA/ZJ60Kf37tJ68pRNvjIR3N2HEz7ofhX
	 1fCeBM8VMBrYhQ6VdbYpXMQGhQNn+RhSBecL9/YM+0iVuZeYcqomVLLiXjMi/se4ui
	 38E/C0WxgqPgQccnfkFKvHzziTQ6tDItI3klVtA6G/08f0FRsOKjKLYrH9VZbVSXz4
	 j4LEkrdtfqp9P0e1H1tUj+iALdxCUMJkoDgNq1vhS2hqtES6TGqeh68N+C2ZW1xbPn
	 2n4FrVSO4b7/35DlM6+U2QkFuZkAandbwq5ZEImJXIfv8XkCoS84GBLX2C4kRZPtU8
	 HInDUNEcF9V2w==
Date: Wed, 25 Dec 2024 23:19:02 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra
 <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] tracing: Switch trace.c code over to use guard()
Message-Id: <20241225231902.e2d68ec1094b4fa61542a600@kernel.org>
In-Reply-To: <20241224221413.7b8c68c3@batman.local.home>
References: <20241224221413.7b8c68c3@batman.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Dec 2024 22:14:13 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> There are several functions in trace.c that have "goto out;" or
> equivalent on error in order to release locks or free values that were
> allocated. This can be error prone or just simply make the code more
> complex.
> 
> Switch every location that ends with unlocking a mutex or freeing on error
> over to using the guard(mutex)() and __free() infrastructure to let the
> compiler worry about releasing locks. This makes the code easier to read
> and understand.
> 
> There's one place that should probably return an error but instead return
> 0. This does not change the return as the only changes are to do the
> conversion without changing the logic. Fixing that location will have to
> come later.
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> ---
> Changes since v1: https://lore.kernel.org/20241219201344.687105470@goodmis.org
> 
> - Had a typo "guaurd" ? I think I screwed it up when sending out the patches.
>   It worked fine in my repo, but when I pulled them from patchwork,
>   it was broken. I sent these out with quilt, and manually review them
>   before sending. I think I must have added the typo in my review :-p
> 
>  kernel/trace/trace.c | 266 +++++++++++++++----------------------------
>  1 file changed, 94 insertions(+), 172 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 957f941a08e7..e6e1de69af01 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -26,6 +26,7 @@
>  #include <linux/hardirq.h>
>  #include <linux/linkage.h>
>  #include <linux/uaccess.h>
> +#include <linux/cleanup.h>
>  #include <linux/vmalloc.h>
>  #include <linux/ftrace.h>
>  #include <linux/module.h>
> @@ -535,19 +536,16 @@ LIST_HEAD(ftrace_trace_arrays);
>  int trace_array_get(struct trace_array *this_tr)
>  {
>  	struct trace_array *tr;
> -	int ret = -ENODEV;
>  
> -	mutex_lock(&trace_types_lock);
> +	guard(mutex)(&trace_types_lock);
>  	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
>  		if (tr == this_tr) {
>  			tr->ref++;
> -			ret = 0;
> -			break;
> +			return 0;
>  		}
>  	}
> -	mutex_unlock(&trace_types_lock);
>  
> -	return ret;
> +	return -ENODEV;
>  }
>  
>  static void __trace_array_put(struct trace_array *this_tr)
> @@ -1443,22 +1441,20 @@ EXPORT_SYMBOL_GPL(tracing_snapshot_alloc);
>  int tracing_snapshot_cond_enable(struct trace_array *tr, void *cond_data,
>  				 cond_update_fn_t update)
>  {
> -	struct cond_snapshot *cond_snapshot;
> -	int ret = 0;
> +	struct cond_snapshot *cond_snapshot __free(kfree) =
> +		kzalloc(sizeof(*cond_snapshot), GFP_KERNEL);
> +	int ret;
>  
> -	cond_snapshot = kzalloc(sizeof(*cond_snapshot), GFP_KERNEL);
>  	if (!cond_snapshot)
>  		return -ENOMEM;
>  
>  	cond_snapshot->cond_data = cond_data;
>  	cond_snapshot->update = update;
>  
> -	mutex_lock(&trace_types_lock);
> +	guard(mutex)(&trace_types_lock);
>  
> -	if (tr->current_trace->use_max_tr) {
> -		ret = -EBUSY;
> -		goto fail_unlock;
> -	}
> +	if (tr->current_trace->use_max_tr)
> +		return -EBUSY;
>  
>  	/*
>  	 * The cond_snapshot can only change to NULL without the
> @@ -1468,29 +1464,20 @@ int tracing_snapshot_cond_enable(struct trace_array *tr, void *cond_data,
>  	 * do safely with only holding the trace_types_lock and not
>  	 * having to take the max_lock.
>  	 */
> -	if (tr->cond_snapshot) {
> -		ret = -EBUSY;
> -		goto fail_unlock;
> -	}
> +	if (tr->cond_snapshot)
> +		return -EBUSY;
>  
>  	ret = tracing_arm_snapshot_locked(tr);
>  	if (ret)
> -		goto fail_unlock;
> +		return ret;
>  
>  	local_irq_disable();
>  	arch_spin_lock(&tr->max_lock);
> -	tr->cond_snapshot = cond_snapshot;
> +	tr->cond_snapshot = no_free_ptr(cond_snapshot);
>  	arch_spin_unlock(&tr->max_lock);
>  	local_irq_enable();
>  
> -	mutex_unlock(&trace_types_lock);
> -
> -	return ret;
> -
> - fail_unlock:
> -	mutex_unlock(&trace_types_lock);
> -	kfree(cond_snapshot);
> -	return ret;
> +	return 0;
>  }
>  EXPORT_SYMBOL_GPL(tracing_snapshot_cond_enable);
>  
> @@ -2203,10 +2190,10 @@ static __init int init_trace_selftests(void)
>  
>  	selftests_can_run = true;
>  
> -	mutex_lock(&trace_types_lock);
> +	guard(mutex)(&trace_types_lock);
>  
>  	if (list_empty(&postponed_selftests))
> -		goto out;
> +		return 0;
>  
>  	pr_info("Running postponed tracer tests:\n");
>  
> @@ -2235,9 +2222,6 @@ static __init int init_trace_selftests(void)
>  	}
>  	tracing_selftest_running = false;
>  
> - out:
> -	mutex_unlock(&trace_types_lock);
> -
>  	return 0;
>  }
>  core_initcall(init_trace_selftests);
> @@ -2807,7 +2791,7 @@ int tracepoint_printk_sysctl(const struct ctl_table *table, int write,
>  	int save_tracepoint_printk;
>  	int ret;
>  
> -	mutex_lock(&tracepoint_printk_mutex);
> +	guard(mutex)(&tracepoint_printk_mutex);
>  	save_tracepoint_printk = tracepoint_printk;
>  
>  	ret = proc_dointvec(table, write, buffer, lenp, ppos);
> @@ -2820,16 +2804,13 @@ int tracepoint_printk_sysctl(const struct ctl_table *table, int write,
>  		tracepoint_printk = 0;
>  
>  	if (save_tracepoint_printk == tracepoint_printk)
> -		goto out;
> +		return ret;
>  
>  	if (tracepoint_printk)
>  		static_key_enable(&tracepoint_printk_key.key);
>  	else
>  		static_key_disable(&tracepoint_printk_key.key);
>  
> - out:
> -	mutex_unlock(&tracepoint_printk_mutex);
> -
>  	return ret;
>  }
>  
> @@ -5123,7 +5104,8 @@ static int tracing_trace_options_show(struct seq_file *m, void *v)
>  	u32 tracer_flags;
>  	int i;
>  
> -	mutex_lock(&trace_types_lock);
> +	guard(mutex)(&trace_types_lock);
> +
>  	tracer_flags = tr->current_trace->flags->val;
>  	trace_opts = tr->current_trace->flags->opts;
>  
> @@ -5140,7 +5122,6 @@ static int tracing_trace_options_show(struct seq_file *m, void *v)
>  		else
>  			seq_printf(m, "no%s\n", trace_opts[i].name);
>  	}
> -	mutex_unlock(&trace_types_lock);
>  
>  	return 0;
>  }
> @@ -5805,7 +5786,7 @@ trace_insert_eval_map_file(struct module *mod, struct trace_eval_map **start,
>  		return;
>  	}
>  
> -	mutex_lock(&trace_eval_mutex);
> +	guard(mutex)(&trace_eval_mutex);
>  
>  	if (!trace_eval_maps)
>  		trace_eval_maps = map_array;
> @@ -5829,8 +5810,6 @@ trace_insert_eval_map_file(struct module *mod, struct trace_eval_map **start,
>  		map_array++;
>  	}
>  	memset(map_array, 0, sizeof(*map_array));
> -
> -	mutex_unlock(&trace_eval_mutex);
>  }
>  
>  static void trace_create_eval_file(struct dentry *d_tracer)
> @@ -5994,23 +5973,18 @@ ssize_t tracing_resize_ring_buffer(struct trace_array *tr,
>  {
>  	int ret;
>  
> -	mutex_lock(&trace_types_lock);
> +	guard(mutex)(&trace_types_lock);
>  
>  	if (cpu_id != RING_BUFFER_ALL_CPUS) {
>  		/* make sure, this cpu is enabled in the mask */
> -		if (!cpumask_test_cpu(cpu_id, tracing_buffer_mask)) {
> -			ret = -EINVAL;
> -			goto out;
> -		}
> +		if (!cpumask_test_cpu(cpu_id, tracing_buffer_mask))
> +			return -EINVAL;
>  	}
>  
>  	ret = __tracing_resize_ring_buffer(tr, size, cpu_id);
>  	if (ret < 0)
>  		ret = -ENOMEM;
>  
> -out:
> -	mutex_unlock(&trace_types_lock);
> -
>  	return ret;
>  }
>  
> @@ -6102,9 +6076,9 @@ int tracing_set_tracer(struct trace_array *tr, const char *buf)
>  #ifdef CONFIG_TRACER_MAX_TRACE
>  	bool had_max_tr;
>  #endif
> -	int ret = 0;
> +	int ret;
>  
> -	mutex_lock(&trace_types_lock);
> +	guard(mutex)(&trace_types_lock);
>  
>  	update_last_data(tr);
>  
> @@ -6112,7 +6086,7 @@ int tracing_set_tracer(struct trace_array *tr, const char *buf)
>  		ret = __tracing_resize_ring_buffer(tr, trace_buf_size,
>  						RING_BUFFER_ALL_CPUS);
>  		if (ret < 0)
> -			goto out;
> +			return ret;
>  		ret = 0;
>  	}
>  
> @@ -6120,12 +6094,11 @@ int tracing_set_tracer(struct trace_array *tr, const char *buf)
>  		if (strcmp(t->name, buf) == 0)
>  			break;
>  	}
> -	if (!t) {
> -		ret = -EINVAL;
> -		goto out;
> -	}
> +	if (!t)
> +		return -EINVAL;
> +
>  	if (t == tr->current_trace)
> -		goto out;
> +		return 0;
>  
>  #ifdef CONFIG_TRACER_SNAPSHOT
>  	if (t->use_max_tr) {
> @@ -6136,27 +6109,23 @@ int tracing_set_tracer(struct trace_array *tr, const char *buf)
>  		arch_spin_unlock(&tr->max_lock);
>  		local_irq_enable();
>  		if (ret)
> -			goto out;
> +			return ret;
>  	}
>  #endif
>  	/* Some tracers won't work on kernel command line */
>  	if (system_state < SYSTEM_RUNNING && t->noboot) {
>  		pr_warn("Tracer '%s' is not allowed on command line, ignored\n",
>  			t->name);
> -		goto out;
> +		return 0;
>  	}
>  
>  	/* Some tracers are only allowed for the top level buffer */
> -	if (!trace_ok_for_array(t, tr)) {
> -		ret = -EINVAL;
> -		goto out;
> -	}
> +	if (!trace_ok_for_array(t, tr))
> +		return -EINVAL;
>  
>  	/* If trace pipe files are being read, we can't change the tracer */
> -	if (tr->trace_ref) {
> -		ret = -EBUSY;
> -		goto out;
> -	}
> +	if (tr->trace_ref)
> +		return -EBUSY;
>  
>  	trace_branch_disable();
>  
> @@ -6187,7 +6156,7 @@ int tracing_set_tracer(struct trace_array *tr, const char *buf)
>  	if (!had_max_tr && t->use_max_tr) {
>  		ret = tracing_arm_snapshot_locked(tr);
>  		if (ret)
> -			goto out;
> +			return ret;
>  	}
>  #else
>  	tr->current_trace = &nop_trace;
> @@ -6200,17 +6169,15 @@ int tracing_set_tracer(struct trace_array *tr, const char *buf)
>  			if (t->use_max_tr)
>  				tracing_disarm_snapshot(tr);
>  #endif
> -			goto out;
> +			return ret;
>  		}
>  	}
>  
>  	tr->current_trace = t;
>  	tr->current_trace->enabled++;
>  	trace_branch_enable(tr);
> - out:
> -	mutex_unlock(&trace_types_lock);
>  
> -	return ret;
> +	return 0;
>  }
>  
>  static ssize_t
> @@ -6288,22 +6255,18 @@ tracing_thresh_write(struct file *filp, const char __user *ubuf,
>  	struct trace_array *tr = filp->private_data;
>  	int ret;
>  
> -	mutex_lock(&trace_types_lock);
> +	guard(mutex)(&trace_types_lock);
>  	ret = tracing_nsecs_write(&tracing_thresh, ubuf, cnt, ppos);
>  	if (ret < 0)
> -		goto out;
> +		return ret;
>  
>  	if (tr->current_trace->update_thresh) {
>  		ret = tr->current_trace->update_thresh(tr);
>  		if (ret < 0)
> -			goto out;
> +			return ret;
>  	}
>  
> -	ret = cnt;
> -out:
> -	mutex_unlock(&trace_types_lock);
> -
> -	return ret;
> +	return cnt;
>  }
>  
>  #ifdef CONFIG_TRACER_MAX_TRACE
> @@ -6522,31 +6485,29 @@ tracing_read_pipe(struct file *filp, char __user *ubuf,
>  	 * This is just a matter of traces coherency, the ring buffer itself
>  	 * is protected.
>  	 */
> -	mutex_lock(&iter->mutex);
> +	guard(mutex)(&iter->mutex);
>  
>  	/* return any leftover data */
>  	sret = trace_seq_to_user(&iter->seq, ubuf, cnt);
>  	if (sret != -EBUSY)
> -		goto out;
> +		return sret;
>  
>  	trace_seq_init(&iter->seq);
>  
>  	if (iter->trace->read) {
>  		sret = iter->trace->read(iter, filp, ubuf, cnt, ppos);
>  		if (sret)
> -			goto out;
> +			return sret;
>  	}
>  
>  waitagain:
>  	sret = tracing_wait_pipe(filp);
>  	if (sret <= 0)
> -		goto out;
> +		return sret;
>  
>  	/* stop when tracing is finished */
> -	if (trace_empty(iter)) {
> -		sret = 0;
> -		goto out;
> -	}
> +	if (trace_empty(iter))
> +		return 0;
>  
>  	if (cnt >= TRACE_SEQ_BUFFER_SIZE)
>  		cnt = TRACE_SEQ_BUFFER_SIZE - 1;
> @@ -6610,9 +6571,6 @@ tracing_read_pipe(struct file *filp, char __user *ubuf,
>  	if (sret == -EBUSY)
>  		goto waitagain;
>  
> -out:
> -	mutex_unlock(&iter->mutex);
> -
>  	return sret;
>  }
>  
> @@ -7204,25 +7162,19 @@ u64 tracing_event_time_stamp(struct trace_buffer *buffer, struct ring_buffer_eve
>   */
>  int tracing_set_filter_buffering(struct trace_array *tr, bool set)
>  {
> -	int ret = 0;
> -
> -	mutex_lock(&trace_types_lock);
> +	guard(mutex)(&trace_types_lock);
>  
>  	if (set && tr->no_filter_buffering_ref++)
> -		goto out;
> +		return 0;
>  
>  	if (!set) {
> -		if (WARN_ON_ONCE(!tr->no_filter_buffering_ref)) {
> -			ret = -EINVAL;
> -			goto out;
> -		}
> +		if (WARN_ON_ONCE(!tr->no_filter_buffering_ref))
> +			return -EINVAL;
>  
>  		--tr->no_filter_buffering_ref;
>  	}
> - out:
> -	mutex_unlock(&trace_types_lock);
>  
> -	return ret;
> +	return 0;
>  }
>  
>  struct ftrace_buffer_info {
> @@ -7298,12 +7250,10 @@ tracing_snapshot_write(struct file *filp, const char __user *ubuf, size_t cnt,
>  	if (ret)
>  		return ret;
>  
> -	mutex_lock(&trace_types_lock);
> +	guard(mutex)(&trace_types_lock);
>  
> -	if (tr->current_trace->use_max_tr) {
> -		ret = -EBUSY;
> -		goto out;
> -	}
> +	if (tr->current_trace->use_max_tr)
> +		return -EBUSY;
>  
>  	local_irq_disable();
>  	arch_spin_lock(&tr->max_lock);
> @@ -7312,24 +7262,20 @@ tracing_snapshot_write(struct file *filp, const char __user *ubuf, size_t cnt,
>  	arch_spin_unlock(&tr->max_lock);
>  	local_irq_enable();
>  	if (ret)
> -		goto out;
> +		return ret;
>  
>  	switch (val) {
>  	case 0:
> -		if (iter->cpu_file != RING_BUFFER_ALL_CPUS) {
> -			ret = -EINVAL;
> -			break;
> -		}
> +		if (iter->cpu_file != RING_BUFFER_ALL_CPUS)
> +			return -EINVAL;
>  		if (tr->allocated_snapshot)
>  			free_snapshot(tr);
>  		break;
>  	case 1:
>  /* Only allow per-cpu swap if the ring buffer supports it */
>  #ifndef CONFIG_RING_BUFFER_ALLOW_SWAP
> -		if (iter->cpu_file != RING_BUFFER_ALL_CPUS) {
> -			ret = -EINVAL;
> -			break;
> -		}
> +		if (iter->cpu_file != RING_BUFFER_ALL_CPUS)
> +			return -EINVAL;
>  #endif
>  		if (tr->allocated_snapshot)
>  			ret = resize_buffer_duplicate_size(&tr->max_buffer,
> @@ -7337,7 +7283,7 @@ tracing_snapshot_write(struct file *filp, const char __user *ubuf, size_t cnt,
>  
>  		ret = tracing_arm_snapshot_locked(tr);
>  		if (ret)
> -			break;
> +			return ret;
>  
>  		/* Now, we're going to swap */
>  		if (iter->cpu_file == RING_BUFFER_ALL_CPUS) {
> @@ -7364,8 +7310,7 @@ tracing_snapshot_write(struct file *filp, const char __user *ubuf, size_t cnt,
>  		*ppos += cnt;
>  		ret = cnt;
>  	}
> -out:
> -	mutex_unlock(&trace_types_lock);
> +
>  	return ret;
>  }
>  
> @@ -7751,12 +7696,11 @@ void tracing_log_err(struct trace_array *tr,
>  
>  	len += sizeof(CMD_PREFIX) + 2 * sizeof("\n") + strlen(cmd) + 1;
>  
> -	mutex_lock(&tracing_err_log_lock);
> +	guard(mutex)(&tracing_err_log_lock);
> +
>  	err = get_tracing_log_err(tr, len);
> -	if (PTR_ERR(err) == -ENOMEM) {
> -		mutex_unlock(&tracing_err_log_lock);
> +	if (PTR_ERR(err) == -ENOMEM)
>  		return;
> -	}
>  
>  	snprintf(err->loc, TRACING_LOG_LOC_MAX, "%s: error: ", loc);
>  	snprintf(err->cmd, len, "\n" CMD_PREFIX "%s\n", cmd);
> @@ -7767,7 +7711,6 @@ void tracing_log_err(struct trace_array *tr,
>  	err->info.ts = local_clock();
>  
>  	list_add_tail(&err->list, &tr->err_log);
> -	mutex_unlock(&tracing_err_log_lock);
>  }
>  
>  static void clear_tracing_err_log(struct trace_array *tr)
> @@ -9511,20 +9454,17 @@ static int instance_mkdir(const char *name)
>  	struct trace_array *tr;
>  	int ret;
>  
> -	mutex_lock(&event_mutex);
> -	mutex_lock(&trace_types_lock);
> +	guard(mutex)(&event_mutex);
> +	guard(mutex)(&trace_types_lock);
>  
>  	ret = -EEXIST;
>  	if (trace_array_find(name))
> -		goto out_unlock;
> +		return -EEXIST;
>  
>  	tr = trace_array_create(name);
>  
>  	ret = PTR_ERR_OR_ZERO(tr);
>  
> -out_unlock:
> -	mutex_unlock(&trace_types_lock);
> -	mutex_unlock(&event_mutex);
>  	return ret;
>  }
>  
> @@ -9574,24 +9514,23 @@ struct trace_array *trace_array_get_by_name(const char *name, const char *system
>  {
>  	struct trace_array *tr;
>  
> -	mutex_lock(&event_mutex);
> -	mutex_lock(&trace_types_lock);
> +	guard(mutex)(&event_mutex);
> +	guard(mutex)(&trace_types_lock);
>  
>  	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
> -		if (tr->name && strcmp(tr->name, name) == 0)
> -			goto out_unlock;
> +		if (tr->name && strcmp(tr->name, name) == 0) {
> +			tr->ref++;
> +			return tr;
> +		}
>  	}
>  
>  	tr = trace_array_create_systems(name, systems, 0, 0);
>  
>  	if (IS_ERR(tr))
>  		tr = NULL;
> -out_unlock:
> -	if (tr)
> +	else
>  		tr->ref++;
>  
> -	mutex_unlock(&trace_types_lock);
> -	mutex_unlock(&event_mutex);
>  	return tr;
>  }
>  EXPORT_SYMBOL_GPL(trace_array_get_by_name);
> @@ -9642,48 +9581,36 @@ static int __remove_instance(struct trace_array *tr)
>  int trace_array_destroy(struct trace_array *this_tr)
>  {
>  	struct trace_array *tr;
> -	int ret;
>  
>  	if (!this_tr)
>  		return -EINVAL;
>  
> -	mutex_lock(&event_mutex);
> -	mutex_lock(&trace_types_lock);
> +	guard(mutex)(&event_mutex);
> +	guard(mutex)(&trace_types_lock);
>  
> -	ret = -ENODEV;
>  
>  	/* Making sure trace array exists before destroying it. */
>  	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
> -		if (tr == this_tr) {
> -			ret = __remove_instance(tr);
> -			break;
> -		}
> +		if (tr == this_tr)
> +			return __remove_instance(tr);
>  	}
>  
> -	mutex_unlock(&trace_types_lock);
> -	mutex_unlock(&event_mutex);
> -
> -	return ret;
> +	return -ENODEV;
>  }
>  EXPORT_SYMBOL_GPL(trace_array_destroy);
>  
>  static int instance_rmdir(const char *name)
>  {
>  	struct trace_array *tr;
> -	int ret;
>  
> -	mutex_lock(&event_mutex);
> -	mutex_lock(&trace_types_lock);
> +	guard(mutex)(&event_mutex);
> +	guard(mutex)(&trace_types_lock);
>  
> -	ret = -ENODEV;
>  	tr = trace_array_find(name);
> -	if (tr)
> -		ret = __remove_instance(tr);
> -
> -	mutex_unlock(&trace_types_lock);
> -	mutex_unlock(&event_mutex);
> +	if (!tr)
> +		return -ENODEV;
>  
> -	return ret;
> +	return __remove_instance(tr);
>  }
>  
>  static __init void create_trace_instances(struct dentry *d_tracer)
> @@ -9696,19 +9623,16 @@ static __init void create_trace_instances(struct dentry *d_tracer)
>  	if (MEM_FAIL(!trace_instance_dir, "Failed to create instances directory\n"))
>  		return;
>  
> -	mutex_lock(&event_mutex);
> -	mutex_lock(&trace_types_lock);
> +	guard(mutex)(&event_mutex);
> +	guard(mutex)(&trace_types_lock);
>  
>  	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
>  		if (!tr->name)
>  			continue;
>  		if (MEM_FAIL(trace_array_create_dir(tr) < 0,
>  			     "Failed to create instance directory\n"))
> -			break;
> +			return;
>  	}
> -
> -	mutex_unlock(&trace_types_lock);
> -	mutex_unlock(&event_mutex);
>  }
>  
>  static void
> @@ -9922,7 +9846,7 @@ static void trace_module_remove_evals(struct module *mod)
>  	if (!mod->num_trace_evals)
>  		return;
>  
> -	mutex_lock(&trace_eval_mutex);
> +	guard(mutex)(&trace_eval_mutex);
>  
>  	map = trace_eval_maps;
>  
> @@ -9934,12 +9858,10 @@ static void trace_module_remove_evals(struct module *mod)
>  		map = map->tail.next;
>  	}
>  	if (!map)
> -		goto out;
> +		return;
>  
>  	*last = trace_eval_jmp_to_tail(map)->tail.next;
>  	kfree(map);
> - out:
> -	mutex_unlock(&trace_eval_mutex);
>  }
>  #else
>  static inline void trace_module_remove_evals(struct module *mod) { }
> -- 
> 2.45.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
