Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795789658;
	b=dOvP+djleg3bTN7cjMXeRoX44QF+A7b/um3ls6eFc20+ToLMQXNKKDdsqiSlbFXbVfYr
	 cMpFarKKnguAHvKjoCEOxOyIh3hDoVcjI8m27QaGj2di3MDKSr9GjMnLnE9mhl+5JzW54
	 Gq1pG+u5//T8dCe+/tVEP7+6Nn6HCSGIw8KhdiDyiEHCuqCEJ41l4Nrvj0/ifbgiJqumm
	 k4XbUvQnk/uh86/vDJEpt6PaqGmNQ12UF/2k2koHvVcCdQ4/MAixY9q4ae2PDcTAbeL4o
	 bdPsbOYwajcnCNSa9sIuytsn+UL8LNYX4DB40aX+CMEoO1Zrd0K+bh5u1ppDdEjniaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795789658;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=NI1jRy0SNvAcR0rqCH0J86Yv5/i/7FwImrdwEEYORLw=;
	b=oEd+np8J2mA2IO0WLOZ8SmUJ47HvZXBpxTC6cpg4XqOnaZKP5v8U9YJKzTlMYiKKRU6R
	 aJiELElIR08Sex3IJO0f2v1cy93SfN/OOmwjsg/2G1N0dDkRUUmBsctIUCEImS6KmI4u+
	 ahS92iT5lrp/PxqyGBFYb+02Guc2jN9deGDgdA+iZXJCE4rLMLnRsM6hs79uMdddeyzPB
	 sdSYU8CBR/XJYsw6PluTnhag1tr1a9ktPpuFYAB9OZ44wMGhjp3wA028vv3HQ2fmF4EBp
	 Qqn8MoqWL6sT+8Y1d9AmtN1ZPy6SXirmBvexiyh1GwElRrkhnldksMDhYTF6r75kj4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=faSRBE9x;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3632C60A3829;
	Fri, 27 Nov 2026 14:27:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3632C60A3829
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=faSRBE9x
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id E8A254E417C6;
	Fri, 27 Nov 2026 14:27:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BBF016049C;
	Fri, 27 Nov 2026 14:27:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 56E0411E68FDF;
	Fri, 27 Nov 2026 15:27:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795789649; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=NI1jRy0SNvAcR0rqCH0J86Yv5/i/7FwImrdwEEYORLw=;
	b=faSRBE9xIdwm6CpFvu5BuVaGN/LXN08eSEmrEpnKLeaHTshe++AwkohlHGgEN1r/8PgxqT
	FlVZLDNThZxhe4T3xc3kqgZ3VVGomrqueIGAA0LRjFV6Uj+zPx6p5AmWt1JWC18xitdQEo
	hwvjrQVgP9dkiY4wzgXgJ6sddFUo8QQenTTL5QNbWKJ8u05NmZzYRme4FSXlDgYeiaChEB
	MHVcjee1bGnVuCcB+ugWlahVrRnk0ahgh2k6R+WiVVVFQx4MT3pOPlU1eHATCAI31UK/e5
	mSpc5OP2dMIYvpW/6+fNQ1gr1gBnKFnL92OB7rSwuAo9sLL0lVZyO+X46+fM4Q==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 27 Nov 2026 15:22:53 +0100
Subject: [PATCH RFC v2 31/35] spi: stm32-qspi: Consume dummy cycles
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
Message-Id: <20261127-macronix-upstreaming-spi-mem-cycles-v2-31-5c93f5e5d630@bootlin.com>
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
 drivers/spi/spi-stm32-qspi.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index b77daba6db83..993b09cc5124 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -393,9 +393,8 @@ static int stm32_qspi_send(struct spi_device *spi, const struct spi_mem_op *op)
 		ccr |= FIELD_PREP(CCR_ADSIZE_MASK, op->addr.nbytes - 1);
 	}
 
-	if (op->dummy.nbytes)
-		ccr |= FIELD_PREP(CCR_DCYC_MASK,
-				  op->dummy.nbytes * 8 / op->dummy.buswidth);
+	if (op->dummy.ncycles)
+		ccr |= FIELD_PREP(CCR_DCYC_MASK, op->dummy.ncycles);
 
 	if (op->data.nbytes) {
 		ccr |= FIELD_PREP(CCR_DMODE_MASK,
@@ -593,7 +592,7 @@ static int stm32_qspi_transfer_one_message(struct spi_controller *ctrl,
 		 */
 		if (transfer->dummy_data) {
 			op.dummy.buswidth = transfer->tx_nbits;
-			op.dummy.nbytes = transfer->len;
+			op.dummy.ncycles = transfer->len * 8 / transfer->tx_nbits;
 			dummy_bytes = transfer->len;
 
 			/* if happens, means that message is not correctly built */
@@ -773,6 +772,10 @@ static const struct spi_controller_mem_ops stm32_qspi_mem_ops = {
 	.poll_status	= stm32_qspi_poll_status,
 };
 
+static const struct spi_controller_mem_caps stm32_qspi_mem_caps = {
+	.dummy_cycles = true,
+};
+
 static int stm32_qspi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -856,6 +859,7 @@ static int stm32_qspi_probe(struct platform_device *pdev)
 	ctrl->setup = stm32_qspi_setup;
 	ctrl->bus_num = -1;
 	ctrl->mem_ops = &stm32_qspi_mem_ops;
+	ctrl->mem_caps = &stm32_qspi_mem_caps;
 	ctrl->use_gpio_descriptors = true;
 	ctrl->transfer_one_message = stm32_qspi_transfer_one_message;
 	ctrl->num_chipselect = STM32_QSPI_MAX_NORCHIP;

-- 
2.56.0

