Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C33F1C860C;
	Thu, 23 Jul 2026 00:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784766698; cv=none; b=etoAh0LIxWxexAAD6oFl8IrIS1XwD/QpMiHZhoZsR4zAPoQa4Au6uMdJpjSMPXgbYuiJX2d0qI+Cdq87CLe0L6xqc2+5TcbL1Qp99pQkaTWYHr8L/VBQ6rfkcT1yvL7lt5LaUYRWmrgvknkPwTfr/Ks7vGB+6dB4nSgEM/MR87Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784766698; c=relaxed/simple;
	bh=dJRdYF0QoOmGyfEmK/zHujedH9tQaiO60kDqBOSKWXc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=X0UKWEerjPfgk+ZPQnnSttdH8Ygh5FMfwaiFv+Yl+c/MobSoUfJOWDhQ9QgDq6q6rli6JZ5uLps7HN9zm2kjzy3yJQzyX3H4+qAZM0k16UWdA2YduMNk137BRq/UQSqTrqIbhY2XGbmeTd/zK9QRsDwfWD3N4OTUacBoEd7NkIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdxhDzXP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdxhDzXP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE0EB1F00A3A;
	Thu, 23 Jul 2026 00:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784766696;
	bh=M1FmOCddcFLRYUEHwII6l1JmdAnN/d2b9APCQ1/D8wk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cdxhDzXPXieA/13FUHaHPEbXmK3kX5VhN1UC+vRAxoVs4nae8Yw2tf+6NPkgm9xdk
	 WwcIqCerDkEYLxCJJbW/aTFUeGua6yLpKPxJGGqFMaxmvCyDEzdVuXMiRwlDCHbTb0
	 wLY2WfAtmoCRHslcNay+K0FYrhBk/Xn0AvGjvZXQOW3Gz0n/BnVAq2ZASfikNFuX3d
	 /fXyVSJzm0bvnzd8t4GbbhyG0volOiFv3GkyrWLK7IYOrEXTru1mWRNIe7aJqBmfX1
	 vYQFQbALpxInBWNx1/4VKLs1OMgfL08JI5K0ESSINJO6Ua8Jv1pzDYZtEkX7XJ8nhG
	 wDJbUMlKGvFjw==
Date: Thu, 23 Jul 2026 09:31:32 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: daichengrong <daichengrong@iscas.ac.cn>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] uprobes: Restore original return address in uretprobe
 context
Message-Id: <20260723093132.4f0e5b22e81aa688f86cb9de@kernel.org>
In-Reply-To: <20260717082331.27058-1-daichengrong@iscas.ac.cn>
References: <20260717082331.27058-1-daichengrong@iscas.ac.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Jul 2026 16:23:31 +0800
daichengrong <daichengrong@iscas.ac.cn> wrote:

> uretprobe replaces the original return address of a probed function with
> a trampoline address to capture function return events.
> 
> After the trampoline is entered and the uretprobe handler completes, the
> original return address needs to be restored in the user register context
> to keep the register state consistent with the state before probing.
> 
> Add an architecture-specific hook for restoring the original return
> address during uretprobe handling.
> 
> The initial implementation adds support for RISC-V. Other architectures
> keep the default empty implementation until their corresponding restore
> logic is implemented.
> 
> Signed-off-by: daichengrong <daichengrong@iscas.ac.cn>
> ---
>  arch/riscv/kernel/probes/uprobes.c | 7 +++++++
>  include/linux/uprobes.h            | 1 +
>  kernel/events/uprobes.c            | 5 +++++
>  3 files changed, 13 insertions(+)
> 
> diff --git a/arch/riscv/kernel/probes/uprobes.c b/arch/riscv/kernel/probes/uprobes.c
> index eb177d0ce8ab..0b1b94d9683e 100644
> --- a/arch/riscv/kernel/probes/uprobes.c
> +++ b/arch/riscv/kernel/probes/uprobes.c
> @@ -139,6 +139,13 @@ arch_uretprobe_hijack_return_addr(unsigned long trampoline_vaddr,
>  	return ra;
>  }
>  
> +void
> +arch_uretprobe_hijack_set_addr(unsigned long orig_ret_vaddr,
> +				  struct pt_regs *regs)

OK, but hijack may not be a good naming, what about
"arch_uretprobe_restore_return_address()"?

And I need RISC-V maintainer's review.

Thank you,

> +{
> +	regs->ra = orig_ret_vaddr;
> +}
> +
>  int arch_uprobe_exception_notify(struct notifier_block *self,
>  				 unsigned long val, void *data)
>  {
> diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> index f548fea2adec..2d0dc919845d 100644
> --- a/include/linux/uprobes.h
> +++ b/include/linux/uprobes.h
> @@ -230,6 +230,7 @@ extern bool arch_uprobe_xol_was_trapped(struct task_struct *tsk);
>  extern int  arch_uprobe_exception_notify(struct notifier_block *self, unsigned long val, void *data);
>  extern void arch_uprobe_abort_xol(struct arch_uprobe *aup, struct pt_regs *regs);
>  extern unsigned long arch_uretprobe_hijack_return_addr(unsigned long trampoline_vaddr, struct pt_regs *regs);
> +extern void arch_uretprobe_hijack_set_addr(unsigned long orig_ret_vaddr, struct pt_regs *regs);
>  extern bool arch_uretprobe_is_alive(struct return_instance *ret, enum rp_check ctx, struct pt_regs *regs);
>  extern bool arch_uprobe_ignore(struct arch_uprobe *aup, struct pt_regs *regs);
>  extern void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 4084e926e284..deecaae01ab7 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -1748,6 +1748,10 @@ void * __weak arch_uretprobe_trampoline(unsigned long *psize)
>  	return &insn;
>  }
>  
> +void __weak arch_uretprobe_hijack_set_addr(unsigned long orig_ret_vaddr, struct pt_regs *regs)
> +{
> +}
> +
>  static struct xol_area *__create_xol_area(unsigned long vaddr)
>  {
>  	struct mm_struct *mm = current->mm;
> @@ -2659,6 +2663,7 @@ void uprobe_handle_trampoline(struct pt_regs *regs)
>  		valid = !next_chain || arch_uretprobe_is_alive(next_chain, RP_CHECK_RET, regs);
>  
>  		instruction_pointer_set(regs, ri->orig_ret_vaddr);
> +		arch_uretprobe_hijack_set_addr(ri->orig_ret_vaddr, regs);
>  		do {
>  			/* pop current instance from the stack of pending return instances,
>  			 * as it's not pending anymore: we just fixed up original
> -- 
> 2.25.1
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
