Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795791649;
	b=JES70IaXfupOcLL4c4GBwKQZgtYb66om3Vlizd3fPktlmSPPn5PkWef6SOCcMKdZ8/S/
	 hJmdYk4wsa3jA165UYUyEFplOPm3G2i9WtexeJHilyqm+UUpYhryqPbql2EsBe5bZwXdh
	 qzYFTTKrph7NUFE7R2Qm4wXDUq3nHGK8kU1VSGOWHxDWcoXcFjnFaNGoQXlpXCKEtILkV
	 KU/vN3XYlGZ66DsFICs64gRvIVwd0wyN9nf0ZUaXZnimw1Ofeh6aiXwrE5fjvwnSXmnpC
	 rxBBWRDoG76gKwNo+Yl+ihpp/HER+woECzRdnVczWWwqZUfR04x54kDm0A8Lz+cW83g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795791649;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=eLcbyujfUpUezFzf+dyuSUdvtd7PBrhQqklGwJTYvrU=;
	b=IRPj3VDDvGl7ulybuOMR+pHIEqFO1zeKpoNsBYQv3pSFPO+gO/4wGPDMhuzFCwSE8Usg
	 1PjAEJT/qa/aQVPkJAA93R1akRoEK0vInBfoX3wvkTI8epXxvuiSXoWM74G84XZi1gSyV
	 SKAfE7W/528EVlK/5zHrFeek7FO6ctvsw0fpK9esPnYGSPup0I528MaOspomtIPYwpVFl
	 bqnbXjtswnSnFOVsNJfGnW0PzDDkYbGpYLZ8IWaIAVegY/hitm7cHaiW64RRd1x0NfqN2
	 3dDeTz+inegVoDwp93INz1nrsLFVHut62bgkrl1bh8OBKLRhhhBIkRMGKQoIfpleIYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ilC/3IeW";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DEA606A31E;
	Fri, 27 Nov 2026 15:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ilC/3IeW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C0051F00893;
	Fri, 27 Nov 2026 15:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795791648;
	bh=eLcbyujfUpUezFzf+dyuSUdvtd7PBrhQqklGwJTYvrU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ilC/3IeW/OwB3WPoHlf9D6FzDd5BY8aQuQ5HEIWB9Zpomygj8Y8u8aVnq8wDqESVd
	 iPhX9IPRqNWIMFfhEC1TNMH2CGHL5f411aolSajFEptnZU1y622XETeDe1CPwXvGRN
	 0wAncTOlryTyaCCcggFLawODTmIu8ehc1BwZYdU+f7nm+lrJRtksEqRsGKOf9qHIbI
	 9qQwj8uj3FnYrVJVcKOMLZNTvaDr99QOce93z5AnGW4yNnrIfhrB7/FzNjiBg0MVAX
	 IWcpinXAYpJs5fTBo39DyaqEx/3oyeTt7Lhqqvf2aOXAgqcQ4lInNzXakVmnlYUsqT
	 F02xFjf9TG9FQ==
Message-ID: <sashiko-outbox-237658@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 19/35] spi: nxp-fspi: Reject mixed DTR modes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Miquel Raynal" <miquel.raynal@bootlin.com>, "Mark Brown" <broonie@kernel.org>, "Liang
 Yang" <liang.yang@amlogic.com>, "Feng Chen" <feng.chen@amlogic.com>, "Xianwei
 Zhao" <xianwei.zhao@amlogic.com>, "Han Xu" <han.xu@nxp.com>, "Conor Dooley" <conor.dooley@microchip.com>, "Valentina
 Fernandez" <valentina.fernandezalanis@microchip.com>, "Daire McNamara" <daire.mcnamara@microchip.com>, "Haibo
 Chen" <haibo.chen@nxp.com>, "Jyan Chou" <jyanchou@realtek.com>, "Yu-Chun
 Lin" <eleanor.lin@realtek.com>, "Maxime Coquelin" <mcoquelin.stm32@gmail.com>, "Alexandre
 Torgue" <alexandre.torgue@foss.st.com>, "Pratyush Yadav" <pratyush@kernel.org>, "Michael
 Walle" <mwalle@kernel.org>, "Takahiro Kuwano" <takahiro.kuwano@infineon.com>, "Richard
 Weinberger" <richard@nod.at>, "Vignesh Raghavendra" <vigneshr@ti.com>, "Tudor
 Ambarus" <tudor.ambarus@linaro.org>, "Steven Rostedt" <rostedt@goodmis.org>, "Masami
 Hiramatsu" <mhiramat@kernel.org>, "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>, "Nicolas
 Ferre" <nicolas.ferre@microchip.com>, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, "Claudiu
 Beznea" <claudiu.beznea@tuxon.dev>, "Matthias Brugger" <matthias.bgg@gmail.com>, "AngeloGioacchino
 Del Regno" <angelogioacchino.delregno@collabora.com>, "Yogesh Gaur" <yogeshgaur.83@gmail.com>, "Chris
 Packham" <chris.packham@alliedtelesis.co.nz>, =?utf-8?b?Sm9uYXRoYW4gTmV1?=
 =?utf-8?b?c2Now6RmZXI=?= <j.neuschaefer@gmx.net>, "Michal Simek" <michal.simek@amd.com>
