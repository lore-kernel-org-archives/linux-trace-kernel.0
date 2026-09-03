Received: from esa2.hc555-34.eu.iphmx.com (esa2.hc555-34.eu.iphmx.com [23.90.104.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4B7392C39;
	Thu,  3 Sep 2026 05:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.90.104.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788414002; cv=none; b=eoBK5QLiTWWWefGMgiwYEJRdRsOL3ZfRWw+X6DSAg3ttq6wr44qG8pl0N/WPyiGAgTTF7JEJogLQl/za8vojXavUzMxbyvKX6TDsSKmFqRpK3PobxG35lkavhhI14c4GdT6tLnXllRmJK7uiKV/Qh0WVqe0zLDLoJX/WuyFeml8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788414002; c=relaxed/simple;
	bh=HlYAVuM9vZLFTesP9pfThfI3jTZfqm2p6kxvhhe8OIs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HwmdpPRUkUJtWnkrEkevI6lmAmweUQj55uAZcxS/5RYVBIWU0wmz+ZB9VLhvGCQ686WrQh7EhJNZTyDgTjpMqtGNd+zcYnlyUDfkny3iBxuW9CXANzTRJbSIjZRVWwnd7SN6EX4G3SJHGoxIfYrF1c32L4c56IWyrQ01PNNisJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com; spf=pass smtp.mailfrom=mobileye.com; dkim=fail (0-bit key) header.d=mobileye.com header.i=@mobileye.com header.b=n3vV20OP reason="key not found in DNS"; arc=none smtp.client-ip=23.90.104.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mobileye.com header.i=@mobileye.com header.b="n3vV20OP"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1788413996; x=1819949996;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=HlYAVuM9vZLFTesP9pfThfI3jTZfqm2p6kxvhhe8OIs=;
  b=n3vV20OP8CVa5vqGCifBFPYj/I+skQ4A8O3ywxZeyiwjI2RECktvNtGB
   r4PYYEVQPb/XZmkUHPpVcSXm63l7kdhokHVkHuimB6aqeyYy1XkMquNjY
   0cbfm4IZLjdLexlszkEM8ozuRhN+Jf4gq/czLbllFPEdDJceudRhp1WZK
   EkSZ0tmMB9TKmX6R2PsLkZUsbpL28eKt37w9cA9K6hasGvpso02hRlcAO
   K473eDLH3O/jZNURFDMpT4dIEIOw5hMVY5hRDZEd4TM/io/RtiKcVLGc6
   GePTlvG6nYc7cfR539GJLf1T21HW+yDEkmvm3tPTgKBXcRFkqybJCAy9z
   A==;
X-CSE-ConnectionGUID: WLsDcoMiRqeta1S+3AaaXA==
X-CSE-MsgGUID: pfpTQci7RAi4ym1F4MPsvw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces03_data.me-corp.lan) ([146.255.191.134])
  by esa2.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 08:38:47 +0300
X-CSE-ConnectionGUID: DGlRIx87RHqxRAx0DKNZDQ==
X-CSE-MsgGUID: /Qj9nrTdRMmiTWGdE7nxiw==
Received: from unknown (HELO epgd056.me-corp.lan) ([10.154.54.3])
  by ces03_data.me-corp.lan with SMTP; 03 Sep 2026 08:45:15 +0300
Received: by epgd056.me-corp.lan (sSMTP sendmail emulation); Thu, 03 Sep 2026 08:38:46 +0300
From: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Date: Thu, 03 Sep 2026 08:38:17 +0300
Subject: [PATCH v2 10/12] i2c: designware: stop transfer if spurious STOP
 is detected
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-i2c-fault-reporting-v2-10-fedeb91792e6@mobileye.com>
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

In `i2c_dw_process_transfer()`, if STOP_DET flag is set while read or
write is in progress, the transfer should be aborted. If this flag is
handled the same interrupt as TX_EMPTY flag, the driver first handles
TX_EMPTY flag and transmits the following messages, and only afterwards
checks STOP_DET flag.

Also, if STOP_DET flag is set, interrupts are not masked, so if TX_EMPTY
interrupts arrives later, the driver will also send further messages.

To abort transmitting data after spurious STOP, check STOP_DET flag
before TX_EMPTY flag, and if STOP_DET flag is set while transfer is in
progress, disable interrupts as it is done in case of TX_ABRT flag set.

Signed-off-by: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
---
 drivers/i2c/busses/i2c-designware-master.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-master.c b/drivers/i2c/busses/i2c-designware-master.c
index 76f28e1696bdc81326cf149dfe88c52dd2f0731f..936b9150754e85a1bac2d17a0fa65f6963e4ef3e 100644
--- a/drivers/i2c/busses/i2c-designware-master.c
+++ b/drivers/i2c/busses/i2c-designware-master.c
@@ -651,17 +651,19 @@ static void i2c_dw_process_transfer(struct dw_i2c_dev *dev, unsigned int stat)
 	if (stat & DW_IC_INTR_RX_FULL)
 		i2c_dw_read(dev);
 
-	if (stat & DW_IC_INTR_TX_EMPTY)
-		i2c_dw_xfer_msg(dev);
-
 	/* Abort if we detect a STOP in the middle of a read or a write */
 	if ((stat & DW_IC_INTR_STOP_DET) &&
 	    (dev->status & (STATUS_READ_IN_PROGRESS | STATUS_WRITE_IN_PROGRESS))) {
 		dev_err(dev->dev, "spurious STOP detected\n");
 		dev->rx_outstanding = 0;
 		dev->msg_err = -EIO;
+		__i2c_dw_write_intr_mask(dev, 0);
+		goto tx_aborted;
 	}
 
+	if (stat & DW_IC_INTR_TX_EMPTY)
+		i2c_dw_xfer_msg(dev);
+
 	/*
 	 * No need to modify or disable the interrupt mask here.
 	 * i2c_dw_xfer_msg() will take care of it according to

-- 
2.43.0

