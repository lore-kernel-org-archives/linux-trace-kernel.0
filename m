Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36372184108
	for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Jul 2024 08:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721031156; cv=none; b=C//Qlb2HA3xU80k7AFj2sg4/KxFBHknmOmVD1kDCwotK2qecxhXApOfyanNSvw2hS0yIfLQLe1CVLpccbk2dkqFtoBEZuJCQ1vmRWrN4DbVhLCYIhyvH3F0NnTTwnPhvoM+ECMNIwT4JIbt1aT4B7hWaGl158DWdR62N37wxdbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721031156; c=relaxed/simple;
	bh=5NT0nQnnuvnj76YU9TmtoXstPxW/ueKhrxD8hU9yT+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JTZw5utq8g1lLegNTEbs1D0f/g7Jjv5KRRD+fDQL4wx6tFFRtLCv7Fj4ZhzemPkmzjXeeiApsKs6KrCFFzO4C5rsq0+Wr/P3A9VJ07IBzPMz+WOA9o2fN7c4IMFJyrd+PIwZHblxJOYnf5p0LrvDS2erKNxOsocqSqET/p5QUoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=jUKypdCY; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="jUKypdCY"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a77e7a6cfa7so437485666b.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Jul 2024 01:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721031152; x=1721635952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=03jWWWCVzc5/LJdqyioI99prKjte6wH3TiKjV7DS5tM=;
        b=jUKypdCY0qNpX8Vc/i5UXyx0VbW9NdWlG8SWSGWJ89cL0H+9Fvjy9/b9SGpcdP1MCS
         Eem2l1xkAg/SQgZXCCg2EPqABTBhZn9CCcWAP+ty7t9bWpULQwA+OORjW6KSd3Ld85AP
         hFg1clu9Hh5Km27E8Aao28WbPhKipRK3gmLm+ep5iV8U6BWLEsmBmsRiu8o/yt8kbBLK
         0IBJOpwuAX83n6Fs9aLUtX13p8ej0G3HMRtNrCgpnYHPOmrK08uJWzAqrim+Sv+GMrcD
         b5sp3Tk85z8IbuZ5NTQn4/JQqp2oxri9gxHGUIjeUF3yB3YaVpSP2+KUDAm1E3rgrNfl
         WnLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721031152; x=1721635952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=03jWWWCVzc5/LJdqyioI99prKjte6wH3TiKjV7DS5tM=;
        b=e1f2gbGx+ZlrTaHi+fXxEAcPcigwBo5AVWbMCCgJsuuE8EtrmWsYZpJigklzKLg5Iq
         PUpCScrX1s2yQ+cHgouXc47oqcfufgrT+ABqvTvw8tV14MERg0oj9m9JtFS0XBeriPs4
         kwgtUGpdOK1mQd7iesG4yTEpOqvLTe8uOEEcagherkSAG0eKIiaNaxEjX2aB+3PcdbRv
         zauJ8C09FeCdxHVdY68mE15pW+ECgGc+43h/2JW61HAKgqh5ulwoGUMJzJU3fVXTGmEP
         bF3vwU/sVLeENwaqxkgmNHUDay1mfGqgJHD2YFYHapwgJwLGrEFz1q17jtFKFcavfsnd
         ur4g==
X-Forwarded-Encrypted: i=1; AJvYcCV2BxGGWXtIv/XDPTof3G31lY2iUC0weqVRm/KmfKFufdrrBKNXviA1UhqXlup24edVykmyJkrZ44101usp29HTCJG7SHeBYVxpB2Gk7iJgnSus
X-Gm-Message-State: AOJu0YzIEXSb/0er6wqzlZy7ZlXu9PZKeZtxOi6/x4+ltGoLtBRDE+5h
	tdXI7MouXPr0sH6llPSSnnvQkyZQqlAF0Hcq8dxwpS54LDumnDGbowZGHW9A8hwJe62LhuEniYG
	eHxWWxwK5Zj85QlhsvQeeu+aPi637ZIZg2aiIdA==
X-Google-Smtp-Source: AGHT+IFAM/JbPKSHGtXJzUtImNJqPcsuIujR27+IbnzngqO96PYEia8kBR8MYr6ACsxPM+BKbwLFE6qk68WRrNEudhw=
X-Received: by 2002:a17:906:66c9:b0:a77:cf9d:f497 with SMTP id
 a640c23a62f3a-a780b70513emr1187421166b.40.1721031152552; Mon, 15 Jul 2024
 01:12:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624082141.153871-1-alexghiti@rivosinc.com> <CAMuHMdUwx=rU2MWhFTE6KhYHm64phxx2Y6u05-aBLGfeG5696A@mail.gmail.com>
In-Reply-To: <CAMuHMdUwx=rU2MWhFTE6KhYHm64phxx2Y6u05-aBLGfeG5696A@mail.gmail.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Mon, 15 Jul 2024 10:12:21 +0200
Message-ID: <CAHVXubicJ=g_vXWUh+uGbv00X0gnn24J3SCaU4PhRD-1ZReY8g@mail.gmail.com>
Subject: Re: [PATCH -fixes] riscv: patch: Flush the icache right after
 patching to avoid illegal insns
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Andy Chiu <andy.chiu@sifive.com>, Puranjay Mohan <puranjay12@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Geert,

On Tue, Jul 9, 2024 at 10:13=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Alexandre,
>
> On Mon, Jun 24, 2024 at 10:23=E2=80=AFAM Alexandre Ghiti <alexghiti@rivos=
inc.com> wrote:
> > We cannot delay the icache flush after patching some functions as we ma=
y
> > have patched a function that will get called before the icache flush.
> >
> > The only way to completely avoid such scenario is by flushing the icach=
e
> > as soon as we patch a function. This will probably be costly as we don'=
t
> > batch the icache maintenance anymore.
> >
> > Fixes: 6ca445d8af0e ("riscv: Fix early ftrace nop patching")
> > Reported-by: Conor Dooley <conor.dooley@microchip.com>
> > Closes: https://lore.kernel.org/linux-riscv/20240613-lubricant-breath-0=
61192a9489a@wendy/
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>
> Thanks for your patch, which is now commit edf2d546bfd6f5c4 ("riscv:
> patch: Flush the icache right after patching to avoid illegal
> insns") in v6.10-rc6.
>
> > --- a/arch/riscv/kernel/patch.c
> > +++ b/arch/riscv/kernel/patch.c
> > @@ -189,9 +205,6 @@ int patch_text_set_nosync(void *addr, u8 c, size_t =
len)
> >
> >         ret =3D patch_insn_set(tp, c, len);
> >
> > -       if (!ret)
> > -               flush_icache_range((uintptr_t)tp, (uintptr_t)tp + len);
> > -
> >         return ret;
> >  }
> >  NOKPROBE_SYMBOL(patch_text_set_nosync);
>
> patch_text_set_nosync() is now identical to (static) patch_insn_set(),
> and the latter has no other callers.
>
> > @@ -224,9 +237,6 @@ int patch_text_nosync(void *addr, const void *insns=
, size_t len)
> >
> >         ret =3D patch_insn_write(tp, insns, len);
> >
> > -       if (!ret)
> > -               flush_icache_range((uintptr_t) tp, (uintptr_t) tp + len=
);
> > -
> >         return ret;
> >  }
> >  NOKPROBE_SYMBOL(patch_text_nosync);
>
> patch_text_nosync() is now identical to patch_insn_write(), and both
> functions are called from outside this file.
>

I'll do something about that, thanks.

Alex

> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds
