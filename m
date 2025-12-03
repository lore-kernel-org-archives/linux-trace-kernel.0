Received: from mail-yx1-f65.google.com (mail-yx1-f65.google.com [74.125.224.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F322BEC2C
	for <linux-trace-kernel@vger.kernel.org>; Wed,  3 Dec 2025 09:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764753369; cv=none; b=AhyNOMwS6+VkVdQZh2HrX7nDsCvLAryCUgYiXKsweZkexjkAu9qt+imtNJOdfv0VaDPcmg44cwa0BElwOLV9zjFNkokuNL1S+Sl3BCgFVWkooey8K9FWB2V46uUVICYz8h4qBzNN9328vWVPgBLtCd36WSOEgXUn+5XEyUf+UB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764753369; c=relaxed/simple;
	bh=PJbfPpXQ1Wl4+h8UE/xMewyCcGHvABOB4dS4pDUJ9yI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WQZOZRLXGx5wXbA38LPrO1DW0mE5UCSb/dGmw35km9i0eS/zHMKOFIkckV3fdQrvX6x1jIEeJbn42IcghqtJ2rcXlzYbXpOkqDdDsDTBA+/7JliFA2a2DqsG2cb1+O4n3mJaqDGkyJOIncfxXfThzLPOTit+ZanZrSVr2DtY5/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ltbo4otk; arc=none smtp.client-ip=74.125.224.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ltbo4otk"
Received: by mail-yx1-f65.google.com with SMTP id 956f58d0204a3-63f96d5038dso5648925d50.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 03 Dec 2025 01:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764753363; x=1765358163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zvn9HrRJdFSvUw/pGaMaIOGegy9462R/6im+1ui/l3U=;
        b=Ltbo4otkpZ6vrWK80nWypID3gJBW1UaBq7N/d3axa+G5fAIzWwGsROXgf+T6BsGmE9
         YpAHb8IIdJwsUtSk4uJCMLL5WhFKZinwV2xNBLIRDDfBbeOBPWxODB586r32gPC9wYJD
         gL+qRzidaAm4Zz4wpVfjnMmC0jHyz4LKOd5VM3wFIq6ljki5jGZP88T1mdonIvU+j9GM
         pNgvfFGUsm8EJ0RzZVEsAuxD8iy/amNeyb3B+YfydkTS8qaHRgN9iYAfrWiXSQ8ckOe6
         TclgjUaSbBrI+HayVX80bcwO210hGJKSNvz3+/br3IvkyuOA5XB5eH+hEZi/bAOQ+Bq9
         g+7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764753363; x=1765358163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zvn9HrRJdFSvUw/pGaMaIOGegy9462R/6im+1ui/l3U=;
        b=aBs58gMuzAMO/VWgcmkE+X9WkVqWN5pl3TwNn43fuNDT43Q0guV5xVwTPW11obq3uQ
         9h/K1hSmki/7d4rEVB6sDWpaxlRt0gMgl00OLe8HYkSUCNkiszhiOf122DgTf3N7YBa6
         vS2haV7RH8NkxUhTEar55qxfxxp8Cx4PcGP7AyJtNDWM/70pKH9Dyq56FJzhA9OuAtyj
         sAB6SfWAgLdbe+/FgBM+tqqOHEidYPR7fF2RcebhEewhthe8PCO527axYU4kCM6W6sGr
         KwkTWJLi/DJC9XQpwACSzWl1CVEqZoqX3g+Wg9V/8/hrJjJVIEsSTesj5R+PXXVxRFKf
         P41w==
X-Forwarded-Encrypted: i=1; AJvYcCVQkTCmbe5yBlNERcUNtbcVtoFzDSIspOQXQUTSwNOOqwWYXqjUkvlrFmwGIO7vOX7AMHSrrBhjsanmUMdgDzAJe1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoXBEYVp+GdMoja/IVwdAIgdXwYDib4s2aSSBBCnKqUidKMsWq
	2GYeWfDuMS+tk/E3/mKDJG39rw2jocNHtqoWGZdRzBGlr6DAJ+rjddNNIhMGTgHkI93nIT+nVyh
	gfacioZ5Ih8u0JqSbvdSkyNo0y/KyLYw=
X-Gm-Gg: ASbGnctLdGcdL0bguRTi8YheMqGqglVreDQELB09km+DiBxMy7r3ELDcszrLuNEdoV7
	05j2Xj9Fb6JSSTlGjIlKicpUcJ/S4LicjtqwErBSnSlFTlX3RZzah6UjaEogu219oklaPD4j0ez
	XsglFLAs3S0jGmlAmCFrWhHD3i+EwH6v2dwoblZgnX3Fle0uj0Ask/9jJAvfw+IT25dOboWZj/Q
	fnl8hRXvnPfaxtHyaCsK2Aa4VMZjA87XKO2kgTyZDFPHB2IjLPrJQJ573pVRKFdr6iqLrI=
X-Google-Smtp-Source: AGHT+IGzwDFZDWme46YAnVAYHhM1JFHKL7Q/q8FoGtyn85xl72liVPRXP4MJCYeiDce1hUNnHIbvdVJiL9cFbDX/sAY=
X-Received: by 2002:a05:690e:120e:b0:63f:b545:9960 with SMTP id
 956f58d0204a3-64436f6da37mr1340803d50.11.1764753363482; Wed, 03 Dec 2025
 01:16:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203082402.78816-1-jolsa@kernel.org> <20251203082402.78816-2-jolsa@kernel.org>
In-Reply-To: <20251203082402.78816-2-jolsa@kernel.org>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Wed, 3 Dec 2025 17:15:52 +0800
X-Gm-Features: AWmQ_bmG0tIamKx5RfhXBBYAUrUfUZzFDuU-aYWqrSdiQGfV8mSCyiAygQcVpgo
Message-ID: <CADxym3awpEbMiSKE5aDcyd2Cg1Cdo7++SLAMSuZmaggt3BSbUA@mail.gmail.com>
Subject: Re: [PATCHv4 bpf-next 1/9] ftrace,bpf: Remove FTRACE_OPS_FL_JMP
 ftrace_ops flag
To: Jiri Olsa <jolsa@kernel.org>
Cc: Steven Rostedt <rostedt@kernel.org>, Florent Revest <revest@google.com>, 
	Mark Rutland <mark.rutland@arm.com>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025 at 4:24=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote:
>
> At the moment the we allow the jmp attach only for ftrace_ops that
> has FTRACE_OPS_FL_JMP set. This conflicts with following changes
> where we use single ftrace_ops object for all direct call sites,
> so all could be be attached via just call or jmp.
>
> We already limit the jmp attach support with config option and bit
> (LSB) set on the trampoline address. It turns out that's actually
> enough to limit the jmp attach for architecture and only for chosen
> addresses (with LSB bit set).
>
> Each user of register_ftrace_direct or modify_ftrace_direct can set
> the trampoline bit (LSB) to indicate it has to be attached by jmp.
>
> The bpf trampoline generation code uses trampoline flags to generate
> jmp-attach specific code and ftrace inner code uses the trampoline
> bit (LSB) to handle return from jmp attachment, so there's no harm
> to remove the FTRACE_OPS_FL_JMP bit.
>
> The fexit/fmodret performance stays the same (did not drop),
> current code:
>
>   fentry         :   77.904 =C2=B1 0.546M/s
>   fexit          :   62.430 =C2=B1 0.554M/s
>   fmodret        :   66.503 =C2=B1 0.902M/s
>
> with this change:
>
>   fentry         :   80.472 =C2=B1 0.061M/s
>   fexit          :   63.995 =C2=B1 0.127M/s
>   fmodret        :   67.362 =C2=B1 0.175M/s
>
> Fixes: 25e4e3565d45 ("ftrace: Introduce FTRACE_OPS_FL_JMP")
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/linux/ftrace.h  |  1 -
>  kernel/bpf/trampoline.c | 32 ++++++++++++++------------------
>  kernel/trace/ftrace.c   | 14 --------------
>  3 files changed, 14 insertions(+), 33 deletions(-)
>
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index 015dd1049bea..505b7d3f5641 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -359,7 +359,6 @@ enum {
>         FTRACE_OPS_FL_DIRECT                    =3D BIT(17),
>         FTRACE_OPS_FL_SUBOP                     =3D BIT(18),
>         FTRACE_OPS_FL_GRAPH                     =3D BIT(19),
> -       FTRACE_OPS_FL_JMP                       =3D BIT(20),

Yeah, the FTRACE_OPS_FL_JMP is not necessary. I added
it in case that we maybe want to implement such "jmp" for
ftrace trampoline in the feature. But it's OK to remove it now.

>  };
>
>  #ifndef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index 976d89011b15..b9a358d7a78f 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -214,10 +214,15 @@ static int modify_fentry(struct bpf_trampoline *tr,=
 u32 orig_flags,
>         int ret;
>
>         if (tr->func.ftrace_managed) {
> +               unsigned long addr =3D (unsigned long) new_addr;
> +
> +               if (bpf_trampoline_use_jmp(tr->flags))
> +                       addr =3D ftrace_jmp_set(addr);

nit: It seems that we can remove the variable "addr" can use
the "new_addr" directly?

> +
>                 if (lock_direct_mutex)
> -                       ret =3D modify_ftrace_direct(tr->fops, (long)new_=
addr);
> +                       ret =3D modify_ftrace_direct(tr->fops, addr);
>                 else
> -                       ret =3D modify_ftrace_direct_nolock(tr->fops, (lo=
ng)new_addr);
> +                       ret =3D modify_ftrace_direct_nolock(tr->fops, add=
r);
>         } else {
>                 ret =3D bpf_trampoline_update_fentry(tr, orig_flags, old_=
addr,
>                                                    new_addr);
> @@ -240,10 +245,15 @@ static int register_fentry(struct bpf_trampoline *t=
r, void *new_addr)
>         }
>
>         if (tr->func.ftrace_managed) {
> +               unsigned long addr =3D (unsigned long) new_addr;
> +
> +               if (bpf_trampoline_use_jmp(tr->flags))
> +                       addr =3D ftrace_jmp_set(addr);

And here.

Thanks!
Menglong Dong

> +
[...]
>
