Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC09A34EF1F
	for <linux-trace-kernel@vger.kernel.org>; Thu, 21 May 2026 08:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779350545; cv=none; b=sh2AHd2geGWkUKwZI+z7Y6Zr8fv3Z95I8Ht2M2fC2jeGYN2MUJVg/OGrhkHH/Sma1r1pTkrI7sQ37OrfOeMly2KSlGtA3hdZhsa4DN8zYBOU2EZmYXrHq9k+9juTAnHt87r08Mh4pg/boa6rySOMFsGAR8Fsspi1bvWZVHT8C5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779350545; c=relaxed/simple;
	bh=hbRDLYE2cbMKakevePB5wZhSMX5cMBexsypIIixVjPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ClOxPjJiro6cG62j4gA9Itq8yLg9MTFGiGGQlll9/KzPrWM1ykMbQRiqW0Pf/8/clOkNWCnLCJEmjDyjiCcohaffprPHTVK+w1nEa/1thzkJi1dnG8iV+T84Eq7SpAb1k4XFQ5vyUVUwPeWsLbPXIGThik2f5tqqYu54zkfSli8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qtJT95k+; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qtJT95k+"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48ff4f8ef0dso63526695e9.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 21 May 2026 01:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779350542; x=1779955342; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hbRDLYE2cbMKakevePB5wZhSMX5cMBexsypIIixVjPk=;
        b=qtJT95k+ftIu51zVzStSaXJ3Bd+UtzIF5vNS1phG1gp1Q1W/MlIPZueEsz/QXWk1Io
         D6POK3Zzi3KVuJ+g2UArOkrnyAl0l0vFoiyxACzI1p7gLCRPFAOXLzt/3cLpS/j3KmLk
         StPmgikxnG6xF1+XUnNDM1IZifqHeOydntIk7D6+khVRZ4s9b0+zM4eS6S5dkj+UmOGg
         na5ZQnB42XkxTgTuGdyyGyErpkm7kphGvc5Xvgpqk4BEWIVWPtWrNp6gh4FrmLlENPYx
         1/L0H4o4SbEohAa5tuf2Z5kJwtnh+dz/qbReht1DyfBib03/G4sEuV6sRurz0sXMvlCw
         34Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779350542; x=1779955342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hbRDLYE2cbMKakevePB5wZhSMX5cMBexsypIIixVjPk=;
        b=I8PZKRx9YOb8sfXS6QgW9IfES098gCqyfTyK8HLIhhZ3CHO7Xr4F67ugB2DzIG6pIB
         +97dxS052YTGDSWZnl2z7YdtV6opbvWbsEPUF7t0s8uQqBEgGvQjENhcseNWVVxxJnc7
         X7GUMj9T7TDu96HC/K6SUZ84/KNIr0ItDzMUYaXBHrv4ChqspNqvyCDziCP44Iy1Qy2Q
         pf82QVH1OetEpkNxDRV3ZN19WN5vm5XivuoRVqGUAsWOqFlB+LvR56zir85SyFBvqKcH
         IGsvmPCoOibXqNdJT3zjVfKm1mdqfMJ0xdG+Awg5WPaeEnvNl5YLRmpR0dH9w1y0l+KL
         DSuw==
X-Forwarded-Encrypted: i=1; AFNElJ8O3AF1m9hvHRgdWOaoquqbgergMEEuYcjBRLKN3EU2of9UuMHOmQMsaZ1S2NrIkdjpIud36ih9eoFGbQhF8gpM6XY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMlHnHaoolMYIyr+c7CPUAfPzTxFkIg1EaLMEp8jyWh/rtyZVH
	CVG97kA43f1CtC2vJUjF4UXfBC3FkxpMYieB/Ts3EmWCQtARdseDu3CA
X-Gm-Gg: Acq92OG24XbYi8JgwEERWwkpT2HkjtgwNptzKlYTkHRereoODAk7h/mT9dU987/H6la
	53pKoLZJWUbTfYld/gJWrrpsniS2LnI+mzxV7eUDSiGEnpKnkXov/GhLxeyJLVlzhCdJpzpzJQ9
	iLOwul3QVD5PQXNiwP4tBZpOeY5wFadoN+ga8arMMbLwc1DeBlW5IZX3X3fnn0zTwnVbP5fRhus
	KgAbRzkxxMIo+tEAlGOkO4oN/Y/YclaWWNjIA3TMfE2nf9hUoTovxMKR7uahGwgHR7D57LHHzT1
	R+7obu60OjCvrhmsOMHbGag+dYQ35u5QC4fL+GZkmQv2Hle3r7/N0LY9ywMqQNCawxAeafKzHfG
	E8tm0xCv4Jieb3DrBJ6hyEFBZ8LE7i25joWM5RxxX/y8i5CDTop20GxcpuPXjQ0WA5OMVMWYxYo
	vyV/CdK/i3FyVaSOjnOPdDB/Vy2hA2O8ImhANu6S/iVGCPJ8xnHPxQnANk0J99TybEbO3qCMtZq
	370QawvQKIR4w==
