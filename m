Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AA12D6E59;
	Thu, 28 Aug 2025 07:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756366455; cv=none; b=rrHw0Cz+gQWRUi2y1KmwCYmU37NTihTBqB48f2YLnDegqx8zUAxWcfndOSgzFh4/39frwt1Z/fO4adQ9immx0ZPNJtdJZwO6vJ9Jmi4iLUlz4S+dXeeP5Wl/IJgg+FfyTOvWJzPDi/zzDnCxlpEDjNGArcukT6/OQPVRHFbHPPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756366455; c=relaxed/simple;
	bh=tBX0hO0TjzB27+2RjkvnkUfPVj0tB9UkFzjloHpm/as=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nlpg/PkGvkQ8/v5l4fTrfuJp7o78ZowDBOeNsgwN+nNdjbMCkIM4+zZkZkNmBNM0MS09OUNXNn12tAF9VNbsfWdAc3QwHYM+38NWEN4lxVb2w6KFBAOkW3JDxD2py0gIFgJFQjXn3G5z1vdWLMfhm+HnB2cPeUlq1YOaYBsvrxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jCIc+nIx; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCIc+nIx"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7721b8214d4so245498b3a.2;
        Thu, 28 Aug 2025 00:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756366452; x=1756971252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lhhrrRkb4F3PyX047v9pUxx2LHKmYVjN4mot0t9leaw=;
        b=jCIc+nIxa/rDXdjBbrPa+HJceSgm/8kH3z0RtuRzyzcaOGhOzpsRpzkvngKYtJrASW
         +Iiqh+B4GB0vb1QiD3sO6b30mp1Zlqe5EMzoNXqHLHRYvUeiy/tqLQDRl5FKn+zfAwCb
         zNzg7cmp0oveoEMlqD579/2BdjlWk7E8walrpWG6LWRzrNG/0fxnIGIXZm0lBDkfGHh4
         PZ42AFeqLfH7lZaffRzp9wmCiSEaEHzYyvU4KpGvtcuAx01Oq74Vk675hA6CI9jiJYbC
         gLlP+4GuxAL6BLlCWeAl2xmNjBRgnEIzIqhjgLojTpLAF7V5+DTc/xtJy90Of1FrDVKA
         Z3RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756366452; x=1756971252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lhhrrRkb4F3PyX047v9pUxx2LHKmYVjN4mot0t9leaw=;
        b=HU0e7qWope8TxCyMBqbjXo+ptJxpOQjdrJfZMAqAM9vByLKrdG6TeZxRyFQZjQoEQM
         TnMYqs4AwHRPciCGYSXrVuTqbRvbjyiquwf//1asGdtc/2WgyAC8h5aNUaY+Q2RT4o51
         cA/8nmYJlP0EMo94GdzzCHU1WSXk17VcqEZw9jvsNwX3fA9yp/GQ/VveAr9UbZ9rCFw8
         9lrHu8Sg25vqgponQdKa2OQKWiwH/pP/1BT2HRfolW3NsjjxHpGEkZo27qR4++9/Mlte
         /r/Leyh7pLJSEad+XoxdNyhb2gN1m3+ym2cnxZGD9PfQQF1xVPMIZQqxCGZnZajo1QSy
         UxFw==
X-Forwarded-Encrypted: i=1; AJvYcCVQz46gqNnCMl7e9OUYympQZrhGR2FIT71J60UlgocaY3DDH26LPZpL6E5kBl2a71N/krtgWnvUaXricAUQdDIWRDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YynUONJopEi3cqAYPhi7imioiRqfSt94H4NkVQy0T29gPT3gjMk
	yx1KJm70+lTRoNswJ7jjpSny84fxfPZLoM9iNyp6VuFRIx2Yp62voz8f
X-Gm-Gg: ASbGncvP5matwlzlRwYXpm+wrMkUTdS4l5RY4ZD41XGFY0HQgH2vG/pMTy7UQoMg+Qw
	lqHHD2o9vQb/43mUq/kyZz7YN0wMdoMpuOPgQ92/wZCDCO8S95/wvmoMQC/scAk5XXMqfOWy5/M
	znW7AQc3VXE06uc9hXtbB7E6d7TRCa5XaS1BPDMYPVZAuHcHzEx0v9VhxCjwI0bgEAWZthACNMf
	v96VYHyqnnsrj9r2pxqTGnthQwI9itSE9Q9LbEV12V3g+RKJ7gglNt54gCTC3aFDbO3FefvqOgk
	8uJZ3b5bsorDcOF3EAFVVsPxkybkzHoxzJFcJeCe8s9xlVZQ5wTDB7XIbsET1D5lHz9fGsY2sDM
	6MXsW11Nig6jzRiRV/LqmG2q5+DKW0qYhi4ClikEWGZN2JT+P/7CjraR5LWul
X-Google-Smtp-Source: AGHT+IFW8MIhp5lAtNEt+uw+DAmzNYmf1p0SiEn72vtOqZ4l+f/YrYQksgLtRZc7uoqAe8mYBAPXtg==
X-Received: by 2002:a05:6a20:914d:b0:243:a52d:7a70 with SMTP id adf61e73a8af0-243a52d7b0dmr6549481637.3.1756366452260;
        Thu, 28 Aug 2025 00:34:12 -0700 (PDT)
