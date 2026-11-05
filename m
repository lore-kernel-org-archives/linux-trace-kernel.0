Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=207.54.77.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793898991;
	b=RSCledax/03mNheUnv+jIuRWKUXK8bNWuglTFGsH+AHu5ve810z/rjrQwXXY07a1KrTh
	 H/2AyALdBKKnyCMTvK61s2JJ8qmWxvCou0xcvhtDOvlPffbHd60U5iMk+0RVqQ6yhpzxP
	 dkSagXHA/fMo5uGoGAwfFuRLhmpvH9ofGVdzu/aVpNELMj9QObmj/w/9oQ1bYEPS7KU4F
	 OnWfQggKSscunWd2lXA9weHH1uUBxrNcek1pjxbgzzZuxCpb5mrIGWd0Lu01TrtCpikeP
	 0O8AjIX8PjyA4klkdGYBRcNw3QHhjjCykJHJTnfP+f3OWCjytTwFsV3zJhqS62/xf+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793898991;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer;
	bh=xayX75I52P3hRuYvCfvPPPMAOpXw/kT1HD9NDFDjrso=;
	b=o+Q8++yN34+UwxSi/cDSvjthtEp5llaU9784VYMXmPlk7qzMNJipdljVO68dpOB3xkcz
	 qiyf9FuA6j7ZIBDc/DPYAy0mAKYCq6Mp+yE6tQjo69r/aDISZ7vf6DV9F2BfMKNRVnwwJ
	 IjANZnS1PR8K5wl2mMfJCE3xpwwDTekuv/SzopjHQNVYttGjtzFwl4t8fOvf35yNLQh1g
	 oUqltRKO8kLWKPh5jx3qPsNYKcqcF3MfMiuzoe0EWNrNVMwJ4hy4foo5yF36CCHQ+glLc
	 nryAb5pZxyt0OQWToUOFwTy4W0CB/neEBNdPexAYiw76f2Z9rgbn6s7hmtIYz4+m5Tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=207.54.77.50
Received: from esa3.hc555-34.eu.iphmx.com (esa3.hc555-34.eu.iphmx.com [207.54.77.50])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C534606A326;
	Thu,  5 Nov 2026 17:16:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C534606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1793898996; x=1825434996;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=MnddUx3A80LCOylxU/7lieiEYsWOlyajJmXCy+kln/k=;
  b=WzHfaXKJfQazfsthjx0JvhMdFgxzHoN8o81ZVG2vcltgvsa63W3MxUsh
   t05iMv5oETE8hA3pXo5Wv8VYir5q58tR21Hw79vO7yEANw/eMK26py1EI
   za/uZY9vqN6yshGTbvhks+mL5acDrsNkh878prNeOZnnqEVinj8OjcEnH
   5VGcQojYgjofV2+DGK6JbSL58caUYQViqD6IrF37JRsumHEZVC8QsNlcC
   l0zSPMQpOzt0uFplJtvSkUqr1VLls4cCEzIFFNwT1YDJmQ+H9ZQzxC49Q
   kPJE+54xPckzlKl31LkdtCXmLJ0BIJC5vzcKo/zrcjhfOal/aFqGkd7+U
   g==;
X-CSE-ConnectionGUID: 6NbJ9AgXTEGCV+Sk4npTag==
X-CSE-MsgGUID: XsuiQxebTqq/UtI8eB+qNw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces03_data.me-corp.lan) ([146.255.191.134])
  by esa3.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 19:16:34 +0200
X-CSE-ConnectionGUID: 7IARYAO7TBaiiB+dZtx5IA==
X-CSE-MsgGUID: JtbxGdyFTiWGvf+QXLvAVg==
Received: from unknown (HELO epgd056.me-corp.lan) ([10.154.54.2])
  by ces03_data.me-corp.lan with SMTP; 05 Nov 2026 19:24:15 +0200
Received: by epgd056.me-corp.lan (sSMTP sendmail emulation); Thu, 05 Nov 2026 19:16:25 +0200
From: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Subject: [PATCH RFC v3 00/14] I2C - detailed transfer reporting in case of
 a fault
