Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6661C374187
	for <linux-trace-kernel@vger.kernel.org>; Tue,  3 Mar 2026 06:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772518428; cv=none; b=JfE05DSG/XSt7YeXHFGfeJwi0WGcheQhJ99EN3mU8350tqZ5TKCTiIGVvO0Dq18OCPK4PjuPdKh5nSGMg1xaihaLHubyg3bb2r57+oSsYjifaUyPMz9mLRGKU8lLSj0c4e+Ya1ovxcc1pxZZuNCvjwRKYLhASWsY/W0jbsfJjeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772518428; c=relaxed/simple;
	bh=iGiE2E9+VdW+HxA91wNyKiTp5jCXwQwdWtX3DSw03NM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EZ4stefimf6orrviUGkv3vWU2mcFvvmIZGpsn7uVlJPPaOxWu0RWSnITzkhYaxGqiYlqhnOXTVP0SXdy2ne7uvbiVMld2IRASY7PVK+P8yETykMR9Sg7LgwrUoiwMNpHtrxNeN4Kwj8BtzaK6W0ynA+un/vk2WcOsK3LTjJxqnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dsYidBuD; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dsYidBuD"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2aaf43014d0so41128495ad.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 02 Mar 2026 22:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1772518427; x=1773123227; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1DNtcofGYhMKbL+3R8ic92tUvVbSv56CGHIW8l4ecF0=;
        b=dsYidBuDL35A9dJFhrsIPHTd41438Pm1f/fmZX7tw5GmXEw2mwf5u63XChsm3b3hOm
         GeIFworVxJ0BvySjDz6uZu+a556U5TRY1pHOORyWH2AkUfI5abyAu8CGBYsjdwW31RuS
         bOrHcV7nfG5P7CFWeyTpcjt7PqJbnFVbFoA20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772518427; x=1773123227;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1DNtcofGYhMKbL+3R8ic92tUvVbSv56CGHIW8l4ecF0=;
        b=s/tgSoifBrjAGw7XEivl+DC0bDnBErIyEVLhdE84doBQx1eEcbavthNwmuZ8alRNhx
         b+EUJkTZ+nWwVQ+BHY8ISxEmaOtCfXhEP0usDQYnIjCG+0spJa00xm+wOWyXDM0msBJi
         Jp92zRdbphNVd5KIsaRmr2219ze3B0zRH8RiilF8KD6bd//8K6htMj6OeW6Fhi60/Y+J
         5krLuBiiSiheiEpwz50+dG1G/xoPDm/J9FEpNVJNxKxsYzXfyBEumtjSYg1EbpNNaanF
         sTEtkr98XZzIAmAvld663kHvqS8VfFBx3homvIoqpNpzubsptXz+CMQQpOjQF8vcxVW8
         DqUw==
X-Forwarded-Encrypted: i=1; AJvYcCUeogzDsdTsl/PCKB3vbbDEXyD4ThB1Pv+51xdEd5R15Y8a0lq/ooGtIdxyWkB8cgwHlkB9FdluCkDRkGWDwb5HT1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YydQxsDNGX/85WEBS7r8/2aHhY6pWEmKlqMZUZdzjH9NziMHG85
	EjUzV82O3HkdegTOF2GxfiHjKPoBiK0Bsr1HTwIVPR5Ma+qcOEykJRyfWTZQ689ilg==
