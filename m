Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4264B19B3CB
	for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740506015; cv=none; b=LECxCVRyBjQOWI87susegiqQ2dGFRUqQL7iPKfSX9d3TmNl92b3aTVQw7mwZ0mliCGXAMliKUx2s7Tp6HVKoc3PBpj4w+raiFZi3pofx5EIinFKwTCC+rhBC+QU9FQfdG1fCtcan51YthM2Saqx4aU7Li5y2CwdeBoxhtp2HQw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740506015; c=relaxed/simple;
	bh=MH07qjLZ92AfV112Knvo2zI/QK4I2MXbywwIDal1d54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFQJSrPK5A4v3wyykll7QHHoXIOxnk6fk8lzgxlvAB+6AmP2i3+TXSHwsLDRuP1JzYjPW2auk/kPTl+g6hCtncpkjBODhSk2r3GAjbSgS+SDTBe78FUgjHd85FxqhBuo3vnJfRIoMsUKJu0oyCTtlDffHBwLby74Kn5L2IuUq9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Q7YzJwdx; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Q7YzJwdx"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2fc0bd358ccso11772699a91.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1740506011; x=1741110811; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M8ytOcimcOajPMmPbmHJ20XRT2ET7W0PdZC0CAWsNrs=;
        b=Q7YzJwdxpNNGG7rEOi38zlyjQJp7g2wUDGdhHQweNiu8FbOyuXI4yqmlQOyIJDzp9l
         26b4of9HRlLUkYF0tIY6BwM6rVOMjL0bYakUDSmsic5xKO4aZn75GbB8nqJv46FCFkJv
         O7YgbRdYXfqd8JnHi9WhFfaNaXZ05Jm/Xi6H9ZAWMfpSbe5oeX43p+FDwHVqrZfLBvk1
         Q0/fuN7MKXEcAo2Y16bEE3aVKAnNNxuomOLXyzz1Y2ifcdqkgO+5W49AZ61CSp98US4U
         3FyGxgA0s5eIz4/EaYGFYJwpIUGC3BTNTQ3nMTP6kwmrxHSxnRrCy9Bdp5XnpyrcDDqk
         wDBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740506011; x=1741110811;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M8ytOcimcOajPMmPbmHJ20XRT2ET7W0PdZC0CAWsNrs=;
        b=YOdSQlsl0TWgNentYygr5eP/AZBSCMgOVUlx9qmMT6qbRNhwDsWmKd0lR04FngkMGX
         5Y/6BaMsAoVEK1ZoQaN8dUv9Bw8hfqO87tHyLe+TpKnvoDcIbqc7NfPaNu0ZTaieP49w
         +5oByc0W8UxNsts5M8x3m/qkrfsLtNiaa2LEWAWlbD1eiVnmMnM+lnrZo4btQRvcwUBe
         SKpSVIvqUyqcODnlopZUEzQ4o8F9s56Gv4nH82r2BZPT0OAMJxBG3A1U1Btbs/mfB0OA
         eavfCwEij9HhP1jS8HSxlA3kM6cLK6B/ctbPHdtwRODkNeZBTLsUnoTSWLVKuZTke/3+
         w6dA==
X-Forwarded-Encrypted: i=1; AJvYcCUkhDY020SGbT1QEpbR4U5goEGlzNDS8YTLer2jfEEbw/2KUMq7ZGz/H3xErFCn+RZUuw+Y1VRPlowUOn39NbP+KkA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnNlwcnYYkflPo42s72d+nbaqI2T1CpZZnyn8I6ST/2PEAjrO5
	7W3AWDm5eZwI/IaB5vaJFYcRh6lAeBwxnv2MEDxX3sr/UdTQRzvGebJ7p5efREI=
X-Gm-Gg: ASbGncurkyINJHOv35CYB6ZkaTUxivqJdVoiILwNQziSG8K5ziG0yX+TasqjMcYdxcp
	+MXsWzF63XKmJKXZ+IezgqU62z/xAd8QoluYxevnxavXfWJ3iJuUfHG6715AmFsmekobh31Vsxu
	VIpkzWCPn72l8RJpCN8ykQ4iZ+DebodCYUu4JMOx9v87dFwhxy4Xu5CAZiDyrk8KBjefKJPEIeJ
	9KC7T42PdYJZoaRiucnITYsPTFKOoWxmlGD9oTO04ULjthwpUoXyx8Epqsxy22FWsyZ3TWAT6gP
	p1SAXoOVV2huHZ9I
