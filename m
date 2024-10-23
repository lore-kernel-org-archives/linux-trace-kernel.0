Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7612C2AD20;
	Wed, 23 Oct 2024 03:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729655292; cv=none; b=KouQHtt9ZqkpIL6JIFcXOwI/6fp4uIkATQ+IssJ4sv3Dmgv+A/Di6HYtJitBNp89KU/Ga5jqCRHPuTtbhwzHBR27UBJu+LDu+IZmKz53sAx+XQx2lUNbAQTaRN8ym20FzAAbs9yGGnFucEvAvu5lQxTEXNLHmjXRdd7bRsy8/80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729655292; c=relaxed/simple;
	bh=IBEoBR/dDKlRcsu8ONxOis+9sgK2u7yyPubCxR3/cw8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jJFxyUq7rTJs4mGAFZd6WLiu3sGBK8aGL5+VSwIT41ou4tcHXAYlwBapajDVI+b5bA2PIByoumvinvjISy+AxmKZcD1kEFwtjHLA1MjbRY04h3UXMHd75rlj7MLKWDp8URxo7APtMoqhnEFTXVpOSBK64weKA8jXfmM5S2Om2jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XYFMs3zbpzyTPd;
	Wed, 23 Oct 2024 11:46:33 +0800 (CST)
Received: from kwepemg200008.china.huawei.com (unknown [7.202.181.35])
	by mail.maildlp.com (Postfix) with ESMTPS id B7ED6180103;
	Wed, 23 Oct 2024 11:48:04 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemg200008.china.huawei.com (7.202.181.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 23 Oct 2024 11:48:03 +0800
Message-ID: <f9b4a78d-4470-9be0-6d70-fdbe5229960b@huawei.com>
Date: Wed, 23 Oct 2024 11:48:03 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2] arm: Add KPROBES_ON_FTRACE supported
Content-Language: en-US
To: Masami Hiramatsu <mhiramat@kernel.org>
CC: <corbet@lwn.net>, <rostedt@goodmis.org>, <mark.rutland@arm.com>,
	<linux@armlinux.org.uk>, <ardb@kernel.org>, <yangtiezhu@loongson.cn>,
	<arnd@arndb.de>, <kees@kernel.org>, <rmk+kernel@armlinux.org.uk>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>
References: <20240618035242.3491691-1-ruanjinjie@huawei.com>
 <20241021174026.6133c7e847c8e94b9cd7e169@kernel.org>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20241021174026.6133c7e847c8e94b9cd7e169@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemg200008.china.huawei.com (7.202.181.35)



