Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E65639524E
	for <linux-trace-kernel@vger.kernel.org>; Fri, 16 Jan 2026 16:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768581007; cv=none; b=D053WIR8cNImXhZ72cUyJRJ31Yxmrx73WHmKYuAtRTwEuzDSOCFt2Zv3LFTJMNhYeUl+50kuQckoppeIfvTSSm3lV5/agaYRPpnBHvtlYaioIxmehrVWmHplokieDOIs/VvWG0iZ3jUcAafYSzFo+hD9SYsUNy0YAtzbq1d4k8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768581007; c=relaxed/simple;
	bh=vqAtTeNWt3JMsiSmpuFstThHQ/fLKkzmuvRKV8eEXAM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FDpSA+Ykmhk7Fu44/j91a3IkGJ+7XkHgS1465cb1Fs7WNOQ8oKKWrK/hqXRsK+EtMFYl4Ltcl9moo/UY3c6f8xOiXPnVH3Oah/JeZGmwEDV5oBDLKKr0Qfj9T6ZSp2EMsBXM7LPkV2ZdPEGxxvwubO9OhtS6QxLpGPcvLUaVKMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJ4KCFkY; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJ4KCFkY"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4801eb2c0a5so7797715e9.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 16 Jan 2026 08:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768581004; x=1769185804; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SRhP8YQ5SRdHis3aow3C5p57lTyMCB7HNXIP4SvzJMY=;
        b=EJ4KCFkY4E58842ryfjumr68rgQszyD3rKBBWA+c4BJksdzCddSr5GKn29WtCyXKHS
         CK/J+IeE5Y3o9A+9ybt6NMFk1k7WtG/cB1RkvMxFNqYSjhsa3Kg8NUW2StwT6SSQ4xvV
         XisHQX/1lzpOTEoFB1jonJVnnJyIFYvtKZrH/CtmQgYbKikQ87tLnFwyUeTWxFCMJDD7
         cDCljw5a0BVCkvbRaddX2xWUY92mey325I48oJ3Zocpyq+8RguQS7JX2JmV5tOch4gCe
         sHZeFc+ZiNcl2KrxdolN+ypiRMiz3VkGDuRtyXibYRxUVNtrfOXRlmaU0ljiPIn8nZee
         haNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768581004; x=1769185804;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SRhP8YQ5SRdHis3aow3C5p57lTyMCB7HNXIP4SvzJMY=;
        b=X7jPqDqrvh08dig2DyYktfwsr6/Kj4Y2b7/LY0nPKg10SJZcuj0XqSGv9fIrA+QgFf
         n95ag1KX0+EJ3oi52rD5EuvA2v4WpfkVFm5Zi/guU7A3q9WEZeZrUA2Zvsqw75yLtZaZ
         fRs60pWdW4PqFmPntCflaNqMQIafTJtIqOnkObNN8KAcqOttNQuIqym4P4FNGH6HoB+u
         QAmFQceCVzGG9JCYee3Rsv2D2DOPCw8hhyV4wfMOxADhardmrWyyDUL0uDhUN/dC20Pw
         7rfk45OTPHQjuer+l78373aoejefnQ6zWTfnEt2xdGp2jBYozVBXrfWtetlK2jU9sFBP
         EJng==
X-Forwarded-Encrypted: i=1; AJvYcCUpfRwg0m+0E7Qp7lR8sAuA7tnkxy0LGfUPK8FRhyxS5DNGd13mvkpcSHDveaitE7qb9nyKzLbHid8oEiZfkHj5vSw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8VqVPuANZIxYOPUBI2MmW3AlnXmFX3axj+5o+ZDeQjO16/zpI
	u7Ocuwwur3CLS8061wl1v73SkuL/nwVeVd0iLaeiNRaXBwPrDp+sKS3s
