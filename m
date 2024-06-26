Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807631E87C;
	Wed, 26 Jun 2024 12:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719406765; cv=none; b=ZfKbXqfByR1BPLckqzGqcjoQfQz88PJF490P0iEtClTWFurpyxuIHwxj1YxsjczV2m6Uqdu2sTAwgws6+sS2JJkEH95ZUnvUkXfqVdFKg60XWENNdAOhZcwdg+/VFr9EGamDPsMfWNE3pdsbMW/ZRoxooz34L46WJB41KkBT7Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719406765; c=relaxed/simple;
	bh=9TrlOyltmZ/QX4Ys9Bg7ZXIQUZ0PLaKMhQFyJgcNcTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kxlpvVeiDIYVnQEAvAFhb3v4BMC3lQmpOBa4kbGvbtPIy4bhz5KnJf3aoY4cRZp6a2qMIh6L7Sk0z5mDoAoaTE8ZicY0pM5SKOXQh44i2lwXbb58lEWSN6nTk2zzItnRaD4mRCttGtpjDNEyo/Wyx62qex4UjV2btEGiHOAX0Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vcn3/n4H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vcn3/n4H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB7DC2BD10;
	Wed, 26 Jun 2024 12:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719406765;
	bh=9TrlOyltmZ/QX4Ys9Bg7ZXIQUZ0PLaKMhQFyJgcNcTo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vcn3/n4HyNJrzHq67QHZQ57mfSDQ9/5xlPXsLqLL/JbJEkVTOMWM6FMCE/9swgyaw
	 t26oBubZBy2xvQ2x49nwiOJXd3h4B/aSu929r8w2ryOz5ptVk7k1yq7SxOr3TGktuA
	 c1GKOQpcPZ69tq4muyjIa0PqKLxqxVZf9S0hfsTVBaqgyNiU3AR9O1FCY7vPrtqiBx
	 LzlyLe5KGFZWRsYoZOY4lxbt3q3VvneIx20mM3nK026K/S53QSQoX0X7CStbs3LjvO
	 OFoMPyFmgEuwsM3NHJXw2wi0I0Nv19+1kQnazttixLmJEaCTiJiGXTDQO+zp1sQjSr
	 QoxA0GHHNdz9w==
Date: Wed, 26 Jun 2024 13:59:20 +0100
From: Conor Dooley <conor@kernel.org>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Andy Chiu <andy.chiu@sifive.com>,
	Puranjay Mohan <puranjay12@gmail.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH -fixes] riscv: patch: Flush the icache right after
 patching to avoid illegal insns
Message-ID: <20240626-astrology-fructose-275fb799ebce@spud>
References: <20240624082141.153871-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="n6A0djetNF9SaJ8G"
Content-Disposition: inline
In-Reply-To: <20240624082141.153871-1-alexghiti@rivosinc.com>


--n6A0djetNF9SaJ8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 10:21:41AM +0200, Alexandre Ghiti wrote:
> We cannot delay the icache flush after patching some functions as we may
> have patched a function that will get called before the icache flush.
>=20
> The only way to completely avoid such scenario is by flushing the icache
> as soon as we patch a function. This will probably be costly as we don't
> batch the icache maintenance anymore.
>=20
> Fixes: 6ca445d8af0e ("riscv: Fix early ftrace nop patching")
> Reported-by: Conor Dooley <conor.dooley@microchip.com>
> Closes: https://lore.kernel.org/linux-riscv/20240613-lubricant-breath-061=
192a9489a@wendy/
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>

So, I can't even test this right now :/ The issue is annoying enough to
reproduce that same config + compiler + commit isn't enough.

--n6A0djetNF9SaJ8G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnwQqAAKCRB4tDGHoIJi
0iSqAP486M4V8TRvY4pTcu95fzUWRuzRV0oH+MPkmoNcTZXfzAD/XOaCqK/Aynb0
LKzQVLCv7/qhMQgD7WB2oSCZZV1YFgA=
=z8Xv
-----END PGP SIGNATURE-----

--n6A0djetNF9SaJ8G--
