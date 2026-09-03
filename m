Received: from esa4.hc555-34.eu.iphmx.com (esa4.hc555-34.eu.iphmx.com [207.54.77.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FB9393DE2;
	Thu,  3 Sep 2026 05:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.77.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788414009; cv=none; b=W6mdj+SC8BrIPlCcJ3mhtHayZ8/SAuc1Aqru5P8/KgvevoQ9w0w1iHnv1mAeMZSO0nypf1U5X9BN1FYNR+D4X/Ak4BZiL/Kq3gkfrm8sNVMQ3E9p90ktD7qgD6HRBYq+d6pBiVs1ZLIzJm/GWx98ncF1wV1oK+EM063HYOIaCH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788414009; c=relaxed/simple;
	bh=8TUN+9eI/Nacj8ClflcM6JdSTv4X8U6aMr/gCQEocVA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ixb+DuqZqMkgQiugV58G3sCEb5zrmzQtsxba3wMP4ehnujw+jAEzCSzSKgD3FpyiU21c2uaTEYPzj3fQUQQsjqMXRA65YWC+i0E4qWBuIiM8wUPy83Jz0ldpcgMsPRHok9x7X96rcsrSQo5SUsN7vpslDg0cbTOkiRfv97CWn+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com; spf=pass smtp.mailfrom=mobileye.com; dkim=fail (0-bit key) header.d=mobileye.com header.i=@mobileye.com header.b=NB03eIlK reason="key not found in DNS"; arc=none smtp.client-ip=207.54.77.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mobileye.com header.i=@mobileye.com header.b="NB03eIlK"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1788414007; x=1819950007;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=8TUN+9eI/Nacj8ClflcM6JdSTv4X8U6aMr/gCQEocVA=;
  b=NB03eIlKkXM3QCHrn3fr9I1crrc6KlyUIZspk/PtWeL5S583U3AusNYM
   CQratuxvojyO9ixpPSFnrhvvKlPkRzvIQy/dPYnoalctpoXUhgjaEDWHR
   4ItrODVhju4/7Z3Y2+z6Xsi5epXRskJ7629N7SdyJ0zGYCqWSmauUT9v/
   la6607AsnzWWAgZOVefq0hNkA1km43qvtQ+VDvfxY7pUDCEqnSdqXIHL3
   kt6gqTCAFfxAS9rpny/qjCSiuHYYRmbwp7+kYdgA3XZWCt1JaR0lmZrjC
   nAFTYKAF7PUJPnKb9HoTUbIPNH4arZK1rPAr1OvwZEu8qplmbjZgvVTy8
   w==;
X-CSE-ConnectionGUID: gmrDEKMWTtS7tr5NnoYm1Q==
X-CSE-MsgGUID: DFSa6K3vTVeVRSxPvcEieg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces02_data.me-corp.lan) ([146.255.191.134])
  by esa4.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 08:38:46 +0300
X-CSE-ConnectionGUID: BmP7FnTISB6uneerkrPTuw==
X-CSE-MsgGUID: 1ZenchvwTdGQwojcUCQLPg==
Received: from unknown (HELO epgd056.me-corp.lan) ([10.154.54.3])
  by ces02_data.me-corp.lan with SMTP; 03 Sep 2026 08:45:24 +0300
Received: by epgd056.me-corp.lan (sSMTP sendmail emulation); Thu, 03 Sep 2026 08:38:45 +0300
From: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Date: Thu, 03 Sep 2026 08:38:16 +0300
Subject: [PATCH v2 09/12] i2c: designware: no SMBUS_READ_BLOCK_DATA without
 EMPTYFIFO_HOLD_MASTER
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-i2c-fault-reporting-v2-9-fedeb91792e6@mobileye.com>
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

Controllers without EMPTYFIFO_HOLD_MASTER feature cannot hold bus with
empty FIFO. This makes impossible to issue SMBUS block read command:
it is not known how many bytes must be read until it reads the  first byte
indicates the data length is read. Without EMPTYFIFO_HOLD_MASTER, when
the first byte is read, TX FIFO gets empty, this causes STOP condition
and the transfer is terminated.

Reset SMBUS_READ_BLOCK_DATA bit in functionality mask on such controllers.

Signed-off-by: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
---
 drivers/i2c/busses/i2c-designware-master.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/i2c/busses/i2c-designware-master.c b/drivers/i2c/busses/i2c-designware-master.c
index d10f46cf4aa44344fa1c53b9b8798a8b0f0c193c..76f28e1696bdc81326cf149dfe88c52dd2f0731f 100644
--- a/drivers/i2c/busses/i2c-designware-master.c
+++ b/drivers/i2c/busses/i2c-designware-master.c
@@ -940,6 +940,13 @@ void i2c_dw_configure_master(struct dw_i2c_dev *dev)
 	if ((dev->flags & MODEL_MASK) != MODEL_AMD_NAVI_GPU)
 		dev->functionality |= I2C_FUNC_PROTOCOL_MANGLING;
 
+	/* Controllers without EMPTYFIFO_HOLD_MASTER feature cannot issue SMBUS
+	 * block read because after reading the data length FIFO gets empty and
+	 * STOP is generated automatically
+	 */
+	if (!dev->emptyfifo_hold_master)
+		dev->functionality &= ~I2C_FUNC_SMBUS_READ_BLOCK_DATA;
+
 	dev->master_cfg = DW_IC_CON_MASTER | DW_IC_CON_SLAVE_DISABLE |
 			  DW_IC_CON_RESTART_EN;
 

-- 
2.43.0

