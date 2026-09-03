Received: from esa2.hc555-34.eu.iphmx.com (esa2.hc555-34.eu.iphmx.com [23.90.104.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA384CCDC6;
	Thu,  3 Sep 2026 05:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.90.104.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788413936; cv=none; b=g+yOSKqZKxnC05kRkNyEOpV0q1S708J4Fs36vcYXcazSLCLYVuOCM7vhcgqF5QA6QqK8+5S3l1w7OgHH6ojn2bZedtIK5PjGYykFDQxzyAkAFzCBCpRD1NhjYU1D46GR1POYZ0GcxHcNJKghu4vvEmlbXPxJQoEkoOskUAdU0AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788413936; c=relaxed/simple;
	bh=eHmFtsWU5LjiwnO3niytJNP8sUYds/84ZFFIoQLM9gk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hl+e/AW2Czxo7fKtiuKNrhawtsonPk+5bijFsjCdkx+yZ8FM6wzBOeddO1+h6/ySCfzfA6rz0cRXtJISnkvXhnMR7a1WQFXZ9/As1/JA1KkvptsutF+NHPrvQg68Blc6M1e0CyJShOLtFLqhBSuSOS4yGba+FN7ynoB8PyTsIkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com; spf=pass smtp.mailfrom=mobileye.com; dkim=fail (0-bit key) header.d=mobileye.com header.i=@mobileye.com header.b=SabPrrm7 reason="key not found in DNS"; arc=none smtp.client-ip=23.90.104.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mobileye.com header.i=@mobileye.com header.b="SabPrrm7"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1788413934; x=1819949934;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=eHmFtsWU5LjiwnO3niytJNP8sUYds/84ZFFIoQLM9gk=;
  b=SabPrrm7km3DMvlwkSM5tPQhXRXkkcN0xrGvJBLnXSL+gwESb/g+sn2B
   qcZgeZv9UAn9XFgBGv4FWC5a9Xzwl3oYVmAU33iSalCvdJ8aokr7qR64C
   avYinIxW2i07pQjnupi+1so08BWm2TfwvQ4SXdpo1whpfgQz5m2OADqHn
   qeRBSmSvwNVs3UjcpN2nwXWHM9qWA1wiRDXBgl80igvlQpELkDh4DryjN
   GrHxoe19TXa0HrypYoBY3y72wjxkv3furM+PPoOKVj+M29QDGxjkoHv5p
   4om6oXhSD0ZVE/XI6GKtyhZ2SI8zeaxFhtu3X6h5Q7CoUZ4xv3oyNbqG0
   A==;
X-CSE-ConnectionGUID: cXTfemmQQHW5DE+hyRYMiQ==
X-CSE-MsgGUID: lO8lWGNRSHmUZbba1rI0gA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces01_data.me-corp.lan) ([146.255.191.134])
  by esa2.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 08:38:48 +0300
X-CSE-ConnectionGUID: 5S1lyqeURkuJKJFGaAW5FQ==
X-CSE-MsgGUID: IQLGvVf4RLesE2UPXjvhPA==
Received: from unknown (HELO epgd056.me-corp.lan) ([10.154.54.3])
  by ces01_data.me-corp.lan with SMTP; 03 Sep 2026 08:45:29 +0300
Received: by epgd056.me-corp.lan (sSMTP sendmail emulation); Thu, 03 Sep 2026 08:38:47 +0300
From: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Date: Thu, 03 Sep 2026 08:38:18 +0300
Subject: [PATCH v2 11/12] i2c: designware: use separate `i2c_algorithm` for
 AMD_NAVI_GPU
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-i2c-fault-reporting-v2-11-fedeb91792e6@mobileye.com>
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

AMD_NAVI_GPU variant of designware I2C controller uses its own
implementation of `xfer` method. Instead of checking flags in runtime,
create a separate `i2c_algorithm` structure and put pointer to
`amd_i2c_dw_xfer_quirk` directly into it.

Signed-off-by: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
---
 drivers/i2c/busses/i2c-designware-common.c | 14 +++++++++++++-
 drivers/i2c/busses/i2c-designware-core.h   |  1 +
 drivers/i2c/busses/i2c-designware-master.c |  6 ++----
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
index e934bcbe766042483874b3e43d10ffff30c59e04..4274bf809b3f4bff90139d186447256b01317951 100644
--- a/drivers/i2c/busses/i2c-designware-common.c
+++ b/drivers/i2c/busses/i2c-designware-common.c
@@ -886,6 +886,15 @@ static const struct i2c_algorithm i2c_dw_algo = {
 #endif
 };
 
+static const struct i2c_algorithm i2c_dw_amd_navi_gpu_algo = {
+	.xfer = amd_i2c_dw_xfer_quirk,
+	.functionality = i2c_dw_func,
+#if IS_ENABLED(CONFIG_I2C_SLAVE)
+	.reg_slave = i2c_dw_reg_slave,
+	.unreg_slave = i2c_dw_unreg_slave,
+#endif
+};
+
 static const struct i2c_adapter_quirks i2c_dw_quirks = {
 	.flags = I2C_AQ_NO_ZERO_LEN,
 };
@@ -922,7 +931,10 @@ int i2c_dw_probe(struct dw_i2c_dev *dev)
 		strscpy(adap->name, "Synopsys DesignWare I2C adapter");
 
 	adap->retries = 3;
-	adap->algo = &i2c_dw_algo;
+	if ((dev->flags & MODEL_MASK) == MODEL_AMD_NAVI_GPU)
+		adap->algo = &i2c_dw_amd_navi_gpu_algo;
+	else
+		adap->algo = &i2c_dw_algo;
 	adap->quirks = &i2c_dw_quirks;
 	adap->dev.parent = dev->dev;
 	i2c_set_adapdata(adap, dev);
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index 025311c8662c612aaaf772fb223af38278217c90..9f3492717e18fe104d307cfc65293ae4b41251f0 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -316,6 +316,7 @@ extern void i2c_dw_configure_master(struct dw_i2c_dev *dev);
 extern int i2c_dw_probe_master(struct dw_i2c_dev *dev);
 
 int i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num);
