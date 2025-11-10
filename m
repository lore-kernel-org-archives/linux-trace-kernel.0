Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87820322DD1
	for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Nov 2025 16:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762792698; cv=none; b=E71+uLeTBRBVOsmVFu2LhGgFJStveBpX17RVunI6HdZdftM2UHw80NX/kGbUQuvd7xpgKO9+BXICOjs06x/7uG3Xqo9iq4Hyppu9h6nUVJZ+VrkSQ66HKPuAnD+amz0tgltZ8MJcqQpy032qJIwTFAT/IUoVQB6SkPsvFwcMS2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762792698; c=relaxed/simple;
	bh=5B8MAc8YcV00iMizH11Y40qRDHrUmpg3vQMS9397iuY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mB7AL3nV1Vaw5i1nydKgXRjXWbPgclnlSlLsNOx3fQvbJFk9EZs+RDacm///wB4uDgAWOqAq3ZFgq6nM8fzKAM+ZS8KwusqKplnIhy2G8FtikYeRRa98xfTHMF1YwV2xyxzVSlNIIzCNGwtEw+XvTfa2OZMGDl31WvVT0HUiKSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dhE5kNYp; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhE5kNYp"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-781997d195aso2063777b3a.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762792695; x=1763397495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LZgTPWUg6fgnNgIWmgc5f2sdICO+ed5Q8W3qiS9yQCY=;
        b=dhE5kNYpjcgzW4+jT3t75DgtPHRNDulghdJNU4syvwxVqwcN5GZ5MnQml+QTDXEN32
         OQ6/yX3unKQE8qHk1cK/56FZkvcAR7pcXu82CvV7D8PhM+wWIJmUCF1SuwBsNTgrDYLW
         ER0FyTXwlKXKNSg77MybeBE1lZ3mQvGGuwy0LEqx2WJk8jmAH7+nt+GfjXfu2Bc22tv3
         tSY8rwid2YVNpR1m7qazEf0MkWOOtAuhhkcs8v41ZxK15fRbcJMQKln6pfdYP+5JlB9V
         Q/pVSABTvhFQTOpEtG2+jfzlSWDrO6e9rkReJRARHKiqUSsJ5/GOamshvWlzgOtY+jCw
         05iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762792695; x=1763397495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LZgTPWUg6fgnNgIWmgc5f2sdICO+ed5Q8W3qiS9yQCY=;
        b=E1TcD6/YvhbaG6C20hkpJ01N+lE4W3CLBKQtWCN/WVAH3EVzZcNhimKN5NtE339M3c
         avlKa+dFdGfAUG/U9ZMz9bsf7YNeQOTaKBQe+30Soadsad/mhtizRoVXyzWb3Q3kZX5Z
         MJntDyaSEGkIuFu5PXLrnW2GD1hbxZ/GI8IICSkqkDZsRZr8sFbgwEBbbhiji4PgLMTa
         rcN980Fnqd4/XwlvgQarASNZ7dO9gAZZZJ9IZAmEVB8V/uihFq6mKDfaL3yllHg/xNl5
         a9x3NOsgSAQ9ReqEgiqpc1sIBYBXWI28D4qxDNcz87wN/nXMep4/CcR8VjUNGq8OH1MA
         d8AQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCSnFQceFkc7C+qXaVzLAOEso5mvZ8y63afq7uj6cUCGsELKSCdeT4BIKaz54kPSnSGmf4bXHOoRjphVTIE6JyHuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGgGthjnvoZPKsemdolf24i4qa0Ddp/q1Zah8KESTSGEUZgkWY
	LWVqLa2QS6wj7PUDICwxbksGQ6MVia9UOJcc3hUqJQ87rmaOgcvwFJ8W
X-Gm-Gg: ASbGncsyQD7yANMnnWNA/aJWBWslytvncsDoEZ4JpvP2r29IUCfw9qRiGbs+niZ4k2U
	wnQE6HqhRgOkijA7JC/vWNoDCY0lsF/2y2582i9vx4u92OFd1/Vk2zinkIk1EAUmv0XRDl+q22f
	huMTo56DMB4gd0KA/kHaBQ9uNmPNZPEqwqDAib1m5zX85icKfmFM/82ABuuiVV6npktbw6pfInj
	KnD1meZjYbgcBZRtUA+R0DGaSZR36qca65RG2Np28eFV4l/kU106CNqHw4U+lgYKRdEHaBOAd02
	X2pIehmK8t/NkxkZ0RgHAHtuv8T/d5WZtaBcX3eNQ+9AZlncCChxKnH4szVpu5hhcU9E4/SikoW
	tosaGRhUsyvRppcG0K87aXL/vF3M3pDkpBAM5gkyD056s1vyVVgfe+faTvng/dE79dw9q/PcKd0
	zoUF1ODASLnxZZ1Mx4ymcJ4g==
