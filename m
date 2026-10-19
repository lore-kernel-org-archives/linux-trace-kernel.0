Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792436493;
	b=FHvk0qpokBTVq70/khGhuBjfOS8mvvM9gAPaazu948xlYOaNrZCgJ/MR+PqxvkHD5eio
	 HSh8ez4sD8Q9YyFW/8xP+GtshK/fnZjnEMEi+kP9hVmig6zRaOgrt7Zt5b5UfH8ZlaY1N
	 grNWgUZcFKxqK4x17DL3ngEoSec6Q1wtF9B1SNYFNXS0Y7ty+dcWBtif84gfiAK8gJuj4
	 PaZq9eyjpmdTFQmvKWMVADmfXsyJ6Dmg8CqcZFqQX/MaSwtKILwxkV739VOjxdomVul2e
	 ytVffQJIdwKzqgdwqRLdDx7XicoKdt0rOWeMkTAv1OL7ycfwTpqh7VwGcrpisfUEmDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792436493;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=FaY9xBH+ODoyMqXQ5rD2hltdyGJo1APi4ZaZtmkclWE=;
	b=e4Hn6oYCnFR22cYUSSZowlfUaTqmRt6rv/Up9e9Nh+0CPpm57telsBT5DhoMCirOb7Uz
	 tt6F/1k7Vx8V1JKNNm15Jd8ob33Acr5HFPgCOlDrkQ4Ak0SEjF6Vx5SwXSvMjzvqqB35u
	 FsoVz+6K5hJG/YxfS0ufaf8CyW54JFr8Oj5sLhwRJ2snuJ4ixAOWL/xrvqKIp8rSPxfZu
	 VxFyC6R18PB1nrhiSuDUd107g+snkEB2+JjJaHcpkdAC85wxwd7wEh0LrDU/2sZyuqtrY
	 AYhNs4jifWPthL3RKWjP30BI77IpLyYQr9d6K3kJIp+Vy9ZnMDGh4QuyE6zr3KD4DiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=BQq+KE8x;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6912F606A339
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Oct 2026 19:01:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6912F606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=BQq+KE8x
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e946155442so19769925ad.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Oct 2026 12:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792436493; x=1793041293; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FaY9xBH+ODoyMqXQ5rD2hltdyGJo1APi4ZaZtmkclWE=;
        b=BQq+KE8xOXbY/uqMBJRUuuiRWixMIYgasL2Q6oCe08KuYbbGLBcRh24ixnfWFYSdS+
         dCiH4G1K7vTp7FQiasyc/3m9GP5veIG+hi/bMw6XJT9kgi/wSJmKm372tZ0JKJdfCLaH
         7FoNQeI1qbJzVaYfIhpmC+tqgs9LZRyoUr7go=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792436493; x=1793041293;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FaY9xBH+ODoyMqXQ5rD2hltdyGJo1APi4ZaZtmkclWE=;
        b=nRXg29sJQCrffPqToVHJdB6sevwTiVG5er4rWeIVmBrAfUlBlh3TIPqU/3824irJKK
         1K/Db5XNcqgr0coPzWuMkEHwCfo8CMsMeZ68AsoOgtULEZV9urtgHo17XErqUYR9tore
         eSUVlPVASlag6qRQmtuFqzHEXwmdec1+aoSc9VhlkEUtIxbHSE/HljuvUJOPTk19vf8+
         Hs1SZav6AixSNwZB5k3xPrcp0hZv99yHBdFl2Wh+SMmfJweu29LJxr+5SNnOsLz7VG6n
         n48N6835saHYPs1xJFLw268sGluNKOMbTv0Heke+oRNWxkRxtV2Jkbj3mnfAL5BEZwlO
         H/QA==
X-Forwarded-Encrypted: i=1; AKwUvBwlq5h+534bS/V2HhD0+Wo4xRGrt/PKJ61oaLl5x3Oa/wj86Sh8TF4W579Y3hhjt5HKQ4B31AWKxCapwBK1zz7L67c=@vger.kernel.org
X-Gm-Message-State: AFq9FYIY/HanfM/CLwhoHUF8dKsOwyiU9Wm0bIOyezNRD9zEswUa5UR0
	Eh0DZgCeDpM8LBlabjM3zLoqj55xZKMHtYYWDP+5CHccEJOlfO4mTzc6Tre6HGt+Wg==
X-Gm-Gg: AYBFou2WLvJ8n2VJTVED2Yw1vK0wMNIW32Gk1CGBOy5y/LNffrxJLjCp4Ye+IsnOmWB
	sgxtlNtQmzmZrbOXL9aj+5LJhsx/QJ3Hf88YCpQT6WyTKFKSNX4bhpRJS5iRYuVQ8XdDzykVOJT
	MWUNQq9eiczrPWb6aKuFWphDLC2l8p57zrxnlqksQViAyp8mmW9SC04hz9/IcCG3sk1Ca9gCNFi
	mMkoujkwwjGBOeDsKoR74+1OHfFfbWZp3tNqPFy3RscgRec+tOs2DggfhU+DJcUmQ6FPavLwIjP
	0QK3C27UdJYTnLeVtgxneSq8C+K7S0/MscEsI/4ot0vH8YWeaSv1hV5qFKFfuWLVZqdDKu4hbd5
	IY8OcdcbvhbCh0Deiv1C5ndWAK4TU+K0ZztOz/2OnEuEMtp79J+YPElIh/4fS4WKD7OIGPnw6AD
	3SPspJ9t0RbQcE6g2ptJhGTXN9TLXb8u8gJ86nBO1m4RO9g10SHgFJOIFeyUmjdd9HMEJNRO6Ye
	yYag55RCHLkn6ACfEbbB0GgsdvuUHiZQS0nslFMGbbNjloDnhsTq1f/ysuxpr+eRWUbPlBlt6et
	Apts1w==
X-Received: by 2002:a17:903:283:b0:2df:90d4:1193 with SMTP id d9443c01a7336-2e9a704f530mr82162035ad.45.1792436491907;
        Mon, 19 Oct 2026 12:01:31 -0700 (PDT)
Received: from jingyliang-input-linux.c.googlers.com (218.117.230.35.bc.googleusercontent.com. [35.230.117.218])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea151e1b7esm4473105ad.75.2026.10.19.12.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 12:01:31 -0700 (PDT)
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Mon, 19 Oct 2026 19:01:14 +0000
Subject: [PATCH v6 02/11] HID: Add BUS_SPI support and define
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
Message-Id: <20261019-send-upstream-v6-2-cb9ba4b3d6fa@chromium.org>
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
 Jarrett Schultz <jaschultz@microsoft.com>, 
 Dmitry Antipov <dmanti@microsoft.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792436487; l=1445;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=Z/2OynYTrncR3whlCD+8cLrRCycyd9G1cnZSFD18TV4=;
 b=lJc8V8Nqjo1jioaiCACjgd6Onu1pi3IF5K3H7O9O0Ysv6de+/D34pDGq9QMvDw8mebB528I80
 2kaE6ZZjzlGBGFbwmdNzil47p34PVsQJh7RrChGNGuNtij++kwe8mZX
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
2.56.0.212.g129ede20d9-goog

