Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB413C7E10
	for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Mar 2026 06:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774334421; cv=none; b=TPGlxMyNletmZL/inZYApWt6eHGWST/gp4Fuf1uPsD32EkcuiwqX216OswfFqAq4adk0rXgmGhy6sRZcf1rcdf5E9ej00Ic71oPnnbf4oJR7uFoIVisBvkb0iOesCN35ci4tghBpX04CWNJ+jMLe/jtN9IGyfC5EwJPKFy2rOZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774334421; c=relaxed/simple;
	bh=I0x2CYlsya/0TkxpZg4isJbbaEKJvgNnG/ZcBXcqYso=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dDNtB6nHl1gGjrDLdtBW+yhp0MBpSnSnRk7HkvjEppafU6C9gXZObvJ7q1xyySP0kia2Am4wyyjfB3/pMS7w3IzlFKd8zPsqDRd5H1jh2ZPTkjACyaOhjIJ01wpCaWJDpWKTytq6WfoiYMBzcICHBuM8m3mav5uWd67PLRuR6bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JPe6YGcf; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JPe6YGcf"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2b0586d5bb8so35943395ad.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Mar 2026 23:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1774334411; x=1774939211; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vmfN5FmsExdbcn4DHUdyn65cCMHIcyMfjFNYjbqU8ZE=;
        b=JPe6YGcfmma5p1cUw0WFcKwlKmvj8pYDCH9sodtY7xVmMA3Oqh8rBuk6Rfoe9cvwCC
         LAxHmZapOrOX67nhBrj77UOb/QWaGDsjjiBsoH3pmgsrP/0bp++l+eB2E+5DjmuJkvPl
         Tv9KT33Fo1kmQ+s9AHnqrONUAcQjAYRnKfT0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774334411; x=1774939211;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vmfN5FmsExdbcn4DHUdyn65cCMHIcyMfjFNYjbqU8ZE=;
        b=FQBnGQiqdCaJb+DYiaBboRgkaULkdVeqGq1GxzAg1l2a+Pcb+7yO2D9c0HJ7gbh8+v
         vpRRKwxmliTyAMZriZZkN2q1Dsd72X1Y6pnu8K2tb5h30SyV/MovO7hQJlfRSZG77+5F
         tkrAxo42tm5UkOBZGzGvWipw+o00LR3rzMFcxGimW4dKHriscPg8knEwicau6SsEsCIq
         t+K2wbasr/7Q52ufuVBTjECgtCgNpzcIE28XMkRJNZoq+TU6yLL5Lh5xDWSGRii0s9NB
         hYZMhbjbQyzsCRruNco67hw2BDl+OCesOQi7FVUfomYv5SrjQiQ9ymtHJDxCLczZExFs
         Ivmg==
X-Forwarded-Encrypted: i=1; AJvYcCX7JTu9E3xEVZOE3BsmeLn9xj1v2l2pXc2pGmJyeHqtKduIAgcaY8FsNzghpjggM+SPsCJJn0kQvr969BN4oZtGJxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFYngrjIl6U24nU2X3wcfMQFv8klT064m2DMthbr9YOqjA0ta6
	Bed5Nkeoai4xYS2tmXipkon7BPfkbGSHv0uXiFOA7g38RAVKsvFexKn2CQmmJEkUqQ==
X-Gm-Gg: ATEYQzyn3lBks1MUW1xQSsIWgCmXg1VXeyGvxeEa0NOu4roNlPlWb2o+FxILrYUep5R
	xW42Q7rSZ0o0m1oYOhpILigIuDSJgJtrfvYYI4WvlyDXD+ytCbFMFabJ5alJQVfpnayN0aw4Xwj
	1lc/gWtJQM2N4aYi7GeH7Ebw3n0hwIFbQyidMyZS0WeHoFJK5q2pOgX9FmdoQvkk0yrLkcGGVB5
	7DBEz+Eylz9+tvklV2tzz8CtM9UC0EVYVKlFXCP6dxTtIo/NlG6dtdxVJmDgOskEAFd2dgQvfzc
	jnh0OghoAbaszF+Myg9UFSz3M5RsckWv55WC4lK32GgSF8rKH+SgVCsdAg2aGLTd4ytq1KYBHny
	WsWrQSMvjnSfvu3LKY0AVytwwPfnRar6m03bgdV4tU/VAmjPDILcn38+eaRjXSTGSFgqCC2bJp5
	DB5B8TxlwuHEDe6WzXKr0a6xiX+yW4Rxl9KbswaZYmgpVWiN5bZ/3nvqOpnBKRDyDlHKu3kpxJo
	vt+Dab1pJVK2iBX4WHEIzQI1vUxOrCGp1C39iOKYwj9
