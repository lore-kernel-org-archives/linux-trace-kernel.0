Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C97320CCD;
	Mon, 18 Aug 2025 12:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755520082; cv=none; b=PnWdrNQLo1NrQ/Fm7q9llUY6BNthMVvsapvXB933aWi4UjwoRX4bCTY8FIC3y/bgjytUmDMqhqxNejN2UgMm9VbhOclCG0xwJahdtdAJR4sgHNUB9lgamTVaSGqJs1aTjcWDu0zcPaG6qgLA6dqK6Kscx1Bjz7VmdHQIfOhlwhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755520082; c=relaxed/simple;
	bh=81531NphhQqXh+V+EMKIJck0MMphvNru8iKR0CmQaA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F3mSAz7BrGNzUd7Xy6eEuBajk7tF0RKFo18KfE7WKDjHvZittOMtGwBvrp4z4acNYu8RRI7Q35HL5s+Zhuu9/qD02IwXgg8TbHLs1MZU8tS02XjL45MZ+gTSWl8qsLXTijjnCldWLnlgkNe4Z6D5B0DblISuynNYyHNUaGL5vgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EEYAcZvX; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEYAcZvX"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b47475cf8eeso519446a12.3;
        Mon, 18 Aug 2025 05:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755520080; x=1756124880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uV2EcOLOEi9NHEaGyWV+jW00E8CTJandeHN7WdmrP2U=;
        b=EEYAcZvXyIdhlSgfrgOvbWogcpE7jXj/ctxo1/OD8JhW9/lUAbwUz0NjGmOINSiubj
         vEfICHKeWD7ppHPsXoGOIXtNRIJXfoNvPEp3jDkeISaXSMdCCjzgh0z8Gcyqz3slRALD
         XnIettHlJxKXg2mfMkdC35kWWJ9eSitBQw70ShzxvaOQWkBOFoOT1ebx2UpanJNC5YYH
         ylWy5d31MYIXGSUx+hrH+pAA4bY9T9YfSGVNpFlpx9jvp34fwssFoRT85esDlPqL4lPq
         339CDFkw9dD617j7Veefbw6tbDCDxTGMJTOlTP7a7KayG7ENUpqKSCnnlfpQut7JokqM
         XUGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755520080; x=1756124880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uV2EcOLOEi9NHEaGyWV+jW00E8CTJandeHN7WdmrP2U=;
        b=mNTWV6leF6t8odSo9yY+9aWa6ua2lL1tMI6USrw+cyTKgLbC3ChpFdWBqMA810R892
         jgOLA67fExF22Z+OtAcreQTtQ/oBh8oEnKd7qOp1A1tHJxNow0N4HG30OS/vDhZFZODD
         +ceN9wZ3B2KT3W1GqrCxD/0v8CUEfTxNV04JDtW7Kx2X9ON42/lu1EcZmRfMNQhXrxc6
         jiTUSSH2scHT97NgSgJ6AN6/e0jh+fGvOvzRQ5y46Lq91fkyEWqonqtp6u9o9Cx/oEg3
         baaPM2cdXC3q12iqglZs1VGqtOFftHq034DE5zLDBKh9UKUN8leTLAdtVuY1yzXwDRP+
         6Bwg==
X-Forwarded-Encrypted: i=1; AJvYcCVOvKrcH7Zat1a5Gz7m90ASZOSW8MvOfjcv4fidC1E5p6obTomCGKzzZ3dEpZH3uFLqcrEwNqu5h/pWiF4=@vger.kernel.org, AJvYcCVjawIy4ffJYpZe3j3T1bctXXnOkOf770mkq8Z3ShG1Q0mJ4RRiu3ds1LuIgszTLs7oEjjuTGCbXthD4hO7TYM/jkhH@vger.kernel.org
X-Gm-Message-State: AOJu0YxqPUQ40L8FcX9zU5dyOfEau3Ug2D5ohi1mbLacq9mjrpeuUYl6
	0CGpRtn+JriV0DAJ9QbbNs0FRwWcXbkl2Kt88GTXh5WQgrnkQPbROYLq
X-Gm-Gg: ASbGnctUkGocywly2RharEDohPqCLpneG74WVdrn/UK+Ze4r4Z5vsEE/vgtc6MhA4Kh
	AuOP50c5AktFH3hiHYbGWBjK/UBvcfXvK9qEDCRhATrTzUUnmLMqYMmF7oPeWVtPPBt7ktwFIAE
	/MFyLSeNF24Xh5KFA47/y0VJHsXBGvMw3H98mNnbBpTNZtAEGo2zDKKO9sC0SlVPFifctY/H4bU
	RHDsuNMmmkzoAGwCpk8JJdy2Zx6upqeI0sjipAy2sn0pwlZyTtAq7M4Ji91BRp0a5o87uoYqBj/
	VhAGSzUQiqxrxDFoPuubD3Yk2iG2Ukkzi51tOQhTConNNT+5fcwoSmryRPwliAMcbYxHwB+f+cm
	pv6+LgFWXxVBZ8CEFDmlstnc8d3+l
