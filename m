Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5633702E4
	for <linux-trace-kernel@vger.kernel.org>; Tue, 18 Nov 2025 22:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763503323; cv=none; b=My4+CHkOsi+x67zFg8/djVH/Z9KJv6erbTaP0VhsPBDEZbZLvNkCO6qGt9RA+o9xmNUHdIOU9tPKrUjKITbcmhaNjOZDzhHaBszuZxTaGY8aY4HM01+sQYac8VuZaCeuGlrmb+3aseJ68eJNXRfCYzQW5vI32LEDISr9lkTILlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763503323; c=relaxed/simple;
	bh=ntvVGR4qtfpL8K6iEH3IM2PbXNyI4dcwND/L0wZFGQc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lij8IahhBbxmnacskcldj1g0jPmB+/OWQVuUR5DTEhuvkOtoO41ZHn6bgbMeFXcajnvebXt+ZAe6IBXEje/orLAwHq5xHJWtJK1LcHDjqTu7seU5fwbiMGLdfDO8KI3KAT3rrgy9epqFSYS5Vr+kRwdW81g66e2afvJvpYjPWFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=klUd2EZY; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klUd2EZY"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4779adb38d3so29512905e9.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 18 Nov 2025 14:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763503320; x=1764108120; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EV5ZlV/r4PmNeNEl8WOn4Jz8XFUkWFRulyEcsSdt9nA=;
        b=klUd2EZYq3HTS6I6pv4U7ilV/SqD0L1zd0G0eKd8VtPW6BwuPJ1FfUUzpTRwm0l9mZ
         liRv0TZavrzX6abX4GEC77dHx76gBPqCiOYOxlH2PrKapGqC1LcPdf8qoW5o89s8g+Eo
         7Xt3P+1x3CeVWQaUnlAhGn47ml/g0pDlRjcxE1a0U1ulVfNgQ+yKGOhrA4UWzxESw1zg
         E3uTqXY5ucOvMSJitUHlaoMD4BDSfj1SMBEkS1AUtgDyfC5J0UPZDT0PR6eV09T2WlIZ
         B50iZO49ZLJappSn/mn7WYEUAPjOVyBHE1pjBJO+OQm3OxJd6xtwIy+VRTu1sPPpstY4
         mmDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763503320; x=1764108120;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EV5ZlV/r4PmNeNEl8WOn4Jz8XFUkWFRulyEcsSdt9nA=;
        b=QEyCq6+FIV0BYxiAjrVX6e8yhgjbhNISqG6Kk+sByJj0buWgfjewp7VKixS7HccB1k
         +mhcZ1fiqmU9dJVzhRTzC0K6ePpRrIn4RrYbYLrxGYyphGopf+XUm4ibipOlmq36tTaU
         0z7yC+uN1Berl06dz2/1h6VM81ggWJPa56/FHv7OVIrlpcx7RRjE9k616bFVlNUGYDem
         a3KkJX4noIetKlok2Cf6c2FX7DfRpuMHRiR/akPOK4ruPCxFC1BtXSIUzNjQaBxC6Bw6
         kO4a1mi54O5qrdyb7wOY+itLPWzaOKO0UNMEpParJ3w6Py/BtC0VIVkLxNUuI3vepa2R
         tg8w==
X-Forwarded-Encrypted: i=1; AJvYcCW3EOnZAJuYKUgeCSJ+S0Ay2f7jb2xA1ggfiHHYtmS0wrYMyKDDvj+t22i8jxMEmuJbOy1l1p/3VExNKOpQbvhBlHE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy97M4fYapzoOhLZtthqaAT5uwilzaPhlYEmblFQKtPaai6xfnk
	3PFD+Gu2gkaHpBxAFh4nuC2F5MfiLoJN4IuCSdMexEiGU7LiWD8jpQEE
X-Gm-Gg: ASbGncvYeOynUn0r8yITRl/AzjR0NJIv56zccZ4wkIvffsMGO0+eg6v6oIIiKsybjZa
	vLqkcFT7HCb3XO2rsh8F7g4AKQp7gxx0HlI8GoEaG6o6tq83SqKwBxPvJ60tHY26yM+6RwcOg4B
	NWU+NcHlaM/pt7cViFP6piQ81bi2f49br4HTEDJrwmk6eFQxMgK+oc6G1V3bzAG4I8R/LfAYR2c
	IEFY+aRkqAPf32MjGcQnsd2xa4zt/D1zamd4i/1Fq2EBc/A2/ScC3wo41maadQQTEjJ7WT6ouSv
	RbO0Kmis48ZmSmy5C8rW6o/GUejvDiFwkmSQvMZ7D3iVTeII3UJM812+KY64Dt9rIjsexsTRhtl
	EpD4gWxs8HNyr9jvEWfE0pMKM3wkf57ilqkAa7+VAvC5qeCNzd3Ng4aMPf68cCMU0vop5h56zGg
	TJZl2p7AuSCw==
