Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=207.54.77.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793898995;
	b=fMYOoVrMBkx3Q2ONNIUwZZyz99PNxNffrFKeXT2X6u9h6yLEHasKG2eUh8iBWHpMfGoo
	 Oi6fjpYeDB6xdR5hf57nBPn1Kp5fobdNe2sPw88fkgp2N61+VOZ8UQ/97SGaDIQU0t6St
	 9RyJxqi2Z8cQP+dp06D7EcucbFTyY9CbxLdfZynHm/Re4YwQtv2JzmuEkkXf02ZOYEJJO
	 PqwaFur4uJYG2RGYMLoLtCMjabz7RERGld4B/1jxVHu2Kmty70yuqhY9772R2xWcaBaD4
	 XKzbThnLczw1/z6VjH90KgFlBcH5IG5RQ+yutSUHC5p9ns72vHu0eMOxd/6PLa/gDzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793898995;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=uDhem8OD0nqC2nbr0UAiAW1wMCT7+FUVptxLNsvSNiA=;
	b=VtnCZc3B6H07WOB76tZj8s8wZKIB9K7xxW9dnZGMS11Gz8sHf9nHhPAn8B/Rt06/WgOU
	 KtTYUEY/TgIVPlrjZMQrrwcZnLVn2rLAq9/RR2qAPl8PJpPqEjAtPSW1XNLlfSvYexQbW
	 T+5UQ/YAeDPX/9KikJzsRADbdfQRI/Oe+bntzmhWrtvZKvi3wTFWSJzdcW/IPO/HtsET6
	 PYlook3oowgzWbcbS9uyl8tn2C2PS+8NCPypPay43b0yITjr8PyWm2j4+OphcycVRq7er
	 ljhgy6lNj5xA+B9ArME5LK3Xoq7A/93JYZIvrWUMTnPfE0Hi3xgstvpDMndLe8eQzEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=207.54.77.50
Received: from esa3.hc555-34.eu.iphmx.com (esa3.hc555-34.eu.iphmx.com [207.54.77.50])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE897606D811;
	Thu,  5 Nov 2026 17:16:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE897606D811
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1793899001; x=1825435001;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=ETDjIESv+Zh7NTQ8c2Qtz2fyj1TajF676spchz2GAvc=;
  b=WxvP/X1lmHNdFJEzcQnsc3sc4Su35af1rJOujjWCHdEA/jsglnEy+5dw
   PTnyLqx9TXD2cycxE7Dcpdu7WElLSSHZpH/o1huQPx8Zv+w5btXAPVWmx
   47edogsXSsV7Ui2hzdBAncMwK0GE+IpJ/y31+8qATFWN2IfT8UQspzhB+
   0dFwEUKunJVOhnDXh2A1vgN+0tduWRTR0AmpauOFTiQMBIKpyCbiYhUaC
   LFz9GC6ka9o/ELN8qqPeGYnArF+Sn35Z/bRk/coeIMHFLo8AnUvzX2uLJ
   N3tPL6IV1PYfOoa3ddzxgorr9Buu1XooWeDg/ArpoMoJ/BJcP61XVMNdP
   g==;
X-CSE-ConnectionGUID: k6QzcMJsStKTIHBSOZ6+Nw==
X-CSE-MsgGUID: lIKbWU7fTRqFSNyIMlMHeg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces04_data.me-crop.lan) ([146.255.191.134])
  by esa3.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 19:16:38 +0200
X-CSE-ConnectionGUID: vY74y+VITTSdvpVlDZKUGg==
X-CSE-MsgGUID: Op8jweWdRbGKTxuBCJeIdQ==
Received: from unknown (HELO epgd056.me-corp.lan) ([10.154.54.3])
  by ces04_data.me-crop.lan with SMTP; 05 Nov 2026 19:24:27 +0200
Received: by epgd056.me-corp.lan (sSMTP sendmail emulation); Thu, 05 Nov 2026 19:16:29 +0200
From: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Date: Thu, 05 Nov 2026 19:15:25 +0200
Subject: [PATCH RFC v3 04/14] i2c: core: add i2c_xfer_to_xfer_v2() helper
 function
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
Message-Id: <20261105-i2c-fault-reporting-v3-4-515ad74ac4c9@mobileye.com>
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

If an I2C bus driver implements i2c_xfer_v2() callback for multi-message
transfer with detailed reporting in its struct i2c_algorithm, it still
must have old xfer() callback for backward compatibility because this
callback sometimes is checked or called directly, without using
i2c_transfer().

To avoid code duplication for drivers that do not need different code
for transfer with and without detailed reporting enabled, provide a
helper function i2c_xfer_to_xfer_v2() that calls xfer_v2() with pointer
to a dummy struct i2c_transfer_report that will be dropped after using.

It should be used in xfer field of struct i2c_algorithm.

Signed-off-by: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
---
 drivers/i2c/i2c-core-base.c | 8 ++++++++
 include/linux/i2c.h         | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 165ec14260c8..12b49c01baed 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -2400,6 +2400,14 @@ int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 }
 EXPORT_SYMBOL(i2c_transfer);
 
+int i2c_xfer_to_xfer_v2(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
+{
+	struct i2c_transfer_report dummy_report;
+
+	return adap->algo->xfer_v2(adap, msgs, num, &dummy_report);
+}
+EXPORT_SYMBOL(i2c_xfer_to_xfer_v2);
+
 /**
  * i2c_transfer_buffer_flags - issue a single I2C message transferring data
  *			       to/from a buffer
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 9bee726592fc..6a4df8562ab4 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -601,6 +601,8 @@ struct i2c_algorithm {
 #endif
 };
 
+int i2c_xfer_to_xfer_v2(struct i2c_adapter *adap, struct i2c_msg *msgs, int num);
+
 static inline void i2c_transfer_report_init(struct i2c_transfer_report *report)
 {
 	report->msgs_cplt = -EOPNOTSUPP;

-- 
2.43.0

