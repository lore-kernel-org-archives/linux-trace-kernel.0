Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481A832ED4E
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Nov 2025 07:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763020272; cv=none; b=bHQLB/7mbYSVtbD/CLOA9ovUeryfmU/dkJw6ZkvLynAVBO9z7wvGnE3RT+KSpB+EnuKpQ228+S2O8aeccr6hTuFVh5kguF41hVWeJgrWt8N/Qk5UZh+KG80D3/joy1vZqj5M4ZwVwW+6927g2F1ShAAa4rw6VGn7ZiVgm3NIQyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763020272; c=relaxed/simple;
	bh=9cETCkpZu+73CbYMxqUO2XKUMgco4Nbh9FZ9O75Z47M=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J1F45scvQbDgLFeGj+aJkvFXpCqe+r+Isz/ux+oMcE/f6Qh4M1ahjsKYdYaj/IGTRv21Hu3i+dQsdM9OHunZjM7izl5lWOLrVTztYKk9/3x2DGHGvpDb84ammjcuJpvsvDCsIVM2SwQhaCpkMjK+VOhQBxNn1lqe8/7Cv6xRNxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V4a7/pke; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4a7/pke"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-641977dc00fso741621a12.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Nov 2025 23:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763020266; x=1763625066; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z4ie9nWkncZ3cv8xdi5OzMmGRGX86lWEjgjZYnVw6xo=;
        b=V4a7/pketx4PI1pk3qXO7rHoShCutUZFeGIPk34JACA3z5JKMz2SNcBP2sw9SxSAlq
         Er00k7/k7x+X44VB+r3tIA2Xftd1jafD77H8vqJbFLTC31Gu+vZTcI8qMylcJjXg8AdY
         2fEBA3gW17qlSLqbmATSpceBocin6eRZ+5ObhzcPEeW6fOoQBy16BkLlGj65ckQp49tt
         AB1sB3wqPUeHhQfqG4yjvroXdVzIWXgRwT7qZUR9EzXnxxNrGGNbf5tJ2tLaP2C6Pn61
         AvZU5ju9/drUNr+5tQzQz8HD5obsA0w+fLx8dgzQ/jBETMuIbhpuP4q43gTBG/zmMIIu
         uJMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763020266; x=1763625066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z4ie9nWkncZ3cv8xdi5OzMmGRGX86lWEjgjZYnVw6xo=;
        b=cJ4vdVeVQt45A5e41ZEkzAsbX/cimpsEAehBNsfAah3psUk+y2Sq0YUMxEKQwRNHd7
         CTr6ck76iwZp3FxzDYwukx/uQNJyj+KtYq/6tt+w7Zbvak3dOjEMDi6PHcYnciB/qziX
         FIn8GRvCE4e6tBX4zRzEvnOPEktA0kjpCFhjNqFsKIb9yxr3Q0/4fWsUo93mfjWKqilz
         YNAYXfI+ttkjKtzHYvhpYoePigYnO3m/urNb9Okst+XsPCzHEFpj2cxvJjldb04SLqhG
         aLvgzSNTiBvTQrlOeDGuNJ1ww2gJHaxTKEnsR29fTLxn9zCMVUt6pBKAyeRB8GSoMRpD
         YnzA==
X-Forwarded-Encrypted: i=1; AJvYcCVyLBvJkNJp7Ivpn3AzM7Udk/E7xWnSJhAwB/jipmoeT8PnQMesC9lMtw4eXB7NTlkW9ZWYRz5rRpDQ749soGwxqBs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz0YtHSkFs+ewXZZ8SsQcUlwqstr7HoFo3a8Bi98RkYtNqeJLN
	ASdGSQTjI0U8OwOzvYg6K2L9oLbRBmm+HVdevMDJNPDuMsmQmLbsq8lo
X-Gm-Gg: ASbGncu/ccIzsdDa2/Zvtk9+ZZM4A86Jrgne8LabwkNOwcPAA859XsYLjZWJMw1jATV
	zZ8n9W2kPVVCxOz1VCO2/6Gu6KTmNX9SikSGG6Syfi/feJBQs0+qAvZ5tAQqykKHwOQADEj46/p
	iw6jRFDwp3Sl2SIFZVGTph+APuNqiXSFGwm2PnphEQlozVVEOU0aDFkQFcq+hDQfWvX+I8ex4f9
	sGrykqBFU+bKFGi7s394ih2v9f8pGbRLUVIGASOkH/G9pJog126KMdvFAfig4IyNYsnzqnAqnx8
	n62LpMdH/+GzsOyGGi+X1ygPMu+R8kGX+3ohM5FaWJMRmxCBDzpPNLHLMjHVeHxXsbzmWPXp59d
	1efGhFMV7RHPnOUb8d51IOoCm4SXuPhxIJN0XJtUr371xHdtma8/k6ScRoRYhQERYYRxI4TeaWF
	KAVph0oc4Uvm+LRRSpko94u2I=
