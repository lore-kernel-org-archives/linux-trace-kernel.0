Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E751CDFC3;
	Thu, 10 Oct 2024 20:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728590790; cv=none; b=pmFsmQI9HMfAJxWlDyhK95/76Kd8q4XQf2YXAX3orVsvfPycIsbtFV1wjv4DBOC5P0WQtyrAUgyvZ0TuPuOV9mobylw/BPuL3A/z5W5fBhEpdaJWIYBp8jqKz7gxTBqzz5ujOZrxIkRQkCDF7JFAKYQkd3QaxpUBlJXiY2DHy3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728590790; c=relaxed/simple;
	bh=5EnkSkJVhfd1OGMGM54oHPSo3LTia12UJMp8e7AmIOs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sQiDkEdvScY+wNADJ1S/InVxDPbmLsiTQauIZ35B+anZ9VLYbMokMbPA5UnoN9IsXVU9ZPz8SlQTnjhS0gqzcEi42rqFZABC5TshkoYmCinsn4c8peb1+RSXHh+LPobQSIZ0B5aHeJ5AjZD4xFBu2Bk/l/0Y6uQQUAGYml+GLFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F3CC4CECC;
	Thu, 10 Oct 2024 20:06:29 +0000 (UTC)
Date: Thu, 10 Oct 2024 16:06:37 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: tglozar@redhat.com
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 jwyatt@redhat.com, jkacur@redhat.com
Subject: Re: [PATCH RESEND v3 3/6] rtla/utils: Add idle state disabling via
 libcpupower
Message-ID: <20241010160637.4340b269@gandalf.local.home>
In-Reply-To: <20241004095014.2492813-4-tglozar@redhat.com>
References: <20241004095014.2492813-1-tglozar@redhat.com>
	<20241004095014.2492813-4-tglozar@redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  4 Oct 2024 11:50:11 +0200
tglozar@redhat.com wrote:

> From: Tomas Glozar <tglozar@redhat.com>
> 
> Add functions to utils.c to disable idle states through functions of
> libcpupower. This will serve as the basis for disabling idle states
> per cpu when running timerlat.
> 
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
>  tools/tracing/rtla/src/utils.c | 150 +++++++++++++++++++++++++++++++++
>  tools/tracing/rtla/src/utils.h |  13 +++
>  2 files changed, 163 insertions(+)
> 
> diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/utils.c
> index 9ac71a66840c..6ae084fdedf9 100644
> --- a/tools/tracing/rtla/src/utils.c
> +++ b/tools/tracing/rtla/src/utils.c
> @@ -4,6 +4,9 @@
>   */
>  
>  #define _GNU_SOURCE
> +#ifdef HAVE_LIBCPUPOWER_SUPPORT
> +#include <cpuidle.h>
> +#endif /* HAVE_LIBCPUPOWER_SUPPORT */
>  #include <dirent.h>
>  #include <stdarg.h>
>  #include <stdlib.h>
> @@ -519,6 +522,153 @@ int set_cpu_dma_latency(int32_t latency)
>  	return fd;
>  }
>  
> +#ifdef HAVE_LIBCPUPOWER_SUPPORT
> +static unsigned int **saved_cpu_idle_disable_state;
> +static size_t saved_cpu_idle_disable_state_alloc_ctr;
> +
> +/*
> + * save_cpu_idle_state_disable - save disable for all idle states of a cpu
> + *
> + * Saves the current disable of all idle states of a cpu, to be subsequently
> + * restored via restore_cpu_idle_disable_state.
> + *
> + * Return: idle state count on success, negative on error
> + */
> +int save_cpu_idle_disable_state(unsigned int cpu)
> +{
> +	unsigned int nr_states;
> +	unsigned int state;
> +	int disabled;
> +	int nr_cpus;
> +
> +	nr_states = cpuidle_state_count(cpu);
> +
> +	if (nr_states == 0)
> +		return 0;

If nr_states is zero, this returns 0 without ever allocating
saved_cpu_idle_disable_state.


> +
> +	if (saved_cpu_idle_disable_state == NULL) {
> +		nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
> +		saved_cpu_idle_disable_state = calloc(nr_cpus, sizeof(unsigned int *));
> +		if (!saved_cpu_idle_disable_state)
> +			return -1;
> +	}
> +
> +	saved_cpu_idle_disable_state[cpu] = calloc(nr_states, sizeof(unsigned int));
> +	if (!saved_cpu_idle_disable_state[cpu])
> +		return -1;
> +	saved_cpu_idle_disable_state_alloc_ctr++;
> +
> +	for (state = 0; state < nr_states; state++) {
> +		disabled = cpuidle_is_state_disabled(cpu, state);
> +		if (disabled < 0)
> +			return disabled;
> +		saved_cpu_idle_disable_state[cpu][state] = disabled;
> +	}
> +
> +	return nr_states;
> +}
> +
> +/*
> + * restore_cpu_idle_disable_state - restore disable for all idle states of a cpu
> + *
> + * Restores the current disable state of all idle states of a cpu that was
> + * previously saved by save_cpu_idle_disable_state.
> + *
> + * Return: idle state count on success, negative on error
> + */
> +int restore_cpu_idle_disable_state(unsigned int cpu)
> +{
> +	unsigned int nr_states;
> +	unsigned int state;
> +	int disabled;
> +	int result;
> +
> +	if (!saved_cpu_idle_disable_state)
> +		return -1;

This returns -1 even if nr_states is zero. That is,
save_cpu_idle_disable_state() can return success, but this restore will
return failure.

-- Steve


> +
> +	nr_states = cpuidle_state_count(cpu);
> +
> +	if (nr_states == 0)
> +		return 0;
> +
> +	for (state = 0; state < nr_states; state++) {
> +		if (!saved_cpu_idle_disable_state[cpu])
> +			return -1;
> +		disabled = saved_cpu_idle_disable_state[cpu][state];
> +		result = cpuidle_state_disable(cpu, state, disabled);
> +		if (result < 0)
> +			return result;
> +	}
> +
> +	free(saved_cpu_idle_disable_state[cpu]);
> +	saved_cpu_idle_disable_state[cpu] = NULL;
> +	saved_cpu_idle_disable_state_alloc_ctr--;
> +	if (saved_cpu_idle_disable_state_alloc_ctr == 0) {
> +		free(saved_cpu_idle_disable_state);
> +		saved_cpu_idle_disable_state = NULL;
> +	}
> +
> +	return nr_states;
> +}
> +
> +/*
> + * free_cpu_idle_disable_states - free saved idle state disable for all cpus
> + *
> + * Frees the memory used for storing cpu idle state disable for all cpus
> + * and states.
> + *
> + * Normally, the memory is freed automatically in
> + * restore_cpu_idle_disable_state; this is mostly for cleaning up after an
> + * error.
> + */
> +void free_cpu_idle_disable_states(void)
> +{
> +	int cpu;
> +	int nr_cpus;
> +
> +	if (!saved_cpu_idle_disable_state)
> +		return;
> +
> +	nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
> +
> +	for (cpu = 0; cpu < nr_cpus; cpu++) {
> +		free(saved_cpu_idle_disable_state[cpu]);
> +		saved_cpu_idle_disable_state[cpu] = NULL;
> +	}
> +
> +	free(saved_cpu_idle_disable_state);
> +	saved_cpu_idle_disable_state = NULL;
> +}
> +
> +/*
> + * set_deepest_cpu_idle_state - limit idle state of cpu
> + *
> + * Disables all idle states deeper than the one given in
> + * deepest_state (assuming states with higher number are deeper).
> + *
> + * This is used to reduce the exit from idle latency. Unlike
> + * set_cpu_dma_latency, it can disable idle states per cpu.
> + *
> + * Return: idle state count on success, negative on error
> + */
> +int set_deepest_cpu_idle_state(unsigned int cpu, unsigned int deepest_state)
> +{
> +	unsigned int nr_states;
> +	unsigned int state;
> +	int result;
> +
> +	nr_states = cpuidle_state_count(cpu);
> +
> +	for (state = deepest_state + 1; state < nr_states; state++) {
> +		result = cpuidle_state_disable(cpu, state, 1);
> +		if (result < 0)
> +			return result;
> +	}
> +
> +	return nr_states;
> +}
> +#endif /* HAVE_LIBCPUPOWER_SUPPORT */
> +
>  #define _STR(x) #x
>  #define STR(x) _STR(x)
>  
> diff --git a/tools/tracing/rtla/src/utils.h b/tools/tracing/rtla/src/utils.h
> index d44513e6c66a..e439db7fc848 100644
> --- a/tools/tracing/rtla/src/utils.h
> +++ b/tools/tracing/rtla/src/utils.h
> @@ -64,6 +64,19 @@ int set_comm_sched_attr(const char *comm_prefix, struct sched_attr *attr);
>  int set_comm_cgroup(const char *comm_prefix, const char *cgroup);
>  int set_pid_cgroup(pid_t pid, const char *cgroup);
>  int set_cpu_dma_latency(int32_t latency);
> +#ifdef HAVE_LIBCPUPOWER_SUPPORT
> +int save_cpu_idle_disable_state(unsigned int cpu);
> +int restore_cpu_idle_disable_state(unsigned int cpu);
> +void free_cpu_idle_disable_states(void);
> +int set_deepest_cpu_idle_state(unsigned int cpu, unsigned int state);
> +static inline int have_libcpupower_support(void) { return 1; }
> +#else
> +static inline int save_cpu_idle_disable_state(unsigned int cpu) { return -1; }
> +static inline int restore_cpu_idle_disable_state(unsigned int cpu) { return -1; }
> +static inline void free_cpu_idle_disable_states(void) { }
> +static inline int set_deepest_cpu_idle_state(unsigned int cpu, unsigned int state) { return -1; }
> +static inline int have_libcpupower_support(void) { return 0; }
> +#endif /* HAVE_LIBCPUPOWER_SUPPORT */
>  int auto_house_keeping(cpu_set_t *monitored_cpus);
>  
>  #define ns_to_usf(x) (((double)x/1000))

