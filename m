Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.90.104.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793899008;
	b=zJxHr6SrwluqmbvH3eYgZZnA+A4xMVuZx3nW8sVgKH895/Slm4XYU4TPmSHYVSKjuB9Z
	 6w4yGIo28aPRZ/RKHMyawPzh97Kf5UaAQ6HR/fl7AoZNgQpkYaT9aqhyrlRmmoMD6FHjw
	 LXjjBNF952pfSfpApNGq/vrN7HjJErxxRe8rt1IauQfmSYOV88sCQwQzbKtGhybnUaLBq
	 h52hRcWlOHbJoAFgerhGsg7oWL3RlyEbC2RNqkbVBEovjkKW5mD5TP/cq5SnQAsaJ7fe8
	 xYgUcBiHFwmlCuMMvW3hazw82MwTahYzrw2eRjKoRdnsrw2feKqmo/GQSvV9IKERUUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793899008;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=gg5b0dMeEslMw2aOATqbJoZiyPtuaE9d4fWSpcO4s5Q=;
	b=F7DEJsE6EmYiaWS3WDa0ZcFM467SctE3QVbhXRsfpoIC5bf4TFFNWUt2jS56PtvtJKBY
	 tHcWGEa9OLUqOnv5JBXUyCkqNuCTPcVFo2bvWni66mLd7WoGJrvocYaMmyBAg3+36K7g/
	 s5ErffDhrrES/vfPgt5TsAcU4FPzkUupCYmH7Y5f56TgRMdqeS81svFwjiJArRltFUdrw
	 eb5lAeDuGjtsWEC/fxGXIDtS2A9porDROnpiw3X3S+zpltTh60ObVDbIRgQ+nWbvKc0fV
	 eBNxVKickq2Lj0Z3MGFO3wZS/E6xH+Bd2UrVQWg/RjZUqk8KJoRv0UEzuVGpj+pWWlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=23.90.104.147
Received: from esa2.hc555-34.eu.iphmx.com (esa2.hc555-34.eu.iphmx.com [23.90.104.147])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3186A6083607;
	Thu,  5 Nov 2026 17:16:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3186A6083607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1793899014; x=1825435014;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=gnp8tA4y2rADZDVqbzjlmD3iUpQrfUNUuMLEH91Ykxc=;
  b=OsrA1F6DqSzdL9nbmdrjNI5tlORgYDWLlUgjDTyMPF71/ld3x6erWg08
   cXcf930sDodSNnOZWstbrj5957cQXXpByFNWBgabWYC1BgDOhn/G5spLz
   1vzcYQC/SiIQZ9imLYAMcm1j4zBu99+ozv1FB/82U9y1w3QOutryM1/0r
   u5puRIvjCPELcTeYDObByf8w59wuIh3EfPRkvrWWfo55paLAOlh9CjJWH
   cQv5tQlOF5wQyBroIMyZVMd93DXWkaGMXo3SAHrnZwGN9a9V5+2t9mg1G
   Q2P99m2qkCJwESAi4KCpAuRcfBTjg2/njY2xDYTEbMX9Y2OQkFXMNZzrb
   A==;
X-CSE-ConnectionGUID: NCGXBDD1Rt+T5depArDyFQ==
X-CSE-MsgGUID: TsBsbZlpSHC2pvO6LhLPMw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces01_data.me-corp.lan) ([146.255.191.134])
  by esa2.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 19:16:38 +0200
X-CSE-ConnectionGUID: MzRslvUbSRm3HKfNtijAFw==
X-CSE-MsgGUID: eHkOcAtOSD+a6mzwMtvCEw==
Received: from unknown (HELO epgd056.me-corp.lan) ([10.154.54.3])
  by ces01_data.me-corp.lan with SMTP; 05 Nov 2026 19:24:41 +0200
Received: by epgd056.me-corp.lan (sSMTP sendmail emulation); Thu, 05 Nov 2026 19:16:37 +0200
From: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Date: Thu, 05 Nov 2026 19:15:32 +0200
Subject: [PATCH RFC v3 11/14] i2c: nomadik: save I2C_CR register before
 resetting HW in IRQ handler
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
Message-Id: <20261105-i2c-fault-reporting-v3-11-515ad74ac4c9@mobileye.com>
References: <20261105-i2c-fault-reporting-v3-0-515ad74ac4c9@mobileye.com>
In-Reply-To: <20261105-i2c-fault-reporting-v3-0-515ad74ac4c9@mobileye.com>
To: Andi Shyti <andi.shyti@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Linus Walleij <linusw@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Dmitry Guzman <Dmitry.Guzman@mobileye.com>, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.16.0

On some interrupts, such as Bus Error interrupt or Arbitration Lost
interrupt, the interrupt handler calls init_hw() to reset the I2C
controller. This clears I2C_SR register value that might be used for
fault reporting.

