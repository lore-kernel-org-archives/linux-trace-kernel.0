Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A194330B0B
	for <linux-trace-kernel@vger.kernel.org>; Mon,  6 Apr 2026 11:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775473728; cv=pass; b=WUvsRLavzXuAE6oqIzdABRCBO6xP+n3lEqctF1k5enj993HLBiog/Rx/ajSazzVNXy2tpekCXAuikRCIzjhMbfDAGnX9ibBLo2TyfHMGt/5M6QIS32tQYD0Os19+PPhM0+/B7M7isr99YwFlP0SC1aAXnCc/nSNukkpnV08ML2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775473728; c=relaxed/simple;
	bh=3Mn9GDNV4q4vxUyTCDjrB4FuPzCEazKiwy8siM7vem0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kFECXtQiV0gFatawxuHBegEBgsehjquFeSvMsfH98uRunr8nZHne/y70FI+qjNjn/Atu/dKE3pKywx0tWoYwdWnzeqbJgO8snBj6DW9rHVUneTwJt5Od6mU7G4n8G+8eZTEejYxKFHV51sL62Prh+PGkJYaJEvd/sd08d4jahx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZ4QxFvv; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZ4QxFvv"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-79ee5037d44so48681417b3.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 06 Apr 2026 04:08:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775473726; cv=none;
        d=google.com; s=arc-20240605;
        b=D9Nh4fNw6SNFYlHlTjEL+Ef5JKEH68DLZaVDKbHB1RTxqGU9nTL4lpXrNEVlwaSAg9
         m3F0rgJ3l7vwIjUTBagYRyVOYKG6zdoSAwCSWYdLsRMkOZbsSez758weqS/99mM4cpxz
         CyXOnE77kSAqVLET2rg+B9PlAakpSap8TUEX6psz9ztP91L7+TazWVW0XcIVwMMdQHjQ
         ORp8d3td5rCR7GkEnrZIktmH3gTZpBAQyOtrP6NT3ltRk/8JfpTTOAuPzdGi166I0qt2
         oisT+uDX9i2D/g3S/eFrgkWdwUoNApDLWHqXwkBMUvamUBF89RSOi7OHaXSBOakZBuds
         H2UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zRgqqTkqqqhQIPLoGqXnLl2qMP89ZJM8SI/ZvvSsQH0=;
        fh=HkwiQAwOTeWTC0zKhIYHSBProtnH9oGU/AAzu2TXi30=;
        b=FI0rJ1idrLU5lVavCGQCSnbcDzenYPFFakrpnYjc49PX+q0ju0SEvYlmr7QzNb+Fhn
         X4RbzhJQspPjOtbZqOcU2QuY+P8Ai7YjQZzdfP19pqtsresMplHN9OwdmrepiMg0/21J
         BD1KcKfap0BJlRsUFwU6T60ONoORSRcC3+s5RltJ4iVgQ718AyB+tTZOVUTRto9arxfg
         Ocovnv4hkt8yMcfRqfWo18MNZFcICOm026k+1yKFPuwtTK04No6/MQCvliLFUnjm1oIj
         DuhwEs4IT1ghFGRLauxFbjlZFjLxFtcAl71bHa6NT4k5aZiOQvIc4BIGfknMuzTFLzHo
         UqYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775473726; x=1776078526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zRgqqTkqqqhQIPLoGqXnLl2qMP89ZJM8SI/ZvvSsQH0=;
        b=bZ4QxFvvCM5l3OfS17/UpRJc6ZJYHUz5HZaKqfP8flALIwz3RSXuxVwG0I5ZJkIycL
         za6eysKesfA0qTLX4yCyCNKpJIaoCIMQrsntOK5NZxezP7j1ZZNMBUOguMZMFoH/ixWP
         fZmSSqGg5rwuZzBwv4Cnd8OgGluo2uBJuX5dgVEar6b5luVlWgLCS8FlypKqSRWFr8Om
         JgTdHP3cPcaa4za0n3e0gOd99RUeMQxVxMtc8Oh3rnP8nISVZWxJeLd0Ccz6AWjOk5IZ
         7JNVANzPpUcQMnoQkrxKlojWRNcO0+Y2RsW1GzgUFGSUdAkUqhuf38puYV1VY8+QCwJI
         Lyig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775473726; x=1776078526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zRgqqTkqqqhQIPLoGqXnLl2qMP89ZJM8SI/ZvvSsQH0=;
        b=hhiEp/Epdtgt/hC6i63NdvAIHcgrFdOt7m/5hY3Co+4BsgZAH4qW9eynlfFzxETDIY
         hAVb0tP51DPvHBm8mWWprpY0EbP1pvmPvJJshMG494YCXcodhIXhFfdT3N4hIPRA73zJ
         fLe/g2+7E8cN6Yl99RW9f7vpRDIzEZPMdIekDF1gbrCeSwRYD2G12OwomaYxRAlKG4xj
         gkyDYEgceIyHlxeV7h79uAdE/u83h8TLe+hSns+jdjf9GgLFqcerLjqJLxV/9AM1WGB/
         ZhUBY+aiC7Da7cpMb7C3v+eY/qctosx/aXLf3PWX592wfUQ7wGoMXEYWrCgQ3dWrw48Q
         xh6g==
