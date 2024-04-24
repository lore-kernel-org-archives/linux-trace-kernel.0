Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA6015B57E
	for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Apr 2024 13:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713964788; cv=none; b=ldxP8MCuIDSava6oTmsIbkUQ0reUMgrj6LBP0bXzkYZAiW+XUCNzPU0s9w3sINg5rCkwSx8M0QWk1Sa+wrt3EZKRJQ3rPZRPJIsTUn6He0/DMZOtlQPvejLfc6X7k8pTMWzmGcoECciHavUFKYAvJkVIiqxTT+4Onz/hcXOu4aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713964788; c=relaxed/simple;
	bh=/GQoX1gc0yl6e/Pz8zk6L9EPOwroU4wExy1cX78SnUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QyRKp3eRzczhXuUbfvbc8ZUfBP/c0zzD29oycPBqBvZe/RbpQ1HcZPj//15sM4nlR7a9ksLmyCr3uCQc6C3657yjUiDo/2bL9HrIYUYL/ZxwtnDePTbcnUXgk36jb9FLBYRToAZXaYEkn9HckliH3iuRYqZ8ipOdvWrlcPb06ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lHgApBrG; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lHgApBrG"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-6001399f22bso2444152a12.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Apr 2024 06:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713964786; x=1714569586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8VvHJ58Y+Q3UWAzWsSTTjuIwD8U8vgOkrH/9YIF6f+M=;
        b=lHgApBrG4E6j0tbQuXywkr1MB58N2Bx9nktuAzORtFE377i1FUVwrKNdg871OpwQvK
         tmBuLsubIW6D+NgNoy9IcN4PgzuKaN/7pYR36T1Bwmxfh7+2yPQn7npHwO+e/kPs2K63
         WmHL37zDXk4UHA6ztqWrVCiy4aFkqIrmHZVUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713964786; x=1714569586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8VvHJ58Y+Q3UWAzWsSTTjuIwD8U8vgOkrH/9YIF6f+M=;
        b=AaKMrs5HMG41u0zIaIGLWqZ66Jaeya8qR9c80ngQ6PhOAJ+ZFoHO2e3AD1obbISOA0
         sTaDvg84ghqienKaZ4ax4WuZjndPuGnGsrdiHt/W0Yuz8IxtOLWdNpTH01cZGWx6jXb0
         MqHxqlq5Y8+WAL3Bnp+00QAgJ6kJTZLjKZv7ViKlv9Nk6FIiCCCocmccnjEirol37sfC
         fEqtxktB52ejIlFMB5L2prCBEWcU8Sua+stNbhbU1H4tzX8ckLOGAHtoTNk9A9P8rfvY
         SaHr5QGKXOItV+9nnxD3pn3WBgespF+wenJ18G9OHjf55qh2JGs1WCE/OrO/ocqQjF48
         2WoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWycTiJ+VNO1vAP5EYU7KAJlbezsAgKqeOMwsW7PnF15xsyr7TQq3QMP3DHCQ5UxnIguAP1BZngLdQtUzg8py/bqEvvo38YZZgxbFuuBLs8BIP2
X-Gm-Message-State: AOJu0Yw3etK1CJoYUeZZ1U52DYQ5VDp3YboBVd+2Mme6N0Q6uzzv3xJL
	9y1D+M05qELH2SV0uJXOwioUFcGVoCt/1b4Uhph6NpAz1cZy9+4VKAsCIzFJAexX1Tkyu7zUR7X
	uj9E98n0TU4+NcrxNWh3qHzS1GreIEcv/fD+7
X-Google-Smtp-Source: AGHT+IEUzUPrMZm5/9Nr7/HujqEqTFgw9lpTp1RH6c+ZBPmhrdCrzL9/trH59BuNk2ibQ8CFKYuYBk72hhVixMAIZqA=
X-Received: by 2002:a17:90b:4f41:b0:2a5:275c:ed with SMTP id
 pj1-20020a17090b4f4100b002a5275c00edmr2474867pjb.23.1713964786600; Wed, 24
 Apr 2024 06:19:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171318533841.254850.15841395205784342850.stgit@devnote2>
 <171318535003.254850.2125783941049872788.stgit@devnote2> <CABRcYmK_Btem8cBbz=j==RWxw11PQ8cNAUshNA540VD3O=2WEQ@mail.gmail.com>
In-Reply-To: <CABRcYmK_Btem8cBbz=j==RWxw11PQ8cNAUshNA540VD3O=2WEQ@mail.gmail.com>
From: Florent Revest <revest@chromium.org>
Date: Wed, 24 Apr 2024 15:19:24 +0200
Message-ID: <CABRcYmK+JMLDf41csuZB4aJSb9956wTy=5rpB1YDsSv0-MoZHg@mail.gmail.com>
Subject: Re: [PATCH v9 01/36] tracing: Add a comment about ftrace_regs definition
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Sven Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alan Maguire <alan.maguire@oracle.com>, Mark Rutland <mark.rutland@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 2:23=E2=80=AFPM Florent Revest <revest@chromium.org=
> wrote:
>
> On Mon, Apr 15, 2024 at 2:49=E2=80=AFPM Masami Hiramatsu (Google)
> <mhiramat@kernel.org> wrote:
> >
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >
> > To clarify what will be expected on ftrace_regs, add a comment to the
> > architecture independent definition of the ftrace_regs.
> >
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > Acked-by: Mark Rutland <mark.rutland@arm.com>
> > ---
> >  Changes in v8:
> >   - Update that the saved registers depends on the context.
> >  Changes in v3:
> >   - Add instruction pointer
> >  Changes in v2:
> >   - newly added.
> > ---
> >  include/linux/ftrace.h |   26 ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >
> > diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> > index 54d53f345d14..b81f1afa82a1 100644
> > --- a/include/linux/ftrace.h
> > +++ b/include/linux/ftrace.h
> > @@ -118,6 +118,32 @@ extern int ftrace_enabled;
> >
> >  #ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
> >
> > +/**
> > + * ftrace_regs - ftrace partial/optimal register set
> > + *
> > + * ftrace_regs represents a group of registers which is used at the
> > + * function entry and exit. There are three types of registers.
> > + *
> > + * - Registers for passing the parameters to callee, including the sta=
ck
> > + *   pointer. (e.g. rcx, rdx, rdi, rsi, r8, r9 and rsp on x86_64)
> > + * - Registers for passing the return values to caller.
> > + *   (e.g. rax and rdx on x86_64)
>
> Ooc, have we ever considered skipping argument registers that are not
> return value registers in the exit code paths ? For example, why would
> we want to save rdi in a return handler ?
>
> But if we want to avoid the situation of having "sparse ftrace_regs"
> all over again, we'd have to split ftrace_regs into a ftrace_args_regs
> and a ftrace_ret_regs which would make this refactoring even more
> painful, just to skip a few instructions. :|
>
> I don't necessarily think it's worth it, I just wanted to make sure
> this was considered.

Ah, well, I just reached patch 22 and noticed that there you add add:

+ * Basically, ftrace_regs stores the registers related to the context.
+ * On function entry, registers for function parameters and hooking the
+ * function call are stored, and on function exit, registers for function
+ * return value and frame pointers are stored.

So ftrace_regs can be a a sparse structure then. That's fair enough with me=
! ;)
