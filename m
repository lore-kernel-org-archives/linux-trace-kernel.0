Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29F33F075A
	for <linux-trace-kernel@vger.kernel.org>; Mon, 25 May 2026 15:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779723850; cv=none; b=JLmmOQCxxndT8MgZQjDeqWo6Wx90cAJtvBdh3EmmIGYlYPbVKUIPIaDg+FTdFhK5NaYAttHLl4BmDNs694sqtL/BcCoU7uBPDc4PomtlyOPqtoU40OD6QNAgsg7pKDB4BvuspwcfHpUda2QvNxpv+J1RYtinc20rutb013AwGp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779723850; c=relaxed/simple;
	bh=PeRv/zuBKjklDXbHAJvShctHzya75FZlIB0CwBE4aCI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mH+RuDGDzqiFtJZxsnnefYF9rapGTHHVWogTWe5jULwhSfc7bO5fv/x3ZYumvPWLY5sh6FjmYlV0OmGuKGuOesDFXWp+xAz4tdwM/Y5WLoZOpeZ+ysKoIe/0kum5Ebsn7kfPo3WOK6EDka4oomvtawR/Y8EUanr0OmIEM2Dep38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qwdnQiW/; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qwdnQiW/"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49040362e4aso40068445e9.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 25 May 2026 08:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779723847; x=1780328647; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3GuX/N/jM1mRTztcavrKb/7VNbwxABT+aEEn/gD5Zek=;
        b=qwdnQiW/r+CH2PkUUKKGZM9I9OVv4WqELRpiOjntfia9P2MQDIOLRvQwWh88GzqSle
         tpeXIb9kmWqCmzQIpHOL/a7tTVhYAX366aogTbhN/F1fQdiX859EMk4J7vNBvdwGJZoP
         WbpCcmTopi5weITlfagP8hXPzVSpZ55F2ieW9UY2GlIct3r2NcIIXqro0uDFH/8GLIL1
         PVw7n/+AdP+t4Th75eO8etWOoSxhFExFGwWeSqfNpbaKcMqI0v/P+O7vWNr0LHsSfL2U
         GKl56smdk8YmfbPigyRVav+LzMF2kIlF1intgKIdIS+sCWZrBhEp2roAIm/t0algS+LX
         VbmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779723847; x=1780328647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3GuX/N/jM1mRTztcavrKb/7VNbwxABT+aEEn/gD5Zek=;
        b=fF8w2RH0XiP5HhovJkV+A1qbN/lvz7E+juLEb7mXGLx3+bZuJTotaRPXz2/a4n9T2j
         awQ35w/cDBoQ5ZjHUxwkPDkkMleQ1nS0iD80mvgcKBFuXcx1HmbS/KmKPPxBfy7iMUgA
         iLsrYCwnPOSI999TGXE1vYQU0gxN+oSCBLhQZ/4P7BDI0H0siQVnM4TLcafyNVnQ5AWm
         YItBjM6gGSDNLTR/Cp9u8s1m/dNeR700gUXN9NFnlLzTtfaE2pVMe47mPTZF4TUZOrNV
         Lw9HxvEZZ+wr29nghK2N7Jr0KdKiYye0MhgP+fMJtsbj9umpfUllVE/wDYGMwJ1vTyZ5
         JhxA==
X-Forwarded-Encrypted: i=1; AFNElJ+hwaccIT5f2UAoImI4MqR66B5iGz3vLyN6pGtGh4klf+vTRgp1BlpUXtm4wnwIqQ8MciocsUt4prsyq8pMiSbSLqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoiwHksvK3eNtzbqpNND/VGlDctSksOan0HBy9hZcwgYsPZ8HJ
	oxYjgPdO6QEQ+BLlChaZl7kNmxLELMoXhZ5rka/4feq7kSyV9YhjJEeh
X-Gm-Gg: Acq92OH2XXFJJKkY48n69kpkPqGatXpa5wlCe/MonPHs6ijWu7AEOTSwwKAazhaGRwv
	UjSmJLSAw5uel5QB1AKe2wcyDVs8pV7O2MKv+ypK6rLaWWxEw2YOcskL1LbfBVCo0TevUfmctQc
	sPQuuRvgEJSB8dilzDrVwFP6dbX3kDw8pq0ciHftD2kInU8wno96HCwGfxFjDklem5DTJROTAtf
	4B0rrbZh2Mbb00ph1N7SBh+akVbEuJMDcE9i8eNYqRRZa6cH7TGSP0qYV8BHYI+G6GkJIY7A28B
	5ZG/se+9cMXG6e/uwRSXW21YMpzksM3pWdIPlJR+8p3WN8e1kD1+LqwfKHqVGLlC/aD6RQubuIq
	/O5/hWa0YanErRpD8TP2IXTmBbpJ5vB0e6qPw1gYQoOyVXpNDi9DJdJODb8Ir50pVklyiIlNLtH
	VtEpxSid6Hxd8=
