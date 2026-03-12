Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2EF401A2D;
	Thu, 12 Mar 2026 20:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773345937; cv=none; b=qkryiYqpuWDj7lNcf9SCWEvfB9laLdVn3UBzPOUYM87nqgHUCKDTiYdfk4ceQ2ceh15SNl5VvTUjCCrogAWtU/+CO/H3YckcPWniL5r58ASQ0FP43OjRqJHQvqyuO7ve71JWe6VPqEb6dn+vsG61TjTC3Ob2IHBUHTZws5CnFtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773345937; c=relaxed/simple;
	bh=wnkRTWEnBAzzk2+VPy0CTM8BvRcwfTCdq5VfMNheyzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R59A0NA8ppybmp6ghjR9t3roHNj5I2y1WgcV7ZegCV9UFqKX/LwuXdCydX/jQ8TYaG+uFzUnxfHmAtpJdDsz1Vk85H47c0z2b0tJobNrnc8IG9kZVtH7Pb53zDnLSg3wi5e9aUz/OAf1Ztks9+F5tI8S5hjybyx3JZ5B0sTwzX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RklpB60U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RklpB60U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A262C4CEF7;
	Thu, 12 Mar 2026 20:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773345937;
	bh=wnkRTWEnBAzzk2+VPy0CTM8BvRcwfTCdq5VfMNheyzs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RklpB60U81FycY7QxevKmlKU/SlPLic7h8suueXh7WjaeyKIFAzg/vODCXmxCMkGh
	 aM0WTAH5aF5P8k2FpEK2PDXF8uIB5S9rV7Z2dcxMbuz4/+MZHyjXDLx0T17Jac2XKm
	 4NV7AbLXfKvWjWKZ2kMpxwS10CYycD+2e+VLNVRr2gC0LRQOcberzIyhwHB6aup18u
	 8o7iXSV6z/Itfc/jHStozC8YPrQhhRQFwd56l5zA5/1GGOmsyD7mpT1DJp2FFu+rvo
	 5U8h6H2OuuJjyxY6ux80GJsztcmZmzZ1SkdFZ0xM4aBuvUp3zbw7DVUfdgux7fTMlB
	 dIkx/AjJ68Tgg==
Date: Thu, 12 Mar 2026 20:05:32 +0000
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
Message-ID: <03705215-4036-4ca9-8ec5-b66c90043f7c@sirena.org.uk>
References: <20260312150523.2054552-1-vineeth@bitbyteword.org>
 <20260312150523.2054552-14-vineeth@bitbyteword.org>
 <5d057b07-be5a-4da6-86e3-87ef4319d4b2@sirena.org.uk>
 <20260312114254.6467c03d@gandalf.local.home>
 <06438818-2e3e-426f-aec5-ea6344e4b057@sirena.org.uk>
 <20260312130022.669e7de4@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6WuQWMgx1jjmEuSF"
Content-Disposition: inline
In-Reply-To: <20260312130022.669e7de4@gandalf.local.home>
X-Cookie: I feel better about world problems now!


--6WuQWMgx1jjmEuSF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 12, 2026 at 01:00:22PM -0400, Steven Rostedt wrote:
> Mark Brown <broonie@kernel.org> wrote:

> > Possibly an _unchecked or something?  Honestly the suggestion someone
> > had for _do seemed OK to me.  Part of it is that I wouldn't think of
> > tracepoints as being something that I'd call.

> The "__do_trace.." is an internal function I don't want to expose.

> I'm thinking of: call_trace_foo(), as that should be pretty obvious to what
> it is.

Yeah, like I day it was the concept of there being a call in a
tracepoint that was a bit of a surprise.  It was more a grumble than
anything else, I did ack the change.

--6WuQWMgx1jjmEuSF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmzHIwACgkQJNaLcl1U
h9BtyAf/c4ahysqs6LKWYZXWrL01Npo7WhCpl8GSshInmVbYwmxdGCJ7Ukr3OymH
heRyM+ACIGpbdUCsFn9MP5qSc3jTUmcJMk1EHLPVXj4i2J3yZ3NIKXxXo2TiKMd3
e/UXkQda1xeE3IYt7twpcg4hIVoVrdhpKzrTpBd4CXjrscrXOgKQAgVGHiKYBfcS
bb8kGucX3i+WgxlPs9TQ6grLgDCyNFxJ+temowOPkh/PrYPCIWS6nO8wV7iJWKe5
OehzXWHrcfjn0HQnJb+RUJbSgrdj0zXktocm/wkMpKoA7iNOba1CLbOzriLmtm8D
yPx6k5hSneIO5p9gZWgZcwcO/nLUXg==
=Z7CW
-----END PGP SIGNATURE-----

--6WuQWMgx1jjmEuSF--
