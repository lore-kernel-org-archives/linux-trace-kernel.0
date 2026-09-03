Received: from esa2.hc555-34.eu.iphmx.com (esa2.hc555-34.eu.iphmx.com [23.90.104.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EAF38F949
	for <linux-trace-kernel@vger.kernel.org>; Thu,  3 Sep 2026 05:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.90.104.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788413996; cv=none; b=TOatOduv6CdlvCzJzrmRM4uIZQc0jqLGR2z25KEjcm9L6y073pg+6kD4nwJXJHDTV2rB0iAbEppQLxRBX74NPbYe9ggV9u+4CmHfgnUYWanfm5JhbuwhMY4B/TRl1luiebDggYKYdlh5fv6jyZclPVJ7/RBgfYnBNMH3JtjpNvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788413996; c=relaxed/simple;
	bh=yEoKYkqAzY02mykJ1us0DXeoBWZGGZzvI9Pqcx6SKBY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=COssT4AGyo1VOpuz+wSX3a7i4DALVp1ksrYy1RClJX9WRSAc8ZsaW0tnnTqoO/3Oe3UWFd2EY+Rczx1rFVGueZV9S5D+jqyzG73FWoojBl4eTwV6gPQz7ezY/6KUfg8+jABFJYKwNuTECrNhyKu7a7zrmO4GQGlDtVc/ApMRf/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com; spf=pass smtp.mailfrom=mobileye.com; dkim=fail (0-bit key) header.d=mobileye.com header.i=@mobileye.com header.b=Cjk9zi+p reason="key not found in DNS"; arc=none smtp.client-ip=23.90.104.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mobileye.com header.i=@mobileye.com header.b="Cjk9zi+p"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1788413993; x=1819949993;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=yEoKYkqAzY02mykJ1us0DXeoBWZGGZzvI9Pqcx6SKBY=;
  b=Cjk9zi+psKSpPtJZ8M7KTcDNfF0vPBw7PzNwBTx0STKPa6LSOIa3Le6z
   xeDOBoekV7vcyL7ZPJhdjlusIoEOunspztZZ28/QQSR5ZdAJqDluFNRlA
   qQTzXnvqHPotKdIYpdCP06eH3OUGoo9DjpdUjnq2f0fQYohVK2rnjbHSn
   +P0heUdo7+NNSxWGgEXgnurqeHrVlMEy8l9jtrg+gKq27tgtwSKY+0PzC
   tM9QDWgAiVqd17mX0A7QaidYvUsMj4VovQy/n5QamGpl2vD1HmklX0R+p
   a+80KluBROTTALnifJ7tNhnFX1kVu7OXXZEtfsuDmmK6UKA5i4TwuFFkv
   g==;
X-CSE-ConnectionGUID: WLsDcoMiRqeta1S+3AaaXA==
X-CSE-MsgGUID: uTwTKCDYSrSG2+vTWAA4vw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces03_data.me-corp.lan) ([146.255.191.134])
  by esa2.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 08:38:41 +0300
X-CSE-ConnectionGUID: iDBMjCADQDiUsQoKA31dWg==
X-CSE-MsgGUID: pmROrQ4KQ02cYRqFDneMXg==
Received: from unknown (HELO epgd056.me-corp.lan) ([10.154.54.3])
  by ces03_data.me-corp.lan with SMTP; 03 Sep 2026 08:45:08 +0300
Received: by epgd056.me-corp.lan (sSMTP sendmail emulation); Thu, 03 Sep 2026 08:38:40 +0300
From: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Date: Thu, 03 Sep 2026 08:38:11 +0300
Subject: [PATCH v2 04/12] i2c: nomadik: return proper fault codes
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-i2c-fault-reporting-v2-4-fedeb91792e6@mobileye.com>
References: <20260903-i2c-fault-reporting-v2-0-fedeb91792e6@mobileye.com>
In-Reply-To: <20260903-i2c-fault-reporting-v2-0-fedeb91792e6@mobileye.com>
To: Andi Shyti <andi.shyti@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Linus Walleij <linusw@kernel.org>, 
 Mika Westerberg <mika.westerberg@linux.intel.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Dmitry Guzman <Dmitry.Guzman@mobileye.com>
X-Mailer: b4 0.14.2

I2C documentation Documentation/i2c/fault-codes.rst defines fault codes
for different negative results in I2C transmittion. Previously,
i2c-nomadik driver didn't implement them properly - it returned
ETIMEDOUT on most errors and EIO on master arbitration lost.

To comply with the documentation, return the proper fault codes for
different conditions, namely:

- EAGAIN if arbitration lost
- EOVERFLOW if message is too long (>2047 bytes)
- ENXIO if target address is not acknowledged
- EIO on other errors detected by controller (for example, NACK on data)
- ETIMEDOUT if driver gets timeout waiting for message completion
  without any fault condition detected by the controller (for example,
too long message, or SDA/SCL line stuck on 0).

Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
---
 drivers/i2c/busses/i2c-nomadik.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index ca9366e09e7125b9c86dd0f995162018df56634d..a3cef4b66190a9e45898e25867a3ceefce5d3d0a 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -226,6 +226,18 @@ static const char *abort_causes[] = {
 	"overflow, maxsize is 2047 bytes",
 };
 
+/* Linux fault codes for controller abort causes */
+static int fault_codes[] = {
+	ENXIO,
+	EIO,
+	EIO,
+	EAGAIN,
+	EIO,
+	EIO,
+	EOVERFLOW,
+	EIO
+};
+
 static inline void i2c_set_bit(void __iomem *reg, u32 mask)
 {
 	writel(readl(reg) | mask, reg);
@@ -653,6 +665,8 @@ static int nmk_i2c_xfer_one(struct nmk_i2c_dev *priv, u16 flags)
 				cause >= ARRAY_SIZE(abort_causes) ?
 				"unknown reason" :
 				abort_causes[cause]);
+			priv->result = -fault_codes[cause];
+			status = priv->result;
 		}
 
 		init_hw(priv);
@@ -865,7 +879,7 @@ static irqreturn_t i2c_irq_handler(int irq, void *arg)
 
 	/* Master Arbitration lost interrupt */
 	case I2C_IT_MAL:
-		priv->result = -EIO;
+		priv->result = -EAGAIN;
 		init_hw(priv);
 
 		i2c_set_bit(priv->virtbase + I2C_ICR, I2C_IT_MAL);

-- 
2.43.0

