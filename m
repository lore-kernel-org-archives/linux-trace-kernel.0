Received: from esa4.hc555-34.eu.iphmx.com (esa4.hc555-34.eu.iphmx.com [207.54.77.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B372B317146;
	Tue, 23 Jun 2026 16:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.77.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782232356; cv=none; b=EyfRIUY3m7wHAynaYP6gRxgsCSjJUI2MUbZqZDvpxx/tIGYsfeZ5xXd1wCqmPoNq5QfB4L6l+6PC/nA1sAY6SiM7LZKmXHJNKKgmmnuIC2pLnh/mQIKsglde+wfbXGS70SjVwBXx9t549Pff+4Nib39tcrrxkGx8ENWTRwy58nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782232356; c=relaxed/simple;
	bh=+Z2cQgxr6f9W2AYTe4LfLElv/Xuc2xJlHOPLDdzJPfU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rejcJiONwMaUjX7IYAa53N33DiTn2eDs1jYfsVSW4H2W5itEPK1DUSy0Evqf6LSeqclqo6Xjwi/QpKdm0gz3c9zU+gfc3NgPUK96VNLNy8RMupaLdpwhumo7S+d3LfOPzn6roZe8YKO3mp/X94zrhkCKJV86PY6jk2oTP83qweQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com; spf=pass smtp.mailfrom=mobileye.com; dkim=fail (0-bit key) header.d=mobileye.com header.i=@mobileye.com header.b=INHqJ29/ reason="key not found in DNS"; arc=none smtp.client-ip=207.54.77.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mobileye.com header.i=@mobileye.com header.b="INHqJ29/"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1782232347; x=1813768347;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=+Z2cQgxr6f9W2AYTe4LfLElv/Xuc2xJlHOPLDdzJPfU=;
  b=INHqJ29/5Ko7QG+InMcf4e9UQ+Lgt3p+YTICvDEWnWIbLLAgU34oFtoF
   wHrTxKNRYG4wSwPE+nayff0+6LDw+IUhr755/HpIPWVfuboAHaAFCZRtq
   qEmkXR0g6Z0S4HVNcgD81GRTICTEKsS07wFym6BLI4V6tzxLL+YJ0wZDM
   rBfa3o9EVn40+ygWg2zpFzfBz5GJbt9J+Nju0gwWDXmK7mtTa25OzXHng
   +9Tc89pzXESbzUJAElNAOc4rE2gBQp2jJjs5rAU2U0/MaULNUUaZMdN3A
   5MP1r0b+E8I4cwskfo11kAa8kRibkE5nvTWj6qH0lSnwzKTm3ib/R2WoA
   A==;
X-CSE-ConnectionGUID: 43BQM9bNRq6K4/FrGlLoHQ==
X-CSE-MsgGUID: xtKA2yEsRJCGfI9UGXP8Fw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces04_data.me-crop.lan) ([146.255.191.134])
  by esa4.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 19:32:26 +0300
X-CSE-ConnectionGUID: mMrEQ/VaSZOzmZ9RjiL74A==
X-CSE-MsgGUID: 9qbGRbl6STyEoZClwz4xOw==
Received: from unknown (HELO epgd056.me-corp.lan) ([10.154.54.2])
  by ces04_data.me-crop.lan with SMTP; 23 Jun 2026 19:37:33 +0300
Received: by epgd056.me-corp.lan (sSMTP sendmail emulation); Tue, 23 Jun 2026 19:32:24 +0300
From: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Date: Tue, 23 Jun 2026 19:31:53 +0300
Subject: [PATCH 6/7] i2c: nomadik: add quirks max_len=2047 and
 no_zero_len_read
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260623-i2c-fault-reporting-v1-6-6db1a8aabf18@mobileye.com>
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

In Nomadik I2c controller, register I2C_MCR has 11-bit wide LENGTH
field. Its maximum value is 2047, so this is the maximum length of a
single message. It is less than the common maximum I2C message length in
I2C subsystem (8192), so define a quirk in order to report the
unsupported message without any attempt to transfer it.

Zero length reading doesn't work properly on this controller, so add
`I2C_AQ_NO_ZERO_LEN_READ` quirk flag.

Signed-off-by: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
---
 drivers/i2c/busses/i2c-nomadik.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index 7d93fb3876dc1324003dd19884e3fd5cbba9cfbb..9cff0c2757fafeaf809395e02a5e754570f65e08 100644
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
@@ -1162,6 +1171,7 @@ static int nmk_i2c_probe(struct amba_device *adev, const struct amba_id *id)
 	adap->class = I2C_CLASS_DEPRECATED;
 	adap->algo = &nmk_i2c_algo;
 	adap->timeout = usecs_to_jiffies(priv->timeout_usecs);
+	adap->quirks = &nmk_i2c_quirks;
 	snprintf(adap->name, sizeof(adap->name),
 		 "Nomadik I2C at %pR", &adev->res);
 

-- 
2.43.0

