Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BA621CC5C;
	Mon, 20 Apr 2026 06:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776666007; cv=none; b=UI915QTXm8NXF738JjY4+bcCK6Zs0iPlZRkALkcmLR37LWWARyosgTypa4DCzyBRtGdNK9BOv6W0VzzHWEg6tT/oJ8ISoxJ+Zlwnreu+BH2CnLdySTPFqhpXgzKRmsswBy9B71G8ZCpAkBLKooA2uVCcqr2pz711b7IbhOot5P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776666007; c=relaxed/simple;
	bh=uRUDax4QCJiUY8j0I0PVWdc+LdrQraWSrO1HT0hTIoA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f4gdz8x9VvH0AFh0yPdRfBiVmmY6tyWCduvSPDfJqkHRLDT6XcxewSk+uvejeRc90R5PjDuv+1M0I5VdS37yuP9yxC+fHrfEJ2O7U+VMiwYUXEGkNZuafe51J53EORgP6kD1WU9e637xx8O4RwDYca1ypGflkH2i+9HhhqZF5RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=T631kUjr; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="T631kUjr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=vC
	oIljNVg+AfT00mNrtTQmpb4L5iG4yH40fK7KOqRyQ=; b=T631kUjr6hAQoAb744
	hEVJJHvT/30wks0FCysOR9dP5Ur8N33Xys4ENt3+4YEjZGLcFAABH5wVkw8UozTs
	JyigIB2OZUkMnXUEeYl0y6pAQoGEgMh+2PsC3FZ3vMzOFa1Ji9wRsGEfVgeNoxWT
	OgVfnxxdr1u25glhtR4m4nyQs=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDnja5hxeVptXW8Ag--.18368S2;
	Mon, 20 Apr 2026 14:19:15 +0800 (CST)
From: Cao Ruichuang <create0818@163.com>
To: rostedt@goodmis.org
Cc: petr.pavlu@suse.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cao Ruichuang <create0818@163.com>
Subject: [PATCH v2] tracing: export live module tracepoint strings in printk_formats
Date: Mon, 20 Apr 2026 14:19:11 +0800
Message-Id: <20260420061911.97066-1-create0818@163.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260413123359.32517-1-create0818@163.com>
References: <20260413123359.32517-1-create0818@163.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnja5hxeVptXW8Ag--.18368S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Wr15AF17ArWrGF4xXFy8AFb_yoWDJFWDpF
	4Sy3s8Jrs8AF4qgF48Xw4DCry3C398uryUtrZ8Cwn3Zwn8tr9F9F47K3yayr18C34UWry3
	KFWY9r1UCr4xZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pi7PExUUUUU=
X-CM-SenderInfo: pfuht3jhqyimi6rwjhhfrp/xtbC6AVel2nlxWXCkQAA3b

tracepoint_string() documents that its strings are exported through
printk_formats so that user space can decode pointer fields recorded in
trace buffers.

That already works for built-in __tracepoint_str entries, but module
__tracepoint_str sections are not collected or exported today. As a
result, module tracepoint_string() users still show raw pointer values
in printk_formats consumers such as trace.dat decoders.

Record module __tracepoint_str sections when modules are loaded, expose
their live ranges through printk_formats, and teach
trace_is_tracepoint_string() to accept those live module strings too.

Keep the lifetime semantics tied to the module itself. This does not
copy strings into tracing-owned storage and does not preserve the
mappings after module unload.

On MODULE_STATE_GOING, the live module string ranges are removed again.
This relies on the existing tracing module notifier ordering: trace
event teardown runs first and resets module event buffers before these
auxiliary string mappings are dropped.

If the small auxiliary registry allocation fails, warn and continue
loading the module. printk_formats exposure is degraded in that case,
but tracing should not fail module load for missing debug metadata.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217196
Assisted-by: Codex:GPT-5.4
Signed-off-by: Cao Ruichuang <create0818@163.com>
---
v2:
- replace the previous copied-string approach with live module section ranges
- record module __tracepoint_str ranges in struct module
- export only live module tracepoint strings in printk_formats
- remove module mappings on MODULE_STATE_GOING
- keep auxiliary registry allocation failure non-fatal and warn instead
- add explicit notifier priority and document the teardown ordering dependency

