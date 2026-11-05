Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=207.54.77.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793898996;
	b=B4wVnP9VqlWqV7/7BJIjTcriMABCFGZxbIPgp99LTymSPueDTAXYiqh6Tu9/HOAo19rb
	 Eh0cCZC+JIEt/sU9jz9K4w2RlZfswz6NCjT0Yr6XZ0U9xERcMTIOgL9CRZW9OhFa2FIgt
	 lGXEVF2L05ERwdl6kcUGVz4C4T1jR6D1gKqi4HFaRIjtBABcwO/81jQ0A/xnrwUD/zgGy
	 o+c2v/2RUYQWu4YdRdtmOXIYM7LbTmyjBA+Ozfdi4njPfAQl8tohXWhMwRat5V4u+6Ei6
	 4MoxKu/VXi/fP2d2ktBBrL8luzFCf4J9yiiCYMv6H9hqk7pvAsJFNSwP8dbxCtWQwlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793898996;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=aMCwmK7IAjaOgwDNgsQ6uSYvpqNKNWbffcoWB8epJZc=;
	b=qMFspIS/YL5/nGaTXxRH7IYKs7E0+gCEBKW7w1ldoMIw5Rhu4S6WPwoDUaK7kQqJdDXy
	 ZjsN4Dm/3NtDeMNGhxYQ3B3pon3v9520IJon/sswGJ3AI5cP+YvNkVj3hALNarUWVcFTp
	 tY+YchdCU4WKFtaO7bVr7yYr8DAGaTlOp5BTvzA05JDb4VaWCEVER9Hx42s9+of42siZi
	 jtPsCtsik7ikQcvydVJEzQmCWyuFkDbkeuQCrnIBOQbZBDmYw0dmPVyERrD6IdJgQhf50
	 OW4VW1Sr79RK9XErxEfQ62+qltNpJTiQCwA7CZKv2T9JiFEpvxos95EgD3LbT+t95pQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=207.54.77.50
Received: from esa3.hc555-34.eu.iphmx.com (esa3.hc555-34.eu.iphmx.com [207.54.77.50])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDDC606D81B;
	Thu,  5 Nov 2026 17:16:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3EDDC606D81B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1793899001; x=1825435001;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=psyr/lUeMakXQMnhGy1IvLcaYp+5UjtFhzPF6MAmIho=;
  b=COm/KiZDEpw/w+m2nbYUDkoorYOA4901Ew4zQdrc6RlUvwkKBls7d10J
   PGRKGf8hUDmXShGTDd/K44AH30gjWsYK6R16iZmwB/EFjc3c/GkEGczpB
   LBSCA2C/G6StewiBm0AvbbXAOociM1kUFkaJkLgv4DW835CegTZ1/KAKN
   rkZ10HQrUtto1q1zTGsNc5/UOR3uxBG1ovAAoIl1sR9N1sUQzc1mbG5xE
   1PnP8rwv7sV6jnfxkFT9AzwNmrtm0W0phGaBiX6PobHhmCFjX9FgiX/BI
   YNBrGaHry+Ko63HjgQmyN/VPvOg3mkZvcrssErbdQo+01ARFhgSbJEoHM
   A==;
X-CSE-ConnectionGUID: k6QzcMJsStKTIHBSOZ6+Nw==
X-CSE-MsgGUID: ahoDWHFbR7ORU7pPgtU9cA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces04_data.me-crop.lan) ([146.255.191.134])
  by esa3.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 19:16:40 +0200
X-CSE-ConnectionGUID: 4YFVb3OeR8aGzqWiMOi1DQ==
X-CSE-MsgGUID: d+iiAsL0TGqIfNLPZBxwjQ==
Received: from unknown (HELO epgd056.me-corp.lan) ([10.154.54.3])
  by ces04_data.me-crop.lan with SMTP; 05 Nov 2026 19:24:29 +0200
Received: by epgd056.me-corp.lan (sSMTP sendmail emulation); Thu, 05 Nov 2026 19:16:32 +0200
From: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Date: Thu, 05 Nov 2026 19:15:27 +0200
Subject: [PATCH RFC v3 06/14] i2c: core: make i2c_check_for_quirks() return
 pointer to the message
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
Message-Id: <20261105-i2c-fault-reporting-v3-6-515ad74ac4c9@mobileye.com>
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

i2c_check_for_quirks() checks if there are messages in msgs array that
cannot be transferred by the adapter. If there is such a message, it
returns -EOPNOTSUPP.

The error code in the return value is not needed because __i2c_transfer()
does not use it and explicitly returns -EOPNOTSUPP if
i2c_check_for_quirks() return value is not zero. So, instead of returning
the error code, return the pointer to the first message that cannot be
transferred by the controller, to provide the possibility to pass the
message index to the client.

This is preparation for implementation of detailed transfer reporting.

Signed-off-by: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
---
 drivers/i2c/i2c-core-base.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 3dd7ef02c562..23ff02a1e532 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -2223,15 +2223,17 @@ module_exit(i2c_exit);
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
@@ -2282,7 +2284,7 @@ static int i2c_check_for_quirks(struct i2c_adapter *adap, struct i2c_msg *msgs,
 		}
 	}
 
-	return 0;
+	return NULL;
 }
 
 /**

-- 
2.43.0

