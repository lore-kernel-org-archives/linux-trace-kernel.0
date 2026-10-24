Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792803114;
	b=aH1wH5kB5RWT4WQbn0SQsu1Bpw4QxRVrdprY0P6dfY8yx3olJI2JEDK3TtRO9ItjD+Zb
	 du/XHuznt6ikmnDWJj8iH1Yg9n4Z0ypy5TBVcefsXsNDV9NV2FSPb4YZorgZK0g/EAZ8I
	 zl7aE2YD3QBKQj2PynNj33b8/AYySEMjOvEmFAZaAgFeTX4L7Z/MHcCfeK/A+Wsgrjqk/
	 7uTGWLpKERh0kyuhAEtSmvwsrZnrshj3zQw+uTautxV0g6HnzvTPkflv9HBYvNTw4ontL
	 FXL4w0U35rjaEcSwYXETZM6QUtuLUIjBJ+FFqN3VXRWUz8WY4ILX15j86DIb/3aWWFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792803114;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=GjJvgQskeA2INOh9xphriRJk4nj64aXRXGnAbm8qNwo=;
	b=lBuwwOqNB5e6pOnL0orXDGVsO+sOV/8YLwCPGdri4bYEmmMKK7TNz60+W84bu4kV8dDV
	 M+Q8xAEjnMKgB33hGDYdQ5szECiZ57fedtU7ubZHV+zYtDHZLpi8ZPdsHMrmmEaDC8lOx
	 9AuogmSW5ujtGwi0t0/v/bwvxcaVFBUnvtdY3dPa+bnVuql8SPN821k/s4sW7igH8is4p
	 0wgO3YxCpuk7URjc0ZZOEsmflNu76e0B5vLlPf/VV5P/JOT7aydKgk9IajIGsBIxcJ9it
	 4s/G8/8zCyHHQZ14cDzYjMQGOdJKkqDzl7oYEp1VoI9GFilTnepXcAsRvqkZ6pVQdRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=F71mQzNN;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13FC606A332
	for <linux-trace-kernel@vger.kernel.org>; Sat, 24 Oct 2026 00:51:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A13FC606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=F71mQzNN
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2e9f6a16aedso8887475ad.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 23 Oct 2026 17:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792803113; x=1793407913; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GjJvgQskeA2INOh9xphriRJk4nj64aXRXGnAbm8qNwo=;
        b=F71mQzNN9Df6I/It3i/2orNrHXqbcP1PQC4xWxfUZUv03/GeKMX0+yP6pW/QSoi4Ii
         ptvSZ1Z31lTqIvQT+c2UUZ4XLuqeRYPIgHONPoesz2XCjoScHRojFWbuVAMtryozroII
         lptbybUDhb+BfNrIIQ8CLpLhFa5OgZPmiEOrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792803113; x=1793407913;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GjJvgQskeA2INOh9xphriRJk4nj64aXRXGnAbm8qNwo=;
        b=nGO1B0ej2NL7FV+zcTXwcnN2oc0I6vndg3nQTHTJbTOFwyrZ05Xi26aZNRxTB+lQah
         dgqWAnkHWpQD+Hu5T+AvqbSSO13jlhkQiWXJ2fx8X3Hd7WlqXRsuPn005SzbhnoaR5UD
         lQ/+VQituQ9SDt/6o4e6vaYeTmPm6cYSxrehj1Jl2ajytYepwa0QsyHHuS5QiRelS16W
         zTgBT5CkrIYByWJ2RWIhY6oGIu2B3hH3qiMGRgt6LANcsDgv1ZcM2Pmm1bGXGKRHqiF4
         sEkM0HDyfkmXzymmypnJZPsZZdsX8whjOAzntlKsWM1B92F4RHrUKenuS7OjGJAq+TJQ
         1bgg==
X-Forwarded-Encrypted: i=1; AKwUvBzIps9oXuVZgIGQL/0vbSuNdtpTNi5Zqnksb21SIHxCN/bhLMNXPMMvIgyvegK+M3Ca9OfSfVZdAICy6VOQpGNPiPs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJSZbmo4ne5UCzfVHF72c94k5c04A0eliTDryYxf6yv8JRv16ey
	7142RW3tpgCY561jkeqnZRKHUckpP0GDDI2cMO6qXiryrReT2CNBeblEVLOjvCphtA==
