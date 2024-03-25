Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF4116B447
	for <linux-trace-kernel@vger.kernel.org>; Mon, 25 Mar 2024 12:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711371025; cv=none; b=eamQeLO99UsiwZ52kSpveirKaha5B1wC1Gx6PXpERUlnun41K9+obiNZQ02ui8ySRHXXDwL+F2V4veC+LQVCGqcR/SK37S2SZyicwxjqTsjiIHEQoRRb+0c40tiot4j/CAeYa6TKJ8tFB/wl5XvpjaBHftTigjKeyzTZgwlbDWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711371025; c=relaxed/simple;
	bh=5RyxoVFw8iV/PhK2kQZFnetLsvcimHQCr4aKA83CIbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LuLtJooVEwEulmLIgehlxlPcGuCXiry46uyP3/juVlY8l7CtaMmrEHoN2/XaOnwoEhJOwIbkYY2/PZlrrIQkAWnDx/JqGDZI8JkDC0qTQ3p/fB7YXxKxvVqYzwtRh1tKO0l7XEbZf2l7ApyLZzDKVdeyH7+BhUqD5wimJ0Ws07s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=a4TNHSkf; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="a4TNHSkf"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5dca1efad59so2434553a12.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 25 Mar 2024 05:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1711371023; x=1711975823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5RyxoVFw8iV/PhK2kQZFnetLsvcimHQCr4aKA83CIbw=;
        b=a4TNHSkf345sgU+AhOU4z07DoeTKHgfhTOtCntVFlL5JUPIJD/s/wbEYk8XiPkG5nT
         eRFKk/ZWgWFH2CzOAStB5sGfJQbQoRmqsv9dUgBiS9bz9s8u02qszMcDF90mG9m7JOX8
         ilAaOOg16Ec8Ky13yUBtua2gFPSRhLWISNT6X4Hu23ivWGSsYc6nx2+nGOgpKk8CDD6E
         kSLSVTFKpttG3ROgenDsIv3lXFgwQMEnDCvKn0NJcOSePd9jovd9u3TXBMvFBRyyYBey
         659DD7xK7+6xGDbySP5Z5MzwVGainNWCQtMukMKLXSFNAloigdk76z4/arVERypC4FrW
         YnHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711371023; x=1711975823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5RyxoVFw8iV/PhK2kQZFnetLsvcimHQCr4aKA83CIbw=;
        b=XvOQescTTE4rR7ujIjkVL7E6F6Z0BNP7LiKt/mCXlon9GfC4Ll+COTyD4MAdhuxZoM
         4OeNnGcpIEvbmkzEF1TqaS894tVXdEQxUDSf5PhmyyEWT76uw5mE11B4VnMbDrWfOUFY
         +3gRB4ObYD7Y6EVanrDiMPePbRAV5FBzornUAyQGHnyKGEkQYbFI0QvpzfXcZBmwRYqL
         OoVGliTpBNjxhnqPYyHMxVTpULxD1NlomtXmTeSIRVzUi4bMRw5/pTHrb+1282G9uEGk
         GXMCz2D4BuqDd0ZkqYcPI3fp6VOAFTU1vJhN3HHOU/yUicwYut3IcOjWA9P9IHOKcnPc
         A6Ug==
X-Forwarded-Encrypted: i=1; AJvYcCU3m9g10R6Sqvju7i7TTjJe6yFYU7lT1d0ingvPhoyRBApx5BsPtfB0guCrvFzXVI/0JFUsBE6K5LawjlPtIGTLx5J6B8yBxsUGCKMgc/6eEvdQ
X-Gm-Message-State: AOJu0Yzzn9GW5J9Vb3DH7EsMjGnYBGL100UoOiUsiwNfxxkwa7T0AZ9c
	arSuM0j+d/IpH7rfaFzGhJCRQJq/5nfcU4MiLc/60eUHFktMussCwNiOfdvA+0MSsuYQUa2Jz/L
	ibLGWpD8Yve45AtpbATqkkz64YdksrRCRvP3BLQ==
X-Google-Smtp-Source: AGHT+IFavvihRisV9kCaSJXWkP5NlMeM+2ciaavifWQ9HNV1hzqkvuSD7eRB5OdriFQR916iQBclkPwrahehtGboVyQ=
X-Received: by 2002:a17:90a:b30c:b0:29c:5c56:ffea with SMTP id
 d12-20020a17090ab30c00b0029c5c56ffeamr4730905pjr.6.1711371023055; Mon, 25 Mar
 2024 05:50:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306165904.108141-1-puranjay12@gmail.com> <87ttlhdeqb.fsf@all.your.base.are.belong.to.us>
 <ZfBbxPDd0rz6FN2T@FVFF77S0Q05N> <8734suqsth.fsf@all.your.base.are.belong.to.us>
 <mb61pplvw6grf.fsf@gmail.com> <87zfv0onre.fsf@all.your.base.are.belong.to.us>
 <87il1oedx8.fsf@all.your.base.are.belong.to.us> <CABgGipWPuvwi43v1+60-=0_MN_q_CD0ZGasxHHVWJ37cig5MmA@mail.gmail.com>
 <87msqsotr8.fsf@all.your.base.are.belong.to.us> <CABgGipUayONdvaH0nexBJUai=qT3yqURhinTbDWxORfMDQ_5pw@mail.gmail.com>
In-Reply-To: <CABgGipUayONdvaH0nexBJUai=qT3yqURhinTbDWxORfMDQ_5pw@mail.gmail.com>
From: Robbin Ehn <rehn@rivosinc.com>
Date: Mon, 25 Mar 2024 13:50:11 +0100
Message-ID: <CAEEvPLB0eVXwRxucKDtc4mG11BwueV4pk4g9Zi82MPeTaP41uw@mail.gmail.com>
Subject: Re: [RFC PATCH] riscv: Implement HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS
To: Andy Chiu <andy.chiu@sifive.com>
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Puranjay Mohan <puranjay12@gmail.com>, Mark Rutland <mark.rutland@arm.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Guo Ren <guoren@kernel.org>, Ley Foon Tan <leyfoon.tan@starfivetech.com>, 
	Deepak Gupta <debug@rivosinc.com>, Sia Jee Heng <jeeheng.sia@starfivetech.com>, 
	Bjorn Topel <bjorn@rivosinc.com>, Song Shuai <suagrfillet@gmail.com>, 
	"Cl'ement L'eger" <cleger@rivosinc.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Jisheng Zhang <jszhang@kernel.org>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Brendan Sweeney <brs@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey,

> <index-in-dispatch-list>
> func_symbol:
> auipc t0, common_dispatch:high <=3D> j actual_func:
> jalr t0, common_dispatch:low(t0)
>

If you are patching in a jump, I don't see why you wouldn't jump over
ld+jalr? (no need for common dispatch)
Patching jalr with nop, and keeping auipc, addresses the issue with
having to jump in the disabled case.
But needs either common dispatch or per func dispatch.

Thanks, Robbin

> common_dispatch:
> load t1, index + dispatch-list
> ld t1, 0(t1)
> jr t1
>
>
> >
> > > However, one thing I am not very sure is: do we need a destination
> > > address in a "per-function" manner? It seems like most of the time th=
e
> > > destination address can only be ftrace_call, or ftrace_regs_call. If
> > > the number of destination addresses is very few, then we could
> > > potentially reduce the size of
> > > <func_trace_target_data_8B_per_function>.
> >
> > Yes, we do need a per-function manner. BPF, e.g., uses
> > dynamically/JIT:ed trampolines/targets.
> >
> >
> >
> > Bj=C3=B6rn
>
> Cheers,
> Andy
