Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.90.104.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793899003;
	b=qMb9KZ7MDkdZ90zl9LI0jNMTnHGMbrDoC/FnJwIa3F5tD+l6cX0H9ngjlm8xkbBdSyol
	 0NIxpwmE0FGOHIPgXZQ9nmwNajIzcjvE+grAOVpZfcs+BSzAcuHT0No6wwrwIMsFYAUYs
	 SKGAmKbLtPNW47vDQ9nawk4u+3uu9pFyI1q1Lq2FiTrFz+3LEOaqpn6r4B4hxy8QH/iwt
	 d4Z8tK8Z9T4VmKZg6T7oygO1jEnFTzvRsNfBudvWFeTLLrfW+c0lElKbJe7lopUOgJn8z
	 wHTiJzfHET6JcBTTG7PeYRKXdsvdEKyew7n8XbGnkv5XFTvvZPACpebhyZpIaXDU/lA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793899003;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=3tEx8KGrhtebJsZtllQQJuzn9Yar2KAyiVOpIFGqfZk=;
	b=ZM7BSahlZTrS5Sq99BOoQ7JSU/Datmwuko6NYH5z33TPhR7KlXjkq2HLRS9sNeu4NUF2
	 x/ct6rWCFANAJKkZusdzyYkvJCcHJdO8pnaBuzQuSadhg7Rll3QvgOIR/yW6EhXU7rwkv
	 1rxG4avvog9Rpgw3fjZ9JfXCzogs2lSLLClvZAj8xHdDikM5cYYWBhbfXIqdFpzQIuGXW
	 NkHWnsLLQH1SeH5OwcU7pq48lqkOe4pXnwgBFJ7bJrAAE+kKBfoOxihYa6hKIDykeK7tl
	 By4csjayAau0dAEUmQ8Aw0HheQJurDH01jITZ0Ab6FUHPWyMQ5wo/1QHUMvJ3U6F4YQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=23.90.104.144
Received: from esa1.hc555-34.eu.iphmx.com (esa1.hc555-34.eu.iphmx.com [23.90.104.144])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB0C6082BC8;
	Thu,  5 Nov 2026 17:16:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BB0C6082BC8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1793899002; x=1825435002;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=yJp8z0fUd0WqLNVGCeBa6CZScwSIESwkwvm1zwqw608=;
  b=apX1FojYDXFmaKuDivdBHyc0P6LTUlD1/fVQGnFT+ZZRLzYcSvZ/zkR5
   XDhG8VozRcOA5k2YwbxWnOe5tgvuRlhXFjzKqlJy7Fl4QruZ3sMS3x+yi
   aeLKfGdODp1mbt0N9OD7Q9oVpfoaGGkq534UEnwBW47VTYyDdc/f1odbL
   16NwNEpOzrmRh4oq9bx4pYEz2gAWKrb59rJw0f+kOEVwedQESaTe2yKoC
   8XH5Js+OIOECfqogMeMayMKFkRfZ4NRLyCd3vHUvwe9zRfKvjh5yfydWe
   hVN2rDtQAerDQpAPy5jjQD410NRQgsTmqA0kpqd04nJ28KDyAMz6n7QdA
   w==;
X-CSE-ConnectionGUID: NYIjUvP0Q8q5IfoXBCRtyA==
X-CSE-MsgGUID: s1p4bN15R0G3Mz0IRPmqNA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces02_data.me-corp.lan) ([146.255.191.134])
  by esa1.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 19:16:36 +0200
X-CSE-ConnectionGUID: 6jLmpjNcQq+h2cqnXk79nA==
X-CSE-MsgGUID: N/kq3xEZT/yWi+7MgDNLXw==
Received: from unknown (HELO epgd056.me-corp.lan) ([10.154.54.3])
  by ces02_data.me-corp.lan with SMTP; 05 Nov 2026 19:24:34 +0200
