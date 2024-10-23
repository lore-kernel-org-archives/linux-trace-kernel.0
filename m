Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954F11607B7;
	Wed, 23 Oct 2024 08:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729673989; cv=none; b=CTOZoOUIZORbB0+qTjP198abiH53q4FfhYaXif+Jokp9V5WFpB1Bk7Hh4LDZfuWuxq7w473cLeeGXbntdxU1Eu9iuStKcz1iwkwVN74n/G1RyOarkxNjiZqO7tSX11uF2KrkPj/REfpbDX7W3tt+OHxn+wh4C2w5lo5JaKvMC0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729673989; c=relaxed/simple;
	bh=avuoVgBcfmbIHNCiyU8RvOrOZgQENWOaajoEHgAXT0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F2NWvqkY6CQhCYBX/hKkKnBu+RJxFOXm9dFkgACD1PnPYSVLsq9t5JwP7Acb+42BndVeDicpJpPjLGTQz4ftuCftbXrBHz7ITpFfw3NT91xb5Ak2KhHFjABddC3o98u4QfXIB8wofwKm65E9jmI1klsHdz1sBVdWh7T9ICW9uZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=none smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=ZALe26Ak; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yoseli.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="ZALe26Ak"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 09746E0002;
	Wed, 23 Oct 2024 08:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1729673983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UJaVg05TpGxgcHK8z5rCBAN6qZL6H8ZEmcOQbT18p8A=;
	b=ZALe26AkgEWhPT8/8dfrIYN7ce8anVtSIARs6nAv0Ns+pqRwG1Ovg68on5CORrSp0cyY2k
	2tIacCaxKNaGB0PQnCqgm418EFGeL8Vb3ZFtUFjo134F3AwZ17mDytRHd0ZR2vDY5Uyzv9
	x7h1Vx8skbmW9EePI4cDWoL0Py9Oq+DpIgS3jBmZOtQ/vNjTXoF0wOKG2leEc1KOPm+rbF
	z3kA/noNZT6hrlN0ptCmcoawqUrPqvd21wZUYaWIDmiSgAP0AFiH+qPFDeNdDDguSxbhzr
	IhK5Bi9nK4vbUThXqX1UhAZqJl1P9VnJIf5hNDGJNYsdDuxi+C40Ks3MciSz4Q==
Message-ID: <57719b35-5e7a-4c9e-b9a3-5017dec73803@yoseli.org>
Date: Wed, 23 Oct 2024 10:59:42 +0200
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
 <86eea4de-2696-4485-9c16-cd3fbbd1aae6@yoseli.org>
 <4e93964e-bafb-0474-743f-8280c46898f4@gmail.com>
Content-Language: en-US
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
In-Reply-To: <4e93964e-bafb-0474-743f-8280c46898f4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: jeanmichel.hautbois@yoseli.org

Hi Michael,

On 23/10/2024 09:30, Michael Schmitz wrote:
> Hi Jean-Michel,
> 
> Am 23.10.2024 um 18:53 schrieb Jean-Michel Hautbois:
>> Hi Michael,
>>
>> On 23/10/2024 05:53, Michael Schmitz wrote:
>>> Jean-Michel,
>>>
>>> thanks for your patches!
>>>
>>> Am 21.10.2024 um 22:44 schrieb Jean-Michel Hautbois:
>>>> The TRACE_IRQFLAGS_SUPPORT requires the architecture to call
>>>> trace_hardirqs_off() when interrupts are disabled and
>>>> trace_hardirqs_on() when they are enabled.
>>>> Add those calls to do_IRQ function.
>>>
>>> You will also have to add these calls to the three sites in arch/m68k/
>>> coldfire/head.S where interrupts are enabled or disabled.
>>
>> Thanks for this ! I prepared a v2 with those calls added. I am wondering
> 
> Good -
> 
>> if my second patch is ok, I think it is not, could you please review it
> 
> I'll have to read up on how arch_stack_walk is supposed to work - have 
> never seen that code before.
> 
>> ? There may already be something related to the stack in the assembly
>> part useful to implement arch_stack_walk() in a different way ?
> 
> I doubt it
> 
>>>
>>> Here:
>>>> ENTRY(system_call)
>>>>         SAVE_ALL_SYS
>>>>         move    #0x2000,%sr             /* enable intrs again */
>>>>         GET_CURRENT(%d2)
>>>
>>> and here:
>>>> ret_from_exception:
>>>>         move    #0x2700,%sr             /* disable intrs */
>>>>         btst    #5,%sp@(PT_OFF_SR)      /* check if returning to
>>>> kernel */
>>>>         jeq     Luser_return            /* if so, skip resched,
>>>> signals */
>>>
>>> and here:
>>>> Lwork_to_do:
>>>>         movel   %a0@(TINFO_FLAGS),%d1   /* get thread_info->flags */
>>>>         move    #0x2000,%sr             /* enable intrs again */
>>>>         btst    #TIF_NEED_RESCHED,%d1
>>>>         jne     reschedule
>>>
>>> There's one similar site in arch/m68k/kernel/head.S
>>> (ret_from_exception) where interrupts are enabled that would need a
>>> similar change, if you want to enable this for all m68k.
>>
>> I won't be able to test it though ;-).
>> I see there are a few interrupts disabling in
>> arch/m68k/include/asm/entry.h too ?
> 
> Right - that's different in the coldfire stack save/restore macros. I 
> missed that before.
> 
> Looks like wherever SAVE_ALL_SYS, SAVE_ALL_INT and RESTORE_USER are 
> used, calls to trace_irqs_on/off() are required as well.
> 
> RESTORE_USER only restores the IPL in the CONFIG_COLDFIRE_SW_A7, which 
> makes this a little tricky ... you might have to add these calls to the 
> macros to get the correct behaviour.
> 

