Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17A1BA3D
	for <linux-trace-kernel@vger.kernel.org>; Mon,  1 Sep 2025 12:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756731033; cv=none; b=Qh0BXLkU1DLXDkKZn9x7pGhq7oXsKIDrclLMzrHSPzWKy1cOpKfqSD+kzG2acIZxqxMTn9S77azCNVG/7OTbaJeog2rRDX+vA93jDvo0O/XF8+5RhLwSJN0E3qthFYcW1ZvSXpr4MlXtwYHe7ry3eSGjC5/GKxxu5MqAInA5cXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756731033; c=relaxed/simple;
	bh=yGkCtZznkuuHPplLNexpSPnof6JgBqRMYMWtmwsRqO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EKlnsGXAfdude7IxC3Ca9A2pi8gER/eZxOt2Vwra9xGhXDK2qc6W7AVT4TwGIGUrONuF/jn41lgckKpFOHdS32Lh3U7VufC9fSEWjiymTQ7EA4SWQmGYWl0U9Ckcpm40vOBXtyvOatwzepo5lh6yi5r7fzQAQU5VLapMA20nV24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NJxM4MjJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NJxM4MjJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756731030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bpCjJ19dY746KgWeJBh4L+0i41Wjb5J692hMFKmo+LE=;
	b=NJxM4MjJOu1J2VrdEpf47vGZ6T1ivlm0/kD7k66o1ZaEvYrzgdurV9HLX+Y0UpX3mMozAJ
	MjsV8U83l6tJOV2q+luTN7uMSmIxt4sv3ROevNYMbxr/D+oyngmhnDKbzne8e8EF/VaACY
	0151t9NSwF8iNgQLdl6VXpc5S6e9Y8U=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-i0AWeXRiOfS9WefTy_e6hQ-1; Mon, 01 Sep 2025 08:50:29 -0400
X-MC-Unique: i0AWeXRiOfS9WefTy_e6hQ-1
X-Mimecast-MFC-AGG-ID: i0AWeXRiOfS9WefTy_e6hQ_1756731028
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b04206e3d7eso119720866b.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 01 Sep 2025 05:50:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756731028; x=1757335828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bpCjJ19dY746KgWeJBh4L+0i41Wjb5J692hMFKmo+LE=;
        b=EKobRtIyVc2Yvcf/EM4QIYaZ/Mi0D/IUZACI5P41l0bA3olX0Zm0Urv0HabiJg62gf
         J1TAm74J2VMOg8bi4QjQser+ynxa5cUjPcI3fTJZO6MDirPlEjvV3idG/AtEnCf51Ykh
         EZ2ds+Iw2M0aU/5WoQNsT9rqq3E+HfDeYbtv5r8Fxmq2Ff9jqAJOAVhrpXJLh7vR/LJU
         CnVSlAFpDemev2Y9QMk2GLtJ/RbP8V57/V9khjWmcn8mH7oGLvDBcxRWiF52G1JhH6aE
         6iHsLpeZu1bZRu/ycnj/kmDguO0OPbaz67gv1Ek3lzxrp6IXnEcsI0l2kes/bGL2wJiS
         WIEA==
X-Forwarded-Encrypted: i=1; AJvYcCU4+i2vVloIKFXJwYaaEQAoJ5Pe1A51rTNrvMdlJXppbn0jZ7Cm6QtvaTNt0r/qF6kYXjREJHBJWPt8POy+dT+lmh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxodqfvwndEV0X9ABgIO+b3pLqfgdrgvGNW0e2y8EdqnniZhFmx
	Y07hBiO14wBA8KjY5Ojv1cc8ajJ4Q4RLp0NbNBYRKBVZj4ii3HAgHxlpz1ihjD9ZUars19yGMl9
	fW4TyTSYxVKJmc36LiXP9p4rqRyZWmjdQ79gGB+oP8CMVSwK8Mruem8jsW7ARkTzKxm2277jfne
	rQjJjN+9Du09wPFEOvebafnPo0CWHavagbjFoxHb6jcGf//Jjb
