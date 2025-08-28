Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325D32E7BC2;
	Thu, 28 Aug 2025 07:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756366476; cv=none; b=kSTIJFv5gA25NnNSQR+ORWfRx1F3SiqkF1m4rAr6biAcxo9+nWmST8dmY4WvuNbw3LLmcDfelNKTVrFxNQnoNyFsXgv2T5Lqe7VG49dc4j93ewIt350cqv8mIs1WWDV94GsD/Pyzxt5tGzyAhg1FyywcLcFi/G4f/G2CrIeWJv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756366476; c=relaxed/simple;
	bh=QgMzLX+EujUl5nFUa6zgdRyiCNDRhy+hzjs8trJUMFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lu3Pp9NGCHnYTg5MgDQr4drg+T9Wmcsd9NYnLr2CHd8eyqinruBkH6uDGR9QULVspK2W30ncsopq2KVUME4BpT/xj28oZapWWkb6/T+E/xlBX3S0eQAgdi+AqrPrKfAy6xuuzKVmWNyl2hxgODBrI3P/782sdZ9JfkCg+FijHss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UuezaxE+; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UuezaxE+"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7720f231174so595454b3a.1;
        Thu, 28 Aug 2025 00:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756366474; x=1756971274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bG7HgZbRDL9zQbYB/rpSIbCyKAIzwo1Rr8phODu9KXc=;
        b=UuezaxE+XgzYLLWHAz1C2s/ScMf/KgV5gqpYUs1j8umvFPgUaeBeJyVmdPI9jppkn/
         PLdBW25I4Bi0Ivc95r+r+n6PMeTx3dYLL3a5xVoXCglRySdzzCTyjUvovBeQ9LS3juoi
         877tBBmZP+j6LFAKRwqtcWmUFjYlDufDTC7RKvn+gNtcC7eWniBhfKrbTqLOmINBQDH1
         N18rrFL17Nv7kbIucCEdslrQLfyK3Otx3gkIwOHhy5NEbTFob3Sjib2ea9WtxL0IvMPC
         qW0lVODFECW/Hp+zq+X8B9A7VdjJ2dbnlw5Q6RLb1WAGUwSmQyqQzIhz5Q9Zc45zZULy
         U2rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756366474; x=1756971274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bG7HgZbRDL9zQbYB/rpSIbCyKAIzwo1Rr8phODu9KXc=;
        b=ctGV5CgYAqURRC98GQ6CeGnew2afLTd4DyArBYoQvFn2wjRf8q0RciGNtJ6TgK9u1+
         PYH0fYtKJjgtY0BNFCcAvGBlgjXZo3UV83HTcu6uVdD+EyaKjC7gahfUs1es+7UJMB+p
         o3ga4JmYeb1mGXs7D8jElZrTcSOEpuhIMJm2CcEu7AVlD8OvSS5uczDXG/xa6ZctRIlN
         1RlmlTF55hMnDQhEi5xNqOlH8rkC6T3XLL4XnQrA6xF8n7KLBoyvKkhNbkBA/CGFcSh0
         CuC9hmoRxi7R9diqI04OvU/4fLbWS3R4xK2ltNHB7569RWzRUjL5Hjt1gfw4q64SXX4k
         VTDg==
X-Forwarded-Encrypted: i=1; AJvYcCX7SsKPuU/zJxye88Y2TcRQDLbKpCTDHTheq0Ug01glAoJ7v3as4lZSnOP8iQWJmx1XYIWIx5t6todPmOKm+GBKqX0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7/OJGk8k/HlwRTavLUPULcNm2+i6BIr5XGV7Dxz1tx9kCXV3f
	Pt0+Wok73l6PXspzuU/MnOLJOU0s8FVK/xDn8BMr1DPd6CNOUr/P10Ti
X-Gm-Gg: ASbGnct67ag45goxYgztAbinQtji37ktY8RIrEUIkw0Lv0I2sW7jbTGltTyEt6ncldy
	HUS3puRA7hf7zuWRyJx+BFzNHp3r6WWepDVTAT9i1B7uSnOhvOq+qnn5aZfF69DzrCnw3Bh2FWY
	uUqi+kK70ajDIueyzjSJ3rf3HQIrRkHzJWbUzgaGSpy9UnI9XH7fMrz0Lhna824axFNjRRs9KeR
	fr1j7KZe6tfKrqk4GXx0gc6vRVXvtHqhYUhp22cs2pqv1Tuq4vJRFe5JIyiXYX2GVnKJxue/Oqw
	yU/LL8K9ko/Q1krqYWBDbkYE7cin2oP4WYOrCESUTIAL7ozwPYNTO0YNRr7HVDLF//xHBHDmhnh
	KCBBshvQpYhAbQX7DiPQ+SCaluJsOsMs6phKiwRyswyz4VwYQL4fAd+w+LKP1
