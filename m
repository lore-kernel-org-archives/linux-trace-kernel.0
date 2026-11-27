Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795789671;
	b=RxHX9aSItSxMV2f/kJ8lFnFXmmIVoW/jPh6t6vwNtN4twPrArMbM2FDoGFxtwx+G8TPK
	 YJV9sKuV7Ng3gZ+Mp5eoZFP6Zplfy4InDtgpNLVdSHk/TYpIaS7uoe1qUcXMs7gWs0lg5
	 JVETcJ84H76i8nU0WIAX4oSMW8g9HtZ1KQyZMzXFhTwfH6Oiz/wD28NOHxOV9VuPOjZQO
	 AMoCLoVZAGJGkEfZlVwxNoOCBFcdlOoH7u3Ixyn0uMgbbdiLWb9C+D4YHxiBa3t8/+Oxx
	 /KjPMgzNWJS0G1utnp2YSPaVOyzc7VyShppuuQMuLB3izXrKRCdnVZPSoxH45wEMZrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795789671;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=k46uZYQ2ESt/gYiB8AP/kZeA93Cegpvn1/Ee8Gyu4sI=;
	b=w1ACI9L5SVzKXn33xrncas+61g2m/+w97hl2b1Bi9nivJ1Z8kKy302I2ZGhNNchoDIoZ
	 2I2VWXIswtN7jOzGcwTL13UYpo5CT3jECoVkAF462mvKJue7kRfYbMWfLQ0SaRm09a2Or
	 7Aps5jAwRcY4t538Ieye++9OQOksHguH4CRYPggSd5gzADnXxONskCpNMxJpF6oErbg3G
	 Bu7QqOQzhFvV28x/pyDc8WuTO4qkcs3ZcqQXXojRryMzwTszcjUm6xxSB06BI7+YcUzp1
	 9NAOG2hGEfh+Yw6DSurC6s1eotqkYcevAkaGBcWilbpMFray5gMnRqIBx3VpZ90qShw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=H5EZ9cMT;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCD1606A71B;
	Fri, 27 Nov 2026 14:27:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CCD1606A71B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=H5EZ9cMT
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 12C424E417CC;
	Fri, 27 Nov 2026 14:27:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D77706049C;
	Fri, 27 Nov 2026 14:27:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D310F11E68FF9;
	Fri, 27 Nov 2026 15:27:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795789666; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=k46uZYQ2ESt/gYiB8AP/kZeA93Cegpvn1/Ee8Gyu4sI=;
	b=H5EZ9cMTMbqjjfd4NGRWP+p9KrOohx/GRpirD8CaXFKwmc+8lEFHH5eFB2jcNGCCu2ycEM
	KxeyRbQoGg6x8fwOJ/uB9TyejjCrlt379CcPUKRNeuGdXoVLSG6TUixsAp7MwdsI9uGXeM
	x2Nnn4nAThqL0lIdVoDC2xHPcil/LOtkTRC0pRX01+WDXmkGC3M/p+CytciONYPQ0qgChH
	7DdkRW10qFFPsCYpSu8OJj9ZSLcHaJm0SQRLrgj8xOtChijjk/Up47YA4Vg4KEXI6dx9FA
	SVX0xrRMN64kt68prbzFdVFChBUaQxOUwPucbqP7wdV5BrElw8Ya8cc+nOoLHg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 27 Nov 2026 15:22:55 +0100
Subject: [PATCH RFC v2 33/35] spi: wpcm-fiu: Drop redundant checks
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
Message-Id: <20261127-macronix-upstreaming-spi-mem-cycles-v2-33-5c93f5e5d630@bootlin.com>
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
 drivers/spi/spi-wpcm-fiu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi-wpcm-fiu.c b/drivers/spi/spi-wpcm-fiu.c
index 884e5042bad5..4142fd894adb 100644
--- a/drivers/spi/spi-wpcm-fiu.c
+++ b/drivers/spi/spi-wpcm-fiu.c
@@ -323,9 +323,6 @@ static bool wpcm_fiu_supports_op(struct spi_mem *mem, const struct spi_mem_op *o
 	if (!spi_mem_default_supports_op(mem, op))
 		return false;
 
-	if (op->cmd.dtr || op->addr.dtr || op->dummy.dtr || op->data.dtr)
-		return false;
-
 	if (op->cmd.buswidth > 1 || op->addr.buswidth > 1 ||
 	    op->dummy.buswidth > 1 || op->data.buswidth > 1)
 		return false;

-- 
2.56.0

