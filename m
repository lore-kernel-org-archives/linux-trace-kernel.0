Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795789499;
	b=5nm2ObpAW1zn1mi5vx08AWTeIu4WcAIr3pwhLG4l3An4jJ5+EUvjs8qWv5SwbdDDLas8
	 jGXQmNqb30AED9MX7BtlpJZ0FCuIieB8xTkqSwRgOIjP1FM1ZGd/44cB9gnwIYP/Xp8n0
	 C4K+a8S0qF8fD7xP0LlwLhdArwYKD75qplG9rovHGcuCBdSTn/h42g78/zbu0aPBOEywX
	 loj8tL1r/KTjINe5biTLBojInc8gSR6phsy880FVeLoCA6D6Ifigh6wVL86wAviloPqlC
	 A83bmRRH21urQK/H1XyxMh5r2V/ChQU+Q3tG/upL2gBaLlSlpIVqW5BaEBqgV3Kn0vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795789499;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=AyWE+t1jQM06xzjS0D79QahZuOEjGLIi+nV7A0Efk90=;
	b=MpbPPZYM1i6PVw3+yxzLLikbP7OkqA4ksqdMwSycdVB9E9Wboua/EdK8tG3IO3DITb4i
	 MRHKc+wNPVimCURDUz5ZbZQOwyGbTMpYFfz77/p8l0DFNldfrIsAryxMFlXdKkm3nm1sm
	 PNnofC9JYPzJDYiaYfNaI7YnmbC4JHWEn7FtkgfHY5TLFdaZsDTKwkdOB5rmcT72R/npd
	 2se2hCcmer0H5GKIa9hepb4u0GcPpNeYUkvzHdM/kfmydKzRn7BZw/acArKdD5D3zpHhY
	 zFUbAg+TShflCQyHRA8fElHPgDl8codw686kdjoCZP/Dxuf0agKwrZkN8Q8rDV3CDcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=iYhTyubi;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E04606A68D
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Nov 2026 14:24:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42E04606A68D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=iYhTyubi
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 25AD11A1838;
	Fri, 27 Nov 2026 14:24:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EAD216049C;
	Fri, 27 Nov 2026 14:24:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A109311E68FF9;
	Fri, 27 Nov 2026 15:24:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795789491; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=AyWE+t1jQM06xzjS0D79QahZuOEjGLIi+nV7A0Efk90=;
	b=iYhTyubiDIwXjPh8z4yCi8Tp5QLBms/5mf5UVSazYSfG7jYL8kvX12KYSqelsXHx02ZYgT
	QUFX4RxgyHRmnBa2A2S0U6uaao9ThPkfBUMeVReQAF2aR8YHtVShehVdR4L9DL8S9QTWP3
	As1DHAWm3E360QU3aT/KsOhMve8juKpr+9GFEdSYZ0az+Berg32tUhlTyU8v86yyVD0sXp
	c11lMlR4XwlFjnKDk8Nbs6SuYFQzG632H8b5ifTkv+4ejfU7aIH8u4p+qyWoA1aLewlvnr
	re/icJkPJviqAv7LZLClwO/6crDYnRsotsCyk1QMsR9ZMr+0GzHX83FgXq5k6Q==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 27 Nov 2026 15:22:34 +0100
Subject: [PATCH RFC v2 12/35] spi: cadence-qspi: Consume dummy cycles
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
Message-Id: <20261127-macronix-upstreaming-spi-mem-cycles-v2-12-5c93f5e5d630@bootlin.com>
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
 drivers/spi/spi-cadence-quadspi.c | 48 +++++++++++++++------------------------
 1 file changed, 18 insertions(+), 30 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 44d96b8cf8f0..df7c04e0e2d2 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -410,20 +410,6 @@ static unsigned int cqspi_calc_rdreg(const struct spi_mem_op *op)
 	return rdreg;
 }
 
