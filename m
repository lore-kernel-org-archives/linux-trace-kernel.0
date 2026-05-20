Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65063DF00B
	for <linux-trace-kernel@vger.kernel.org>; Wed, 20 May 2026 12:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779278606; cv=none; b=nF2EIN1FacIzF8P/jA/3gqbFoc/Fu+Ca9eDOngWBd61a+/EOUdMl/Eaq09CdSXm3/zDfWHeQg06fQmFMRSPinxSO5a08cMh7/MSFlX3DOimCf3PSjHKLUddj9Hud+AeAlP0/FxqEop620bsoRUAEWGqNwlAnrR77Vqwlgtwm8Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779278606; c=relaxed/simple;
	bh=CtnAB2ZbclNUYrpWW7beXYEowxt1rzkSH4c465Z18Qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pkiNLKmixNx2roU9/h3zSo40klOhT+xaCtG0QW0AwpbbOblpz5OmH29t0eN8b+tcPHjInocwFNaBCKeD1Aax1sUvfWWpghh+uKM57M4FMPPv40vLmgjfk9VxTIvoMKVH9QKAscTe6g+fo/BWvWb5Fb4eeOzG6I2CMMkIFxoF92Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i5qiWtqp; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5qiWtqp"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-44ccbd3290aso4479555f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 20 May 2026 05:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779278602; x=1779883402; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CtnAB2ZbclNUYrpWW7beXYEowxt1rzkSH4c465Z18Qc=;
        b=i5qiWtqpWVIqvgyi56dBjpao3pSyOKqILxqU4RH8qgRUShA5P0ZwUuV0mWv5sbojiu
         iaeLU5I1f/4k9wG0h/SApvllXzY6HjcIuutlVjbY/HIzaBKwgSVcRiDCKxYLZv+9SesX
         wP2ob9zinx1AYD9oKXbTMLK6tb9jCOeR4pe9oUpvB8FhzRDuYNSMVqf3uDnAVpAHR78a
         dTk1lVAsIXh22sJs4q/7d4Z3tZoMPcVka5WxFQup1rGyV4TmkNL7Bxgd22oAzY0WoU/H
         pJqN58/LPE+wvRe6n6+oQFl63Vs4ULwPv7Cqnadm8WIBRaJMmOvOu4XvFzXdQFJnfKb5
         WCEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779278602; x=1779883402;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CtnAB2ZbclNUYrpWW7beXYEowxt1rzkSH4c465Z18Qc=;
        b=NbArgex9XT+QMuH2wTc84EGLhzkzADHWR/a83YxFJlLRxcA2hIDX62pAi7e7sts7TU
         f+FAuywnI5QCS7pTa+Y8WxjlaBR5fEljRV9xw5j3mkRM4jPetsO22uJXDMZLkPZoVcvz
         VjKdO9IZH4Pf0e3+nnwgbdS0PwIiSLIaOAg7ZPdYcn6/b+HlWpFfLPYMKLnELRe/z7Wa
         FueI5eFvQTTtQ1XAMerxcay66wJX6nZLQCjoKRzMgy5wksB6WrOH3OKH1e81v9xBXKMz
         mos5sAnoszft/c7CKTA/oYvI0Q7Pyd0fv/Oa0FncN5TV3gwsSeNMRnOTyWd+Gs1BrpU7
         cHXw==
X-Forwarded-Encrypted: i=1; AFNElJ86/UUtXAmUfbBkdjDhDPc+oKKrWy2y81tbMqOivSstJyxL/rAZLRn2d8bhc8YoUz31URSoIytqpPou0ey7uMdfbZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYvHaogc/Q4rOjQ/sVozAUdh73kIhdobLrx6SxboU1EXSuiwwc
	Z5WSymzPEeMaBZhVQew9CnvJ4r8nmAYKUhaVnOt5buZl3vbMo4aekw/k
X-Gm-Gg: Acq92OGDp3EJrRDeCEVT3rJxjqwMtreGjutOR1tr7b/qpL7rgWW+9fZpHQHY9P2EPrp
	s1qItjZ6+E36NYZZm5TTlEU/nuIPjgRM0qGLDla9FE3ZNVHo3Bpg+jenpN415LhFuddFeipem6i
	DJLvnEjWaq3nfEBN+vG6b6/dgv2KNkt/PyS1g9HlO6FzfhW1S3qQV9dGVtamBRLkr1o0UDVmHvJ
	fIr1QHW2Sstg7sWDu6I8i4SLi4omXoYRtYmpXpgCfjuXRXDvU+AQI5eHMwQFXXY6Ap5H/q3iTm4
	cqWYdrVaPDY7F655o3gpRmGhfOc8KODalNThREyy+7PrXYR5G7AX6mQUDvhNUQhxlqgcOsKs/Z/
	f/MV5HU7QDr+mD8ct1p39sPkkiIjrRLy8qfaa8An18XFxMyPnHKAT9nb+7J0TLA/ITYEcCMMRre
	S+OUQJO5eZSCIaS9zPn5bq/d6OhbhDHN/CLJ8/1RzSMk//UIUIopqtFN899SpFD8u+Ghffz7QAi
	fdT5+hCWUsaog==
