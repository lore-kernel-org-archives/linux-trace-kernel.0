Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795789626;
	b=s4cGEEAeb2wqcD/gz/1Zmxk0Abq7aGkESsV5bdvRXwOV6mIp3vnx/nPE8fzZrkX3j93O
	 1iUqEj0+u1m56uavthqqdg4fPv1fn7ouTJSeTtQ+n6XcbHbonzxbQY47f7K+0p/l8Tw6J
	 7QAYmpL7qiLUk+HE/6ekyyYTMrAetu4W6L2EqbqfAMxvvlI2IKLesyPN6X7K/D3nlMPu2
	 ps6rqsII2ihaYIgYfp95QWav1kZi7yn5sI6rl9OWk1143magxjc4wTS9t+isd6cWjpL6z
	 GbgOpwe84MTV0bNHKD6m3QYHigAaHKoXSpIrYv08sD8sIDhBf2HkVkxKbJ/+FQ5PHRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795789626;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=Yz6ZHF4IiJQgqN5fGyCKopgkxnOtrQuXNS72mjrBGKo=;
	b=gxHseGDxiCsWwaMqX8imjR+lZmSKDGRgUcDHaht7SSTgFE4JcY93efmfDO7JmPKmQDTh
	 UIZd4bq9JsoX1winshc38IWPTauwsVtlX9RCv3VsN3ZKR66Oh9T/uSHi0dSNAfy4pK/bA
	 yC7LQ0huphvfWKh61DTRA5/mj6wy2KYDrYmoqQ9qjPz1Gyhu45Up012lNGb6eMjKcK9Fx
	 /3qkvXqB4J1eFhNffcpxn8EwlwFS85vALowd0WVdii6g0CV+gw09//np1LkH8pXZHVVuA
	 lXDK4ByOnjtuLhjSVnVFxASYA7X7J8oAxa2JXiFkVDH/poIgUsMhaGif8hjbBfan30g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=XaxpBtto;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025AF60A2636;
	Fri, 27 Nov 2026 14:27:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 025AF60A2636
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=XaxpBtto
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id A87F51A1838;
	Fri, 27 Nov 2026 14:27:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 739C36049C;
	Fri, 27 Nov 2026 14:27:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A3B1411E68FF9;
	Fri, 27 Nov 2026 15:26:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795789621; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Yz6ZHF4IiJQgqN5fGyCKopgkxnOtrQuXNS72mjrBGKo=;
	b=XaxpBttouWRivkGS5XBCoKMKjn9+r09abbOOcttCyqgQiDM47o2QC6SVNrFvwZBPSI60dJ
	XsMCzDDNjhx7H8L+HmQYdSmfxQGo0gWzZJ3aqyOs5wBZSk/O9s4UeoTuEluIkz7Kj4yfXD
	1MUrFpvv1HGNwcKhMLSZksf/tciwr2RDI12qctgPjNsotVQ24IADBG5mBAWgZ7Bw4xG9Sd
	RM6F+MsWSqAxEd27wlNxwmKGTOMQ0+PLCX9HURsBYqdGS0n8dwNyxveIh1us4fMaeyWf9u
	86oV9TcgN4S2eP+kPduNd4KKBgUcpBrfkkyNEVmiWZkMP7QRX/qgNpLcWdwTUw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 27 Nov 2026 15:22:50 +0100
Subject: [PATCH RFC v2 28/35] spi: spi-qpic-snand: Drop redundant check
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
Message-Id: <20261127-macronix-upstreaming-spi-mem-cycles-v2-28-5c93f5e5d630@bootlin.com>
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

The core already sanitizes the spi-mem operations, this check is
redundant so let's drop it.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-qpic-snand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
index b03e2e4f0f0b..23f78171d27d 100644
--- a/drivers/spi/spi-qpic-snand.c
+++ b/drivers/spi/spi-qpic-snand.c
@@ -1531,7 +1531,7 @@ static bool qcom_spi_supports_op(struct spi_mem *mem, const struct spi_mem_op *o
 	if (!spi_mem_default_supports_op(mem, op))
 		return false;
 
-	if (op->cmd.nbytes != 1 || op->cmd.buswidth != 1)
+	if (op->cmd.buswidth != 1)
 		return false;
 
 	if (qcom_spi_is_page_op(op))

-- 
2.56.0