X-Gm-Gg: AYBFou3SSQvzjcn9k+MGrQzsgp4xx2f74kqHBXRoldlWFjAN1wRbwQaPylTnIZ78h1k
	peZx4Z1r45mwQ3/xMk1Hgwwn0AOR0//uBMRUEzw6ECyBEv9vF3gNPnTyZqPGP41rR5lLBY7vtd9
	CE534HbqCOACh5+ntbIQESK6E6f/gCl1/uBn14l19nGZHeeKpDbNhLKPhqD2QHZeI9Y6sR1kaY9
	WLHVweoFgLTlcaakA3LFWc8AqFS8r0RMSfrhMvsXKxlQIMQImHf7ei2hEZnu8j10yaHAYXKKX1Q
	tfiW2Wiwwfc1rMz80HaWBsaOyc2RdSSVUVcz2oDvbCGjhsuNRveuJSKgAs/nNbkwJ53CE0IbjCG
	Rfx5MzyRzaCCfKfqdS/GDlSIh/rDpO+vWboXUdyfghIhPSQ3UWAkam4oJSjG1hj+XGNnBuIHm04
	LrQehbr+RDYezuCQfUn9hRnuhO40ZdXR5AA1FJHzxV33w17Mv/nIEkoiZxKuNEnT1yoM9dB81gH
	JdRTNV8lPKxYodDGrW6qdVCcgw1L5+6avNd0Hg9K3wrjb3v/gr8LCDNLgpnK9M70auD9wWgtkkv
	+s+PnSP9d5W0CFjtGHn9O1zX3NcM9zKRlnU69C0cWbcQkAWbziLh04kjMqFIdAoWMLUChT+07HG
	9i6SkQR7M
X-Received: by 2002:a17:90b:3b45:b0:3a8:7096:9b48 with SMTP id 98e67ed59e1d1-3ade9b2cff5mr812341a91.1.1792803113127;
        Fri, 23 Oct 2026 17:51:53 -0700 (PDT)
Received: from jingyliang-input-linux.c.googlers.com (218.117.230.35.bc.googleusercontent.com. [35.230.117.218])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebadfeb1sm843763a91.9.2026.10.23.17.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 17:51:52 -0700 (PDT)
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Sat, 24 Oct 2026 00:51:36 +0000
Subject: [PATCH v7 02/11] HID: Add BUS_SPI support and define
 HID_SPI_DEVICE macro
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
Message-Id: <20261024-send-upstream-v7-2-abad13174b43@chromium.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792803111; l=1445;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=yw607yxfhlGqzMQvUei0spNkHE3rjdhJJTsFkZ74pk4=;
 b=KYERMVr2ZOi6iWqsiLz616NCWFhyAhngzW+obBzlRREHTXw7r+si9gzT5hauuQa2QoLoisRF4
 r+kaho6ZY6bB466JTmNpULLdgLk/5/3ojuz9VXHF+5kjPJhrFfcp5yo
X-Developer-Key: i=jingyliang@chromium.org; a=ed25519;
 pk=VTYSdqslTtYOjWWoIGgYoWupGWqNSidrggReKMgfPo4=

From: Jarrett Schultz <jaschultz@microsoft.com>

If connecting a hid_device with bus field indicating BUS_SPI print out
"SPI" in the debug print.

Macro sets the bus field to BUS_SPI and uses arguments to set vendor
product fields.

Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Tested-by: Dale Whinham <daleyo@gmail.com>
Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
---
 drivers/hid/hid-core.c | 3 +++
 include/linux/hid.h    | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index a3ff0514f9cd..1b9dbb7515ad 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2373,6 +2373,9 @@ int hid_connect(struct hid_device *hdev, unsigned int connect_mask)
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
index 8d17b741638c..45f713fe9982 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -821,6 +821,8 @@ struct hid_descriptor {
 	.bus = BUS_BLUETOOTH, .vendor = (ven), .product = (prod)
 #define HID_I2C_DEVICE(ven, prod)				\
 	.bus = BUS_I2C, .vendor = (ven), .product = (prod)
+#define HID_SPI_DEVICE(ven, prod)				\
+	.bus = BUS_SPI, .vendor = (ven), .product = (prod)
 
 #define HID_REPORT_ID(rep) \
 	.report_type = (rep)

-- 
2.56.0.257.gf7497c7d27-goog