X-Gm-Gg: ASbGncuY9kjTKlw+IkkYytVYA8wb4+5pvfm6Ee1L995A0/sIpuzKBHDnUapJv/olCP7
	AWhfs2x5TEwFstJi1p3Rl7JgOpeLoNVsbC5a3AoaK5Y+JDXxEkofiU6TCgFyyL+SMKuN4FhRBWo
	8GM0fInifhVq81LV0vJLGThf4Q5LyDk2a5g1JVuKnp+bhhEjVDGTQ=
X-Received: by 2002:a17:907:1c1b:b0:b04:3c00:55ac with SMTP id a640c23a62f3a-b043c0059dbmr182495766b.16.1756731028186;
        Mon, 01 Sep 2025 05:50:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3EnT9uTmPLlZFR7YbWHEbQQ+XmSJ/Hp/7Lsmli+LXdVXOSLPWsTThTOLUiMBy09VcJqIsfH6NaYZINLg6hRs=
X-Received: by 2002:a17:907:1c1b:b0:b04:3c00:55ac with SMTP id
 a640c23a62f3a-b043c0059dbmr182491766b.16.1756731027701; Mon, 01 Sep 2025
 05:50:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821035719.137161-1-crwood@redhat.com> <20250821035719.137161-7-crwood@redhat.com>
 <CAP4=nvQthvoE9tGPqbXmk3dP_XJjmgkh_wXDd9JiVTTGvM3nKQ@mail.gmail.com> <d11da952ca2ef28e3427fd09972cc02e727606f3.camel@redhat.com>
In-Reply-To: <d11da952ca2ef28e3427fd09972cc02e727606f3.camel@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Mon, 1 Sep 2025 14:50:16 +0200
X-Gm-Features: Ac12FXySt4Ea4ID-qu_JoT7VxrjHRBPrXdHOzLTlsOwK0IgBgFMPYFBp2eZvv04
Message-ID: <CAP4=nvTJNJhueJi1vCR4hh2q9Z1mib3GCGv7eCHbAKfEJL=A9Q@mail.gmail.com>
Subject: Re: [PATCH 6/7] tools/rtla: Add test engine support for unexpected output
To: Crystal Wood <crwood@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org, 
	John Kacur <jkacur@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RXvMBn6QrdOHB7mvh88UHB-ofn9Wsg2VkCYtB0zE6Hw_1756731028
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

p=C3=A1 29. 8. 2025 v 23:35 odes=C3=ADlatel Crystal Wood <crwood@redhat.com=
> napsal:
>
> I'm not seeing the "tests/hwnoise.t ... 2/6" part.  What is printing
> that?
>

Test::Harness (which is one implementation of what is called a "TAP
harness") is printing that (the "prove" command which runs the tests),
it runs the tests, consumes the output and formats it.

> > Furthermore, it's standard to first print "not ok" and then the
> > comments, see the documentation to Test::More [1], so I think we
> > should keep that.
> >
> > [1] https://metacpan.org/pod/Test::More#ok
>
> https://xkcd.com/927/ :-P
>
> I'm not a Perler, so I didn't recognize it as anything standardized.
> Still seems backwards to me, both in terms of making it easier to see
> which test failed, and in terms of being a pain to implement.  And we
> don't even get the benefit of seeing the test name printed before it
> runs, to make it easier to see what's taking a long time.
>

We can certainly modify the test system so that it works better for
us. The TAP standard that is used by the harness to process the output
of the RTLA test engine [1] does not specify where the additional
output should go, it's just a convention. I just say this might be
confusing to people who are used to the "not ok, then error" format,
which is associated with this type of test.

I'll have a look whether there is a way to easily print the test names
besides the number.

[1] https://testanything.org/tap-specification.html

> Seems like Linux uses a variant of this, though:
> Documentation/dev-tools/ktap.rst
>

Yes, this is used by kselftests [2], which are written in C.

[2] https://docs.kernel.org/dev-tools/kselftest.html

> I'll fix it, hopefully by sticking the error output into a variable or
> something rather than duplicating logic.  Or should we be using some
> existing test infrastructure?
>

I wanted to use existing infrastructure, but could not find anything
suitable. I originally wanted to adopt the runtime test engine from
bpftrace, which is also an end-to-end test suite for a userspace
program closely related to the kernel. But bpftrace is licensed under
Apache 2, so it cannot be in the GPLv2 kernel source easily. I'm not
against suggestions, the test suite can always be migrated, that's not
the hard part.

Tomas

