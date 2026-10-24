Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792803115;
	b=HVR8TLh+ylpTsUcwUOWlGb9AYD09LisrOBkSQWAbQHPu96UZEmIhIlAHmxUDYYkvX5dy
	 u0+I4LFbK/7geFp83AMGvIG8uqNOqBSoNl2/Dnn8bhU7U7BhTXmezLEJHU0bZ1hutrPn6
	 8I8L6F67hFYc1UrrWpzSbFS7wzpsdF0FQDP3TF/Ps9TI1Cn810j+5JNrWbi2KYRKVrIOW
	 9RvrPlHSPsZzIdgGRp1DVT8awp2AGeAFjJrckE/q8qKXypOjMUQ2FmD7+PIEtIPee4zQ5
	 bkooLZILbA6mtw6OhKpl6Zmteby0iCTji90knrOiNzQl2FnGr7X+HK2Y0+rS+9BPqEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792803115;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=WyQaDxrxGTsX5Oh1V8K+PKKyhp5Oq8DyrDg5XAZ9Gwc=;
	b=d44aV17cDn2MtNhNfjjN/nCobMv24QYbHN8tUlHrpbG/lXM85o1Rj1vJ6LRxvRxGnL2e
	 AM0kWrIsBTh4vqlPG3YRQ9ZvooEqurOUMlljFVdmrldqEQni98qXn5fah8byB/sQYfeRD
	 kdr8tVvXWnXuiB8Odyzuu3RJzsghjsYhcDEJyfr8ejeSBRRPcXkd0nm46iAYXG+lvwFHU
	 G50JchVGp29fSHVswUVf8B6NKyrD62uE7Rz8fAvq1uLa7VKINt1RCDdLVezoyGNsg9AQy
	 FgXPULMrqFPIwOFE7ifHCat71wMBSNlQ9iR1lG9009hLmgpI2FgAaJ7r0r6wl8WxEYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=WzTEMHkt;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9730F60A260B
	for <linux-trace-kernel@vger.kernel.org>; Sat, 24 Oct 2026 00:51:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9730F60A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=WzTEMHkt
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3acb512a7a0so773638a91.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 23 Oct 2026 17:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792803114; x=1793407914; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WyQaDxrxGTsX5Oh1V8K+PKKyhp5Oq8DyrDg5XAZ9Gwc=;
        b=WzTEMHktigzn5QU1ypgOW78Rjy6sGrSK6BNYl5UkSRi5I21k3KxC0mbXdQ9L3U5MPG
         1qwvnj+1kaPgyPlBGcAYC+oMgdtOjIPV9A1reZAArVSLkFf4cx4xo2HC1cxgiQxn5zAg
         fTWDAA4FhhNDmToS2ZLuGfAV2FT9XdBodGyG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792803114; x=1793407914;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WyQaDxrxGTsX5Oh1V8K+PKKyhp5Oq8DyrDg5XAZ9Gwc=;
        b=pU+qWM/iqIF4NPnvzCAqAXZrp2xkKOopn5rcPXWBQYa4ZBJjIiBcPodLbjmfRVshkw
         m/PoelkQc+697VGPj6+jXdroFMwkHP+4IqXgdMcgx6F/G9f3owCfKV19IJHeRI40tjeg
         Rs+eaIfUhrYX92gUIQPIYaAXXrWB5hTTRjBw7SJf24x0+WDayyuTVKdheIqqxkqN1Axb
         RClScnQrtz+bPbzcNEwrhszkrCRPSPP2huqD445wg2uIujwWHxJzFASamiP/GYQ67hj/
         lt1Y41ME8QnLf5PUckTYGvA2vy6lFUgMM0jQZcpqQCEoMBNIOIN+MB0j3aFTdoxmpl5v
         vfJQ==
X-Forwarded-Encrypted: i=1; AKwUvBze+hQ0D3JVcvmr46Lc7jtmHYOXmmkOil3hpsQhuq/UrBTHP6WyLFFs6jR9CRlLfoGnVwspAtqEZq1W3HgavK+itnM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJlke9O3jh3xDwm1N2KvIAnDC0U8H5TSDdx/80A+q2aunBy0PhW
	NerkkNJgIL0g/ys6IVS2ZUAHKR5o8xtEtvyFgiynPPTfuh2JIUnt3MlW8jNwMXHiRw==
