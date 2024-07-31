Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A6A1AD9FE;
	Wed, 31 Jul 2024 15:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722441109; cv=none; b=tc4xQfd/K2vYgTLXjlah8PVYPNP5KzVN9xdUpT9DGzmk0rqHIcTN7D09SnCe5EyM7OazIH534WLg6yFqJs3BM7782oGeR/cI8zjYoUCPBEpIVfIgiDuLU03YRGbdR0IkuGgJ0uJvYuEhzS2C9vbIkR3NJctXGyQHuT7mBOaHvKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722441109; c=relaxed/simple;
	bh=sHoaTphO82tBC4+EhCDCDI0u09HIu+sTJ4X78ZvWgJk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hDEh2dBAXm6Ii1ulcw+QYSNhEDD4XLDuQEMFkV9XlIwr3RPKgISsUB6RNfFgwExEsj2ZPFfttOEk3FgZo70WmJ8Fez/xw/67a25oJab9KQLMwe0+d4ai7HnmhThDybLQo72LkkedWe9SFzjghhk18NGZTFwflFZx4BUWsWy/UQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9804BC116B1;
	Wed, 31 Jul 2024 15:51:48 +0000 (UTC)
Date: Wed, 31 Jul 2024 11:52:22 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: tglozar@redhat.com
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 jwyatt@redhat.com, jkacur@redhat.com
Subject: Re: [PATCH v2 4/6] rtla/timerlat: Add --deepest-idle-state for top
Message-ID: <20240731115222.21e99427@gandalf.local.home>
In-Reply-To: <20240731083655.375293-5-tglozar@redhat.com>
References: <20240731083655.375293-1-tglozar@redhat.com>
	<20240731083655.375293-5-tglozar@redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Jul 2024 10:36:53 +0200
tglozar@redhat.com wrote:

