Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066C99476;
	Thu, 13 Feb 2025 03:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739417496; cv=none; b=bzOUI5sK0t2UYY14aBvvsoFFRoJ8zy77lxJrTsLHeoZ070+VLTG8ZWfiHDVCHLV9kQqpUYmYGFFH36rSIGTarlSZMhKjH9yMmbpjIzR/pGBQaZfEiic4kS3gcd9a0xsnayR3M8MqbGgeCkeh7hbz4GRaWm23KvNl0f6iCr+LMRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739417496; c=relaxed/simple;
	bh=Q8EwH0ENUprCzIBAekBdCxAsKlSG8kdvqUySrD13GpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f6Kys7RTjJdXAwaO4/sZioLWg3o95QEZdRWwmnOK9G5suJPSmFGQXcI/N0QPADqnlD8xaL8twp2HzlCei0zGdx9HGV0/JcBHZ6Op3pB+RKKmRN8p/kDBePzNddmb9V1TxhvkV+HF+pKz3a+w/UvKHCUGXQAajU4hbsamlAaZumw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NEbkf8BX; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NEbkf8BX"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2fc1843495eso101127a91.1;
        Wed, 12 Feb 2025 19:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739417494; x=1740022294; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=75irhUr4NJWrSjQg3lqVY6NYuQhtQPvJ4JEknJJLBuM=;
        b=NEbkf8BXLQ8NrE8Dx5C9GMGjJ4Yx3w668QK48R4clrTLHGV6R1bVD8C1cUY1mTxLn4
         XPRg81P5splozw1XkkrNN8LgdPmuiSdYwyD/U/Ml06rop+ZTILoxW3Rg41vLHPFG7AM7
         93UNoYuX/MCh5osfKKhfTshZBeEioUW2fHsKgBxHztX2vF/AZ2c4iNrI7ANiTvW7LLpG
         21gw37NifiQ5VAekJm10SfzEM3fn9+7qw6inh7F9Uabo7bKOGPPP3Z03wpCXOkMVxjxG
         7QvLoB+AXwyrkSguKtsuMU5VU74bRP9FgeXr9Or3gX836Yhl2t3D9upkkLn5t3gaXV9q
         QUjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739417494; x=1740022294;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=75irhUr4NJWrSjQg3lqVY6NYuQhtQPvJ4JEknJJLBuM=;
        b=Vaj/0gk6CNTcxdXpe+nnWQFNCpKMFlw6oM4RzfOTAX4AOirthdXyonx1dfig/OE4bn
         moh6maANDFQY/QUs2aIYxK8diyDIPBYHkiAVPPvpbj/jSpv4yjT43EgHYWOG+8LqJp3v
         jRgByhZClQOHJZ2416a71HMx00JNa8EjUwbCs5fanSyGrSBa9N5QB/5Scp/P7v3ujPQ/
         o0S8ySi8ffZr19UeLtz2wQPKbraK6VR8osUTILvrRMySwr9wFn472IQBJ91ouymSKN+P
         MYFBWnEYOcIYuAeIVssEBgG7Eq4IGqOLeGXJTs0QyiU8xU26j5DeyaJeHRRDoYAafAgc
         MH1w==
X-Forwarded-Encrypted: i=1; AJvYcCVCUzZ3nUjiJVZ52U9Is1y7plNNnw4G1FWJGxA21+ZXYCMLa/FdeIlJmlgpOpBAESeyALdYDgGzKzk=@vger.kernel.org, AJvYcCVRgWQkU8kQ6U38micMKxK00PJvmm9deEV1Tgyh2HIfPOh3CtMMU+gWjHR5w1V8GX3WGAEKHCgccssX/hC7@vger.kernel.org, AJvYcCWSM3g34vFO3AocSB9EmpCxNKALA7Bs9OhmmVMO7ljrgip4d1ZMs9SHdLKQ+JmXo8oqnqleaggIQTqjNOhbyPrPVmV/@vger.kernel.org
X-Gm-Message-State: AOJu0YzwHQY0fUJwANJJ8iwTLB/SI52P52Z/KJ5ZHLrbZnrs01rTRQs9
	cJ+0DnG2P/bqGdigeh0pAtAmOpXUmvybe2FzEmMggngBhdzpQryW
