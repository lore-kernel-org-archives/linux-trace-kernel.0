Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0868E223DDA
	for <linux-trace-kernel@vger.kernel.org>; Tue,  4 Nov 2025 09:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762248446; cv=none; b=m8I8iIZXBdZgVH+Y+KKnIRb3owocteSzo/SidwruybpA3Jnr0Ql2690ExIHXf3gt3uUypSVrIqWHLVjlSRFEUekH0IWpiV7WLVrVfnejXBWKJlaZ3oP4l16+yvI9OqwmncOWUXsJu7n6BJx30ivOcrfZ+jY3hSJYy9bMk/JsPzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762248446; c=relaxed/simple;
	bh=VIL05nHFT4N6JAG/H2iMRz7OrtDZbp13GR+Lkr9m0m4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kee3WqaYOfu+aABlv9FGBOZZ+pLVG2RKZYP4SJgGWzhw1JnGycdPInF0EZ8Nbq78EPeSYEl8YqgU+lsn0OHYw0Z9w4naOU0susAsCrsvGAsj9YyNgGTg66fLwUzz7pk8lg8Q0RKY1HJy7XA4bmo3st8schTS/Wv7qQ4osmomwQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K4IhtWMC; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4IhtWMC"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-429bf011e6cso3814362f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 04 Nov 2025 01:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762248443; x=1762853243; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oAiC86qBA7A39iWQR2bMUkqXVWA4G10ZvXba/KKkMyI=;
        b=K4IhtWMCtKLxMSMUCxBB4qWgLuSWTpzCT12alYZRcv4KDgzm7rz/ezkL79TgPc9cdN
         X4S/9WQThRupWvuEN5VYqQXHXyxoHHsIL1+nPrXv8g8PRmkJhC8ylBG5mPWthm6And69
         q/YHnxLQVkrvTkW9n2AuTGoamQqxtp/yvkHje++WYSzQ4YnWg9pvZJvdj69kWA5GcGYE
         oSOCIyJ4h9R9gABKW7tCkU3fu8V4G6KQpoxNKkf78akoCNLmOexow4EHR9Nn3jwc500X
         cDBFf/TffiDhObbufEB9KNMDhiuJURctJeXoRITDpwlwhDx8CsADckLs0T8t8UY8f0a/
         +sig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762248443; x=1762853243;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oAiC86qBA7A39iWQR2bMUkqXVWA4G10ZvXba/KKkMyI=;
        b=lCegMEXmmM0OwRPDt/OBALcDdjITnklhTF731kKz3KqltTezeT4VoCPbrAaKQ8mDC0
         lsYsIuWjzDmAGNsrY2tlr77bbfUhhkVhNTPOtcyVSaF0VPY92qo3CWlTFlamgoE5BNFn
         QxsfMBEiXF/V18dvezp36bhNm3OVIocfIMSYg1iDEi8InV/EH2pLQJvJYHQvr4BrHb4n
         CRxIMo/LVVhhKiBssWqfK+2f/s7ZAku6cLm3G7Zyq2iOR7/Jvx2GWwyFoJnDkwmM/XIk
         ZfDuW1yaKyA+O4/JTPEGzfWac3bp3pBC8mch3vI88Mw9rLYnPOLr7tsultWzZoLPrFKW
         MRRg==
X-Forwarded-Encrypted: i=1; AJvYcCUdyQ0iiJb4EaBI4YPmnv+wcfopDtjCXQIwZPZbxFzBUj5bkVVMvf3uWOZsJoV2nSr/bX2b8scldSswEntUZbK39cw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTTysDR53QzyBlW0RqRkUJlixLlOknYS6dVERpFq7T8jgEt7Ep
	UefiIGRsi/L0FfQCL4fR2ZOEhB4urWRtS1MOEQuZVWrnKlHFFwe7lhyk
