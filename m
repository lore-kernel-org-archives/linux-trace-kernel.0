Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8582366544
	for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Jan 2026 06:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768977090; cv=none; b=G/n5VGX5gv1vJeE9Mj5SDh3zJEh4IJkqnKEAKb/bLD9TyATFaJUNm62dmvXjBvd4RT0E0/iHvsAT0Bra0Dcf6f4DftOaRvSewqxsAuYSQ/35ZLu+YqWzWBkDNQzrLegeeQ2EdQG3kKmvxms6AxevitCquxtzydbWiwh8OKffJ8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768977090; c=relaxed/simple;
	bh=yB34ssNgYqrvs1pO6Tx9dAlHasb9eryPavDvedeGhgM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WHXyz0pM5eFRvRrVi7ox4rEgclMvR2WlqWIR/41dWR+VcYaJg8NAPOlGCN1l3YHLGpPEpFiLnVZeujGdysdTaJSwB/XlkwIJmo3/brKo1ZTkwe+BH47/npKVZB25jYBCnpo4ulMuMiPExPrzyuQCaEAyJwD6YXG0Wdjkl2JYyDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E53jKCPW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E53jKCPW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768977087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yB34ssNgYqrvs1pO6Tx9dAlHasb9eryPavDvedeGhgM=;
	b=E53jKCPWe1O7WK/Ws57/AyFCalKdh29hgQtQn+iAtxhehZdF8ZzGY1PolGznSrp0iPQt83
	dgIyyWGnkpUCeRkGQDzK7Kq9iFt82wGy6XSEKjPnBDmy7PTvxvkIZha2IAqSskT6FvY34r
	1RMlwPzOmtiDexPloF8oR52w/86YMMw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-9tsfZHXxPS2uVBRN8TfxNw-1; Wed, 21 Jan 2026 01:31:26 -0500
X-MC-Unique: 9tsfZHXxPS2uVBRN8TfxNw-1
X-Mimecast-MFC-AGG-ID: 9tsfZHXxPS2uVBRN8TfxNw_1768977085
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-430ffc4dc83so5389925f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Jan 2026 22:31:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768977085; x=1769581885;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yB34ssNgYqrvs1pO6Tx9dAlHasb9eryPavDvedeGhgM=;
        b=i852H1bLwC1sWYhUiIli9h8KP9MTQ2/yaA2Qpl/zqqUMPg8+vqqKlpJYSmJH/zaPQ+
         2SwjLg4YU6IqKx8b3W37uknnBjVr7qGkWLWBITbVf7I67P7IYo25B6Hh5WXKyKj58HF1
         fDJ53u2C9IgD2YmuuBXfHtjAwXI1KZq+I6sWz6yjWcOUZkzkY454pGNrSmkS8cjY1w3s
         WclMVF9HJJSDg1svDuzBH0jSR0KBHhbYbvlq9fDVF5z/iN+4mhFo4LxLb/yyW3YO86Lh
         tcWfJO9rqwoabhgtElA5nTjGbZQQGcE5FBjOdkq9WZMe2B2f19PDsY8zeF5ZVS2lkhML
         OU2g==
X-Forwarded-Encrypted: i=1; AJvYcCX6qPtXMHsuhD6ULesHENmqHGsVxfcOLk0jkGCjXl9BViYb0nrrnE5RuXgwbPd3+FH6/PO3JpCG8Tg3eqloBXZ0tfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvbsRlxuw4G/s+KW4ybDenaVN1uDdsY42kksZ+36GucTzQZyvC
	gEeHisM6t0betFgEMAiRoiY+ahpNVZEs5leN7n7Jb/UJm2GyL3q5+NJ9PqXKLHlySDwRGOufTOk
	82IK/hJr10OUMv7XUqjxZopMQeDxqPaBX61/e6HMhvpSrTHGwG4H130mPwkSsMsv6GG4bvPZsEg
	==
X-Gm-Gg: AZuq6aLDf0Asl2GKf/tdF72ZDn0YJcG1Jm71HBHbkfhUJS+khpNqFQ+F9LXxa0pbWKW
	deYs8Yk5LhWbtaxhcFwoFxziwNJwaKXQNY15pls7zpApDI34i5Qq7D9UOBEpI0Ml1sqwecn/628
	g2w9sHGP+42cZChRwp8ElAdqs8WEqFVyScQRHqiRrdiCPIftibL0PDVW6VJwI8FWqfsu0SSL8rA
	0hS+D5tc9FD35Zyjx77rYZJ4RmBv9EYqKvCzNSMhM7tSkbYEM+ahE6rtOXUIRxZywusFOfzr92Z
	kc+yA+6m140ei6wvti9ss2GgWJmOWXyhQ56sp0KwAvS0XFmrZ7HtB+NK26wRjXqmvEFi2Bv3vda
	o3rtxW5Fz9CUURyOIcMZR8ZvV2dUdZivXv9+npRIZMSGvlGKDq9tiWGja+hDz0lrDdBosPLRwzS
	BHOEJE/6Ye