X-Google-Smtp-Source: AGHT+IG2cMUWd4+kNO3PHhwHAxn0aEjXgn4rf+81c8SxWqiq8TRWIkN8Ewenr6E1OgwngH659LqMOg==
X-Received: by 2002:a05:6a20:7f96:b0:243:78a:828d with SMTP id adf61e73a8af0-24340e2a75cmr34553679637.52.1756366474244;
        Thu, 28 Aug 2025 00:34:34 -0700 (PDT)
Received: from localhost.localdomain ([103.88.46.62])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cb8afb7bsm13182613a12.16.2025.08.28.00.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 00:34:33 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"Naveen N . Rao" <naveen@kernel.org>,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH 07/17] mm/ksw: add stack probe support
Date: Thu, 28 Aug 2025 15:32:40 +0800
Message-ID: <20250828073311.1116593-8-wangjinchao600@gmail.com>
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

Introduce stack management for KStackWatch using kprobes and fprobes to
enable dynamic watch switching:

- Entry: prepare target address/length and enable watch
- Exit: disable watch

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/kstackwatch.h |  4 ++
 mm/kstackwatch/stack.c       | 91 ++++++++++++++++++++++++++++++++++++
 2 files changed, 95 insertions(+)

diff --git a/mm/kstackwatch/kstackwatch.h b/mm/kstackwatch/kstackwatch.h
index 13ef8c79f855..bc8664af4fa6 100644
--- a/mm/kstackwatch/kstackwatch.h
+++ b/mm/kstackwatch/kstackwatch.h
@@ -38,6 +38,10 @@ struct ksw_config {
 
 extern bool panic_on_catch;
 
+/* stack management */
+int ksw_stack_init(struct ksw_config *config);
+void ksw_stack_exit(void);
+
 /* watch management */
 int ksw_watch_init(struct ksw_config *config);
 void ksw_watch_exit(void);
diff --git a/mm/kstackwatch/stack.c b/mm/kstackwatch/stack.c
index cec594032515..3b72177315cc 100644
--- a/mm/kstackwatch/stack.c
+++ b/mm/kstackwatch/stack.c
@@ -1 +1,92 @@
 // SPDX-License-Identifier: GPL-2.0
+
+#include <linux/fprobe.h>
+#include <linux/kprobes.h>
+#include <linux/sched.h>
+#include <linux/spinlock.h>
+
+#include "kstackwatch.h"
+
+struct ksw_config *probe_config;
+
+/* prepare watch_addr and watch_len for watch */
+static int ksw_stack_prepare_watch(struct pt_regs *regs,
+				   struct ksw_config *config, u64 *watch_addr,
+				   u64 *watch_len)
+{
+	/* TODO: implement logic */
+	*watch_addr = 0;
+	*watch_len = 0;
+	return 0;
+}
+
+static struct kprobe entry_probe;
+static struct fprobe exit_probe_fprobe;
+
+static void ksw_stack_entry_handler(struct kprobe *p, struct pt_regs *regs,
+				    unsigned long flags)
+{
+	int ret;
+	u64 watch_addr;
+	u64 watch_len;
+
+	ret = ksw_stack_prepare_watch(regs, probe_config, &watch_addr,
+				      &watch_len);
+	if (ret) {
+		pr_err("KSW: failed to prepare watch target: %d\n", ret);
+		return;
+	}
+
+	ret = ksw_watch_on(watch_addr, watch_len);
+	if (ret) {
+		pr_err("KSW: failed to watch on addr:0x%llx len:%llx %d\n",
+		       watch_addr, watch_len, ret);
+		return;
+	}
+}
+
+static void ksw_stack_exit_handler(struct fprobe *fp, unsigned long ip,
+				   unsigned long ret_ip,
+				   struct ftrace_regs *regs, void *data)
+{
+	ksw_watch_off();
+}
+
+int ksw_stack_init(struct ksw_config *config)
+{
+	int ret;
+	char *symbuf = NULL;
+
+	/* Setup entry probe */
+	memset(&entry_probe, 0, sizeof(entry_probe));
+	entry_probe.symbol_name = config->function;
+	entry_probe.offset = config->ip_offset;
+	entry_probe.post_handler = ksw_stack_entry_handler;
+	probe_config = config;
+	ret = register_kprobe(&entry_probe);
+	if (ret < 0) {
+		pr_err("KSW: Failed to register kprobe ret %d\n", ret);
+		return ret;
+	}
+
+	/* Setup exit probe */
+	memset(&exit_probe_fprobe, 0, sizeof(exit_probe_fprobe));
+	exit_probe_fprobe.exit_handler = ksw_stack_exit_handler;
+	symbuf = probe_config->function;
+
+	ret = register_fprobe_syms(&exit_probe_fprobe, (const char **)&symbuf,
+				   1);
+	if (ret < 0) {
+		pr_err("KSW: register_fprobe_syms fail %d\n", ret);
+		unregister_kprobe(&entry_probe);
+		return ret;
+	}
+
+	return 0;
+}
+
+void ksw_stack_exit(void)
+{
+	unregister_fprobe(&exit_probe_fprobe);
+	unregister_kprobe(&entry_probe);
+}
-- 
2.43.0

