Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4C032ABDC
	for <linux-trace-kernel@vger.kernel.org>; Mon, 27 Oct 2025 22:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761603935; cv=none; b=RIYtuIshGezbse/Zc5Xek6DRNJ+ykPJBOshobLIZ+etPdWt90/JnCyKTjjYtbxUfrqrvT1aW/MJKj3DyuPw4u8jS1ny73Ak1hdxUrip2iGHZee7iywh0I8kB+VdB/bp8/ZOS7M/DlN4D0ySQIbxBW3fqvPNHQiA0pyDi7DAweXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761603935; c=relaxed/simple;
	bh=ujIAydKczuzdwKBdhbyuKoWTL5IbL7V/TEs/+/HAH2M=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZaA0hyk2Kbv0Yk+TRAm+4ZdPLg2W40LKzsDyQHqyy/polp/vRcy+x8DWw6AV2v6OydSmn75eJq4zvU10H8SVBuLlgoPkIkHX5QfNb/6V4/zvQctEqE0H75czDl4JPOZo64d3I1u0EgNzapV6HEV71vgYa4bi0afHU32BH30nhEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFjWr7Is; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFjWr7Is"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-475d9de970eso25157745e9.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761603932; x=1762208732; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MKDbU8B4IbG+AAzbZltvWI7s50AOGrKS71QrEu9vmRY=;
        b=LFjWr7IsGCicE/XBCvNiXABDOS/DJOaKIjU7vurkKgaa5l/7481xoGTrfgjNFbpwFG
         uw8XTUw0bzG1cVhxmBs3dn8sgkTSFmgaqkWIvit2DRymc/0jvFSGk/CguXxXjnQMTKtk
         uq2oInYyANV/qupdxUP4UShFBdAVmpzqALb2PVTEqrLvfz5Lwxbm64eKNCMC4BUBtaq5
         v2AG9t6tI8VFIbDQ3iFqw8BrHZPYdkVSeowvu7Y/m3yEiDA6F89py0eSPm+weFW0ww7B
         ayEwWZ6d8Yp9QXNnYkFvjb7IzWTtaPY29aWvfNf+o+M0K8W/SSz9sGfiO2rMUDvQo33L
         SU0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761603932; x=1762208732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MKDbU8B4IbG+AAzbZltvWI7s50AOGrKS71QrEu9vmRY=;
        b=EwK0nr5OtZxOC6e4KG78PHiX5Cb8YccMFlzH0S9HleuADzwKyOnsMHbUkrXkg81VXZ
         l1b9t4ZOFS4ZGfUp3juMdOOyoyqp2dRkuwORqWi5Zk+DIFaTpcCEdla4dFH2ywaRrAvw
         5wuaA0iYTas6Ro8j02ganpvoZRPgZVxe8ByepCmW/8HpGkEFE68ixvY8kWbC+AJc4Sib
         T7+a5FQGMBk2rD81Wo2DbLVf5kfHR69IGobNYvk60f9L5e0+yxc+5ntIa2sZqc47yqvf
         k2KqaPeDRRblYoCFT90qhAfRKGynUPGVCR/oTsozb1kU8vrO96ayfn7l7tD94kaARtuo
         GVzw==
X-Forwarded-Encrypted: i=1; AJvYcCX4PhS3MpGb8NBqgx7tkHPkBoARBQ2UVExudD9vzo8umQWbtvFN5AJEE3EkJHEAnL06lLSIfQ+CPoQlm23XytezCP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNWKsWOYA0kL1UEgdRgMqZ7QJ04EbFqmAdgRQSnoaIfTFpRGNr
	JMIBOTPxMoFGnQqEA5UeBin3fLWOgIXDqbq3DfJ0LNiBm75O9MrU/Qfo
X-Gm-Gg: ASbGncvUJVYkCcRMs7h1cCn1qjbZzJ2FWI7mS0fx6spRannRBr4ZoLnPwjv74luDtaO
	bncVMyatpsRMtmJQzNFPYNBr3soh/Deychp03pWSqoDzUAZl3wnD14+0Q2/Ebqb6BRdW+2VV2rC
	tCpqaLm7/GaXJ2SzUNcDb8UtWRhrISLtPmYQIRd2FnWTXVv7szqSlDnf55A0Q3Zalpt3h+NIyK0
	aW7rAmm6k9CNK3RRyfWoV3aMjJBgSDsAwqvShcwt2aUSCJSekWHNFv8+XEFWfSQP9ZdL5k1/8i6
	i1G+DUjQ2kGRxNHi4SWwjS55BbU/RCOKIk1sdX5qCtydMwBnjYfBsG7Rx/Kr74Wp6pC4kWDriKo
	jJdoa7KjAqLAXslnIK3lwX1szXz9BRqRRNaQ2FkHclxY97uHywGkk5kTA/WxiH3lu
