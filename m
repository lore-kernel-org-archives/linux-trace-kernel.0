Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795789435;
	b=np9CoTumsv2XvKhBP6NZ8P77t6QRRsR4ofI5aHqB01DMppOyKzfZgy44qlsrWPmBRvFI
	 trWHR9Edgj6LSMv76iPaoLj1T6on8yWAtqiZzo6WFfBxDpRKOIlYeEEjJV6CAsWTdxQqV
	 uKJv/z6mlg0neDmH3Da3HayTfDhaLwI7IU84JkHUB/FjTuafP7ta8D3Z+iebVdX1zXXOW
	 5lE2E3ZIAinoUHpOZwB4czBb4oiwku4sHjMe0jWMk+WToS6kemxYI6GMFIpUM4N4+xqEg
	 llNXuEPL2eyG9nH/QOJDHh3wDSsVPNxeZT77LVkWDv/Y0A/j6AA0W45NGj9p82yTNHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795789435;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=rLV3AiVfesH7+JN4SghWwMFjSPsBHJqy3yngjEbzPMg=;
	b=YxsqdasADG6HeSdEJSqvDCOI0X1oIJB8jr1OfkiNXSChBadpy8PhcX1E9Lh1Jiv32s2S
	 IeAqJUDFztVxW05KUQk/sQT9Z+Vby7axvRdvbXBPa89rY0w8RYVuVKM05hHppypOEL+f7
	 /QhtAVxau18EBScIqq0Fy636Ktp0BBR3ekmAqi8++mynR7t2iuEFTpS1Y2SvRm37AfLYp
	 Vv+q9eEwtgtc7pVv6d/f9CUac4esymrOfV+yQg4XlRZXHT4GfvHlT5nSIZ57KStH0Wp6X
	 5b02WLXSPmwZBQENs2MVfLgG3X24o4Nk+6gEp9uErHkqyfyFRJ5QU2J0RV5x+7J8WWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=VUC9H8n3;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AEE606A321
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Nov 2026 14:23:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3AEE606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=VUC9H8n3
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 89DFA4E417C8;
	Fri, 27 Nov 2026 14:23:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 547B16049C;
	Fri, 27 Nov 2026 14:23:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6422611E68FDF;
	Fri, 27 Nov 2026 15:23:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795789429; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=rLV3AiVfesH7+JN4SghWwMFjSPsBHJqy3yngjEbzPMg=;
	b=VUC9H8n3pAarXQo2g6qN067XkCpnQwpm/9E/2Hk/I/tB2/1XjdWLGM9P4hBoCk9E1JFxvl
	7J73tquQz2tKFGE2WS1IAUZmedaT+KEy8IOWHjtt+NZ5NVCKpzAogmzQQ432xXmK788h7I
	OPnifGiuXyvdQgpKjfmZW/6R/gmGUXYAqZN5x8erH8kLD7UZmo88dREo0edxaZo7/VHVOB
	O8HcV8efoiegMzRWc5KP4Jp+8apQaRGkS6nhprcWVDoH/FjQQxuOI06RFltCq+Kqlauzdv
	16TuJt77aMuawELzzNmaPR/mVBrmDeGr+G1nP3Q9031kHufg6haf+aH0byuP1A==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 27 Nov 2026 15:22:26 +0100
Subject: [PATCH RFC v2 04/35] spi: spi-mem: Sanitize mixed DTR modes
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
Message-Id: <20261127-macronix-upstreaming-spi-mem-cycles-v2-4-5c93f5e5d630@bootlin.com>
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

The following operations are supported:
- S-S-D
- S-D-D
- D-D-D
But the following are not:
- S-D-S
- D-D-S
- D-S-S

Make sure these cases are refused by the core.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-mem.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 3989017dd86f..25f795d5e9ba 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -195,6 +195,27 @@ bool spi_mem_default_supports_op(struct spi_mem *mem,
 		return false;
 	}
 
+	/* xD-xS-xS is not allowed */
+	if (op->cmd.dtr) {
+		if ((op->addr.nbytes && !op->addr.dtr) ||
+		    (op->dummy.nbytes && !op->dummy.dtr) ||
+		    (op->data.nbytes && !op->data.dtr))
+			return false;
+	}
+
+	/* xS-xD-xS is not allowed */
+	if (op->addr.nbytes && op->addr.dtr) {
+		if ((op->dummy.nbytes && !op->dummy.dtr) ||
+		    (op->data.nbytes && !op->data.dtr))
+			return false;
+	}
+
+	/* xS-xS-xD-xS is not allowed */
+	if (op->dummy.nbytes && op->dummy.dtr) {
+		if (op->data.nbytes && !op->data.dtr)
+			return false;
+	}
+
 	if (op->data.ecc) {
 		if (!spi_mem_controller_is_capable(ctlr, ecc))
 			return false;

-- 
2.56.0

