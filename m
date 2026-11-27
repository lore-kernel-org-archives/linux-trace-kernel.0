Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795789648;
	b=plAYPINXWud43Z6UUvAWY/nRBUepmP0QDqvLsSHYUc2qBMPzu7qWVhZQcGgyV38Vp+uD
	 1YkyeKmsNBFiv3hXMtAfQ5nw7E6q/noFAJ0KAjcjN0pno2TLP5vLVegbu6D1BoYGQCCHI
	 nC7YG7E1a3yC6/kVmRLbVrpdgputhNdw3b19rbQweaMnecBIG6LXVn8PBaN78nHXpyZOx
	 C9FnG8fnYa8vBEBwuMs/vWX6wRRyDsjHlo2A+cPBgeLgbDBCgjCy3ndsbwppiII/7UObv
	 rm2yvb46B44yjNIpTEovizAodP90PCC4BIM5n8PWYZl6txbZRU0uo0h1KZck/BlG84w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795789648;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=PzsT2/vnTOLgeC13FDUQXpv3y/kUea2jI2GTpmgE9eM=;
	b=ZKzRMb4xgWrBg5RFl2RZIGUnPcGaDQy1ffLm1wyHah89+f197MSerrMyilleUZzFQQOl
	 r3XxlfS1fP8hr1ZOx6UfmjmWUvJ5jQ3lZ/uGDbSNXPmvcnqCy2zoCTuTy3m5vHEyHidiN
	 IccBIIlJAzNR9dUjWiZ1gJg7UzVeifawNfaJowa1QtJTnzt5ZpAWLsFRMfOleewp8Jxmz
	 PB40Gg+JBwhjPDdjwJR+BsWg4lCk0tPH9CByr2FpG1XCXLKd0/1iMVVukdpIHAO3ly7Qy
	 ydO9TdZs/53KKQf2WgvENP6g5cbmIla/naHzay4REg3TwhL1stCeNg4xoCxfwH1wxlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=udHo41LZ;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6E5606B182;
	Fri, 27 Nov 2026 14:27:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED6E5606B182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=udHo41LZ
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id B08251A183F;
	Fri, 27 Nov 2026 14:27:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 825CB6049C;
	Fri, 27 Nov 2026 14:27:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 04CC211E69021;
	Fri, 27 Nov 2026 15:27:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795789642; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=PzsT2/vnTOLgeC13FDUQXpv3y/kUea2jI2GTpmgE9eM=;
	b=udHo41LZ9pUYk5V1GKFBsW+tpcv8NEvbhIdv1MV7PCqO9109uFbTupw+GGlpLp4jY0jUNc
	8m+eKM5zExD2ih/EIGrU3+JoJ8HjqcVBNvsxBzTVSoYjikEcax9o94bun1EBRzj4Dgl9er
	R3Ne/Rmgyh9Z1UEMsL8hTkFQ97NmuwtSmKbPC7xpSOXEHWHiLiPE6vAWniqV6lCW7PrzpP
	fQuJovv/7NBZYLkytUwsR+IF9dlAnOdttrpygKXOk/aBWIRzzizFgPBE/seqiHsrVXAUoC
	fp89ZOlDp0u7aUFZRg9hxGo1GrSFPklJCBEECRWRTrr2cxGxVvNCqgFX8wppLQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 27 Nov 2026 15:22:52 +0100
Subject: [PATCH RFC v2 30/35] spi: stm32-ospi: Reject excessive dummy cycle
 counts
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
Message-Id: <20261127-macronix-upstreaming-spi-mem-cycles-v2-30-5c93f5e5d630@bootlin.com>
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

The controller stores the number of dummy cycles in a 5-bit field.
Prevent field corruption by adding a proper ->supports_op() callback.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-stm32-ospi.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-stm32-ospi.c b/drivers/spi/spi-stm32-ospi.c
index bf42f46ce194..30d48ee1be21 100644
--- a/drivers/spi/spi-stm32-ospi.c
+++ b/drivers/spi/spi-stm32-ospi.c
@@ -772,11 +772,17 @@ static int stm32_ospi_setup(struct spi_device *spi)
 	return 0;
 }
 
-/*
- * No special host constraint, so use default spi_mem_default_supports_op
- * to check supported mode.
- */
+static bool stm32_ospi_supports_op(struct spi_mem *mem,
+				   const struct spi_mem_op *op)
+{
+	if (op->dummy.ncycles > FIELD_MAX(TCR_DCYC_MASK))
+		return false;
+
+	return spi_mem_default_supports_op(mem, op);
+}
+
 static const struct spi_controller_mem_ops stm32_ospi_mem_ops = {
+	.supports_op	= stm32_ospi_supports_op,
 	.exec_op	= stm32_ospi_exec_op,
 	.dirmap_create	= stm32_ospi_dirmap_create,
 	.dirmap_read	= stm32_ospi_dirmap_read,

-- 
2.56.0

