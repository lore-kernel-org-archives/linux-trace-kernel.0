Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394A117BB22
	for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Jun 2024 03:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718594006; cv=none; b=HO48PN/R2wdSCqwSLFQKa8TFI3U6urjVtd1wl1P5Cg6ntwtRIgLYXu/y/+pOwHsyB0Ejg4nLjNbaFYZjXBWqD9vU44Mn/9g/SBr0B9dzBOFO5Hc2u/2TiW3BiHwT7tmgiNspFMq3Q5pT8r9JbF5/iheWv9E2jsd0wo+iZINQclQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718594006; c=relaxed/simple;
	bh=ipKCaT77f+BUWT9EBLkbLtp2pj7mmowaKj2ZBqhLeeM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QBPyJ10ZnohUsCPh7FvJ5KKQEFVgBCFDqCs3sqJ2ZfcwOFNXJsVHwjVS9w+sZyfKJNoCQ3tfHo3XGJl+S5C2tDegTaZi5YutROp4Zs7kwYsMxHaYYlFXnqqXX2Pqo29BYM0vw9/PVE8dSzxDOOdDUVdRbUI8SUmF1ObjraswzPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=gTRFCI6l; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="gTRFCI6l"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-62ffc495935so41628197b3.1
        for <linux-trace-kernel@vger.kernel.org>; Sun, 16 Jun 2024 20:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1718594004; x=1719198804; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MTUZ05e6Yum4t2GwgWWjL5msqoEXhl4LpMNkyudXVSA=;
        b=gTRFCI6lrebc8ayFGC2fYAYVobfBfBbDZgFshWalvmzKMkG0qUfainAU/4zFHlxQxC
         JHNZ9YFXpH2A5uKt7pHTItasPGniCanTEJ4vuaI+MG6sJpKDvwQDUn1cPP3p6TEQ84+M
         TVDgRo+OubAFnldcmrHIZM64MqeTgjGZyZ54Twluibk1mAqig0fCeFdrq4YkgeD7I3M5
         SmADpbobRolQB/pJu55PJO9G2EpQfa6wx9ZbrGLKSc4yYTnE6ACOO+aPFm+Vc6xbqNSs
         22NTl/20jIUN7RXyUf2tOeFHJpmhh47hmBd88HNk0oKZ5VHOst9az3UdBrlr+gRizbjx
         qgmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718594004; x=1719198804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MTUZ05e6Yum4t2GwgWWjL5msqoEXhl4LpMNkyudXVSA=;
        b=LkhdI07yAc7+j5EUlCq9xCAfr6AEXoYSZ1ohgB4LpL8aALG/OB4T6nE0hEQEX9FRac
         vnD27C36Ok1Uq2oPWcsrIjEA6M11UblrokOwJVTVDiMRo+txEh57XQeA5yS2U6HGJSAy
         4OOXxtYGj6BXnPYOrp1V1BFDR8gfKm80PmvzwmHCyGVkJrdKn3B031fNsudJeUY0b7vN
         655vr8B91VWKiWeZcwxRisXxdBimGvAyUG6/P7ugKy0DfAcjaAvUdGZaTlmF/Sll53bC
         vzS2jN3HcDTtwirV+v82+Qu3WriRzbKTuEQiCTscUQCvzFDf6yWJbuqteVX/9bCWFdiS
         rEGA==
X-Forwarded-Encrypted: i=1; AJvYcCUzIb+CPdeoWsf7gJuAVG8COKNVk0noyx4pXLzVplxPqVQNedz5baM1jkou9rIY9DyKd5c3hWxNnf+jlovP1oP6OrIBSEcfJIqqoB3JG10bKNqA
X-Gm-Message-State: AOJu0Ywr0ds5XBtA5sl64HGFmpgkqOuMVsPbYh/UJ0MZ5N3DF/VFNF4/
	jZ2JslX/w8CFa/MCVrE3bEHvj6RaXCgSUOGLvvV8eHTNujXEm89oKbu8c2pK88ilM0foHlXqucw
	XmLkx1XqglwJmg3rxgVwjuplw7aXFw780y5TYcVLjOIpxGCXWzu8=
X-Google-Smtp-Source: AGHT+IGcbuDhr//ejMFGoqLnDmcjq65GRM5Khv3QI8grXciiziqO38Mc6HPFBs3lKXswm9MpPGZCzPb1AOhqda4ES4M=
X-Received: by 2002:a0d:e648:0:b0:627:ecd3:6223 with SMTP id
 00721157ae682-6322480e9e1mr84249517b3.35.1718594004136; Sun, 16 Jun 2024
 20:13:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613-dev-andyc-dyn-ftrace-v4-v1-0-1a538e12c01e@sifive.com>
 <20240613-dev-andyc-dyn-ftrace-v4-v1-4-1a538e12c01e@sifive.com>
 <20240613190920.GB1272931@thelio-3990X> <CABgGipV_6sFx8TJNrHszGLk=V9X1PJAXuOmRDxnTHPrigqJL0A@mail.gmail.com>
