Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.90.104.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793899009;
	b=dEctganDzRjtNzxMPW9zTJaT2xSnVqXnWdSd5PIMt0XuiN3sVF5w51nWnPd5gj81PYYR
	 tUk+aIrFuN5bE0tZ/oIQpV4DxGnbDNMC2UQWqcDKN0J87d0uXmNsKhz0wjnk3g8ypeb3r
	 5w7QWe9VkCxjUH9DxkrOo3h6785qGj3TTyffPkMwTXWrLHhsakizuhtO+Mspx1yY28vjz
	 p6qi8PIpP6AUxDrgHEfgcyVshNg33WTf49k9NTZXeCx/YJNUQrrKXChNN98AGL9o2i+S4
	 7W3bsbNgTmTx8fychqHDvqHjulqdrxq6GKsahtJoJyjqZEgClRSMKBtZKKpLABXhRrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793899009;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=UjMb22YoQ0tLzZ04yXcHLaoHfX3SrH8zs5UQo00NOrQ=;
	b=3gnonDhklAhvW+2kZghwJub7hVOXUtzVyeFsZyaNu6xfyi7En+4gpTOkOgbbT/JX7TbQ
	 weXfspYqK9+KW6K8Aih6RqxKsaO1CP2CN+xBOsqvbyDXM30q4DLDpvaS5tteQShH3DgUe
	 JE/TO7Foy2TvIhT/raj3TwHzb84sdyUU+WG94bOysMVdjMMdq5cE6xNRIpyAd1OV3QoJ5
	 OBWLSc1h4U2jZ0jkeCdjTLWE5+DZFZrYy0RKQ0tZaCwYn/9Mv4GE+yZnq1r7C49M45gCf
	 Cwx7NwygB4LxXitgM6s3NUULYePYhe6V8lvDoFoB+0RBie68U6DU58sw2AIlqt1+tgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=23.90.104.147
Received: from esa2.hc555-34.eu.iphmx.com (esa2.hc555-34.eu.iphmx.com [23.90.104.147])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8896083623;
	Thu,  5 Nov 2026 17:16:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D8896083623
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1793899009; x=1825435009;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=HVHfXTQiDPZZw3tnNbaGhNodlorPF1IZ5YA83GihI/M=;
  b=L4PCvDkeMfV8VxYsDg9QLgNQlHYw2MnPZWTE1SNFqMPj3F+3YfRgUn4X
   I0P0W+V0MB8exNtxB1o4f2XFaeQWyHGPx/+DuYHF4+qTK7A8QjkSLhXqo
   sczzOsWZKGdBaMBMUckrWRkRi7JSr+kuNcC7VwnBNhZ78g25/OVw+fCwG
   m6GRZLFb0+DgV5KTHDqpNYS0VUi8gnYPShYlCSz7/fqqG53tZqA0JoQzd
   HTJ4KhSqq9kh7HcOxe1VR7FTk7sXIJ8BErs+uY/Onu+76GVRZDplpNG0Q
   xZ8AUNnmT7hmrjXRAX6xdkV77++G4GfdXRWTHL8/G19gWyvvAVLY63/Dk
   w==;
X-CSE-ConnectionGUID: NCGXBDD1Rt+T5depArDyFQ==
X-CSE-MsgGUID: eOk5XnCGQ1CfIyyWkMuzFA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces01_data.me-corp.lan) ([146.255.191.134])
  by esa2.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 19:16:39 +0200
X-CSE-ConnectionGUID: oxqlKXw/Q1mllKPZQYc7ng==
X-CSE-MsgGUID: D83syo3ST6W5x+pdhQ871Q==
Received: from unknown (HELO epgd056.me-corp.lan) ([10.154.54.2])
  by ces01_data.me-corp.lan with SMTP; 05 Nov 2026 19:24:42 +0200
Received: by epgd056.me-corp.lan (sSMTP sendmail emulation); Thu, 05 Nov 2026 19:16:38 +0200
From: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Date: Thu, 05 Nov 2026 19:15:33 +0200
Subject: [PATCH RFC v3 12/14] i2c: nomadik: add support for I2C_XFER_V2 -
 detailed fault reporting
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
Message-Id: <20261105-i2c-fault-reporting-v3-12-515ad74ac4c9@mobileye.com>
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
index f68d4cf7c0e7..9f43ab792ae2 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -198,6 +198,7 @@ struct i2c_nmk_client {
  * @stop: stop condition.
  * @xfer_wq: xfer done wait queue.
  * @result: controller propogated result.
+ * @bytes_cplt: number of bytes completed in the message that caused a fault.
  */
 struct nmk_i2c_dev {
 	struct i2c_vendor_data		*vendor;
@@ -218,6 +219,7 @@ struct nmk_i2c_dev {
 	int				stop;
 	struct wait_queue_head		xfer_wq;
 	int				result;
+	int				bytes_cplt;
 };
 
 /* controller's abort causes */
@@ -530,6 +532,8 @@ static int read_i2c(struct nmk_i2c_dev *priv, u16 flags)
 	int status = 0;
 	bool xfer_done;
 
+	priv->cli.xfer_bytes = 0;
+
 	mcr = load_i2c_mcr_reg(priv, flags);
 	writel(mcr, priv->virtbase + I2C_MCR);
 
@@ -655,6 +659,7 @@ static int nmk_i2c_xfer_one(struct nmk_i2c_dev *priv, u16 flags)
 	int status;
 
 	priv->i2c_sr = 0;
+	priv->bytes_cplt = 0;
 	if (flags & I2C_M_RD) {
 		/* read operation */
 		priv->cli.operation = I2C_READ;
@@ -690,6 +695,16 @@ static int nmk_i2c_xfer_one(struct nmk_i2c_dev *priv, u16 flags)
 			status = priv->result;
 		}
 
+		if (flags & I2C_M_RD) {
+			/* For READ messages, return the number of bytes read from FIFO */
+			priv->bytes_cplt = priv->cli.xfer_bytes;
+		} else {
+			/* For WRITE messages, return the number of bytes sent on bus */
+			priv->bytes_cplt = FIELD_GET(I2C_SR_LENGTH, priv->i2c_sr);
+			/* LENGTH value includes the last byte that has not been sent or ACKed */
+			if (priv->bytes_cplt > 0)
+				priv->bytes_cplt--;
+		}
 		init_hw(priv);
 
 		status = status ? status : priv->result;
@@ -699,10 +714,11 @@ static int nmk_i2c_xfer_one(struct nmk_i2c_dev *priv, u16 flags)
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
@@ -745,8 +761,9 @@ static int nmk_i2c_xfer_one(struct nmk_i2c_dev *priv, u16 flags)
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
@@ -756,6 +773,8 @@ static int nmk_i2c_xfer(struct i2c_adapter *i2c_adap,
 	if (i)
 		return i;
 
+	priv->bytes_cplt = 0;
+
 	/* setup the i2c controller */
 	setup_i2c_controller(priv);
 
@@ -774,10 +793,15 @@ static int nmk_i2c_xfer(struct i2c_adapter *i2c_adap,
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
+		i2c_transfer_report_success(report, num_msgs);
 		return num_msgs;
+	}
 }
 
 /**
@@ -1029,7 +1053,8 @@ static unsigned int nmk_i2c_functionality(struct i2c_adapter *adap)
 }
 
 static const struct i2c_algorithm nmk_i2c_algo = {
-	.xfer = nmk_i2c_xfer,
+	.xfer = i2c_xfer_to_xfer_v2,
+	.xfer_v2 = nmk_i2c_xfer_v2,
 	.functionality = nmk_i2c_functionality
 };
 

-- 
2.43.0

