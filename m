Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B40838D690;
	Thu, 12 Mar 2026 16:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773334445; cv=none; b=szpi/XD+zef2mmKPIilGeB/Vf4eTZumB0RnLv64LZapuL6Z9BdJZc3oLJRRQ643C8e42I0/Dt/XMJjVb06ObTW6rzIiSWHz8XG9yoHF/eW5h0GdP3fEcCo4nUA0yaBAVjWbQgbeKazR4+wN6YdxOBGxMF0JJ7p3Hf/RpPe/fzK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773334445; c=relaxed/simple;
	bh=kQIwU0xGOMg0VyvdqXQPa+t6rrBcO2v4iR9O/5na1Jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jH4lMxto9qXgXz5r1jANlI8mmB8ZVVU7FVwPmWQmozPgSpZS8Py+TsX2cuWJgvHUonFZrVuaUyQ8nVM1/CQ/LYkJjLX55ou1HaS6Wi8MHQAjdw2owQk5ihD1RyVMhHmoVHvx54UDej2vCDWcXxVfwa1OpdaeN77Ix4KwgSDBIkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qQHEQG8f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qQHEQG8f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5735AC4CEF7;
	Thu, 12 Mar 2026 16:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773334445;
	bh=kQIwU0xGOMg0VyvdqXQPa+t6rrBcO2v4iR9O/5na1Jc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qQHEQG8fu/7FiG+qTv9g/Bg5AKFFnFgYIawaAUHfGlY67YyxJOJXzl7ByzIp8BNs1
	 MZg2g+bv3NCxeO3P7hb5f8BjYK4vhW54LFIG5Jb9Wc0IIw+/AGIhSVhrXhtsAVS2Z7
	 5rRcl0ng99wsrmeVHMIsAmzj93URvL3Ni/nKjkxaFSrlXCXPVT4uIfmawWa2D21okb
	 9s1NXxP5aFyTnBk+fVgknOy9gvtCxeig3erhE30+ve3VogSjzVAWCCXfghUHDGFSqN
	 UezcWr+AeGC8BryFSIBBOxeEqSY11+92DBx0KdsrDoGminltftk8yeezn6WgitnobY
	 E98EZoXd0BI4g==
Date: Thu, 12 Mar 2026 16:54:00 +0000
From: Mark Brown <broonie@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 13/15] spi: Use trace_invoke_##name() at guarded
 tracepoint call sites
Message-ID: <06438818-2e3e-426f-aec5-ea6344e4b057@sirena.org.uk>
References: <20260312150523.2054552-1-vineeth@bitbyteword.org>
 <20260312150523.2054552-14-vineeth@bitbyteword.org>
 <5d057b07-be5a-4da6-86e3-87ef4319d4b2@sirena.org.uk>
 <20260312114254.6467c03d@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wM0qBj2BElCyqJPv"
Content-Disposition: inline
In-Reply-To: <20260312114254.6467c03d@gandalf.local.home>
X-Cookie: I feel better about world problems now!


--wM0qBj2BElCyqJPv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 12, 2026 at 11:42:54AM -0400, Steven Rostedt wrote:
> Mark Brown <broonie@kernel.org> wrote:

> > though not loving the naming here, I'll have a hard time figuring out
> > what the weird call is about next time I look at that code

> Would:

> 	trace_call__foo()

> Be better?

> Or do you have another name we should use?

Possibly an _unchecked or something?  Honestly the suggestion someone
had for _do seemed OK to me.  Part of it is that I wouldn't think of
tracepoints as being something that I'd call.

--wM0qBj2BElCyqJPv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmy76cACgkQJNaLcl1U
h9DP9wf/bK6/IDwtMQblrcTIfF70GfHZ9wpy3+AJRCH98VbSYgIG08mrTuG5WZjG
7WZ6XMedgcGux8cU1L1aX38BuljaO513iBa6fT4GObUmBT21VtgDEGFfZ/Nj3OuI
sUZN7dacugzMKvd0NgMbHcbLIVjXKWUFaMUg2ATexn/oYiukM3Scq+D71/DnpoNQ
FYPHvtNjNeUyUOcCGZILmsuhqsi6JLDf7wOVihbR7nKI9aIoSYdadSMQy6+CK/3Y
KO5KwqpnyKDyXQEbT4xTJ8S0qLaEvVW1zt+rQ7NBfLnqsPGhhuLwKPojI7UiKJlh
uCsT7ixclUu36z3qRPSvMxgDQKxxmw==
=++4k
-----END PGP SIGNATURE-----

--wM0qBj2BElCyqJPv--
