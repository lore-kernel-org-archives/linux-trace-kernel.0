Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CC03CC9E9
	for <linux-trace-kernel@vger.kernel.org>; Fri,  3 Jul 2026 12:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783080686; cv=none; b=nikyGDn4DH1CZgIt9xVjRRSaPjl+r7Bj+xJ2PwJM3ouOqmsGRy1A5uMHhiDWq4uxtaL2jlkDpCe+0n2Wmevrp5fpi3kyDwWJJAtXzfs6DOY1OZoVm4rd1d8Tka2okbenEna/W/+q5UH+KgAXNSz9u+9tM22mdb1ShGCpj1nz5GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783080686; c=relaxed/simple;
	bh=B86iAGKKAroJnUmClZ+xpHcB7vJ8VUPQp7/mPSgp8/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UCaDeaaU3lB8u5KUpdHxVI/JzJRwOjAIgqhBTCEh65UiYM9W1K67MpMs3J9cuBANW8BcATHWsGArij07Wc1llZyXz+TkaCqatr46cUwnRaZAuv85SubCmX1AcIqzuhF8YcAQHBKUEzMe/NwmmT6IQzaD/y6dMufWQubtaYlejJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZLfymS34; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZLfymS34"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783080684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/I1Zl/n1kwvszS0jjU2bK9K0CLNxEDNzktjKpRvI2/0=;
	b=ZLfymS34xlBaZAj9/1Z0cZitFNVM+LXbsdPkSun6ha8aXF3RMzNdXXndpeztiudobaEzT9
	UdFzuA7Q+xvicE2GhTT9fpx9a8v2B7s/zdSLFEUpW77ifqkFKDVXztMLvnSqpQHAapvnWR
	h6DjhBewWI3q6RIUgwYkypOHr35Vebw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-x-NlLLRVOZ-XpQsIhu1kNQ-1; Fri, 03 Jul 2026 08:11:22 -0400
X-MC-Unique: x-NlLLRVOZ-XpQsIhu1kNQ-1
X-Mimecast-MFC-AGG-ID: x-NlLLRVOZ-XpQsIhu1kNQ_1783080682
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-698aa06326eso1828857a12.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 03 Jul 2026 05:11:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783080681; x=1783685481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/I1Zl/n1kwvszS0jjU2bK9K0CLNxEDNzktjKpRvI2/0=;
        b=CWmfE0SCTiU8SgOjPKm1LY2AGsN5KoHZdDZtONUPPv6EfRcVKEJfRWCs7fAhneSVJG
         NLZueAC9pSaUAYDF58apiybVs/BWM1kqPuoy6ndp3ruOz2K/tpQW5aDLojTzcVp26Eh0
         A1CI5CfhwccSF1c1ygdaef9dpK9aOJNk0HK9oLqM4WmE+PeOmg2V8WQGDlqp40DsesS2
         9E6cohX0oBMg6uplaYXc0JCsha/6S4YVgHmaTV3aZv/GwFB1P0p+/2hbD5MFlnnrSBMP
         eI6CNH/XVRKXp/cjzwAz+W1DXxStzZoYPvOYmfpiAWBvdDdCZQJGg1jwpghjsPFRWtMg
         qEqw==
X-Forwarded-Encrypted: i=1; AHgh+RozRlLxjGd3HWpHBEXO7+NyS8X5sPV36fggwJemZZZGKMl84Gwh2AELvCFRhU82QSS0WDixmpbmyzORRJPofh4IKAg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz31pnwsKc+cJn0d8/IdTZcEAO1B1A8fPrAkZgZ334fbH30poDD
	282am6DZcbJRAhZI6ju5409E2C3O2hHz8eC5Zy5gbxr68KeZJpjA0spQw+3RUmM1EXE3yYr64S4
	2FxfrqSfGYFwgoCmh8O6uTkMrV89S/iF4n6rZIuk6h5qFDiSsZMzLbYHWr6enKTbk0w09gryFc3
	bZho9qZe8X3B3gNUWvnOFFLeUYntgkKp6BEmBwQL9V+yM5gjee
X-Gm-Gg: AfdE7cl7TBSrhKrOBA/cQ9v4CLTgK/+PFKVQ1kbW4KLvYZbE+QjwCOWSQ97S5bBHNTY
	mfFAwgqrXLpAuz2FXum/TRwIzrxJK0EGQtrn8SmzKSGvZct4WRJvsM3Y10rl51ubZ95HrqZ7GeW
	o585SNU2AHtSEhe0r+t/gzqdfC8AgPU8M7+n/2DsWiBmPe49AtNJzADDg9I6k48EfDQx2sbr0ht
	Rlm5SBIPvsmWXhyID6gX66bKw==
