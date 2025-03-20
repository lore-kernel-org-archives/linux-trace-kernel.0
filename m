Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB2D227E84
	for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Mar 2025 19:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742498887; cv=none; b=YJv6sQrY/BmzExbVpeISFkbGP7ZbjWCN4DxqH0Gn2NcN1XNGNJysi7hurrqsXKaa2CjTfwfWvBDLyqAiBEFmg5wOYEmk1NqGgthGOWhQ9Hr6FfYdrfDhxk/p21+yMSNrNQYZi9wocOuPaD3oECka8V0JbBtR6B3GC2jVHavfyYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742498887; c=relaxed/simple;
	bh=uLpyElJsLBlCf2ZGzTLRhFUkPl6Hp3k0LdLV2yfn3PA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=YOFC8yBTTdmwFYGC+Ndd6/pV7rDCSfbCDF3czyP7jfSnawS9C5n3PhA4bgeeqlF/Mjv9juYYhyvlBhWrTQp2zvldqT+L9iRA8Pugn3LQqqFYvFC+Pn6FJCRCEEw17l6EAvqo6T/gXIWUHOfGIjNRgahSwVUcB+c5Y3tLvXVnAME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AMZJgCRE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AMZJgCRE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742498883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CLF81VeXeOX1zGhjO0VlKCrB3y5MRqHukB1ANBUNRQg=;
	b=AMZJgCRE6QM2DwBnwJyzA8R8KL8f7eWJF6wOtX8He8m4CZI2ah4k8sBUUBoYiivEXbrKHl
	ZBrKokK4ytyJ6GLXPIX82X48TcKmm+ioUhHw86BPy6oIH8lbwyzLkzcHPo3D2ligXP5tP/
	2mIDVxKuwpJTY5I4IEYv2k/CdAK1v64=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-KprkoTcWNOqoJgcTh8OtkQ-1; Thu, 20 Mar 2025 15:28:01 -0400
X-MC-Unique: KprkoTcWNOqoJgcTh8OtkQ-1
X-Mimecast-MFC-AGG-ID: KprkoTcWNOqoJgcTh8OtkQ_1742498881
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c0a71aaf9fso327063885a.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Mar 2025 12:28:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742498881; x=1743103681;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CLF81VeXeOX1zGhjO0VlKCrB3y5MRqHukB1ANBUNRQg=;
        b=uqT7J+6XXlB5LKesAdhFwv1u5CJNshav4BK4ISYcIatyRIfxkHfL2doO2HzXgJJZKL
         RqZrh0XvaSvtJoLiSxiHptV53OGdQrG0TV1Fpa7/u2V0fNAqhOpvBpYv+U64/C02iEN3
         41Q8qxKX4kYGP+CWtHyD+SBwPgLYpS/RBGjbxNqSCdNX2YBXhxdlHtOPUPN1FVs98HQY
         VDDQ9LtKYXZWwxgtaGV+cuV+5Y4MVjteeXwxD/y3oIEEnWwsntFqDOFYaI3FBAfkTK0k
         o7wECaJHVPT2DWHDwjzNTwu0Owa8cTE+s7DmuhZzpSK+WGFa0ypZ5HBRmxsWVuigdgzS
         Y7MA==
X-Forwarded-Encrypted: i=1; AJvYcCXTG2oRdmvu2GdBcT5Tavs0SkqqkGthxrQxdDjaO9Sei6akKh0aZxNnUq3GWxYu+1M4gu/58SosI52eqEqY6M59iUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvnmpoRc5xtlbvgY5ykNYDKfGV+/OzgFR4+cJZR2+PkiZc+gK9
	aBvNHNsrh8vcjE06+JuqMkeRoPYbv/4KI+ZBIiEXp0crqCyqHeSXcCWYTy2IwPl7BFFnwNZnyMn
	jR3w4cBh5ESmpD7nSclZOxkuzwnrWdXWc/AmjzK4JTqkBI9tQfiDfMmbC9/4A2K5sZNxJdQ==
X-Gm-Gg: ASbGncui/fkQjze/mAL91N83rtJ5tnMT+olH4s1ksFb0HrdRKqSZiT9dxFViYxiINs0
	5lwbCnNT++/hgh/7fCXKJyPEnw8B5TAoJzzXxqoohVUgU1hQE5u0XaG0b5uZ+sp6g7vpL4o6RZ4
	e7uwM2VS3EuM/BeJ7JH/CeOGILp8+KmwjcC1a5xTvYsJrs0vWVUoxRXhMU6U7dFXuMZQR0JrXB9
	5LItr5kh+jIdCROBQYG7vwbI3ZlMEyM17fTJ9oWmjQ3O6qNBy3Ae+ezqm8AZFYbwa+kzoBKDKON
X-Received: by 2002:a05:620a:2486:b0:7c3:c9f4:522 with SMTP id af79cd13be357-7c5ba16185bmr50067285a.14.1742498880644;
        Thu, 20 Mar 2025 12:28:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfw5/2FOr5YPPpUndqar/nsM2jLEYzIw+tbYDzlcJHQ3UVWusSc3zMMoFaTcvnzkrcBtgGhg==
