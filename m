Received: from esa2.hc555-34.eu.iphmx.com (esa2.hc555-34.eu.iphmx.com [23.90.104.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CA137702C;
	Thu,  3 Sep 2026 05:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.90.104.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788413934; cv=none; b=S7D+8400pYPBI2eKPU63huKa/51yq7y5GyhygJmJbPriins62Ds5Y2P3aGCWuLLPIzlVLkS4KHXyldT+ClXT9HDBw21XF2t6xGeddkx/0f4lAHai7BuQtzWUMpgnWuqIZBlYUVVfLUZuNHVUFpBMBAmfP58Kjct1ge8sd4AEkSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788413934; c=relaxed/simple;
	bh=PNI7MueqC5h/YY2PhbaG1O/1pTebA97FxujwfRwmfw0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QKpd+yARxAZjonk20l6SDj5UrlBkw3tAOxeQIYlgkHByFDmnG8/+JET4xy139tV3bhe4Ef+dS/pSVBZf0um28gL/yXrnb5DDuNlWq3ZWKjdp7j2fYtML5i0hUtsLh0VLAddqVAPwxA8ltEh8uNfFGc1ynoq76b0iblJxSiPeqMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com; spf=pass smtp.mailfrom=mobileye.com; dkim=fail (0-bit key) header.d=mobileye.com header.i=@mobileye.com header.b=CyU9ZQJy reason="key not found in DNS"; arc=none smtp.client-ip=23.90.104.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mobileye.com header.i=@mobileye.com header.b="CyU9ZQJy"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1788413929; x=1819949929;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=PNI7MueqC5h/YY2PhbaG1O/1pTebA97FxujwfRwmfw0=;
  b=CyU9ZQJytgq1yNnRsywUfdJUbQiYZEi1SN8YKx6itJtISJKGxNAHZjv5
   0NToH4DIbxEUrFP8dhnIXta6sc4hdP3juhumEcRXcJeZFhfqafJpPFziT
   0t2kRmieu3cNN4FIVzgEv8LPwmdtAzsc6pAYHyyh9C7WSqe/BHFzwklLN
   ZD0l/1DVz8I+NDHDKh/6JNfxuTzJ3l40CBr4CCD6wE7ARaIfev2tUT9Aq
   wPhyL912rj0BJBrkeasVbefsFUW5Qj1OszR7ZkvKzBiuFn9iptB1mNxsS
   ITcQGZTRBQqFibFkkdNBtRNG0YiyGwwqTpu3Yo7/fRwJJLHIQxUX2G2dM
   g==;
X-CSE-ConnectionGUID: cXTfemmQQHW5DE+hyRYMiQ==
X-CSE-MsgGUID: U4v0nJcpRyW0gwHdYcGigA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces01_data.me-corp.lan) ([146.255.191.134])
  by esa2.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 08:38:45 +0300
X-CSE-ConnectionGUID: +5PfWTSgRT+W4mKBZF2RYg==
X-CSE-MsgGUID: VzPzu2k/TLmp0Oeb2pFa8w==
Received: from unknown (HELO epgd056.me-corp.lan) ([10.154.54.3])
  by ces01_data.me-corp.lan with SMTP; 03 Sep 2026 08:45:25 +0300
Received: by epgd056.me-corp.lan (sSMTP sendmail emulation); Thu, 03 Sep 2026 08:38:44 +0300
From: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Date: Thu, 03 Sep 2026 08:38:15 +0300
Subject: [PATCH v2 08/12] i2c: designware: return proper fault codes
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-i2c-fault-reporting-v2-8-fedeb91792e6@mobileye.com>
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
i2c-designware driver didn't implement them properly - it returned
EREMOTEIO on NACK either on address or data phase instead of ENXIO and
EIO respectively, and EINVAL instead of EOPNOTSUPP if a message cannot be
sent due to controller hardware limitations.

To comply with the documentation, return the proper fault codes for
different conditions, namely:

- EOPNOTSUPP if the controller cannot transfer the message sequence
  requested (for example, target address change without STOP condition)
- ENXIO if target address is not acknowledged
- EIO on other faults detected by controller (for example, NACK on data)

Signed-off-by: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
---
 drivers/i2c/busses/i2c-designware-common.c | 8 ++++++--
 drivers/i2c/busses/i2c-designware-core.h   | 3 +--
 drivers/i2c/busses/i2c-designware-master.c | 2 +-
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
index a1eca6cd4b75e9a76f2fc10afba8877d2b45417d..e934bcbe766042483874b3e43d10ffff30c59e04 100644
--- a/drivers/i2c/busses/i2c-designware-common.c
+++ b/drivers/i2c/busses/i2c-designware-common.c
@@ -776,11 +776,15 @@ int i2c_dw_handle_tx_abort(struct dw_i2c_dev *dev)
 	unsigned long abort_source = dev->abort_source;
 	int i;
 
-	if (abort_source & DW_IC_TX_ABRT_NOACK) {
+	if (abort_source & (DW_IC_TX_ABRT_ADDR_NOACK | DW_IC_TX_ABRT_TXDATA_NOACK)) {
 		for_each_set_bit(i, &abort_source, ARRAY_SIZE(abort_sources))
 			dev_dbg(dev->dev,
 				"%s: %s\n", __func__, abort_sources[i]);
-		return -EREMOTEIO;
+
+		if (abort_source & DW_IC_TX_ABRT_TXDATA_NOACK)
+			return -EIO;
+		else
+			return -ENXIO;
 	}
 
 	for_each_set_bit(i, &abort_source, ARRAY_SIZE(abort_sources))
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index 2c929a6e8da2a35b3b2d8ad886e326e2df285927..025311c8662c612aaaf772fb223af38278217c90 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -112,10 +112,9 @@
 #define DW_IC_RX_ABRT_SLAVE_ARBLOST		BIT(ABRT_SLAVE_ARBLOST)
 #define DW_IC_RX_ABRT_SLAVE_FLUSH_TXFIFO	BIT(ABRT_SLAVE_FLUSH_TXFIFO)
 
-#define DW_IC_TX_ABRT_NOACK			(DW_IC_TX_ABRT_7B_ADDR_NOACK | \
+#define DW_IC_TX_ABRT_ADDR_NOACK		(DW_IC_TX_ABRT_7B_ADDR_NOACK | \
 						 DW_IC_TX_ABRT_10ADDR1_NOACK | \
 						 DW_IC_TX_ABRT_10ADDR2_NOACK | \
-						 DW_IC_TX_ABRT_TXDATA_NOACK | \
 						 DW_IC_TX_ABRT_GCALL_NOACK)
 
 struct clk;
diff --git a/drivers/i2c/busses/i2c-designware-master.c b/drivers/i2c/busses/i2c-designware-master.c
index a1bcc3797e4ffef0edb9d3e978eab20a3c09d6aa..d10f46cf4aa44344fa1c53b9b8798a8b0f0c193c 100644
--- a/drivers/i2c/busses/i2c-designware-master.c
+++ b/drivers/i2c/busses/i2c-designware-master.c
@@ -894,7 +894,7 @@ i2c_dw_xfer_common(struct dw_i2c_dev *dev, struct i2c_msg msgs[], int num)
 		 */
 		for (cnt = 1; ; cnt++) {
 			if (!i2c_dw_msg_is_valid(dev, msgs_part, cnt - 1)) {
-				ret = -EINVAL;
+				ret = -EOPNOTSUPP;
 				break;
 			}
 

-- 
2.43.0

