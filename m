Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82333218DA;
	Mon, 18 Aug 2025 12:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755520144; cv=none; b=VheYsRb5QlTbm7iFdGaatnorXGfA/iwLutZQHy9Dpw96dljJDg+Kc1nOXkMKdOXm7qWRiTwaWvR/pFqf3wrV2UodrSwQKyM/yeVfy3RN2VkImuBo0+ibvxGF5B65FcClO219dXvdZg8uzZb5gt5bOSEuMuQk/zlQfbZahatc0RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755520144; c=relaxed/simple;
	bh=AhPjh1jqu+DMgB13UXAvI+WqZRRx+dA9LsWO+UiIhTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KaXWoS2sXkddcTJpZiUb+IIQ5PervvRRil5MyqvDgxCMg5fPZtVYGTyVqenJkzlupWIuO1qODBwJURQPH0Mfoc8F6EfoNqYz50QoqcLph0RxXkPAjDrNGUb1eS7JJtv6E/OxDd1OOI8Irn2241TONXkxECVCahUcVjqyXp6lFck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iiFa/cOk; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iiFa/cOk"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-24458194d83so27930315ad.2;
        Mon, 18 Aug 2025 05:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755520142; x=1756124942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iWGhIiUrKxsgr5+uGk+m1lOyTRB3MBYIRFP+EnuGnws=;
        b=iiFa/cOk8uAryGzIhXgg1CQLftEDaGENCoU8cB0/0SOkOTI7ZMrbM0f++gYN85Z0k7
         +MM5ifdpSkq5c/ilbCpL91g5uApnkBUD9j6DRxdzGMRtsToNFa0GQkZKG2xLl4qAyczg
         1maarpGN2GTKyY5FuWufsD5OG1kIIQVSUU7zv5dQgWiZjyF7kVs86sjlCpch4I0vlOiQ
         +DXMuNhLwT7z+hxPKAemCXy65uejpXfoEomO9ls+HM0mG6R4bj6INlbuKTYqgbGtE+Gt
         sIHUcBC+n7SQWs63jsj8BJauitjJ6zQJUU3wkHA4K5XN3puD7BJZy5fA9lD1//rnCOAf
         IxDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755520142; x=1756124942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iWGhIiUrKxsgr5+uGk+m1lOyTRB3MBYIRFP+EnuGnws=;
        b=IvHfd4GNjvytFidvmUw/zHudxwYzVxkKiZQcIJk66TJ7dQyCufwZznEheohJFb7kk4
         lE+Fhlg8ll5nFuka6LcyLOcRP2K2gKOLmepB8R/ujaqg/v1ErSrEQjCYxZTpuH5Nw70b
         vf8FQA3FlPl1fk8I1efnCVA3ZOxGlRGhAYyLGw65S3uePAn/I0kF8SbyysbjfNO78HM4
         ddy/rwjBwGo4e3AGyG/gBz8uonk0gjhLGjwV7q2qYOF1K+fC5oBOMqy9WjTUUMayzemj
         PEbIH25+BCzS8m4BFH6JAmG2TQfh+eocc4R0p1CzlnXit894b0dtGi0ZOGJg7nYu+Zla
         zebg==
X-Forwarded-Encrypted: i=1; AJvYcCVIXgBvhAOx7gb3DIzHDQ+P5ikS08YEHrDTj7Gt3VwHldOY56vhr/3ytLRTxfswQ4Z2jcXwcsuFzIwAcNQ=@vger.kernel.org, AJvYcCWFGl11Ii0oaxIXRe5Wac6TjLdF34Sm9XuhFrSJ8fMPsiLCDjaJ2HTqpNgWnTcvwvioH/wfGT3NcSiVjMES/DDumhug@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5fwiwRXE9YlRxR79B1JPqVo0DVTb+aYafebZO2A52gTwr0at0
	DsEEiroQhX0YBxdOefn1UisYLUPsfouzjOZdGBBj//l0kNsa/1uYULuQ7Cb1eBCwMqloPA==
