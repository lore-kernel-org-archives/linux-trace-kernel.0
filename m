Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7963043C9
	for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Nov 2025 16:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762792633; cv=none; b=QciyhyWCPQAIEUvVjJJPsJrHWpE/2YfrgwesrVp5OmwEB/4hpI2ZXclPV4Np+WGviq26O4JrFc0QQ09VmPHcMcDyin6yTU8NCg2TQ1Fu+k334SgXeCTm+9Aoh0OZf3bcbQYF+mmKWCA5VwHP7bndYHzOSZ7W/AB1IDl0fmr4YmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762792633; c=relaxed/simple;
	bh=Ima2e4/C5WqdeZyYCnDIwbDgz9ZYOLESM4kickHutQ8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iwXyTvw6TDWLRs7XGubBxFs/bkx+XIHzHGggKTioN42lyCKFFHpyZg2n2Bl3Xqblo2URHGXNWlIOZSdij1CUNmb+G+xaUz3UtuGXJEqkm5fVjSVpC1EK83OuDGFyHoP2uMz+vfo0XaX07Mi9PvJaIF+tEe3J7C2z1+pDjMLKKeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PSIZCYhG; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSIZCYhG"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b8c0c0cdd61so2689135a12.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762792629; x=1763397429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RDpE0CvbPiS95CD/e7bDhFl1FHfdcNhWeVLe6GjR39g=;
        b=PSIZCYhGt4Dd7vdyEl0mOkvONblClWeuS4QZ5ZGZ0MedDHaXvNpz8ADNwK6qenO/nl
         Pb/UnAJOqDscQSNuGq5DvTveWqzQNJRjZR74EfcpeSq51CYCe8HZQf1eSXkClT3lN4v5
         jDA4Uf1eMXEwoFGNz7xw5vivscquUJFUyP3J6VHHZKqUBpHtJy+DPu7PXVAYSUuoVyJP
         aB4usMrzfDrouMV5Cvutjl1EAzaR4YDI8xNeDhDMscnv5m1YQVAjiAs0jvblEGrrVfpv
         i1/D/oTtCvkXRE+Waa0EpWEcbdCvHLnzoFCbgrWsj1I31g3LKULWa5rQBUPlBE/yXd+A
         DXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762792629; x=1763397429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RDpE0CvbPiS95CD/e7bDhFl1FHfdcNhWeVLe6GjR39g=;
        b=c1okd+FrLudk1htEu4fz5cBZmVnr6IFQGC8Iwejw/p3sg5XsZa1Alhj8Vn7zgQmNde
         LnqtmW69TpZO1xjymnaD2z15iO1NyvI4tJh7VguK9MaNLz/rsma4oKfB/kDHCbtZ9UgT
         tu70XzPSRBCWMdDxqHnG12/WUGQtCNSHHuKSIuKNJROOJQ5wHQtdGHm+OvsqMt0Owzop
         6C9sQapdt+eOHRdeAc+P+n3xVhi0brWAcZfJ0vih0P61UeTs+LDuVC7vf/z4UqkavDAB
         PR0k66GnOlLGlLAT5Ljh3kwdqUMgvlJWjS9cmmJNN/r+lxDcJOMMBYzcCD5kJRNOWO+3
         Y3Ww==
X-Forwarded-Encrypted: i=1; AJvYcCUOEc090VqzaNqRDg+oZjXl/UiChDZmlkI4FPtkXeHRrFAspEYkuC1wPicUGYQcpe3sNTVPsK4X3jdkn7/Wjtgf+TQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu2gJv9DRR9WLzsPWX7ez1A18Pr/NRuydDq1+C/HTUjEyxgKTd
	nwAV9e3BaUQamN2qe/wkHvJSSCy5HaqRqGoszeQk5RFMUJWo5Hi0W87G
X-Gm-Gg: ASbGncuHQvOhFXOUQd0iStsHgfLEeedHF/ZoN3U4CFrcbVJ4XbuhVjMgwZqveCtCM5p
	jJAcwxzKdo/Y+2hTfGyaxZfXB602wka36sYZc5QFk4QFc8hmEeLNdLQKKAJcd8RtzrHPeefx3WD
	Sj8qUJ7e+GBROirEYJQj8WuqtVbtnFSBHld8QpaO8c79fuOhLB4TAAWS2PgPesfQQG6GHrq6DAE
	HxZ1srvScvHCKYgv2c8hIOtsS9lkkofTNVJbijEhPprGyGWfe6QMHlMUKGrxbRzACvonWzmjc3V
	a7E3wPGN3RchJF7tZO19xJQDVYua6oaANn7phUe3GQcYuPwCQk4WlBtI0zNySoAAJc+EzAS4gAQ
	VT2U3e1AYPpCt2CgrZkjttcyVevkEzzjivJ8XgV+uqJd2WzaoHQxaoLfa/RPqNJrjGfcjYuGwkK
	ynqxYtr4PMYsHQWrEPW6sizQ==
X-Google-Smtp-Source: AGHT+IHLWcFC7W3aH7MtEyBpRAAfyoGWF1TXnIybIjXPJD9gYvIPg0ozGaDjCXeoqvDbHEVRJoG18g==
X-Received: by 2002:a17:902:d481:b0:295:9b73:b15c with SMTP id d9443c01a7336-297e56f9c21mr125602655ad.42.1762792628683;
        Mon, 10 Nov 2025 08:37:08 -0800 (PST)
