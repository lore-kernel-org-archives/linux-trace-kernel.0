Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAE134D3B0
	for <linux-trace-kernel@vger.kernel.org>; Thu,  2 Apr 2026 01:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775095195; cv=none; b=j4oyW+pbenUrf6jpEtigJakRVwLaY6Id9YJqwWezGYkDEMiENspkzTRCvv0WNh/EoabJWtJ/3LUXmRIPcmTKqH9LRh0Lsil1qedUprdfn4Xm2XecVjEB2al2+WrIkulhKGO2WM+wIr9X4C9rkinsXuOYsMOgqAfPveuPXCmU5ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775095195; c=relaxed/simple;
	bh=G9ErukyjtFQQONiLAGMEclYQ3lC/nZkKFqeuRk5+bII=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mLGBIO+YRMyUc/XXqZTNnerWj70KVwt0j5/UpF6e9XDjs8IgRxAAHHL9mX87v/4e1JfN/oBjVVquOU9qqpwMr1+njEJz27QzwclE/dSEmwIds2bBsKnUCVogNKEJSvgXKMvTIOynMXcl4m9XCh8cwFECzdFjUnIv+7OOYk3sBVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jpZTNAKK; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jpZTNAKK"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3590042fa8eso195434a91.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 01 Apr 2026 18:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1775095189; x=1775699989; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1HRLPCzgG72vKngIOPMMcPHhtLpKEoLGj3vPRDEvTYE=;
        b=jpZTNAKKcsuq6+jSNZvtl3J9HxWg7l4lLK/mRVHB+SY40WA9ynaQUrLU8yflp3A/lY
         yOtxjy7s6rAmPmxJFZh7JwAHwZ7YW5El83xBgHBdM4Ul9mPWbxf/A6mcRmtcGF0Ui3Ue
         zw21cVYOkx6mh5qjwy5yyHkbqscThNNrSSLNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775095189; x=1775699989;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1HRLPCzgG72vKngIOPMMcPHhtLpKEoLGj3vPRDEvTYE=;
        b=JeHV/0QiBoC6pFr71sRtLZCHD3uSu+I4V7AY1a1IVLbSX3uRyzxgrm8n1ocrIb0/Gd
         FuzQ1pAoT3R22V87OHC6xJED+lQQLb7JL0ZroRGFwZOVSqZbq8rnp1vyRjactPIoA0PL
         fE0y2+vS/Opc0MIkbBn/qWr7Kpr1owYYWa002UJBM8XVr6TQdAHY4Ic69h1xE6E/Jk5m
         in+nAfHJe0ZMPfyUbG9P38Sp7KzREa2GfVu81UDLK2wvx0yvyWcgzYulkqWKn1Jy/8vM
         3++vv6EniFSNxJogst5fibihIcfs1sz2QJyvTzfOpiF84HM0EPzbuwpKvSDCXMb0JoPL
         rRHA==
X-Forwarded-Encrypted: i=1; AJvYcCUsGo6QLCtVaY2fxxeubAndFzZTam4ebnaZcArAPRu89ei0KmJD7BP8LQt14/2TeHXT4ZupFd23pFS//nkwmeoE8Oc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7NgKqzGW1eolszRmAeSUqJEHojeCQHf55wYpNSiy48NHcXU1Q
	JSlMeqQ1BcmiN6fIgE96ZvFg6i4qRbT6IaAzHeWf38u6EHePNnmMXnV3dbIJeBKiag==
X-Gm-Gg: ATEYQzyfXs2/dP03G+baHrf2Oxc66LSTk6BJRJa0ssldxnwBQMGHQWaotmPugm2rFKz
	EM9eB9bXWBThPCuGS4KEoD0HsZgAio3WoyYcKaBgvPedeWbBCuqBPDwz19y2gnpbDVQYcmHuL9F
	fvrYuAlpVrygadtjbLlCYkOtSVJSzKbnfG2ueZwT7q7yerMnxWFWvoVMqNqtoTn6SA6cNnEeYtv
	h0WTL68Rgm5UfkXp9iob8Ilxna5Ht9JfSnMaZGeiFbYHBmewS/HZMvycO7duEFMXa6MeHCFxFDx
	iVG3VffOOvKhyfyAutU8y1s9Fvyg0jkq5J6yNUSJoKT4trOZU2ese4WTX1d+Frg5lG7oaYxCMjn
	mlmyJuP/BrXuaMlKGuYr9P+HvlLPDbNIEAVyhN12mcoKMU/hd2heoTFS6Ldpq/gSj8oeodZSRQp
	fsRInQLcsnafQ0wXys+znghz0WQr7yrYwVd/c9CMk5rR/86fzkVLhdHs1cKFumyYPhB7g8RrWCn
	mmCdUw2KUhLcHvX/syoH5/rdvo3onuKXA==
X-Received: by 2002:a17:903:22d1:b0:2ae:fc60:2650 with SMTP id d9443c01a7336-2b269c94d5dmr58282855ad.39.1775095188890;
        Wed, 01 Apr 2026 18:59:48 -0700 (PDT)
Received: from jingyliang-input-linux.c.googlers.com (111.169.168.34.bc.googleusercontent.com. [34.168.169.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27478cb4fsm11187535ad.29.2026.04.01.18.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 18:59:48 -0700 (PDT)
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Thu, 02 Apr 2026 01:59:46 +0000
Subject: [PATCH v3 09/11] dt-bindings: input: Document hid-over-spi DT
 schema
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-send-upstream-v3-9-6091c458d357@chromium.org>
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
 Dmitry Antipov <dmanti@microsoft.com>, 
 Jarrett Schultz <jaschultz@microsoft.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775095180; l=4684;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=G9ErukyjtFQQONiLAGMEclYQ3lC/nZkKFqeuRk5+bII=;
 b=ycKoinGQcCRHLiNXC/cPrBW/8Eb646sAYUjTLCBWfa8jeV0fetsq980x3F7Mj3e2GB9rJqrL3
 pMQPugikmo/CIMzn+dRTxihOXhj4JvYuFrgOkwZyMmKNE9uU1LucVvv
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
2.53.0.1185.g05d4b7b318-goog