In-Reply-To: <CABgGipV_6sFx8TJNrHszGLk=V9X1PJAXuOmRDxnTHPrigqJL0A@mail.gmail.com>
From: Andy Chiu <andy.chiu@sifive.com>
Date: Mon, 17 Jun 2024 11:13:13 +0800
Message-ID: <CABgGipXqZe5GTNNe0oRBPBaFqRYF7LLZsdhQQ9RSuXqk7+cukA@mail.gmail.com>
Subject: Re: [PATCH 4/8] riscv: ftrace: align patchable functions to 4 Byte boundary
To: Nathan Chancellor <nathan@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Zong Li <zong.li@sifive.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Puranjay Mohan <puranjay@kernel.org>, 
	Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, Evgenii Shatokhin <e.shatokhin@yadro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry for the noise,

On Mon, Jun 17, 2024 at 10:38=E2=80=AFAM Andy Chiu <andy.chiu@sifive.com> w=
rote:
>
> On Fri, Jun 14, 2024 at 3:09=E2=80=AFAM Nathan Chancellor <nathan@kernel.=
org> wrote:
> >
> > Hi Andy,
> >
> > On Thu, Jun 13, 2024 at 03:11:09PM +0800, Andy Chiu wrote:
> > > We are changing ftrace code patching in order to remove dependency fr=
om
> > > stop_machine() and enable kernel preemption. This requires us to alig=
n
> > > functions entry at a 4-B align address.
> > >
> > > However, -falign-functions on older versions of GCC alone was not str=
ong
> > > enoungh to align all functions. In fact, cold functions are not align=
ed
> > > after turning on optimizations. We consider this is a bug in GCC and
> > > turn off guess-branch-probility as a workaround to align all function=
s.
> > >
> > > GCC bug id: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D88345
> > >
> > > The option -fmin-function-alignment is able to align all functions
> > > properly on newer versions of gcc. So, we add a cc-option to test if
> > > the toolchain supports it.
> > >
> > > Suggested-by: Evgenii Shatokhin <e.shatokhin@yadro.com>
> > > Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
> > > ---
> > >  arch/riscv/Kconfig  | 1 +
> > >  arch/riscv/Makefile | 7 ++++++-
> > >  2 files changed, 7 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > index b94176e25be1..80b8d48e1e46 100644
> > > --- a/arch/riscv/Kconfig
> > > +++ b/arch/riscv/Kconfig
> > > @@ -203,6 +203,7 @@ config CLANG_SUPPORTS_DYNAMIC_FTRACE
> > >  config GCC_SUPPORTS_DYNAMIC_FTRACE
> > >       def_bool CC_IS_GCC
> > >       depends on $(cc-option,-fpatchable-function-entry=3D8)
> > > +     depends on $(cc-option,-fmin-function-alignment=3D4) || !RISCV_=
ISA_C
> >
> > Please use CC_HAS_MIN_FUNCTION_ALIGNMENT (from arch/Kconfig), which
> > already checks for support for this option.
>
> Thanks for the suggestion!
>
> >
> > >  config HAVE_SHADOW_CALL_STACK
> > >       def_bool $(cc-option,-fsanitize=3Dshadow-call-stack)
> > > diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> > > index 06de9d365088..74628ad8dcf8 100644
> > > --- a/arch/riscv/Makefile
> > > +++ b/arch/riscv/Makefile
> > > @@ -14,8 +14,13 @@ endif
> > >  ifeq ($(CONFIG_DYNAMIC_FTRACE),y)
> > >       LDFLAGS_vmlinux +=3D --no-relax
> > >       KBUILD_CPPFLAGS +=3D -DCC_USING_PATCHABLE_FUNCTION_ENTRY
> > > +ifeq ($(CONFIG_CC_IS_CLANG),y)
> >
> > Same here, please invert this and use
> >
> >   ifdef CONFIG_CC_HAS_MIN_FUNCTION_ALIGNMENT
> >
> > like the main Makefile does.
>
> Hope this makes sense to you. I am going to add the following in riscv Kc=
onig:
>
> select FUNCTION_ALIGNMENT_4B if DYNAMIC_FTRACE && !RISCV_ISA_C

This should be:

select FUNCTION_ALIGNMENT_4B if DYNAMIC_FTRACE && RISCV_ISA_C

as RISCV_ISA_C =3D=3D y means that there are 2B instructions. In this
case, functions can be non 4B aligned, so we need to enforce the
alignment requirement from the compiler.

>
> So we will not need any of these
>
> >
> > > +     cflags_ftrace_align :=3D -falign-functions=3D4
> > > +else
> > > +     cflags_ftrace_align :=3D -fmin-function-alignment=3D4
> > > +endif
> > >  ifeq ($(CONFIG_RISCV_ISA_C),y)
> > > -     CC_FLAGS_FTRACE :=3D -fpatchable-function-entry=3D4
> > > +     CC_FLAGS_FTRACE :=3D -fpatchable-function-entry=3D4 $(cflags_ft=
race_align)
> > >  else
> > >       CC_FLAGS_FTRACE :=3D -fpatchable-function-entry=3D2
> > >  endif
> > >
> > > --
> > > 2.43.0
> > >
> > >
>
> Thanks,
> Andy
