Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A67228D858;
	Thu, 22 May 2025 15:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747926004; cv=none; b=lKfbdjwc1yrmN71GMWYmGFNtEEPK1SmE25JasvYGIwSHCK7LQgusBrPhQcM6AYH2Vx1/XCGmZ9RhbS6v0HoYFsTXVGewx3sqEUPNhbq3DYL0UGNFbVa7ajEJpB9zoPjqTAUCh+Jx76unxBvEgFKWna7Vjnhh1tTAQHnGJkTEK0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747926004; c=relaxed/simple;
	bh=QyXHdsbPMAnYWpMP4HzJCUjWBiH7pUfZKz+6024A3jk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=siFOAJED0CrfBdy/34w+O+6r5herY5fsn5fhqUXnJKaNyacS0kmyx2NR/XaKVkPLZiPCsOHdoZpsMg9wpgRiqWiDXqSZJQSc2CC+5upaBDzrgU2ky9FBR8mLQRaMhtYAxXFuEnYbGBOfFiHwKjCyt9wqEcIoezdPn7C1/GFuSvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hBfHL3AQ; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBfHL3AQ"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3293da06120so8499801fa.2;
        Thu, 22 May 2025 08:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747926001; x=1748530801; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3PzOxk6N7900Qw0GLki2Q+7lBECuGYSk9c5WiInesAc=;
        b=hBfHL3AQ/+05blKUWUDfm+Gac+aD3a2RIjhurTMujVXmExZ7N3ULZBl5qSZiiFh3u9
         au/FwJjamvhdUG5GJOdEFTpNokS0nfW37+ixjooPOuk86NKqt2kaHeHasbXDXEK3hSaK
         nMzpTEUaHYrEDDd70KVU9/YtQUG4E0PoiBU7CLu/W8u/AgqhRUsg/kYKg4wg6zh0dMMq
         DFyWHJESvewKoDXeuHxFW0YSWuFO+q4Z5A1+CQolYYEoNC9El67EAMws227Y0N2yMlFL
         XbPiQevk0Me4oXUQmDGX2+MEvAYFaNtB9/c1NdSbbR/cEe3OcjgLAYoZw9A1XYLMB7Go
         GmKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747926001; x=1748530801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3PzOxk6N7900Qw0GLki2Q+7lBECuGYSk9c5WiInesAc=;
        b=XYXK0XLES9ICdhGMkD6VNERJo17a8VELtO+D4VSEG4UZcZ6ibYUYthxq27SK2cMj/M
         lQW4inE7wfdpYJM8kSyRiaxc7Yh1aLWcuFhe4bBatOSHPgDsYaNqVHlHK0JTVcoPoiMq
         g/pFGOIJcBzktJS8LWdvI+d1yc0pEId79HE6zlBPj+f6RQNBQ7gC95NakbfvgRLgghmI
         zp8wnTv9Me8OhzuEHPX2ymkDzzHUozgEUKdQHpGkjvnXdR0YYZeB9q2PznPSHqQfNZEO
         6QJLcO6og5BJ+8y0Zs7OSVJyT0Iqy+TQ4aCHm+UhMh2VjmlE6TOFs+UYfiKAd81YYQQN
         EaqA==
X-Forwarded-Encrypted: i=1; AJvYcCWETRF+MiKHhZ1aiNXw1PC9kHfWR7hUDmKjOjrie0WTBv4T9GvoM9bZkrTGmlc5vheceJiG3ysWTjpX9AA=@vger.kernel.org, AJvYcCXrbjfp8uTT5WmhLxHvdkcEcDY6sD1g32huzUBsboq7zgRat+UMfATcEfi94HRShYPGRUpzbDJngx/9AuI6Y9tZlaAz@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/Lsf+rTeHzz9FiJjqzCpGIczThI35SjlTuECpTeJFADvnCheg
	TJ0epUmR5Fp13iY/e9RY7lDi+dyBTtBiX2IEt1Ae+vZRYKDzdLEsx6t6N0+F7jFudPB4Dit0QrH
	1C3+cIb/hUd0iZnAlhDj60OcRU0O/nQ==
