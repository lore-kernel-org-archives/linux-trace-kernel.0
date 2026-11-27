Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795789600;
	b=F8F/UP+V+WWyWYAEFh9uc5Pg7bTiFDqXdzkIh+6dYQ6SshlFskDwrZjkuZ4z0xS16Vib
	 8NJYLu/VNNo0VDWJYLwNS6l1uj06NL2B7fkSxSIxy6OFm+M34JNje+ZAvJXQfxWWurI2K
	 QDKO8fV94IVTsrcHWg5iKrW9lWEXOQ5jL0UPunfX0o/xFWi/FDBAy1LJSQ4HjrjykVh03
	 +JY9LexgDBMnfvbcjhyb4gwj+gRNR25iB+9a67C51YLXGIi6RVVcd6YZv1CGpZYOCaOSo
	 RtHA7PGe4QapuwZmObtYisR/aRi3yiLykQ+UvP0ZiamNKiM+fhjKO4wLFb2xa8SfLGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795789600;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=zu0lJYnLrg1ZYSrYUBUQpODtv+uDnit0AU11jYGH7x4=;
	b=B+vOa8ZRpPNXoIpnLfcprmot4l5Cud+JqJJuH1p1hEUiQriOxKseQ8ggt5fkGIaFrL/v
	 38NOhrA6fQRjNbdQ1eqRjGqFTI3C9NMUg3WNtmu2FoFOrCsL7HQg+Fgi4Z1tBmcoxNDnU
	 FhdVZYG6r7GvmOntAJ5BDsT4wUuhDsad7XT9Uprp1l11jKflvWKKnd9uM7hwJelWBbYvA
	 FIOkcIUtNWPwjIvPW0HfvaIgDNRVUOowHwWaFNbuaf8tE9D3ji6GeMR6sqpIOqNniT5C+
	 ospLibU4gjbAo2r/ewPBiEVnKORPtVH4G8+oz/wrvGeMI3L+Zd5muhxZl68zJs6XPoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=F5FxOjCN;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918CE606A693;
	Fri, 27 Nov 2026 14:26:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 918CE606A693
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=F5FxOjCN
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 3B8854E417CA;
	Fri, 27 Nov 2026 14:26:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 064DA6049C;
	Fri, 27 Nov 2026 14:26:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 77B1111E68FD9;
	Fri, 27 Nov 2026 15:26:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795789594; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=zu0lJYnLrg1ZYSrYUBUQpODtv+uDnit0AU11jYGH7x4=;
	b=F5FxOjCNucjObr+WpOHDrEhkZVlYHLQEzVZPxyFtxTgV4dEIzIKnUN7gxonuOrhSqt9p9e
	SZgyMm5WF9oF5//bprUzP0wEVKjkXBG8brJ9Lpd2+pqj7JZf5RyAYk4IBBgvnOSkZuJsQR
	2T8fXKyTJ3NMrC9KryISZCkIhYemuPGhB55+OmsKA+n2yJRZLtZ27dyJXEsPCQDPyK5EBm
	U1IeQDQJvLpcLC73J9fuABHcni2av3M+s1RZs+HuC62rl4UkR6N3788pNG1i5gujetnks9
	6qTztonu2XIu+6i9c9N81L82lXcEsgVWSBH5jwUUiIgRSrss6FuwJ4DWNqf6PQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 27 Nov 2026 15:22:46 +0100
Subject: [PATCH RFC v2 24/35] spi: rpc-if: Consume dummy cycles directly
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
Message-Id: <20261127-macronix-upstreaming-spi-mem-cycles-v2-24-5c93f5e5d630@bootlin.com>
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
 drivers/spi/spi-rpc-if.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-rpc-if.c b/drivers/spi/spi-rpc-if.c
index 9a740342d0f7..fb27ee6064c2 100644
--- a/drivers/spi/spi-rpc-if.c
+++ b/drivers/spi/spi-rpc-if.c
@@ -32,10 +32,9 @@ static void rpcif_spi_mem_prepare(struct spi_device *spi_dev,
 		rpc_op.addr.val = spi_op->addr.val;
 	}
 
-	if (spi_op->dummy.nbytes) {
+	if (spi_op->dummy.ncycles) {
 		rpc_op.dummy.buswidth = spi_op->dummy.buswidth;
-		rpc_op.dummy.ncycles  = spi_op->dummy.nbytes * 8 /
-					spi_op->dummy.buswidth;
+		rpc_op.dummy.ncycles = spi_op->dummy.ncycles;
 	}
 
 	if (spi_op->data.nbytes || (offs && len)) {
@@ -141,6 +140,10 @@ static const struct spi_controller_mem_ops rpcif_spi_mem_ops = {
 	.dirmap_write	= xspi_spi_mem_dirmap_write,
 };
 
+static const struct spi_controller_mem_caps rpcif_spi_mem_caps = {
+	.dummy_cycles = true,
+};
+
 static int rpcif_spi_probe(struct platform_device *pdev)
 {
 	struct device *parent = pdev->dev.parent;
@@ -167,6 +170,7 @@ static int rpcif_spi_probe(struct platform_device *pdev)
 
 	ctlr->num_chipselect = 1;
 	ctlr->mem_ops = &rpcif_spi_mem_ops;
+	ctlr->mem_caps = &rpcif_spi_mem_caps;
 
 	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
 	ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_TX_QUAD | SPI_RX_QUAD;

-- 
2.56.0

