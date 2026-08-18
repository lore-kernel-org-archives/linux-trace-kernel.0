Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33C55474F
	for <linux-trace-kernel@vger.kernel.org>; Tue, 18 Aug 2026 22:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787092267; cv=none; b=iS9faGsALzva5DCoYIrPpG6P2V4cXtWsKHDCcNPjE7xHDSHCHh0vY9znKusAp964nWBxrwpHvb4gXOleRA6GMD0g1U+EJrJERoe5KrMR9OA2GCva/AoTUXd6/CYswU1JCacP/+lNA0EU4YDI0+aaXNu2sIfjN+oNcGrWFmYvNrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787092267; c=relaxed/simple;
	bh=cEAUlVrnwFYcUbaih8b4M/AXALgEnPiYvfqYIUSFi8A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T0gxir4TdC8kBMuoSztsHFQC0w9rqf06U6ESulvEbe3/e/WUXOHwrPtWm2JvBvl/eMvuFZTRmrkH5GTF7LYoqr4kuMa77zHD4ibbghnEaTBk9LJ6QecHnIL1L/Hac5Jh7vnNk85NK8AVqFAbMClf1NAdNoPGl9lKZkG8J9CAnZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eSxk4ReW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eSxk4ReW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787092264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ka33O0a5qwccrjVpff6VzG4m8rfuJ6C/aWMH+nm7MRc=;
	b=eSxk4ReWbSJNIMdfAQrVU7m7UVQpIIV3CMWCqpevTA0UhFVCrOECIx9zXutLHGr12lkZaT
	TkZ6xL3z0rYPKmaSZkPW81uzpuZA3c+vS0OnSXWyL1DGVvvCrL9B+Rv2Q7vpj34+pgvPC+
	5mfXE8Lgx7CvC5Tp1EJ7hb7hybLGOuE=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-oZ84z7i_P2OL_nLZCyB7uQ-1; Tue, 18 Aug 2026 18:31:03 -0400
X-MC-Unique: oZ84z7i_P2OL_nLZCyB7uQ-1
X-Mimecast-MFC-AGG-ID: oZ84z7i_P2OL_nLZCyB7uQ_1787092263
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-52d33c89a29so5056041cf.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 18 Aug 2026 15:31:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787092263; x=1787697063;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ka33O0a5qwccrjVpff6VzG4m8rfuJ6C/aWMH+nm7MRc=;
        b=TLVv0crXbvuREjK2SWdiGiOtErZMtUsvMo5+/tvEUMt3ncDhxykVQm/C0NcUMmK+sD
         ozY24Ae5ZN7KXtToVygUK5hnA9PLIlQb0zybNzAs/rqbxw5vEQ3Tb6Dl8OZj/u6xvAKg
         euwSOpGJ23myR/Ac9sWBNW1B42kD2r6ZCdq6hWyzWIOh8aYn/3gplD6i+2bston65Uk1
         cMVZIg7FIQzm8F4YI5bDMYUYFY1OZlfFmCIsFa0sqbaMfq5/o4u3OtnqoR2HZviun90V
         4znxMf8hF7XBpktwdGC57v+dJgvWovDfw76Ksy2MVs5C4iho4/3Jme5eQD4KgJodmtk/
         j34g==
X-Forwarded-Encrypted: i=1; AHgh+Ro+js8fgnl0bZNVzcP42G+9ghP39g0/or5YR6mdESrfP/Wnwk4gaJhWLmWGvVLbL9XNh9PD6o2kjBB8fLSyZTGJnsY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBpUkT5nfFw/rA1Gw10NbCbxFT2dkvhjy07UMI1QgL3b3eIf4l
	i7jlkKhdDwvAzlwTIEoTumZeuXhEnk38V8pSTq2k2mDMVVWLkmTSRJXwmUqSHn0P4wMecGVHT9o
	SPc30xFlYuw/vpwHuS8dHJSOvnr7Mkumb+MGJJvmOkIns4eqfvZSMsWlhFVgm8IHBxZf7udYbDw
	==
