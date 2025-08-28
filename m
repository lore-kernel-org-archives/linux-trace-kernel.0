Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53CD2DF6E6;
	Thu, 28 Aug 2025 07:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756366465; cv=none; b=FseGJDC+TKOwLRGsdoH7qqk8qBTfb8Dm0eFj21mNLy05Dvs6RMmBZ3AEBQGaujL/uTbr3jteeFbGUY4JyjTrJu9MhAcu+gfz23SBj1+SAzHq07tMhgkZbyg0B8asOqaZ6JKsR3AONy+4vQ5GnLZ1dbnZqcnD6kykYuRgprZ/dAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756366465; c=relaxed/simple;
	bh=rufIEWmrAKLQ+mfcV5W+4Uljip8z5lF1CAVZ2QbsVZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WlQx+RaSgsAmPB9+xmy/b3Xm2m/wzoCHFMi/HneKjNqHFyW0zZGE6Hr2SGIX1dKyRHuERmZmrWpAzFZO8GL1dVw57sUXycGC2922iN1dzqbuxAXaED4CDSO24UnITT+3HmANRngYKP1lwUWNElBotcj2w+RlWlVbM/8HY6G8t78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hIT7mrfu; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hIT7mrfu"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-324e6daaa39so674718a91.0;
        Thu, 28 Aug 2025 00:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756366463; x=1756971263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=06EnX4xNHqiA4W3dBLh6+8AEySVO628YRMoxqtZgpzs=;
        b=hIT7mrfuPxaCiMuyeLR+JgUncHBIBjmoy9XGk4+qZbp+EAeWmR1Z9alOUQLf4VWPOM
         PClQRGUPBaTNx/uQ2Nv63/gzPbY4d8YKCkfltMotppKIfl29ZPC1+VSGrEHFgROkQpsr
         c+mBMZjQ6QmnOaF6CFJAJ33I5yaf5Si0rUyNaj1/gBUK0cngLq7g9tg7GGuf9h/HlHR2
         xqhqKocSyqcQsiiLl0etO7Teadkwqibk7EjPA5jzWop2tlCiiMKSXcv0fIcP2SibPceu
         JDutNJLi+JmLuRMHiAjeVRToWIolIPQK54tFfGaPRtWn8Mi0wk10LX+NPvHeafj/8CaZ
         tE9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756366463; x=1756971263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=06EnX4xNHqiA4W3dBLh6+8AEySVO628YRMoxqtZgpzs=;
        b=N0sLLyoEXP5qLuu9L9tUAzSHKQjj90R249S9XqwsPv9TTva/c6bdCBSZ82teTKfbpa
         1Nekp+WkC56VaqpBd+QmTv9KJlA7yJ+vut1Jl4edT2JHooggIIa4VKrGm5BYORz7eqA9
         5oIcXZM8eDLCtJubFxWjXeGEbuqLO23DiOIAbI/riEM8hPeFh/hLRMzDP0qPLfM8WrIu
         GviTHSUNmyeQCyyDpp9LiHYOgn2u4NhvyLL9atqyZh7uZFhiYVy31HrsbNXFL0gNCr2m
         peXVEehthgGrw7pRBeMLtMuULAeymOpO1FFit7FZfsyDO1daRzcWcbstCsy07WJ0tFEZ
         d6Xg==
X-Forwarded-Encrypted: i=1; AJvYcCV1GIFdp2yGsqTG1/J04+jsRnAC1cbOybrQqevqplwiSKWVgnrVNiNu2fWuV4WBVnGKM+S9UI0r8KqT6l9qdb6o+po=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTRHYbPIo6LWdXOUp6C+Va6hb/tKwiLnESJ/Z+E6uhS3SJjg8G
	MQBEsYJAyvN7phbVEa/pHZxti2MNXkTiFA6PBhxJH8bOD4MFnpGV+G77
X-Gm-Gg: ASbGnctFIXJiPQii1eQXLey7UDTrLonAG2S6OD6FhPfszyxz0sAhgkytMyGEmxnwXfb
	c/w49r0tOzHMlsltWnvvCV1EHcTEvdLcwpSn3H3a7bmhJOd9SBSAKerBbyMhVrmIFY9Oss3UAB/
	o6NFoLa8U4FJK7oMP770UX5ipEx9bCG0YqFMSfFi73fbD/0Hcx1Dt7JJB9DLuhggt5OzcmSDHlt
	4z4SMkwJP5Mi6qCfGQVwbeGL/Az4eIruwKHV2t49SRv6qor2YBEIH+/SPGrBByDJXsUvdFM6yeB
	pBUMgJ4pIduk8J5JL0jrjrSr5vrdUwex+MCKnXeJDGUlCrhBKUe17+7gjWadjpQNJAS2ATJ+t+S
	kiDlQMjtkp/sYPKjLTCG5/aHAWO/dBsBk8Zsd37CjTodAVA77tw==
