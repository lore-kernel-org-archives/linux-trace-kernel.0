Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612B21D8E1D
	for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Oct 2024 22:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729895518; cv=none; b=YlKeqsjeEju62ZcxBppyJ+5xI0/TkhsPRsaqVAQvazakvG3czsqWxYVpt9AmVRKahFkAoW6cSxYr5u78HW730buivYrnzLtcw+GphCQf4WZMCVeyKh9QQlfBccbKS61wf0xIapbvCxe1WgCvaGVDDcxy8gHCz4CxftxGy5wspDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729895518; c=relaxed/simple;
	bh=Pmgxmkz/+mibX3Vvf+b416HY3mbxrWVnMpirkRa95Xc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ARSqt9A3SnYasMJ8kTlRGy01QfUVIv6f4YDLb+f+7WzVfi3ugQMIPcatGF3qNIvLUfvzHzBKSSjfGBEaxkpZQdFVHsvUoQbCKZUP6b30KMQLNJS3C6rhJwFK5J+e29rIAkPiHfZzcbxc7iHVX8qVkjWf89c3j0TrQEbTnuPk3wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QSphtebK; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QSphtebK"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539ebb5a20aso2725331e87.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Oct 2024 15:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729895513; x=1730500313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+pu9+IFniI0vxwrFMTIumDSK37smBdwK2XEoZEbtTA=;
        b=QSphtebKM8aODZk1jtYghcstp4wQz8TY5tWSi2aSXn3fW3yTxGlvtsqP723o89UnJn
         O8am9o9uvAyldO5hkOEeWWijoAokcB+m4tPVn6CkIvm60lwp4FrYFP0mCD3qtq3KSon3
         4YkrYPLOCYYcLFH0+BEjc6EVuHYn2Jd4EvRZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729895513; x=1730500313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N+pu9+IFniI0vxwrFMTIumDSK37smBdwK2XEoZEbtTA=;
        b=ZP1ERb8Lt0+/I9JjaRAPKklhU5S6GlDwOh8fBPo6frv/CIs0I11MN8rfO7nlo88DsM
         2KoxkmVm6Xi3uLwA1kjtC9lWLnQur93wO/QPoRtaD5lgQcnW6b7j8by5txPtZ0mzwClG
         ar2S+fopNy0gn5GXsf6pzRTKAdZ+Tej7AIPLKkdVAFu4H09DxchA3Pqgp0JsEXbKBNEI
         aTSFEDRKtMxbtIXL+JpqYA5q0nJCaVgk4lO9IJs6vtwqsrmjanb0PZavVuCaz5t/Tty1
         o8WOQNzzGBgSdHssrFuF2dQT2r8s0l6FSKhH1uji+FdEux8pBYZQs141WWmbm+JYwCYu
         wkpg==
X-Forwarded-Encrypted: i=1; AJvYcCW13NQ1C+8+tekae9mItR3rGilhg9mypPmS0e8/8G+ItupL9smc3tRjO4lIx+2JW+k6D8jqdN9L3P/BIt4bu5djK9E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw13JRV5IHNtjsUCqc5qAB4M8MSY805SW1QGR7yCLccpuGiWdyB
	udnOiGdGYcnIwREKcZnSZksVrMZAVCx2D6/N2GXlRplhgE3sT9fAe+BOcku0dT5AW0rZEzKVqOU
	LvQ==
X-Google-Smtp-Source: AGHT+IEmudRe4VLiKkic4H5igM9vViC0NzY56jSvhV2Eg4Ie5SWU7vYJmpvsP2MfuVvuuJbvUKgocQ==
X-Received: by 2002:a05:6512:118e:b0:536:a533:c03a with SMTP id 2adb3069b0e04-53b348cf91amr374703e87.17.1729895513293;
        Fri, 25 Oct 2024 15:31:53 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e1df2fesm326499e87.251.2024.10.25.15.31.51
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 15:31:52 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fb3da341c9so26740551fa.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Oct 2024 15:31:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWAj8cViOFXRtu1MxU/HpHPQABN60Zrq6zdXzb0rfmfM8NeEEPkGmTqex2kBDQ3Bv77r7OV5uwtthav0UzKUElDsyw=@vger.kernel.org
X-Received: by 2002:a2e:612:0:b0:2fa:d4ef:f222 with SMTP id
 38308e7fff4ca-2fcbe0a8fa2mr2908991fa.38.1729895511516; Fri, 25 Oct 2024
 15:31:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021211724.GC835676@lichtman.org>