X-Gm-Gg: ASbGncufzXue/URT4m6LYMKbfJhRkxkXseJ0OSgvj0HF40/BgqfJVDt12JGeK45Evwc
	0GDf+3bR0OTCklHmLLmY8JYCZ2aXLcCvsCUwrE3W7+aRpYCQd7qJef9U5dXGGJcjceCq/JtRSZp
	Bty9gt06o4mhgel9ue4fmu70zHeDMacRhvQOJg6ySgR9s2NaSvIs//hpuKhwl2h9vmuBUlTWtQB
	oFGZ7bDmb0kHIg2/ndFo/Skjb0S0P8PgvuukGn1xgL19nU+OA51sHRb+IjaIDhfxbGp/VHVEcaG
	iDTJEtnLOmjLTOnSK8K4OA3peKSseXB5cin3lIzYPvWxAUcZP9B5G311BhjhXMhepIO4d1KbuAY
	nJDLr3XWQNlIE9vIpG3qsX8A2dylGA5xY5g==
X-Google-Smtp-Source: AGHT+IEtwU3EH40nw5zAQzPHHXzoiBUOdJKizYRpuvX2BrnKPMV4mvfPsFyaNhmOO6WxMZTmIw0cfg==
X-Received: by 2002:a17:903:32c8:b0:240:7fb:cb05 with SMTP id d9443c01a7336-2446d6eeb26mr162548755ad.10.1755520142112;
        Mon, 18 Aug 2025 05:29:02 -0700 (PDT)
Received: from localhost.localdomain ([2604:a840:3::3008])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d57f12esm79236705ad.157.2025.08.18.05.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 05:29:01 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: akpm@linux-foundation.org
Cc: mhiramat@kernel.org,
	naveen@kernel.org,
	davem@davemloft.net,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [RFC PATCH 13/13] mm/kstackwatch: Add a test module and script
Date: Mon, 18 Aug 2025 20:26:18 +0800
Message-ID: <20250818122720.434981-14-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250818122720.434981-13-wangjinchao600@gmail.com>
References: <20250818122720.434981-1-wangjinchao600@gmail.com>
 <20250818122720.434981-2-wangjinchao600@gmail.com>
 <20250818122720.434981-3-wangjinchao600@gmail.com>
 <20250818122720.434981-4-wangjinchao600@gmail.com>
 <20250818122720.434981-5-wangjinchao600@gmail.com>
 <20250818122720.434981-6-wangjinchao600@gmail.com>
 <20250818122720.434981-7-wangjinchao600@gmail.com>
 <20250818122720.434981-8-wangjinchao600@gmail.com>
 <20250818122720.434981-9-wangjinchao600@gmail.com>
 <20250818122720.434981-10-wangjinchao600@gmail.com>
 <20250818122720.434981-11-wangjinchao600@gmail.com>
 <20250818122720.434981-12-wangjinchao600@gmail.com>
 <20250818122720.434981-13-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch introduces a test module and a helper script to verify the
functionality of the KStackWatch debugging tool.

The `kstackwatch_test.c` module provides a set of controlled scenarios for
stack-related issues, including:
- Direct write using ksw_watch_fire().
- Intentional stack overflow.
- Corruption of a local variable from another thread.
- Recursive function calls to test nested stack frames.

The accompanying `kstackwatch_test.sh` script automates the process of
loading the test module, configuring the KStackWatch tool via its debugfs
interface, and triggering each test case. This script also includes
instructions for users to find the necessary offsets for their specific
kernel build.

This dedicated test module and script significantly aid in the development,
validation, and long-term maintenance of the KStackWatch tool.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/Kconfig.debug                      |  11 ++
 mm/kstackwatch/Makefile               |   8 +
 mm/kstackwatch/kstackwatch_test.c     | 237 ++++++++++++++++++++++++++
 tools/kstackwatch/kstackwatch_test.sh | 122 +++++++++++++
 4 files changed, 378 insertions(+)
 create mode 100644 mm/kstackwatch/kstackwatch_test.c
 create mode 100644 tools/kstackwatch/kstackwatch_test.sh

diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
index dd9c1bb7f549..5e9402e39001 100644
--- a/mm/Kconfig.debug
+++ b/mm/Kconfig.debug
@@ -321,3 +321,14 @@ config KSTACK_WATCH
 	  which is useful for debugging stability issues.
 
 	  If unsure, say N.
