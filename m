Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3B55B21A;
	Mon,  6 Apr 2026 17:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775495444; cv=none; b=NtzeQ7BxuBnDjHafXJKFb9wYUOA3IduPTWm52hDuTOyj2YFiqqsPYDCeKkt1RMxWb295AdiFwEOGhSKQGDBoV9pM+DXbvk5KbwhrAmUFroQ+VHxQ8X/g+2N30zQ8bhGKiFbJdgNfwz1LgB55aOzIN7B8kgNB6nH5KamgM3A2Q7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775495444; c=relaxed/simple;
	bh=MXWMfm7gYuCy+lH29Ulu+OgomyQFa4RlJVCCUcO2sq0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VDXh1Ry/xDiY+EH/HoXJwFMXdJSixpR2RRfhmJlplrVj6kJzwv/+u/EF830rHemRJbK9VvxF2wPo7dFJbF+wRoYIB79ZBGKGAPnJhJH7zxK0idSDkO5hPs5ely3q+MJp/NIKpp411isaH+RpeBag2OASGzzEHnyWutzHJ0nSOl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=NJWaSml/; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="NJWaSml/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=3f
	/CqEZ6rAhrvqy84EMB+c5jUzWz13pC4lbmPe/95RM=; b=NJWaSml/YpA23MeChR
	4oneWjsJvUkTDgw37unXxB+bfv2Wid8HF+tCME1qWG+9MetTHso0Rg6DxQi+VMdS
	VNl8ZUE4e6czH6nEbGQ2PzU2reOKXUmjw1V+22kEeSFANsj+3Jk66kTcGk2cr/09
	camzlSI/1M5jKJU9dN5hKi+KI=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD31xDd6NNpTvd2Dg--.47409S2;
	Tue, 07 Apr 2026 01:09:51 +0800 (CST)
From: Cao Ruichuang <create0818@163.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	mcgrof@kernel.org,
	petr.pavlu@suse.com,
	da.gomez@kernel.org,
	samitolvanen@google.com,
	atomlin@atomlin.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org
Subject: [PATCH] tracing: preserve module tracepoint strings
Date: Tue,  7 Apr 2026 01:09:44 +0800
Message-Id: <20260406170944.51047-1-create0818@163.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD31xDd6NNpTvd2Dg--.47409S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3WFWDJw1DWr1kCr4fKF47CFg_yoWxuw1Up3
	Wayr9xtrs8AF4qgFW0g34qkry3GrZ8CryjqFZxCr1fA3Z8t34DZa17tws8Aw18CryUWrya
	kF1Y9r97Cr48Z3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jbAwsUUUUU=
X-CM-SenderInfo: pfuht3jhqyimi6rwjhhfrp/xtbCwADB+mnT6OA7JAAA3W

tracepoint_string() is documented as exporting constant strings
through printk_formats, including when it is used from modules.
That currently does not work.

A small test module that calls
tracepoint_string("tracepoint_string_test_module_string") loads
successfully and gets a pointer back, but the string never appears
in /sys/kernel/tracing/printk_formats. The loader only collects
__trace_printk_fmt from modules and ignores __tracepoint_str.

Collect module __tracepoint_str entries too, copy them to stable
tracing-managed storage like module trace_printk formats, and let
trace_is_tracepoint_string() recognize those copied strings. This
makes module tracepoint strings visible through printk_formats and
keeps them accepted by the trace string safety checks.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217196
Signed-off-by: Cao Ruichuang <create0818@163.com>
---
 include/linux/module.h      |  2 ++
 kernel/module/main.c        |  4 +++
 kernel/trace/trace_printk.c | 63 ++++++++++++++++++++++++++++---------
 3 files changed, 54 insertions(+), 15 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 14f391b18..e475466a7 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -515,6 +515,8 @@ struct module {
 #ifdef CONFIG_TRACING
 	unsigned int num_trace_bprintk_fmt;
 	const char **trace_bprintk_fmt_start;
+	unsigned int num_tracepoint_strings;
+	const char **tracepoint_strings_start;
 #endif
 #ifdef CONFIG_EVENT_TRACING
 	struct trace_event_call **trace_events;
diff --git a/kernel/module/main.c b/kernel/module/main.c
index c3ce106c7..d7d890138 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2672,6 +2672,10 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 	mod->trace_bprintk_fmt_start = section_objs(info, "__trace_printk_fmt",
 					 sizeof(*mod->trace_bprintk_fmt_start),
 					 &mod->num_trace_bprintk_fmt);
+	mod->tracepoint_strings_start =
+		section_objs(info, "__tracepoint_str",
+			     sizeof(*mod->tracepoint_strings_start),
+			     &mod->num_tracepoint_strings);
 #endif
 #ifdef CONFIG_DYNAMIC_FTRACE
 	/* sechdrs[0].sh_size is always zero */
diff --git a/kernel/trace/trace_printk.c b/kernel/trace/trace_printk.c
index 5ea5e0d76..9f67ce42e 100644
--- a/kernel/trace/trace_printk.c
+++ b/kernel/trace/trace_printk.c
@@ -22,8 +22,9 @@
 #ifdef CONFIG_MODULES
 
 /*
- * modules trace_printk()'s formats are autosaved in struct trace_bprintk_fmt
- * which are queued on trace_bprintk_fmt_list.
+ * modules trace_printk() formats and tracepoint_string() strings are
+ * autosaved in struct trace_bprintk_fmt, which are queued on
+ * trace_bprintk_fmt_list.
  */
 static LIST_HEAD(trace_bprintk_fmt_list);
 
@@ -33,8 +34,12 @@ static DEFINE_MUTEX(btrace_mutex);
 struct trace_bprintk_fmt {
 	struct list_head list;
 	const char *fmt;
+	unsigned int type;
 };
 
+#define TRACE_BPRINTK_TYPE		BIT(0)
+#define TRACE_TRACEPOINT_TYPE		BIT(1)
+
 static inline struct trace_bprintk_fmt *lookup_format(const char *fmt)
 {
 	struct trace_bprintk_fmt *pos;
@@ -49,22 +54,24 @@ static inline struct trace_bprintk_fmt *lookup_format(const char *fmt)
 	return NULL;
 }
 
-static
-void hold_module_trace_bprintk_format(const char **start, const char **end)
+static void hold_module_trace_format(const char **start, const char **end,
+				     unsigned int type)
 {
 	const char **iter;
 	char *fmt;
 
 	/* allocate the trace_printk per cpu buffers */
-	if (start != end)
+	if ((type & TRACE_BPRINTK_TYPE) && start != end)
 		trace_printk_init_buffers();
 
 	mutex_lock(&btrace_mutex);
 	for (iter = start; iter < end; iter++) {
 		struct trace_bprintk_fmt *tb_fmt = lookup_format(*iter);
 		if (tb_fmt) {
-			if (!IS_ERR(tb_fmt))
+			if (!IS_ERR(tb_fmt)) {
+				tb_fmt->type |= type;
 				*iter = tb_fmt->fmt;
+			}
 			continue;
 		}
 
@@ -76,6 +83,7 @@ void hold_module_trace_bprintk_format(const char **start, const char **end)
 				list_add_tail(&tb_fmt->list, &trace_bprintk_fmt_list);
 				strcpy(fmt, *iter);
 				tb_fmt->fmt = fmt;
+				tb_fmt->type = type;
 			} else
 				kfree(tb_fmt);
 		}
@@ -85,17 +93,28 @@ void hold_module_trace_bprintk_format(const char **start, const char **end)
 	mutex_unlock(&btrace_mutex);
 }
 
