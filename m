Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A18246BD5
	for <linux-trace-kernel@vger.kernel.org>; Sun,  7 Dec 2025 20:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765140989; cv=none; b=RuAtjjni7arpjLxHhySJkCvyNVclhjLWfmnScm0YUOw4lV3OI4bOVRJRHvU36sUgwCSjJwLYZA+gMyRwswm5cp9HaykVpsqKqwUnJ6cmbYwhSnRFzJDR1BYQTJG/ETF8BbD1ya9rv6CRqIPiic5OIghOjzRyg62THvVY/AskegM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765140989; c=relaxed/simple;
	bh=EbCy3n9ZFFb7TBZueSvzwcuEg3m30F0z5i41Es5ad9g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EELdeTCyjIOQ8A4oqwYqMCJER4/M7gxqB4rE8AvM+wYbMvYwlJ6ayfCctLmDEtou2SJsmdmQb7kiAoeEJNarMA4vtXXA0dO8zt+fXTrLjFzlkZtG+eHHrC9Nl6iRx9OBEqNsXFrucICRQ34iaMsy/dB618AfNr9tFEASK/PQNsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qp/UQ3u0; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qp/UQ3u0"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7b89c1ce9easo4299930b3a.2
        for <linux-trace-kernel@vger.kernel.org>; Sun, 07 Dec 2025 12:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765140988; x=1765745788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y4Twm++QTtW7ndlCw/joSx585IZV4Lb6XDQUy1KIgB4=;
        b=Qp/UQ3u0iyGBBReIa17kzrsi8UeiEDWA8/lx+Hls8vL9LYoYHB7nr3YIS5jZ9sM1r6
         4fa12axPq9gSQD1UnWKsvg+c4eZfFrXqrXBLfAFMc/MTnQYniA+R+2LYPwewpZGq2J5r
         hnnb/BycXVMRa05fql1G11IN5Yz/WluBoM4v25VAsOusyFYlEQXNovAOLpJ3oMZHOCw2
         xuTa5wHr2YrBkHqZzJFHJjRaDsq0ikkw0mBW1DrYK7te8AMHiFr+yuCnPq4YpzXK06Wm
         Cf40/q+5uZ5P6hY+jviKfJpp04EuGwxiyoNSwI+GRWPxXwZTXiywHVxW2o7Mz/GBiCaX
         ry6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765140988; x=1765745788;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y4Twm++QTtW7ndlCw/joSx585IZV4Lb6XDQUy1KIgB4=;
        b=lj1KlaBtvPdWrZygXAx4tKfzIGD1h93HOkXqeQIgV5N41/mDaC7/27eP6mdtsxeQaF
         hKqP354pK8x+4RK/axOKMsikkdQsog0hd6UDrC1I3Jp2otW2CuoMKaTs4nNsgwzSvcHk
         5GnoST+Ugi+0OzKgcUb9hd/8iXlDFnd7zDh6XZW1Ok9NB7v2ckjtoB60YhPabJ6PpOwH
         /16Np97X7mD+XjK6Tj4aIyujbaMmsnqyatMMV85YztrA2k/xgV9Ti49KwwW6286qrQjb
         hqziXyvUZrJfBHBEJYVfCVyeLQLbo5gw+pVoACHTdgx3msZWxdK/1kdt9Yr5pa45gdwi
         RB2A==
X-Gm-Message-State: AOJu0YzpmNBg3+GGsVkgMw9RvLZ8aiUNCtDzE/4VsG0/WPkJMhUdb0f8
	g/7heixdR5GaarRVZmamBiGWPU2NKMm2T4iD57m4oa7w4946mnGdbxK5
X-Gm-Gg: ASbGncuyApOf3DmZWOEMWTsFIHzsMeioiU70sV/BAGMdvtSKf7i+DGT9MWZZYLE/v58
	pxRm+IxTRgVnGeDoxAX/hsdalJUoYEY9sj9w+3sKnArLWOZECNyW9qG1cNgw5ZfV9hig4TsjRh3
	WZ6LgOP9qVa6lPhyeYcnsmFZ6zGrnGREoQ7KuglQX9lr/MwoljN1tbDCGd4SksNy400BxzG+jjd
	LR/AEnDzW4IrgP3glh6MpQcIxJfGVNFliU/XEG7SpJlL/ptOxo2w+sYy1pSm6/nzpNoSRyaY/FK
	PkJKKWTi+j4jJUAnGMT6M5TXeqNmqi/hFX4rGojYqrAzPVlYOOqoXM7LTFX6mrdiKFF4H5qzr8I
	FkGaQo/VPtALefRu+zuDmAoLyvSG0m/v0Z2DSg4VPaSbMtFrExhjqhNRQfJIGAxJhoNGQzttHgs
	XvHCZON5D1SZLidbZU7Fxd8FM2yUNd1TbfH9I3Lg==
X-Google-Smtp-Source: AGHT+IEj9siDqvwpWgjrDu01ZCtyc8MS9lDqMkGld2qETQJFyBxrnzl9nnFn5K6XftsWYZAXaC7vSA==
X-Received: by 2002:a05:6a20:12d3:b0:364:31e:2cac with SMTP id adf61e73a8af0-36617ed60e4mr4896526637.46.1765140987698;
        Sun, 07 Dec 2025 12:56:27 -0800 (PST)
Received: from golem.. ([223.187.99.232])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bf6a2745c43sm10170350a12.29.2025.12.07.12.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Dec 2025 12:56:27 -0800 (PST)
From: Shubham Sharma <slopixelz@gmail.com>
To: rostedt@goodmis.org,
	gmonaco@redhat.com
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shubham Sharma <slopixelz@gmail.com>
Subject: [PATCH] rv: Fix documentation reference in da_monitor.h
Date: Mon,  8 Dec 2025 02:25:46 +0530
Message-ID: <20251207205546.73946-1-slopixelz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update documentation reference to reflect the file rename.
Monitor synthesis documentation was renamed in commit f40a7c060207
(\"Documentation/rv: Prepare monitor synthesis document for LTL inclusion\")
from da_monitor_synthesis.rst to monitor_synthesis.rst.

Signed-off-by: Shubham Sharma <slopixelz@gmail.com>
---
 include/rv/da_monitor.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index 0cef64366538..810cfb140131 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -8,7 +8,7 @@
  * The dot2k tool is available at tools/verification/dot2k/
  *
  * For further information, see:
- *   Documentation/trace/rv/da_monitor_synthesis.rst
+ *   Documentation/trace/rv/monitor_synthesis.rst
  */
 
 #include <rv/automata.h>
-- 
2.43.0

