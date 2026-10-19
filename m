Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792436503;
	b=o7ZCnvA5U9taMy1J9Y/3vQ20b/JZAUlEcj+EUrLzBfvE5TlWhY1AXhO8cVumlUnLPQWQ
	 QKYbb1Wbhjsb/8bcp6RNikcmuD1APawL3H55rwRkl3rMHJhv2x8LGebqRYJJTbel4uDfk
	 Wz7BUCjZaUquumfV/t9cHC58EEesVT0oY8JaOInHKFFNqG0SxHywFe8HA3D5D3OIEMUlX
	 e8ndwdQltF/Ki5zyL1hip0KJN8zPAdhQeDZ0iaq3yG0hhxObto+rOzVSLBDNAnpOxUFZu
	 WJZqtVaoukMi8WfIG8y5AO606llxPiRx8Z3d7gLL6aW/MoV1F1WRTETFdxNqeb+7IBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792436503;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=zPfvRWM7bSNeBi2gQjCK2xqmlEgV+DzhRh7S+wwhFIw=;
	b=rxM39Aefns68tiSi2BzVH/wACIsenRFjBpSqP/ei9QLrbZzCeTKgZYiAOpO9Bgkb07gi
	 Ml3tjN7daDPkPQKKyYUuR40Xpk1bEiVdvLTcaTHr250Qu/c9NBojnSRyTrUCfBbsq4fCu
	 OerBzUzSoPLDl7SaXID69f7njqvCumDqVt631hu2tjgeiiSoefXvt9TxqP3C74DxFWM+V
	 dxHgvEcc6XSsYop24cgprBcCMCh8qMaqhLBXxjEdTGl3/Qwk4SMdbAyPvulYKXYqFXJgK
	 X7G8o9fNivjw1N8oTj07dLHRvF41zUG/64EIKtBBZuuTcBRcZQsNorXMhXNvDpmOfHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=OOzWEP9A;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E0560A4ADD
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Oct 2026 19:01:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7E0560A4ADD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=OOzWEP9A
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2e608cd460eso13597595ad.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Oct 2026 12:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792436501; x=1793041301; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zPfvRWM7bSNeBi2gQjCK2xqmlEgV+DzhRh7S+wwhFIw=;
        b=OOzWEP9A13yvn7IDRzpSBQULW1MraF5lMOdMHKUir0slkMU0jl69RWniFMFrfr/Y5v
         mNM/MroFMs+lz9pbII329dSRc2y+Zu86FF71af/KdsNM9AcMJWFWzqTWeyKeG8k9GdhT
         +f7LzvLc+jXbpcYzL96idvhPgsU83xmE/u48Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792436501; x=1793041301;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zPfvRWM7bSNeBi2gQjCK2xqmlEgV+DzhRh7S+wwhFIw=;
        b=0aVqBh9nDzOqpTTVVyxpGpE9EVb2bm/UyDBxEmHhsEQYvSQfgtcrQDgqZubUGWGVLJ
         vI8CUeKJo7U5lFfik/hJeyTgv2OGBx7dqVZr1RyhAHLAE2zweei4JY1BW1cPzXYlmEoQ
         jTHdJriYGY18OG3vEzcgwk6xtFK8VHM9c2cZzVFLpHors/Gqh0uWT2QZDoY2i8/meq7R
         kbqp/wC14eK4MbN7FdsNUapPLTADKXJX7n2jlTubK61C+m4Ue29FLCOVAmRrP26FqnWp
         +/LGcD4ux5Z2YzWXYWH19Qc/OM1EE2UeiqxKGUlTvTL+Op9f4oX6BGsNPK9i348qUwtw
         4uzA==
X-Forwarded-Encrypted: i=1; AKwUvBwbAb6BX/jiz+yIrjSZJ49iszbMqohtPweugpSBLpDupT9ijfGqf1xSOddXBcFCR4+UzBIDFpIdvSEvhd9Yimyv/Nw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJFgxhoMeLJN/8hbYjs57tuPVOVmoT/LR5/JXWVUhXvNWf2BSUW
	L9hoMBZ0ZutHjwoPQfnyNWlGWUZBxmkvoFC9rwcmHQkuIvc4f7bY6cvk/qEgPdtX4w==
