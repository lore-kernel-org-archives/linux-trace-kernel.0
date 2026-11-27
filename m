Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795790586;
	b=WhhmBJIMnOgnNGjA0/JdeR6cjfKULFlEGx7LzxAwXJ+ZDhwb1sVsIIX1XgjtsrLcZMh+
	 Fh010sHrMhUJ8LLZ6qcKu+gxSt7RkzIgMCFLHerFhkNfVfXhPZhWY4FZZYorl2dA7a/4b
	 XSusWf24I2xpLtMZEyISB++syyH/Gh2vwwI0QOidFvIwb4jwatG1B5X/OOjcr7lZc6+CS
	 jaWxRq4VzpUhYRuS3ifT4miw/lkkL5IhtVizlTYzCc2AJYkp3EEYboOPUC7x1y5zSjbq8
	 qItA/W2KR001ZT0cIhaeBQIBSJFBm6cyMn8Ikv+r9cAsiUilFJESpg0PYsCRNaan2cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795790586;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=oWWqZ5Ga7+BMiSg1Mh0sLjfADGHTNfzDFkajJz6BULc=;
	b=wBh9M5yapogcsdC2pPFG9Q9oqUS5rv+U0LC1+gZAFYBWKIzdbc5KmwALTQGwttZ44RfL
	 YZTrb3got3vW2HFFXH57zDMWcM5vPWrMEHlKeJjZvhrZycSA2DnCMnkcBiPYKJ8xM8VVj
	 tDpEjGw6w3DDqdaeNYnHwvUdWvD3d75RYTyAcrqpCpG9MTP12zmetcN8319g1adTnN5A5
	 +CSbvW35CFPnsdCAEYdNpuR6Z1V0CjHgixZeBQvMlJNAWa/t33aRMekVSbvWI0lgqFPG4
	 8ij6VC7bgNPU8kJwRADWzepSQx52QS6XztBPregh1whi57kZR/ggormez7zvcbrfHlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FBrTFKIH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BB8606A31C;
	Fri, 27 Nov 2026 14:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FBrTFKIH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE34F1F000C1;
	Fri, 27 Nov 2026 14:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795790585;
	bh=oWWqZ5Ga7+BMiSg1Mh0sLjfADGHTNfzDFkajJz6BULc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FBrTFKIHvYqjGOEJLKQZ0OLNVFYSah/uA5luM2GA5RC4lVw/7Iaq1Ku63HwmYIEmI
	 WKLk/bHV6VPCTA7/uGCwTRTnDOKv+rtuwro/VRTrG7fcw5MNRN1wO2b8gT8xGM8Dxk
	 X9Th/SEF4GsQPESx0W3JmjVRPqlhUBHq/10Rs/8Bdy2W1qoLT3J41GeTtGYcmUHyqe
	 F0IErYNpbOmzEsXXO+VQMVbIZ+Bsr5f3n7F04U+76BvrxKpQ/0gWNxjpIyYlgTjD55
	 A3dCWp3fRg/bg1KoFMsQR3ox4q7hZtlAhubPNK3lqMfKhA9WedjWSqAVMiTEoP6+Y4
	 OsychnkcX6jsg==
Message-ID: <sashiko-outbox-237589@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 06/35] spi: spi-mem: Add support for dummy cycles
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
In-Reply-To: <20261127-macronix-upstreaming-spi-mem-cycles-v2-6-5c93f5e5d630@bootlin.com>
References: <20261127-macronix-upstreaming-spi-mem-cycles-v2-0-5c93f5e5d630@bootlin.com>
 <20261127-macronix-upstreaming-spi-mem-cycles-v2-6-5c93f5e5d630@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 14:43:03 +0000
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
- [Medium] spi: spi-mem: missing dummy.ncycles checks in
  spi_mem_default_supports_op()
--

commit 5399654721195bff49303bc619a04db290c22c52
Author: Miquel Raynal <miquel.raynal@bootlin.com>

spi: spi-mem: Add support for dummy cycles

This commit adds a dummy.ncycles field to struct spi_mem_op and a
dummy_cycles capability to struct spi_controller_mem_caps, converting
between dummy bytes and dummy clock cycles depending on controller
capabilities.

