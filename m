Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.90.104.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793899003;
	b=1pMuf7kz769SbpFKHnj07v+sCy29aCqcGW5BDyBwSr76Kzp1wxR2ctI2CoF81HvNXE45
	 aZkaaL02QJVEFg+GN/HkVACV/xatbGGiHAj6VYmExTkn/errMsP2RsUdHdUWfWGYSZxxl
	 BVXYVKhwEhiutw9ug+ShpSeiZccWnMVjoUGdu4V6yjeoSTO1xiNbY4ye1SSCEepXOH/1Q
	 1ER7l8jsUDsTfr/p1PGGqucnkw2JiN4+JFFTgB/E+hebrRw21j8kVAvTLew7dFXo50PHA
	 uoexHHjY1lwy/SSwPIYCuRiW94sh4ZSsoA+cEwtjeG5XL6VBmtgjsq752IlvJlBUHsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793899003;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=G8OEW2oMhJH1UyxWk63Qgz4BWFzIqv2porLIH+T4v+Y=;
	b=4Erfgx5k1lgjJyZoLjcvAP/k1u5hb5R60AfV+EDXBaq2O7Un057379rW2RVA2MTr+Gjg
	 k34A9KHukLETzpsACRa42uz3kp8NmhXbKK0iW09G0CwXC8YIHgICFrr5nFeWnXDTWwAl7
	 LraxtpoO6cLHjKk8UAilCbNOr52pulxL4sLn8ONU0N8ERHe5Q/9vuvOeXbmBrjHh3l2W6
	 fUVIKBUkbqouDy66vlxpSjO9dx5bfxeE+ElOFL23/1CNFR+PCx3+tmzX0mI+MVawxYgM2
	 5ttqOlV4fOjNJE1bEU1/9ZRU+LpRWezbiA/3y3Er9vaUFYwmRqaFRILTJDvM692wO/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=23.90.104.144
Received: from esa1.hc555-34.eu.iphmx.com (esa1.hc555-34.eu.iphmx.com [23.90.104.144])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0772A6082BC1;
	Thu,  5 Nov 2026 17:16:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0772A6082BC1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1793899001; x=1825435001;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=u8JZnmjS3IQKnZG0ImyZQfEmDzkCLtrT3qM2bwJYsBQ=;
  b=PVR83fMgoXOR+SXesoUARdtTGCyEmppTxkc2B56NlbClJ36F3ygxm8Ax
   MRGeQpMcjJ0O6sx359Z6J5SaZ5UpMCUo6qmPCd+GW08/ANSH44bv8t+aF
   xsig4cJNNp4SOt/aUsxNE9Tv6FBlBGJ1NidX+TpUVIDjLdada8l5Vktlx
   LHikfKGmw2L0l8XDHhy9xPntnT4lzXef+/3yrT62h9VSOusnjdzcPWC/h
   Ru0Ru0TSpYLGDLKacnft0biAzaFaeFobiG+C6jP6ReiRDZviLy05YcVNn
   Vta/KNvH69zQodrmNpOkLSOlpYHbQJJJ+duGjXsDBTFD4xyUvaZIzcILy
   w==;
X-CSE-ConnectionGUID: NYIjUvP0Q8q5IfoXBCRtyA==
X-CSE-MsgGUID: BOgUS6YiRmCiGnIsAUOqFQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces02_data.me-corp.lan) ([146.255.191.134])
  by esa1.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 19:16:34 +0200
X-CSE-ConnectionGUID: TjAjZrnoQMiuCLkkx3d0oA==
X-CSE-MsgGUID: T6XPbA59Q6WGnPYNrnP5Iw==
Received: from unknown (HELO epgd056.me-corp.lan) ([10.154.54.2])
  by ces02_data.me-corp.lan with SMTP; 05 Nov 2026 19:24:32 +0200
Received: by epgd056.me-corp.lan (sSMTP sendmail emulation); Thu, 05 Nov 2026 19:16:33 +0200
From: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Date: Thu, 05 Nov 2026 19:15:28 +0200
Subject: [PATCH RFC v3 07/14] i2c: core: implement i2c_transfer_v2() -
 transfer with detailed reporting
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
Message-Id: <20261105-i2c-fault-reporting-v3-7-515ad74ac4c9@mobileye.com>
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

In __i2c_transfer() and i2c_transfer(), add one more parameter - pointer
to transfer report. In __i2c_transfer(), if the pointer is not NULL,
use algo->xfer_v2() callback instead of algo->xfer() in order to get the
detailed transfer report. If the adapter does not have xfer_v2(), return
-EOPNOTSUPP.

