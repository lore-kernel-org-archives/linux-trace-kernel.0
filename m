Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795789553;
	b=LQ5GscE29NRZBgQUMF0aoWR2P/9sQrrNweFzmn4XZhala04kj29Ax5VeXmdJmX+7f8Jm
	 hW4R0HpTu4/PAZcYZt3SzDafd5UwEhfSlCZu9nB8iNTjDD/+EIRFyIvB5YwA6oLU/OSpO
	 wR2xMdHezJI+L5CCzLp9YWAalxACEkZZKxlqNOGRbaupCVuYMumUUmkPGVyGjX6WoX56H
	 U0H2s34yl8hLkYFNVyMv1SEoKaunvY/DS7I5BAFXyFIZTIbwfXOa1uR5u85zYJaQ6taWP
	 sHrCTjMGDLlD2aq9tcbzPo/hI3xxfhNBTskihoFaGi5SwI3d9bq78gWdb+FgehVxi1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795789553;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=Z7J8RFTeR+O5qxgkBrWEhbpfO8vy8KFpxScRWHW4sNU=;
	b=ZiT4yPcJtowjFNnEfwai1w+bwFasXd38jJJSL7JQE5E8jxGa11rCKDg7e06P98eTCieR
	 ApJRNcRWQd9FvluLd2i4Q8Ni8uWQ+yHh5DUcDh/biBBa+JOUAq/rrr61Obp3In6A5kzG1
	 za6YGuSAiUf1GmSXXmZz7d2GHFcILQw5DDeDJG4YMZY/Hw9dobRZbvYQ3MFd2Kp+g7R7/
	 f5dhgj6LrE11MSGLLALmwJYDwulMliSEdSDdXrL0lq64MVGVenEb6eMgiknrgHuoDFjqb
	 PVJIbHpZOzagLxXETu2SGETfSnjMStVqydzU4uC5nNrh8bto/Ik9lz5ZDrmdNa4t7Mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=h1TDITrE;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CB7606A326;
	Fri, 27 Nov 2026 14:25:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03CB7606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=h1TDITrE
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id A9AD01A0440;
	Fri, 27 Nov 2026 14:25:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 759536049C;
	Fri, 27 Nov 2026 14:25:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EC0D511E68FD9;
	Fri, 27 Nov 2026 15:25:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795789546; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Z7J8RFTeR+O5qxgkBrWEhbpfO8vy8KFpxScRWHW4sNU=;
	b=h1TDITrE5rFBAEHgSpChjkohl9gGsEMmV2KR5aw1kHDblUhtISY7f3kvJgn/BUmFS1sJ/W
	6w5TvkyqOnUD01g90D2uSU4+7hk1ZOi0KeKUiTy6guMwSFwHMDuK9K++iL8uFisukOZC8f
	6zIa4RLKxjCXh+LYzKQ65Cyse3ho0ayvXp7M+L4ACovmI0Ab/9SwWj4bzVpbqjPCmIyqAZ
	tpGThMyMGXmlDmNFn4LznRjofJn7vqS7C1nO4+WdnfrkTv6YNGEChlOK5KAgruHcuSjn0y
	63G2ItL4pn/u/UasHFtq+3LgS4q2XL7cuQ083plQHW3iyd2Bm870yFwtErpcvQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 27 Nov 2026 15:22:40 +0100
Subject: [PATCH RFC v2 18/35] spi: nxp-fspi: Consume dummy cycles directly
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-macronix-upstreaming-spi-mem-cycles-v2-18-5c93f5e5d630@bootlin.com>
References: <20261127-macronix-upstreaming-spi-mem-cycles-v2-0-5c93f5e5d630@bootlin.com>
In-Reply-To: <20261127-macronix-upstreaming-spi-mem-cycles-v2-0-5c93f5e5d630@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Liang Yang <liang.yang@amlogic.com>, 
 Feng Chen <feng.chen@amlogic.com>, Xianwei Zhao <xianwei.zhao@amlogic.com>, 
 Han Xu <han.xu@nxp.com>, Conor Dooley <conor.dooley@microchip.com>, 
 Valentina Fernandez <valentina.fernandezalanis@microchip.com>, 
 Daire McNamara <daire.mcnamara@microchip.com>, 
 Haibo Chen <haibo.chen@nxp.com>, Jyan Chou <jyanchou@realtek.com>, 
 Yu-Chun Lin <eleanor.lin@realtek.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Takahiro Kuwano <takahiro.kuwano@infineon.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Yogesh Gaur <yogeshgaur.83@gmail.com>, 
 Chris Packham <chris.packham@alliedtelesis.co.nz>, 
 =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, 
 Michal Simek <michal.simek@amd.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Alvin Zhou <alvinzhou@mxic.com.tw>, 
 Cheng Ming Lin <chengminglin@mxic.com.tw>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 imx@lists.linux.dev, linux-riscv@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org, 
 linux-trace-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 openbmc@lists.ozlabs.org, Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

The controller programs the dummy phase in clock cycles in the LUT, but
the driver converts the legacy dummy byte count itself. Advertise the
dummy_cycles capability and use op->dummy.ncycles directly.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-nxp-fspi.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 66cb58f95fdb..e6fdded67a00 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -543,7 +543,7 @@ static bool nxp_fspi_supports_op(struct spi_mem *mem,
 	if (op->addr.nbytes)
 		ret |= nxp_fspi_check_buswidth(f, op->addr.buswidth);
 
-	if (op->dummy.nbytes)
+	if (op->dummy.ncycles)
 		ret |= nxp_fspi_check_buswidth(f, op->dummy.buswidth);
 
 	if (op->data.nbytes)
@@ -567,8 +567,7 @@ static bool nxp_fspi_supports_op(struct spi_mem *mem,
 		return false;
 
 	/* Max 64 dummy clock cycles supported */
-	if (op->dummy.buswidth &&
-	    (op->dummy.nbytes * 8 / op->dummy.buswidth > 64))
+	if (op->dummy.ncycles > 64)
 		return false;
 
 	/* Max data length, check controller limits and alignment */
@@ -652,16 +651,15 @@ static void nxp_fspi_prepare_lut(struct nxp_fspi *f,
 		lutidx++;
 	}
 
-	/* dummy bytes, if needed */
-	if (op->dummy.nbytes) {
+	/* dummy cycles, if needed */
+	if (op->dummy.ncycles) {
 		lutval[lutidx / 2] |= LUT_DEF(lutidx, op->dummy.dtr ? LUT_DUMMY_DDR : LUT_DUMMY,
 		/*
 		 * Due to FlexSPI controller limitation number of PAD for dummy
 		 * buswidth needs to be programmed as equal to data buswidth.
 		 */
 					      LUT_PAD(op->data.buswidth),
-					      op->dummy.nbytes * 8 /
-					      op->dummy.buswidth);
+					      op->dummy.ncycles);
 		lutidx++;
 	}
 
@@ -1372,11 +1370,13 @@ static const struct spi_controller_mem_caps nxp_fspi_mem_caps = {
 	.dtr = true,
 	.swap16 = false,
 	.per_op_freq = true,
+	.dummy_cycles = true,
 };
 
 static const struct spi_controller_mem_caps nxp_fspi_mem_caps_disable_dtr = {
 	.dtr = false,
 	.per_op_freq = true,
+	.dummy_cycles = true,
 };
 
 static void nxp_fspi_cleanup(void *data)

-- 
2.56.0

