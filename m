Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7252414E2E1;
	Wed, 19 Jun 2024 14:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718806045; cv=none; b=LeMFJrgmatFC1lgA05BvXg0mOR/VJJOf2AWwfvCC0TNxefl0CbBazHbNO7hRJhFPzn0hj1uCtg7+1mcb3fRiIpMnyysayrLWnOYXvx7ZdFXKB2bufrWxuUKNH7lIdA4LNMrHlXq17JAMmwFRhBDsgl9yQWLM2HaaTcBnG1Jrq0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718806045; c=relaxed/simple;
	bh=u3uIPHvnecFZ62Xri1qTs1XTXE2rR0AjrQfJPDlTCwg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=YZp+dlo70eA8MSzOb3PVGV3quW3u1kU4l1oPgJdrFJ+iL4qWgeIoAE05Q/sTReac972OqpZorzsRfzJe/zNsgQqOAAGO8A0PWRe9GrZ/XFC1rL1NghfEDMPBrLLbLiVvYqkhgQXzX0KOYFT05kFONU6J+CnFKY7k0Z0/zzgaF4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B3kcX/jR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B3kcX/jR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CA63C2BBFC;
	Wed, 19 Jun 2024 14:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718806044;
	bh=u3uIPHvnecFZ62Xri1qTs1XTXE2rR0AjrQfJPDlTCwg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B3kcX/jRTvjJQW7tphw8g1JOPB1tkjt47dSXZDAhp++ix+uAyNQKVSj8ZFQBI+V0C
	 elzY78pcqVxuFMRgFwvWrUfyZOiPZktDsEJARd3C8Tmhaf8lFjqqjbBB30VThg2hQw
	 4yk4BfR+Y19JH6Kw+V2+Y0Szr695JIP4Irf5eDfOTcvSQ1PTc3Xx2ANXPUkvUTH+Wc
	 KDMGXJSseyDj+gYzNIKOimx5wcPpf+L+e0Hr5l19GgzNAeZ6R4OguiXGDCYcdGtnRm
	 dTVVCnH7ynetH3U5yLgft3BqscHhsBKJq2TuHPe70sM3aeHdEEVd+/dkyo5VF5OoqZ
	 0R6Z87uryccwg==
Date: Wed, 19 Jun 2024 23:07:20 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
 <aou@eecs.berkeley.edu>, <rostedt@goodmis.org>, <mark.rutland@arm.com>,
 <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH] trace: riscv: Remove deprecated kprobe on ftrace
 support
Message-Id: <20240619230720.14fbd3a7e03139cbc0157407@kernel.org>
In-Reply-To: <20240613111347.1745379-1-ruanjinjie@huawei.com>
References: <20240613111347.1745379-1-ruanjinjie@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Jun 2024 19:13:47 +0800
Jinjie Ruan <ruanjinjie@huawei.com> wrote:

> Since commit 7caa9765465f60 ("ftrace: riscv: move from REGS to ARGS"),
> kprobe on ftrace is not supported by riscv, because riscv's support for
> FTRACE_WITH_REGS has been replaced with support for FTRACE_WITH_ARGS, and
> KPROBES_ON_FTRACE will be supplanted by FPROBES. So remove the deprecated
> kprobe on ftrace support, which is misunderstood.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