X-Received: by 2002:a05:6000:4310:b0:435:91b8:e023 with SMTP id ffacd0b85a97d-43591b8e2eamr6201305f8f.7.1768977084739;
        Tue, 20 Jan 2026 22:31:24 -0800 (PST)
X-Received: by 2002:a05:6000:4310:b0:435:91b8:e023 with SMTP id ffacd0b85a97d-43591b8e2eamr6201273f8f.7.1768977084346;
        Tue, 20 Jan 2026 22:31:24 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (185-132-178-103.hosted-by-worldstream.net. [185.132.178.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43569921f6esm33540846f8f.4.2026.01.20.22.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 22:31:24 -0800 (PST)
Message-ID: <7e83ab8b607cdc9e1c677e7b118d46eabe35b7f8.camel@redhat.com>
Subject: Re: [PATCH 17/26] rv/rvgen: fix possibly unbound variable in ltl2k
From: Gabriele Monaco <gmonaco@redhat.com>
To: Wander Lairson Costa <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>, 
 open list <linux-kernel@vger.kernel.org>, "open list:RUNTIME VERIFICATION
 (RV)"	 <linux-trace-kernel@vger.kernel.org>
Date: Wed, 21 Jan 2026 07:31:22 +0100
In-Reply-To: <aW_Q6ixdtMqnzfhU@fedora>
References: <20260119205601.105821-1-wander@redhat.com>
	 <20260119205601.105821-18-wander@redhat.com>
	 <b8a2b88e484cac27a82e1c27d0e27599515c4bc6.camel@redhat.com>
	 <aW9oj7-iagg2-VF_@fedora>
	 <3507c2f454ca66aa27dd3a24e33f5941fac96639.camel@redhat.com>
	 <aW_Q6ixdtMqnzfhU@fedora>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iecRTn_VTTNUrfgYCB6nBvMwyEvxmvlt_qibzPLOUQw_1768977085
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-01-20 at 16:38 -0300, Wander Lairson Costa wrote:
> On Tue, Jan 20, 2026 at 01:30:35PM +0100, Gabriele Monaco wrote:
>=20
> > You basically want i to be the length of the longest prefix common to a=
t
> > least
> > another atom.
> >=20
> > You could assign i to some python trick doing the exact same thing the =
loop
> > does, like:
> >=20
> > =C2=A0=C2=A0=C2=A0 i =3D next((i for i in range(len(atom), -1, -1)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if sum(a.startswith(atom[:i]=
) for a in atoms) > 1))
> >=20
> > next() is basically doing the break at the first occurrence from the
> > generator,
> > just now your i doesn't live (only) inside the loop.
> >=20
> > So now you save 2 lines and get any C developer scratch their head when=
 they
> > look at the code, but hey, pyright is happy!
> >=20
>=20
> Or just leave the assignment.
>=20
> > If you do find the trick with next() readable or have any better idea, =
feel
> > free
> > to try though.
> >=20
>=20
> Definitely the next() trick is not worth to make pyright happy.

Alright, thinking on this again next() is the python way to do if(...) brea=
k ,
it looked a bit odd to me only because I didn't know about it, but if you'r=
e
using python iterators, it kinda makes sense.

Anyway I'm fine also with the dull assignment, there's no need to argue on =
this.

Thanks,
Gabriele

>=20
> > Thanks,
> > Gabriele
> >=20
> > > I will modify it in v2.
> > >=20
> > > >=20
> > > > Thanks,
> > > > Gabriele
> > > >=20
> > > > [1] - https://github.com/microsoft/pyright/issues/844
> > > >=20
> > > > >=20
> > > > > Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> > > > > ---
> > > > > =C2=A0tools/verification/rvgen/rvgen/ltl2k.py | 1 +
> > > > > =C2=A01 file changed, 1 insertion(+)
> > > > >=20
> > > > > diff --git a/tools/verification/rvgen/rvgen/ltl2k.py
> > > > > b/tools/verification/rvgen/rvgen/ltl2k.py
> > > > > index fa9ea6d597095..94dc64af1716d 100644
> > > > > --- a/tools/verification/rvgen/rvgen/ltl2k.py
> > > > > +++ b/tools/verification/rvgen/rvgen/ltl2k.py
> > > > > @@ -45,6 +45,7 @@ def abbreviate_atoms(atoms: list[str]) -> list[=
str]:
> > > > > =C2=A0
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0 abbrs =3D []
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0 for atom in atoms:
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i =3D 0
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for i in range(l=
en(atom), -1, -1):
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 if sum(a.startswith(atom[:i]) for a in atoms) > 1:
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break
> > > >=20
> >=20

