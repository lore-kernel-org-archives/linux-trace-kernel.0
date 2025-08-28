Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1E92D9798;
	Thu, 28 Aug 2025 07:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756366462; cv=none; b=bj/xICt19aflrCiss6f6WO3yCBP2NnocjwGF7/E0hYjCqlDpZaixrWQbs8u/FqBc9209g4OCO5lWbcxVmmfUs5jzIzvGuVd7Zk96yTzgoBBwDCtLNGPznU894LPBz7sdDJU1yOxfg1yeoAWaep9HimxqzSxyVQWJZcJqDWqZWnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756366462; c=relaxed/simple;
	bh=riKBu2I/0IniTUQEc51qBXh7Lfn5NQ94RTpD6hcQAWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KXcGNjGfApvHxTfScfY6uqZ3WJQpsr0hP2Hj+JjlcQokNtMIEHqdY0UUGBJ1KRFJZuOZDSbT7MAB7T5yrcvwweq163BAH8fiCNqFmcuG3gvJcnl0I1/2EzVY+Wk7E82MJRQONl3Yt42iqym7w2xdTH+ZYgsCoxgS5O9k/0fHauI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jISD1V9J; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jISD1V9J"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-771facea122so333827b3a.1;
        Thu, 28 Aug 2025 00:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756366459; x=1756971259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PVjzrm6vJvhOYeF4QMjv0eGIgiL9m2bJu49WtrTbuMs=;
        b=jISD1V9JYehdFQkQuMPjgovqzaTXgYhdKgq7zOU9UkBEpOK2a+XFHOSecS2UWZGW6i
         keoPRn/0Vz4ZMWVDApgU6F96OSfDks69EHVhEjEIZq6RTzjJm/LC9A2sep21TdLN9jzx
         K1HM80So8KWxZ2g8d7SzQay+yZWZ/FF+eD/jC33uvQ0LCcT8pbeWtibhQYOf8QYx/6aS
         a+d9YnR1HT0OtyGDYN08RuCn3mRqMcL7Tw3X+fygYJ3eslxMnVex+Og8wtB7fHF8zpwI
         gwidR3WkTTGxGws5FIc10mNMN/QpOAGQoVvgmrP8WlMJtCY5C30t42o9Fm24zXOEeCZj
         Tdbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756366459; x=1756971259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PVjzrm6vJvhOYeF4QMjv0eGIgiL9m2bJu49WtrTbuMs=;
        b=POLlL/+wofc8HPbyvHxwtC8CGwrVGHNx9VRnYZGdCimYrV2oQULbxA5hV6wJah+lk+
         AeH+C7Z4X9qKa0a5g6VB3f04625gH2LOT/IzsgvvIAVCJOX5H4nV+4lmVF8v/U5vq77l
         BCSK6wpgGeaHj2uL+I5b2N8Vvpj0ies/X0aIHGztcLbngk0ZeAd2J1ctMGzy6DeFNluA
         l6X3FqP8j5+LFmPSHMu6byR4b/Wokn6Jw5S/KyRuInPfx4sRM1PoEtNu1R7qlC4Tvhfn
         Ca3lE5f1DMprgxCs3pD1cZBGly3sAPk9g3u5PRTa/UzjwZBiM3Bs6NL1PoLrR1/yy115
         5VWA==
X-Forwarded-Encrypted: i=1; AJvYcCUTGNXSDx0pvpne8iQgdoyNG5UIdL3sYIdDf7wRSpRJ5+QbnXAksu51XOlqGinh4ifYa4Tdj7zatZ+bGHMf4kbbybo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRKj1KCVtT3f0nh/2qgk4J3nHjfhF0icPXUPEdwb8mqj5Uwyll
	kAgrmC4OfNhHIQMGmq9+0pHm8ser6IBI3UsMPT3WUV8w536MKH5VQIsW
X-Gm-Gg: ASbGncsX275DMe9Gy58pEh15rBw6Nuzhiu+65pI6bja4Ur7D6kRTsMRV/Jxb4e37Vdf
	EyOB9/2IWxoeNUs2x+xTiIPUoaBsAEH+aYKRWqi+7eOGEGse4YmfLqDZTtdf8KoUYW+yv1r8sZj
	3fiqU+Yrlf0aXQgFwRCEjbAmEVfiV12lZQlLn18MQXFl1vCFKK3qdPmBQ1Pd5go95T1v9YVz7ef
	6r+FrBKBVR7jQgThu8KR9krLyM/c21pg+UT4oFFEd/1h1UjGdb/eISFlFmYgxcCdxLmBYo61Ila
	wa19s7wI05qtsdCDczRXUp7NulyuAn6hXfasM4nlST82eD3J1gCNvcZYXwFcUMvP9D9yZzhOE94
	8Ekj4UQ/tpwAsOhmO8b2tpcE/tiBR+5+bxB2VxPYCtWGZSdJ7duTUJgISZKvi
X-Google-Smtp-Source: AGHT+IFYhlbFCeQPuAaCUEgKiUrGtQ+7l2i/ih6peCZQtuclDB1MWqRTOOZ5F985pI8fDDhetrxXsg==
X-Received: by 2002:a05:6a20:6a1c:b0:243:9587:a743 with SMTP id adf61e73a8af0-2439587a912mr9614332637.23.1756366459180;
        Thu, 28 Aug 2025 00:34:19 -0700 (PDT)
