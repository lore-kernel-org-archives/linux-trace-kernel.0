Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7981662FA;
	Wed, 23 Oct 2024 09:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729674482; cv=none; b=Qm6sNhAO0AjuJgvUvzYZW42kSxttPTsx3XVPpyIucUUW2k/tQZUjQSVlphRFhyRGVXh3QhHryQS8VjnGNk9X1dK5Ko758fmVoQSUzab5bg+2mTM0kbNtQOfE4S1B9L5vtU3EB2knTNXxjChzfxCMF6KLWJOrzitk4cs2JT8XA24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729674482; c=relaxed/simple;
	bh=tbDydY/g0gP9i/qHvzsa6DB2Vdww1QZr+ZuT0zDljw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I4tjvjk1u64Gmekg1/sgPqlrgU6b1IfYGSFZIl/eI/bbzVnM4Bd7WTZzH4JYIurbs0X7EU3cf8GOc3IoS0SfhjW5rOI6TEK9j4mne1NG87WYL9GGl4b+icE9UlCiNZ/oRjnp+xm4dmT/ISCwxH0PYcgSwjK14pIjvMvuqSaifKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=none smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=BqAUoxVE; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yoseli.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="BqAUoxVE"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0D120FF805;
	Wed, 23 Oct 2024 09:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1729674478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=duGBblZySXHjNbKpCsyaY0S9onpbOMK+ADpEkjW/JZM=;
	b=BqAUoxVED0LIxgKeWcHgf7n1XLzvkg1oy+PjoAWgpY2rUUMVm8TE/CzS4r0mPiR48HoHxl
	QuOdhKl4+36K0eMHOGa+HJMIqMRrtTbRf4OirwQbNDWllU43pr6bht0HzvoAE2w4CTL5/q
	1AZ7nEBA2My9w8GFKlwYzA/sI6u9lh3ttN/Jd6WnsoJkOyFPuVDkdNxSy2ZstpKI5ZzgEz
	wP2Oc2xgXuPfbCf76TzH34cLIU8OZOfDofRpHCaZUdRPwSA+P8xXzMhHc2R51PR0AhnEao
	Jc61cHneZzrUrz20Ar4fzzhicKfpmO/RA/UT9kIKYzFeYHmbic67H+RwDHH4Pw==
Message-ID: <262d7758-c752-49f6-87ef-4f75d681a919@yoseli.org>
Date: Wed, 23 Oct 2024 11:07:57 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/2] m68k: Add tracirqs
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <20241021-add-m68k-tracing-support-v1-0-0883d704525b@yoseli.org>
 <20241021-add-m68k-tracing-support-v1-1-0883d704525b@yoseli.org>
 <20241022012809.1ef083cd@rorschach.local.home>
 <075d6720-a690-437c-a10f-e2746651e2a8@yoseli.org>
 <20241022043037.13efb239@rorschach.local.home>
 <2c79be22-1157-41e4-9f3a-53443112ca9a@yoseli.org>
 <20241023044711.3eb838fe@rorschach.local.home>
Content-Language: en-US
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
In-Reply-To: <20241023044711.3eb838fe@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: jeanmichel.hautbois@yoseli.org

Hi Steve,

On 23/10/2024 10:47, Steven Rostedt wrote:
> On Tue, 22 Oct 2024 11:21:34 +0200
> Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org> wrote:
> 
>>
>> I was not really expecting you to review the m68k one no :-).
>> I think I have other issues which might have impact on ftrace too.
>> For instance, when I launch cyclictest I have a warning about HRTIMERS:
>> # cyclictest -p 99
>> WARN: stat /dev/cpu_dma_latency failed: No such file or directory
>> WARN: High resolution timers not available
>> policy: fifo: loadavg: 1.21 0.40 0.14 1/122 245
>>
>> T: 0 (  245) P:99 I:1000 C:  11203 Min:     92 Act:  623 Avg:  775 Max:
>>     3516
>>
>> The latencies are quite high...
> 
> Yes, if you don't have high resolution timers, the latency will be high.
> 

According to my config, I should have those:
CONFIG_HIGH_RES_TIMERS=y

>>
>> But regarding ftrace it seems that the trace is not able to give me more
>> than a microsecond precision. I addded a few trace_printk() in a driver
>> of mine and I get:
>>    irq/182-dspi-sl-112     [000] D....   277.160000: dspi_interrupt:
>> Received 2 bytes
>>    irq/182-dspi-sl-112     [000] D....   277.160000: dspi_interrupt:
>> Received 2 bytes
>>    irq/182-dspi-sl-112     [000] D....   277.163000: dspi_interrupt:
>> dspi_interrupt
>>    irq/182-dspi-sl-112     [000] D....   277.163000: dspi_interrupt: TX
>> FIFO overflow
>>    irq/182-dspi-sl-112     [000] D....   277.163000: dspi_interrupt:
>> Restart FIFO
>>
>> Do you have any clue ?
> 
> Yes. The ring buffer clock is dependent on the architecture's clock. By
> default, it uses whatever the scheduler clock uses. If the scheduler
> clock is 1ms resolution, so will the tracing data be.

By default. So, I could change it to mono_raw for instance :-). It seems 
that timerlat is ok with it !

     irq/178-UART-99      [000] D.h1.    95.766649: #27138 context 
irq timer_latency    525376 ns
       timerlat/0-235     [000] .....    95.766826: #27138 context 
thread timer_latency    697920 ns
           <idle>-0       [000] dnh1.    95.767682: #27139 context 
irq timer_latency    559616 ns
       timerlat/0-235     [000] .....    95.767839: #27139 context 
thread timer_latency    713216 ns
           <idle>-0       [000] dnh1.    95.768701: #27140 context 
irq timer_latency    577984 ns
       timerlat/0-235     [000] .....    95.768861: #27140 context 
thread timer_latency    734656 ns
     irq/178-UART-99      [000] d.h1.    95.769671: #27141 context 
irq timer_latency    548736 ns
       timerlat/0-235     [000] .....    95.769838: #27141 context 
thread timer_latency    711552 ns
     irq/178-UART-99      [000] D.h1.    95.770664: #27142 context 
irq timer_latency    540992 ns
       timerlat/0-235     [000] .....    95.770841: #27142 context 
thread timer_latency    713024 ns

> 
> -- Steve
> 

