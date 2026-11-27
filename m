Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795789477;
	b=XFD0iksYOVX0Ez2Vic9bFGn9BnRDRIdgUbb7NDFgbeUPt5waLvW74JUxOQ6EEFuxhE8J
	 hMVTBMB2PkKFnwdVg9JPh/AVgP0UKGdiLLeaqxAVkIJ/VVD3EI3tTKYmSkwLv2dyyeqOy
	 Rk92/Z+a2EWI1tsg4HDFXSvr/RUzFQQ6juw05y9i5Hl4IyduPBFI3dBY/nJMQnR/Jv4oD
	 ejHm+Ova68V4U+Lbx5Vuj2uyYl69HNyouCx4aQzI206e6LwVyvBdu7Bj1GpCLPpkmWBas
	 QZgjuCUdTTNzzVwtkKhMmxxoH0xT+gW4yGlFt+mX7ZYMNoJ08n1HfMyakqWkBfEjh1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795789477;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=l/15886dKnKp6gPMgY9uT99zHLf7znFw9ejlkvdaZy0=;
	b=cfnuNl4EfM83vqdHgbar8W4Hb2wPfjQYC3ocRNcuw7Y3VjueF8QhwCkmOSTe6u4+okM4
	 O4+6/d2ruKPQqPSN828G9Xu7pLlW4/j5c18LPTSJzbjcj+C5bLrQft2nr+7y+KtOnb6Rh
	 5pq44PBPyROnEkH0B3lSLq0ihPeJ2XLmceB2U9tW2gGXyfaxitV5sApQMRFhLsOceOknZ
	 ci9hw9M7n6z37fpSkZf/YmB0f2Lwsoj7+sky4RFYGB34Mfzz+zaCHhHAV5cg6DsWI/uM5
	 oojNbx/t4r0WdNUW413HuftGTKfUy91d0r0YmlWwUviIv5c/45xVflN1VMgV/h+NMVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=kGsF5AxB;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15C2606A69B;
	Fri, 27 Nov 2026 14:24:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F15C2606A69B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=kGsF5AxB
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id A876E1A183A;
	Fri, 27 Nov 2026 14:24:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7992D6049C;
	Fri, 27 Nov 2026 14:24:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9FBB711E68FFA;
	Fri, 27 Nov 2026 15:24:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795789472; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=l/15886dKnKp6gPMgY9uT99zHLf7znFw9ejlkvdaZy0=;
	b=kGsF5AxBn8Rt2DEwGlOWei3yUYq4TV1ZPi4qIPPHbmd6eelpv0mn1xbA+O0+dGwhY0pfK7
	O4OwZIp/z2P+n6XRQdP3puDumWjXAMqCKBmsqF6x/5TOzwGL/q4QWJ4HI6NySSUru5UKwg
	/lmJaFMaTkGqeFtOfb5wM3vrtMgyQ1iZU/xGMCDHfOjH2mj6YNkumLoY67HK0nKH9MNB3x
	wMZf/+++3cDKfUD9EroH9uwfH/ZLm4l6uVDLmUzCFpknODt6ftJJ5V1MtDj37SJBWArfUE
	aVRxGvdI57fv+avy18hAS2Kd2HzRYepJF/CDBRtDl5803yDLPE5CswKuWXlyew==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 27 Nov 2026 15:22:31 +0100
Subject: [PATCH RFC v2 09/35] spi: amlogic-spifc-a4: Consume dummy cycles
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
Message-Id: <20261127-macronix-upstreaming-spi-mem-cycles-v2-9-5c93f5e5d630@bootlin.com>
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
 drivers/spi/spi-amlogic-spifc-a4.c | 29 +++++------------------------
 1 file changed, 5 insertions(+), 24 deletions(-)

diff --git a/drivers/spi/spi-amlogic-spifc-a4.c b/drivers/spi/spi-amlogic-spifc-a4.c
index 16346f50c7d9..9b658ed1a580 100644
--- a/drivers/spi/spi-amlogic-spifc-a4.c
+++ b/drivers/spi/spi-amlogic-spifc-a4.c
@@ -148,7 +148,6 @@
 #define SFC_MAX_CS_NUM			2
 
 /* SPI-FLASH R/W operation cmd */
-#define SPIFLASH_RD_OCTALIO		0xcb
 #define SPIFLASH_RD_OCTAL		0x8b
 #define SPIFLASH_RD_QUADIO		0xeb
 #define SPIFLASH_RD_QUAD		0x6b
@@ -334,23 +333,9 @@ static int aml_sfc_send_addr(struct aml_sfc *sfc, const struct spi_mem_op *op)
 	return 0;
 }
 
-static bool aml_sfc_is_xio_op(const struct spi_mem_op *op)
-{
-	switch (op->cmd.opcode) {
-	case SPIFLASH_RD_OCTALIO:
-	case SPIFLASH_RD_QUADIO:
-	case SPIFLASH_RD_DUALIO:
-		return true;
-	default:
-		break;
-	}
-
-	return false;
-}
-
 static int aml_sfc_send_cmd_addr_dummy(struct aml_sfc *sfc, const struct spi_mem_op *op)
 {
-	u32 dummy_cycle, cmd;
+	u32 cmd;
 	int ret;
 
 	ret = aml_sfc_send_cmd(sfc, op);
@@ -361,13 +346,8 @@ static int aml_sfc_send_cmd_addr_dummy(struct aml_sfc *sfc, const struct spi_mem
 	if (ret)
 		return ret;
 
-	if (op->dummy.nbytes) {
-		/*  Dummy buswidth configuration is not supported */
-		if (aml_sfc_is_xio_op(op))
-			dummy_cycle = op->dummy.nbytes * 8 / op->data.buswidth;
-		else
-			dummy_cycle = op->dummy.nbytes * 8;
-		cmd = CMD_DUMMY(sfc->cs_sel, dummy_cycle - 1);
+	if (op->dummy.ncycles) {
+		cmd = CMD_DUMMY(sfc->cs_sel, op->dummy.ncycles - 1);
 		return regmap_write(sfc->regmap_base, SFC_CMD, cmd);
 	}
 
@@ -803,7 +783,7 @@ static int aml_sfc_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 
 	dev_dbg(sfc->dev, "cmd:0x%02x - addr:%08llX@%d:%u - dummy:%d:%u - data:%d:%u",
 		op->cmd.opcode, op->addr.val, op->addr.buswidth, op->addr.nbytes,
-		op->dummy.buswidth, op->dummy.nbytes, op->data.buswidth, op->data.nbytes);
+		op->dummy.buswidth, op->dummy.ncycles, op->data.buswidth, op->data.nbytes);
 
 	ret = aml_sfc_pre_transfer(sfc, DEFAULT_PULLUP_CYCLE, CS_SETUP_CYCLE);
 	if (ret)
@@ -1057,6 +1037,7 @@ static int aml_sfc_ecc_finish_io_req(struct nand_device *nand,
 
 static const struct spi_controller_mem_caps aml_sfc_mem_caps = {
 	.ecc = true,
+	.dummy_cycles = true,
 };
 
 static const struct nand_ecc_engine_ops aml_sfc_ecc_engine_ops = {

-- 
2.56.0