No problem, Now we have fprobe instead.
Anyway, this looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> ---
>  arch/riscv/Kconfig                |  1 -
>  arch/riscv/kernel/probes/Makefile |  1 -
>  arch/riscv/kernel/probes/ftrace.c | 65 -------------------------------
>  3 files changed, 67 deletions(-)
>  delete mode 100644 arch/riscv/kernel/probes/ftrace.c
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 0525ee2d63c7..a1f2d604c459 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -149,7 +149,6 @@ config RISCV
>  	select HAVE_KERNEL_UNCOMPRESSED if !XIP_KERNEL && !EFI_ZBOOT
>  	select HAVE_KERNEL_ZSTD if !XIP_KERNEL && !EFI_ZBOOT
>  	select HAVE_KPROBES if !XIP_KERNEL
> -	select HAVE_KPROBES_ON_FTRACE if !XIP_KERNEL
>  	select HAVE_KRETPROBES if !XIP_KERNEL
>  	# https://github.com/ClangBuiltLinux/linux/issues/1881
>  	select HAVE_LD_DEAD_CODE_DATA_ELIMINATION if !LD_IS_LLD
> diff --git a/arch/riscv/kernel/probes/Makefile b/arch/riscv/kernel/probes/Makefile
> index 8265ff497977..d2129f2c61b8 100644
> --- a/arch/riscv/kernel/probes/Makefile
> +++ b/arch/riscv/kernel/probes/Makefile
> @@ -1,7 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_KPROBES)		+= kprobes.o decode-insn.o simulate-insn.o
>  obj-$(CONFIG_RETHOOK)		+= rethook.o rethook_trampoline.o
> -obj-$(CONFIG_KPROBES_ON_FTRACE)	+= ftrace.o
>  obj-$(CONFIG_UPROBES)		+= uprobes.o decode-insn.o simulate-insn.o
>  CFLAGS_REMOVE_simulate-insn.o = $(CC_FLAGS_FTRACE)
>  CFLAGS_REMOVE_rethook.o = $(CC_FLAGS_FTRACE)
> diff --git a/arch/riscv/kernel/probes/ftrace.c b/arch/riscv/kernel/probes/ftrace.c
> deleted file mode 100644
> index a69dfa610aa8..000000000000
> --- a/arch/riscv/kernel/probes/ftrace.c
> +++ /dev/null
> @@ -1,65 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -
> -#include <linux/kprobes.h>
> -
> -/* Ftrace callback handler for kprobes -- called under preepmt disabled */
> -void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
> -			   struct ftrace_ops *ops, struct ftrace_regs *fregs)
> -{
> -	struct kprobe *p;
> -	struct pt_regs *regs;
> -	struct kprobe_ctlblk *kcb;
> -	int bit;
> -
> -	if (unlikely(kprobe_ftrace_disabled))
> -		return;
> -
> -	bit = ftrace_test_recursion_trylock(ip, parent_ip);
> -	if (bit < 0)
> -		return;
> -
> -	p = get_kprobe((kprobe_opcode_t *)ip);
> -	if (unlikely(!p) || kprobe_disabled(p))
> -		goto out;
> -
> -	regs = ftrace_get_regs(fregs);
> -	kcb = get_kprobe_ctlblk();
> -	if (kprobe_running()) {
> -		kprobes_inc_nmissed_count(p);
> -	} else {
> -		unsigned long orig_ip = instruction_pointer(regs);
> -
> -		instruction_pointer_set(regs, ip);
> -
> -		__this_cpu_write(current_kprobe, p);
> -		kcb->kprobe_status = KPROBE_HIT_ACTIVE;
> -		if (!p->pre_handler || !p->pre_handler(p, regs)) {
> -			/*
> -			 * Emulate singlestep (and also recover regs->pc)
> -			 * as if there is a nop
> -			 */
> -			instruction_pointer_set(regs,
> -				(unsigned long)p->addr + MCOUNT_INSN_SIZE);
> -			if (unlikely(p->post_handler)) {
> -				kcb->kprobe_status = KPROBE_HIT_SSDONE;
> -				p->post_handler(p, regs, 0);
> -			}
> -			instruction_pointer_set(regs, orig_ip);
> -		}
> -
> -		/*
> -		 * If pre_handler returns !0, it changes regs->pc. We have to
> -		 * skip emulating post_handler.
> -		 */
> -		__this_cpu_write(current_kprobe, NULL);
> -	}
> -out:
> -	ftrace_test_recursion_unlock(bit);
> -}
> -NOKPROBE_SYMBOL(kprobe_ftrace_handler);
> -
> -int arch_prepare_kprobe_ftrace(struct kprobe *p)
> -{
> -	p->ainsn.api.insn = NULL;
> -	return 0;
> -}
> -- 
> 2.34.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
