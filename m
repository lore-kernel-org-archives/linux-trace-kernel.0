Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB03B28684;
	Fri,  6 Dec 2024 10:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733479352; cv=none; b=iRVVETNibzGLJnuDjTfsByDsSVXZovd3FK85kmKnd3cLYVlP/sJetu0vHRAdRnShZvNvA78i4lK9l7RNmkJOCAD40IwiVWWHIUBgqFdn7a6doE8rLgmkgjabLTghfvAHdxguebw9SiMY0FEDKcefii9DreP2T3aXtH70uAROoTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733479352; c=relaxed/simple;
	bh=dRdjztA9b+bUdj65UIY2rf3m8UrhDjme/2VdkbsCfRo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dww6Wz0rRU8hQ1gOGwjKhtxmdw1xsRZIqEr0Pb+0G0GlGf81w2ePae3CUAeQplkdDCiUQ8Lt3FF1wLhVr3l8ylGkuHTP3vrA201o9C/FAbSoQTyVJ7wQHJeU1T7Vv+ROMFF0Ilvv1PELD4ULKspcG+f/5CAgxiE8RzjApGeEPy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2eLXQQW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2eLXQQW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F359BC4CED1;
	Fri,  6 Dec 2024 10:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733479352;
	bh=dRdjztA9b+bUdj65UIY2rf3m8UrhDjme/2VdkbsCfRo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=K2eLXQQWebgTZ/SIkRJ4EGhpkJTyYomTgm8MQD5McbW/kNgYqLw4yvEQfuGKmryVI
	 aCZfqL+9i9aZkFtAG4JPRJ4YEXrcUiuOa+fcqHQPSfTQVlU3DDRQbp2ZL90cD8oUzq
	 rTxb3mG8YphpWJf8+3B92FEJKeVdbhZSvRCyN7xjDb3lKwXgKPfi109sYpLnl7vIrn
	 QwYJ5sc7ZBWOdjqNBi81eE3rM4MQk2bdYhkYyIBgzZ+LTZz2swyAYAYdmQiUkpWsT/
	 qVkHSwuN7/YURYYsxKO1nMIm8fy6DN32c5FdGTuicEMzfrghbjxmzZ+62iLLb/3GUp
	 IvOvhg+glSQLg==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Andy Chiu <andybnac@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Steven
 Rostedt <rostedt@goodmis.org>, Robbin Ehn <rehn@rivosinc.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, bjorn@rivosinc.com, puranjay12@gmail.com,
 alexghiti@rivosinc.com, yongxuan.wang@sifive.com, greentime.hu@sifive.com,
 nick.hu@sifive.com, nylon.chen@sifive.com, tommy.wu@sifive.com,
 eric.lin@sifive.com, viccent.chen@sifive.com, zong.li@sifive.com,
 samuel.holland@sifive.com
Subject: Re: [PATCH v3 3/7] riscv: ftrace: prepare ftrace for atomic code
 patching
In-Reply-To: <20241127172908.17149-4-andybnac@gmail.com>
References: <20241127172908.17149-1-andybnac@gmail.com>
 <20241127172908.17149-4-andybnac@gmail.com>
Date: Fri, 06 Dec 2024 11:02:29 +0100
Message-ID: <87v7vxf7t6.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Adding Robbin for input, who's doing much more crazy text patching in
JVM, than what we do in the kernel. ;-)

Andy Chiu <andybnac@gmail.com> writes:

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

Let's say we're tracing "f". Previously w/ stop_machine() it was
something like:

f:
1: nop
   nop
   ...
   ...

ftrace_caller:
   ...
   auipc	a2, function_trace_op
   ld		a2, function_trace_op(a2)
   ...
2: auipc    ra, ftrace_stub
   jalr     ftrace_stub(ra)

The text was patched by ftrace in 1 and 2.

...and now:
f:
   auipc    t0, ftrace_caller
A: nop
   ...
   ...

