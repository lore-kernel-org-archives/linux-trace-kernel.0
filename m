Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795789509;
	b=H1B5Krj4l11tiAyOZG0eNmi3hgnuqUcb4yMFojGBTVymFvKXv+Arekbj/orscm7QZUzf
	 Gr8cpdPx876/8p6Np2HxU3Rr/QDCWdqDiCLv3MQmxp3FKYHxZs7u6fEqP1FhADSGPP382
	 4AWPJh+msqxrNQYXsG1JCwM/7fa7A7oPUfOlPsqUIucDX/3Ig+kIRSCkgjDplgPeIIjlY
	 ges5yu371GeJGSkog1UlS7sJb39K/DdUsIP410quYhZE0/KHWIzt+vn762Alf7gtXNE5z
	 jXIYpmP92PLQNAHATio+7BWJYIo3Rcp4M6j8vuNl1DMYM/Jqnl2e985N3eMiHqgQS2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795789509;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=VDYSicKqp2OeFF0Ws3pjAHSZvsSuFmA+Av5A7v9g3uU=;
	b=iNmOphrsL+WCgK6YV9DY6BivmSp7gAQv7TZk+d0pU9mqQmcvhc4+eC3YQWtNBO3neW10
	 uFA/zjHhYbcyJwuPhyYSsKnc/bnPbnm1NtSwUnQM5g85huVWeWmx2Hs7VoH+VDq8veSH6
	 hYyxytbkWgpKXFXqvt7qY6pDH93B6mx1z4GiGe/dSFnLGWpz0dwg/0So52lTb3WR3WERp
	 1ikZkWl/aKim7rLCppKiCPrOMDzoKhwJppvE/J4gWFtvjsLielOioHJaB7cooBYIZXjHs
	 7U5LHbCwy+wee/EGMLn2qDRoA7UGpXfK2PbxIDUNsF7WlcsD7UnlKJ+Lk/NF3Nevg9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=mCPupFMk;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA40606A329
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Nov 2026 14:25:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEA40606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=mCPupFMk
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id A2DCC1A1836;
	Fri, 27 Nov 2026 14:25:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6EC866049C;
	Fri, 27 Nov 2026 14:25:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D3EAA11E68FF4;
	Fri, 27 Nov 2026 15:24:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795789504; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=VDYSicKqp2OeFF0Ws3pjAHSZvsSuFmA+Av5A7v9g3uU=;
	b=mCPupFMkcRfnTzAr1Spz4Iuoof0rLblYlcTgdlvYugdCRiPEsvTHWNKbhADlCvSGKwJ1Je
	lG5Vz4gbMxFDMXUAKX2zEYbs9SW2y0Jt47OVeQdpx5boCZeYYwietaLpwk2CBCcFzA01od
	hVYZ222UDqBIVsfEuci6NiuPKeuD2ZvKxyVqhraL0Objx+rpc+fqiGjWVnPgNKypPf0fKm
	JBTqjtXV9bIr1kQI/iTrkEOQPe34K0Ljw8c3zBiDtM4FKtg1390PqeJTgE3ARKDWqV77no
	PMvdPfBmyC4s/lrYEyIosPnLrCgIz2+uZdciTN3WxwezM/pZCt3kVrFNO09jVQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 27 Nov 2026 15:22:35 +0100
Subject: [PATCH RFC v2 13/35] spi: cadence-qspi: Drop redundant checks
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
Message-Id: <20261127-macronix-upstreaming-spi-mem-cycles-v2-13-5c93f5e5d630@bootlin.com>
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

The core already sanitizes the spi-mem operations, these checks are
redundant so let's drop them.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-cadence-quadspi.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index df7c04e0e2d2..97725ffeae93 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -476,9 +476,6 @@ static int cqspi_setup_opcode_ext(struct cqspi_flash_pdata *f_pdata,
 	unsigned int reg;
 	u8 ext;
 
-	if (op->cmd.nbytes != 2)
-		return -EINVAL;
-
 	/* Opcode extension is the LSB. */
 	ext = op->cmd.opcode & 0xff;
 
@@ -1515,11 +1512,7 @@ static bool cqspi_supports_mem_op(struct spi_mem *mem,
 
 	if (all_true) {
 		/* Right now we only support 8-8-8 DTR mode. */
-		if (op->cmd.nbytes && op->cmd.buswidth != 8)
-			return false;
-		if (op->addr.nbytes && op->addr.buswidth != 8)
-			return false;
-		if (op->data.nbytes && op->data.buswidth != 8)
+		if (op->cmd.buswidth != 8)
 			return false;
 
 		if (cqspi->is_rzn1)

-- 
2.56.0

