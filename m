Received: from esa1.hc555-34.eu.iphmx.com (esa1.hc555-34.eu.iphmx.com [23.90.104.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F353921CE;
	Thu,  3 Sep 2026 05:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.90.104.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788413995; cv=none; b=MEWyTTN0I3ba5c9pwSLUL/N71A52wI9fmLHa0hzAhK53YNeeXjGnXPAgBBk4axI8xe2wr6JMNpmgPAAnSgcAXqd7D3UQGZz3dlpLFhmkB7o559pWGh9J8Gth5/QAJSbwQu2zAa7b2PzUk5Tf1Kd1xh5fQgbPikeQFAxufJSaxmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788413995; c=relaxed/simple;
	bh=L1VT8VFHal4ll3cgXxcUxpNo9geScucAPiMQYju1t00=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kQhNKl1UnYU1X365sMTttGZyFqvlKsHABrqVSE1BPmurhA43JW3JAnOmc+3us7LmC7JeruGJksQ5PFTNtE1GGulKulcxiItc029t+M6ULyKiv2KscWmIPWm8X3slwPxSsauSturQb1UvDk2XBFSED84fYUNeUYtS42+YSvd1IHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com; spf=pass smtp.mailfrom=mobileye.com; dkim=fail (0-bit key) header.d=mobileye.com header.i=@mobileye.com header.b=Wb1TkKqr reason="key not found in DNS"; arc=none smtp.client-ip=23.90.104.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mobileye.com header.i=@mobileye.com header.b="Wb1TkKqr"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1788413992; x=1819949992;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=L1VT8VFHal4ll3cgXxcUxpNo9geScucAPiMQYju1t00=;
  b=Wb1TkKqrafptV2gcl0ooV9tktX9QjK6IGiS+A1j4PDwyG8c9tARkrADp
   /HDEUs/O+zL17HzQrAa5ZsQ80NupJPprPG04wD5w9KFp7idlnvrqDYJee
   ZslOdCWtIa7nx0emAxUrbeGManNKUAGNyVVkuIJWkA/o8/qEbnJpZeBP5
   ZUcyAiG0jY2CT9AW06pxxFhIro7ET0XBaDrY8m10BH8Cy4XfY8OfXUqxb
   9TaefUUwjcXXAL+9DoknpzLrKg3Pp61psMWl5xSJXq1tHPccLQ99lhv8s
   8szW8qYLvPoQYSuMDbuYWfc5Il+UpaUiuqgekOcoa3oSREGun/+8TLWfe
   Q==;
X-CSE-ConnectionGUID: BKzXfXlOS5uYZ2kKHy4/sw==
X-CSE-MsgGUID: EAf+4oaGRMC/m1xt+OCdKw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces04_data.me-crop.lan) ([146.255.191.134])
  by esa1.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 08:38:40 +0300
X-CSE-ConnectionGUID: uHjNl9sHS3GOyxfMXxEu2Q==
X-CSE-MsgGUID: OSj80QBdQDyXPUG5vZ1qzA==
Received: from unknown (HELO epgd056.me-corp.lan) ([10.154.54.3])
  by ces04_data.me-crop.lan with SMTP; 03 Sep 2026 08:45:15 +0300
Received: by epgd056.me-corp.lan (sSMTP sendmail emulation); Thu, 03 Sep 2026 08:38:38 +0300
From: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Date: Thu, 03 Sep 2026 08:38:10 +0300
Subject: [PATCH v2 03/12] i2c: nomadik: do not try to retransmit I2C
 message series on errors
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-i2c-fault-reporting-v2-3-fedeb91792e6@mobileye.com>
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

i2c-nomadik driver of I2C bus controller in `xfer` callback retransmits
the whole message series in cause of any fault, and returns fault only
after third failed attempt. This behavior contradicts with API because
not only it hides hardware faults, but also re-sends messages, while
they are not guaranteed to be idempotent.

Remove the triple attempt to send messages in `xfer` callback.

Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
---
 drivers/i2c/busses/i2c-nomadik.c | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index 45b4815b094524d9a8de69376e2933171541611a..ca9366e09e7125b9c86dd0f995162018df56634d 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -716,27 +716,21 @@ static int nmk_i2c_xfer(struct i2c_adapter *i2c_adap,
 	int status = 0;
 	int i;
 	struct nmk_i2c_dev *priv = i2c_get_adapdata(i2c_adap);
-	int j;
 
 	pm_runtime_get_sync(&priv->adev->dev);
 
-	/* Attempt three times to send the message queue */
-	for (j = 0; j < 3; j++) {
-		/* setup the i2c controller */
-		setup_i2c_controller(priv);
-
-		for (i = 0; i < num_msgs; i++) {
-			priv->cli.slave_adr	= msgs[i].addr;
-			priv->cli.buffer		= msgs[i].buf;
-			priv->cli.count		= msgs[i].len;
-			priv->stop = (i < (num_msgs - 1)) ? 0 : 1;
-			priv->result = 0;
-
-			status = nmk_i2c_xfer_one(priv, msgs[i].flags);
-			if (status != 0)
-				break;
-		}
-		if (status == 0)
+	/* setup the i2c controller */
+	setup_i2c_controller(priv);
+
+	for (i = 0; i < num_msgs; i++) {
+		priv->cli.slave_adr	= msgs[i].addr;
+		priv->cli.buffer		= msgs[i].buf;
+		priv->cli.count		= msgs[i].len;
+		priv->stop = (i < (num_msgs - 1)) ? 0 : 1;
+		priv->result = 0;
+
+		status = nmk_i2c_xfer_one(priv, msgs[i].flags);
+		if (status != 0)
 			break;
 	}
 

-- 
2.43.0