X-Received: by 2002:a17:907:6d23:b0:c12:7f75:7900 with SMTP id a640c23a62f3a-c12c9f50e07mr186580966b.27.1783080681443;
        Fri, 03 Jul 2026 05:11:21 -0700 (PDT)
X-Received: by 2002:a17:907:6d23:b0:c12:7f75:7900 with SMTP id
 a640c23a62f3a-c12c9f50e07mr186579166b.27.1783080680883; Fri, 03 Jul 2026
 05:11:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612115121.54862-1-tglozar@redhat.com> <725da8a4ca6a46ea8ba41778971602b49d650e60.camel@redhat.com>
In-Reply-To: <725da8a4ca6a46ea8ba41778971602b49d650e60.camel@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Fri, 3 Jul 2026 14:11:09 +0200
X-Gm-Features: AVVi8Cfll8QjPJdFVXS5QkoigOtapPm-uSv7V_IHt_hSXm9WR7DOqNo3hs7Qsl0
Message-ID: <CAP4=nvRMAZ6AJ_WQPVM2sm9jH++4RwN8DhodU7oL6-AcXNg8OA@mail.gmail.com>
Subject: Re: [PATCH] rtla: Simplify osnoise tracer option setting code
To: Crystal Wood <crwood@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, John Kacur <jkacur@redhat.com>, 
	Luis Goncalves <lgoncalv@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	Wander Lairson Costa <wander@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UiSSwhbqJ_CBieYsTB3KBiMd2iz2C2x0NPlGRb8d6Dk_1783080682
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

p=C3=A1 12. 6. 2026 v 19:55 Crystal Wood <crwood@redhat.com> napsala:

> > OSNOISE_LL_OPTIONS takes three options: name - struct osnoise_context
> > field name (written "<opt>" above), path - filename inside
> > /sys/kernel/tracing/osnoise passed to libtracefs, and init_val - initia=
l
> > value of struct fields, corresponding to an otherwise invalid option
> > (some options use OSNOISE_OPTION_INIT_VAL =3D -1, some use
> > OSNOISE_TIME_INIT_VAL =3D 0).
>
> Can we simplify by always using -1?  Especially since that's already
> treated as the universal "invalid" by osnoise_read_ll_config().
>
> FWIW using "init val" to mean "invalid" rather than "default" is a bit
> unintuitive.
>

The idea behind *_INIT_VAL is to re-use a value that is invalid on the
osnoise tracer side to mean "not (read from tracer and) set yet (on
the RTLA side)". OSNOISE_TIME_INIT_VAL is used for values where 0 is
invalid (e.g. period, runtime), OSNOISE_OPTION_INIT_VAL is used for
those where 0 is valid. I believe the distinction comes from the fact
that some of the osnoise options are unsigned on the kernel side, and
-1 (=3D 18446744073709551615) is actually a valid value there. E.g.:

[root@cs9 osnoise]# cat period_us
1000000
[root@cs9 osnoise]# echo 18446744073709551615 > period_us
[root@cs9 osnoise]# cat period_us
18446744073709551615

There are values where both 0 and -1 are valid (stop_tracing_us,
stop_tracing_total_us, timerlat_align_us), and they use
OSNOISE_OPTION_INIT_VAL. Those cannot use OSNOISE_TIME_INIT_VAL as 0
is a meaningful and common value for them (disabled for
stop_us/stop_total_us, zero alignment for timerlat_align_us). Those
will break if pre-set to 18446744073709551615.

Merging OSNOISE_OPTION_INIT_VAL and OSNOISE_TIME_INIT_VAL would
introduce this breakage to options that are using
OSNOISE_TIME_INIT_VAL now. IMHO the cleanest solution is dropping the
entire complex logic around checking if the value was read from the
kernel already, as there is no user: RTLA always saves the value once,
then restores it at the end.

> > OSNOISE_FLAG_OPTION is similar, but instead of path, it takes the optio=
n
> > string inside /sys/kernel/tracing/osnoise/options (opt_string), and no
> > init_val, as it is purely boolean (0 or 1).
> >
> > Previously, for options timerlat_align and osnoise_workload, the return
> > value of osnoise_set_<opt>() distinguished between -2 (option cannot be
> > set) and -1 (option not present). This distinction is expanded for all
> > options for consistency; for most options, it is currently not used,
> > only osnoise_workload is implemented to avoid error on -1 on older RTLA
> > versions.
>
> "on -1 on"?

On older RTLA versions, osnoise_workload distinguishes between -1 and
-2 to avoid error when the kernel doesn't support the feature.