X-Google-Smtp-Source: AGHT+IEM5Su6Hnp4ru+i7ZTcc23vkwmNQiSNdXgOr/mmO6C717GoWpmDkvA/Iw9C6gak0AA7kGqiVQ==
X-Received: by 2002:a17:903:244a:b0:295:59ef:809e with SMTP id d9443c01a7336-297e564e380mr115227515ad.24.1762792694655;
        Mon, 10 Nov 2025 08:38:14 -0800 (PST)
Received: from localhost ([103.88.46.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c953d0a6sm12288816b3a.12.2025.11.10.08.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 08:38:14 -0800 (PST)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Marco Elver <elver@google.com>,
	Mike Rapoport <rppt@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ben Segall <bsegall@google.com>,
	Bill Wendling <morbo@google.com>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	David Kaplan <david.kaplan@amd.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ian Rogers <irogers@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>,
	Jinchao Wang <wangjinchao600@gmail.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Juri Lelli <juri.lelli@redhat.com>,
	Justin Stitt <justinstitt@google.com>,
	kasan-dev@googlegroups.com,
	Kees Cook <kees@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	"Liang Kan" <kan.liang@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mel Gorman <mgorman@suse.de>,
	Michal Hocko <mhocko@suse.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nam Cao <namcao@linutronix.de>,
	Namhyung Kim <namhyung@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Rong Xu <xur@google.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Will Deacon <will@kernel.org>,
	workflows@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v8 21/27] mm/ksw: add test module
Date: Tue, 11 Nov 2025 00:36:16 +0800
Message-ID: <20251110163634.3686676-22-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251110163634.3686676-1-wangjinchao600@gmail.com>
References: <20251110163634.3686676-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a standalone test module for KStackWatch to validate functionality
in controlled scenarios.

The module exposes a simple interface via debugfs
(/sys/kernel/debug/kstackwatch/test), allowing specific test cases to
be triggered with commands such as:

  echo test0 > /sys/kernel/debug/kstackwatch/test

To ensure predictable behavior during testing, the module is built with
optimizations disabled.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>

show addr of buf and watch_addr of test case
---
 include/linux/kstackwatch.h |   2 +
 mm/kstackwatch/Kconfig      |  10 +++
 mm/kstackwatch/Makefile     |   6 ++
 mm/kstackwatch/kernel.c     |   5 ++
 mm/kstackwatch/test.c       | 121 ++++++++++++++++++++++++++++++++++++
 5 files changed, 144 insertions(+)
 create mode 100644 mm/kstackwatch/test.c

diff --git a/include/linux/kstackwatch.h b/include/linux/kstackwatch.h
index 6daded932ba6..7711efe85240 100644
--- a/include/linux/kstackwatch.h
+++ b/include/linux/kstackwatch.h
@@ -40,6 +40,8 @@ struct ksw_config {
 
 // singleton, only modified in kernel.c
 const struct ksw_config *ksw_get_config(void);
+struct dentry *ksw_get_dbgdir(void);
+
 
 /* stack management */
 int ksw_stack_init(void);
diff --git a/mm/kstackwatch/Kconfig b/mm/kstackwatch/Kconfig
index 3c9385a15c33..343b492ddbd3 100644
--- a/mm/kstackwatch/Kconfig
+++ b/mm/kstackwatch/Kconfig
@@ -22,3 +22,13 @@ config KSTACKWATCH_PROFILING
 	  stopping. Useful for performance tuning, not for production use.
 
 	  If unsure, say N.
+
+config KSTACKWATCH_TEST
+	tristate "KStackWatch Test Module"
+	depends on KSTACKWATCH
+	help
+	  This module provides controlled stack corruption scenarios to verify
+	  the functionality of KStackWatch. It is useful for development and
+	  validation of KStackWatch mechanism.
+
+	  If unsure, say N.
diff --git a/mm/kstackwatch/Makefile b/mm/kstackwatch/Makefile
index c99c621eac02..a2c7cd647f69 100644
--- a/mm/kstackwatch/Makefile
+++ b/mm/kstackwatch/Makefile
@@ -1,2 +1,8 @@
 obj-$(CONFIG_KSTACKWATCH)	+= kstackwatch.o
 kstackwatch-y := kernel.o stack.o watch.o
+
+obj-$(CONFIG_KSTACKWATCH_TEST)	+= kstackwatch_test.o
+kstackwatch_test-y := test.o
+CFLAGS_test.o := -fno-inline \
+		-fno-optimize-sibling-calls \
+		-fno-pic -fno-pie -O0 -Og
diff --git a/mm/kstackwatch/kernel.c b/mm/kstackwatch/kernel.c
index a0e676e60692..b25cf6830b15 100644
--- a/mm/kstackwatch/kernel.c
+++ b/mm/kstackwatch/kernel.c
@@ -235,6 +235,11 @@ const struct ksw_config *ksw_get_config(void)
 	return ksw_config;
 }
 
+struct dentry *ksw_get_dbgdir(void)
+{
+	return dbgfs_dir;
+}
+
 static int __init kstackwatch_init(void)
 {
 	int ret = 0;
diff --git a/mm/kstackwatch/test.c b/mm/kstackwatch/test.c
new file mode 100644
index 000000000000..2969564b1a00
--- /dev/null
+++ b/mm/kstackwatch/test.c
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/debugfs.h>
+#include <linux/delay.h>
+#include <linux/kthread.h>
+#include <linux/kstackwatch.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/prandom.h>
+#include <linux/printk.h>
+#include <linux/random.h>
+#include <linux/spinlock.h>
+#include <linux/string.h>
+#include <linux/uaccess.h>
+
+static struct dentry *test_file;
+
+#define BUFFER_SIZE 32
+
+static void test_watch_fire(void)
+{
+	u64 buffer[BUFFER_SIZE] = { 0 };
+
+	pr_info("entry of %s\n", __func__);
+	ksw_watch_show();
+	pr_info("buf: 0x%px\n", buffer);
+
+	ksw_watch_fire();
+
+	barrier_data(buffer);
+	pr_info("exit of %s\n", __func__);
+}
+
+static ssize_t test_dbgfs_write(struct file *file, const char __user *buffer,
+				size_t count, loff_t *pos)
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
+	pr_info("received command: %s\n", cmd);
+
+	if (sscanf(cmd, "test%d", &test_num) == 1) {
+		switch (test_num) {
+		case 0:
+			test_watch_fire();
+			break;
+		default:
+			pr_err("Unknown test number %d\n", test_num);
+			return -EINVAL;
+		}
+	} else {
+		pr_err("invalid command format. Use 'testN'.\n");
+		return -EINVAL;
+	}
+
+	return count;
+}
+
+static ssize_t test_dbgfs_read(struct file *file, char __user *buffer,
+			       size_t count, loff_t *ppos)
+{
+	static const char usage[] =
+		"KStackWatch Simplified Test Module\n"
+		"============ usage ===============\n"
+		"Usage:\n"
+		"echo test{i} > /sys/kernel/debug/kstackwatch/test\n"
+		" test0 - test watch fire\n";
+
+	return simple_read_from_buffer(buffer, count, ppos, usage,
+				       strlen(usage));
+}
+
+static const struct file_operations test_dbgfs_fops = {
+	.owner = THIS_MODULE,
+	.read = test_dbgfs_read,
+	.write = test_dbgfs_write,
+	.llseek = noop_llseek,
+};
+
+static int __init kstackwatch_test_init(void)
+{
+	struct dentry *ksw_dir = ksw_get_dbgdir();
+
+	if (!ksw_dir) {
+		pr_err("kstackwatch must be loaded first\n");
+		return -ENODEV;
+	}
+
+	test_file = debugfs_create_file("test", 0600, ksw_dir, NULL,
+					&test_dbgfs_fops);
+	if (!test_file) {
+		pr_err("Failed to create debugfs test file\n");
+		return -ENOMEM;
+	}
+
+	pr_info("module loaded\n");
+	return 0;
+}
+
+static void __exit kstackwatch_test_exit(void)
+{
+	debugfs_remove(test_file);
+	pr_info("module unloaded\n");
+}
+
+module_init(kstackwatch_test_init);
+module_exit(kstackwatch_test_exit);
+
+MODULE_AUTHOR("Jinchao Wang");
+MODULE_DESCRIPTION("KStackWatch Test Module");
+MODULE_LICENSE("GPL");
-- 
2.43.0

