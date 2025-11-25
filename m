Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A59F21CFE0
	for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Nov 2025 13:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764077687; cv=none; b=iVs3Op2e44OZrryoORMxES+7WgDeMMxCm4+UxbU3tkRQMQ2DppovTLPa61g+uBWFkQhV3FRa6fau6+vZsv+Xc8maRZcV5oADK3lj9UXjGLiP8qJvjDexUnkA5f+rSmaSDUzHeWXobN0Zrava0ceGqewQbCKwJzwZkmZPWdD6MTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764077687; c=relaxed/simple;
	bh=etD/zC7KgIaLoz8/uK0eNdolW/aHkPh00njUq2K4OIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nxbe6Jkb2fiDXnxEKwmm17YC7Qib1+qfycWKy2FyIXSKLjIP5OtPz1gkaH/m7lv8USwfgzEUOP9KmSftnuKiO8kWQceZ5cQq9Tc2bUlRVkAj9hSO8wlMz6Cr43N8ESBEsqt6e1lc6+mZ+l3cBSmegDkbKv5+FL/HOelc30wH3iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dfLo2ZiD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dfLo2ZiD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764077684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yzvCE0HXjjHNitafAJjfZm5OBX9yo3X4qA4rV1S0mjI=;
	b=dfLo2ZiDwf2bgsaRkzIz701gG/ORY+YeAsFTScvBtQ+P/4I6Zdnc8ZQpeNtHE3P8He34Kl
	Hsw4Lmonm1ytl9Er83Q6Rxurl88dF2IKdLSXo9BthH+km8b5VtYiaqfjMjdhRxynVlASOT
	PjuL2f+4Zw4SahW8ZC2fFAapDxGmnoQ=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-zBqNj4vqPvWKSMm-uAaI6Q-1; Tue, 25 Nov 2025 08:34:42 -0500
X-MC-Unique: zBqNj4vqPvWKSMm-uAaI6Q-1
X-Mimecast-MFC-AGG-ID: zBqNj4vqPvWKSMm-uAaI6Q_1764077679
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-37cc3fc4f2cso21091881fa.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Nov 2025 05:34:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764077679; x=1764682479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yzvCE0HXjjHNitafAJjfZm5OBX9yo3X4qA4rV1S0mjI=;
        b=uTgzx4EDUUSj4RPZ2RpVDSUh/Vw1FmVvSmKdfIkO9VrVoLII/cvT53WTDQpm0gsBvR
         ObKIaebnCtunCELhIkqiDQ/nfHbqqjWtX+qU1cIHbvMC+gEGhlQ++cRjf7Su6OAZ1d0r
         M3gCoh2uawZT8QFk80kZbnalWtF6Za5FvcZ/vSu7rVdJGxvE6X7APUdRRybaYXKALZJ8
         M+ALkirIdY0wy75BfDlO2+ijnGN9LMreyyAZhRzPAASjuWvN54wrIV1nSCaFhjp2TGRv
         4NYvGqDlSuYC0YfcBGR3K/as+Fm+RBvKfoGUA8QWx5cydJngTst4/aOqCEGGVL2JwfZy
         aFkg==
X-Forwarded-Encrypted: i=1; AJvYcCVd6e57vHzlmulzKgHidrE7W2BQZ0mM0H8stdxGLgNfDBPuAIhIeyWH/lYtNltO1C7PRsX/UYAb+j40Ci+cAIs7vJI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1R9DLVh9A+Akg3lRam91Ev8p2l0mkSnvEPSDms8mc0vhsKJDQ
	JqYK0QlZPXr88r+sXucAVFIFDt0tlsuic/ijNtj+aEAe9lRey+h0LeMyAIzwwXXTtDn/iIV5hN8
	1AU9CV/fiSN6eKpma2l1TKpSKHl+NmaSnomkKRuuDAcrSHp3WS+SCka3rtA4rnj67SzSK4It0bN
	ux6zglmxMRNoOB+ONIiF1I63GXroZI8TXU/j0/3EQLUD4KJg96
X-Gm-Gg: ASbGncuCvbfHmSnG57mnx34kK8EGj6vLV9KKebwaD2OfMgBzBRMJQpJ9rdAhM4F+12M
	etFRRrLo/Kwb9FmrQgxS6kcrwxzgpBKtG2xDB9IL0sIwZ02O9ZksabGKlUuX2QEWVJL0N4l0BiE
	/78Uu5wiUjJCVnGeGS5zYhxMVeIQxogPPOfATm0exr6CWMSEHPHoSia8Ix0cASEjKcRw==
