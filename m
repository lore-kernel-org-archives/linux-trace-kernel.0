Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DFF34D4EA
	for <linux-trace-kernel@vger.kernel.org>; Sun, 17 May 2026 08:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779008171; cv=none; b=dx1pZPKk1QJq09zvN+gaysdBJsZjEC2UldPnBPZFzaBIess+a9fpnJSIZ+rkVEGiog96VMLBCO18ok1oJ4G7J7Iur7HySii7KrSh+LcC9r3R7LOHFuJz0XG2uF8rCbERWQFGW0XAZ7QWP+CFyM9d3parB6GKHMmKDQE0YU6F4AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779008171; c=relaxed/simple;
	bh=DAX0umuHG6i2tE+0SlGwZeeimhUzK1XKQPLaMCiq/PE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HwYBMlkAQgwDqEMHzz1aK4m1N4rADdoCh+qRw7otV1qF9Kw1hjAGy98zXcEIrlolH97vFMeAHjn8gKmDf9eElCu5sfsexd6qHZYhqYQufJPFx24aeZwIjp17I+vPPpqc7/1qrQajWf2OftSLZlR9n+5Roe/n5hQQ+2xn6Wpu1z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bMcnDD+H; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bMcnDD+H"
Message-ID: <a871022a-baf2-426f-b3dc-36149e928a26@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779008157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AGPTfXmKnCz+bMzM2sm8ET03aE5Myac73X/032y2E7w=;
	b=bMcnDD+HO2qwF85XIRq/wxrOC1ZSep1rjIaazZ9Yzj79R+hItcGSqfN1ioo7qS/+GF6vxo
	4xXDIZPTxzWMxNhjd2KK8pB7Vk4fxNG6hTstOgh+VJvescL0RblcmPAn5jEnK8LnHiATJD
	78vCSlD+gvfp7VBSZ8ppZ0McNnm9dz4=
Date: Sun, 17 May 2026 16:55:41 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 3/9] rv: Reset per-task DA monitors before releasing the
 slot
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>,
 linux-trace-kernel@vger.kernel.org
References: <20260512140250.262190-1-gmonaco@redhat.com>
 <20260512140250.262190-4-gmonaco@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <20260512140250.262190-4-gmonaco@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


The fix is correct: task_mon_slot = RV_PER_TASK_MONITOR_INIT
equals CONFIG_RV_PER_TASK_MONITORS, which is one past the end of rv[],
so calling da_monitor_reset_all() after rv_put_task_monitor_slot()
would write into whatever memory follows task_struct.rv[] — which is
randomised and can get quite nasty, as you noted in the review thread.

Overlap note: . 
https://lore.kernel.org/all/f654a17c671469fd8fc9ea438daf2266d05068d4.camel@redhat.com/

We will coordinate to avoid redundancy;
we are happy to defer to your version here.


Reviewed-by: Wen Yang <wen.yang@linux.dev>



On 5/12/26 22:02, Gabriele Monaco wrote:
> Per-task monitors use task_mon_slot to determine which slot in the array
> to use for the monitor. During destruction, this slot is returned but
> this is done before resetting the monitor. As a result, the monitor's
> reset is in fact resetting a slot that is outside of the array
> (RV_PER_TASK_MONITOR_INIT).
> 
> Release the slot only after the reset to avoid out-of-bound memory
> access.
> 
> Fixes: 30984ccf31b7f ("rv: Refactor da_monitor to minimise macros")
> Fixes: 792575348ff70 ("rv/include: Add deterministic automata monitor definition via C macros")
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---
>   include/rv/da_monitor.h | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
> index 250888812125..0b7028df08fb 100644
> --- a/include/rv/da_monitor.h
> +++ b/include/rv/da_monitor.h
> @@ -309,10 +309,11 @@ static inline void da_monitor_destroy(void)
>   		WARN_ONCE(1, "Disabling a disabled monitor: " __stringify(MONITOR_NAME));
>   		return;
>   	}
> -	rv_put_task_monitor_slot(task_mon_slot);
> -	task_mon_slot = RV_PER_TASK_MONITOR_INIT;
>   
>   	da_monitor_reset_all();
> +
> +	rv_put_task_monitor_slot(task_mon_slot);
> +	task_mon_slot = RV_PER_TASK_MONITOR_INIT;
>   }
>   
>   #elif RV_MON_TYPE == RV_MON_PER_OBJ
