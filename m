Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9ECC30CD89;
	Thu,  7 May 2026 08:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778141596; cv=none; b=PqOZBCCJz9axiZjH4yR4/oZMzfRdY15L997KLNZeriBVr9oyPFFuce2nmTyOl8py/ATwuZEWObLQvEO4AbVOSXpcCuIWVJk+k2Op/QH3G/EDNuN3cHijtvGxjekRx1Dnq9YEOKo2vlxz/5IMYeoXn3fEjK4QOHpD3rhxR49JbJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778141596; c=relaxed/simple;
	bh=94EURvBpaB/qpYv6arM6rRi/1tApSfXs4S6MvcECnhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ggwf0yfUtko99icPLy379AlbmrU/sUHVep0l2AiFmP90XCbFKXkmUIwJuN/hJOaUSJx7f+KI3p+gQRKnOtNhAzaGRSPpm6qeqtta1kJx/TllmQxbMde8fG9YJxq65z/WJclQzNS09e0tEPD03F3AOUBbAf51MSqRyZBzAxKBf9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jMVEIOcn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jMVEIOcn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38A84C2BCB8;
	Thu,  7 May 2026 08:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778141596;
	bh=94EURvBpaB/qpYv6arM6rRi/1tApSfXs4S6MvcECnhQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jMVEIOcnAq5xHdT9rmQAFkmVgwQEJYmsfBjuY4/9QetcrIBztdU8besi1tRZWOD1J
	 LYBg2SdFguiU+qIAfWw0N6ss8p3MAiveP+ByjvHjgWbvbnWBlDdcdG0ogCSM89K7G2
	 xFnaBzeBwTiMP46eQyzpEKo6VzIz/5Bl516UeYsRythG0b3Htu4OWxocWAEKu5QIih
	 YXDiKYwjPil2tKvrvnVaulbLaGBfSvGhj5VNfzgS2sTbPjbsh4Zh5ELS7gYe8Xrvn+
	 fddeswvFHTiDH4RKb0fQfIPFJ3uJvMts9Txp6vPIoXf2+udbIo4PQ6qa/0Gwfj6Son
	 2stLEYb2jGBcA==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 60B971AC5891; Thu, 07 May 2026 09:13:13 +0100 (BST)
Date: Thu, 7 May 2026 17:13:13 +0900
From: Mark Brown <broonie@kernel.org>
To: Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
	MukeshKumarSavaliyamukesh.savaliya@oss.qualcomm.com,
	AniketRandiveaniket.randive@oss.qualcomm.com,
	chandana.chiluveru@oss.qualcomm.com,
	jyothi.seerapu@oss.qualcomm.com
Subject: Re: [PATCH v1 1/2] spi: qcom-geni: trace: Add trace events for
 Qualcomm GENI SPI
Message-ID: <afxJmZ9MkP5eJkQC@sirena.co.uk>
References: <20260506-add-tracepoints-for-qcom-geni-spi-v1-0-c957cfe712d1@oss.qualcomm.com>
 <20260506-add-tracepoints-for-qcom-geni-spi-v1-1-c957cfe712d1@oss.qualcomm.com>
 <afvkiT50ZUEXZ-YO@sirena.co.uk>
 <e4651363-7c1c-4ae0-a97b-b64841424c83@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CXGHJEGZJRzdqvcU"
Content-Disposition: inline
In-Reply-To: <e4651363-7c1c-4ae0-a97b-b64841424c83@oss.qualcomm.com>
X-Cookie: Truckers welcome.


--CXGHJEGZJRzdqvcU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 07, 2026 at 08:58:02AM +0530, Praveen Talari wrote:
> On 07-05-2026 06:32, Mark Brown wrote:

> > At least these feel like they really should be generic events, there
> > hopefully isn't anything driver specific about them.

> Initially implemented as a generic event; however, splitting into separate
> TX and RX events may be more appropriate.

> Which approach would you prefer?

By generic I mean this should not be driver specific at all.

--CXGHJEGZJRzdqvcU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmn8SZUACgkQJNaLcl1U
h9CJOwf9GQwE4WHnloSJ6SGx5h8PlOn3Me2DgSuTUn+tkIXBMhWopzwxzrdLcs0j
y/geHWa9Wuw+Zr2KXhS2t8mkpODHldshlbPjusaZ0y4cvy5va0gP0cUhYKoizJH/
7E30AQ7HqBonTW8Mpt9UCiDcw0JPDmqBySmf/tg0s/hnJJbJq6gF3R2xSrGQvo1c
v5yx/lV+kAJQlvcPhpOrAB+Xv2qUT/SrP8uQ69/Nyw7GGBDZixV1Y0hUcvHaT9xM
WDw4vnDSizjiqGrfjJ4LcdazIZ9WgEz0MV6aNcSAMbuzGTxuKyj7MDSbPE49iNCF
OGmQSKWAk+bSk5ZmS4Cg62RyvxGfRw==
=rJdk
-----END PGP SIGNATURE-----

--CXGHJEGZJRzdqvcU--
