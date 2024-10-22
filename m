Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CAB13B59E;
	Tue, 22 Oct 2024 05:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729575735; cv=none; b=iKMl3ehm01w63X5Krm/JUiIrcGlJFRqBnJUXP4nOQu949TNqFPHpovZh2lrp34+S4flPjpdKAYSJ3/eNY5Vsf2socRTsoFIDchg7lDR2JC2H5oECzSHpfwUZ80VbUZiSDWTHweZqQsovnGapLYHX8r+Ttv85cEgm5YFdRX9OjPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729575735; c=relaxed/simple;
	bh=ITGPMDLWm1cpr9OdganmwN/ZJufyuOaNs7Ifn1uexTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LKQoqeWXGqNViZ0nyiPf3MoTmfS0Tj6PRXzwuD5g2aflz9+1it4qOhG1CJKLkBlRoXzPAEBDu0S5W3YWEZXUJ27d0vqSxSGP1YSuHzuoL9lPa7l6oFUpaFUIou05VNJ1qhoIGALOa7hZeHMPj0Za5ffy8HPPX2S+PgDyJGvlULY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=none smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=c5MaUZ3t; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yoseli.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="c5MaUZ3t"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 37E8E20004;
	Tue, 22 Oct 2024 05:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1729575731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0OvqaX/hJ3L/xnjQ+i7iCYEcS54tFywcWXvR7vkK5io=;
	b=c5MaUZ3tbaNyEtgwjwrVzYpYWklJbdpcujBLdw8rFoZNr2QTu6Yg2cvbaW9382lSSM69wD
	3IP1VDH8IK+hfbg0O6sP8Hnt5w7ELY4Vs07zd5m9n40ht5uuPBWFi2XkoZGY19SJ32Walz
	buZLuQtKuCfgc/rYLEWB2+uMMNtHkKesp0IQx5lXaKcun+STjvyr8aP5Py3G2C8w7Wgny9
	43NBGVn/ZCb8O4cFmP90vx745zSSNJqwxjJEJ5Eto78x3jNoGd5L4w+hzZWA6FNgnOmdT3
	/PpmgU/bKAOHnhqpo+Kb7hm5/YS6N75TnBmTs1UvbS1KOQ8evzOfFXRRLx55eQ==
Message-ID: <075d6720-a690-437c-a10f-e2746651e2a8@yoseli.org>
Date: Tue, 22 Oct 2024 07:42:10 +0200
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
Content-Language: en-US
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
In-Reply-To: <20241022012809.1ef083cd@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: jeanmichel.hautbois@yoseli.org

Hi Steve,

On 22/10/2024 07:28, Steven Rostedt wrote:
> On Mon, 21 Oct 2024 11:44:42 +0200
> Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org> wrote:
> 
>> The TRACE_IRQFLAGS_SUPPORT requires the architecture to call
>> trace_hardirqs_off() when interrupts are disabled and
>> trace_hardirqs_on() when they are enabled.
>> Add those calls to do_IRQ function.
>>
>> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
>> ---
>>   arch/m68k/Kconfig      | 1 +
>>   arch/m68k/kernel/irq.c | 2 ++
>>   2 files changed, 3 insertions(+)
>>
>> diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
>> index cc26df907bfe3c8143a931d259eceabb16af7411..ab3375475721fa63418c40d4ba6ac76679ebc77d 100644
>> --- a/arch/m68k/Kconfig
>> +++ b/arch/m68k/Kconfig
>> @@ -39,6 +39,7 @@ config M68K
>>   	select OLD_SIGSUSPEND3
>>   	select UACCESS_MEMCPY if !MMU
>>   	select ZONE_DMA
>> +	select TRACE_IRQFLAGS_SUPPORT
>>   
>>   config CPU_BIG_ENDIAN
>>   	def_bool y
>> diff --git a/arch/m68k/kernel/irq.c b/arch/m68k/kernel/irq.c
>> index 9ab4f550342e5de11c528f55781432675ffd66bf..74cf60ebbc4bca51f3caa4046dbd2bdb02355711 100644
>> --- a/arch/m68k/kernel/irq.c
>> +++ b/arch/m68k/kernel/irq.c
>> @@ -21,9 +21,11 @@ asmlinkage void do_IRQ(int irq, struct pt_regs *regs)
>>   {
>>   	struct pt_regs *oldregs = set_irq_regs(regs);
>>   
>> +	trace_hardirqs_off();
>>   	irq_enter();
>>   	generic_handle_irq(irq);
>>   	irq_exit();
>> +	trace_hardirqs_on();
> 
> This part of the patch shouldn't be needed because those shoudl be
> called by irq_enter() and irq_exit(). Does this not work if you don't
> have these?

Thanks for your quick review !
Indeed, it works without those lines, so the patch is now a one-liner 
:-). I will wait for the second part to be reviewed before sending v2.

JM
