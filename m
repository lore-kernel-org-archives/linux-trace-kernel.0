Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="APSnabA4"
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB3F1B1
	for <linux-trace-kernel@vger.kernel.org>; Tue,  5 Dec 2023 13:42:13 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-67ab19339b4so24789226d6.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 05 Dec 2023 13:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701812531; x=1702417331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6YS5yNlvl+FKFyGS3DIWxbNX8VWKvkEW8slTswnooc=;
        b=APSnabA4fbMPiUy+Z1Ba2nYOftClJzzqtuBcFXY1QJ2+KJFcg7NpyWXfOI3ZaZCsFh
         a+QxWfioKpgObJ95pJFLvzD7h5JLW3v2zulY+bLquyxSK879g5tqrY6qYdl7NKDjTxmC
         D8uikSoo1bW5mVwA9jgDJFX+IN/dajC7zlHoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701812531; x=1702417331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q6YS5yNlvl+FKFyGS3DIWxbNX8VWKvkEW8slTswnooc=;
        b=XqDOHglXjJROAdLEfxWI8PdBLyVbINnc+BKJ4MKzSxSZp/yvSPq0stOMfmOjtUpgM2
         P9BZwpqFeHa/x6mMswFKTUEzSstsdd5iimtVenTDy8PnLlKtmLCuxEqzAnLMf4+HMOea
         YHpeUimFERqB1sfkX6fu+Ool8O6iBkI+Ej3JZlGlZvSr9UyhnqnNxJPhd1somATGxHIy
         PVPYQfBsjA23aXekSiqxUWvbjFkZiO4VhMDJzBMgjJrw4eYYLhCU5N+iDzULV+n0HkSM
         g2LlnY3Y1hFXMyJbYtpmT6HGrjMTnKs14aqGKB5uQhcrhoY4e454NgtVruRAo4xra8uu
         pSAw==
X-Gm-Message-State: AOJu0Yy9tjXypixKmESnRpbpkhoXrHWQNZm8eMpzz3Fe3LLEZ13cCuEJ
	sex4ZpfwuSYbB/r2raOZ+1NuSf38CYtM9aGKC0E9ISSC
X-Google-Smtp-Source: AGHT+IH9vZBhCqXYZ4sqF+0TCtO2uYF0GmCgXcsbGnsD7AqeeVmrRL5YnmdIbpzFDjZGmpLHirrotg==
X-Received: by 2002:a05:6214:118c:b0:67a:b4ed:fb1 with SMTP id t12-20020a056214118c00b0067ab4ed0fb1mr1737187qvv.22.1701812531400;
        Tue, 05 Dec 2023 13:42:11 -0800 (PST)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com. [209.85.160.174])
        by smtp.gmail.com with ESMTPSA id y15-20020a0c8ecf000000b0067ac2490d95sm2353502qvb.136.2023.12.05.13.42.10
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 13:42:10 -0800 (PST)
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-423e04781d3so96281cf.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 05 Dec 2023 13:42:10 -0800 (PST)
X-Received: by 2002:a05:622a:4ce:b0:425:4823:f9a3 with SMTP id
 q14-20020a05622a04ce00b004254823f9a3mr60587qtx.2.1701812530294; Tue, 05 Dec
 2023 13:42:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <GV1PR10MB65635561FB160078C3744B5FE8B4A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
 <GV1PR10MB6563DC208657E86715361E94E8B4A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <GV1PR10MB6563DC208657E86715361E94E8B4A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 5 Dec 2023 13:41:57 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XpK0T-oPi2Q6-9jELFseSsvgkFtRuXP1LXK6PbV_MwCg@mail.gmail.com>
Message-ID: <CAD=FV=XpK0T-oPi2Q6-9jELFseSsvgkFtRuXP1LXK6PbV_MwCg@mail.gmail.com>
Subject: Re: [PATCH 2/2] trace: kdb: Replace simple_strtoul with kstrtoul in kdb_ftdump
To: Yuran Pereira <yuran.pereira@hotmail.com>
Cc: kgdb-bugreport@lists.sourceforge.net, linux-trace-kernel@vger.kernel.org, 
	jason.wessel@windriver.com, daniel.thompson@linaro.org, rostedt@goodmis.org, 
	mhiramat@kernel.org, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Nov 19, 2023 at 4:10=E2=80=AFPM Yuran Pereira <yuran.pereira@hotmai=
l.com> wrote:
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
> ---
>  kernel/trace/trace_kdb.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/trace/trace_kdb.c b/kernel/trace/trace_kdb.c
> index 59857a1ee44c..3891f885e4a6 100644
> --- a/kernel/trace/trace_kdb.c
> +++ b/kernel/trace/trace_kdb.c
> @@ -96,23 +96,21 @@ static int kdb_ftdump(int argc, const char **argv)
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
> +       if (argc)
> +               if (kstrtoint(argv[1], 0, &skip_entries))
>                         skip_entries =3D 0;
> -       }

Similar nit about braces as in patch #1. tl;dr is change the above to:

if (argc && kstrtoint(argv[1], 0, &skip_entries))
  skip_entries =3D 0;


>
>         if (argc =3D=3D 2) {
> -               cpu_file =3D simple_strtol(argv[2], &cp, 0);
> -               if (*cp || cpu_file >=3D NR_CPUS || cpu_file < 0 ||
> -                   !cpu_online(cpu_file))
> +               err =3D kstrtol(argv[2], 0, &cpu_file);
> +               if (err || cpu_file >=3D NR_CPUS || cpu_file < 0 ||
> +                               !cpu_online(cpu_file))

nit: why did you change the indentation for "!cpu_online(cpu_file))"?
It seemed better before.

With nits fixed:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
