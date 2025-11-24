Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAA938DD8;
	Mon, 24 Nov 2025 05:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763963354; cv=none; b=lWgQEDVOpskMXVypWV1PtAIMpLh4CKbKFaTTfXbdXZChFP6HHwKbkH9d3pBnstzHojMl0zXXSRXOyHDK+l/yGxLj+hi6iALM5F1OMPHVNHN2WR8wU0tzCjQEzTRj77+v7sfy8r6ScsnqUh0aqehMPsA6145NU0bEHM/BwfpZxpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763963354; c=relaxed/simple;
	bh=RtmieIsRpu0yymoknLrJY7KVzPDvgcoCBsCC6GwVpPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uzqj1A1M6PKQ/WBtu/3lmeF6eGArMEpSzkHnZF7v1T7ko7qlnUo3bxax9NlxuxAmgww/ct+5DfXvSGMBYYvq8YrGWcjebzzerc331re8S2IdJ2LeIQNUlAHVPPpgzpFc0Bfb6Pk2if5Wp0iWamL8Pyc9AUADad4yMjKtrV1S+/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0hF0S29; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0hF0S29"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FEDAC4CEF1;
	Mon, 24 Nov 2025 05:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763963354;
	bh=RtmieIsRpu0yymoknLrJY7KVzPDvgcoCBsCC6GwVpPw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d0hF0S293H4CLdNZYHzKT3Sy19IcdMMHpgMd0I2ySi7yRxraNmOYU340i+32ka0eL
	 3zxez05k6i4WcwOJnWAWguZIUpzNbzzpIroRxnRfj/onrTwgkB1Jz0C157tXMFDFho
	 CnJ3K4GolGj/uMZMXp0ZKJtuXJTWdzgIzgCDJMFgox/rhMhZ+GsH3dT+Ct773b1J1n
	 Mw5pIvUco6A43OkP/4hSekcFICNUBX5h/mfGtGjjuqiIuObY/dVYzyDDceU42opqNw
	 UF8dzfMJ90NVnieiCGikHIVcaFBadRZtZQR2nSLz2zUPlZqVSqMP69Cttr3KfEve6G
	 fANOXP9aKIA8g==
Date: Mon, 24 Nov 2025 11:19:16 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Michael Ellerman <mpe@ellerman.id.au>, linux-trace-kernel@vger.kernel.org, 
	Mark Rutland <mark.rutland@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, llvm@lists.linux.dev, Maryam Moghadas <maryammo@ca.ibm.com>
Subject: Re: [PATCH 1/3] powerpc64: make clang cross-build friendly
Message-ID: <rtnn6dd6y3refo7myc4crzmrunbuyabr2ewlyk7oe4yx3f2rl2@wzoyvsucfeyf>
References: <20251108210405.2375472-1-hbathini@linux.ibm.com>
 <20251108210405.2375472-2-hbathini@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251108210405.2375472-2-hbathini@linux.ibm.com>

On Sun, Nov 09, 2025 at 02:34:03AM +0530, Hari Bathini wrote:
> ARCH_USING_PATCHABLE_FUNCTION_ENTRY depends on toolchain support for
> -fpatchable-function-entry option. The current script that checks
> for this support only handles GCC. Rename the script and extend it
> to detect support for -fpatchable-function-entry with Clang as well,
> allowing clean cross-compilation with Clang toolchains.
> 
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> ---
>  arch/powerpc/Kconfig                                         | 5 +++--
>  ...-function-entry.sh => check-fpatchable-function-entry.sh} | 0
>  2 files changed, 3 insertions(+), 2 deletions(-)
>  rename arch/powerpc/tools/{gcc-check-fpatchable-function-entry.sh => check-fpatchable-function-entry.sh} (100%)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 325c1171894d..dfb62e211c92 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -568,8 +568,9 @@ config ARCH_USING_PATCHABLE_FUNCTION_ENTRY
>  	depends on FUNCTION_TRACER && (PPC32 || PPC64_ELF_ABI_V2)
>  	depends on $(cc-option,-fpatchable-function-entry=2)
>  	def_bool y if PPC32
> -	def_bool $(success,$(srctree)/arch/powerpc/tools/gcc-check-fpatchable-function-entry.sh $(CC) -mlittle-endian) if PPC64 && CPU_LITTLE_ENDIAN
> -	def_bool $(success,$(srctree)/arch/powerpc/tools/gcc-check-fpatchable-function-entry.sh $(CC) -mbig-endian) if PPC64 && CPU_BIG_ENDIAN
> +	def_bool $(success,$(srctree)/arch/powerpc/tools/check-fpatchable-function-entry.sh $(CC) -mlittle-endian) if PPC64 && CPU_LITTLE_ENDIAN && CC_IS_GCC
> +	def_bool $(success,$(srctree)/arch/powerpc/tools/check-fpatchable-function-entry.sh $(CC) -target ppc64le -mlittle-endian) if PPC64 && CPU_LITTLE_ENDIAN && CC_IS_CLANG

Can you instead pass $(CLANG_FLAGS) to retain the same command across 
gcc/clang?

- Naveen