-static unsigned int cqspi_calc_dummy(const struct spi_mem_op *op)
-{
-	unsigned int dummy_clk;
-
-	if (!op->dummy.nbytes)
-		return 0;
-
-	dummy_clk = op->dummy.nbytes * (8 / op->dummy.buswidth);
-	if (op->cmd.dtr)
-		dummy_clk /= 2;
-
-	return dummy_clk;
-}
-
 static int cqspi_wait_idle(struct cqspi_st *cqspi)
 {
 	const unsigned int poll_idle_retry = 3;
@@ -549,7 +535,6 @@ static int cqspi_command_read(struct cqspi_flash_pdata *f_pdata,
 	size_t n_rx = op->data.nbytes;
 	unsigned int rdreg;
 	unsigned int reg;
-	unsigned int dummy_clk;
 	size_t read_len;
 	int status;
 
@@ -574,12 +559,11 @@ static int cqspi_command_read(struct cqspi_flash_pdata *f_pdata,
 	rdreg = cqspi_calc_rdreg(op);
 	writel(rdreg, reg_base + CQSPI_REG_RD_INSTR);
 
-	dummy_clk = cqspi_calc_dummy(op);
-	if (dummy_clk > CQSPI_DUMMY_CLKS_MAX)
+	if (op->dummy.ncycles > CQSPI_DUMMY_CLKS_MAX)
 		return -EOPNOTSUPP;
 
-	if (dummy_clk)
-		reg |= (dummy_clk & CQSPI_REG_CMDCTRL_DUMMY_MASK)
+	if (op->dummy.ncycles)
+		reg |= (op->dummy.ncycles & CQSPI_REG_CMDCTRL_DUMMY_MASK)
 		     << CQSPI_REG_CMDCTRL_DUMMY_LSB;
 
 	reg |= BIT(CQSPI_REG_CMDCTRL_RD_EN_LSB);
@@ -696,7 +680,6 @@ static int cqspi_read_setup(struct cqspi_flash_pdata *f_pdata,
 {
 	struct cqspi_st *cqspi = f_pdata->cqspi;
 	void __iomem *reg_base = cqspi->iobase;
-	unsigned int dummy_clk = 0;
 	unsigned int reg;
 	int ret;
 	u8 opcode;
@@ -714,13 +697,11 @@ static int cqspi_read_setup(struct cqspi_flash_pdata *f_pdata,
 	reg |= cqspi_calc_rdreg(op);
 
 	/* Setup dummy clock cycles */
-	dummy_clk = cqspi_calc_dummy(op);
-
-	if (dummy_clk > CQSPI_DUMMY_CLKS_MAX)
+	if (op->dummy.ncycles > CQSPI_DUMMY_CLKS_MAX)
 		return -EOPNOTSUPP;
 
-	if (dummy_clk)
-		reg |= (dummy_clk & CQSPI_REG_RD_INSTR_DUMMY_MASK)
+	if (op->dummy.ncycles)
+		reg |= (op->dummy.ncycles & CQSPI_REG_RD_INSTR_DUMMY_MASK)
 		       << CQSPI_REG_RD_INSTR_DUMMY_LSB;
 
 	writel(reg, reg_base + CQSPI_REG_RD_INSTR);
@@ -1523,16 +1504,14 @@ static bool cqspi_supports_mem_op(struct spi_mem *mem,
 	bool all_true, all_false;
 
 	/*
-	 * op->dummy.dtr is required for converting nbytes into ncycles.
-	 * Also, don't check the dtr field of the op phase having zero nbytes.
+	 * The controller only supports operations where all phases use the
+	 * same DTR mode.
 	 */
 	all_true = op->cmd.dtr &&
 		   (!op->addr.nbytes || op->addr.dtr) &&
-		   (!op->dummy.nbytes || op->dummy.dtr) &&
 		   (!op->data.nbytes || op->data.dtr);
 
-	all_false = !op->cmd.dtr && !op->addr.dtr && !op->dummy.dtr &&
-		    !op->data.dtr;
+	all_false = !op->cmd.dtr && !op->addr.dtr && !op->data.dtr;
 
 	if (all_true) {
 		/* Right now we only support 8-8-8 DTR mode. */
@@ -1550,6 +1529,13 @@ static bool cqspi_supports_mem_op(struct spi_mem *mem,
 		return false;
 	}
 
+	/*
+	 * The controller has no separate dummy buswidth: the dummy phase is
+	 * clocked with the address buswidth.
+	 */
+	if (op->dummy.ncycles && op->dummy.buswidth != op->addr.buswidth)
+		return false;
+
 	return spi_mem_default_supports_op(mem, op);
 }
 
@@ -1739,12 +1725,14 @@ static const struct spi_controller_mem_ops cqspi_mem_ops = {
 static const struct spi_controller_mem_caps cqspi_mem_caps = {
 	.dtr = true,
 	.per_op_freq = true,
+	.dummy_cycles = true,
 };
 
 static const struct spi_controller_mem_caps cqspi_am654_mem_caps = {
 	.dtr = true,
 	.per_op_freq = true,
 	.no_cs_assertion = true,
+	.dummy_cycles = true,
 };
 
 static int cqspi_setup_flash(struct cqspi_st *cqspi)

-- 
2.56.0

