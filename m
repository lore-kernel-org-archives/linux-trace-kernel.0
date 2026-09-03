Received: from esa1.hc555-34.eu.iphmx.com (esa1.hc555-34.eu.iphmx.com [23.90.104.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8753446CE;
	Thu,  3 Sep 2026 05:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.90.104.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788414003; cv=none; b=PsXwtfbKGiK6+vhuyQj7ckaj4utMPgEhfpF/uT2NRw/zR3yxe1aQP7vlSXPfxQxvGIP3+X8g1NqyjcdyZSZNbvJyeySVjUtYuJ3MWW1yp3BWbWjzqRsl89OG0TrMK5hUtwLkQqC4mp8hMV/zhLrtBTlNgujwHrbfVjqFwbINrRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788414003; c=relaxed/simple;
	bh=ngGDtfpm/5mhvpzqlcomRG1s4PNkluY8gIbRm8fwLA8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=grwvgnrXPMaikzLsNfk1BBVpA+Bf/B6F2EG8V+/o8P8UTN2nzyZnzJPOf78MVrFc0DtjlMZfEPy4KpQBMan2jCGs3KXMqRCYM2QJB0UPGWwzuSv8rEQd+lW+Fx9cUixsrJod2u3Lc2KhPZ20Om4H92V4zXTKfy+foZ0B4ma6vGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com; spf=pass smtp.mailfrom=mobileye.com; dkim=fail (0-bit key) header.d=mobileye.com header.i=@mobileye.com header.b=oqrKNgh5 reason="key not found in DNS"; arc=none smtp.client-ip=23.90.104.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mobileye.com header.i=@mobileye.com header.b="oqrKNgh5"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1788413996; x=1819949996;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=ngGDtfpm/5mhvpzqlcomRG1s4PNkluY8gIbRm8fwLA8=;
  b=oqrKNgh5U38X2Cu/PPhPNRSCezyLWLiqKh5JB7kLcH/coTw7NtDppDBS
   pY4Iq4F+BTTC2gI5zV9DVgPPQoFdV5+dbJ0/LTigeBXn2z47QjI3wo0wd
   Yl/uPgIUyaM2a/jejsA/aq/uvQLnG6nWpKW7ML4w4ZIYpj06j0IT6W1iB
   92r9tj0ZTveN/sWGxjy6pX5olrS4HTYOcHzmrSPY3XjXv+gc119LT03dt
   ycmpVa0BjN1sFM8iSqbbL7YXYtv3ge1YORt1AUsrHSJIobrA3hGaUbyVu
   i7LBP/tI7lzz6fROk2cVZXWd4DD7Yj/8qJrOkhHv8chzO3VnBtfPm0E18
   A==;
X-CSE-ConnectionGUID: BKzXfXlOS5uYZ2kKHy4/sw==
X-CSE-MsgGUID: mk5qw241RI6HyVpvebXJUA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces04_data.me-crop.lan) ([146.255.191.134])
  by esa1.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 08:38:42 +0300
X-CSE-ConnectionGUID: NsHN44qGTJiJHqU79igiIA==
X-CSE-MsgGUID: AHHKGvs0QmqFFmKhMvwnVg==
Received: from unknown (HELO epgd056.me-corp.lan) ([10.154.54.2])
  by ces04_data.me-crop.lan with SMTP; 03 Sep 2026 08:45:18 +0300
Received: by epgd056.me-corp.lan (sSMTP sendmail emulation); Thu, 03 Sep 2026 08:38:42 +0300
From: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Date: Thu, 03 Sep 2026 08:38:13 +0300
Subject: [PATCH v2 06/12] i2c: nomadik: add quirks max_len=2047 and
 no_zero_len_read
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-i2c-fault-reporting-v2-6-fedeb91792e6@mobileye.com>
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

In Nomadik I2c controller, register I2C_MCR has 11-bit wide LENGTH
field. Its maximum value is 2047, so this is the maximum length of a
single message. It is less than the common maximum I2C message length in
I2C subsystem (8192), so define a quirk in order to report the
unsupported message without any attempt to transfer it.

Zero length reading doesn't work properly on this controller, so add
`I2C_AQ_NO_ZERO_LEN_READ` quirk flag.

Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
---
 drivers/i2c/busses/i2c-nomadik.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index 9c7658148bd45ecdaef1f998558315580233555d..c36e9961e0a39e76386a6e20f6e0b6fec3d5b5a9 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -79,6 +79,9 @@
 #define I2C_MCR_STOP		BIT(14)		/* Stop condition */
 #define I2C_MCR_LENGTH		GENMASK(25, 15)	/* Transaction length */
 
+/* Controller hardware limitation of the message length */
+#define I2C_MAX_MSG_LENGTH	(I2C_MCR_LENGTH >> 15)
+
 /* Status register (SR) */
 #define I2C_SR_OP		GENMASK(1, 0)	/* Operation */
 #define I2C_SR_STATUS		GENMASK(3, 2)	/* controller status */
@@ -238,6 +241,12 @@ static int fault_codes[] = {
 	EIO
 };
 
+static const struct i2c_adapter_quirks nmk_i2c_quirks = {
+	.flags = I2C_AQ_NO_ZERO_LEN_READ,
+	.max_read_len  = I2C_MAX_MSG_LENGTH,
+	.max_write_len = I2C_MAX_MSG_LENGTH,
+};
+
 static inline void i2c_set_bit(void __iomem *reg, u32 mask)
 {
 	writel(readl(reg) | mask, reg);
@@ -1161,6 +1170,7 @@ static int nmk_i2c_probe(struct amba_device *adev, const struct amba_id *id)
 	adap->class = I2C_CLASS_DEPRECATED;
 	adap->algo = &nmk_i2c_algo;
 	adap->timeout = usecs_to_jiffies(priv->timeout_usecs);
+	adap->quirks = &nmk_i2c_quirks;
 	snprintf(adap->name, sizeof(adap->name),
 		 "Nomadik I2C at %pR", &adev->res);
 

-- 
2.43.0