Tested in QEMU:
- basic repro showing module tracepoint_string() entries in printk_formats
- load/unload validation confirming mappings are removed after rmmod
- failed module init after MODULE_STATE_COMING with no stale mapping left
- targeted failslab injection on the notifier-time auxiliary allocation,
  confirming module load still succeeds, a warning is emitted, and the
  module mapping is not exported

 include/linux/module.h      |   2 +
 kernel/module/main.c        |   4 +
 kernel/trace/trace_printk.c | 153 ++++++++++++++++++++++++++++++++++--
 3 files changed, 152 insertions(+), 7 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 14f391b186c..e475466a785 100644
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
index c3ce106c70a..d7d890138ac 100644
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
index 5ea5e0d76f0..2d41b0a63b3 100644
--- a/kernel/trace/trace_printk.c
+++ b/kernel/trace/trace_printk.c
@@ -13,6 +13,7 @@
 #include <linux/string.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/rcupdate.h>
 #include <linux/ctype.h>
 #include <linux/list.h>
 #include <linux/slab.h>
@@ -24,10 +25,15 @@
 /*
  * modules trace_printk()'s formats are autosaved in struct trace_bprintk_fmt
  * which are queued on trace_bprintk_fmt_list.
+ *
+ * modules tracepoint_string() entries are kept as ranges into the owning
+ * module's __tracepoint_str section and are removed again when the module
+ * goes away.
  */
 static LIST_HEAD(trace_bprintk_fmt_list);
+static LIST_HEAD(tracepoint_str_list);
 
