Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B411E635;
	Sun,  8 Jun 2025 10:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749379505; cv=none; b=ab2Qopijw8bJcOF0qLnK6TxUAex7Fm6QKBIUF/F99pdye2IgvpwDx0Ab21j/Z28h9vs8S5ty+3JUAK3HkUW7YBAgrJylTyKhkyWITC4wjf9Aqo5SPK2pLWEFw8E40NUaaIWeqKGU99iHMTm82FCkx45+TjVIvyYUHPq9YQcrbk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749379505; c=relaxed/simple;
	bh=XqdKlSyA1x3wAP2oaLII0/8MRAREl75HnHHUM2ZEPhk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o6vgMGqxI6/AATJQ9OnAKGVOTa4JSxAGjT/IDbSjeUkt9ltSoJv48YCYX974GuHSOtUH5D2fYnVEd2u+b3lVWPf+BunjgKBTWxvwplSe0zGDJscsCepmcmVkDHNNXCvCEQcFawvyQ9mejfqnSrGGEl9S6QB2SjKGi5GJ/aD/XZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a528243636so1928689f8f.3;
        Sun, 08 Jun 2025 03:45:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749379502; x=1749984302;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LIvD9g5pC58Ztk0zOCRRAzy2zEC5MQKjWs7oUbzPh2c=;
        b=aF22KidtjsyW8PLvMFcxxTDZGmYQBg+pvKD7IzFK0B4aaQCHNWSkwHUZLPc4zr7jF3
         iGo5ydr1Pz4pSuuFekkAzGqqQVLu9mkXdOHAhK2PVkVyAPfn9X0I9QVyorgaoRS7sZSv
         sNQaJ9wU23NyTuFjFxpF9x3Bhoa6c1FcehRo8RhPuCIR9em8A/LH5wcK6t1YtWHa4t1d
         gSfLEeyDpZDl/TQUCCAG0nK2AbdDJ+xVuHP1IKCt6d6ZXbL5aVEJTSfpWcjIkpPXSFqR
         y9KMiL4LuMz5w5Q1K4Hsjda8/XfffL+2xpeAET7NNcXECGwHwlGVaPzrUj8hGf4HoTA9
         q5lw==
X-Forwarded-Encrypted: i=1; AJvYcCVAYTJcOc7DbyQoDGWSFnTp+FScCXxWPN77TlmMazeaTtWsAd6zEq7LtSJ8UCBzZPjOqlo8FUXmmN0=@vger.kernel.org, AJvYcCVDi6m7nA/Ds45fBt4/s79R/uvzx2jYOOzqG3XoYu6jNT2CBVeY4BeM7/yEGbbRti74c/kt9JcAyD/XkgeW9skO/0v6@vger.kernel.org, AJvYcCW4COvZBRGTrfbXlRjyttVx+bPvAdw7S5tGNq7IPqrq/GqvjCTn+uNbCxbfvKO921YS+eUHvio6kRsjFw4Q@vger.kernel.org
X-Gm-Message-State: AOJu0Yy36HhWuC7YNPo2uvA5VNYTdZfwtoYeoFtzebsrLQyOj9XwxB4j
	i35e/mcee5XbUsKmyDoXTz2NUjlGWUXpDWISHa6kKIRLMaas2UYoU94c
X-Gm-Gg: ASbGnctp/JC+iY3y6KeREbk7XQGsO6bz2FI9sjqKgnRstuhALdVYlYIaAnlmc6vjkHn
	6Ke1BhDalBtLy0rWk1CexTJbaVJnxfP3vQZbfYgPmq9ejXAycL3R/UhMRH/Qzj7SHU16PTaXSJE
	zka75VePs0o7hKCuUW7LoG/jIjU8jm1Yu3QPPLVx3hFuJvuewjMtwNUHxL+GckaacWVR8SNWe2/
	amMSg1iw9grOR8GV9oIgc5V1jX6C3xCUN8to56xgS3L3Dmrh50J/8aY7waaVF59jP/o2fz7R1WQ
	eD2tUxntoaF0rsJTigNd3fhRtiXi7lbXRkSW9hQpwPT9f2BF5Nfk3AkwKV2K0ZOi7U0z
X-Google-Smtp-Source: AGHT+IGNFGDMfHfIEL0sJ7ZD7k7TZPhXhBYgp26b9eOex0Dz6soSxZxw1jxgnEFXR22EthMgy5D0Cw==
X-Received: by 2002:a5d:42d1:0:b0:3a4:f90c:31e3 with SMTP id ffacd0b85a97d-3a53188e4b7mr6104014f8f.31.1749379501863;
        Sun, 08 Jun 2025 03:45:01 -0700 (PDT)
Received: from costa-tp.redhat.com ([2a00:a041:e280:5300:9068:704e:a31a:c135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-452137290b9sm81516285e9.34.2025.06.08.03.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jun 2025 03:45:01 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>
Subject: [PATCH] Documentation/rtla: Add include common_appendix.rst
Date: Sun,  8 Jun 2025 13:44:36 +0300
Message-ID: <20250608104437.753708-2-costa.shul@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add include common_appendix.rst into
Documentation/tools/rtla/rtla-timerlat-hist.rst - the only file of
rtla-*.rst still without common_appendix.rst.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 Documentation/tools/rtla/rtla-timerlat-hist.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/tools/rtla/rtla-timerlat-hist.rst b/Documentation/tools/rtla/rtla-timerlat-hist.rst
index 03b7f3deb069..b2d8726271b3 100644
--- a/Documentation/tools/rtla/rtla-timerlat-hist.rst
+++ b/Documentation/tools/rtla/rtla-timerlat-hist.rst
@@ -107,3 +107,5 @@ SEE ALSO
 AUTHOR
 ======
 Written by Daniel Bristot de Oliveira <bristot@kernel.org>
+
+.. include:: common_appendix.rst
-- 
2.48.1