X-Google-Smtp-Source: AGHT+IGE1vlRW/ZqwQ5Dzm1smcnQLurLLpTK4sP2+b5ghrhOvAR+GUgf0qQALw30DxM3WGJrzHgVQQ==
X-Received: by 2002:a17:90b:54c7:b0:2f5:63a:44f9 with SMTP id 98e67ed59e1d1-2fe68d065e9mr5651684a91.23.1740506011483;
        Tue, 25 Feb 2025 09:53:31 -0800 (PST)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fceb10fb43sm8709371a91.35.2025.02.25.09.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 09:53:30 -0800 (PST)
Date: Tue, 25 Feb 2025 09:53:27 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Oleg Nesterov <oleg@redhat.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH] riscv: tracing: Fix __write_overflow_field in
 ftrace_partial_regs()
Message-ID: <Z74DlyiSS75MrkqS@ghost>
References: <20250224-fix_ftrace_partial_regs-v1-1-54b906417e86@rivosinc.com>
 <b449aacb-f981-4907-af37-1ca5aea83bb4@ghiti.fr>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b449aacb-f981-4907-af37-1ca5aea83bb4@ghiti.fr>

On Tue, Feb 25, 2025 at 09:36:04AM +0100, Alexandre Ghiti wrote:
> Hi Charlie,
> 
> On 25/02/2025 03:42, Charlie Jenkins wrote:
> > The size of &regs->a0 is unknown, causing the error:
> > 
> > ../include/linux/fortify-string.h:571:25: warning: call to
> > '__write_overflow_field' declared with attribute warning: detected write
> > beyond size of field (1st parameter); maybe use struct_group()?
> > [-Wattribute-warning]
> 
> 
> I can't reproduce this warning with gcc and llvm, even when setting by hand
> -Wattribute-warning when compiling bpf_trace.c (which is the user of
> ftrace_partial_regs()).
> 
> Which toolchain did you use?

You need to have the configs:
CONFIG_BPF_SYSCALL=y
CONFIG_FORTIFY_SOURCE=y
CONFIG_FUNCTION_TRACER=y
CONFIG_FPROBE=y
CONFIG_DYNAMIC_FTRACE=y

I used gcc 14.2.0

- Charlie

> 
> Thanks,
> 
> Alex
> 
> 
> > 
> > Fix this by wrapping the required registers in pt_regs with
> > struct_group() and reference the group when doing the offending
> > memcpy().
> > 
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> >   arch/riscv/include/asm/ftrace.h |  2 +-
> >   arch/riscv/include/asm/ptrace.h | 18 ++++++++++--------
> >   2 files changed, 11 insertions(+), 9 deletions(-)
> > 
> > diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
> > index c4721ce44ca474654b37b3d51bc0a63d46bc1eff..ec6db1162021fbf4fa48fc87e7984266040aa7d9 100644
> > --- a/arch/riscv/include/asm/ftrace.h
> > +++ b/arch/riscv/include/asm/ftrace.h
> > @@ -207,7 +207,7 @@ ftrace_partial_regs(const struct ftrace_regs *fregs, struct pt_regs *regs)
> >   {
> >   	struct __arch_ftrace_regs *afregs = arch_ftrace_regs(fregs);
> > -	memcpy(&regs->a0, afregs->args, sizeof(afregs->args));
> > +	memcpy(&regs->a_regs, afregs->args, sizeof(afregs->args));
> >   	regs->epc = afregs->epc;
> >   	regs->ra = afregs->ra;
> >   	regs->sp = afregs->sp;
> > diff --git a/arch/riscv/include/asm/ptrace.h b/arch/riscv/include/asm/ptrace.h
> > index b5b0adcc85c18e15c156de11172a5d7f03ada037..2910231977cb71dac3cc42f2dc32590284204057 100644
> > --- a/arch/riscv/include/asm/ptrace.h
> > +++ b/arch/riscv/include/asm/ptrace.h
> > @@ -23,14 +23,16 @@ struct pt_regs {
> >   	unsigned long t2;
> >   	unsigned long s0;
> >   	unsigned long s1;
> > -	unsigned long a0;
> > -	unsigned long a1;
> > -	unsigned long a2;
> > -	unsigned long a3;
> > -	unsigned long a4;
> > -	unsigned long a5;
> > -	unsigned long a6;
> > -	unsigned long a7;
> > +	struct_group(a_regs,
> > +		unsigned long a0;
> > +		unsigned long a1;
> > +		unsigned long a2;
> > +		unsigned long a3;
> > +		unsigned long a4;
> > +		unsigned long a5;
> > +		unsigned long a6;
> > +		unsigned long a7;
> > +	);
> >   	unsigned long s2;
> >   	unsigned long s3;
> >   	unsigned long s4;
> > 
> > ---
> > base-commit: d082ecbc71e9e0bf49883ee4afd435a77a5101b6
> > change-id: 20250224-fix_ftrace_partial_regs-eddaf4a7e5ed