X-Gm-Gg: AYBFou3p6GUoGUHayr5mS4WOeLvmH++MGPj1UZiMBFfWg0DyvoxX5sGeoPiKw9pHRHR
	ifaeOZbCCZtuGeJ9oRPMIW2im8ahTxiwbi+LFpAH97dthtchp+XyBw0MTh3oItLuJok3raE+gmb
	bbghu1mXqSByLDqfKadT8WGC/BgwwHg8Wp3fnEpYd6pKUSiS3K1F0gbIl42eIN02IVJp1+sRSnd
	OcUQ5Os8vNnD7y7HUzVnZVNrHnWIjsFQKuWtNzxbkdfEg033ulIPbltXY2yxV4JBhKEIXRMf9d7
	+yxCE09NNI2PE1FRGO0pc3zt+48Iz2k2/zJulyhQkycZY/6Lh5WcVeLRENVPbC8JIQCOo+mT6Gc
	nXJqUW9j6s2YUXPGARDjao2sHtmTCoWrGcHS78LgJGMIiagJ/4Nsh6AdaHB6vWrBEHQluN7KS6Q
	fTivbmbbwgcyXzNoOKNNPldTJqDcQBc2lMVXqZ6QktYfRWt0jv60NmIuwU984ZEXKA6rZQG0iES
	4kp8lNqmwCHg4J2tv3YBLdj0+5020WON0NMWSkp44HdqrRjTBJkHQYf+ylAx0HdChysYyHQpj3u
	R0janxeOzachZdAHesAJb9EdAdTi0k9yUwuiMMYBFtCJTHDRCQdT1cNStnbAA48=
X-Received: by 2002:a17:90b:564d:b0:3ac:8ee5:e00f with SMTP id 98e67ed59e1d1-3adeafb048dmr756235a91.57.1792803114041;
        Fri, 23 Oct 2026 17:51:54 -0700 (PDT)
Received: from jingyliang-input-linux.c.googlers.com (218.117.230.35.bc.googleusercontent.com. [35.230.117.218])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebadfeb1sm843763a91.9.2026.10.23.17.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 17:51:53 -0700 (PDT)
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Sat, 24 Oct 2026 00:51:37 +0000
Subject: [PATCH v7 03/11] HID: spi-hid: add transport driver skeleton for
 HID over SPI bus
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
Message-Id: <20261024-send-upstream-v7-3-abad13174b43@chromium.org>
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
 Jingyuan Liang <jingyliang@chromium.org>, Angela Czubak <acz@semihalf.com>, 
 Dmitry Antipov <dmanti@microsoft.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792803111; l=7049;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=dHd9ieI1rPWyNtZTf93ybIIIk3OGUSmw9cXrsWLZvDQ=;
 b=ipH/tV9JOZ3DbvJONxOAfdMqw9rKAu9tJrIPcOhAC2CR7qcP6xAaUKhV6h0bP3V+wJEPwD56u
 nseVQfrdrZcCIy8qrDC5nqHElhiGx8Vv+KJry6G8LiTt87kfPzbhiAw
X-Developer-Key: i=jingyliang@chromium.org; a=ed25519;
 pk=VTYSdqslTtYOjWWoIGgYoWupGWqNSidrggReKMgfPo4=

From: Angela Czubak <acz@semihalf.com>

Create spi-hid folder and add Kconfig and Makefile for spi-hid driver.
Add basic device structure, definitions, and probe/remove functions.

Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
Signed-off-by: Angela Czubak <acz@semihalf.com>
Tested-by: Dale Whinham <daleyo@gmail.com>
Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
---
 drivers/hid/Kconfig                |   2 +
 drivers/hid/Makefile               |   2 +
 drivers/hid/spi-hid/Kconfig        |  15 ++++
 drivers/hid/spi-hid/Makefile       |   9 +++
 drivers/hid/spi-hid/spi-hid-core.c | 158 +++++++++++++++++++++++++++++++++++++
 5 files changed, 186 insertions(+)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index c43e824428f0..17a42301875c 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -1527,6 +1527,8 @@ source "drivers/hid/bpf/Kconfig"
 
 source "drivers/hid/i2c-hid/Kconfig"
 
+source "drivers/hid/spi-hid/Kconfig"
+
 source "drivers/hid/intel-ish-hid/Kconfig"
 
 source "drivers/hid/amd-sfh-hid/Kconfig"
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 48a863b245ee..b5a7ef7f208f 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -177,6 +177,8 @@ obj-$(CONFIG_USB_KBD)		+= usbhid/
 
 obj-$(CONFIG_I2C_HID_CORE)	+= i2c-hid/
 
+obj-$(CONFIG_SPI_HID_CORE)	+= spi-hid/
+
 obj-$(CONFIG_INTEL_ISH_HID)	+= intel-ish-hid/
 
 obj-$(CONFIG_AMD_SFH_HID)       += amd-sfh-hid/
