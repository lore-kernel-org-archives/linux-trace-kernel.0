Received: from esa4.hc555-34.eu.iphmx.com (esa4.hc555-34.eu.iphmx.com [207.54.77.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D9E30C608;
	Tue, 23 Jun 2026 16:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.77.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782232346; cv=none; b=aOA5+aTnF8MDQeIjZO500v7U/PbdSrcOOuXyjablvMAGKefaJhbW2WMcl0QTU3zwieC9Ty1dheXKNiGTBI8LF65dGy6q1RK9K646FlbgHtGNkX7baG0BckYKHS7CYD9TlyDRAMHi+Mk+kSCkiGpybQdFle2vN2CeRE6LnVuJGrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782232346; c=relaxed/simple;
	bh=abiK5M9SqmKOeUi773fAhbaXyma8I8MJl0G28FSla+E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LNtTDeO3id8p56s8ZQA+IH/9/L/Qs8fykn7LISre6NfU+4n6eikSWPqmXaQ3bPJBb2QAbZDK01/hzZaqx+HvO0suqz8sa8sFzbTbMS36ypo41ntzZDo38j4ylabENhh3nXVKGOCNaPiDeIICH6psClN2YGfeAgxCmmnyiRyVPFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com; spf=pass smtp.mailfrom=mobileye.com; dkim=fail (0-bit key) header.d=mobileye.com header.i=@mobileye.com header.b=HcFkLohW reason="key not found in DNS"; arc=none smtp.client-ip=207.54.77.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mobileye.com header.i=@mobileye.com header.b="HcFkLohW"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1782232344; x=1813768344;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=abiK5M9SqmKOeUi773fAhbaXyma8I8MJl0G28FSla+E=;
  b=HcFkLohWSncltAtRu2j2RFBhKl2xiByrsS8tkWi+DZP81dzc2UcfQHZD
   enA6pcJJMSpEoHpst+46JrQq6wZNoWJVIEl7QMKmOPVDI/aBXlmRD0Vni
   g3GXFscL5EA0NEryavjvfqoqJa3w1+rkpBKjovZ2bZX0zGfTfv+Sv6do+
   RKIvkv+F02ZIpzEMgOxqrYOQMNC9fP3Q144mPezxyhL17UDSzRUNR5ioT
   8zjuNDbOffl9jY+NDWafKHbeItpitMLsKid9ziJL499OHd8unzuqLctZ5
   Wz3u6HDK45xzVFShvHtYarMOz953YEb7s51GaTLS4Vx/sWR93XyGu/HiS
   w==;
X-CSE-ConnectionGUID: cVg/OfupQMGiDkenHRR6qw==
X-CSE-MsgGUID: TW3kFmyKSsGNwXPdVOve3g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces02_data.me-corp.lan) ([146.255.191.134])
  by esa4.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 19:32:21 +0300
X-CSE-ConnectionGUID: 7WgFv90rTkCko6acKTvoTA==
X-CSE-MsgGUID: qdZ6EPPlRHWkQeWOry9Zyg==
Received: from unknown (HELO epgd056.me-corp.lan) ([10.154.54.2])
  by ces02_data.me-corp.lan with SMTP; 23 Jun 2026 19:37:31 +0300
Received: by epgd056.me-corp.lan (sSMTP sendmail emulation); Tue, 23 Jun 2026 19:32:20 +0300
From: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Date: Tue, 23 Jun 2026 19:31:49 +0300
Subject: [PATCH 2/7] i2c: nomadik: optimize layout of struct nmk_i2c_dev
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260623-i2c-fault-reporting-v1-2-6db1a8aabf18@mobileye.com>
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

Put two bool variables `xfer_done` and `has_32b_bus` and two char
variables `tft` and `rft` together in order to reduce struct size
wasted for padding.

Signed-off-by: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
---
 drivers/i2c/busses/i2c-nomadik.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index b63ee51c1652080e414f4302bee16905914c1288..e4e5c6943c66144058fba857d7bf6c0be79ed5bd 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
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
@@ -206,13 +206,13 @@ struct nmk_i2c_dev {
 	u32				clk_freq;
 	unsigned char			tft;
 	unsigned char			rft;
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

