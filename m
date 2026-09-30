Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32B3515980
	for <linux-trace-kernel@vger.kernel.org>; Wed, 30 Sep 2026 20:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790800877; cv=none; b=TQ4p0Hvy0TI8B/EsIP/vxOZF8CFQW2K+Zj1IRCBaq1435TxGouuBkTuDZKi6YXfpKnHjxP7PRv8DvXnCoU9V2kf4IavF8FZqydpU991mYDOXpx4Ekej0gHoj5722l/niiAST+W+LjxRC+yN6qFxOvteQjppPcmfmlubKf7WLtPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790800877; c=relaxed/simple;
	bh=aUR8FEMmgE7bEDKmKfknA3ZQtMT+T/l/QFxWzhTO/xw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=o/Ky9jLJ3WuNWYFI1BXvNfchgmdjF4LazRPS3G5F+AXOcl7auCZ6enSVfW9q3fMAjFdCkrZULi7M5JGaIMiD+U4lxm6eYnctt5H3VCXaXz/+YN25GKS0mbBmTXtMvTfQ8DZLwAeFalJTNZD6qlL+A0mtcOzWdiByTilNDAqoaLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hght+W+F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hght+W+F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E7701F000FF;
	Wed, 30 Sep 2026 20:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790800876;
	bh=kueaPfhbmT+fZrnr8FpYThCnr3Vso8veFpe83XNyh3M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hght+W+FZj2SYn/A4bJn2Lm4zGrzDi5M7RH6DFyyHqjLic2GNUm2YXwB3UcEDLmpB
	 GOxey1cn1b+eoaE6OxXUtqXysdDfabmw1vglVTfAD6AfNqSk1sAasd5yl5gRpKhdhe
	 Z+mNuh4DsF9763BDRNffNLKoEJhaxdA377NKiqYTIoxckHmYobDB4BXAwAxGl60wRP
	 nGroRjq4zN/DcMAJnC3+eKl41SBXCCxmeon28gXnZsAnpwtgNRpjvXVd85eOcKyV98
	 Wu61t8y5VgVVCNcSGGag8S4Wjn7K8FDVJXXhzDkS6EVztatHz6tR06CCscmCLQXo29
	 lPyDpwTWYCL0g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] openrisc: Add Kretprobes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sahil Siddiq" <sahilcdq0@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260930203129.51048-5-sahilcdq0@gmail.com>
References: <20260407185650.79816-2-sahilcdq0@gmail.com>
 <20260930203129.51048-5-sahilcdq0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 20:41:15 +0000
Message-Id: <20260930204116.4E7701F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] openrisc: kretprobe trampoline leaves regs->sp and regs->sr uninit=
ialized
--

commit a5e8b19fd4705325db24ad7195d2d69f741fc493
Author: Sahil Siddiq <sahilcdq0@gmail.com>

openrisc: Add Kretprobes

This commit adds Kretprobes support for OpenRISC by building on top of the
generic rethook framework. It implements the necessary trampoline routines =
to
intercept function returns and route them through the kretprobe handler.

> diff --git a/arch/openrisc/kernel/rethook_trampoline.S b/arch/openrisc/ke=
rnel/rethook_trampoline.S
> new file mode 100644
> index 0000000000000..ac4ca0ecc6694
> --- /dev/null
> +++ b/arch/openrisc/kernel/rethook_trampoline.S
[ ... ]
> +	.text
> +
> +	.macro save_all_base_regs
> +	l.sw	PT_GPR2(r1),r2
> +	l.sw	PT_GPR3(r1),r3

[Severity: High]
Does this macro need to save the stack pointer (r1) to the PT_SP offset and
the status register to the PT_SR offset? It appears they are omitted from t=
he
base register save list.

[ ... ]
> +SYM_CODE_START(arch_rethook_trampoline)
> +	/* Allocate enough space on stack for pt_regs */
> +	l.addi	r1,r1,-PT_SIZE
> +	save_all_base_regs
> +
> +	l.addi	r3,r1,0	/* pt_regs */
> +	l.jal	arch_rethook_trampoline_callback

[Severity: High]
Since save_all_base_regs skips saving r1 (sp) and sr, will the pt_regs
passed into arch_rethook_trampoline_callback contain uninitialized stack
garbage for regs->sp and regs->sr?

Tracing handlers like BPF or ftrace rely on functions like
kernel_stack_pointer() and user_mode() which read these fields. Could these
uninitialized fields lead to broken stack unwinding or incorrect privilege
evaluation when the kretprobe handlers run?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930203129.5104=
8-1-sahilcdq0@gmail.com?part=3D4
