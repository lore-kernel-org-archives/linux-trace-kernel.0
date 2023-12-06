Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DSZKvOSJ"
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16D9B5
	for <linux-trace-kernel@vger.kernel.org>; Wed,  6 Dec 2023 07:17:45 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-54da61eb366so254904a12.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 06 Dec 2023 07:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701875864; x=1702480664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zZJM1Env+eEXFazDQzwu0LsFevasaND9E0B7qCoSTyU=;
        b=DSZKvOSJKt1hcYYXh6N2a+Xk3C09d5HhpoWL/zzE+w0mQjlHdBzXfJSkBk1j8LGzWD
         6pdWFgtseulRGPC94si9TmcsA6IGoOvtPvEHEdXuPtBKGsNX1x/Qdvx8DLISME4wvZqT
         SvbWl21j3z+XUVPabn3SCNmwoweBZ+l+41eHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701875864; x=1702480664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zZJM1Env+eEXFazDQzwu0LsFevasaND9E0B7qCoSTyU=;
        b=swl56EDetiyp5URvXYiZ89oEWAcA/MLPbea/wb8Gwrvj54Y0A+qx/+qfvuKY23K6Hw
         Qvmy28/vOXTGrQS54fZ68sGBfNuPVKe7V5D6ZvWD7EIajD9CR5jsRv9mRM4hG93n6X7g
         xpykHJLJ6Xj9lXZPMStEW0I4MJgNlOhF4Uv5xza+lA4u9KZJW3zp28ztLK6M9rTjEI0b
         H8t+FNDVdFyWW5ezhrN1AeSkE0catqgn08s2RDq5v7+C4y+vg5ATVD5vpup+3KdEFiyH
         BABL+7U/4u8x0ZPT8npMNb6iECWQJAjLnePqjxvtQUnoU817b+50EryDVletDIjwuOhH
         GOSQ==
X-Gm-Message-State: AOJu0Yx2gIlSkE4EQPrx+t2Es/gwDjw2NFCx49qXRESJ+vAJ+PGPne0A
	WjKQjXQWnSAVD6O+MoK0x4dEiLrXYVdN0LO0kHaFurdk
X-Google-Smtp-Source: AGHT+IHaRJS9ASEnO6/+hEYM07JX6s7zEOIafAL0TlIrRmkO6CnZ23PQmkCmm+346aFPHiwcimnbTQ==
X-Received: by 2002:a50:c00b:0:b0:54c:b719:a8d4 with SMTP id r11-20020a50c00b000000b0054cb719a8d4mr623642edb.9.1701875863657;
        Wed, 06 Dec 2023 07:17:43 -0800 (PST)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id y16-20020aa7d510000000b0054ca16087ebsm77478edq.80.2023.12.06.07.17.43
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 07:17:43 -0800 (PST)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40b35199f94so76965e9.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 06 Dec 2023 07:17:43 -0800 (PST)
X-Received: by 2002:a05:600c:3b22:b0:40b:4355:a04b with SMTP id
 m34-20020a05600c3b2200b0040b4355a04bmr89811wms.6.1701875862555; Wed, 06 Dec
 2023 07:17:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <GV1PR10MB65635561FB160078C3744B5FE8B4A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
 <GV1PR10MB6563DC208657E86715361E94E8B4A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
 <CAD=FV=XpK0T-oPi2Q6-9jELFseSsvgkFtRuXP1LXK6PbV_MwCg@mail.gmail.com> <20231206113753.GB81045@aspen.lan>
In-Reply-To: <20231206113753.GB81045@aspen.lan>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 6 Dec 2023 07:17:25 -0800
X-Gmail-Original-Message-ID: <CAD=FV=W7K5d8Dg+W5qaB_Kg8LuzMdMFEKZ2FfFC3qp2xAPMfKA@mail.gmail.com>
Message-ID: <CAD=FV=W7K5d8Dg+W5qaB_Kg8LuzMdMFEKZ2FfFC3qp2xAPMfKA@mail.gmail.com>
Subject: Re: [PATCH 2/2] trace: kdb: Replace simple_strtoul with kstrtoul in kdb_ftdump
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Yuran Pereira <yuran.pereira@hotmail.com>, kgdb-bugreport@lists.sourceforge.net, 
	linux-trace-kernel@vger.kernel.org, jason.wessel@windriver.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Dec 6, 2023 at 3:38=E2=80=AFAM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Tue, Dec 05, 2023 at 01:41:57PM -0800, Doug Anderson wrote:
> > Hi,
> >
> > On Sun, Nov 19, 2023 at 4:10=E2=80=AFPM Yuran Pereira <yuran.pereira@ho=
tmail.com> wrote:
> > >
> > > The function simple_strtoul performs no error checking in scenarios
> > > where the input value overflows the intended output variable.
> > > This results in this function successfully returning, even when the
> > > output does not match the input string (aka the function returns
> > > successfully even when the result is wrong).
> > >
> > > Or as it was mentioned [1], "...simple_strtol(), simple_strtoll(),
> > > simple_strtoul(), and simple_strtoull() functions explicitly ignore
> > > overflows, which may lead to unexpected results in callers."
> > > Hence, the use of those functions is discouraged.
> > >
> > > This patch replaces all uses of the simple_strtoul with the safer
> > > alternatives kstrtoint and kstrtol.
> > >
> > > [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#si=
mple-strtol-simple-strtoll-simple-strtoul-simple-strtoull
> > >
> > > Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>
> > > ---
> > >  kernel/trace/trace_kdb.c | 14 ++++++--------
> > >  1 file changed, 6 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/kernel/trace/trace_kdb.c b/kernel/trace/trace_kdb.c
> > > index 59857a1ee44c..3891f885e4a6 100644
> > > --- a/kernel/trace/trace_kdb.c
> > > +++ b/kernel/trace/trace_kdb.c
> > > @@ -96,23 +96,21 @@ static int kdb_ftdump(int argc, const char **argv=
)
> > >  {
> > >         int skip_entries =3D 0;
> > >         long cpu_file;
> > > -       char *cp;
> > > +       int err;
> > >         int cnt;
> > >         int cpu;
> > >
> > >         if (argc > 2)
> > >                 return KDB_ARGCOUNT;
> > >
> > > -       if (argc) {
> > > -               skip_entries =3D simple_strtol(argv[1], &cp, 0);
> > > -               if (*cp)
> > > +       if (argc)
> > > +               if (kstrtoint(argv[1], 0, &skip_entries))
> > >                         skip_entries =3D 0;
> > > -       }
> >
> > Similar nit about braces as in patch #1. tl;dr is change the above to:
> >
> > if (argc && kstrtoint(argv[1], 0, &skip_entries))
> >   skip_entries =3D 0;
>
> Surely that should be:
>
> if (...)
>         return KDB_BADINT;
>
> There seems little point switching to a "safer" API if we just ignore the
> errors it provides us.

Ah, sure. I have no objections to that. Note that would have also been
possible with the old code, which did still do awkward error checking,
so I assumed that it was a conscious decision. ...but I'm definitely
happier with the error being reported instead of glossed over.

-Doug
