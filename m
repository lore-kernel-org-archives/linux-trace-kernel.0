Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.90.104.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793899006;
	b=qZZ+zk/qRx4X6Rp4PcppM/iufQboHG6L1rbytXCjUOTdUkj/CqmdsRqdL63Ndda2Wj61
	 PlTFWnnzBHRQdT7rxgRpteoFHOsTfkVqzoH1UFuabXUBWyejIGXmPx0vzPaBE+OT6xXZ2
	 bUStDm59gn0hRCTkEUIvpHN6T8fvmNnyT225BeRWSIL4jNNKRkVtVdWeSMslWhaF+t6+L
	 3sfUT2GYfPhJ5qQtZUeu8x/F1JCLrR/cJlYQCSi30QQJ4U2FBVut1DXMrnVqja3Dfob1+
	 U8jiJ/fCdlE9yfwRZkBC00KNmzyHAWCQwB11AEOITJdIrfA/u17gqvz+iczfeQN4CZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793899006;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=T7tP7R2n8WhWHJO0GCJusIxU/QUf54O8a8To4Y8YAJA=;
	b=leY8kU3zCI9MTUPsWrBGRXskORl9eHWxlfryYTWbv9onGSal69vMcyUOeZKhQApzQWZL
	 F9euhJZGfGin2eyu7iG72QGxPRAZPvu75M44sQ1JnZcuGjiXRBNtA/WKcdQ2QGPdAJ+0s
	 Raz8ogzyHP8TMcLOYDJOUno/nB/JyFz2SYcgLFMiwUsNh8HasXEwvnyWu2p4AHXFsenO1
	 3udrrNuy5X3fmjtezCgk4klsS4DEBe/kW1pYeHgsXktEBucBQqvd/f4RJCAWL/OS/CozK
	 zw4S/kwaBebjUIRQF6tc20A+RM9eMqzb6rYNYtI5bTjpVYt5LKBpy3sj1uNT/HMik+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=23.90.104.147
Received: from esa2.hc555-34.eu.iphmx.com (esa2.hc555-34.eu.iphmx.com [23.90.104.147])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660326082BEB;
	Thu,  5 Nov 2026 17:16:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 660326082BEB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1793899013; x=1825435013;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=/+cabZaiN4XfIIx659yXwo3U+cCoXUx1gf9HDDu89No=;
  b=ZY5JCgOm3eobCloQduWGwXlJX2Jt5Zakj/oO9EOJo5OhycZU3ecpqJFa
   rFYpI+JaRV+iLezmKZ1ixNrLjttH4T/PWrgmPA0bPfsbe9Y7lH8o89Cd6
   M7CrAWhh5Tm/XW8v9UzKgTv7tZFILgtKTjaBGf4IoF5zu7/Jdt7sklOIO
   /dMel87s/IIciQGRgJKHQWFpJhOdpIAmUqbhKt3KUR36u/povcejPKKe1
   BkL83xVjTif8wd2KEDeuWrm9fsYhsfkzynxixEhEw5y0MSoquOwHIeak0
   pgajCDY+6iaKl36NG+R0j5Ae4uu3Bntfc3EyXQ/LF6L7SYHQ9KndDsq7Z
   g==;
X-CSE-ConnectionGUID: NCGXBDD1Rt+T5depArDyFQ==
X-CSE-MsgGUID: 6o8eMIcaRx+vM26W1Rj0Pg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces01_data.me-corp.lan) ([146.255.191.134])
  by esa2.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 19:16:37 +0200
X-CSE-ConnectionGUID: c6LJYtgqStywnTEpyIVnaw==
X-CSE-MsgGUID: W1xX3KOGTdCBR+CU05DcGg==
Received: from unknown (HELO epgd056.me-corp.lan) ([10.154.54.2])
  by ces01_data.me-corp.lan with SMTP; 05 Nov 2026 19:24:40 +0200
