Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 180BBEB64D7
	for <linux-trace-kernel@archiver.kernel.org>; Fri, 23 Jun 2023 16:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbjFWQue (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Fri, 23 Jun 2023 12:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232745AbjFWQuM (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 12:50:12 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6D63584
        for <linux-trace-kernel@vger.kernel.org>; Fri, 23 Jun 2023 09:49:10 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so1197924e87.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 23 Jun 2023 09:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1687538949; x=1690130949;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x/PxY8tQdU97MOLVqoUfvdu4nBfQfQu+R5cDKKfJECE=;
        b=E4/bpa3eloQI10LagVtXTw1L/3vtPtM+lrADhYSLrhyC2jL/v28lxNL8U/k0AgJHNo
         SDYqeTFyf8gLF6hF7X44tRzAeNjb5D4kYmpCZrB0L5vtT4wGu2t8NNGamz/l726h0F4A
         gL+GcekQeDGYERPgR+wpO0emY06JHpVlM7dHJ1jjuXdbZ1Dzx5tbj3YMgUanYMvqkcLi
         90CJzSPBiRIuCkH8fTKsFNd+0Kg9p4ma3uVVpXyYSLQAFztY8+HuREb08DNvFvEAjZuC
         vKWw4ncIv7+BWhJvx8828kI3DvYUmV7/Y5Kcy8O16nTxosdE/g0YkQxz2Aq1WySCCafc
         5ugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687538949; x=1690130949;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x/PxY8tQdU97MOLVqoUfvdu4nBfQfQu+R5cDKKfJECE=;
        b=Ub6b09f3piGkSEJ2JXQ7HWpYnX9C59m8ZAJgEw6UxM5ULq8IPRFxPk5q+N20EBfi2X
         pE75tf1DHaAXXfKNT0bNNh0qyRaTpZztZajkKXe0GliPL9sRbrJ+IgvkMZ07lm8rG5+n
         pSPxEq7JU8bnZNb+lC6yk2QmbW0CKq6rsT7NmFoiQN7YVIKcOdUBQ6yfHzTRTzEzC1w9
         E7dYA5lYI9c0huODmACHL8epOuxF9pVADqqpIYE6aSica6JJwX1gFdC5eluChcCF4B1p
         cHl4I6p6TBZZ0RfaA1PnOCCfZ1RXODM9piYp+qSyrqeYKWsUeF2qvD4uQ+USgPV9Viy9
         Medw==
X-Gm-Message-State: AC+VfDz7IQ7b8py0z95aw0l2xWA10hX3vm+IOvBL+H0AvsCR6mn25h58
        KrRIOjXA3vSL+tArZrRyls5r4g==
X-Google-Smtp-Source: ACHHUZ7X2+xNVmFTyjh5Me4U/3iHEc+o+CUQiaa1cGfFaJpDx1mMN3TgiATBx/MkBX79wNu748XWgQ==
X-Received: by 2002:a19:f201:0:b0:4f7:42de:3a8f with SMTP id q1-20020a19f201000000b004f742de3a8fmr12673193lfh.56.1687538948928;
        Fri, 23 Jun 2023 09:49:08 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:9cb8:f81f:3342:3b44? ([2a02:8011:e80c:0:9cb8:f81f:3342:3b44])
        by smtp.gmail.com with ESMTPSA id v15-20020a05600c214f00b003fa78d1055esm2843808wml.21.2023.06.23.09.49.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 09:49:08 -0700 (PDT)
Message-ID: <74aab2b3-db85-abde-5361-f638c272c096@isovalent.com>
Date:   Fri, 23 Jun 2023 17:49:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 bpf-next 10/11] bpftool: Add perf event names
Content-Language: en-GB
To:     Yafang Shao <laoar.shao@gmail.com>, ast@kernel.org,
        daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, rostedt@goodmis.org, mhiramat@kernel.org
Cc:     bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Jiri Olsa <olsajiri@gmail.com>
References: <20230623141546.3751-1-laoar.shao@gmail.com>
 <20230623141546.3751-11-laoar.shao@gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20230623141546.3751-11-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

2023-06-23 14:15 UTC+0000 ~ Yafang Shao <laoar.shao@gmail.com>
> Add new functions and macros to get perf event names. These names are
> copied from tool/perf/util/{parse-events,evsel}.c, so that in the future we
> will have a good chance to use the same code.
> 
> Suggested-by: Jiri Olsa <olsajiri@gmail.com>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  tools/bpf/bpftool/link.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
> 
> diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
> index 8461e6d..e5aeee3 100644
> --- a/tools/bpf/bpftool/link.c
> +++ b/tools/bpf/bpftool/link.c
> @@ -5,6 +5,7 @@
>  #include <linux/err.h>
>  #include <linux/netfilter.h>
>  #include <linux/netfilter_arp.h>
> +#include <linux/perf_event.h>
>  #include <net/if.h>
>  #include <stdio.h>
>  #include <unistd.h>
> @@ -19,6 +20,72 @@
>  static struct hashmap *link_table;
>  static struct dump_data dd = {};
>  
> +static const char *perf_type_name[PERF_TYPE_MAX] = {
> +	[PERF_TYPE_HARDWARE]			= "hardware",
> +	[PERF_TYPE_SOFTWARE]			= "software",
> +	[PERF_TYPE_TRACEPOINT]			= "tracepoint",
> +	[PERF_TYPE_HW_CACHE]			= "hw-cache",
> +	[PERF_TYPE_RAW]				= "raw",
> +	[PERF_TYPE_BREAKPOINT]			= "breakpoint",
> +};

These ones (above) are not defined in perf, are they?

> +
> +const char *event_symbols_hw[PERF_COUNT_HW_MAX] = {
> +	[PERF_COUNT_HW_CPU_CYCLES]		= "cpu-cycles",
> +	[PERF_COUNT_HW_INSTRUCTIONS]		= "instructions",
> +	[PERF_COUNT_HW_CACHE_REFERENCES]	= "cache-references",
> +	[PERF_COUNT_HW_CACHE_MISSES]		= "cache-misses",
> +	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS]	= "branch-instructions",
> +	[PERF_COUNT_HW_BRANCH_MISSES]		= "branch-misses",
> +	[PERF_COUNT_HW_BUS_CYCLES]		= "bus-cycles",
> +	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND]	= "stalled-cycles-frontend",
> +	[PERF_COUNT_HW_STALLED_CYCLES_BACKEND]	= "stalled-cycles-backend",
> +	[PERF_COUNT_HW_REF_CPU_CYCLES]		= "ref-cycles",
> +};
> +
> +const char *event_symbols_sw[PERF_COUNT_SW_MAX] = {
> +	[PERF_COUNT_SW_CPU_CLOCK]		= "cpu-clock",
> +	[PERF_COUNT_SW_TASK_CLOCK]		= "task-clock",
> +	[PERF_COUNT_SW_PAGE_FAULTS]		= "page-faults",
> +	[PERF_COUNT_SW_CONTEXT_SWITCHES]	= "context-switches",
> +	[PERF_COUNT_SW_CPU_MIGRATIONS]		= "cpu-migrations",
> +	[PERF_COUNT_SW_PAGE_FAULTS_MIN]		= "minor-faults",
> +	[PERF_COUNT_SW_PAGE_FAULTS_MAJ]		= "major-faults",
> +	[PERF_COUNT_SW_ALIGNMENT_FAULTS]	= "alignment-faults",
> +	[PERF_COUNT_SW_EMULATION_FAULTS]	= "emulation-faults",
> +	[PERF_COUNT_SW_DUMMY]			= "dummy",
> +	[PERF_COUNT_SW_BPF_OUTPUT]		= "bpf-output",
> +	[PERF_COUNT_SW_CGROUP_SWITCHES]		= "cgroup-switches",
> +};
> +
> +const char *evsel__hw_cache[PERF_COUNT_HW_CACHE_MAX] = {
> +	[PERF_COUNT_HW_CACHE_L1D]		= "L1-dcache",
> +	[PERF_COUNT_HW_CACHE_L1I]		= "L1-icache",
> +	[PERF_COUNT_HW_CACHE_LL]		= "LLC",
> +	[PERF_COUNT_HW_CACHE_DTLB]		= "dTLB",
> +	[PERF_COUNT_HW_CACHE_ITLB]		= "iTLB",
> +	[PERF_COUNT_HW_CACHE_BPU]		= "branch",
> +	[PERF_COUNT_HW_CACHE_NODE]		= "node",
> +};
> +
> +const char *evsel__hw_cache_op[PERF_COUNT_HW_CACHE_OP_MAX] = {
> +	[PERF_COUNT_HW_CACHE_OP_READ]		= "load",
> +	[PERF_COUNT_HW_CACHE_OP_WRITE]		= "store",
> +	[PERF_COUNT_HW_CACHE_OP_PREFETCH]	= "prefetch",
> +};
> +
> +const char *evsel__hw_cache_result[PERF_COUNT_HW_CACHE_RESULT_MAX] = {
> +	[PERF_COUNT_HW_CACHE_RESULT_ACCESS]	= "refs",
> +	[PERF_COUNT_HW_CACHE_RESULT_MISS]	= "misses",
> +};
> +
> +#define perf_event_name(array, id) ({			\
> +	const char *event_str = NULL;			\
> +							\
> +	if ((id) >= 0 && (id) < ARRAY_SIZE(array))	\
> +		event_str = array[id];			\
> +	event_str;					\
> +})
> +
>  static int link_parse_fd(int *argc, char ***argv)
>  {
>  	int fd;

Reviewed-by: Quentin Monnet <quentin@isovalent.com>