X-Received: by 2002:a05:6512:12c4:b0:595:7d95:eacd with SMTP id 2adb3069b0e04-596b4e4b76dmr984718e87.8.1764077678663;
        Tue, 25 Nov 2025 05:34:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfGw3W8ScMQe1ku6YWllmhNAIovzKH3FJqo8QXbxYKH/hwDLT0p8hMBiFjD56rgk/v8JStgTQmMj9ANJkgq4M=
X-Received: by 2002:a05:6512:12c4:b0:595:7d95:eacd with SMTP id
 2adb3069b0e04-596b4e4b76dmr984702e87.8.1764077678103; Tue, 25 Nov 2025
 05:34:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117184409.42831-1-wander@redhat.com> <20251117184409.42831-5-wander@redhat.com>
 <9770045bcf400920152f0698c07090a641cc4aa1.camel@redhat.com>
In-Reply-To: <9770045bcf400920152f0698c07090a641cc4aa1.camel@redhat.com>
From: Wander Lairson Costa <wander@redhat.com>
Date: Tue, 25 Nov 2025 10:34:26 -0300
X-Gm-Features: AWmQ_blgXR85mYgUfaQ8idupZ16Ae7dRI2-VhSy-jeUInMobXiAc48bASO5gx-Y
Message-ID: <CAAq0SU=MPghhj9FxB9M0M2Lk0H23ZgyBs6qnucXit7YE+tr0NA@mail.gmail.com>
Subject: Re: [rtla 04/13] rtla: Replace atoi() with a robust strtoi()
To: Crystal Wood <crwood@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, 
	Ivan Pravdin <ipravdin.official@gmail.com>, John Kacur <jkacur@redhat.com>, 
	Costa Shulyupin <costa.shul@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-trace-kernel@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:BPF [MISC]:Keyword:(?:\\b|_)bpf(?:\\b|_)" <bpf@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DxYuf7PTdOlAPLE7IVe2PvQlhl2xFyhgDCTz98_bVSo_1764077679
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 24, 2025 at 9:46=E2=80=AFPM Crystal Wood <crwood@redhat.com> wr=
ote:
>
> On Mon, 2025-11-17 at 15:41 -0300, Wander Lairson Costa wrote:
>
> >
> > diff --git a/tools/tracing/rtla/src/actions.c b/tools/tracing/rtla/src/=
actions.c
> > index efa17290926da..e23d4f1c5a592 100644
> > --- a/tools/tracing/rtla/src/actions.c
> > +++ b/tools/tracing/rtla/src/actions.c
> > @@ -199,12 +199,14 @@ actions_parse(struct actions *self, const char *t=
rigger, const char *tracefn)
> >               /* Takes two arguments, num (signal) and pid */
> >               while (token !=3D NULL) {
> >                       if (strlen(token) > 4 && strncmp(token, "num=3D",=
 4) =3D=3D 0) {
> > -                             signal =3D atoi(token + 4);
> > +                             if(!strtoi(token + 4, &signal))
> > +                                     return -1;
>
> if (
>
> >                       } else if (strlen(token) > 4 && strncmp(token, "p=
id=3D", 4) =3D=3D 0) {
> >                               if (strncmp(token + 4, "parent", 7) =3D=
=3D 0)
> >                                       pid =3D -1;
> >                               else
> > -                                     pid =3D atoi(token + 4);
> > +                                     if (!strtoi(token + 4, &pid))
> > +                                             return -1;
>
> else if (
>
> Please run the patches through checkpatch.pl
>

Good catch, thanks.

> > @@ -959,3 +967,25 @@ int auto_house_keeping(cpu_set_t *monitored_cpus)
> >
> >       return 1;
> >  }
> > +
> > +/*
> > + * strtoi - convert string to integer with error checking
> > + *
> > + * Returns true on success, false if conversion fails or result is out=
 of int range.
> > + */
> > +bool strtoi(const char *s, int *res)
>
> Could use __attribute__((__warn_unused_result__)) like kstrtoint().
>

Sure, I will do it in v2.

> BTW, it's pretty annoying that we need to reinvent the wheel on all this
> stuff just because it's userspace.  From some of the other tools it
> looks like we can at least include basic kernel headers like compiler.h;
> maybe we should have a tools/-wide common util area as well?  Even
> better if some of the code can be shared with the kernel itself.
>
> Not saying that should in any way be a blocker for these patches, just
> something to think about.
>

I thought the same thing some time ago.

>
> -Crystal
>