X-Received: by 2002:a05:620a:2486:b0:7c3:c9f4:522 with SMTP id af79cd13be357-7c5ba16185bmr50063785a.14.1742498880165;
        Thu, 20 Mar 2025 12:28:00 -0700 (PDT)
Received: from fionn ([76.69.33.37])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b9347bd1sm24018085a.70.2025.03.20.12.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 12:27:59 -0700 (PDT)
Date: Thu, 20 Mar 2025 15:27:48 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
cc: Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org, 
    linux-kernel@vger.kernel.org, Luis Goncalves <lgoncalv@redhat.com>
Subject: Re: [PATCH 2/6] rtla: Unify apply_config between top and hist
In-Reply-To: <20250320092500.101385-3-tglozar@redhat.com>
Message-ID: <358dc2ec-93e3-893b-d487-2684f7d242a8@redhat.com>
References: <20250320092500.101385-1-tglozar@redhat.com> <20250320092500.101385-3-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Y2EQAHbbgcDNB-m9c4lrdbD1YNduxlJN_aWbfrk7Yrw_1742498881
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII



On Thu, 20 Mar 2025, Tomas Glozar wrote:

> The functions osnoise_top_apply_config and osnoise_hist_apply_config, as
> well as timerlat_top_apply_config and timerlat_hist_apply_config, are
> mostly the same.
> 
> Move common part from them into separate functions osnoise_apply_config
> and timerlat_apply_config.
> 
> For rtla-timerlat, also unify params->user_hist and params->user_top
> into one field called params->user_data, and move several fields used
> only by timerlat-top into the top-only section of struct
> timerlat_params.
> 
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
>  tools/tracing/rtla/src/osnoise.c       |  79 ++++++++++++++++
>  tools/tracing/rtla/src/osnoise.h       |   1 +
>  tools/tracing/rtla/src/osnoise_hist.c  |  66 +-------------
>  tools/tracing/rtla/src/osnoise_top.c   |  66 +-------------
>  tools/tracing/rtla/src/timerlat.c      | 109 ++++++++++++++++++++++
>  tools/tracing/rtla/src/timerlat.h      |  11 +--
>  tools/tracing/rtla/src/timerlat_hist.c | 119 ++++---------------------
>  tools/tracing/rtla/src/timerlat_top.c  | 110 +++--------------------
>  8 files changed, 227 insertions(+), 334 deletions(-)
> 
> diff --git a/tools/tracing/rtla/src/osnoise.c b/tools/tracing/rtla/src/osnoise.c
> index 93d485c0e949..1735a36466c4 100644
> --- a/tools/tracing/rtla/src/osnoise.c
> +++ b/tools/tracing/rtla/src/osnoise.c
> @@ -3,6 +3,7 @@
>   * Copyright (C) 2021 Red Hat Inc, Daniel Bristot de Oliveira <bristot@kernel.org>
>   */
>  
> +#define _GNU_SOURCE
>  #include <sys/types.h>
>  #include <sys/stat.h>
>  #include <pthread.h>
> @@ -12,6 +13,7 @@
>  #include <errno.h>
>  #include <fcntl.h>
>  #include <stdio.h>
> +#include <sched.h>
>  
>  #include "osnoise.h"
>  
> @@ -1114,6 +1116,83 @@ osnoise_report_missed_events(struct osnoise_tool *tool)
>  	}
>  }
>  
> +/*
> + * osnoise_apply_config - apply common configs to the initialized tool
> + */
> +int
> +osnoise_apply_config(struct osnoise_tool *tool, struct osnoise_params *params)
> +{
> +	int retval;
> +
> +	if (!params->sleep_time)
> +		params->sleep_time = 1;
> +
> +	if (params->cpus) {
> +		retval = osnoise_set_cpus(tool->context, params->cpus);
> +		if (retval) {
> +			err_msg("Failed to apply CPUs config\n");
> +			goto out_err;
> +		}
> +	}
> +
> +	if (params->runtime || params->period) {
> +		retval = osnoise_set_runtime_period(tool->context,
> +						    params->runtime,
> +						    params->period);
> +		if (retval) {
> +			err_msg("Failed to set runtime and/or period\n");
> +			goto out_err;
> +		}
> +	}
> +
> +	if (params->stop_us) {
> +		retval = osnoise_set_stop_us(tool->context, params->stop_us);
> +		if (retval) {
> +			err_msg("Failed to set stop us\n");
> +			goto out_err;
> +		}
> +	}
> +
> +	if (params->stop_total_us) {
> +		retval = osnoise_set_stop_total_us(tool->context, params->stop_total_us);
> +		if (retval) {
> +			err_msg("Failed to set stop total us\n");
> +			goto out_err;
> +		}
> +	}
> +
> +	if (params->threshold) {
> +		retval = osnoise_set_tracing_thresh(tool->context, params->threshold);
> +		if (retval) {
> +			err_msg("Failed to set tracing_thresh\n");
> +			goto out_err;
> +		}
> +	}
> +
> +	if (params->hk_cpus) {
> +		retval = sched_setaffinity(getpid(), sizeof(params->hk_cpu_set),
> +					   &params->hk_cpu_set);
> +		if (retval == -1) {
> +			err_msg("Failed to set rtla to the house keeping CPUs\n");
> +			goto out_err;
> +		}
> +	} else if (params->cpus) {
> +		/*
> +		 * Even if the user do not set a house-keeping CPU, try to
> +		 * move rtla to a CPU set different to the one where the user
> +		 * set the workload to run.
> +		 *
> +		 * No need to check results as this is an automatic attempt.
> +		 */
> +		auto_house_keeping(&params->monitored_cpus);
> +	}
> +
> +	return 0;
> +
> +out_err:
> +	return -1;
> +}
> +
>  static void osnoise_usage(int err)
>  {
>  	int i;
> diff --git a/tools/tracing/rtla/src/osnoise.h b/tools/tracing/rtla/src/osnoise.h
> index f78ffbdc8c8d..ac1c99910744 100644
> --- a/tools/tracing/rtla/src/osnoise.h
> +++ b/tools/tracing/rtla/src/osnoise.h
> @@ -155,6 +155,7 @@ struct osnoise_tool *osnoise_init_tool(char *tool_name);
>  struct osnoise_tool *osnoise_init_trace_tool(char *tracer);
>  void osnoise_report_missed_events(struct osnoise_tool *tool);
>  bool osnoise_trace_is_off(struct osnoise_tool *tool, struct osnoise_tool *record);
> +int osnoise_apply_config(struct osnoise_tool *tool, struct osnoise_params *params);
>  
>  int osnoise_hist_main(int argc, char *argv[]);
>  int osnoise_top_main(int argc, char **argv);
> diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
> index 4721f15f77cd..d9d15c8f27c7 100644
> --- a/tools/tracing/rtla/src/osnoise_hist.c
> +++ b/tools/tracing/rtla/src/osnoise_hist.c
> @@ -12,7 +12,6 @@
>  #include <errno.h>
>  #include <stdio.h>
>  #include <time.h>
> -#include <sched.h>
>  
>  #include "osnoise.h"
>  
> @@ -705,68 +704,9 @@ osnoise_hist_apply_config(struct osnoise_tool *tool, struct osnoise_params *para
>  {
>  	int retval;
>  
> -	if (!params->sleep_time)
> -		params->sleep_time = 1;
> -
> -	if (params->cpus) {
> -		retval = osnoise_set_cpus(tool->context, params->cpus);
> -		if (retval) {
> -			err_msg("Failed to apply CPUs config\n");
> -			goto out_err;
> -		}
> -	}
> -
> -	if (params->runtime || params->period) {
> -		retval = osnoise_set_runtime_period(tool->context,
> -						    params->runtime,
> -						    params->period);
> -		if (retval) {
> -			err_msg("Failed to set runtime and/or period\n");
> -			goto out_err;
> -		}
> -	}
> -
> -	if (params->stop_us) {
> -		retval = osnoise_set_stop_us(tool->context, params->stop_us);
> -		if (retval) {
> -			err_msg("Failed to set stop us\n");
> -			goto out_err;
> -		}
> -	}
> -
> -	if (params->stop_total_us) {
> -		retval = osnoise_set_stop_total_us(tool->context, params->stop_total_us);
> -		if (retval) {
> -			err_msg("Failed to set stop total us\n");
> -			goto out_err;
> -		}
> -	}
> -
> -	if (params->threshold) {
> -		retval = osnoise_set_tracing_thresh(tool->context, params->threshold);
> -		if (retval) {
> -			err_msg("Failed to set tracing_thresh\n");
> -			goto out_err;
> -		}
> -	}
> -
> -	if (params->hk_cpus) {
> -		retval = sched_setaffinity(getpid(), sizeof(params->hk_cpu_set),
> -					   &params->hk_cpu_set);
> -		if (retval == -1) {
> -			err_msg("Failed to set rtla to the house keeping CPUs\n");
> -			goto out_err;
> -		}
> -	} else if (params->cpus) {
> -		/*
> -		 * Even if the user do not set a house-keeping CPU, try to
> -		 * move rtla to a CPU set different to the one where the user
> -		 * set the workload to run.
> -		 *
> -		 * No need to check results as this is an automatic attempt.
> -		 */
> -		auto_house_keeping(&params->monitored_cpus);
> -	}
> +	retval = osnoise_apply_config(tool, params);
> +	if (retval)
> +		goto out_err;
>  
>  	return 0;
>  
> diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
> index 7f393019bbf5..3455ee73e2e6 100644
> --- a/tools/tracing/rtla/src/osnoise_top.c
> +++ b/tools/tracing/rtla/src/osnoise_top.c
> @@ -11,7 +11,6 @@
>  #include <unistd.h>
>  #include <stdio.h>
>  #include <time.h>
> -#include <sched.h>
>  
>  #include "osnoise.h"
>  
> @@ -523,50 +522,9 @@ osnoise_top_apply_config(struct osnoise_tool *tool, struct osnoise_params *param
>  {
>  	int retval;
>  
> -	if (!params->sleep_time)
> -		params->sleep_time = 1;
> -
> -	if (params->cpus) {
> -		retval = osnoise_set_cpus(tool->context, params->cpus);
> -		if (retval) {
> -			err_msg("Failed to apply CPUs config\n");
> -			goto out_err;
> -		}
> -	}
> -
> -	if (params->runtime || params->period) {
> -		retval = osnoise_set_runtime_period(tool->context,
> -						    params->runtime,
> -						    params->period);
> -		if (retval) {
> -			err_msg("Failed to set runtime and/or period\n");
> -			goto out_err;
> -		}
> -	}
> -
> -	if (params->stop_us) {
> -		retval = osnoise_set_stop_us(tool->context, params->stop_us);
> -		if (retval) {
> -			err_msg("Failed to set stop us\n");
> -			goto out_err;
> -		}
> -	}
> -
> -	if (params->stop_total_us) {
> -		retval = osnoise_set_stop_total_us(tool->context, params->stop_total_us);
> -		if (retval) {
> -			err_msg("Failed to set stop total us\n");
> -			goto out_err;
> -		}
> -	}
> -
> -	if (params->threshold) {
> -		retval = osnoise_set_tracing_thresh(tool->context, params->threshold);
> -		if (retval) {
> -			err_msg("Failed to set tracing_thresh\n");
> -			goto out_err;
> -		}
> -	}
> +	retval = osnoise_apply_config(tool, params);
> +	if (retval)
> +		goto out_err;
>  
>  	if (params->mode == MODE_HWNOISE) {
>  		retval = osnoise_set_irq_disable(tool->context, 1);
> @@ -576,24 +534,6 @@ osnoise_top_apply_config(struct osnoise_tool *tool, struct osnoise_params *param
>  		}
>  	}
>  
> -	if (params->hk_cpus) {
> -		retval = sched_setaffinity(getpid(), sizeof(params->hk_cpu_set),
> -					   &params->hk_cpu_set);
> -		if (retval == -1) {
> -			err_msg("Failed to set rtla to the house keeping CPUs\n");
> -			goto out_err;
> -		}
> -	} else if (params->cpus) {
> -		/*
> -		 * Even if the user do not set a house-keeping CPU, try to
> -		 * move rtla to a CPU set different to the one where the user
> -		 * set the workload to run.
> -		 *
> -		 * No need to check results as this is an automatic attempt.
> -		 */
> -		auto_house_keeping(&params->monitored_cpus);
> -	}
> -
>  	if (isatty(STDOUT_FILENO) && !params->quiet)
>  		params->pretty_output = 1;
>  
> diff --git a/tools/tracing/rtla/src/timerlat.c b/tools/tracing/rtla/src/timerlat.c
> index 21cdcc5c4a29..448fb1f7d3a6 100644
> --- a/tools/tracing/rtla/src/timerlat.c
> +++ b/tools/tracing/rtla/src/timerlat.c
> @@ -2,6 +2,7 @@
>  /*
>   * Copyright (C) 2021 Red Hat Inc, Daniel Bristot de Oliveira <bristot@kernel.org>
>   */
> +#define _GNU_SOURCE
>  #include <sys/types.h>
>  #include <sys/stat.h>
>  #include <pthread.h>
> @@ -11,9 +12,117 @@
>  #include <errno.h>
>  #include <fcntl.h>
>  #include <stdio.h>
> +#include <sched.h>
>  
>  #include "timerlat.h"
>  
> +/*
> + * timerlat_apply_config - apply common configs to the initialized tool
> + */
> +int
> +timerlat_apply_config(struct osnoise_tool *tool, struct timerlat_params *params)
> +{
> +	int retval, i;
> +
> +	if (!params->sleep_time)
> +		params->sleep_time = 1;
> +
> +	if (params->cpus) {
> +		retval = osnoise_set_cpus(tool->context, params->cpus);
> +		if (retval) {
> +			err_msg("Failed to apply CPUs config\n");
> +			goto out_err;
> +		}
> +	} else {
> +		for (i = 0; i < sysconf(_SC_NPROCESSORS_CONF); i++)
> +			CPU_SET(i, &params->monitored_cpus);
> +	}
> +
> +	if (params->stop_us) {
> +		retval = osnoise_set_stop_us(tool->context, params->stop_us);
> +		if (retval) {
> +			err_msg("Failed to set stop us\n");
> +			goto out_err;
> +		}
> +	}
> +
> +	if (params->stop_total_us) {
> +		retval = osnoise_set_stop_total_us(tool->context, params->stop_total_us);
> +		if (retval) {
> +			err_msg("Failed to set stop total us\n");
> +			goto out_err;
> +		}
> +	}
> +
> +
> +	if (params->timerlat_period_us) {
> +		retval = osnoise_set_timerlat_period_us(tool->context, params->timerlat_period_us);
> +		if (retval) {
> +			err_msg("Failed to set timerlat period\n");
> +			goto out_err;
> +		}
> +	}
> +
> +
> +	if (params->print_stack) {
> +		retval = osnoise_set_print_stack(tool->context, params->print_stack);
> +		if (retval) {
> +			err_msg("Failed to set print stack\n");
> +			goto out_err;
> +		}
> +	}
> +
> +	if (params->hk_cpus) {
> +		retval = sched_setaffinity(getpid(), sizeof(params->hk_cpu_set),
> +					   &params->hk_cpu_set);
> +		if (retval == -1) {
> +			err_msg("Failed to set rtla to the house keeping CPUs\n");
> +			goto out_err;
> +		}
> +	} else if (params->cpus) {
> +		/*
> +		 * Even if the user do not set a house-keeping CPU, try to
> +		 * move rtla to a CPU set different to the one where the user
> +		 * set the workload to run.
> +		 *
> +		 * No need to check results as this is an automatic attempt.
> +		 */
> +		auto_house_keeping(&params->monitored_cpus);
> +	}
> +
> +	/*
> +	 * If the user did not specify a type of thread, try user-threads first.
> +	 * Fall back to kernel threads otherwise.
> +	 */
> +	if (!params->kernel_workload && !params->user_data) {
> +		retval = tracefs_file_exists(NULL, "osnoise/per_cpu/cpu0/timerlat_fd");
> +		if (retval) {
> +			debug_msg("User-space interface detected, setting user-threads\n");
> +			params->user_workload = 1;
> +			params->user_data = 1;
> +		} else {
> +			debug_msg("User-space interface not detected, setting kernel-threads\n");
> +			params->kernel_workload = 1;
> +		}
> +	}
> +
> +	/*
> +	 * Set workload according to type of thread if the kernel supports it.
> +	 * On kernels without support, user threads will have already failed
> +	 * on missing timerlat_fd, and kernel threads do not need it.
> +	 */
> +	retval = osnoise_set_workload(tool->context, params->kernel_workload);
> +	if (retval < -1) {
> +		err_msg("Failed to set OSNOISE_WORKLOAD option\n");
> +		goto out_err;
> +	}
> +
> +	return 0;
> +
> +out_err:
> +	return -1;
> +}
> +
>  static void timerlat_usage(int err)
>  {
>  	int i;
> diff --git a/tools/tracing/rtla/src/timerlat.h b/tools/tracing/rtla/src/timerlat.h
> index cadc613dc82e..73045aef23fa 100644
> --- a/tools/tracing/rtla/src/timerlat.h
> +++ b/tools/tracing/rtla/src/timerlat.h
> @@ -15,17 +15,15 @@ struct timerlat_params {
>  	int			sleep_time;
>  	int			output_divisor;
>  	int			duration;
> -	int			quiet;
>  	int			set_sched;
>  	int			dma_latency;
>  	int			no_aa;
> -	int			aa_only;
>  	int			dump_tasks;
>  	int			cgroup;
>  	int			hk_cpus;
>  	int			user_workload;
>  	int			kernel_workload;
> -	int			pretty_output;
> +	int			user_data;
>  	int			warmup;
>  	int			buffer_size;
>  	int			deepest_idle_state;
> @@ -35,11 +33,12 @@ struct timerlat_params {
>  	union {
>  		struct {
>  			/* top only */
> -			int			user_top;
> +			int			quiet;
> +			int			aa_only;
> +			int			pretty_output;
>  		};
>  		struct {
>  			/* hist only */
> -			int			user_hist;
>  			char			no_irq;
>  			char			no_thread;
>  			char			no_header;
> @@ -52,6 +51,8 @@ struct timerlat_params {
>  	};
>  };
>  
> +int timerlat_apply_config(struct osnoise_tool *tool, struct timerlat_params *params);
> +
>  int timerlat_hist_main(int argc, char *argv[]);
>  int timerlat_top_main(int argc, char *argv[]);
>  int timerlat_main(int argc, char *argv[]);
> diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
> index 822c068b4776..9d9efeedc4c2 100644
> --- a/tools/tracing/rtla/src/timerlat_hist.c
> +++ b/tools/tracing/rtla/src/timerlat_hist.c
> @@ -315,7 +315,7 @@ static void timerlat_hist_header(struct osnoise_tool *tool)
>  		if (!params->no_thread)
>  			trace_seq_printf(s, "   Thr-%03d", cpu);
>  
> -		if (params->user_hist)
> +		if (params->user_data)
>  			trace_seq_printf(s, "   Usr-%03d", cpu);
>  	}
>  	trace_seq_printf(s, "\n");
> @@ -371,7 +371,7 @@ timerlat_print_summary(struct timerlat_params *params,
>  			trace_seq_printf(trace->seq, "%9llu ",
>  					data->hist[cpu].thread_count);
>  
> -		if (params->user_hist)
> +		if (params->user_data)
>  			trace_seq_printf(trace->seq, "%9llu ",
>  					 data->hist[cpu].user_count);
>  	}
> @@ -399,7 +399,7 @@ timerlat_print_summary(struct timerlat_params *params,
>  					     data->hist[cpu].min_thread,
>  					     false);
>  
> -		if (params->user_hist)
> +		if (params->user_data)
>  			format_summary_value(trace->seq,
>  					     data->hist[cpu].user_count,
>  					     data->hist[cpu].min_user,
> @@ -429,7 +429,7 @@ timerlat_print_summary(struct timerlat_params *params,
>  					     data->hist[cpu].sum_thread,
>  					     true);
>  
> -		if (params->user_hist)
> +		if (params->user_data)
>  			format_summary_value(trace->seq,
>  					     data->hist[cpu].user_count,
>  					     data->hist[cpu].sum_user,
> @@ -459,7 +459,7 @@ timerlat_print_summary(struct timerlat_params *params,
>  					     data->hist[cpu].max_thread,
>  					     false);
>  
> -		if (params->user_hist)
> +		if (params->user_data)
>  			format_summary_value(trace->seq,
>  					     data->hist[cpu].user_count,
>  					     data->hist[cpu].max_user,
> @@ -521,7 +521,7 @@ timerlat_print_stats_all(struct timerlat_params *params,
>  	if (!params->no_thread)
>  		trace_seq_printf(trace->seq, "       Thr");
>  
> -	if (params->user_hist)
> +	if (params->user_data)
>  		trace_seq_printf(trace->seq, "       Usr");
>  
>  	trace_seq_printf(trace->seq, "\n");
> @@ -537,7 +537,7 @@ timerlat_print_stats_all(struct timerlat_params *params,
>  		trace_seq_printf(trace->seq, "%9llu ",
>  				 sum.thread_count);
>  
> -	if (params->user_hist)
> +	if (params->user_data)
>  		trace_seq_printf(trace->seq, "%9llu ",
>  				 sum.user_count);
>  
> @@ -558,7 +558,7 @@ timerlat_print_stats_all(struct timerlat_params *params,
>  				     sum.min_thread,
>  				     false);
>  
> -	if (params->user_hist)
> +	if (params->user_data)
>  		format_summary_value(trace->seq,
>  				     sum.user_count,
>  				     sum.min_user,
> @@ -581,7 +581,7 @@ timerlat_print_stats_all(struct timerlat_params *params,
>  				     sum.sum_thread,
>  				     true);
>  
> -	if (params->user_hist)
> +	if (params->user_data)
>  		format_summary_value(trace->seq,
>  				     sum.user_count,
>  				     sum.sum_user,
> @@ -604,7 +604,7 @@ timerlat_print_stats_all(struct timerlat_params *params,
>  				     sum.max_thread,
>  				     false);
>  
> -	if (params->user_hist)
> +	if (params->user_data)
>  		format_summary_value(trace->seq,
>  				     sum.user_count,
>  				     sum.max_user,
> @@ -654,7 +654,7 @@ timerlat_print_stats(struct timerlat_params *params, struct osnoise_tool *tool)
>  						data->hist[cpu].thread[bucket]);
>  			}
>  
> -			if (params->user_hist) {
> +			if (params->user_data) {
>  				total += data->hist[cpu].user[bucket];
>  				trace_seq_printf(trace->seq, "%9d ",
>  						data->hist[cpu].user[bucket]);
> @@ -690,7 +690,7 @@ timerlat_print_stats(struct timerlat_params *params, struct osnoise_tool *tool)
>  			trace_seq_printf(trace->seq, "%9d ",
>  					 data->hist[cpu].thread[data->entries]);
>  
> -		if (params->user_hist)
> +		if (params->user_data)
>  			trace_seq_printf(trace->seq, "%9d ",
>  					 data->hist[cpu].user[data->entries]);
>  	}
> @@ -965,7 +965,7 @@ static struct timerlat_params
>  			params->user_workload = 1;
>  			/* fallback: -u implies in -U */
>  		case 'U':
> -			params->user_hist = 1;
> +			params->user_data = 1;
>  			break;
>  		case '0': /* no irq */
>  			params->no_irq = 1;
> @@ -1063,98 +1063,11 @@ static struct timerlat_params
>  static int
>  timerlat_hist_apply_config(struct osnoise_tool *tool, struct timerlat_params *params)
>  {
> -	int retval, i;
> -
> -	if (!params->sleep_time)
> -		params->sleep_time = 1;
> -
> -	if (params->cpus) {
> -		retval = osnoise_set_cpus(tool->context, params->cpus);
> -		if (retval) {
> -			err_msg("Failed to apply CPUs config\n");
> -			goto out_err;
> -		}
> -	} else {
> -		for (i = 0; i < sysconf(_SC_NPROCESSORS_CONF); i++)
> -			CPU_SET(i, &params->monitored_cpus);
> -	}
> -
> -	if (params->stop_us) {
> -		retval = osnoise_set_stop_us(tool->context, params->stop_us);
> -		if (retval) {
> -			err_msg("Failed to set stop us\n");
> -			goto out_err;
> -		}
> -	}
> -
> -	if (params->stop_total_us) {
> -		retval = osnoise_set_stop_total_us(tool->context, params->stop_total_us);
> -		if (retval) {
> -			err_msg("Failed to set stop total us\n");
> -			goto out_err;
> -		}
> -	}
> -
> -	if (params->timerlat_period_us) {
> -		retval = osnoise_set_timerlat_period_us(tool->context, params->timerlat_period_us);
> -		if (retval) {
> -			err_msg("Failed to set timerlat period\n");
> -			goto out_err;
> -		}
> -	}
> -
> -	if (params->print_stack) {
> -		retval = osnoise_set_print_stack(tool->context, params->print_stack);
> -		if (retval) {
> -			err_msg("Failed to set print stack\n");
> -			goto out_err;
> -		}
> -	}
> -
> -	if (params->hk_cpus) {
> -		retval = sched_setaffinity(getpid(), sizeof(params->hk_cpu_set),
> -					   &params->hk_cpu_set);
> -		if (retval == -1) {
> -			err_msg("Failed to set rtla to the house keeping CPUs\n");
> -			goto out_err;
> -		}
> -	} else if (params->cpus) {
> -		/*
> -		 * Even if the user do not set a house-keeping CPU, try to
> -		 * move rtla to a CPU set different to the one where the user
> -		 * set the workload to run.
> -		 *
> -		 * No need to check results as this is an automatic attempt.
> -		 */
> -		auto_house_keeping(&params->monitored_cpus);
> -	}
> -
> -	/*
> -	 * If the user did not specify a type of thread, try user-threads first.
> -	 * Fall back to kernel threads otherwise.
> -	 */
> -	if (!params->kernel_workload && !params->user_hist) {
> -		retval = tracefs_file_exists(NULL, "osnoise/per_cpu/cpu0/timerlat_fd");
> -		if (retval) {
> -			debug_msg("User-space interface detected, setting user-threads\n");
> -			params->user_workload = 1;
> -			params->user_hist = 1;
> -		} else {
> -			debug_msg("User-space interface not detected, setting kernel-threads\n");
> -			params->kernel_workload = 1;
> -		}
> -	}
> +	int retval;
>  
> -	/*
> -	* Set workload according to type of thread if the kernel supports it.
> -	* On kernels without support, user threads will have already failed
> -	* on missing timerlat_fd, and kernel threads do not need it.
> -	*/
> -	retval = osnoise_set_workload(tool->context, params->kernel_workload);
> -	if (retval < -1) {
> -		err_msg("Failed to set OSNOISE_WORKLOAD option\n");
> +	retval = timerlat_apply_config(tool, params);
> +	if (retval)
>  		goto out_err;
> -	}
>  
>  	return 0;
>  
> diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
> index c3196a0bb585..79cb6f28967f 100644
> --- a/tools/tracing/rtla/src/timerlat_top.c
> +++ b/tools/tracing/rtla/src/timerlat_top.c
> @@ -266,7 +266,7 @@ static void timerlat_top_header(struct timerlat_params *params, struct osnoise_t
>  		trace_seq_printf(s, "\033[2;37;40m");
>  
>  	trace_seq_printf(s, "                                     Timer Latency                                              ");
> -	if (params->user_top)
> +	if (params->user_data)
>  		trace_seq_printf(s, "                                         ");
>  
>  	if (params->pretty_output)
> @@ -277,7 +277,7 @@ static void timerlat_top_header(struct timerlat_params *params, struct osnoise_t
>  			params->output_divisor == 1 ? "ns" : "us",
>  			params->output_divisor == 1 ? "ns" : "us");
>  
> -	if (params->user_top) {
> +	if (params->user_data) {
>  		trace_seq_printf(s, "      |    Ret user Timer Latency (%s)",
>  				params->output_divisor == 1 ? "ns" : "us");
>  	}
> @@ -287,7 +287,7 @@ static void timerlat_top_header(struct timerlat_params *params, struct osnoise_t
>  		trace_seq_printf(s, "\033[2;30;47m");
>  
>  	trace_seq_printf(s, "CPU COUNT      |      cur       min       avg       max |      cur       min       avg       max");
> -	if (params->user_top)
> +	if (params->user_data)
>  		trace_seq_printf(s, " |      cur       min       avg       max");
>  
>  	if (params->pretty_output)
> @@ -338,7 +338,7 @@ static void timerlat_top_print(struct osnoise_tool *top, int cpu)
>  		trace_seq_printf(s, "%9llu", cpu_data->max_thread);
>  	}
>  
> -	if (!params->user_top) {
> +	if (!params->user_data) {
>  		trace_seq_printf(s, "\n");
>  		return;
>  	}
> @@ -380,7 +380,7 @@ timerlat_top_print_sum(struct osnoise_tool *top, struct timerlat_top_cpu *summar
>  	}
>  
>  	trace_seq_printf(s, "%.*s|%.*s|%.*s", 15, split, 40, split, 39, split);
> -	if (params->user_top)
> +	if (params->user_data)
>  		trace_seq_printf(s, "-|%.*s", 39, split);
>  	trace_seq_printf(s, "\n");
>  
> @@ -405,7 +405,7 @@ timerlat_top_print_sum(struct osnoise_tool *top, struct timerlat_top_cpu *summar
>  		trace_seq_printf(s, "%9llu", summary->max_thread);
>  	}
>  
> -	if (!params->user_top) {
> +	if (!params->user_data) {
>  		trace_seq_printf(s, "\n");
>  		return;
>  	}
> @@ -722,7 +722,7 @@ static struct timerlat_params
>  			params->user_workload = true;
>  			/* fallback: -u implies -U */
>  		case 'U':
> -			params->user_top = true;
> +			params->user_data = true;
>  			break;
>  		case '0': /* trigger */
>  			if (params->events) {
> @@ -800,100 +800,10 @@ static int
>  timerlat_top_apply_config(struct osnoise_tool *top, struct timerlat_params *params)
>  {
>  	int retval;
> -	int i;
> -
> -	if (!params->sleep_time)
> -		params->sleep_time = 1;
> -
> -	if (params->cpus) {
> -		retval = osnoise_set_cpus(top->context, params->cpus);
> -		if (retval) {
> -			err_msg("Failed to apply CPUs config\n");
> -			goto out_err;
> -		}
> -	} else {
> -		for (i = 0; i < sysconf(_SC_NPROCESSORS_CONF); i++)
> -			CPU_SET(i, &params->monitored_cpus);
> -	}
> -
> -	if (params->stop_us) {
> -		retval = osnoise_set_stop_us(top->context, params->stop_us);
> -		if (retval) {
> -			err_msg("Failed to set stop us\n");
> -			goto out_err;
> -		}
> -	}
> -
> -	if (params->stop_total_us) {
> -		retval = osnoise_set_stop_total_us(top->context, params->stop_total_us);
> -		if (retval) {
> -			err_msg("Failed to set stop total us\n");
> -			goto out_err;
> -		}
> -	}
> -
> -
> -	if (params->timerlat_period_us) {
> -		retval = osnoise_set_timerlat_period_us(top->context, params->timerlat_period_us);
> -		if (retval) {
> -			err_msg("Failed to set timerlat period\n");
> -			goto out_err;
> -		}
> -	}
>  
> -
> -	if (params->print_stack) {
> -		retval = osnoise_set_print_stack(top->context, params->print_stack);
> -		if (retval) {
> -			err_msg("Failed to set print stack\n");
> -			goto out_err;
> -		}
> -	}
> -
> -	if (params->hk_cpus) {
> -		retval = sched_setaffinity(getpid(), sizeof(params->hk_cpu_set),
> -					   &params->hk_cpu_set);
> -		if (retval == -1) {
> -			err_msg("Failed to set rtla to the house keeping CPUs\n");
> -			goto out_err;
> -		}
> -	} else if (params->cpus) {
> -		/*
> -		 * Even if the user do not set a house-keeping CPU, try to
> -		 * move rtla to a CPU set different to the one where the user
> -		 * set the workload to run.
> -		 *
> -		 * No need to check results as this is an automatic attempt.
> -		 */
> -		auto_house_keeping(&params->monitored_cpus);
> -	}
> -
> -	/*
> -	 * If the user did not specify a type of thread, try user-threads first.
> -	 * Fall back to kernel threads otherwise.
> -	 */
> -	if (!params->kernel_workload && !params->user_top) {
> -		retval = tracefs_file_exists(NULL, "osnoise/per_cpu/cpu0/timerlat_fd");
> -		if (retval) {
> -			debug_msg("User-space interface detected, setting user-threads\n");
> -			params->user_workload = 1;
> -			params->user_top = 1;
> -		} else {
> -			debug_msg("User-space interface not detected, setting kernel-threads\n");
> -			params->kernel_workload = 1;
> -		}
> -	}
> -
> -	/*
> -	* Set workload according to type of thread if the kernel supports it.
> -	* On kernels without support, user threads will have already failed
> -	* on missing timerlat_fd, and kernel threads do not need it.
> -	*/
> -	retval = osnoise_set_workload(top->context, params->kernel_workload);
> -	if (retval < -1) {
> -		err_msg("Failed to set OSNOISE_WORKLOAD option\n");
> +	retval = timerlat_apply_config(top, params);
> +	if (retval)
>  		goto out_err;
> -	}
>  
>  	if (isatty(STDOUT_FILENO) && !params->quiet)
>  		params->pretty_output = 1;
> @@ -1142,7 +1052,7 @@ int timerlat_top_main(int argc, char *argv[])
>  		}
>  	}
>  
> -	if (params->cgroup && !params->user_top) {
> +	if (params->cgroup && !params->user_data) {
>  		retval = set_comm_cgroup("timerlat/", params->cgroup_name);
>  		if (!retval) {
>  			err_msg("Failed to move threads to cgroup\n");
> -- 
> 2.48.1
> 
> 
> 
Reviewed-by: John Kacur <jkacur@redhat.com>