ftrace_caller:
   ...
   auipc    a2, function_trace_op
   ld       a2, function_trace_op(a2)
   ...
   auipc    ra, ftrace_call_dest
   ld       ra, ftrace_call_dest(ra)
   jalr     ra=20

The text is only patched in A, and the tracer func is loaded via
ftrace_call_dest.

Today, when we enable trace "f" the following is done by ftrace:
  Text patch 2: call ftrace_stub -> call arch_ftrace_ops_list_func
  Text patch 1: nop,nop -> call ftrace_caller
  store function_trace_op
  smp_wmb()
  IPI: smp_rmb()
  Text patch 2: call arch_ftrace_ops_list_func -> call function_trace_call

Disable, would be something like:
  Text patch 2: call function_trace_call -> call arch_ftrace_ops_list_func
  Text patch 1: call ftrace_caller -> nop,nop
  store function_trace_op
  smp_wmb()
  IPI: smp_rmb()
  Text patch 2: call arch_ftrace_ops_list_func -> call ftrace_stub

Now with this change, enable would be:
  store ftrace_call_dest (was: Text patch 2: call ftrace_stub -> call arch_=
ftrace_ops_list_func)
  <<ORDERING>>
  Text patch A: nop -> jalr ftrace_caller(t0)
  store function_trace_op
  smp_wmb()
  IPI: smp_rmb()
  store ftrace_call_dest (was: Text patch 2: call arch_ftrace_ops_list_func=
 -> call function_trace_call)

Seems like we're missing some data ordering in "<<ORDERING>>", wrt to
the text patching A (The arch specific ftrace_update_ftrace_func())? Or
are we OK with reordering there? Maybe add what's done for
function_trace_op?

[...]

> Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
> ---
>  arch/riscv/include/asm/ftrace.h |  4 ++
>  arch/riscv/kernel/ftrace.c      | 80 +++++++++++++++++++++------------
>  arch/riscv/kernel/mcount-dyn.S  |  9 ++--
>  3 files changed, 62 insertions(+), 31 deletions(-)
>
> diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftr=
ace.h
> index 4ca7ce7f34d7..36734d285aad 100644
> --- a/arch/riscv/include/asm/ftrace.h
> +++ b/arch/riscv/include/asm/ftrace.h
> @@ -80,6 +80,7 @@ struct dyn_arch_ftrace {
>  #define JALR_T0			(0x000282e7)
>  #define AUIPC_T0		(0x00000297)
>  #define NOP4			(0x00000013)
> +#define JALR_RANGE		(JALR_SIGN_MASK - 1)
>=20=20
>  #define to_jalr_t0(offset)						\
>  	(((offset & JALR_OFFSET_MASK) << JALR_SHIFT) | JALR_T0)
> @@ -117,6 +118,9 @@ do {									\
>   * Let auipc+jalr be the basic *mcount unit*, so we make it 8 bytes here.
>   */
>  #define MCOUNT_INSN_SIZE 8
> +#define MCOUNT_AUIPC_SIZE	4
> +#define MCOUNT_JALR_SIZE	4
> +#define MCOUNT_NOP4_SIZE	4

Align please.

>=20=20
>  #ifndef __ASSEMBLY__
>  struct dyn_ftrace;
> diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
> index 4b95c574fd04..5ebe412280ef 100644
> --- a/arch/riscv/kernel/ftrace.c
> +++ b/arch/riscv/kernel/ftrace.c
> @@ -64,42 +64,64 @@ static int ftrace_check_current_call(unsigned long ho=
ok_pos,
>  	return 0;
>  }
>=20=20
> -static int __ftrace_modify_call(unsigned long hook_pos, unsigned long ta=
rget,
> -				bool enable, bool ra)
> +static int __ftrace_modify_call(unsigned long hook_pos, unsigned long ta=
rget, bool validate)

While we're updating this function; Can we rename hook_pos to something
that makes sense from an ftrace perspective?

>  {
>  	unsigned int call[2];
> -	unsigned int nops[2] =3D {NOP4, NOP4};
> +	unsigned int replaced[2];
> +
> +	make_call_t0(hook_pos, target, call);
>=20=20
> -	if (ra)
> -		make_call_ra(hook_pos, target, call);
> -	else
> -		make_call_t0(hook_pos, target, call);
> +	if (validate) {
> +		/*
> +		 * Read the text we want to modify;
> +		 * return must be -EFAULT on read error
> +		 */
> +		if (copy_from_kernel_nofault(replaced, (void *)hook_pos,
> +					     MCOUNT_INSN_SIZE))

Don't wrap this line.

> +			return -EFAULT;
> +
> +		if (replaced[0] !=3D call[0]) {
> +			pr_err("%p: expected (%08x) but got (%08x)\n",
> +			       (void *)hook_pos, call[0], replaced[0]);
> +			return -EINVAL;
> +		}
> +	}
>=20=20
> -	/* Replace the auipc-jalr pair at once. Return -EPERM on write error. */
> -	if (patch_insn_write((void *)hook_pos, enable ? call : nops, MCOUNT_INS=
N_SIZE))
> +	/* Replace the jalr at once. Return -EPERM on write error. */
> +	if (patch_insn_write((void *)(hook_pos + MCOUNT_AUIPC_SIZE), call + 1, =
MCOUNT_JALR_SIZE))
>  		return -EPERM;
>=20=20
>  	return 0;
>  }
>=20=20
> -int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
> +static int __ftrace_modify_call_site(ftrace_func_t *hook_pos, ftrace_fun=
c_t target, bool enable)
>  {
> -	unsigned int call[2];
> +	ftrace_func_t call =3D target;
> +	ftrace_func_t nops =3D &ftrace_stub;

Confusing to call nops. This is not nops. This is the ftrace_stub. Also
the __ftrace_modify_call_site is not super clear to me. Maybe just ditch
the enable flag, and have two functions? Or just or inline it?

>=20=20
> -	make_call_t0(rec->ip, addr, call);
> -
> -	if (patch_insn_write((void *)rec->ip, call, MCOUNT_INSN_SIZE))
> -		return -EPERM;
> +	WRITE_ONCE(*hook_pos, enable ? call : nops);
>=20=20
>  	return 0;
>  }
>=20=20
> +int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
> +{
> +	unsigned long distance, orig_addr;
> +
> +	orig_addr =3D (unsigned long)&ftrace_caller;
> +	distance =3D addr > orig_addr ? addr - orig_addr : orig_addr - addr;
> +	if (distance > JALR_RANGE)
> +		return -EINVAL;
> +
> +	return __ftrace_modify_call(rec->ip, addr, false);
> +}
> +
>  int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
>  		    unsigned long addr)
>  {
> -	unsigned int nops[2] =3D {NOP4, NOP4};
> +	unsigned int nops[1] =3D {NOP4};

It's just one nop, not nops. No biggie, but why array?

>=20=20
> -	if (patch_insn_write((void *)rec->ip, nops, MCOUNT_INSN_SIZE))
> +	if (patch_insn_write((void *)(rec->ip + MCOUNT_AUIPC_SIZE), nops, MCOUN=
T_NOP4_SIZE))
>  		return -EPERM;
>=20=20
>  	return 0;
> @@ -114,21 +136,23 @@ int ftrace_make_nop(struct module *mod, struct dyn_=
ftrace *rec,
>   */
>  int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec)
>  {
> +	unsigned int nops[2];
>  	int out;
>=20=20
> +	make_call_t0(rec->ip, &ftrace_caller, nops);
> +	nops[1] =3D NOP4;
> +
>  	mutex_lock(&text_mutex);
> -	out =3D ftrace_make_nop(mod, rec, MCOUNT_ADDR);
> +	out =3D patch_insn_write((void *)rec->ip, nops, MCOUNT_INSN_SIZE);
>  	mutex_unlock(&text_mutex);
>=20=20
>  	return out;
>  }
>=20=20
> +ftrace_func_t ftrace_call_dest =3D ftrace_stub;
>  int ftrace_update_ftrace_func(ftrace_func_t func)
>  {
> -	int ret =3D __ftrace_modify_call((unsigned long)&ftrace_call,
> -				       (unsigned long)func, true, true);
> -
> -	return ret;
> +	return __ftrace_modify_call_site(&ftrace_call_dest, func, true);
>  }
>=20=20
>  struct ftrace_modify_param {
> @@ -182,7 +206,7 @@ int ftrace_modify_call(struct dyn_ftrace *rec, unsign=
ed long old_addr,
>  	if (ret)
>  		return ret;
>=20=20
> -	return __ftrace_modify_call(caller, addr, true, false);
> +	return __ftrace_modify_call(caller, addr, true);
>  }
>  #endif
>=20=20
> @@ -217,17 +241,17 @@ void ftrace_graph_func(unsigned long ip, unsigned l=
ong parent_ip,
>  	prepare_ftrace_return(&fregs->ra, ip, fregs->s0);
>  }
>  #else /* CONFIG_DYNAMIC_FTRACE_WITH_ARGS */
> -extern void ftrace_graph_call(void);
> +ftrace_func_t ftrace_graph_call_dest =3D ftrace_stub;
>  int ftrace_enable_ftrace_graph_caller(void)
>  {
> -	return __ftrace_modify_call((unsigned long)&ftrace_graph_call,
> -				    (unsigned long)&prepare_ftrace_return, true, true);
> +	return __ftrace_modify_call_site(&ftrace_graph_call_dest,
> +					 &prepare_ftrace_return, true);
>  }
>=20=20
>  int ftrace_disable_ftrace_graph_caller(void)
>  {
> -	return __ftrace_modify_call((unsigned long)&ftrace_graph_call,
> -				    (unsigned long)&prepare_ftrace_return, false, true);
> +	return __ftrace_modify_call_site(&ftrace_graph_call_dest,
> +					 &prepare_ftrace_return, false);
>  }
>  #endif /* CONFIG_DYNAMIC_FTRACE_WITH_ARGS */
>  #endif /* CONFIG_DYNAMIC_FTRACE */
> diff --git a/arch/riscv/kernel/mcount-dyn.S b/arch/riscv/kernel/mcount-dy=
n.S
> index e988bd26b28b..bc06e8ab81cf 100644
> --- a/arch/riscv/kernel/mcount-dyn.S
> +++ b/arch/riscv/kernel/mcount-dyn.S
> @@ -162,7 +162,8 @@ SYM_FUNC_START(ftrace_caller)
>  	mv	a3, sp
>=20=20
>  SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
> -	call	ftrace_stub
> +	REG_L	ra, ftrace_call_dest
> +	jalr	0(ra)
>=20=20
>  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
>  	addi	a0, sp, ABI_RA
> @@ -172,7 +173,8 @@ SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
>  	mv	a2, s0
>  #endif
>  SYM_INNER_LABEL(ftrace_graph_call, SYM_L_GLOBAL)
> -	call	ftrace_stub
> +	REG_L	ra, ftrace_graph_call_dest
> +	jalr	0(ra)
>  #endif
>  	RESTORE_ABI
>  	jr	t0
> @@ -185,7 +187,8 @@ SYM_FUNC_START(ftrace_caller)
>  	PREPARE_ARGS
>=20=20
>  SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)

Not used, please remove.

> -	call	ftrace_stub
> +	REG_L	ra, ftrace_call_dest
> +	jalr	0(ra)
>=20=20
>  	RESTORE_ABI_REGS
>  	bnez	t1, .Ldirect
> --=20
> 2.39.3 (Apple Git-145)



Bj=C3=B6rn
