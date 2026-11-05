Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.90.104.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793899004;
	b=tyRt1kxBCGbclu4Bev3/EzeAXY0zxjVMwlNL+sS+avpeuCmyKk2Bfp9Q9taq9OWS7BG0
	 l7Ug1Hp9CcHNnmnJKWVQEVrK6YuwC5PXKT+7FHE3jQJc8KNFs/ertmX1w5HC/0E4aqfVF
	 WFAvmVvYHLrUvK/KosSzLiYHuuIp9YMN961FB6qSP10eU0MfIGWp1Xpkp/C7Kefc6kMzN
	 TLLv4zADS5vSbLj8QVXM07fdftmDudsLF0r57xbcXD3htXuNQm0wYm1gG58Jh4XPKQn4t
	 goz+kVWq3lSxbL/OuMa2qMKdi7mRStuEYeuBGdEXVR529U7YLOFnzDPgVUtqX0KwQtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793899004;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=cdQNTg4bdoFV18ObiKumRIAb3JVyubSMmS9cG9ueoUY=;
	b=m9fYHEZ0Avf8ZIblKTI/zEnHnA8r6KCOt+yUw3gtvtaNGSAfGfbNtEW09ndGuysk1MHG
	 AYY+kP2+d0Lfm5wEnJK6Tk3+3Ur0DqRbfajRJglz8xthO8yBB4tO+CK6y87IqrsrnpV81
	 zfminMXZRoeJZgAah9rjU+dLcVihrmLADutubbn7DDH/MVBwDOoky/KnHFJDErFGES38r
	 PNwz4ZIHcbjLupAWF92AlIzrnPZWFUKMk8xcUHJYc5YsmpHuH0oB6PzuK1Ua28jNTaiJ9
	 i2rG32UBQMEYloAsPIt9zD8cf0PV2h7etp5QjBJIJsBBmexJ0b/b/BoN3eZ9Jhr52qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=23.90.104.144
Received: from esa1.hc555-34.eu.iphmx.com (esa1.hc555-34.eu.iphmx.com [23.90.104.144])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979E2606D804;
	Thu,  5 Nov 2026 17:16:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 979E2606D804
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1793899004; x=1825435004;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=IUsmgBK0bIxzEAsyUzlxlzNIalo2oo4LQdwchNFudOE=;
  b=VG2FXqvTGFe1rVQHauFxrv7GTfLo88jNamqMT/zi+HDGk6nlCKc972s8
   E+QHkSSu5kEU7ECve12Cl/ZAlDE3DR0HNw14dHKt4buUyLuxMcvoA4Nz9
   eg7mT0lNq/j9pSfJDKm4Os8b/HppBQg8gNTxZWArqutpJsLU6s6dbZp7u
   xC1bblTPxbauppwOXq1FSzR4zWmKrGL66OiOciecJKSIIafu/Sz211pOM
   ieqbwtvWf7AWDiebnKMbstyQS/RHuUjpiUWhGkyZe5l4OZ6FOlr3li6rB
   1uZOdAGa5vJQ1N7+UYlX4erdLcf3qKn5QuflPPS82gP19UB3P3d2wVXf9
   A==;
X-CSE-ConnectionGUID: VP2dxIi7SxK56IKKbGkV9g==
X-CSE-MsgGUID: fCQMjw5KR52A/IzilpCSzQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces04_data.me-crop.lan) ([146.255.191.134])
  by esa1.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 19:16:40 +0200
X-CSE-ConnectionGUID: ERBuxDu0TIipd/Tm5OO/Gw==
X-CSE-MsgGUID: FVbeRIkUQzOnFSgyIawHcg==
Received: from unknown (HELO epgd056.me-corp.lan) ([10.154.54.2])
  by ces04_data.me-crop.lan with SMTP; 05 Nov 2026 19:24:37 +0200
Received: by epgd056.me-corp.lan (sSMTP sendmail emulation); Thu, 05 Nov 2026 19:16:39 +0200
From: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Date: Thu, 05 Nov 2026 19:15:34 +0200
Subject: [PATCH RFC v3 13/14] i2c: designware: use separate `i2c_algorithm`
 for AMD_NAVI_GPU
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
Message-Id: <20261105-i2c-fault-reporting-v3-13-515ad74ac4c9@mobileye.com>
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
index e934bcbe7660..4274bf809b3f 100644
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
index 025311c8662c..9f3492717e18 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -316,6 +316,7 @@ extern void i2c_dw_configure_master(struct dw_i2c_dev *dev);
 extern int i2c_dw_probe_master(struct dw_i2c_dev *dev);
 
 int i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num);
+int amd_i2c_dw_xfer_quirk(struct i2c_adapter *adap, struct i2c_msg *msgs, int num_msgs);
 
 #if IS_ENABLED(CONFIG_I2C_SLAVE)
 extern void i2c_dw_configure_slave(struct dw_i2c_dev *dev);
diff --git a/drivers/i2c/busses/i2c-designware-master.c b/drivers/i2c/busses/i2c-designware-master.c
index 412ab0cd2a32..7670f909f88c 100644
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
@@ -947,9 +948,6 @@ int i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 {
 	struct dw_i2c_dev *dev = i2c_get_adapdata(adap);
 
-	if ((dev->flags & MODEL_MASK) == MODEL_AMD_NAVI_GPU)
-		return amd_i2c_dw_xfer_quirk(dev, msgs, num);
-
 	return i2c_dw_xfer_common(dev, msgs, num);
 }
 

-- 
2.43.0