Sadly, not that straightforward.
I have this patch right now:
diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index b2a3093af677..fc4a2d124514 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -41,6 +41,7 @@ config M68K
         select ZONE_DMA
         select ARCH_SUPPORTS_RT
         select IRQ_FORCED_THREADING
+       select TRACE_IRQFLAGS_SUPPORT

  config CPU_BIG_ENDIAN
         def_bool y
diff --git a/arch/m68k/coldfire/entry.S b/arch/m68k/coldfire/entry.S
index 4ea08336e2fb..fbdc4404f29e 100644
--- a/arch/m68k/coldfire/entry.S
+++ b/arch/m68k/coldfire/entry.S
@@ -57,6 +57,9 @@ enosys:
  ENTRY(system_call)
         SAVE_ALL_SYS
         move    #0x2000,%sr             /* enable intrs again */
+#ifdef CONFIG_TRACE_IRQFLAGS
+       jbsr    trace_hardirqs_on
+#endif
         GET_CURRENT(%d2)

         cmpl    #NR_syscalls,%d0
@@ -99,6 +102,9 @@ ENTRY(system_call)
         addql   #4,%sp

  ret_from_exception:
+#ifdef CONFIG_TRACE_IRQFLAGS
+       jbsr    trace_hardirqs_off
+#endif
         move    #0x2700,%sr             /* disable intrs */
         btst    #5,%sp@(PT_OFF_SR)      /* check if returning to kernel */
         jeq     Luser_return            /* if so, skip resched, signals */
@@ -140,6 +146,9 @@ Lreturn:
  Lwork_to_do:
         movel   %a0@(TINFO_FLAGS),%d1   /* get thread_info->flags */
         move    #0x2000,%sr             /* enable intrs again */
+#ifdef CONFIG_TRACE_IRQFLAGS
+       jbsr    trace_hardirqs_on
+#endif
         btst    #TIF_NEED_RESCHED,%d1
         jne     reschedule

