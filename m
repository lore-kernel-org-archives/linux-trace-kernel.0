Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB596364E9E
	for <linux-trace-kernel@vger.kernel.org>; Tue,  9 Jun 2026 04:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780980087; cv=none; b=CiGpSB84HDNT+4Qr6r38maje/mrI0ZK5u33QHzwVhZFLXg+f2Ps7a+LTt0QCPW8D0TpkScILnSaFVXvrTRh4z0eE/l4sNUcoWPM/6NjYqT2v1Qzx2W5wklmzG8LmZDaJPzBpL1RgcU5lfFs3tlLwtYCBq3m8BsI/gGMINPC6O2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780980087; c=relaxed/simple;
	bh=niVPKu3KCGXpaVcO6/gS8ySgoA3IT21ZaQzq7eQRAoI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=N7xquSF2B38PAoduxUJQd5/kTYqGAqrHDWOl/nIFZA9MT4MnMgGnfcry4VHrMA3w/XJZf5cRk2WpIVRtYh3ipOgiXAhs/SGTvDGWjdp39v5k5yD92I/2okQOaZawxb5hcCcz+A9pw7+ErByc1OC2D6M1qGPP6a07s5oEJ4Dv9hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bey43OSD; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bey43OSD"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2bf18c30bb2so35515155ad.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 08 Jun 2026 21:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1780980085; x=1781584885; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M58CbF2eNhyrWg008D0ABCR+x+AP5d/FSVenLDFjbso=;
        b=bey43OSDnW2g8//wfLnVS3L2InOBrSR+7XhB23f9w5SPJSS3FcNjfPEvIPaIDLkOkZ
         PWujDlQ1QxvqiqQsSG9naXhLuD7bXHH6XXzbq7EJQsT1ehQ68NjC7bVt1ZHuGdRXJL5h
         zacagIEJnUBeVDzYY//jx8/Sf91rQUFo8QB/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780980085; x=1781584885;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M58CbF2eNhyrWg008D0ABCR+x+AP5d/FSVenLDFjbso=;
        b=UeWcWlDV5YCA5yZWwM4BY3iadbnO/Msy2V7UGbyq+L/0B4rLgJ+3O7TPxavxNcrhMU
         mvr3+C+XgQjL2r1xQqiaOfcNzNiC2HVwhFh7CXmOs8dFnYy8LMdkFLvWDY7mPKmR7qPn
         /Kr+6rHamwkTS0QSX/tXPIi4Uuun4NwqcXujV/S6bCgmLxjLOL7U6Erhx7mBIbAhMi9J
         Lp4f0wySHJg/suFAafkMKPxxDu2kpEtr3PMmAQy+Q/7dPvpd/qUwDW6BYfrkF3gXyIzz
         9519w7cmdnNYTvMnm62C6qO6jRJMV9AKANseeWQbiKZR2cgCLesqBJBoN1k3Rwgj9rOC
         fzsA==
X-Forwarded-Encrypted: i=1; AFNElJ84PDFcvLpR9cktLdI2Z9wqmbXIA2XhbSy1oo8feIKsdSN0oS2D/4cEWSWkpDrnwbqlyjviiPT6wkXv9BTT9zT9Vrw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdhKu+ZjKVrArHVJCQMqDCfZqkj+Sj89UcHSBGF6gC4eP998Aa
	0fCrIXrAH6DZDKeeyDSMZwBuaepm0q9FlsEm8qn/Hl+jTHADIFSsPOiWJBymPpz0ww==