X-Gm-Gg: ASbGncspmKV16H/Y/BQJJ5MF39F0dnGZ3dx7VsrZkaBOZKazfKm9YxWKxjijHpnPfi7
	2KxCoWf6YyFqXFh1ZOWlMBdu9ev4YIwnEInea4bbHG4+4mCKFG/jXN+EuVZRluOc9tIWAkgwJMu
	CzMUOhqJerLCSGErGNOWYew0FfXNBOIR1TQPNhORYGdJQr+cEFAJs90yq5ctIUy/ga
X-Google-Smtp-Source: AGHT+IGa0fRAXH+FSfeRHv71a7lGxigI2bEQFrpHFNP/gBaU5DRmpA61nFRj6pRVHcarxmk11YS5q1KFtjk4w4RmHdo=
X-Received: by 2002:a05:651c:31c5:b0:30d:b366:d259 with SMTP id
 38308e7fff4ca-32807700167mr71865711fa.10.1747926000572; Thu, 22 May 2025
 08:00:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP=Rh=OFdom8bL-KiWf88AyVZkJWnAJ+HBO7rE_74sOFzK=apQ@mail.gmail.com>
 <20250521133137.1b2f2cac@gandalf.local.home>
In-Reply-To: <20250521133137.1b2f2cac@gandalf.local.home>
From: John <john.cs.hey@gmail.com>
Date: Thu, 22 May 2025 22:59:49 +0800
X-Gm-Features: AX0GCFuovz7ZbwMdD4ggExVMavYVsIZZ4uJElQKK8CkTJhik2S-SJEJUixu59cI
Message-ID: <CAP=Rh=O3550HZTmzMhveaMNeq=FoNcTydhLjWkH-JEFGWCKPsQ@mail.gmail.com>
Subject: Re: [Bug] soft lockup in syscall_exit_to_user_mode in Linux kernel v6.15-rc5
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Steven,

Thank you very much for your prompt reply and kind support. Based on
your analysis, I will disable KASAN and attempt to reproduce the crash
accordingly.

I will keep you updated with any progress. I truly appreciate your
time and assistance.

Best regards,
John