X-Gm-Gg: AY/fxX4xrX4m4vmfAHDLw/FAFZg6dMxJDoUD1qeNQEntAa5ywzp5RMvpIxVznI9Vg7U
	QvemtZd5A2Omtk9RS2OAQDmwBiLcmvi+9PokJZg+IM08llaHoTEmWcpn445dIbAiyyWn1N/qPTY
	yocKYr0vBiGKYrpT0oo6uKsZnLbs7L0WTB3t238FPMzPuEe181i0SzKSDGoJayBfIBdOwkbcGYr
	yQYJmKVJd76LHIk9l6LLEpmCMoz3PsUePpWDEgbhY1rGAruJjxQ8tyH4WIgzcaCjdhgLXqdSGiP
	kf5AiNh7CIe2cgI+gtEtTBYA/RU7xYkEhhb+v3TZKf2T0hL257JnzB6WtacM5hph3CtLW/VB4vu
	7MEFwxXeJthI6YhZcTZXyPNQRBUDxmOa/5WFS06z/reqxSMhnS81NN7mHvMgvBECf0wkp5lPPxo
	P2Tn8LFlI6l18Tpg==
X-Received: by 2002:a05:600c:4586:b0:477:9ce2:a0d8 with SMTP id 5b1f17b1804b1-4801e29edc9mr45785855e9.0.1768581004338;
        Fri, 16 Jan 2026 08:30:04 -0800 (PST)
Received: from krava ([2a00:102a:400f:3ccc:ffd6:980:bac0:cb06])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e80c477sm62954615e9.0.2026.01.16.08.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 08:30:04 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 16 Jan 2026 17:30:01 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	Yonghong Song <yhs@fb.com>, Song Liu <songliubraving@fb.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: Re: [PATCH bpf-next 4/4] selftests/bpf: Allow to benchmark trigger
 with stacktrace
Message-ID: <aWpniVM2NKteJaA5@krava>
References: <20260112214940.1222115-1-jolsa@kernel.org>
 <20260112214940.1222115-5-jolsa@kernel.org>
 <CAEf4BzaXhGpkycs-TO_1V81-irq3d8Mjfyk=LMc0OC-NW-FnRg@mail.gmail.com>
 <CAEf4Bzbn-Sai+pnC1Gu-E-uhJeSA8g-6xB49bswdPFpJd92Rng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bzbn-Sai+pnC1Gu-E-uhJeSA8g-6xB49bswdPFpJd92Rng@mail.gmail.com>

On Thu, Jan 15, 2026 at 10:50:13AM -0800, Andrii Nakryiko wrote:

SNIP

> > > diff --git a/tools/testing/selftests/bpf/benchs/bench_trigger.c b/tools/testing/selftests/bpf/benchs/bench_trigger.c
> > > index 34018fc3927f..aeec9edd3851 100644
> > > --- a/tools/testing/selftests/bpf/benchs/bench_trigger.c
> > > +++ b/tools/testing/selftests/bpf/benchs/bench_trigger.c
> > > @@ -146,6 +146,7 @@ static void setup_ctx(void)
> > >         bpf_program__set_autoload(ctx.skel->progs.trigger_driver, true);
> > >
> > >         ctx.skel->rodata->batch_iters = args.batch_iters;
> > > +       ctx.skel->rodata->stacktrace = env.stacktrace;
> > >  }
> > >
> > >  static void load_ctx(void)
> > > diff --git a/tools/testing/selftests/bpf/progs/trigger_bench.c b/tools/testing/selftests/bpf/progs/trigger_bench.c
> > > index 2898b3749d07..479400d96fa4 100644
> > > --- a/tools/testing/selftests/bpf/progs/trigger_bench.c
> > > +++ b/tools/testing/selftests/bpf/progs/trigger_bench.c
> > > @@ -25,6 +25,23 @@ static __always_inline void inc_counter(void)
> > >         __sync_add_and_fetch(&hits[cpu & CPU_MASK].value, 1);
> > >  }
> > >
> > > +volatile const int stacktrace;
> > > +
> > > +typedef __u64 stack_trace_t[128];
> > > +
> > > +struct {
> > > +       __uint(type, BPF_MAP_TYPE_STACK_TRACE);
> > > +       __uint(max_entries, 16384);
> > > +       __type(key, __u32);
> > > +       __type(value, stack_trace_t);
> > > +} stackmap SEC(".maps");
> 
> oh, and why bother with STACK_TRACE map, just call bpf_get_stack() API
> and have maybe per-CPU scratch array for stack trace (per-CPU so that
> in multi-cpu benchmarks they don't just contend on the same cache
> lines)

ok, will change

thanks,
jirka
