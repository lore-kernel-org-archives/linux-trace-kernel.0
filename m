Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795789426;
	b=dykGkQ2GDaH5WwUY2J/H1vbgA8jB6lrxFC8YbBAnDE1guzFBNFxYpbd93w//jk0TXsra
	 bARShiFSxVUDD5Nirz8bbF0PcJCBxSmYL0ys99eqXzBJ+x4jXYcv1NYxxH15F/X1Re9p0
	 n9jywuULwzkWK6mPIRE862SS8l070hkhpQNWdu/3TeevXuL98ehf4pLv8393cZzwZpIic
	 q/a1OheBCe4Jm9ykbO+Po4VI8U76Bm709E7K3dpn2EsoP8Q02ZLGES4bLibOlpDYW4CIy
	 MCgtGlEQBe1wxTYUDKCAzdNBWuOI/lqEHaiaF7jnDMDmQ+wBzXhkniMt/j35Cst+etA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795789426;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=HXhroBPZRcgrGIbcVc0pbxOO3IgNrBXDGvDEJWoY0CY=;
	b=0ulZCQRQ4WH/pfNq+7A6nJmyQ9N+t/pA7KNu1XJacPh0qFR9Gt4G4tENdL8c0uv+n5gj
	 Ky9WlFbOkZDIHiMEFTnjGq+Wn5CCe9d/sZYXiD0OheLLcoRrPXomCqd50gJgbpGXnFJ9Z
	 LVngwuckLZi8aUN+eWvAn9CK/G+nQ8xX5nTbhWiB/v6jEF/75+TKoI12VTAyo9dnr3eYv
	 UhrWj7y1XdiCmyJEPQBs+sOZnscy3yWTX0rQkGyauDi/II96rdFkQpFulUQl/YwD+CluS
	 xk6nJS0ppeTw4Fy6KU/bUU+QVW0HjVvv1VL6d/aXcGms4ITFajqNScHWduU6SENRwxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=rnfWUyNN;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A56606A32C;
	Fri, 27 Nov 2026 14:23:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86A56606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=rnfWUyNN
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 372A74E417C9;
	Fri, 27 Nov 2026 14:23:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0352B6049C;
	Fri, 27 Nov 2026 14:23:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E836E11E68FD9;
	Fri, 27 Nov 2026 15:23:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795789420; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=HXhroBPZRcgrGIbcVc0pbxOO3IgNrBXDGvDEJWoY0CY=;
	b=rnfWUyNNVeOK0yIxaUGUvuInfYVJ+8b8lpDJm7yQa263eaQy52ZcaPnICSJQiAeL1v5PW1
	BnxVGnjOPlC8YUqXIxXhDIQUW/RW3ZRbLzF5WsQCZz0yDnP5ZL71LBUa587cvfv2OJ9sv/
	UcAi5Mj64c6CUQXYFtv835NnxDv3LiUbKzxbXYI8NMWmsBtskn3W3+HIPWoWNYL5qwTQEZ
	vIJ5IR5fSoZzIQ7kOiVGXDybE81wHr76CUoskIRh15IokIpWwGocq6mcYlvefx27LCEEdx
	Fx8MHL/xhrCG9qjTqN8pmNrGBupdr2M7X6UB1sRWSTFWLhMjXM/RydF0YQeuVw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 27 Nov 2026 15:22:25 +0100
Subject: [PATCH RFC v2 03/35] spi: spi-mem: Handle a corner case while
 sanitizing ops
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
Message-Id: <20261127-macronix-upstreaming-spi-mem-cycles-v2-3-5c93f5e5d630@bootlin.com>
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

Mixed DTR operations (eg. 1S-xD-yD) set op_is_dtr but do not enter the
ODTR checks, so their command size is never validated.

Always check the command size: one byte, or two bytes in ODTR mode.
Require an even byte count only on 8-bit DTR phases, which carry two
bytes per clock cycle. Narrower DTR phases may use odd counts.

Regarding the dummy phase, either the controller is only supporting
"bytes", in which case the check must be performed, or (soon) they might
advertize the dummy_cycles capability for which sending an even number
of dummy bytes is irrelevant. The check can remain though, since in this
case dummy.nbytes will be 0 (those values are mutually exclusive, the
core will check that).

Fixes: 8618271887ca ("spi: spi-mem: Limit octal DTR constraints to octal DTR situations")
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-mem.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index f4d71f740163..3989017dd86f 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -171,6 +171,7 @@ bool spi_mem_default_supports_op(struct spi_mem *mem,
 	struct spi_controller *ctlr = mem->spi->controller;
 	bool op_is_dtr =
 		op->cmd.dtr || op->addr.dtr || op->dummy.dtr || op->data.dtr;
+	bool op_is_odtr = op->cmd.dtr && op->cmd.buswidth == 8;
 
 	if (op_is_dtr) {
 		if (!spi_mem_controller_is_capable(ctlr, dtr) && !ctlr->dtr_caps)
@@ -178,23 +179,20 @@ bool spi_mem_default_supports_op(struct spi_mem *mem,
 
 		if (op->data.swap16 && !spi_mem_controller_is_capable(ctlr, swap16))
 			return false;
+	}
 
-		/* Extra 8D-8D-8D limitations */
-		if (op->cmd.dtr && op->cmd.buswidth == 8) {
-			if (op->cmd.nbytes != 2)
-				return false;
+	/* Command phase is single byte, except in ODTR mode where it is two */
+	if ((!op_is_odtr && op->cmd.nbytes != 1) ||
+	    (op_is_odtr && op->cmd.nbytes != 2))
+		return false;
 
-			if ((op->addr.nbytes % 2) ||
-			    (op->dummy.nbytes % 2) ||
-			    (op->data.nbytes % 2)) {
-				dev_err(&ctlr->dev,
-					"Odd byte numbers not allowed in octal DTR operations\n");
-				return false;
-			}
-		}
-	} else {
-		if (op->cmd.nbytes != 1)
-			return false;
+	/* ODTR phases shall carry even byte numbers */
+	if ((op->addr.dtr && op->addr.buswidth == 8 && op->addr.nbytes % 2) ||
+	    (op->dummy.dtr && op->dummy.buswidth == 8 && op->dummy.nbytes % 2) ||
+	    (op->data.dtr && op->data.buswidth == 8 && op->data.nbytes % 2)) {
+		dev_err(&ctlr->dev,
+			"Odd byte numbers not allowed in octal DTR phases\n");
+		return false;
 	}
 
 	if (op->data.ecc) {

-- 
2.56.0

