Received: from mail-lr2-f10.google.com (mail-lr2-f10.google.com [74.125.230.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11BA2E717B
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 03:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787713927; cv=pass; b=oMFyV/OImVj3E2mNc4HgX9OkkqGuCDoNWhApsxdrYr845gAU/5sKdQJzwCg39ReoE86c4K9YcDdnel/MsJhXOUKYEHn1cinAlbgk9Lg3SjdkD+bVLgVbtYUOaKWZWVXlMj0dLrGUG59M7ZM9mYR24gsFOg0menkN9808agGFc8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787713927; c=relaxed/simple;
	bh=dSqBXOdyD9HPVRewoslxiTwnYYt7O/GNF6cjvWkbc2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AufEUQjZsjmQV2seD6lxw67uv4n4mP0LXhuBIMsVAT68CKd6mTgdhefsb6VlvQcyO9yJcjgkgMuK3MGVdbRPeDziIV4XmpzLkZhl76KfYt0vyHDpFRfavP5svHCrwT8tTbDMwDwRJaTbskDSWKlYXHazh2CfUOoIfCq3FzntaN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AWgIjUJL; arc=pass smtp.client-ip=74.125.230.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWgIjUJL"
Received: by mail-lr2-f10.google.com with SMTP id 38308e7fff4ca-3a1921429f3so1856171fa.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Aug 2026 20:12:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787713924; cv=none;
        d=google.com; s=arc-20260327;
        b=qrWHRPa10SBjAcMzZqeWljqLoUxqlWpn7LI/1gzNC1akoJBk//0NxFV4lSyxNB58Az
         OFy82BDoVUZjkh/HTPX3e9nK2Ju8nApw4FfPoQe9oQc+p6mXMYHK94s7Q0qFRfsXMp5o
         60FU4Pa9ERJkysGnNUiO5Ic7o4G0/XK4OiHLmLnPIXP5fm635p1LW/hEQFDQCZPMafi0
         K+4JBIBzySJeR/D8w+F0adxvUXilcjU+RTRpd7DL81z83j0jWnOKB6kLKNyQtFzkfHh+
         eE4rnMR+IJqXFWzz84zZBPoO3cg7XVIMn63dUex696+WdRHixZh3v44bc0BaMFY/xrZE
         CWUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=O+Qt3snVLSXt9bz85P9Y6uHkaEjgQM21tQftzjLIsxM=;
        fh=7c6NSBaymGLaEVCoJia4Pi91nJUw2vIzmki0eIiRSFE=;
        b=WAf7zWhP4v/9xEDOJqObdKLV0oqtahjoETMRHUOxZEUX9cbP3mxHuZ1IMdG2WlmF6k
         2e8UxEr2rM7JH/g4CSYFLk3b/H0Z21RfyRvGudueVXY0Kb5JY8pxl3Gu2SaArg2UwQv6
         NbaDul0nXWNUu04zaevuxqwX8WzJC8+JcdMigIGP1DD8GS3ai5pHTZDCeCJ1OnpzEeS1
         uk5vD+2WGpHO1oe64iYCpBlw5zRCuXRzx8Rz80mjhS+p1NS3wT/XKhQAaYcY5V0wZV08
         gCdgqGHv7QYhd4mubpv6pEnNTWYXsWp0hW/ZLrUAMJwZmpIzL9/7hiI+aZi3vFmC9OLl
         PTVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787713924; x=1788318724; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=O+Qt3snVLSXt9bz85P9Y6uHkaEjgQM21tQftzjLIsxM=;
        b=AWgIjUJLcMR6jPo5co1GAveSCCuWO+EaGFLSt57UlvsfuDL5HR2sd3u1Id0ZjvC1Tg
         cfLaDl4S+Kl0watfKiYEmoKx/gDxNtJQ4xRkgQQwYbCOP1WfrgM1kLtpadYbKaFbmHh2
         qnv6BiP/C7gh8rP+/XgA1BNTj6LPqVet2mjohl38Sa6QF4OM9Ph/DsUidoWGj034fa23
         y8FfLxuz/NQneEMD+lqwCvByyxA8tdcQ0xlPYazQ0U+RnOz1/fbRxzViPOMOiDidSiS6
         I94ju7iAcNE3hYwqkoYxCCmaS8uGNCiVMcPNz8Nk1J9Qo1y871BiiGi+ryWTdINXxKQS
         Tkkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787713924; x=1788318724;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O+Qt3snVLSXt9bz85P9Y6uHkaEjgQM21tQftzjLIsxM=;
        b=WD6VKw2Obv0JJRAo81KJv1zXecT7vn3KOS6pHqMD+BJK45vuJ4f3dTqm9kyt0OfTH4
         VBeo/SL2297dNSonFe9HexTBc7apUg4nK+RPIfKN70jaLhe3bUN/jDLbjUAjp6TJ3Ocp
         egrYoOCmoJvrQ+McIZk8hCOuHhDyuUi43GZVGNqXpYvmGS2/nkdqLiy8fPE8pfh6sXuD
         VzyxX9ZqN9jkf69dNtylhQ0/IvKnJ00HFbCClyXYc4fSAb6dmm0i7yD53QLKKnzQJRVg
         75l48ujGF+WU8UMG2JZ0auC3EO2YIOOwPEGpUBr65/cFg67ObxVUVff6u1WQpmRqNAwN
         vh8w==
X-Forwarded-Encrypted: i=1; AHgh+RpXnKtRXwwAQ6mH9SocCZwisiacEzMD5p30ynev2ggsNriUlX8sf6Sub8denz9l4H+Ae5mi2Z8vQCzkx6hGPkx67aY=@vger.kernel.org
X-Gm-Message-State: AFuF++ky6JoCwCLMi+LoSdEpvaumsKQ7nB0ASKR8dg7Tu0ePc9jSjpLC
	aru/qWvTxD73xR1jEjHDFQEX5EDfx0TBBVTPz0kkKq5RR/CDhMvQSvQkslzjVvYLz9nUn7V8muR
	I215UCT2KykgWUS7dGXzpHw9DFnahk6I=
X-Gm-Gg: AR+sD10qOEYh9jgqbhjOcA01SOHycvFcJ+xYmZt1Sz6gm5n2qsaqlRZPjymc0FLeU0O
	wpNj+RWi0+ZfFvygscT1trb38bPdX0GSjnU/KVFz/vPXSnnDgUU9i+bKyNV+hfwP0jvmGsOBlrs
	OV/m/tWNjuklQNe0qs/Z5MtSqfFqWGVoHZBDUtSCnBDDwZQwYV+e5avEp9G3/KXapntJ+T2RXeC
	zRJbvYZ2VLj7Zohzeo2jPEqo84Ms4wbwOGKrfWnNYbtaJBo1mD0UqGqAmrc1zyPldMcVY5SrzBw
	XeB1WtSWLCdtODItVVMp5aItTh8C322mCl5MGC80Wnx40g==
X-Received: by 2002:a2e:be9d:0:b0:39b:7cd:e1ca with SMTP id
 38308e7fff4ca-3a1fd6195b9mr5546241fa.9.1787713923379; Tue, 25 Aug 2026
 20:12:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824144356.1f61aea2@gandalf.local.home> <20260825111210.3271443-1-bsdhenrymartin@gmail.com>
 <20260825113714.188131F000E9@smtp.kernel.org> <20260825102221.79713c98@gandalf.local.home>
In-Reply-To: <20260825102221.79713c98@gandalf.local.home>
From: henry martin <bsdhenrymartin@gmail.com>
Date: Wed, 26 Aug 2026 11:11:51 +0800
X-Gm-Features: AcwNN1Uze5KPl3mPJAnkr6yhIlyrgGYUjcYqqqNCSUYyKI9Yp24XdzpFrCidUZY
Message-ID: <CAEnQdOoXAnfFjM_ifc6-JeT+WOdgXTwHY0Dt9sQPxbBPUKztHw@mail.gmail.com>
Subject: Re: [PATCH v3] tracing/probes: Fix use-after-free on field name/type
 of multi-probe events
To: Steven Rostedt <rostedt@goodmis.org>
Cc: sashiko-bot@kernel.org, sashiko-reviews@lists.linux.dev, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[1]: <20260826030009.1855331-1-bsdhenrymartin@gmail.com>

Thanks,

-- Henry


Steven Rostedt <rostedt@goodmis.org> =E4=BA=8E2026=E5=B9=B48=E6=9C=8825=E6=
=97=A5=E5=91=A8=E4=BA=8C 22:21=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, 25 Aug 2026 11:37:13 +0000
> sashiko-bot@kernel.org wrote:
>
> > > diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> > > index 36dff277de464..3057d31c57376 100644
> > > --- a/kernel/trace/trace_probe.c
> > > +++ b/kernel/trace/trace_probe.c
> > > @@ -965,19 +965,48 @@ int traceprobe_set_print_fmt(struct trace_probe=
 *tp, enum probe_print_type ptype
> > >  int traceprobe_define_arg_fields(struct trace_event_call *event_call=
,
> > >                              size_t offset, struct trace_probe *tp)
> > >  {
> > > +   struct trace_probe_event *tpe =3D trace_probe_event_from_call(eve=
nt_call);
> > >     int ret, i;
> > >
> > > +   /*
> > > +    * A field created by trace_define_field() only stores the name a=
nd
> > > +    * type pointers, it does not copy the strings. Here they point i=
nto
> > > +    * the probe_arg of @tp, which is freed when @tp is removed. For =
a
> > > +    * multi-probe event the field list is defined once by the first =
probe
> > > +    * but kept alive by the surviving siblings, so removing that fir=
st
> > > +    * probe would leave the fields referencing freed memory. Make th=
e
> > > +    * event own duplicates that live as long as the event call itsel=
f.
> > > +    */
> > > +   if (tp->nr_args) {
> > > +           tpe->field_strings =3D kcalloc(tp->nr_args * 2, sizeof(ch=
ar *),
> > > +                                        GFP_KERNEL);
> > > +           if (!tpe->field_strings)
> > > +                   return -ENOMEM;
> > > +   }
> > > +
> > >     /* Set argument names as fields */
> > >     for (i =3D 0; i < tp->nr_args; i++) {
> > >             struct probe_arg *parg =3D &tp->args[i];
> > >             const char *fmt =3D parg->type->fmttype;
> > >             int size =3D parg->type->size;
> > > +           char *name, *type;
> > >
> > >             if (parg->fmt)
> > >                     fmt =3D parg->fmt;
> > >             if (parg->count)
> > >                     size *=3D parg->count;
> > > -           ret =3D trace_define_field(event_call, fmt, parg->name,
> > > +
> > > +           name =3D kstrdup(parg->name, GFP_KERNEL);
> > > +           type =3D kstrdup(fmt, GFP_KERNEL);
> > > +           if (!name || !type) {
> > > +                   kfree(name);
> > > +                   kfree(type);
> > > +                   return -ENOMEM;
> > > +           }
> > > +           tpe->field_strings[tpe->nr_field_strings++] =3D name;
> > > +           tpe->field_strings[tpe->nr_field_strings++] =3D type;
> > > +
> > > +           ret =3D trace_define_field(event_call, type, name,
> > >                                      offset + parg->offset, size,
> > >                                      parg->type->is_signed,
> > >                                      FILTER_OTHER);
> > > +           if (ret)
> > > +                   return ret;
> >
> > [Severity: High]
> > If trace_define_field() fails, does this error path leak the newly allo=
cated
> > strings and the tpe->field_strings array?
> >
> > Looking at event_define_fields() in kernel/trace/trace_events.c, the re=
turn
> > value from this function is ignored:
> >
> >     if (field->type =3D=3D TRACE_FUNCTION_TYPE) {
> >         field->define_fields(call);
> >         break;
> >     }
> >
> > Since the return value is ignored and the event's field list remains em=
pty
> > if the first argument fails, couldn't the system invoke this function a=
gain
> > on retry if there are multiple trace array instances?
> >
> > If it is retried, the initial kcalloc() unconditionally overwrites
> > tpe->field_strings, leaking the old array.
> >
> > Additionally, since tpe->nr_field_strings is not reset on failure, woul=
dn't
> > a retry start appending string pointers out of bounds of the new array?
> > This appears like it could eventually cause trace_probe_event_free() to=
 read
> > out-of-bounds pointers and pass them to kfree().
> >
>
> The above looks legit too. Please address it.
>
> -- Steve
>
>
> > >     }
> > >     return 0;
> > >  }
> >
>
