Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795790876;
	b=yeW8C20zayc7/wEtBpjR86ULsmY6RAZ6Ou0z2mj05tSrYIlylcwvBudz/vSgVmjMywuQ
	 ae7OvVcwSbwZf3b/Me054IvCVzySMQ/uoLH6e64FL+PhP8NUlub+EavgcLB99dZDS42sc
	 7UUVkRtWD9kIyydMbraYMRM2pF9m3vFlcw1u6ppWBMEEp9SxIwKVIVuJhvqmeLZfWgY7I
	 VAf65OuQGAiQ+REJIZFhf3sFosxN2i5DZPzkxcSMHRI1J7fn8BnmjLrWHO3E/WzjQkmm4
	 h55IeV/VgzAeeBfcQXjZ2BefT5Hv5M2NVMN3ehLlGTo5RJfXWn8F3wbzqq2iTczqjXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795790876;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=oRjIqSWINEkHmDyw4sCziPp6EwjJYhFVjZ6ycoabQMM=;
	b=aO1+IQXc5OTsldZ8PBBL+AHrk2Wc5LayQs4KyhTwJxXI6yEx5Qwq9rUlGBczTxrWiFyu
	 1N2GMM4LZuBngxDkgqWCJ7H/GDjNALdGClvkcDAjgSD648Tzj3arlplFLDOUh0rSMeh7O
	 2TRPRvlkEvR7i6JLksS9Zk0QinJnXmXaWej0YtNOAjZGxxPhlePBjDgWeB3q7UKVqKKhP
	 8qvp/8XyMggjvR7XqsqEiwsjgdWjJfIOVdsTO+pyma0ljsZK+i/VNM8xRsoAFikuhyKA4
	 foTcaMr26DPbFuNC40pMkK16bWvdPnxp4IY1pOH7N2erU9mTLqPIBB+gjI/SW93x/QA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gb+PgFDd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF77606A33D;
	Fri, 27 Nov 2026 14:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gb+PgFDd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 826441F0089A;
	Fri, 27 Nov 2026 14:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795790876;
	bh=oRjIqSWINEkHmDyw4sCziPp6EwjJYhFVjZ6ycoabQMM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gb+PgFDdzoHGawX0SYTrnaJtt78i6/E2aEnD03hZO0CxwgyZ4p6u4GySQZnzzG4Pg
	 6CJNSWoyilHSm+kZEbdaKO4voErn4u9PQNr2epJdFTzTmj2NmYs7evhHrh2MibsK2E
	 VHUYzokAUZJZh/wgP0O1wfNkdFVXeBtV07oJpVXIS5QJoNDlaxhLzYTQlqLUpO04N1
	 DwMWg+eEG/rn5OihPzZHhoKm8RDnAbB+qJiL9t2VHqcoNFq2hLvQilLDtiXtm+a8+I
	 swuTMXdnSTEMfxd+s7yItcCM1/S7Jm5OZWxmFpN5VMO8txHs10PScanA/rJrWkCy93
	 sckTuhmUA+9Xg==
Message-ID: <sashiko-outbox-237604@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 11/35] spi: atmel-quadspi: Reject excessive dummy
 cycle counts
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
In-Reply-To: <20261127-macronix-upstreaming-spi-mem-cycles-v2-11-5c93f5e5d630@bootlin.com>
References: <20261127-macronix-upstreaming-spi-mem-cycles-v2-0-5c93f5e5d630@bootlin.com>
 <20261127-macronix-upstreaming-spi-mem-cycles-v2-11-5c93f5e5d630@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 14:47:54 +0000
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
- [High] spi: atmel-quadspi: broken dummy buswidth check in
  atmel_qspi_supports_op()
--

commit 841dc168dae61bbe3593e703339f362587a598fd
Author: Miquel Raynal <miquel.raynal@bootlin.com>

spi: atmel-quadspi: Reject excessive dummy cycle counts

This commit adds checks to atmel_qspi_supports_op() to reject operations
whose dummy cycle count exceeds QSPI_IFR_NBDUM_MASK or whose dummy
buswidth differs from the address buswidth.

> diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
> index abca99b32b619..8946abaafa81b 100644
> --- a/drivers/spi/atmel-quadspi.c
> +++ b/drivers/spi/atmel-quadspi.c
> @@ -487,9 +487,15 @@ static bool atmel_qspi_supports_op(struct spi_mem *m=
em,
>  	if (!spi_mem_default_supports_op(mem, op))
>  		return false;
> =20
> +	if (op->dummy.ncycles && op->dummy.buswidth !=3D op->addr.buswidth)
> +		return false;

[Severity: High]
Does this reject every operation that has dummy cycles but no address
phase?

When op->addr.nbytes is 0, op->addr.buswidth is 0 (for example, in
spi_nor_spimem_setup_op() when micron_st_nor_octal_dtr_en() issues an
8D-8D-8D Read ID with 0 address bytes and 8 dummy bytes, or in SPI NAND
operations using SPI_MEM_OP_NO_ADDR with dummy bytes), so comparing
op->dummy.buswidth against op->addr.buswidth without checking
op->addr.nbytes causes atmel_qspi_supports_op() to return false and fails
those operations with -EOPNOTSUPP.

Also, this buswidth check is not mentioned in the commit message.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127-macronix-u=
pstreaming-spi-mem-cycles-v2-0-5c93f5e5d630@bootlin.com?part=3D11
