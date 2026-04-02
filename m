Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF323254B2
	for <linux-trace-kernel@vger.kernel.org>; Thu,  2 Apr 2026 01:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775095184; cv=none; b=g17ICvgTFMdnOsYF77opTxpWZVLYSQDa7luQXV7G7pXQX36F2DyZ8CQYqmt/SyC/CG5PsPZHi7DbFVgq1uYM99DUdoM7esO/GidJRKZcPUjuGVKKIWUDnwcukD0KpXDIeMho7bg7hEKYOoOMOw2DRHQrf3nLjms4OEvLVYhGC/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775095184; c=relaxed/simple;
	bh=Tpi0yK/iaLtS44lW6KsA/vacKkKe39WvD034jzj5Q1k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fr/4bFYSbF3tlq2Fc3sq/VpSKW73BeVoFMG9i79u5jtcodbB9oUwyElAQDs78K8b2JBViFgzDg6ThiA4KHkyFre6LPO2Xo4rdqjwsIUT/R6Jdk5gkfxrOT95YTs3qY6o3okp427J1IdRJN1p4oydi4K9ItvGxhMZWWdNCvoZKG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=l9wyNuW/; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l9wyNuW/"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b0ba3bfe16so11933015ad.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 01 Apr 2026 18:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1775095182; x=1775699982; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uaSym8CXCOjXII696jSRn6vHWWlOmeUfwp714NDMznM=;
        b=l9wyNuW/X8GoaB8VBjCO8tdBYvh9Vd24nXum3SRwu6fQJxDlm/CtMGE4ey/u9w4gC2
         lyhdGhqTpfrcZDtYcsz0v2C/zRcmt+KuCg3lOlEuMN+KSh1jnbq9M/JTPr89FuhnHFvP
         +ndaRXJ/LQIDNlyR1IsjvnKRHp8RLbNI1ahoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775095182; x=1775699982;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uaSym8CXCOjXII696jSRn6vHWWlOmeUfwp714NDMznM=;
        b=AQfmOOWJ3NzeBRoaszLjU397O8vBlhGPa9TchBOIinoMXx20b/Dh9eYQeXkaqBilBb
         9yl85O6Ilp/+YDtpKIwil0X4f7fxgWV5wV1PFdseducY+x/AFhXyrXI9fj7j8nF+PhDw
         5a1Ecy/+MQ+9BhuxZRqSgwIWhDOy+g26D1VCMTuGBUDgngtjA32XvqBhqSOphyTtmgk3
         G94bvM/TuQ1e4WUnd886eJrTlG7MJE/EGObVIZCH6UXuMrDZuwJ1FVUdmgj8uZ6lry2y
         ZrPdbEJ9UQIQNQAyG08Oq9VAx077gJsSoEoJODSP0F5PWaxeI+IuDG9+G2FCsFOo8Kjv
         e7SA==
X-Forwarded-Encrypted: i=1; AJvYcCXLIzziwbyqCLB0BmXiYgnu9DMSomyN+1pPolnrEBC3ZO/nxEfT/9NFc9feGZ4+8sL3z0E0f0ZjJ7pVnyVuWbvtyQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNInupld+ytqXFwLBFJZNgwxJTWufgVnMx0zqwMV1z/3bPUNfP
	owBbuQt9VlhlMxVwVDRgdG/ktktNBOh3sQSa87cvM4rkdkz92s2tIdNDVTOJlMPJ4Q==
X-Gm-Gg: ATEYQzwO+Zzp4uBBJTw3vO/y8mCiXp5iwmjOGHDWf40vzrPAHgRmkgwrtfLeTUsdngx
	GRqIkw19tYUnDBFENBul5FAgKIQgXeZdSbfHfF03mTDpHTDyGcrvBDfQIk7dXlu1a53foR57PEg
	nU0GPi9F4irk1U4ZINeO+a6VFH/5oq90iHZauQ6IEjL2K27aFqz+sAH+mqka7L1/0BL6BTSEEHN
	YRFBg9ZlLzuBsrtSpgNaCDCrY4easIvQWZw9Dft0urNgSpDlKpD03Yny5HJBOPBsCeQUcDx7Ylb
	KRy3RTtUMEiF6/TMTEVsLblrxDqmW0GQAsGA3QquNiOgIXKqaqPqI/mjPyqboeABLG9BIHJEAon
	M6I8+oSFe8e2U5kVX5NWmR18MDE3xdmRWw2sOSeSTVVxpFoB5M7rNqRmoE4Miaj0LAqkRrxcYIw
	Sqa0S9CRM2NGfbcXXTESF5gr+G2NEXgbqfZSstJqWhRHkbxUFkTwCFLVlQ0z/0KQX6I8qGkId4x
	yfLr8zd56I1fl2gFMqBR0pG34RLj+MMLQ==
X-Received: by 2002:a17:903:946:b0:2b2:5293:f415 with SMTP id d9443c01a7336-2b277d8ba21mr5711705ad.7.1775095182367;
        Wed, 01 Apr 2026 18:59:42 -0700 (PDT)
Received: from jingyliang-input-linux.c.googlers.com (111.169.168.34.bc.googleusercontent.com. [34.168.169.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27478cb4fsm11187535ad.29.2026.04.01.18.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 18:59:41 -0700 (PDT)
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Thu, 02 Apr 2026 01:59:39 +0000
Subject: [PATCH v3 02/11] HID: Add BUS_SPI support and define
 HID_SPI_DEVICE macro
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-send-upstream-v3-2-6091c458d357@chromium.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775095180; l=1402;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=FjzRhH7/ErE4TnsMI+7AvjihWBkT/xpCI98HMGNLH6s=;
 b=u4Lc+txBMvZJgNMm1YnjIU7DFBygkIoEJquBuEPB6zFCxqo5mXw0HAIQJAzTByC+gO06+zlwJ
 t0bqPyaLh0nD1I0sai05bo1y2ot0KK93bqPfmYAxaNKepG3FQdXBoLt
X-Developer-Key: i=jingyliang@chromium.org; a=ed25519;
 pk=VTYSdqslTtYOjWWoIGgYoWupGWqNSidrggReKMgfPo4=

From: Jarrett Schultz <jaschultz@microsoft.com>

If connecting a hid_device with bus field indicating BUS_SPI print out
"SPI" in the debug print.

Macro sets the bus field to BUS_SPI and uses arguments to set vendor
product fields.

Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
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
2.53.0.1185.g05d4b7b318-goog

