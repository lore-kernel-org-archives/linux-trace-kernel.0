Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0C01A3172;
	Thu,  7 May 2026 01:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778116024; cv=none; b=Ashbw0pn0djGkb6Eho4IHXHl2a2VOahsvqti6o75hL+dmWYyrDmPHjaCGk1XpYMEWmgmS0DIXIrYGPBEXSrzqdkQjkgcbM5TbfM0TAwTgjnU+vHMZLw2c9w/Ox5HLfRI1wrJGPLw1Z+h6UdhsjJZ5Dh3Pd5kmXxq6kLgK5AtsAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778116024; c=relaxed/simple;
	bh=ZKX/D9zQmeru+Huodbh+JH3SBzBKUgpTWReRJ4E3UTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U6bP5jsguuxLnJhcdtBq/wXg3/hqIrAUNvu6RM+Jf7cB5ZaGs9gbsQsqJzWkbz1V/HbM5eRUnOv44BlUzUpqBlacPkXal5E2x0aEuSAXkc2TIB0BdIu2Cruc1bV07J6nYm+8n6RY/r1UX/t+hfE+IF22UBSf6g+R7P9KxVaILqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IO2OLgQn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IO2OLgQn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29022C2BCB2;
	Thu,  7 May 2026 01:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778116023;
	bh=ZKX/D9zQmeru+Huodbh+JH3SBzBKUgpTWReRJ4E3UTU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IO2OLgQnworEChZaex5cnXRDKnURRbNnLtrGlkbVqAn4XLpkwQuCwmI+/qCKiHkbU
	 nVC6srkNSL6kIPcf7Fx7bacrpVrX5SR3PNxvBBFqHmXJpa6g3p6vDjc23St/1tYfFS
	 L9bJUZW3ue9e7wBiL2VJPg7JOfDC9exjNdP2s+reoZZw7tFBAB4+q/x+lOD2sdIcW9
	 W38qkaPyAyv7X3mzXgjtFLAJnoO8KiPS5d+vv+J89KTxO5N9W4/oq558HPAi36kq2T
	 Y9eaLGKxCVNAj7lm0ondgcvm2S9pjtNIhe54WHTFlfzRfD46DshupqjZsAG1HSmFUj
	 qipex1InBt7dA==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id DD5741AC588F; Thu, 07 May 2026 02:07:00 +0100 (BST)
Date: Thu, 7 May 2026 10:07:00 +0900
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
Subject: Re: [PATCH v1 2/2] spi: qcom-geni: Add trace events for Qualcomm
 GENI SPI driver
Message-ID: <afvltFJzKLaO9weP@sirena.co.uk>
References: <20260506-add-tracepoints-for-qcom-geni-spi-v1-0-c957cfe712d1@oss.qualcomm.com>
 <20260506-add-tracepoints-for-qcom-geni-spi-v1-2-c957cfe712d1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t1mwQTkrypJu9WtS"
Content-Disposition: inline
In-Reply-To: <20260506-add-tracepoints-for-qcom-geni-spi-v1-2-c957cfe712d1@oss.qualcomm.com>
X-Cookie: Truckers welcome.


--t1mwQTkrypJu9WtS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 06, 2026 at 10:59:43PM +0530, Praveen Talari wrote:

> @@ -717,6 +726,7 @@ static bool geni_spi_handle_tx(struct spi_geni_master=
 *mas)
>  		max_bytes =3D mas->tx_rem_bytes;
> =20
>  	tx_buf =3D mas->cur_xfer->tx_buf + mas->cur_xfer->len - mas->tx_rem_byt=
es;
> +
>  	while (i < max_bytes) {
>  		unsigned int j;
>  		unsigned int bytes_to_write;

Unrelated whitespace change.

--t1mwQTkrypJu9WtS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmn75bMACgkQJNaLcl1U
h9CLKwf7BDdQED7owq4YZXcm+ix61hp5aMPV6hUNEf6moiRWDvmCDjUSSAvoCR5B
rbbSbaNr09B+oP3xp1r+BQu3f4YX4Z/+C+CgAkPRurh5MPsFt41S5JU3P9t2Nosi
rbjRsa0+9ri8+dnS+8L3xpKlb2RkoZpr+xvo16E8cOcSxp0cYUnwk/QiPI2+pWc3
HjCztBS5VqUy30p8aIEVovMBTbVML5jXdVurCJA1qUrDo1GOW//HogkqgOe1A/9y
0WroGfpL3ZOiHfhe6mynITWvS6JidXtoDVrCu/1ZVbg+prQv8bwoXFdop7JoHc/7
v6QitFNhe860INKjEcHZmDgc451vxg==
=hUXa
-----END PGP SIGNATURE-----

--t1mwQTkrypJu9WtS--
