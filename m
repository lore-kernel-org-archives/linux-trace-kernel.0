Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4B83E5576;
	Thu, 28 May 2026 12:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779970276; cv=none; b=ZVeewjjB7KpO2mU3WjxyejVD7wO+XsqwRcf/R/uZI1SfVCyXx2+Unz6bGxyerLdC80a3l4hUWATRiHU/E2LFFWhmfCdxsfY4bXZ/hcO/XpYPHjiaZrFBcot40shvyPn9A5hPuYqOYVDzZHdEZC+m91JRhECwAzL+thCUoJ6Ibis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779970276; c=relaxed/simple;
	bh=tGIC/AyQACA+lR256/z7ZDVfaq5pMMadhUh5Wwxw6SE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZ00aQGuXWaaecmHWh77aDhRq9G5OWQ1hnrw6ZHdei+iqzVW/H+wF3Y7+n9igjvt1jNpevb33NSGn3yyHhqbuCyiVQDzFuft+BcBWqXZnfMGTxNnpHq1SYNj/DEeMAVbhjSG1G2HI1i8GtuCeKZsfCxdWLBtIa6WwycUVlZxxcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YEiQQ4K4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YEiQQ4K4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A795E1F000E9;
	Thu, 28 May 2026 12:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779970273;
	bh=bXnftk/OKOffma6hnrgGhxCRMA65PWP8cZj4tNQWqKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YEiQQ4K4iXk//kQRPbUqsgU2KxNTN9prTrOyc8q/D5jw0UA5yBuhwzY5hRo9PUCZi
	 X8roXwThGjczMuwGC/Ndiw2h2PD2W0h7Kkpc6GPHF7Luc6eygin1AIvfRRWLKg9X8v
	 +xoWr6Q35ZnrkgYrErLudsOp2YxI9syEnQFWEDYzwpr1/iiowuYGX+8BykRKHjsij6
	 Jv9wj0v0SqqHdUC44QfBqFbychXTHU1y+/cFkmIuuT2USmL/02rQjOdBrt5GYI6tJd
	 OrVP8/cc9jUua6mnE9kdqm9J+3X2REi6mf21GKgCUxj5O5gAnp63ILy47mP6GIOS6x
	 t4Dp6TQ+zNRAg==
Date: Thu, 28 May 2026 14:11:10 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: Artur Kowalski <arturkow2000@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] gpu: host1x: trace: fix string fields in host1x traces
Message-ID: <ahgw0zZhY_-RMwUA@orome>
References: <20260519-host1x-tracing-v1-1-55afb8cbd186@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4opbyer3wpfx6z6r"
Content-Disposition: inline
In-Reply-To: <20260519-host1x-tracing-v1-1-55afb8cbd186@gmail.com>


--4opbyer3wpfx6z6r
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] gpu: host1x: trace: fix string fields in host1x traces
MIME-Version: 1.0

On Tue, May 19, 2026 at 12:16:43PM +0200, Artur Kowalski wrote:
> Use __assign_str and __get_str as required by tracing subsystem. Fixes
> string fields being rejected by the verifier and unreadable from
> userspace.
>=20
> Tested on v6.18.21.
>=20
> Signed-off-by: Artur Kowalski <arturkow2000@gmail.com>
> ---
>  include/trace/events/host1x.h | 50 ++++++++++++++++++++++---------------=
------
>  1 file changed, 26 insertions(+), 24 deletions(-)

Applied, thanks.

Thierry

--4opbyer3wpfx6z6r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmoYMN4ACgkQ3SOs138+
s6GH1Q//QR5ThdWyD+g/p4MSrhw98bH62IOxAtpe0ifT/+xa/SVQYwSyyzxS7j+B
hZRwdPu7HBwZoiJAVFChO+13MSehk8XAyi/S2Z4detl7Vpqbsdls9KRHXFQF4hBk
t96Oljv5U9IYHKGBNYQ04WcYGdOHgZ7wAv+OPAZc9VaUJs+xdT9k1RqjCZmDwdlR
u4MBPgtcq6a7xUMHZjFkHKxyuFkDjmmEw0DB1m2xH8jpuAp+U29jq//3cMoHEi3H
VnFnLX6SOj3GEpjg4OqhqTDzDkC89tcGtTSkVRINiVsAPmKIoqCP7S9+YLpIaAEe
TOyNz8EZAXIz3+TofsBtVbNAM3ZmknWyxli8xmi4Mu/hK4DIlHubcWMJMwAyt9M6
GwQqVlM82wDjuqDGMJcQbVpLRSf6GeTLrMJXjVApPnEu0skEyq/9REEVxkZ5k5xj
acNr7mxo2H/2FIkUeFXvtGg2iV6NpA5djiP4oFlYikjJDY1pEn3ClwfGI5j8hNVb
A1dwbzS2C32uB9eDZVe+KkZo8ZHn1gq65FwOuFHHMC66ACXFS/j43FF83NO4aWeD
erkFNmMVDuBd2UcgazconHV4jENOI+guevPphNTmowi7X5qziuRlkyEKvse+Lod1
M7G7R4WsT4wY3ZBUfKoqax3u1qziTPD3cY+Q30J36gd538ZbXM4=
=+Jze
-----END PGP SIGNATURE-----

--4opbyer3wpfx6z6r--