X-Google-Smtp-Source: AGHT+IHVrkl5ftPUCc2idnw2qC4J8BRUimnWx6JJY1s/gQB+ln/cURHHPYk7pTtS8ycN6UhNj5km9g==
X-Received: by 2002:a17:906:794e:b0:b3d:98fa:b3fe with SMTP id a640c23a62f3a-b7331b307e2mr650559466b.63.1763020266209;
        Wed, 12 Nov 2025 23:51:06 -0800 (PST)
Received: from krava (37-188-200-155.red.o2.cz. [37.188.200.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7359bfb238sm13421466b.14.2025.11.12.23.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 23:51:05 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 13 Nov 2025 08:51:00 +0100
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, x86@kernel.org,
	Yonghong Song <yhs@fb.com>, Song Liu <songliubraving@fb.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: Re: [BUG/RFC 1/2] arm64/ftrace,bpf: Fix partial regs after
 bpf_prog_run
Message-ID: <aRWN5EnjEekA5VE4@krava>
References: <20251105125924.365205-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105125924.365205-1-jolsa@kernel.org>

ping, thanks

jirka

On Wed, Nov 05, 2025 at 01:59:23PM +0100, Jiri Olsa wrote:
> hi,
> Mahe reported issue with bpf_override_return helper not working
> when executed from kprobe.multi bpf program on arm.
> 
> The problem seems to be that on arm we use alternate storage for
> pt_regs object that is passed to bpf_prog_run and if any register
> is changed (which is the case of bpf_override_return) it's not
> propagated back to actual pt_regs object.
> 
> The change below seems to fix the issue, but I have no idea if
> that's proper fix for arm, thoughts?
> 
> I'm attaching selftest to actually test bpf_override_return helper
> functionality, because currently we only test that we are able to
> attach a program with it, but not the override itself.
> 
> thanks,
> jirka
> 
> 
> ---
>  arch/arm64/include/asm/ftrace.h | 11 +++++++++++
>  include/linux/ftrace.h          |  3 +++
>  kernel/trace/bpf_trace.c        |  1 +
>  3 files changed, 15 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
> index ba7cf7fec5e9..ad6cf587885c 100644
> --- a/arch/arm64/include/asm/ftrace.h
> +++ b/arch/arm64/include/asm/ftrace.h
> @@ -157,6 +157,17 @@ ftrace_partial_regs(const struct ftrace_regs *fregs, struct pt_regs *regs)
>  	return regs;
>  }
>  
> +static __always_inline void
> +ftrace_partial_regs_fix(const struct ftrace_regs *fregs, struct pt_regs *regs)
> +{
> +	struct __arch_ftrace_regs *afregs = arch_ftrace_regs(fregs);
> +
> +	if (afregs->pc != regs->pc) {
> +		afregs->pc = regs->pc;
> +		afregs->regs[0] = regs->regs[0];
> +	}
> +}
> +
>  #define arch_ftrace_fill_perf_regs(fregs, _regs) do {		\
>  		(_regs)->pc = arch_ftrace_regs(fregs)->pc;			\
>  		(_regs)->regs[29] = arch_ftrace_regs(fregs)->fp;		\
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index 7ded7df6e9b5..4cb1315522bb 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -205,6 +205,9 @@ ftrace_partial_regs(struct ftrace_regs *fregs, struct pt_regs *regs)
>  	return &arch_ftrace_regs(fregs)->regs;
>  }
>  
> +static __always_inline void
> +ftrace_partial_regs_fix(struct ftrace_regs *fregs, struct pt_regs *regs) { }
> +
>  #endif /* !CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS || CONFIG_HAVE_FTRACE_REGS_HAVING_PT_REGS */
>  
>  #ifdef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index a795f7afbf3d..7b5768ced9b3 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2564,6 +2564,7 @@ kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
>  	old_run_ctx = bpf_set_run_ctx(&run_ctx.session_ctx.run_ctx);
>  	err = bpf_prog_run(link->link.prog, regs);
>  	bpf_reset_run_ctx(old_run_ctx);
> +	ftrace_partial_regs_fix(fregs, bpf_kprobe_multi_pt_regs_ptr());
>  	rcu_read_unlock();
>  
>   out:
> -- 
> 2.51.1
> 
