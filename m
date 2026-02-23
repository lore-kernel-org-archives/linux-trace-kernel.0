Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF2C1D61BC;
	Mon, 23 Feb 2026 15:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771860497; cv=none; b=jmZzsRJTxmmA3skPjzr95DYD40ZFPHUxldKgHSDDc/zuethHDl4VBilqcjx3eKnWGQr+EVYFbruaKbUuwaQERaN2VmZxVH/QvP8LzZxwXkL+9ajp6a51HhfKTydpVYB8oIm1wGWdUkRwh2wZiM77zzddgHoP/WbS1qB7Pq7uwbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771860497; c=relaxed/simple;
	bh=SGk+H4006zmMAlGLukg7Ze2tiNB+iOK4R4Mit7+56iA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pbzpQS+Cm1dWQkWvZCW6NpFXQt20UIf07VWmVzkfhPtGQdKjwc1qul5BHiSrFQ2YI/cNPpgQmlZXxZEN8FFPvjVN1wRKsinF6m9TBvL+pxtXV76PZb4JTBie1tmGoWiZChI+BGJEqt8ttE3SSb3zjeuKJ7/hpr917TLjAPLrHLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=JyHusBBJ; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="JyHusBBJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1771860496; x=1803396496;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SGk+H4006zmMAlGLukg7Ze2tiNB+iOK4R4Mit7+56iA=;
  b=JyHusBBJkla4sAehiGNyVLLUFFMSXGUs2uYQV+/D5gXYUPPo3sl/SkXP
   cogISClD2wbMMQzEZxk+sXEkbniDdhpEqPsDbf8E6KSpk/hDUtvhW+Ztt
   gicGwjVcVGI4qjmnFRUr7pQ4qyvKm7DfI8DXZOj4YgVHFLH/srSO+4GoB
   uNXmesTtoE+pZ8ZMtJFkmiXTesHrdL/N2d661H9vfvngxa20BeA1uiaKq
   AtoKEhdfQIUChnDJtobCOBH48Cu5arV7ZQIAgIINoojTqY7u8WB/l9R1K
   scmLEK5F/uDm2PRVpmXVrh1dUBhQjqjq+xhnL7KLfkE2Nm5Pjy8AwNl1y
   A==;
X-CSE-ConnectionGUID: bzMGrKsuTG+NBUg/lZ3EpA==
X-CSE-MsgGUID: 5B74SaMqRq2mAvJBLiyEWw==
X-IronPort-AV: E=Sophos;i="6.21,306,1763449200"; 
   d="asc'?scan'208";a="221005511"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 08:28:14 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Mon, 23 Feb 2026 08:27:34 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58 via Frontend
 Transport; Mon, 23 Feb 2026 08:27:29 -0700
Date: Mon, 23 Feb 2026 15:27:12 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Puranjay Mohan <puranjay12@gmail.com>
CC: Conor Dooley <conor@kernel.org>, Andy Chiu <andybnac@gmail.com>,
	<linux-riscv@lists.infradead.org>, <alexghiti@rivosinc.com>,
	<palmer@dabbelt.com>, =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	<linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	Alexandre Ghiti <alex@ghiti.fr>, Mark Rutland <mark.rutland@arm.com>,
	<paul.walmsley@sifive.com>, <greentime.hu@sifive.com>, <nick.hu@sifive.com>,
	<nylon.chen@sifive.com>, <eric.lin@sifive.com>, <vicent.chen@sifive.com>,
	<zong.li@sifive.com>, <yongxuan.wang@sifive.com>,
	<samuel.holland@sifive.com>, <olivia.chu@sifive.com>, <c2232430@gmail.com>,
	<arnd@arndb.de>, Sami Tolvanen <samitolvanen@google.com>, Kees Cook
	<kees@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
	<llvm@lists.linux.dev>, <pjw@kernel.org>
Subject: Re: [PATCH v4 10/12] riscv: Implement
 HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS
Message-ID: <20260223-respect-chaste-60c3403b5bc9@wendy>
References: <20250407180838.42877-1-andybnac@gmail.com>
 <20250407180838.42877-10-andybnac@gmail.com>
 <20260221-repeal-emphatic-ddc2e9b94208@spud>
 <CANk7y0iTjHUBK66xx50b-eT=ssz9g0moFjOhCmipQC1SzkGs5g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="k/9IywnAJZZAgTS4"
Content-Disposition: inline
In-Reply-To: <CANk7y0iTjHUBK66xx50b-eT=ssz9g0moFjOhCmipQC1SzkGs5g@mail.gmail.com>