-/* serialize accesses to trace_bprintk_fmt_list */
+/* serialize accesses to module trace printk and tracepoint string lists */
 static DEFINE_MUTEX(btrace_mutex);
 
 struct trace_bprintk_fmt {
@@ -35,6 +41,13 @@ struct trace_bprintk_fmt {
 	const char *fmt;
 };
 
+struct tracepoint_mod_str {
+	struct list_head list;
+	struct module *mod;
+	const char **start;
+	unsigned int num;
+};
+
 static inline struct trace_bprintk_fmt *lookup_format(const char *fmt)
 {
 	struct trace_bprintk_fmt *pos;
@@ -85,16 +98,70 @@ void hold_module_trace_bprintk_format(const char **start, const char **end)
 	mutex_unlock(&btrace_mutex);
 }
 
+static void hold_module_tracepoint_strings(struct module *mod)
+{
+	struct tracepoint_mod_str *tp_str;
+
+	if (!mod->num_tracepoint_strings)
+		return;
+
+	tp_str = kmalloc_obj(*tp_str);
+	if (!tp_str) {
+		pr_warn("tracing: Failed to expose module tracepoint strings for %s\n",
+			mod->name);
+		return;
+	}
+
+	tp_str->mod = mod;
+	tp_str->start = mod->tracepoint_strings_start;
+	tp_str->num = mod->num_tracepoint_strings;
+
+	mutex_lock(&btrace_mutex);
+	list_add_tail_rcu(&tp_str->list, &tracepoint_str_list);
+	mutex_unlock(&btrace_mutex);
+}
+
+static void release_module_tracepoint_strings(struct module *mod)
+{
+	struct tracepoint_mod_str *tp_str, *next;
+	struct tracepoint_mod_str *found = NULL;
+
+	mutex_lock(&btrace_mutex);
+	list_for_each_entry_safe(tp_str, next, &tracepoint_str_list, list) {
+		if (tp_str->mod != mod)
+			continue;
+
+		list_del_rcu(&tp_str->list);
+		found = tp_str;
+		break;
+	}
+	mutex_unlock(&btrace_mutex);
+
+	if (found) {
+		synchronize_rcu();
+		kfree(found);
+	}
+}
+
 static int module_trace_bprintk_format_notify(struct notifier_block *self,
 		unsigned long val, void *data)
 {
 	struct module *mod = data;
-	if (mod->num_trace_bprintk_fmt) {
-		const char **start = mod->trace_bprintk_fmt_start;
-		const char **end = start + mod->num_trace_bprintk_fmt;
 
-		if (val == MODULE_STATE_COMING)
+	switch (val) {
+	case MODULE_STATE_COMING:
+		if (mod->num_trace_bprintk_fmt) {
+			const char **start = mod->trace_bprintk_fmt_start;
+			const char **end = start + mod->num_trace_bprintk_fmt;
+
 			hold_module_trace_bprintk_format(start, end);
+		}
+		hold_module_tracepoint_strings(mod);
+		break;
+	case MODULE_STATE_GOING:
+		/* trace event teardown runs first and clears module event buffers. */
+		release_module_tracepoint_strings(mod);
+		break;
 	}
 	return NOTIFY_OK;
 }
@@ -159,6 +226,55 @@ find_next_mod_format(int start_index, void *v, const char **fmt, loff_t *pos)
 	return &mod_fmt->fmt;
 }
 
+static int count_mod_formats(void)
+{
+	struct trace_bprintk_fmt *p;
+	int count = 0;
+
+	list_for_each_entry(p, &trace_bprintk_fmt_list, list)
+		count++;
+
+	return count;
+}
+
+static const char **
+find_next_mod_tracepoint_str(int start_index, loff_t *pos)
+{
+	struct tracepoint_mod_str *tp_str;
+	int index = start_index;
+	unsigned int i;
+
+	list_for_each_entry(tp_str, &tracepoint_str_list, list) {
+		for (i = 0; i < tp_str->num; i++) {
+			if (index == *pos)
+				return tp_str->start + i;
+			index++;
+		}
+	}
+
+	return NULL;
+}
+
+static bool is_module_tracepoint_string(const char *str)
+{
+	struct tracepoint_mod_str *tp_str;
+	unsigned int i;
+	bool found = false;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(tp_str, &tracepoint_str_list, list) {
+		for (i = 0; i < tp_str->num; i++) {
+			if (str == tp_str->start[i]) {
+				found = true;
+				goto out;
+			}
+		}
+	}
+out:
+	rcu_read_unlock();
+	return found;
+}
+
 static void format_mod_start(void)
 {
 	mutex_lock(&btrace_mutex);
@@ -181,6 +297,22 @@ find_next_mod_format(int start_index, void *v, const char **fmt, loff_t *pos)
 {
 	return NULL;
 }
+
+static inline int count_mod_formats(void)
+{
+	return 0;
+}
+
+static inline const char **
+find_next_mod_tracepoint_str(int start_index, loff_t *pos)
+{
+	return NULL;
+}
+
+static inline bool is_module_tracepoint_string(const char *str)
+{
+	return false;
+}
 static inline void format_mod_start(void) { }
 static inline void format_mod_stop(void) { }
 #endif /* CONFIG_MODULES */
@@ -195,6 +327,7 @@ void trace_printk_control(bool enabled)
 __initdata_or_module static
 struct notifier_block module_trace_bprintk_format_nb = {
 	.notifier_call = module_trace_bprintk_format_notify,
+	.priority = 0,
 };
 
 int __trace_bprintk(unsigned long ip, const char *fmt, ...)
@@ -259,12 +392,13 @@ bool trace_is_tracepoint_string(const char *str)
 		if (str == *ptr)
 			return true;
 	}
-	return false;
+	return is_module_tracepoint_string(str);
 }
 
 static const char **find_next(void *v, loff_t *pos)
 {
 	const char **fmt = v;
+	int mod_formats;
 	int start_index;
 	int last_index;
 
@@ -292,7 +426,12 @@ static const char **find_next(void *v, loff_t *pos)
 		return __start___tracepoint_str + (*pos - last_index);
 
 	start_index += last_index;
-	return find_next_mod_format(start_index, v, fmt, pos);
+	mod_formats = count_mod_formats();
+	if (*pos < start_index + mod_formats)
+		return find_next_mod_format(start_index, v, fmt, pos);
+
+	start_index += mod_formats;
+	return find_next_mod_tracepoint_str(start_index, pos);
 }
 
 static void *
-- 
2.39.5 (Apple Git-154)