> From: Tomas Glozar <tglozar@redhat.com>
> 
> Add option to limit deepest idle state on CPUs where timerlat is running
> for the duration of the workload.
> 
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
>  tools/tracing/rtla/src/timerlat_top.c | 46 ++++++++++++++++++++++++++-
>  1 file changed, 45 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
> index 8c16419fe22a..ef1d3affef95 100644
> --- a/tools/tracing/rtla/src/timerlat_top.c
> +++ b/tools/tracing/rtla/src/timerlat_top.c
> @@ -48,6 +48,7 @@ struct timerlat_top_params {
>  	int			pretty_output;
>  	int			warmup;
>  	int			buffer_size;
> +	int			deepest_idle_state;
>  	cpu_set_t		hk_cpu_set;
>  	struct sched_attr	sched_param;
>  	struct trace_events	*events;
> @@ -447,7 +448,7 @@ static void timerlat_top_usage(char *usage)
>  		"",
>  		"  usage: rtla timerlat [top] [-h] [-q] [-a us] [-d s] [-D] [-n] [-p us] [-i us] [-T us] [-s us] \\",
>  		"	  [[-t[file]] [-e sys[:event]] [--filter <filter>] [--trigger <trigger>] [-c cpu-list] [-H cpu-list]\\",
> -		"	  [-P priority] [--dma-latency us] [--aa-only us] [-C[=cgroup_name]] [-u|-k] [--warm-up s]",
> +		"	  [-P priority] [--dma-latency us] [--aa-only us] [-C[=cgroup_name]] [-u|-k] [--warm-up s] [--deepest-idle-state n]",
>  		"",
>  		"	  -h/--help: print this menu",
>  		"	  -a/--auto: set automatic trace mode, stopping the session if argument in us latency is hit",
> @@ -481,6 +482,7 @@ static void timerlat_top_usage(char *usage)
>  		"	  -U/--user-load: enable timerlat for user-defined user-space workload",
>  		"	     --warm-up s: let the workload run for s seconds before collecting data",
>  		"	     --trace-buffer-size kB: set the per-cpu trace buffer size in kB",

Could probably do:

#ifdef HAVE_LIBCPUPOWER_SUPPORT
> +		"	     --deepest-idle-state n: only go down to idle state n on cpus used by timerlat to reduce exit from idle latency",
#else
+		"	     --deepest-idle-state n: [rtla built without libcpupower, --deepest-idle-state is not supported]",
#endif

>  		NULL,
>  	};
>  
> @@ -518,6 +520,9 @@ static struct timerlat_top_params
>  	/* disabled by default */
>  	params->dma_latency = -1;
>  
> +	/* disabled by default */
> +	params->deepest_idle_state = -2;
> +
>  	/* display data in microseconds */
>  	params->output_divisor = 1000;
>  
> @@ -550,6 +555,7 @@ static struct timerlat_top_params
>  			{"aa-only",		required_argument,	0, '5'},
>  			{"warm-up",		required_argument,	0, '6'},
>  			{"trace-buffer-size",	required_argument,	0, '7'},
> +			{"deepest-idle-state",	required_argument,	0, '8'},
>  			{0, 0, 0, 0}
>  		};
>  
> @@ -726,6 +732,9 @@ static struct timerlat_top_params
>  		case '7':
>  			params->buffer_size = get_llong_from_str(optarg);
>  			break;
> +		case '8':
> +			params->deepest_idle_state = get_llong_from_str(optarg);
> +			break;
>  		default:
>  			timerlat_top_usage("Invalid option");
>  		}
> @@ -922,6 +931,9 @@ int timerlat_top_main(int argc, char *argv[])
>  	int return_value = 1;
>  	char *max_lat;
>  	int retval;
> +#ifdef HAVE_LIBCPUPOWER_SUPPORT
> +	int i;
> +#endif /* HAVE_LIBCPUPOWER_SUPPORT */
>  
>  	params = timerlat_top_parse_args(argc, argv);
>  	if (!params)
> @@ -971,6 +983,26 @@ int timerlat_top_main(int argc, char *argv[])
>  		}
>  	}
>  
> +	if (params->deepest_idle_state >= -1) {
> +#ifdef HAVE_LIBCPUPOWER_SUPPORT
> +		for (i = 0; i < sysconf(_SC_NPROCESSORS_CONF); i++) {
> +			if (params->cpus && !CPU_ISSET(i, &params->monitored_cpus))
> +				continue;
> +			if (save_cpu_idle_disable_state(i) < 0) {
> +				err_msg("Could not save cpu idle state.\n");
> +				goto out_free;
> +			}
> +			if (set_deepest_cpu_idle_state(i, params->deepest_idle_state) < 0) {
> +				err_msg("Could not set deepest cpu idle state.\n");
> +				goto out_free;
> +			}
> +		}
> +#else
> +		err_msg("rtla built without libcpupower, --deepest-idle-state is not supported\n");
> +		goto out_free;
> +#endif /* HAVE_LIBCPUPOWER_SUPPORT */

We could get rid of most of the ifdefs if you changed the header file to be:

#ifdef HAVE_LIBCPUPOWER_SUPPORT
int save_cpu_idle_disable_state(unsigned int cpu);
int restore_cpu_idle_disable_state(unsigned int cpu);
void free_cpu_idle_disable_states(void);
int set_deepest_cpu_idle_state(unsigned int cpu, unsigned int state);
static inline have_libcpower_support(void) { return 1; }
#else
static inline int save_cpu_idle_disable_state(unsigned int cpu) { return -1 }
static inline int restore_cpu_idle_disable_state(unsigned int cpu) { return -1; }
static inline void free_cpu_idle_disable_states(void) { }
static inline int set_deepest_cpu_idle_state(unsigned int cpu, unsigned int state) { return -1 }
static inline have_libcpower_support(void) { return 0; }
#endif /* HAVE_LIBCPUPOWER_SUPPORT */


Then the above can simply be:

	if (params->deepest_idle_state >= -1) {

		if (!have_libcpower_support()) {
			err_msg("rtla built without libcpupower, --deepest-idle-state is not supported\n");
			goto out_free;
		}

		for (i = 0; i < sysconf(_SC_NPROCESSORS_CONF); i++) {
			if (params->cpus && !CPU_ISSET(i, &params->monitored_cpus))
				continue;
			if (save_cpu_idle_disable_state(i) < 0) {
				err_msg("Could not save cpu idle state.\n");
				goto out_free;
			}
			if (set_deepest_cpu_idle_state(i, params->deepest_idle_state) < 0) {
				err_msg("Could not set deepest cpu idle state.\n");
				goto out_free;
			}
		}

Makes the code much nicer to look at.

> +	}
> +
>  	if (params->trace_output) {
>  		record = osnoise_init_trace_tool("timerlat");
>  		if (!record) {
> @@ -1125,6 +1157,15 @@ int timerlat_top_main(int argc, char *argv[])
>  	timerlat_aa_destroy();
>  	if (dma_latency_fd >= 0)
>  		close(dma_latency_fd);
> +#ifdef HAVE_LIBCPUPOWER_SUPPORT
> +	if (params->deepest_idle_state >= -1) {
> +		for (i = 0; i < sysconf(_SC_NPROCESSORS_CONF); i++) {

You would think gcc may optimize it, but I don't have that much confidence
it can or would. You may want to change that to:

		int nr_cpus = sysconf(_SC_NPROCESSORS_CONF);

		for (i = 0; i < nr_cpus; i++) {

Otherwise you may be calling that sysconf() for each iteration of the loop.

-- Steve

> +			if (params->cpus && !CPU_ISSET(i, &params->monitored_cpus))
> +				continue;
> +			restore_cpu_idle_disable_state(i);
> +		}
> +	}
> +#endif /* HAVE_LIBCPUPOWER_SUPPORT */
>  	trace_events_destroy(&record->trace, params->events);
>  	params->events = NULL;
>  out_free:
> @@ -1134,6 +1175,9 @@ int timerlat_top_main(int argc, char *argv[])
>  	osnoise_destroy_tool(record);
>  	osnoise_destroy_tool(top);
>  	free(params);
> +#ifdef HAVE_LIBCPUPOWER_SUPPORT
> +	free_cpu_idle_disable_states();
> +#endif /* HAVE_LIBCPUPOWER_SUPPORT */
>  out_exit:
>  	exit(return_value);
>  }

