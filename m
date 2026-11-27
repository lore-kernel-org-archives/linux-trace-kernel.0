Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795791034;
	b=qb7lLkxdH0S0xpighfxf1RHkYbmsce/hVovoPYIY/gS5bkLTk3EETpQG0bVVnF6tHXXs
	 s6aGwAH2z8BjGi2HVBPQLfOImlhBWNzURfP/sfuzmwowV0ai+cLz2unxuVVR2zMirlOFa
	 +qLIL7hnbN5eDKRC6kKIUeyfLf9dB94j39VhniuD6QwMoS+mLqnP83cCBl7WJ+XtuWoV5
	 k61k7Wc1rY48J2KNNMDhFmCuZyO1DMfQ0Tpc0XA+9+WpX5Zv0qZ4ymEfV+X7ZF5fj3BzP
	 SsBnHwGrCBmoueSyBrIwVGMEwZW6zCKxeET4O1zEuVRdg++4KpDFdsMqik+TbOMI1Kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795791034;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gxq3wgw+barjPLXIWEn74CmRmFDc4UPXarLciG8c6xg=;
	b=YTH3FsaLMm36yeJS6fVmDUQJ89Z67d7D7sYhWlNrdFkw6JuFJ9rQZqt15/1VrS/pEOCM
	 Wzf3MHX+/a5d01f6vYPuaYrGQgQ9Yrwks8OMYRfJQgODua9HVCNW89VyEyBOTBLd2dn95
	 jViqrBTq1zJqkejgbhPHN280jac/FBncl1odimyIt4IMu12WoV/8bpxxWsPnB+Ucv6tRK
	 dmSpN3Istr0UO2taYJNJhpYqWo9vkS5KKSKy/v3BsTEmHbQTMR4R/5bCucsGM+wY74Q0Z
	 FDGbiKs3I2RkB/I0+8L+WrZTAhs9K4ZwhIePHD72GHWJYXKlEMnZF34hnSadSeN+iUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TED4nW9v;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1525606A31F;
	Fri, 27 Nov 2026 14:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TED4nW9v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A4701F0089B;
	Fri, 27 Nov 2026 14:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795791034;
	bh=gxq3wgw+barjPLXIWEn74CmRmFDc4UPXarLciG8c6xg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TED4nW9vOgPd2OvStCjk2PF00jhZuHuSUvhW879VmLpQmVpXIioWRCoVr0mcM7bcF
	 YVWMtdmXdTlHG28Y+rmPVHxmYB/Z7RG4cgdwOVBdBDLQWpCOhcy40ptKwEmR6UYxu0
	 OaN1zAL2D3arNsLBOpMKLZerpLUPtFATPJy0Oa81PNnhriQcPfDHY3WUV6WxDqGgUw
	 1bF+3AN85o5VC2LjPuU5R0GMsWhDEaXjoIpK2FCMlb9QaViA7MbchUSfHC9EK//uti
	 CLXLy+ainP5AkYjWmCJ9SiAwmhrd6lykH00Sk7jBtKp7xboCkF3EFUIy7eEdzPiWPC
	 lihqnxW6BL9Mw==
Message-ID: <sashiko-outbox-237610@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 18/35] spi: nxp-fspi: Consume dummy cycles
 directly
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
In-Reply-To: <20261127-macronix-upstreaming-spi-mem-cycles-v2-18-5c93f5e5d630@bootlin.com>
References: <20261127-macronix-upstreaming-spi-mem-cycles-v2-0-5c93f5e5d630@bootlin.com>
 <20261127-macronix-upstreaming-spi-mem-cycles-v2-18-5c93f5e5d630@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 14:50:31 +0000
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
- [High] spi: nxp-fspi: LUT_DUMMY_DDR operand halved in
  nxp_fspi_prepare_lut()
--

commit 1599225157c651da7c372805ec30cf72cfe8b69c
Author: Miquel Raynal <miquel.raynal@bootlin.com>

spi: nxp-fspi: Consume dummy cycles directly

This commit enables the dummy_cycles capability in the NXP FlexSPI driver
and replaces the dummy byte-to-cycle conversions with op->dummy.ncycles.

> diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
> index 66cb58f95fdb1..e6fdded67a00e 100644
> --- a/drivers/spi/spi-nxp-fspi.c
> +++ b/drivers/spi/spi-nxp-fspi.c
[ ... ]
> @@ -567,8 +567,7 @@ static bool nxp_fspi_supports_op(struct spi_mem *mem,
>  		return false;
> =20
>  	/* Max 64 dummy clock cycles supported */
> -	if (op->dummy.buswidth &&
> -	    (op->dummy.nbytes * 8 / op->dummy.buswidth > 64))
> +	if (op->dummy.ncycles > 64)
>  		return false;
> =20
>  	/* Max data length, check controller limits and alignment */
> @@ -652,16 +651,15 @@ static void nxp_fspi_prepare_lut(struct nxp_fspi *f,
>  		lutidx++;
>  	}
> =20
> -	/* dummy bytes, if needed */
> -	if (op->dummy.nbytes) {
> +	/* dummy cycles, if needed */
> +	if (op->dummy.ncycles) {
>  		lutval[lutidx / 2] |=3D LUT_DEF(lutidx, op->dummy.dtr ? LUT_DUMMY_DDR =
: LUT_DUMMY,
>  		/*
>  		 * Due to FlexSPI controller limitation number of PAD for dummy
>  		 * buswidth needs to be programmed as equal to data buswidth.
>  		 */
>  					      LUT_PAD(op->data.buswidth),
> -					      op->dummy.nbytes * 8 /
> -					      op->dummy.buswidth);
> +					      op->dummy.ncycles);
>  		lutidx++;
>  	}

[Severity: High]
Does passing op->dummy.ncycles directly to LUT_DUMMY_DDR halve the dummy
cycles programmed in DTR mode?

In DTR mode, FlexSPI runs the serial root clock at 2x the flash SCLK rate
and LUT_DUMMY_DDR counts DDR half-cycles (2 * ncycles).  Previously, DTR
callers doubled op->dummy.nbytes to account for two transfers per clock,
and op->dummy.nbytes * 8 / op->dummy.buswidth intentionally did not divide
by 2, yielding 2 * ncycles.  With .dummy_cycles set,
spi_mem_dummy_bytes_to_cycles() divides by 2 * op->dummy.buswidth when
op->dummy.dtr is true (and direct ncycles callers pass full SCLK cycles),
so nxp_fspi_prepare_lut() now programs half the required LUT_DUMMY_DDR
operand and breaks DTR flash reads.

For the same reason, the > 64 check in nxp_fspi_supports_op() no longer
accounts for the 2x factor when op->dummy.dtr is set.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127-macronix-u=
pstreaming-spi-mem-cycles-v2-0-5c93f5e5d630@bootlin.com?part=3D18
