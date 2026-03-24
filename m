Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE593D2FFD;
	Tue, 24 Mar 2026 16:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774369122; cv=none; b=k2QgY2fQpkMFNjG1Ei1IKRnfAZhuNievO/YRcZMR+0N3IOyYGQ0mqqySrP1/ajsFxf7Lr3PE4ye3OgfVglXdEACF4kEVBGImqbVFCQLDSQNExxvYwVBeHMHEBBXTuXmOQ6TxAOkAv7L95DiGjSzHNN0T6TGULxN90fj4KHvxyt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774369122; c=relaxed/simple;
	bh=XWLd2knKWRKJfgzX4ohM9pATxzDgSSdtIM2rxrGnybw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LdtFwY0l8lQQQUL4Cnhlu1wrCObYhRHUJl73LkeQcO3KQvRi9/MRMuI9ky1GRAGBZK+ETE44c9XSiUp8MpwBrSeU94JssGsGMFzdOQM+z35Xyb9QmicXP/yaZIIxLeXrSGcirZMgSE2EAOEdiZFZVZvUycTPL3+ehtjMtV2W7tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id C0F86C1749;
	Tue, 24 Mar 2026 16:18:38 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id 9C1C440;
	Tue, 24 Mar 2026 16:18:36 +0000 (UTC)
Date: Tue, 24 Mar 2026 12:19:18 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: <hu.shengming@zte.com.cn>
Cc: <mhiramat@kernel.org>, <mathieu.desnoyers@efficios.com>,
 <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <zhang.run@zte.com.cn>, <yang.tao172@zte.com.cn>, <ran.xiaokai@zte.com.cn>,
 <luo.haiyang@zte.com.cn>
Subject: Re: [PATCH] tracing/osnoise: fix potential deadlock in cpu hotplug
Message-ID: <20260324121918.454d6a7b@gandalf.local.home>
In-Reply-To: <20260324150616953rMo1BWtAZ1nXTNrEFP6hr@zte.com.cn>
References: <20260324150616953rMo1BWtAZ1nXTNrEFP6hr@zte.com.cn>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9C1C440
X-Stat-Signature: pwz7918ig4n6sf37aphi14uu1sqtmqcj
X-Rspamd-Server: rspamout03
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18g94aUZ9l09HEiUxAw+R8+ja7AllMmhBE=
X-HE-Tag: 1774369116-252273
X-HE-Meta: U2FsdGVkX18Z9Qx05BLSb+56CuGMEixhjoVv1D1qx8OccXRV9vweRE6DqvjSL+BDhl3WWQzd0FfvjMcGHJp0tE0/bv3JPDeGBOueNCgk7ug6E2rNGyaJZWT6x6U2M40ZqySTvwqFJnNHCq8LztnqoQ5/Q05JzbMAZbwkjuvkBjC2ldJcNxY2IN8wHRW5G7GixJutVQOxUXvz4nIt5hdr6T0PjbokpOOlObbp4BO6i4DkL6zIexL3f/74coro/SngfXMfpc/1bM0JVAzyq4VueZpfUyYXCLsU9zgQXky2YKWa3TbC6B8H7I6tOYMpxlb26tQnCxZFDZ0xvgLIj7EYGQC8u64QEXkIEGJbVoUAxNaeBBZkjZ5JF1IMrPo8c7s1Gm2o0PWMY2dra4xQXgj7SoNjyZy2cEqL3dbxnPXMUs4=

On Tue, 24 Mar 2026 15:06:16 +0800 (CST)
<hu.shengming@zte.com.cn> wrote:

> From: luohaiyang10243395 <luo.haiyang@zte.com.cn>
> 
> The following sequence may leads deadlock in cpu hotplug:
> 
>   CPU0                        |  CPU1
>                               |  schedule_work_on
>                               |
>   _cpu_down//set CPU1 offline |
>   cpus_write_lock             |
>                               |  osnoise_hotplug_workfn
>                               |    mutex_lock(&interface_lock);
>                               |    cpus_read_lock();  //wait cpu_hotplug_lock
>                               |
>                               |  cpuhp/1
>                               |    osnoise_cpu_die
>                               |      kthread_stop
>                               |        wait_for_completion //wait osnoise/1 exit
>                               |
>                               |  osnoise/1
>                               |    osnoise_sleep
>                               |      mutex_lock(&interface_lock); //deadlock
> 
> Fix by swap the order of cpus_read_lock() and mutex_lock(&interface_lock).

So the deadlock is due to the "wait_for_completion"?

How did you find this bug? Inspection, AI, triggered?

Thanks,

-- Steve


> 
> Signed-off-by: Luo Haiyang <luo.haiyang@zte.com.cn>
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

