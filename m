Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D60938DE3
	for <linux-trace-kernel@vger.kernel.org>; Thu, 14 Dec 2023 20:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FfoMFynM"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-551ee7d5214so2085860a12.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 14 Dec 2023 12:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1702587047; x=1703191847; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=70Y7o3IdU9xF6jWzjwutAl8ZEw5YbkckBXgTZi3FBa0=;
        b=FfoMFynMFOxD2ydWLHwg2k1Vn5PZ898lYI5PZoP+z020RE1SNUzT2jwNvaAYIjYpnd
         hdGSfSgrIST54KTK1rCQkphZHpqHL9nTq9eIjW/6Q/T/ySagqKXX5dXMp2bKl1aFpSO8
         YblI4YcHcxpx0A2t9ioMk71y+T7KKeKo19aHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702587047; x=1703191847;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=70Y7o3IdU9xF6jWzjwutAl8ZEw5YbkckBXgTZi3FBa0=;
        b=GkptN5AbaJWoODQ4srvA5/R/dvCmyTPP43Hn864GIXmSetswvzmGayfV0gchgZ2UAt
         7idH3H5iHCC1e8fXlJVjcvjUfJ34TcMl0ontpvTD9Qpn+6fsIEcfCPxaw9DQTVPx09W6
         yEC1w5ewu4R17sJfVT4EJRJ8LwOlRGRb/5RYj9dnMFXC/FpHpCgsti3cNRM91AXud1Bn
         81RlgBpv2//3gGl1szMxq4mI3niDT9rLZ9jZdBzVaOxjVDkPufFWUGhO/Qk6wir2H9mJ
         vN8Sya6sqP2FONiwPs+n8oHoD+NEPPZykhVFSNFzh1ptwUHcaJGxdnYRxEFMZoNQH1cl
         H9nw==
X-Gm-Message-State: AOJu0YzEItYX3JU2M0HQH5E5Bk1yI3pQboVavkOeE5pZsQMSyG3rO/u+
	pKCNmV2wlZBHOChFXZJRgCII7kzSIAnJLL3yLMU5mM3N
X-Google-Smtp-Source: AGHT+IHmegUnfBwaOb6XIkh25MahS9s6MFJ/LkRkU52FvKQ8g6s1jWI84AFLSJYBuypnIAWFhFSb7w==
X-Received: by 2002:a17:906:fe4c:b0:a1c:4eee:3521 with SMTP id wz12-20020a170906fe4c00b00a1c4eee3521mr13068812ejb.56.1702587047716;
        Thu, 14 Dec 2023 12:50:47 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id kt19-20020a1709079d1300b00a1b65958c54sm9823564ejc.125.2023.12.14.12.50.47
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 12:50:47 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5527ee1b5c3so1622227a12.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 14 Dec 2023 12:50:47 -0800 (PST)
X-Received: by 2002:a17:906:608e:b0:a04:e1e7:d14c with SMTP id
 t14-20020a170906608e00b00a04e1e7d14cmr11442076ejj.32.1702587046729; Thu, 14
 Dec 2023 12:50:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213211126.24f8c1dd@gandalf.local.home> <20231213214632.15047c40@gandalf.local.home>
 <CAHk-=whESMW2v0cd0Ye+AnV0Hp9j+Mm4BO2xJo93eQcC1xghUA@mail.gmail.com>
 <20231214115614.2cf5a40e@gandalf.local.home> <CAHk-=wjjGEc0f4LLDxCTYvgD98kWqKy=89u=42JLRz5Qs3KKyA@mail.gmail.com>
 <20231214153636.655e18ce@gandalf.local.home>
In-Reply-To: <20231214153636.655e18ce@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 14 Dec 2023 12:50:29 -0800
X-Gmail-Original-Message-ID: <CAHk-=wieVSfyjTpe8L5kmwC4mk9dRge9dvyJiMZEkyz4-tOvow@mail.gmail.com>
Message-ID: <CAHk-=wieVSfyjTpe8L5kmwC4mk9dRge9dvyJiMZEkyz4-tOvow@mail.gmail.com>
Subject: Re: [PATCH] ring-buffer: Remove 32bit timestamp logic
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Dec 2023 at 12:35, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Thu, 14 Dec 2023 11:44:55 -0800
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
> > On Thu, 14 Dec 2023 at 08:55, Steven Rostedt <rostedt@goodmis.org> wrote:
> > >
> > > And yes, this does get called in NMI context.
> >
> > Not on an i486-class machine they won't. You don't have a local apic
> > on those, and they won't have any NMI sources under our control (ie
> > NMI does exist, but we're talking purely legacy NMI for "motherboard
> > problems" like RAM parity errors etc)
>
> Ah, so we should not worry about being in NMI context without a 64bit cmpxchg?

.. on x86.

Elsewhere, who knows?

It is *probably* true in most situations. '32-bit' => 'legacy' =>
'less likely to have fancy profiling / irq setups'.

But I really don't know.

> > So no. You need to forget about the whole "do a 64-bit cmpxchg on
> > 32-bit architectures" as being some kind of solution in the short
> > term.
>
> But do all archs have an implementation of cmpxchg64, even if it requires
> disabling interrupts? If not, then I definitely cannot remove this code.

We have a generic header file, so anybody who uses that would get the
fallback version, ie

arch_cmpxchg64 -> generic_cmpxchg64_local -> __generic_cmpxchg64_local

which does that irq disabling thing.

But no, not everybody is guaranteed to use that fallback. From a quick
look, ARC, hexagon and CSky don't do this, for example.

And then I got bored and stopped looking.

My guess is that *most* 32-bit architectures do not have a 64-bit
cmpxchg - not even the irq-safe one.

For the UP case you can do your own, of course.

            Linus