In-Reply-To: <20241021211724.GC835676@lichtman.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 25 Oct 2024 15:31:34 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X+sGVF91WFDpB9cdXboCnL1NX6nZ4z2qE_ctYqZ0sNkw@mail.gmail.com>
Message-ID: <CAD=FV=X+sGVF91WFDpB9cdXboCnL1NX6nZ4z2qE_ctYqZ0sNkw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] trace: kdb: Replace simple_strtoul with kstrtoul
 in kdb_ftdump
To: Nir Lichtman <nir@lichtman.org>
Cc: kgdb-bugreport@lists.sourceforge.net, linux-trace-kernel@vger.kernel.org, 
	yuran.pereira@hotmail.com, jason.wessel@windriver.com, 
	daniel.thompson@linaro.org, rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 21, 2024 at 2:17=E2=80=AFPM Nir Lichtman <nir@lichtman.org> wro=
te:
>
> The function simple_strtoul performs no error checking in scenarios
> where the input value overflows the intended output variable.
> This results in this function successfully returning, even when the
> output does not match the input string (aka the function returns
> successfully even when the result is wrong).
>
> Or as it was mentioned [1], "...simple_strtol(), simple_strtoll(),
> simple_strtoul(), and simple_strtoull() functions explicitly ignore
> overflows, which may lead to unexpected results in callers."
> Hence, the use of those functions is discouraged.
>
> This patch replaces all uses of the simple_strtoul with the safer
> alternatives kstrtoint and kstrtol.
>
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#simple=
-strtol-simple-strtoll-simple-strtoul-simple-strtoull
>
> Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>
> Signed-off-by: Nir Lichtman <nir@lichtman.org>

I have the same comments as patch #1 about authorship and noting what
you changed.


> ---
>  kernel/trace/trace_kdb.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/trace/trace_kdb.c b/kernel/trace/trace_kdb.c
> index 59857a1ee44c..eadda6e05526 100644
> --- a/kernel/trace/trace_kdb.c
> +++ b/kernel/trace/trace_kdb.c
> @@ -96,23 +96,20 @@ static int kdb_ftdump(int argc, const char **argv)
>  {
>         int skip_entries =3D 0;
>         long cpu_file;
> -       char *cp;
> +       int err;
>         int cnt;
>         int cpu;
>
>         if (argc > 2)
>                 return KDB_ARGCOUNT;
>
> -       if (argc) {
> -               skip_entries =3D simple_strtol(argv[1], &cp, 0);
> -               if (*cp)
> -                       skip_entries =3D 0;
> -       }
> +       if (argc && kstrtoint(argv[1], 0, &skip_entries))
> +               return KDB_BADINT;
>
>         if (argc =3D=3D 2) {
> -               cpu_file =3D simple_strtol(argv[2], &cp, 0);
> -               if (*cp || cpu_file >=3D NR_CPUS || cpu_file < 0 ||
> -                   !cpu_online(cpu_file))
> +               err =3D kstrtol(argv[2], 0, &cpu_file);
> +               if (err || cpu_file >=3D NR_CPUS || cpu_file < 0 ||
> +                       !cpu_online(cpu_file))

FWIW, this is still changing the indentation of the second line in a
way that makes it worse list like v1 did [1]. :-P The "!" in "!cpu_"
should line up right under the "e" in "err".

That's a pretty tiny nit, so I'm OK with:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

When sending v3 you'd want to keep Masami's Acked-by tag and my
Reviewed-by tag. They should go just above your Signed-off-by tag.