>
> > The change overall has two main benefits: it makes it much simpler to
> > add a new option, as well as to change existing logic consistently for
> > all of them. It also makes the code shorter by a bit over 500 lines.
> >
> > There is no intentional user-visible change coming from the refactoring=
.
> > osnoise_restore_<opt>() for flag options now sets <opt> instead of
> > orig_<opt>. As the latter is also set by osnoise_put_<opt>(), plus long
> > long options set <opt> in both the old and new implementation, the old
> > behavior was likely a mistake, and should not matter for now, as the
> > options are only restored once at the end of tracing and neither <opt>
> > nor orig_<opt> field is read again.
> >
> > Assisted-by: Claude:claude-opus-4-6
> > Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> > ---
> >  tools/tracing/rtla/src/common.h  |  79 +--
> >  tools/tracing/rtla/src/osnoise.c | 836 ++++++-------------------------
> >  tools/tracing/rtla/src/osnoise.h |  22 -
> >  3 files changed, 188 insertions(+), 749 deletions(-)
>
> While we're at it, can we move this code to common.c, and drop
> "osnoise" from the names, to move closer to using that only for the
> actual osnoise mode?
>
> Or if we really want to namespace things that are specific to the
> osnoise subsystem (i.e. everything implemented in trace_osnoise.c) but
> not specific with respect to the osnoise/timerlat split, I'd suggest
> something different like "osn_".
>

They are called "osnoise options" in the interface (although they are
shared with the timerlat tracer), which cannot be changed. I don't
like using an esoteric prefix like "osn".

> > + * Long long option get/set/restore/put functions, generated from OSNO=
ISE_LL_OPTIONS.
> > + */
> > +#define OSNOISE_LL_OPTION(name, path, init_val)                       =
                       \
> > +static long long                                                      =
               \
> > +osnoise_get_##name(struct osnoise_context *context)                   =
               \
> > +{                                                                     =
               \
> > +     long long name;                                                  =
               \
> > +                                                                      =
               \
> > +     if (context->name !=3D (init_val))                               =
                 \
> > +             return context->name;                                    =
               \
> > +                                                                      =
               \
> > +     if (context->orig_##name !=3D (init_val))                        =
                 \
> > +             return context->orig_##name;                             =
               \
> > +                                                                      =
               \
> > +     name =3D osnoise_read_ll_config(path);                           =
                 \
> > +     if (name < 0)                                                    =
               \
> > +             return (init_val);                                       =
               \
> > +                                                                      =
               \
> > +     context->orig_##name =3D name;                                   =
                 \
> > +     return name;                                                     =
               \
> > +}                                                                     =
               \
> > +                                                                      =
               \
> > +int osnoise_set_##name(struct osnoise_context *context, long long name=
)                      \
> > +{                                                                     =
               \
> > +     long long curr =3D osnoise_get_##name(context);                  =
                 \
> > +     int retval;                                                      =
               \
> > +                                                                      =
               \
> > +     if (curr =3D=3D (init_val))                                      =
                   \
> > +             return -1;                                               =
               \
> > +                                                                      =
               \
> > +     retval =3D osnoise_write_ll_config(path, name);                  =
                 \
> > +     if (retval < 0)                                                  =
               \
> > +             return -2;                                               =
               \
> > +                                                                      =
               \
> > +     context->name =3D name;                                          =
                 \
> > +     return 0;                                                        =
               \
> > +}                                                                     =
               \
>
> Using "name" for the value is confusing... "val" would be better.
>

But it's the *name* of the option/field/argument here, not the value.
If you use "value" you'll get:

#define OSNOISE_LL_OPTION(value, path, init_val)

which is incorrect. Would making the macro options in capital letters
(i.e. NAME) make it more clear?

> > +                                                                      =
               \
> > +void osnoise_restore_##name(struct osnoise_context *context)          =
               \
