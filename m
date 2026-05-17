Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1422E11B9
	for <linux-trace-kernel@vger.kernel.org>; Sun, 17 May 2026 08:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779008232; cv=none; b=kqvRQjsZsMXLrR511aKfSPVHeRyWdz1PygFNQ2y8r+6c/LuNv2GA2f/afCZhRFCX57SfJdSUfFtzqnUM5voSYfTL2RzcPbbS4x7bM/msw0pJcMP/sFWiTk4fNFGJwJY/Dbc9SDpJ2T9nHA0bGJ+o9Yc8WOUusHrQSLDUWPJOEvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779008232; c=relaxed/simple;
	bh=z3YA7y1bwrIb9iFkopAnzudbaZ8F7aLoSOFC9nDB8H8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uVK5ot2KtIEhbTrGXcIB8m0EOC5bicFe2ehSzTWdRaHTuJTpvAY5yTdLSRpuz5uNVJPB34f5UCWMewRJocigwZwgIEwNxdaGnBi12xviUknTDs/v0g2Ugzf33N14t7Dpc9EbHDDx3z8SZO+A0WLMFA7iVBxnM31kHo14dnB65GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PfvHcmAI; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PfvHcmAI"
Message-ID: <09e02fe2-ae50-43df-8193-bd45341b9937@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779008229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=96R5XIm5RhfUoA+mwCP5R8VFzO7ElyJX2wxDiHtL9y8=;
	b=PfvHcmAIstdTMIzzIxdM/3Qxz1MBQYBwziXXHA8y6DyYDltF6rn4+Z3NliwU66y3YWa6Y2
	nYcTpaXZBcXr7YOu5WgOG1SBaXmeC8ufePgpnWlUDZ3nGdoqlP6pWmPS3BLAOvt9E56Qoo
	DCWhM4oXlFiFqHjbfzjDK1bV2efpfRU=
Date: Sun, 17 May 2026 16:57:01 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 4/9] rv: Prevent task migration while handling per-CPU
 events
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
References: <20260512140250.262190-1-gmonaco@redhat.com>
 <20260512140250.262190-5-gmonaco@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <20260512140250.262190-5-gmonaco@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


The da_implicit_guard() mechanism is a clean way to inject a monitor-
type-specific guard without cluttering the hot-path helpers.


Reviewed-by: Wen Yang <wen.yang@linux.dev>



On 5/12/26 22:02, Gabriele Monaco wrote:
> Tracepoint handlers are now fully preemptible. When a per-CPU monitor
> handles an event, it retrieves the monitor state using a per-CPU
> pointer. If the event itself doesn't disable preemption, the task can
> migrate to a different CPU and we risk updating the wrong monitor.
> 
> Mitigate this by explicitly disabling task migration before acquiring
> the monitor pointer. This cannot guarantee the monitor runs on the
> correct CPU but reduces the race condition window and prevents warnings.
> 
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---
>   include/rv/da_monitor.h | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
> index 0b7028df08fb..a9fd284195ee 100644
> --- a/include/rv/da_monitor.h
> +++ b/include/rv/da_monitor.h
> @@ -181,6 +181,10 @@ static inline void da_monitor_destroy(void)
>   	da_monitor_reset_all();
>   }
>   
> +#ifndef da_implicit_guard
> +#define da_implicit_guard()
> +#endif
> +
>   #elif RV_MON_TYPE == RV_MON_PER_CPU
>   /*
>    * Functions to define, init and get a per-cpu monitor.
> @@ -230,6 +234,10 @@ static inline void da_monitor_destroy(void)
>   	da_monitor_reset_all();
>   }
>   
> +#ifndef da_implicit_guard
> +#define da_implicit_guard() guard(migrate)()
> +#endif
> +
>   #elif RV_MON_TYPE == RV_MON_PER_TASK
>   /*
>    * Functions to define, init and get a per-task monitor.
> @@ -677,6 +685,7 @@ static inline bool __da_handle_start_run_event(struct da_monitor *da_mon,
>    */
>   static inline void da_handle_event(enum events event)
>   {
> +	da_implicit_guard();
>   	__da_handle_event(da_get_monitor(), event, 0);
>   }
>   
> @@ -692,6 +701,7 @@ static inline void da_handle_event(enum events event)
>    */
>   static inline bool da_handle_start_event(enum events event)
>   {
> +	da_implicit_guard();
>   	return __da_handle_start_event(da_get_monitor(), event, 0);
>   }
>   
> @@ -703,6 +713,7 @@ static inline bool da_handle_start_event(enum events event)
>    */
>   static inline bool da_handle_start_run_event(enum events event)
>   {
> +	da_implicit_guard();
>   	return __da_handle_start_run_event(da_get_monitor(), event, 0);
>   }
>   
