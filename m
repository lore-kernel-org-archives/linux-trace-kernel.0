Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD6432039A;
	Mon, 18 Aug 2025 12:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755520114; cv=none; b=A+99yuGrGi5hzNPGVvtWxrHjKcEtrlU6vwj/p9zcKI6d47DTITle5Hc/NZk/8NQ3ootr1iPh/XczxozERpS86GcYyUOA5/1Nz8DSLTlh8vSCigeMkhCJPFGoRqJflkHeoaEElPkViU5PDcvvcpsS/7vNbzRq32PZB0rVXhPzch4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755520114; c=relaxed/simple;
	bh=5HEDcYasMtK+Q1JjFG0e1pBJUlU9HBDS/YspmQF1+KM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SUWbOkO/E5NuObH30WmSRVJNdvK9Nzm1/OHP82fVuvJC1Oww97YFcd7pwNTr0Ncb9zFhGeOqhIuLRDz6CFewrOhDkMUdGSsezXne0lL+Vj5bEsHfCiBWkBG2uMqf4wQR70dXDJD3hPxQqYR1kzMPyzSdt+oai7qzxRBA1fMVX0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nGPpiB7T; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGPpiB7T"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b47052620a6so3964888a12.1;
        Mon, 18 Aug 2025 05:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755520112; x=1756124912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/DpZ0VS7862Ajy+KQk2G/2dTQnm2+OmeTQP24iYLyY=;
        b=nGPpiB7TH86Nf0Q4pRvl+GVVGdaXSDr3lsGkfcq+twFtkgJx1k5u3e0MTybsjjBrY4
         kELor4/ZN31ei55uaP/MWLE5f8PJYhEM5w62FdRJINKWNpK4piOO/eRfaikds0iYbmj7
         9/lyiKFMQnhesq6h08KldyEvc4hi74j8V9XdgB7Ad/mOrAtA2fj9ioHxIvu4IsOJhgU7
         AHpBcUmYOA5x4cqtsaGhVbr/dwGZKlujQ8LRS+c8JdCZEcGQPbWqvCaJHVfzgU07aMjb
         8a5qXcNsWsJNLLtU3LzNBjNgXOl0IZABZp6UESZo0+qhD0MEmdLVEyOh/sdsLEFq6h+e
         kixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755520112; x=1756124912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q/DpZ0VS7862Ajy+KQk2G/2dTQnm2+OmeTQP24iYLyY=;
        b=ccHNDr5PAIQN4KjiSxn1bFqXXyB6xiOEYAoCc9H7RFWXiyN4UKFw70w3AdjLyj6sxO
         XdL3ORSsbmuhvGEJOTMLkVmFMQfv171oeGDiKFNgR+YRGwymfE/Ft5YFZNtNBdHsNPaR
         h5Xj8l5mzzw8/R28t+xQnOMe6D3wzvdH6THAOWdbQgCAiUOz2OYiVIrsNe/wFwimOCUc
         7kNhUT231pQP+A6w43s6R2wr1yVrAH9jFIXeYphf1JTBhiEuD6X2nJ4nAqy3XHT1T3Dh
         nXyOpNMa6QxMLA3KOuJJDff05AhpBHjEO90otNzpLHP+pb5GHytGFCL3vHGNcOuen1+O
         uIAQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1t7vx8QTJyAUgaXX9cjUISBjypQFJKsg4d6GE4zZUZXPAzb+FwC3rKjgJSd3SnsfEjBPdLrKVCdjsLno=@vger.kernel.org, AJvYcCW5CIHvLsVOOqVjJ9y4E04P02XdGyhAX16fia6h7/OThyNRq9AEAk+ahrNL3SAgx+EkNDDy8RIVDi3wZl+N0eo7XSMK@vger.kernel.org
X-Gm-Message-State: AOJu0YwkzIPmWoXEvwZhFKemKuvxLGu5xgmls5NcpVlhatoTIUMFHhY0
	bpq2XfrXqNoyG9EpMjhT6gqNqHQTSLKUdChG2AIbf7ED5TJ+vMnkQHxE
