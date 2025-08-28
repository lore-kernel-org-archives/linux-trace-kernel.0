Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9C62D94A3;
	Thu, 28 Aug 2025 07:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756366493; cv=none; b=WcfJdwp8LM21VJjRZ4VYVD8wncT692Sr2AMuvVtHZRS2z681OqgWZevNNYMu4+xiqNFM9N14lY7wMNQmET8vS6jEQFiNOfPU7Rys6CilWKJZAQHZRoxksVgMp8Cm4erEo7sQOaitU5QSa+uQGsaa34r+06TG2K0x+4nPDHISWdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756366493; c=relaxed/simple;
	bh=qkcftcj0fqlwmdDkYmum8il+ZDjAfjmbv7Do9ex3a28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nco1ZqHZ4VmCraZ2idEttQrlSEY3FDa7tNiuCnu+JHV/hZzx01aryn45XIOIlDW7CK0KAbna2X8YClz/O9esST90lkT2z3BuOylY4dHox9wiTzCLmFXfA3Pwc8NGkDtxb2kKu1BiUd9XLJelVKUU+YUw+k1FrEX2scerAtjIXjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LADLh5tF; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LADLh5tF"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-771f3f89952so538725b3a.0;
        Thu, 28 Aug 2025 00:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756366491; x=1756971291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HEG4bH5cgwUC7a1orTI7hmUJnz956GpzDiyDWs45yMQ=;
        b=LADLh5tFElhD48ZtlyyGy+OGC5wE7WvrsRF/H8ceHcI+MbEfEdJKVnSR6ZkQDM09qc
         iG5RK+1ri+9F1tk3fN/BwwY4lrXedhCNX5gBHx3kbjsc5AX96fSgtAXv0ox/RsfcKZ/R
         2/6/zK7dQI8DyKNOafpRIkvvvzNH08K7IRpEt8eV2IdOf4R9ADfkoYEwiRz3KnWviHZE
         b33Y3A972+Rroy34vV2XJzxwaVyr0opUkAtIO0icDnah/urdHsptM7ze0l0WAWI7haFr
         dqtBb5u4PT992SwYrc9lMLsjl6dNDPGPqRkq5XXAX1/rqbO/Hhuk5WjXLIb87eP8EmMf
         0rjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756366491; x=1756971291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HEG4bH5cgwUC7a1orTI7hmUJnz956GpzDiyDWs45yMQ=;
        b=ew2uolHx7XMeyUJpqywbpSe2OJ/BQkEKsKyTn6LEnv2JmjR95ftOj9MZN9IKjr6QYE
         PN32e09g+98vBVUVyPMo8JaD+tC7Soo/fNzau/Zwb1F6m0BBoflzrw7XjLmcGTgxYMJi
         Q2lgdS+6JGr2/rYET1j34BWvn5j2i45+dYpH6UrZBOBW+vUspo7/ehIaPBXUqGVwEm4X
         2+0ZWVRs4SZy2h0PvT7VHb3KkaWJKXmhxlIgrfO3kiDT7jBNW6LFcLU1iIFuX6ZmiFxG
         kSCDSTIhZ/iuFIhwHMrsBFr7YCS0cdOvwX/3ljNbTRpcq2Kdl39MLSqpRZih8Y0CCBDm
         jNRw==
X-Forwarded-Encrypted: i=1; AJvYcCUbz+7VcySY59gIJD2bfuBYD7JD83ZLL+PIYFmO6Zos3FVvYESimHpoixrASbC7FoBFAzpRhZDBNZfpJC/s7g5k7Es=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNt2eDdVA+jVqFzT0aaGG7ab98Oqx3gY6XZEizpSJ0B5ZPVnzJ
	mIpCcoYwSPE0+IsYRsZMJ3VMsA6f6R1OAEj3uTS6/pJ9gG24ttluc6WS
