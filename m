Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795789680;
	b=xiFGpRIF+96vuC4gKgQhKhPfTcLPyT+LQNNpoAvwH0OH9CSR8OWkYexScc38kYhnnNii
	 6rkVnEgGm94tsyV4NpdZ5KGMLSGQSdVN+lmrYULO3CmhW8+LsTe+Np/91yiOA76HVTaQr
	 dLWL+slEKi4sNAq1S8Jr3566BbBQhB46+FWIoTvqlLuZ/iGSVzwt1KQBdOKP/7Sjykn4C
	 JFVXWjTs00S+H7wVrnEpl+qLnjkKv8wQb+q8V56FxaEwC13aoCI05LPAMVU0fVNnkK0Xo
	 U7ydLVYXRfEgZ1rTSUNRpQ+vhK2KZK/3FON7amhgtJgNPMEWNX+sCLv5r/502438SDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795789680;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=t8xaCGkapw3XVy4Hw7CV1emEcGQK7H2PmWY00ef3WO0=;
	b=Yj6nrE4MOGW8Gs/QlBy4I4ieFHd0dlRFyrdprfdkOtlRhgQCItexAJc1TboAL0cUggc2
	 l5ruRFztyRRqpNRXN0HAo1gCtlaVBn+Siz649OvPWmjVFk8lhWquHYmKvS/8vWWag51HY
	 114K61MoyBK1By5xuTnC9Ejh3Mu554CY4VFKB8EAYr2p6sOg5v/6/VhBVJne9FDd7R7SM
	 sglKMlbm4zSN2VkytF0A5wn3sT7CvN2CTenskw+LfiKZAFlUjIvBCApmR0VG4RxSLDZ9J
	 e5xlosasUQG15cCV7LIFXUK3Au1AEI5/jFB/9njxqcWIo2kPHxX2axzU4hyjGy8G8vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=E5CGmgTl;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998C86072F03
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Nov 2026 14:27:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 998C86072F03
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=E5CGmgTl
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id EDFDCC2AC52;
	Fri, 27 Nov 2026 14:28:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2E54A6049C;
	Fri, 27 Nov 2026 14:27:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 50A7611E68FDF;
	Fri, 27 Nov 2026 15:27:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795789675; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=t8xaCGkapw3XVy4Hw7CV1emEcGQK7H2PmWY00ef3WO0=;
	b=E5CGmgTl43LUv/Wxw0p2JNyzgHt6z+dpetXd2kS2qL+rL3snuzvIp+P3rbNz+oyk3fu7hU
	TreJNAyLrcFBm0ugH5RPSeM0g9U79sBAo6XOxTA0gykC687ycVdJNNS8Omz1uj7z0kNkMj
	ptomlmpr0rgl6yiczbLUuJ0sCh9qWzEjbvJpVGx3HrxQZmFyOInGk/ho6nHCOJrDnNMGKQ
	/ffnWqCFriCA1995pfJqfSAshYk3zJkoF0AyX/et/5qq9IVuqHC+Wx+beqi9s7hknfy5a3
	XVhD4IsrEdp1utYqalbP0yCtkNQrPGdfvYa4RkylmyJh+fe3smtIk4rCrLocDQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 27 Nov 2026 15:22:56 +0100
Subject: [PATCH RFC v2 34/35] spi: zynqmp-gqspi: Consume dummy cycles
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
Message-Id: <20261127-macronix-upstreaming-spi-mem-cycles-v2-34-5c93f5e5d630@bootlin.com>
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

The controller programs the dummy phase in clock cycles in the GEN_FIFO,
but the driver converts the legacy dummy byte count itself. Advertise the
dummy_cycles capability and use op->dummy.ncycles directly.