X-Gm-Gg: AR+sD133oIqpesxORVlL5hFdWcki+1rWE1WWY1WtmQeOjcrwyfD7cI0ob0DsiaVh1Yb
	8qrupIPhSt2jQfThArE0lvK1luAgRtPEq77x6kHciYoDCoDGfHJsAeGv4RrwdoRVK52Yt9nx7kp
	LEIHqgzdczow5XbGhvoP/dTAcGGhoBJfUPqy3GrmfQUbUExCs+Bsr2cYxyAiJqCMTG5DRpkf1bU
	FobCMS3LxX2HAd3x5ZP/3mERrShV2GJHCZdduMMj6aaw8FdJwpsmanQCwRZ2muNGCRSqOO0KDJC
	mH/EkOFWHp/KPE1v9LMokwqMED+4pyHDlo49Kdqmg37wX9dt47mMnPKacVDfxKhvjHvm+NLvFem
	P1JcWk+DSqbf8tsm/vnuaizTjjQVEuMpb
X-Received: by 2002:a05:6214:450d:b0:907:bf2a:481f with SMTP id 6a1803df08f44-90c5e7142cbmr2306726d6.1.1787092262719;
        Tue, 18 Aug 2026 15:31:02 -0700 (PDT)
X-Received: by 2002:a05:6214:450d:b0:907:bf2a:481f with SMTP id 6a1803df08f44-90c5e7142cbmr2305906d6.1.1787092262259;
        Tue, 18 Aug 2026 15:31:02 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:cc01:6890:c623:cd89:345e:99f3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c5eec3214sm226246d6.16.2026.08.18.15.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 15:31:01 -0700 (PDT)
Message-ID: <67895578a730d56a50568a7403ba4ef8f7b3e24a.camel@redhat.com>
Subject: Re: [PATCH] rtla: Simplify osnoise tracer option setting code
From: Crystal Wood <crwood@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, John Kacur <jkacur@redhat.com>, 
 Luis Goncalves <lgoncalv@redhat.com>, Costa Shulyupin
 <costa.shul@redhat.com>, Wander Lairson Costa	 <wander@redhat.com>, LKML
 <linux-kernel@vger.kernel.org>, linux-trace-kernel	
 <linux-trace-kernel@vger.kernel.org>
Date: Tue, 18 Aug 2026 17:31:00 -0500
In-Reply-To: <CAP4=nvRMAZ6AJ_WQPVM2sm9jH++4RwN8DhodU7oL6-AcXNg8OA@mail.gmail.com>
References: <20260612115121.54862-1-tglozar@redhat.com>
	 <725da8a4ca6a46ea8ba41778971602b49d650e60.camel@redhat.com>
	 <CAP4=nvRMAZ6AJ_WQPVM2sm9jH++4RwN8DhodU7oL6-AcXNg8OA@mail.gmail.com>
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RECtcwnyg_USt0brm7GsVMnKa6_NN0ortTstpA-_yag_1787092263
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-07-03 at 14:11 +0200, Tomas Glozar wrote:
> p=C3=A1 12. 6. 2026 v 19:55 Crystal Wood <crwood@redhat.com> napsala:
>=20
> > > OSNOISE_LL_OPTIONS takes three options: name - struct osnoise_context
> > > field name (written "<opt>" above), path - filename inside
> > > /sys/kernel/tracing/osnoise passed to libtracefs, and init_val - init=
ial
> > > value of struct fields, corresponding to an otherwise invalid option
> > > (some options use OSNOISE_OPTION_INIT_VAL =3D -1, some use
> > > OSNOISE_TIME_INIT_VAL =3D 0).
> >=20
> > Can we simplify by always using -1?  Especially since that's already
> > treated as the universal "invalid" by osnoise_read_ll_config().
> >=20
> > FWIW using "init val" to mean "invalid" rather than "default" is a bit
> > unintuitive.
> >=20
>=20
> The idea behind *_INIT_VAL is to re-use a value that is invalid on the
> osnoise tracer side to mean "not (read from tracer and) set yet (on
> the RTLA side)". OSNOISE_TIME_INIT_VAL is used for values where 0 is
> invalid (e.g. period, runtime), OSNOISE_OPTION_INIT_VAL is used for
> those where 0 is valid.
>=20

