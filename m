Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD00358365
	for <linux-trace-kernel@vger.kernel.org>; Tue,  3 Mar 2026 06:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772518427; cv=none; b=VEX+uA7x1YlkGizKZZxVXlXP985I9UGY+oLjuuQ/TeqT5XfkZrpc4kZ9w4tj5hU4T5MX7F27juKG39EEVS7eKaz2Gsoi8KWOwrQ6CJUO0Q9B+CFCz2VoCUgYicEnJQGWMwdjmrHsYNf3d9Ty7G30fwRKapcdGZ+XBvPNTTQMGmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772518427; c=relaxed/simple;
	bh=wSdJCNEcRSpLA7NqxRp95eZD0EaV2U7w5ovgw1r/V+E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MTm7pc6M62966gRRhq1t2h71WHiSIojMCHGMh10d+Z/6iM8x9e89h47+HipKZlJKSwR2dD6PaWw8XEW9h6gJAOVLAZD+lJ7ygmXDsDH/IeL2/JG5NJ/AH1mDVERLWYfpUHrN/dTvSmaEPRyR0CBqgthm6QWok0agHHecV4TZNJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dihq27W7; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dihq27W7"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ae5636ab04so16335295ad.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 02 Mar 2026 22:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1772518425; x=1773123225; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VUnwHAHVUtkTlajQSql9yZcRD1MLD9k9rKTQHvdToZs=;
        b=dihq27W7M+QYvEUMNaZAnfn8oi/CBE2ERA9Yg6VszunmTsEiG/h2f4tqLUOFANK/Wl
         GVUlTR4wNwi3EBJx3Ixkv8Y2zyBuEvEBSOMDAKByWpvGAyXBVfoyNKWEyycOEgXDXQ5g
         TKp+A8cDbyes9OZ0rrHrD6fwRuIk30oPQ8qCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772518425; x=1773123225;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VUnwHAHVUtkTlajQSql9yZcRD1MLD9k9rKTQHvdToZs=;
        b=U9ggYEaMZPiTCPIqR32yoayV7UaLangMWc2jWdp/dY+WU7XRk3uSf2B8hqSoNlG0Cs
         kUWRzWBWQbAP4btmX3rgjQqOwH6IqiEdIUtHfxzzAuiso5TmQblvZH2CvtNTSG/CCWLA
         4Idnz2x3Cj2Wi6uXCo8yCPEQ1EpjKtBeZlLM85yxCjQxyU1sSWcxhHpGwNNAcXf7xScc
         r41QzmUU3rd9EmtNEVhqyT4FkBCwJRuxbspwaMvMlY1yqalZzPDAIVZuqXL4PaamXaEz
         ce4NreY3KSi4YPPy3/oNA4eiACkgSrxmXvFPICXVItzl5QshcerbChtCkemdTS302jy9
         NQ4w==
X-Forwarded-Encrypted: i=1; AJvYcCXMGZF3B0fPETQ89SXooHMNnHjMcoOxN/HGbhnJoh2VwDByaSedJubGrmoNpDhqufuw+11+JRchOXJSGhCp2yLny3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAOHT20Dl4F4zot1qG+cZ0g8gQKXO+rY/7LQ2fjZHx/Wvq1hM9
	ypZawA9AaBhuYf+2ezYuQC/XqdMzKXrWMuJQrPuvteAxCrPyH60onozDKVe3yjrnLA==
X-Gm-Gg: ATEYQzzETxDU+dz+WCsbdIiIA4qu3c09TYiC+nvX4Ls6dPBwRKTWcg0HoSBN88KDPBo
	CMctNKcACr6X+/HMF3pxLw5Gwn6UT/TgBb0vjxWPi271T+cGqFUVyl9oIJIOkmb6T6a6dNTubKE
	2nzzXw5vHLgobbs+OFsx1VoSTYBNtHyl2ShOYy18h0Ub6vxN9VVTSyRroxss/IgO47aLUI4QNTx
	JkWOrp1G4fRuzCpfoUEmNEW3m1bKIAyGnQ7676eU9Dm+oufblZt6i00wrMi6NLlHN69bvo41NMs
	r0WCUCN8KSojV5rg/0tb4bSqJO+DKRq3jKLI/mbTAsqyKz/RPMLDcrMu32b0VKWhBEe61K88sc3
	19z+ojyW6yIySGeH/VID6jyF43Tp740EPVn/GRHL/jPrQ7BxCtwudTzIUlbYfaEvaqo2DIotGst
	LvdgmE7g1bmmRPTaq6rD79TN7XA9iQbxEaRH+F3bj2y23iItXawS6ptXPg0I76m48b1R4XVgp7E
	Saw9NiKn0boUDlKSO9fMx5A3fSLQ8nYgw==