-static int module_trace_bprintk_format_notify(struct notifier_block *self,
-		unsigned long val, void *data)
+static int module_trace_format_notify(struct notifier_block *self,
+				      unsigned long val, void *data)
 {
 	struct module *mod = data;
+
+	if (val != MODULE_STATE_COMING)
+		return NOTIFY_OK;
+
 	if (mod->num_trace_bprintk_fmt) {
 		const char **start = mod->trace_bprintk_fmt_start;
 		const char **end = start + mod->num_trace_bprintk_fmt;
 
-		if (val == MODULE_STATE_COMING)
-			hold_module_trace_bprintk_format(start, end);
+		hold_module_trace_format(start, end, TRACE_BPRINTK_TYPE);
+	}
+
+	if (mod->num_tracepoint_strings) {
+		const char **start = mod->tracepoint_strings_start;
+		const char **end = start + mod->num_tracepoint_strings;
+
+		hold_module_trace_format(start, end, TRACE_TRACEPOINT_TYPE);
 	}
+
 	return NOTIFY_OK;
 }
 
@@ -171,8 +190,8 @@ static void format_mod_stop(void)
 
 #else /* !CONFIG_MODULES */
 __init static int
-module_trace_bprintk_format_notify(struct notifier_block *self,
-		unsigned long val, void *data)
+module_trace_format_notify(struct notifier_block *self,
+			   unsigned long val, void *data)
 {
 	return NOTIFY_OK;
 }
@@ -193,8 +212,8 @@ void trace_printk_control(bool enabled)
 }
 
 __initdata_or_module static
-struct notifier_block module_trace_bprintk_format_nb = {
-	.notifier_call = module_trace_bprintk_format_notify,
+struct notifier_block module_trace_format_nb = {
+	.notifier_call = module_trace_format_notify,
 };
 
 int __trace_bprintk(unsigned long ip, const char *fmt, ...)
@@ -254,11 +273,25 @@ EXPORT_SYMBOL_GPL(__ftrace_vprintk);
 bool trace_is_tracepoint_string(const char *str)
 {
 	const char **ptr = __start___tracepoint_str;
+#ifdef CONFIG_MODULES
+	struct trace_bprintk_fmt *tb_fmt;
+#endif
 
 	for (ptr = __start___tracepoint_str; ptr < __stop___tracepoint_str; ptr++) {
 		if (str == *ptr)
 			return true;
 	}
+
+#ifdef CONFIG_MODULES
+	mutex_lock(&btrace_mutex);
+	list_for_each_entry(tb_fmt, &trace_bprintk_fmt_list, list) {
+		if ((tb_fmt->type & TRACE_TRACEPOINT_TYPE) && str == tb_fmt->fmt) {
+			mutex_unlock(&btrace_mutex);
+			return true;
+		}
+	}
+	mutex_unlock(&btrace_mutex);
+#endif
 	return false;
 }
 
@@ -824,7 +857,7 @@ fs_initcall(init_trace_printk_function_export);
 
 static __init int init_trace_printk(void)
 {
-	return register_module_notifier(&module_trace_bprintk_format_nb);
+	return register_module_notifier(&module_trace_format_nb);
 }
 
 early_initcall(init_trace_printk);
-- 
2.39.5 (Apple Git-154)