X-Google-Smtp-Source: AGHT+IGu3kpiiSiL73cGsjPJgf9P00IwKBpnUK06c+y7atJn3vhldLPJGipG7+4Nhxv9ijUCYrxi2g==
X-Received: by 2002:a17:903:37c3:b0:240:a05:5b79 with SMTP id d9443c01a7336-2446d939f0cmr153301435ad.44.1755520079929;
        Mon, 18 Aug 2025 05:27:59 -0700 (PDT)
Received: from localhost.localdomain ([2604:a840:3::3008])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d57f12esm79236705ad.157.2025.08.18.05.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 05:27:59 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: akpm@linux-foundation.org
Cc: mhiramat@kernel.org,
	naveen@kernel.org,
	davem@davemloft.net,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [RFC PATCH 03/13] mm/kstackwatch: Add module core and configuration interface
Date: Mon, 18 Aug 2025 20:26:08 +0800
Message-ID: <20250818122720.434981-4-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250818122720.434981-3-wangjinchao600@gmail.com>
References: <20250818122720.434981-1-wangjinchao600@gmail.com>
 <20250818122720.434981-2-wangjinchao600@gmail.com>
 <20250818122720.434981-3-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the main module infrastructure for kstackwatch, providing
a proc-based configuration interface and basic module lifecycle
management.

This patch introduces:

1. Module initialization and cleanup with proper resource management
2. Configuration parsing for the flexible watch specification format:
   "function+ip_offset[+depth] [local_var_offset:local_var_len]"
3. Proc interface (/proc/kstackwatch) for runtime configuration
4. Support for both watch types through unified configuration syntax

The configuration parser handles:
- Function name and instruction pointer offset (mandatory)
- Optional recursion depth filtering
- Optional local variable specification (offset:length)
- Automatic detection of watch type based on presence of stack parameters

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/kernel.c      | 205 +++++++++++++++++++++++++++++++++++
 mm/kstackwatch/kstackwatch.h |  39 +++++++
 2 files changed, 244 insertions(+)