+int amd_i2c_dw_xfer_quirk(struct i2c_adapter *adap, struct i2c_msg *msgs, int num_msgs);
 
 #if IS_ENABLED(CONFIG_I2C_SLAVE)
 extern void i2c_dw_configure_slave(struct dw_i2c_dev *dev);
diff --git a/drivers/i2c/busses/i2c-designware-master.c b/drivers/i2c/busses/i2c-designware-master.c
index 936b9150754e85a1bac2d17a0fa65f6963e4ef3e..f029aa1eadbf83d304fc73b038e92f258e2148a1 100644
--- a/drivers/i2c/busses/i2c-designware-master.c
+++ b/drivers/i2c/busses/i2c-designware-master.c
@@ -291,8 +291,9 @@ static int i2c_dw_status(struct dw_i2c_dev *dev)
  * Initiate and continue master read/write transaction with polling
  * based transfer routine afterward write messages into the Tx buffer.
  */
-static int amd_i2c_dw_xfer_quirk(struct dw_i2c_dev *dev, struct i2c_msg *msgs, int num_msgs)
+int amd_i2c_dw_xfer_quirk(struct i2c_adapter *adap, struct i2c_msg *msgs, int num_msgs)
 {
+	struct dw_i2c_dev *dev = i2c_get_adapdata(adap);
 	int msg_wrt_idx, msg_itr_lmt, buf_len, data_idx;
 	int cmd = 0, status;
 	u8 *tx_buf;
@@ -926,9 +927,6 @@ int i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 {
 	struct dw_i2c_dev *dev = i2c_get_adapdata(adap);
 
-	if ((dev->flags & MODEL_MASK) == MODEL_AMD_NAVI_GPU)
-		return amd_i2c_dw_xfer_quirk(dev, msgs, num);
-
 	return i2c_dw_xfer_common(dev, msgs, num);
 }
 

-- 
2.43.0

