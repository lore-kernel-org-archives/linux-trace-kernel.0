Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795789418;
	b=nIoSVHJ05h0F7lD3irnd2sJ9KSDWwtBBDFO5wtODZ4qEVqfVO5VKiWQ284laDEE8bme/
	 UWJjY0kJWQ17EOG2hiruPMF+fl7SyHb/JFVfkL/e8mearoxhfb5GGTZwkWHb+LLPN0phH
	 jzKQT8UzjJO5W59azMI/TOWHkFr/9CjBiEV3yOtxfXxwmfXshw0TJE96X+6T4xKE2yKc5
	 NXp75DQo4SUG09v5tYbawSzKu+ak6D/Y82fvJw5YyLN7q4Kad+TJYhqwgcFtqE0VLWvNG
	 Q+nH6q+hYPjp9SBP6t3mGIG235WdgKkxVzpLtSO0bWkaHY8+1WrN8rqx9XQDLU8FRYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795789418;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=YL0LWj0GcbHfK49EIrBlf9jCG/E4YqaKYD91ZbSxEeE=;
	b=KSrNmIu8QUqTi51FJQSI9eVTd3znoSHwei7qsnGh58x74A+Tar8zbw8M25NxJ61aKEPR
	 a2btIzkDCyNexKd8bokGvRDOH1sN2DTsf6TtOueUUGtG2tvR2UHaGlL7+SixEVmfeRiTG
	 uLje/98DPi/Vzh38e0YCM/r/vLpT0N8io/d4cKkWKahuoY22yPIFgddtndtVNQopAdGiB
	 MSMYxkNSv/NW2qtgxHk2VEU3v2p9k3MnjXfwoXBXGTWT8/JzvfAlBt+QPI3ddjkzmRAkP
	 njdPhDNP6/PlUBFnlBHHKLe+wRGewxNZvGsu/w058cMvcbAu3rGre6v+IeOUEtK2KnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=qQwaRkz1;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360BE606A323
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Nov 2026 14:23:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 360BE606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=qQwaRkz1
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 312B0C2AC4D;
	Fri, 27 Nov 2026 14:23:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 663A36049C;
	Fri, 27 Nov 2026 14:23:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4BC0E11E69006;
	Fri, 27 Nov 2026 15:23:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795789408; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=YL0LWj0GcbHfK49EIrBlf9jCG/E4YqaKYD91ZbSxEeE=;
	b=qQwaRkz1NcTtKMJ3rcaD9AaD0G88VYsq9rRXNdRhGxFwrpHJQNa4Qan2umCsy+PgAzkjJi
	YbIeVsEiyfbdLNBIWdd319ntMr1ek7feEq/y0wE2JDkJRgY51bvte2zxJidEhNgWWLyVtt
	5fT4uEQYUESgkzfJYZG1S1+J6VsQWhjPWLBP8TGnXE4GP52SSYhPaagtRkLcR046vEep9V
	/7NBqPAyP0q9YFqATDPFlJR4ttvE+XUEYcuGcu+Tfz1BEYBsfm+/R6dvMss+C4T3MmNQMB
	LK48fjtnD5qHJws2gtwCMBizByQA/gXTJ0ray9Gwg35xbRdb/lRy8A95FuL9CQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 27 Nov 2026 15:22:24 +0100
Subject: [PATCH RFC v2 02/35] spi: spi-mem: Fix the odd byte count error
 message
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
Message-Id: <20261127-macronix-upstreaming-spi-mem-cycles-v2-2-5c93f5e5d630@bootlin.com>
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

The check rejects odd byte counts but the error message claims that
even byte numbers are not allowed. Fix the wording.

Fixes: 8618271887ca ("spi: spi-mem: Limit octal DTR constraints to octal DTR situations")
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 648982350863..f4d71f740163 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -188,7 +188,7 @@ bool spi_mem_default_supports_op(struct spi_mem *mem,
 			    (op->dummy.nbytes % 2) ||
 			    (op->data.nbytes % 2)) {
 				dev_err(&ctlr->dev,
-					"Even byte numbers not allowed in octal DTR operations\n");
+					"Odd byte numbers not allowed in octal DTR operations\n");
 				return false;
 			}
 		}

-- 
2.56.0

