Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14BB31690D
	for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Oct 2025 09:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760606682; cv=none; b=L6dTMivCsZsrS7ixTpTgGfkmkFJ/yqJG0pr4gHtoKzDfBvnA+4gAgwNfDPImkpsqQ0vcSEPzwTh9A98CFFDoqNPO+fVIftghtLKKf4WHIo1u7511CrlU4DkApWkjjMNG+NdZjtbPdGZUbE6R/spKoxJ1QI7qLxDPB0YkkLItWiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760606682; c=relaxed/simple;
	bh=M4Y1UfCzl//9fhvdpaNABF0RhKSRR5+CnAVK+a7lT1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gwpRJWT47Z2VBpMmsEJmBOjmDpKmDK72SfuxKLJoZH7cy4mYJFLp5jCEpn8NIVB2KjNdEAfzewQHVp75UXKQM2JWmzyH1uKq2opB37gxOrZKTZW2twPxDuOUF6obJdbQe2V9f1H6XH4UhvbX2T4Y2yty9FY1MMOjBU+cmJZtoFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Frt74fXz; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Frt74fXz"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7abbdf3c476so425648a34.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Oct 2025 02:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1760606679; x=1761211479; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/c6zz769KW3+RZuhvQvM45rkjkysrRExAu4xufMTsS4=;
        b=Frt74fXz52BMMBmRe54r+ulQVSZIdfXUs9fE5ujie5YMWCwHVt+LAXJ7egaln21wqL
         o+Y0bYkgc7yIZac7cFRZwX6kdH6bT3+pVoGuHPGZNc5FKvk1sxMn/I3hk5td3nF6qi7I
         LzberP0ULy7vwn4dbzodeVhNnAfc3FSwpsB7QRKPxUNsrGpntnDwj7AdRSWihksjz3ga
         kGAczZqMg4ta2QS900/GSluXBsV3wNEQ2b9RYYEYVukkrSSj8q/kpVaIK1RP4I9TYPgq
         RGpZt/TaJsTEElLsK3bG5D3u7DQAyiFoaEK0eeS0tqI4iT8IM1t18Y0AMClrJ2uDIp98
         CCBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760606679; x=1761211479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/c6zz769KW3+RZuhvQvM45rkjkysrRExAu4xufMTsS4=;
        b=ZjosEVWEmkKo/AANhEEjw/kZBDt14vHOjdDTfeLAAccv7t55A1mmI39UU00y+P0/hw
         /kDoPFZBDxj6q/QkLJ3pfcDMtulF0kaazThdnAKGfSfWa8fhIsNadrrRzX5l9+d9n3fc
         nWnRN8lk9PAfBSmQv4R8CKzP5GzLfWkMznl22IhwxuQYeBwcdu5lFUJTpIJSqh53yjoS
         snRHsXQEbFfEU3aw2WMQFM43JS5HPAr23go4BCJfI+MpDAGCT1//d/w3zpDABiFlFTQV
         X6TPV/J4xPdmLrcEJ8IpS23vJ7FKLcSJRjST8fgpTycUkz8QFd0RJudE5UWLdobMxTJd
         rDTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkrS9RzLQw6muij0VbKvM6G+HzBee7pIo2k91LoVHWH/6rsAuQ+/6b3iw1I1h3C/44E7V+8lMi89VALpLBqpEUdio=@vger.kernel.org
X-Gm-Message-State: AOJu0YyioBpFKhc3xwc8ldj6rtwfkTMj/DXuwbEWrJDmQS4F48DEAqIq
	HR1KpMnRZxiS6S+tn5nDoafDkM63GIFUOjYeDEkYTzbd8pQTcqN70KQ7wH/Lf1q8YdI72sEG2jm
	cQF1ZjlwnY7xMkXTfKzeKsyaBqd3CiZ8KRDGfvjlShg==
X-Gm-Gg: ASbGncuRn+X0OcuyfPlS6ivSR6tsjlCbrSDd/+yDHKVByk0aQ+bTrGl82q5xfwg1oKg
	q6vNYQn15xboCOd4f9YcDTlc5DMmrU7BW346fitZm6liBCr50AqoVK4zW84G8vx++7VaLy8EF9K
	JYddoZO0bkjE8f4xHdMMM2OiFTNVfiY+0oMLqC+ka7Qr/SQbcSDgom1wgIQX5Se/QlHls2MerM9
	sUY7MfD9yss7cwoWuuU/YxnlxGEpy60gVkqjxFOtMT6gz0cprpu+xuOQP/NligbqeOwuOBv
X-Google-Smtp-Source: AGHT+IHm4R3HAhs61U+ziACGhT5EU87YhgLPPrROIOYqvuuTTqIEn/VlTT4VJwJAYRRve6qjnJ4K5VlBxkGqJHLI9cY=
X-Received: by 2002:a05:6808:1787:b0:439:8e9:637c with SMTP id
 5614622812f47-4417b3b1440mr14272700b6e.25.1760606678720; Thu, 16 Oct 2025
 02:24:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009134514.8549-1-cuiyunhui@bytedance.com> <aOfmnjJmQAdR1wD4@pie>