X-Received: by 2002:a17:902:f70f:b0:2ae:5a21:f7ee with SMTP id d9443c01a7336-2ae5a21fa6fmr37483595ad.0.1772518425479;
        Mon, 02 Mar 2026 22:13:45 -0800 (PST)
Received: from jingyliang-input-linux.c.googlers.com (111.169.168.34.bc.googleusercontent.com. [34.168.169.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6fe4f3sm152639735ad.91.2026.03.02.22.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 22:13:44 -0800 (PST)
From: Jingyuan Liang <jingyliang@chromium.org>
Subject: [PATCH 00/12] Add spi-hid transport driver
Date: Tue, 03 Mar 2026 06:12:52 +0000
Message-Id: <20260303-send-upstream-v1-0-1515ba218f3d@chromium.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOR7pmkC/x3MQQ5AMBBG4avIrDWpSZC6iliI/mUWSjqIRNxdY
 /kt3ntIkQRKXfFQwiUqW8yoyoKmZYwzjPhsYsuN5YqNInpz7nokjKtp69AE7+Adg3KzJwS5/18
 /vO8H6J83h18AAAA=
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
 hbarnor@chromium.org, Jingyuan Liang <jingyliang@chromium.org>, 
 Jarrett Schultz <jaschultz@microsoft.com>, 
 Dmitry Antipov <dmanti@microsoft.com>, Angela Czubak <acz@semihalf.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772518424; l=2786;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=wSdJCNEcRSpLA7NqxRp95eZD0EaV2U7w5ovgw1r/V+E=;
 b=ZiBezP9vXWQWUH4xJexyE2fSowbVOByYok8M/4ZB3IOWkh60Ktwg63v7/f43RkdINRwEM6e0Y
 twvbFrczErzD1aGZ5lqUJLsWtx9uFpEEmLogAK8K6CvDRUR2TuWLffa
X-Developer-Key: i=jingyliang@chromium.org; a=ed25519;
 pk=VTYSdqslTtYOjWWoIGgYoWupGWqNSidrggReKMgfPo4=

This series picks up the spi-hid driver work originally started by
Microsoft. The patch breakdown has been modified and the implementation has
been refactored to address upstream feedback and testing issues. We are
submitting this as a new series while keeping the original sign-off
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
Angela Czubak (2):
      HID: spi-hid: add transport driver skeleton for HID over SPI bus
      HID: spi_hid: add ACPI support for SPI over HID

Jarrett Schultz (3):
      Documentation: Correction in HID output_report callback description.
      HID: Add BUS_SPI support and define HID_SPI_DEVICE macro
      HID: spi_hid: add device tree support for SPI over HID

Jingyuan Liang (7):
      HID: spi-hid: add spi-hid driver HID layer
      HID: spi-hid: add HID SPI protocol implementation
      HID: spi_hid: add spi_hid traces
      dt-bindings: input: Document hid-over-spi DT schema
      HID: spi-hid: add power management implementation
      HID: spi-hid: add panel follower support
      HID: spi-hid: add quirkis to support mode switch for Ilitek touch

 .../devicetree/bindings/input/hid-over-spi.yaml    |  153 ++
 Documentation/hid/hid-transport.rst                |    4 +-
 drivers/hid/Kconfig                                |    2 +
 drivers/hid/Makefile                               |    2 +
 drivers/hid/hid-core.c                             |    3 +
 drivers/hid/spi-hid/Kconfig                        |   45 +
 drivers/hid/spi-hid/Makefile                       |   11 +
 drivers/hid/spi-hid/spi-hid-acpi.c                 |  254 ++++
 drivers/hid/spi-hid/spi-hid-core.c                 | 1493 ++++++++++++++++++++
 drivers/hid/spi-hid/spi-hid-core.h                 |   94 ++
 drivers/hid/spi-hid/spi-hid-of.c                   |  244 ++++
 drivers/hid/spi-hid/spi-hid.h                      |   51 +
 include/linux/hid.h                                |    2 +
 include/trace/events/spi_hid.h                     |  156 ++
 14 files changed, 2512 insertions(+), 2 deletions(-)
---
base-commit: 05f7e89ab9731565d8a62e3b5d1ec206485eeb0b
change-id: 20260212-send-upstream-75f6fd9ed92e

Best regards,
-- 
Jingyuan Liang <jingyliang@chromium.org>