Add i2c_sr field to nmk_i2c_dev structure, store there I2C_SR register
value before resetting the hardware, and use this value instead of
reading it directly in nmk_i2c_xfer_one() if it was read in IRQ handler.

Signed-off-by: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
---
 drivers/i2c/busses/i2c-nomadik.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index b9f839d5a6fa..f68d4cf7c0e7 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -193,6 +193,7 @@ struct i2c_nmk_client {
  * @xfer_done: xfer done boolean.
  * @has_32b_bus: controller is on a bus that only supports 32-bit accesses.
  * @timeout_usecs: Slave response timeout
+ * @i2c_sr: last read I2C_SR register value
  * @sm: speed mode
  * @stop: stop condition.
  * @xfer_wq: xfer done wait queue.
@@ -212,6 +213,7 @@ struct nmk_i2c_dev {
 	bool				xfer_done;
 	bool				has_32b_bus;
 	u32				timeout_usecs;
+	u32				i2c_sr;
 	enum i2c_freq_mode		sm;
 	int				stop;
 	struct wait_queue_head		xfer_wq;
@@ -652,6 +654,7 @@ static int nmk_i2c_xfer_one(struct nmk_i2c_dev *priv, u16 flags)
 {
 	int status;
 
+	priv->i2c_sr = 0;
 	if (flags & I2C_M_RD) {
 		/* read operation */
 		priv->cli.operation = I2C_READ;
@@ -663,12 +666,22 @@ static int nmk_i2c_xfer_one(struct nmk_i2c_dev *priv, u16 flags)
 	}
 
 	if (status || priv->result) {
-		u32 i2c_sr;
 		u32 cause;
+		/*
+		 * On some errors, the interrupt handler reads I2C_SR register value,
+		 * stores it into priv->i2c_sr and resets the hardware with init_hw().
+		 * If it is done, we use this value. The value cannot be 0 because
+		 * I2C_SR_STATUS after transfer start may be I2C_ON_GOING, I2C_OK or
+		 * I2C_ABORT but not I2C_NOP.
+		 * If priv->i2c_sr == 0, it was not updated since transmission start, so
+		 * init_hw() was not called and the hardware register I2C_SR still holds
+		 * correct value.
+		 */
+		if (!priv->i2c_sr)
+			priv->i2c_sr = readl(priv->virtbase + I2C_SR);
 
-		i2c_sr = readl(priv->virtbase + I2C_SR);
-		if (FIELD_GET(I2C_SR_STATUS, i2c_sr) == I2C_ABORT) {
-			cause = FIELD_GET(I2C_SR_CAUSE, i2c_sr);
+		if (FIELD_GET(I2C_SR_STATUS, priv->i2c_sr) == I2C_ABORT) {
+			cause = FIELD_GET(I2C_SR_CAUSE, priv->i2c_sr);
 			dev_dbg(&priv->adev->dev, "%s\n",
 				cause >= ARRAY_SIZE(abort_causes) ?
 				"unknown reason" :
@@ -879,6 +892,7 @@ static irqreturn_t i2c_irq_handler(int irq, void *arg)
 			priv->result = -EIO;
 			dev_err(dev, "%lu bytes still remain to be xfered\n",
 				priv->cli.count);
+			priv->i2c_sr = readl(priv->virtbase + I2C_SR);
 			init_hw(priv);
 		}
 		priv->xfer_done = true;
@@ -890,6 +904,7 @@ static irqreturn_t i2c_irq_handler(int irq, void *arg)
 	/* Master Arbitration lost interrupt */
 	case I2C_IT_MAL:
 		priv->result = -EAGAIN;
+		priv->i2c_sr = readl(priv->virtbase + I2C_SR);
 		init_hw(priv);
 
 		i2c_set_bit(priv->virtbase + I2C_ICR, I2C_IT_MAL);
@@ -906,11 +921,9 @@ static irqreturn_t i2c_irq_handler(int irq, void *arg)
 	 */
 	case I2C_IT_BERR:
 	{
-		u32 sr;
-
-		sr = readl(priv->virtbase + I2C_SR);
+		priv->i2c_sr = readl(priv->virtbase + I2C_SR);
 		priv->result = -EIO;
-		if (FIELD_GET(I2C_SR_STATUS, sr) == I2C_ABORT)
+		if (FIELD_GET(I2C_SR_STATUS, priv->i2c_sr) == I2C_ABORT)
 			init_hw(priv);
 
 		i2c_set_bit(priv->virtbase + I2C_ICR, I2C_IT_BERR);
@@ -927,6 +940,7 @@ static irqreturn_t i2c_irq_handler(int irq, void *arg)
 	 */
 	case I2C_IT_TXFOVR:
 		priv->result = -EIO;
+		priv->i2c_sr = readl(priv->virtbase + I2C_SR);
 		init_hw(priv);
 
 		dev_err(dev, "Tx Fifo Over run\n");

-- 
2.43.0

