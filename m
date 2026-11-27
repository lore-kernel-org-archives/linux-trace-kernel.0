Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795791534;
	b=iTCcZpjtmH+eGYVVaLAsa6sGxACxSH/KBuTb+RkD9suRwHNO9TdMcvro9j7TzcwGAA1l
	 A8eNB5cwH4Ak0EoxZQzmqKtE5KntEBX3vzGUogCLM/nrjihNLCqYAWnpyfE1rz5rnWFnC
	 RWiUAiaSZo/JUv3mvjB9cN0Kqkxon3uj1TzR5DMup+LjfGko8AgVaiCou6NFOMPRCyIfM
	 OXmDMwADTfkM/iAQpMcvmYKzseD0Mv1JYZFrE90DSbo9ODcBbWkF6ETx9Cs6XCU2fgYAC
	 EGM2Z+QqT1RS17BOuPmokuj74lQzOAwQOC4RYhXze6Kohejc9+yvUVv5OcJO+ud596w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795791534;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9EdxXWF0MoQta2ocUjikzENKESzXNTXPeM81HlznVmk=;
	b=Yg7riaAU0HYgaWBtCf8dfZKBIHbWOjQpFuqMdj857wyjESDw3vIu2GwPPQu29b0WMQgL
	 863V+RF39QOu909x1lz5Wbxeg/E2LkdP1C/fnVp6xI0HBFvKUjoEmCfH3C0QkVwEISlvt
	 aSbzhSQ9RfrIUwlsSvtp5OIZkXnUSk1SmtCciQE/zuLHDxw86bEbFxjpqYJ/lhsw34bYP
	 uGFTudHF4fmVL+huiOsapxZSAMLGjeajwr3Txvd+NhiQ4T7NqBOb9McCA9hdOfyzj5tQy
	 Kge9LtGAeqX9aTWM9QPBH9KNiO9EU4LvcrbZmw30AdDbwE/UzjserQM8Ow2TXhpGvEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bzD5rd0s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB35606A31E;
	Fri, 27 Nov 2026 14:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bzD5rd0s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39D9A1F00897;
	Fri, 27 Nov 2026 14:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795791534;
	bh=9EdxXWF0MoQta2ocUjikzENKESzXNTXPeM81HlznVmk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bzD5rd0s0Z04M6LYUY7OeLU2Arm74Odj6rXpmxsA0tQ5uvzfJbJqxeHU06nMJbm/r
	 CLkWXeqrqDZQlmjgfqnCNd9EU0noBkWRT9v+21PNsD/GBMm4m2LXMZmQm99QkEQOKJ
	 YkfZgNH0uhJXwYwlhYz2MxWEUumYNi/9iEaY6kOlTcek7JcfQD8EeFPy8YqV3MH7oI
	 G3Tw0s5VriahDWUQK/EA963+RvOQx2L67HhYbVmKtnEcQnQe1iP9gDwsp52z1yDSWY
	 1nV5KVzk8VgWiUtqccPHyvvFzfZfDv2JB6u1q0J+4cYf7CN6uQyrR98OwYyfHPaW+b
	 e+YwVYoGkcA6w==
Message-ID: <sashiko-outbox-237651@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 22/35] spi: nxp-xspi: Reject mixed DTR modes
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
In-Reply-To: <20261127-macronix-upstreaming-spi-mem-cycles-v2-22-5c93f5e5d630@bootlin.com>
References: <20261127-macronix-upstreaming-spi-mem-cycles-v2-0-5c93f5e5d630@bootlin.com>
 <20261127-macronix-upstreaming-spi-mem-cycles-v2-22-5c93f5e5d630@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 14:58:51 +0000
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
- [Medium] spi: nxp-xspi: inconsistent DTR detection in
  nxp_xspi_supports_op()
--

commit ce8d7a3ff5fbe9ec51a6d3a172d4b7891aaf62c1
Author: Miquel Raynal <miquel.raynal@bootlin.com>

spi: nxp-xspi: Reject mixed DTR modes

This commit updates nxp_xspi_supports_op() to reject SPI memory operations
that mix DTR and SDR phases.

> diff --git a/drivers/spi/spi-nxp-xspi.c b/drivers/spi/spi-nxp-xspi.c
> index ccd00c744d186..f2a847b5fd27d 100644
> --- a/drivers/spi/spi-nxp-xspi.c
> +++ b/drivers/spi/spi-nxp-xspi.c
> @@ -385,8 +385,18 @@ static bool nxp_xspi_supports_op(struct spi_mem *mem,
>  				 const struct spi_mem_op *op)
>  {
>  	struct nxp_xspi *xspi =3D spi_controller_get_devdata(mem->spi->controll=
er);
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
Does this DTR check match how nxp_xspi_select_mem() detects DTR operations
and how the dummy phase is validated?

In nxp_xspi_select_mem(), op_is_dtr requires dtr to be set on all four
phases unconditionally:

drivers/spi/spi-nxp-xspi.c:nxp_xspi_select_mem() {
    ...
	/* xspi only support one DTR mode: 8D-8D-8D */
	bool op_is_dtr =3D op->cmd.dtr && op->addr.dtr && op->dummy.dtr && op->dat=
a.dtr;
    ...
}

Standard Octal DTR templates that omit an address, dummy, or data phase
(such as SPINAND_PROG_LOAD_8D_8D_8D_OP or SPINAND_WR_EN_8D_0_0_OP) leave
dtr as false on the unused phase via SPI_MEM_OP_NO_DUMMY,
SPI_MEM_OP_NO_ADDR, or SPI_MEM_OP_NO_DATA.  Those operations pass
all_true here, and nxp_xspi_prepare_lut() emits DDR LUT instructions for
the active phases, but nxp_xspi_select_mem() evaluates op_is_dtr as false
and calls nxp_xspi_disable_ddr().

In addition, neither all_true nor all_false checks op->dummy.dtr when
op->dummy.ncycles > 0.  Because this driver sets dummy_cycles =3D true in
nxp_xspi_mem_caps, spi_mem_convert_dummy() clears op->dummy.nbytes to 0
before nxp_xspi_supports_op() and spi_mem_default_supports_op() run, so a
mismatched op->dummy.dtr is not caught by spi_mem_default_supports_op()
either.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127-macronix-u=
pstreaming-spi-mem-cycles-v2-0-5c93f5e5d630@bootlin.com?part=3D22
