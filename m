Received: from mta-03.yadro.com (mta-03.yadro.com [89.207.88.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B215AD5A;
	Sun,  1 Dec 2024 15:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.207.88.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733067078; cv=none; b=UFzrOY4ayaDpgrqR5ZZ5g2I1e9TXoko8M1QaEBqMn1n1qezeoWiQCWOr41npJnBhwsVGQZkIF6zcnptpYEkzopSZSGpwn1bhS6CbYvEUrnE3YHpb+9Eib9IIBZ/cXXit6urY+cH/56Z+vqxUl6DUBi8wgjsWncv8EzSHxGoWNJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733067078; c=relaxed/simple;
	bh=RROm/nbaf//OLrCpmxxop9lguMk2k4nmWVA7Ur7yues=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UGvl0d1Zji8XGc0NxB/5ickNbsiGx/S9YROOGC/C2UPYkqMi5BIOxQfwmy6cvywsCQ7N69Mb5qc5vU4dpHSsPIrHM6nkw0JDDf68AcqMUy2CIKE1vdRjdurF7aP8xryKwQUJdV8nDyAQoFP6n5QqzCVbvGTQMx4nd7shVHuGw4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadro.com; spf=pass smtp.mailfrom=yadro.com; dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b=MgkYVtSN; dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b=vSInmEBQ; arc=none smtp.client-ip=89.207.88.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yadro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="MgkYVtSN";
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="vSInmEBQ"
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-03.yadro.com 29222E0008
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1733067065; bh=Rk4mscyhtODXOoZtND+S+9aETGqegjWDO/UcHkuTmgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=MgkYVtSN293oTUIjbbJqxqONNowdN4QqN1FqM3nHbYZpy25m7/Y97lRFP2bHuFHb5
	 WifpssSe/McUAgkMlMh0hQocqRe9/6UK2pcTRcYDc8uH46uzjkxWqJspAp9Bnc33yj
	 zIiwCTq9SFMU9T+aTpgg4gG+QfiwZRrDwkg0YBh8ETbesLiGoDQdbtSOAVkZNOY5ws
	 QR5cgm58Rt140uJx3dg5ypfRZs6Med79F+FS3ZuwOp4X0ohaTRd8KDfR5uS+4OJhxs
	 zk+kpC0sk7X86VGa7UQSIaCJbM3Q7bs2qpLs/DfLnCG29R3AAvtBmN556duRLgPY7w
	 88Wl52Wyr7Egw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1733067065; bh=Rk4mscyhtODXOoZtND+S+9aETGqegjWDO/UcHkuTmgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=vSInmEBQjOunc3kSw9zLl0Nikb4nl+yFmWBYBH6N1RoEZDagW3Ny+ZIQHtkdEAFEt
	 3gkJhKWynUwsO+2s36AeKzOXFCmAGVl7NnqwGPCr86PKbp64NHRp8zWTv4CF4NCMVS
	 xpP8BrV+0uKfDDaOOh2WGrFCZQUBuDt1w+SR71PsOqZBHrzU4W6bgAHnOpWkJymFbz
	 wqNlzp8+vTTlU7cj8f4UctP90CgT/NBoZSYSrpQ4wQdYZO98W7MNKCUe1B+Cj+bL7K
	 jWDESxagqYFHqyxA1GFv3JlW/2cwn4mBQ3H/FiQ/xeDlv4kQ0YbW4Umu0YdA0bRm4L
	 K6T2iIct021oQ==
Message-ID: <12e8b66b-5a6e-435e-b927-18a3ce2216e3@yadro.com>
Date: Sun, 1 Dec 2024 18:31:03 +0300
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/7] riscv: ftrace: prepare ftrace for atomic code
 patching
To: Andy Chiu <andybnac@gmail.com>
CC: Albert Ou <aou@eecs.berkeley.edu>, Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>, Mark Rutland
	<mark.rutland@arm.com>, Masami Hiramatsu <mhiramat@kernel.org>, Steven
 Rostedt <rostedt@goodmis.org>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<bjorn@rivosinc.com>, <puranjay12@gmail.com>, <alexghiti@rivosinc.com>,
	<yongxuan.wang@sifive.com>, <greentime.hu@sifive.com>, <nick.hu@sifive.com>,
	<nylon.chen@sifive.com>, <tommy.wu@sifive.com>, <eric.lin@sifive.com>,
	<viccent.chen@sifive.com>, <zong.li@sifive.com>, <samuel.holland@sifive.com>,
	<linux@yadro.com>
References: <20241127172908.17149-1-andybnac@gmail.com>
 <20241127172908.17149-4-andybnac@gmail.com>
Content-Language: en-US
From: Evgenii Shatokhin <e.shatokhin@yadro.com>
In-Reply-To: <20241127172908.17149-4-andybnac@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: T-EXCH-10.corp.yadro.com (172.17.11.60) To
 T-EXCH-10.corp.yadro.com (172.17.11.60)

Hi Andy,

First of all, thank you for working on this series.

On 27.11.2024 20:29, Andy Chiu wrote:
> From: Andy Chiu <andy.chiu@sifive.com>
> 
> We use an AUIPC+JALR pair to jump into a ftrace trampoline. Since
> instruction fetch can break down to 4 byte at a time, it is impossible
> to update two instructions without a race. In order to mitigate it, we
> initialize the patchable entry to AUIPC + NOP4. Then, the run-time code
> patching can change NOP4 to JALR to eable/disable ftrcae from a
> function. This limits the reach of each ftrace entry to +-2KB displacing
> from ftrace_caller.
> 
> Starting from the trampoline, we add a level of indirection for it to
> reach ftrace caller target. Now, it loads the target address from a
> memory location, then perform the jump. This enable the kernel to update
> the target atomically.
> 
> The ordering of reading/updating the targert address should be guarded
> by generic ftrace code, where it sends smp_rmb ipi.
> 
> Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
> ---
>   arch/riscv/include/asm/ftrace.h |  4 ++
>   arch/riscv/kernel/ftrace.c      | 80 +++++++++++++++++++++------------
>   arch/riscv/kernel/mcount-dyn.S  |  9 ++--
>   3 files changed, 62 insertions(+), 31 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
> index 4ca7ce7f34d7..36734d285aad 100644
> --- a/arch/riscv/include/asm/ftrace.h
> +++ b/arch/riscv/include/asm/ftrace.h
> @@ -80,6 +80,7 @@ struct dyn_arch_ftrace {
>   #define JALR_T0                        (0x000282e7)
>   #define AUIPC_T0               (0x00000297)
>   #define NOP4                   (0x00000013)
> +#define JALR_RANGE             (JALR_SIGN_MASK - 1)
> 
>   #define to_jalr_t0(offset)                                             \
>          (((offset & JALR_OFFSET_MASK) << JALR_SHIFT) | JALR_T0)
> @@ -117,6 +118,9 @@ do {                                                                        \
>    * Let auipc+jalr be the basic *mcount unit*, so we make it 8 bytes here.
>    */
>   #define MCOUNT_INSN_SIZE 8
> +#define MCOUNT_AUIPC_SIZE      4
> +#define MCOUNT_JALR_SIZE       4
> +#define MCOUNT_NOP4_SIZE       4
> 
>   #ifndef __ASSEMBLY__
>   struct dyn_ftrace;
> diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
> index 4b95c574fd04..5ebe412280ef 100644
> --- a/arch/riscv/kernel/ftrace.c
> +++ b/arch/riscv/kernel/ftrace.c
> @@ -64,42 +64,64 @@ static int ftrace_check_current_call(unsigned long hook_pos,
>          return 0;
>   }
> 
> -static int __ftrace_modify_call(unsigned long hook_pos, unsigned long target,
> -                               bool enable, bool ra)
> +static int __ftrace_modify_call(unsigned long hook_pos, unsigned long target, bool validate)
>   {
>          unsigned int call[2];
> -       unsigned int nops[2] = {NOP4, NOP4};
> +       unsigned int replaced[2];
> +
> +       make_call_t0(hook_pos, target, call);
> 
> -       if (ra)
> -               make_call_ra(hook_pos, target, call);
> -       else
> -               make_call_t0(hook_pos, target, call);
> +       if (validate) {
> +               /*
> +                * Read the text we want to modify;
> +                * return must be -EFAULT on read error
> +                */
> +               if (copy_from_kernel_nofault(replaced, (void *)hook_pos,
> +                                            MCOUNT_INSN_SIZE))
> +                       return -EFAULT;
> +
> +               if (replaced[0] != call[0]) {
> +                       pr_err("%p: expected (%08x) but got (%08x)\n",
> +                              (void *)hook_pos, call[0], replaced[0]);
> +                       return -EINVAL;
> +               }
> +       }
> 
> -       /* Replace the auipc-jalr pair at once. Return -EPERM on write error. */
> -       if (patch_insn_write((void *)hook_pos, enable ? call : nops, MCOUNT_INSN_SIZE))
> +       /* Replace the jalr at once. Return -EPERM on write error. */
> +       if (patch_insn_write((void *)(hook_pos + MCOUNT_AUIPC_SIZE), call + 1, MCOUNT_JALR_SIZE))
>                  return -EPERM;
> 
>          return 0;
>   }
> 
> -int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
> +static int __ftrace_modify_call_site(ftrace_func_t *hook_pos, ftrace_func_t target, bool enable)
>   {
> -       unsigned int call[2];
> +       ftrace_func_t call = target;
> +       ftrace_func_t nops = &ftrace_stub;
> 
> -       make_call_t0(rec->ip, addr, call);
> -
> -       if (patch_insn_write((void *)rec->ip, call, MCOUNT_INSN_SIZE))
> -               return -EPERM;
> +       WRITE_ONCE(*hook_pos, enable ? call : nops);
> 
>          return 0;
>   }
> 
> +int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
> +{
> +       unsigned long distance, orig_addr;
> +
> +       orig_addr = (unsigned long)&ftrace_caller;
> +       distance = addr > orig_addr ? addr - orig_addr : orig_addr - addr;
> +       if (distance > JALR_RANGE)
> +               return -EINVAL;

If I understand it correctly, it is not the range itself that matters 
here, but rather, that AUIPC instruction remains the same for the 
address of ftrace_caller and for the new addr.

For the displacements like 0xfabcd000 and 0xfabccf00, for example, the 
distance is 0x100, which is within JALR range. However, the higher 20 
bits differ, so the AUIPC instructions will differ too. 
__ftrace_modify_call() would catch this though ("if (replaced[0] != 
call[0]) ...").

I'd suggest checking the higher 20 bits explicitly instead, something 
like this:

if ((orig_addr & AUIPC_OFFSET_MASK) != (addr & AUIPC_OFFSET_MASK))
         return -EINVAL;

What do you think?

> +
> +       return __ftrace_modify_call(rec->ip, addr, false);
> +}
> +
>   int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
>                      unsigned long addr)
>   {
> -       unsigned int nops[2] = {NOP4, NOP4};
> +       unsigned int nops[1] = {NOP4};
> 
> -       if (patch_insn_write((void *)rec->ip, nops, MCOUNT_INSN_SIZE))
> +       if (patch_insn_write((void *)(rec->ip + MCOUNT_AUIPC_SIZE), nops, MCOUNT_NOP4_SIZE))
>                  return -EPERM;
> 
>          return 0;
> @@ -114,21 +136,23 @@ int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
>    */
>   int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec)
>   {
> +       unsigned int nops[2];
>          int out;
> 
> +       make_call_t0(rec->ip, &ftrace_caller, nops);
> +       nops[1] = NOP4;
> +
>          mutex_lock(&text_mutex);
> -       out = ftrace_make_nop(mod, rec, MCOUNT_ADDR);
> +       out = patch_insn_write((void *)rec->ip, nops, MCOUNT_INSN_SIZE);
>          mutex_unlock(&text_mutex);
> 
>          return out;
>   }
> 
> +ftrace_func_t ftrace_call_dest = ftrace_stub;
>   int ftrace_update_ftrace_func(ftrace_func_t func)
>   {
> -       int ret = __ftrace_modify_call((unsigned long)&ftrace_call,
> -                                      (unsigned long)func, true, true);
> -
> -       return ret;
> +       return __ftrace_modify_call_site(&ftrace_call_dest, func, true);
>   }
> 
>   struct ftrace_modify_param {
> @@ -182,7 +206,7 @@ int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
>          if (ret)
>                  return ret;
> 
> -       return __ftrace_modify_call(caller, addr, true, false);
> +       return __ftrace_modify_call(caller, addr, true);
>   }
>   #endif
> 
> @@ -217,17 +241,17 @@ void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
>          prepare_ftrace_return(&fregs->ra, ip, fregs->s0);
>   }
>   #else /* CONFIG_DYNAMIC_FTRACE_WITH_ARGS */
> -extern void ftrace_graph_call(void);
> +ftrace_func_t ftrace_graph_call_dest = ftrace_stub;
>   int ftrace_enable_ftrace_graph_caller(void)
>   {
> -       return __ftrace_modify_call((unsigned long)&ftrace_graph_call,
> -                                   (unsigned long)&prepare_ftrace_return, true, true);
> +       return __ftrace_modify_call_site(&ftrace_graph_call_dest,
> +                                        &prepare_ftrace_return, true);
>   }
> 
>   int ftrace_disable_ftrace_graph_caller(void)
>   {
> -       return __ftrace_modify_call((unsigned long)&ftrace_graph_call,
> -                                   (unsigned long)&prepare_ftrace_return, false, true);
> +       return __ftrace_modify_call_site(&ftrace_graph_call_dest,
> +                                        &prepare_ftrace_return, false);
>   }
>   #endif /* CONFIG_DYNAMIC_FTRACE_WITH_ARGS */
>   #endif /* CONFIG_DYNAMIC_FTRACE */
> diff --git a/arch/riscv/kernel/mcount-dyn.S b/arch/riscv/kernel/mcount-dyn.S
> index e988bd26b28b..bc06e8ab81cf 100644
> --- a/arch/riscv/kernel/mcount-dyn.S
> +++ b/arch/riscv/kernel/mcount-dyn.S
> @@ -162,7 +162,8 @@ SYM_FUNC_START(ftrace_caller)
>          mv      a3, sp
> 
>   SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
> -       call    ftrace_stub
> +       REG_L   ra, ftrace_call_dest
> +       jalr    0(ra)
> 
>   #ifdef CONFIG_FUNCTION_GRAPH_TRACER
>          addi    a0, sp, ABI_RA
> @@ -172,7 +173,8 @@ SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
>          mv      a2, s0
>   #endif
>   SYM_INNER_LABEL(ftrace_graph_call, SYM_L_GLOBAL)
> -       call    ftrace_stub
> +       REG_L   ra, ftrace_graph_call_dest
> +       jalr    0(ra)
>   #endif
>          RESTORE_ABI
>          jr      t0
> @@ -185,7 +187,8 @@ SYM_FUNC_START(ftrace_caller)
>          PREPARE_ARGS
> 
>   SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
> -       call    ftrace_stub
> +       REG_L   ra, ftrace_call_dest
> +       jalr    0(ra)
> 
>          RESTORE_ABI_REGS
>          bnez    t1, .Ldirect
> --
> 2.39.3 (Apple Git-145)
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

