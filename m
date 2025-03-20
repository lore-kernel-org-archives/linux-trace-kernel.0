Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD348229B1F
	for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Mar 2025 19:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742497226; cv=none; b=DKdbaPk2Z59wnmQIJCa0bHcW+qyLIcRnYzD41moZxVGQgWVP+pudb2sRb+Wy0g35miIioKDBbPFGEHbD5cIuzBo8+R6FocpBiXuAf2z/Iw4t4E64R0BEMmRAMtfqiUDGZL8XeqsNzBvbmbQw7/1+jbMyXK2XMa+P2MjQAyHNruQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742497226; c=relaxed/simple;
	bh=fONLWc0pdl6aockjAsBgkwI0FG1fN/b0CNtheN9i+xg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Lm2yYmVNkum7CuIYw0HFN9jfwLXiMHcIs3HAsXnEHOAqh66FFFXn5EahhUhnLU/LWB2Jjg8035llmPBvWwg9vEGeLEBIHlFx4L4LqoYccl/NQxKGWWY9bKM6oGJp+Hvf5BaaDdIZdgcL2KJ86KzuqmqcXl/pTdqmR80+i5v7gRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HZHsowmi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HZHsowmi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742497223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GuLKzl80HJEUzxBiHeEZpvGj2gfPB3PhlsUl2O7OoJE=;
	b=HZHsowmitt3tEGpSoyCGwgiflD1oneDpxpt+96V2un8J8RHkQaVG5UOZllkgy4w+JH8Mg5
	uDnj79Oe9kNdHHMRQxf+Rtu0fYzBgabgXXvY0ZB2TGHPwTzJkfn7GuwYvTiRXge/5ZNp5O
	g66lbdeFcbOO/wInvdiP47fRKdFxhpo=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-tNUEVVqLNdy1HF9skKcJnA-1; Thu, 20 Mar 2025 15:00:21 -0400
X-MC-Unique: tNUEVVqLNdy1HF9skKcJnA-1
X-Mimecast-MFC-AGG-ID: tNUEVVqLNdy1HF9skKcJnA_1742497221
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c549ea7166so190790185a.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Mar 2025 12:00:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742497221; x=1743102021;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GuLKzl80HJEUzxBiHeEZpvGj2gfPB3PhlsUl2O7OoJE=;
        b=DgPohMVSL9F8gFqzq64grkPNbIOV0kFU5iPQv5dkTWmo5M6tFZpplCFCOGQAHZhz1H
         v8sGjH3X77ECERWvkx71dOvso1g11fRY1fzWU/Uun8K37+9wiywtKROGKrp8MuHkCz0Y
         BhHEs96kBOVZiW6zwUyLxeptA7Twh0FKyoeqTgf+w3Sy6gYQB3eN9YdWVOfgHWQO26Fd
         hBZAqpwNbSoWy7ZlgwkDOj5K6x2XjTvh8ZtVo18Q1u8lXcr7h8TxSftyUq5F9fT20BSF
         WbY+0q8N3j6yd44k94HA00zxwA7oKCa4fjb48ocilSMMEyWcaC4YSeQV38bXoCCP70a6
         N56g==
X-Forwarded-Encrypted: i=1; AJvYcCWGPLsQElVLne1s9UwplNjNspQw+T5X40c+7HDuEL3Wp7tteRIOqDVkkCRK5GhaP4yTxBvwdxUmCshHqZd04AnJspg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj0Xhl0mLsFMgK6ytgW5Z6fwmv4RlpF2sqI/pCB5+wkdutU0rm
	ebXiF8KYsmSssM8CmO5w28S0eCggyOAPKcavyykhJs3e186zX3Y2iibpWtRy8rn1e5/D1ZsFhGj
	nauU1O9XF1d4b81yFXYwB3XZ7/FB6A5g+2y2chdZHuj+qjw6pkjWehAzMXgy6d7F0Mh6L+JS8S7
	dnEA==
