Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JuyBWAu8"
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF23B7
	for <linux-trace-kernel@vger.kernel.org>; Wed, 13 Dec 2023 22:53:39 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-a1e7971db2aso895191366b.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 13 Dec 2023 22:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1702536818; x=1703141618; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NiI/O/Kwj2hTfnkTjsVyBrnrMlgdhxR75QC+suIDMTA=;
        b=JuyBWAu8XDqIvkbPyykWZeiETanDax3fQLjEG8ZS8xvjLWmd2aIkQg3mDI+EaFFxBA
         qXcaEDmyU6bbDHy+l8/jgEjSO44OyDxI1fmqPOa7Id0DMO2axssU3H9+S9HO4Rp1+J7s
         rbdWbcdpPidBcQ/F4oul/p3Vd+3JWywyhHe8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702536818; x=1703141618;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NiI/O/Kwj2hTfnkTjsVyBrnrMlgdhxR75QC+suIDMTA=;
        b=o5jYkGh1Bu6RRCnzplWg+YlZTBUQLwGVI5Cy8Oc7y/5J8CsU0EA6F3dDsyXcwVD9Gn
         WWQ6FBT0BKKUDUeh+qGjM1nni0RkX+gxEYA92Tq2gqCeNn/fgUzkXuCyRjH09mf8AYdV
         kektE5N6CjfOBWUFrVTntDK9xRDkr0pPZutr3Pd6por0gAyVN2GSFM/auPEunJwNdd6e
         vEnlUefO2qrw8XK43NpE1JWatNcy/+CHLZHJr1bksEuAkhzZUhFeiYFABJeMbuzj+nKx
         yjwyE3TzLZQ7yc+rAGRibgBDZuDpqNv7LnO65N+b9OVotDcKIsXgb4W66LirvtCsXqc+
         n27w==
X-Gm-Message-State: AOJu0Yy6gPHOjYiJT9QZKev0Yt8TzojE1qLoXormQxQ9Vk2eWQTJFxm/
	JivgbC7LeS0X9aN53PTH70gvQGo6LNiJAGwg/ze7pkGO
X-Google-Smtp-Source: AGHT+IHgR06S4mMLYujHzOZUvwsTnUbXbkuxamewy1LYckGm4jP9JOIkhTdeaEnNLroffvWIqRh61A==
X-Received: by 2002:a17:906:c14b:b0:a1d:182:efcc with SMTP id dp11-20020a170906c14b00b00a1d0182efccmr5845085ejc.65.1702536817975;
        Wed, 13 Dec 2023 22:53:37 -0800 (PST)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id vc11-20020a170907d08b00b00a1b6d503e7esm8856575ejc.157.2023.12.13.22.53.36
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 22:53:36 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a1db6c63028so897126866b.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 13 Dec 2023 22:53:36 -0800 (PST)
X-Received: by 2002:a17:907:6d1d:b0:a1e:eecd:6f88 with SMTP id
 sa29-20020a1709076d1d00b00a1eeecd6f88mr5810857ejc.77.1702536816499; Wed, 13
 Dec 2023 22:53:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213211126.24f8c1dd@gandalf.local.home> <20231213214632.15047c40@gandalf.local.home>
In-Reply-To: <20231213214632.15047c40@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 13 Dec 2023 22:53:19 -0800
X-Gmail-Original-Message-ID: <CAHk-=whESMW2v0cd0Ye+AnV0Hp9j+Mm4BO2xJo93eQcC1xghUA@mail.gmail.com>
Message-ID: <CAHk-=whESMW2v0cd0Ye+AnV0Hp9j+Mm4BO2xJo93eQcC1xghUA@mail.gmail.com>
Subject: Re: [PATCH] ring-buffer: Remove 32bit timestamp logic
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Dec 2023 at 18:45, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> tl;dr;  The ring-buffer timestamp requires a 64-bit cmpxchg to keep the
> timestamps in sync (only in the slow paths). I was told that 64-bit cmpxchg
> can be extremely slow on 32-bit architectures. So I created a rb_time_t
> that on 64-bit was a normal local64_t type, and on 32-bit it's represented
> by 3 32-bit words and a counter for synchronization. But this now requires
> three 32-bit cmpxchgs for where one simple 64-bit cmpxchg would do.

It's not that a 64-bit cmpxchg is even slow. It doesn't EXIST AT ALL
on older 32-bit x86 machines.

Which is why we have

    arch/x86/lib/cmpxchg8b_emu.S

which emulates it on machines that don't have the CX8 capability
("CX8" being the x86 capability flag name for the cmpxchg8b
instruction, aka 64-bit cmpxchg).

Which only works because those older 32-bit cpu's also don't do SMP,
so there are no SMP cache coherency issues, only interrupt atomicity
issues.

IOW, the way to do an atomic 64-bit cmpxchg on the affected hardware
is to simply disable interrupts.

In other words - it's not just slow.  It's *really* slow. As in 10x
slower, not "slightly slower".

> We started discussing how much time this is actually saving to be worth the
> complexity, and actually found some hardware to test. One Atom processor.

That atom processor won't actually show the issue. It's much too
recent. So your "test" is actually worthless.

And you probably did this all with a kernel config that had
CONFIG_X86_CMPXCHG64 set anyway, which wouldn't even boot on a i486
machine.

So in fact your test was probably doubly broken, in that not only
didn't you test the slow case, you tested something that wouldn't even
have worked in the environment where the slow case happened.

Now, the real question is if anybody cares about CPUs that don't have
cmpxchg8b support.

IBecause in practice, it's really just old 486-class machines (and a
couple of clone manufacturers who _claimed_ to be Pentium class, but
weren't - there was also some odd thing with Windows breaking if you
had CPUID claiming to support CX8

We dropped support for the original 80386 some time ago. I'd actually
be willing to drop support for ll pre-cmpxchg8b machines, and get rid
of the emulation.

I also suspect that from a perf angle, none of this matters. The
emulation being slow probably is a non-issue, simply because even if
you run on an old i486 machine, you probably won't be doing perf or
tracing on it.

             Linus
