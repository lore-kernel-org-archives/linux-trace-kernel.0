Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205303C5556
	for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Mar 2026 06:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774334410; cv=none; b=Z/plEGvxVvvH7cA19pI9xTzku1I5o+VWoaY/xXfVKxJXfO7UlzaR6g+iB4mWp05ItW9oGf70uRnAAFyvjXwtka1Jd9cl0h0zObs3Y21RYZc9QRI4/84pJBSaSfAiDwvsNo9ynALXpaNKCuMXssQNBS26KWXyl+Fe9T/cky9Cv9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774334410; c=relaxed/simple;
	bh=qznTTsH95JMiWz2KpE1aJItnwW6ycamhHq8hzhCMPB8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GlbLLxtQhr1h7m5nVV5IH4JVljY+0TN5uKwd9gB2Eic9K2GSFlBGd05jFMBY2JYxPjAqlTtjsj8W748E98jqn1Uz69pCT71KI33TlljMOB5mgLYVfrt5m8mrLgxxXP5SMWLnSk3exgaF136aiFUcqoNfIiY2kXiIgZXAHLidYq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=f9aYIaU5; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f9aYIaU5"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c6e2355739dso366136a12.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Mar 2026 23:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1774334404; x=1774939204; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ws1XJhm562F8Eqr4Gpp6hR2Els0noubs7wtAB+jE3IQ=;
        b=f9aYIaU5D8+n175pz0sVt1dDRcFNP3LrPfin9laH7FEGhusp3Jum5kWNRAryiFQSA2
         ASiCLsCmAb7iuq404pHLcbvo4pcOuGVJJFXChFM8+VOONN16R6/8feAvlAiqj1d/doT3
         q2K3lltJ27gylknDg9m+qxUjhX10d7KONwdtQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774334404; x=1774939204;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ws1XJhm562F8Eqr4Gpp6hR2Els0noubs7wtAB+jE3IQ=;
        b=DWDrH5YRbDxM6T9iHdX9uz39rQs+/nKYG16EoxUO99Rm0wXi89n6N/baeeCFlAc/Jp
         JJhERkkfrWWe/prZHtl7er+58tlOhPO9ILHRi/r4Ab46LNYV6fhOs7sCehvX0e6JfJWM
         b7Q1EeTyy0kFIwjTXQGRYIzVnbGUHcCSLy/U/pZ39xX1nsmTu3imb0yLQtk+9AAswrHB
         6UQWyPhPs24ueD572wXImo3GhWACWj8jShYDe4KyB0U0HvR3HsgVAXPYWNZ7bZrbSnri
         CqtEffAKlaqokRvtg1tyaUr6VGe7LurUeGaFOqHPUcnXlW3beMK6EktaYkkzUqdnFnBf
         OlSA==
X-Forwarded-Encrypted: i=1; AJvYcCXGnUy6scH7yLKJ7Kqut28EtsLbI82XtOECL3I+JDHO8ZbglPJ4B+LQrE0Ywt9g+DWhi+Xcy3IHDSkeZzjWR9QMPpk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ0uPRehI0rD07cD7lvZKYZtYbo2yoidwmOslUXy82+2NBmV7B
	epYwUJZ5esgX2HRQAMn7OIoi0+wLgi3zKw/LyJclYC0nYftfM/HIF9xj44rv9lBrHg==
X-Gm-Gg: ATEYQzzeUKpk5Qx8SZ5LB+rGshiO6rwbxfawoFQ/p8JyBsZ06obWqygzAjlwcqw6gqg
	awxML9UB5Rghp6I/2aNDX4z/XzZpmVxZNKvt4baxROLoLsDJ2qe59B3uZ2TtYwHuqDfZIQRY0mn
	dufMzTsi3LhNqU/OpMJN6LTOy+kW15iJ3PQWQMLYRiJZo/sOLnzAwwRWh2OejdTQvVSQ50O2sFE
	feFV1yepnJPLPvaYs6q+/G2BOwDNvpCfP/qqFWnms9MuEGxPrIiao5+kX+au6BnXrtR8RhoBufa
	RtjRs/r2QEoNtAo5IpHtCF5rEZEbsPcTugY07krB9QY/91G+uouuPm9Zmis5KBbV9NnjxyPrWtB
	+CmdjWK+vqdAe0UbMrCcVrLxugh0zKbucQ8D/TxrZJeprwrpx+O6SRIxY2wyiiWiVH/DKepRlHN
	Pe3aiuZWCTpdP2Snj9gBvgm42VzziUAJDvMe44ZBs9J6pPAi3b7dR+gVb2X4VrwueQwqBG8xFlJ
	3QbZ8+X3PvV2PeWQT/2oPZNZxD4oFekBw==
X-Received: by 2002:a17:903:94e:b0:2ae:826f:2c50 with SMTP id d9443c01a7336-2b0826e2f0emr127644455ad.12.1774334403691;
        Mon, 23 Mar 2026 23:40:03 -0700 (PDT)
Received: from jingyliang-input-linux.c.googlers.com (111.169.168.34.bc.googleusercontent.com. [34.168.169.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0835429afsm128416545ad.26.2026.03.23.23.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 23:40:02 -0700 (PDT)
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Tue, 24 Mar 2026 06:39:35 +0000
Subject: [PATCH v2 02/11] HID: Add BUS_SPI support and define
 HID_SPI_DEVICE macro
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-send-upstream-v2-2-521ce8afff86@chromium.org>
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
 Jarrett Schultz <jaschultz@microsoft.com>, 
 Dmitry Antipov <dmanti@microsoft.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774334401; l=1401;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=uFPHOo5tVahmnQsO+3HulhbmLaF0uQlDRKXTc/zQ45Y=;
 b=FzRz6hRBlzD7ymlf0UgsS6IIaaR2bkVOGVToLSaLqiBXlBFUdjUt7+8GdOcAKeSszYW95MDk7
 /3ijkLg5nuzBKxgO95bX3yQFQEwML0ujPgq48j85CrKspcQ4tbxqT5x
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
2.53.0.983.g0bb29b3bc5-goog