X-Gm-Gg: ASbGnctrDXl7gQB5SB4Rf66SkJi0QP7N7OLav0hqJwUPQ6fuZyleUm44CgaNkq388XO
	iTIQsmqJm+rlKbSWgus5ZxMByJ5fkDR5rssK0E4pdGGLmrnbQSjJtVPU9axqLyq4uIoh2TuDHb0
	rhCdi9I04FwGNpe/IJle2ZZxoIuFNWcSkJjUNP5MbdbBOU3cgCQgZQU7cHZKRGfFUWO8MaQDnL2
	V9PfOiFXLgv+qw9VHzIRMgPDvc1w7Pgq54T/M7PvyHiMYWqf9TgwoJgl3ehuC/qohZFd36l6pch
	GIFY6+MPqOTm8/BsDfmsdbaorGg5Rq4fWj/FZG8pWhRllNDzyAZWYFtDq2FSnf8hgbcennTNukG
	lcpfWh/9iowEVA9z8KbLdnrUIPqukmEO5hQt4x4Qjx8OSmOzDRPMpxbCF0FSERxtvFpvuv40=
X-Google-Smtp-Source: AGHT+IFVYiXk5nYF/khbmrTEYSILlLTUA9ybwIqxEMQ2lhYq37r8kAhdhR5nVQny3eugczv3xuUyrQ==
X-Received: by 2002:a05:6a20:a10b:b0:243:50c7:24e5 with SMTP id adf61e73a8af0-2438fad31b4mr15697853637.7.1756366490914;
        Thu, 28 Aug 2025 00:34:50 -0700 (PDT)
Received: from localhost.localdomain ([103.88.46.62])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cb8afb7bsm13182613a12.16.2025.08.28.00.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 00:34:50 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"Naveen N . Rao" <naveen@kernel.org>,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH 12/17] mm/ksw: add test module
Date: Thu, 28 Aug 2025 15:32:45 +0800
Message-ID: <20250828073311.1116593-13-wangjinchao600@gmail.com>
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

Introduce a separate test module to validate KStackWatch functionality in
controlled scenarios, such as stack canary writes and simulated corruption.

The module provides a proc interface (/proc/kstackwatch_test) that allows
triggering specific test cases via simple commands:

 - test0: directly corrupt the canary to verify watch/fire behavior

This helps development and validation of KStackWatch without affecting
normal kernel operation. Test module is built with optimizations disabled
to ensure predictable behavior.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/Kconfig.debug                  |  10 +++
 mm/kstackwatch/Makefile           |   6 +-
 mm/kstackwatch/kstackwatch_test.c | 118 ++++++++++++++++++++++++++++++
 3 files changed, 133 insertions(+), 1 deletion(-)
 create mode 100644 mm/kstackwatch/kstackwatch_test.c

diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
index c2cc8c7b595f..7fdf7b03d458 100644
--- a/mm/Kconfig.debug
+++ b/mm/Kconfig.debug
@@ -319,3 +319,13 @@ config KSTACK_WATCH
 	  the recursive depth of the monitored function.
 
 	  If unsure, say N.
+
+config KSTACK_WATCH_TEST
+	tristate "KStackWatch Test Module"
+	depends on KSTACK_WATCH
+	help
+	  This module provides controlled stack exhaustion and overflow scenarios
+	  to verify the functionality of KStackWatch. It is particularly useful
+	  for development and validation of the KStachWatch mechanism.
+
+	  If unsure, say N.
diff --git a/mm/kstackwatch/Makefile b/mm/kstackwatch/Makefile
index d422f0e114dd..c04c0780da01 100644
--- a/mm/kstackwatch/Makefile
+++ b/mm/kstackwatch/Makefile
@@ -1,4 +1,8 @@
 obj-$(CONFIG_KSTACK_WATCH)	+= kstackwatch.o
 kstackwatch-y := kernel.o stack.o watch.o
 