X-Received: by 2002:a05:600c:1f89:b0:48a:52ee:5776 with SMTP id 5b1f17b1804b1-4903606b7f1mr20526055e9.11.1779350541494;
        Thu, 21 May 2026 01:02:21 -0700 (PDT)
Received: from orome (p200300e41f291e00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f29:1e00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eaa7d9daasm1044740f8f.11.2026.05.21.01.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 01:02:19 -0700 (PDT)
Date: Thu, 21 May 2026 10:02:17 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	Artur Kowalski <arturkow2000@gmail.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-tegra@vger.kernel.org, Thierry Reding <thierry.reding@kernel.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH] gpu: host1x: trace: fix string fields in host1x traces
Message-ID: <ag67-LzzT6ZQTKlf@orome>
References: <20260519-host1x-tracing-v1-1-55afb8cbd186@gmail.com>
 <20260519141059.77435501@fedora>
 <ag2iF9bZJcBQ93lh@orome>
 <pQKtL-t0RKO7KsvRTAIQ_w@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5k33r6t7pdtm7qgm"
Content-Disposition: inline
In-Reply-To: <pQKtL-t0RKO7KsvRTAIQ_w@nvidia.com>


--5k33r6t7pdtm7qgm
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] gpu: host1x: trace: fix string fields in host1x traces
MIME-Version: 1.0

On Thu, May 21, 2026 at 01:33:24PM +0900, Mikko Perttunen wrote:
> On Wednesday, May 20, 2026 9:03=E2=80=AFPM Thierry Reding wrote:
> > On Tue, May 19, 2026 at 02:10:59PM -0400, Steven Rostedt wrote:
> > > On Tue, 19 May 2026 12:16:43 +0200
> > > Artur Kowalski <arturkow2000@gmail.com> wrote:
> > >=20
> > > > Use __assign_str and __get_str as required by tracing subsystem. Fi=
xes
> > > > string fields being rejected by the verifier and unreadable from
> > > > userspace.
> > >=20
> > > Does anyone use these tracepoints? The fact that they have been broken
> > > for 5 years and nobody noticed makes me think they are useless.
> > >=20
> > > I rather remove them than fix them, but if someone thinks that these
> > > are still useful then by all means apply this patch.
> > >=20
> > > Acked-by: Steven Rostedt <rostedt@goodmis.org>
> >=20
> > I know that Mikko used them a lot early on, but this driver is pretty
> > mature now, so we rarely need this low level of tracing. I'll defer to
> > Mikko on whether we still need these.
> >=20
> > Thierry
>=20
> Yeah, these have been quite useful in the past when debugging why a job
> is failing. Without the cdma traces it can be cumbersome to find out
> exactly what is being sent to the hardware in some cases.
>=20
> My preference is for keeping them for now.

Thanks, I'll pick this up then.

Thierry

--5k33r6t7pdtm7qgm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmoOvAkACgkQ3SOs138+
s6Eaiw//axqMHw2aCBN/4prDAG+8/dWi3NTEhYUsoXdeqpwErHY035ErOee+dQ/J
UZhhYf6GPAWSiUycfr9sqpgdRLLBwaNZpAcwcWfUMRk5iCOrI11+gs8FtYK/jkcJ
Hjpu5d7IaywXKHq4j2yX03vT9Dm1XqHtc7JdHDxW/FINaqM23FXZyzE8u1FLjvSF
UllYcn6pWbPB1iF57OnrHMaNI79aBU9mHLmIHMvWZZKUfkkE0mVd8q7IVWlqCv4w
GvVf7aZI77rTWWzaCjqAQtzFTQ274x4B2BsNDw3aIc01BdCO+wXCkok+u7olVwNf
vq/El8n8PCSNJADGxiGeT2nVnF3lMb0zAmbBUFtKe6hCeI5pIZWFH8B6zrGOklNK
ajNNPg/diQTBFEeEWZbHp9jo1vUbbULEiNhmoHchrmFeSIiVTGJLJjV4wG+fE8nL
tLiE/Ie38IvQ60q+7CMkxtFfVHI+4BixDq+tw0cIlimaGKUB8muDlOkb6fvGtave
i3qs1uKqTtyECsm0xYJ9Q+/BDHANvPHvm1PRvoU/5mkK0qP50SkiwSM2SL14giaj
mPB6loPhE/tAtBSakC957dD2A3YPFAfWeHUjmhrYZ+tJEB1kLRW/u5Jb/L5T0Mq7
0ZoDYGbIU7mynkc2ZCnwjFuIQbJkTjzuF8lFjiIUwy4wdpMdsiw=
=VGnz
-----END PGP SIGNATURE-----

--5k33r6t7pdtm7qgm--
