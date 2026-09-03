Received: from esa2.hc555-34.eu.iphmx.com (esa2.hc555-34.eu.iphmx.com [23.90.104.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B753446CE;
	Thu,  3 Sep 2026 05:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.90.104.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788413933; cv=none; b=ALCUEAzI1CUF8zxAw6SRaKQ1a7W2GdE50jFF1NSWgQ/lLqGqWOb+FQV5D52Fujd+h30i8mTZPSETLQjVRJ7M29OcDZxKdXyDQx788JI86X5b2HyGbs3IsdsWW74yU9CjaQEJWeGXUYx0jwAu2lt+1FyVwCXM5jwI+TPAX95pVjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788413933; c=relaxed/simple;
	bh=nlZNbwIyTEpADUlhze0eaVgSfFmoT/5b05U10+WjG/M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UOU6eq5JL9FMbEu4jNCKQef50bvvGXMEQTNN2FpX8FGlvfJCr/tnDsoCfopQu09JAYQwyAPEXgjivpAi4Quw9gKkiKnygjoBkc9z5bJMZnbp13sWNl9YXHVirjpfvobFJirUgI93IwN49tcdAeVarvcB5zhhoI1c1IFqetFaf50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com; spf=pass smtp.mailfrom=mobileye.com; dkim=fail (0-bit key) header.d=mobileye.com header.i=@mobileye.com header.b=PngKJ1Vv reason="key not found in DNS"; arc=none smtp.client-ip=23.90.104.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mobileye.com header.i=@mobileye.com header.b="PngKJ1Vv"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1788413929; x=1819949929;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=nlZNbwIyTEpADUlhze0eaVgSfFmoT/5b05U10+WjG/M=;
  b=PngKJ1Vv61tC69Ymm2HzSHKL+qI/uFA7l7VZo7VvSFnRnwcpwy+8lpJ9
   5zdGOHQJxe610zFdy7vvT8/abzyq938Ss7UVNTNtlU2U21ekxk8X5592p
   pC17+JrYjTxob3fUABgGzZoywm8QQKCYP2Fm+Ar/QZ+EhjwQ+5likzACJ
   8A7/2eCvG8OB/p9Zy6PO3un+zFqGJxGXLtJmz1s0PsDQwdNiiOoCk7CdN
   hwBwxT+lmGVCZ+75Or0u+UW2R6xyjPm5TtmZvHMq8/sQt44j89nXpjaOf
   nJW0/T+ztsQSrwod1gFIaKcsTfSTk0j06S1/A8H7JKuv0RtaFa5/CDz3U
   g==;
X-CSE-ConnectionGUID: WLsDcoMiRqeta1S+3AaaXA==
X-CSE-MsgGUID: qPMyAe9NRcqGeLolwasNGw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces03_data.me-corp.lan) ([146.255.191.134])
  by esa2.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 08:38:42 +0300
X-CSE-ConnectionGUID: abxc5S9CQ2SBHX1Nd2NPmw==
X-CSE-MsgGUID: ZuKQV8clSlyTOQVNKYtjJA==
Received: from unknown (HELO epgd056.me-corp.lan) ([10.154.54.3])
  by ces03_data.me-corp.lan with SMTP; 03 Sep 2026 08:45:09 +0300
Received: by epgd056.me-corp.lan (sSMTP sendmail emulation); Thu, 03 Sep 2026 08:38:41 +0300
From: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Date: Thu, 03 Sep 2026 08:38:12 +0300
Subject: [PATCH v2 05/12] i2c: nomadik: change print level for fault
 messages to debug
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-i2c-fault-reporting-v2-5-fedeb91792e6@mobileye.com>
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

i2c-nomadik driver prints error message on every faulted message. This
is not a good practice, because in I2C a fault not always is an error,
sometimes it is the expected result. For example, scanning bus with
`i2cdetects` prints over 100 messages in dmesg (two messages per each
target address).

To avoid excessive prints in the log, change the print level from err to
debug.

Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
---
 drivers/i2c/busses/i2c-nomadik.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index a3cef4b66190a9e45898e25867a3ceefce5d3d0a..9c7658148bd45ecdaef1f998558315580233555d 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -627,7 +627,7 @@ static int write_i2c(struct nmk_i2c_dev *priv, u16 flags)
 
 	if (!xfer_done) {
 		/* Controller timed out */
-		dev_err(&priv->adev->dev, "write to slave 0x%x timed out\n",
+		dev_dbg(&priv->adev->dev, "write to slave 0x%x timed out\n",
 			priv->cli.slave_adr);
 		status = -ETIMEDOUT;
 	}
@@ -661,7 +661,7 @@ static int nmk_i2c_xfer_one(struct nmk_i2c_dev *priv, u16 flags)
 		i2c_sr = readl(priv->virtbase + I2C_SR);
 		if (FIELD_GET(I2C_SR_STATUS, i2c_sr) == I2C_ABORT) {
 			cause = FIELD_GET(I2C_SR_CAUSE, i2c_sr);
-			dev_err(&priv->adev->dev, "%s\n",
+			dev_dbg(&priv->adev->dev, "%s\n",
 				cause >= ARRAY_SIZE(abort_causes) ?
 				"unknown reason" :
 				abort_causes[cause]);

-- 
2.43.0

