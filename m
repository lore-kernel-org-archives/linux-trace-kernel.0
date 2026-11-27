Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795790486;
	b=kM8iAZxX3tv2EVVoo02E0oA1++YiC3IYp47HIwR7nqcUVfzViQOYYRA74L7VOZkjC7E2
	 YWKEMMU5QY1+JZlUZvWgmJMwOUEJyQESwZbHdErhZjZlavR0ba2Rk7Z++SXAgh1yO4zy7
	 mzK+H3XoHSkJtQTVukbXRX3xKBBbCxtTFysvQ4goApbsHcJFNOrwfK9QRzHnHiLffxOQ1
	 Yo44dKrbVRHhnncLx3PUCQ9cygvEY43y/XgQeYhMd2INVoYBC+du0a9Pn7JJzLWHVEdNY
	 6+aECR+UaVy623CRwBb4El9RFPvNnKTOV8TLuqLysIk39ADRy7YvNh4rhYMfky9NChA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795790486;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=iBwxQmXSjGr3/gqu7AvvP0Rjc+5sGJ4XbMUAtx8two0=;
	b=aqPTRDZhCwd9pUxazHTZigd2PL40Nw5KXZOEamXEmyVfGQDojo+8BjLcBhBnNEjd7u4A
	 P/8Osigqwwq70C62l3fqP35J+L0L7RxhY4siOBijFZs+kVrJPB+VyEu9VM9I7EdqGT72Q
	 0BSYmquFqdsAArp5funIbs/lNbKD+lNJeXV4Kgk3uY6UUBNUm3edWRufKyLMrDxIpliCd
	 TCKTZcNAravjBueMt3v7pjoxsKfTWg6PI2xqL0XBnLyDvfgMikJ22h1LIWEzn9QL657KZ
	 0tNW5rCLHI6RvZQA7X3Kzo9zRU6jGWzJQVFLCGwPSmwk8xJKEJ8MS1N9lJZexX2Kg2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MtDzQRjv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92623606A332;
	Fri, 27 Nov 2026 14:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MtDzQRjv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 660511F00899;
	Fri, 27 Nov 2026 14:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795790486;
	bh=iBwxQmXSjGr3/gqu7AvvP0Rjc+5sGJ4XbMUAtx8two0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MtDzQRjvYMv9X8QxM4QadsuI11MwnUZF4aJ0/DDKm0vfbvGgov0uacS12aKidW1Gl
	 Iqx7qmx0Wikyei+Fbgiez9j5oWxSuWU++QPGUtfRF6+sNM9oBqsxZr3JikxMqthPzX
	 hybDZB/ZO8uN0qg4IwN9oAO6yucW0v96Vwky1f+mkvuX7oh70Ize39GNvzh2oG7C0a
	 vtw40CM5eV0Xxe2ShXdXZgsFySHqnxs9OBAv4hYnr/L4T541VLWaLbI5TPUwlIYQV/
	 xROM4jr+AoOosGGunpM4aCN6g0l6TaaOuJ+/rIKVO/Erx27uJyxgDIjqPq3SMvsd+l
	 dimkPC12q986A==
Message-ID: <sashiko-outbox-237584@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 10/35] spi: atmel-quadspi: Consume dummy cycles
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
In-Reply-To: <20261127-macronix-upstreaming-spi-mem-cycles-v2-10-5c93f5e5d630@bootlin.com>
References: <20261127-macronix-upstreaming-spi-mem-cycles-v2-0-5c93f5e5d630@bootlin.com>
 <20261127-macronix-upstreaming-spi-mem-cycles-v2-10-5c93f5e5d630@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 14:41:23 +0000
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
- [Medium] spi: atmel-quadspi: incomplete dummy cycle check in
  atmel_qspi_supports_op()
--

commit 07ba105643bc7f3f3737d56084ca2bed8b3821f6
Author: Miquel Raynal <miquel.raynal@bootlin.com>

spi: atmel-quadspi: Consume dummy cycles directly

This commit advertises the dummy_cycles spi-mem capability and switches
the driver from converting op->dummy.nbytes to consuming
op->dummy.ncycles directly.

> diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
> index 0b695b0b3c98f..abca99b32b619 100644
> --- a/drivers/spi/atmel-quadspi.c
> +++ b/drivers/spi/atmel-quadspi.c
> @@ -502,7 +502,7 @@ static bool atmel_qspi_supports_op(struct spi_mem *me=
m,
> =20
>  	/* special case not supported by hardware */
>  	if (op->addr.nbytes =3D=3D 2 && op->cmd.buswidth !=3D op->addr.buswidth=
 &&
> -	    op->dummy.nbytes =3D=3D 0)
> +	    !op->dummy.ncycles)
>  		return false;
> =20
>  	return true;

[Severity: Medium]
Should this check reject op->dummy.ncycles < 8 / op->addr.buswidth
instead of !op->dummy.ncycles?

For 2-byte addresses in atmel_qspi_set_cfg(), shifting the address into
the first dummy byte requires at least 8 / op->addr.buswidth dummy
cycles:

drivers/spi/atmel-quadspi.c:atmel_qspi_set_cfg() {
	...
		case 2:
			if (dummy_cycles < 8 / op->addr.buswidth) {
				ifr &=3D ~QSPI_IFR_INSTEN;
				ifr |=3D QSPI_IFR_ADDREN;
				iar =3D (op->cmd.opcode << 16) |
					(op->addr.val & 0xffff);
			} else {
				ifr |=3D QSPI_IFR_ADDREN;
				iar =3D (op->addr.val << 8) & 0xffffff;
				dummy_cycles -=3D 8 / op->addr.buswidth;
			}
			break;
	...
}

When op->cmd.buswidth !=3D op->addr.buswidth and op->dummy.ncycles is
non-zero but less than 8 / op->addr.buswidth (for example, 2 dummy
cycles in 1-2-2 mode), atmel_qspi_supports_op() now accepts the
operation, causing atmel_qspi_set_cfg() to pack op->cmd.opcode into iar
and transmit the opcode on op->addr.buswidth lines instead of
op->cmd.buswidth lines.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127-macronix-u=
pstreaming-spi-mem-cycles-v2-0-5c93f5e5d630@bootlin.com?part=3D10