Date: Thu, 05 Nov 2026 19:15:21 +0200
Message-Id: <20261105-i2c-fault-reporting-v3-0-515ad74ac4c9@mobileye.com>
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
X-B4-Tracking: v=1; b=H4sIAKm57GoC/32Qy07DMBBFfyXyGiN7nDh2VkhIfABbxMKPcWrRx
 MVJA1XVf8eECFAlWI5H98w9PpMJc8SJdNWZZFziFNNYBnFTEbczY480+jITYCCZBEEjOBrMcT/
 TjIeU5zj2VIOQTpsQHHhSkoeMIb6v1Cfy+HBPnsvjLk5zyqf10sLX1b/QhVNGpbfcKGNs4OpuS
 Dbu8YS3Lg0rcoEfjGZ/YKBgAnq0mrcaUF5hLl99M74ei/y8lf5276pPOmfQrHSPU+zHN5ORroZ
 UNL7V3jIlle6K1u9/u8qOaTA+vmzBVnDgzkleM7UFrZmQllJDnLtKSlDY+tpJC41TnqvARd2gM
 MA8cAXaGGyxLgaXD27B2OHGAQAA
X-Change-ID: 20260623-i2c-fault-reporting-9236c9affc2d
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

The existing API has function i2c_transfer() that transfers one or more
messages, and it only returns a single error code if the transfer was
failed. It doesn't allow to know how many of the messages were
transferred successfully, neither how many bytes were transferred in the
message that caused the fault, and also it drops all data received from
target device before the fault. There is a comment about this in
drivers/i2c/i2c-core-base.c: "REVISIT the fault reporting model here is
weak".

This patch series introduces new API function i2c_transfer_v2() that does
the same as i2c_transfer() but also returns detailed transfer report,
including number of messages and bytes transferred before the fault. This
also allows caller to get the bytes read from the target before the fault
occurred.

For user space clients, new ioctl `I2C_RDWR_V2` is introduced.

Patch for `i2c-tools` user space utility that introduces support of this
feature:

https://lore.kernel.org/linux-i2c/20260623-i2c_detailed_report-v1-1-b67259a31a9d@mobileye.com/

Below there are several usage examples with modified i2c-tools.

- Unsupported message (max length supported by I2C controller is 2047):

    # i2ctransfer -y 0 -r w1@0x19 0 r8000
    Error: Operation not supported at message 1
    0 out of 2 messages sent
    #

- First two messages transferred successfully, the third one is sent to
  non-existent target address and thus is not ACKed. The data read in the
second message is available for the caller:

    # i2ctransfer -y 0 -r w1@0x19 0 r1 w1@0x1a 0
    Error: No such device or address at message 2
    2 out of 3 messages sent
    0x32
    #

- Target ACKs first two bytes but sends NACK on the third byte:

    # i2ctransfer -r -y 0 w4@0x09 0x80 0x80 0x55 0x55
    Error: Input/output error at message 0
    0 out of 1 messages sent
    Message 0: 2 out of 4 bytes sent
    #

- Message reading is not finished due to timeout. The data read before
  timeout is available:

    # i2ctransfer -y 0 -r r100@0x19
    Error: Connection timed out at message 0
    0 out of 1 messages sent
    Message 0: 16 out of 100 bytes sent
    0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
    #

- Driver does not support detailed fault reporting:

    # i2ctransfer -y 0 -r r1@0x19
    Error: Sending messages failed: Operation not supported
    #

In this patchset, the introduced functionality is implemented in
i2c-core and in two bus drivers: i2c-nomadik and i2c-designware.

Patches #11..#14 that implement the new feature in the bus drivers depend
on two other patch sets:

https://lore.kernel.org/linux-i2c/20261103-i2c-designware-fixes-v1-1-f83dd71f988c@mobileye.com

https://lore.kernel.org/linux-i2c/20261103-i2c-nomadik-fixes-v1-0-655c6af2cb70@mobileye.com

that contain other improvements of these two drivers. I submit them
separately from this patchset because they can be applied independently
of remaining patches in the set and because v3 of this patch set becomes
too long with them.

i2c-nomadik driver has been tested on EyeQ6H.

i2c-designware driver has been tested on EyeQ6L+.

The implementation is split up into patches:

Patch #1 Add definition for I2C transfer report structure.
Patch #2 Add xfer_v2() method to i2c_algorithm structure.
Patch #3 Add helper functions for transfer report generation.
Patch #4 Add i2c_xfer_to_xfer_v2() helper function for drivers that do
	not have specific implementation for xfer() method but have
	xfer_v2().
Patch #5 Pass message length separately from i2c_msg structure in
	trace_i2c_reply().
Patch #6 Make i2c_check_for_quirks() return the pointer to the message
	that cannot be sent.
Patch #7 Implement i2c_transfer_v2() in I2C core.
Patch #8 Add definitions for I2C_XFER_V2 ioctl for using the new feature
	from user space.