Right, it just hurts seeing something called "INIT_VAL" that isn't the
initial value. :-/

> > While we're at it, can we move this code to common.c, and drop
> > "osnoise" from the names, to move closer to using that only for the
> > actual osnoise mode?
> >=20
> > Or if we really want to namespace things that are specific to the
> > osnoise subsystem (i.e. everything implemented in trace_osnoise.c) but
> > not specific with respect to the osnoise/timerlat split, I'd suggest
> > something different like "osn_".
> >=20
>=20
> They are called "osnoise options" in the interface (although they are
> shared with the timerlat tracer), which cannot be changed. I don't
> like using an esoteric prefix like "osn".

I'm not suggesting changing the kernel interface, just having some
convention within rtla (and within trace_osnoise.c) to make it clearer
which things apply to osnoise-the-subsystem versus osnoise-the-specific-
tracer.  It might be "esoteric" which one gets the abbreviation, but as
long as it's consistent I think it'd be an improvement over the current
jumble.

>=20
> > > + * Long long option get/set/restore/put functions, generated from OS=
NOISE_LL_OPTIONS.
> > > + */
> > > +#define OSNOISE_LL_OPTION(name, path, init_val)                     =
                         \
> > > +static long long                                                    =
                 \
> > > +osnoise_get_##name(struct osnoise_context *context)                 =
                 \
> > > +{                                                                   =
                 \
> > > +     long long name;                                                =
                 \
> > > +                                                                    =
                 \
> > > +     if (context->name !=3D (init_val))                             =
                   \
> > > +             return context->name;                                  =
                 \
> > > +                                                                    =
                 \
> > > +     if (context->orig_##name !=3D (init_val))                      =
                   \
> > > +             return context->orig_##name;                           =
                 \
> > > +                                                                    =
                 \
> > > +     name =3D osnoise_read_ll_config(path);                         =
                   \
> > > +     if (name < 0)                                                  =
                 \
> > > +             return (init_val);                                     =
                 \
> > > +                                                                    =
                 \
> > > +     context->orig_##name =3D name;                                 =
                   \
> > > +     return name;                                                   =
                 \
> > > +}                                                                   =
                 \
> > > +                                                                    =
                 \
> > > +int osnoise_set_##name(struct osnoise_context *context, long long na=
me)                      \
> > > +{                                                                   =
                 \
> > > +     long long curr =3D osnoise_get_##name(context);                =
                   \
> > > +     int retval;                                                    =
                 \
> > > +                                                                    =
                 \
> > > +     if (curr =3D=3D (init_val))                                    =
                     \
> > > +             return -1;                                             =
                 \
> > > +                                                                    =
                 \
> > > +     retval =3D osnoise_write_ll_config(path, name);                =
                   \
> > > +     if (retval < 0)                                                =
                 \
> > > +             return -2;                                             =
                 \
> > > +                                                                    =
                 \
> > > +     context->name =3D name;                                        =
                   \
> > > +     return 0;                                                      =
                 \
> > > +}                                                                   =
                 \
> >=20
> > Using "name" for the value is confusing... "val" would be better.
> >=20
>=20
> But it's the *name* of the option/field/argument here, not the value.
> If you use "value" you'll get:
>=20
> #define OSNOISE_LL_OPTION(value, path, init_val)
>=20
> which is incorrect. Would making the macro options in capital letters
> (i.e. NAME) make it more clear?

That's not what I meant.  I was suggesting this:

int osnoise_set_##name(struct osnoise_context *context, long long val)

-Crystal

