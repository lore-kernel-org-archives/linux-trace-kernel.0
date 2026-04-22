Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3BC2D2495
	for <linux-trace-kernel@vger.kernel.org>; Wed, 22 Apr 2026 02:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776824420; cv=none; b=jKsEqN0Yhy0rs1M3tOhzFzMR1aSEfYB3Rj3bZr9vaY+5/LGB3wEih13XjEZFcSLwngJTapRONLENH3Y5OAWPLUHj6FyEE66zRmOhV9kGe45MDzjC/sqUWliZU2iUu0QEe9sGI+oxzmgFxTEVXaFJNQQeIgg4iSXDsbx6sDxhsf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776824420; c=relaxed/simple;
	bh=o1eREh2wBNdu8gIXpQezamgmlO1RaMH9tdht2gx4RfA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=inKQzx7XfTubImJW2ismST2C2teFbTnoEFhNNFqKUa/p25NGHrZbhF2fpbaJtO0X9GMFz3r5N1BppPKkcjNhkqxpptAvQlZbiXxc9acw9PJVg/Vrr/X72zCEa8VrnNAa20KSsOHlueKAD3OOOKlZuZAWra+7g0SHdn/sWSzyceE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n1UFsPDC; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n1UFsPDC"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-35e563b0ee7so2341175a91.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Apr 2026 19:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776824418; x=1777429218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h/b9I2S9HzS+/E6HYqvopPnl5327mzHx6NTVo8J4WP4=;
        b=n1UFsPDCIxYQoFJZtahH2K0ofsBfq7qlSBuBsPXWWkJGHmpJxGt1xsebgTIzkiNtnk
         QuZLGbmgy7OVIdz2T3OzdMBcYGigQ5ZRAd6qEApGhOuitVh+2ZsC3qYodr4iz9dK0Bfr
         eKG+q94V/NrKI+E6mZEwuyUgOeU5wb3vxTH/oVL9PcXohFCmg6LCFexyPbvWSDpSZBqV
         rbJ5HyWG8LfWIUndPmwAs7RCSEqBPEzqJkRXxPaY5zm54mTv37MdSzVw+H0Ywia1Vbmr
         fUDBwwN7Gy2q34mpDDlWwGQZKtXCj0g3ro0XictUU3U1nbcrwm6C8nZHLfp9OhtOTYff
         Pf9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776824418; x=1777429218;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h/b9I2S9HzS+/E6HYqvopPnl5327mzHx6NTVo8J4WP4=;
        b=pj8AzZVF51EcSvHq9NeNRPndNuMrTpxLCavNO8TQmdFQOm+jFwIVNEwWvAk6nFgC7E
         9++yigpFHl46gs5KpDmGO8+UNPS9RhtfHwN1Ng6Z/BtfRQ6Qw7YvNAI+qnIcdZ2DZCAy
         ySrekdjvFZT4T7OJGhRawOvKrefQqGQbOXw9U4E2GO86ZWdbuFGBw3mOs/X9lyxvI91p
         lnurhkBhvU/nyp/9TMvvxSSpktmr34qZ2j9Crl5tzW5YX8Sk+O3SH7m+TYTI7dyAulvG
         93MEDCCNUx9cuGrzsLMykSAnEvZNojvF5Ctjri0yDRgqfLPiAOq9VB8J4r3Vu0oa6GJh
         iRyg==
X-Gm-Message-State: AOJu0YzVQcR4ZHx1Jen1ycBSWhV/Gj9vsP+AmvadEFLTOt/44p+gSWFd
	aEpy4SptwOiQwUOfpZ/sr3lphmtU0n6D6S4qJl52l3Rj+BMWUv9kCGZp
X-Gm-Gg: AeBDieuPM6S4SguO28UD/EAfTtt8YdH1qXA+WAXBaXj/zRCxVU8GnGS9WgV9wORJkpB
	3OQ3r5hULWaeLkCrYjP0ANaBso190zurwvgQ8HRUcpCFNmP8ypzMRgyEMgFptl07X0jKErXKsZc
	tC7hh52nazuzrawvalaBEFV/+8IRR4uYfYgJlwytyGmjYXjJd1EWSNDb9LtNnqgWAx1hAp+x3Tq
	tKadzVBDYCq1NJUG2w4kd2fiX2Ytm2f2Leng0R9GY8HEUqtsi47dDWXoaLlzSvFktDc1sCdqwM+
	an0XizRnetlhIxzKv/g0Axb0n+4ggrJFeJhgacSd/SgR0UpWiczdQ6p0vOsFPi/fAmFjRyQ1lS5
	+3224qaeD+nZNWmLyfwVjhR/9bg9TTPIEYfL/3XsznZQTzQXh4JQy36qFMQJWgu+Z4L2t1ObYIM
	kKUxueIC2cPXBn5oqUpyOG/qpOh0J4lmbP5N2ao0DQrNeBiAQaL+rZ0ac=
X-Received: by 2002:a17:90b:558e:b0:35f:c1cc:fee0 with SMTP id 98e67ed59e1d1-36140290941mr13420309a91.8.1776824418197;
        Tue, 21 Apr 2026 19:20:18 -0700 (PDT)
Received: from DESKTOP-O76RRP8.localdomain ([140.116.247.199])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3613f56ecbesm5704328a91.0.2026.04.21.19.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 19:20:17 -0700 (PDT)
From: Sheng Che Peng <synte4028@gmail.com>
To: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sheng Che Peng <synte4028@gmail.com>
Subject: [PATCH v2] tracepoint: Fix typo in tracepoint.h comment
Date: Wed, 22 Apr 2026 10:18:19 +0800
Message-Id: <20260422021819.1788091-1-synte4028@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change "my" to "may" in the description of subsystem configurations.

Signed-off-by: Sheng Che Peng <synte4028@gmail.com>
---
 include/linux/tracepoint.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 578e520b6ee6c..763eea4d80d87 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -202,7 +202,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 #define TP_CONDITION(args...)	args
 
 /*
- * Individual subsystem my have a separate configuration to
+ * Individual subsystem may have a separate configuration to
  * enable their tracepoints. By default, this file will create
  * the tracepoints if CONFIG_TRACEPOINTS is defined. If a subsystem
  * wants to be able to disable its tracepoints from being created
-- 
2.34.1

