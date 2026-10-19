Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792436500;
	b=HXEek9u1pPtAOYU62+hra+pR2ydz683BKUu50oIXe2SaaegetMqRApcH9AtfRFSz0RVu
	 n+sZjhowR2aYUQPMrLKTUCVLlLaWzFzC4xCfumRpdKs+Jb/JuB7efmBZNJRCwuBpEikAk
	 eqxG6EKQLXYcdyA3Now6d7yBBSIDkuqbHWhpZjlEMzI0f3Rs58Xwjsf5+r1YUhhPlxFhK
	 gRxgpjYD5KGnISx1ppjQGxqbmnLBHHYDIefO1u3+v0Dxy3jISID+RV9MqKvqwZHGsDGJo
	 8KqvmntruGUlIs1YO25bxRAK3E3643NZoa5sChDifGMrfoF7qYMimfx8ProBxOY6Eqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792436500;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=knSMb1LCCCwS1RlP3a3YG2pI2EdQ26l7Uk9lyEfeZEg=;
	b=efifeP7iLbB/y/hQZfwo6PJnA9OI34SjfRWvW9uJKryPgeXYHINSu8tHTsEvivuEJZ9J
	 DxIPtuohC7Tcv+zMKPU08/TEGAjTkWNp2+wHJSYFqjJLQpcV9F3EEhSRudTG2n8QnacaF
	 Kl+TRS/QM4aL84g94tke916paqNqBsmxj95Y75xjQYAYriES7tCOCi781Ll5trX4HXfiL
	 m2YPhgupN25JVCv4cUOMIeJ7vBl3JesplMWUCoS7iYQhCrS8Ho4mOXKgJpwYpHPDhWNna
	 s7g395JgFN0sNiEClkGVs7TsdOi8RugyYhavbhgQAoZpS8tkIFW7gSlTz+NIlIEu6Yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=XrXni+e1;
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBD760A3815
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Oct 2026 19:01:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FBD760A3815
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=XrXni+e1
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e901e114fdso11785815ad.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Oct 2026 12:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792436499; x=1793041299; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=knSMb1LCCCwS1RlP3a3YG2pI2EdQ26l7Uk9lyEfeZEg=;
        b=XrXni+e1B+yPH+38EamS+iWh4IPeE2CaTM724gbwiQHa/ykB2LnSn4QhFwR7xb/OaR
         bE1vH7rLp2lkGqYarVtOriL+SEUk7NWf122HhY+86F2c1mU0dL44QB+kOeIV3+0luL7m
         F1eTq07yIboL0xadaHqRARhoGmNHeKlVVJOLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792436499; x=1793041299;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=knSMb1LCCCwS1RlP3a3YG2pI2EdQ26l7Uk9lyEfeZEg=;
        b=ec3myQkG5tOKL4701Sis2Ia5tHUbwa091+2lNH1L9reBEetSUqp3y+YUX0V9DyxKX+
         fxy+b5gF6mHXyL5+1kXQ009UAOSm+eZ9HYGmIMHUysJH+5dbWLT7ZO1jfvPbxHdj9Sgu
         Abv+QxpJivb92mX/hYb33FNoLuBlI0cwO8fUm7JqvEgZN0Fa9KC5yxFRMqSbQRgZ7Uu5
         Fh6QjvkUto2dt/IpYRETK8QL8liwoH5F1ostLrjpW5pbyEuyr9XpEVdl4GJN5/k/EcyT
         SrBcOQso30Di7ZvgIxb8bJ76KXOvrG6dvamgHpz1F14ygBy8yXHIhSTe9dyfd8Ux2KT1
         9c+g==
X-Forwarded-Encrypted: i=1; AKwUvBzUwCQWMt9fBZYpgvHSVUh2q47eOu4f3txGb4WbvvACF9ztHoQGHlLYaJbxvsdpltw3ZVCJx8QT9CqGgrZoEBCbdSE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKpvakIgLnoNFcg52OmcxuFCSvgU7s17fRJLaHihnIP2GslY3NP
	1675ulh6DEntLqlnY5g6/7LZbt3QS0iyyR7ozkb9tvuekeVrZ4KKTVaRpUVzoHNyeQ==