diff --git a/drivers/hid/spi-hid/Kconfig b/drivers/hid/spi-hid/Kconfig
new file mode 100644
index 000000000000..836fdefe8345
--- /dev/null
+++ b/drivers/hid/spi-hid/Kconfig
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Copyright (c) 2021 Microsoft Corporation
+#
+
+menuconfig SPI_HID
+	tristate "SPI HID support"
+	default y
+	depends on SPI
+
+if SPI_HID
+
+config SPI_HID_CORE
+	tristate
+endif
diff --git a/drivers/hid/spi-hid/Makefile b/drivers/hid/spi-hid/Makefile
new file mode 100644
index 000000000000..92e24cddbfc2
--- /dev/null
+++ b/drivers/hid/spi-hid/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Makefile for the SPI HID input drivers
+#
+# Copyright (c) 2021 Microsoft Corporation
+#
+
+obj-$(CONFIG_SPI_HID_CORE)	+= spi-hid.o
+spi-hid-objs 			= spi-hid-core.o
diff --git a/drivers/hid/spi-hid/spi-hid-core.c b/drivers/hid/spi-hid/spi-hid-core.c
new file mode 100644
index 000000000000..4991dc972cae
--- /dev/null
+++ b/drivers/hid/spi-hid/spi-hid-core.c
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * HID over SPI protocol implementation
+ *
+ * Copyright (c) 2021 Microsoft Corporation
+ * Copyright (c) 2026 Google LLC
+ *
+ * This code is partly based on "HID over I2C protocol implementation:
+ *
+ *  Copyright (c) 2012 Benjamin Tissoires <benjamin.tissoires@gmail.com>
+ *  Copyright (c) 2012 Ecole Nationale de l'Aviation Civile, France
+ *  Copyright (c) 2012 Red Hat, Inc
+ *
+ *  which in turn is partly based on "USB HID support for Linux":
+ *
+ *  Copyright (c) 1999 Andreas Gal
+ *  Copyright (c) 2000-2005 Vojtech Pavlik <vojtech@suse.cz>
+ *  Copyright (c) 2005 Michael Haboustak <mike-@cinci.rr.com> for Concept2, Inc
+ *  Copyright (c) 2007-2008 Oliver Neukum
+ *  Copyright (c) 2006-2010 Jiri Kosina
+ */
+
+#include <linux/device.h>
+#include <linux/hid.h>
+#include <linux/hid-over-spi.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/spi/spi.h>
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
+/* Driver context */
+struct spi_hid {
+	struct spi_device	*spi;	/* spi device. */
+	struct hid_device	*hid;	/* pointer to corresponding HID dev. */
+
+	struct spihid_ops	*ops;
+	struct spi_hid_conf	*conf;
+
+	enum hidspi_power_state power_state;
+};
+
+static const char *spi_hid_power_mode_string(enum hidspi_power_state power_state)
+{
+	switch (power_state) {
+	case HIDSPI_ON:
+		return "d0";
+	case HIDSPI_SLEEP:
+		return "d2";
+	case HIDSPI_OFF:
+		return "d3";
+	default:
+		return "unknown";
+	}
+}
+
+static irqreturn_t spi_hid_dev_irq(int irq, void *_shid)
+{
+	return IRQ_HANDLED;
+}
+
+int spi_hid_core_probe(struct spi_device *spi, struct spihid_ops *ops,
+		       struct spi_hid_conf *conf)
+{
+	struct device *dev = &spi->dev;
+	struct spi_hid *shid;
+	int error;
+
+	if (spi->irq <= 0)
+		return dev_err_probe(dev, spi->irq ?: -EINVAL, "Missing IRQ\n");
+
+	shid = devm_kzalloc(dev, sizeof(*shid), GFP_KERNEL);
+	if (!shid)
+		return -ENOMEM;
+
+	shid->spi = spi;
+	shid->power_state = HIDSPI_ON;
+	shid->ops = ops;
+	shid->conf = conf;
+
+	spi_set_drvdata(spi, shid);
+
+	/*
+	 * At the end of probe we initialize the device:
+	 *   0) assert reset, bias the interrupt line
+	 *   1) sleep minimal reset delay
+	 *   2) request IRQ
+	 *   3) power up the device
+	 *   4) deassert reset (high)
+	 * After this we expect an IRQ with a reset response.
+	 */
+
+	shid->ops->assert_reset(shid->ops);
+
+	shid->ops->sleep_minimal_reset_delay(shid->ops);
+
+	error = devm_request_threaded_irq(dev, spi->irq, NULL, spi_hid_dev_irq,
+					  IRQF_ONESHOT, dev_name(&spi->dev), shid);
+	if (error) {
+		dev_err(dev, "%s: unable to request threaded IRQ\n", __func__);
+		return error;
+	}
+
+	error = shid->ops->power_up(shid->ops);
+	if (error) {
+		dev_err(dev, "%s: could not power up: %d\n", __func__, error);
+		return error;
+	}
+
+	shid->ops->deassert_reset(shid->ops);
+
+	dev_dbg(dev, "%s: d3 -> %s\n", __func__,
+		spi_hid_power_mode_string(shid->power_state));
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(spi_hid_core_probe);
+
+void spi_hid_core_remove(struct spi_device *spi)
+{
+	struct spi_hid *shid = spi_get_drvdata(spi);
+	struct device *dev = &spi->dev;
+	int error;
+
+	shid->ops->assert_reset(shid->ops);
+	error = shid->ops->power_down(shid->ops);
+	if (error)
+		dev_err(dev, "failed to disable regulator: %d\n", error);
+}
+EXPORT_SYMBOL_GPL(spi_hid_core_remove);
+
+MODULE_DESCRIPTION("HID over SPI transport driver");
+MODULE_AUTHOR("Dmitry Antipov <dmanti@microsoft.com>");
+MODULE_LICENSE("GPL");

-- 
2.56.0.257.gf7497c7d27-goog

