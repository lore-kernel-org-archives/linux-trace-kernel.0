Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03ED238E8D0;
	Mon, 10 Aug 2026 08:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786349135; cv=none; b=a7hTN5ECu9n3pQ4Mw/MJDlMYcSd3/gpeZfAcJOGY+wjkliv5dm1Kv8dR4g7llDuGmMz3dy3h4gP3hggT/BUeYlyTAz0J/wMY7Tj9TlAVmGfsW8Eis2JbPwV8k3AuM33SvY/C0I62sHa5l5ViiRODXOxQZjjX2+FfeeM2cqd4Ci8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786349135; c=relaxed/simple;
	bh=OsQ8XQe+R6FeIlrmQhhm8qY4zTyIythOi5Ylpzqu4bY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Myl3AuHgUblGsur7YzyJuS0XUqouQ3Vzf7pZ/ktK0cbl0ty0/IcoRjxK6q3U/XyYEOQElJkY9feY11XSyjHOULg8JoHqlGsYjMxP09ik6ISSVu/Znll9qycd+tYFlUkKqukSeIB5KIatlbu5ut40J/8lPy7DE4pRiLb3ZZRc0DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [198.18.0.1] (unknown [121.237.244.183])
	by APP-03 (Coremail) with SMTP id rQCowAAHDDpDhnlq8ehwBA--.11335S2;
	Mon, 10 Aug 2026 16:05:23 +0800 (CST)
Message-ID: <2bebf1fe-6ad1-4a20-bb0b-121af1bc794e@iscas.ac.cn>
Date: Mon, 10 Aug 2026 16:05:22 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] uprobes: Restore original return address in uretprobe
 context
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20260717082331.27058-1-daichengrong@iscas.ac.cn>
 <20260723093132.4f0e5b22e81aa688f86cb9de@kernel.org>
Content-Language: en-US
From: daichengrong <daichengrong@iscas.ac.cn>
In-Reply-To: <20260723093132.4f0e5b22e81aa688f86cb9de@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAAHDDpDhnlq8ehwBA--.11335S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGr1fCr17tw15Aw17Cw4fuFg_yoWrWFyUpa
	1vkay3KFZ7Gry5uFZrXr4rZ3WFvrZ5Xw17Cr17K343C345KryxtF1I9rW5uF1YyrZ2g3W2
	yw4jgrWjvFZxJFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
	w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4j6F4UMc
	vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCY1x0262kKe7AKxVWUAVWUtwCY02Av
	z4vE14v_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUy7
	PiUUUUU
X-CM-SenderInfo: pgdluxxhqj201qj6x2xfdvhtffof0/



On 7/23/26 08:31, Masami Hiramatsu (Google) wrote:
> On Fri, 17 Jul 2026 16:23:31 +0800
> daichengrong <daichengrong@iscas.ac.cn> wrote:
> 
>> uretprobe replaces the original return address of a probed function with
>> a trampoline address to capture function return events.
>>
>> After the trampoline is entered and the uretprobe handler completes, the
>> original return address needs to be restored in the user register context
>> to keep the register state consistent with the state before probing.
>>
>> Add an architecture-specific hook for restoring the original return
>> address during uretprobe handling.
>>
>> The initial implementation adds support for RISC-V. Other architectures
>> keep the default empty implementation until their corresponding restore
>> logic is implemented.
>>
>> Signed-off-by: daichengrong <daichengrong@iscas.ac.cn>
>> ---
>>  arch/riscv/kernel/probes/uprobes.c | 7 +++++++
>>  include/linux/uprobes.h            | 1 +
>>  kernel/events/uprobes.c            | 5 +++++
>>  3 files changed, 13 insertions(+)
>>
>> diff --git a/arch/riscv/kernel/probes/uprobes.c b/arch/riscv/kernel/probes/uprobes.c
>> index eb177d0ce8ab..0b1b94d9683e 100644
>> --- a/arch/riscv/kernel/probes/uprobes.c
>> +++ b/arch/riscv/kernel/probes/uprobes.c
>> @@ -139,6 +139,13 @@ arch_uretprobe_hijack_return_addr(unsigned long trampoline_vaddr,
>>  	return ra;
>>  }
>>  
>> +void
>> +arch_uretprobe_hijack_set_addr(unsigned long orig_ret_vaddr,
>> +				  struct pt_regs *regs)
> 
> OK, but hijack may not be a good naming, what about
> "arch_uretprobe_restore_return_address()"?

Thanks for the suggestion.

I’ve renamed the function in v2 as suggested:

https://lore.kernel.org/all/20260810080140.96587-1-daichengrong@iscas.ac.cn/

Thanks,

> 
> And I need RISC-V maintainer's review.
> 
> Thank you,
> 
>> +{
>> +	regs->ra = orig_ret_vaddr;
>> +}
>> +
>>  int arch_uprobe_exception_notify(struct notifier_block *self,
>>  				 unsigned long val, void *data)
>>  {
>> diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
>> index f548fea2adec..2d0dc919845d 100644
>> --- a/include/linux/uprobes.h
>> +++ b/include/linux/uprobes.h
>> @@ -230,6 +230,7 @@ extern bool arch_uprobe_xol_was_trapped(struct task_struct *tsk);
>>  extern int  arch_uprobe_exception_notify(struct notifier_block *self, unsigned long val, void *data);
>>  extern void arch_uprobe_abort_xol(struct arch_uprobe *aup, struct pt_regs *regs);
>>  extern unsigned long arch_uretprobe_hijack_return_addr(unsigned long trampoline_vaddr, struct pt_regs *regs);
>> +extern void arch_uretprobe_hijack_set_addr(unsigned long orig_ret_vaddr, struct pt_regs *regs);
>>  extern bool arch_uretprobe_is_alive(struct return_instance *ret, enum rp_check ctx, struct pt_regs *regs);
>>  extern bool arch_uprobe_ignore(struct arch_uprobe *aup, struct pt_regs *regs);
>>  extern void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
>> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
>> index 4084e926e284..deecaae01ab7 100644
>> --- a/kernel/events/uprobes.c
>> +++ b/kernel/events/uprobes.c
>> @@ -1748,6 +1748,10 @@ void * __weak arch_uretprobe_trampoline(unsigned long *psize)
>>  	return &insn;
>>  }
>>  
>> +void __weak arch_uretprobe_hijack_set_addr(unsigned long orig_ret_vaddr, struct pt_regs *regs)
>> +{
>> +}
>> +
>>  static struct xol_area *__create_xol_area(unsigned long vaddr)
>>  {
>>  	struct mm_struct *mm = current->mm;
>> @@ -2659,6 +2663,7 @@ void uprobe_handle_trampoline(struct pt_regs *regs)
>>  		valid = !next_chain || arch_uretprobe_is_alive(next_chain, RP_CHECK_RET, regs);
>>  
>>  		instruction_pointer_set(regs, ri->orig_ret_vaddr);
>> +		arch_uretprobe_hijack_set_addr(ri->orig_ret_vaddr, regs);
>>  		do {
>>  			/* pop current instance from the stack of pending return instances,
>>  			 * as it's not pending anymore: we just fixed up original
>> -- 
>> 2.25.1
>>
>>
> 
> 


-- 
Chengrong

