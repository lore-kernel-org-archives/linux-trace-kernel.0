Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66916177999
	for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Jun 2024 02:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718591949; cv=none; b=upulkncEfR8msfzQSaoAJ1SGBdEEvqQMEGCRiD2NIZKJWEGkA23TdmVnY6oDlZLouYJv8DY7b7UMMms0c1qNW8BX6WpviPEBpwNcC6VnZUDQy3oXf63yUJcePDxHdELCtspCwZpzJZYCfkf0uP7vdrwzr3yYHbVozS6+rA57u+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718591949; c=relaxed/simple;
	bh=K7pDmm+KuihRdNnBeqcmqK4FUXdjWwv/YZO/vwywIOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a1vKhE9QmqiLXuU1VP9mF/5xhVeG28Aw4z7I7aU4NkhKYpqVLcx96Uirpf0wSe+/Q/awkQr/BcZL0BiaW/4bdnRTH22z7xUaxGff+DYfGxJlCD78iUuuyo6c7QUsVY3r4PfouhmWl22L+BazeEnAWChryIjH8yqMla1t5JBylEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=GGXhekeG; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="GGXhekeG"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-62a2424ecb8so41537777b3.1
        for <linux-trace-kernel@vger.kernel.org>; Sun, 16 Jun 2024 19:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1718591946; x=1719196746; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RvWKRG4G4uh/VafRKr+dQcPE/37QW82H6MxcQ22NpJs=;
        b=GGXhekeG6R/OHSII3KTOT5URBT/Zv3r5QQkNwUWddyafnA/EgoJgbgTvDk6ITbneVl
         BtOaLCFUHbPkQK2dZiVyaPvplBoz/d5ESj/GBJ563OyZ0LWbssAeOERAYbsCw26UYoLw
         v5up4lyszNguYjjB1Mv9tmSB3eYlD5Hb3y62vkfn4uxM1Wf2x8VQ+GJPBpX0YbAc8Yl5
         bpdXZTTLsglxIWBOlj0xBddDg8MynDlZLFCPo34xZhc4gUgnQur4s+ZBQtiAJlIJC5Uz
         4dc/R527x+9V2dXCTsbWxFaijBXIcSrjOxXaRlt0hjUgt/Ixy/7Ah/HRdUO0BvgTawx1
         q52Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718591946; x=1719196746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RvWKRG4G4uh/VafRKr+dQcPE/37QW82H6MxcQ22NpJs=;
        b=Sx3ZErlA9upaDTOcTjTnaDH/4wVZCFOLhvyMR+BTjOgTrL5vAOfP1ABhfffPqNqgCf
         7qnOJL8fUGu2TDMING3gSjLeptvDNc7dufo+3fgx+vml/F0Hf45vhl2m4qjnMmTTKGZ7
         M1QtudshdKUNWNCbEdSBTc7Um3R0Y3bMno8slII7ub135PlQWYlYSU2shAIkkOEBN56f
         qiyAPViZyYXOXu2UrqfUdLrfZDoWCAQyswtHh070XQH+/hvFXOAfANN7+OAW6JYyXFuB
         qGpomUBsSI3yvQ3pYid0oFqU41gRurkqqvK1/UC2QcH7BOHExfOhtI0qVZI7+iBwm9db
         Mu/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUp2JMlZA+FRrN6PJZuy2Z2C3j9gTfinxn+OypWtS1T7SjbsHi+OWa3RAznGPyDNhBavcdgRkfu7O4E6iPo4NCyJBuNpCR7QX1qAJ3gdWikvKZL
X-Gm-Message-State: AOJu0YxR7OaePkRTWxPXBj2Cgg5SzeEyfQQiXJAOlA4Cm55SuZloy04z
	IKeuSoE2dkA84ldNLgX0gkVLZmI326wrqSkCFEbsjKxWVj0cZxjv7h99q7U6HmWBaxO3PtPR9Ko
	6QsVb5oQuEbE0MTesSaDzTY5cY9hXcjmpNw0a3w==