On 2024/10/21 16:40, Masami Hiramatsu wrote:
> Hi Jinjie,
> 
> Sorry for reviewing so late. I have some comments below.
> 
> On Tue, 18 Jun 2024 11:52:42 +0800
> Jinjie Ruan <ruanjinjie@huawei.com> wrote:
> 
>> Add support for kprobes on ftrace call sites to avoid much of the overhead
>> with regular kprobes. Try it with simple steps:
>>
>> 	cd /sys/kernel/debug/tracing/
>> 	echo 'p:myprobe sys_clone r0=%r0 r1=%r1 r2=%r2' > kprobe_events
>> 	echo 1 > events/kprobes/enable
>> 	echo  1 > events/kprobes/myprobe/enable
>> 	cat trace
>> 	# tracer: nop
>> 	#
>> 	# entries-in-buffer/entries-written: 2/2   #P:4
>> 	#
>> 	#                                _-----=> irqs-off/BH-disabled
>> 	#                               / _----=> need-resched
>> 	#                              | / _---=> hardirq/softirq
>> 	#                              || / _--=> preempt-depth
>> 	#                              ||| / _-=> migrate-disable
>> 	#                              |||| /     delay
>> 	#           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
>> 	#              | |         |   |||||     |         |
>> 	              sh-75      [000] .....    33.793362: myprobe: (sys_clone+0xc/0xa0) r0=0x1200011 r1=0x0 r2=0x0
>> 	              sh-75      [000] .....    34.817804: myprobe: (sys_clone+0xc/0xa0) r0=0x1200011 r1=0x0 r2=0x0
>>
>> 	cat /sys/kernel/debug/kprobes/list
>> 		c03453e8  k  sys_clone+0xc    [FTRACE]
>> 					       ^^^^^^
>>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202406160646.J89U1UKK-lkp@intel.com/
>> ---
>> v2:
>> - Fix the allmodconfig compile issue by renaming "NOP" to "FTRACE_NOP".
>> ---
>>  .../debug/kprobes-on-ftrace/arch-support.txt  |  2 +-
>>  arch/arm/Kconfig                              |  1 +
>>  arch/arm/include/asm/ftrace.h                 | 17 ++++++
>>  arch/arm/kernel/ftrace.c                      | 19 +------
>>  arch/arm/probes/Makefile                      |  1 +
>>  arch/arm/probes/ftrace.c                      | 53 +++++++++++++++++++
>>  arch/arm/probes/kprobes/core.c                | 32 +++++++++++
>>  7 files changed, 106 insertions(+), 19 deletions(-)
>>  create mode 100644 arch/arm/probes/ftrace.c
>>
>> diff --git a/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt b/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
>> index 02febc883588..4ecd7d53e859 100644
>> --- a/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
>> +++ b/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
>> @@ -8,7 +8,7 @@
>>      -----------------------
>>      |       alpha: | TODO |
>>      |         arc: | TODO |
>> -    |         arm: | TODO |
>> +    |         arm: |  ok  |
>>      |       arm64: | TODO |
>>      |        csky: |  ok  |
>>      |     hexagon: | TODO |
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index 9f09a16338e3..036381c5d42f 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -114,6 +114,7 @@ config ARM
>>  	select HAVE_KERNEL_LZO
>>  	select HAVE_KERNEL_XZ
>>  	select HAVE_KPROBES if !XIP_KERNEL && !CPU_ENDIAN_BE32 && !CPU_V7M
>> +	select HAVE_KPROBES_ON_FTRACE if !XIP_KERNEL && !CPU_ENDIAN_BE32 && !CPU_V7M
> 
> You should write this as
> 
> select HAVE_KPROBES_ON_FTRACE if HAVE_KPROBES
> 
> to clear that this needs more restrictions than Kprobes or not.
> 
>>  	select HAVE_KRETPROBES if HAVE_KPROBES
>>  	select HAVE_MOD_ARCH_SPECIFIC
>>  	select HAVE_NMI
>> diff --git a/arch/arm/include/asm/ftrace.h b/arch/arm/include/asm/ftrace.h
>> index 5be3ddc96a50..ecf5590f3657 100644
>> --- a/arch/arm/include/asm/ftrace.h
>> +++ b/arch/arm/include/asm/ftrace.h
>> @@ -22,6 +22,23 @@ struct dyn_arch_ftrace {
>>  #endif
>>  };
>>  
>> +/*
>> + * The compiler emitted profiling hook consists of
>> + *
>> + *   PUSH    {LR}
>> + *   BL	     __gnu_mcount_nc
>> + *
>> + * To turn this combined sequence into a NOP, we need to restore the value of
>> + * SP before the PUSH. Let's use an ADD rather than a POP into LR, as LR is not
>> + * modified anyway, and reloading LR from memory is highly likely to be less
>> + * efficient.
>> + */
>> +#ifdef CONFIG_THUMB2_KERNEL
>> +#define	FTRACE_NOP		0xf10d0d04	/* add.w sp, sp, #4 */
>> +#else
>> +#define	FTRACE_NOP		0xe28dd004	/* add   sp, sp, #4 */
>> +#endif
>> +
>>  static inline unsigned long ftrace_call_adjust(unsigned long addr)
>>  {
>>  	/* With Thumb-2, the recorded addresses have the lsb set */
>> diff --git a/arch/arm/kernel/ftrace.c b/arch/arm/kernel/ftrace.c
>> index e61591f33a6c..0bb372f5aa1d 100644
>> --- a/arch/arm/kernel/ftrace.c
>> +++ b/arch/arm/kernel/ftrace.c
>> @@ -25,23 +25,6 @@
>>  #include <asm/stacktrace.h>
>>  #include <asm/patch.h>
>>  
>> -/*
>> - * The compiler emitted profiling hook consists of
>> - *
>> - *   PUSH    {LR}
>> - *   BL	     __gnu_mcount_nc
>> - *
>> - * To turn this combined sequence into a NOP, we need to restore the value of
>> - * SP before the PUSH. Let's use an ADD rather than a POP into LR, as LR is not
>> - * modified anyway, and reloading LR from memory is highly likely to be less
>> - * efficient.
>> - */
>> -#ifdef CONFIG_THUMB2_KERNEL
>> -#define	NOP		0xf10d0d04	/* add.w sp, sp, #4 */
>> -#else
>> -#define	NOP		0xe28dd004	/* add   sp, sp, #4 */
>> -#endif
>> -
>>  #ifdef CONFIG_DYNAMIC_FTRACE
>>  
>>  static int __ftrace_modify_code(void *data)
>> @@ -60,7 +43,7 @@ void arch_ftrace_update_code(int command)
>>  
>>  static unsigned long ftrace_nop_replace(struct dyn_ftrace *rec)
>>  {
>> -	return NOP;
>> +	return FTRACE_NOP;
>>  }
>>  
>>  void ftrace_caller_from_init(void);
>> diff --git a/arch/arm/probes/Makefile b/arch/arm/probes/Makefile
>> index 8b0ea5ace100..b3c355942a21 100644
>> --- a/arch/arm/probes/Makefile
>> +++ b/arch/arm/probes/Makefile
>> @@ -1,6 +1,7 @@
>>  # SPDX-License-Identifier: GPL-2.0
>>  obj-$(CONFIG_UPROBES)		+= decode.o decode-arm.o uprobes/
>>  obj-$(CONFIG_KPROBES)		+= decode.o kprobes/
>> +obj-$(CONFIG_KPROBES_ON_FTRACE)	+= ftrace.o
>>  ifdef CONFIG_THUMB2_KERNEL
>>  obj-$(CONFIG_KPROBES)		+= decode-thumb.o
>>  else
>> diff --git a/arch/arm/probes/ftrace.c b/arch/arm/probes/ftrace.c
>> new file mode 100644
>> index 000000000000..0f54b8e5d2a6
>> --- /dev/null
>> +++ b/arch/arm/probes/ftrace.c
>> @@ -0,0 +1,53 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#include <linux/kprobes.h>
>> +
>> +/* Ftrace callback handler for kprobes -- called under preepmt disabled */
>> +void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
>> +			   struct ftrace_ops *ops, struct ftrace_regs *regs)
> 
> nit: ftrace_regs argument should be 'fregs' to distinguish from pt_regs.
> 
>> +{
> 
> To avoid accessing regs inside fregs, use ftrace_get_regs() here.
> 
> struct pt_regs *regs = ftrace_get_regs(fregs);
> 
> And check regs is not NULL.
> 
>> +	struct kprobe *p;
>> +	struct kprobe_ctlblk *kcb;
> 
> ----
> 	int bit;
> 
> 	if (unlikely(kprobe_ftrace_disabled))
> 		return;
> 
> 	bit = ftrace_test_recursion_trylock(ip, parent_ip);
> 	if (bit < 0)
> 		return;
> ----
> 
> See arch/x86/kernel/kprobes/ftrace.c 
> 
>> +
>> +	p = get_kprobe((kprobe_opcode_t *)ip);
>> +	if (unlikely(!p) || kprobe_disabled(p))
>> +		return;
>> +
>> +	kcb = get_kprobe_ctlblk();
>> +	if (kprobe_running()) {
>> +		kprobes_inc_nmissed_count(p);
>> +	} else {
>> +		unsigned long orig_ip = instruction_pointer(&(regs->regs));
>> +
>> +		instruction_pointer_set(&(regs->regs), ip);
>> +
>> +		__this_cpu_write(current_kprobe, p);
>> +		kcb->kprobe_status = KPROBE_HIT_ACTIVE;
>> +		if (!p->pre_handler || !p->pre_handler(p, &(regs->regs))) {
>> +			/*
>> +			 * Emulate singlestep (and also recover regs->pc)
>> +			 * as if there is a nop
>> +			 */
>> +			instruction_pointer_set(&(regs->regs),
>> +						(unsigned long)p->addr + MCOUNT_INSN_SIZE);
> 
> Hm, x86 implementation is somewhat wrong (not good). This instruction
> pointer should be updated only if p->post_handler is there...
> 
>> +			if (unlikely(p->post_handler)) {
>> +				kcb->kprobe_status = KPROBE_HIT_SSDONE;
>> +				p->post_handler(p, &(regs->regs), 0);
>> +			}
>> +			instruction_pointer_set(&(regs->regs), orig_ip);
>> +		}
>> +
>> +		/*
>> +		 * If pre_handler returns !0, it changes regs->pc. We have to
>> +		 * skip emulating post_handler.
>> +		 */
>> +		__this_cpu_write(current_kprobe, NULL);
>> +	}
> 
> And 
> 
> out:
> 	ftrace_test_recursion_unlock(bit);
> 
>> +}
>> +NOKPROBE_SYMBOL(kprobe_ftrace_handler);
>> +
>> +int arch_prepare_kprobe_ftrace(struct kprobe *p)
>> +{
>> +	p->ainsn.insn = NULL;
>> +	return 0;
>> +}
>> diff --git a/arch/arm/probes/kprobes/core.c b/arch/arm/probes/kprobes/core.c
>> index d8238da095df..45ccf8bea5e4 100644
>> --- a/arch/arm/probes/kprobes/core.c
>> +++ b/arch/arm/probes/kprobes/core.c
>> @@ -45,6 +45,38 @@ DEFINE_PER_CPU(struct kprobe *, current_kprobe) = NULL;
>>  DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
>>  
>>  
>> +kprobe_opcode_t *arch_adjust_kprobe_addr(unsigned long addr, unsigned long offset,
>> +					 bool *on_func_entry)
>> +{
> 
> Here @addr is a symbol address and @offset is the probe offset from symbol.
> 
>> +#ifdef CONFIG_KPROBES_ON_FTRACE
>> +	unsigned long nop_offset = 0;
> 
> In the above comment in ftrace.h, the mcount callsite code should be
> 
> <FUNCTION>:
>  PUSH {LR}
>  FTRACE_NOP
> 
> Thus if the @offset is 0 or 4, then we should check the function's entry
> sequence (2 instructions) should be the above pattern, and if so,
> the offset should be skipped and the address should be @addr + 4.
> If there is no such pattern, do not change it, return @addr + @offset.

Hi, Masami,

Actually, it doesn't have to be, the following is some example for
arm32, before the { psu {lr}, bl mocunt}, there may be different number
of push stack instructions:

c04fa4dc <do_sys_open>:
c04fa4dc:       e92d4030        push    {r4, r5, lr}
c04fa4e0:       e24dd03c        sub     sp, sp, #60     ; 0x3c
c04fa4e4:       e52de004        push    {lr}            ; (str lr, [sp,
#-4]!)
c04fa4e8:       ebf85796        bl      c0310348 <__gnu_mcount_nc>

c03453dc <__se_sys_clone>:
c03453dc:       e92d40f0        push    {r4, r5, r6, r7, lr}
c03453e0:       e24dd05c        sub     sp, sp, #92     ; 0x5c
c03453e4:       e52de004        push    {lr}            ; (str lr, [sp,
#-4]!)
c03453e8:       ebff2bd6        bl      c0310348 <__gnu_mcount_nc>
c03453ec:       e1a06003        mov     r6, r3


c0378820 <sched_show_task>
c0378820:      e92d4810         push    {r4, fp, lr}
c0378824:      e28db008         add     fp, sp, #8
c0378828:      e24dd00c         sub     sp, sp, #12
c037882c:      e52de004         push    {lr}            ;(str lr,[sp,#-4]!)
c0378830:      ebfe5ec4         bl      c0310348 <__gnu_mcount_nc>

8010111c <handle_fiq_as_nmi>:
8010111c:       e92d4070        push    {r4, r5, r6, lr}
80101120:       e52de004        push    {lr}            ; (str lr, [sp,
#-4]!)
80101124:       eb007f4a        bl      80120e54 <__gnu_mcount_nc>


80101334 <__do_softirq>:
80101334:       e52de004        push    {lr}            ; (str lr, [sp,
#-4]!)
80101338:       eb007ec5        bl      80120e54 <__gnu_mcount_nc>


> 
> So, something like,
> 
> #define ARM_MCOUNT_OFFSET 4
> 
> if (offset <= ARM_MCOUNT_OFFSET) {
> 	if (copy_from_kernel_nofault())
> 		goto out;
> 	if (insn != FTRACE_PUSH_LR)
> 		goto out;
> 	if (copy_from_kernel_nofault())
> 		goto out;
> 	if (insn != FTRACE_NOP)
> 		goto out;
> 	if (!offset)
> 		
> 	offset = ARM_MCOUNT_OFFSET;
> 	*on_func_entry = true;
> }
> out:
> 	return addr + offset;
> 
> Thank you,
> 
>> +	u32 insn = 0;
>> +
>> +	/*
>> +	 * Since 'addr' is not guaranteed to be safe to access, use
>> +	 * copy_from_kernel_nofault() to read the instruction:
>> +	 */
>> +	if (copy_from_kernel_nofault(&insn, (void *)(addr + nop_offset),
>> +				     sizeof(u32)))
>> +		return NULL;
>> +
>> +	while (insn != FTRACE_NOP) {
>> +		nop_offset += 4;
>> +		if (copy_from_kernel_nofault(&insn, (void *)(addr + nop_offset),
>> +					     sizeof(u32)))
>> +			return NULL;
>> +	}
>> +
>> +	*on_func_entry = offset <= nop_offset;
>> +	if (*on_func_entry)
>> +		offset = nop_offset;
>> +#else
>> +	*on_func_entry = !offset;
>> +#endif
>> +
>> +	return (kprobe_opcode_t *)(addr + offset);
>> +}
>> +
>>  int __kprobes arch_prepare_kprobe(struct kprobe *p)
>>  {
>>  	kprobe_opcode_t insn;
>> -- 
>> 2.34.1
>>
> 
> 
