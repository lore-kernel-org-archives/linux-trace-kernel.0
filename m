Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549CB392817
	for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Jan 2026 12:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768912243; cv=none; b=FDeETDtCOHBgIQiho7awqK6AO0q/dMfFptb8Dz0Bzel1G3FfEumzQQhmxmee0bV3nYoklCfjbOyeD3rLZpsKDkpCV1h8KRjItVA1dbUK0ISWupHac3PhG1lyB4jCiY/OuI5dn7rJpaFmowjuC6NP3tmA6rYDWiWl7p4pdtNDtJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768912243; c=relaxed/simple;
	bh=+FBQZ6Q28Yg47DBEKLCBMlTE4PqHHpVpLAubkFN2ITM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t1f8jBZKF4W8Ia6boSzvCyRunz567C/BYKqCr0e60MhsndBEBAgjW2AulGVKXvfYiiax2IfQdBiRIuXCExO3MLyf/mEGgRNkBNJbDSpVxNKsP+uQtS5H767Xu8SbvjrF0/dxXS672d4g9qHL9i1ULuucbSx9M7YhtQ0ZB2Ic9v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BFaqSdU3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BFaqSdU3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768912240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rpCNh1dlGOvCmCYkmDU1iHRuLmyVXGuGZm17griz6eM=;
	b=BFaqSdU3/dQ2cwRJLLpdhxXshH7YxzherW8xxqTdba8B03KzEsH7LGV+pXCyTIFx9spHoS
	+ZO8T7G91WFXo4S6eM8kKC/5gbu7MEjwjIzsVOsRgFJw8vkVYY7X03TGVSWU2IIpJOfqMP
	a42YxKgK2wCMn2KcAP+dUJF/UOT/Zxw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-swM6T0zVPpeoo1A1n8Zflg-1; Tue, 20 Jan 2026 07:30:38 -0500
X-MC-Unique: swM6T0zVPpeoo1A1n8Zflg-1
X-Mimecast-MFC-AGG-ID: swM6T0zVPpeoo1A1n8Zflg_1768912238
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47fff4fd76dso36435085e9.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Jan 2026 04:30:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768912238; x=1769517038;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rpCNh1dlGOvCmCYkmDU1iHRuLmyVXGuGZm17griz6eM=;
        b=TD6CFrWyhBeeB9VgP9GGwl0GPSAnRw6iICPDhk9fz6J4MnfNxIm4Iy6DojjeOC6h1d
         UBvEa7U/RhAkXtLc52GihdAzsAdWvKsZX3FBG3h2lcUMx7cDVo3fASnCj5qBhZJfBdSY
         djKdQaHEAKwWdg7PD2NE9TXn2uPlk6+Tx909ao56GVNAfOqFtbWmnYExUfL1Uq07hbv2
         KEBLT/tg6U/GBhhKG6SzFPEkf970nD1HMPjuQSwSao1ejGjzrDFCcoM4ia2uVfZHk79D
         mhdIH8OQnCM0FpZKuoLgLkGjMD+c0uU5V3Oyaxp9+AyXOYcSQCqedC7+6CeRD/epP/yb
         CGNA==
X-Forwarded-Encrypted: i=1; AJvYcCXb1SZtuWSTVuLa87PMyUhvU245VFdk1vxmBnjXXGWXnOMQnriCHg2hqqM3SUioxryghqaNsSMJ3pdRB+H2cVSUHKc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+3rjR0ZPXXCHewywkf5mgx0Se9IxGN8KgTKtzyzL0x4ZioSI4
	qjrcGrbtRu+H6X6spg1+Y3nAbHfk1fwowfk//MKOIc1Zo8qHS/szN2zoCLhWWtlG+cNrbpNNk7x
	FmVMT7VCQGsQOEigJ/4CH7u05l5GtrRTlz5+yqP69b5Vmn+TMZVlkZY0bdyK17elujLSPOJzgWQ
	==
X-Gm-Gg: AY/fxX45YZt1mrnIAnOJT50Za+AjaLtv20rD0XGtsVKtwQ0SnHd7LtaHSAq+ExCumc+
	90sZ9BgCEp3TEWEqakYF5q1jVOf75MNrGZivuqdMJ6X6g2/YVB+1XG5THF7H5tPjdV9eVCotDm3
	vo0o/AViIQfV3Yqe7l94ZPDGjppvnEIHSpxUTbaJ28qt0pps8c0N+y5NzbbIhoqM+1DPahLLi6J
	jJakGZ0VyqOmDa6t1MtINi1qbt0u4Cy0/Qav/bfB5r2jMWpm++IHWm5dPEIQMp1zWaPwz4zz9Xm
	Iadj+llGEwZchk/0nEs4pMi2pZtUN2xvrEsIiFrjbgGHAWo8XDQXAza1WECUVI2CkdrbP841N+U
	gBWQRhu7CVugCXPskH/ldKCauM/Xk0ySAOE/k0u5Z30cRhICpvc2fT8YejPdEfzGvgq5Hw4Y/oO
	ike1gxJ4Jq
X-Received: by 2002:a05:600c:8a0c:20b0:480:1e9e:f9c with SMTP id 5b1f17b1804b1-4801e9e10aemr145886815e9.10.1768912237659;
        Tue, 20 Jan 2026 04:30:37 -0800 (PST)
