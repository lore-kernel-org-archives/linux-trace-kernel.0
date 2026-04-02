Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063C834D4FE
	for <linux-trace-kernel@vger.kernel.org>; Thu,  2 Apr 2026 01:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775095194; cv=none; b=W0FHjEodRQfauzNHfkyL+VEuhjDaOJe+cXv7Vzwbay8Za87pLNgy2lueXO+gXDdlAX8zNNWlwtIfZ46ZIJf6+crgDrsz3JZXAlUKwhDOszWQtOd4S1mUrPRzsPBWEK54sD5yAKTL4ImUWkOBO+wWy1IBzgVDCdXKrYA1qaaKOQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775095194; c=relaxed/simple;
	bh=muYzCeJxxDVVoGN5ZRXonkUdkqtuysZ7Wys8uAcwP2Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fFJa1cevjhP4spcaN4qS7peANFxD5NW35M6tPW61eRi1Liuq86N1yZp8g4IAZXinoMwdW7R+R5/Wxim8E73PxVwzC/APruXWcr8FC9xCKXKSgdFM05WGe8lY9i0O0PlCFTe+9szZ+AHjmkCQ9oHQnFXj7HSIH8ylnpc9PmA6QYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Wk6O4AER; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Wk6O4AER"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-35da2d35eccso190333a91.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 01 Apr 2026 18:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1775095188; x=1775699988; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ci9N603dJdfsrRIavDTc2BSxOYIaJmfIgiSDMr4kr0s=;
        b=Wk6O4AERIJ5LocFJPSwl5UwQVnSbB0kGTGOWilSjgNeLn/qqmesNJpQguLzpOgqW+a
         wYSd6tTptqhdbK+HDFbZttfTC9s3Tlprl0FuAHQhBbSYxjtwZjXI7WQl+lI0PvaiOmf/
         DpOd2dywKfsU6bsjmoMhoxhDpl91uW4kRxvwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775095188; x=1775699988;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ci9N603dJdfsrRIavDTc2BSxOYIaJmfIgiSDMr4kr0s=;
        b=sBkQ4rHHCMNxnR1wNAy9hDMUzTIDsfU4UMTfibj/Ogx21sU3izAa4OynnsdeDRGrtT
         TLeNU9Z3C89EE/G0cOTeep3qR4ZUGgN2C39xQFdCzsXgMmpg1ZUtJ40UlLIOQMp7khkK
         EnUSa1Met+Mp8qZHWGmj5tibgrKbwx31DtTiOV6Kaxw/VMNIBWDJQ4bEHT56Igi/crMM
         bF2cvsU7IZn1EXQfZZD4sb6zJ+NmV2hqsit52gL83YTA2XmE5vP8BLEx1UnXcPez9lVi
         prqC2m+5q3rPHIEVaqMKLU+/xgdxowFKqB0mQEahtIUkLz49rW994Soqj8Ifgj+G3yBp
         WXLw==
X-Forwarded-Encrypted: i=1; AJvYcCVPucq+XjyTvIW5rEDpZHLSqUbwpxSF6703F9WG4bu43xbW3Fmcr0ac2YKtEUvtO5BjWtm4wLB+legJzYIZbAIW7G8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+zoQoYnm+6ti4C9AxrrkOFmEniZ8BC/iqQoMgUe6u0NON5HOD
	QZPPw4zNGDv5yC7I1G5Zc4qwwmOJc1CyLRGfPwxMau1J55DpNALTX/XoFID4H+zc8A==
X-Gm-Gg: ATEYQzzcADSd9j5iCjIElNZRTXzBDchLnvncv7vTYsKfkx6nExSUPRqJfMkZMyJ/qmC
	QOxc1GOOZ7rLfiqmQsEM8N7FF7DbEqFceEO15zeQlJ1fC0kHt0KMUPmq0V1xNLpRYbA+xxq40V+
	pNY2fUw3+ACodKGKQVxdeEPwqusauqKqUt+yj7kArc+GMhVIZyLnAibl2qUJMEoeEq/YaBUc8CP
	Eb2gpBjJWRtZTiykW01JBB+G4T+XzvLEsKE9Y5QbLi/y0SogTiUCBgrr2tLXlQUh2VNpimNJhQ4
	6gkjDRFoBrkE7AEuMhXOAMzmjI1Gj0hL8oXYmhvDqoGN6WwNuQ4oTjdGu5ywHHJYDxSgzOXOCg+
	rCwHPqsXlrPSkvEd1aVAz5MQmP1tkbvGU9QnWNHEP4TYLiFejm3jJ8il0fjr+b4bOwEmgKE60F7
	Hwj2sZZ0g28Z9a2z1HvJAru90YB34LLiLghJh/mlxc5H952eqOB8RMLDXRXbpWx6r2lMK33XAqu
	kxFAy/+Eds+ZOGZ5Ek0qdoLCaY9HF5rzQ==
X-Received: by 2002:a17:902:da87:b0:2b2:50f6:cdd9 with SMTP id d9443c01a7336-2b269aa3b73mr60215885ad.8.1775095187988;
        Wed, 01 Apr 2026 18:59:47 -0700 (PDT)