X-Received: by 2002:a05:600c:8484:b0:488:7ff6:1f75 with SMTP id 5b1f17b1804b1-490426cda54mr269295035e9.21.1779723847013;
        Mon, 25 May 2026 08:44:07 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490428ec538sm86946705e9.23.2026.05.25.08.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 08:44:06 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 25 May 2026 17:44:04 +0200
To: bot+bpf-ci@kernel.org
Cc: oleg@redhat.com, peterz@infradead.org, mingo@kernel.org,
	mhiramat@kernel.org, andrii@kernel.org, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCHv3 11/12] selftests/bpf: Add tests for uprobe nop10 red
 zone clobbering
Message-ID: <ahRuRPmrKdrDjOnP@krava>
References: <20260521124411.31133-12-jolsa@kernel.org>
 <7773c27d0070aa7544a5a7596aceb8abacb4fbdb20a3aab998f05c39de4f20dc@mail.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7773c27d0070aa7544a5a7596aceb8abacb4fbdb20a3aab998f05c39de4f20dc@mail.kernel.org>

On Thu, May 21, 2026 at 01:26:07PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> > index 969f4deba9fd..efff0c515184 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> 
> [ ... ]
> 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c b/tools/testing/selftests/bpf/prog_tests/usdt.c
> > index fda3a298ccfc..8004c9568ffa 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/usdt.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
> 
> [ ... ]
> 
> > diff --git a/tools/testing/selftests/bpf/progs/test_usdt.c b/tools/testing/selftests/bpf/progs/test_usdt.c
> > index f00cb52874e0..0ee78fb050a1 100644
> > --- a/tools/testing/selftests/bpf/progs/test_usdt.c
> > +++ b/tools/testing/selftests/bpf/progs/test_usdt.c
> 
> [ ... ]
> 
> > diff --git a/tools/testing/selftests/bpf/usdt_2.c b/tools/testing/selftests/bpf/usdt_2.c
> > index b359b389f6c0..5e38f8605b02 100644
> > --- a/tools/testing/selftests/bpf/usdt_2.c
> > +++ b/tools/testing/selftests/bpf/usdt_2.c
> > @@ -13,4 +13,17 @@ void usdt_2(void)
> >  	USDT(optimized_attach, usdt_2);
> >  }
> >
> > +static volatile unsigned long usdt_red_zone_arg1 = 0xDEADBEEF;
> > +static volatile unsigned long usdt_red_zone_arg2 = 0xCAFEBABE;
> > +static volatile unsigned long usdt_red_zone_arg3 = 0xFEEDFACE;
> > +
> > +void __attribute__((noinline)) usdt_red_zone_trigger(void)
> > +{
> > +	unsigned long a1 = usdt_red_zone_arg1;
> > +	unsigned long a2 = usdt_red_zone_arg2;
> > +	unsigned long a3 = usdt_red_zone_arg3;
> > +
> > +	USDT(optimized_attach, usdt_red_zone, a1, a2, a3);
> > +}
> 
> Following up on a review comment from sashiko-bot: is this test reliable
> across different compiler versions?

Andrii replied this one in the original post:
  https://lore.kernel.org/bpf/CAEf4BzZ-nASpoF+-vLYZ1D8eWRVd5JWAuhrwx8XZNrX7ZPY5_Q@mail.gmail.com/

jirka

> 
> The x86-64 USDT macro uses the "nor" inline assembly constraint, which allows
> the compiler to allocate these operands to CPU registers. Because there is no
> register pressure in usdt_red_zone_trigger(), modern compilers might allocate
> the local variables a1, a2, and a3 directly to registers rather than the
> stack's red zone.
> 
> If the operands are placed in registers, the uprobe CALL optimization
> clobbering [rsp-8] will not corrupt them. This could cause the test to pass
> even on buggy kernels, creating a false positive.
> 
> The author acknowledged this concern but kept the test as-is, noting that
> selftests compile with -O0 and there's also an assembly-based test.
> 
> Would it be safer to explicitly force these operands into the red zone using
> inline assembly constraints, rather than depending on the compiler's register
> allocator?
> 
> Reference:
> https://lore.kernel.org/bpf/20260509021238.AE98FC2BCB0@smtp.kernel.org/
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26227520868

