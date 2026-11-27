Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795789483;
	b=vxxYKqpQ5LXO5tmflyvBB7LphMeHs6lnupewJrk/pINHIbLor7FlrRKoi0ldL+hcfOKZ
	 RBAU45KhqRoSv+WCL6t0+VFLi31EBABZ1NzR7axN6fOXTG9Cm5xNB4DYufmSStzfxN3lf
	 tq8NLbDdHYXtF1HDu/OpySIB7ztnGSziX/cwJevFN4PklPT08yo7Eo42PJqzXkqMAMNWh
	 3FobTlhp/eUl9SoK4J4FGO/IkeDHckj0XTpnZVDqza5vciqpDCqvL0uaduHZphj6T2SEm
	 J+DMAdA++IiNicpMLtCIYzp5JtX8h2jdRH5FCdQ5F3TgEOCzJJH7MPSO3Q1afrYP8uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795789483;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=TBZW7Ptwz+yw8AXqBhejxSGjbWw/7ikzInaFBRYqbMw=;
	b=YUCB7LTxjWcTqs3JhKv8oj+mbvMa8jY+5qdDz22P1Rg+TsHh/o/eVYh0M45dBry25L9M
	 k7ET+jrM0lSRmCzzt5zi/ZeXTU3RCSvzP4DH9KEW/bidCPEGBtC3ZP9VMwxdisL/Wl6I+
	 RC/I1y/DBMwBZBMDluZkAvlg0bZ7cuzj8NaOv/aZHzYwy8v0EbHIYcHEQ5Qn2Ti9DBPLR
	 9yJsVnIMoooq2liReoIX2lnqm29LUNbqvt5dNZ7b8QxJNfMPG2BeEHbOGcQc6r1PZ3SFm
	 LIRGVxST/xTA3CpkKOOSAHV4bD2OoMp2RRzLu6lpa0SZbhI9MQg2BiW31noIBSsDr4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=iNcMVji5;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E12606A69D;
	Fri, 27 Nov 2026 14:24:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9E12606A69D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=iNcMVji5
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 65DFB1A1838;
	Fri, 27 Nov 2026 14:24:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 332896049C;
	Fri, 27 Nov 2026 14:24:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 22E8111E68FD9;
	Fri, 27 Nov 2026 15:24:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795789478; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=TBZW7Ptwz+yw8AXqBhejxSGjbWw/7ikzInaFBRYqbMw=;
	b=iNcMVji5FJ6CiqLt5PrRB1JZ3mB+OTxGlkV8xIWF1ejjwqQTrcOX0vXSSQ85Z2x9fXRRZu
	EyBYoOJrmudeLSJVqboEMsF2ZCpJQqtc+2Auxps+wVOSHd2Ib4FAL8pMmtlePbC9BCRu/f
	dVUgxy2omCV0x0LT//8irghtcm3zfTMOMmONKITlE1X08b5QTNXUG4kdBwjw+DQg2msRdH
	LaY+0h5WJ0H9melMp5ZaoeKAT6OTmuBTR6UDr+o3htZYUbimya7dqN+IELDdlqa8z1rtE+
	Z1osr8DpkaZ2d1+GP/Ct6gE7Ur/NDLh8luqp6qvDNrP0vEc/VhRs+2aQkZoq8A==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 27 Nov 2026 15:22:32 +0100
Subject: [PATCH RFC v2 10/35] spi: atmel-quadspi: Consume dummy cycles
 directly
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
Message-Id: <20261127-macronix-upstreaming-spi-mem-cycles-v2-10-5c93f5e5d630@bootlin.com>
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

The controller programs the dummy phase in clock cycles, but the driver
converts the legacy dummy byte count into cycles. Advertise the
dummy_cycles capability and use op->dummy.ncycles directly.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/atmel-quadspi.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 0b695b0b3c98..abca99b32b61 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -502,7 +502,7 @@ static bool atmel_qspi_supports_op(struct spi_mem *mem,
 
 	/* special case not supported by hardware */
 	if (op->addr.nbytes == 2 && op->cmd.buswidth != op->addr.buswidth &&
-	    op->dummy.nbytes == 0)
+	    !op->dummy.ncycles)
 		return false;
 
 	return true;
@@ -543,8 +543,8 @@ static int atmel_qspi_set_cfg(struct atmel_qspi *aq,
 		return mode;
 	ifr |= atmel_qspi_modes[mode].config;
 
-	if (op->dummy.nbytes)
-		dummy_cycles = op->dummy.nbytes * 8 / op->dummy.buswidth;
+	dummy_cycles = op->dummy.ncycles;
+
 
 	/*
 	 * The controller allows 24 and 32-bit addressing while NAND-flash
@@ -706,14 +706,8 @@ static int atmel_qspi_sama7g5_set_cfg(struct atmel_qspi *aq,
 		return mode;
 	ifr |= atmel_qspi_sama7g5_modes[mode].config;
 
-	if (op->dummy.buswidth && op->dummy.nbytes) {
-		if (op->addr.dtr && op->dummy.dtr && op->data.dtr)
-			ifr |= QSPI_IFR_NBDUM(op->dummy.nbytes * 8 /
-					      (2 * op->dummy.buswidth));
-		else
-			ifr |= QSPI_IFR_NBDUM(op->dummy.nbytes * 8 /
-					      op->dummy.buswidth);
-	}
+	if (op->dummy.ncycles)
+		ifr |= QSPI_IFR_NBDUM(op->dummy.ncycles);
 
 	if (op->addr.nbytes) {
 		ifr |= FIELD_PREP(QSPI_IFR_ADDRL_SAMA7G5, op->addr.nbytes - 1) |
@@ -990,6 +984,10 @@ static const struct spi_controller_mem_ops atmel_qspi_mem_ops = {
 	.get_name = atmel_qspi_get_name
 };
 
+static const struct spi_controller_mem_caps atmel_qspi_mem_caps = {
+	.dummy_cycles = true,
+};
+
 static int atmel_qspi_set_pad_calibration(struct atmel_qspi *aq)
 {
 	unsigned long pclk_rate;
@@ -1441,6 +1439,7 @@ static int atmel_qspi_probe(struct platform_device *pdev)
 	ctrl->set_cs_timing = atmel_qspi_set_cs_timing;
 	ctrl->bus_num = -1;
 	ctrl->mem_ops = &atmel_qspi_mem_ops;
+	ctrl->mem_caps = &atmel_qspi_mem_caps;
 	ctrl->num_chipselect = 1;
 	platform_set_drvdata(pdev, ctrl);
 

-- 
2.56.0

