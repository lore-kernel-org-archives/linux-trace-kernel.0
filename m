Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0856386C09
	for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Mar 2026 16:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774369830; cv=none; b=FVubGvLOPEM1slLw91QLm00TO5UvvOCVi5nqeXSnFCGKEYIsv+A3wTvxvPilzBrkhyRsX1SEwN2DMRbF56MUKuxvazWSCMvm3c0aCKwAQQPq/bGBwjkhW65f1jQ1jDEYB3b7uAiFDLpsnjEXIIbmuxQ/jSB3Mhn6V2T+NBjSAr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774369830; c=relaxed/simple;
	bh=GedLTtgddWEJUyRlhK6X15vbM4AFh3IuYy7fD8Qy7UA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A/IrTdFXpOifTK3HCKP4Dzx81kW+ttZ/qHgpgofaF52IHKxy0JREWTGsW7uVMGtFpo4eg3eV36I2q5wrBwqk3VdG1JpVH7XPVGIueSM0g1AdwE1l12tDTZDcKmaPy/yLWhqTmCa9Sn/VWza1TWhwuxp1spY/FJBV1zyEZaiwBiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MwZepDhN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MwZepDhN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774369827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cy/sMQ7RhCqH87m41O4mchOBapesGxmdoWuSE/4nMCU=;
	b=MwZepDhNzt/8J1M/Ds4aoCirzbQIfcqCQN/E3NGNluhXw3NZwe6aE0G7ZBJej4Y41J6E58
	Gtx0x8hpMpikuoKbMcouDl290ucBCtLLdGMgJqn/KB4lNe1/0keyqCRCK48gWaKh+bGnXA
	QsRhnAXgHAzM7nWA1JvjY05OPobVkWY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-PnZ98AQcNq259gLrmbqNnA-1; Tue, 24 Mar 2026 12:30:23 -0400
X-MC-Unique: PnZ98AQcNq259gLrmbqNnA-1
X-Mimecast-MFC-AGG-ID: PnZ98AQcNq259gLrmbqNnA_1774369822
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b983ca42edfso3262766b.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Mar 2026 09:30:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774369822; x=1774974622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Cy/sMQ7RhCqH87m41O4mchOBapesGxmdoWuSE/4nMCU=;
        b=iJsrgmaFvMTtkF+8MuqBGDG34u9fXdu77hr7oeU65LucAZLYzzk5ydQTHh/GgFdAyl
         lrj4/hVCH1gNVOElMPAKNf9BYjTqtplBYAIcCKbLgFyYFFcw9F5d8+NAWz7sBvIgvPpe
         PHAHBZD9a7CnBhud71fZqZ0OPkLj294XJwQYdmaI2UscVWYdQWlbeYMkYq27g8cmWbYG
         MpgTu+b23hzjnIdqjcO0JJ2Vlf2cLPWK/B/kols4I1olJkH+/R2R2DMKubuhp8gh0U2a
         ReFSW+64abd0EvIvepA5ufnhZ9nHWKwoXavWeprgImJjFlUKwf0voLWh7OkvOAkSCNwY
         iYRA==
X-Forwarded-Encrypted: i=1; AJvYcCXnLpMY+uYZ9AmPGUivNTvKHpBpQ758xTT6/xK3ubtkS6n6aCh5/oMBkg09v5Kb8QYYtXOZxrdzhNb58scJFslnKds=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf2F7FcWbQU0Mgt/BKosND5eiIJLn8JjtMohplqWEZfCuA9n13
	UVB1nOSn5bjo+3APsSaQDRGGw4AG+r6Sk5+bzDYHORaEV2ikHaCO8k3s4F+wVoTM/+qxdHQlsnT
	5UOAFbaTdttWLptddwdlbWBDQgxezdvywhHsVfeFDhDTEFYgAcHVGARnJB2Q+lZhBYGd20pTzdL
	xDsb5sGH7mefhe+Q4OwnLc7LG/BI0iTikiUnhOtKzNV+mbZDuu