X-Google-Smtp-Source: AGHT+IGx5gyoe+gPzQWT+v+p8579+Wzzy0Rc6gNG/13H/HestUrQLJhhbdrIOQVQ4ELHkFaMdUbQlF19+HnvPT5nnBA=
X-Received: by 2002:a25:b19b:0:b0:dfe:5a00:df5c with SMTP id
 3f1490d57ef6-dff153a6620mr8483209276.18.1718591946340; Sun, 16 Jun 2024
 19:39:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613-dev-andyc-dyn-ftrace-v4-v1-0-1a538e12c01e@sifive.com>
 <20240613-dev-andyc-dyn-ftrace-v4-v1-4-1a538e12c01e@sifive.com> <20240613190920.GB1272931@thelio-3990X>
In-Reply-To: <20240613190920.GB1272931@thelio-3990X>
From: Andy Chiu <andy.chiu@sifive.com>
Date: Mon, 17 Jun 2024 10:38:55 +0800
Message-ID: <CABgGipV_6sFx8TJNrHszGLk=V9X1PJAXuOmRDxnTHPrigqJL0A@mail.gmail.com>
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

On Fri, Jun 14, 2024 at 3:09=E2=80=AFAM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> Hi Andy,
>
> On Thu, Jun 13, 2024 at 03:11:09PM +0800, Andy Chiu wrote:
> > We are changing ftrace code patching in order to remove dependency from
> > stop_machine() and enable kernel preemption. This requires us to align
> > functions entry at a 4-B align address.
> >
> > However, -falign-functions on older versions of GCC alone was not stron=
g
> > enoungh to align all functions. In fact, cold functions are not aligned
> > after turning on optimizations. We consider this is a bug in GCC and
> > turn off guess-branch-probility as a workaround to align all functions.
> >
> > GCC bug id: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D88345
> >
> > The option -fmin-function-alignment is able to align all functions
> > properly on newer versions of gcc. So, we add a cc-option to test if
> > the toolchain supports it.
> >
> > Suggested-by: Evgenii Shatokhin <e.shatokhin@yadro.com>
> > Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
> > ---
> >  arch/riscv/Kconfig  | 1 +
> >  arch/riscv/Makefile | 7 ++++++-
> >  2 files changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index b94176e25be1..80b8d48e1e46 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -203,6 +203,7 @@ config CLANG_SUPPORTS_DYNAMIC_FTRACE
> >  config GCC_SUPPORTS_DYNAMIC_FTRACE
> >       def_bool CC_IS_GCC
> >       depends on $(cc-option,-fpatchable-function-entry=3D8)
> > +     depends on $(cc-option,-fmin-function-alignment=3D4) || !RISCV_IS=
A_C
>
> Please use CC_HAS_MIN_FUNCTION_ALIGNMENT (from arch/Kconfig), which
> already checks for support for this option.

Thanks for the suggestion!

>
> >  config HAVE_SHADOW_CALL_STACK
> >       def_bool $(cc-option,-fsanitize=3Dshadow-call-stack)
> > diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> > index 06de9d365088..74628ad8dcf8 100644
> > --- a/arch/riscv/Makefile
> > +++ b/arch/riscv/Makefile
> > @@ -14,8 +14,13 @@ endif
> >  ifeq ($(CONFIG_DYNAMIC_FTRACE),y)
> >       LDFLAGS_vmlinux +=3D --no-relax
> >       KBUILD_CPPFLAGS +=3D -DCC_USING_PATCHABLE_FUNCTION_ENTRY
> > +ifeq ($(CONFIG_CC_IS_CLANG),y)
>
> Same here, please invert this and use
>
>   ifdef CONFIG_CC_HAS_MIN_FUNCTION_ALIGNMENT
>
> like the main Makefile does.

Hope this makes sense to you. I am going to add the following in riscv Kcon=
ig:

select FUNCTION_ALIGNMENT_4B if DYNAMIC_FTRACE && !RISCV_ISA_C

So we will not need any of these

>
> > +     cflags_ftrace_align :=3D -falign-functions=3D4
> > +else
> > +     cflags_ftrace_align :=3D -fmin-function-alignment=3D4
> > +endif
> >  ifeq ($(CONFIG_RISCV_ISA_C),y)
> > -     CC_FLAGS_FTRACE :=3D -fpatchable-function-entry=3D4
> > +     CC_FLAGS_FTRACE :=3D -fpatchable-function-entry=3D4 $(cflags_ftra=
ce_align)
> >  else
> >       CC_FLAGS_FTRACE :=3D -fpatchable-function-entry=3D2
> >  endif
> >
> > --
> > 2.43.0
> >
> >

Thanks,
Andy
