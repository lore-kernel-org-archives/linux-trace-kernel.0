Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=207.54.77.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793898993;
	b=jXj6+kGNcTzNpyQGe2YkAEcrr6HFfpnAwc4Wd46dJBiXx1eLg3AUFNDWqVU126r5lnsD
	 h/zPYv+Iek3yYjrnKtrOCTAeRD1ZK1l2AQcNupZtUSF38zIRA4qoo6EUQ1XA/jadFO1Di
	 Mj1GA+H42C/CV7QsxFKu37myhlvgoiE9JB5kS7eA0OSBXCQNVluY4IfNXO9ZzPtEFe4VW
	 mqNxvgz2+HPAPhXHNI5XLZsh/kqeeE7FsVaZwis5XYR7CP3fR+3zRNM9FsmfZZp8DYSbb
	 C9YaMGCSQyvDbt4qWTW4xIWTcugKaVAOe1Xjr7wyNDaNBq6sF9KmxDEXCJoSuoDpZUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793898993;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=dOYfdxhTQE6miHpeR1fvtBzuyo960p8PFto6/UVXRJs=;
	b=jfoPk7vV1n5toEKcjiZwQkPzZffHn/3VvxDIK3fSiDDz7EDxCPsZKE3azXqzD0SUbe0d
	 0G8JRXS7Hq0wvPuwbmkZyKUkh5EPDdq0CjetLoNoaM2Iu81b2jk47kgs6+t2gCMYe7Bve
	 TO3crcUK3yi4vzKUeR8HqjofANptHua+fx+s4kl0vd1dcueicjxiXITEE182+vhYw7Y9k
	 JeSX20MALxRPq1zurR6Iog6MaD+etr+OgpjUGnqIAMX5msWYkcVw+3FSpTy+bYQeFj2ta
	 jW1uGcQI3QBSUjkUnzvy7EAbru7bTNBJW3UhFzS3po3Mg71HarZKS8lWZDOPPBHEQMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=207.54.77.50
Received: from esa3.hc555-34.eu.iphmx.com (esa3.hc555-34.eu.iphmx.com [207.54.77.50])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAEC606A328;
	Thu,  5 Nov 2026 17:16:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AAEC606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1793898999; x=1825434999;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=YpjmhVlx+holnUU9APQW5il/uttLbURlUiMfTjZsTJE=;
  b=mLdytLTmz8jjXjlUWR7ZSxH6qcVIp6Bb8JNHf2BMPzjdtJrGmqKom1h3
   4ZJ+rGJNwKxkU6Qontf7Tr0PtJsAmOntB0o+7s1R0fakZTpm2oUcLiZZ7
   6+hyhHK+9vNQj6MPAJBb2NsDeN+AqMz10Aobh5QQ1pgl61ZkDP7rjrCWP
   oKLUerQRI/tFjkA4eDEIwGj/ZktUTUz6wsDY4uialTsljfD9dWFi/fG2x
   zyDwambNzth/LU8gqRSSpheHVIfXPrMaAN258+fgIE/46jjxQcYYt3q2e
   lzShBEEYnSi/IC1+VatbnBP9EehNcqsurUE/xP9BT22OSwJHiQ36bjygH
   g==;
X-CSE-ConnectionGUID: 6NbJ9AgXTEGCV+Sk4npTag==
X-CSE-MsgGUID: 7bQ6RQDhTTO9Z7KjXH6H8w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces03_data.me-corp.lan) ([146.255.191.134])
  by esa3.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 19:16:35 +0200
X-CSE-ConnectionGUID: rsPO3BM3QemOm3ocJOoFRA==
X-CSE-MsgGUID: U0ErBUmjQrq6FBx4m/ejqA==
Received: from unknown (HELO epgd056.me-corp.lan) ([10.154.54.3])
  by ces03_data.me-corp.lan with SMTP; 05 Nov 2026 19:24:16 +0200
Received: by epgd056.me-corp.lan (sSMTP sendmail emulation); Thu, 05 Nov 2026 19:16:26 +0200
From: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Date: Thu, 05 Nov 2026 19:15:22 +0200
Subject: [PATCH RFC v3 01/14] i2c: uapi: add i2c_transfer_report structure
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
Message-Id: <20261105-i2c-fault-reporting-v3-1-515ad74ac4c9@mobileye.com>
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

Add i2c_transfer_report structure declaration for detailed transfer
reporting in case of a fault.

The structure has three fields:

- fault_msg_idx - index of message that caused fault;
- msgs_cplt - number of messages transferred successfully;
- bytes_cplt - number of bytes transferred in the last message if it was
  completed partially.

Signed-off-by: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
---
 include/uapi/linux/i2c.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/uapi/linux/i2c.h b/include/uapi/linux/i2c.h
index 2a226657d9f8..5e8e7d3536c8 100644
--- a/include/uapi/linux/i2c.h
+++ b/include/uapi/linux/i2c.h
@@ -135,6 +135,27 @@ struct i2c_msg {
 					 I2C_FUNC_SMBUS_READ_BLOCK_DATA | \
 					 I2C_FUNC_SMBUS_BLOCK_PROC_CALL)
 
+/* Detailed transfer report */
+
+struct i2c_transfer_report {
+	__s32 fault_msg_idx;		/* In case of a fault, index of the message that caused
+					 * the fault. If the bus driver cannot determine it, it
+					 * puts a negative error code. If there is no fault, the
+					 * value is equal to number of messages transferred.
+					 */
+	__s32 msgs_cplt;		/* Number of messages that are known to be transferred
+					 * successfully. If the bus driver cannot determine it, it
+					 * puts a negative error code. If there is no fault, the
+					 * value is equal to number of messages transferred.
+					 */
+	__s32 bytes_cplt;		/* In case of a fault, number of bytes in the message at
+					 * index `msgs_cplt` that are known to be transferred
+					 * successfully. If the bus driver cannot determine the
+					 * number of bytes, it puts a negative error value.
+					 * If there is no fault, the value is 0.
+					 */
+};
+
 /*
  * Data for SMBus Messages
  */

-- 
2.43.0

