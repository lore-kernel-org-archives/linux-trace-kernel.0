Received: from esa2.hc555-34.eu.iphmx.com (esa2.hc555-34.eu.iphmx.com [23.90.104.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16093911A8;
	Thu,  3 Sep 2026 05:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.90.104.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788413995; cv=none; b=jPtf9kCw8g3F18qC9Zx+9jQabLXR0zh7tIuv8pMIkwsjMxnH2JbaHKpnfapnbmjs/Yd4HGtKof1t38X+Ds42vH2IlgULDwuXftnl0D2adcqcQtm0VJxQvUFGfbcOBR2ma5zy3aNLy+wgMj2Ui44N4xyqexphBeXU4l5s8EU3T8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788413995; c=relaxed/simple;
	bh=laNov46rEhoHC/594iUdtbtLJH8byqqzWUsDYSOQ0MQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SQd/Rf/KdL4kbAiEn7y2CxiZIQDPBGeJ/KiObCP6bUE6EyS1z2v2zqbukjWQKrpbhMGbb+NHo2YJcYkOqtvko0LtNBiBMVFVE8JDD8up1Jxr4SGf0BnCAtlIzLXRtiKCSOy0bFVyP0BthqPcPtxQTAjWDUdc+CsfD78R31+cGPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com; spf=pass smtp.mailfrom=mobileye.com; dkim=fail (0-bit key) header.d=mobileye.com header.i=@mobileye.com header.b=KgGP0UVS reason="key not found in DNS"; arc=none smtp.client-ip=23.90.104.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mobileye.com header.i=@mobileye.com header.b="KgGP0UVS"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1788413992; x=1819949992;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=laNov46rEhoHC/594iUdtbtLJH8byqqzWUsDYSOQ0MQ=;
  b=KgGP0UVSlNncCVEY4DvDKRH2T/WiLcx6NYJd0U3hdIr9z1tT2Qv9nLVZ
   uXcCgRTzOgNW4jlbmjEJCRqQ0uZM0J4UvG7XQHkp6sW+FUPGYePWo/jNQ
   bnD+4jmpRcK5zfoIf//mGFwulZkANNmNLl0t1lwtSem5pAiZCQ9LUVy8T
   Ukhd+I+1S6d/sJmMfJ0wyKtcDCZThjipCFDQZwcXyOT+fMR1/s8qqeVis
   dez783p53hNd1iTxSa3Ulx+YOZHXuCnSVTshGFAp1vWsSnG5an+10+3G+
   11dh8THeDna5pHxy97x3aDuEcyS9uKqqHrLW6naBdAvFKaw7kNJPuYQNz
   A==;
X-CSE-ConnectionGUID: WLsDcoMiRqeta1S+3AaaXA==
X-CSE-MsgGUID: TAJc5vCoREOTFPUhgZxbUg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces03_data.me-corp.lan) ([146.255.191.134])
  by esa2.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 08:38:38 +0300
X-CSE-ConnectionGUID: KLgcRyVFTouh6uKzqEEf/Q==
X-CSE-MsgGUID: WQqKPgDaTeGS1ta5vi3O2w==
Received: from unknown (HELO epgd056.me-corp.lan) ([10.154.54.2])
  by ces03_data.me-corp.lan with SMTP; 03 Sep 2026 08:45:06 +0300
Received: by epgd056.me-corp.lan (sSMTP sendmail emulation); Thu, 03 Sep 2026 08:38:37 +0300
From: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Date: Thu, 03 Sep 2026 08:38:09 +0300
Subject: [PATCH v2 02/12] i2c: nomadik: optimize struct layout, change
 unsigned char into u8
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-i2c-fault-reporting-v2-2-fedeb91792e6@mobileye.com>
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

Change type of `tft` and `rft` fields of `nmk_i2c_dev` structure from
`unsigned char` to `u8` and `buffer` field of `i2c_nmk_client` structure
from `unsigned char *` to `u8 *`.

Put two bool variables `xfer_done` and `has_32b_bus` and two u8 variables
`tft` and `rft` together in order to reduce struct size wasted for padding.

Signed-off-by: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
---
 drivers/i2c/busses/i2c-nomadik.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index c3878670da9cfa462b66919ddc58b55cc78db6e5..45b4815b094524d9a8de69376e2933171541611a 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -170,7 +170,7 @@ enum i2c_operating_mode {
 struct i2c_nmk_client {
 	unsigned short		slave_adr;
 	unsigned long		count;
-	unsigned char		*buffer;
+	u8			*buffer;
 	unsigned long		xfer_bytes;
 	enum i2c_operation	operation;
 };
@@ -187,13 +187,13 @@ struct i2c_nmk_client {
  * @clk_freq: clock frequency for the operation mode
  * @tft: Tx FIFO Threshold in bytes
  * @rft: Rx FIFO Threshold in bytes
+ * @xfer_done: xfer done boolean.
+ * @has_32b_bus: controller is on a bus that only supports 32-bit accesses.
  * @timeout_usecs: Slave response timeout
  * @sm: speed mode
  * @stop: stop condition.
  * @xfer_wq: xfer done wait queue.
- * @xfer_done: xfer done boolean.
  * @result: controller propogated result.
- * @has_32b_bus: controller is on a bus that only supports 32-bit accesses.
  */
 struct nmk_i2c_dev {
 	struct i2c_vendor_data		*vendor;
@@ -204,15 +204,15 @@ struct nmk_i2c_dev {
 	struct clk			*clk;
 	struct i2c_nmk_client		cli;
 	u32				clk_freq;
-	unsigned char			tft;
-	unsigned char			rft;
+	u8				tft;
+	u8				rft;
+	bool				xfer_done;
+	bool				has_32b_bus;
 	u32				timeout_usecs;
 	enum i2c_freq_mode		sm;
 	int				stop;
 	struct wait_queue_head		xfer_wq;
-	bool				xfer_done;
 	int				result;
-	bool				has_32b_bus;
 };
 
 /* controller's abort causes */

-- 
2.43.0

