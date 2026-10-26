Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793046526;
	b=YdV7w9+biZ0cXJgy7IWR84upW9LvnkeVmu/4g1dty+Fut6Nwv9CSXKg/U06YvIZOnEES
	 YdKI7FlNYTRt4WQO+YocmE89EyGkAV+xTr+Jm18HYcOuucYHaSXSVi9zOzASTgF+eBE3q
	 Kch3Ix7wib1gCsJ862+QOKBJDg3xDwkNKpxTc6FZvWmscBMeTQzuxrZHFGFik4rhV7dSq
	 lhFph+MMF/GrPbBedA1bXsWF4jxFV+la6g9B6D0xD673x6bBFydSZsBsT3UZG5oW6NRgr
	 7OoR9i8NBgLE+k7aK+q6x7/QcSUcDcbtbVEBt9dTuje0qqkWoSIZBIXR+qFYETNgrSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793046526;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=EhwuTnHu+ix/BI2sCrY08QcOZBgFTj13dOHwcWXnDHw=;
	b=MSpUtuSHL5x3/casRx0G+OkQUTGcIdLpxdP/9lqa1ozmNuYsmj2fF8ldSb3jDZWi9L69
	 7rF+yZG8S3stdjrpPudqWFp34vWkW3UQrLlmxKhVxgVX5cy3dt9SH06xy23InmIdO7oK9
	 ZBZgDkwS1I4KpDDwUl4MfeGD/VZ4JdwGIhd3pniTbhlJfAF3WwPFhW8nanyJMog+nEzjw
	 j92QnvKJQdj6fDjEYrGBjt3XOyvZBGLiMWfB4lJSpjJxnuBE6kcV9vPB1pFzZjVvK7vNc
	 4V8DyQ9OH8HSX4qfCoC6ru9AIeKT5xvpRnMLNXicNH7cWGhOl2ULA+hXWaavos8qmMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AZQ32iKI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B03606A324
	for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Oct 2026 20:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AZQ32iKI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 676111F01828;
	Mon, 26 Oct 2026 20:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793046525;
	bh=EhwuTnHu+ix/BI2sCrY08QcOZBgFTj13dOHwcWXnDHw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AZQ32iKIs7R0IFQvVjr6mQClNMBkQf64VioEZnicQhSQmydTvxBhKgz5P+smeXjt+
	 xPnHQ8GCRnH3f5ffgzV+M8EiIRcbtiWau4eGkwJxxBXkwvr2mw41VDO3FLBVhTb63y
	 mG2msSX1doVH+TI2zzyU1qoy9pZqKtWk5LAoqX8gjpmRN4ZjjJaam+710LWKFR51sq
	 fePPnMcM4A+H7/AB2i8eJKc1TgOFNNj/NTDR3XM2AvaC2LD4LejPPBBOkTXdnqfXEy
	 H7KEjYCp7C8kwMk0ci3PkHhXIBJok/YWO67CxvpHkQedAhxIhf+9u69vLsYLdaXSyv
	 ZuLablhUf7ycg==
Message-ID: <sashiko-outbox-185721@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/4] openrisc: Add Kretprobes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sahil Siddiq" <sahilcdq0@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261026201240.107462-5-sahilcdq0@gmail.com>
References: <20260930202744.50489-1-sahilcdq0@gmail.com>
 <20261026201240.107462-5-sahilcdq0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 20:28:44 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] openrisc: missing NOKPROBE annotation on arch_rethook_trampoline()
--

commit 20e73d01661b40600429433415de2e9c63032d8f
Author: Sahil Siddiq <sahilcdq0@gmail.com>

openrisc: Add Kretprobes

This commit adds Kretprobes support for OpenRISC on top of the generic
rethook framework, providing arch_rethook_prepare(),
arch_rethook_trampoline_callback(), and the assembly return trampoline
arch_rethook_trampoline.

> diff --git a/arch/openrisc/kernel/rethook_trampoline.S b/arch/openrisc/ke=
rnel/rethook_trampoline.S
> new file mode 100644
> index 0000000000000..5e8fd5a652222
> --- /dev/null
> +++ b/arch/openrisc/kernel/rethook_trampoline.S
> @@ -0,0 +1,111 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Author: Sahil Siddiq <sahilcdq0@gmail.com>
> + */
> +
> +#include <linux/linkage.h>
> +
> +#include <asm/asm.h>

[ ... ]

> +SYM_CODE_START(arch_rethook_trampoline)
> +	/* Allocate enough space on stack for pt_regs */
> +	l.addi	r1,r1,-PT_SIZE
> +	save_all_base_regs
> +
> +	l.addi	r3,r1,0	/* pt_regs */
> +	l.jal	arch_rethook_trampoline_callback
> +	l.nop
> +
> +	/* use the result as the return-address */
> +	l.addi	r9,r11,0
> +
> +	restore_all_base_regs
> +	l.addi	r1,r1,PT_SIZE
> +
> +	l.jr	r9
> +	l.nop
> +SYM_CODE_END(arch_rethook_trampoline)

[Severity: High]
Should arch_rethook_trampoline be marked with _ASM_NOKPROBE() here (or
NOKPROBE_SYMBOL() in arch/openrisc/kernel/rethook.c)?

Although arch/openrisc/kernel/rethook_trampoline.S includes <asm/asm.h> and
arch/openrisc/kernel/rethook.c marks arch_rethook_trampoline_callback() and
arch_rethook_prepare() with NOKPROBE_SYMBOL(), arch_rethook_trampoline is
placed in .text without a kprobe blacklist annotation.

Because arch_rethook_trampoline is not blacklisted, registering a kretprobe
or kprobe on arch_rethook_trampoline is permitted. When a kretprobed functi=
on
returns to arch_rethook_trampoline with r9 holding the address of
arch_rethook_trampoline, a kretprobe on arch_rethook_trampoline triggers:

pre_handler_kretprobe()
  rethook_hook()
    arch_rethook_prepare()
      rhn->ret_addr =3D regs->gpr9;

which pushes a rethook_node with ret_addr set to arch_rethook_trampoline on=
to
current->rethooks. When arch_rethook_trampoline_callback() then calls
rethook_trampoline_handler(), __rethook_find_ret_addr() skips nodes whose
ret_addr equals arch_rethook_trampoline:

kernel/trace/rethook.c:__rethook_find_ret_addr() {
    ...
	while (node) {
		rh =3D container_of(node, struct rethook_node, llist);
		if (rh->ret_addr !=3D (unsigned long)arch_rethook_trampoline) {
			*cur =3D node;
			return rh->ret_addr;
		}
		node =3D node->next;
	}
	return 0;
}

Can this corrupt the current->rethooks shadow stack or trigger the BUG_ON(1)
in rethook_trampoline_handler() when a probe is attached to
arch_rethook_trampoline?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026201240.1074=
62-1-sahilcdq0@gmail.com?part=3D4