If the adapter has any quirks that make impossible to transfer requested
message or messages, put the index of the first such message to the
transfer report structure.

If the report is not NULL, algo->xfer_v2() returned an error and there
are any read messages, trace the read data using `trace_i2c_reply(). If
the last read message is incomplete (transfer was interrupted in the
middle of a read message), trace the read portion of data also.

Rename __i2c_transfer() to __i2c_transfer_v2() and i2c_transfer() to
i2c_transfer_v2().

For backward compatibility, add __i2c_transfer() and i2c_transfer() that
call __i2c_transfer_v2() and i2c_transfer_v2() respectively with null
report pointer.

Remove comment "REVISIT the fault reporting model here is weak".

Signed-off-by: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
---
 drivers/i2c/i2c-core-base.c | 115 ++++++++++++++++++++++++++++++++------------
 include/linux/i2c.h         |   8 +++
 2 files changed, 93 insertions(+), 30 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 23ff02a1e532..e8449f55f045 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -2288,22 +2288,37 @@ static struct i2c_msg *i2c_check_for_quirks(struct i2c_adapter *adap,
 }
 
 /**
- * __i2c_transfer - unlocked flavor of i2c_transfer
+ * __i2c_transfer_v2 - unlocked flavor of i2c_transfer_v2
  * @adap: Handle to I2C bus
  * @msgs: One or more messages to execute before STOP is issued to
  *	terminate the operation; each message begins with a START.
  * @num: Number of messages to be executed.
+ * @report: The buffer for detailed transfer report (may be NULL).
  *
  * Returns negative errno, else the number of messages executed.
+ * Writes the detailed transfer report to the structure pointed by @report.
  *
  * Adapter lock must be held when calling this function. No debug logging
  * takes place.
  */
-int __i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
+int __i2c_transfer_v2(struct i2c_adapter *adap, struct i2c_msg *msgs, int num,
+		      struct i2c_transfer_report *report)
 {
 	unsigned long orig_jiffies;
 	int ret, try;
 
+	if (report) {
+		/* Initialize the report structure with -EOPNOTSUPP in all fields.
+		 * This differentiates from the case when the adapter supports
+		 * fault reporting and returns -EOPNOTSUPP because it cannot transfer
+		 * a certain message.
+		 */
+		i2c_transfer_report_init(report);
+
+		if (!adap->algo->xfer_v2)
+			return -EOPNOTSUPP;
+	}
+
 	if (!adap->algo->master_xfer) {
 		dev_dbg(&adap->dev, "I2C level transfers not supported\n");
 		return -EOPNOTSUPP;
@@ -2316,8 +2331,16 @@ int __i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 	if (ret)
 		return ret;
 
-	if (adap->quirks && i2c_check_for_quirks(adap, msgs, num))
-		return -EOPNOTSUPP;
+	if (adap->quirks) {
+		struct i2c_msg *bad_msg;
+
+		bad_msg = i2c_check_for_quirks(adap, msgs, num);
+		if (bad_msg) {
+			if (report)
+				i2c_transfer_report_bad_msg(report, bad_msg - msgs);
+			return -EOPNOTSUPP;
+		}
+	}
 
 	/*
 	 * i2c_trace_msg_key gets enabled when tracepoint i2c_transfer gets
@@ -2336,10 +2359,14 @@ int __i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 	/* Retry automatically on arbitration loss */
 	orig_jiffies = jiffies;
 	for (ret = 0, try = 0; try <= adap->retries; try++) {
-		if (i2c_in_atomic_xfer_mode() && adap->algo->master_xfer_atomic)
+		if (i2c_in_atomic_xfer_mode() && adap->algo->master_xfer_atomic) {
 			ret = adap->algo->master_xfer_atomic(adap, msgs, num);
-		else
-			ret = adap->algo->master_xfer(adap, msgs, num);
+		} else {
+			if (report)
+				ret = adap->algo->xfer_v2(adap, msgs, num, report);
+			else
+				ret = adap->algo->master_xfer(adap, msgs, num);
+		}
 
 		if (ret != -EAGAIN)
 			break;
@@ -2348,58 +2375,86 @@ int __i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 	}
 
 	if (static_branch_unlikely(&i2c_trace_msg_key)) {
-		int i;
-		for (i = 0; i < ret; i++)
+		int i, n;
+
+		if (report)
+			n = report->msgs_cplt;
+		else
+			n = ret;
+		for (i = 0; i < n; i++)
 			if (msgs[i].flags & I2C_M_RD)
 				trace_i2c_reply(adap, &msgs[i], msgs[i].len, i);
+		if (report && report->bytes_cplt > 0 && msgs[n].flags & I2C_M_RD)
+			trace_i2c_reply(adap, &msgs[n], report->bytes_cplt, n);
 		trace_i2c_result(adap, num, ret);
 	}
 
 	return ret;
 }
+EXPORT_SYMBOL(__i2c_transfer_v2);
+
+/**
+ * __i2c_transfer - unlocked flavor of i2c_transfer
+ * @adap: Handle to I2C bus
+ * @msgs: One or more messages to execute before STOP is issued to
+ *	terminate the operation; each message begins with a START.
+ * @num: Number of messages to be executed.
+ *
+ * Returns negative errno, else the number of messages executed.
+ *
+ * Adapter lock must be held when calling this function. No debug logging
+ * takes place.
+ */
+int __i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
+{
+	return __i2c_transfer_v2(adap, msgs, num, NULL);
+}
 EXPORT_SYMBOL(__i2c_transfer);
 
 /**
- * i2c_transfer - execute a single or combined I2C message
+ * i2c_transfer_v2 - execute combined I2C message with detailed report
  * @adap: Handle to I2C bus
  * @msgs: One or more messages to execute before STOP is issued to
  *	terminate the operation; each message begins with a START.
  * @num: Number of messages to be executed.
+ * @report: The buffer for detailed transfer report (may be NULL).
  *
  * Returns negative errno, else the number of messages executed.
+ * Writes the detailed transfer report to the structure pointed by @report.
  *
- * Note that there is no requirement that each message be sent to
- * the same slave address, although that is the most common model.
  */
-int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
+int i2c_transfer_v2(struct i2c_adapter *adap, struct i2c_msg *msgs, int num,
+		    struct i2c_transfer_report *report)
 {
 	int ret;
 
-	/* REVISIT the fault reporting model here is weak:
-	 *
-	 *  - When we get an error after receiving N bytes from a slave,
-	 *    there is no way to report "N".
-	 *
-	 *  - When we get a NAK after transmitting N bytes to a slave,
-	 *    there is no way to report "N" ... or to let the master
-	 *    continue executing the rest of this combined message, if
-	 *    that's the appropriate response.
-	 *
-	 *  - When for example "num" is two and we successfully complete
-	 *    the first message but get an error part way through the
-	 *    second, it's unclear whether that should be reported as
-	 *    one (discarding status on the second message) or errno
-	 *    (discarding status on the first one).
-	 */
 	ret = __i2c_lock_bus_helper(adap);
 	if (ret)
 		return ret;
 
-	ret = __i2c_transfer(adap, msgs, num);
+	ret = __i2c_transfer_v2(adap, msgs, num, report);
 	i2c_unlock_bus(adap, I2C_LOCK_SEGMENT);
 
 	return ret;
 }
+EXPORT_SYMBOL(i2c_transfer_v2);
+
+/**
+ * i2c_transfer_v2 - execute a single or combined I2C message
+ * @adap: Handle to I2C bus
+ * @msgs: One or more messages to execute before STOP is issued to
+ *	terminate the operation; each message begins with a START.
+ * @num: Number of messages to be executed.
+ *
+ * Returns negative errno, else the number of messages executed.
+ *
+ * Note that there is no requirement that each message be sent to
+ * the same slave address, although that is the most common model.
+ */
+int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
+{
+	return i2c_transfer_v2(adap, msgs, num, NULL);
+}
 EXPORT_SYMBOL(i2c_transfer);
 
 int i2c_xfer_to_xfer_v2(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 6a4df8562ab4..ec5f5d6792a8 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -131,6 +131,14 @@ int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num);
 /* Unlocked flavor */
 int __i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num);
 
+/* Transfer with detailed transfer reporting.
+ */
+int i2c_transfer_v2(struct i2c_adapter *adap, struct i2c_msg *msgs, int num,
+		    struct i2c_transfer_report *report);
+/* Unlocked flavor */
+int __i2c_transfer_v2(struct i2c_adapter *adap, struct i2c_msg *msgs, int num,
+		      struct i2c_transfer_report *report);
+
 /* This is the very generalized SMBus access routine. You probably do not
    want to use this, though; one of the functions below may be much easier,
    and probably just as fast.

-- 
2.43.0

