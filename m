Received: from esa2.hc555-34.eu.iphmx.com (esa2.hc555-34.eu.iphmx.com [23.90.104.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E7B385D89;
	Thu,  3 Sep 2026 05:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.90.104.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788413991; cv=none; b=ZGf7ITtrjHCxs7M4dnveULPSXJtUenf7XpXk3eMzp3RpJAglNpaA3uFtzC+z296B+DXNZN8HG+84bltCtqeWPfEe/g2DccfUydWeooduz5tlma56AaIVDe+UZ2m0Us3/2cJE4EkkAXzvReswbMLXGnINqvb/zlYpkC4fzjvxZBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788413991; c=relaxed/simple;
	bh=DGHMa0elmHe7zroIZqViDotdXzPUEOAZSse6uP5DSf8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fVDuvOzbPxsVe9SxKNNCSUEiQubvPTbq1Q8lD98ZkfKj+AV1IyC9Htpltsb0z37tia3mMXGS5mIE96YIkOnBMkhlxGCaIxrgEExSnEwCYRaRcsgA7lMvgORiYXKkr4PzQDf3bovgsdorzMhbPRyRST0ks5ZPzo2Jtol3JVAwRhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com; spf=pass smtp.mailfrom=mobileye.com; dkim=fail (0-bit key) header.d=mobileye.com header.i=@mobileye.com header.b=KKIqkFWZ reason="key not found in DNS"; arc=none smtp.client-ip=23.90.104.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mobileye.com header.i=@mobileye.com header.b="KKIqkFWZ"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1788413989; x=1819949989;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=DGHMa0elmHe7zroIZqViDotdXzPUEOAZSse6uP5DSf8=;
  b=KKIqkFWZxpWsniAdbL/PLxKFq6HRufpbIqyY+LdD3/vivNZcMDu/VgNW
   P/YlpHq+fBgB2FCAACjV60pwSTLf7dyvmGFDfSHqu50z7HbeevfEPC7DN
   nMpzxENPu6K9+HPzYiDsuTOicUqglWEHx+X7uNZNikyvkPErbsBiqNmqF
   a9NU6xUb7yywtDfWAMaFtFEjBA4xzqKC3SrPuwO4V0ZJHZ0fBFdPI79v/
   cZ0cy5PClitX58Bg8NWtocZSFbRMHefMmmbK4E0TCDY6VIi9R+q2SEMdW
   AeA/RAPf3yr+rruzpDj/8B257qYpeelqZfJVXPf5+mZc8y06dKlGJ+Xel
   A==;
X-CSE-ConnectionGUID: WLsDcoMiRqeta1S+3AaaXA==
X-CSE-MsgGUID: THyZ2zrBTXm+jax9w1bAAg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces03_data.me-corp.lan) ([146.255.191.134])
  by esa2.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 08:38:37 +0300
X-CSE-ConnectionGUID: 1R5tgvQmQ1eeiTDezhVfyQ==
X-CSE-MsgGUID: DRImNC4JT0mItxgK7dbeRw==
Received: from unknown (HELO epgd056.me-corp.lan) ([10.154.54.2])
  by ces03_data.me-corp.lan with SMTP; 03 Sep 2026 08:45:04 +0300
Received: by epgd056.me-corp.lan (sSMTP sendmail emulation); Thu, 03 Sep 2026 08:38:35 +0300
From: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Subject: [PATCH v2 00/12] I2C - detailed transfer reporting in case of a
 fault
Date: Thu, 03 Sep 2026 08:38:07 +0300
Message-Id: <20260903-i2c-fault-reporting-v2-0-fedeb91792e6@mobileye.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL8HmWoC/32NQQqDMBBFryKz7hQzQtCueo/iIsaJDqiRJJWKe
 PemHqDL9+C/f0DkIBzhURwQeJMofslAtwLsaJaBUfrMQCXpUlOFQhadeU8JA68+JFkGbKjStjH
 OWeohL9fATj5X9dVmHiUmH/brZFM/+7+3KSxR950ytTGdU/Vz9p1MvPPd+hna8zy/ranRl7kAA
 AA=
X-Change-ID: 20260623-i2c-fault-reporting-9236c9affc2d
To: Andi Shyti <andi.shyti@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Linus Walleij <linusw@kernel.org>, 
 Mika Westerberg <mika.westerberg@linux.intel.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
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

Patch for `i2c-tools` user space utility that introduces support of this
feature:

https://lore.kernel.org/linux-i2c/20260623-i2c_detailed_report-v1-1-b67259a31a9d@mobileye.com/

A usage example (the first message changes the target address, so the
second message is not ACKed):

    # i2ctransfer -r -y 0 w2@0x20 0 0x55 r1
    Error: No such device or address at message 1
    1 out of 2 messages sent
    #

In this patchset, the introduced functionality is implemented in
`i2c-nomadik` and `i2c-designware` drivers. Several other improvements in
these drivers related to fault handling are also included in this patchset.

`i2c-nomadik` driver has been tested on EyeQ6H.

`i2c-designware` driver has been tested on EyeQ6L+.

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
Patch #8 Fix error codes returned by `xfer` callback in
	  `i2c-designware`.
Patch #9 Reset SMBUS_READ_BLOCK_DATA bit in functionality mask for
	  `designware` variants without EMPTYFIFO_HOLD_MASTER feature.
Patch #10 Terminate transfer if spurious STOP is detected in
	  `i2c-designware` driver.
Patch #11 Separate `i2c_algorithm` structure for AMD_NAVI_GPU variant of
	  designware controller.
Patch #12 Add support for `xfer_v2` in `i2c-designware` driver.

Signed-off-by: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
---
Changes in v2:
- Add support for detailed transfer reporting in designware driver (patches
  #8..#12).
- Change `unsigned char` into `u8` in patch #2.
- Added code-review trailers for patches #3..#7.
- Rebase on new kernel version (no conflicting code changes).
- Link to v1: https://lore.kernel.org/r/20260623-i2c-fault-reporting-v1-0-6db1a8aabf18@mobileye.com

---
Dmitry Guzman (12):
      i2c: core: add I2C_XFER_V2 - support for detailed transfer reporting
      i2c: nomadik: optimize struct layout, change unsigned char into u8
      i2c: nomadik: do not try to retransmit I2C message series on errors
      i2c: nomadik: return proper fault codes
      i2c: nomadik: change print level for fault messages to debug
      i2c: nomadik: add quirks max_len=2047 and no_zero_len_read
      i2c: nomadik: add support for I2C_XFER_V2 - detailed fault reporting
      i2c: designware: return proper fault codes
      i2c: designware: no SMBUS_READ_BLOCK_DATA without EMPTYFIFO_HOLD_MASTER
      i2c: designware: stop transfer if spurious STOP is detected
      i2c: designware: use separate `i2c_algorithm` for AMD_NAVI_GPU
      i2c: designware: add support for I2C_XFER_V2 - detailed fault reporting

 Documentation/i2c/dev-interface.rst        |  46 +++++++++
 drivers/i2c/busses/i2c-designware-common.c |  23 ++++-
 drivers/i2c/busses/i2c-designware-core.h   |  14 ++-
 drivers/i2c/busses/i2c-designware-master.c | 160 ++++++++++++++++++++++++++---
 drivers/i2c/busses/i2c-nomadik.c           | 111 ++++++++++++++------
 drivers/i2c/i2c-core-base.c                | 107 +++++++++++++------
 drivers/i2c/i2c-dev.c                      |  79 +++++++++++---
 include/linux/i2c.h                        |  12 +++
 include/trace/events/i2c.h                 |   6 +-
 include/uapi/linux/i2c-dev.h               |   9 ++
 include/uapi/linux/i2c.h                   |  21 ++++
 11 files changed, 489 insertions(+), 99 deletions(-)
---
base-commit: 940de590b839f71d6dc846160534bf202401b8b7
change-id: 20260623-i2c-fault-reporting-9236c9affc2d

Best regards,
-- 
Dmitry Guzman <Dmitry.Guzman@mobileye.com>