X-Gm-Gg: ATEYQzx9laR/sh/WS8hz1W7uWmNSBQz8v0h9qhsr78yTNx4fornk9c8S3L6Dkjzuurj
	0WPGGLBCNCFhw7jSwHX3AZ6nzndwFmfAbbuJ4z0yAEA9Zq3oxvUQ+jSxySaNfjv4+xD2kvK2TCZ
	xPEk9M694xBZVw1dqsX95SveMFPipKDoEet5+enwsOxYbour0hiv/62L+izA7Pu+IE/Uqc0y1Uc
	irE+A==
X-Received: by 2002:a17:907:e916:b0:b94:113c:a89e with SMTP id a640c23a62f3a-b9886321044mr276826466b.11.1774369821839;
        Tue, 24 Mar 2026 09:30:21 -0700 (PDT)
X-Received: by 2002:a17:907:e916:b0:b94:113c:a89e with SMTP id
 a640c23a62f3a-b9886321044mr276824466b.11.1774369821401; Tue, 24 Mar 2026
 09:30:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324123229.152424-1-tglozar@redhat.com> <20260324112249.5fe25641@gandalf.local.home>
In-Reply-To: <20260324112249.5fe25641@gandalf.local.home>
From: Tomas Glozar <tglozar@redhat.com>
Date: Tue, 24 Mar 2026 17:30:09 +0100
X-Gm-Features: AaiRm50Win-KQMvQ3JCFdbn6fqEhXmkuYyGL5536EXJW4ZPMCiOhtVACMahWg9I
Message-ID: <CAP4=nvRj3beYwzWKwGFRsM350xYhVwcOAUZBuSBsHfAeawk-oA@mail.gmail.com>
Subject: Re: [PATCH] Documentation/rtla: Document SIGINT behavior
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	John Kacur <jkacur@redhat.com>, Luis Goncalves <lgoncalv@redhat.com>, 
	Crystal Wood <crwood@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	Wander Lairson Costa <wander@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, linux-doc <linux-doc@vger.kernel.org>, 
	Attila Fazekas <afazekas@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: P0vT-sY0aecfOBUt7mM50627ueBY7KCzoXmQLSMvvyU_1774369822
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C3=BAt 24. 3. 2026 v 16:22 odes=C3=ADlatel Steven Rostedt <rostedt@goodmis=
.org> napsal:
> >
> > Note: There was a bug in SIGINT behavior, fixed in upcoming commit [1].
> >
> > [1] https://lore.kernel.org/linux-trace-kernel/20260310160725.144443-1-=
tglozar@redhat.com/
>
> Hmm, this may be interesting enough to add to the change log itself.
>

I thought about that, but it felt a bit redundant, since the other
patch will also be a part of the commit history. I see that some
documentation patches do mention the commit that introduced the
change. Here, it is only the SIGINT during cleanup part that got
changed (segfault/undefined behavior -> default handler) so it might
make sense.

> > +Also note that when using the timerlat tool in BPF mode, samples are p=
rocessed
> > +in-kernel; RTLA only copies them out to display them to the user. A se=
cond
> > +SIGINT does not affect in-kernel sample aggregation.
>
> But does it affect the user space side of reading that information?
>

No, it shouldn't, the pattern for both timerlat-top and timerlat-hist is:

while(stop_tracing) {
   timerlat_bpf_wait(...);
   timerlat_{top,hist}_pull_bpf_data(...);
   ...
}

The BPF program is detached after this, so all data gathered up to the
point of the SIGINT will be displayed. A second SIGINT does not affect
it, since it calls tracefs_iterate_stop() which stops
tracefs_iterate_raw_events(). It does not stop
timelat_{top,hist}_pull_bpf_data() - which is aggregated anyway, so
stopping it would just leave a part of the histogram/top empty.

> > +
> >  EXIT STATUS
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
>
> Other than that ... LGTM,
>
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>
> -- Steve
>

Thanks for looking at this.


Tomas