Patch #9 Implement I2C_XFER_V2 ioctl in I2C core.
Patch #10 Add documentation for the new feature.
Patch #11 Save I2C_SR register value before resetting hardware in
	interrupt handler in i2c-nomadik.
Patch #12 Add support for xfer_v2() in i2c-nomadik.
Patch #13 Separate i2c_algorithm structure for AMD_NAVI_GPU variant of
	  designware controller.
Patch #14 Add support for xfer_v2() in i2c-designware driver.

Signed-off-by: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
---
Changes in v3:
- Split a single big patch #1 with all i2c-core changes into smaller
  patches (#1..#10).
- Separate fixes of pre-existing issues in i2c-nomadik and
  i2c-designware drivers into their own patch sets.
- Fix issues found in v2 by AI review bot.
- Improve comments, fix typos.
- Added more usage examples in the cover letter.
- Link to v2: https://lore.kernel.org/r/20260903-i2c-fault-reporting-v2-0-fedeb91792e6@mobileye.com

Changes in v2:
- Add support for detailed transfer reporting in designware driver (patches
  #8..#12).
- Change `unsigned char` into `u8` in patch #2.
- Added code-review trailers for patches #3..#7.
- Rebase on new kernel version (no conflicting code changes).
- Link to v1: https://lore.kernel.org/r/20260623-i2c-fault-reporting-v1-0-6db1a8aabf18@mobileye.com

To: Andi Shyti <andi.shyti@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Linus Walleij <linusw@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

---
Dmitry Guzman (14):
      i2c: uapi: add i2c_transfer_report structure
      i2c: core: add xfer_v2() to i2c_algorithm structure
      i2c: core: add helper functions for transfer report generation
      i2c: core: add i2c_xfer_to_xfer_v2() helper function
      i2c: trace: pass message length separately in trace_i2c_reply()
      i2c: core: make i2c_check_for_quirks() return pointer to the message
      i2c: core: implement i2c_transfer_v2() - transfer with detailed reporting
      i2c: uapi: add I2C_XFER_V2 ioctl - detailed fault reporting
      i2c: core: implement I2C_RDWR_V2 ioctl - transfer with detailed report
      i2c: doc: add section for I2C_RDWR_V2 ioctl
      i2c: nomadik: save I2C_CR register before resetting HW in IRQ handler
      i2c: nomadik: add support for I2C_XFER_V2 - detailed fault reporting
      i2c: designware: use separate `i2c_algorithm` for AMD_NAVI_GPU
      i2c: designware: add support for I2C_XFER_V2 - detailed fault reporting

 Documentation/i2c/dev-interface.rst        |  48 ++++++++++
 drivers/i2c/busses/i2c-designware-common.c |  15 ++-
 drivers/i2c/busses/i2c-designware-core.h   |  13 +++
 drivers/i2c/busses/i2c-designware-master.c | 145 +++++++++++++++++++++++++++--
 drivers/i2c/busses/i2c-nomadik.c           |  67 ++++++++++---
 drivers/i2c/i2c-core-base.c                | 135 ++++++++++++++++++++-------
 drivers/i2c/i2c-dev.c                      | 123 ++++++++++++++++++++----
 include/linux/i2c.h                        |  35 +++++++
 include/trace/events/i2c.h                 |  10 +-
 include/uapi/linux/i2c-dev.h               |   9 ++
 include/uapi/linux/i2c.h                   |  21 +++++
 11 files changed, 538 insertions(+), 83 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20260623-i2c-fault-reporting-9236c9affc2d
prerequisite-change-id: 20261025-i2c-designware-fixes-35d79db08689:v1
prerequisite-patch-id: dfc2af82eb4d654796ee4222fd86651c624b3305
prerequisite-change-id: 20261025-i2c-nomadik-fixes-73121cc61408:v1
prerequisite-patch-id: 04275f1ef88d65148fc56f1392942dbf3d523cf9
prerequisite-patch-id: 40eac74ab9e214ef658e5061368df45b719247f0
prerequisite-patch-id: 450e16ffa1879c1903048486aefa5a35c1e71f3c
prerequisite-patch-id: 1ea98272288b495cf185d7760b68d78982448f0f
prerequisite-patch-id: 8fd5cc8ebc4572189389c645f5fd939429118324
prerequisite-patch-id: fe840395009e945fc2442d4d7d3d07a426d48d54
prerequisite-patch-id: 0f6884cf9b38bd015cd7a23ba85cc0e239c3a49c
prerequisite-patch-id: 5f5ffed672373fc7f141bca2a9b605a31b6148ef

Best regards,
--  
Dmitry Guzman <Dmitry.Guzman@mobileye.com>