X-Received: by 2002:a17:902:f651:b0:2b0:4d7d:fbc8 with SMTP id d9443c01a7336-2b0825e0b04mr139394415ad.0.1774334410624;
        Mon, 23 Mar 2026 23:40:10 -0700 (PDT)
Received: from jingyliang-input-linux.c.googlers.com (111.169.168.34.bc.googleusercontent.com. [34.168.169.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0835429afsm128416545ad.26.2026.03.23.23.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 23:40:10 -0700 (PDT)
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Tue, 24 Mar 2026 06:39:42 +0000
Subject: [PATCH v2 09/11] dt-bindings: input: Document hid-over-spi DT
 schema
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-send-upstream-v2-9-521ce8afff86@chromium.org>
References: <20260324-send-upstream-v2-0-521ce8afff86@chromium.org>
In-Reply-To: <20260324-send-upstream-v2-0-521ce8afff86@chromium.org>
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
 Dmitry Antipov <dmanti@microsoft.com>, 
 Jarrett Schultz <jaschultz@microsoft.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774334401; l=4683;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=I0x2CYlsya/0TkxpZg4isJbbaEKJvgNnG/ZcBXcqYso=;
 b=Wd4UHeJCa7yzoQMx8kpcrdTRh9ZPmUZ2TgcHdNkjZOoJrOu56ULT4r/WjLCmtbtGg/Lffo9HD
 mwgl9wmJhmvBIaFZfYBBF7eQ+TVVS8ocx+e4UQRW6+Wvcw0ow6HtA8N
X-Developer-Key: i=jingyliang@chromium.org; a=ed25519;
 pk=VTYSdqslTtYOjWWoIGgYoWupGWqNSidrggReKMgfPo4=

Documentation describes the required and optional properties for
implementing Device Tree for a Microsoft G6 Touch Digitizer that
supports HID over SPI Protocol 1.0 specification.

The properties are common to HID over SPI.

Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
Signed-off-by: Jarrett Schultz <jaschultz@microsoft.com>
Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
---
 .../devicetree/bindings/input/hid-over-spi.yaml    | 126 +++++++++++++++++++++
 1 file changed, 126 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/hid-over-spi.yaml b/Documentation/devicetree/bindings/input/hid-over-spi.yaml
new file mode 100644
index 000000000000..d1b0a2e26c32
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/hid-over-spi.yaml
@@ -0,0 +1,126 @@
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
+
+description: |+
+  HID over SPI provides support for various Human Interface Devices over the
+  SPI bus. These devices can be for example touchpads, keyboards, touch screens
+  or sensors.
+
+  The specification has been written by Microsoft and is currently available
+  here: https://www.microsoft.com/en-us/download/details.aspx?id=103325
+
+  If this binding is used, the kernel module spi-hid will handle the
+  communication with the device and the generic hid core layer will handle the
+  protocol.
+
+allOf:
+  - $ref: /schemas/input/touchscreen/touchscreen.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - microsoft,g6-touch-digitizer
+          - const: hid-over-spi
+      - description: Just "hid-over-spi" alone is allowed, but not recommended.
+        const: hid-over-spi
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
+      GPIO specifier for the digitizer's reset pin (active low). The line must
+      be flagged with GPIO_ACTIVE_LOW.
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
+      Value to be used in Write Approval packets. 1 byte.
+
+required:
+  - compatible
+  - interrupts
+  - reset-gpios
+  - vdd-supply
+  - input-report-header-address
+  - input-report-body-address
+  - output-report-address
+  - read-opcode
+  - write-opcode
+
+additionalProperties: false
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
2.53.0.983.g0bb29b3bc5-goog

