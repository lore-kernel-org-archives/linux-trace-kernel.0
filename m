Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829A932C957
	for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Nov 2025 18:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764094237; cv=none; b=U5lOacl83tZCOHjn252TsaVGnBCNP/fAGmZUfvw7XYw+XB8iz4mCfMZj49n+6BShaThBa2USbFysk3pKoMl3RL1Q5iglqilj14/EBwGDeAG87gdY5G9dgSESm5X3PoMgBPCUroikAhMP/1+3ggcHVOZrBg7AePp8zgGkjciW+bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764094237; c=relaxed/simple;
	bh=4g7xrRU2lpdiOPzjszXQs5lmY/lkSZOz4y4TRRzowuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n1rSJJbnz7J8jTF8W71DI6uzbmTmzRum8IesAP7YIKRVWRwCAjfOdyiF1dL634NDyzlzuHui5fOLNbSoO1e4Hx6PG5jEuUMl+GC/Aa5k2Wh/8WsJ82YRlkGcP2lJYfo1cktTJFzVkuM2gFJAfW+dO6O0dOvtEwOefZNW2mXcITM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JwGbbv4k; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JwGbbv4k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764094234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cnw5p4Mr2cXRljwPqXaWsy1Fv2cqOobT8sUiZC6XQdg=;
	b=JwGbbv4kfbND8aCyt3ondE6QBHx6cKyuvhLF7LXd40akGErrPFIZNP9Ok6OUvMFNnmNXOO
	yqZ5I5KC9/cNXNCAvYse+VcMOH/+9ceqEcA9tJT+0eoxmrKjKM83RMdzFIYNfhoCPHM8ow
	Z/lnJFTVbt/IQn/3jU9/DjpM3w5XXl0=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-9MWMrQY-PTKHBMxKMH_oYg-1; Tue, 25 Nov 2025 13:10:31 -0500
X-MC-Unique: 9MWMrQY-PTKHBMxKMH_oYg-1
X-Mimecast-MFC-AGG-ID: 9MWMrQY-PTKHBMxKMH_oYg_1764094230
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-37a2d8cc3d3so332581fa.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Nov 2025 10:10:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764094230; x=1764699030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Cnw5p4Mr2cXRljwPqXaWsy1Fv2cqOobT8sUiZC6XQdg=;
        b=WLpHIUUgo37iIgFh8myp57yDNIPPKLvvWamxuXejbp+yp6K0tfUgTlPPxZj5Qv+Foo
         VucOQA+QLCeKZ+ggxpZeJXa9FKeL8Hmw3lRP+a6yjfvrnbToroiZUHKFthzkx7zEZ79k
         K0V0InAdiT2lTtv1J9LnIlxHwhsu/RKkU82GqvicFJLM6gBvdimJowIL3I/Bh86B0f/a
         cOcUkkRDq6zazHp/561hkRt//sn7iXzNRL31E2+XEKN0R3RXJROghUFccvY6ffru/r68
         3eiYBZdk6rnv+hodbSrxBbkgHx7kZKVHn7AqKTTAh5NTtjE/xG21a8vNjftsuks4u31g
         G5LA==
X-Forwarded-Encrypted: i=1; AJvYcCV9XCmjlLwH8EevvbQvBCN0PeDS5KHtM9OTmvI7ISSXl6farFPctoE3PLbX0Fc+6Mll69K0O9/cxxPdVhQjtmRU6Hg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx776vGE1m8MX+SX3cLWn2kNE/aMdmySi5Qe62lJO7BZo0Tm80+
	Jpgv4wy9VI/9yA/vl/qXap+kC+LbtF+jnup5pLaGss+ANGKHAzbfBzURylbVw2vjHkXssXFxfws
	BwTjhyZMSfDm2csjDqI02qcdkqTF4BqMp9UHBsJ2svtqDoXZAyIoxWSBb9grh/qBGNFBp4oWSqm
	k6GWqJRfWQ2GbtsKTuEAPy0ElasXyVJjZlAs1o4jjTDkuBwp5V