In-Reply-To: <aOfmnjJmQAdR1wD4@pie>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Thu, 16 Oct 2025 17:24:26 +0800
X-Gm-Features: AS18NWAzFcG41x3ym-AvM6L2OgXYcfI1rHQW_3fAesaQdIbiv5CARk8r2OaaGpI
Message-ID: <CAEEQ3wkH5FZSOGPhu7i7UDyi5=Xe6B9q7=4_ZZN_R2BHi63J1A@mail.gmail.com>
Subject: Re: [External] Re: [PATCH RFC] riscv: add support for Ziccid
To: Yao Zi <ziyao@disroot.org>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com, 
	peterz@infradead.org, jpoimboe@kernel.org, jbaron@akamai.com, ardb@kernel.org, 
	willy@infradead.org, guoren@kernel.org, ziy@nvidia.com, 
	akpm@linux-foundation.org, bjorn@rivosinc.com, ajones@ventanamicro.com, 
	parri.andrea@gmail.com, cleger@rivosinc.com, yongxuan.wang@sifive.com, 
	inochiama@gmail.com, samuel.holland@sifive.com, charlie@rivosinc.com, 
	conor.dooley@microchip.com, yikming2222@gmail.com, andybnac@gmail.com, 
	yury.norov@gmail.com, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yao,

On Fri, Oct 10, 2025 at 12:46=E2=80=AFAM Yao Zi <ziyao@disroot.org> wrote:
>
> On Thu, Oct 09, 2025 at 09:45:14PM +0800, Yunhui Cui wrote:
> > The Ziccid extension provides hardware synchronization between
> > Dcache and Icache. With this hardware support, there's no longer
> > a need to trigger remote hart execution of fence.i via IPI.
>
> This description looks wrong to me: Ziccid only guarantees code
> modification **eventually** becomes visible to remote HARTs, not
> immediately. Quoting a paragraph from documentation of Ziccid[1],
>
> > Since, under Ziccid, instruction fetches appear in the global memory
> > order, the RVWMO progress axiom suffices to guarantee that stores
> > **eventually** become visible to instruction fetches, even without
> > executing a FENCE.I instruction.
>
> and an issue[2] in the same repository (Ziccid hardware implementation &
> software model),
>
> > > Is fence.i still necessary in any case with the presence of Ziccid
> >
> > The only thing that Ziccid guarantees is that stores eventually become
> > visible to instruction fetch. It doesn't guarantee that stores
> > immediately become visible to instruction fetch, even on the same
> > hart.
> >
> > So, fence.i is still usually necessary. The only situations in which
> > fence.i is not necessary is when race conditions in code patching are
> > functionally acceptable, i.e. when it doesn't matter whether the old
> > code or new code is executed.

Well, yes, based on this link, no additional software support is
needed=E2=80=94and that=E2=80=99s also a good thing.
https://github.com/aswaterman/riscv-misc/issues/4

>
> So it's definitely wrong to state "there's no longer a need to trigger
> remote hart execution of fence.i".
>
> > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > ---
> >  arch/riscv/include/asm/cacheflush.h |  4 ++--
> >  arch/riscv/include/asm/hwcap.h      |  1 +
> >  arch/riscv/include/asm/switch_to.h  | 10 ++++++++++
> >  arch/riscv/kernel/cpufeature.c      |  1 +
> >  arch/riscv/kernel/ftrace.c          |  2 +-
> >  arch/riscv/kernel/hibernate.c       |  2 +-
> >  arch/riscv/kernel/jump_label.c      |  2 +-
> >  arch/riscv/mm/cacheflush.c          | 16 ++++++++++++++--
> >  8 files changed, 31 insertions(+), 7 deletions(-)
> >
>
> ...
>
> > -void flush_icache_all(void)
> > +void flush_icache_all(bool force)
> >  {
> >       local_flush_icache_all();
> >
> >       if (num_online_cpus() < 2)
> >               return;
> >
> > +     if (!force)
> > +             asm goto(ALTERNATIVE("nop", "j %l[ziccid]", 0,
> > +                     RISCV_ISA_EXT_ZICCID, 1)
> > +                     : : : : ziccid);
>
> and even in the patch, a remote-fence is still triggered if
> flush_icache_all() is called with force set to true.
>
> Best regards,
> Yao Zi
>
> [1]: https://github.com/aswaterman/riscv-misc/blob/e4fe3aa7b4d5b/isa/zicc=
id.adoc?plain=3D1#L139-L158
> [2]: https://github.com/aswaterman/riscv-misc/issues/4#issuecomment-28849=
84633
>
> >       /*
> >        * Make sure all previous writes to the D$ are ordered before mak=
ing
> >        * the IPI. The RISC-V spec states that a hart must execute a dat=
a fence
> > @@ -41,6 +46,7 @@ void flush_icache_all(void)
> >               sbi_remote_fence_i(NULL);
> >       else
> >               on_each_cpu(ipi_remote_fence_i, NULL, 1);
> > +ziccid:;
> >  }
> >  EXPORT_SYMBOL(flush_icache_all);


Thanks,
Yunhui