--k/9IywnAJZZAgTS4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 03:18:17PM +0000, Puranjay Mohan wrote:
> On Sat, Feb 21, 2026 at 12:15=E2=80=AFPM Conor Dooley <conor@kernel.org> =
wrote:
> >
> > Hey,
> >
> > On Tue, Apr 08, 2025 at 02:08:34AM +0800, Andy Chiu wrote:
> > > From: Puranjay Mohan <puranjay12@gmail.com>
> > >
> > > This patch enables support for DYNAMIC_FTRACE_WITH_CALL_OPS on RISC-V.
> > > This allows each ftrace callsite to provide an ftrace_ops to the comm=
on
> > > ftrace trampoline, allowing each callsite to invoke distinct tracer
> > > functions without the need to fall back to list processing or to
> > > allocate custom trampolines for each callsite. This significantly spe=
eds
> > > up cases where multiple distinct trace functions are used and callsit=
es
> > > are mostly traced by a single tracer.
> > >
> > > The idea and most of the implementation is taken from the ARM64's
> > > implementation of the same feature. The idea is to place a pointer to
> > > the ftrace_ops as a literal at a fixed offset from the function entry
> > > point, which can be recovered by the common ftrace trampoline.
> > >
> > > We use -fpatchable-function-entry to reserve 8 bytes above the functi=
on
> > > entry by emitting 2 4 byte or 4 2 byte  nops depending on the presenc=
e of
> > > CONFIG_RISCV_ISA_C. These 8 bytes are patched at runtime with a point=
er
> > > to the associated ftrace_ops for that callsite. Functions are aligned=
 to