Cc: "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Alvin Zhou" <alvinzhou@mxic.com.tw>, "Cheng
 Ming Lin" <chengminglin@mxic.com.tw>, linux-amlogic@lists.infradead.org, imx@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com, linux-mtd@lists.infradead.org, linux-trace-kernel@vger.kernel.org, Frank.Li@kernel.org, neil.armstrong@linaro.org
In-Reply-To: <20261127-macronix-upstreaming-spi-mem-cycles-v2-19-5c93f5e5d630@bootlin.com>
References: <20261127-macronix-upstreaming-spi-mem-cycles-v2-0-5c93f5e5d630@bootlin.com>
 <20261127-macronix-upstreaming-spi-mem-cycles-v2-19-5c93f5e5d630@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 15:00:45 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] spi: nxp-fspi: missing dummy.dtr check in
  nxp_fspi_supports_op()
--

commit d17e73cd13692fc9ae92cbd1176efe56ea596829
Author: Miquel Raynal <miquel.raynal@bootlin.com>

spi: nxp-fspi: Reject mixed DTR modes

This commit adds checks in nxp_fspi_supports_op() to reject spi-mem
operations that mix SDR and DTR phases.

> diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
> index e6fdded67a00e..04999369dd1bd 100644
> --- a/drivers/spi/spi-nxp-fspi.c
> +++ b/drivers/spi/spi-nxp-fspi.c
> @@ -536,8 +536,18 @@ static bool nxp_fspi_supports_op(struct spi_mem *mem,
>  				 const struct spi_mem_op *op)
>  {
>  	struct nxp_fspi *f =3D spi_controller_get_devdata(mem->spi->controller);
> +	bool all_true, all_false;
>  	int ret;
> =20
> +	all_true =3D op->cmd.dtr &&
> +		   (!op->addr.nbytes || op->addr.dtr) &&
> +		   (!op->data.nbytes || op->data.dtr);
> +
> +	all_false =3D !op->cmd.dtr && !op->addr.dtr && !op->data.dtr;
> +
> +	if (!all_true && !all_false)
> +		return false;

[Severity: Medium]
Should all_true and all_false also check op->dummy.dtr when
op->dummy.ncycles is non-zero?

Because nxp_fspi_mem_caps sets dummy_cycles =3D true,
spi_mem_convert_dummy() converts op->dummy.nbytes to op->dummy.ncycles and
clears op->dummy.nbytes before nxp_fspi_supports_op() and
spi_mem_default_supports_op() run.  Since spi_mem_default_supports_op()
only checks op->dummy.nbytes, an operation whose dummy phase has a
different DTR setting from the command, address, and data phases passes
validation.

Unlike other drivers that ignore op->dummy.dtr once dummy bytes are
converted to cycles, this driver still uses op->dummy.dtr to program the
LUT and to select the controller DTR mode and clock rate:

drivers/spi/spi-nxp-fspi.c:nxp_fspi_prepare_lut() {
    ...
	if (op->dummy.ncycles) {
		lutval[lutidx / 2] |=3D LUT_DEF(lutidx, op->dummy.dtr ? LUT_DUMMY_DDR : L=
UT_DUMMY,
    ...
}

drivers/spi/spi-nxp-fspi.c:nxp_fspi_select_mem() {
    ...
	/* flexspi only support one DTR mode: 8D-8D-8D */
	bool op_is_dtr =3D op->cmd.dtr && op->addr.dtr && op->dummy.dtr && op->dat=
a.dtr;
    ...
}

Also note that all_true permits empty addr or data phases to have .dtr
set to false, whereas op_is_dtr in nxp_fspi_select_mem() requires all four
.dtr fields to be true unconditionally.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127-macronix-u=
pstreaming-spi-mem-cycles-v2-0-5c93f5e5d630@bootlin.com?part=3D19
