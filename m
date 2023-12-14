Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB706979D
	for <linux-trace-kernel@vger.kernel.org>; Thu, 14 Dec 2023 19:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dDSEl6v/"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a1f8510883aso787409466b.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 14 Dec 2023 11:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1702583113; x=1703187913; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MpUjOoTdCqNzayaiwbixMLyZUnTZjhFDCaA6n5v3lDM=;
        b=dDSEl6v/M30epCXcAY1R4AfnWJ0Y9Rv5feREx5G/OGXKQJIr7SIQEfxlZp7yh7ifJE
         piG+jenbdrIVKGmy8zSyUPkmtSq2+f5CgI4kfcUV7f4Ogjt+DuQg+4goWlJ0x+ErpiF+
         jfkDVTw6DNsR97TBL9mDmjyWbrzFbXt1imYjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702583113; x=1703187913;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MpUjOoTdCqNzayaiwbixMLyZUnTZjhFDCaA6n5v3lDM=;
        b=p7Wg/v2OMwrfKQUzGV9dt18Hf4Pjg6pGcKS8SUZMLEYNdvUxIATazRc1U1irWqLkEq
         FK2RSoEjmUyBJN0V92OcDHEtCx3AN/5FMEFFFUv31Ft6iDSvlSGyYCydL5Ivvs2ke9+2
         HYlqVCyvQtqBcZdcMNaf7YI4tlX1uev3xXrRmsl1BIChrZGgPb5ctNxwMTTNARLzfboF
         a+R4ue67msxGcN5AXi8dQWUAAaSk4/Est8//qLoFgnJ0mdp3M0d61QoM27r0Agvlwnsi
         mY07M7GYsb1z3WoScCaAxfF6BcJ7R4xwGUOrrym4RKd++K6spsiO1vsqoRbACJtyYnti
         4M3A==
X-Gm-Message-State: AOJu0YwNtM2XBY+EZuvNzBxYv5PiKegMzVKCQ6GqqeN84uZeLlnT8qiP
	jz2MKGadttm/6cSpYTWdxVA0ejMM7HCA+qjdYMByGw==
X-Google-Smtp-Source: AGHT+IGfmMrfULrA4NjEg+ax6niwSjfrlMc9r7UgBf3ieesgmzgLdOzqUkO/8J+9iwHgQRfGRUGYRw==
X-Received: by 2002:a17:907:cbc8:b0:a19:a1ba:baed with SMTP id vk8-20020a170907cbc800b00a19a1babaedmr3231546ejc.147.1702583113519;
        Thu, 14 Dec 2023 11:45:13 -0800 (PST)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id ry9-20020a1709068d8900b00a1f744953c1sm9138608ejc.105.2023.12.14.11.45.12
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 11:45:12 -0800 (PST)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a1f653e3c3dso956093566b.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 14 Dec 2023 11:45:12 -0800 (PST)
X-Received: by 2002:a17:907:3ac2:b0:a19:d40a:d21f with SMTP id
 fi2-20020a1709073ac200b00a19d40ad21fmr2222801ejc.235.1702583112429; Thu, 14
 Dec 2023 11:45:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213211126.24f8c1dd@gandalf.local.home> <20231213214632.15047c40@gandalf.local.home>
 <CAHk-=whESMW2v0cd0Ye+AnV0Hp9j+Mm4BO2xJo93eQcC1xghUA@mail.gmail.com> <20231214115614.2cf5a40e@gandalf.local.home>
In-Reply-To: <20231214115614.2cf5a40e@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 14 Dec 2023 11:44:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjjGEc0f4LLDxCTYvgD98kWqKy=89u=42JLRz5Qs3KKyA@mail.gmail.com>
Message-ID: <CAHk-=wjjGEc0f4LLDxCTYvgD98kWqKy=89u=42JLRz5Qs3KKyA@mail.gmail.com>
Subject: Re: [PATCH] ring-buffer: Remove 32bit timestamp logic
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Dec 2023 at 08:55, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> And yes, this does get called in NMI context.

Not on an i486-class machine they won't. You don't have a local apic
on those, and they won't have any NMI sources under our control (ie
NMI does exist, but we're talking purely legacy NMI for "motherboard
problems" like RAM parity errors etc)

> I had a patch that added:
>
> +       /* ring buffer does cmpxchg, make sure it is safe in NMI context */
> +       if (!IS_ENABLED(CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG) &&
> +           (unlikely(in_nmi()))) {
> +               return NULL;
> +       }

CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG doesn't work on x86 in this context,
because the issue is that yes, there's a safe 'cmpxchg', but that's
not what you want.

You want the save cmpxchg64, which is an entirely different beast.

And honestly, I don't think that NMI_SAFE_CMPXCHG covers the
double-word case anywhere else either, except purely by luck.

In mm/slab.c, we also use a double-wide cmpxchg, and there the rule
has literally been that it's conditional on

 (a) system_has_cmpxchg64() existing as a macro

 (b) using that macro to then gate - at runtime - whether it actually
works or not

I think - but didn't check - that we essentially only enable the
two-word case on x86 as a result, and fall back to the slow case on
all other architectures - and on the i486 case.

That said, other architectures *do* have a working double-word
cmpxchg, but I wouldn't guarantee it. For example, 32-bit arm does
have one using ldrexd/strexd, but that only exists on arm v6+.

And guess what? You'll silently get a "disable interrupts, do it as a
non-atomic load-store" on arm too for that case. And again, pre-v6 arm
is about as relevant as i486 is, but my point is, that double-word
cmpxchg you rely on simply DOES NOT EXIST on 32-bit platforms except
under special circumstances.

So this isn't a "x86 is the odd man out". This is literally generic.

> Now back to my original question. Are you OK with me sending this to you
> now, or should I send you just the subtle fixes to the 32-bit rb_time_*
> code and keep this patch for the merge window?

I'm absolutely not taking some untested random "let's do 64-bit
cmpxchg that we know is broken on 32-bit using broken conditionals"
shit.

What *would* work is that slab approach, which is essentially

  #ifndef system_has_cmpxchg64
      #define system_has_cmpxchg64() false
  #endif

        ...
        if (!system_has_cmpxchg64())
                return error or slow case

        do_64bit_cmpxchg_case();

(although the slub case is much more indirect, and uses a
__CMPXCHG_DOUBLE flag that only gets set when that define exists etc).

But that would literally cut off support for all non-x86 32-bit architectures.

So no. You need to forget about the whole "do a 64-bit cmpxchg on
32-bit architectures" as being some kind of solution in the short
term.

               Linus
