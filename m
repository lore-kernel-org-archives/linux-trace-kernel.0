Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792436501;
	b=JK9cVjUQMr6AvhFj/8XLvgy2ixlGkoqf77qeN74DzuDc/452KdGx+69nx1SX2coOwolD
	 Pe+N1f1FHNAB9RynizsvWoFd1NOkwOaPtZEbb8YTHV2ZYYset4oV7jx5KRxxWk0YznBs8
	 BHsZo/BV1FPZQIp91qqxjt/hLOv+3Wxc1MIb2E0goR4RlhXO+mYJX4MxOlXDe672151oX
	 tCBeKN6/p+7zwFITQ/zAu21Ysvq0rJYnb7GxLiXV9wtEp3J2XFJc+QjRSgK+54B68WF1s
	 j5U+vgxP6IcgnvdA3pXmzAUMBy7G91CWIg4o1eywwG32W1AJX71V+zbW/DUeu/nBpJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792436501;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=F0ffJvvgOrYCYreXinduE/MSyfEkUTiTaHiJcqh9oWA=;
	b=O1g2YkKSNesHFfGR5417vAWeRd0ryZ7dBlm2k72fJe+gKjgcaDATnqJ9+TIqZ9ZYIpUm
	 9DQ4V37FZ2Y8tWnI60M5ZGKHLOqudb/XoaZijVNCCmPTJ8R0FIT7k3KakKHP5BQxDen4M
	 RCz0Y1o+DFk8voneYdJ4giVOR3f2Q4e01jPuQzxbwzaZmOaN5Op8mlMRra3UVD+geqe5/
	 97CHRXA3/9bQ3lIAkk1pEotcyld5s/AQC+HZMebDipALC/YXRiTPk0Z/BFxXxwFB0tdPF
	 xg+J/FfHIgHF4JELgOWL4H1TsI30KXW8GdjkS6B3jD0+cIv5x4pZMpjRWTPJ3m4UMng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=FKnZBbDI;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B313460A3837
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Oct 2026 19:01:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B313460A3837
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=FKnZBbDI
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2e9f6a16aedso6821145ad.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Oct 2026 12:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792436500; x=1793041300; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F0ffJvvgOrYCYreXinduE/MSyfEkUTiTaHiJcqh9oWA=;
        b=FKnZBbDIYTQBI/lm+RY+U0oRYalleczJpRcFVNg7bCE7Qdwt7SyYO3WqHnsbyAaa32
         7hQkmNUlpgAif1RNEClPL6RePrsQvCrylUliDxJ9SLtq4RyICURi1qoyaumv6THWS/pe
         2q30JOR5An753EDkakfdafMgwkUS2CS7EzlXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792436500; x=1793041300;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F0ffJvvgOrYCYreXinduE/MSyfEkUTiTaHiJcqh9oWA=;
        b=ZqA9ebQhBlqjSx9U2v6GU2d67CCQNx4NrPvaII+swXWgkVXeFiuc6aex93Y29sCeCk
         9cuY6xkxAP+Wh+C5ewUHohiaAeLuFDL5HLM5GfIPkag5j1k/6yN7YuO1D3n5Qz3XCpF5
         0H0u37fevnbcmUvmdCuTnQBkntDy2Lj/ShD64gpI8GoG/XynQojX8fDMHxzGzRQbptrL
         MiLmwT59marUs98VEcf7+H50l38Oqu2fzWXwoA0VGHWZ4R4pWv2MDkSgtCRqSMuxMi0z
         klzA26KYMmWg32Bluk/KoKxPoykNvF97X9CbffQ19rgBIwu7n+p0RIZ/KNoPs8/cDKpt
         tXhQ==
X-Forwarded-Encrypted: i=1; AKwUvBwV5CwSBNAugcUpuFIADAlkNXK3ZSElQxmHbGEsUsaY+cgsN8tj2dKErtIJSwacsFbygvYxHvdDuPimr41dCdLChCI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLDDLytCbKQbWIOS2O95z2C7ZLQm0bwS75Hgkt2j6NflD4WBg59
	YwmI5O0cDb3sx3DVRstUXLZg7sJD40pl3/FN/KfaMQQjTNWsy8XnPmjMABAHZiLdug==
X-Gm-Gg: AYBFou1d9C4IGYuOxgscUdlwKRjJR/s1rkA8KUAOxA/gfaWe0BIPNDO8Hf5aZhyjXpS
	M1vyoPCIOROFqhIM/LBudd0ASswOjplomCq2RmghAF2pqyPlD0v+nu956jLvN0l63cEbkHYWkqS
	mz+T0OseBup+bUeyyXrOPLGKbo6BuoSi3dk3C94Gmbdzna/necuPRU7NXfbwl2cZBt42o83zkCf
	DJTvNXmElebiA1IYJZQD/Z3b61JeF2L+dyvJ1NlwunaThTVH/JsLE7FPiz/xQnkDMyGVHTbQO30
	JVhP5gfgKQjMMl9bJO8t2Hk7Jk22Gf/PS0VFbb9H9Wcdpg9XDW7W1lt/nJH1TH9JPk4tgxuV8iv
	/6LdwnEy08VqZjZ8l2v9ovlLBUDnfaUwDHCFez3FM5o8uLiOH7nFfBGc6L3SV/OV9ibB+r+GVyV
	4Da9NaFGoKDN0vUwKImMMqpuFLXdI7DXID1y3W1a5OsGa38yeudrcQ4kcyqMxZZC4w0qyX1v7+G
	mb9v5rUcG8uIxUGT7bWKAmV4ZW1Udgh36vLBRFNNTi68eFZ1kGzOjgV+xlBbK1DfvglBdiDl/fi
	AM6Wn/sATaZZBxR2Fa3xyxNNZz/OyahR4+0sKEwjEHpnOu4ZbGMVlKH7+eMBuV0=
X-Received: by 2002:a17:902:ea12:b0:2e5:78b1:33fc with SMTP id d9443c01a7336-2e9a705023emr80598155ad.53.1792436500085;
        Mon, 19 Oct 2026 12:01:40 -0700 (PDT)
Received: from jingyliang-input-linux.c.googlers.com (218.117.230.35.bc.googleusercontent.com. [35.230.117.218])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea151e1b7esm4473105ad.75.2026.10.19.12.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 12:01:38 -0700 (PDT)
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Mon, 19 Oct 2026 19:01:20 +0000
Subject: [PATCH v6 08/11] dt-bindings: input: Document hid-over-spi DT
 schema
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
Message-Id: <20261019-send-upstream-v6-8-cb9ba4b3d6fa@chromium.org>
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
 Dmitry Antipov <dmanti@microsoft.com>, 
 Jarrett Schultz <jaschultz@microsoft.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792436487; l=4977;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=3JV7SIx4Z2hhtNXaNrWUG27kANewD8ikLOOlV/xW+/0=;
 b=lIoWtzK94uJ2CVOcYas1knqxryWopuM6+bcWy1s2MFL43hSH7uhTVG2g2uPlgxQ4yidS0l0qV
 8EEWiL1+FpDD2WJlM4xKES4vF4ZWysNWe9oO4shLMegkzX5e2etMgEc
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
2.56.0.212.g129ede20d9-goog