> > +{                                                                     =
               \
> > +     int retval;                                                      =
               \
> > +                                                                      =
               \
> > +     if (context->orig_##name =3D=3D (init_val))                      =
                   \
> > +             return;                                                  =
               \
> > +                                                                      =
               \
> > +     if (context->orig_##name =3D=3D context->name)                   =
                   \
> > +             goto out_done_##name;                                    =
               \
> > +                                                                      =
               \
> > +     retval =3D osnoise_write_ll_config(path, context->orig_##name);  =
                 \
> > +     if (retval < 0)                                                  =
               \
> > +             err_msg("Could not restore original " #name "\n");       =
               \
> > +                                                                      =
               \
> > +out_done_##name:                                                      =
               \
> > +     context->name =3D (init_val);                                    =
                 \
> > +}                                                                     =
               \
>
> Why does the label need to have ##name in it?
>

It doesn't. Code assistants are just not smart enough to distinguish
labels from global symbols yet, it seems...

> > +                                                                      =
               \
> > +static void osnoise_put_##name(struct osnoise_context *context)       =
                       \
> > +{                                                                     =
               \
> > +     osnoise_restore_##name(context);                                 =
               \
> > +                                                                      =
               \
> > +     if (context->orig_##name =3D=3D (init_val))                      =
                   \
> > +             return;                                                  =
               \
> > +                                                                      =
               \
> > +     context->orig_##name =3D (init_val);                             =
                 \
> > +}
> [snip]
> > +/*
> > + * Flag option get/set/restore/put functions, generated from OSNOISE_F=
LAG_OPTIONS.
> > + */
> > +#define OSNOISE_FLAG_OPTION(name, option_str)                         =
                       \
> > +static int osnoise_get_##name(struct osnoise_context *context)        =
                       \
> > +{                                                                     =
               \
> > +     if (context->opt_##name !=3D OSNOISE_OPTION_INIT_VAL)            =
                 \
> > +             return context->opt_##name;                              =
               \
> > +                                                                      =
               \
> > +     if (context->orig_opt_##name !=3D OSNOISE_OPTION_INIT_VAL)       =
                 \
> > +             return context->orig_opt_##name;                         =
               \
> > +                                                                      =
               \
> > +     context->orig_opt_##name =3D osnoise_options_get_option(option_st=
r);              \
> > +     return context->orig_opt_##name;                                 =
               \
> > +}                                                                     =
               \
> > +                                                                      =
               \
> > +int osnoise_set_##name(struct osnoise_context *context, bool onoff)   =
               \
> > +{                                                                     =
               \
> > +     int val =3D osnoise_get_##name(context);                         =
                 \
> > +     int retval;                                                      =
               \
> > +                                                                      =
               \
> > +     if (val =3D=3D OSNOISE_OPTION_INIT_VAL)                          =
                   \
> > +             return -1;                                               =
               \
> > +                                                                      =
               \
> > +     if (val =3D=3D onoff)                                            =
                   \
> > +             return 0;                                                =
               \
> > +                                                                      =
               \
> > +     retval =3D osnoise_options_set_option(option_str, onoff);        =
                 \
> > +     if (retval < 0)                                                  =
               \
> > +             return -2;                                               =
               \
> > +                                                                      =
               \
> > +     context->opt_##name =3D onoff;                                   =
                 \
> > +     return 0;                                                        =
               \
> > +}                                                                     =
               \
> > +                                                                      =
               \
> > +void osnoise_restore_##name(struct osnoise_context *context)          =
               \
> > +{                                                                     =
               \
> > +     int retval;                                                      =
               \
> > +                                                                      =
               \
> > +     if (context->orig_opt_##name =3D=3D OSNOISE_OPTION_INIT_VAL)     =
                   \
> > +             return;                                                  =
               \
> > +                                                                      =
               \
> > +     if (context->orig_opt_##name =3D=3D context->opt_##name)         =
                   \
> > +             goto out_done_##name;                                    =
               \
> > +                                                                      =
               \
> > +     retval =3D osnoise_options_set_option(option_str, context->orig_o=
pt_##name);      \
> > +     if (retval < 0)                                                  =
               \
> > +             err_msg("Could not restore original " option_str " option=
\n");          \
> > +                                                                      =
               \
> > +out_done_##name:                                                      =
               \
> > +     context->opt_##name =3D OSNOISE_OPTION_INIT_VAL;                 =
                 \
> > +}                                                                     =
               \
> > +                                                                      =
               \
> > +static void osnoise_put_##name(struct osnoise_context *context)       =
                       \
> > +{                                                                     =
               \
> > +     osnoise_restore_##name(context);                                 =
               \
> > +                                                                      =
               \
> > +     if (context->orig_opt_##name =3D=3D OSNOISE_OPTION_INIT_VAL)     =
                   \
> > +             return;                                                  =
               \
> > +                                                                      =
               \
> > +     context->orig_opt_##name =3D OSNOISE_OPTION_INIT_VAL;            =
                 \
> > +}
>
> Can we reduce the amount of code we put in macros by moving some of the
> logic to osnoise_read/write_ll_config() and osnoise_get/set_optino()?
> Or a non-macro wrapper around them if there are other callers that need
> the current behavior.
>
> Something like (assuming universal -1 invalid):
>
> static int osn_read_ll_config(const char *rel_path, long long *val, long =
long *orig)
> static int osn_write_ll_config(const char *rel_path, long long *val, long=
 long *orig)
> static int osn_get_option(const char *name, int *val, int *orig)
> static int osn_set_option(const char *name, int *val, int *orig)
>

Yeah I think that could work. The get/set functions call each other,
but they can just pass the pointers instead.

> -Crystal (who wishes we were using a modern language that didn't require =
all
> this macro stuff)
>

Tomas

