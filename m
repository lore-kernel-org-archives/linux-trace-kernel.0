Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3177330B53A;
	Thu, 26 Mar 2026 07:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774509533; cv=none; b=SfSwxqyLUjzbHvmefAYxSrp1n9C4PqhSZM/MGMQ4pn2nO/DWnJKuSVCNAEux7B2B/xu52B5Ll2K5JTeTaYoRMS2/TWgrQGQePRdKkUv5L6K8XFUm7GGSLjdo/HPxfkuzX6khySI7FCLTKpHbfbJp00ign0kVI8xYDKDPDyvVTlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774509533; c=relaxed/simple;
	bh=bRHthhw/kpEPF3CrEGYr8StErpixfmv86PsLdF7IH4w=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=pNKieuE60F9X1oIiUou3DfO7l0gA5AE1LTTjOTinFj9VAVDwIlbv0YvtpgkeKuqxdbqfL8ADntb1E0oMCv2OEE7SQXC/lF81bF4Z36lKwZt8CUUrjflMLaHaeZH8e/Fn9/PnMwPkkEDAkIpIL5oai5RjYUlmJ7RW22BzfgTluME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DPjKwnTu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPjKwnTu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 845E8C116C6;
	Thu, 26 Mar 2026 07:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774509532;
	bh=bRHthhw/kpEPF3CrEGYr8StErpixfmv86PsLdF7IH4w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DPjKwnTu/dpDlsoxGpIMw0/CVV+qjfO3wdlHPrL30BpA1qNUzH72BBCutP3Hw+wRV
	 FUg3xUxFEGhR8+7FFGD9McT64R5qqTx6buuDQ6871O9nR3ckwyxtCESqMBe+392mJx
	 /4dksZWIIllj0+uXFa4xUrJUhOBChsQMJokm/QSGupr1FvwwM82zNjAMmGHf+IhMnO
	 CDpPqRg7fhCsQ3hV9Q7/SY+6c9ectR99iwQDl0U8yk17+3E2BKWrrzT80W22xNr1ix
	 pV9hc+EdiCyzpPdL0WvRx1YQb+PJfysvGBoLB3EKCT8/EtUCHieT+g0HZ6FxxLYriO
	 CKJnW+8NdIYiw==
Date: Thu, 26 Mar 2026 16:18:50 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: <hu.shengming@zte.com.cn>
Cc: <rostedt@goodmis.org>, <mathieu.desnoyers@efficios.com>,
 <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <zhang.run@zte.com.cn>, <yang.tao172@zte.com.cn>, <ran.xiaokai@zte.com.cn>,
 <luo.haiyang@zte.com.cn>
Subject: Re: [PATCH v2] tracing/osnoise: fix potential deadlock in cpu
 hotplug
Message-Id: <20260326161850.54563df8ee6fc2178a95b7ad@kernel.org>
In-Reply-To: <20260326141953414bVSj33dAYktqp9Oiyizq8@zte.com.cn>
References: <20260326141953414bVSj33dAYktqp9Oiyizq8@zte.com.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Mar 2026 14:19:53 +0800 (CST)
<hu.shengming@zte.com.cn> wrote:

> From: Luo Haiyang <luo.haiyang@zte.com.cn>
> 
> The following sequence may leads deadlock in cpu hotplug:
> 
>     task1        task2        task3
>     -----        -----        -----
> 
>  mutex_lock(&interface_lock)
> 
>             [CPU GOING OFFLINE]
> 
>             cpus_write_lock();
>             osnoise_cpu_die();
>               kthread_stop(task3);
>                 wait_for_completion();
> 
>                       osnoise_sleep();
>                         mutex_lock(&interface_lock);
> 
>  cpus_read_lock();
> 
>  [DEAD LOCK]
> 
> Fix by swap the order of cpus_read_lock() and mutex_lock(&interface_lock).
> 
> Signed-off-by: Luo Haiyang <luo.haiyang@zte.com.cn>
> 

This looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,


> ---
> Changes in v2:
> - update change log
> - Link to v1: https://lore.kernel.org/all/20260324150616953rMo1BWtAZ1nXTNrEFP6hr@zte.com.cn/
> ---
>  kernel/trace/trace_osnoise.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
> index dee610e465b9..be6cf0bb3c03 100644
> --- a/kernel/trace/trace_osnoise.c
> +++ b/kernel/trace/trace_osnoise.c
> @@ -2073,8 +2073,8 @@ static void osnoise_hotplug_workfn(struct work_struct *dummy)
>  	if (!osnoise_has_registered_instances())
>  		return;
>  
> -	guard(mutex)(&interface_lock);
>  	guard(cpus_read_lock)();
> +	guard(mutex)(&interface_lock);
>  
>  	if (!cpu_online(cpu))
>  		return;
> @@ -2237,11 +2237,11 @@ static ssize_t osnoise_options_write(struct file *filp, const char __user *ubuf,
>  	if (running)
>  		stop_per_cpu_kthreads();
>  
> -	mutex_lock(&interface_lock);
>  	/*
>  	 * avoid CPU hotplug operations that might read options.
>  	 */
>  	cpus_read_lock();
> +	mutex_lock(&interface_lock);
>  
>  	retval = cnt;
>  
> @@ -2257,8 +2257,8 @@ static ssize_t osnoise_options_write(struct file *filp, const char __user *ubuf,
>  			clear_bit(option, &osnoise_options);
>  	}
>  
> -	cpus_read_unlock();
>  	mutex_unlock(&interface_lock);
> +	cpus_read_unlock();
>  
>  	if (running)
>  		start_per_cpu_kthreads();
> @@ -2345,16 +2345,16 @@ osnoise_cpus_write(struct file *filp, const char __user *ubuf, size_t count,
>  	if (running)
>  		stop_per_cpu_kthreads();
>  
> -	mutex_lock(&interface_lock);
>  	/*
>  	 * osnoise_cpumask is read by CPU hotplug operations.
>  	 */
>  	cpus_read_lock();
> +	mutex_lock(&interface_lock);
>  
>  	cpumask_copy(&osnoise_cpumask, osnoise_cpumask_new);
>  
> -	cpus_read_unlock();
>  	mutex_unlock(&interface_lock);
> +	cpus_read_unlock();
>  
>  	if (running)
>  		start_per_cpu_kthreads();
> -- 
> 2.25.1

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