X-Gm-Gg: AYBFou3e9WD57YuSrEF/YG/AVx+aifd3eYlMSLo5TduNTj5e2A970U0+F4iDFffqkLR
	AG6aYaVnOcPxH777QrHru4aJpuwCViIiACIc7u93Hzk0cLUNx3NRg8OLUdXSgx1b/93GDu9bWbq
	6d1P6bcrMrg+k3gQu3vuSMzNLl7Mh2TRIZ3ySOgJmfNb4+rt5BNXwgqdWU1zT/iJE5hs5Ugjz2d
	hXTaNoiKl241II057wQEc6/vtbwA35dOFYJ2YcH4dkeWMZ1vQTO0tAmhrge93PHsE9oyZs3ODIj
	QJq73rS8VAy3aVj6Vbfr69GpjGxGAmpUYFdU4u/3Oyxeh5awNAG5UYzOWCOXNqVXxhnX+wos6Qz
	DOLWU8aHJzlul4+YTXZwkVsZY8c9P5ZUBQCOFEJzJjzk9XWGPz/J0OZcHncAQ25mGdTs1XRRDSY
	loJWPcZ0ddyI2TRs/lCK8cILD+kQjdUFhv4mukLs5i1w5wEVAo7Z3o7Cb0X+2Yp6/uAlfluKTgg
	ws7iKXAEuVXSTEUsoy+AtcB0BvhKPk3oGwuxNcEYJzRKLrMgmT+MRkRUQOyCtjJvTMb9SX9ecLw
	tYU0uw==
X-Received: by 2002:a17:902:c40a:b0:2e5:e1de:9c3c with SMTP id d9443c01a7336-2e9a6d2b9b3mr74547125ad.47.1792436498569;
        Mon, 19 Oct 2026 12:01:38 -0700 (PDT)
Received: from jingyliang-input-linux.c.googlers.com (218.117.230.35.bc.googleusercontent.com. [35.230.117.218])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea151e1b7esm4473105ad.75.2026.10.19.12.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 12:01:37 -0700 (PDT)
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Mon, 19 Oct 2026 19:01:19 +0000
Subject: [PATCH v6 07/11] HID: spi-hid: add ACPI support for HID over SPI
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
Message-Id: <20261019-send-upstream-v6-7-cb9ba4b3d6fa@chromium.org>
References: <20261019-send-upstream-v6-0-cb9ba4b3d6fa@chromium.org>
In-Reply-To: <20261019-send-upstream-v6-0-cb9ba4b3d6fa@chromium.org>
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
 hbarnor@chromium.org, tfiga@chromium.org, fqwqf@fqwqf.xyz, daleyo@gmail.com, 
 Jingyuan Liang <jingyliang@chromium.org>, Angela Czubak <acz@semihalf.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792436487; l=13793;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=pT22yksqmt09BNvdotyWmbbvsqwK0g2QM86zwVsCKC4=;
 b=zEF7oHW7aAQ2hZ0Pzk5WJrpGqiKNHcWk5UUcV14MHHh8m0jvnMDiG6iBXtioS+InHHPJbaXSN
 dRCaXljb1AjC4cxahGZTsRnpg3KxAmDfInZ03GwjUJsUoyjWs2XEFPd
X-Developer-Key: i=jingyliang@chromium.org; a=ed25519;
 pk=VTYSdqslTtYOjWWoIGgYoWupGWqNSidrggReKMgfPo4=

From: Angela Czubak <acz@semihalf.com>

Detect SPI HID devices described in ACPI.

Signed-off-by: Angela Czubak <acz@semihalf.com>
Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Tested-by: Dale Whinham <daleyo@gmail.com>
Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
---
 drivers/hid/spi-hid/Kconfig        |  16 +++
 drivers/hid/spi-hid/Makefile       |   1 +
 drivers/hid/spi-hid/spi-hid-acpi.c | 261 +++++++++++++++++++++++++++++++++++++
 drivers/hid/spi-hid/spi-hid-core.c |  48 +++----
 drivers/hid/spi-hid/spi-hid.h      |  45 +++++++
 5 files changed, 344 insertions(+), 27 deletions(-)

