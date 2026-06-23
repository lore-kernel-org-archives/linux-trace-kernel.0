Received: from esa2.hc555-34.eu.iphmx.com (esa2.hc555-34.eu.iphmx.com [23.90.104.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B88330F548;
	Tue, 23 Jun 2026 16:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.90.104.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782232346; cv=none; b=plfzX0sQdL24Ixt/59ubnz5KeRy8ZFPeNmwJueVwTPuR9262+sb8NkVNX5AwLl0wLfRbNCA9kJzqmkMzTYkdrgM+nrxyJTGNiv8dV208DdRN6uYmXPwI3MfGpi7JCogohxocsBKVCOu2SrcJc1giAfPcpIdoBsOSsOShYgA9JlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782232346; c=relaxed/simple;
	bh=pMygV4wVZCEzFKn92Ljymdz/YFKu2YEw1uG0Z50x9b0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RVMJ+T2IcL+M0IFzFlYTiGgAhVZD53e2MEG/3CRy4t5Unk2uvcHtVS2mosLOh6/O1xEItml56ly1d8lxBqHRyIXy4fMexOb2yBLZySfx455CdnKvYyVvwz2bHxA0XESwaICzs6/yGdf5rC28neF5+AChLqaxfV+Jf/9kcL61vNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com; spf=pass smtp.mailfrom=mobileye.com; dkim=fail (0-bit key) header.d=mobileye.com header.i=@mobileye.com header.b=CY+7KzFw reason="key not found in DNS"; arc=none smtp.client-ip=23.90.104.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mobileye.com header.i=@mobileye.com header.b="CY+7KzFw"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1782232343; x=1813768343;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=pMygV4wVZCEzFKn92Ljymdz/YFKu2YEw1uG0Z50x9b0=;
  b=CY+7KzFwbh58HdrZYhhLd0yIQWWlwwaEA+ZJELT52if/WyaUIoPYXCRJ
   Pjifs0rZR7Q0kdYsFSxBdmizo30tBgqs4mLA6BSGepNaIwl1ID1kYLE8Y
   V+Z5Xkg1p8fHyf2nsApv1nzjii1d4xrxsUjvAqERukmViCZP2utWIqnpV
   6z1RW4pmmAvHrcijNQtydBv69klCPFc19j3kWqeyjndzmJzyGMWVzTfq+
   PK/J48daWhSsxhPeR+DG2DkgmOEc+qyDBUSzsACCbtyEv9eGh0uFmAQTx
   pKCZsKTjDADyTJcd+9gwEXvaa+ELF9SvnyqyWyVfzoBDvCbZOiiiQgYYI
   g==;
X-CSE-ConnectionGUID: 5B2kRBwMSeKX+fi1EpcMaA==
X-CSE-MsgGUID: FgOYtYtHT6CZe0IVL5B3wg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces01_data.me-corp.lan) ([146.255.191.134])
  by esa2.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 19:32:20 +0300
X-CSE-ConnectionGUID: dmkLI/qgQ8es5bHxuTEK7g==
X-CSE-MsgGUID: VTv/WnCQQa2qHRAgho2Htw==
Received: from unknown (HELO epgd056.me-corp.lan) ([10.154.54.3])
  by ces01_data.me-corp.lan with SMTP; 23 Jun 2026 19:37:30 +0300
Received: by epgd056.me-corp.lan (sSMTP sendmail emulation); Tue, 23 Jun 2026 19:32:19 +0300
From: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Date: Tue, 23 Jun 2026 19:31:48 +0300
Subject: [PATCH 1/7] i2c: add I2C_XFER_V2 - support for detailed transfer
 reporting
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260623-i2c-fault-reporting-v1-1-6db1a8aabf18@mobileye.com>
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

In I2C subsystem there is API that allows sending/receiving a number of
messages in a single call. I2C_RDWR ioctl, as well as i2c_transfer kernel
API function, returns only a single error code. In case of a fault,
there is no way to know which message in the series caused a fault, and
how many bytes have been sent or received before the fault.

This commit introduces i2c_transfer_v2 kernel API function and
I2C_RDWR_V2 ioctl. They provide the same functionality as the old ones,
but also accept additional pointer to `i2c_transfer_report` structure
and fill it with detailed fault report: number of messages transferred
successfully, index of message that caused fault, number of bytes
transferred (if a fault occurred in the middle of the last message).

I2C bus controller driver may implement either both callbacks or any one
of them. The implementation of both callbacks may make sense if the
precise detection of the fault position requires different handling with
the hardware that causes to extra CPU load or other consequences that
may be unwanted if the precise fault report is not required. If the
precise fault detection is free, the driver may implement only `xfer_v2`
callback - the infrastructure will provide pointer to a dummy fault
report that will be dropped if the client uses old API.

Signed-off-by: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
---
 Documentation/i2c/dev-interface.rst |  46 ++++++++++++++++
 drivers/i2c/i2c-core-base.c         | 107 +++++++++++++++++++++++++-----------
 drivers/i2c/i2c-dev.c               |  79 ++++++++++++++++++++++----
 include/linux/i2c.h                 |  12 ++++
 include/trace/events/i2c.h          |   6 +-
 include/uapi/linux/i2c-dev.h        |   9 +++
 include/uapi/linux/i2c.h            |  21 +++++++
 7 files changed, 232 insertions(+), 48 deletions(-)

diff --git a/Documentation/i2c/dev-interface.rst b/Documentation/i2c/dev-interface.rst
index c277a8e1202b51403a8d00d6c92fca13da1afc58..45a8b94f585b57889c153fbb110a5826879484f6 100644
--- a/Documentation/i2c/dev-interface.rst
+++ b/Documentation/i2c/dev-interface.rst
@@ -140,6 +140,52 @@ The following IOCTLs are defined:
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
+  The rdwr_data is the same structure as the argument for I2C_RDWR ioctl.
+  The report is the structure that the transfer report is written to::
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
+  fault_msg_idx is the number of message that caused a fault. In case of a
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
+  determine the byte number, the value should be -EOPNOTSUPP. If there was
+  no fault, the value should be 0.
+
+  To discover if the device supports detailed fault reporting, use I2C_RDWR_V2
+  ioctl with nmsgs = 0. If the driver supports it, the return value shall be 0.
+  If the driver supports only legacy I2C_RDWR, the return value shall be
+  -EOPNOTSUPP. In any case, nothing is done on the bus.
+
 ``ioctl(file, I2C_SMBUS, struct i2c_smbus_ioctl_data *args)``
   If possible, use the provided ``i2c_smbus_*`` methods described below instead
   of issuing direct ioctls.
diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 3ec04787a7373f113a15ee3fb35db425ae470427..c3694618b94fbdfd79a71d7cbd8d7c69c9638a17 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -2170,15 +2170,17 @@ module_exit(i2c_exit);
 /* Check if val is exceeding the quirk IFF quirk is non 0 */
 #define i2c_quirk_exceeded(val, quirk) ((quirk) && ((val) > (quirk)))
 
-static int i2c_quirk_error(struct i2c_adapter *adap, struct i2c_msg *msg, char *err_msg)
+static struct i2c_msg *i2c_quirk_error(struct i2c_adapter *adap,
+				       struct i2c_msg *msg, char *err_msg)
 {
 	dev_err_ratelimited(&adap->dev, "adapter quirk: %s (addr 0x%04x, size %u, %s)\n",
 			    err_msg, msg->addr, msg->len,
 			    str_read_write(msg->flags & I2C_M_RD));
-	return -EOPNOTSUPP;
+	return msg;
 }
 
-static int i2c_check_for_quirks(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
+static struct i2c_msg *i2c_check_for_quirks(struct i2c_adapter *adap,
+					    struct i2c_msg *msgs, int num)
 {
 	const struct i2c_adapter_quirks *q = adap->quirks;
 	int max_num = q->max_num_msgs, i;
@@ -2229,31 +2231,51 @@ static int i2c_check_for_quirks(struct i2c_adapter *adap, struct i2c_msg *msgs,
 		}
 	}
 
-	return 0;
+	return NULL;
 }
 
 /**
- * __i2c_transfer - unlocked flavor of i2c_transfer
+ * __i2c_transfer_v2 - unlocked flavor of i2c_transfer_v2
  * @adap: Handle to I2C bus
  * @msgs: One or more messages to execute before STOP is issued to
  *	terminate the operation; each message begins with a START.
  * @num: Number of messages to be executed.
+ * @report: The buffer for detailed transfer report (may be NULL if not required)
  *
  * Returns negative errno, else the number of messages executed.
+ * Writes the detailed transfer report to the structure pointed by 'report'.
  *
  * Adapter lock must be held when calling this function. No debug logging
  * takes place.
  */
-int __i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
+int __i2c_transfer_v2(struct i2c_adapter *adap, struct i2c_msg *msgs, int num,
+		   struct i2c_transfer_report *report)
 {
+	struct i2c_transfer_report dummy_report;
 	unsigned long orig_jiffies;
 	int ret, try;
 
-	if (!adap->algo->master_xfer) {
+	if (report) {
+		report->msgs_cplt = -EOPNOTSUPP;
+		report->bytes_cplt = -EOPNOTSUPP;
+		report->fault_msg_idx = -EOPNOTSUPP;
+
+		if (!adap->algo->xfer_v2)
+			return -EOPNOTSUPP;
+	}
+
+	if (!adap->algo->master_xfer && !adap->algo->xfer_v2) {
 		dev_dbg(&adap->dev, "I2C level transfers not supported\n");
 		return -EOPNOTSUPP;
 	}
 
+	/*
+	 * If the controller only supports "v2" callback and the report is not requested,
+	 * provide pointer to a dummy report.
+	 */
+	if (!(adap->algo->master_xfer) && (!report))
+		report = &dummy_report;
+
 	if (WARN_ON(!msgs || num < 1))
 		return -EINVAL;
 
@@ -2261,8 +2283,18 @@ int __i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 	if (ret)
 		return ret;
 
-	if (adap->quirks && i2c_check_for_quirks(adap, msgs, num))
-		return -EOPNOTSUPP;
+	if (adap->quirks) {
+		struct i2c_msg *bad_msg = i2c_check_for_quirks(adap, msgs, num);
+
+		if (bad_msg) {
+			if (report) {
+				report->msgs_cplt = 0;
+				report->bytes_cplt = 0;
+				report->fault_msg_idx = bad_msg - msgs;
+			}
+			return -EOPNOTSUPP;
+		}
+	}
 
 	/*
 	 * i2c_trace_msg_key gets enabled when tracepoint i2c_transfer gets
@@ -2283,8 +2315,12 @@ int __i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 	for (ret = 0, try = 0; try <= adap->retries; try++) {
 		if (i2c_in_atomic_xfer_mode() && adap->algo->master_xfer_atomic)
 			ret = adap->algo->master_xfer_atomic(adap, msgs, num);
-		else
-			ret = adap->algo->master_xfer(adap, msgs, num);
+		else {
+			if (report)
+				ret = adap->algo->xfer_v2(adap, msgs, num, report);
+			else
+				ret = adap->algo->master_xfer(adap, msgs, num);
+		}
 
 		if (ret != -EAGAIN)
 			break;
@@ -2293,58 +2329,63 @@ int __i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 	}
 
 	if (static_branch_unlikely(&i2c_trace_msg_key)) {
-		int i;
-		for (i = 0; i < ret; i++)
+		int n;
+
+		if (report)
+			n = report->msgs_cplt;
+		else
+			n = ret;
+		for (int i = 0; i < n; i++)
 			if (msgs[i].flags & I2C_M_RD)
-				trace_i2c_reply(adap, &msgs[i], i);
+				trace_i2c_reply(adap, &msgs[i], msgs[i].len, i);
+		if (report && report->bytes_cplt > 0 && msgs[n].flags & I2C_M_RD)
+			trace_i2c_reply(adap, &msgs[n], report->bytes_cplt, n);
 		trace_i2c_result(adap, num, ret);
 	}
 
 	return ret;
 }
+EXPORT_SYMBOL(__i2c_transfer_v2);
+
+int __i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
+{
+	return __i2c_transfer_v2(adap, msgs, num, NULL);
+}
 EXPORT_SYMBOL(__i2c_transfer);
 
 /**
- * i2c_transfer - execute a single or combined I2C message
+ * i2c_transfer_v2 - execute a single or combined I2C message
  * @adap: Handle to I2C bus
  * @msgs: One or more messages to execute before STOP is issued to
  *	terminate the operation; each message begins with a START.
  * @num: Number of messages to be executed.
+ * @report: Pointer for transmission fault report.
  *
  * Returns negative errno, else the number of messages executed.
  *
  * Note that there is no requirement that each message be sent to
  * the same slave address, although that is the most common model.
  */
-int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
+int i2c_transfer_v2(struct i2c_adapter *adap, struct i2c_msg *msgs, int num,
+		 struct i2c_transfer_report *report)
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
+int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
+{
+	return i2c_transfer_v2(adap, msgs, num, NULL);
+}
 EXPORT_SYMBOL(i2c_transfer);
 
 /**
diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index ccaac5e29f906bec0bf3b0e4a259391053469c2f..90456e6c04b4131dde9a9c2a5bd2075dd32b4baf 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -240,12 +240,18 @@ static int i2cdev_check_addr(struct i2c_adapter *adapter, unsigned int addr)
 	return result;
 }
 
-static noinline int i2cdev_ioctl_rdwr(struct i2c_client *client,
-		unsigned nmsgs, struct i2c_msg *msgs)
+static noinline int i2cdev_ioctl_rdwr_v2(struct i2c_client *client,
+				      unsigned int nmsgs, struct i2c_msg *msgs,
+				      struct i2c_transfer_report __user *user_report)
 {
+	struct i2c_transfer_report report;
 	u8 __user **data_ptrs;
 	int i, res;
 
+	report.msgs_cplt = -EOPNOTSUPP;
+	report.fault_msg_idx = -EOPNOTSUPP;
+	report.bytes_cplt = -EOPNOTSUPP;
+
 	/* Adapter must support I2C transfers */
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
 		return -EOPNOTSUPP;
@@ -259,6 +265,7 @@ static noinline int i2cdev_ioctl_rdwr(struct i2c_client *client,
 		/* Limit the size of the message to a sane amount */
 		if (msgs[i].len > 8192) {
 			res = -EINVAL;
+			report.fault_msg_idx = i;
 			break;
 		}
 
@@ -266,6 +273,7 @@ static noinline int i2cdev_ioctl_rdwr(struct i2c_client *client,
 		msgs[i].buf = memdup_user(data_ptrs[i], msgs[i].len);
 		if (IS_ERR(msgs[i].buf)) {
 			res = PTR_ERR(msgs[i].buf);
+			report.fault_msg_idx = i;
 			break;
 		}
 		/* memdup_user allocates with GFP_KERNEL, so DMA is ok */
@@ -289,6 +297,7 @@ static noinline int i2cdev_ioctl_rdwr(struct i2c_client *client,
 					     I2C_SMBUS_BLOCK_MAX) {
 				i++;
 				res = -EINVAL;
+				report.fault_msg_idx = i;
 				break;
 			}
 
@@ -303,9 +312,34 @@ static noinline int i2cdev_ioctl_rdwr(struct i2c_client *client,
 		return res;
 	}
 
-	res = i2c_transfer(client->adapter, msgs, nmsgs);
+	if (user_report) {
+		res = i2c_transfer_v2(client->adapter, msgs, nmsgs, &report);
+		i = report.msgs_cplt;
+	} else {
+		res = i2c_transfer(client->adapter, msgs, nmsgs);
+		if (res < 0)
+			i = 0;
+		else
+			i = nmsgs;
+	}
+
+	if (user_report && copy_to_user(user_report, &report, sizeof(report)))
+		res = -EFAULT;
+
+	/* Number of messages transferred completely or partially */
+	if (report.bytes_cplt > 0) {
+		i++;
+		msgs[i].len = report.bytes_cplt;
+	}
+
+	if (i > (int)nmsgs) {
+		pr_err("Bad i2c_transfer_report: msgs_cplt = %i, bytes_cplt = %i, nmsgs = %i\n",
+		       report.msgs_cplt, report.bytes_cplt, nmsgs);
+		i = nmsgs;
+	}
+
 	while (i-- > 0) {
-		if (res >= 0 && (msgs[i].flags & I2C_M_RD)) {
+		if (msgs[i].flags & I2C_M_RD) {
 			if (copy_to_user(data_ptrs[i], msgs[i].buf,
 					 msgs[i].len))
 				res = -EFAULT;
@@ -439,18 +473,39 @@ static long i2cdev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		funcs = i2c_get_functionality(client->adapter);
 		return put_user(funcs, (unsigned long __user *)arg);
 
-	case I2C_RDWR: {
+	case I2C_RDWR:
+	case I2C_RDWR_V2:
+	{
+		struct i2c_rdwr_ioctl_data __user *user_arg;
+		struct i2c_transfer_report __user *user_rep;
 		struct i2c_rdwr_ioctl_data rdwr_arg;
 		struct i2c_msg *rdwr_pa;
 		int res;
 
-		if (copy_from_user(&rdwr_arg,
-				   (struct i2c_rdwr_ioctl_data __user *)arg,
-				   sizeof(rdwr_arg)))
+		if (cmd == I2C_RDWR_V2) {
+			user_arg = &((struct i2c_rdwr_v2_ioctl_data __user *)arg)->rdwr_data;
+			user_rep = &((struct i2c_rdwr_v2_ioctl_data __user *)arg)->report;
+		} else {
+			user_arg = (struct i2c_rdwr_ioctl_data __user *)arg;
+			user_rep = NULL;
+		}
+
+		if (copy_from_user(&rdwr_arg, user_arg, sizeof(rdwr_arg)))
 			return -EFAULT;
 
-		if (!rdwr_arg.msgs || rdwr_arg.nmsgs == 0)
-			return -EINVAL;
+		if (!rdwr_arg.msgs || rdwr_arg.nmsgs == 0) {
+			/*
+			 * I2C_RDWR_V2 ioctl with nmsgs == 0 is used for
+			 * discovering of the controller capability to return
+			 * detailed fault reports.
+			 */
+			if (cmd == I2C_RDWR)
+				return -EINVAL;
+			if (client->adapter->algo->xfer_v2)
+				return 0;
+			else
+				return -EOPNOTSUPP;
+		}
 
 		/*
 		 * Put an arbitrary limit on the number of messages that can
@@ -464,7 +519,7 @@ static long i2cdev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		if (IS_ERR(rdwr_pa))
 			return PTR_ERR(rdwr_pa);
 
-		res = i2cdev_ioctl_rdwr(client, rdwr_arg.nmsgs, rdwr_pa);
+		res = i2cdev_ioctl_rdwr_v2(client, rdwr_arg.nmsgs, rdwr_pa, user_rep);
 		kfree(rdwr_pa);
 		return res;
 	}
@@ -572,7 +627,7 @@ static long compat_i2cdev_ioctl(struct file *file, unsigned int cmd, unsigned lo
 			};
 		}
 
-		res = i2cdev_ioctl_rdwr(client, rdwr_arg.nmsgs, rdwr_pa);
+		res = i2cdev_ioctl_rdwr_v2(client, rdwr_arg.nmsgs, rdwr_pa, NULL);
 		kfree(rdwr_pa);
 		return res;
 	}
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 20fd41b51d5c85ee1665395c07345faafd8e2fca..0305d4daa157c27d700f31c15faf0c3984114ce0 100644
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
@@ -567,6 +575,10 @@ struct i2c_algorithm {
 				 unsigned short flags, char read_write,
 				 u8 command, int size, union i2c_smbus_data *data);
 
+	/* Same as xfer with detailed reporting */
+	int (*xfer_v2)(struct i2c_adapter *adap, struct i2c_msg *msgs,
+		       int num, struct i2c_transfer_report *report);
+
 	/* To determine what the adapter supports */
 	u32 (*functionality)(struct i2c_adapter *adap);
 
diff --git a/include/trace/events/i2c.h b/include/trace/events/i2c.h
index 142a23c6593c611de9abc2a89a146b95550b23cd..2ea8e9805edf591d63dcb589340b0704fd6d38f7 100644
--- a/include/trace/events/i2c.h
+++ b/include/trace/events/i2c.h
@@ -88,8 +88,8 @@ TRACE_EVENT_FN(i2c_read,
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
@@ -102,7 +102,7 @@ TRACE_EVENT_FN(i2c_reply,
 		       __entry->msg_nr = num;
 		       __entry->addr = msg->addr;
 		       __entry->flags = msg->flags;
-		       __entry->len = msg->len;
+		       __entry->len = data_len;
 		       memcpy(__get_dynamic_array(buf), msg->buf, msg->len);
 			      ),
 	       TP_printk("i2c-%d #%u a=%03x f=%04x l=%u [%*phD]",
diff --git a/include/uapi/linux/i2c-dev.h b/include/uapi/linux/i2c-dev.h
index 1c4cec4ddd84d739193b234d33cae7860856738e..5097568a31490e2c9c2036a7d94ab47588413beb 100644
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
diff --git a/include/uapi/linux/i2c.h b/include/uapi/linux/i2c.h
index 2a226657d9f8238365453121321fd70dc11dac02..5e8e7d3536c85f2fe604a285258b070f2efffbb2 100644
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