X-Gm-Gg: ASbGncsb4qxPrCsHMoL1T0vQbF5vM+SaWfQa7ZfRZ0oum3q7uYR51RPOgxN7rf8/Bbj
	jr1CZHxgp10Vh0sq4ueaHQGzS5okDFjDaF4M6v7L8Hn+hQoWL/7ZcT76yRzUzIYlayFsmRV7Y5b
	X8Kyp6PztXXamyShxcYDsHZQtD90V7PqmEhfdECe43j3R7rnKwYVJPuRfUBkU1N2S16rQ/1JTZr
	QYkEY8kH21XGzyu6usYvo42uQC4hPqUtC51IhWqGHl5z5hCNjRtG2Tk0KnZ+LV5S2HaJ1KV+G7E
	OfjNZFNXqIjUQhE=
X-Google-Smtp-Source: AGHT+IFSe8dlFKi5twoIhx4rWsHQnu8HvDw55CQSxaFV/pYXI3d9NEwKZfEDzy+KIvYPgQTIbXIcTQ==
X-Received: by 2002:a05:6a00:3989:b0:729:a31:892d with SMTP id d2e1a72fcca58-7322c591baemr10797114b3a.8.1739417493949;
        Wed, 12 Feb 2025 19:31:33 -0800 (PST)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73242761619sm215859b3a.141.2025.02.12.19.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 19:31:32 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id E42274208FB6; Thu, 13 Feb 2025 10:31:30 +0700 (WIB)
Date: Thu, 13 Feb 2025 10:31:30 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Purva Yeshi <purvayeshi550@gmail.com>, mhiramat@kernel.org,
	corbet@lwn.net, skhan@linuxfoundation.org,
	mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] docs: trace: Refactor index documentation
Message-ID: <Z61nkk7X3jQJyzYX@archie.me>
References: <20250206141453.139613-1-purvayeshi550@gmail.com>
 <20250210174556.70fc53b7@gandalf.local.home>
 <Z6yBtB7mjoiquKRj@archie.me>
 <20250212095111.7e07b92e@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="G1xUjSJSMfJSdqY9"
Content-Disposition: inline
In-Reply-To: <20250212095111.7e07b92e@gandalf.local.home>


--G1xUjSJSMfJSdqY9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 09:51:11AM -0500, Steven Rostedt wrote:
> On Wed, 12 Feb 2025 18:10:44 +0700
> Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>=20
> > > > +Introduction to Tracing
> > > > +-----------------------
> > > > +
> > > > +This section provides an overview of Linux tracing mechanisms
> > > > +and debugging approaches.
> > > > =20
> > > >  .. toctree::
> > > > -   :maxdepth: 2
> > > > +   :maxdepth: 1 =20
> > >=20
> > > I don't really know what the maxdepth gives here, but there was no me=
ntion
> > > in the change log why it had to be converted from 2 to 1. =20
> >=20
> > :maxdepth: specifies heading levels depth of the toctree. In this case,
> > the author wants only doc titles (hence 1), whereas 2 also includes
> > second-level (section) headings.
>=20
> As I'm the original author, I would like to know why there was a change.
>=20

Oops, I mean I'm referring to the patch author (Purva Yeshi).

--=20
An old man doll... just what I always wanted! - Clara

--G1xUjSJSMfJSdqY9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZ61njAAKCRD2uYlJVVFO
o1RTAP0R+L/WHOcFYnFYSyJUoEvegF44yZcBOi74NnUA5cbqGAD/aFv94vJEm1Uv
fVr4b6gsHMzKFD95XwkISpY0U1rpEgQ=
=8Que
-----END PGP SIGNATURE-----

--G1xUjSJSMfJSdqY9--