Link: https://lore.kernel.org/all/20220911174551.653599-1-sergiu.moga@micro=
chip.com/
Link: https://lore.kernel.org/all/20250115134158.19908-1-pratyush@kernel.or=
g/

> diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
> index a1f129c476984..1642388b70048 100644
> --- a/drivers/spi/spi-mem.c
> +++ b/drivers/spi/spi-mem.c

[ ... ]

> +/*
> + * Controllers either program the dummy phase in clock cycles or in whole
> + * bytes. Convert the representation used by the operation to the one the
> + * controller expects.
> + *
> + * Return: 0 if the operation is lossless, -EOPNOTSUPP otherwise.
> + */
> +static int spi_mem_convert_dummy(struct spi_mem *mem, struct spi_mem_op =
*op)
> +{
> +	struct spi_controller *ctlr =3D mem->spi->controller;
> +	int n;
> +
> +	if (op->dummy.ncycles) {
> +		if (spi_mem_controller_is_capable(ctlr, dummy_cycles))
> +			return 0;
> +
> +		n =3D spi_mem_dummy_cycles_to_bytes(op);
> +		if (n < 0)
> +			return n;
> +
> +		op->dummy.nbytes =3D n;
> +		op->dummy.ncycles =3D 0;
> +	} else if (op->dummy.nbytes) {
> +		if (!spi_mem_controller_is_capable(ctlr, dummy_cycles))
> +			return 0;
> +
> +		n =3D spi_mem_dummy_bytes_to_cycles(op);
> +		if (n < 0)
> +			return n;
> +
> +		op->dummy.ncycles =3D n;
> +		op->dummy.nbytes =3D 0;
> +
> +		return 0;
> +	}
> +
> +	return 0;
> +}

[ ... ]

> @@ -321,6 +448,9 @@ bool spi_mem_supports_op(struct spi_mem *mem, const s=
truct spi_mem_op *op)
>  	if (spi_mem_check_op(&eval_op))
>  		return false;
> =20
> +	if (spi_mem_convert_dummy(mem, &eval_op))
> +		return false;
> +
>  	return spi_mem_internal_supports_op(mem, &eval_op);
>  }
>  EXPORT_SYMBOL_GPL(spi_mem_supports_op);

[Severity: Medium]
Should spi_mem_default_supports_op() also check op->dummy.ncycles in its
dummy-phase DTR and buswidth checks?

When a controller advertises dummy_cycles, spi_mem_convert_dummy() leaves
the dummy duration in op->dummy.ncycles with op->dummy.nbytes set to 0
before spi_mem_supports_op() and spi_mem_exec_op() call
spi_mem_internal_supports_op().  Because spi_mem_default_supports_op() only
tests op->dummy.nbytes:

drivers/spi/spi-mem.c:spi_mem_default_supports_op() {
	...
	/* xS-xS-xD-xS is not allowed */
	if (op->dummy.nbytes && op->dummy.dtr) {
		if (op->data.nbytes && !op->data.dtr)
			return false;
	}

	/* Bus width can only grow across phases, ie. 1-4-1, or 1-8-4 are not allo=
wed */
	if ((op->addr.nbytes && op->addr.buswidth < op->cmd.buswidth) ||
	    (op->dummy.nbytes && op->dummy.buswidth < op->cmd.buswidth) ||
	    (op->data.nbytes && op->data.buswidth < op->cmd.buswidth) ||
	    (op->addr.nbytes && op->dummy.nbytes && op->dummy.buswidth < op->addr.=
buswidth) ||
	    (op->addr.nbytes && op->data.nbytes && op->data.buswidth < op->addr.bu=
swidth) ||
	    (op->dummy.nbytes && op->data.nbytes && op->data.buswidth < op->dummy.=
buswidth))
		return false;
	...
}

those checks are skipped whenever op->dummy.ncycles is used, allowing
operations with invalid DTR transitions or decreasing buswidth across the
dummy phase to pass spi_mem_supports_op() and reach controller execution.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127-macronix-u=
pstreaming-spi-mem-cycles-v2-0-5c93f5e5d630@bootlin.com?part=3D6
