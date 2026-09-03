Received: from esa4.hc555-34.eu.iphmx.com (esa4.hc555-34.eu.iphmx.com [207.54.77.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467353921E9;
	Thu,  3 Sep 2026 05:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.77.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788414006; cv=none; b=Fqip8HeieSYAeDGhFmMik0tpJPHX76p30Oll4sCRM7yZl2Z25wEXkVhYXWdEG8og4dQxNYdbROVitLm5sq5RrlD+d1pUR9QrTETlR51G7XZyvZN7IfzpniD+igKi9pigEh63GnEPs4x8Ssr2u65uNlj1DuPx06nd9xUXgyvbqV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788414006; c=relaxed/simple;
	bh=ItnzHs4CMTfZZuAr1WQ3jV2V8snov5mwV0y2o0zOF2g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kn6U6iKsEWk5wk8fsYfGkzZwzd/Wz+RBERcW8mpywbD6RCQY00u8Bzis6BF/tdSkJ/H1cb7g3xKw9rfbvIGxMlsbzTHo687qcWIo1Vpvx4KHwlj56JM2DTSmFhOV+wqa1WJk2TQKPR9jOeGWg8XXUyobXyMpRGEqiQK7pNFOVOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com; spf=pass smtp.mailfrom=mobileye.com; dkim=fail (0-bit key) header.d=mobileye.com header.i=@mobileye.com header.b=XLwle03L reason="key not found in DNS"; arc=none smtp.client-ip=207.54.77.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mobileye.com header.i=@mobileye.com header.b="XLwle03L"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1788413996; x=1819949996;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=ItnzHs4CMTfZZuAr1WQ3jV2V8snov5mwV0y2o0zOF2g=;
  b=XLwle03LEXq3ibRNo/30ryteQMV6Hy9CvYApIlbOClQZzpGRzqIfgnCo
   o4hKWaYbTlK2uO5v8vRg3h/FLj20Uw+03IFc1mbqnDBeb7YBFtdTn1KPV
   BXoVCZOG1ZQUaZtsaPdnlrd6Bmnk+gjU2bxisTTCkEdw+Z7yOW5MK1P26
   aX4AgeNqwXVlM06lADy+F27zGRyD5L2T5pbhEu8SOGtxHokusipriBkKv
   HUqeD8SYc9JgMU8f8kRDRFEgrNlhqGjGBUs6mhVsIIOCotoTNtTkpCbYs
   QRIypUoGeI5wEPyfBWkjN3RmC41cXyWa28wBjFei0eA/qEwSKTRBS4l1H
   Q==;
X-CSE-ConnectionGUID: gmrDEKMWTtS7tr5NnoYm1Q==
X-CSE-MsgGUID: aSDCu6A7SASemtRNvPFdUg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces02_data.me-corp.lan) ([146.255.191.134])
  by esa4.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 08:38:44 +0300
X-CSE-ConnectionGUID: 0bgttk3bQ+aWaisyrwKAlA==
X-CSE-MsgGUID: WeSs7CFaRlWuEIIEcXulAQ==
Received: from unknown (HELO epgd056.me-corp.lan) ([10.154.54.3])
  by ces02_data.me-corp.lan with SMTP; 03 Sep 2026 08:45:22 +0300
Received: by epgd056.me-corp.lan (sSMTP sendmail emulation); Thu, 03 Sep 2026 08:38:43 +0300
From: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Date: Thu, 03 Sep 2026 08:38:14 +0300
Subject: [PATCH v2 07/12] i2c: nomadik: add support for I2C_XFER_V2 -
 detailed fault reporting
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-i2c-fault-reporting-v2-7-fedeb91792e6@mobileye.com>
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

I2C_XFER_V2 is a new API that allows I2C clients to get the detailed
report in case of transmission failure. Previously, the only information
returned by I2C bus controller was the error code; there was no way to
find out how many messages or bytes in a certain message have been sent
or received until the fault condition occurred.

This commit introduces support of this feature in i2c-nomadik driver.

Acked-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
---
 drivers/i2c/busses/i2c-nomadik.c | 37 +++++++++++++++++++++++++++++++------
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index c36e9961e0a39e76386a6e20f6e0b6fec3d5b5a9..8b0ab191f7c1fc120f81319c1b1689193e2b9ea2 100644
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