Received: from localhost ([103.88.46.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650c5ce87sm150073335ad.29.2025.11.10.08.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 08:37:08 -0800 (PST)
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
Subject: [PATCH v8 06/27] mm/ksw: add singleton debugfs interface
Date: Tue, 11 Nov 2025 00:36:01 +0800
Message-ID: <20251110163634.3686676-7-wangjinchao600@gmail.com>
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

Provide the debugfs config file to read or update the configuration.
Only a single process can open this file at a time, enforced using atomic
config_file_busy, to prevent concurrent access.

ksw_get_config() exposes the configuration pointer as const.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 include/linux/kstackwatch.h |   3 ++
 mm/kstackwatch/kernel.c     | 103 ++++++++++++++++++++++++++++++++++--
 2 files changed, 103 insertions(+), 3 deletions(-)

diff --git a/include/linux/kstackwatch.h b/include/linux/kstackwatch.h
index dd00c4c8922e..ada5ac64190c 100644
--- a/include/linux/kstackwatch.h
+++ b/include/linux/kstackwatch.h
@@ -35,4 +35,7 @@ struct ksw_config {
 	char *user_input;
 };
 
+// singleton, only modified in kernel.c
+const struct ksw_config *ksw_get_config(void);
+
 #endif /* _KSTACKWATCH_H */
diff --git a/mm/kstackwatch/kernel.c b/mm/kstackwatch/kernel.c
index 50104e78cf3d..87fef139f494 100644
--- a/mm/kstackwatch/kernel.c
+++ b/mm/kstackwatch/kernel.c
@@ -1,13 +1,18 @@
 // SPDX-License-Identifier: GPL-2.0
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/debugfs.h>
 #include <linux/kstackwatch.h>
 #include <linux/kstrtox.h>
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/string.h>
+#include <linux/uaccess.h>
 
+static atomic_t dbgfs_config_busy = ATOMIC_INIT(0);
 static struct ksw_config *ksw_config;
+static struct dentry *dbgfs_config;
+static struct dentry *dbgfs_dir;
 
 struct param_map {
 	const char *name;       /* long name */
@@ -76,7 +81,7 @@ static int ksw_parse_param(struct ksw_config *config, const char *key,
  * - sp_offset  |so (u16) : offset from stack pointer at func_offset
  * - watch_len  |wl (u16) : watch length (1,2,4,8)
  */
-static int __maybe_unused ksw_parse_config(char *buf, struct ksw_config *config)
+static int ksw_parse_config(char *buf, struct ksw_config *config)
 {
 	char *part, *key, *val;
 	int ret;
@@ -111,18 +116,110 @@ static int __maybe_unused ksw_parse_config(char *buf, struct ksw_config *config)
 	return 0;
 }
 
+static ssize_t ksw_dbgfs_read(struct file *file, char __user *buf, size_t count,
+			      loff_t *ppos)
+{
+	return simple_read_from_buffer(buf, count, ppos, ksw_config->user_input,
+		ksw_config->user_input ? strlen(ksw_config->user_input) : 0);
+}
+
+static ssize_t ksw_dbgfs_write(struct file *file, const char __user *buffer,
+			       size_t count, loff_t *ppos)
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
+	input[count] = '\0';
+	strim(input);
+
+	if (!strlen(input)) {
+		pr_info("config cleared\n");
+		return count;
+	}
+
+	ret = ksw_parse_config(input, ksw_config);
+	if (ret) {
+		pr_err("Failed to parse config %d\n", ret);
+		return ret;
+	}
+
+	return count;
+}
+
+static int ksw_dbgfs_open(struct inode *inode, struct file *file)
+{
+	if (atomic_cmpxchg(&dbgfs_config_busy, 0, 1))
+		return -EBUSY;
+	return 0;
+}
+
+static int ksw_dbgfs_release(struct inode *inode, struct file *file)
+{
+	atomic_set(&dbgfs_config_busy, 0);
+	return 0;
+}
+
+static const struct file_operations kstackwatch_fops = {
+	.owner = THIS_MODULE,
+	.open = ksw_dbgfs_open,
+	.read = ksw_dbgfs_read,
+	.write = ksw_dbgfs_write,
+	.release = ksw_dbgfs_release,
+	.llseek = default_llseek,
+};
+
+const struct ksw_config *ksw_get_config(void)
+{
+	return ksw_config;
+}
+
 static int __init kstackwatch_init(void)
 {
+	int ret = 0;
+
 	ksw_config = kzalloc(sizeof(*ksw_config), GFP_KERNEL);
-	if (!ksw_config)
-		return -ENOMEM;
+	if (!ksw_config) {
+		ret = -ENOMEM;
+		goto err_alloc;
+	}
+
+	dbgfs_dir = debugfs_create_dir("kstackwatch", NULL);
+	if (!dbgfs_dir) {
+		ret = -ENOMEM;
+		goto err_dir;
+	}
+
+	dbgfs_config = debugfs_create_file("config", 0600, dbgfs_dir, NULL,
+				       &kstackwatch_fops);
+	if (!dbgfs_config) {
+		ret = -ENOMEM;
+		goto err_file;
+	}
 
 	pr_info("module loaded\n");
 	return 0;
+
+err_file:
+	debugfs_remove_recursive(dbgfs_dir);
+	dbgfs_dir = NULL;
+err_dir:
+	kfree(ksw_config);
+	ksw_config = NULL;
+err_alloc:
+	return ret;
 }
 
 static void __exit kstackwatch_exit(void)
 {
+	debugfs_remove_recursive(dbgfs_dir);
+	kfree(ksw_config->func_name);
+	kfree(ksw_config->user_input);
 	kfree(ksw_config);
 
 	pr_info("module unloaded\n");
-- 
2.43.0

