Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.90.104.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793899001;
	b=xc20bX1p/6slbR7uMl31pPyJRbS7y/aPTaPhMPB8t5u/L382glSt3vGUzwv8ffdgkXDs
	 AfpxBfuZKtBoAHErp8EE/6T9UKacuoDBLMrts3QFfYpWCNWv4irAXeG4clchcMfqbpnxI
	 7Jz6GkNeQO4l70iQAJtPamMgHTahZNeAqXAz8KbRBWzZYVDZ/S0vREZHngQU0p3xyFaYO
	 CrTAh5AfY+Hqbx+AoSnDpruTTTrtWMdeFFyIllRiyv1OSzAQ+Ul3yfhIC4h3NUikjLJiV
	 CcSA25htIcn6WYwwfpaV7iNwkFdaJha2Ztm9pH9UVvJVMqAke0Ly0S2QqaPSPMPAvQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793899001;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=mlozEQJqTD17Kdg9fKmit8CMQRbYKQwG4XIhXLnNK9c=;
	b=ZUYGP5w1EDy/cVy0ANu7ptA2cD2YDzOJWZpIB6E/XO9AVdp6OUvBddRpmb6FJdonwFZX
	 n3IrX141XBAFoOiu3ahRlYE6ziHaV+ismrCeF3eq7WNTt5LYMQKvPi6BSVVmM96yFeFUw
	 0dqq7LcmfVfFNkr1vA6W7lul3eWUAJAaAPKobz+PRJIQOCHBg3AW0FrjAQvPu6kIB8ImF
	 Q69fHRHeezVvdydV9G7lT5Ovv5C2a1qvJmqy/xxSlRzoVi9ZKytC7wgahWK8M8JPWbEiF
	 Hs9n2wVFbSrhYyDIKwwXQu3NykWs6fT8oYC0/1GevQ3EB3Ko3IxLLyArCcjmuW1vV1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=23.90.104.144
Received: from esa1.hc555-34.eu.iphmx.com (esa1.hc555-34.eu.iphmx.com [23.90.104.144])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22B3606EEB1;
	Thu,  5 Nov 2026 17:16:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A22B3606EEB1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1793899000; x=1825435000;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=3jyyUN+2uw6JFBOwpE+o/eA+FGjKrA2InO/IUR82Kg0=;
  b=RfM7UhnIhV06jB+7r7sDhQw+iOO34rcYarqHQMvZ7VPA59sBi+D0VAnA
   gQzRoOJ59ycYadg+Il0PKUT+qC8y47pYMgW3Zt1Qom4NTWclMpYZtiCmv
   0Yna9+jNBWoxiutZ0KhisPGff5AzsgaLqeqeLhJF2dQQChSQGegY9evhc
   CoeQN/Pz5ITQeiiPJWO2g1WAiRL4VD24Hb/SKjhpX6lbzGWFEiA5IRhTG
   OcEdR2QACv3UvO1Y2+LBaZJ2kgPyPXMVl335WDJqGzSG5TWUuNcIQxE0n
   7K09k8jedNkt/tHo69LICvMmFWqgc96/3G3LQrPxR5IoPuD5ChSb3zaop
   g==;
X-CSE-ConnectionGUID: NYIjUvP0Q8q5IfoXBCRtyA==
X-CSE-MsgGUID: KbmlAUO+QtuWcj+BISCMRQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces02_data.me-corp.lan) ([146.255.191.134])
  by esa1.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 19:16:32 +0200
X-CSE-ConnectionGUID: Q2rOifoGRTWF94W7W8RBmQ==
X-CSE-MsgGUID: uJOAv3ouRK+VlizjS+FESw==
Received: from unknown (HELO epgd056.me-corp.lan) ([10.154.54.2])
  by ces02_data.me-corp.lan with SMTP; 05 Nov 2026 19:24:30 +0200
Received: by epgd056.me-corp.lan (sSMTP sendmail emulation); Thu, 05 Nov 2026 19:16:30 +0200
From: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Date: Thu, 05 Nov 2026 19:15:26 +0200
Subject: [PATCH RFC v3 05/14] i2c: trace: pass message length separately in
 trace_i2c_reply()
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
Message-Id: <20261105-i2c-fault-reporting-v3-5-515ad74ac4c9@mobileye.com>
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

In trace_i2c_reply(), add separate argument for message length and use it
instead of taking the message length from struct i2c_msg. This allows to
trace the read data of an interrupted read message.

This is preparation for implementation of detailed transfer reporting
feature.

Signed-off-by: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
---
 drivers/i2c/i2c-core-base.c |  2 +-
 include/trace/events/i2c.h  | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 12b49c01baed..3dd7ef02c562 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -2349,7 +2349,7 @@ int __i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 		int i;
 		for (i = 0; i < ret; i++)
 			if (msgs[i].flags & I2C_M_RD)
-				trace_i2c_reply(adap, &msgs[i], i);
+				trace_i2c_reply(adap, &msgs[i], msgs[i].len, i);
 		trace_i2c_result(adap, num, ret);
 	}
 
diff --git a/include/trace/events/i2c.h b/include/trace/events/i2c.h
index 142a23c6593c..b3267dcec420 100644
--- a/include/trace/events/i2c.h
+++ b/include/trace/events/i2c.h
@@ -88,22 +88,22 @@ TRACE_EVENT_FN(i2c_read,
  */
 TRACE_EVENT_FN(i2c_reply,
 	       TP_PROTO(const struct i2c_adapter *adap, const struct i2c_msg *msg,
-			int num),
-	       TP_ARGS(adap, msg, num),
+			int data_len, int num),
+	       TP_ARGS(adap, msg, data_len, num),
 	       TP_STRUCT__entry(
 		       __field(int,	adapter_nr		)
 		       __field(__u16,	msg_nr			)
 		       __field(__u16,	addr			)
 		       __field(__u16,	flags			)
 		       __field(__u16,	len			)
-		       __dynamic_array(__u8, buf, msg->len)	),
+		       __dynamic_array(__u8, buf, data_len)	),
 	       TP_fast_assign(
 		       __entry->adapter_nr = adap->nr;
 		       __entry->msg_nr = num;
 		       __entry->addr = msg->addr;
 		       __entry->flags = msg->flags;
-		       __entry->len = msg->len;
-		       memcpy(__get_dynamic_array(buf), msg->buf, msg->len);
+		       __entry->len = data_len;
+		       memcpy(__get_dynamic_array(buf), msg->buf, data_len);
 			      ),
 	       TP_printk("i2c-%d #%u a=%03x f=%04x l=%u [%*phD]",
 			 __entry->adapter_nr,

-- 
2.43.0

