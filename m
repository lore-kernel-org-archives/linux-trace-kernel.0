Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD763B894D;
	Mon, 23 Mar 2026 16:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774281822; cv=none; b=p4+42rhUHJS8HbHcpY9eiKj/LgrHd1IidPWLYbhjIwSkbqBwfs5DxzSC/FRIH0uiYqFJn9dXdcADG+cV9vISZj8QsOnwY5NINpvJSnktu/GlKVN9uos+WhASCJk0BDXWpLEhjLBJj2jwDEVtKSoxwgQTa7XZEXpaKqBhdgwbrDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774281822; c=relaxed/simple;
	bh=tfYgaSVsbuMU1gmb9kgnQ+Bw+1i7YuI6A1J5ry0oUuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gn2FdklKGimhYUfFXVM+FIxL0xh551ZW/BMpTPFClaKE3H8ROEve+o9cIm03HrhGi7xTH726Cmd9aPcHVkV4TUJhHkRubgLqpUZ/Bejby4cpqcP/e+VfZDaRaUVj3jYsfuYP6ch11M2h+nXVRQeSa9SEskTZ+ecQ8+usxkTEVtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vKwWPzoz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vKwWPzoz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 435C7C4CEF7;
	Mon, 23 Mar 2026 16:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774281822;
	bh=tfYgaSVsbuMU1gmb9kgnQ+Bw+1i7YuI6A1J5ry0oUuk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vKwWPzozkhT1klWx5Eb3sWTaHEXysVhsQmIeM4JHnn9Az08iMPHtGOSnRhndxQwsb
	 +o2bpFv8wjT+4OA5BEwzXpTbPKBazw5m1DHCZxVl7jfKNrDCLkmIu4IHIgS+m0WF0z
	 H6o3c7bKL+Pq6yLiH4ftaw/u6WESMl3CaSckAzt9qOzqgE5uS7bGyD0QYZW7bUL9ZH
	 ZpJQeOfCEKvgDL3O8qqhBZ1ElnWyaYp2EkGd0Ng33C1Lgbk+5VUAIFyLtzp02z4MEV
	 HiZ239Vu+E0rGOGT92PCCrEuYJSM0zr7CclEJsis9hgu6WSFB/SpIavUKAcsMkaMUq
	 eVh/CoosDLYaQ==
Date: Mon, 23 Mar 2026 16:03:37 +0000
From: Mark Brown <broonie@kernel.org>
To: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 13/19] spi: Use trace_call__##name() at guarded
 tracepoint call sites
Message-ID: <233c401b-e658-47e0-9ae2-b41521276a69@sirena.org.uk>
References: <20260323160052.17528-1-vineeth@bitbyteword.org>
 <20260323160052.17528-14-vineeth@bitbyteword.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YTLD6mE05S2eEcHn"
Content-Disposition: inline
In-Reply-To: <20260323160052.17528-14-vineeth@bitbyteword.org>
X-Cookie: Avoid gunfire in the bathroom tonight.


--YTLD6mE05S2eEcHn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 23, 2026 at 12:00:32PM -0400, Vineeth Pillai (Google) wrote:
> Replace trace_foo() with the new trace_call__foo() at sites already
> guarded by trace_foo_enabled(), avoiding a redundant
> static_branch_unlikely() re-evaluation inside the tracepoint.
> trace_call__foo() calls the tracepoint callbacks directly without
> utilizing the static branch again.

Acked-by: Mark Brown <broonie@kernel.org>

--YTLD6mE05S2eEcHn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnBZFgACgkQJNaLcl1U
h9D2MAf/XiwNHzHQ9gsY5CmvVqSvM6vmhpnqY7Pq9Iw3sd1qfGZSk1bTit6YsL0+
hhTxFHoc4DBTQRfNwtd8QsTcg42oa2JmNPRT3CyR+kKkYcKqvuCjOiHt33JVH6Ud
l8VKUwPnHn5VEyxgfCny3eZ9EcpWM8exYNNCQ4A7jnbQPHuE/aCTUaYywRJZM8rQ
8HPuaZIRiL3DTP+BsClQV4O1lqWIrwGNw0hf6fsXZPkc3jjmh8kQCSfiJay2A68g
nmqFIV0LNxTsnDYMEEeQ1y856fUTFHzCz+6AZVxvB+qytSLJdvpOULH0wbYI8Tmq
e4H2qhLiJhuxrJt0bNq1ffEBdHoqLg==
=a/t7
-----END PGP SIGNATURE-----

--YTLD6mE05S2eEcHn--
