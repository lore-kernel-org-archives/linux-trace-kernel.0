Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19731239097;
	Fri, 11 Apr 2025 17:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744394006; cv=none; b=bzecnXI9CTZwLDFy6QK+mpG36SwXqfRkEQjX1fHIcFNXHkXwejEtrMMdxksTI31KGrD8sGOMTrEBJYMQdcsEERK8deVluq+GzDw/lBEVJoAS7PiHJWZ8/Xh2ljh4Amdc2IpEh1WVF0k2nzwyiyRfPz0Xi5m0lq+FE4tBXNT6E3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744394006; c=relaxed/simple;
	bh=7ICvhFr+uZa3SSsTnEhogcfdrwv3IAyVQanCmS7m2vA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BGlmuFkoxlctcF1h8erfWrT27KAGm3dPLSEwJ6S9d5Y4ZY/6w/57VKuzJe/RpiqR1UnWUeGS9vTllipp6sZ9rEX/jBXii6LLla52F2Z1Ibk9wOCYPjSCXhDo0hLcBAwiQt/xy76LkwqeU/jt/pAKDvRtZSbb9jkAOK0YvKdDmj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=trwIwmkI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="trwIwmkI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38EA6C4CEE2;
	Fri, 11 Apr 2025 17:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744394005;
	bh=7ICvhFr+uZa3SSsTnEhogcfdrwv3IAyVQanCmS7m2vA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=trwIwmkIPCsADSAp5RLzPO893NYL6upxsahbf1vwjKw3pZXAXlq7DyAMziytnX8YL
	 74Rl8duWZTY+TBSWFK4sMbff+4UWS57ACIsUNBiMI6xTtFHL1KpKnnL8LhIQ3lzLf/
	 G06Ns8XTh1viRI+l0w7a1sDk/toHQcdtrvO8qr7Gga3YLJwcCLrx+WUImUFVy0kT+d
	 2NzqvzS6zoyx1Vw0tOIqUGX02A8aI2dHvFlX4NTMTGUOjdg+kPrgD5VSKbFIMg6EwZ
	 uzcyDya/ph4xiNhAoERRH196ezzoH4KLAgNapPQI4L/r5RP7npeyMJvhMzn3ltNprM
	 BpejONUbmhyoA==
Date: Fri, 11 Apr 2025 18:53:21 +0100
From: Mark Brown <broonie@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] ftrace: Do not have print_graph_retval() add a newline
Message-ID: <11a807bd-6fea-472a-8afd-01201817f7ba@sirena.org.uk>
References: <20250411133015.015ca393@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="37MoEqSJiaN4NckA"
Content-Disposition: inline
In-Reply-To: <20250411133015.015ca393@gandalf.local.home>
X-Cookie: You will be awarded some great honor.


--37MoEqSJiaN4NckA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 01:30:15PM -0400, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
>=20
> The retval and retaddr options for function_graph tracer will add a
> comment at the end of a function for both leaf and non leaf functions that
> looks like:

This fixes the pid filters tests on my systems:

Tested-by: Mark Brown <broonie@kernel.org>

--37MoEqSJiaN4NckA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmf5VxAACgkQJNaLcl1U
h9DHYAf/S7sjG7dUSUP3lZdCJzMNYWc9lnMcCTEUAw/EyjR5iYmqiQAXs0Qs8w7K
iDOpdQmHKZv3DULJ4Wh5eblduTQc9ssjy3ZZdGl6nvyQM5pvOsh5KeZgiXf4fuiC
BSuKZChPVdxTJ68D4rmG3TOqO8kgBqMZPE3qx8oiVlsj9m2xkbWPpbsCUVfNtjvt
Gg8Y8NYTdGfP1I+p8Dc5gbi0+OxcDm1Oq0I3dKT1CYLR5i1V125FvNXzSi90MhI2
3DAIGpG7hDasqX4GOo3/2DO+TlUhPeVFaIMehPgahKleEg6Jgsdv1d7/B1Ffj5kN
lx60CFuo1B8sPbHie05LrVoAy7cEXg==
=N7H9
-----END PGP SIGNATURE-----

--37MoEqSJiaN4NckA--