X-Gm-Gg: AYBFou2G1PWHmrf4jjeWQCb9zeHPBk8UCMt4eVIel/AWSgRygIAg7ILwEdKCJTuWk7f
	kbTLXTvlYKBa3IHL97AbGhNRLONl96RTzMb5TIrtXvqZE4FbrNlRe/PZ0WnTC19+MGgQVJ2Q39U
	hckYp8e2Yb5aeA3lLNTTVnodpou4o6AyVeSYQvHKoPM7pp0DgqgTEzldaKaJ8PKQU1POK1F0Xwn
	NtfJGxfTuiw54G8d1fubvFMaVQCOE+mRp6pxMmRwo/FerYjzHJgMTSG9mHnlu9jxrNm92lKd4uN
	TGJ5t1Nm+td3tZtJlJosp+e6CfqjreKcUB78S6dfxzLsJwGUxGpBP2/fl8N8vNdyrPEi6UKZqWK
	uJyIQYXpcQWR6fFYGIzeGfYM/SLOMT7lwCvG9la4hpnQjbAJ6QIgKeJGtbESawuTZBffXG36zJ9
	ApBy8fEVqZAPsKlP/bEBUpa0lCOUbtHnHBQd/6MzOZ+pd5xv9seb4tlicOqyrRBOfj96xJM5fp0
	XHct0ljHG9Cb4kh9UZ6Btto8xrhgz+ecNnmB4X9mKKaOIYDslZKkgjGkKWT86M4OgoHaxZgCFGA
	k+3J4tSnmHgq1bUU
X-Received: by 2002:a17:903:19e7:b0:2e9:5059:4468 with SMTP id d9443c01a7336-2e9a683494emr71737535ad.7.1792436501030;
        Mon, 19 Oct 2026 12:01:41 -0700 (PDT)
Received: from jingyliang-input-linux.c.googlers.com (218.117.230.35.bc.googleusercontent.com. [35.230.117.218])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea151e1b7esm4473105ad.75.2026.10.19.12.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 12:01:40 -0700 (PDT)
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Mon, 19 Oct 2026 19:01:21 +0000
Subject: [PATCH v6 09/11] HID: spi-hid: add device tree support for HID
 over SPI
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
Message-Id: <20261019-send-upstream-v6-9-cb9ba4b3d6fa@chromium.org>
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
 Jingyuan Liang <jingyliang@chromium.org>, 
 Jarrett Schultz <jaschultz@microsoft.com>, 
 Dmitry Antipov <dmanti@microsoft.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792436487; l=8811;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=ZwplQx3Zaio7A0BeO3K1MwL13gktGgnxvBWSAzF3474=;
 b=hj1gYmEhnIR2luvY05+VzohgfAKYfecLZ7gP9Zi8ZZmeDQaAMJWyQL+VuDRcTaSY/9+ffvLP3
 Hmn5LFFKlVABs01WX/YT2ic5JqNOlsDsHlE+oEnAIYSK0lv5MDt55Yo
X-Developer-Key: i=jingyliang@chromium.org; a=ed25519;
 pk=VTYSdqslTtYOjWWoIGgYoWupGWqNSidrggReKMgfPo4=

From: Jarrett Schultz <jaschultz@microsoft.com>

Detect SPI HID devices described in Device Tree.

Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
Tested-by: Dale Whinham <daleyo@gmail.com>
Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
---
 drivers/hid/spi-hid/Kconfig      |  15 +++
 drivers/hid/spi-hid/Makefile     |   1 +
 drivers/hid/spi-hid/spi-hid-of.c | 241 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 257 insertions(+)

diff --git a/drivers/hid/spi-hid/Kconfig b/drivers/hid/spi-hid/Kconfig
index 303ada03a1bf..63f202975ac3 100644
--- a/drivers/hid/spi-hid/Kconfig
+++ b/drivers/hid/spi-hid/Kconfig
@@ -26,6 +26,21 @@ config SPI_HID_ACPI
 	  will be called spi-hid-acpi. It will also build/depend on the
 	  module spi-hid.
 
