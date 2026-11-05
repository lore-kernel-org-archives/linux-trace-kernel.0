Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.90.104.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793898999;
	b=oIYdLF164wjJR1K/+xgZ9eXukHrOtmD2z+qF667PTccvJArnMUDqf6pvvarj8hJhm1fI
	 OBa8vKq4X6nbPXf0SVkbMjHPJkUyOuV/Ump0cKZQ4VcmIl02LwgifiQAxEjjzgRlBXVCA
	 nkBWEr0fHhOdLHdjHSpGo6xqfIn5ijQIgnsGmobrl0NjYyY6Axm2XDSxInTbZxalwnQIf
	 TRUciDs7CoPuq+hgjQdZqVmp9hoy8cPnfOnRea8yqcC+Z1S6K+3ujqPe+oh80sZNXE67P
	 uct5V5ht2Zuf662mUzl4caSissGw72vuTfYPIWRMybQ2ktkZzr98qaUbWiToXmOrj3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793898999;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=UBdjNu6Hf5V0V9uMBNBVG0ug+WBnwMvQ4aA39umfh6M=;
	b=CnJK0mxNb4VSVSvczBMCDzKEyLqdLhFRCUDfXGbz7539Wkyrd04GTBvoy4x7VpUUJYLS
	 dOvkSzxmNUeUEGgqYo9JGqDtsgNJi6rEjYI+prcgRnGZfvn1x9p32iVa0x8YGFfS+ojX1
	 wvbS0dcNey8+s14REDYQcZPIjz8AhwYde9OK1usHFy6YhyJt22ppjEwmD8C/E2l+tLJjI
	 FOZ4jrGWxFJRcmVg++AkejbIvb/rCFjxMuzdArZTzPEMymV4HI6H+oTffima91RJiW0Rs
	 6JUSFzHn5T0dstVUVlpWziltQ5GlNH+9dVQp8iDHfAufHK/PzkbO+aQzAQHqLmtHpPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=23.90.104.144
Received: from esa1.hc555-34.eu.iphmx.com (esa1.hc555-34.eu.iphmx.com [23.90.104.144])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B50C606EE93;
	Thu,  5 Nov 2026 17:16:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B50C606EE93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1793898998; x=1825434998;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=XrcwCM187WI161c394wQbmjLIFf8yO5479299ymnpRc=;
  b=IRZMpq71tWQX0bkME4cpx0ltLRUS7Fb2dOYz19BCCtSePXT4z6nFROba
   F3vo4J7uOcTdAmHQwTl8GKUXpCtUp0rDbfg6CJiiav/3FXfujcQoY2wlj
   VUyT/ndifxewjZ2JBUPmL/ysD38QoKVth7Bqe7YQVKcHgLrXObSueFnvD
   7EGn1wIUIbk4VGVM77TgNH2Z+AtY4QzNX2m0BdDgJll7CN4oMSiPw4BGx
   lox3mU20yQHxopKZMt5POP6ZQOxN8xF8NIw6us6ABsRuLYIuWjWf0T9zg
   Kcg/+rCvrU4VOvY/Hr52kBUXVZgoNgDXal28YcnWA2ESasXT/U+oBYZY1
   w==;
X-CSE-ConnectionGUID: NYIjUvP0Q8q5IfoXBCRtyA==
X-CSE-MsgGUID: jFnUwluyTW+9BupEWJxT4w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces02_data.me-corp.lan) ([146.255.191.134])
  by esa1.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 19:16:29 +0200
X-CSE-ConnectionGUID: LRKzbrL+S7mAH4sHc4Vfeg==
X-CSE-MsgGUID: SpM9P5F7TjeQBtLpi6p6bg==
Received: from unknown (HELO epgd056.me-corp.lan) ([10.154.54.2])
  by ces02_data.me-corp.lan with SMTP; 05 Nov 2026 19:24:27 +0200
Received: by epgd056.me-corp.lan (sSMTP sendmail emulation); Thu, 05 Nov 2026 19:16:27 +0200
From: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Date: Thu, 05 Nov 2026 19:15:23 +0200
Subject: [PATCH RFC v3 02/14] i2c: core: add xfer_v2() to i2c_algorithm
 structure
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
Message-Id: <20261105-i2c-fault-reporting-v3-2-515ad74ac4c9@mobileye.com>
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

In struct i2c_algorithm, add xfer_v2() - a new method that is
similar to xfer() but accepts in addition pointer to struct
i2c_transfer_report and puts the detailed transfer report into it.

With this method, it case of a fault, it is possible to get not only
the error code, but also the number of messages and bytes transferred
before the fault. If there were read messages before the fault, the read
data may also be used by the client.

Signed-off-by: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
---
 include/linux/i2c.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 6a847fc88d25..bf7dc12f7264 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -537,6 +537,8 @@ i2c_register_board_info(int busnum, struct i2c_board_info const *info,
  *   into I2C transfers instead.
  * @smbus_xfer_atomic: Same as @smbus_xfer. Yet, only using atomic context
  *   so e.g. PMICs can be accessed very late before shutdown. Optional.
+ * @xfer_v2: Same as @xfer, but provides detailed report in case of a fault.
+ *   Optional. If it is present, @xfer must be also present.
  * @functionality: Return the flags that this algorithm/adapter pair supports
  *   from the ``I2C_FUNC_*`` flags.
  * @reg_target: Register given client to local target mode of this adapter
@@ -582,6 +584,8 @@ struct i2c_algorithm {
 				 unsigned short flags, char read_write,
 				 u8 command, int size, union i2c_smbus_data *data);
 
+	int (*xfer_v2)(struct i2c_adapter *adap, struct i2c_msg *msgs,
+		       int num, struct i2c_transfer_report *report);
 	/* To determine what the adapter supports */
 	u32 (*functionality)(struct i2c_adapter *adap);
 

-- 
2.43.0

