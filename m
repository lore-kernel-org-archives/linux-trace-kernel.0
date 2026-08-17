Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20643F5BFD
	for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Aug 2026 11:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786964723; cv=none; b=sJDghD2VcLgIaPyB+XPBcN3dhFFd2r/+iiBVfec9LHgKYzBsMJ4RlzsZRnIblvoql9nf+Jj6BxjaI+Z91Qwq5GzyP8ZbDEtIWPxe56WfYfzfgMu+ppkAD3csvB7pBbLjSSahoVmrdMMAuMBKOTdr3QEJ2A8E/E8jUmn9ZcXXKdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786964723; c=relaxed/simple;
	bh=VSoEXH18n8VSRL1XUU1ajNZQgIIyb5rsL/oEgfpDneI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hNt+S29TTFN7YjXmBit/Z8JL1Bd/0gos7AMiL/diKUWQBYD+wMI2/N/GAxxq23Gb/cqVe/pFyFPE09NJdu03e0Lk3zg81gQC7dDGrckdoBTCZqYiYcXdoP4JtMVDDSNA8FQjEue7QIBSnOWm/FeobhubqOPUpxLHCFhU7QWgkDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xrj/qcjT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xrj/qcjT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786964720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VSoEXH18n8VSRL1XUU1ajNZQgIIyb5rsL/oEgfpDneI=;
	b=Xrj/qcjTwlT1Qq92gDR7oSloEDvfVExEfDGce+VAjOfxt9T8uu6mJVF9pr+tcGTbRmXMMu
	5i1uI2h0DOSruHCvVTTvXx4XAkcpX9HyGaUiYTjHqq58MsSZ8xNpprPkmin965spM91NO0
	vUHrpQbcFVnXD2LBrOXiYOFGNSbmPz0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-pv2Cl0XZM_6i9iomEKPZgg-1; Mon, 17 Aug 2026 07:05:14 -0400
X-MC-Unique: pv2Cl0XZM_6i9iomEKPZgg-1
X-Mimecast-MFC-AGG-ID: pv2Cl0XZM_6i9iomEKPZgg_1786964713
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4955843c6cdso31379525e9.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Aug 2026 04:05:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786964713; x=1787569513;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bFJHtQEQTjEN89h+WkE0r6/DImgMIWSTd0t59oRhvCU=;
        b=HvvN8qklZV7DRKBGtvMMmT5JTSX0Rq02aZ0WPvSNan3Q1E5f+8HDSJBMJnnKMT2tZ+
         wIirkV5mkWK4Xi0wJCPUcL2dtGwDh90niAIgYL1j40cbZYfd+wR4L4jo1ONOaUefB7dn
         YdThnXHNWtnfe6m6y5zpPNlH2KjSSfuGVigKEwnzVhhaSa8bsdpB+44i01de/KrgieZi
         +Y3O2Ggw3GeLKmrZkxSElytjWK4PpyNbcJiOo8TElErBIGyELd0e9FfekwJ/4L16opVM
         2eC6CwbENNbrQnB9Iq2Vf7E00lcJtF23rpHlgQ6Lp6ZbhjkyAj6HGb2L9TeFdShlctqv
         96uw==
X-Gm-Message-State: AOJu0YxswGzdnThwWbvnHXko89tR4sNqjUeIVCAYy/pquGxVCP6mc3a2
	ZLx+JymjRO60Fyf7THs4PJYaiqQnA8jQE7Wy+VMSGfMddShcmuaFJNqh7WPgKXbEriouzjPy1Rz
	mjhHPU6T448TPSg2epmkXKmeyNI18t3OoCYpgjALyoDDx8h6HTHLy4kMGA/OdQ38xlnKPC43mMw
	==
X-Gm-Gg: AR+sD12Z6gVQzIwYwv03jb5vqF5duCQ6FyFRxg1cTo549psXsgB7p2LpVmrtAbq4/jJ
	mhhT6+Nd3u/aBKgL/sxyvmC6nIDVdJKnpWEwbvx0l+pr0eXMKmSNSJAls2wKxQn2aR9Na5VCAgi
	ilRnmtxsb24wcpSjVmrkuSNBoSd0UwhgoxHBgZ7ZkO9ltxyPwHApVSEEyNprw3jx9MTTz0BeAFN
	ugoGcE8C4/00m+8TWhBS2enOW0Ph3XJbQ2a527myhQjuXlpxEFCBdW4tWUFh+VccmdgHbpxTaoS
	PKVrg87C+eY55mn58EGaloDCDiCa/OYyt2LrWKjOcjJQ1K2V/kiKctWsbY39X8acytmHNaL/k/F
	R1mb2DVYrEHQ6yh2g4jJ7l+iv6/6mddBPdB6qJsuJsbu2rpQRrLbei578dTLMM14ps/mzBg==
X-Received: by 2002:a05:600c:3151:b0:499:51f0:a9b2 with SMTP id 5b1f17b1804b1-499880b4335mr339156475e9.1.1786964713052;
        Mon, 17 Aug 2026 04:05:13 -0700 (PDT)
X-Received: by 2002:a05:600c:3151:b0:499:51f0:a9b2 with SMTP id 5b1f17b1804b1-499880b4335mr339155485e9.1.1786964712658;
        Mon, 17 Aug 2026 04:05:12 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5a3b51asm3138914f8f.11.2026.08.17.04.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 04:05:12 -0700 (PDT)
