Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC28F509F00
	for <linux-trace-kernel@vger.kernel.org>; Fri,  9 Oct 2026 22:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791584810; cv=none; b=Hfb0RnqZLDru876XAG8g9lwDZPm64jDuTXMcyVsq3rqUufzq6OWZIg6ugFNC1YLo3P8tuCCP8SXmCkYVLrQOjghWsohzWinz1sRRulji36hebfzEj7MqoiZohlrf48q7jCb+8d7nq7GHJtb4f5hv6G2NkhFhZ+62rHwz79lRKgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791584810; c=relaxed/simple;
	bh=72Nm2xPACBMza4dpmAjiF+9Mji7R6ngQlpvq8pPnER4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=clriLz5JvLnyLHBqwPl4tCqm0nmWB38ChIjPfyV3n5UiuLvWNonv7HMZzWDzl6aCHlNMk0KDweIUv1aMPyKTsT8SY3koIJfm/67tuTz0VqZUOkR9zkVGe1+LMN8NTjk81uXz5k8M+kkcqBr/BjoUBFYAkuLRz8qqY5E5DwKzujI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BtGj9MVI; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BtGj9MVI"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2dd9cbb661bso1372345ad.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 09 Oct 2026 15:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1791584805; x=1792189605; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PBu3xWQl0zj63Pw/WrczlkLjQSRA1otgNmqx45WtYLU=;
        b=BtGj9MVI65pUQpo0bBT4GquTh6PQF5U5JBMtgv79jVkAf+iQvZC2D6OJlhd19vRbRO
         FBz60UDUX0GwJqbuR+oMqwG1LEt2cZ7bNy+OlePCapySx2UpZMou2fJ4A3j3r0eWB2lb
         /T6a6y2/PZSf53ZuHjMfGIzrT+HbmTgczlhTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791584805; x=1792189605;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PBu3xWQl0zj63Pw/WrczlkLjQSRA1otgNmqx45WtYLU=;
        b=G+JFvna3im8U5vAQyRVIUnbUvdpuKOKxguHU0uELx9+EjuaMSxh4QTrI9QB3w3clhM
         UJ26GUbdlX5USc0LKJ/Q3ToUgDH5kw81TX7noDHB1t0DCNb7uf59EBJojrvB3lDRpFX6
         +AZHCue6vxYSexkvmtwotkQ+tqDNz5rn+y5PzCK1LErSKalPdlda+Y3JsCkz3qnWacXm
         8jZ1kYiQDC6aV/RniZ7ilVGJUIqkeP+ZAUq73lU3lhx1Y9Sudi3cjBFyqVzV3yjFUW3l
         2KXekQDRXbnoSooN+j4+sMWFmUGYwNcYnY/qgazRkUhqyqcy4BxWq3mS5MmfhCjdvO2Q
         o3JQ==
X-Forwarded-Encrypted: i=1; AKwUvBzwUOMonv4M+RNjNyQcelBgGRwphMEEvYe5bawZwP1SQd7x/qmcjOiYk4gHwHg5CWKURE52T3N0942qwBJZOIveusw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKXX/FT1KqvDtWJLbOyTuRJWZTMSBPD6zGelpHv+7Ho32wnTdmc
	d6AxGu7k614HZgHAc0ivCfsCA/+eEhjBPn81JF5OLFwFiDu0zBPqovGTGDY3x6G3yQ==
X-Gm-Gg: AYBFou3jFHIe+nQtzKTb7Jv+FMf1/zYzKzPOgU45jQtqTxvWY9HFdp96QwOUSLLedBj
	GnNj+W+aBflqpybkR85HUJIhPDEUo7FmgvJjIee2J8XoSifKrb69okrpLyI/rfjYhS7eKqZ797r
	5fAJj/NNv8D+hy30cB9dCK6AmcFxVfk7ubisL/dID5Hndaejbw5y5MdEiikzD86HAoXRjb8m8/9
	u6lYS69DEiRK5v/v0akscxlcHpVA2AeXLJytm9i+M8e95CZuTG0lg/uMEVGTUnY9J5Elp86bWB0
	rcxRF7kPrn2dN5AjmLRS+mw++LVEEZLb2fpspVALmwrqqh1dSkv3omozNPvunFoGSyRbHU9fiGr
	Cq8LKhquXRUgtf9Hrt23wSqYlIb5TgHXRfxN11jkqlA38OwhprKUCexHYu9eUEk871KS/DQSen9
	+nPMf6EsYyuXNn+raF+fpSC1eQoNVCAYyOgi8lt8nIS15mJ5yHW7+0Fpa6XJBgfKVd2aWpD9iMf
	tFfaXq90ywc01rLh8wCCsXH5StkSIL7siREV5oSGvh2lKzDBMHPmtzKPZxBxkV5byFmm4YJz5MC
X-Received: by 2002:a17:903:1585:b0:2dd:c100:9433 with SMTP id d9443c01a7336-2e842cd0d8dmr30724495ad.49.1791584805029;
        Fri, 09 Oct 2026 15:26:45 -0700 (PDT)
