Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795789613;
	b=kEPtHUv/vAPac3ZwujGwQ03QZTU9a/qEg0EhZ3hcVQHdnqOI78vQsZaPLyLZgUIy/B28
	 y5Win26UKTAf/Jpk2CZ/VRtqjNBdWX0ZmZEHxH2h3eMJEBqNgXvkSOqYkUGnSXMCKzuYP
	 d69dgM4Q0HVRdncYwMOGmfEt3DVKscZ8W/g4qViuIxQshe+b8jSBo5jZ5UC6oGlqBgYai
	 V0EykKYve2NTLUyfdbCEgqB+K0kjV2avXFp8eM1GOMApyGaxMp0vP3knTtLTTM/oD8prD
	 GtAnhDNWHR8eV49NVBUHql0KuZm+sSbDT4kcmKTU0EQgttX/RYET11XerVoJ2AlpRWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795789613;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=A/IqQZ9VTKgRjMcNT4EZBKACErnAYfbhJSeeu/M9Auw=;
	b=NlBWeU9dBN3lz0YRFKUFtrBkYyeXJ/Mi7T0Y8G52QanpMEdfvKtkeOFKlBfn7xBYv4bW
	 iyNvOt4eXdefqiNqfvD4xjt6xJp8LieVB4jEefcUNzH3A4VgG/hP1kq0uOj92HNAi30Vy
	 H+u5GFgRH1b0Psy/8W4yWDk9/ZXGAfSbGBU8EjIPIMUJni+y24pWcsrBWeHKWT5yWRfhw
	 pWhOHJUmlIdQc5q8us2PzM3wAM2wqHIRipgXTszjV5oGc4YxaRQ2iwwMdjcxFaAk6N5I+
	 8PjAfSK6ockwkIEwynCDrhagR7zm8vkv3/VjE1ceCyg6IERs4zw1jrwmQOHOxJaAPag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Ubx3tDOw;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE016071E68
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Nov 2026 14:26:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABE016071E68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Ubx3tDOw
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 8AE371A1838;
	Fri, 27 Nov 2026 14:26:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 576E36049C;
	Fri, 27 Nov 2026 14:26:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3D39111E68FD9;
	Fri, 27 Nov 2026 15:26:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795789608; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=A/IqQZ9VTKgRjMcNT4EZBKACErnAYfbhJSeeu/M9Auw=;
	b=Ubx3tDOwV6i0QBpzsCyzanuCPyUDDo4aCHNmLwm25tRKbXNc5vmxkKN60QMwfrkdqmQ9Jz
	W7kyWWjP0od8K6vkQMKREz7zWXffZrPdkN3AGLKYj8mc7jB0gytVh0iUV3Ttyeo6V7yKa1
	BFGhzVf18NQ+UmWjkL9mSegQkcGKm3KqhdCOHRba0n9GmycoED4NUg5sV0iyRGDmN9zo1y
	fCSiIkJRCkS07GowircgCo22KGRVUoC3iWW/zY4D5iVslHneSG7qsvus9ZlJXofcDyQo54
	314IuM911yasw0KDvRGF8Ki+ghgxrkdleT4jgJEapDWZ+cZPyaCRcc82YJkD+g==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 27 Nov 2026 15:22:48 +0100
Subject: [PATCH RFC v2 26/35] spi: rtk-nor: Drop redundant checks
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
Message-Id: <20261127-macronix-upstreaming-spi-mem-cycles-v2-26-5c93f5e5d630@bootlin.com>
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
 drivers/spi/spi-rtk-nor.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi-rtk-nor.c b/drivers/spi/spi-rtk-nor.c
index 28fafa69cfbd..2fcd2172a0b4 100644
--- a/drivers/spi/spi-rtk-nor.c
+++ b/drivers/spi/spi-rtk-nor.c
@@ -316,9 +316,6 @@ static bool rtk_spi_supports_op(struct spi_mem *mem,
 	if (op->cmd.buswidth != 1)
 		return false;
 
-	if (op->cmd.dtr || op->addr.dtr || op->data.dtr)
-		return false;
-
 	if (op->addr.nbytes != 0) {
 		if (op->addr.buswidth > 1)
 			return false;

-- 
2.56.0