Received: by epgd056.me-corp.lan (sSMTP sendmail emulation); Thu, 05 Nov 2026 19:16:35 +0200
From: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Date: Thu, 05 Nov 2026 19:15:30 +0200
Subject: [PATCH RFC v3 09/14] i2c: core: implement I2C_RDWR_V2 ioctl -
 transfer with detailed report
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
Message-Id: <20261105-i2c-fault-reporting-v3-9-515ad74ac4c9@mobileye.com>
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
successfully transferred and which message caused the fault. If there is
any read data, it also may be used.

This feature is available on drivers that implement i2c_xfer_v2() method
in their i2c_algorithm.

Signed-off-by: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
---
 drivers/i2c/i2c-dev.c | 123 ++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 104 insertions(+), 19 deletions(-)

diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index d219eb89f978..14fe1dd7eecf 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -240,11 +240,19 @@ static int i2cdev_check_addr(struct i2c_adapter *adapter, unsigned int addr)
 	return result;
 }
 
-static noinline int i2cdev_ioctl_rdwr(struct i2c_client *client,
-		unsigned nmsgs, struct i2c_msg *msgs)
+static noinline int i2cdev_ioctl_rdwr_v2(struct i2c_client *client,
+					 unsigned int nmsgs, struct i2c_msg *msgs,
+					 struct i2c_transfer_report __user *user_report)
 {
+	struct i2c_transfer_report report;
 	u8 __user **data_ptrs;
-	int i, res;
+	int i, res, msgs_done;
+
+	i2c_transfer_report_init(&report);
+
+	if (user_report)
+		if (copy_to_user(user_report, &report, sizeof(report)))
+			return -EFAULT;
 
 	/* Adapter must support I2C transfers */
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
@@ -259,6 +267,7 @@ static noinline int i2cdev_ioctl_rdwr(struct i2c_client *client,
 		/* Limit the size of the message to a sane amount */
 		if (msgs[i].len > 8192) {
 			res = -EINVAL;
+			i2c_transfer_report_bad_msg(&report, i);
 			break;
 		}
 
@@ -266,6 +275,7 @@ static noinline int i2cdev_ioctl_rdwr(struct i2c_client *client,
 		msgs[i].buf = memdup_user(data_ptrs[i], msgs[i].len);
 		if (IS_ERR(msgs[i].buf)) {
 			res = PTR_ERR(msgs[i].buf);
+			i2c_transfer_report_bad_msg(&report, i);
 			break;
 		}
 		/* memdup_user allocates with GFP_KERNEL, so DMA is ok */
@@ -287,6 +297,7 @@ static noinline int i2cdev_ioctl_rdwr(struct i2c_client *client,
 			    msgs[i].len < 1 || msgs[i].buf[0] < 1 ||
 			    msgs[i].len < msgs[i].buf[0] +
 					     I2C_SMBUS_BLOCK_MAX) {
+				i2c_transfer_report_bad_msg(&report, i);
 				i++;
 				res = -EINVAL;
 				break;
@@ -300,12 +311,44 @@ static noinline int i2cdev_ioctl_rdwr(struct i2c_client *client,
 		for (j = 0; j < i; ++j)
 			kfree(msgs[j].buf);
 		kfree(data_ptrs);
+		if (user_report && copy_to_user(user_report, &report, sizeof(report)))
+			res = -EFAULT;
 		return res;
 	}
 
-	res = i2c_transfer(client->adapter, msgs, nmsgs);
+	if (user_report) {
+		res = i2c_transfer_v2(client->adapter, msgs, nmsgs, &report);
+		msgs_done = report.msgs_cplt;
+	} else {
+		res = i2c_transfer(client->adapter, msgs, nmsgs);
+		if (res < 0)
+			msgs_done = 0;
+		else
+			msgs_done = nmsgs;
+	}
+
+	if (user_report && copy_to_user(user_report, &report, sizeof(report)))
+		res = -EFAULT;
+
+	if (msgs_done > (int)nmsgs) {
+		//fixme - use dev_err?
+		pr_err("Bad i2c_transfer_report: msgs_cplt = %i, bytes_cplt = %i, nmsgs = %i\n",
+		       report.msgs_cplt, report.bytes_cplt, nmsgs);
+		msgs_done = nmsgs;
+	}
+
+	if (report.bytes_cplt > 0) {
+		if (msgs_done < nmsgs && msgs_done >= 0) {
+			msgs[msgs_done].len = report.bytes_cplt;
+			msgs_done++;
+		} else {
+			pr_err("Bad i2c_transfer_report: msgs_cplt = %i, bytes_cplt = %i, nmsgs = %i\n",
+				report.msgs_cplt, report.bytes_cplt, nmsgs);
+		}
+	}
+
 	while (i-- > 0) {
-		if (res >= 0 && (msgs[i].flags & I2C_M_RD)) {
+		if (msgs[i].flags & I2C_M_RD && i < msgs_done) {
 			if (copy_to_user(data_ptrs[i], msgs[i].buf,
 					 msgs[i].len))
 				res = -EFAULT;
@@ -439,18 +482,39 @@ static long i2cdev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
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
@@ -464,7 +528,7 @@ static long i2cdev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		if (IS_ERR(rdwr_pa))
 			return PTR_ERR(rdwr_pa);
 
-		res = i2cdev_ioctl_rdwr(client, rdwr_arg.nmsgs, rdwr_pa);
+		res = i2cdev_ioctl_rdwr_v2(client, rdwr_arg.nmsgs, rdwr_pa, user_rep);
 		kfree(rdwr_pa);
 		return res;
 	}
@@ -531,6 +595,11 @@ struct i2c_rdwr_ioctl_data32 {
 	u32 nmsgs;
 };
 
+struct i2c_rdwr_v2_ioctl_data32 {
+	struct i2c_rdwr_ioctl_data32 rdwr_data;
+	struct i2c_transfer_report report;
+};
+
 static long compat_i2cdev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct i2c_client *client = file->private_data;
@@ -539,19 +608,35 @@ static long compat_i2cdev_ioctl(struct file *file, unsigned int cmd, unsigned lo
 	case I2C_FUNCS:
 		funcs = i2c_get_functionality(client->adapter);
 		return put_user(funcs, (compat_ulong_t __user *)arg);
-	case I2C_RDWR: {
+	case I2C_RDWR:
+	case I2C_RDWR_V2:
+	{
+		struct i2c_rdwr_ioctl_data32 __user *user_arg;
+		struct i2c_transfer_report __user *user_rep;
 		struct i2c_rdwr_ioctl_data32 rdwr_arg;
 		struct i2c_msg32 __user *p;
 		struct i2c_msg *rdwr_pa;
 		int i, res;
 
-		if (copy_from_user(&rdwr_arg,
-				   (struct i2c_rdwr_ioctl_data32 __user *)arg,
-				   sizeof(rdwr_arg)))
+		if (cmd == I2C_RDWR_V2) {
+			user_arg = &((struct i2c_rdwr_v2_ioctl_data32 __user *)arg)->rdwr_data;
+			user_rep = &((struct i2c_rdwr_v2_ioctl_data32 __user *)arg)->report;
+		} else {
+			user_arg = (struct i2c_rdwr_ioctl_data32 __user *)arg;
+			user_rep = NULL;
+		}
+
+		if (copy_from_user(&rdwr_arg, user_arg, sizeof(rdwr_arg)))
 			return -EFAULT;
 
-		if (!rdwr_arg.msgs || rdwr_arg.nmsgs == 0)
-			return -EINVAL;
+		if (!rdwr_arg.msgs || rdwr_arg.nmsgs == 0) {
+			if (cmd == I2C_RDWR)
+				return -EINVAL;
+			if (client->adapter->algo->xfer_v2)
+				return 0;
+			else
+				return -EOPNOTSUPP;
+		}
 
 		if (rdwr_arg.nmsgs > I2C_RDWR_IOCTL_MAX_MSGS)
 			return -EINVAL;
@@ -575,7 +660,7 @@ static long compat_i2cdev_ioctl(struct file *file, unsigned int cmd, unsigned lo
 			};
 		}
 
-		res = i2cdev_ioctl_rdwr(client, rdwr_arg.nmsgs, rdwr_pa);
+		res = i2cdev_ioctl_rdwr_v2(client, rdwr_arg.nmsgs, rdwr_pa, user_rep);
 		kfree(rdwr_pa);
 		return res;
 	}

-- 
2.43.0

