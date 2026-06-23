Received: from esa1.hc555-34.eu.iphmx.com (esa1.hc555-34.eu.iphmx.com [23.90.104.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B67305670;
	Tue, 23 Jun 2026 16:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.90.104.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782232345; cv=none; b=tEPaUimmU/RTrvw1Jyt+OuaTsy+Do7zlg5/Rc8/jACExy4RJmJWFp8pwrCAETvh5LPNfDBnPPOYF7CqDkZddWw/OWS6P4pY6pBWv6g0ZO6Z/J07x5sHKfO1uJ9+xEZYde2ScYe3YyAE8w8RXtXindObtEVfaiXKwudRIjMqnYVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782232345; c=relaxed/simple;
	bh=7D9n4G2VjlN0quJaHg5EJso3RvCYIN2+BPYWUvKiBhE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Z+LMXqi76qUEUmN6AD9SRLSwqd+yzHxHW2Fi270x8pd1Eo6xzsT+IZPFIc4pnOV2nwEmEXlpIx3LMIZfxz3OcQXFei1HMq6UzjIY6feyRXcyDIS1yceGnzngSKuShLQJhkNyMJ+/ryistxpn+xw6Nw+FbfKV13kff7Tfz2WDtLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com; spf=pass smtp.mailfrom=mobileye.com; dkim=fail (0-bit key) header.d=mobileye.com header.i=@mobileye.com header.b=oqBOTtKi reason="key not found in DNS"; arc=none smtp.client-ip=23.90.104.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mobileye.com header.i=@mobileye.com header.b="oqBOTtKi"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1782232341; x=1813768341;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=7D9n4G2VjlN0quJaHg5EJso3RvCYIN2+BPYWUvKiBhE=;
  b=oqBOTtKipMmtVvTduS9RFdIH5SOXLhtpb8+yWBQtLqFdS5GoDmkDhwjY
   wtf+XkcnurQHZiCxVqo5GCJId4SN6JwhR7Q2jWySWlyK7NBUn/B4ml4N3
   8zkOd/2S9mnH9iEqUQja4VCL6AsnmgqHg2snyIxt2nQSxo0OyJ8i6i6fO
   rlmGo4X5PCNVRhu73JsLr4KOF/UK6bAFI2TcpTjEIxCjkXPeQhdumaifI
   iWY5xPzslZoDwoHY/jnAevqIVboi0HlpuxIewuyvVomQQITrtGRqFeb+n
   exn4pqs9PjRnOTRFFe+rWPPSq5vf5EMUwii2BgLFTFLvxIqBDZgZSjgWK
   Q==;
X-CSE-ConnectionGUID: Py2lPxYwTcqB46KaPgC8Mw==
X-CSE-MsgGUID: 9UE12DbnRwuc48tVCnm9yA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces04_data.me-crop.lan) ([146.255.191.134])
  by esa1.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 19:32:19 +0300
X-CSE-ConnectionGUID: QoDWkqHUTOuIdYE3NPUUvw==
X-CSE-MsgGUID: DSID08ozSY2lIAbbZOkm2Q==
Received: from unknown (HELO epgd056.me-corp.lan) ([10.154.54.2])
  by ces04_data.me-crop.lan with SMTP; 23 Jun 2026 19:37:27 +0300
Received: by epgd056.me-corp.lan (sSMTP sendmail emulation); Tue, 23 Jun 2026 19:32:18 +0300
From: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Subject: [PATCH 0/7] I2C - detailed transfer reporting in case of a fault
Date: Tue, 23 Jun 2026 19:31:47 +0300
Message-Id: <20260623-i2c-fault-reporting-v1-0-6db1a8aabf18@mobileye.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPS0OmoC/x3MMQqAMAxA0atIZgMaoVCvIg6lTWtAqqQqgnh3i
 +Mb/n+gsAoXGJsHlC8psuWKvm3ALy4nRgnVQB2ZztCAQh6jO9cDlfdND8kJLQ3GWxejpwC13JW
 j3P91mt/3A5KDRu9lAAAA
X-Change-ID: 20260623-i2c-fault-reporting-9236c9affc2d
To: Andi Shyti <andi.shyti@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Linus Walleij <linusw@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Dmitry Guzman <Dmitry.Guzman@mobileye.com>
X-Mailer: b4 0.14.2

The existing API has function `i2c_xfer` that transfers one or more
messages, and it only returns a single error code if the transfer was
failed. It doesn't allow to know how many of the messages were
transferred successfully, neither how many bytes were transferred in the
message that caused the fault, and also it drops all data received from
target device before the fault. There is a comment about this in
drivers/i2c/i2c-core-base.c: "REVISIT the fault reporting model here is
weak".

This patch series implements new API function `i2c_xfer_v2` that does
the same as `i2c_xfer` but also returns detailed transfer report, including
number of messages and bytes transferred before the fault. This also allows
client to get the bytes read from the target before the fault occurred.

For user space clients, new ioctl `I2C_RDWR_V2` is introduced.

In this patchset, the introduced functionality is implemented in
`i2c-nomadik` driver. Several other improvements in this driver related
to fault handling are also included in this patchset. It has been tested
on EyeQ6H-EPM6 board.

The implementation is split up into patches:

Patch #1 Introduce callback `xfer_v2` in struct `i2c_algorithm`,
	 function `i2c_xfer_v2`, ioctl `I2C_RDWR_V2`, structures for I2C
	 transfer reporting and implement all driver-independent functionality.
Patch #2 Optimize struct layout in `i2c-nomadik`.
Patch #3 Remove automatic retransfer in `i2c-nomadik`.
Patch #4 Fix error codes returned by `xfer` callback in `i2c-nomadik`.
Patch #5 Replace `dev_err` with `dev_dbg` on I2C faults in `i2c-nomadik`.
Patch #6 Add quirks that describe some limitations of `i2c-nomadik`.
Patch #7 Add support for `xfer_v2` in `i2c-nomadik`.

Signed-off-by: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
---
Dmitry Guzman (7):
      i2c: add I2C_XFER_V2 - support for detailed transfer reporting
      i2c: nomadik: optimize layout of struct nmk_i2c_dev
      i2c: nomadik: do not try to retransmit I2C message series on errors
      i2c: nomadik: return proper fault codes
      i2c: nomadik: change print level for fault messages to debug
      i2c: nomadik: add quirks max_len=2047 and no_zero_len_read
      i2c: nomadik: add support for I2C_XFER_V2 - detailed fault reporting

 Documentation/i2c/dev-interface.rst |  46 ++++++++++++++++
 drivers/i2c/busses/i2c-nomadik.c    | 105 ++++++++++++++++++++++++-----------
 drivers/i2c/i2c-core-base.c         | 107 +++++++++++++++++++++++++-----------
 drivers/i2c/i2c-dev.c               |  79 ++++++++++++++++++++++----
 include/linux/i2c.h                 |  12 ++++
 include/trace/events/i2c.h          |   6 +-
 include/uapi/linux/i2c-dev.h        |   9 +++
 include/uapi/linux/i2c.h            |  21 +++++++
 8 files changed, 306 insertions(+), 79 deletions(-)
---
base-commit: 502d801f0ab03e4f32f9a33d203154ce84887921
change-id: 20260623-i2c-fault-reporting-9236c9affc2d

Best regards,
-- 
Dmitry Guzman <Dmitry.Guzman@mobileye.com>