-CFLAGS_kernel.o := -Wno-error=unused-function
+obj-$(CONFIG_KSTACK_WATCH_TEST)	+= kstackwatch_test.o
+CFLAGS_kstackwatch_test.o := -fno-ipa-sra -fno-inline \
+                             -fno-optimize-sibling-calls \
+                             -fno-section-anchors \
+                             -fno-pic -fno-pie -O0 -Og
diff --git a/mm/kstackwatch/kstackwatch_test.c b/mm/kstackwatch/kstackwatch_test.c
new file mode 100644
index 000000000000..bba2ab8530ed
--- /dev/null
+++ b/mm/kstackwatch/kstackwatch_test.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/compiler.h>
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/kthread.h>
+#include <linux/module.h>
+#include <linux/prandom.h>
+#include <linux/printk.h>
+#include <linux/proc_fs.h>
+#include <linux/random.h>
+#include <linux/sched.h>
+#include <linux/string.h>
+#include <linux/uaccess.h>
+
+#include "kstackwatch.h"
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Jinchao Wang");
+MODULE_DESCRIPTION("Simple KStackWatch Test Module");
+
+static struct proc_dir_entry *test_proc;
+#define BUFFER_SIZE 4
+#define MAX_DEPTH 4
+
+/*
+ * Test Case 0: Write to the canary position directly (Canary Test)
+ * use a u64 buffer array to ensure the canary will be placed
+ * corrupt the stack canary using the debug function
+ */
+static void canary_test_write(void)
+{
+	u64 buffer[BUFFER_SIZE];
+
+	pr_info("KSW: test: starting %s with u64 write\n", __func__);
+	ksw_watch_show();
+	ksw_watch_fire();
+
+	buffer[0] = 0;
+
+	/* make sure the compiler do not drop assign action */
+	barrier_data(buffer);
+	pr_info("KSW: test: canary write test completed\n");
+}
+
+static ssize_t test_proc_write(struct file *file, const char __user *buffer,
+			       size_t count, loff_t *pos)
+{
+	char cmd[256];
+	int test_num;
+
+	if (count >= sizeof(cmd))
+		return -EINVAL;
+
+	if (copy_from_user(cmd, buffer, count))
+		return -EFAULT;
+
+	cmd[count] = '\0';
+	strim(cmd);
+
+	pr_info("KSW: test: received command: %s\n", cmd);
+
+	if (sscanf(cmd, "test%d", &test_num) == 1) {
+		switch (test_num) {
+		case 0:
+			pr_info("KSW: test: triggering canary write test\n");
+			canary_test_write();
+			break;
+
+		default:
+			pr_err("KSW: test: Unknown test number %d\n", test_num);
+			return -EINVAL;
+		}
+	} else {
+		pr_err("KSW: test: invalid command format. Use 'test1', 'test2', or 'test3'.\n");
+		return -EINVAL;
+	}
+
+	return count;
+}
+
+static ssize_t test_proc_read(struct file *file, char __user *buffer,
+			      size_t count, loff_t *pos)
+{
+	static const char usage[] =
+		"KStackWatch Simplified Test Module\n"
+		"==================================\n"
+		"Usage:\n"
+		"  echo 'test0' > /proc/kstackwatch_test  - canary write test\n";
+
+	return simple_read_from_buffer(buffer, count, pos, usage,
+				       strlen(usage));
+}
+
+static const struct proc_ops test_proc_ops = {
+	.proc_read = test_proc_read,
+	.proc_write = test_proc_write,
+};
+
+static int __init kstackwatch_test_init(void)
+{
+	test_proc = proc_create("kstackwatch_test", 0644, NULL, &test_proc_ops);
+	if (!test_proc) {
+		pr_err("KSW: test: Failed to create proc entry\n");
+		return -ENOMEM;
+	}
+	pr_info("KSW: test: Module loaded, use 'cat /proc/kstackwatch_test' for usage\n");
+	return 0;
+}
+
+static void __exit kstackwatch_test_exit(void)
+{
+	if (test_proc)
+		remove_proc_entry("kstackwatch_test", NULL);
+	pr_info("KSW: test: Module unloaded\n");
+}
+
+module_init(kstackwatch_test_init);
+module_exit(kstackwatch_test_exit);
-- 
2.43.0

