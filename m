Received: from esa1.hc555-34.eu.iphmx.com (esa1.hc555-34.eu.iphmx.com [23.90.104.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E1A30FF27;
	Tue, 23 Jun 2026 16:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.90.104.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782232358; cv=none; b=MIjH12IHzG8zeM5p22JtIRD589l/BWDimyJCOozTbI3v/+vIpr8+/n+u9VGQzOCFvjpOycD4CmetubWOflku3IJvvBB/8iwUMkl1mWQp9sIzm7wbaEUhl6SiK1uaQ0LPh+YYYmINeBuv5Fz4yRHcAnyzBDiW5dHA391lGtxJuJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782232358; c=relaxed/simple;
	bh=C/vv+Wd+jN0eObHLm0dfYoxQnpT01lrFMvaEEaQBakM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hcC5IQ9PQ4td0F06lfRyILMfts+PzJkA4gXjJ0r/RonBzEET1zTkpdNofSyYe4JP+h/w5pSNo1W2pMJPAZ7LgJ8ksXlW9AJtZ686Ns2ph4xuDSTZz2KpN7VAQ8bxJ9bz+HbYfBdlaG6Cyb0w7gfbEyVfprU85PIisGyBS+1JBgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com; spf=pass smtp.mailfrom=mobileye.com; dkim=fail (0-bit key) header.d=mobileye.com header.i=@mobileye.com header.b=mnYlzqlB reason="key not found in DNS"; arc=none smtp.client-ip=23.90.104.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mobileye.com header.i=@mobileye.com header.b="mnYlzqlB"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1782232350; x=1813768350;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=C/vv+Wd+jN0eObHLm0dfYoxQnpT01lrFMvaEEaQBakM=;
  b=mnYlzqlBgiXls793tQ5qWRLw1ETqZyyt+PbMBzuUbSbG2H3m0+J94Ti+
   bihBP83MEIy2X7/0UYbV5P9sYI/TrmPHH0lbpZ0Boh57EqDkrVQ3DT2/c
   ToLPE3TZ+svDWl6llYdRbv2j6VssF0FBCsVQose+ySHJn0g4qqUhQ+wsU
   sYmDZkSPVJva4AswqPDftiRBi5XUS2HoxRn4r6BbEetaRD9GxM+zagDYs
   LlCE1JEN4uBpowpPRc05/c0e1zd2wLaZNiVgqXEblYJrF2qp2JzcFduPr
   wsE7uLUaXWmwpvO8PKOlt8mNaZC0ME4d27d+WcmLMsP9iIZzggRlt3C3Y
   g==;
X-CSE-ConnectionGUID: 94snKhe5SHqNCVFQZ3FOhQ==
X-CSE-MsgGUID: W9FMqoJwRsiTgQtBrH6W0w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces03_data.me-corp.lan) ([146.255.191.134])
  by esa1.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 19:32:26 +0300
X-CSE-ConnectionGUID: n6p33+ChQhK1KrZJ32EwkQ==
X-CSE-MsgGUID: uHMMXYjgTTmw41CIMvGwVA==
Received: from unknown (HELO epgd056.me-corp.lan) ([10.154.54.2])
  by ces03_data.me-corp.lan with SMTP; 23 Jun 2026 19:37:27 +0300
Received: by epgd056.me-corp.lan (sSMTP sendmail emulation); Tue, 23 Jun 2026 19:32:25 +0300
From: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Date: Tue, 23 Jun 2026 19:31:54 +0300
Subject: [PATCH 7/7] i2c: nomadik: add support for I2C_XFER_V2 - detailed
 fault reporting
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260623-i2c-fault-reporting-v1-7-6db1a8aabf18@mobileye.com>
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

I2C_XFER_V2 is a new API that allows I2C clients to get the detailed
report in case of transmission failure. Previously, the only information
returned by I2C bus controller was the error code; there was no way to
find out how many messages or bytes in a certain message have been sent
or received until the fault condition occurred.

This commit introduces support of this feature in i2c-nomadik driver.

Signed-off-by: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
---
 drivers/i2c/busses/i2c-nomadik.c | 37 +++++++++++++++++++++++++++++++------
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index 9cff0c2757fafeaf809395e02a5e754570f65e08..1cf03d634fdc856dc335a58597e0fd31ab077078 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -197,6 +197,7 @@ struct i2c_nmk_client {
  * @stop: stop condition.
  * @xfer_wq: xfer done wait queue.
  * @result: controller propogated result.
+ * @bytes_cplt: number of bytes completed in the message that caused a fault.
  */
 struct nmk_i2c_dev {
 	struct i2c_vendor_data		*vendor;
@@ -216,6 +217,7 @@ struct nmk_i2c_dev {
 	int				stop;
 	struct wait_queue_head		xfer_wq;
 	int				result;
+	int				bytes_cplt;
 };
 
 /* controller's abort causes */
@@ -529,6 +531,8 @@ static int read_i2c(struct nmk_i2c_dev *priv, u16 flags)
 	int status = 0;
 	bool xfer_done;
 
+	priv->cli.xfer_bytes = 0;
+
 	mcr = load_i2c_mcr_reg(priv, flags);
 	writel(mcr, priv->virtbase + I2C_MCR);
 
@@ -653,6 +657,7 @@ static int nmk_i2c_xfer_one(struct nmk_i2c_dev *priv, u16 flags)
 {
 	int status;
 
+	priv->bytes_cplt = 0;
 	if (flags & I2C_M_RD) {
 		/* read operation */
 		priv->cli.operation = I2C_READ;
@@ -678,6 +683,16 @@ static int nmk_i2c_xfer_one(struct nmk_i2c_dev *priv, u16 flags)
 			status = priv->result;
 		}
 
+		if (flags & I2C_M_RD) {
+			/* For READ messages, return the number of bytes read from FIFO */
+			priv->bytes_cplt = priv->cli.xfer_bytes;
+		} else {
+			/* For WRITE messages, return the number of bytes sent on bus */
+			priv->bytes_cplt = FIELD_GET(I2C_SR_LENGTH, i2c_sr);
+			/* LENGTH value includes the last byte that has not been sent or ACKed */
+			if (priv->bytes_cplt > 0)
+				priv->bytes_cplt--;
+		}
 		init_hw(priv);
 
 		status = status ? status : priv->result;
@@ -687,10 +702,11 @@ static int nmk_i2c_xfer_one(struct nmk_i2c_dev *priv, u16 flags)
 }
 
 /**
- * nmk_i2c_xfer() - I2C transfer function used by kernel framework
+ * nmk_i2c_xfer_v2() - I2C transfer function used by kernel framework
  * @i2c_adap: Adapter pointer to the controller
  * @msgs: Pointer to data to be written.
  * @num_msgs: Number of messages to be executed
+ * @report: Pointer to transfer report to be written.
  *
  * This is the function called by the generic kernel i2c_transfer()
  * or i2c_smbus...() API calls. Note that this code is protected by the
@@ -733,14 +749,16 @@ static int nmk_i2c_xfer_one(struct nmk_i2c_dev *priv, u16 flags)
  * please use the i2c_smbus_read_i2c_block_data()
  * or i2c_smbus_write_i2c_block_data() API
  */
-static int nmk_i2c_xfer(struct i2c_adapter *i2c_adap,
-		struct i2c_msg msgs[], int num_msgs)
+static int nmk_i2c_xfer_v2(struct i2c_adapter *i2c_adap,
+		struct i2c_msg msgs[], int num_msgs,
+		struct i2c_transfer_report *report)
 {
 	int status = 0;
 	int i;
 	struct nmk_i2c_dev *priv = i2c_get_adapdata(i2c_adap);
 
 	pm_runtime_get_sync(&priv->adev->dev);
+	priv->bytes_cplt = 0;
 
 	/* setup the i2c controller */
 	setup_i2c_controller(priv);
@@ -760,10 +778,17 @@ static int nmk_i2c_xfer(struct i2c_adapter *i2c_adap,
 	pm_runtime_put_sync(&priv->adev->dev);
 
 	/* return the no. messages processed */
-	if (status)
+	if (status) {
+		report->msgs_cplt = i;
+		report->bytes_cplt = priv->bytes_cplt;
+		report->fault_msg_idx = i;
 		return status;
-	else
+	} else {
+		report->msgs_cplt = num_msgs;
+		report->bytes_cplt = 0;
+		report->fault_msg_idx = num_msgs;
 		return num_msgs;
+	}
 }
 
 /**
@@ -1014,7 +1039,7 @@ static unsigned int nmk_i2c_functionality(struct i2c_adapter *adap)
 }
 
 static const struct i2c_algorithm nmk_i2c_algo = {
-	.xfer = nmk_i2c_xfer,
+	.xfer_v2 = nmk_i2c_xfer_v2,
 	.functionality = nmk_i2c_functionality
 };
 

-- 
2.43.0

