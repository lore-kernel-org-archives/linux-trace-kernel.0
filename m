Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA4853392
	for <linux-trace-kernel@vger.kernel.org>; Thu,  1 Feb 2024 14:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706798168; cv=none; b=olFU5+uZwKdc67MfAzExFFv4HFpNQ0V2RmmpGczgTqYdjFftox4CKVDe1WPsrENzq3MK1pllE2qMUR0uPZ9wew1O6TgU16eqW5+z7eqfsrJA07Qnj5I9ce1PvverHujtNTPIOeOfJVuYTV3BPd08BA7ZRKanwzmxhn7VUvuk4U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706798168; c=relaxed/simple;
	bh=K9v2DSPddAe6y+1QPT3+1f+MCfxiCpU3C+vvqFGrF/s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n9Oc3ln6bdgR07Zf2l9OkIS7Sgs9LcIwWzRTEvYol/3/vxDNOuFoZf1+8oMdICenzc+AYoek+xgbPpruf2i/3Mmi1LDTUvmEBqu/JjTDP9hfX3zeL3Axarp0zjYiJHz/d8W+4OeYpK9VxnKQNLpColZpdwwze4CKyO1x4kgUOe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42453C433F1;
	Thu,  1 Feb 2024 14:36:07 +0000 (UTC)
Date: Thu, 1 Feb 2024 09:36:22 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Andy Chiu <andy.chiu@sifive.com>, bristot@kernel.org
Cc: linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com
Subject: Re: [v1] trace/osnoise: prevent osnoise hotplog worker running in
 UNBOUND workqueue
Message-ID: <20240201093622.0b820990@gandalf.local.home>
In-Reply-To: <20240201061845.3154289-1-andy.chiu@sifive.com>
References: <20240201061845.3154289-1-andy.chiu@sifive.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  1 Feb 2024 14:18:45 +0800
Andy Chiu <andy.chiu@sifive.com> wrote:

> smp_processor_id() should be called with migration disabled. This mean
> we may safely call smp_processor_id() in percpu thread. However, this is
> not the case if the work is (re-)queued into unbound workqueue, during
> cpu-hotplog. So, detect and return early if this work happens to run on
> an unbound wq.
> 

Yeah I triggered this too, but never made it a priority to fix.


> Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
> ---
>  kernel/trace/trace_osnoise.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
> index bd0d01d00fb9..cf7f716d3f35 100644
> --- a/kernel/trace/trace_osnoise.c
> +++ b/kernel/trace/trace_osnoise.c
> @@ -2068,7 +2068,12 @@ static int start_per_cpu_kthreads(void)
>  #ifdef CONFIG_HOTPLUG_CPU
>  static void osnoise_hotplug_workfn(struct work_struct *dummy)
>  {
> -	unsigned int cpu = smp_processor_id();
> +	unsigned int cpu;
> +
> +	if (!is_percpu_thread())
> +		return;

But doesn't this then fail to register the CPU thread?

I wonder if this has some race with schedule_work_on() and hotplug?

-- Steve



> +
> +	cpu = smp_processor_id();
>  
>  	mutex_lock(&trace_types_lock);
>  