Received: from localhost.localdomain ([103.88.46.62])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cb8afb7bsm13182613a12.16.2025.08.28.00.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 00:34:11 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"Naveen N . Rao" <naveen@kernel.org>,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH 01/17] mm/ksw: add build system support
Date: Thu, 28 Aug 2025 15:32:34 +0800
Message-ID: <20250828073311.1116593-2-wangjinchao600@gmail.com>
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

Add Kconfig and Makefile infrastructure for KStackWatch, a real-time tool
for debugging kernel stack corruption.

The implementation is located under `mm/kstackwatch/`.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/Kconfig.debug             | 10 ++++++++++
 mm/Makefile                  |  1 +
 mm/kstackwatch/Makefile      |  2 ++
 mm/kstackwatch/kernel.c      | 24 ++++++++++++++++++++++++
 mm/kstackwatch/kstackwatch.h |  5 +++++
 mm/kstackwatch/stack.c       |  1 +
 mm/kstackwatch/watch.c       |  1 +
 7 files changed, 44 insertions(+)
 create mode 100644 mm/kstackwatch/Makefile
 create mode 100644 mm/kstackwatch/kernel.c
 create mode 100644 mm/kstackwatch/kstackwatch.h
 create mode 100644 mm/kstackwatch/stack.c
 create mode 100644 mm/kstackwatch/watch.c

diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
index 32b65073d0cc..c2cc8c7b595f 100644
--- a/mm/Kconfig.debug
+++ b/mm/Kconfig.debug
@@ -309,3 +309,13 @@ config PER_VMA_LOCK_STATS
 	  overhead in the page fault path.
 
 	  If in doubt, say N.
+
+config KSTACK_WATCH
+	tristate "Kernel Stack Watch"
+	depends on STACKPROTECTOR && HAVE_HW_BREAKPOINT && KPROBES && FPROBE
+	help
+	  A lightweight real-time debugging tool to detect stack corruption.
+	  It can watch either the canary or local variable and tracks
+	  the recursive depth of the monitored function.
+
+	  If unsure, say N.
diff --git a/mm/Makefile b/mm/Makefile
index ef54aa615d9d..665c9f2bf987 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -92,6 +92,7 @@ obj-$(CONFIG_PAGE_POISONING) += page_poison.o
 obj-$(CONFIG_KASAN)	+= kasan/
 obj-$(CONFIG_KFENCE) += kfence/
 obj-$(CONFIG_KMSAN)	+= kmsan/
+obj-$(CONFIG_KSTACK_WATCH)	+= kstackwatch/
 obj-$(CONFIG_FAILSLAB) += failslab.o
 obj-$(CONFIG_FAIL_PAGE_ALLOC) += fail_page_alloc.o
 obj-$(CONFIG_MEMTEST)		+= memtest.o
diff --git a/mm/kstackwatch/Makefile b/mm/kstackwatch/Makefile
new file mode 100644
index 000000000000..84a46cb9a766
--- /dev/null
+++ b/mm/kstackwatch/Makefile
@@ -0,0 +1,2 @@
+obj-$(CONFIG_KSTACK_WATCH)	+= kstackwatch.o
+kstackwatch-y := kernel.o stack.o watch.o
diff --git a/mm/kstackwatch/kernel.c b/mm/kstackwatch/kernel.c
new file mode 100644
index 000000000000..93379a0a0f7e
--- /dev/null
+++ b/mm/kstackwatch/kernel.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/module.h>
+
+MODULE_AUTHOR("Jinchao Wang");
+MODULE_DESCRIPTION("Kernel Stack Watch");
+MODULE_LICENSE("GPL");
+
+static int __init kstackwatch_init(void)
+{
+	pr_info("KSW: module loaded\n");
+	pr_info("KSW: usage:\n");
+	pr_info("KSW: echo 'function+ip_offset[+depth] [local_var_offset:local_var_len]' > /proc/kstackwatch\n");
+
+	return 0;
+}
+
+static void __exit kstackwatch_exit(void)
+{
+	pr_info("KSW: Module unloaded\n");
+}
+
+module_init(kstackwatch_init);
+module_exit(kstackwatch_exit);
diff --git a/mm/kstackwatch/kstackwatch.h b/mm/kstackwatch/kstackwatch.h
new file mode 100644
index 000000000000..0273ef478a26
--- /dev/null
+++ b/mm/kstackwatch/kstackwatch.h
@@ -0,0 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _KSTACKWATCH_H
+#define _KSTACKWATCH_H
+
+#endif /* _KSTACKWATCH_H */
diff --git a/mm/kstackwatch/stack.c b/mm/kstackwatch/stack.c
new file mode 100644
index 000000000000..cec594032515
--- /dev/null
+++ b/mm/kstackwatch/stack.c
@@ -0,0 +1 @@
+// SPDX-License-Identifier: GPL-2.0
diff --git a/mm/kstackwatch/watch.c b/mm/kstackwatch/watch.c
new file mode 100644
index 000000000000..cec594032515
--- /dev/null
+++ b/mm/kstackwatch/watch.c
@@ -0,0 +1 @@
+// SPDX-License-Identifier: GPL-2.0
-- 
2.43.0

