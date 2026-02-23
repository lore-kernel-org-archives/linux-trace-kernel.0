Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C5A333733;
	Mon, 23 Feb 2026 17:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771868525; cv=none; b=A+KH2nFCGPY1W8IaR2ycBrfT3Whdy62DwYII8Ki0SidBTAPo7ENdumLoPlvs+vhsjoXos+1z4TIMT7MH0rhoEAC8laZr/oe7EseSeoLArgeY8EKlUQNpyWo/kKpUjUzy1zUPk0/8lCvu2n77CQQ/ObGVPAlpWW8IqqlugzVQLx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771868525; c=relaxed/simple;
	bh=e59depEMM95HBTJ5jekap2dk5SJzCAO4MePwFF8/XK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZCi2pU/6O9ZfYfIl8TWMmqg6q9WQe9aWwF+Ge46rlR0Pko6zNYmuZe5DghICIKVjkFL+9PmoZgPeOsFn8cVUbq2d81BQXptCm4Ike2DagN35d8XxF23fmab2Kn7cCTA4k7IOsi6rKpydIQLLs1BtXZUCoCICTD6WFeiXLcBlcbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cRUlMZ3o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cRUlMZ3o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A27C9C116C6;
	Mon, 23 Feb 2026 17:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771868524;
	bh=e59depEMM95HBTJ5jekap2dk5SJzCAO4MePwFF8/XK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cRUlMZ3oLcN9NeB4lLM3Lk6rsJit8P3ciXiSEScPPJiuvmdhmMo2jpfEbVQqn/zvc
	 Yn5ZaSFOP617Ihn5xbJNuj5l7aHksqcWsAgrI2Bm5rKMCOk8X33d+y5FJ+0jmD2XwU
	 8ZGkxa83fnMMltVZoaR0tn0OdNCkYyPu45DY6tt8qWnnZcgwYHWzAnLohyqV35iOvI
	 JZXsiVdwRAvp2fgkFXaYzfL6iIFPBWy8A/hH/9Kg/jRRuaYJfCTneR2YJwduEO3bdO
	 yHuRZ1PoUPmw7rJJIGB1WwsdeiA6i1TdMTHozTCxaKnGg7vR0IqSwi1qh8k55s8m7X
	 pi7Sw1fbFc7/w==
Date: Mon, 23 Feb 2026 17:41:57 +0000
From: Conor Dooley <conor@kernel.org>
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Andy Chiu <andybnac@gmail.com>, linux-riscv@lists.infradead.org,
	alexghiti@rivosinc.com, palmer@dabbelt.com,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Alexandre Ghiti <alex@ghiti.fr>,
	Mark Rutland <mark.rutland@arm.com>, paul.walmsley@sifive.com,
	greentime.hu@sifive.com, nick.hu@sifive.com, nylon.chen@sifive.com,
	eric.lin@sifive.com, vicent.chen@sifive.com, zong.li@sifive.com,
	yongxuan.wang@sifive.com, samuel.holland@sifive.com,
	olivia.chu@sifive.com, c2232430@gmail.com, arnd@arndb.de,
	Sami Tolvanen <samitolvanen@google.com>,
	Kees Cook <kees@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
	llvm@lists.linux.dev, pjw@kernel.org
Subject: Re: [PATCH v4 10/12] riscv: Implement
 HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS
Message-ID: <20260223-dropout-knickers-766174170935@spud>
References: <20250407180838.42877-1-andybnac@gmail.com>
 <20250407180838.42877-10-andybnac@gmail.com>
 <20260221-repeal-emphatic-ddc2e9b94208@spud>
 <CANk7y0iTjHUBK66xx50b-eT=ssz9g0moFjOhCmipQC1SzkGs5g@mail.gmail.com>
 <20260223-respect-chaste-60c3403b5bc9@wendy>
 <CANk7y0jdzCeFaLVpj6-mnWiSZvv+rJF=9kgWDYF7g_rjCpiYsw@mail.gmail.com>
 <20260223-garlic-sulphuric-0c1574608d09@spud>
 <CANk7y0iokvWz==XQ67v3aztQ268WVmud22Y4gp-dPd4SrFhzMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bp3ZjyzaI6V6BAFV"
Content-Disposition: inline
In-Reply-To: <CANk7y0iokvWz==XQ67v3aztQ268WVmud22Y4gp-dPd4SrFhzMQ@mail.gmail.com>


--bp3ZjyzaI6V6BAFV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 05:36:24PM +0000, Puranjay Mohan wrote:
> > Ye, this is what Nathan and I both did locally, give or take. I just
> > wasn't sure if this was actually correct to do or if it was just
> > papering over an issue with our CFI support. Do you want to send this as
> > a patch?
>=20
> Yes, I will send a patch with fixes tag.


Great, thanks! Add a cc: stable too, while you're at it ;)

--bp3ZjyzaI6V6BAFV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaZyRZQAKCRB4tDGHoIJi
0hOMAQCYpiOeeKK/vZJG30655INe2kwTlJzDJsYxaTNFOLcmZAD9EImTaZbUYiXU
fE06svL0UqDXSj8d6ry6fEcp69G+1As=
=5z9m
-----END PGP SIGNATURE-----

--bp3ZjyzaI6V6BAFV--
