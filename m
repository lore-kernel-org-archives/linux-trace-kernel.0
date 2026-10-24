Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792803120;
	b=0cgjAWRWfVEUOh8e8RLQHfacx4/LHVT4H3E23i38lF6vz5ScF0Koa/r1D/w2EsiFPm/0
	 /yaHdhCvmFhtdbSsWEbOegxYSpxx3ArcQHGq3XlwCCpIXx9Dh+9ZHwhT6FcPMg2jqxUrv
	 hCQSICRnGYd8dArkKI/sCNsKkYwnBZ2+H7jZihVzjsaj/Ge6bY9maVEX6HOLEJpZf1hEA
	 EeAcCj+4GD2+nZg7NlWsa8gpEz3s1fHTVicGByr2c+wght7BlhGN3tHw3mKqkRiNKn+IG
	 r4/GYXyzZfCHjOl9Sn9M3QnNrIUUHZVkfnwQuAh5gnd0Q7X/ipkZ4lvkehClof2FPJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792803120;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=qhROuWKNB1zu9GN0+zWtwkE2StJd098hmWLDpMHCuHw=;
	b=233uGcQL1e2ZUvtjLz9bEtRB3qNVkJLJ7bXxdDQ0RZHFqT/QqeN7jVghhngwk8m4bMGJ
	 Bg/7g/SjmvXnuj2mjeq4wAppXu8HQ9eHn1E97S7liui2akr+4Y83R3Vksxo29hF6TMhHs
	 8bOFHWd9ngM9WEN7GVHbjK2KtoTPtz/QZ8NwkF2nhC+ArkI8X1veOAKkYGYDzXpdwPFBS
	 fKiRBc3AOAqTWJuu1aNn/Lq5a24vyqcsVYZ7fvKE9mlfPV3p1Xv4k7P+Rx4HkPEhFy1dQ
	 eBQOjtw6zl4Kp+CmB8EL/pGM+REBD7QLFKwTZtlJQgQ56hZSqIJfF6q2AZwN+KTfXJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=RLtLcn9L;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916B560A3804
	for <linux-trace-kernel@vger.kernel.org>; Sat, 24 Oct 2026 00:51:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 916B560A3804
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=RLtLcn9L
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3ad787b79ffso817989a91.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 23 Oct 2026 17:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792803119; x=1793407919; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qhROuWKNB1zu9GN0+zWtwkE2StJd098hmWLDpMHCuHw=;
        b=RLtLcn9LajDMTUG4e+brYlO8O8fLxgyQJvbrTx5vRJIknt12EczmRKkqtdKbofOvXK
         lMlIKXCU0ip9IujT4eDHRJTaWv6ExERqP5JqNyM80ZggSP5E+SezOdf+7gz4cm32Memi
         r1TVe8bYt43+Ht8K0n8KrS2La3cPrpG84I0QY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792803119; x=1793407919;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qhROuWKNB1zu9GN0+zWtwkE2StJd098hmWLDpMHCuHw=;
        b=fz+Nq3GOEtsdHTpjsa2un7Xn8eTjBQTgVJRYFhb5Z64QeoXH+h7pYXECgVP5dagdQF
         tHMTxDoSJF0vSUfw0Du+vIFcEVrkEE9TRFuAGklkBhRgqKSm0+/ckGifAt9AG9aR0cZY
         1g+QiQn+RgPIBLb0F1hTq5DYUE6LZS/4C0pKe50tpgR6ad+sSYgTNKfso55f/NqKI4Ay
         aUEAP7UioA4OR6sxlKsfeUje/Z2h7no1Epq4Bd+0SFspvG6K4+wjSG3PG1ihK5+BXj+1
         23/HrYxFIxpRef8gmD91zR+xhxjuavzUAnPOlc5vjo00iSQdC9xXUPJCpA15K0V/JUk6
         xt3w==
X-Forwarded-Encrypted: i=1; AKwUvBwv2B31nfRsn5cwcOvqKkuUN1qr4aoCIRw1FPdLLqnGM2I0H5FOs3IcdTt8CteZ0rKFMg7jBTNCNLnnZuAs4QHoBGA=@vger.kernel.org
X-Gm-Message-State: AFq9FYK3z5yfga/wwYndyM84GncPsB8/pfbob6pWmW5slJjishbO3Nmm
	Wr7FVMMfDm30IIE5RMxrD7x/H6vzoYD+7pey9p0VicjMAXe5/UfM3Xwl5BinmLFmKg==
