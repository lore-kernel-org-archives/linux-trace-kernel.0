Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LORwLkOJ"
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCE7D3
	for <linux-trace-kernel@vger.kernel.org>; Tue,  5 Dec 2023 13:42:03 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-77f0e76c948so20530985a.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 05 Dec 2023 13:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701812521; x=1702417321; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UUoV3c5EcqzGgFazFRODspx6X9OPb/ruYMRTuRufHkE=;
        b=LORwLkOJijSLv1a3JS4KGh407RuW8KkQ33jVeltlmYXKfxgODgKsEd9bnK+PAA0fiO
         mFd2nKYNwnWCPrjFZyuSxvfP3lE0qowo0qzupe5K07PEkfIHHlMqh7bJ2EyfD7XMjVC1
         Jc31mnqCiYJgQwF0sz8rqQhlGW1iZO7eeGUeY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701812521; x=1702417321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UUoV3c5EcqzGgFazFRODspx6X9OPb/ruYMRTuRufHkE=;
        b=W+5h7eLF3c1OZEn8R4v3WPzpDA+RLXHXSVnOrrbrpd61Y0USUSnW1HbceFDFnG7CaV
         DqebLjR0CB3EPQcFDxbgAhw7E6aWRjBB5HNJUnsIoZc/dgwM0Q49ef9owmAhUutIYHVc
         knLcTVAfJmMuz/SJXbB8b6T7ITwb6g3NefE3HyY/m2nOw2gcuNkLIsGHeU7eJ/aJIZpi
         dbzAV8hb+1Gn2HT37nyLL8pVzmDPpBqIOysLIGRYG2xRRx/u9aEQ8aW+Dm2PyddaKfD/
         5/RQoL7ezbg6hf5EOH/+IOh/O7NdCpiT5DtPYxXXES6iulhzWG7GHo4Jp7lQehgZTzEo
         2+9g==
X-Gm-Message-State: AOJu0YyGdKIlRIoQIkVHyssPsZWFPv9GiwYcPsPmlWVR6XiJWNmy6QGI
	+1pPRV06Og0sYItVFxpnO9UVT4/Ro2VuMoO/FWIWNfPI
X-Google-Smtp-Source: AGHT+IHeg4U85NtoRcDwG9SiO6ePERkFtJppObeNZG54vf95F2dN1MV0vXkbcbv/VHQHcym92d/svg==
X-Received: by 2002:a05:620a:1a08:b0:77d:7585:2960 with SMTP id bk8-20020a05620a1a0800b0077d75852960mr3281028qkb.26.1701812521601;
        Tue, 05 Dec 2023 13:42:01 -0800 (PST)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com. [209.85.160.181])
        by smtp.gmail.com with ESMTPSA id bk21-20020a05620a1a1500b00773fe8971bbsm5390936qkb.90.2023.12.05.13.42.00
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 13:42:01 -0800 (PST)
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-425546ad42fso98881cf.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 05 Dec 2023 13:42:00 -0800 (PST)
X-Received: by 2002:a05:622a:247:b0:423:babe:75f1 with SMTP id
 c7-20020a05622a024700b00423babe75f1mr7180qtx.17.1701812520401; Tue, 05 Dec
 2023 13:42:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <GV1PR10MB65635561FB160078C3744B5FE8B4A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
 <GV1PR10MB6563E0F8DB2D335BD9CFE4D3E8B4A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <GV1PR10MB6563E0F8DB2D335BD9CFE4D3E8B4A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 5 Dec 2023 13:41:44 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VZ61XFb1Ks79BHr1jL1jwf_36wYXryy0ZXOz1xTQ9zOg@mail.gmail.com>
Message-ID: <CAD=FV=VZ61XFb1Ks79BHr1jL1jwf_36wYXryy0ZXOz1xTQ9zOg@mail.gmail.com>
Subject: Re: [PATCH 1/2] kdb: Replace the use of simple_strto with safer
 kstrto in kdb_main
To: Yuran Pereira <yuran.pereira@hotmail.com>
Cc: kgdb-bugreport@lists.sourceforge.net, linux-trace-kernel@vger.kernel.org, 
	jason.wessel@windriver.com, daniel.thompson@linaro.org, rostedt@goodmis.org, 
	mhiramat@kernel.org, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Nov 19, 2023 at 4:07=E2=80=AFPM Yuran Pereira <yuran.pereira@hotmai=
