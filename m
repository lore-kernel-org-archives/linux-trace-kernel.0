Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794926716;
	b=k/Bp7aRD6F2A4jAupwPjud21tlx+8rUa3Hmx0Qta6kymI/OsPaHbwg76PNfUt+Q5oGnL
	 /omvINYhWHMSqTB7o0XnWSqz7IBqLUz/1/h1iv2Wi1JYQNSyX4lJTQ4yUs6lT+LmrsNP5
	 rcEBhJb29/ApcOGtJyJEgsonvyQXSvYnSlqlNl/f0Mkv/2znqQRT/qV7vsVBAK89g2VL8
	 96GQ4npEurh7EEjL+u+Wo58VMx1EKeYovAJchsK+ICC1GtJvgeeL5h7zQpDwErUKeQd2l
	 9pX1mok2Xth8UTbpNRnCsiqz98n/BpQysgG5buRcp6VSwae1mLnVQ7L38iyhjjJuesA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794926716;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=epOu/LkfbjXuT6sbFKBgAkwfLLbAipZN7ibgC7Hr7uY=;
	b=hDzexZfAJcQz0p4S1pKL6LRWZ0I5QKwOyB0tuKBtz1nFiSXZc26ltpLuzgZAvlQnq9ex
	 FVjLj0xh7iH0J83TQ9T/I0cvUsWeKSMZzWd3+NvjIvHoMjhPUcCbQtcWAbX4WtlDm+Sin
	 3PJBLcXAl+uDhiEL5lH1FH32d0rWaR5xFvzMShgTujMKyFvz85u3vEbZhR7JZDZ5VUfWJ
	 pzgCIOgtG2+6rs+5HmMo7iZ/Xpw59fvHEEe6kdCH70noEO2CsvZTUIe4RaBnZAC/vMStl
	 zE+3PU6mU7nIeswDHE/Dd2MbSL8s+xh8rN+Bg/kGleWP0ZlbYzwbAdZDQ9s3feY0i3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ha+Ffphy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489AD606A32F;
	Tue, 17 Nov 2026 14:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ha+Ffphy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 481091F000C5;
	Tue, 17 Nov 2026 14:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794926716;
	bh=epOu/LkfbjXuT6sbFKBgAkwfLLbAipZN7ibgC7Hr7uY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ha+Ffphy6OKfOrok1oN1DIOWa9vjFyC1m6ZqHmXZ0e+u3/hfEL2U7eNiAvgguEaiM
	 33F9xj0wM4OpkYSSnfvV1LDvcSEy00AzXnjzL+1v7wUgpxOcSW1ubgYK90zSi+eF5p
	 kB0yU7CnQgCGXol0FveJ2y4GaRmej8QYuu1anCIkjD7hN0x/GY5CQ8sdfqMqgfWelz
	 cmu6FtW7vdeuiYdtD7z0YQFW5Z/WLBYJM6Tw+PXHtJpAFEKEEVuH8qH7gKYIfIbQ+w
	 iaAouNyusrAr2RVJfiU4ySJkEvkSwVW+JJaFjcYCQSXmd+WDk2wMokKJclG3r8n1xz
	 Is9FhEkz1D7Ew==
Date: Tue, 17 Nov 2026 14:45:11 +0000
From: Mark Brown <broonie@kernel.org>
To: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= <amadeuszx.slawinski@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Temitope obabi <obabitemitope765@gmail.com>
Subject: Re: [PATCH] ASoC: Intel: Remove unused sst_ipc_inbox_rdata tracepoint
Message-ID: <d128751d-ea87-47d4-9818-a6d1cbc2fd1c@sirena.org.uk>
References: <20261110132013.732-1-obabitemitope765@gmail.com>
 <179487776546.3663701.11916478949345242482.b4-ty@b4>
 <19df2f93-adbf-47d3-84ae-6cca78b34df0@intel.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QFnHMYSH+eaxyNwC"
Content-Disposition: inline
In-Reply-To: <19df2f93-adbf-47d3-84ae-6cca78b34df0@intel.com>
X-Cookie: Marriage, n.:


--QFnHMYSH+eaxyNwC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 17, 2026 at 03:02:06PM +0100, Cezary Rojewski wrote:
> On 11/17/2026 2:09 AM, Mark Brown wrote:

> > Applied to

> >    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.5

> There is a separate thread [1] started by the author that will conflict
> with this very change. Ideally only the "remove whole header" version
> should be applied.

Too late :/ - the whole header one will need to be rebased.

--QFnHMYSH+eaxyNwC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmr8aHYACgkQJNaLcl1U
h9DnEgf8CranPxtYstZaECZZQbpJ2Z9KetcbycS8vtv4ZTUs9mdcbRGpZitakrMU
JYuB0w/3XUxdYKktqYR+djMvTMWaCG5WQtu5Rji6DWBq2wFcIeR90diiwG5+1YJa
6nsgtWfRmeWB/5ZJASVV+gT7yzhxCv7vsmgFdesIyMU+UtOHw/f0hT/BM/mimReQ
sK1RL+K3ZMWDnKPeSmsGcf5OLDYi5V01dxs6CL+/Qfhi7pAb7/jI4Xy9X/PxPY+m
neFMAZf6wXFV9RPQgZAqclTZW/l4d+hEqr/MY3z/X+VhuBNHqS/HFaw+KOUftOfN
aRtIz0buO1H68J3W7fuS+3G6Q4LN6A==
=Qkri
-----END PGP SIGNATURE-----

--QFnHMYSH+eaxyNwC--