Store the dummy cycle count in a dedicated dummy_cycles field instead of
reusing bytes_to_transfer, which is reserved for byte-oriented transfers.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-zynqmp-gqspi.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 15e9d3ef8839..6289e33c2807 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -176,6 +176,8 @@ struct qspi_platform_data {
  * @rxbuf:		Pointer to the RX buffer
  * @bytes_to_transfer:	Number of bytes left to transfer
  * @bytes_to_receive:	Number of bytes left to receive
+ * @dummy_cycles:	Number of dummy cycles to insert
+ * @dummy_phase:	Whether the dummy phase is currently executing
  * @genfifocs:		Used for chip select
  * @genfifobus:		Used to select the upper or lower bus
  * @dma_rx_bytes:	Remaining bytes to receive by DMA mode
@@ -198,6 +200,8 @@ struct zynqmp_qspi {
 	void *rxbuf;
 	int bytes_to_transfer;
 	int bytes_to_receive;
+	u32 dummy_cycles;
+	bool dummy_phase;
 	u32 genfifocs;
 	u32 genfifobus;
 	u32 dma_rx_bytes;
@@ -681,8 +685,14 @@ static void zynqmp_qspi_fillgenfifo(struct zynqmp_qspi *xqspi, u8 nbits,
 			transfer_len = xqspi->dma_rx_bytes;
 		else
 			transfer_len = xqspi->bytes_to_receive;
-	} else {
+	} else if (xqspi->txbuf) {
 		transfer_len = xqspi->bytes_to_transfer;
+	} else {
+		/*
+		 * The GEN_FIFO immediate_data field carries a number of
+		 * dummy SCLK cycles, not a byte count.
+		 */
+		transfer_len = xqspi->dummy_cycles;
 	}
 
 	if (xqspi->txbuf)
@@ -832,7 +842,8 @@ static irqreturn_t zynqmp_qspi_irq(int irq, void *dev_id)
 			(mask & GQSPI_IER_GENFIFOEMPTY_MASK))
 		zynqmp_qspi_readrxfifo(xqspi, GQSPI_RX_FIFO_FILL);
 
-	if (xqspi->bytes_to_receive == 0 && xqspi->bytes_to_transfer == 0 &&
+	if (!xqspi->dummy_phase &&
+	    xqspi->bytes_to_receive == 0 && xqspi->bytes_to_transfer == 0 &&
 	    ((status & GQSPI_IRQ_MASK) == GQSPI_IRQ_MASK)) {
 		zynqmp_gqspi_write(xqspi, GQSPI_IDR_OFST, GQSPI_ISR_IDR_MASK);
 		complete(&xqspi->data_completion);
@@ -1109,15 +1120,13 @@ static int zynqmp_qspi_exec_op(struct spi_mem *mem,
 		}
 	}
 
-	if (op->dummy.nbytes) {
+	if (op->dummy.ncycles) {
 		xqspi->txbuf = NULL;
 		xqspi->rxbuf = NULL;
-		/*
-		 * xqspi->bytes_to_transfer here represents the dummy circles
-		 * which need to be sent.
-		 */
-		xqspi->bytes_to_transfer = op->dummy.nbytes * 8 / op->dummy.buswidth;
+		xqspi->dummy_cycles = op->dummy.ncycles;
+		xqspi->bytes_to_transfer = 0;
 		xqspi->bytes_to_receive = 0;
+		xqspi->dummy_phase = true;
 		/*
 		 * Using op->data.buswidth instead of op->dummy.buswidth here because
 		 * we need to use it to configure the correct SPI mode.
@@ -1136,6 +1145,7 @@ static int zynqmp_qspi_exec_op(struct spi_mem *mem,
 			xqspi->rxbuf = NULL;
 			xqspi->bytes_to_transfer = op->data.nbytes;
 			xqspi->bytes_to_receive = 0;
+			xqspi->dummy_phase = false;
 			zynqmp_qspi_write_op(xqspi, op->data.buswidth,
 					     genfifoentry);
 			zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST,
@@ -1151,6 +1161,7 @@ static int zynqmp_qspi_exec_op(struct spi_mem *mem,
 			xqspi->rxbuf = (u8 *)op->data.buf.in;
 			xqspi->bytes_to_receive = op->data.nbytes;
 			xqspi->bytes_to_transfer = 0;
+			xqspi->dummy_phase = false;
 			err = zynqmp_qspi_read_op(xqspi, op->data.buswidth,
 					    genfifoentry);
 			if (err)
@@ -1179,6 +1190,7 @@ static int zynqmp_qspi_exec_op(struct spi_mem *mem,
 
 return_err:
 
+	xqspi->dummy_phase = false;
 	zynqmp_qspi_chipselect(mem->spi, true);
 	mutex_unlock(&xqspi->op_lock);
 
@@ -1206,6 +1218,7 @@ static const struct spi_controller_mem_ops zynqmp_qspi_mem_ops = {
 
 static const struct spi_controller_mem_caps zynqmp_qspi_mem_caps = {
 	.per_op_freq = true,
+	.dummy_cycles = true,
 };
 
 /**

-- 
2.56.0

