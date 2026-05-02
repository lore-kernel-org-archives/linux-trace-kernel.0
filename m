Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22726226D18
	for <linux-trace-kernel@vger.kernel.org>; Sat,  2 May 2026 07:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777707426; cv=none; b=DbilMwq6UbMNgSVwSs8yWy9wizuPGJ1aYHX0zrVXqaGiFLqqaWSpdGwj1hVrwgG3lSuFZ6axJso/I+xh7+k6LMQ310j0hMCxyFafX6rIK4W6CPBrSxHbBxjbNqeFMBS4ltybJs+I3E8Y3ZyBFxPR/xXeBh4KNEJPRQktEJ06arA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777707426; c=relaxed/simple;
	bh=OgSupQYuv8M08Z6lDFgcm93HWo22RmGCCbGaM/Spy+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MumCQbR93ayoBnD0JEhE7WkwDxPQnHAa93AI8MT55toiCYs9E3C6Jl1HHqLBNmRbaeNSVElc4Xw5+WcyThmRosk/AYbakqMqmDHRbWVnsQ745ZxYzvTpUVdClMl1Uj4dlOs30A+9We8YxY6nCZM4OtNPCBDywq7PblnEOtiD27s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FOczte+p; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOczte+p"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82fb2d0c5d1so2361192b3a.0
        for <linux-trace-kernel@vger.kernel.org>; Sat, 02 May 2026 00:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777707424; x=1778312224; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BHCOVHKhdHZ6jfgYD/72LtN/jBh0rvDnY8iDxuRsrAA=;
        b=FOczte+p+X76EKhDjgCbwc3Qsjo3COAILnKWg17ZUiHAy9tOb1b7iCZvH43gL1WEgb
         u9LZJzGbepyjyDTC7PwFDVG3CQr57RfqsEhz7YP6RtaSXg//cmmfy7n30ITTGPb65F56
         2Kx3cmMluohkbUBTz7vtXgpsv/Sls/480d4BGZNlGDXdZ1h0e+TVknGp7+G7aQwlOtMT
         hEuqL3mFp8Jskg2dxxnxIjeY9idsTA2wOgDNoqADoXh2EKK9sIf4V8FaqkS9gyDLUHrS
         hxmiT8sUByYHNQc71p5mFcHjNZgDipTXTHld91FEw543zzSExMBpJRKZNVFAEWkcWr6S
         wusQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777707424; x=1778312224;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BHCOVHKhdHZ6jfgYD/72LtN/jBh0rvDnY8iDxuRsrAA=;
        b=p3JTkjadnDkPByBEb7FEr4hV86BinU+JptdQRArqP5BTtdUY5mjdCB9Fj6QhS8/489
         AgcpzloZlDGF5Q2Lhdp7A4WAvImzCNcZTvVQMUdR5Aoo2HQ20bs2VqUAbsiHjhPfP5xs
         3ihBrIY/+3HOKDJq4YL5SXXPg/8y1Xt5zQwWkBGTy3fPtMscr7qA7gZhVlV+EwbggXnq
         ymJVcLEM/fPn6MoB+tgRKRMVFFVgs0xFBU8UP2Pw9N3NO6v/MrkgfR1ip3GpUETyzWGJ
         Zm4LH6U6hH3tnGT+/57NgmIUaIij49sw0Ah7eCvyLjZXFqx1W8GQhTWNELnhJqb5Lwbj
         272g==
X-Forwarded-Encrypted: i=1; AFNElJ/Ay7ElgWs7nFfazyuQMhc0aG4E4hp1CsZL51p007Q5U3QomsV4rl2hmT6luMMmp+KOPmxiC4hK47czr3aM8foSq4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBhRwgEcaU6DKS+p0w2AmrH0s/awdy5h6A04wRaBHM/dRh2xwI
	o1jRQmRL+NeC6hteIPYxhEyhtW29xaajrriUFlq/DKnuzlF+y2ZxoQhJ
X-Gm-Gg: AeBDieugVyHS2HRxva6V9rEaBsgnQAQ065+Am6SeIq1uKeTHMlUgyyoIwSLy6+BhEZO
	9Nq0KbZmgdoaYFEFXh53UTMUs/A/2PoBRAhi5ImhZ0boEATb4HjCOTutRqXvD+JqaRP7Bt/lIx8
	ouLHXleeV72ybsj3oS//muPHrERvKiIAOgI/YMo3VLzcFRVZ69bKD3Ha26cJw2ApKD5rYlfCeMY
	Lrlw6NcJ0r2Px0mDBH34n2yNOtj0RBCa+fkpP0ojSDpmU9x8YAlj9EpDqRWOYw0sL0HtwllLwfk
	FOr+Q43dSc3kezyGEK+DC64PGJkWei7L/eyswKTQFqg0fnTg/xOVAnRbWINsbafjKE47xf7RYQK
	XTcxSZ0UIWe3RqWDEQ3DaIUkbL0ujR6dQrYvqHAWF9ZWN3QrX32Af3q+IPFPmmBLcJyUm5TOwf1
	0haIdSFQGvyw/OVca9Xle6AOxKttpXiA==
