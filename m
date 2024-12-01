Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B515718A6D3;
	Sun,  1 Dec 2024 19:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733081874; cv=none; b=PfBTn0ZuK8jI7MiNuks4ogkMvGP5gWcipg5vtlXUnc5nS9/iuKm6dZWPH30limF/G9lGQDplEtHwGorrUKPnTCiJWEDkntUQZ/icnpGOnbfT5Gy2GEjv2Pganw2rsKL2rExkhVfvYvh5D5QQW9bCW9UVLHdf3HJ2qYL+S7SKzzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733081874; c=relaxed/simple;
	bh=On7E003j244SXWLYTXr5ztZu8doSjj79uML4UwpULX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C8jzmazXRMe1jTEucCU7rGyT7EA2VvdIP4GVCg8J8ZvWflPqaPWVHdRJVFrkNXeWGeGG0T4x4ejN7Uyy0N4My7FFFKx+wa/KmGT2hJuGDMO7EHOv9cQXRirsNwBIoiSUG0Pv8EwpnuluaUodyhJ1aH5u698yR6pTK6UVXqf3hjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Y1cdM713Zz9sPd;
	Sun,  1 Dec 2024 20:37:43 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VLzN7jj4nxi7; Sun,  1 Dec 2024 20:37:43 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Y1cdM5gFxz9rvV;
	Sun,  1 Dec 2024 20:37:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id A8F378B764;
	Sun,  1 Dec 2024 20:37:43 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id AtnQEdGVaZWz; Sun,  1 Dec 2024 20:37:43 +0100 (CET)
Received: from [192.168.232.62] (unknown [192.168.232.62])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 32E9A8B763;
	Sun,  1 Dec 2024 20:37:43 +0100 (CET)
Message-ID: <6fb1e232-3bc3-4d5d-bff9-9f1a8c784782@csgroup.eu>
Date: Sun, 1 Dec 2024 20:37:42 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ftrace: Show timings of how long nop patching took
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mike Rapoport <rppt@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <20241017113105.1edfa943@gandalf.local.home>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20241017113105.1edfa943@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Steven,

Le 17/10/2024 à 17:31, Steven Rostedt a écrit :
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> Since the beginning of ftrace, the code that did the patching had its
> timings saved on how long it took to complete. But this information was
> never exposed. It was used for debugging and exposing it was always
> something that was on the TODO list. Now it's time to expose it. There's
> even a file that is where it should go!
> 
> Also include how long patching modules took as a separate value.
> 
>   # cat /sys/kernel/tracing/dyn_ftrace_total_info
>   57680 pages:231 groups: 9
>   ftrace boot update time = 14024666 (ns)
>   ftrace module total update time = 126070 (ns)

What is this supposed to report / measure ?

On powerpc I get:

25850 pages:14 groups: 3
ftrace boot update time = 0 (ns)
ftrace module total update time = 0 (ns)

Christophe

> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>   kernel/trace/ftrace.c | 11 ++++++++---
>   kernel/trace/trace.c  | 15 +++++++++++----
>   kernel/trace/trace.h  |  2 ++
>   3 files changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index e9fd4fb2769e..7fb0d2934a23 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -3686,7 +3686,8 @@ static int ftrace_hash_move_and_update_subops(struct ftrace_ops *subops,
>   }
>   
>   
> -static u64		ftrace_update_time;
> +u64			ftrace_update_time;
> +u64			ftrace_total_mod_time;
>   unsigned long		ftrace_update_tot_cnt;
>   unsigned long		ftrace_number_of_pages;
>   unsigned long		ftrace_number_of_groups;
> @@ -3706,7 +3707,7 @@ static int ftrace_update_code(struct module *mod, struct ftrace_page *new_pgs)
>   	bool init_nop = ftrace_need_init_nop();
>   	struct ftrace_page *pg;
>   	struct dyn_ftrace *p;
> -	u64 start, stop;
> +	u64 start, stop, update_time;
>   	unsigned long update_cnt = 0;
>   	unsigned long rec_flags = 0;
>   	int i;
> @@ -3750,7 +3751,11 @@ static int ftrace_update_code(struct module *mod, struct ftrace_page *new_pgs)
>   	}
>   
>   	stop = ftrace_now(raw_smp_processor_id());
> -	ftrace_update_time = stop - start;
> +	update_time = stop - start;
> +	if (mod)
> +		ftrace_total_mod_time += update_time;
> +	else
> +		ftrace_update_time = update_time;
>   	ftrace_update_tot_cnt += update_cnt;
>   
>   	return 0;
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index c01375adc471..405dcf498159 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -8548,15 +8548,22 @@ tracing_read_dyn_info(struct file *filp, char __user *ubuf,
>   	char *buf;
>   	int r;
>   
> -	/* 256 should be plenty to hold the amount needed */
> -	buf = kmalloc(256, GFP_KERNEL);
> +	/* 512 should be plenty to hold the amount needed */
> +#define DYN_INFO_BUF_SIZE	512
> +
> +	buf = kmalloc(DYN_INFO_BUF_SIZE, GFP_KERNEL);
>   	if (!buf)
>   		return -ENOMEM;
>   
> -	r = scnprintf(buf, 256, "%ld pages:%ld groups: %ld\n",
> +	r = scnprintf(buf, DYN_INFO_BUF_SIZE,
> +		      "%ld pages:%ld groups: %ld\n"
> +		      "ftrace boot update time = %llu (ns)\n"
> +		      "ftrace module total update time = %llu (ns)\n",
>   		      ftrace_update_tot_cnt,
>   		      ftrace_number_of_pages,
> -		      ftrace_number_of_groups);
> +		      ftrace_number_of_groups,
> +		      ftrace_update_time,
> +		      ftrace_total_mod_time);
>   
>   	ret = simple_read_from_buffer(ubuf, cnt, ppos, buf, r);
>   	kfree(buf);
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index 6adf48ef4312..3307dad4d917 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -775,6 +775,8 @@ extern void trace_event_follow_fork(struct trace_array *tr, bool enable);
>   extern unsigned long ftrace_update_tot_cnt;
>   extern unsigned long ftrace_number_of_pages;
>   extern unsigned long ftrace_number_of_groups;
> +extern u64 ftrace_update_time;
> +extern u64 ftrace_total_mod_time;
>   void ftrace_init_trace_array(struct trace_array *tr);
>   #else
>   static inline void ftrace_init_trace_array(struct trace_array *tr) { }
