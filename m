Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1101A2EB868;
	Thu, 28 Aug 2025 07:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756366486; cv=none; b=ETya2YpVn2QeYws71wUH/G1y6Af5mrpwgCHWt2Z60bW6A8hfWK0d1ETCki4EzX2A4fiG+RWzf5LHKIjlMZaobpayKSbIpwxM/DaQWpGCrRnWwps/kWYjY3QA6cX5SUSiDrkBdHFG9K20RcIWiBTxG6tEzvXxbOkTS5kjfRiCL/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756366486; c=relaxed/simple;
	bh=IGZGRl7SPv8QYEkfF81MfJQSk3f6SOpoIfAg9jVan/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gh87/DlJzAe2mgYDChOFgRQEK0LDSFU/ORMFBTKi9BkMR+fi4ldw0gimvIgjxuOQv0BtkR1jQnEl5XuKp2N6xjCLyWCz9gCmeeo92+fLVqdCF6fXk61p4g3hJ9+n2BIG8FVFKil+XzhhO81PhKlkXwSa1CSXrOjegXGGzGwAkY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fdL8wPJT; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdL8wPJT"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-771ff6f117aso637087b3a.2;
        Thu, 28 Aug 2025 00:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756366484; x=1756971284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y7709ieFUlS+2MrC1zNfTfKDbThJkcQv3sQ/PEEU3R8=;
        b=fdL8wPJTl5JRKHXPHhjVsl5c/kjtXn93/eaqygafEK9V9kGf419qUXQ68hjmAVzGC1
         kKXNGF6JviYgIXrv7t6qmUxXNKPor4LN6AK0q343w7bepZ6CzJP29DW3j9nslkpvZDT0
         xFJC1LyIGakKsZTWD4SRxocCbmsE2+UH2p2u8c+vTjaqZ7/YanLNr/dcMoEkATvj2HuC
         1LZGCP0GxZ1YCNMqUc5xP+uOEqyxoYKRlGAQD7cQVYVhSP6XjeYd43FMx61af0kdL3ZZ
         t2N2GI7gnypSAmGawcQL7OSIr2fSGy4ZAI2i6ohKmIDzfUwcS77ligbgFv0yw6YHkRxP
         JWHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756366484; x=1756971284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y7709ieFUlS+2MrC1zNfTfKDbThJkcQv3sQ/PEEU3R8=;
        b=Gnn1qVU9amm6JR6NZvWMw3A3GG/9M2wTdMslK8gbJdUzfLyAFUJRlPqbWsl72FX4MS
         e2UVmFpUE67G1GwkdWu/5Ocy3dC/kwc4RLdc/EHaZDkADuTskvF57/6VQbZWWjK2H7ll
         4BTsqzmaxvY6uzinkKBILiN4duwuNGFIXHR4yrLfPM6eLe8QVE1GNH3AyRkGRN3iOTvz
         o8NWvtlFzs6TUaysFIJork3wiJPT7qVb2+Ih3yRJ4eok8rz8Ck44oUP4hrP5154Z3vn6
         hfvC36g2KsupOE9HfVDb/ca8/sgC1gr3rQymMkzIClZMKrI8y57tOfhsHoAInQ3N2r9o
         UNHg==
X-Forwarded-Encrypted: i=1; AJvYcCV26C3+mhlOVrLYZ58HNfbBPqvZvrqGIFXEyNJxIUa3nRjPFisD2qH6vqc/WryooHPXdQ1FyjmvhMgnpgQzqan+fqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxlAONpCrIXqZAmXBZevVBcQ5ZmlN8nC+TOUPtAm2ICZM70cm6
	bw4131OY8cHV6nnUF1adHUt37IkbjUHwAnkAuNhbJgqjuzJKPRizgCYc
X-Gm-Gg: ASbGncuk6ewd8Qqy1iu9qCL0r9weWfI9gtiKorL61zOOHyLzK9R6+wOdUs0IFJsPppP
	X6732YWZ0l7k0E0BxfdX3+iKkq++bW9kFXUJYZol/23dGwZovfogJUTkWHPAE12YUbFUgd79MlY
	Degi6brGcbOo4Hgd214Tzr3by1NegVZYIFZ80BFyA/+r1kYoKvzjuNwdjn6ZOhRbHT9JpGYGIUp
	E/WZSmhhisOQOn6VdwxnVwahxm5dpqzYxpAR3dv2IPu540KKSF1p6cawuaKLPNrJ9xIg5ssFsc0
	KKnmQvW2oFSpgoC6hP7zFCKYisFgL4e1EbhGkxcNtGeOZLFrWtPLKFqGrWmpTZModueuuNWBUHF
	67WpT+KB82Q1lX/GyMzuMTYlNMOVnTFC/55+jkWP9Y1jsfvSLV1at8YT3B37mBCleyVRHXfw=
X-Google-Smtp-Source: AGHT+IEIHHNWrId/X4KeEFqzkhy9anSPZ3dizoDTWPZdjGsO5evyyrSwN6uApRA0NfOM0BM6Js4xvg==
X-Received: by 2002:a05:6a20:9147:b0:23f:31ab:371b with SMTP id adf61e73a8af0-24340b4623bmr30386114637.17.1756366484347;
        Thu, 28 Aug 2025 00:34:44 -0700 (PDT)
Received: from localhost.localdomain ([103.88.46.62])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cb8afb7bsm13182613a12.16.2025.08.28.00.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 00:34:44 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"Naveen N . Rao" <naveen@kernel.org>,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH 10/17] mm/ksw: coordinate watch and stack for full functionality
Date: Thu, 28 Aug 2025 15:32:43 +0800
Message-ID: <20250828073311.1116593-11-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828073311.1116593-1-wangjinchao600@gmail.com>
References: <20250828073311.1116593-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch connects the watch and stack so that all components function
together.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/kernel.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/mm/kstackwatch/kernel.c b/mm/kstackwatch/kernel.c
index 95ade95abde1..4c5fbcaddab0 100644
--- a/mm/kstackwatch/kernel.c
+++ b/mm/kstackwatch/kernel.c
@@ -1,10 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/kern_levels.h>
+#include <linux/kernel.h>
 #include <linux/kstrtox.h>
 #include <linux/module.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <linux/string.h>
 #include <linux/uaccess.h>
+#include <linux/utsname.h>
 
 #include "kstackwatch.h"
 
@@ -22,6 +25,29 @@ MODULE_PARM_DESC(panic_on_catch,
 
 static int ksw_start_watching(void)
 {
+	int ret;
+
+	if (strlen(ksw_config->function) == 0) {
+		pr_err("KSW: no target function specified\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * Watch init will preallocate the HWBP,
+	 * so it must happen before stack init
+	 */
+	ret = ksw_watch_init(ksw_config);
+	if (ret) {
+		pr_err("KSW: ksw_watch_init ret: %d\n", ret);
+		return ret;
+	}
+
+	ret = ksw_stack_init(ksw_config);
+	if (ret) {
+		pr_err("KSW: ksw_stack_init_fprobe ret: %d\n", ret);
+		ksw_watch_exit();
+		return ret;
+	}
 	watching_active = true;
 
 	pr_info("KSW: start watching %s\n", ksw_config->config_str);
@@ -30,6 +56,8 @@ static int ksw_start_watching(void)
 
 static void ksw_stop_watching(void)
 {
+	ksw_stack_exit();
+	ksw_watch_exit();
 	watching_active = false;
 
 	pr_info("KSW: stop watching %s\n", ksw_config->config_str);
-- 
2.43.0

