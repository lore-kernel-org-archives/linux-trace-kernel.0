Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9FA13C68A;
	Thu, 23 May 2024 14:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716473635; cv=none; b=kAbxvXKtpTP8wH5liEfJQY10wL9ENg5fv8Gb6xsrQ8N1ZFp84R7ASj+O4NyMWZoM2NXgtvh6SCcN8UjIp40ANXylazjPEQsH15AY1bKVtqwLflVdjaCCfxXOkwsARu86csbLDDN3mBlnABZjxmsBgHCBnaHn2NGlhO8hLwKMh8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716473635; c=relaxed/simple;
	bh=wHmf0+7f1PdiR6STtU5I6IdOk8lZ3B3cslxc5ZQ4saA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FvsIzqGUZJNP5A1LapgeiReH5vl3PtByHfeRM9CaHGyA4Xit1gtBCD694Bpg4ggPkfzz+yjpTHNdvtGUXhAMvffLAtJi/cvtyPDT4soYbzVgZeHRJ10tdH9gFPg8KKRfDd9Mi8G2Vo3yifMX1kv6i0MeXUDeqCoxgO6b3ZA5PdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pG3FZUZc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pG3FZUZc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ADDFC32786;
	Thu, 23 May 2024 14:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716473634;
	bh=wHmf0+7f1PdiR6STtU5I6IdOk8lZ3B3cslxc5ZQ4saA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pG3FZUZcHCWWmWQj87cDsg9x+aCOqkZg0AY/fdChUJM8p14lzvEzizpRKuHjSb8v1
	 mr+V8Ar+hMyMvXJziq18S8UPfLVnpcIvZsWW5T2uP27KPi1k4NhK+fm21bFRgmpwvD
	 iKz3+ZbnSCTKVeisPwev02H1OBWy6vHmdlNXoxLIl+J1DkliIbkDmsFJZc8/ZFIBTr
	 AnnjzBUEoeE7dGoU2XYLpqbf35+nxElqLJKaNgpqgJcOJNivCrs03H5PQG0dpt3qJq
	 C7SS8H0HmRti2jEqD+pEBRyNA77lNi3BCtjTnSsHnD1HiI3y9UAyLNSt8J6chiHXne
	 cETsF6OVa7ZmQ==
Date: Thu, 23 May 2024 15:13:50 +0100
From: Conor Dooley <conor@kernel.org>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Andrea Parri <parri.andrea@gmail.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: Fix early ftrace nop patching
Message-ID: <20240523-showcase-helpful-4cc84fe2f1d5@spud>
References: <20240523115134.70380-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2HITYodwdCyzzdtT"
Content-Disposition: inline
In-Reply-To: <20240523115134.70380-1-alexghiti@rivosinc.com>


--2HITYodwdCyzzdtT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 01:51:34PM +0200, Alexandre Ghiti wrote:
> Commit c97bf629963e ("riscv: Fix text patching when IPI are used")
> converted ftrace_make_nop() to use patch_insn_write() which does not
> emit any icache flush relying entirely on __ftrace_modify_code() to do
> that.
>=20
> But we missed that ftrace_make_nop() was called very early directly when
> converting mcount calls into nops (actually on riscv it converts 2B nops
> emitted by the compiler into 4B nops).
>=20
> This caused crashes on multiple HW as reported by Conor and Bj=F6rn since
> the booting core could have half-patched instructions in its icache
> which would trigger an illegal instruction trap: fix this by emitting a
> local flush icache when early patching nops.
>=20
> Fixes: c97bf629963e ("riscv: Fix text patching when IPI are used")
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Reported-by: Conor Dooley <conor.dooley@microchip.com>
Tested-by: Conor Dooley <conor.dooley@microchip.com>

Thanks for the quick fix Alex :)

--2HITYodwdCyzzdtT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZk9PHQAKCRB4tDGHoIJi
0qjYAQCZbnkVecKQA29bgEC+XPR/AW8H6mGRAzkYf8O1XZA2AQEAoILUgAjaGIaK
gWxhQLnUJzhG8w4SK9oCaJ0aLEtWgAI=
=2ZE4
-----END PGP SIGNATURE-----

--2HITYodwdCyzzdtT--
