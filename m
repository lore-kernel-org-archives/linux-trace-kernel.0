Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB509137C20;
	Thu, 13 Jun 2024 19:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718305764; cv=none; b=DWYbhgdpZS/HCD7O8CddL//tSVedSGYcROmijJ/R/uP7PmNNPR6cQUVT3g5TvdT5soTPM41UsD+bzza0MVOx39Zppmlz3ab++gRldO5pBMZA6FQ22E2IeMovZw0ukGtdOryCk5bAgH2lOEB9zwxlyFWgKhA+WDN/2SPYmzsV7x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718305764; c=relaxed/simple;
	bh=HFWyWh6KpryPRqXeZqS8bpwy4cpqT7565JH13UCYe8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=URFTR3E1b82UiJldQXEDSVB+81XT14dvazmUnQ1xmmWrPkqxJ60oAQQPTip+jCV0NBpHp9mABL8MVyAZTINsOAaRb3IFKvGZgU9l67xF22UpQckhVG0beTo9YiduTZZ1cNngRDusphIOUkyTc+s2YcFxHggYNIASFngZtR4na0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r15KrCdS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r15KrCdS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C484C2BBFC;
	Thu, 13 Jun 2024 19:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718305763;
	bh=HFWyWh6KpryPRqXeZqS8bpwy4cpqT7565JH13UCYe8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r15KrCdS9IdIHad1rdEnJ2d8ckWytMU6LKbZHtECfabZeOOL5NeBLIxxPBq3z0zys
	 3slzhtA9cdHuWZnGZHDV5NLs2bTHbBZynuD7Q8DQOxVA09rVcITHteKZ+9+HgLXR5M
	 HdoVCKVKrpzgEk2cSlL6jYQ71DUrUvpCH8y/LyXJsqZGTYjaU0YmUIsxGTKPGUwrAM
	 uV1gBh1sR/ghA14TJc9M7AyHJIwf42TPHHmnNcaLCqawQObi8CV5wvWxi8CbRIG6cM
	 TBm0dJY8W1NUsdLFkBf/mQlzHFacpAS20ZjS1cela3jB5ird9bozLTcvGNoQEx+Z3j
	 J9N0ANl5gHr0g==
Date: Thu, 13 Jun 2024 12:09:20 -0700
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
Subject: Re: [PATCH 4/8] riscv: ftrace: align patchable functions to 4 Byte
 boundary
Message-ID: <20240613190920.GB1272931@thelio-3990X>
References: <20240613-dev-andyc-dyn-ftrace-v4-v1-0-1a538e12c01e@sifive.com>
 <20240613-dev-andyc-dyn-ftrace-v4-v1-4-1a538e12c01e@sifive.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613-dev-andyc-dyn-ftrace-v4-v1-4-1a538e12c01e@sifive.com>

Hi Andy,

On Thu, Jun 13, 2024 at 03:11:09PM +0800, Andy Chiu wrote:
> We are changing ftrace code patching in order to remove dependency from
> stop_machine() and enable kernel preemption. This requires us to align
> functions entry at a 4-B align address.
> 
> However, -falign-functions on older versions of GCC alone was not strong
> enoungh to align all functions. In fact, cold functions are not aligned
> after turning on optimizations. We consider this is a bug in GCC and
> turn off guess-branch-probility as a workaround to align all functions.
> 
> GCC bug id: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=88345
> 
> The option -fmin-function-alignment is able to align all functions
> properly on newer versions of gcc. So, we add a cc-option to test if
> the toolchain supports it.
> 
> Suggested-by: Evgenii Shatokhin <e.shatokhin@yadro.com>
> Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
> ---
>  arch/riscv/Kconfig  | 1 +
>  arch/riscv/Makefile | 7 ++++++-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index b94176e25be1..80b8d48e1e46 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -203,6 +203,7 @@ config CLANG_SUPPORTS_DYNAMIC_FTRACE
>  config GCC_SUPPORTS_DYNAMIC_FTRACE
>  	def_bool CC_IS_GCC
>  	depends on $(cc-option,-fpatchable-function-entry=8)
> +	depends on $(cc-option,-fmin-function-alignment=4) || !RISCV_ISA_C

Please use CC_HAS_MIN_FUNCTION_ALIGNMENT (from arch/Kconfig), which
already checks for support for this option.

>  config HAVE_SHADOW_CALL_STACK
>  	def_bool $(cc-option,-fsanitize=shadow-call-stack)
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index 06de9d365088..74628ad8dcf8 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -14,8 +14,13 @@ endif
>  ifeq ($(CONFIG_DYNAMIC_FTRACE),y)
>  	LDFLAGS_vmlinux += --no-relax
>  	KBUILD_CPPFLAGS += -DCC_USING_PATCHABLE_FUNCTION_ENTRY
> +ifeq ($(CONFIG_CC_IS_CLANG),y)

Same here, please invert this and use

  ifdef CONFIG_CC_HAS_MIN_FUNCTION_ALIGNMENT

like the main Makefile does.

> +	cflags_ftrace_align := -falign-functions=4
> +else
> +	cflags_ftrace_align := -fmin-function-alignment=4
> +endif
>  ifeq ($(CONFIG_RISCV_ISA_C),y)
> -	CC_FLAGS_FTRACE := -fpatchable-function-entry=4
> +	CC_FLAGS_FTRACE := -fpatchable-function-entry=4 $(cflags_ftrace_align)
>  else
>  	CC_FLAGS_FTRACE := -fpatchable-function-entry=2
>  endif
> 
> -- 
> 2.43.0
> 
> 
