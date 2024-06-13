Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E5913C8FF;
	Thu, 13 Jun 2024 07:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718264958; cv=none; b=Q2AbHutii92cnpcd/NtH/vzdiNmPYzjMq9iyxbTpXV9yUH2VNqbg3DGKCC/FnsvT8oyeNTJUJ82ejRSPakmE7iVXuxCWWXd39P14WVTFdRNPQ2lJhXjGq1lR69Z88jrxZUzJr9uaFJYsFoknTHXtAue0UYzecN9JF2DlcngpqnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718264958; c=relaxed/simple;
	bh=tOsnQVOFTDPDAjyXqM6o5BX1/ALySEuh1yBpE5U5t04=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=POrwzKFW3kXvLAy2vACT5dviI84CkJPtVgCsDAxTPqjL1tTk4LW526zQo9jz9A8B8iMeLYL4QLW4Fdtrz2J44oC1Pc9X/R/LpF0K0nW8R64mVNXGoIJMTOfPnD3RVTLX8XCPSaNGCV+73iUD+trdLjT3W2uOPdN6JEZ83g7V/QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=HMvLdNuo; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="HMvLdNuo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1718264955; x=1749800955;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tOsnQVOFTDPDAjyXqM6o5BX1/ALySEuh1yBpE5U5t04=;
  b=HMvLdNuoCW8QchGY2gQAkxqeLGY+6ijhiwXQECNNzQ9dNSYAPU6ZI+2B
   tsuWMRPLjwamHRPaWi1C73VEhpuYAJFSdL5PLMk9Uj+Ap+WnmAPLE0C2B
   CdlC6Xd4IYdnIO7u5v6rgXOnuLgT3hVs6dyPltUYu18kC4YPcocFZfxh2
   pe2wm2SRGIi4NXPrQQcBDxwlhO+UmkbrCMLTpSJbo5dimubNJgR6M8d+h
   k3eCjlvuMmXcoeK3jst2qROa0TjIfRWnLHTmvUWvwylb8EUvLlLhCUmZT
   RUd+8Hu1/hADsZ8wJdlM4NsfTlWdoM3ICnjVuKqZ20aqtg4SSzn2bqqSa
   g==;
X-CSE-ConnectionGUID: HD7DQktUQset5I4Uvw9H8Q==
X-CSE-MsgGUID: EH4vLWffT2uZaRrw4Ct1EA==
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="asc'?scan'208";a="29819693"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Jun 2024 00:49:13 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 13 Jun 2024 00:48:53 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Thu, 13 Jun 2024 00:48:51 -0700
Date: Thu, 13 Jun 2024 08:48:34 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
CC: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
	<palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Steven Rostedt
	<rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>, Andrea Parri <parri.andrea@gmail.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH] riscv: Fix early ftrace nop patching
Message-ID: <20240613-lubricant-breath-061192a9489a@wendy>
References: <20240523115134.70380-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ucH24q+vfrE+sERa"
Content-Disposition: inline
In-Reply-To: <20240523115134.70380-1-alexghiti@rivosinc.com>

--ucH24q+vfrE+sERa
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
> ---
>  arch/riscv/include/asm/cacheflush.h | 6 ++++++
>  arch/riscv/kernel/ftrace.c          | 3 +++
>  2 files changed, 9 insertions(+)
>=20
> diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm=
/cacheflush.h
> index dd8d07146116..ce79c558a4c8 100644
> --- a/arch/riscv/include/asm/cacheflush.h
> +++ b/arch/riscv/include/asm/cacheflush.h
> @@ -13,6 +13,12 @@ static inline void local_flush_icache_all(void)
>  	asm volatile ("fence.i" ::: "memory");
>  }
> =20
> +static inline void local_flush_icache_range(unsigned long start,
> +					    unsigned long end)
> +{
> +	local_flush_icache_all();
> +}
> +
>  #define PG_dcache_clean PG_arch_1
> =20
>  static inline void flush_dcache_folio(struct folio *folio)
> diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
> index 4f4987a6d83d..32e7c401dfb4 100644
> --- a/arch/riscv/kernel/ftrace.c
> +++ b/arch/riscv/kernel/ftrace.c
> @@ -120,6 +120,9 @@ int ftrace_init_nop(struct module *mod, struct dyn_ft=
race *rec)
>  	out =3D ftrace_make_nop(mod, rec, MCOUNT_ADDR);
>  	mutex_unlock(&text_mutex);

So, turns out that this patch is not sufficient. I've seen some more
crashes, seemingly due to initialising nops on this mutex_unlock().
Palmer suggested moving the if (!mod) ... into the lock, which fixed
the problem for me.

> =20
> +	if (!mod)
> +		local_flush_icache_range(rec->ip, rec->ip + MCOUNT_INSN_SIZE);
> +
>  	return out;
>  }
> =20
> --=20
> 2.39.2
>=20

--ucH24q+vfrE+sERa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmqkUQAKCRB4tDGHoIJi
0m3VAQDMZOg52eVsvZthKmdZBM/Y3SXPrObGxlcvKyFsEVooWQD8C8VClKYq1GTX
I/KHs08ahGuI+30Vfq/MEeFlrbU1AgU=
=hljr
-----END PGP SIGNATURE-----

--ucH24q+vfrE+sERa--
