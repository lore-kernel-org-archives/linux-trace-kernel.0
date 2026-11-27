Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795789536;
	b=2zlFBUbZ9tUc85vrcLgK6EG53HjjfYEF3gmx1WJ1xDmxijIXxN5H8toPUl0Pj5LSVcOo
	 7Wuxadp3TplJu0L2oAX0CDCveKtm7r4WkhrqtZB8wuM86/1fo+i/hLzOEXkcY4YRYjM1j
	 7KcZfWVNVwyKgQGJEHUWvZUsZmLD4WRJOH6Dmtxkdp9Lc6SSI+59A6lWylqcNl5gRQqNE
	 wsoCDUjScZp6pYYVTl8flq5Y+EXCE4ijZAFJoi4oPktil3Pdn8aLm3D7+5MChTXB/yv1A
	 N/PIHbzH3aemq0bTe7pKvW9rJ4oFhej500nQ5+Q3MyujUc2NdAfn6Boh5y1gvUlVHsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795789536;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=oIP6YsVJ0tzemJtkR4/F0RGkjUMxie6otevjRQEs/Zw=;
	b=agaOkUngWsHQB4Kp6nBTtb+RFdK9ZPIAh2t+ZW4nK9HR0MUYjU/u+E3O2k1tffx/66eo
	 lnSg0DyD4IBg/O+HVUf0m2BRIIbnxMI7i6uYqKQgvokGDZJPHLlz1qMh21J88bOuRxG3T
	 W6gR9TxRsFHjEBkWFqsTDcuHCBqW5j0RWzobzpCJ7MI1hpn1nFUMf9AL5T9peTPSaI6HN
	 hDLVjhKv/+QpKvOVNkksHw9MtwCGeGF4zu3PR5MdjFkQOMkoXA/1Y9s+gH+ecwEqqUdzF
	 Uya1UM5Dy+8olqOpNu0Vwkt9W1OYlCeCUADyMZK7Hi5E97c2QaOHNqjWkgBOOJXwDdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Nbd+2k2z;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F7E606C2F3
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Nov 2026 14:25:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1F7E606C2F3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Nbd+2k2z
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 49B35C6223B;
	Fri, 27 Nov 2026 14:25:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 73B116049C;
	Fri, 27 Nov 2026 14:25:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 026A611E68FF4;
	Fri, 27 Nov 2026 15:25:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795789528; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=oIP6YsVJ0tzemJtkR4/F0RGkjUMxie6otevjRQEs/Zw=;
	b=Nbd+2k2zRxfdX4N7PZuOesTe7y9uTS4XxFCrwjSo3LlykwttKnd2QBPXS7PTjAeHu+DGsh
	ub3eIakOiP6Hwf4eE4KcQ6YASWe65YaVejiDLnN5qvyijvuYpqqX5380WkqD+LdzgSxTeG
	hHVt7tbvP1wXmxEl3y3Xj1L7/yArHiTLqkQjyFNFVzowU47sJHCqDoz7MDVHrXwR9Q6Ng6
	cFg4OluANdGXIR+2n8CHr79haJq9g91aU7IpYD0AKFqSBfvfRvX+SutHyxGkqrS9FR19y+
	EaljxuCCa79rQSzyVe7u74NkZpnNJezBU/S5NAko5jt+NEUgcla3e/xg4+kB9w==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 27 Nov 2026 15:22:38 +0100
Subject: [PATCH RFC v2 16/35] spi: microchip-core-qspi: Consume dummy
 cycles directly
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
Message-Id: <20261127-macronix-upstreaming-spi-mem-cycles-v2-16-5c93f5e5d630@bootlin.com>
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
 drivers/spi/spi-microchip-core-qspi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-microchip-core-qspi.c b/drivers/spi/spi-microchip-core-qspi.c
index c0ea65014d2e..80481011b83e 100644
--- a/drivers/spi/spi-microchip-core-qspi.c
+++ b/drivers/spi/spi-microchip-core-qspi.c
@@ -8,6 +8,7 @@
  *
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/init.h>
@@ -420,7 +421,6 @@ static int mchp_coreqspi_setup_clock(struct mchp_coreqspi *qspi, struct spi_devi
 
 static void mchp_coreqspi_config_op(struct mchp_coreqspi *qspi, const struct spi_mem_op *op)
 {
-	u32 idle_cycles = 0;
 	int total_bytes, cmd_bytes, frames, ctrl;
 
 	cmd_bytes = op->cmd.nbytes + op->addr.nbytes;
@@ -459,11 +459,7 @@ static void mchp_coreqspi_config_op(struct mchp_coreqspi *qspi, const struct spi
 	writel_relaxed(frames, qspi->regs + REG_FRAMESUP);
 	frames = total_bytes & BYTESLOWER_MASK;
 	frames |= cmd_bytes << FRAMES_CMDBYTES_SHIFT;
-
-	if (op->dummy.buswidth)
-		idle_cycles = op->dummy.nbytes * 8 / op->dummy.buswidth;
-
-	frames |= idle_cycles << FRAMES_IDLE_SHIFT;
+	frames |= op->dummy.ncycles << FRAMES_IDLE_SHIFT;
 	ctrl = readl_relaxed(qspi->regs + REG_CONTROL);
 
 	if (ctrl & CONTROL_MODE12_MASK)
@@ -561,6 +557,9 @@ static bool mchp_coreqspi_supports_op(struct spi_mem *mem, const struct spi_mem_
 	if (!spi_mem_default_supports_op(mem, op))
 		return false;
 
+	if (op->dummy.ncycles > FIELD_MAX(FRAMES_IDLE_MASK))
+		return false;
+
 	if ((op->data.buswidth == 4 || op->data.buswidth == 2) &&
 	    (op->cmd.buswidth == 1 && (op->addr.buswidth == 1 || op->addr.buswidth == 0))) {
 		/*
@@ -601,6 +600,7 @@ static const struct spi_controller_mem_ops mchp_coreqspi_mem_ops = {
 
 static const struct spi_controller_mem_caps mchp_coreqspi_mem_caps = {
 	.per_op_freq = true,
+	.dummy_cycles = true,
 };
 
 static int mchp_coreqspi_unprepare_message(struct spi_controller *ctlr, struct spi_message *m)

-- 
2.56.0

