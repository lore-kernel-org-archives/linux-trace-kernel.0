Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795789447;
	b=Dh+bqrxUUD0TXm0zOl6MjNORko3h24bZZQvl8dmPOuh75n/PDyL3JAfw/mJGQcOXYqMC
	 lUzKXMzmhA5pIoPH3orJyttD0qFhRFzF66fnLxCVk9K1oTTeE2LotgWVSNhGBOQ+Fd4xR
	 1D97QpJDGxkmjSacmc6xlf7a2QhvVlVyD6sv/On+lbSezi0K45r/cmR0/XbRnMiAkUNSp
	 kE57D6e01Z/t6TzfLyEtmdhKi3C2+bE5ei9Pwvwn+Vzfd6ZLI7fLCCIQBUWU9krMtNgYI
	 o14kKgIc9Igvl9bOnqj+WdPbwpxRpiwuqCUQggMouKxJRc7ob7RiCQi7+gBV+S/wY9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795789447;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=wxfJPUKHoAB+1K3wnXPXnqak814WKCu5TUfSaAEjIso=;
	b=WfYt0kZhC2UiZI+S56yat2eBQZ5mTAQIGkHpX5U0U+wYu/dGX4VJ2PZhkre4Mrbn8nbV
	 S9XDiBUlzC1pGK5VNIIND3tNIA35xhuj2YJOxk01V9TdublWHhXajQoDu8QZBlgUdsYnS
	 ozmAw7k2DsdoEsVSW+qsjFroqfHJjQXp1EzeFhnNaQ+p0zjI9FFyl5a2EYVcNSoWMqsgn
	 hw+rL+vpAkcS4iqsCmo4KKVw61vVa851+f5BpNnbh9YXAtt0Tt5PAAP2M0vtT1Z+4XHYP
	 R/iOWcPRG6BJxSt27oHuvfkNdi0p6HJKD6MUZ15W99vWBe3l6gRm7AMzCzUUZdPW0fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=KqziPh8l;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00248606A33C;
	Fri, 27 Nov 2026 14:24:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00248606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=KqziPh8l
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id AB1B51A0440;
	Fri, 27 Nov 2026 14:24:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 72CDF6049C;
	Fri, 27 Nov 2026 14:24:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1C07811E69006;
	Fri, 27 Nov 2026 15:23:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795789439; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=wxfJPUKHoAB+1K3wnXPXnqak814WKCu5TUfSaAEjIso=;
	b=KqziPh8ltiM8u5+b6eKfqHjpZwwL1tuSrz9B43KqmDBcTFYtGFxkYvIYsXji0ngHmJfQMz
	HMYknla3frw6GZAIimkPVVve5WfMCll0ltxhioVlYXjqQK8QDtC+0X4nyAizs1G2E8mjSx
	QEmiP3NpEAk1JuFMrlPs/jHoMSE3uRpjOgOXUHCyiijgIHx9/ZQG0DU/2WZILymrbq1sRP
	qgX5ttf/7/I1Ei7RuCVq0X1p4AtlqgzQ5mCqeZFZYv+l14QKJWryXuh/kRwtSZXUH+2o/P
	Br+32uJQRsmzsk7ElCYdt/m/ZNr1crLvAtt1D58vA61ocIx1A+3fg26Xcipd3g==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 27 Nov 2026 15:22:27 +0100
Subject: [PATCH RFC v2 05/35] spi: spi-mem: Sanitize mixed buswidth
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
Message-Id: <20261127-macronix-upstreaming-spi-mem-cycles-v2-5-5c93f5e5d630@bootlin.com>
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

Buswidth is allowed to evolve over phases. Many controllers strictly
apply the settings passed by the core. In practice for an X-Y-Z
operation where X, Y and Z represent the buswidth of the command,
address and data phase, respectively. We do not support:
- Y < X
- Z < Y
- Z < X

Make sure those conditions are sanitized early by the core, to avoid the
feeling that these needs to be checked in controller drivers. The
implementation also covers the dummy.nbytes case with the same logic.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-mem.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 25f795d5e9ba..a1f129c47698 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -216,6 +216,15 @@ bool spi_mem_default_supports_op(struct spi_mem *mem,
 			return false;
 	}
 
+	/* Bus width can only grow across phases, ie. 1-4-1, or 1-8-4 are not allowed */
+	if ((op->addr.nbytes && op->addr.buswidth < op->cmd.buswidth) ||
+	    (op->dummy.nbytes && op->dummy.buswidth < op->cmd.buswidth) ||
+	    (op->data.nbytes && op->data.buswidth < op->cmd.buswidth) ||
+	    (op->addr.nbytes && op->dummy.nbytes && op->dummy.buswidth < op->addr.buswidth) ||
+	    (op->addr.nbytes && op->data.nbytes && op->data.buswidth < op->addr.buswidth) ||
+	    (op->dummy.nbytes && op->data.nbytes && op->data.buswidth < op->dummy.buswidth))
+		return false;
+
 	if (op->data.ecc) {
 		if (!spi_mem_controller_is_capable(ctlr, ecc))
 			return false;

-- 
2.56.0