X-Gm-Gg: Acq92OGe985QafUxKfOD2fk41lc+91jwakaVgVviVtqWj1WqyCQWvqLG845971lri2Q
	NeD0bWYKFSOwnjt33n/No3nhY1LTscspMc9Rn2RbT3F/PdZVaAjPK232eh1r73m3dHphcSK1HVu
	4Ja6/o1bbiywte9KxyJUovvZlQnbV3tcqXaZPCvQbMxRy79Ar/BtmdY9aaIzInrfOLBkNJKz4PJ
	05hWR83mjCmEGSEI5lcOSz+pVa1prQ8ihN0OhcDcaRGBwXMSFDZoGS5OmRJLaI0/tAxsEoN23u+
	NeuotMMZONZp+w3mun2gH9JazSYWvfnKN8kkFkPX6wMqdYOhk7eo3DCO7mS+PmI12DH6OgBZUC+
	NRSH0PxHu5wgJgYJPxskIlSCuQmvo8ivtsyzEb7b+omRjGgn15typPkuVbG2szCRmYjQPPZJoZ4
	zlPu42o1wFuMi54UiufUtNwvmj1p/MEnjLNBh5n6cfmL4mTkK0iZ5VNj1F+JE1ugMqj/q0ffXcb
	21wCotn/dmivKYvStpboN7vWOdZxGWmcjy7WGC5wEKp
X-Received: by 2002:a17:903:19e8:b0:2c0:bb2d:a30b with SMTP id d9443c01a7336-2c1e893e978mr199020155ad.32.1780980085248;
        Mon, 08 Jun 2026 21:41:25 -0700 (PDT)
