Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B878145323;
	Wed, 23 Oct 2024 05:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729662824; cv=none; b=J2U193c8Xd+AGOaXX6cbAB1XPPUV5V8GOpGNxwQ1K+CGWSfmPmnO6q2KTtpHEQpfF6LHbeNIbuHIP9T9lc+ya9H8b4mtktoLKbL5poyrO3owpmbAQaddrGmyXjn/HVJ5CU3Y+5cGayncr6ur48yvfstXBjk1woyhSADBH4O0EXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729662824; c=relaxed/simple;
	bh=JG8xIFkVAmkAMbNlf9OjQcCN99iuWEAbJwPtuIirpD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ak57hsUmmHLTLScX985thdyGuRGXNBhUG6TW0PGdnQ+Wl+UIHDidUF2MfV9aSY4KZA7j4lKTrFY3bEVk8DmJ+fMYhjN4/noo/fPwIOX+bX0sZYvCeP0vQ+pUMSG2ujKEs3h55piDF3HB2LqpfxEOyQprEZYWtQb6oNx8WtvdL90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=none smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=e6h6HoH4; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yoseli.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="e6h6HoH4"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 96488C0007;
	Wed, 23 Oct 2024 05:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1729662820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Uru5ypYoR9iINvGXem77EGS2R3KpFyiiw3GqJeT5ns=;
	b=e6h6HoH4SunlVcIMGlzoWAjkXy1L6U3033COQLWdveRAKv3QkreuRDx7IAX2GINBNM0xeR
	o15qviHtZmVSyb3wyjOjKWTqfQmN+L9SCBTAoYMJ9zVJMMmRMwm7XZwAexMxeKxT46sqPa
	Kc98CsLobsVYfDZiH+1u4wEk3jhAztbGihWxBCN8KXTwh3/BKbVJ94gWzq69k0HcNzVCLd
	0tYjPQd1e1q66JuTm/V9sB+Kwt4YNJL36nFl5NJjhvA5CDneAWXAotljw6HWqtDCDXvdrT
	m/mXFweAxEbmFLN2QLGgfFnsHSauUVAEFDIH622DCtAqN/1fJINS5UuL8Lcc0g==
Message-ID: <86eea4de-2696-4485-9c16-cd3fbbd1aae6@yoseli.org>
Date: Wed, 23 Oct 2024 07:53:39 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/2] m68k: Add tracirqs
To: Michael Schmitz <schmitzmic@gmail.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org
References: <20241021-add-m68k-tracing-support-v1-0-0883d704525b@yoseli.org>
 <20241021-add-m68k-tracing-support-v1-1-0883d704525b@yoseli.org>
 <4ab85330-5a50-bde1-f014-99a8e7cb28cc@gmail.com>
Content-Language: en-US
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
In-Reply-To: <4ab85330-5a50-bde1-f014-99a8e7cb28cc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: jeanmichel.hautbois@yoseli.org

Hi Michael,

On 23/10/2024 05:53, Michael Schmitz wrote:
> Jean-Michel,
> 
> thanks for your patches!
> 
> Am 21.10.2024 um 22:44 schrieb Jean-Michel Hautbois:
>> The TRACE_IRQFLAGS_SUPPORT requires the architecture to call
>> trace_hardirqs_off() when interrupts are disabled and
>> trace_hardirqs_on() when they are enabled.
>> Add those calls to do_IRQ function.
> 
> You will also have to add these calls to the three sites in arch/m68k/ 
> coldfire/head.S where interrupts are enabled or disabled.

Thanks for this ! I prepared a v2 with those calls added. I am wondering 
if my second patch is ok, I think it is not, could you please review it 
? There may already be something related to the stack in the assembly 
part useful to implement arch_stack_walk() in a different way ?
> 
> Here:
>> ENTRY(system_call)
>>         SAVE_ALL_SYS
>>         move    #0x2000,%sr             /* enable intrs again */
>>         GET_CURRENT(%d2)
> 
> and here:
>> ret_from_exception:
>>         move    #0x2700,%sr             /* disable intrs */
>>         btst    #5,%sp@(PT_OFF_SR)      /* check if returning to 
>> kernel */
>>         jeq     Luser_return            /* if so, skip resched, 
>> signals */
> 
> and here:
>> Lwork_to_do:
>>         movel   %a0@(TINFO_FLAGS),%d1   /* get thread_info->flags */
>>         move    #0x2000,%sr             /* enable intrs again */
>>         btst    #TIF_NEED_RESCHED,%d1
>>         jne     reschedule
> 
> There's one similar site in arch/m68k/kernel/head.S (ret_from_exception) 
> where interrupts are enabled that would need a similar change, if you 
> want to enable this for all m68k.

I won't be able to test it though ;-).
I see there are a few interrupts disabling in 
arch/m68k/include/asm/entry.h too ?

> 
> Registers %d0-%d5 and %a0-%a2 are saved on the stack at this point and 
> can be clobbered if need be.

I don't know if they need to be clobbered...

Thanks,
JM

> 
> Cheers,
> 
>      Michael
> 
> 
>>
>> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
>> ---
>>  arch/m68k/Kconfig      | 1 +
>>  arch/m68k/kernel/irq.c | 2 ++
>>  2 files changed, 3 insertions(+)
>>
>> diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
>> index 
>> cc26df907bfe3c8143a931d259eceabb16af7411..ab3375475721fa63418c40d4ba6ac76679ebc77d 100644
>> --- a/arch/m68k/Kconfig
>> +++ b/arch/m68k/Kconfig
>> @@ -39,6 +39,7 @@ config M68K
>>      select OLD_SIGSUSPEND3
>>      select UACCESS_MEMCPY if !MMU
>>      select ZONE_DMA
>> +    select TRACE_IRQFLAGS_SUPPORT
>>
>>  config CPU_BIG_ENDIAN
>>      def_bool y
>> diff --git a/arch/m68k/kernel/irq.c b/arch/m68k/kernel/irq.c
>> index 
>> 9ab4f550342e5de11c528f55781432675ffd66bf..74cf60ebbc4bca51f3caa4046dbd2bdb02355711 100644
>> --- a/arch/m68k/kernel/irq.c
>> +++ b/arch/m68k/kernel/irq.c
>> @@ -21,9 +21,11 @@ asmlinkage void do_IRQ(int irq, struct pt_regs *regs)
>>  {
>>      struct pt_regs *oldregs = set_irq_regs(regs);
>>
>> +    trace_hardirqs_off();
>>      irq_enter();
>>      generic_handle_irq(irq);
>>      irq_exit();
>> +    trace_hardirqs_on();
>>
>>      set_irq_regs(oldregs);
>>  }
>>

