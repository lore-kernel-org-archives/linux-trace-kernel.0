Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=207.54.77.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793898997;
	b=wCWT1tdj+z+JThY3R8h1QhvsH1XlrgOhP21cgsF/GHmFLe0GI0acqcIA5/CM95LttvHs
	 UD9GgyMevBtmf/nRocKKPYyB4JsHduWvs5NbXHJwYtggi5AHcPUqnMd/sn7F3urxwFiJC
	 b2pfZYE/sNIOUCcYztC/TXF8o94nAEPCT8Eu9LAOAJLRR+jU7vLDz3wMgtal6px5q7x4N
	 lM7E+lvk4HwNG35nDB2M+I05BQcsAnlkz4agUTGfDGpFIPRzHYbdMF5BVxSPKewBx5AlW
	 Bg8sdqFl8VCsX8M/G1xlTPbjM93MomrqeSDlS+53/x9GCjcd5M/21s+CLeDI4AE1c7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793898997;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=L7PfW0w9w4vPHWcoJQq9wrlaGYaPvcqfDhLDkXUySZg=;
	b=GUiNyYl3jt0kN3CZXQmyPxRmDAxBtxPlgsYpbN6r6ygoi5oJlVtYBu33EkGYaJE3EIc6
	 ung7Q/76gBa3b5eKuLkvU2REEncEk7n62tSXHoUPhAAif2jie7IvA/Xw+uOzM0wgYuw4o
	 lsnJES69iQdvWZqNn3CITtLsN09i4upTb/grv+rm4JVu8tmU7fLYCnedxkOPEKnkWMca6
	 R55MXH5eEco2PoM7nxXVMUY/2LD96Mp+6SxBThwL1gDtlJ4WpfYot71tBDbTac7Qi5g8W
	 sALdJhfieMpnasuDCKRPnt8aBtSEFmKQ0OjQ+BumEtd/ReUtQjpAlG+oqHe1HiAHL8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=207.54.77.50
Received: from esa3.hc555-34.eu.iphmx.com (esa3.hc555-34.eu.iphmx.com [207.54.77.50])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB831606EE87;
	Thu,  5 Nov 2026 17:16:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB831606EE87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1793899004; x=1825435004;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=mPXDpDXk7iYLdkJnXSbOYchRVsaiItuRno2Q6Q7CGuw=;
  b=cC2AZqomeq6oR0EpDrLwHUUpPP/GKAN+FCO5kN4JuG+z9lhjvx8tYNST
   1HnvMLcaLbeBakgSTe490HMraaHawp/pM3+H2GWGFsaGq2aWAhEE3CG1W
   MxME/H2i1joAiQI56P8X++CcZYIb0a5JZYl4sxtlXYzUItPLjhVxS1Lv0
   UJ+pXSlf/wfmI3HZNBkiwyD6fhaGQyqpNp0v0xEm/pv8vEazqJrgTmKS9
   CnsIXcewrVB4Ipn1Z99aCIntlhR0GKIs8mi0ikW8cpRrFQ46wUoNgOc9e
   Hu9qCG6B0M67mKUj5jqoefLwrLzoCNSdQd+Tpqe7993TFnoCf3I6ZRHq/
   A==;
X-CSE-ConnectionGUID: ZFaMPsdJTa+hF7AyHIluTQ==
X-CSE-MsgGUID: P7aw34uVR76Dtmp7irlltw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces03_data.me-corp.lan) ([146.255.191.134])
  by esa3.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 19:16:42 +0200
X-CSE-ConnectionGUID: 6gkyCM6BQdqLiTZNHvDv0A==
X-CSE-MsgGUID: suYRD3d+RUKY/qNhMfdJ9A==
Received: from unknown (HELO epgd056.me-corp.lan) ([10.154.54.2])
  by ces03_data.me-corp.lan with SMTP; 05 Nov 2026 19:24:23 +0200
Received: by epgd056.me-corp.lan (sSMTP sendmail emulation); Thu, 05 Nov 2026 19:16:34 +0200
From: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Date: Thu, 05 Nov 2026 19:15:29 +0200
Subject: [PATCH RFC v3 08/14] i2c: uapi: add I2C_XFER_V2 ioctl - detailed
 fault reporting
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
Message-Id: <20261105-i2c-fault-reporting-v3-8-515ad74ac4c9@mobileye.com>
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

For user-space access to I2C multi-message transfer with detailed
reporting functionality, add I2C_XFER_V2 ioctl and corresponding
struct i2c_rdwr_v2_ioctl_data.

The structure consists of struct i2c_rdwr_ioctl_data that used in the
same way as in I2C_XFER, and struct i2c_transfer_report that the
detailed transfer report is put in.

Signed-off-by: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
---
 include/uapi/linux/i2c-dev.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/uapi/linux/i2c-dev.h b/include/uapi/linux/i2c-dev.h
index 1c4cec4ddd84..5097568a3149 100644
--- a/include/uapi/linux/i2c-dev.h
+++ b/include/uapi/linux/i2c-dev.h
@@ -11,11 +11,13 @@
 
 #include <linux/types.h>
 #include <linux/compiler.h>
+#include <linux/i2c.h>
 
 /* /dev/i2c-X ioctl commands.  The ioctl's parameter is always an
  * unsigned long, except for:
  *	- I2C_FUNCS, takes pointer to an unsigned long
  *	- I2C_RDWR, takes pointer to struct i2c_rdwr_ioctl_data
+ *	- I2C_RDWR_V2, takes pointer to struct i2c_rdwr_v2_ioctl_data
  *	- I2C_SMBUS, takes pointer to struct i2c_smbus_ioctl_data
  */
 #define I2C_RETRIES	0x0701	/* number of times a device address should
@@ -33,6 +35,7 @@
 #define I2C_FUNCS	0x0705	/* Get the adapter functionality mask */
 
 #define I2C_RDWR	0x0707	/* Combined R/W transfer (one STOP only) */
+#define I2C_RDWR_V2	0x0709  /* I2C_RDWR with detailed fault reporting */
 
 #define I2C_PEC		0x0708	/* != 0 to use PEC with SMBus */
 #define I2C_SMBUS	0x0720	/* SMBus transfer */
@@ -52,6 +55,12 @@ struct i2c_rdwr_ioctl_data {
 	__u32 nmsgs;			/* number of i2c_msgs */
 };
 
+/* This is the structure as used in the I2C_RDWR_V2 ioctl call */
+struct i2c_rdwr_v2_ioctl_data {
+	struct i2c_rdwr_ioctl_data rdwr_data;
+	struct i2c_transfer_report report;
+};
+
 #define  I2C_RDWR_IOCTL_MAX_MSGS	42
 /* Originally defined with a typo, keep it for compatibility */
 #define  I2C_RDRW_IOCTL_MAX_MSGS	I2C_RDWR_IOCTL_MAX_MSGS

-- 
2.43.0