+config SPI_HID_OF
+	tristate "HID over SPI transport layer Open Firmware driver"
+	depends on OF
+	select SPI_HID_CORE
+	help
+	  Say Y here if you use a keyboard, a touchpad, a touchscreen, or any
+	  other HID based devices which are connected to your computer via SPI.
+	  This driver supports Open Firmware (Device Tree)-based systems.
+
+	  If unsure, say N.
+
+	  This support is also available as a module.  If so, the module
+	  will be called spi-hid-of. It will also build/depend on the
+	  module spi-hid.
+
 config SPI_HID_CORE
 	tristate
 endif
diff --git a/drivers/hid/spi-hid/Makefile b/drivers/hid/spi-hid/Makefile
index 3ca326602643..31192e71edae 100644
--- a/drivers/hid/spi-hid/Makefile
+++ b/drivers/hid/spi-hid/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_SPI_HID_CORE)	+= spi-hid.o
 spi-hid-objs 			= spi-hid-core.o
 CFLAGS_spi-hid-core.o 		:= -I$(src)
 obj-$(CONFIG_SPI_HID_ACPI)	+= spi-hid-acpi.o
+obj-$(CONFIG_SPI_HID_OF)	+= spi-hid-of.o
diff --git a/drivers/hid/spi-hid/spi-hid-of.c b/drivers/hid/spi-hid/spi-hid-of.c
new file mode 100644
index 000000000000..24215ffaaafd
--- /dev/null
+++ b/drivers/hid/spi-hid/spi-hid-of.c
@@ -0,0 +1,241 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * HID over SPI protocol, Open Firmware related code
+ *
+ * Copyright (c) 2021 Microsoft Corporation
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
+#include <linux/container_of.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/property.h>
+#include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
+#include <linux/types.h>
+
+#include "spi-hid.h"
+
+struct spi_hid_timing_data {
+	u32 post_power_on_delay_ms;
+	u32 minimal_reset_delay_ms;
+};
+
+/* Config structure is filled with data from Device Tree */
+struct spi_hid_of_config {
+	struct spihid_ops ops;
+
+	struct spi_hid_conf property_conf;
+	const struct spi_hid_timing_data *timing_data;
+
+	struct gpio_desc *reset_gpio;
+	struct regulator *supply;
+	bool supply_enabled;
+};
+
+static const struct spi_hid_timing_data timing_data = {
+	.post_power_on_delay_ms = 10,
+	.minimal_reset_delay_ms = 100,
+};
+
+static int spi_hid_of_populate_config(struct spi_hid_of_config *conf,
+				      struct device *dev)
+{
+	int error;
+	u32 val;
+
+	error = device_property_read_u32(dev, "input-report-header-address",
+					 &val);
+	if (error) {
+		dev_err(dev, "Input report header address not provided\n");
+		return -ENODEV;
+	}
+	conf->property_conf.input_report_header_address = val;
+
+	error = device_property_read_u32(dev, "input-report-body-address", &val);
+	if (error) {
+		dev_err(dev, "Input report body address not provided\n");
+		return -ENODEV;
+	}
+	conf->property_conf.input_report_body_address = val;
+
+	error = device_property_read_u32(dev, "output-report-address", &val);
+	if (error) {
+		dev_err(dev, "Output report address not provided\n");
+		return -ENODEV;
+	}
+	conf->property_conf.output_report_address = val;
+
+	error = device_property_read_u8(dev, "read-opcode",
+					&conf->property_conf.read_opcode);
+	if (error) {
+		dev_err(dev, "Read opcode not provided\n");
+		return -ENODEV;
+	}
+
+	error = device_property_read_u8(dev, "write-opcode",
+					&conf->property_conf.write_opcode);
+	if (error) {
+		dev_err(dev, "Write opcode not provided\n");
+		return -ENODEV;
+	}
+
+	conf->supply = devm_regulator_get(dev, "vdd");
+	if (IS_ERR(conf->supply))
+		return dev_err_probe(dev, PTR_ERR(conf->supply),
+				     "Failed to get regulator\n");
+	conf->supply_enabled = false;
+
+	conf->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(conf->reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(conf->reset_gpio),
+				     "Failed to get reset GPIO\n");
+
+	return 0;
+}
+
+static int spi_hid_of_power_down(struct spihid_ops *ops)
+{
+	struct spi_hid_of_config *conf = container_of(ops,
+						      struct spi_hid_of_config,
+						      ops);
+	int error;
+
+	if (!conf->supply_enabled)
+		return 0;
+
+	error = regulator_disable(conf->supply);
+	if (error == 0)
+		conf->supply_enabled = false;
+
+	return error;
+}
+
+static int spi_hid_of_power_up(struct spihid_ops *ops)
+{
+	struct spi_hid_of_config *conf = container_of(ops,
+						      struct spi_hid_of_config,
+						      ops);
+	int error;
+
+	if (conf->supply_enabled)
+		return 0;
+
+	error = regulator_enable(conf->supply);
+
+	if (error == 0) {
+		conf->supply_enabled = true;
+		fsleep(1000 * conf->timing_data->post_power_on_delay_ms);
+	}
+
+	return error;
+}
+
+static int spi_hid_of_assert_reset(struct spihid_ops *ops)
+{
+	struct spi_hid_of_config *conf = container_of(ops,
+						      struct spi_hid_of_config,
+						      ops);
+
+	return gpiod_set_value_cansleep(conf->reset_gpio, 1);
+}
+
+static int spi_hid_of_deassert_reset(struct spihid_ops *ops)
+{
+	struct spi_hid_of_config *conf = container_of(ops,
+						      struct spi_hid_of_config,
+						      ops);
+
+	return gpiod_set_value_cansleep(conf->reset_gpio, 0);
+}
+
+static void spi_hid_of_sleep_minimal_reset_delay(struct spihid_ops *ops)
+{
+	struct spi_hid_of_config *conf = container_of(ops,
+						      struct spi_hid_of_config,
+						      ops);
+	fsleep(1000 * conf->timing_data->minimal_reset_delay_ms);
+}
+
+static int spi_hid_of_probe(struct spi_device *spi)
+{
+	struct device *dev = &spi->dev;
+	struct spi_hid_of_config *config;
+	int error;
+
+	config = devm_kzalloc(dev, sizeof(struct spi_hid_of_config),
+			      GFP_KERNEL);
+	if (!config)
+		return -ENOMEM;
+
+	config->ops.power_up = spi_hid_of_power_up;
+	config->ops.power_down = spi_hid_of_power_down;
+	config->ops.assert_reset = spi_hid_of_assert_reset;
+	config->ops.deassert_reset = spi_hid_of_deassert_reset;
+	config->ops.sleep_minimal_reset_delay =
+		spi_hid_of_sleep_minimal_reset_delay;
+
+	config->timing_data = device_get_match_data(dev);
+	if (!config->timing_data)
+		config->timing_data = &timing_data;
+
+	/*
+	 * FIXME: multi-SPI not supported. Once it is, derive the
+	 * HID-over-SPI flags from spi->mode.
+	 */
+
+	error = spi_hid_of_populate_config(config, dev);
+	if (error)
+		return dev_err_probe(dev, error, "Unable to populate config data\n");
+
+	return spi_hid_core_probe(spi, &config->ops, &config->property_conf);
+}
+
+static const struct of_device_id spi_hid_of_match[] = {
+	{ .compatible = "hid-over-spi", .data = &timing_data },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, spi_hid_of_match);
+
+static const struct spi_device_id spi_hid_of_id_table[] = {
+	{ .name = "hid" },
+	{ .name = "hid-over-spi" },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, spi_hid_of_id_table);
+
+static struct spi_driver spi_hid_of_driver = {
+	.driver = {
+		.name = "spi_hid_of",
+		.owner = THIS_MODULE,
+		.of_match_table = spi_hid_of_match,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+		.dev_groups = spi_hid_groups,
+	},
+	.probe = spi_hid_of_probe,
+	.remove = spi_hid_core_remove,
+	.id_table = spi_hid_of_id_table,
+};
+
+module_spi_driver(spi_hid_of_driver);
+
+MODULE_DESCRIPTION("HID over SPI OF transport driver");
+MODULE_AUTHOR("Dmitry Antipov <dmanti@microsoft.com>");
+MODULE_LICENSE("GPL");

-- 
2.56.0.212.g129ede20d9-goog

