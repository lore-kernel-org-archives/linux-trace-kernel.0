Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795087742;
	b=sMIiCOHFfn/wvln31KXpsOhpOwh6Rqv3xPUsKRZ9m2zXc9uhUCZ3FnZlYtEjJU9TY5y9
	 1GRavDREih+tc5vTT/T6gmbCGQHXBmwIOr+BD7oZdJ/rtavs/uq3ckm75/xj+xC/bB3Cw
	 fEasx9yrYuXfN4FBQaW9Bs8eB7vjCOn+sotyef2+1PzRyo0V29uLOuVCDywRMraDSbX1/
	 sBil3DFKvd57DnUjN3HoVfgik0bmB5rME5OJMfvQRFagh7K9HPxmojanOqboKzjvsOeMt
	 kOXfzuiSyj8vDlSL4rSBJcwsyTiPmn0EUSulGBdANOdaN6Vh5RyITB2HUQ4q/2q51kA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795087742;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=rT49vqX0d2z5yeuabJbBdwkVravn81cAUid9mwENomY=;
	b=WLCrSzPPmlkCq+YTwQLxbEi3Sxf17uGCKgCNTScb6DVCxuomxj3X3p/K7sIfyf4/ojcU
	 kvt9grjWAga5LfEmyx8tWJ+Vuu/3yj2KpxZ6qPiwbfDJ7E4OLjHjhRBT1jFZ2PPz0WfWp
	 uKCv68ceFbJAj7rP2flSybu1RV6mA2wiTF7vj5pmGdWkURreh1Ib+2lfyhRqjLg2gJOLL
	 CPg0gf89mLJlxCNiT4BK5sKjUJK2dPjIXXd500N+a2sRlYnoPDFY0gBiBzLNfKGiTeLsZ
	 C5zSpnpmNYzKh8+o/d2SMmsaQ/nSEOLBhDCsT2fcV9fwl9vkxTMshRlffBo5cqY4scg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=S0cZMpCL;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524C9606A324;
	Thu, 19 Nov 2026 11:29:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 524C9606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=S0cZMpCL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795087742; x=1826623742;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=am2GaxzuuxixHXIPR8eVr72TaNxgHF9IMiwJVeXwZkg=;
  b=S0cZMpCL/iJ32juj5FDuQT3uopnICZtiEnjMcxJFdQNBqjKP3/yTqgfo
   1QaCBvAExiL97ph9tMFtnX4R3RaYTDYmvauYOXjXBS91Oy9xF+ghZOALU
   r8wv1bBXlHdFq6ZQVLwWkhDLFJNkJMc2LokJMGUAKjVODFHGZyT+h+xh9
   fcm9Zev/0NaYk39AYIa1nChs3iXrqfHRSFEKml3Ty0XgXHOyGQu9d/8OO
   0oGKt3ehYPFFm7Td431vpS8bVObADIJ3zjjTFwe1mWHol+/H2s7WPoMEe
   jAMJOOR+LnuVAd6iMos/9DiyRslkUaKaZd6ROY3goLhtetj6u1V8vE7P4
   w==;
X-CSE-ConnectionGUID: n1ZuHzsnQNu6SVn1+r3Ldg==
X-CSE-MsgGUID: Wl0rEWf4TmusY48PcQS+2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="4012136"
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="4012136"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 03:29:01 -0800
X-CSE-ConnectionGUID: 0cMWW9MbQaqwfWljk0pIIQ==
X-CSE-MsgGUID: bfc1o6b0QKC5L9UrztxXKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="10274588"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.132])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 03:28:55 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 19 Nov 2026 13:28:50 +0200 (EET)
To: Ehab Ababneh <ehab.ababneh@intel.com>
cc: Hans de Goede <hansg@kernel.org>, tony.luck@intel.com, 
    Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>, 
    Ingo Molnar <mingo@redhat.com>, ashok.raj.linux@gmail.com, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
    rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
    linux-trace-kernel@vger.kernel.org, 
    sathyanarayanan.kuppuswamy@linux.intel.com, pengfei.xu@intel.com, 
    ravi.v.shankar@intel.com
Subject: Re: [PATCH v2 07/17] stop_machine: Add stop_cluster_cpuslocked()
 for per-cluster operations
In-Reply-To: <20261118193259.519568-8-ehab.ababneh@intel.com>
Message-ID: <61f51eda-ed44-0f0a-86b8-522134896d17@linux.intel.com>
References: <20261118193259.519568-1-ehab.ababneh@intel.com> <20261118193259.519568-8-ehab.ababneh@intel.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 18 Nov 2026, Ehab Ababneh wrote:

> From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> 
> There is already stop_core_cpuslocked() for hardware core-level testing

Please rewrite this paragraph, as is it starts at middle of nowhere so it 
won't connect to anything.

Do not depend on shortlog in the changelog body, the body should be 100% 
readable on its own.

> features, which requires near-simultaneous execution of the WRMSR
> instruction on all threads of a core to initiate a test. However, some
> hardware requires this simultaneous execution of WRMSR at the cluster
> level.