On Thu, May 22, 2025 at 1:30=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Thu, 22 May 2025 00:40:29 +0800
> John <john.cs.hey@gmail.com> wrote:
>
> > Root Cause Analysis:
> > The root cause is unbounded recursion or excessive iteration in
> > lock_acquire() initiated via perf tracepoints that fire during slab
> > allocations and trace buffer updates. Specifically:
> > tracing_gen_ctx_irq_test() is invoked while tracing kernel contexts
> > (e.g., IRQ/softirq nesting).
> > This tracepoint triggers perf_trace_lock_acquire() and further invokes
> > lock_acquire() from lockdep.
>
> tracing_gen_ctx_irq_test() is not a tracepoint. It's a simple routine to
> find out how to fill the "common_flags" part of a trace event.
>
> Here's the entire function:
>
> unsigned int tracing_gen_ctx_irq_test(unsigned int irqs_status)
> {
>         unsigned int trace_flags =3D irqs_status;
>         unsigned int pc;
>
>         pc =3D preempt_count();
>
>         if (pc & NMI_MASK)
>                 trace_flags |=3D TRACE_FLAG_NMI;
>         if (pc & HARDIRQ_MASK)
>                 trace_flags |=3D TRACE_FLAG_HARDIRQ;
>         if (in_serving_softirq())
>                 trace_flags |=3D TRACE_FLAG_SOFTIRQ;
>         if (softirq_count() >> (SOFTIRQ_SHIFT + 1))
>                 trace_flags |=3D TRACE_FLAG_BH_OFF;
>
>         if (tif_need_resched())
>                 trace_flags |=3D TRACE_FLAG_NEED_RESCHED;
>         if (test_preempt_need_resched())
>                 trace_flags |=3D TRACE_FLAG_PREEMPT_RESCHED;
>         if (IS_ENABLED(CONFIG_ARCH_HAS_PREEMPT_LAZY) && tif_test_bit(TIF_=
NEED_RESCHED_LAZY))
>                 trace_flags |=3D TRACE_FLAG_NEED_RESCHED_LAZY;
>         return (trace_flags << 16) | (min_t(unsigned int, pc & 0xff, 0xf)=
) |
>                 (min_t(unsigned int, migration_disable_value(), 0xf)) << =
4;
> }
>
> The functions it calls are:
>
> static __always_inline int preempt_count(void)
> {
>         return raw_cpu_read_4(__preempt_count) & ~PREEMPT_NEED_RESCHED;
> }
>
> # define softirq_count()        (preempt_count() & SOFTIRQ_MASK)
> #define in_serving_softirq()    (softirq_count() & SOFTIRQ_OFFSET)
>
> static __always_inline bool tif_need_resched(void)
> {
>         return tif_test_bit(TIF_NEED_RESCHED);
> }
>
> static __always_inline bool test_preempt_need_resched(void)
> {
>         return !(raw_cpu_read_4(__preempt_count) & PREEMPT_NEED_RESCHED);
> }
>
> static unsigned short migration_disable_value(void)
> {
> #if defined(CONFIG_SMP)
>         return current->migration_disabled;
> #else
>         return 0;
> #endif
> }
>
> Nothing there should cause any recursion or issue. It's basically testing
> various states and then returns a flags value.
>
> It does not call lock_acquire().
>
>
> > Inside lock_acquire(), the kernel attempts to inspect instruction
> > addresses via __kernel_text_address(), which cascades into
> > unwind_get_return_address() and stack_trace_save().
> > However, these introspection functions are not expected to run in
> > real-time-sensitive softirq context and they do not contain preemption
> > or rescheduling points. With sufficient recursion or stress (e.g.,
> > slab allocation with tracepoints and lockdep active), CPU#0 gets
> > trapped and triggers the watchdog.
> >
> > At present, I have not yet obtained a minimal reproducer for this
> > issue. However, I am actively working on reproducing it, and I will
> > promptly share any additional findings or a working reproducer as soon
> > as it becomes available.
> >
> > Thank you very much for your time and attention to this matter. I
> > truly appreciate the efforts of the Linux kernel community.
> >
>
> Looking at the backtrace you have:
>
> kernel_text_address+0x35/0xc0 kernel/extable.c:94
>  __kernel_text_address+0xd/0x40 kernel/extable.c:79
>  unwind_get_return_address arch/x86/kernel/unwind_orc.c:369 [inline]
>  unwind_get_return_address+0x59/0xa0 arch/x86/kernel/unwind_orc.c:364
>  arch_stack_walk+0x9c/0xf0 arch/x86/kernel/stacktrace.c:26
>  stack_trace_save+0x8e/0xc0 kernel/stacktrace.c:122
>  kasan_save_stack+0x24/0x50 mm/kasan/common.c:47
>  kasan_save_track+0x14/0x30 mm/kasan/common.c:68
>  unpoison_slab_object mm/kasan/common.c:319 [inline]
>  __kasan_slab_alloc+0x59/0x70 mm/kasan/common.c:345
>  kasan_slab_alloc include/linux/kasan.h:250 [inline]
>  slab_post_alloc_hook mm/slub.c:4147 [inline]
>
> KASAN is a very intrusive debugging utility that often causes soft lockup=
s
> and such when used with other debugging utilities.
>
> If you can reproduce a softlockup without KASAN enabled, I'd then be more
> worried about this. Usually when I trigger a softlockup and have KASAN
> enabled, I just disable KASAN.
>
> -- Steve