X-Gm-Gg: ATEYQzzTCYgsuuxrkoRQjjBlu26OL/04qGTmVakp2PEMuwcS0+ht1Lpl4LGwx4/71cu
	R1lRauZXtd7qZxtYDj1HbvnsMN0rcl1mQGR4cmguBAgGIs6uzz00VyBccxwFOFl1U8XwETYVKXh
	1WGoUzgcnzcwMUjrfc86D5iEsAfyuCTYwCBxCcouFUCk0oP/qjg1C/witR1oX6QUQd9KgCkhxuI
	hUX32UwhRSbrPi4wkP2/40yyLkCnum7z1DZv+Wm9/M3jxTKGGmTdiNuQeKy5qyl7OIMX+u04kyr
	knoL2SoaI/TxQ6nJBvpZ4OmmySvg44uhJJqw/rR9D8B2O+G6WQkU8O1BL0qgOatjon/U7i2JyrJ
	9SxRjAQJ767Qxw9Mf0lBfh8MtGtYwp+jfFcltKp9hT65jktMnx/OcL0sZm7Mj7jffrbh9r2Gyun
	yiKn3wg5Qa1RzHbLuJxRu/4jbeeEu4kl7AvX4oWm+9DwdXAWfBXpQS4hqcDGVIWDzIT4b74KqfA
	O4HSbkew3kbi2LXisBbVutK7XB981EaCA==
X-Received: by 2002:a17:903:2350:b0:2ae:3f72:fdc5 with SMTP id d9443c01a7336-2ae3f730132mr113772815ad.26.1772518426894;
        Mon, 02 Mar 2026 22:13:46 -0800 (PST)
Received: from jingyliang-input-linux.c.googlers.com (111.169.168.34.bc.googleusercontent.com. [34.168.169.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6fe4f3sm152639735ad.91.2026.03.02.22.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 22:13:46 -0800 (PST)
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Tue, 03 Mar 2026 06:12:54 +0000
Subject: [PATCH 02/12] HID: Add BUS_SPI support and define HID_SPI_DEVICE
 macro
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-send-upstream-v1-2-1515ba218f3d@chromium.org>
References: <20260303-send-upstream-v1-0-1515ba218f3d@chromium.org>
In-Reply-To: <20260303-send-upstream-v1-0-1515ba218f3d@chromium.org>
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
 Dmitry Antipov <dmanti@microsoft.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772518424; l=1343;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=cf+ZImr6i3mdjVcBn+wz/4JaSL42jhFPKySUJttD6b0=;
 b=YJAK3yDkHhhBB1rQeKmmk/wkmhQZiNnZ7tZkIkyoA0Fh20kDjb/Qet/ksj96xn4+enVKORB4U
 Mb/njusCz/xAUKz4lZQ/rh4zomjFu8ThVaKXJWgeW4oc1T5DedFx1a6
X-Developer-Key: i=jingyliang@chromium.org; a=ed25519;
 pk=VTYSdqslTtYOjWWoIGgYoWupGWqNSidrggReKMgfPo4=

From: Jarrett Schultz <jaschultz@microsoft.com>

If connecting a hid_device with bus field indicating BUS_SPI print out
"SPI" in the debug print.

Macro sets the bus field to BUS_SPI and uses arguments to set vendor
product fields.

Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
---
 drivers/hid/hid-core.c | 3 +++
 include/linux/hid.h    | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index a5b3a8ca2fcb..813c9c743ccd 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2316,6 +2316,9 @@ int hid_connect(struct hid_device *hdev, unsigned int connect_mask)
 	case BUS_I2C:
 		bus = "I2C";
 		break;
+	case BUS_SPI:
+		bus = "SPI";
+		break;
 	case BUS_SDW:
 		bus = "SOUNDWIRE";
 		break;
diff --git a/include/linux/hid.h b/include/linux/hid.h
index dce862cafbbd..957f322a0ebd 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -786,6 +786,8 @@ struct hid_descriptor {
 	.bus = BUS_BLUETOOTH, .vendor = (ven), .product = (prod)
 #define HID_I2C_DEVICE(ven, prod)				\
 	.bus = BUS_I2C, .vendor = (ven), .product = (prod)
+#define HID_SPI_DEVICE(ven, prod)				\
+	.bus = BUS_SPI, .vendor = (ven), .product = (prod)
 
 #define HID_REPORT_ID(rep) \
 	.report_type = (rep)

-- 
2.53.0.473.g4a7958ca14-goog

