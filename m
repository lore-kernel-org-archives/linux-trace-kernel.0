Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2450232786
	for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Feb 2025 22:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740524103; cv=none; b=lbw69EEDLw+DXjEkyCIf915gBJiiO+NF6DvTnONAg1W1lXgwvJP9z2vRvU8ZrpF5osIGV2AjrLyG/il1zXNI2SsZT/BdrsUWfHiBdzoYFkii3GbQU8XeVysImnwzKnfr3chf8cSpcCTZUyl7PdIyFEbXjGjkuW3TWGGVCBk2Ego=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740524103; c=relaxed/simple;
	bh=b7GE2WDSJ8erb2DRmKw664l9pESoplGUaVO7FPP4lP8=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=NlJuPP7SOqH0vHj7WkAqyTgm5bfMU83aUKUC6C4SpjHq/ypc8//pghGP9QrP31+cWPE1qP62hU1DkcibtX821rUe5/S66L7qWRWbrXomz2DXSxpxKdlxWRdeWKXJA3IfqdP0TeIBLkqjhQPzQS3OkYDto9LzGcrv0eSKTtYpuss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=Z09qg6/M; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="Z09qg6/M"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-220c8f38febso130057455ad.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Feb 2025 14:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1740524101; x=1741128901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eoxgd0LXqhYyoIs1TcxAsnvLmRYvl51fOK6HZwrhImc=;
        b=Z09qg6/MfsbPoF1aSZoQlg2H7xUhPjefiDOQjO8gpa2Lqh5KndyaQ9FoA5gTzFKk1d
         +7j8aL3Iwcrwyzlcx3Dgu1LzjUu57gVNIwCi0gfX8zli8bv1kMXJWde7/cECc/G7UspX
         nL9/o+8IiYEsVIohGvH76EaAvL/IbHTTGrCIo7wS8tfS+TriUJi2orYFDWZgYtiJnpQV
         rcq05FGC6yUzHYCYqu4l6MGU65qCqC1h7P2Elqu0f/0aYAZHPiW31+V7HqhyfidI+fbl
         ARGjydJdtIPrJA1yRi+Oia3CIzLqGfCVUmG+xDXNVcpHHwJBUlcpRaMGCSC/y8Z8E3wD
         OnEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740524101; x=1741128901;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eoxgd0LXqhYyoIs1TcxAsnvLmRYvl51fOK6HZwrhImc=;
        b=WkBz3M2NEYDZ4VziobpoWqptmrLznpFnIyMAO780eIC8h8FZl2ci9zUTDtH4a+fyPU
         WV3mjNvU6oCSDUHTaFCMvK6q7NZ2b/XWfTdEZY1nUxk32iQDPiu9d7J7n6Kl17/ibxeJ
         FI1E8Gpj3UdIcCgSKH4Og0bvkGW2NvnRllYaum5QDW6TLo5NBeGEK6xEleQ6ZZB7aYRd
         iLDn9otuUQS3ZGCfm9/vLoZut+Pdi2RNH34SGH4JQEAihONL6wmV9akPX+GuPONzMMQR
         X26avzKhkjLCNRR2b+pnKdRsdW1rPByx2pVIQEGs7h+x7VTP2aejLa12tuHrBJcMcYC6
         0eyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGlT/5yZ27w9pKMuh96DDk8RX2n78RpeZHkJJ60c+ikDyDHPM9e/nJY1MAm0cC8+GJ6i8enZx8pKRZpRA6JfuPkCk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1sS/GxIIz5U9Kq/PrxLiIxqKsbWvE490Jqz0d5gJcQifrhW3P
	lwupE/iFp1moe0S5l4F5D610a78i+NyHM0Bjpp9OnPuRKUUGRR35nGyivhTRRTA=
X-Gm-Gg: ASbGncsSXZInR8oRQZgBZp/qqChQFwvE3Mg9CMb2q0SJ2o93J6o/6MWgGQZvIqEeu2z
	XigffDQW/8vm5Hn+kNhMl6rfhJVWWh49MOsWo/rU3kkIimrVw1FFCTTXHQpoxnpeJCkhODiRIXV
	jVVMyDOxHvvjw7ygelp4m5QuWj7Rj8blCi17Iu8Tfj55RGGV1R6BS4wX9rjfoCzy6rnnWnkHwc+
	aCuO7o/s8boWeqEw/Y1Of0G6qiEXoF9UAWy+WlObDmSlUrY3TCdczKbMa+gO00kPkKl5yyehtEh
	4UYJf3E9XgzlN55tcbg=
X-Google-Smtp-Source: AGHT+IHDF0cWJ/SEBMVNAJOxihTtvNcg7f922v9D9w95rEqvhz8RZQiYleayAK1FRV0WuHL7CfLLPw==
X-Received: by 2002:a17:903:986:b0:221:80f8:99cd with SMTP id d9443c01a7336-2219ffb3badmr294881865ad.21.1740524101121;
        Tue, 25 Feb 2025 14:55:01 -0800 (PST)