diff --git a/mm/kstackwatch/kernel.c b/mm/kstackwatch/kernel.c
index e69de29bb2d1..726cf3f25888 100644
--- a/mm/kstackwatch/kernel.c
+++ b/mm/kstackwatch/kernel.c
@@ -0,0 +1,205 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/kern_levels.h>
+#include <linux/kstrtox.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/proc_fs.h>
+#include <linux/uaccess.h>
+#include <linux/string.h>
+#include <linux/utsname.h>
+#include <linux/seq_file.h>
+
+#include "kstackwatch.h"
+
+MODULE_AUTHOR("Jinchao Wang");
+MODULE_DESCRIPTION("Kernel Stack Watch");
+MODULE_LICENSE("GPL");
+
+struct ksw_config *ksw_config;
+bool watching_active;
+
+/* Module parameters */
+bool panic_on_catch;
+module_param(panic_on_catch, bool, 0644);
+MODULE_PARM_DESC(panic_on_catch,
+		 "Trigger a kernel panic immediately on corruption catch");
+
+static int start_watching(void)
+{
+	if (strlen(ksw_config->function) == 0) {
+		pr_err("KSW: No target function specified\n");
+		return -EINVAL;
+	}
+
+	watching_active = true;
+
+	pr_info("KSW: start watching %s\n", ksw_config->config_str);
+	return 0;
+}
+
+static void stop_watching(void)
+{
+	watching_active = false;
+
+	pr_info("KSW: stop watching %s\n", ksw_config->config_str);
+}
+
+/* Parse watch configuration:
+ *    function+ip_offset[+depth] [local_var_offset:local_var_len]
+ */
+static int parse_config(char *buf, struct ksw_config *config)
+{
+	char *func_part, *stack_part = NULL;
+	char *token;
+
+	/* Initialize with default values */
+	memset(config, 0, sizeof(*config));
+	config->type = WATCH_CANARY;
+
+	/* strim() removes leading/trailing whitespace */
+	func_part = strim(buf);
+	strscpy(config->config_str, func_part, MAX_CONFIG_STR_LEN);
+
+	stack_part = strchr(func_part, ' ');
+	if (stack_part) {
+		*stack_part = '\0'; // Terminate the function part
+		stack_part = strim(stack_part + 1);
+	}
+
+	/* 1. Parse the function part: function+ip_offset[+depth] */
+	token = strsep(&func_part, "+");
+	if (!token)
+		return -EINVAL;
+
+	strscpy(config->function, token, MAX_FUNC_NAME_LEN - 1);
+
+	token = strsep(&func_part, "+");
+	if (!token || kstrtou16(token, 0, &config->ip_offset)) {
+		pr_err("KSW: Failed to parse instruction offset\n");
+		return -EINVAL;
+	}
+
+	token = strsep(&func_part, "+");
+	if (token && kstrtou16(token, 0, &config->depth)) {
+		pr_err("KSW: Failed to parse depth\n");
+		return -EINVAL;
+	}
+	if (!stack_part || !(*stack_part))
+		return 0;
+
+	/* 2. Parse the optional stack part: offset:len */
+	config->type = WATCH_LOCAL_VAR;
+	token = strsep(&stack_part, ":");
+	if (!token || kstrtou16(token, 0, &config->local_var_offset)) {
+		pr_err("KSW: Failed to parse stack variable offset\n");
+		return -EINVAL;
+	}
+
+	if (!stack_part || kstrtou16(stack_part, 0, &config->local_var_len)) {
+		pr_err("KSW: Failed to parse stack variable length\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/* Proc interface for configuration */
+static ssize_t kstackwatch_proc_write(struct file *file,
+				      const char __user *buffer, size_t count,
+				      loff_t *pos)
+{
+	char input[256];
+	int ret;
+
+	if (count == 0 || count >= sizeof(input))
+		return -EINVAL;
+
+	if (copy_from_user(input, buffer, count))
+		return -EFAULT;
+
+	input[count] = '\0';
+	strim(input);
+
+	/* Stop current watching */
+	if (watching_active)
+		stop_watching();
+
+	ret = parse_config(input, ksw_config);
+	if (ret)
+		return ret;
+
+	/* Start watching */
+	ret = start_watching();
+	if (ret < 0) {
+		pr_err("KSW: Failed to start watching with %d\n", ret);
+		return ret;
+	}
+
+	return count;
+}
+
+static int kstackwatch_proc_show(struct seq_file *m, void *v)
+{
+	struct ksw_config *config = ksw_config;
+
+	if (watching_active) {
+		seq_printf(m, "KSW: watch config %s\n", config->config_str);
+	} else {
+		seq_puts(m, "Not watching\n");
+		seq_puts(m, "\nUsage:\n");
+		seq_puts(
+			m,
+			"  echo 'function+ip_offset[+depth] [local_var_offset:local_var_len]' > /proc/kstackwatch\n");
+		seq_puts(m, "  if ignore the stack part, watch the canary");
+	}
+
+	return 0;
+}
+
+static int kstackwatch_proc_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, kstackwatch_proc_show, NULL);
+}
+
+static const struct proc_ops kstackwatch_proc_ops = {
+	.proc_open = kstackwatch_proc_open,
+	.proc_read = seq_read,
+	.proc_write = kstackwatch_proc_write,
+	.proc_lseek = seq_lseek,
+	.proc_release = single_release,
+};
+
+static int __init kstackwatch_init(void)
+{
+	ksw_config = kmalloc(sizeof(*ksw_config), GFP_KERNEL);
+	if (!ksw_config)
+		return -ENOMEM;
+
+	/* Create proc interface */
+	if (!proc_create("kstackwatch", 0644, NULL, &kstackwatch_proc_ops)) {
+		pr_err("KSW: create proc kstackwatch fail");
+		return -ENOMEM;
+	}
+
+	pr_info("KSW: Module loaded\n");
+	pr_info("KSW: Usage:\n");
+	pr_info("KSW: echo 'function+ip_offset[+depth] [local_var_offset:local_var_len]' > /proc/kstackwatch\n");
+
+	return 0;
+}
+
+static void __exit kstackwatch_exit(void)
+{
+	/* Cleanup active watching */
+	if (watching_active)
+		stop_watching();
+
+	/* Remove proc interface */
+	remove_proc_entry("kstackwatch", NULL);
+	kfree(ksw_config);
+
+	pr_info("KSW: Module unloaded\n");
+}
+
+module_init(kstackwatch_init);
+module_exit(kstackwatch_exit);
diff --git a/mm/kstackwatch/kstackwatch.h b/mm/kstackwatch/kstackwatch.h
index e69de29bb2d1..f58af36e64a7 100644
--- a/mm/kstackwatch/kstackwatch.h
+++ b/mm/kstackwatch/kstackwatch.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _KSTACKWATCH_H
+#define _KSTACKWATCH_H
+
+#include <linux/types.h>
+
+#define MAX_FUNC_NAME_LEN 64
+#define MAX_CONFIG_STR_LEN 128
+
+/* Watch target types */
+enum watch_type {
+	WATCH_CANARY = 0, /* canary placed by compiler */
+	WATCH_LOCAL_VAR, /* local var defined by code */
+};
+
+struct ksw_config {
+	/* function part */
+	char function[MAX_FUNC_NAME_LEN];
+	u16 ip_offset;
+	u16 depth;
+
+	/* stack part, useless for canary watch */
+	/* offset from rsp at function+ip_offset */
+	u16 local_var_offset;
+
+	/*
+	 * local var size (1,2,4,8 bytes)
+	 * it will be the watching len
+	 */
+	u16 local_var_len;
+
+	/* easy for understand*/
+	enum watch_type type;
+
+	/* save to show */
+	char config_str[MAX_CONFIG_STR_LEN];
+};
+
+#endif /* _KSTACKWATCH_H */
-- 
2.43.0