diff --git a/drivers/hid/spi-hid/Kconfig b/drivers/hid/spi-hid/Kconfig
index 836fdefe8345..303ada03a1bf 100644
--- a/drivers/hid/spi-hid/Kconfig
+++ b/drivers/hid/spi-hid/Kconfig
@@ -10,6 +10,22 @@ menuconfig SPI_HID
 
 if SPI_HID
 
+config SPI_HID_ACPI
+	tristate "HID over SPI transport layer ACPI driver"
+	depends on ACPI
+	select RESET_CONTROLLER
+	select SPI_HID_CORE
+	help
+	  Say Y here if you use a keyboard, a touchpad, a touchscreen, or any
+	  other HID based devices which are connected to your computer via SPI.
+	  This driver supports ACPI-based systems.
+
+	  If unsure, say N.
+
+	  This support is also available as a module.  If so, the module
+	  will be called spi-hid-acpi. It will also build/depend on the
+	  module spi-hid.
+
 config SPI_HID_CORE
 	tristate
 endif
diff --git a/drivers/hid/spi-hid/Makefile b/drivers/hid/spi-hid/Makefile
index 733e006df56e..3ca326602643 100644
--- a/drivers/hid/spi-hid/Makefile
+++ b/drivers/hid/spi-hid/Makefile
@@ -8,3 +8,4 @@
 obj-$(CONFIG_SPI_HID_CORE)	+= spi-hid.o
 spi-hid-objs 			= spi-hid-core.o
 CFLAGS_spi-hid-core.o 		:= -I$(src)
