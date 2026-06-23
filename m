Received: from esa1.hc555-34.eu.iphmx.com (esa1.hc555-34.eu.iphmx.com [23.90.104.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F312FE56F;
	Tue, 23 Jun 2026 16:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.90.104.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782232346; cv=none; b=XmJ+jfCSbJnwVtglHK2rkEhKk7XsCjfPli7rqMd7M0vOf2qG3R4QEIRoSa8bLAPCz8TDJIsQygwNZDH/+2z3AvMLNbxcmZxqUSmxhrXII09SUBSdUcdfpUVCGjPV/M2cLOvYJoc6qgkZMLtm+g5rJryVNipXXMlUUJHavF8u6tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782232346; c=relaxed/simple;
	bh=gTrRTdtLS8baBdybUjfIaCTg6YqV6Q88loNVflxOmBA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rqsYCzb0fjq7si9zrgKkaT9Bi7/7KZCvL/EiJ4cHVSnM1mvNgUwYElTo21D6cB+lkvKH7xRfHQElkVzmnmQd9zuCzFtocWSg0J0kGIjImkkK7SjpEBhsqEw/Hv5+yOayrIubX7bfdq9OGcP4bhOXhfPk9BPBQVB2+p0/ympzmMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com; spf=pass smtp.mailfrom=mobileye.com; dkim=fail (0-bit key) header.d=mobileye.com header.i=@mobileye.com header.b=hvFRecfe reason="key not found in DNS"; arc=none smtp.client-ip=23.90.104.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mobileye.com header.i=@mobileye.com header.b="hvFRecfe"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1782232344; x=1813768344;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=gTrRTdtLS8baBdybUjfIaCTg6YqV6Q88loNVflxOmBA=;
  b=hvFRecfe2QdzfChCB5lsXWeExYn4ksDuJGW4RKkqslLFPUVx4Lz8pZcm
   gkiYBu8moCwK+Bd7ppAViQfbsEX/9dsdUz4MKduNa4Vs4+EgRqhDurjJe
   8xNKayfmBaiqUzCX5c85dXoEMFsMFrrkFOLuh063cxU43nKyBIpvayZNR
   ujA6R/6WgMitpFiet9xHAVruipqlCVjazNm3aCDdRg0mS9EIw5zm4uugs
   qPKh8AYw2DbYsw3skUOzcXj1wXvmm9DsWtRFVTgQ1kZRmEdiLcBxnT+0J
   S180rvrP4U6oJsod3E4zmlJCs8Ugb+BtQnA/VPwWZS8dW/K1DAkWpKGMd
   g==;
X-CSE-ConnectionGUID: 94snKhe5SHqNCVFQZ3FOhQ==
X-CSE-MsgGUID: TZVnjfY4QEK8u0TmsHy87g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces03_data.me-corp.lan) ([146.255.191.134])
  by esa1.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 19:32:22 +0300
X-CSE-ConnectionGUID: 5UkoFnxtT+ajORjDtGw7yA==
X-CSE-MsgGUID: 4nQu2gUfRFS94rakXpXx0g==
Received: from unknown (HELO epgd056.me-corp.lan) ([10.154.54.2])
  by ces03_data.me-corp.lan with SMTP; 23 Jun 2026 19:37:22 +0300
Received: by epgd056.me-corp.lan (sSMTP sendmail emulation); Tue, 23 Jun 2026 19:32:21 +0300
From: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Date: Tue, 23 Jun 2026 19:31:50 +0300
Subject: [PATCH 3/7] i2c: nomadik: do not try to retransmit I2C message
 series on errors
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260623-i2c-fault-reporting-v1-3-6db1a8aabf18@mobileye.com>
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

i2c-nomadik driver of I2C bus controller in `xfer` callback retransmits
the whole message series in cause of any fault, and returns fault only
after third failed attempt. This behavior contradicts with API because
not only it hides hardware faults, but also re-sends messages, while
they are not guaranteed to be idempotent.

Remove the triple attempt to send messages in `xfer` callback.

Signed-off-by: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
---
 drivers/i2c/busses/i2c-nomadik.c | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index e4e5c6943c66144058fba857d7bf6c0be79ed5bd..3eb06988c026e5c573fcf55d83de7136b5ca7ac9 100644
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