+
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
index 076822eb7661..5e63e8c2e7c0 100644
--- a/mm/kstackwatch/Makefile
+++ b/mm/kstackwatch/Makefile
@@ -1,3 +1,11 @@
 obj-$(CONFIG_KSTACK_WATCH)	+= kstackwatch.o
 
 kstackwatch-y := kernel.o stack.o watch.o
+
+obj-$(CONFIG_KSTACK_WATCH_TEST)	+= kstackwatch_test.o
+
+kstackwatch-y := kernel.o stack.o watch.o
+CFLAGS_kstackwatch_test.o := -fno-ipa-sra -fno-inline \
+                             -fno-optimize-sibling-calls \
+                             -fno-section-anchors \
+                             -fno-pic -fno-pie
diff --git a/mm/kstackwatch/kstackwatch_test.c b/mm/kstackwatch/kstackwatch_test.c
new file mode 100644
index 000000000000..c21618ca0c8b
--- /dev/null
+++ b/mm/kstackwatch/kstackwatch_test.c
@@ -0,0 +1,237 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/proc_fs.h>
+#include <linux/uaccess.h>
+#include <linux/string.h>
+#include <linux/kthread.h>
+#include <linux/delay.h>
+#include <linux/sched.h>
+
+#include "kstackwatch.h"
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Jinchao Wang");
+MODULE_DESCRIPTION("Simplified KStackWatch Test Module ");
+
+static struct proc_dir_entry *test_proc;
+#define BUFFER_SIZE 4
+#define MAX_DEPTH 4
+
+/* Global variables for multi-thread test synchronization */
+static u64 *g_corrupt_ptr;
+static struct completion g_wait_for_init;
+
+/*
+ * Test Case 0: Write to the canary position directly (Canary Test)
+ * This function uses a u64 buffer
+ * 64-bit write, corrupting the stack canary with a single operation.
+ */
+static void canary_test_write(void)
+{
+	u64 buffer[BUFFER_SIZE];
+
+	pr_info("KStackWatch Test: Starting %s with u64 write\n", __func__);
+	ksw_watch_show();
+	ksw_watch_fire();
+
+	buffer[0] = 0;
+	/* make sure the compiler do not drop assign action */
+	barrier_data(buffer);
+	pr_info("KStackWatch Test: Canary write test completed\n");
+}
+
+/*
+ * Test Case 1: Stack Overflow (Canary Test)
+ * This function uses a u64 buffer
+ * 64-bit write, corrupting the stack canary with a single operation.
+ */
+static void canary_test_overflow(void)
+{
+	u64 buffer[BUFFER_SIZE];
+
+	pr_info("KStackWatch Test: Starting %s with u64 write\n", __func__);
+	pr_info("KStackWatch Test: buffer 0x%px\n", buffer);
+
+	/* Intentionally overflow the u64 buffer. */
+	buffer[BUFFER_SIZE] = 0xdeadbeefdeadbeef;
+
+	/* make sure the compiler do not drop assign action */
+	barrier_data(buffer);
+
+	pr_info("KStackWatch Test: Canary overflow test completed\n");
+}
+
+/*
+ * Corrupts the variable on multi_thread_corruption_test's stack
+ */
+static int multi_thread_corruption_thread2(void *data)
+{
+	pr_info("KStackWatch Test: Starting %s\n", __func__);
+
+	wait_for_completion(&g_wait_for_init);
+
+	pr_info("KStackWatch Test: Thread2  woke up. Corrupting variable at 0x%px\n",
+		g_corrupt_ptr);
+	if (g_corrupt_ptr)
+		*g_corrupt_ptr = 0xdeadbeefdeadbeef;
+
+	pr_info("KStackWatch Test: Thread2 finished corruption\n");
+
+	return 0;
+}
+
+/*
+ * Test Case 2: Multi-threaded Local Variable Corruption
+ * multi_thread_corruption_test initializes a local variable
+ * makes its address globally available,
+ * and then sleeps. Thread B corrupts it.
+ */
+static void multi_thread_corruption_thread1(void)
+{
+	u64 local_var = 0x1234567887654321;
+
+	pr_info("KStackWatch Test: Starting %s\n", __func__);
+
+	pr_info("KStackWatch Test: Thread1 local_var address: 0x%px, value: 0x%llx\n",
+		&local_var, local_var);
+	WRITE_ONCE(g_corrupt_ptr, &local_var);
+
+	/* Signal Thread 2 that the pointer is ready, then sleep */
+	complete(&g_wait_for_init);
+	msleep(1000);
+
+	pr_info("KStackWatch Test: Thread1 woke up. Final local_var value: 0x%llx\n",
+		local_var);
+}
+
+static void multi_thread_corruption_test(void)
+{
+	struct task_struct *corrupt_thread;
+
+	pr_info("KStackWatch Test: Starting %s\n", __func__);
+
+	/* Reset completion */
+	init_completion(&g_wait_for_init);
+
+	corrupt_thread = kthread_run(multi_thread_corruption_thread2, NULL,
+				     "corruption_b");
+	if (IS_ERR(corrupt_thread)) {
+		pr_err("KStackWatch Test: Failed to create corruption thread\n");
+		return;
+	}
+	multi_thread_corruption_thread1();
+}
+
+/*
+ * Test Case 3: Recursive Call Corruption
+ * This function calls itself recursively and corrupts the stack at a specific depth.
+ * This tests whether KStackWatch can handle dynamic stack frames.
+ */
+static void recursive_corruption_test(int depth)
+{
+	u64 buffer[BUFFER_SIZE];
+
+	pr_info("KStackWatch Test: Recursive call at depth %d\n", depth);
+	pr_info("KStackWatch Test: buffer 0x%px\n", buffer);
+	if (depth <= MAX_DEPTH)
+		recursive_corruption_test(depth + 1);
+
+	buffer[0] = depth;
+
+	/* make sure the compiler do not drop assign action */
+	barrier_data(buffer);
+
+	pr_info("KStackWatch Test: Returning from depth %d\n", depth);
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
+	pr_info("KStackWatch Test: Received command: %s\n", cmd);
+
+	if (sscanf(cmd, "test%d", &test_num) == 1) {
+		switch (test_num) {
+		case 0:
+			pr_info("KStackWatch Test: Triggering canary write test\n");
+			canary_test_write();
+			break;
+		case 1:
+			pr_info("KStackWatch Test: Triggering canary overflow test\n");
+			canary_test_overflow();
+			break;
+		case 2:
+			pr_info("KStackWatch Test: Triggering local variable corruption test\n");
+			multi_thread_corruption_test();
+			break;
+		case 3:
+			pr_info("KStackWatch Test: Triggering recursive corruption test\n");
+			/* depth start with 0 */
+			recursive_corruption_test(0);
+			break;
+		default:
+			pr_err("KStackWatch Test: Unknown test number %d\n",
+			       test_num);
+			return -EINVAL;
+		}
+	} else {
+		pr_err("KStackWatch Test: Invalid command format. Use 'test1', 'test2', or 'test3'.\n");
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
+		"  echo 'test0' > /proc/kstackwatch_test  - Canary test test\n"
+		"  echo 'test1' > /proc/kstackwatch_test  - Canary overflow test\n"
+		"  echo 'test2' > /proc/kstackwatch_test  - Multi-threaded local variable corruption test\n"
+		"  echo 'test3' > /proc/kstackwatch_test  - Recursive corruption test\n";
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
+		pr_err("KStackWatch Test: Failed to create proc entry\n");
+		return -ENOMEM;
+	}
+	pr_info("KStackWatch Test: Module loaded, use 'cat /proc/kstackwatch_test' for usage\n");
+	return 0;
+}
+
+static void __exit kstackwatch_test_exit(void)
+{
+	if (test_proc)
+		remove_proc_entry("kstackwatch_test", NULL);
+	pr_info("KStackWatch Test: Module unloaded\n");
+}
+
+module_init(kstackwatch_test_init);
+module_exit(kstackwatch_test_exit);
diff --git a/tools/kstackwatch/kstackwatch_test.sh b/tools/kstackwatch/kstackwatch_test.sh
new file mode 100644
index 000000000000..33ca590b7374
--- /dev/null
+++ b/tools/kstackwatch/kstackwatch_test.sh
@@ -0,0 +1,122 @@
+#!/bin/bash
+
+# --- Usage function ---
+usage() {
+    echo "======================================"
+    echo "  KStackWatch Test Script Usage"
+    echo "======================================"
+    echo ""
+    echo "IMPORTANT: Before running, make sure you have updated the offset values!"
+    echo ""
+    echo "To find your offsets, use objdump:"
+    echo "  objdump -S --disassemble=canary_test_write vmlinux"
+    echo ""
+    echo "Then search for your function names to find the instruction addresses."
+    echo "- Instruction offset: address relative to function's start"
+    echo "- Stack var offset: distance from stack base (%rbp) to the variable"
+    echo ""
+    echo "Usage: $0 [test_case_number]"
+    echo ""
+    echo "Available test cases:"
+    echo "  0  - Canary Write Test"
+    echo "  1  - Canary Overflow Test"
+    echo "  2  - Multi-threaded Local Variable Corruption Test"
+    echo "  3  - Recursive Corruption Test"
+    echo ""
+    echo "======================================"
+    echo ""
+}
+
+# --- Interactive menu ---
+show_menu() {
+    echo "Select a test case to run:"
+    echo "  0) Canary Write Test"
+    echo "  1) Canary Overflow Test"
+    echo "  2) Multi-threaded Local Variable Corruption Test"
+    echo "  3) Recursive Corruption Test"
+    echo "  q) Quit"
+    echo ""
+    echo "WARNING: Each test may cause system crash/hang!"
+    echo ""
+    read -p "Enter your choice [0-3/q]: " choice
+    echo ""
+
+    case "$choice" in
+        0) test0 ;;
+        1) test1 ;;
+        2) test2 ;;
+        3) test3 ;;
+        q|Q) echo "Exiting..."; exit 0 ;;
+        *) echo "Invalid choice. Please try again."; echo ""; show_menu ;;
+    esac
+}
+
+# --- Test Case 0: Canary Write ---
+test0() {
+    echo "=== Running Test Case 0: Canary Write ==="
+    # function+instruction_off[+depth] [local_var_offset:local_var_len]
+    echo "canary_test_write+0x19" > /proc/kstackwatch
+    echo "test0" > /proc/kstackwatch_test
+    echo ""
+    echo "-------------------------------------"
+    echo ""
+}
+
+# --- Test Case 1: Canary Overflow ---
+test1() {
+    echo "=== Running Test Case 1: Canary Overflow ==="
+    # function+instruction_off[+depth] [local_var_offset:local_var_len]
+    echo "canary_test_overflow+0x19" > /proc/kstackwatch
+    echo "test1" > /proc/kstackwatch_test
+    echo ""
+    echo "-------------------------------------"
+    echo ""
+}
+
+# --- Test Case 2: Multi-threaded Local Variable Corruption ---
+test2() {
+    echo "=== Running Test Case 2: Multi-threaded Corruption ==="
+    # function+instruction_off[+depth] [local_var_offset:local_var_len]
+    echo "multi_thread_corruption_thread1+0x2b 0:8" > /proc/kstackwatch
+    echo "test2" > /proc/kstackwatch_test
+    echo ""
+    echo "-------------------------------------"
+    echo ""
+}
+
+# --- Test Case 3: Recursive Corruption ---
+test3() {
+    echo "=== Running Test Case 3: Recursive Corruption ==="
+    # function+instruction_off[+depth] [local_var_offset:local_var_len]
+    echo "recursive_corruption_test+0x2b+3 0:8"  > /proc/kstackwatch
+    echo "test3" > /proc/kstackwatch_test
+    echo ""
+    echo "-------------------------------------"
+    echo ""
+}
+
+# --- Run all tests ---
+# Removed: These tests cause system crashes and should not be run sequentially
+
+echo 7 > /proc/sys/kernel/printk
+
+# --- Main ---
+if [ -z "$1" ]; then
+    usage
+    echo ""
+    show_menu
+else
+    case "$1" in
+        0) test0 ;;
+        1) test1 ;;
+        2) test2 ;;
+        3) test3 ;;
+        help|--help|-h) usage ;;
+        *)
+            echo "Error: Invalid argument '$1'"
+            echo ""
+            usage
+            exit 1
+            ;;
+    esac
+fi
-- 
2.43.0