Received: from jingyliang-input-linux.c.googlers.com (111.169.168.34.bc.googleusercontent.com. [34.168.169.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27478cb4fsm11187535ad.29.2026.04.01.18.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 18:59:47 -0700 (PDT)
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Thu, 02 Apr 2026 01:59:45 +0000
Subject: [PATCH v3 08/11] HID: spi_hid: add device tree support for SPI
 over HID
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-send-upstream-v3-8-6091c458d357@chromium.org>
References: <20260402-send-upstream-v3-0-6091c458d357@chromium.org>
In-Reply-To: <20260402-send-upstream-v3-0-6091c458d357@chromium.org>
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
 Dmitry Antipov <dmanti@microsoft.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775095180; l=8657;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=dkIDzLBKdAqTbNwZchQpCk88/EtnlSaDxMhx8sAerwU=;
 b=vr2vdVnMrpKHC0DyZIyl9spKXeNl9V6J92Ju1O6Xne+YKaIYVQfFLm50hSetEbpNdQMM/Fi3o
 A1E3qmVS3usB8zqPhUD1RV40nH2TG/my1dQ9OzzC/1b8ghKU2fzVnbB
X-Developer-Key: i=jingyliang@chromium.org; a=ed25519;
 pk=VTYSdqslTtYOjWWoIGgYoWupGWqNSidrggReKMgfPo4=

From: Jarrett Schultz <jaschultz@microsoft.com>

Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
---
 drivers/hid/spi-hid/Kconfig      |  15 +++
 drivers/hid/spi-hid/Makefile     |   1 +
 drivers/hid/spi-hid/spi-hid-of.c | 243 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 259 insertions(+)

diff --git a/drivers/hid/spi-hid/Kconfig b/drivers/hid/spi-hid/Kconfig
index 114b1e00da39..76a2cd587a3e 100644
--- a/drivers/hid/spi-hid/Kconfig
+++ b/drivers/hid/spi-hid/Kconfig
@@ -25,6 +25,21 @@ config SPI_HID_ACPI
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
index 000000000000..651456b6906d
--- /dev/null
+++ b/drivers/hid/spi-hid/spi-hid-of.c
@@ -0,0 +1,243 @@
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
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/regulator/consumer.h>
+#include <linux/gpio/consumer.h>
+#include <linux/delay.h>
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
+	u16 hid_over_spi_flags;
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
+		dev_err(dev, "Input report header address not provided.");
+		return -ENODEV;
+	}
+	conf->property_conf.input_report_header_address = val;
+
+	error = device_property_read_u32(dev, "input-report-body-address", &val);
+	if (error) {
+		dev_err(dev, "Input report body address not provided.");
+		return -ENODEV;
+	}
+	conf->property_conf.input_report_body_address = val;
+
+	error = device_property_read_u32(dev, "output-report-address", &val);
+	if (error) {
+		dev_err(dev, "Output report address not provided.");
+		return -ENODEV;
+	}
+	conf->property_conf.output_report_address = val;
+
+	error = device_property_read_u32(dev, "read-opcode", &val);
+	if (error) {
+		dev_err(dev, "Read opcode not provided.");
+		return -ENODEV;
+	}
+	conf->property_conf.read_opcode = val;
+
+	error = device_property_read_u32(dev, "write-opcode", &val);
+	if (error) {
+		dev_err(dev, "Write opcode not provided.");
+		return -ENODEV;
+	}
+	conf->property_conf.write_opcode = val;
+
+	conf->supply = devm_regulator_get(dev, "vdd");
+	if (IS_ERR(conf->supply)) {
+		if (PTR_ERR(conf->supply) != -EPROBE_DEFER)
+			dev_err(dev, "Failed to get regulator: %ld.",
+				PTR_ERR(conf->supply));
+		return PTR_ERR(conf->supply);
+	}
+	conf->supply_enabled = false;
+
+	conf->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(conf->reset_gpio)) {
+		dev_err(dev, "%s: error getting reset GPIO.", __func__);
+		return PTR_ERR(conf->reset_gpio);
+	}
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
+	gpiod_set_value(conf->reset_gpio, 1);
+	return 0;
+}
+
+static int spi_hid_of_deassert_reset(struct spihid_ops *ops)
+{
+	struct spi_hid_of_config *conf = container_of(ops,
+						      struct spi_hid_of_config,
+						      ops);
+
+	gpiod_set_value(conf->reset_gpio, 0);
+	return 0;
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
+	/*
+	 * FIXME: hid_over_spi_flags could be retrieved from spi mode.
+	 * It is always 0 because multi-SPI not supported.
+	 */
+	config->hid_over_spi_flags = 0;
+
+	error = spi_hid_of_populate_config(config, dev);
+	if (error) {
+		dev_err(dev, "%s: unable to populate config data.", __func__);
+		return error;
+	}
+
+	return spi_hid_core_probe(spi, &config->ops, &config->property_conf);
+}
+
+const struct spi_hid_timing_data timing_data = {
+	.post_power_on_delay_ms = 10,
+	.minimal_reset_delay_ms = 100,
+};
+
+const struct of_device_id spi_hid_of_match[] = {
+	{ .compatible = "hid-over-spi", .data = &timing_data },
+	{}
+};
+MODULE_DEVICE_TABLE(of, spi_hid_of_match);
+
+static const struct spi_device_id spi_hid_of_id_table[] = {
+	{ "hid", 0 },
+	{ "hid-over-spi", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, spi_hid_of_id_table);
+
+static struct spi_driver spi_hid_of_driver = {
+	.driver = {
+		.name	= "spi_hid_of",
+		.owner	= THIS_MODULE,
+		.of_match_table = spi_hid_of_match,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+		.dev_groups = spi_hid_groups,
+	},
+	.probe		= spi_hid_of_probe,
+	.remove		= spi_hid_core_remove,
+	.id_table	= spi_hid_of_id_table,
+};
+
+module_spi_driver(spi_hid_of_driver);
+
+MODULE_DESCRIPTION("HID over SPI OF transport driver");
+MODULE_AUTHOR("Dmitry Antipov <dmanti@microsoft.com>");
+MODULE_LICENSE("GPL");

-- 
2.53.0.1185.g05d4b7b318-goog