+obj-$(CONFIG_SPI_HID_ACPI)	+= spi-hid-acpi.o
diff --git a/drivers/hid/spi-hid/spi-hid-acpi.c b/drivers/hid/spi-hid/spi-hid-acpi.c
new file mode 100644
index 000000000000..31ca3fa336cd
--- /dev/null
+++ b/drivers/hid/spi-hid/spi-hid-acpi.c
@@ -0,0 +1,261 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * HID over SPI protocol, ACPI related code
+ *
+ * Copyright (c) 2021 Microsoft Corporation
+ * Copyright (c) 2026 Google LLC
+ *
+ * This code was forked out of the HID over SPI core code, which is partially
+ * based on "HID over I2C protocol implementation:
+ *
+ * Copyright (c) 2012 Benjamin Tissoires <benjamin.tissoires@gmail.com>
+ * Copyright (c) 2012 Ecole Nationale de l'Aviation Civile, France
+ * Copyright (c) 2012 Red Hat, Inc
+ *
+ * which in turn is partially based on "USB HID support for Linux":
+ *
+ * Copyright (c) 1999 Andreas Gal
+ * Copyright (c) 2000-2005 Vojtech Pavlik <vojtech@suse.cz>
+ * Copyright (c) 2005 Michael Haboustak <mike-@cinci.rr.com> for Concept2, Inc
+ * Copyright (c) 2007-2008 Oliver Neukum
+ * Copyright (c) 2006-2010 Jiri Kosina
+ */
+
+#include <linux/acpi.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/reset.h>
+#include <linux/uuid.h>
+
+#include "spi-hid.h"
+
+/* Config structure is filled with data from ACPI */
+struct spi_hid_acpi_config {
+	struct spihid_ops ops;
+
+	struct spi_hid_conf property_conf;
+	u32 post_power_on_delay_ms;
+	u32 minimal_reset_delay_ms;
+	struct acpi_device *adev;
+	struct device *dev;
+};
+
+/* HID SPI Device: 6e2ac436-0fcf41af-a265-b32a220dcfab */
+static guid_t spi_hid_guid =
+	GUID_INIT(0x6E2AC436, 0x0FCF, 0x41AF,
+		  0xA2, 0x65, 0xB3, 0x2A, 0x22, 0x0D, 0xCF, 0xAB);
+
+static int spi_hid_acpi_populate_config(struct spi_hid_acpi_config *conf,
+					struct acpi_device *adev)
+{
+	acpi_handle handle = acpi_device_handle(adev);
+	union acpi_object *obj;
+
+	conf->adev = adev;
+
+	/* Revision 3 for HID over SPI V1, see specification. */
+	obj = acpi_evaluate_dsm_typed(handle, &spi_hid_guid, 3, 1, NULL,
+				      ACPI_TYPE_INTEGER);
+	if (!obj) {
+		acpi_handle_err(handle,
+				"Error _DSM call to get HID input report header address failed\n");
+		return -ENODEV;
+	}
+	conf->property_conf.input_report_header_address = obj->integer.value;
+	ACPI_FREE(obj);
+
+	obj = acpi_evaluate_dsm_typed(handle, &spi_hid_guid, 3, 2, NULL,
+				      ACPI_TYPE_INTEGER);
+	if (!obj) {
+		acpi_handle_err(handle,
+				"Error _DSM call to get HID input report body address failed\n");
+		return -ENODEV;
+	}
+	conf->property_conf.input_report_body_address = obj->integer.value;
+	ACPI_FREE(obj);
+
+	obj = acpi_evaluate_dsm_typed(handle, &spi_hid_guid, 3, 3, NULL,
+				      ACPI_TYPE_INTEGER);
+	if (!obj) {
+		acpi_handle_err(handle,
+				"Error _DSM call to get HID output report header address failed\n");
+		return -ENODEV;
+	}
+	conf->property_conf.output_report_address = obj->integer.value;
+	ACPI_FREE(obj);
+
+	obj = acpi_evaluate_dsm_typed(handle, &spi_hid_guid, 3, 4, NULL,
+				      ACPI_TYPE_BUFFER);
+	if (!obj) {
+		acpi_handle_err(handle,
+				"Error _DSM call to get HID read opcode failed\n");
+		return -ENODEV;
+	}
+	if (obj->buffer.length == 1) {
+		conf->property_conf.read_opcode = obj->buffer.pointer[0];
+	} else {
+		acpi_handle_err(handle,
+				"Error _DSM call to get HID read opcode, too long buffer\n");
+		ACPI_FREE(obj);
+		return -ENODEV;
+	}
+	ACPI_FREE(obj);
+
+	obj = acpi_evaluate_dsm_typed(handle, &spi_hid_guid, 3, 5, NULL,
+				      ACPI_TYPE_BUFFER);
+	if (!obj) {
+		acpi_handle_err(handle,
+				"Error _DSM call to get HID write opcode failed\n");
+		return -ENODEV;
+	}
+	if (obj->buffer.length == 1) {
+		conf->property_conf.write_opcode = obj->buffer.pointer[0];
+	} else {
+		acpi_handle_err(handle,
+				"Error _DSM call to get HID write opcode, too long buffer\n");
+		ACPI_FREE(obj);
+		return -ENODEV;
+	}
+	ACPI_FREE(obj);
+
+	/* Value not provided in ACPI,*/
+	conf->post_power_on_delay_ms = 5;
+	conf->minimal_reset_delay_ms = 150;
+
+	if (!acpi_has_method(handle, "_RST")) {
+		acpi_handle_err(handle, "No reset method for acpi handle\n");
+		return -EINVAL;
+	}
+
+	/* FIXME: not reading hid-over-spi-flags, multi-SPI not supported */
+
+	return 0;
+}
+
+static int spi_hid_acpi_power_none(struct spihid_ops *ops)
+{
+	return 0;
+}
+
+static int spi_hid_acpi_power_down(struct spihid_ops *ops)
+{
+	struct spi_hid_acpi_config *conf = container_of(ops,
+							struct spi_hid_acpi_config,
+							ops);
+
+	return acpi_device_set_power(conf->adev, ACPI_STATE_D3);
+}
+
+static int spi_hid_acpi_power_up(struct spihid_ops *ops)
+{
+	struct spi_hid_acpi_config *conf = container_of(ops,
+							struct spi_hid_acpi_config,
+							ops);
+	int error;
+
+	error = acpi_device_set_power(conf->adev, ACPI_STATE_D0);
+	if (error) {
+		dev_err(&conf->adev->dev, "Error could not power up ACPI device: %d\n", error);
+		return error;
+	}
+
+	if (conf->post_power_on_delay_ms)
+		msleep(conf->post_power_on_delay_ms);
+
+	return 0;
+}
+
+static int spi_hid_acpi_assert_reset(struct spihid_ops *ops)
+{
+	return 0;
+}
+
+static int spi_hid_acpi_deassert_reset(struct spihid_ops *ops)
+{
+	struct spi_hid_acpi_config *conf = container_of(ops,
+							struct spi_hid_acpi_config,
+							ops);
+
+	/*
+	 * Probe guarantees an ACPI reset method exists. Use the optional
+	 * variant so that the absence of an additional reset controller
+	 * binding is not reported as an error after a successful reset.
+	 */
+	return device_reset_optional(conf->dev);
+}
+
+static void spi_hid_acpi_sleep_minimal_reset_delay(struct spihid_ops *ops)
+{
+	struct spi_hid_acpi_config *conf = container_of(ops,
+							struct spi_hid_acpi_config,
+							ops);
+	fsleep(1000 * conf->minimal_reset_delay_ms);
+}
+
+static int spi_hid_acpi_probe(struct spi_device *spi)
+{
+	struct device *dev = &spi->dev;
+	struct acpi_device *adev;
+	struct spi_hid_acpi_config *config;
+	int error;
+
+	adev = ACPI_COMPANION(dev);
+	if (!adev) {
+		dev_err(dev, "Error could not get ACPI device\n");
+		return -ENODEV;
+	}
+
+	config = devm_kzalloc(dev, sizeof(struct spi_hid_acpi_config),
+			      GFP_KERNEL);
+	if (!config)
+		return -ENOMEM;
+
+	config->dev = dev;
+
+	if (acpi_device_power_manageable(adev)) {
+		config->ops.power_up = spi_hid_acpi_power_up;
+		config->ops.power_down = spi_hid_acpi_power_down;
+	} else {
+		config->ops.power_up = spi_hid_acpi_power_none;
+		config->ops.power_down = spi_hid_acpi_power_none;
+	}
+	config->ops.assert_reset = spi_hid_acpi_assert_reset;
+	config->ops.deassert_reset = spi_hid_acpi_deassert_reset;
+	config->ops.sleep_minimal_reset_delay =
+		spi_hid_acpi_sleep_minimal_reset_delay;
+
+	error = spi_hid_acpi_populate_config(config, adev);
+	if (error) {
+		dev_err(dev, "%s: unable to populate config data\n", __func__);
+		return error;
+	}
+
+	return spi_hid_core_probe(spi, &config->ops, &config->property_conf);
+}
+
+static const struct acpi_device_id spi_hid_acpi_match[] = {
+	{ "ACPI0C51", 0 },
+	{ "PNP0C51", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, spi_hid_acpi_match);
+
+static struct spi_driver spi_hid_acpi_driver = {
+	.driver = {
+		.name	= "spi_hid_acpi",
+		.owner	= THIS_MODULE,
+		.acpi_match_table = spi_hid_acpi_match,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+		.dev_groups = spi_hid_groups,
+	},
+	.probe		= spi_hid_acpi_probe,
+	.remove		= spi_hid_core_remove,
+};
+
+module_spi_driver(spi_hid_acpi_driver);
+
+MODULE_DESCRIPTION("HID over SPI ACPI transport driver");
+MODULE_AUTHOR("Angela Czubak <aczubak@google.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/hid/spi-hid/spi-hid-core.c b/drivers/hid/spi-hid/spi-hid-core.c
index e428fae762ac..96805c10bfe3 100644
--- a/drivers/hid/spi-hid/spi-hid-core.c
+++ b/drivers/hid/spi-hid/spi-hid-core.c
@@ -44,6 +44,7 @@
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 
+#include "spi-hid.h"
 #include "spi-hid-core.h"
 
 #define CREATE_TRACE_POINTS
@@ -115,31 +116,6 @@ struct spi_hid_output_report {
 	u8 *content;
 };
 
-/* struct spi_hid_conf - Conf provided to the core */
-struct spi_hid_conf {
-	u32 input_report_header_address;
-	u32 input_report_body_address;
-	u32 output_report_address;
-	u8 read_opcode;
-	u8 write_opcode;
-};
-
-/**
- * struct spihid_ops - Ops provided to the core
- * @power_up: do sequencing to power up the device
- * @power_down: do sequencing to power down the device
- * @assert_reset: do sequencing to assert the reset line
- * @deassert_reset: do sequencing to deassert the reset line
- * @sleep_minimal_reset_delay: minimal sleep delay during reset
- */
-struct spihid_ops {
-	int (*power_up)(struct spihid_ops *ops);
-	int (*power_down)(struct spihid_ops *ops);
-	int (*assert_reset)(struct spihid_ops *ops);
-	int (*deassert_reset)(struct spihid_ops *ops);
-	void (*sleep_minimal_reset_delay)(struct spihid_ops *ops);
-};
-
 static struct hid_ll_driver spi_hid_ll_driver;
 
 static void spi_hid_populate_read_approvals(const struct spi_hid_conf *conf,
@@ -327,8 +303,21 @@ static void spi_hid_error_handler(struct spi_hid *shid)
 
 	shid->power_state = HIDSPI_ON;
 
-	shid->ops->deassert_reset(shid->ops);
+	error = shid->ops->deassert_reset(shid->ops);
+	if (error) {
+		dev_err(dev, "failed to deassert reset: %d\n", error);
+		shid->bus_error_count++;
+		shid->bus_last_error = error;
+		/*
+		 * Without a successful reset the device will not send a reset
+		 * response, so no IRQ would trigger another recovery attempt.
+		 * Retry from here; reset_attempts bounds the number of tries.
+		 */
+		set_bit(SPI_HID_ERROR, &shid->flags);
+		schedule_work(&shid->reset_work);
+	}
 
+	/* Balance disable_irq() above; a retry disables it again. */
 	enable_irq(shid->spi->irq);
 }
 
@@ -1431,7 +1420,12 @@ int spi_hid_core_probe(struct spi_device *spi, struct spihid_ops *ops,
 		return error;
 	}
 
-	shid->ops->deassert_reset(shid->ops);
+	error = shid->ops->deassert_reset(shid->ops);
+	if (error) {
+		dev_err(dev, "%s: failed to deassert reset: %d\n", __func__, error);
+		shid->ops->power_down(shid->ops);
+		return error;
+	}
 
 	enable_irq(spi->irq);
 
diff --git a/drivers/hid/spi-hid/spi-hid.h b/drivers/hid/spi-hid/spi-hid.h
new file mode 100644
index 000000000000..f5a5f4d54beb
--- /dev/null
+++ b/drivers/hid/spi-hid/spi-hid.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2021 Microsoft Corporation
+ * Copyright (c) 2026 Google LLC
+ */
+
+#ifndef SPI_HID_H
+#define SPI_HID_H
+
+#include <linux/spi/spi.h>
+#include <linux/sysfs.h>
+
+/* struct spi_hid_conf - Conf provided to the core */
+struct spi_hid_conf {
+	u32 input_report_header_address;
+	u32 input_report_body_address;
+	u32 output_report_address;
+	u8 read_opcode;
+	u8 write_opcode;
+};
+
+/**
+ * struct spihid_ops - Ops provided to the core
+ * @power_up: do sequencing to power up the device
+ * @power_down: do sequencing to power down the device
+ * @assert_reset: do sequencing to assert the reset line
+ * @deassert_reset: do sequencing to deassert the reset line
+ * @sleep_minimal_reset_delay: minimal sleep delay during reset
+ */
+struct spihid_ops {
+	int (*power_up)(struct spihid_ops *ops);
+	int (*power_down)(struct spihid_ops *ops);
+	int (*assert_reset)(struct spihid_ops *ops);
+	int (*deassert_reset)(struct spihid_ops *ops);
+	void (*sleep_minimal_reset_delay)(struct spihid_ops *ops);
+};
+
+int spi_hid_core_probe(struct spi_device *spi, struct spihid_ops *ops,
+		       struct spi_hid_conf *conf);
+
+void spi_hid_core_remove(struct spi_device *spi);
+
+extern const struct attribute_group *spi_hid_groups[];
+
+#endif /* SPI_HID_H */

-- 
2.56.0.212.g129ede20d9-goog