X-Received: by 2002:a05:6a21:1405:b0:3a2:cf6d:aa04 with SMTP id adf61e73a8af0-3a3d1b443efmr9564744637.8.1777707424386;
        Sat, 02 May 2026 00:37:04 -0700 (PDT)
Received: from nova ([134.208.63.146])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7ffbc6f66dsm4055562a12.15.2026.05.02.00.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 00:37:03 -0700 (PDT)
Date: Sat, 2 May 2026 15:37:00 +0800
From: Qian-Yu Lin <tiffany019230@gmail.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] trace_printk: replace _______STR with __UNIQUE_ID(STR)
Message-ID: <afWpnEWYZyhxy7-i@nova>
References: <20260429165707.7020-1-tiffany019230@gmail.com>
 <20260429134226.49e95e9d@robin>
 <afS7UUAfzgiSzEHv@nova>
 <20260501221315.1f709d6d@pumpkin>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260501221315.1f709d6d@pumpkin>

On Fri, May 01, 2026 at 10:13:15PM +0100, David Laight wrote:
> On Fri, 1 May 2026 22:40:17 +0800
> Qian-Yu Lin <tiffany019230@gmail.com> wrote:
> 
> ...
> > Yes. I measured compile time of kernel/trace/ring_buffer_benchmark.o
> > after make clean on an x86_64 machine running Ubuntu 24.04 LTS:
> > 
> >   - Original _______STR:                 49.8s
> >   - v1 with __UNIQUE_ID (compiler.h):    53.5s
> >   - compound literal (no extra include): 33.2s
> 
> That difference looks far to big to me.
> And the times are far too large to be measuring the actual compile time.
> 

You're right, my earlier measurements included dependency rebuilds
after make clean. I re-measured using touch to isolate the actual
compile time of ring_buffer_benchmark.o on x86_64:

  - Original ___STR:                        1.757s
  - v1 with __UNIQUE_ID (compiler.h):       1.836s
  - sizeof __stringify (your suggestion):   1.781s

> > 
> > I propose using a compound literal in v2, which eliminates the local
> > variable entirely and requires no extra include:
> > 
> > #define trace_printk(fmt, ...)                          \
> > do {                                                    \
> >     if (sizeof((char[])                             \
> >         {__stringify((__VA_ARGS__))}) > 3)      \
> >         do_trace_printk(fmt, ##__VA_ARGS__);    \
> 
> There has to be a better way to align that code.
> Although you should be able to use:
> 	if (sizeof __stringify((__VA_ARGS__)) > 3)
> (I've omitted one set of parenthesis for clarity)
> 
> You could change __stringify() to work with __VA_ARGS__ the you don't need
> the extra (); this works fine:
> #define _x(...) #__VA_ARGS__
> #define x(...) _x(__VA_ARGS__)
> #define z abcd
> int a = sizeof x(z, v); /* 8 */
> See: https://godbolt.org/z/zo4h4nr9b
> 
> -- David
> 

Yes, this works. I verified with objdump on the
samples/trace_printk module that all four cases branch correctly:
__trace_bputs, __trace_puts, __trace_bprintk, and __trace_printk.

I'll use this form in v3 since it's simpler than the compound literal.

> >     else                                            \
> >         trace_puts(fmt);                        \
> > } while (0)
> > 
> > This fully eliminates the shadowing risk without any compile overhead.
> > 
> > Qian-Yu
> > 
> > > 
> > >   
> > > >  #include <linux/compiler_attributes.h>
> > > >  #include <linux/instruction_pointer.h>
> > > >  #include <linux/stddef.h>
> > > > @@ -84,15 +85,18 @@ do {									\
> > > >   * let gcc optimize the rest.
> > > >   */
> > > >  
> > > > -#define trace_printk(fmt, ...)				\
> > > > +#define ___trace_printk(fmt, str, ...)				\
> > > >  do {							\
> > > > -	char _______STR[] = __stringify((__VA_ARGS__));	\
> > > > -	if (sizeof(_______STR) > 3)			\
> > > > +	char str[] = __stringify((__VA_ARGS__));	\
> > > > +	if (sizeof(str) > 3)			\
> > > >  		do_trace_printk(fmt, ##__VA_ARGS__);	\
> > > >  	else						\
> > > >  		trace_puts(fmt);			\
> > > >  } while (0)
> > > >  
> > > > +#define trace_printk(fmt, ...) \
> > > > +	___trace_printk(fmt, __UNIQUE_ID(str), ##__VA_ARGS__)
> > > > +
> > > >  #define do_trace_printk(fmt, args...)					\
> > > >  do {									\
> > > >  	static const char *trace_printk_fmt __used			\  
> > >   
> 
