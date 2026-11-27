Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795789587;
	b=jBtkhnFUFY4WGQgBJ5RPrxa8H/E51un0Q51xPF/BcqngD0llUpxB/DVEv/FiSP9VgCL3
	 l1hUz3AuhJ+KzyzIjl9Nd000wid6IzH+u2yqte8kUbvJyoUbIzXHGnRq82JRtcuO0uI6b
	 TyUnsP2VXbJAQgEO4IGBFx9Z5bHlac/TOYBzPdbkbR5o8eWnc1Q9P/PGx0T7i/N7IsZWA
	 cw6tuO9/AE73YzbNhimlZte77sKrAnoSU9F9QBPXPehoiRNM2Ls495M5n99dfXApSJbuG
	 c5aUqhymZBfIArV3sm2VvOyg9FQ7SMWCMLaIPHdzXT+zSUH7mOz0OtkdyVoF1XWCQRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795789587;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=+5J6Vj21k2iCMRlv7+I2xt+eX5HWFZ+N3D4FDSD3N6s=;
	b=FIFeEIhzAHi5NuO1+4sKGrMIv4ZYAG8jtP7X0qNYrIfWD8igiyDpvjxCgSL9ee0tTjSO
	 IyVOZSDSE2Tf6Ozx7mqsMfJ02iFW/froEOZGnjuOf7Y5hzqGY+AlNrDzyQ+7R+aS0C5L4
	 Ja4E1ilzqNPCXNg48IkboSeEkzMPyWT5FPaEqVU0WcX2C+R/hXi1EiXRqY5X4ryGB50r3
	 VvJ4/ZMEB5TUiiYU9x+iwNxgyFBDoR8dE++lVDJWW4JQ3EBCirMmH36O7BmzjiGNKc+Nd
	 Y8jCCvsy/g1kQcT32lR5nOS4q/58um3v8TFZfXy+1xp1JRntHh/e6WIbF3346cVZFnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=qbitKIHM;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45899606A690;
	Fri, 27 Nov 2026 14:26:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45899606A690
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=qbitKIHM
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id DDCCD1A0440;
	Fri, 27 Nov 2026 14:26:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AF40A6049C;
	Fri, 27 Nov 2026 14:26:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A1BA211E6900C;
	Fri, 27 Nov 2026 15:26:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795789578; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=+5J6Vj21k2iCMRlv7+I2xt+eX5HWFZ+N3D4FDSD3N6s=;
	b=qbitKIHMBo7JeSA9tv7PrthCAxceGYnOkYVFxh3VzX9NhCk+/mp8UTJjR5xfvMinznzFHM
	GVLflZTyfHkJ1emb3sTNL4lpUVe5cIxRD/jlFecbpswD/HdHbL1wlTYiwjRCj3pLd7jVOc
	PG67VSW7pRkdoxAHRm6YAFT2iqctzn5AgLhouaUrCJxCYu1iYmALl4mrk5emTwREmwSTn6
	vnd5sAgUeANKiJJsWPUGLS10MBgwQJ7sGJiF1k6VoNZdfaOB8VP3sT4IUfjG11v55PIODr
	7eGteqQuvq2buyDMr/96s/fNWfLq3XgsGhzsZAtWj9oKcwNpcRpARJCn9OTWkg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 27 Nov 2026 15:22:44 +0100
Subject: [PATCH RFC v2 22/35] spi: nxp-xspi: Reject mixed DTR modes
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
Message-Id: <20261127-macronix-upstreaming-spi-mem-cycles-v2-22-5c93f5e5d630@bootlin.com>
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

The controller only supports operations where all phases use the same
DTR mode. The mode selection in nxp_xspi_select_mem() assumes either an
all-DTR or an all-SDR operation; mixed DTR operations would be
misconfigured.

Reject mixed DTR operations from ->supports_op().

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-nxp-xspi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/spi/spi-nxp-xspi.c b/drivers/spi/spi-nxp-xspi.c
index ccd00c744d18..f2a847b5fd27 100644
--- a/drivers/spi/spi-nxp-xspi.c
+++ b/drivers/spi/spi-nxp-xspi.c
@@ -385,8 +385,18 @@ static bool nxp_xspi_supports_op(struct spi_mem *mem,
 				 const struct spi_mem_op *op)
 {
 	struct nxp_xspi *xspi = spi_controller_get_devdata(mem->spi->controller);
+	bool all_true, all_false;
 	int ret;
 
+	all_true = op->cmd.dtr &&
+		   (!op->addr.nbytes || op->addr.dtr) &&
+		   (!op->data.nbytes || op->data.dtr);
+
+	all_false = !op->cmd.dtr && !op->addr.dtr && !op->data.dtr;
+
+	if (!all_true && !all_false)
+		return false;
+
 	ret = nxp_xspi_check_buswidth(xspi, op->cmd.buswidth);
 
 	if (op->addr.nbytes)

-- 
2.56.0

