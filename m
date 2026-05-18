Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3D033A716;
	Mon, 18 May 2026 14:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779113249; cv=none; b=cPuUzRg33ELTnGTrv1eQnLJNtqROv49a1AWz868PHXqdefRKdh7GM6zZVa4haqljrJTecgs+liDcV7+sf8WY4ELL9JdaxVoWnQf5D1UjZuq75FwjDzYCBbnbT+Q8Re+sbLaWhyARUMzw4Vob25pJGj9v5TVin8P97VTGYixv5YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779113249; c=relaxed/simple;
	bh=oSvp7HZJRVj3cQNvzZaMyeOe+Zjm47CA3YN9oHEJfws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XOkrFFlQqAkyIICdDc7btAYxpY79ItOEQamOT2ueJZzdw59UU6wvlQjE7HUuk/23IpBqH/poG/lmOtrqKWTwN86PHDJc3sso308894K2AkXH4XB5x1a77o/qQ8gEA+gux0wclUfId8ZLz2de60VC2ZNjGBy98w4Se1mu3Xqb9OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uJt1PS6G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uJt1PS6G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 714DAC2BCB7;
	Mon, 18 May 2026 14:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779113248;
	bh=oSvp7HZJRVj3cQNvzZaMyeOe+Zjm47CA3YN9oHEJfws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uJt1PS6GA6XOPI8K9x8xWy8HSHvpyj6SM8FCfRiVOC1mkNGs+EXK5TNMPKR5XsniI
	 0ETmqRflAeflhC3oCRLIAw750VEpEBQ5geHQ48hcxyDG2+cu/CYuXwOxK09lmDF65G
	 wrW9Eru86BdaQgzpCg453G83qxnmiwR3S6Hchwv4T4piVY0NlgUocrQKD9eA4GwbBi
	 XFPMwzQIBqrznRURs90nlsEkUb4M24203cce5kY77g54gpbt1C7nlxDAEUhHzhaxi3
	 ySWXVCGDpqOKmk0gRBKh3sZEvpt3sMKcyeFKdQAplxXRFyAu28Cirblvij24IVhrL7
	 CBwZFRf0+MRcQ==
Date: Mon, 18 May 2026 15:07:23 +0100
From: Mark Brown <broonie@kernel.org>
To: Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
	mukesh.savaliya@oss.qualcomm.com, aniket.randive@oss.qualcomm.com,
	chandana.chiluveru@oss.qualcomm.com,
	jyothi.seerapu@oss.qualcomm.com
Subject: Re: [PATCH v2 1/2] spi: qcom-geni: trace: Add trace events for
 Qualcomm GENI SPI
Message-ID: <a713082f-e84e-403a-af1d-c6fa0c5d8613@sirena.org.uk>
References: <20260512-add-tracepoints-for-qcom-geni-spi-v2-0-3b184068ecf9@oss.qualcomm.com>
 <20260512-add-tracepoints-for-qcom-geni-spi-v2-1-3b184068ecf9@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="u3XUWEzwlYVcuoq9"
Content-Disposition: inline
In-Reply-To: <20260512-add-tracepoints-for-qcom-geni-spi-v2-1-3b184068ecf9@oss.qualcomm.com>
X-Cookie: She sells cshs by the cshore.


--u3XUWEzwlYVcuoq9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 12, 2026 at 11:42:52AM +0530, Praveen Talari wrote:

> +TRACE_EVENT(geni_spi_fifo_params,
> +	    TP_PROTO(struct device *dev, u8 cs, u32 mode,
> +		     u32 mode_changed, bool cs_changed),
> +	    TP_ARGS(dev, cs, mode, mode_changed, cs_changed),
> +
> +	    TP_STRUCT__entry(__string(name, dev_name(dev))
> +			     __field(u8, cs)
> +			     __field(u32, mode)
> +			     __field(u32, mode_changed)
> +			     __field(bool, cs_changed)

These don't really seem like FIFO parameters?  I see that's the name of
the function where we log this but they're more just generic bus status
things.

--u3XUWEzwlYVcuoq9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoLHRoACgkQJNaLcl1U
h9A0Swf+Odkv1N6HfnsJDnd/LK8D4r1GD/LtejPCiZp/mKDpeDgz4l20FvpeT/L1
xMPbTTM6wn1y6m0XDwkANSk3XtwsYb6rW0vxTqVKZNxYuurpp9KJ+MTXPu5z/yuf
BOdQgbzc1u2B12kcdjlQlN52vc7YvyYkx8Iur+nRmOpbZy621PLEK2qDhUSpu+62
MAZQr/FCvJ2ehx7VfVfWqrQdy39D/EYCIOF9rzL17HD56EfZ+Q22Mqz1ar/E4cZy
We8GPggzqUxsHW4WzIYa13mZ4peVTffEW6RMX5VY1htdnP33DNe/WrVhePIVhUwM
wclc6baB3yZAkrq2kts0QQXVK1Y6OQ==
=BhrI
-----END PGP SIGNATURE-----

--u3XUWEzwlYVcuoq9--