> > > 8 bytes to make sure that the accesses to this literal are atomic.
> > >
> > > This approach allows for directly invoking ftrace_ops::func even for
> > > ftrace_ops which are dynamically-allocated (or part of a module),
> > > without going via ftrace_ops_list_func.
> > >
> > > We've benchamrked this with the ftrace_ops sample module on Spacemit =
K1
> > > Jupiter:
> > >
> > > Without this patch:
> > >
> > > baseline (Linux rivos 6.14.0-09584-g7d06015d936c #3 SMP Sat Mar 29
> > > +-----------------------+-----------------+--------------------------=
--+
> > > |  Number of tracers    | Total time (ns) | Per-call average time    =
  |
> > > |-----------------------+-----------------+--------------------------=
--|
> > > | Relevant | Irrelevant |    100000 calls | Total (ns) | Overhead (ns=
) |
> > > |----------+------------+-----------------+------------+-------------=
--|
> > > |        0 |          0 |        1357958 |          13 |             =
- |
> > > |        0 |          1 |        1302375 |          13 |             =
- |
> > > |        0 |          2 |        1302375 |          13 |             =
- |
> > > |        0 |         10 |        1379084 |          13 |             =
- |
> > > |        0 |        100 |        1302458 |          13 |             =
- |
> > > |        0 |        200 |        1302333 |          13 |             =
- |
> > > |----------+------------+-----------------+------------+-------------=
--|
> > > |        1 |          0 |       13677833 |         136 |           12=
3 |
> > > |        1 |          1 |       18500916 |         185 |           17=
2 |
> > > |        1 |          2 |       22856459 |         228 |           21=
5 |
> > > |        1 |         10 |       58824709 |         588 |           57=
5 |
> > > |        1 |        100 |      505141584 |        5051 |          503=
8 |
> > > |        1 |        200 |     1580473126 |       15804 |         1579=
1 |
> > > |----------+------------+-----------------+------------+-------------=
--|
> > > |        1 |          0 |       13561000 |         135 |           12=
2 |
> > > |        2 |          0 |       19707292 |         197 |           18=
4 |
> > > |       10 |          0 |       67774750 |         677 |           66=
4 |
> > > |      100 |          0 |      714123125 |        7141 |          712=
8 |
> > > |      200 |          0 |     1918065668 |       19180 |         1916=
7 |
> > > +----------+------------+-----------------+------------+-------------=
--+
> > >
> > > Note: per-call overhead is estimated relative to the baseline case wi=
th
> > > 0 relevant tracers and 0 irrelevant tracers.
> > >
> > > With this patch:
> > >
> > > v4-rc4 (Linux rivos 6.14.0-09598-gd75747611c93 #4 SMP Sat Mar 29
> > > +-----------------------+-----------------+--------------------------=
--+
> > > |  Number of tracers    | Total time (ns) | Per-call average time    =
  |
> > > |-----------------------+-----------------+--------------------------=
--|
> > > | Relevant | Irrelevant |    100000 calls | Total (ns) | Overhead (ns=
) |
> > > |----------+------------+-----------------+------------+-------------=
--|
> > > |        0 |          0 |         1459917 |         14 |             =
- |
> > > |        0 |          1 |         1408000 |         14 |             =
- |
> > > |        0 |          2 |         1383792 |         13 |             =
- |
> > > |        0 |         10 |         1430709 |         14 |             =
- |
> > > |        0 |        100 |         1383791 |         13 |             =
- |
> > > |        0 |        200 |         1383750 |         13 |             =
- |
> > > |----------+------------+-----------------+------------+-------------=
--|
> > > |        1 |          0 |         5238041 |         52 |            3=
8 |
> > > |        1 |          1 |         5228542 |         52 |            3=
8 |
> > > |        1 |          2 |         5325917 |         53 |            4=
0 |
> > > |        1 |         10 |         5299667 |         52 |            3=
8 |
> > > |        1 |        100 |         5245250 |         52 |            3=
9 |
> > > |        1 |        200 |         5238459 |         52 |            3=
9 |
> > > |----------+------------+-----------------+------------+-------------=
--|
> > > |        1 |          0 |         5239083 |         52 |            3=
8 |
> > > |        2 |          0 |        19449417 |        194 |           18=
1 |
> > > |       10 |          0 |        67718584 |        677 |           66=
3 |
> > > |      100 |          0 |       709840708 |       7098 |          708=
5 |
> > > |      200 |          0 |      2203580626 |      22035 |         2202=
2 |
> > > +----------+------------+-----------------+------------+-------------=
--+
> > >
> > > Note: per-call overhead is estimated relative to the baseline case wi=
th
> > > 0 relevant tracers and 0 irrelevant tracers.
> > >
> > > As can be seen from the above:
> > >
> > >  a) Whenever there is a single relevant tracer function associated wi=
th a
> > >     tracee, the overhead of invoking the tracer is constant, and does=
 not
> > >     scale with the number of tracers which are *not* associated with =
that
> > >     tracee.
> > >
> > >  b) The overhead for a single relevant tracer has dropped to ~1/3 of =
the
> > >     overhead prior to this series (from 122ns to 38ns). This is large=
ly
> > >     due to permitting calls to dynamically-allocated ftrace_ops witho=
ut
> > >     going through ftrace_ops_list_func.
> > >
> > > Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> > >
> > > [update kconfig, asm, refactor]
> > >
> > > Signed-off-by: Andy Chiu <andybnac@gmail.com>
> > > Tested-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> >
> > I bisected a boot failure to this commit [c217157bcd1df ("riscv:
> > Implement HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS")] yesterday, that appears
> > to be affecting all LLVM versions that I currently have installed. From
> > some initial testing of Kconfig options, it looks like the issue is
> > CFI_CLANG related because when I disable CFI_CLANG things work once
> > more. Since this option depends on !CFI_CLANG, but is def_bool y, I
> > modified Kconfig to force disable it at all times and tested
> > !DYNAMIC_FTRACE_WITH_CALL_OPS && !CFG_CLANG, which did boot.
> >
> > I dunno anything about what's going on in this patch, but so little in
> > it relates to having DYNAMIC_FTRACE_WITH_CALL_OPS, that I was able to
> > figure out that the problem is -fpatchable-function-entry=3D8,4
> >
>=20
> DYNAMIC_FTRACE_WITH_CALL_OPS can't work together with CFI_CLANG.
>=20
> arm64 has:
>=20
> select HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS \
> if (DYNAMIC_FTRACE_WITH_ARGS && !CFI && \
>    (CC_IS_CLANG || !CC_OPTIMIZE_FOR_SIZE))
>=20
> would need something similar for riscv if not already done.


I think you've misunderstood my email. We already have:

	select HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS if (DYNAMIC_FTRACE_WITH_ARGS && !=
CFI)

The problem is that the patch broke using CFI_CLANG, due to the
fpatchable-function-entry change.

Cheers,
Conor.

--k/9IywnAJZZAgTS4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaZxx0AAKCRB4tDGHoIJi
0hZ2AQCJsgz7wd2DUBlnm9B9PddWNSIe/63gugstmYQrfXtUAgD9GwPez1Kci42H
5tpyUgCsNyzu820HBicCyULaebhQbgU=
=1stI
-----END PGP SIGNATURE-----

--k/9IywnAJZZAgTS4--