X-Google-Smtp-Source: AGHT+IF3oK1wtDDUKHh7prZzFv/h2WgsQ8uT2JvqKbar3UHoHg6u2L/SgTz5aOR5xgZdGT+bcHmpXA==
X-Received: by 2002:a17:90b:5823:b0:327:50b2:8007 with SMTP id 98e67ed59e1d1-32750b28118mr9705895a91.32.1756366462755;
        Thu, 28 Aug 2025 00:34:22 -0700 (PDT)
Received: from localhost.localdomain ([103.88.46.62])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cb8afb7bsm13182613a12.16.2025.08.28.00.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 00:34:22 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"Naveen N . Rao" <naveen@kernel.org>,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH 04/17] mm/ksw: add HWBP pre-allocation support
Date: Thu, 28 Aug 2025 15:32:37 +0800
Message-ID: <20250828073311.1116593-5-wangjinchao600@gmail.com>
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

Pre-allocate per-CPU hardware breakpoints at init with a dummy address,
which will be retargeted dynamically in kprobe handler. This avoids
allocation in atomic contexts.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/kstackwatch.h |  6 ++++
 mm/kstackwatch/watch.c       | 62 ++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/mm/kstackwatch/kstackwatch.h b/mm/kstackwatch/kstackwatch.h
index b5f1835586c1..2318779bde70 100644
--- a/mm/kstackwatch/kstackwatch.h
+++ b/mm/kstackwatch/kstackwatch.h
@@ -36,4 +36,10 @@ struct ksw_config {
 	char config_str[MAX_CONFIG_STR_LEN];
 };
 
+extern bool panic_on_catch;
+
+/* watch management */
+int ksw_watch_init(struct ksw_config *config);
+void ksw_watch_exit(void);
+
 #endif /* _KSTACKWATCH_H */
diff --git a/mm/kstackwatch/watch.c b/mm/kstackwatch/watch.c
index cec594032515..e7ed88700b49 100644
--- a/mm/kstackwatch/watch.c
+++ b/mm/kstackwatch/watch.c
@@ -1 +1,63 @@
 // SPDX-License-Identifier: GPL-2.0
+
+#include <linux/hw_breakpoint.h>
+#include <linux/kern_levels.h>
+#include <linux/kprobes.h>
+#include <linux/printk.h>
+#include <linux/perf_event.h>
+#include <linux/sched/debug.h>
+#include <linux/slab.h>
+#include <linux/smp.h>
+#include <linux/stacktrace.h>
+
+#include "kstackwatch.h"
+
+#define MAX_STACK_ENTRIES 64
+
+struct perf_event *__percpu *watch_events;
+struct ksw_config *watch_config;
+
+static unsigned long long watch_holder;
+
+static void ksw_watch_handler(struct perf_event *bp,
+			      struct perf_sample_data *data,
+			      struct pt_regs *regs)
+{
+	pr_err("========== KStackWatch: Caught stack corruption =======\n");
+	pr_err("KSW: config %s\n", watch_config->config_str);
+	show_regs(regs);
+	pr_err("=================== KStackWatch End ==================\n");
+
+	if (panic_on_catch)
+		panic("KSW: Stack corruption detected");
+}
+
+int ksw_watch_init(struct ksw_config *config)
+{
+	struct perf_event_attr attr;
+
+	hw_breakpoint_init(&attr);
+	attr.bp_addr = (unsigned long)&watch_holder;
+	attr.bp_len = HW_BREAKPOINT_LEN_8;
+	attr.bp_type = HW_BREAKPOINT_W;
+	watch_events =
+		register_wide_hw_breakpoint(&attr, ksw_watch_handler, NULL);
+	if (IS_ERR((void *)watch_events)) {
+		int ret = PTR_ERR((void *)watch_events);
+
+		pr_err("KSW: failed to register wide hw breakpoint: %d\n", ret);
+		return ret;
+	}
+
+	watch_config = config;
+	pr_info("KSW: watch inited\n");
+	return 0;
+}
+
+void ksw_watch_exit(void)
+{
+	unregister_wide_hw_breakpoint(watch_events);
+	watch_events = NULL;
+
+	pr_info("KSW: watch exited\n");
+}
-- 
2.43.0