Something along the lines of:

stop_core_cpuslocked() is limited in performing simultaneous execution of 
WRMSR on all threads of a core. However, ...

That will immediately tell the reader there's a limitation and why the 
limitation has to be removed.

I'm not sure if "for hardware core-level testing features" is that 
necessary at all (perhaps that's from LLM that wanted to describe 
unnecessary details like it usually does).

"some hardware" is vague, please be precise.

> Add stop_cluster_cpuslocked(), a customized version of
> stop_machine_cpuslocked() for operating solely on the threads of a
> single cluster.
> 
> Suggested-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Signed-off-by: Ehab Ababneh <ehab.ababneh@intel.com>
> Tested-by: Yi Lai <yi1.lai@intel.com>
> ---
>  include/linux/stop_machine.h | 15 +++++++++++++++
>  kernel/stop_machine.c        | 35 ++++++++++++++++++++++-------------
>  2 files changed, 37 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/stop_machine.h b/include/linux/stop_machine.h
> index 84e7fb627ba4..a189f405a4f2 100644
> --- a/include/linux/stop_machine.h
> +++ b/include/linux/stop_machine.h
> @@ -157,6 +157,21 @@ int stop_machine_cpuslocked(cpu_stop_fn_t fn, void *data, const struct cpumask *
>   */
>  int stop_core_cpuslocked(unsigned int cpu, cpu_stop_fn_t fn, void *data);
>  
> +/**
> + * stop_cluster_cpuslocked: - stop all threads on a CPU cluster

Extra :

> + * @cpu: any CPU in the targeted cluster
> + * @fn: the function to run
> + * @data: the data ptr for @fn()
> + *
> + * Same as above, only the CPUs associated with a single CPU cluster are affected.
> + *
> + * Context: Must be called from within a cpus_read_lock() protected region.
> + *
> + * Return: 0 if all executions of @fn returned 0, any non zero return
> + * value if any returned non zero.
> + */
> +int stop_cluster_cpuslocked(unsigned int cpu, cpu_stop_fn_t fn, void *data);
> +
>  int stop_machine_from_inactive_cpu(cpu_stop_fn_t fn, void *data,
>  				   const struct cpumask *cpus);
>  #else	/* CONFIG_SMP || CONFIG_HOTPLUG_CPU */
> diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
> index d085ba1f4b44..1afda0ddfb90 100644
> --- a/kernel/stop_machine.c
> +++ b/kernel/stop_machine.c
> @@ -630,32 +630,41 @@ int stop_machine(cpu_stop_fn_t fn, void *data, const struct cpumask *cpus)
>  }
>  EXPORT_SYMBOL_GPL(stop_machine);
>  
> -#ifdef CONFIG_SCHED_SMT
> -/*
> - * INTEL_IFS is the only user of this API. That selftest can
> - * only be compiled if SMP=y. On x86 it selects SCHED_SMT.
> - * Keep the ifdefs for now.
> - */
> -int stop_core_cpuslocked(unsigned int cpu, cpu_stop_fn_t fn, void *data)
> +static int stop_cpus_cpuslocked(const struct cpumask *cpus, cpu_stop_fn_t fn, void *data)
>  {
> -	const struct cpumask *smt_mask = cpu_smt_mask(cpu);
> -
>  	struct multi_stop_data msdata = {
>  		.fn = fn,
>  		.data = data,
> -		.num_threads = cpumask_weight(smt_mask),
> -		.active_cpus = smt_mask,
> +		.num_threads = cpumask_weight(cpus),
> +		.active_cpus = cpus,
>  	};
>  
>  	lockdep_assert_cpus_held();
>  
> -	/* Set the initial state and stop all online cpus. */
> +	/* Set the initial state and stop all online @cpus. */
>  	set_state(&msdata, MULTI_STOP_PREPARE);
> -	return stop_cpus(smt_mask, multi_cpu_stop, &msdata);
> +	return stop_cpus(cpus, multi_cpu_stop, &msdata);
> +}
> +
> +#ifdef CONFIG_SCHED_SMT
> +/*
> + * INTEL_IFS is the only user of this API. That selftest can
> + * only be compiled if SMP=y. On x86 it selects SCHED_SMT.
> + * Keep the ifdefs for now.
> + */
> +int stop_core_cpuslocked(unsigned int cpu, cpu_stop_fn_t fn, void *data)
> +{
> +	return stop_cpus_cpuslocked(cpu_smt_mask(cpu), fn, data);
>  }
>  EXPORT_SYMBOL_GPL(stop_core_cpuslocked);
>  #endif
>  
> +int stop_cluster_cpuslocked(unsigned int cpu, cpu_stop_fn_t fn, void *data)
> +{
> +	return stop_cpus_cpuslocked(topology_cluster_cpumask(cpu), fn, data);
> +}
> +EXPORT_SYMBOL_GPL(stop_cluster_cpuslocked);
> +
>  /**
>   * stop_machine_from_inactive_cpu - stop_machine() from inactive CPU
>   * @fn: the function to run
> 

-- 
 i.

