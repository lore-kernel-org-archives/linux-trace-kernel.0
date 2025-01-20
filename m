Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150021E376E
	for <linux-trace-kernel@vger.kernel.org>; Mon, 20 Jan 2025 14:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737384121; cv=none; b=VbucgffUGcK9YO9o1SBLno/HqHmBqhppPghr2i+WitEhLns5ZeNjI2ZpEhDLOtSB6ZvIgQC+P1q5hIh4xqrlyMPm/zIpDFSG5KEF0h8NJ7T5W6RswHLr05np9ZIYxRj2Yr9040+lSM3t/wBKPQibrP3nq0fax7yEVQX3jrjYsPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737384121; c=relaxed/simple;
	bh=nhHIoW1loicdjg/JLUt8zvhYvoYH6v5P8fUXM0nyK20=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=AXaABr0DWLjGO9PijuypsdTJMgji/bdoerFCJLnEJiXXsTKNhMoZwWM3Nw6u4BcGW1gWG2jpnzOJjsSHau57g28ER9mqO2Oub0+7AyyEq+5TsjVsRov2Mf6NYu/35V8g7/8NMNiKK9SUDrT9shxnt2RxmhpFVvoFgu+fafNWDsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=rFZmTiYS; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="rFZmTiYS"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4YcChr3PBJz1DQr7;
	Mon, 20 Jan 2025 15:41:48 +0100 (CET)
Received: from [10.10.15.9] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4YcChr0FK8z1DQrb;
	Mon, 20 Jan 2025 15:41:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1737384108;
	bh=lG0+FoE6fy+Q0Krk/qbZ9O+fjw1ZgH+C5gmLeoMQA1A=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=rFZmTiYS/bklW/M68NBPRQBrR3FSiSHV6hw/1n4J9WkzW2dBM//d1by3qtVmJ3Boq
	 /gREijuSpffFCbJ3Z3wqGxmz6TkmiQt0PfyfkqGSOO4D+LGcsQ5HReXaMZKoLASA0b
	 VkZU/FMkTxfq9HWZypCH8BQHcFXsLFTemudt/weo=
Message-ID: <150fa7ce-eec6-4452-8552-da70cba84a04@gaisler.com>
Date: Mon, 20 Jan 2025 15:41:47 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ludwig Rydberg <ludwig.rydberg@gaisler.com>
Subject: Re: [BUG] spinlock recursion when enabling function tracer on 32-bit
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, Andreas Larsson <andreas@gaisler.com>
References: <86fb4f86-a0e4-45a2-a2df-3154acc4f086@gaisler.com>
 <20241218110115.29d4cc77@gandalf.local.home>
 <bb8485bf-d720-4803-aa3c-037ea1169f8a@gaisler.com>
 <20241218163526.2569917f@gandalf.local.home>
 <2d634c54-d8d9-4f33-bfda-9236b6a2ea06@gaisler.com>
 <20241220100558.10b48f0f@gandalf.local.home>
Content-Language: en-US
In-Reply-To: <20241220100558.10b48f0f@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-12-20 16:05, Steven Rostedt wrote:

> 
> Can you try this patch on top of the last one?
> 

Hi Steven,

I just wanted to check if you saw my last reply to this thread.
I've tested both patches, and they work (tested on sparc32 and riscv32).

Let me know if you need more input.

Best regards,
// Ludwig

> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 7e257e855dd1..a9fe54b79ce5 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -4398,8 +4398,13 @@ rb_reserve_next_event(struct trace_buffer *buffer,
>  	int nr_loops = 0;
>  	int add_ts_default;
>  
> -	/* ring buffer does cmpxchg, make sure it is safe in NMI context */
> -	if (!IS_ENABLED(CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG) &&
> +	/*
> +	 * ring buffer does cmpxchg as well as atomic64 operations
> +	 * (which some archs use locking for atomic64), make sure this
> +	 * is safe in NMI context
> +	 */
> +	if ((!IS_ENABLED(CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG) ||
> +	     IS_ENABLED(CONFIG_GENERIC_ATOMIC64)) &&
>  	    (unlikely(in_nmi()))) {
>  		return NULL;
>  	}

