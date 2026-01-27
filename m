Received: from mail-qv1-f67.google.com (mail-qv1-f67.google.com [209.85.219.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A896274FE3
	for <linux-trace-kernel@vger.kernel.org>; Tue, 27 Jan 2026 21:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769547961; cv=none; b=k6VSt9iddGPGS1Hs5aQTOPeOE7VfWeuL+QXPlmpQGtyrWuSJCaX36Y3hfCyILiRRUYWQR5KlgBNkiEb36NcMjhx0mw1JGgg8Ui5dO844+Pcr+EHext21A0khaHDka5imaqwD9GvuIpRQ12Sl5M2gNiYVdhB5p/3LBcWid8kE76g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769547961; c=relaxed/simple;
	bh=TqcB88iZumxYon6GKRh86c9N0jSFrUOSXga87SF3Atg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RSBaaKaomar0zzsVhNmQu/MfhlURLdKBka9qqPPnNKguADuRV77gd8kw2vCwSbrKGJqwX3ldGqMrrZV8iSX1Nechm/9e1XqpeySKiBH+f4F4dA5VOgqac7Bf5RE57JMfjK4yfgZLqMhdCsXqntLRWQCo5Tjt04oE612BJH/pjKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QPVGx9xs; arc=none smtp.client-ip=209.85.219.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPVGx9xs"
Received: by mail-qv1-f67.google.com with SMTP id 6a1803df08f44-88a367a1dbbso104428176d6.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 27 Jan 2026 13:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769547959; x=1770152759; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=0CI0u9zQ3FuvPcx6E7U+YtAWO1aOAnspb+PLLUc7h5Y=;
        b=QPVGx9xstucO4+wuwECaytFNEwBYLlXluOesjkIl9wyg8rudM4KHO4reBG8g2ooFz8
         mfFeciLO2R+/v5sa44Q305xZU8hEKnOf5QgnxwoO7HfWzvH8pt0vzX8rF+SMm9VUpx7v
         LXCK93WjJYv/JFUOQqQ/seTXxp5GVTw1QPLTJFOEe2dcptIu8WGWqRRvI5tdj//QFrCD
         I38YscrWDL/N7eVQOPwQLHeS6bXLeki6o0xoBdtG8lOcMiKfjHoU1AZORIjeFsGujx5S
         rnjDmdHxpu+wOowzCAF39G5K/Hor8bv/10DEFB8IvQBiNjB7djiD/3N2Gsucl9Juu52+
         7nqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769547959; x=1770152759;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0CI0u9zQ3FuvPcx6E7U+YtAWO1aOAnspb+PLLUc7h5Y=;
        b=LAOkOV+Le4m+6SnlrXUfpyz3fVuxh/b4olI/WzLM2e5TzeRjP55VrRO/81FXG3XrAF
         ZBVXgK2VQscKysKaFsKUQ1IpblNn3b205wuyprRaJytQGiZo7WUsYu6ogdcmnZnuosUH
         SQsgH9P25OMoL54JlqGri/0REVlxxrgu4+Rzntx+V+owtfm19ce9d7YQLk537d75DU9z
         MLmxs2cbu6jDlgeciIYi4qabHoSgB7sqmuQUgaVSBT7908OSItXfckHSm5Vwiz2NpcOc
         XQUGlg4Nz64YSC/hXmaJwrQIQGwmzHzpjGhebm3pQ3pna/DgvPkxwRCvkdxtgw52+NHM
         GY3w==
X-Forwarded-Encrypted: i=1; AJvYcCWhhRRtEw/3vDF1HcrFRltEu9EkwcuhgejQrlrUGls6AoyNel7sp6/9SNbPaWDPbcLFgMk8xswRsWjjc0qwAg9VuU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK3g3h5w3KT0VWhns/kIXaz7gcyRKevSN1rMPqtw0/cSpF5xrr
	I2pVNPI59x63N59UkDuk2M3lNxEuHNaNR32uBCRoFdrJlO1V/FLLzDvU
X-Gm-Gg: AZuq6aJyWVZui6u6UF8/VT+iLTcb4zTRmlRM2nr+nz7u+X4f/9x7HtysbC1MMPntj0w
	f/SzxLZua1g8tEIok8pWSAkHUGp3L9OfKJ7jmZ3x+CcZcgCjXaKuEy+hU7AwmkbmGo3J8ZKWHTa
	WOSyzVZJdV99QzPc+SrmV8Grn9fxsGh6SRMC083SQe87QHchEPHcFZVESKwhY1nIenKGGpsVnpX
	YSX1l7WBKMvy65mlmUY2SgMRTDH3D19aUDECTrp0x8KT7B8RWRPrV3hzc6Um3lBxk9iBahZO2vd
	o7NfDGHXkp3HVLH/qBtEFIYWVu8oKH0JKhasQCa+FyGIMM9QD1TgwkOs+CBnd8Ipom/uVWOaZrQ
	BY4oaZC0HL7FVOt+Yu8rdl8cNa3y40WeRMLPs7Hv1dpK/SLwivrQCksa3Re8+55lLx+Vkx/lSOX
	he/6pMtp7gsJPogWCr2upYiP7JZXqs14cN9pGHjDoRowsNxdwiyIJsLBC/BwZk
X-Received: by 2002:a05:6a00:8f0c:b0:823:d04:dee1 with SMTP id d2e1a72fcca58-823692a38cemr2644528b3a.32.1769540827567;
        Tue, 27 Jan 2026 11:07:07 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379bfcab8sm299991b3a.36.2026.01.27.11.07.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 11:07:06 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <402e0322-bc2d-441f-8969-fc643dfaff06@roeck-us.net>
Date: Tue, 27 Jan 2026 11:07:05 -0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND][PATCH 3/5] perf: Use current->flags &
 PF_KTHREAD|PF_USER_WORKER instead of current->mm == NULL
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Thomas Gleixner <tglx@linutronix.de>
References: <20250820180338.701352023@kernel.org>
 <20250820180428.592367294@kernel.org>
 <0d877e6f-41a7-4724-875d-0b0a27b8a545@roeck-us.net>
 <20260126120553.2fa79048@gandalf.local.home>
 <20260126121803.4a90c959@gandalf.local.home>
 <27f9a957-67c7-4c88-b320-0f8725e9b03d@roeck-us.net>
 <20260127102234.755d8c4e@gandalf.local.home>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260127102234.755d8c4e@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Steven,

On 1/27/26 07:22, Steven Rostedt wrote:
> On Mon, 26 Jan 2026 17:32:35 -0800
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
>> Still crashing, though not as often and with a slightly different backtrace.
>> I added the backtrace to the bug report @ Google.
> 
> I figured there would be other locations. A while ago I had a patch to wrap
> the checks in a "is_user_thread()" helper function[1], but Ingo had issues
> with it. It seems now it's biting us in the butt and let's see if it would
> help now. I modified it slightly.
> 
> [1] https://lore.kernel.org/linux-trace-kernel/20250425204313.616425861@goodmis.org/
> 
> If the below fixes it, I'll resend it, but now as a real bug fix.
> 

Trying. So far I can no longer reproduce the problem with the patch below applied.
Obviously that doesn't mean that the problem is fixed, only that I can no longer
reproduce it. I'll keep trying with different platforms.

Guenter

> -- Steve
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index da0133524d08..5f00b5ed0f3b 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1776,6 +1776,11 @@ static __always_inline bool is_percpu_thread(void)
>   		(current->nr_cpus_allowed  == 1);
>   }
>   
> +static __always_inline bool is_user_task(struct task_struct *task)
> +{
> +	return task->mm && !(task->flags & (PF_KTHREAD | PF_USER_WORKER));
> +}
> +
>   /* Per-process atomic flags. */
>   #define PFA_NO_NEW_PRIVS		0	/* May not gain new privileges. */
>   #define PFA_SPREAD_PAGE			1	/* Spread page cache over cpuset */
> diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
> index 1f6589578703..9d24b6e0c91f 100644
> --- a/kernel/events/callchain.c
> +++ b/kernel/events/callchain.c
> @@ -246,7 +246,7 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
>   
>   	if (user && !crosstask) {
>   		if (!user_mode(regs)) {
> -			if (current->flags & (PF_KTHREAD | PF_USER_WORKER))
> +			if (!is_user_task(current))
>   				goto exit_put;
>   			regs = task_pt_regs(current);
>   		}
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index a0fa488bce84..8cca80094624 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -7460,7 +7460,7 @@ static void perf_sample_regs_user(struct perf_regs *regs_user,
>   	if (user_mode(regs)) {
>   		regs_user->abi = perf_reg_abi(current);
>   		regs_user->regs = regs;
> -	} else if (!(current->flags & (PF_KTHREAD | PF_USER_WORKER))) {
> +	} else if (is_user_task(current)) {
>   		perf_get_regs_user(regs_user, regs);
>   	} else {
>   		regs_user->abi = PERF_SAMPLE_REGS_ABI_NONE;
> @@ -8100,7 +8100,7 @@ static u64 perf_virt_to_phys(u64 virt)
>   		 * Try IRQ-safe get_user_page_fast_only first.
>   		 * If failed, leave phys_addr as 0.
>   		 */
> -		if (!(current->flags & (PF_KTHREAD | PF_USER_WORKER))) {
> +		if (is_user_task(current)) {
>   			struct page *p;
>   
>   			pagefault_disable();
> @@ -8215,7 +8215,7 @@ perf_callchain(struct perf_event *event, struct pt_regs *regs)
>   {
>   	bool kernel = !event->attr.exclude_callchain_kernel;
>   	bool user   = !event->attr.exclude_callchain_user &&
> -		!(current->flags & (PF_KTHREAD | PF_USER_WORKER));
> +		is_user_task(current);
>   	/* Disallow cross-task user callchains. */
>   	bool crosstask = event->ctx->task && event->ctx->task != current;
>   	bool defer_user = IS_ENABLED(CONFIG_UNWIND_USER) && user &&