Received: from localhost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a092fc9sm19662355ad.126.2025.02.25.14.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 14:55:00 -0800 (PST)
Date: Tue, 25 Feb 2025 14:55:00 -0800 (PST)
X-Google-Original-Date: Tue, 25 Feb 2025 14:54:59 PST (-0800)
Subject:     Re: [PATCH] riscv: tracing: Fix __write_overflow_field in ftrace_partial_regs()
In-Reply-To: <Z74DlyiSS75MrkqS@ghost>
CC: alex@ghiti.fr, rostedt@goodmis.org, mhiramat@kernel.org,
  Mark Rutland <mark.rutland@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
  oleg@redhat.com, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
  linux-riscv@lists.infradead.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: Charlie Jenkins <charlie@rivosinc.com>
Message-ID: <mhng-2350fde8-5ca3-4770-94d0-26582bdfc0dd@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Tue, 25 Feb 2025 09:53:27 PST (-0800), Charlie Jenkins wrote:
> On Tue, Feb 25, 2025 at 09:36:04AM +0100, Alexandre Ghiti wrote:
>> Hi Charlie,
>>
>> On 25/02/2025 03:42, Charlie Jenkins wrote:
>> > The size of &regs->a0 is unknown, causing the error:
>> >
>> > ../include/linux/fortify-string.h:571:25: warning: call to
>> > '__write_overflow_field' declared with attribute warning: detected write
>> > beyond size of field (1st parameter); maybe use struct_group()?
>> > [-Wattribute-warning]
>>
>>
>> I can't reproduce this warning with gcc and llvm, even when setting by hand
>> -Wattribute-warning when compiling bpf_trace.c (which is the user of
>> ftrace_partial_regs()).
>>
>> Which toolchain did you use?
>
> You need to have the configs:
> CONFIG_BPF_SYSCALL=y
> CONFIG_FORTIFY_SOURCE=y

I don't think I have any FORTIFY_SOURCE runs, unless they're on by 
default behind some other argument.  I'm kind of surprised this is the 
only bug we have, that usually trips up all sorts of stuff.

I'll go add some runs and see...

(I'm also going to just go pick this up, might take a little bit to show 
up.)

Thanks!

> CONFIG_FUNCTION_TRACER=y
> CONFIG_FPROBE=y
> CONFIG_DYNAMIC_FTRACE=y
>
> I used gcc 14.2.0
>
> - Charlie
>
>>
>> Thanks,
>>
>> Alex
>>
>>
>> >
>> > Fix this by wrapping the required registers in pt_regs with
>> > struct_group() and reference the group when doing the offending
>> > memcpy().
>> >
>> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
>> > ---
>> >   arch/riscv/include/asm/ftrace.h |  2 +-
>> >   arch/riscv/include/asm/ptrace.h | 18 ++++++++++--------
>> >   2 files changed, 11 insertions(+), 9 deletions(-)
>> >
>> > diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
>> > index c4721ce44ca474654b37b3d51bc0a63d46bc1eff..ec6db1162021fbf4fa48fc87e7984266040aa7d9 100644
>> > --- a/arch/riscv/include/asm/ftrace.h
>> > +++ b/arch/riscv/include/asm/ftrace.h
>> > @@ -207,7 +207,7 @@ ftrace_partial_regs(const struct ftrace_regs *fregs, struct pt_regs *regs)
>> >   {
>> >   	struct __arch_ftrace_regs *afregs = arch_ftrace_regs(fregs);
>> > -	memcpy(&regs->a0, afregs->args, sizeof(afregs->args));
>> > +	memcpy(&regs->a_regs, afregs->args, sizeof(afregs->args));
>> >   	regs->epc = afregs->epc;
>> >   	regs->ra = afregs->ra;
>> >   	regs->sp = afregs->sp;
>> > diff --git a/arch/riscv/include/asm/ptrace.h b/arch/riscv/include/asm/ptrace.h
>> > index b5b0adcc85c18e15c156de11172a5d7f03ada037..2910231977cb71dac3cc42f2dc32590284204057 100644
>> > --- a/arch/riscv/include/asm/ptrace.h
>> > +++ b/arch/riscv/include/asm/ptrace.h
>> > @@ -23,14 +23,16 @@ struct pt_regs {
>> >   	unsigned long t2;
>> >   	unsigned long s0;
>> >   	unsigned long s1;
>> > -	unsigned long a0;
>> > -	unsigned long a1;
>> > -	unsigned long a2;
>> > -	unsigned long a3;
>> > -	unsigned long a4;
>> > -	unsigned long a5;
>> > -	unsigned long a6;
>> > -	unsigned long a7;
>> > +	struct_group(a_regs,
>> > +		unsigned long a0;
>> > +		unsigned long a1;
>> > +		unsigned long a2;
>> > +		unsigned long a3;
>> > +		unsigned long a4;
>> > +		unsigned long a5;
>> > +		unsigned long a6;
>> > +		unsigned long a7;
>> > +	);
>> >   	unsigned long s2;
>> >   	unsigned long s3;
>> >   	unsigned long s4;
>> >
>> > ---
>> > base-commit: d082ecbc71e9e0bf49883ee4afd435a77a5101b6
>> > change-id: 20250224-fix_ftrace_partial_regs-eddaf4a7e5ed