X-Google-Smtp-Source: AGHT+IFewjIU04uCpHRCTJrs4Aqm896DfPXNFrP2ep6c0V5rjWWsGXrd3MTH1aryAc1zbKqXD+Is1w==
X-Received: by 2002:a05:600c:4fc4:b0:477:fcb:2256 with SMTP id 5b1f17b1804b1-47717e037f5mr9929675e9.17.1761603932286;
        Mon, 27 Oct 2025 15:25:32 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd4783b8sm159667385e9.15.2025.10.27.15.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 15:25:31 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 27 Oct 2025 23:25:29 +0100
To: bot+bpf-ci@kernel.org
Cc: mhiramat@kernel.org, rostedt@goodmis.org, jpoimboe@kernel.org,
	song@kernel.org, peterz@infradead.org, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, yhs@fb.com,
	songliubraving@fb.com, andrii@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH 1/3] Revert "perf/x86: Always store regs->ip in
 perf_callchain_kernel()"
Message-ID: <aP_xWRe7qNr1j9Px@krava>
References: <20251027131354.1984006-2-jolsa@kernel.org>
 <8227ad3af501bb982231ef00ac5e970a0a12c9d64e07ea3f3d37100ec7e3f1cc@mail.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8227ad3af501bb982231ef00ac5e970a0a12c9d64e07ea3f3d37100ec7e3f1cc@mail.kernel.org>

On Mon, Oct 27, 2025 at 01:52:18PM +0000, bot+bpf-ci@kernel.org wrote:
> 
> ```
> commit 26b06def1956497a15eecf22787d5430fad2fed6
> Author: Jiri Olsa <jolsa@kernel.org>
> 
> Revert "perf/x86: Always store regs->ip in perf_callchain_kernel()"
> 
> This commit reverts a 2019 fix that ensured regs->ip is stored when
> using non-HW regs (regs populated by perf_arch_fetch_caller_regs). The
> revert claims the IP is captured during unwinding, but analysis suggests
> otherwise.
> 
> > diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> > index 745caa6c1..fa6c47b50 100644
> > --- a/arch/x86/events/core.c
> > +++ b/arch/x86/events/core.c
> > @@ -2789,13 +2789,13 @@ perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *re
> >  		return;
> >  	}
> >
> > -	if (perf_callchain_store(entry, regs->ip))
> > -		return;
> > -
> > -	if (perf_hw_regs(regs))
> > +	if (perf_hw_regs(regs)) {
> > +		if (perf_callchain_store(entry, regs->ip))
> > +			return;
> >  		unwind_start(&state, current, regs, NULL);
> > -	else
> > +	} else {
> >  		unwind_start(&state, current, NULL, (void *)regs->sp);
> > +	}
> 
> When perf_hw_regs(regs) returns false (which happens when regs comes from
> perf_arch_fetch_caller_regs since it sets regs->flags=0), the else branch
> calls unwind_start with regs=NULL. Can this lose the regs->ip value?
> 
> Looking at the code flow:
> 
> perf_arch_fetch_caller_regs() sets:
>   - regs->ip = CALLER_ADDR0 (the caller's instruction pointer)
>   - regs->flags = 0 (no X86_EFLAGS_FIXED)
> 
> perf_hw_regs() checks:
>   - returns (regs->flags & X86_EFLAGS_FIXED), which is false
> 
> The else branch executes:
>   - unwind_start(&state, current, NULL, (void *)regs->sp)
> 
> In __unwind_start() at arch/x86/kernel/unwind_orc.c, when regs=NULL:
>   - Takes the "else if (task == current)" path (line 711)
>   - Initializes state->ip via inline asm from current location
>   - This is __unwind_start's IP, not the original regs->ip
>   - Then advances to first_frame at regs->sp (lines 755-758)
> 
> The original regs->ip value (captured by perf_arch_fetch_caller_regs) is
> never stored in the callchain. This was the exact issue fixed by commit

IIUC it is, unwinder will eventually unwind to it

> 83f44ae0f8af in 2019, which stated:
> 
>   "The stacktrace_map_raw_tp BPF selftest is failing because the RIP
>    saved by perf_arch_fetch_caller_regs() isn't getting saved by
>    perf_callchain_kernel()."
> 
> Does this revert re-introduce the BPF selftest failure that was fixed in
> 2019? The test tools/testing/selftests/bpf/prog_tests/stacktrace_map_raw_tp.c
> still exists in the kernel tree.

stacktrace_map_raw_tp does not check what's the first ip of the
stacktrace and it passes with or without this change

I can see double entries on current code and just one with this change:

# bpftrace -e 'tracepoint:sched:sched_process_exec { print(kstack()); }'
Attaching 1 probe...

        bprm_execve+1767
        bprm_execve+1767
        do_execveat_common.isra.0+425
        __x64_sys_execve+56
        do_syscall_64+133
        entry_SYSCALL_64_after_hwframe+118

thanks,
jirka
