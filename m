Received: from esa4.hc555-34.eu.iphmx.com (esa4.hc555-34.eu.iphmx.com [207.54.77.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C27D317153;
	Tue, 23 Jun 2026 16:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.77.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782232347; cv=none; b=OldaYci+9aPYlX5qrkLogjC2fF7H0AJqiYKPJ7mfxbp4sodAa0DmMz27gIVyP3SfI58hcp1sPzznZMa9fxlzupUVrLhGwcViDuHh9g/66/jD4993c1IeezR9UF4SmZlDQrIjlJl7uEnenAInX8nvG8rRLwsCIvZf4Y849Bw3qAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782232347; c=relaxed/simple;
	bh=b7Dymf517kF4quGrb7HxG94OSgoCfOvil6bI35Zl1p0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hwOAdSixCFLb+/x/66wEpx9yPVCHNE5Z6WId/L15lfmYmBzxdUSK/qilvUWSmheAvPkbvy0Fp6D+5lc7eaNJx4xkzY6JFTEVjezx/0G9rsv6/Q1xM8CQjXKzdjt2soUHdmAJGSAfXGqk1Wui02Lvsih5PWUXcThcZKbT0O9RKjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com; spf=pass smtp.mailfrom=mobileye.com; dkim=fail (0-bit key) header.d=mobileye.com header.i=@mobileye.com header.b=D/IfpeNE reason="key not found in DNS"; arc=none smtp.client-ip=207.54.77.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mobileye.com header.i=@mobileye.com header.b="D/IfpeNE"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1782232345; x=1813768345;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=b7Dymf517kF4quGrb7HxG94OSgoCfOvil6bI35Zl1p0=;
  b=D/IfpeNEmj94mzOl7K+zfIjLkKZ0E0MeIO8Ya8945jFMXTWNCAvzasfo
   hTTLZ6ISus1GkE1UaZlPTvro56KY6lQg8IRFmAS1+4/Jbk8Dj+LMzP/JV
   +7GThVF6O0apQgtnCr0OwYdUEz4M30RH0iab/twS4aYvhzDtk60eNAWFP
   ylg8o1PfnbXkdGnZhjgAxGO3mza9qhrRAHhOqSA5tztnS1XUyh8XiU2bg
   Ha7j/DEAZOHvLKCsY2qTEjl3XxP9SGIbkVCW5J/QZjtVqFRzZ1xNY+qq4
   Ib6k8TA7sjDge+98+TBLZcX1Mu277sPZtn3Wjo6zzUeURPVcvVEn5oZ3H
   Q==;
X-CSE-ConnectionGUID: cVg/OfupQMGiDkenHRR6qw==
X-CSE-MsgGUID: kVkWamKhQvuU/qKbu6Odyw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces02_data.me-corp.lan) ([146.255.191.134])
  by esa4.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 19:32:23 +0300
X-CSE-ConnectionGUID: 1FpYdYBbQbWRD79i76cAKQ==
X-CSE-MsgGUID: ijERLh72R7CTM4JgnseRvw==
Received: from unknown (HELO epgd056.me-corp.lan) ([10.154.54.3])
  by ces02_data.me-corp.lan with SMTP; 23 Jun 2026 19:37:33 +0300
Received: by epgd056.me-corp.lan (sSMTP sendmail emulation); Tue, 23 Jun 2026 19:32:22 +0300
From: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Date: Tue, 23 Jun 2026 19:31:51 +0300
Subject: [PATCH 4/7] i2c: nomadik: return proper fault codes
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260623-i2c-fault-reporting-v1-4-6db1a8aabf18@mobileye.com>
References: <20260623-i2c-fault-reporting-v1-0-6db1a8aabf18@mobileye.com>
In-Reply-To: <20260623-i2c-fault-reporting-v1-0-6db1a8aabf18@mobileye.com>
To: Andi Shyti <andi.shyti@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Linus Walleij <linusw@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
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

Signed-off-by: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
---
 drivers/i2c/busses/i2c-nomadik.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index 3eb06988c026e5c573fcf55d83de7136b5ca7ac9..e19ace904e79cd2d83171d9f38fc103a6c5e023b 100644
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