Received: from jingyliang-input-linux.c.googlers.com (35.152.82.34.bc.googleusercontent.com. [34.82.152.35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e84219e503sm16660725ad.17.2026.10.09.15.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 15:26:44 -0700 (PDT)
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Fri, 09 Oct 2026 22:25:34 +0000
Subject: [PATCH v5 09/11] dt-bindings: input: Document hid-over-spi DT
 schema
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-send-upstream-v5-9-384af01da3ee@chromium.org>
References: <20261009-send-upstream-v5-0-384af01da3ee@chromium.org>
In-Reply-To: <20261009-send-upstream-v5-0-384af01da3ee@chromium.org>
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
 Dmitry Antipov <dmanti@microsoft.com>, 
 Jarrett Schultz <jaschultz@microsoft.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791584797; l=5021;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=72Nm2xPACBMza4dpmAjiF+9Mji7R6ngQlpvq8pPnER4=;
 b=XESZK185fOwWrPZ4glwRC6/Im76uCbwmPk+s0WAzP8HshRks8rpkdjeNqdiN4VhlVHpQ/yP9Z
 cSXImZpNeakDSGJtVH0n9pQLrL2+dFpcOYiDwHaQZJIqm4gvbyyQoaP
X-Developer-Key: i=jingyliang@chromium.org; a=ed25519;
 pk=VTYSdqslTtYOjWWoIGgYoWupGWqNSidrggReKMgfPo4=

Documentation describes the required and optional properties for
implementing Device Tree for a Microsoft G6 Touch Digitizer that
supports HID over SPI Protocol 1.0 specification.

The properties are common to HID over SPI.

Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
Signed-off-by: Jarrett Schultz <jaschultz@microsoft.com>
Tested-by: Dale Whinham <daleyo@gmail.com>
Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
---
 .../devicetree/bindings/input/hid-over-spi.yaml    | 130 +++++++++++++++++++++
 1 file changed, 130 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/hid-over-spi.yaml b/Documentation/devicetree/bindings/input/hid-over-spi.yaml
new file mode 100644
index 000000000000..2a5fa0868a09
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/hid-over-spi.yaml
@@ -0,0 +1,130 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/hid-over-spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: HID over SPI Devices
+
+maintainers:
+  - Benjamin Tissoires <benjamin.tissoires@redhat.com>
+  - Jiri Kosina <jkosina@suse.cz>
+  - Jingyuan Liang <jingyliang@chromium.org>
+
+description: |+
+  HID over SPI provides support for various Human Interface Devices over the
+  SPI bus. These devices can be for example touchpads, keyboards, touch screens
+  or sensors.
+
+  The specification has been written by Microsoft and is currently available
+  here: https://www.microsoft.com/en-us/download/details.aspx?id=103325
+
+  The HID over SPI specification does not define fixed values for the
+  read/write opcodes and the input/output report addresses. The host
+  retrieves them from platform firmware (ACPI _DSM), and they differ
+  between devices. These properties provide the same values on Device
+  Tree systems, so devices that fully comply with the specification work
+  with the "hid-over-spi" fallback compatible.
+
+allOf:
+  - $ref: /schemas/input/touchscreen/touchscreen.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - microsoft,g6-touch-digitizer
+      - const: hid-over-spi
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+    description:
+      GPIO specifier for the device's reset line. The HID over SPI
+      specification requires a dedicated, host-driven, active-low reset
+      line. The line must be flagged with GPIO_ACTIVE_LOW.
+
+  vdd-supply:
+    description:
+      Regulator for the VDD supply voltage.
+
+  input-report-header-address:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 0xffffff
+    description:
+      A value to be included in the Read Approval packet, listing an address of
+      the input report header to be put on the SPI bus. This address has 24
+      bits.
+
+  input-report-body-address:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 0xffffff
+    description:
+      A value to be included in the Read Approval packet, listing an address of
+      the input report body to be put on the SPI bus. This address has 24 bits.
+
+  output-report-address:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 0xffffff
+    description:
+      A value to be included in the Output Report sent by the host, listing an
+      address where the output report on the SPI bus is to be written to. This
+      address has 24 bits.
+
+  read-opcode:
+    $ref: /schemas/types.yaml#/definitions/uint8
+    description:
+      Value to be used in Read Approval packets. 1 byte.
+
+  write-opcode:
+    $ref: /schemas/types.yaml#/definitions/uint8
+    description:
+      Value to be used in Output Report packets. 1 byte.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - reset-gpios
+  - vdd-supply
+  - input-report-header-address
+  - input-report-body-address
+  - output-report-address
+  - read-opcode
+  - write-opcode
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
+
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      hid@0 {
+        compatible = "microsoft,g6-touch-digitizer", "hid-over-spi";
+        reg = <0x0>;
+        interrupts-extended = <&gpio 42 IRQ_TYPE_EDGE_FALLING>;
+        reset-gpios = <&gpio 27 GPIO_ACTIVE_LOW>;
+        vdd-supply = <&pm8350c_l3>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&ts_d6_int_bias>;
+        input-report-header-address = <0x1000>;
+        input-report-body-address = <0x1004>;
+        output-report-address = <0x2000>;
+        read-opcode = /bits/ 8 <0x0b>;
+        write-opcode = /bits/ 8 <0x02>;
+      };
+    };

-- 
2.56.0.385.gd3acb90ef8-goog