Received: from jingyliang-input-linux.c.googlers.com (111.169.168.34.bc.googleusercontent.com. [34.168.169.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c1664a67b0sm200736065ad.80.2026.06.08.21.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 21:41:24 -0700 (PDT)
From: Jingyuan Liang <jingyliang@chromium.org>
Subject: [PATCH v4 00/11] Add spi-hid transport driver
Date: Tue, 09 Jun 2026 04:40:51 +0000
Message-Id: <20260609-send-upstream-v4-0-b843d5e6ced3@chromium.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFOZJ2oC/23Pyw7CIBCF4VdpWIuBAXpx5XsYF7UMLYteAi3RN
 H13aV1oiMv/JPMlsxKPzqInl2wlDoP1dhxiyFNGmq4eWqRWxybAIGfAgXocNF0mPzuse1ookxt
 doa4ASbyZHBr7PLzbPXZn/Ty618EHvq8fSTCRSIFTRrni6lEDL43Q16ZzY2+X/jy6luxYgB8AZ
 ApABBTwBsvaGFPmfwDxBSRLfwkiAjmreCNVqYUqEmDbtjdCPS72LwEAAA==
X-Change-ID: 20260212-send-upstream-75f6fd9ed92e
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Mark Brown <broonie@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 hbarnor@chromium.org, tfiga@chromium.org, 
 Jingyuan Liang <jingyliang@chromium.org>, 
 Jarrett Schultz <jaschultz@microsoft.com>, 
 Dmitry Antipov <dmanti@microsoft.com>, Angela Czubak <acz@semihalf.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780980084; l=4487;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=niVPKu3KCGXpaVcO6/gS8ySgoA3IT21ZaQzq7eQRAoI=;
 b=gMiaV3ssfrSxB6Fkr0m/bcfIHp9ptbFeLfSnTk8bUHRLDQdur44JJWF8n6UENBPsDLHjwnDys
 a1vurmOpnbgC1mSlSC2pqiuwkJcE4MyhX8Df0zwQplhFF1Yawu1lVbU
X-Developer-Key: i=jingyliang@chromium.org; a=ed25519;
 pk=VTYSdqslTtYOjWWoIGgYoWupGWqNSidrggReKMgfPo4=

This series picks up the spi-hid driver work originally started by
Microsoft. The patch breakdown has been modified and the implementation
has been refactored to address upstream feedback and testing issues. We
are submitting this as a new series while keeping the original sign-off
chain to reflect the history.

Same as the original series, there is a change to HID documentation, some
HID core changes to support a SPI device, the SPI HID transport driver,
and HID over SPI Device Tree binding. We have added the HID over SPI ACPI
support, power management, panel follower, and quirks for Ilitek touch
controllers.

Original authors: Jarrett Schultz <jaschultz@microsoft.com>,
		  Dmitry Antipov <dmanti@microsoft.com>
Link: https://lore.kernel.org/r/86b63b7b-afda-d7f4-7bfa-175085d5a8ef@gmail.com

Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
---
Changes in v4:
- Extended io_lock scope to protect the shid->hid pointer lifecycle
  against races with the IRQ handler
- Cacheline-aligned DMA buffers, enforced 4-byte alignment
- Added error rollback for failed suspend/resume transitions
- Moved IRQ request to probe with IRQF_NO_AUTOEN (disabled by default)
- DT Bindings & OF Driver:
  - Required a device-specific compatible string in the schema.
  - Added description to explain why opcodes and addresses properties
    need to be defined in the schema
  - Added `spi-peripheral-props.yaml` reference and switched to
    `unevaluatedProperties: false`.
  - Added fallback to default timing parameters in OF driver if match
    data is missing.
- Link to v3: https://lore.kernel.org/r/20260402-send-upstream-v3-0-6091c458d357@chromium.org

Changes in v3:
- Add io_lock init
- Relocate tracepoints to drivers/hid/spi-hid/ and fix tracepoint macros
- Add tracepoints for sync, error handling, reset, and report processing
- Clean up internal includes and fix Makefile CFLAGS
- Add more details in v2 changelog
- Link to v2: https://lore.kernel.org/r/20260324-send-upstream-v2-0-521ce8afff86@chromium.org

Changes in v2:
- Clean up DT bindings: fix formatting and remove timing and flags properties
- Update DT binding example: use a device-specific compatible and drop
  reset_assert
- Simplify ACPI/OF match tables by removing ACPI_PTR/of_match_ptr
- Refactor OF driver to use match data for timing parameters instead
  of DT properties
- Switch to fsleep() for delays in ACPI and OF drivers
- Drop patch 12 as it is vendor specific
- Add a lock to fix input/output concurrency race
- Link to v1: https://lore.kernel.org/r/20260303-send-upstream-v1-0-1515ba218f3d@chromium.org

---
Angela Czubak (2):
      HID: spi-hid: add transport driver skeleton for HID over SPI bus
      HID: spi_hid: add ACPI support for SPI over HID

Jarrett Schultz (3):
      Documentation: Correction in HID output_report callback description.
      HID: Add BUS_SPI support and define HID_SPI_DEVICE macro
      HID: spi_hid: add device tree support for SPI over HID

Jingyuan Liang (6):
      HID: spi-hid: add spi-hid driver HID layer
      HID: spi-hid: add HID SPI protocol implementation
      HID: spi_hid: add spi_hid traces
      dt-bindings: input: Document hid-over-spi DT schema
      HID: spi-hid: add power management implementation
      HID: spi-hid: add panel follower support

 .../devicetree/bindings/input/hid-over-spi.yaml    |  128 ++
 Documentation/hid/hid-transport.rst                |    4 +-
 drivers/hid/Kconfig                                |    2 +
 drivers/hid/Makefile                               |    2 +
 drivers/hid/hid-core.c                             |    3 +
 drivers/hid/spi-hid/Kconfig                        |   45 +
 drivers/hid/spi-hid/Makefile                       |   12 +
 drivers/hid/spi-hid/spi-hid-acpi.c                 |  254 ++++
 drivers/hid/spi-hid/spi-hid-core.c                 | 1521 ++++++++++++++++++++
 drivers/hid/spi-hid/spi-hid-core.h                 |   98 ++
 drivers/hid/spi-hid/spi-hid-of.c                   |  247 ++++
 drivers/hid/spi-hid/spi-hid-trace.h                |  169 +++
 drivers/hid/spi-hid/spi-hid.h                      |   46 +
 include/linux/hid.h                                |    2 +
 14 files changed, 2531 insertions(+), 2 deletions(-)
---
base-commit: 05f7e89ab9731565d8a62e3b5d1ec206485eeb0b
change-id: 20260212-send-upstream-75f6fd9ed92e

Best regards,
-- 
Jingyuan Liang <jingyliang@chromium.org>