X-Gm-Gg: ASbGncumfCUbXmsHP/odSoZEIL7K2V2T66pemIMjUVeXMEH2DKD9lcdQPmE5sQ+n/yb
	Eg/KAIucooYFOVli2vNH8sVzmMULP4g07w81cucyzIisNR1el4ZOB1tRG7FGNF1kAUhVBE/bFmg
	Bj4WPL7V/g7w8LDh8RfA8PdqohjHgZSxayqlJRFqH/2HHGcOFFodTHJ10S0fhIvZ8AyONRSmxDI
	x5zbLzRNhD0MwAPxOq96FG8Fc7T9HAP1gKPDwIulYDoV3N8xkxrl6X4Lgfmw7JidjS8OigzA6Yb
	heE4ncOr4p33hPBNK817MpxV1tFlLK0bXdwW3A8XqaGgXtXhg4i8+bhUdFcsPMauxUpAJCG0XC4
	2JM4TtusawJ6qRE/FVjFKX3B2cMc9
X-Google-Smtp-Source: AGHT+IEvY/jwsGgceZVHHVEFZS6zGhiEPgpJ/TKsUEzDfEeP0f4EMRoUPlRe+ApAp6RTIagWz9PdWg==
X-Received: by 2002:a17:903:41cd:b0:240:5bf7:97ac with SMTP id d9443c01a7336-2445978bb29mr248116735ad.16.1755520111835;
        Mon, 18 Aug 2025 05:28:31 -0700 (PDT)
Received: from localhost.localdomain ([2604:a840:3::3008])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d57f12esm79236705ad.157.2025.08.18.05.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 05:28:31 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: akpm@linux-foundation.org
Cc: mhiramat@kernel.org,
	naveen@kernel.org,
	davem@davemloft.net,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [RFC PATCH 08/13] mm/kstackwatch: Wire up watch and stack subsystems in module core
Date: Mon, 18 Aug 2025 20:26:13 +0800
Message-ID: <20250818122720.434981-9-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250818122720.434981-8-wangjinchao600@gmail.com>
References: <20250818122720.434981-1-wangjinchao600@gmail.com>
 <20250818122720.434981-2-wangjinchao600@gmail.com>
 <20250818122720.434981-3-wangjinchao600@gmail.com>
 <20250818122720.434981-4-wangjinchao600@gmail.com>
 <20250818122720.434981-5-wangjinchao600@gmail.com>
 <20250818122720.434981-6-wangjinchao600@gmail.com>
 <20250818122720.434981-7-wangjinchao600@gmail.com>
 <20250818122720.434981-8-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Connect the watch and stack functions to complete
the kstackwatch initialization sequence with proper ordering and
error handling.

This patch integrates the previously implemented components:

Initialization sequence:
1. ksw_watch_init() - Pre-allocate HWBP on all CPUs (must be first)
2. ksw_stack_init() - Register kprobes for function entry/exit
3. Set watching_active flag to enable operation

The ordering is critical because:
- HWBP must be pre-allocated before kprobes are registered
- Kprobe handlers depend on pre-existing HWBP infrastructure

Cleanup sequence:
1. ksw_stack_exit() - Unregister kprobes (stops new activations)
2. ksw_watch_exit() - Release pre-allocated HWBP resources
3. Clear watching_active flag

This completes the functional kstackwatch implementation, enabling
real-time stack corruption detection through the proc interface
with automatic HWBP management.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/kernel.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/mm/kstackwatch/kernel.c b/mm/kstackwatch/kernel.c
index 726cf3f25888..b6366808e891 100644
--- a/mm/kstackwatch/kernel.c
+++ b/mm/kstackwatch/kernel.c
@@ -26,11 +26,29 @@ MODULE_PARM_DESC(panic_on_catch,
 
 static int start_watching(void)
 {
+	int ret;
+
 	if (strlen(ksw_config->function) == 0) {
 		pr_err("KSW: No target function specified\n");
 		return -EINVAL;
 	}
 
+	/*
+	 * watch init will prealloc HWBP
+	 * so it must be before stack init
+	 */
+	ret = ksw_watch_init(ksw_config);
+	if (ret) {
+		pr_err("KSW: ksw_watch_init ret: %d\n", ret);
+		return ret;
+	}
+
+	ret = ksw_stack_init(ksw_config);
+	if (ret) {
+		pr_err("KSW: ksw_stack_init ret: %d\n", ret);
+		ksw_watch_exit();
+		return ret;
+	}
 	watching_active = true;
 
 	pr_info("KSW: start watching %s\n", ksw_config->config_str);
@@ -39,6 +57,8 @@ static int start_watching(void)
 
 static void stop_watching(void)
 {
+	ksw_stack_exit();
+	ksw_watch_exit();
 	watching_active = false;
 
 	pr_info("KSW: stop watching %s\n", ksw_config->config_str);
-- 
2.43.0