X-Gm-Gg: AYBFou3D2Cyo/8POxrnB0xjuuywdL/lfawCbqGL8bqlCmbtHzRvEvxtKY6icTTuAtXS
	7sKQ9BCPjpbmGBIK/YDZnHuN2haKlOCUf0QG/J/aLor7nWHOGTbDchx16H4dZEa0uH3+uKfyhnm
	rd481u59fL7AOWO9Am70gac/A3ASzXdDs0Trx5hl2dX5Vk1a9x7ad6JTJalpLelV1eJbn2ggI3K
	i2IQw9Uzia3a4DensNBFWsqPR344m4Pbj3XbkrEQqcPWHsWjGXffR18BVZrN6mlE4aY5+kRbazf
	il3P2x23MPean+P7szozEsEZJo8vdlJ/43eIoDGKfJMUNUSgxNcFRyhWR0UICvGI1ZTascA/M3P
	uewGrNTJ/LHJzDDriOX51OE8MhGW5x/0D/g7FloWMLoegKCfPpLH4hOL9TsYhhr+z/uwuFM7qZY
	NGm8DpVnUkdN0ck/UtTuIj18Px3GrJ3S1aG6KryN5CG1veUUf18Q9untbWDgcb59HJ+rmTfUz7I
	miLrnYi89SZK6HrF0vzUx9HslPkyKVFoB9XB3dTJG95wrxMmDqMpy2GQ9tq1DZm+Pw9fpJvQw6Y
	YLKHbexj5GnnkiFRsNr1aaNUOo2IWnHEuiZwJU3Nf8YdqcNPAGnCDlB23ANvvSw=
X-Received: by 2002:a17:90b:5787:b0:3ac:a139:1b13 with SMTP id 98e67ed59e1d1-3adeabe4318mr657663a91.29.1792803118943;
        Fri, 23 Oct 2026 17:51:58 -0700 (PDT)
Received: from jingyliang-input-linux.c.googlers.com (218.117.230.35.bc.googleusercontent.com. [35.230.117.218])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebadfeb1sm843763a91.9.2026.10.23.17.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 17:51:58 -0700 (PDT)
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Sat, 24 Oct 2026 00:51:43 +0000
Subject: [PATCH v7 09/11] HID: spi-hid: add device tree support for HID
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
Message-Id: <20261024-send-upstream-v7-9-abad13174b43@chromium.org>
References: <20261024-send-upstream-v7-0-abad13174b43@chromium.org>
In-Reply-To: <20261024-send-upstream-v7-0-abad13174b43@chromium.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792803111; l=7909;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=d3PymUtLWxe99doziaHIYJBPfLQ/rKkR0CjPyLuledA=;
 b=HYYjnGNbkyh3fZZpXhyedWvrRYvZqZYx97jmI7aJXcMi0wFN0CAIwXs8IizWJ6Wmqs12BPKIO
 Se0/gf9HIVkD0xH6JAOWiVmPARO82ZGh1vMVOLcLXknY8haBXi74hD3
X-Developer-Key: i=jingyliang@chromium.org; a=ed25519;
 pk=VTYSdqslTtYOjWWoIGgYoWupGWqNSidrggReKMgfPo4=

From: Jarrett Schultz <jaschultz@microsoft.com>

Detect SPI HID devices described in Device Tree.

Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
---
 drivers/hid/spi-hid/Kconfig      |  15 +++
 drivers/hid/spi-hid/Makefile     |   1 +
 drivers/hid/spi-hid/spi-hid-of.c | 210 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 226 insertions(+)

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
index 000000000000..d1bbdc17102e
--- /dev/null
+++ b/drivers/hid/spi-hid/spi-hid-of.c
@@ -0,0 +1,210 @@
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
+#include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
+#include <linux/types.h>
+
+#include "spi-hid.h"
+
+/* Per-compatible data: protocol parameters and timings */
+struct spi_hid_of_data {
+	struct spi_hid_conf conf;
+	u32 post_power_on_delay_ms;
+	u32 minimal_reset_delay_ms;
+};
+
+/* Config structure is filled with match data and Device Tree resources */
+struct spi_hid_of_config {
+	struct spihid_ops ops;
+
+	struct spi_hid_of_data data;
+
+	struct gpio_desc *reset_gpio;
+	struct regulator *supply;
+	bool supply_enabled;
+};
+
+static const struct spi_hid_of_data microsoft_g6_data = {
+	.conf = {
+		.input_report_header_address = 0x1000,
+		.input_report_body_address = 0x1004,
+		.output_report_address = 0x2000,
+		.read_opcode = 0x0b,
+		.write_opcode = 0x02,
+	},
+	.post_power_on_delay_ms = 10,
+	.minimal_reset_delay_ms = 100,
+};
+
+static int spi_hid_of_populate_config(struct spi_hid_of_config *conf,
+				      struct device *dev)
+{
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
+		fsleep(1000 * conf->data.post_power_on_delay_ms);
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
+	fsleep(1000 * conf->data.minimal_reset_delay_ms);
+}
+
+static int spi_hid_of_probe(struct spi_device *spi)
+{
+	struct device *dev = &spi->dev;
+	const struct spi_hid_of_data *data;
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
+	data = spi_get_device_match_data(spi);
+	if (!data)
+		return dev_err_probe(dev, -ENODEV, "No match data\n");
+
+	config->data = *data;
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
+	return spi_hid_core_probe(spi, &config->ops, &config->data.conf);
+}
+
+static const struct of_device_id spi_hid_of_match[] = {
+	{ .compatible = "microsoft,g6-touch-digitizer", .data = &microsoft_g6_data },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, spi_hid_of_match);
+
+static const struct spi_device_id spi_hid_of_id_table[] = {
+	{ .name = "g6-touch-digitizer", .driver_data = (kernel_ulong_t)&microsoft_g6_data },
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
2.56.0.257.gf7497c7d27-goog

