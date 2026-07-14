Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF34343C07E
	for <linux-trace-kernel@vger.kernel.org>; Tue, 14 Jul 2026 18:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784053990; cv=none; b=YLOaw1gZlGxy38M+FwJsk++h41gs5FQJmjbi3Qho0GybOS/PmJnZ4UzA08A83PSdls9fMbCPh2vQQ2bk7Let3KqUYuCq3BIMD4l+ftZw19fynlakScTi+H8XS5mKSxxaX2i+S4541gieadSEgnk3gBQG/3Ra5icR/BYahUJPZNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784053990; c=relaxed/simple;
	bh=HtjHQF0w4jDf5jPZ2VynT9uUeex8aV3wyoJGoZkJo4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ttbgoo6Ni2uNslWFZU65XJD2081m+LHqI3141qMyjY/zHN4N72rbeueIVvtrEdpKJrZezS0DVh7cnZnsCTsn15UJ0/gS3mDxCVnoldNnb9bExFcRvVoUSnkFBC848/9H0h3mK1monQ0YycMMmoDfnyJJSwRQj9WRNjiz1li91OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dETxNDqx; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dETxNDqx"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-92e512a9a6bso235077885a.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 14 Jul 2026 11:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784053988; x=1784658788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=88qx9YixiLkFD/vh8cYDKX7z/SdNlgRZ6Zz58PjlN0k=;
        b=dETxNDqxbHw0FOIZOXFfiIEdLJG9fczIlEfMsIYl4L11w87iwra4wFviXb+E5+9Tb6
         Ay4Qj/8qa30SiDz0s9pi9SOfYl/QYzSrTJlEkaDYBNkGBa9XIoRxZ9RpgHGbXxXrwYDV
         cKKYgySsHnJM9cVT+7YpN/3EBL8LvrK6gwUSb/EWSAIHYjvdb0o41Vd/Jh6RZT6WHQVk
         85ffKaWkfPT8SfsV+JLcGK4/KO+PemSss7PTRJM9hY0GTf7oCqkF9DBzVBGcYn/jq29/
         mujz6yjLQup/HeovE77FFsUV2U7roGkdXhrJveLQjS0EHxcAmo87Bmn0y7nazv+rL1eu
         IDPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784053988; x=1784658788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=88qx9YixiLkFD/vh8cYDKX7z/SdNlgRZ6Zz58PjlN0k=;
        b=pyEIpsDVgvOPLFqju40//E/doe6y9i/jk4anJiTlhIZFNpej8lKcQBajnCLhlNAMi7
         ygVoedH+u/PUUKez1FQGOpMskc5r3QgcHFTsgSbB9r3igGXINEusWKF2pZKxF/SH9S+7
         pTEoUr7J1lVOxFJ12zp3SDJT7X7FFnbVRrmGO2QT69P2H1QOzZGkJBRWGxeaNpseo8EP
         3uzYsF8xg2cgNkCpci/zvLAOiRhVl/SNauUINJH0vyMvYjz0JJS1u/X2ovNQS0eiEPal
         Os8etswt9DfbfRfsMvBa/eaHZRs6v/Pj3jN9NytAmjE9rqMIbaPxC99oAUcxHs/dS16+
         2/xg==
X-Forwarded-Encrypted: i=1; AHgh+Rp4fknFdFZ0hxg7KkHT4l1Cbc6P0FHLWcnMXym/O4Kok8FVOpHP79L+CQoWhuIX7LVtc8Q8bB7iaEdqG8hm1fy3d4A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz49o6TkXhZsBWyys2UWthZy+vDIthVvfYJ/R9BG6z/4Esjx01h
	LAyiqC9p3dYqAbGYueENnQm1zfBsYuDO+whiUW0Tho8gQqZnTm0NQlmt
X-Gm-Gg: AfdE7cmVBBDG9cmkXJyfJxZovrd3cYQAjQRD9lFDQjNTEt2wtT4jcQyU1B1PyPdxvco
	ipBEHn400NqvJkVfQBNILq60B3+ovvSg1aDgMzYI6tqahh2J19huGor7UluNXmx/y1pJIPGV2Mj
	55FgmJooIAx22ZGEUYOk/hGukC2+4IR4CqB7skEwp8+MieBTZVt/QaLpyWgyE1q2AKAlg4ubSI0
	KZrIU3JE0Mi8nmcEs88LB3xNg7/+P+Osh8rUz/dw1kWtoIHlqAOFlzsR5emfEUm2lLIeiCsl2r/
	YkmI3g3NBz/AtvCIu5hBxsb90ZrE28vFMMT+eCl/0GNfmqP16YeRNUWTD+5wveUR015+irVfQmt
	o11O/0C740Q7WG8fjFJKGaBk71l7cewaArZ5uPaHKDoGwEt6030NZ6OJjvuuANoA6TqwLMk4Vbk
	E+2GhZgbOB503h8GYDJAIXkrHytM/AMJMIH7h+094y2ZOPvQ4JZninCJrob8QaSQ==