X-Gm-Gg: ASbGnctlC4DDKsKrUlzg/KD//PXIXr1orehcJ86epA39PMu8HxML5SFnM1K0OFwHkMT
	oH5r/VGUWg0S03U3XjZsuIAuMw1LEJs4BuTLWLs21mddWRZrveESi+GC6EWTGyKCo9x3we/u9Uh
	8Xu4EZXf2QdJQkwkbSLk5fAsDom1z1mCoqCK25WJhmoPkzLXTayhH8QZpYVWwLydZzaoTgiP3OR
	0giYDA1Ojdk+kyGLTtA58dl88ahKjYL9UNgkOFa/4UzcWqI6yKxf5kEmQyi+Wa2oWXM6FUU6Wz2
	R+WKPPZFaq0rnl/EpvTSCXCk7T5sutAeG5V/LKdNsjBib6J0ULPt8Yy9L/zEb7WsHWx7OPksCdB
	HMY/98Q1VXy6Sa8AZXNVDRz3x0PK6naSFFUQFKFt56jGoTBIthQ==
X-Google-Smtp-Source: AGHT+IG1Iz02Do8vk/OkUauhbzeE1XTOlKai6jAIc/dx9gUu7tjggesIQloqaLtajEfFQGe39i3EMQ==
X-Received: by 2002:a05:6000:400d:b0:3f7:b7ac:f3d2 with SMTP id ffacd0b85a97d-429bd6be4e8mr13062531f8f.43.1762248443219;
        Tue, 04 Nov 2025 01:27:23 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc18f41bsm3393650f8f.9.2025.11.04.01.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 01:27:22 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 4 Nov 2025 10:27:20 +0100
To: bot+bpf-ci@kernel.org
Cc: mhiramat@kernel.org, rostedt@goodmis.org, jpoimboe@kernel.org,
	peterz@infradead.org, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, yhs@fb.com,
	songliubraving@fb.com, andrii@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCHv2 2/4] x86/fgraph,bpf: Fix stack ORC unwind from
 kprobe_multi return probe
Message-ID: <aQnG-D8O8Jco9_4X@krava>
References: <20251103220924.36371-3-jolsa@kernel.org>
 <bb44afd60873d171a8482032e466d2827018486ecd13b4047df74632d2df4950@mail.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb44afd60873d171a8482032e466d2827018486ecd13b4047df74632d2df4950@mail.kernel.org>

On Mon, Nov 03, 2025 at 11:47:37PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
> > index 93156ac4f..b08c95872 100644
> > --- a/arch/x86/include/asm/ftrace.h
> > +++ b/arch/x86/include/asm/ftrace.h
> > @@ -56,6 +56,11 @@ arch_ftrace_get_regs(struct ftrace_regs *fregs)
> >  	return &arch_ftrace_regs(fregs)->regs;
> >  }
> >
> > +#define arch_ftrace_partial_regs(regs) do {	\
> > +	regs->flags &= ~X86_EFLAGS_FIXED;	\
> > +	regs->cs = __KERNEL_CS;			\
> > +} while (0)
> > +
> 
> Can arch_ftrace_partial_regs read uninitialized regs->flags?
> 
> In return_to_handler, the ftrace_regs structure is allocated on the
> stack but only a few fields are initialized (RAX, RDX, RBP, RSP).
> The EFLAGS/flags field is never written before
> arch_ftrace_partial_regs reads it:
> 
> arch/x86/kernel/ftrace_64.S return_to_handler:
>     subq $(FRAME_SIZE), %rsp    # Allocate ftrace_regs on stack
>     movq %rax, RAX(%rsp)
>     movq %rdx, RDX(%rsp)
>     movq %rbp, RBP(%rsp)
>     movq %rsp, RSP(%rsp)
>     # No initialization of EFLAGS field
> 
> Then ftrace_partial_regs()->arch_ftrace_partial_regs() executes:
>     regs->flags &= ~X86_EFLAGS_FIXED;
> 
> This reads the uninitialized flags field. Stack allocations contain
> garbage, so regs->flags will have whatever data was previously on
> the stack. The &= operation produces undefined results when operating
> on uninitialized memory.
> 
> For comparison, ftrace_regs_caller explicitly initializes EFLAGS:
>     movq MCOUNT_REG_SIZE(%rsp), %rcx
>     movq %rcx, EFLAGS(%rsp)
> 
> Should return_to_handler initialize regs->flags to 0 (or another
> appropriate value) before arch_ftrace_partial_regs modifies it?

yes, that was in the initial version [1] but Stephen did not like that,
so I moved the flags init to later where it needs to take into account
other callers (that have meaningful flags) and just zeros the X86_EFLAGS_FIXED,
so we go through !perf_hw_regs leg in perf_callchain_kernel

jirka


[1] https://lore.kernel.org/bpf/aObSyt3qOnS_BMcy@krava/