X-Gm-Gg: ASbGncutP5RSWehy6ZnSkGjPatDDIxBFHYjmhvzHG6Y0QA3XZM1+EP/X6XBTaImHoe7
	PkOrBx/3Hj/i/uaUWSrx/hT0247FysolameV+5gkNVRM9HsHMzIDEUfr37HjxbJ4hYroktAwgbh
	vystEPGj3zE73dOC1sO5bFtBzxKSvUTWn4eNJwU+psV03rVTNiuREfdhjkvNHhA1glvNJSMWM8w
	BIk2Cw5khAQty7T66+LSnb5hL4mv3x5MEMzRN3QdmFRMeCN+9FkoHA7hWhBrVN5dW/RsfmMzOeJ
X-Received: by 2002:a05:620a:44c2:b0:7c5:43c2:a908 with SMTP id af79cd13be357-7c5ba133652mr60554385a.6.1742497220486;
        Thu, 20 Mar 2025 12:00:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJCv97CbLirycFl3FwKrvZEV1g9U/E4BjEKpfuDTaAswcrKNBDLffkcybURQtgaTw+QqN/Hw==
X-Received: by 2002:a05:620a:44c2:b0:7c5:43c2:a908 with SMTP id af79cd13be357-7c5ba133652mr60547585a.6.1742497220085;
        Thu, 20 Mar 2025 12:00:20 -0700 (PDT)
Received: from fionn ([76.69.33.37])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b92ec54dsm21984785a.59.2025.03.20.12.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 12:00:19 -0700 (PDT)
Date: Thu, 20 Mar 2025 15:00:08 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
cc: Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org, 
    linux-kernel@vger.kernel.org, Luis Goncalves <lgoncalv@redhat.com>
Subject: Re: [PATCH 1/6] rtla/osnoise: Unify params struct
In-Reply-To: <20250320092500.101385-2-tglozar@redhat.com>
Message-ID: <e6a2d061-42bf-72c0-0e40-75bbe5b1e831@redhat.com>
References: <20250320092500.101385-1-tglozar@redhat.com> <20250320092500.101385-2-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -gjWSR-mb8LDfCntZyr9EFWOwvbEDZzSO4k1ce3n2ns_1742497221
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII



On Thu, 20 Mar 2025, Tomas Glozar wrote:

> Instead of having separate structs osnoise_top_params and
> osnoise_hist_params, use one struct osnoise_params for both.
> 
> This allows code using the structs to be shared between osnoise-top and
> osnoise-hist.
> 
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
>  tools/tracing/rtla/src/osnoise.c      |  1 -
>  tools/tracing/rtla/src/osnoise.h      | 47 +++++++++++++++++++++++
>  tools/tracing/rtla/src/osnoise_hist.c | 52 ++++++--------------------
>  tools/tracing/rtla/src/osnoise_top.c  | 54 +++++----------------------
>  tools/tracing/rtla/src/timerlat.h     |  1 -
>  5 files changed, 68 insertions(+), 87 deletions(-)
> 
> diff --git a/tools/tracing/rtla/src/osnoise.c b/tools/tracing/rtla/src/osnoise.c
> index 85f398b89597..93d485c0e949 100644
> --- a/tools/tracing/rtla/src/osnoise.c
> +++ b/tools/tracing/rtla/src/osnoise.c
> @@ -14,7 +14,6 @@
>  #include <stdio.h>
>  
>  #include "osnoise.h"
> -#include "utils.h"
>  
>  /*
>   * osnoise_get_cpus - return the original "osnoise/cpus" content
> diff --git a/tools/tracing/rtla/src/osnoise.h b/tools/tracing/rtla/src/osnoise.h
> index 056c8b113dee..f78ffbdc8c8d 100644
> --- a/tools/tracing/rtla/src/osnoise.h
> +++ b/tools/tracing/rtla/src/osnoise.h
> @@ -1,8 +1,55 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #pragma once
>  
> +#include "utils.h"
>  #include "trace.h"
>  
> +enum osnoise_mode {
> +	MODE_OSNOISE = 0,
> +	MODE_HWNOISE
> +};
> +
> +struct osnoise_params {
> +	/* Common params */
> +	char			*cpus;
> +	cpu_set_t		monitored_cpus;
> +	char			*trace_output;
> +	char			*cgroup_name;
> +	unsigned long long	runtime;
> +	unsigned long long	period;
> +	long long		threshold;
> +	long long		stop_us;
> +	long long		stop_total_us;
> +	int			sleep_time;
> +	int			duration;
> +	int			set_sched;
> +	int			cgroup;
> +	int			hk_cpus;
> +	cpu_set_t		hk_cpu_set;
> +	struct sched_attr	sched_param;
> +	struct trace_events	*events;
> +	int			warmup;
> +	int			buffer_size;
> +	union {
> +		struct {
> +			/* top only */
> +			int			quiet;
> +			int			pretty_output;
> +			enum osnoise_mode	mode;
> +		};
> +		struct {
> +			/* hist only */
> +			int			output_divisor;
> +			char			no_header;
> +			char			no_summary;
> +			char			no_index;
> +			char			with_zeros;
> +			int			bucket_size;
> +			int			entries;
> +		};
> +	};
> +};
> +
>  /*
>   * osnoise_context - read, store, write, restore osnoise configs.
>   */
> diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
> index f4c9051c33c4..4721f15f77cd 100644
> --- a/tools/tracing/rtla/src/osnoise_hist.c
> +++ b/tools/tracing/rtla/src/osnoise_hist.c
> @@ -14,38 +14,8 @@
>  #include <time.h>
>  #include <sched.h>
>  
> -#include "utils.h"
>  #include "osnoise.h"
>  
> -struct osnoise_hist_params {
> -	char			*cpus;
> -	cpu_set_t		monitored_cpus;
> -	char			*trace_output;
> -	char			*cgroup_name;
> -	unsigned long long	runtime;
> -	unsigned long long	period;
> -	long long		threshold;
> -	long long		stop_us;
> -	long long		stop_total_us;
> -	int			sleep_time;
> -	int			duration;
> -	int			set_sched;
> -	int			output_divisor;
> -	int			cgroup;
> -	int			hk_cpus;
> -	cpu_set_t		hk_cpu_set;
> -	struct sched_attr	sched_param;
> -	struct trace_events	*events;
> -	char			no_header;
> -	char			no_summary;
> -	char			no_index;
> -	char			with_zeros;
> -	int			bucket_size;
> -	int			entries;
> -	int			warmup;
> -	int			buffer_size;
> -};
> -
>  struct osnoise_hist_cpu {
>  	int			*samples;
>  	int			count;
> @@ -126,7 +96,7 @@ static struct osnoise_hist_data
>  static void osnoise_hist_update_multiple(struct osnoise_tool *tool, int cpu,
>  					 unsigned long long duration, int count)
>  {
> -	struct osnoise_hist_params *params = tool->params;
> +	struct osnoise_params *params = tool->params;
>  	struct osnoise_hist_data *data = tool->data;
>  	unsigned long long total_duration;
>  	int entries = data->entries;
> @@ -168,7 +138,7 @@ static void osnoise_destroy_trace_hist(struct osnoise_tool *tool)
>   */
>  static int osnoise_init_trace_hist(struct osnoise_tool *tool)
>  {
> -	struct osnoise_hist_params *params = tool->params;
> +	struct osnoise_params *params = tool->params;
>  	struct osnoise_hist_data *data = tool->data;
>  	int bucket_size;
>  	char buff[128];
> @@ -253,7 +223,7 @@ static void osnoise_read_trace_hist(struct osnoise_tool *tool)
>   */
>  static void osnoise_hist_header(struct osnoise_tool *tool)
>  {
> -	struct osnoise_hist_params *params = tool->params;
> +	struct osnoise_params *params = tool->params;
>  	struct osnoise_hist_data *data = tool->data;
>  	struct trace_seq *s = tool->trace.seq;
>  	char duration[26];
> @@ -292,7 +262,7 @@ static void osnoise_hist_header(struct osnoise_tool *tool)
>   * osnoise_print_summary - print the summary of the hist data to the output
>   */
>  static void
> -osnoise_print_summary(struct osnoise_hist_params *params,
> +osnoise_print_summary(struct osnoise_params *params,
>  		       struct trace_instance *trace,
>  		       struct osnoise_hist_data *data)
>  {
> @@ -370,7 +340,7 @@ osnoise_print_summary(struct osnoise_hist_params *params,
>   * osnoise_print_stats - print data for all CPUs
>   */
>  static void
> -osnoise_print_stats(struct osnoise_hist_params *params, struct osnoise_tool *tool)
> +osnoise_print_stats(struct osnoise_params *params, struct osnoise_tool *tool)
>  {
>  	struct osnoise_hist_data *data = tool->data;
>  	struct trace_instance *trace = &tool->trace;
> @@ -508,10 +478,10 @@ static void osnoise_hist_usage(char *usage)
>  /*
>   * osnoise_hist_parse_args - allocs, parse and fill the cmd line parameters
>   */
> -static struct osnoise_hist_params
> +static struct osnoise_params
>  *osnoise_hist_parse_args(int argc, char *argv[])
>  {
> -	struct osnoise_hist_params *params;
> +	struct osnoise_params *params;
>  	struct trace_events *tevent;
>  	int retval;
>  	int c;
> @@ -731,7 +701,7 @@ static struct osnoise_hist_params
>   * osnoise_hist_apply_config - apply the hist configs to the initialized tool
>   */
>  static int
> -osnoise_hist_apply_config(struct osnoise_tool *tool, struct osnoise_hist_params *params)
> +osnoise_hist_apply_config(struct osnoise_tool *tool, struct osnoise_params *params)
>  {
>  	int retval;
>  
> @@ -808,7 +778,7 @@ osnoise_hist_apply_config(struct osnoise_tool *tool, struct osnoise_hist_params
>   * osnoise_init_hist - initialize a osnoise hist tool with parameters
>   */
>  static struct osnoise_tool
> -*osnoise_init_hist(struct osnoise_hist_params *params)
> +*osnoise_init_hist(struct osnoise_params *params)
>  {
>  	struct osnoise_tool *tool;
>  	int nr_cpus;
> @@ -842,7 +812,7 @@ static void stop_hist(int sig)
>   * osnoise_hist_set_signals - handles the signal to stop the tool
>   */
>  static void
> -osnoise_hist_set_signals(struct osnoise_hist_params *params)
> +osnoise_hist_set_signals(struct osnoise_params *params)
>  {
>  	signal(SIGINT, stop_hist);
>  	if (params->duration) {
> @@ -853,7 +823,7 @@ osnoise_hist_set_signals(struct osnoise_hist_params *params)
>  
>  int osnoise_hist_main(int argc, char *argv[])
>  {
> -	struct osnoise_hist_params *params;
> +	struct osnoise_params *params;
>  	struct osnoise_tool *record = NULL;
>  	struct osnoise_tool *tool = NULL;
>  	struct trace_instance *trace;
> diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
> index dacec2f99017..7f393019bbf5 100644
> --- a/tools/tracing/rtla/src/osnoise_top.c
> +++ b/tools/tracing/rtla/src/osnoise_top.c
> @@ -14,40 +14,6 @@
>  #include <sched.h>
>  
>  #include "osnoise.h"
> -#include "utils.h"
> -
> -enum osnoise_mode {
> -	MODE_OSNOISE = 0,
> -	MODE_HWNOISE
> -};
> -
> -/*
> - * osnoise top parameters
> - */
> -struct osnoise_top_params {
> -	char			*cpus;
> -	cpu_set_t		monitored_cpus;
> -	char			*trace_output;
> -	char			*cgroup_name;
> -	unsigned long long	runtime;
> -	unsigned long long	period;
> -	long long		threshold;
> -	long long		stop_us;
> -	long long		stop_total_us;
> -	int			sleep_time;
> -	int			duration;
> -	int			quiet;
> -	int			set_sched;
> -	int			cgroup;
> -	int			hk_cpus;
> -	int			warmup;
> -	int			buffer_size;
> -	int			pretty_output;
> -	cpu_set_t		hk_cpu_set;
> -	struct sched_attr	sched_param;
> -	struct trace_events	*events;
> -	enum osnoise_mode	mode;
> -};
>  
>  struct osnoise_top_cpu {
>  	unsigned long long	sum_runtime;
> @@ -158,7 +124,7 @@ osnoise_top_handler(struct trace_seq *s, struct tep_record *record,
>   */
>  static void osnoise_top_header(struct osnoise_tool *top)
>  {
> -	struct osnoise_top_params *params = top->params;
> +	struct osnoise_params *params = top->params;
>  	struct trace_seq *s = top->trace.seq;
>  	char duration[26];
>  
> @@ -218,7 +184,7 @@ static void clear_terminal(struct trace_seq *seq)
>   */
>  static void osnoise_top_print(struct osnoise_tool *tool, int cpu)
>  {
> -	struct osnoise_top_params *params = tool->params;
> +	struct osnoise_params *params = tool->params;
>  	struct trace_seq *s = tool->trace.seq;
>  	struct osnoise_top_cpu *cpu_data;
>  	struct osnoise_top_data *data;
> @@ -258,7 +224,7 @@ static void osnoise_top_print(struct osnoise_tool *tool, int cpu)
>   * osnoise_print_stats - print data for all cpus
>   */
>  static void
> -osnoise_print_stats(struct osnoise_top_params *params, struct osnoise_tool *top)
> +osnoise_print_stats(struct osnoise_params *params, struct osnoise_tool *top)
>  {
>  	struct trace_instance *trace = &top->trace;
>  	static int nr_cpus = -1;
> @@ -286,7 +252,7 @@ osnoise_print_stats(struct osnoise_top_params *params, struct osnoise_tool *top)
>  /*
>   * osnoise_top_usage - prints osnoise top usage message
>   */
> -static void osnoise_top_usage(struct osnoise_top_params *params, char *usage)
> +static void osnoise_top_usage(struct osnoise_params *params, char *usage)
>  {
>  	int i;
>  
> @@ -354,9 +320,9 @@ static void osnoise_top_usage(struct osnoise_top_params *params, char *usage)
>  /*
>   * osnoise_top_parse_args - allocs, parse and fill the cmd line parameters
>   */
> -struct osnoise_top_params *osnoise_top_parse_args(int argc, char **argv)
> +struct osnoise_params *osnoise_top_parse_args(int argc, char **argv)
>  {
> -	struct osnoise_top_params *params;
> +	struct osnoise_params *params;
>  	struct trace_events *tevent;
>  	int retval;
>  	int c;
> @@ -553,7 +519,7 @@ struct osnoise_top_params *osnoise_top_parse_args(int argc, char **argv)
>   * osnoise_top_apply_config - apply the top configs to the initialized tool
>   */
>  static int
> -osnoise_top_apply_config(struct osnoise_tool *tool, struct osnoise_top_params *params)
> +osnoise_top_apply_config(struct osnoise_tool *tool, struct osnoise_params *params)
>  {
>  	int retval;
>  
> @@ -640,7 +606,7 @@ osnoise_top_apply_config(struct osnoise_tool *tool, struct osnoise_top_params *p
>  /*
>   * osnoise_init_top - initialize a osnoise top tool with parameters
>   */
> -struct osnoise_tool *osnoise_init_top(struct osnoise_top_params *params)
> +struct osnoise_tool *osnoise_init_top(struct osnoise_params *params)
>  {
>  	struct osnoise_tool *tool;
>  	int nr_cpus;
> @@ -674,7 +640,7 @@ static void stop_top(int sig)
>  /*
>   * osnoise_top_set_signals - handles the signal to stop the tool
>   */
> -static void osnoise_top_set_signals(struct osnoise_top_params *params)
> +static void osnoise_top_set_signals(struct osnoise_params *params)
>  {
>  	signal(SIGINT, stop_top);
>  	if (params->duration) {
> @@ -685,7 +651,7 @@ static void osnoise_top_set_signals(struct osnoise_top_params *params)
>  
>  int osnoise_top_main(int argc, char **argv)
>  {
> -	struct osnoise_top_params *params;
> +	struct osnoise_params *params;
>  	struct osnoise_tool *record = NULL;
>  	struct osnoise_tool *tool = NULL;
>  	struct trace_instance *trace;
> diff --git a/tools/tracing/rtla/src/timerlat.h b/tools/tracing/rtla/src/timerlat.h
> index e452d385cb0f..cadc613dc82e 100644
> --- a/tools/tracing/rtla/src/timerlat.h
> +++ b/tools/tracing/rtla/src/timerlat.h
> @@ -1,5 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#include "utils.h"
>  #include "osnoise.h"
>  
>  struct timerlat_params {
> -- 

Reviewed-by: John Kacur <jkacur@redhat.com>