Message-ID: <0e0641cfd06ee56488305ffdb410ab27706f202b.camel@redhat.com>
Subject: Re: [PATCH v3 4/4] rv/reactors: add KUnit tests for reactor
 registration and dispatch
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, wen.yang@linux.dev
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 17 Aug 2026 13:05:10 +0200
In-Reply-To: <87wltpnhne.fsf@yellow.woof>
References: <cover.1786294920.git.wen.yang@linux.dev>
	 <2b91af9f6d045f7fdb8620ef5c66c3b3e189833b.1786294920.git.wen.yang@linux.dev>
	 <87wltpnhne.fsf@yellow.woof>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8kl9r8-P8TqjbnSrHq0At88ARxviwOveOq13WIFyCM0_1786964713
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-08-17 at 12:52 +0200, Nam Cao wrote:
> wen.yang@linux.dev=C2=A0writes:
> > +/*
> > + * Use a fixed-size array so sizeof() gives the exact byte count at
> > + * compile time.
> > + */
>=20
> There is no need for a comment. This is obvious from the code itself.
>=20
> > +static const char long_reactor_name[] =3D "kunit_reactor_name_too_long=
_xxx_";
> > +_Static_assert(sizeof(long_reactor_name) - 1 >=3D MAX_RV_REACTOR_NAME_=
SIZE,
> > +=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "long_reactor_name must be at =
least MAX_RV_REACTOR_NAME_SIZE
> > chars");
> > +
> > +static void test_name_too_long(struct kunit *test)
> > +{
> > +=09static struct rv_reactor long_reactor =3D {
> > +=09=09.name =3D long_reactor_name,
> > +=09};
> > +
> > +=09KUNIT_EXPECT_EQ(test, rv_register_reactor(&long_reactor), -EINVAL);
> > +}
> > +
> > +static struct kunit_case rv_reactor_registration_cases[] =3D {
> > +=09KUNIT_CASE(test_double_register),
> > +=09KUNIT_CASE(test_name_too_long),
> > +=09{}
> > +};
>=20
> I am not sure about the usefulness of these test cases.
> rv_register_reactor() is not an user API that we have to prepare
> for corner case usage. We can expect its users to be sane since the
> users are us.
>=20
> But well, if Gabriele wants to keep them..
>=20

That's right, it can be a bit of an overkill, but I'm thinking one day reac=
tors
could come from (out-of-tree) kernel modules, it wouldn't hurt to have this=
 path
tested, especially if it doesn't require much effort.

> > +
> > +static struct kunit_suite rv_reactor_registration_suite =3D {
> > +=09.name=09=09=3D "rv_reactor_registration",
> > +=09.test_cases=09=3D rv_reactor_registration_cases,
> > +};
> > +
> > +static atomic_t react_call_count;
>=20
> Do we really need atomic_t? Does int work?

Missed that, yes, it should work just fine since KUnit runs in a single thr=
ead.

>=20
> > +
> > +__printf(1, 0) static void mock_react(const char *msg, va_list args)
> > +{
> > +=09atomic_inc(&react_call_count);
> > +=09/*
> > +=09 * Hold the CPU for 5 ms so a timer interrupt is likely to fire
> > +=09 * inside rv_react()'s lockdep context, exercising the LD_WAIT_SPIN
> > +=09 * constraint.=C2=A0 mdelay() is a calibrated busy-wait with no
> > scheduler
> > +=09 * interaction.
> > +=09 */
>=20
> The comment above mdelay()'s definition already explains what it does.
>=20
> > +=09mdelay(5);
> > +}
> > +
> > +static void test_react_no_callback(struct kunit *test)
> > +{
> > +=09struct rv_monitor monitor =3D {
> > +=09=09.name =3D "kunit_null_react",
> > +=09};
> > +
> > +=09atomic_set(&react_call_count, 0);
> > +=09rv_react(&monitor, "no callback");
> > +
> > +=09/*
> > +=09 * The only possible failure in this test case is a kernel panic.
> > +=09 * NULL react guard: callback must NOT have been invoked
> > +=09 */
>=20
> Obvious comment.
>=20
> > +=09KUNIT_EXPECT_EQ(test, atomic_read(&react_call_count), 0);
> > +}
> > +
> > +static void test_react_callback_invoked(struct kunit *test)
> > +{
> > +=09struct rv_monitor monitor =3D {
> > +=09=09.name=09=3D "kunit_dispatch_monitor",
> > +=09=09.react=09=3D mock_react,
> > +=09};
> > +
> > +=09atomic_set(&react_call_count, 0);
> > +=09rv_react(&monitor, "callback invocation test");
> > +=09KUNIT_EXPECT_EQ(test, atomic_read(&react_call_count), 1);
> > +}
>=20
> So the test calls rv_react(), and validates that the reactor is called?
> Honestly I am not sure how useful that is. Especially since Gabriele
> already made the selftest which validates that the reactor is invoked.

From what I understood, the value in this test suite isn't really about the
assertions (especially in test_react_no_callback). It triggers cases that s=
hould
not produce a splat (panic/lockdep) and a pass should consider that too.
This makes them not quite pure KUnit, but again, I think it doesn't hurt to=
 have
this kind of test since KUnit output is in dmesg anyway, so a splat would h=
ardly
slip.

What do you think?

Gabriele