X-Received: by 2002:a05:620a:2623:b0:92e:7ba3:740d with SMTP id af79cd13be357-93086c1dfb1mr389163985a.68.1784053987420;
        Tue, 14 Jul 2026 11:33:07 -0700 (PDT)
Received: from localhost ([48.45.163.146])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5d6c28bsm1566578185a.46.2026.07.14.11.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 11:33:06 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Matthew Wilcox <willy@infradead.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [RFC PATCH 10/13] mm/kwatch: add anchor thread for global watchpoints
Date: Wed, 15 Jul 2026 02:32:53 +0800
Message-ID: <20260714183253.12848-1-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714182243.10687-1-wangjinchao600@gmail.com>
References: <20260714182243.10687-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Global variables have no function whose execution can bound the
watch window. Provide one: a kernel thread sleeps for the configured
duration inside a dedicated noinline function,
kwatch_global_anchor(), and the probe runtime hooks that function
like any other target.

When the duration expires the thread schedules a work item that
tears the session down; the expired flag is cleared under the
control-plane mutex so a stale work item from a previous session
cannot stop a new one.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kwatch/Makefile |  2 +-
 mm/kwatch/anchor.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+), 1 deletion(-)
 create mode 100644 mm/kwatch/anchor.c

diff --git a/mm/kwatch/Makefile b/mm/kwatch/Makefile
index f04673cc5b1c..b196c794619a 100644
--- a/mm/kwatch/Makefile
+++ b/mm/kwatch/Makefile
@@ -1,3 +1,3 @@
 obj-$(CONFIG_KWATCH) += kwatch.o
 
-kwatch-y := deref.o task_ctx.o hwbp.o probe.o
+kwatch-y := deref.o task_ctx.o hwbp.o probe.o anchor.o
diff --git a/mm/kwatch/anchor.c b/mm/kwatch/anchor.c
new file mode 100644
index 000000000000..11da6aff9413
--- /dev/null
+++ b/mm/kwatch/anchor.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/kthread.h>
+#include <linux/wait.h>
+#include <linux/jiffies.h>
+#include <linux/err.h>
+#include <linux/workqueue.h>
+
+#include "kwatch.h"
+
+static DECLARE_WAIT_QUEUE_HEAD(kwatch_anchor_wq);
+static struct task_struct *kwatch_anchor_tsk;
+static bool kwatch_anchor_expired;
+
+bool kwatch_anchor_has_expired(void)
+{
+	return READ_ONCE(kwatch_anchor_expired);
+}
+
+void kwatch_anchor_clear_expired(void)
+{
+	WRITE_ONCE(kwatch_anchor_expired, false);
+}
+
+static void kwatch_auto_stop_handler(struct work_struct *work)
+{
+	kwatch_auto_stop();
+}
+
+static DECLARE_WORK(kwatch_auto_stop_work, kwatch_auto_stop_handler);
+
+noinline void kwatch_global_anchor(unsigned long duration_sec)
+{
+	wait_event_timeout(kwatch_anchor_wq, kthread_should_stop(),
+			   duration_sec * HZ);
+}
+
+static int kwatch_anchor_thread_fn(void *data)
+{
+	unsigned long duration = (unsigned long)data;
+
+	kwatch_global_anchor(duration);
+
+	if (!kthread_should_stop()) {
+		/* mark before scheduling; cleared under the control mutex */
+		WRITE_ONCE(kwatch_anchor_expired, true);
+		schedule_work(&kwatch_auto_stop_work);
+	}
+
+	while (!kthread_should_stop())
+		schedule_timeout_uninterruptible(HZ);
+
+	return 0;
+}
+
+int kwatch_anchor_start(u16 duration)
+{
+	kwatch_anchor_tsk = kthread_run(kwatch_anchor_thread_fn,
+					(void *)(unsigned long)duration,
+					"kwatch_anchor");
+	if (IS_ERR(kwatch_anchor_tsk)) {
+		int ret = PTR_ERR(kwatch_anchor_tsk);
+
+		kwatch_anchor_tsk = NULL;
+		return ret;
+	}
+	return 0;
+}
+
+void kwatch_anchor_stop(void)
+{
+	if (kwatch_anchor_tsk) {
+		kthread_stop(kwatch_anchor_tsk);
+		kwatch_anchor_tsk = NULL;
+	}
+}
+
+void kwatch_anchor_cancel_work(void)
+{
+	cancel_work_sync(&kwatch_auto_stop_work);
+}
-- 
2.53.0