X-Google-Smtp-Source: AGHT+IF/OhkurrwdOZ6kPNeXhKWxi8ctcdf4yOCE/6q75hLzkXUfFrkHbSkcxerxH8L/9+nbFF3bSw==
X-Received: by 2002:a05:600c:1d19:b0:46e:5100:326e with SMTP id 5b1f17b1804b1-4778fea835dmr160650775e9.23.1763503319442;
        Tue, 18 Nov 2025 14:01:59 -0800 (PST)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a9d198a0sm26974015e9.1.2025.11.18.14.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 14:01:58 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 18 Nov 2025 23:01:56 +0100
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: ast@kernel.org, rostedt@goodmis.org, daniel@iogearbox.net,
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	mhiramat@kernel.org, mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com, jiang.biao@linux.dev,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 2/6] x86/ftrace: implement
 DYNAMIC_FTRACE_WITH_JMP
Message-ID: <aRzs1GGLCm5svW5_@krava>
References: <20251118123639.688444-1-dongml2@chinatelecom.cn>
 <20251118123639.688444-3-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118123639.688444-3-dongml2@chinatelecom.cn>

On Tue, Nov 18, 2025 at 08:36:30PM +0800, Menglong Dong wrote:
> Implement the DYNAMIC_FTRACE_WITH_JMP for x86_64. In ftrace_call_replace,
> we will use JMP32_INSN_OPCODE instead of CALL_INSN_OPCODE if the address
> should use "jmp".
> 
> Meanwhile, adjust the direct call in the ftrace_regs_caller. The RSB is
> balanced in the "jmp" mode. Take the function "foo" for example:
> 
>  original_caller:
>  call foo -> foo:
>          call fentry -> fentry:
>                  [do ftrace callbacks ]
>                  move tramp_addr to stack
>                  RET -> tramp_addr
>                          tramp_addr:
>                          [..]
>                          call foo_body -> foo_body:
>                                  [..]
>                                  RET -> back to tramp_addr
>                          [..]
>                          RET -> back to original_caller
> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
>  arch/x86/Kconfig            |  1 +
>  arch/x86/kernel/ftrace.c    |  7 ++++++-
>  arch/x86/kernel/ftrace_64.S | 12 +++++++++++-
>  3 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index fa3b616af03a..462250a20311 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -230,6 +230,7 @@ config X86
>  	select HAVE_DYNAMIC_FTRACE_WITH_ARGS	if X86_64
>  	select HAVE_FTRACE_REGS_HAVING_PT_REGS	if X86_64
>  	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
> +	select HAVE_DYNAMIC_FTRACE_WITH_JMP	if X86_64
>  	select HAVE_SAMPLE_FTRACE_DIRECT	if X86_64
>  	select HAVE_SAMPLE_FTRACE_DIRECT_MULTI	if X86_64
>  	select HAVE_EBPF_JIT
> diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
> index 4450acec9390..0543b57f54ee 100644
> --- a/arch/x86/kernel/ftrace.c
> +++ b/arch/x86/kernel/ftrace.c
> @@ -74,7 +74,12 @@ static const char *ftrace_call_replace(unsigned long ip, unsigned long addr)
>  	 * No need to translate into a callthunk. The trampoline does
>  	 * the depth accounting itself.
>  	 */
> -	return text_gen_insn(CALL_INSN_OPCODE, (void *)ip, (void *)addr);
> +	if (ftrace_is_jmp(addr)) {
> +		addr = ftrace_jmp_get(addr);
> +		return text_gen_insn(JMP32_INSN_OPCODE, (void *)ip, (void *)addr);
> +	} else {
> +		return text_gen_insn(CALL_INSN_OPCODE, (void *)ip, (void *)addr);
> +	}
>  }
>  
>  static int ftrace_verify_code(unsigned long ip, const char *old_code)
> diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
> index 823dbdd0eb41..a132608265f6 100644
> --- a/arch/x86/kernel/ftrace_64.S
> +++ b/arch/x86/kernel/ftrace_64.S
> @@ -285,8 +285,18 @@ SYM_INNER_LABEL(ftrace_regs_caller_end, SYM_L_GLOBAL)
>  	ANNOTATE_NOENDBR
>  	RET
>  
> +1:
> +	testb	$1, %al
> +	jz	2f
> +	andq $0xfffffffffffffffe, %rax
> +	movq %rax, MCOUNT_REG_SIZE+8(%rsp)
> +	restore_mcount_regs
> +	/* Restore flags */
> +	popfq
> +	RET

is this hunk the reason for the 0x1 jmp-bit you set in the address?

I wonder if we introduced new flag in dyn_ftrace::flags for this,
then we'd need to have extra ftrace trampoline for jmp ftrace_ops

jirka