Received: from localhost.localdomain ([103.88.46.62])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cb8afb7bsm13182613a12.16.2025.08.28.00.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 00:34:18 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"Naveen N . Rao" <naveen@kernel.org>,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH 03/17] mm/ksw: add /proc/kstackwatch interface
Date: Thu, 28 Aug 2025 15:32:36 +0800
Message-ID: <20250828073311.1116593-4-wangjinchao600@gmail.com>
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

Provide the /proc/kstackwatch file to read or update the KSW configuration.
Writing a valid config string starts watching; empty input stops watching.
Invalid input stops watching and reports an error.

Allocate a ksw_config struct on module init and free it on exit.
Manage watching state with ksw_start_watching() and ksw_stop_watching().

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/kernel.c | 140 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 140 insertions(+)

diff --git a/mm/kstackwatch/kernel.c b/mm/kstackwatch/kernel.c
index 4a6dc49449fe..95ade95abde1 100644
--- a/mm/kstackwatch/kernel.c
+++ b/mm/kstackwatch/kernel.c
@@ -1,7 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/kstrtox.h>
 #include <linux/module.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
 #include <linux/string.h>
+#include <linux/uaccess.h>
 
 #include "kstackwatch.h"
 
@@ -9,6 +12,29 @@ MODULE_AUTHOR("Jinchao Wang");
 MODULE_DESCRIPTION("Kernel Stack Watch");
 MODULE_LICENSE("GPL");
 
+struct ksw_config *ksw_config;
+bool watching_active;
+
+bool panic_on_catch;
+module_param(panic_on_catch, bool, 0644);
+MODULE_PARM_DESC(panic_on_catch,
+		 "Trigger a kernel panic immediately on corruption catch");
+
+static int ksw_start_watching(void)
+{
+	watching_active = true;
+
+	pr_info("KSW: start watching %s\n", ksw_config->config_str);
+	return 0;
+}
+
+static void ksw_stop_watching(void)
+{
+	watching_active = false;
+
+	pr_info("KSW: stop watching %s\n", ksw_config->config_str);
+}
+
 /*
  * Format of the configuration string:
  *    function+ip_offset[+depth] [local_var_offset:local_var_len]
@@ -74,8 +100,114 @@ static int ksw_parse_config(char *buf, struct ksw_config *config)
 	return 0;
 }
 
+/**
+ * kstackwatch_proc_write - Handle writes to the /proc/kstackwatch file
+ * @file: file struct for the proc entry
+ * @buffer: user-space buffer containing the command string
+ * @count: the number of bytes from the user-space buffer
+ * @pos: file offset
+ *
+ * This function processes user input to control the kernel stack watcher
+ * Before attempting to process any new configuration. It handles three
+ * cases based on the input string, In all three cases, the system will
+ * clear its state first, with subsequent actions determined by the input:
+ *
+ * 1. An empty or whitespace-only string
+ *    Return a success code
+ *
+ * 2. An invalid configuration string
+ *    Return a error code
+ *
+ * 3. A valid configuration string
+ *    Start a new stack watch, return a success code
+ *
+ * Return: The number of bytes successfully processed on success,
+ * or a negative error code on failure.
+ */
+static ssize_t kstackwatch_proc_write(struct file *file,
+				      const char __user *buffer, size_t count,
+				      loff_t *pos)
+{
+	char input[MAX_CONFIG_STR_LEN];
+	int ret;
+
+	if (count == 0 || count >= sizeof(input))
+		return -EINVAL;
+
+	if (copy_from_user(input, buffer, count))
+		return -EFAULT;
+
+	if (watching_active)
+		ksw_stop_watching();
+	memset(ksw_config, 0, sizeof(*ksw_config));
+
+	input[count] = '\0';
+	strim(input);
+
+	/* case 1 */
+	if (!strlen(input)) {
+		pr_info("KSW: config cleared\n");
+		return count;
+	}
+
+	ret = ksw_parse_config(input, ksw_config);
+	if (ret) {
+		/* case 2 */
+		pr_err("KSW: Failed to parse config %d\n", ret);
+		return ret;
+	}
+
+	/* case 3 */
+	ret = ksw_start_watching();
+	if (ret) {
+		pr_err("KSW: Failed to start watching with %d\n", ret);
+		return ret;
+	}
+
+	return count;
+}
+
+static int kstackwatch_proc_show(struct seq_file *m, void *v)
+{
+	if (watching_active) {
+		seq_printf(m, "%s\n", ksw_config->config_str);
+	} else {
+		seq_puts(m, "not watching\n");
+		seq_puts(m, "\nusage:\n");
+		seq_puts(
+			m,
+			" echo 'function+ip_offset[+depth] [local_var_offset:local_var_len]' > /proc/kstackwatch\n");
+		seq_puts(m, "  Watch the canary without the local var part.");
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
 static int __init kstackwatch_init(void)
 {
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
 	pr_info("KSW: module loaded\n");
 	pr_info("KSW: usage:\n");
 	pr_info("KSW: echo 'function+ip_offset[+depth] [local_var_offset:local_var_len]' > /proc/kstackwatch\n");
@@ -85,6 +217,14 @@ static int __init kstackwatch_init(void)
 
 static void __exit kstackwatch_exit(void)
 {
+	/* Cleanup active watching */
+	if (watching_active)
+		ksw_stop_watching();
+
+	/* Remove proc interface */
+	remove_proc_entry("kstackwatch", NULL);
+	kfree(ksw_config);
+
 	pr_info("KSW: Module unloaded\n");
 }
 
-- 
2.43.0

