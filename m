Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D076F14D71E;
	Thu, 13 Jun 2024 22:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718318178; cv=none; b=IRIM3O5mGjlIo6ouFSxN2fo9QiLyiBWcCQBCnJJnsyS5Ap+fhuW+abDGOBVQ2qr6b0u0LT9Jc3mxKxgkDH7kXg8oHO+OsjD9tooNgbcKv+r+rcScsHR80dpvFwDGHRecvzOLn6uWVYv94fL2kPjpCDOQHExiLUpnJShePJ2uboY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718318178; c=relaxed/simple;
	bh=wL06T1k2B8Q2rL32NqzllZw15uOhghb5OR6zN4NYrfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=to0mo54n+A3VpFwFrtWqr1XMgDWwSnpsoMtjwJljDulzBf/oaJpSES+wFk52dV2P7kRBYFPpjL5KBShadn07VutiM4LF+S+fMgEnJpFvf0amhhdZhJaHf59RxH9AvZjQA7v7cDEf3qb9ygLO1td3mjIrCV0IqLvks4caj5B6iwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gNzn+PCH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gNzn+PCH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3894BC32786;
	Thu, 13 Jun 2024 22:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718318178;
	bh=wL06T1k2B8Q2rL32NqzllZw15uOhghb5OR6zN4NYrfo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gNzn+PCHszOklsBLsMSUobxEOt3oNA31VuDs0RoPQzosJ5FKK4ZZpIUgZvpeLy0Ys
	 ZcnN3hmYy2Et0hsuuT7G67TJ4asf17PqyfivrljLeTL/7sbh/RvGLABbvGbZMLoJqz
	 xu485Bb1Lx1Vd29xTjkzPXPGV0+7rvANw6oDJIi2Pt+mRZ9cCfxMfnI6Ph7qnmymx3
	 hYltskgyvOGG2fxulkPoaxbcwPeKj5k3qWwWlGgnF8TbL8+KIagy8O2AKaf3C4Kwzg
	 p+0A1IYbrvnDSRCtba5fIGMz4WOiHodY7XQ0tN7C3b7yH7t0aVrU98QV5BpB/ekqj/
	 oHLy4+BBqawag==
Date: Thu, 13 Jun 2024 15:36:15 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Andy Chiu <andy.chiu@sifive.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Zong Li <zong.li@sifive.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, llvm@lists.linux.dev,
	Evgenii Shatokhin <e.shatokhin@yadro.com>
Subject: Re: [PATCH 3/8] riscv: ftrace: support fastcc in Clang for WITH_ARGS
Message-ID: <20240613223615.GA2739249@thelio-3990X>
References: <20240613-dev-andyc-dyn-ftrace-v4-v1-0-1a538e12c01e@sifive.com>
 <20240613-dev-andyc-dyn-ftrace-v4-v1-3-1a538e12c01e@sifive.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613-dev-andyc-dyn-ftrace-v4-v1-3-1a538e12c01e@sifive.com>

On Thu, Jun 13, 2024 at 03:11:08PM +0800, Andy Chiu wrote:
> Some caller-saved registers which are not defined as function arguments
> in the ABI can still be passed as arguments when the kernel is compiled
> with Clang. As a result, we must save and restore those registers to
> prevent ftrace from clobbering them.
> 
> - [1]: https://reviews.llvm.org/D68559
> Reported-by: Evgenii Shatokhin <e.shatokhin@yadro.com>
> Closes: https://lore.kernel.org/linux-riscv/7e7c7914-445d-426d-89a0-59a9199c45b1@yadro.com/
> Signed-off-by: Andy Chiu <andy.chiu@sifive.com>

Acked-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  arch/riscv/include/asm/ftrace.h |  7 +++++++
>  arch/riscv/kernel/asm-offsets.c |  7 +++++++
>  arch/riscv/kernel/mcount-dyn.S  | 16 ++++++++++++++--
>  3 files changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
> index 9eb31a7ea0aa..5f81c53dbfd9 100644
> --- a/arch/riscv/include/asm/ftrace.h
> +++ b/arch/riscv/include/asm/ftrace.h
> @@ -144,6 +144,13 @@ struct ftrace_regs {
>  			unsigned long a5;
>  			unsigned long a6;
>  			unsigned long a7;
> +#ifdef CONFIG_CC_IS_CLANG
> +			unsigned long t2;
> +			unsigned long t3;
> +			unsigned long t4;
> +			unsigned long t5;
> +			unsigned long t6;
> +#endif
>  		};
>  	};
>  };
> diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
> index b09ca5f944f7..db5a26fcc9ae 100644
> --- a/arch/riscv/kernel/asm-offsets.c
> +++ b/arch/riscv/kernel/asm-offsets.c
> @@ -497,6 +497,13 @@ void asm_offsets(void)
>  	DEFINE(FREGS_SP,	    offsetof(struct ftrace_regs, sp));
>  	DEFINE(FREGS_S0,	    offsetof(struct ftrace_regs, s0));
>  	DEFINE(FREGS_T1,	    offsetof(struct ftrace_regs, t1));
> +#ifdef CONFIG_CC_IS_CLANG
> +	DEFINE(FREGS_T2,	    offsetof(struct ftrace_regs, t2));
> +	DEFINE(FREGS_T3,	    offsetof(struct ftrace_regs, t3));
> +	DEFINE(FREGS_T4,	    offsetof(struct ftrace_regs, t4));
> +	DEFINE(FREGS_T5,	    offsetof(struct ftrace_regs, t5));
> +	DEFINE(FREGS_T6,	    offsetof(struct ftrace_regs, t6));
> +#endif
>  	DEFINE(FREGS_A0,	    offsetof(struct ftrace_regs, a0));
>  	DEFINE(FREGS_A1,	    offsetof(struct ftrace_regs, a1));
>  	DEFINE(FREGS_A2,	    offsetof(struct ftrace_regs, a2));
> diff --git a/arch/riscv/kernel/mcount-dyn.S b/arch/riscv/kernel/mcount-dyn.S
> index 745dd4c4a69c..e988bd26b28b 100644
> --- a/arch/riscv/kernel/mcount-dyn.S
> +++ b/arch/riscv/kernel/mcount-dyn.S
> @@ -96,7 +96,13 @@
>  	REG_S	x8,  FREGS_S0(sp)
>  #endif
>  	REG_S	x6,  FREGS_T1(sp)
> -
> +#ifdef CONFIG_CC_IS_CLANG
> +	REG_S	x7,  FREGS_T2(sp)
> +	REG_S	x28, FREGS_T3(sp)
> +	REG_S	x29, FREGS_T4(sp)
> +	REG_S	x30, FREGS_T5(sp)
> +	REG_S	x31, FREGS_T6(sp)
> +#endif
>  	// save the arguments
>  	REG_S	x10, FREGS_A0(sp)
>  	REG_S	x11, FREGS_A1(sp)
> @@ -115,7 +121,13 @@
>  	REG_L	x8, FREGS_S0(sp)
>  #endif
>  	REG_L	x6,  FREGS_T1(sp)
> -
> +#ifdef CONFIG_CC_IS_CLANG
> +	REG_L	x7,  FREGS_T2(sp)
> +	REG_L	x28, FREGS_T3(sp)
> +	REG_L	x29, FREGS_T4(sp)
> +	REG_L	x30, FREGS_T5(sp)
> +	REG_L	x31, FREGS_T6(sp)
> +#endif
>  	// restore the arguments
>  	REG_L	x10, FREGS_A0(sp)
>  	REG_L	x11, FREGS_A1(sp)
> 
> -- 
> 2.43.0
> 