Received: by epgd056.me-corp.lan (sSMTP sendmail emulation); Thu, 05 Nov 2026 19:16:36 +0200
From: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Date: Thu, 05 Nov 2026 19:15:31 +0200
Subject: [PATCH RFC v3 10/14] i2c: doc: add section for I2C_RDWR_V2 ioctl
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
Message-Id: <20261105-i2c-fault-reporting-v3-10-515ad74ac4c9@mobileye.com>
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

I2C_RDWR_V2 is a new ioctl for I2C controller devices. It has the same
functionality as I2C_RDWR, with additional feature - in case of a fault
during transfer, it provides information how many messages and bytes were
successfully transferred and which message caused the fault.

Add documentation section about the new ioctl and the structures it uses.

Signed-off-by: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
---
 Documentation/i2c/dev-interface.rst | 48 +++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/Documentation/i2c/dev-interface.rst b/Documentation/i2c/dev-interface.rst
index c277a8e1202b..95e60bdb2f4d 100644
--- a/Documentation/i2c/dev-interface.rst
+++ b/Documentation/i2c/dev-interface.rst
@@ -140,6 +140,54 @@ The following IOCTLs are defined:
   The slave address and whether to use ten bit address mode has to be
   set in each message, overriding the values set with the above ioctl's.
 
+``ioctl(file, I2C_RDWR_V2, struct i2c_rdwr_v2_ioctl_data *msgset)``
+  Does the same combined read/write transaction as I2C_RDWR, but also
+  provides detailed fault report. The argument is a pointer to a::
+
+    struct i2c_rdwr_v2_ioctl_data {
+	    struct i2c_rdwr_ioctl_data rdwr_data;
+	    struct i2c_transfer_report report;
+    };
+
+  rdwr_data is the same structure as the argument for I2C_RDWR ioctl.
+  report is the structure that the transfer report is written to::
+
+    struct i2c_transfer_report {
+      __s32 fault_msg_idx;
+      __s32 msgs_cplt;
+      __s32 bytes_cplt;
+    };
+
+  msgs_cplt is the number of messages that has been sent or received
+  successfully. If there are read messages within this range, the returned
+  data is guaranteed to be valid. If a message has been read from the
+  device but the read data is lost (for example, FIFO is flushed before
+  CPU read it), this message must not be counted.  If the controller cannot
+  determine the number of completed messages, the value is -EOPNOTSUPP.
+
+  fault_msg_idx is the number of messages that caused a fault. In case of a
+  fault, it is not necessary equal to msgs_cplt. For example, if the driver
+  validates the whole batch before starting transmission, detects that it
+  cannot send it, it returns -EOPNOTSUPP error immediately, so msgs_cplt is 0,
+  while fault_msg_idx points to the message that cannot be sent. Another
+  example when these two value may be different is I2C controller that
+  flushes RX FIFO when an error is detected before CPU reads data from it.
+
+  If there is no fault, the fault_msg_idx value is equal to msgs_cplt.
+
+  bytes_cplt indicates the number of bytes sent/received in the message at
+  index msgs_cplt. If this is a read message, it is guaranteed that these
+  bytes in the message data buffer are valid. If the controller cannot
+  determine the byte count, the value should be -EOPNOTSUPP. If there was
+  no fault or no data was transferred successfully in the faulty message
+  (for example, NACK on target address or first data byte), the value should
+  be 0.
+
+  To discover whether the device supports detailed fault reporting, use
+  I2C_RDWR_V2 ioctl with nmsgs = 0. If the driver supports it, the return
+  value should be 0. If the driver supports only plain I2C_RDWR, the return
+  value should be -EOPNOTSUPP. In any case, nothing is done on wire.
+
 ``ioctl(file, I2C_SMBUS, struct i2c_smbus_ioctl_data *args)``
   If possible, use the provided ``i2c_smbus_*`` methods described below instead
   of issuing direct ioctls.

-- 
2.43.0