X-Forwarded-Encrypted: i=1; AJvYcCX94gKy3mJ6ksjIcpfMLdqDgpK5riPMSceJ2X89MpsycjDD752UeTj8waB3Vs2OCDRD/nXEN9bZmWOyU2sH9B+kiCs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzMwgPRhjo/WL8GL9z5WoUw+mooR5Pw3AfiwLnL/vs1QyU6+ZC
	XCzqW2c4faXvM9x93e4MOGchLd0UsEIZ/qM5acdP5NsRvJwLYSGu3pku9vCaXgIlT7d1twuh3X6
	VxJlZdhDsQN6T0CpfWQU1PaWam5sADW0=
X-Gm-Gg: AeBDievKi7uAUgcWAuvEPgBLecHjtbq6HQ6ADnq0CwCVPJkwm5o+VhN4A/iZqEfwlv4
	ZRTFA55tJ2WXdpIWQDsZ+w/nXi1HF9m7BMrUCWPwIq21QFDPrKWLZ4gWSofG4NM7K2iB7QwHLa1
	rAaCO4HQQSjq4msrORJ+qDFmIB47Oh+rlT5KMopt5rNYodWWZHk4TK//z9JQj3174PHhQhkxbK7
	N3yAQkTZ1LEIrC5/B/jjITjFaGsnDD2IcS7QAu5d1cIcFtu1QptnjcZ2l/6suiYT6JM21fUNmnX
	sNGyXNkth6LKpNZM7QZNvR2hZxY0xyJwbKEaEkg=
X-Received: by 2002:a05:690c:660c:b0:79b:e051:96e8 with SMTP id
 00721157ae682-7a3bdd81cb4mr120300357b3.19.1775473725931; Mon, 06 Apr 2026
 04:08:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402092607.96430-1-laoar.shao@gmail.com> <20260402092607.96430-4-laoar.shao@gmail.com>
 <CAPhsuW51Hh7XfN6xXm_uMAoDXBBQoNQ5ynqom+wVNdqCt81f2A@mail.gmail.com>
 <CADBMgpy3e25EH5xbKMN5GeOK47jE6uzviknbt35V49_Y7zFj8A@mail.gmail.com> <CAPhsuW6p3YOv3_M_c0ThMcrNqNjT=7i46ekJBrWO_oGzQkxrxA@mail.gmail.com>
In-Reply-To: <CAPhsuW6p3YOv3_M_c0ThMcrNqNjT=7i46ekJBrWO_oGzQkxrxA@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon, 6 Apr 2026 19:08:05 +0800
X-Gm-Features: AQROBzClNHdpWRN0VTHhIbiSXgzDQrDfqIlpgmQNcrbfQYOo_c0hDREkWaKO-G0
Message-ID: <CALOAHbCbcw2jpjk9JD9yyf+SMpQ-s9FAonSaz7Gs4XUeP+w+2g@mail.gmail.com>
Subject: Re: [RFC PATCH 3/4] livepatch: Add "replaceable" attribute to klp_patch
To: Song Liu <song@kernel.org>
Cc: Dylan Hatch <dylanbhatch@google.com>, jpoimboe@kernel.org, jikos@kernel.org, 
	mbenes@suse.cz, pmladek@suse.com, joe.lawrence@redhat.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	kpsingh@kernel.org, mattbobrowski@google.com, jolsa@kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, memxor@gmail.com, yonghong.song@linux.dev, 
	live-patching@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 4, 2026 at 5:36=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> On Fri, Apr 3, 2026 at 1:55=E2=80=AFPM Dylan Hatch <dylanbhatch@google.co=
m> wrote:
> [...]
> > > IIRC, the use case for this change is when multiple users load variou=
s
> > > livepatch modules on the same system. I still don't believe this is t=
he
> > > right way to manage livepatches. That said, I won't really NACK this
> > > if other folks think this is a useful option.
> >
> > In our production fleet, we apply exactly one cumulative livepatch
> > module, and we use per-kernel build "livepatch release" branches to
> > track the contents of these cumulative livepatches. This model has
> > worked relatively well for us, but there are some painpoints.
> >
> > We are often under pressure to selectively deploy a livepatch fix to
> > certain subpopulations of production. If the subpopulation is running
> > the same build of everything else, this would require us to introduce
> > another branching factor to the "livepatch release" branches --
> > something we do not support due to the added toil and complexity.
> >
> > However, if we had the ability to build "off-band" livepatch modules
> > that were marked as non-replaceable, we could support these selective
> > patches without the additional branching factor. I will have to
> > circulate the idea internally, but to me this seems like a very useful
> > option to have in certain cases.
>
>  IIUC, the plan is:
>
> - The regular livepatches are cumulative, have the replace flag; and
>   are replaceable.
> - The occasional "off-band" livepatches do not have the replace flag,
>   and are not replaceable.
>
> With this setup, for systems with off-band livepatches loaded, we can
> still release a cumulative livepatch to replace the previous cumulative
> livepatch. Is this the expected use case?

That matches our expected use case.

>
> I think there are a few issues with this:
> 1. The "off-band" livepatches cannot be replaced atomically. To upgrade
>    "off-band' livepatches, we will have to unload the old version and loa=
d
>    the new version later.

Right. That is how the non-atomic-replace patch works.

> 2. Any conflict with the off-band livepatches and regular livepatches wil=
l
>    be difficult to manage.

We need to manage this conflict with a complex user script. That said,
everything can be controlled from userspace.

> IOW, we kind removed the benefit of cumulative
>    livepatches. For example, what shall we do if we really need two fixes
>    to the same kernel functions: one from the original branch, the other
>    from the off-band branch?

We run tens of livepatches on our production servers and have never
run into this issue. It's an extremely rare case =E2=80=94 and if it does
happen, a user script should be able to handle it just fine.

--=20
Regards
Yafang
