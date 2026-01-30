Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D0E35C195
	for <linux-trace-kernel@vger.kernel.org>; Fri, 30 Jan 2026 10:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769768544; cv=none; b=HpGzz4vKoofWd5Vgry3CHCc0wwW7hs2kioO7vyPeD6Ztrw02BBuj1if102vCwjXejJZX+5SnF37Ygn66JvThxm74GeAhlf9JtN5ycBe/RU5Dd40x4iaU4SO3yFAEruDTxRlAkEHgqFBhscKjsL4euDYwgaEWCcuISTpwovaEVJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769768544; c=relaxed/simple;
	bh=2C6M3tSHSfSWufF6RUJ85n9Nm2/4nxP6ALy7z2Z7v60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m5IKKc4GPb3qBYZ3s6O3JE22QzQHOY0a+nk/IdeCa/Taq715qJhlP/mvfpkjsG46MPirBvJPp2mxKV5AJ5guP+TjF11T6SbpjAKqv18YuvAX6z4AQ0OZCtNDyY6xXjTRCtw5lOyA5HM86pY7mOidb+pVUhToUrOnXe5FrsMKI/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Gr4vNUXs; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Gr4vNUXs"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42fb2314eb0so1687905f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 30 Jan 2026 02:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769768541; x=1770373341; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2C6M3tSHSfSWufF6RUJ85n9Nm2/4nxP6ALy7z2Z7v60=;
        b=Gr4vNUXsb+lf9QOsJ/Jmn80Hn5LmaoTN4KXvT/eB6ITDJP9Cyl10UhjEBzpLlviyPN
         FVp1RfJrue+IQrZBzw5uHmcXSopGtOqTyr3qyGJYOFAZlwL5etPl9Ck0rID4s8nk1YYf
         /nxVD385g3RGfbDRyPIaH35cXtQyEM1o8TfFTWS3qqjHS7v54+Mh2d1Sr9Hb5x+me5KC
         QgCQlljImlhPGjXJ4vV2sZVHpTJqE44QFQLAZshjYx915X3Hm96avnlH2KfCuM3wnwkf
         dXr+U90HHDJnKA4rHxFmMAdwicM+H1UKf23HsiD+6ZrxCVSdfSv1KXz2sySuFrYgdmwa
         xgAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769768541; x=1770373341;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2C6M3tSHSfSWufF6RUJ85n9Nm2/4nxP6ALy7z2Z7v60=;
        b=ttizL9DzUGnM5strhtfW+eUceTUPG/rzRP58yZ77Nj2ei4WA7RPgbVzmHXTnGkZ/7t
         EYN7+12Dcu7edPdcX9k1NIPVAPGuAy9DnH14pbYsXjVgGyTM3GCszUZ/YyJVFWJbdiWL
         ltRDSY5tTiFDSTS40aTIz/mdUNNNg2JeZfJohMWgAfzpEJ7mMDmaKFhgL/p7GmtIUzzs
         XqCp03cxFukkqGnPKnQQ30LEz+ubsHa1VC8vnrFhFcqvScwtz0s4OcS0ceN4d0KeckLo
         Dj37lMI89tcjypQi+TQbzGIb8fJ5/Q4osD9OIYYcOy77WIeRyiNVu5h0rypPort58MTl
         QOLA==
X-Forwarded-Encrypted: i=1; AJvYcCX63rvsBhEkhIl9eiyCq6vO3FG9GpgRFBQw4bRweUM7xrsVCZ0ygZdcnQdZCOleb8uwFjeMmzDJ7Mla4Ja2z/kfZ0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFfmHmYReVst6SzXHuq8GX9jUa6i/bpM4ohqAfpeBSPybqb8BL
	m2+lBiBwFT5sZ/gjNihTfhlIyQlyOsZo3woGOxBbKfHA1u+OL+V4Xs9U4rLKRwoMM8I=
X-Gm-Gg: AZuq6aIRu8OFSc5uA/Zmij5AvFqrUN/+psADhLMdFsCs/S9ZxYkpIBtgdQ+iliHsdD5
	u6sUF8/oGFrkwbe6GLWA/3CRvSytNQFC8bJ9a9lF7Yio3aigqsyWAwbWmh8JUc6//aBp1ly6g05
	jKOBbs2lKoMkllSXh+Xmge6RwyhcI61Vy4yrNpj2NfD4/r3woRDmgSeDtKZW/X1ODWVrgObr/d/
	s3tTGtqwqSGtusm1/rntdOXh06mNf20QHgKin2d3246R5qaCCIsRyndFexntyFmvlY7Uha2nqPz
	i1toGOVecq8GEYvT90jyqJZ2Eo077vzEFJ6NjoRDR/K62KYWtoRRIhByx3KxfYeuC14ZZMkUhhP
	0Di0lfqHUT12M1RzE7gv2wupxTz5c3UTkjIOLOikri7bXx53fEVPXCwWIo7Ch3Jxlo32JQI0ykV
	RYnJIrtgrvwwwEVK+YEOjuth+7Okl2C1o=
X-Received: by 2002:a05:6000:2305:b0:432:da3b:5949 with SMTP id ffacd0b85a97d-435f3a72ae9mr3679398f8f.21.1769768540911;
        Fri, 30 Jan 2026 02:22:20 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e1354d43sm22606824f8f.43.2026.01.30.02.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 02:22:20 -0800 (PST)
Date: Fri, 30 Jan 2026 11:22:18 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, rostedt@goodmis.org, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, inwardvessel@gmail.com, 
	shakeel.butt@linux.dev, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, lujialin4@huawei.com
Subject: Re: [PATCH -next] cgroup: increase maximum subsystem count from 16
 to 32
Message-ID: <stsf73lnkx2luuak3a7oi3q4l5axosrxogi2lncw4dkndnc2ge@3tioqa6ww5q7>
References: <20260129063133.209874-1-chenridong@huaweicloud.com>
 <asryf3kk6c337l33faqpeznk7d4a3rxblzmqrawxffq7sfbaf7@5yfzzdroltjq>
 <3a12eb16-3a91-4278-9dfd-6c6f424e7f9f@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zispwon7xf4glpk3"
Content-Disposition: inline
In-Reply-To: <3a12eb16-3a91-4278-9dfd-6c6f424e7f9f@huaweicloud.com>


--zispwon7xf4glpk3
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH -next] cgroup: increase maximum subsystem count from 16
 to 32
MIME-Version: 1.0

On Thu, Jan 29, 2026 at 05:51:33PM +0800, Chen Ridong <chenridong@huaweiclo=
ud.com> wrote:
> We compiled with 'make allmodconfig'.

A-ha.

> The BUILD_BUG_ON(CGROUP_SUBSYS_COUNT > 16) macro worked correctly.

Good.

> Can I propose increasing the maximum number now? If we switch certain con=
figs to
> default N and then a new subsystem is added later, the default configurat=
ion may
> work fine, but it will become a problem under allmodconfig =E2=80=94 whic=
h some users
> actually rely on.
>=20
> Besides, this shouldn't be a major change, right?

I'd like there to be gradual move away from legacy controllers code
captured in config defaults.
Could you adjust the commit message to stress out the allmodconfig tests?

The change is OK technically.

Thanks,
Michal

--zispwon7xf4glpk3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaXyGSxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+Ai/3gD+Pqinek9yDHfUrKo9Kffa
e6XIsBNZyHtXPceaa55CI3gA/0dRtNVhHx0+A1IfBm3aDf/gT/fX1P09yTJj8Mt/
8Y4E
=Tf8X
-----END PGP SIGNATURE-----

--zispwon7xf4glpk3--
