Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581C53C9ECF;
	Thu, 12 Mar 2026 15:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773329665; cv=none; b=kjN3lexTlCqehL9pRdlzqo8IZG3dJGS1pUCZHOwC+MdZavs7idsIFqz7RINXWyaK9LahZahSkuAeIYgwhibu19mS0N7ehB2A8ClEzp5qDz9hvAjqIN6YzYiHl5qxyxUA6chzhyuMWqHeB2iotcRhyTaspM3rydqRSZug0JWKCg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773329665; c=relaxed/simple;
	bh=XwbYrDZVkKHKimCJCC9l61umHnd4IinbH8x6pkOXTyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pqSU03/TBaADH9BbvAtJ2aKA419yXePYDnjdGt77rSTq01GYkPnZSwQeGZbglfCMs+HgggiAw7LxjjiNJusOFFeR0FtlUHzSNj3NdboNiHN5rvAl8TUcKPQYg9AmPCd3v1PT0jVZmDuPnSqeWpGvwFVEZyEtnXFUnvnN65rb1ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fcy9XaRC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fcy9XaRC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C27C4CEF7;
	Thu, 12 Mar 2026 15:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773329664;
	bh=XwbYrDZVkKHKimCJCC9l61umHnd4IinbH8x6pkOXTyM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fcy9XaRC7dpkoEL0QmleJNX/Sx1dyIjp5KU70wJLe5E0gy/pjxVV78Ot8xGdCFJcb
	 j35Em4Qzcebf69FwFKUntAldXVf1BA4q77xv/D6U0ZRAHDEBh/IlNsEjMDX5ZHXHw5
	 vjXhYCOq6XJ2iJf/uJPR73IMTih1JAWOVKs1X5Vmu4gND5PPDEkW123sGZE9YdDK6N
	 Lq1bHd6yBzLdO5cFRT+dYyUgQ+6aigx4F7p5/xL91VYX7O3ZV4HsJQ5HVV4OEKWQsr
	 IOQpVJ7rp0w/S688mE8qS1+6CzbddTaI3NNsXzknfZbFhAt2ZA8yClIjNx/S3/Tz1C
	 fWahnLPXU2WVA==
Date: Thu, 12 Mar 2026 15:34:20 +0000
From: Mark Brown <broonie@kernel.org>
To: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 13/15] spi: Use trace_invoke_##name() at guarded
 tracepoint call sites
Message-ID: <5d057b07-be5a-4da6-86e3-87ef4319d4b2@sirena.org.uk>
References: <20260312150523.2054552-1-vineeth@bitbyteword.org>
 <20260312150523.2054552-14-vineeth@bitbyteword.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3IffVxr2kKNJsVoV"
Content-Disposition: inline
In-Reply-To: <20260312150523.2054552-14-vineeth@bitbyteword.org>
X-Cookie: I feel better about world problems now!


--3IffVxr2kKNJsVoV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 12, 2026 at 11:05:08AM -0400, Vineeth Pillai (Google) wrote:
> Replace trace_foo() with the new trace_invoke_foo() at sites already
> guarded by trace_foo_enabled(), avoiding a redundant
> static_branch_unlikely() re-evaluation inside the tracepoint.
> trace_invoke_foo() calls the tracepoint callbacks directly without
> utilizing the static branch again.

Acked-by: Mark Brown <broonie@kernel.org>

though not loving the naming here, I'll have a hard time figuring out
what the weird call is about next time I look at that code

--3IffVxr2kKNJsVoV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmy3PsACgkQJNaLcl1U
h9CI4wf+KbEAS/EcFORfv+VqtUutx+YGQqsudJyFY5B0P207nda5IOmqZ0zESbhS
sImvE3Fl2BIWy/OG9WH29xOUvUlkNQcKdm5QmhZuyqQSLfCstUcSKImt4z7W8k2/
fvJfK+9urw7kMPcaSK27ZySfXWrNqHrbp7hJymC8lHcI5cqqQ1Nkhv265Fo8VQMy
+n5HkgE4tat52k/SZbmeJ7C3veRSp9ayIY1CGe6wutJMW68IcTOT+ByKkYBs+3F9
LYU+JwXZ757kyJ5JVlLuvStn2RZx8XRadjc2pl8QWnVHcczMv5Z8kC8GGDtwpvTF
19NYaSmPOWIxGz/8ut7+4AyjJzjK5g==
=Mozc
-----END PGP SIGNATURE-----

--3IffVxr2kKNJsVoV--