X-Gm-Gg: ASbGnctCtEsBCp6e4p5vbA6Q7A2nphbU4lo9/xdbwqiL1FrIlXnxX+o4Si43O8C0IBv
	BFU0fgfQLQhXUH+OyKyLe6E33U6OcSMnBDp5F8yYby2ZJcujMdz1Rq4Q/oT9744y7/kNyu6pFJE
	JL90rALuWrRHkSiVX4OlxoBN/fXcf2A7fptZRyClw3h2BeiAGcAm2QWkWpsXWUkZBrhg==
X-Received: by 2002:a05:6512:2311:b0:594:2f25:d491 with SMTP id 2adb3069b0e04-596a378a57emr5474939e87.16.1764094229548;
        Tue, 25 Nov 2025 10:10:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG3bLL2RpC0XPBZEkU5LO2Aurh/OCSPQjH/2qdBJtFq0fHMb4yOaVfYi9qCWKIktzKNcDJgytAETU1wE2gMgc8=
X-Received: by 2002:a05:6512:2311:b0:594:2f25:d491 with SMTP id
 2adb3069b0e04-596a378a57emr5474928e87.16.1764094229085; Tue, 25 Nov 2025
 10:10:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027153401.1039217-1-tglozar@redhat.com> <20251027153401.1039217-3-tglozar@redhat.com>
 <liouklnl72kulibowk33roalgtjor24u3h6hfbuzudlodasdvz@fhy2zeif43nk> <CAP4=nvS6zDkb-yo+uu0LHk=OBKP+UO-p46tLygGOUG0zkrkbiw@mail.gmail.com>
In-Reply-To: <CAP4=nvS6zDkb-yo+uu0LHk=OBKP+UO-p46tLygGOUG0zkrkbiw@mail.gmail.com>
From: Wander Lairson Costa <wander@redhat.com>
Date: Tue, 25 Nov 2025 15:10:16 -0300
X-Gm-Features: AWmQ_bl90P1rpEUjOXLdCdkG8uIoDNMvzYlETUf_5prv6XHxIqiR26DWvlgWjeQ
Message-ID: <CAAq0SUmqMFFyP8JFfvwHZvmwwC=-X=nMzVA=LEbD+PBX_P=L+g@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] rtla/timerlat: Add --bpf-action option
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, John Kacur <jkacur@redhat.com>, 
	Luis Goncalves <lgoncalv@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	Crystal Wood <crwood@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NDAkeDuDkY4zyUog4lvqj1bL2GNqVgA7cEIYCUP23G8_1764094230
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 10:49=E2=80=AFAM Tomas Glozar <tglozar@redhat.com> =
wrote:
>
> po 3. 11. 2025 v 15:45 odes=C3=ADlatel Wander Lairson Costa
> <wander@redhat.com> napsal:
> > >
> > > Executing additional BPF code on latency threshold overflow allows do=
ing
> > > doing low-latency and in-kernel troubleshooting of the cause of the
> >
> > typo: double "doing"
> >
>
> Thanks, I'll fix that :)
>
> > > --- a/tools/tracing/rtla/src/timerlat.c
> > > +++ b/tools/tracing/rtla/src/timerlat.c
> > > @@ -48,6 +48,17 @@ timerlat_apply_config(struct osnoise_tool *tool, s=
truct timerlat_params *params)
> > >               }
> > >       }
> > >
> > > +     /* Check if BPF action program is requested but BPF is not avai=
lable */
> > > +     if (params->bpf_action_program) {
> > > +             if (params->mode =3D=3D TRACING_MODE_TRACEFS) {
> > > +                     err_msg("BPF actions are not supported in trace=
fs-only mode\n");
> >
> > I would just emit a warning to the user and proceed ignoring the bpf ac=
tion argument.
> >
>
> I believe if the user explicitly requests BPF actions to be used,
> measurement should not proceed without the action. Imagine someone
> setting --bpf-action in an automated test, expecting it to report
> something. But the action never fires, because they do not notice they
> are running an old kernel that does not support this.
>
> The user can always restart/reconfigure RTLA to skip the option.
>

I was thinking in a more interactive debug session where you go back and fo=
rth
with little changes in the command line. But you have a good point.

> Tomas
>