X-Received: by 2002:a05:600c:491e:b0:48e:978f:c45a with SMTP id 5b1f17b1804b1-48fed455991mr226125105e9.19.1779278602148;
        Wed, 20 May 2026 05:03:22 -0700 (PDT)
Received: from orome (p200300e41f291e00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f29:1e00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe6b60csm193175225e9.6.2026.05.20.05.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 05:03:20 -0700 (PDT)
Date: Wed, 20 May 2026 14:03:17 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Artur Kowalski <arturkow2000@gmail.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, 
	Thierry Reding <thierry.reding@kernel.org>, Mikko Perttunen <mperttunen@nvidia.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH] gpu: host1x: trace: fix string fields in host1x traces
Message-ID: <ag2iF9bZJcBQ93lh@orome>
References: <20260519-host1x-tracing-v1-1-55afb8cbd186@gmail.com>
 <20260519141059.77435501@fedora>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d6arr666wdzokuxu"
Content-Disposition: inline
In-Reply-To: <20260519141059.77435501@fedora>


--d6arr666wdzokuxu
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] gpu: host1x: trace: fix string fields in host1x traces
MIME-Version: 1.0

On Tue, May 19, 2026 at 02:10:59PM -0400, Steven Rostedt wrote:
> On Tue, 19 May 2026 12:16:43 +0200
> Artur Kowalski <arturkow2000@gmail.com> wrote:
>=20
> > Use __assign_str and __get_str as required by tracing subsystem. Fixes
> > string fields being rejected by the verifier and unreadable from
> > userspace.
>=20
> Does anyone use these tracepoints? The fact that they have been broken
> for 5 years and nobody noticed makes me think they are useless.
>=20
> I rather remove them than fix them, but if someone thinks that these
> are still useful then by all means apply this patch.
>=20
> Acked-by: Steven Rostedt <rostedt@goodmis.org>

I know that Mikko used them a lot early on, but this driver is pretty
mature now, so we rarely need this low level of tracing. I'll defer to
Mikko on whether we still need these.

Thierry

--d6arr666wdzokuxu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmoNowIACgkQ3SOs138+
s6EmzxAAtBKSWrGlDxj+qSzQteKD0zS9CKlL5opFtbzDlSDXgJvEjK6vr6dhIXsy
lo65nAdDGzecxHLrchhx90CM1Xnex4QBCQW3XvoXnqi0/O/MqkEvyjYYLV3gleUN
/Nzd+0P5gQHmizLjew6pb2krhLLHyKxSWgiidTcaSfv9q3rmAxn/8aAM0mfzS1vv
jMLhFnhLqwJttHjJxAkBGwG3EEr9Un4WHBqgXSaNCkW3Daky3xtNCE6AX3tpDp+6
kMz+GKl4dvJ68H/wyLe+5KcxaRQBhxQq1Xn4XBxsRqmlONQgCZPNzUrBXq4Dr8tm
oHfmQnlecryMR2SSrC16HVLbCaPWzNAjosK7ru7jyIsItxNj46UZZ47t/0/DKqHf
CIVuVq8FPw2I4DIpsTpPACEvyfrXf9OylNjnHYIWdRvDkgOMKBLKtWqNv/eSdfwO
40x+qNczPl6zz7BLB/5FEemEdfPdVIm5w70kOq0zeG6T4EglNJPWCj8dswr7nOD3
FrmdOGbdDpxQxI4UiuMbsoSTU8mo5z+DqoE+YWkwH8jm4m4cp4tH2JdIlT20ZUcC
sInAaMw/u4dPX8OTfWNCTED0S5sNMb7E5Yzy5s2c1yc0MQ0fDPYjPt4MPloupNR6
lET8uxSahuvpLSevsopbI//mq4F7M0wGsgoXFb4qXk7pxgGxMu8=
=tzJP
-----END PGP SIGNATURE-----

--d6arr666wdzokuxu--