l.com> wrote:
>
> The simple_str* family of functions perform no error checking in
> scenarios where the input value overflows the intended output variable.
> This results in these functions successfully returning even when the
> output does not match the input string.
>
> Or as it was mentioned [1], "...simple_strtol(), simple_strtoll(),
> simple_strtoul(), and simple_strtoull() functions explicitly ignore
> overflows, which may lead to unexpected results in callers."
> Hence, the use of those functions is discouraged.
>
> This patch replaces all uses of the simple_strto* series of functions
> with their safer kstrto* alternatives.
>
> Side effects of this patch:
> - Every string to long or long long conversion using kstrto* is now
>   checked for failure.
> - kstrto* errors are handled with appropriate `KDB_BADINT` wherever
>   applicable.
> - A good side effect is that we end up saving a few lines of code
>   since unlike in simple_strto* functions, kstrto functions do not
>   need an additional "end pointer" variable, and the return values
>   of the latter can be directly checked in an "if" statement without
>   the need to define additional `ret` or `err` variables.
>   This, of course, results in cleaner, yet still easy to understand
>   code.
>
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#simple=
-strtol-simple-strtoll-simple-strtoul-simple-strtoull
>
> Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>
> ---
>  kernel/debug/kdb/kdb_main.c | 70 +++++++++++--------------------------
>  1 file changed, 21 insertions(+), 49 deletions(-)

Sorry for taking so long to review this--it arrived in my inbox at a
bad time. A few minor nits below that I think should be fixed before
landing but overall I think it's a nice cleanup. Thanks!


> @@ -412,42 +412,21 @@ static void kdb_printenv(void)
>   */
>  int kdbgetularg(const char *arg, unsigned long *value)
>  {
> -       char *endp;
> -       unsigned long val;
> -
> -       val =3D simple_strtoul(arg, &endp, 0);
> -
> -       if (endp =3D=3D arg) {
> -               /*
> -                * Also try base 16, for us folks too lazy to type the
> -                * leading 0x...
> -                */
> -               val =3D simple_strtoul(arg, &endp, 16);
> -               if (endp =3D=3D arg)
> +       /*
> +        * If the first fails, also try base 16, for us
> +        * folks too lazy to type the leading 0x...
> +        */
> +       if (kstrtoul(arg, 0, value))
> +               if (kstrtoul(arg, 16, value))

Not new to your patch, but the above seems like a terrible idea to me.
What that means is that:

kdbgetularg("18", &value) =3D> value is 18
kdbgetularg("19", &value) =3D> value is 19
kdbgetularg("1a", &value) =3D> value is 26

Bleh! If someone wants hex then they should put the 0x first.

I'd suggest a followup patch that removes the fallback for the lazy
folks. Here and in the next function...


> @@ -2095,15 +2074,11 @@ static int kdb_dmesg(int argc, const char **argv)
>         if (argc > 2)
>                 return KDB_ARGCOUNT;
>         if (argc) {
> -               char *cp;
> -               lines =3D simple_strtol(argv[1], &cp, 0);
> -               if (*cp)
> +               if (kstrtoint(argv[1], 0, &lines))
>                         lines =3D 0;
> -               if (argc > 1) {
> -                       adjust =3D simple_strtoul(argv[2], &cp, 0);
> -                       if (*cp || adjust < 0)
> +               if (argc > 1)
> +                       if (kstrtouint(argv[2], 0, &adjust) || adjust < 0=
)

My gut reaction is that some sort of build bot is going to come and
yell at you about the above line. Even if it doesn't, it's a bit
confusing. You're passing a pointer to an int into a function that
expects a pointer to an unsigned int. Most things don't really care
about signed/unsigned, but I could swear that some compilers get mad
when you start working with pointers to those types...

In any case, I think everything would work fine if you just change it
to kstrtoint(), right? I guess the other option would be to change the
variable to unsigned, but I guess that doesn't make sense since it's a
modifier to "lines" which is an int.

Side note: I didn't even know about the "adjust" argument, since it's
not in the help text in the command table below. I guess that could be
fixed in a separate patch.

nit: IMO if you have nested "if" statements then the outer one should
have braces. AKA:

if (a) {
  if (b)
    blah();
}

instead of:

if (a)
  if (b)
    blah();

...or you could do better and just change it to:

if (a && b)
  blah();