But it fails when init is called:
[    5.313000] Run /bin/bash as init process
[    5.314000]   with arguments:
[    5.315000]     /bin/bash
[    5.316000]   with environment:
[    5.317000]     HOME=/
[    5.318000]     TERM=linux
[    5.684000] Kernel panic - not syncing: Attempted to kill init! 
exitcode=0x0000000b
[    5.684000] CPU: 0 UID: 0 PID: 1 Comm: bash Not tainted 
6.12.0-rc4-00049-g4393ca34ead3 #364
[    5.684000] Stack from 41a03e18:
[    5.684000]         41a03e18 41540187 41540187 0000000a ffffffff 
415a8fb4 4140dd90 41416588
[    5.684000]         41540187 4140d5de 4102ba84 4100b19c 4100b1a8 
00000000 41a38000 4102ba3a
[    5.684000]         41a03ea0 4100c34a 4150e87e 0000000b 0000000b 
41a03f80 0000000a 41a3c0d4
[    5.684000]         41a02000 400004d8 41a08000 4102ba3a 4102ba84 
00000000 00000000 000000ff
[    5.684000]         00000000 00000000 41a03ef4 4100cb82 0000000b 
0000000b 41a03f80 41a03f6c
[    5.684000]         41016cd2 0000000b 41a03f6c 0000001d 00000026 
0000048c ffffffff 00000006
[    5.684000] Call Trace: [<4140dd90>] _printk+0x0/0x18
[    5.684000]  [<41416588>] dump_stack+0xc/0x10
[    5.684000]  [<4140d5de>] panic+0xf2/0x2d4
[    5.684000]  [<4102ba84>] preempt_count_sub+0x0/0x2e
[    5.684000]  [<4100b19c>] arch_local_irq_enable+0x0/0xc
[    5.684000]  [<4100b1a8>] arch_irqs_disabled+0x0/0x10
[    5.684000]  [<4102ba3a>] preempt_count_add+0x0/0x1e
[    5.684000]  [<4100c34a>] do_exit+0x266/0x930
[    5.684000]  [<4102ba3a>] preempt_count_add+0x0/0x1e
[    5.684000]  [<4102ba84>] preempt_count_sub+0x0/0x2e
[    5.684000]  [<4100cb82>] do_group_exit+0x26/0xba
[    5.684000]  [<41016cd2>] get_signal+0x60e/0x76c
[    5.684000]  [<410044e8>] test_ti_thread_flag+0x0/0x14
[    5.684000]  [<4102ba94>] preempt_count_sub+0x10/0x2e
[    5.684000]  [<41004b68>] do_notify_resume+0x3a/0x4c6
[    5.684000]  [<41015d52>] force_sig_fault_to_task+0x32/0x3e
[    5.684000]  [<41015d72>] force_sig_fault+0x14/0x1a
[    5.684000]  [<41005606>] buserr_c+0x9a/0x188
[    5.684000]  [<410065fc>] Lsignal_return+0x14/0x24
[    5.684000]  [<410065de>] Lwork_to_do+0xe/0x18
[    5.684000]
[    5.684000] ---[ end Kernel panic - not syncing: Attempted to kill 
init! exitcode=0x0000000b ]---


JM

>>
>>>
>>> Registers %d0-%d5 and %a0-%a2 are saved on the stack at this point and
>>> can be clobbered if need be.
>>
>> I don't know if they need to be clobbered...
> 
> I meant to say that if you need registers to prepare function arguments 
> for trace_irqs_on/off() on the stack, these can be used. But that may 
> not be necessary in this case.
> 
> Cheers,
> 
>      Michael
> 
> 
>>
>> Thanks,
>> JM
>>
>>>
>>> Cheers,
>>>
>>>      Michael
>>>
>>>
>>>>
>>>> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
>>>> ---
>>>>  arch/m68k/Kconfig      | 1 +
>>>>  arch/m68k/kernel/irq.c | 2 ++
>>>>  2 files changed, 3 insertions(+)
>>>>
>>>> diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
>>>> index
>>>> cc26df907bfe3c8143a931d259eceabb16af7411..ab3375475721fa63418c40d4ba6ac76679ebc77d
>>>> 100644
>>>> --- a/arch/m68k/Kconfig
>>>> +++ b/arch/m68k/Kconfig
>>>> @@ -39,6 +39,7 @@ config M68K
>>>>      select OLD_SIGSUSPEND3
>>>>      select UACCESS_MEMCPY if !MMU
>>>>      select ZONE_DMA
>>>> +    select TRACE_IRQFLAGS_SUPPORT
>>>>
>>>>  config CPU_BIG_ENDIAN
>>>>      def_bool y
>>>> diff --git a/arch/m68k/kernel/irq.c b/arch/m68k/kernel/irq.c
>>>> index
>>>> 9ab4f550342e5de11c528f55781432675ffd66bf..74cf60ebbc4bca51f3caa4046dbd2bdb02355711
>>>> 100644
>>>> --- a/arch/m68k/kernel/irq.c
>>>> +++ b/arch/m68k/kernel/irq.c
>>>> @@ -21,9 +21,11 @@ asmlinkage void do_IRQ(int irq, struct pt_regs 
>>>> *regs)
>>>>  {
>>>>      struct pt_regs *oldregs = set_irq_regs(regs);
>>>>
>>>> +    trace_hardirqs_off();
>>>>      irq_enter();
>>>>      generic_handle_irq(irq);
>>>>      irq_exit();
>>>> +    trace_hardirqs_on();
>>>>
>>>>      set_irq_regs(oldregs);
>>>>  }
>>>>
>>

