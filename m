Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061BE1E51EE;
	Thu,  9 Oct 2025 16:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760028804; cv=none; b=liKDnvqzvKCkeP1XIosbGtTbKjZ5lEDLef7smBQBcqibzCknKmfYzvT229F3My9M8vbRyhHwFmZdX9lC7d6BiVM8V7UkmOOwicrFH0PWd5Q+fBcNR4SO/KO7HlZcX7L9YpMgVm8eMcwbaRUqNHaIsRIIvIO6/S7nf31JE7IalRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760028804; c=relaxed/simple;
	bh=s3EeI5Z56afA2rXL7zIjK2ku2OOzEBiB/kUemFUGtIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RrTaVznqPlXlVf0iJxqzV9tvcerUpQDEfomTUL1+/L+PC/hdsp2Nhq8UmYEL2ICFBYV7O8cjpdV25VAeVvVLUQmsFwmlpb1WfoQDWxSw0w4Pbdzcs3g1YsT2Fg82r2ZMQIhxSK3llWtZamAYZxb8rpAt8aogvApdpR8cz/xIgEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eoF+m5hs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eoF+m5hs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 246BDC4CEE7;
	Thu,  9 Oct 2025 16:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760028802;
	bh=s3EeI5Z56afA2rXL7zIjK2ku2OOzEBiB/kUemFUGtIY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eoF+m5hsCRlnJ3mziERlyxeSUZkpA+Uq3/wyy0nW6KS76Qfb+DLrB7hQ4iX52qBHG
	 7tXtaxX24wHY/VwV9QKXc/FiB2EJAmz5u+VKW8IEu1dmCUNunglycXeDQVoaBd7VdY
	 dJzXhEOr48fU7PwHGyMy45putihKE4EoaFAvtrOVJ7FYK/LOCIiXQ6QvJFljBV3dXC
	 5lDb8tQRlWcItlQ+g9QOd+oI6bns4qp+WL2GQJP4+tUFU7s2GY/gsFpJdwkjJ4dKg3
	 bRNiLY4RVfWd+P6Ud/EfIwhG4WBQO0oJk5VxwnQC113R7E1j57jp6id5eK7q0kVWcT
	 FJMxRKP14E4TQ==
Date: Thu, 9 Oct 2025 17:53:14 +0100
From: Conor Dooley <conor@kernel.org>
To: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, rostedt@goodmis.org, mhiramat@kernel.org,
	mark.rutland@arm.com, peterz@infradead.org, jpoimboe@kernel.org,
	jbaron@akamai.com, ardb@kernel.org, willy@infradead.org,
	guoren@kernel.org, ziy@nvidia.com, akpm@linux-foundation.org,
	bjorn@rivosinc.com, ajones@ventanamicro.com, parri.andrea@gmail.com,
	cleger@rivosinc.com, yongxuan.wang@sifive.com, inochiama@gmail.com,
	samuel.holland@sifive.com, charlie@rivosinc.com,
	conor.dooley@microchip.com, yikming2222@gmail.com,
	andybnac@gmail.com, yury.norov@gmail.com,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] riscv: add support for Ziccid
Message-ID: <20251009-secluded-writing-adefb1f71a72@spud>
References: <20251009134514.8549-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nor471u/BfNy6yoJ"
Content-Disposition: inline
In-Reply-To: <20251009134514.8549-1-cuiyunhui@bytedance.com>


--nor471u/BfNy6yoJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 09, 2025 at 09:45:14PM +0800, Yunhui Cui wrote:
> The Ziccid extension provides hardware synchronization between
> Dcache and Icache. With this hardware support, there's no longer
> a need to trigger remote hart execution of fence.i via IPI.
>=20
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>

Actual correctness aside, in an RFC should you really state why this is
an RFC and not just a v1 patch. You're missing a dt-binding change
that's required for new extensions, that you'll need for v2.

> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> index 67b59699357da..2da82aa2dbf0a 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -540,6 +540,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] =3D {
>  	__RISCV_ISA_EXT_DATA(svnapot, RISCV_ISA_EXT_SVNAPOT),
>  	__RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
>  	__RISCV_ISA_EXT_DATA(svvptc, RISCV_ISA_EXT_SVVPTC),
> +	__RISCV_ISA_EXT_DATA(ziccid, RISCV_ISA_EXT_ZICCID),
>  };

The comment about this structure reads:
/*
 * The canonical order of ISA extension names in the ISA string is defined =
in
 * chapter 27 of the unprivileged specification.
 *
 * Ordinarily, for in-kernel data structures, this order is unimportant but
 * isa_ext_arr defines the order of the ISA string in /proc/cpuinfo.
 *
 * The specification uses vague wording, such as should, when it comes to
 * ordering, so for our purposes the following rules apply:
 *
 * 1. All multi-letter extensions must be separated from other extensions b=
y an
 *    underscore.
 *
 * 2. Additional standard extensions (starting with 'Z') must be sorted aft=
er
 *    single-letter extensions and before any higher-privileged extensions.
 *
 * 3. The first letter following the 'Z' conventionally indicates the most
 *    closely related alphabetical extension category, IMAFDQLCBKJTPVH.
 *    If multiple 'Z' extensions are named, they must be ordered first by
 *    category, then alphabetically within a category.
 *
 * 3. Standard supervisor-level extensions (starting with 'S') must be list=
ed
 *    after standard unprivileged extensions.  If multiple supervisor-level
 *    extensions are listed, they must be ordered alphabetically.
 *
 * 4. Standard machine-level extensions (starting with 'Zxm') must be listed
 *    after any lower-privileged, standard extensions.  If multiple
 *    machine-level extensions are listed, they must be ordered
 *    alphabetically.
 *
 * 5. Non-standard extensions (starting with 'X') must be listed after all
 *    standard extensions. If multiple non-standard extensions are listed, =
they
 *    must be ordered alphabetically.
 *
 * An example string following the order is:
 *    rv64imadc_zifoo_zigoo_zafoo_sbar_scar_zxmbaz_xqux_xrux
 *
 * New entries to this struct should follow the ordering rules described ab=
ove.
 */

Cheers,
Conor.

--nor471u/BfNy6yoJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaOfoegAKCRB4tDGHoIJi
0hdSAP4mmjzLQiGeP2lXFFu31PWRRLqRQHE8ipZDJS96deFWTQD+PwyH70gg9y03
slIpEN0aUuJ9z2FpvqNH5MXCJurtAgE=
=tcgM
-----END PGP SIGNATURE-----

--nor471u/BfNy6yoJ--