X-Received: by 2002:a05:600c:8a0c:20b0:480:1e9e:f9c with SMTP id 5b1f17b1804b1-4801e9e10aemr145886485e9.10.1768912237227;
        Tue, 20 Jan 2026 04:30:37 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (185-132-178-103.hosted-by-worldstream.net. [185.132.178.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801fe2c2a2sm101581445e9.10.2026.01.20.04.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 04:30:36 -0800 (PST)
Message-ID: <3507c2f454ca66aa27dd3a24e33f5941fac96639.camel@redhat.com>
Subject: Re: [PATCH 17/26] rv/rvgen: fix possibly unbound variable in ltl2k
From: Gabriele Monaco <gmonaco@redhat.com>
To: Wander Lairson Costa <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>, 
 open list <linux-kernel@vger.kernel.org>, "open list:RUNTIME VERIFICATION
 (RV)"	 <linux-trace-kernel@vger.kernel.org>
Date: Tue, 20 Jan 2026 13:30:35 +0100
In-Reply-To: <aW9oj7-iagg2-VF_@fedora>
References: <20260119205601.105821-1-wander@redhat.com>
	 <20260119205601.105821-18-wander@redhat.com>
	 <b8a2b88e484cac27a82e1c27d0e27599515c4bc6.camel@redhat.com>
	 <aW9oj7-iagg2-VF_@fedora>
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
X-Mimecast-MFC-PROC-ID: uKQvt4kM6lKAS7SwogOEUsnY3PmU0kQr-HvOqMuRnXI_1768912238
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-01-20 at 08:37 -0300, Wander Lairson Costa wrote:
> On Tue, Jan 20, 2026 at 09:59:11AM +0100, Gabriele Monaco wrote:
> > On Mon, 2026-01-19 at 17:45 -0300, Wander Lairson Costa wrote:
> > > Initialize loop variable `i` before the for loop in abbreviate_atoms
> > > function to fix pyright static type checker error. The previous code
> > > left `i` potentially unbound in edge cases where the range could be
> > > empty, though this would not occur in practice since the loop always
> > > executes at least once with the given range parameters.
> > >=20
> > > The initialization to zero ensures that `i` has a defined value befor=
e
> > > entering the loop scope, satisfying static analysis requirements
> > > while preserving the existing logic. The for loop immediately assigns
> > > i to the first value from the range, so the initialization value is
> > > never actually used in normal execution paths.
> > >=20
> > > This change resolves the pyright reportPossiblyUnbound error without
> > > altering the function's behavior or performance characteristics.
> >=20
> > So are we just pleasing the tool or is there a real implication of this=
?
> >=20
> > Apparently code like
> >=20
> > for i in range(len([]), -1, -1):
> > =C2=A0=C2=A0=C2=A0 pass
> > print(i)
> >=20
> > works just fine since range() returns at least 0 (as you mentioned in t=
he
> > commit
> > message) and i is not used before assignation in the loop, so I don't r=
eally
> > see
> > a problem.
> >=20
> > Apparently pyright devs don't want ([1]) to implement a logic to sort o=
ut
> > the
> > /possibly/ unbound error here.
> >=20
> > From what I understand, this code is already not pythonic, so rather th=
an
> > silence the warning to please this tool I'd just refactor the code not =
to
> > use i
> > after the loop (or leave it as it is, since it works fine).
> >=20
> > What do you think?
>=20
> You're right, I could have done:
>=20
> for atom in reversed(atoms): ...
>=20

I'm missing what you mean with this, the range is iterating over the string
representation of atom (in reverse) not the array of atoms.

You basically want i to be the length of the longest prefix common to at le=
ast
another atom.

You could assign i to some python trick doing the exact same thing the loop
does, like:

    i =3D next((i for i in range(len(atom), -1, -1)
        if sum(a.startswith(atom[:i]) for a in atoms) > 1))

next() is basically doing the break at the first occurrence from the genera=
tor,
just now your i doesn't live (only) inside the loop.

So now you save 2 lines and get any C developer scratch their head when the=
y
look at the code, but hey, pyright is happy!

If you do find the trick with next() readable or have any better idea, feel=
 free
to try though.

Thanks,
Gabriele

> I will modify it in v2.
>=20
> >=20
> > Thanks,
> > Gabriele
> >=20
> > [1] - https://github.com/microsoft/pyright/issues/844
> >=20
> > >=20
> > > Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> > > ---
> > > =C2=A0tools/verification/rvgen/rvgen/ltl2k.py | 1 +
> > > =C2=A01 file changed, 1 insertion(+)
> > >=20
> > > diff --git a/tools/verification/rvgen/rvgen/ltl2k.py
> > > b/tools/verification/rvgen/rvgen/ltl2k.py
> > > index fa9ea6d597095..94dc64af1716d 100644
> > > --- a/tools/verification/rvgen/rvgen/ltl2k.py
> > > +++ b/tools/verification/rvgen/rvgen/ltl2k.py
> > > @@ -45,6 +45,7 @@ def abbreviate_atoms(atoms: list[str]) -> list[str]=
:
> > > =C2=A0
> > > =C2=A0=C2=A0=C2=A0=C2=A0 abbrs =3D []
> > > =C2=A0=C2=A0=C2=A0=C2=A0 for atom in atoms:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i =3D 0
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for i in range(len(a=
tom), -1, -1):
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if sum(a.startswith(atom[:i]) for a in atoms) > 1:
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 break
> >=20

