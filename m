Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A331F3D955C;
	Tue, 11 Aug 2026 18:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786474340; cv=none; b=o4khSJJuQ0/aLrGMVcMNVJqwlexZ5q5W2N2HJHkFR9wKqjbEBjN/IWAMAiru9eLHLnlN0ce/P2GXN6mfVipeYFZRSxtPNf3hPHknWPynYgmnJuN9yJ8MkuXq4/5arotV6dW+/WTerWHzDBee8o4T8N0Y2qCFYtQeqLnYq8e9x4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786474340; c=relaxed/simple;
	bh=fr6rsnOWCblH1rAlGjYtWOtLFz0/3jV+WMq9FUe7FY4=;
	h=From:Date:Subject:To:Cc:In-Reply-To:References:Message-ID; b=W5qwXEO4Ah+Mu1o1v8+zfQoIxih1AM/azQlpwWys5G5SUmYMdxUVu1duzC6rDkt99C0WyzoYuwpV99GjKYJrhIbW3gBrqfq+XS2lWyWD5SsQ0f1xpaa2CC0M2unWcIJXGlOU8uiioEGaDCm8cmdu1jWdNxZSe8gHHwOgPm0zo5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JBkaqBfr; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JBkaqBfr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Date:Subject:To:Message-ID; bh=6o37fi/oYdoZbkO
	/u7wWAXvVaV6dKNOFDwv2HxxADgg=; b=JBkaqBfr/Hwa8CM1RaBCL4JAS9aDL4X
	+C4Dh7bu7S3Yd4Ddy4gJcKPCqGhMW8tBK/V/qosLUb9sUeTPsnMIFho2prDWCwAo
	1Am1zUn9rn7FxC48gkTc5jXtA3elPjLJZUFwdDeJFvqcioEcIIhTBFIAsd8weX2U
	XUFfCgYFUHoA=
Received: from [127.0.1.1] (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wDHScYgb3tqZ4JDOg--.44573S2;
	Wed, 12 Aug 2026 02:51:13 +0800 (CST)
From: Cao Ruichuang <create0818@163.com>
Date: Tue, 11 Aug 2026 18:15:13 +0000
Subject: [PATCH v3] tracing: Export live module tracepoint strings in
 printk_formats
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>, Shuah Khan <shuah@kernel.org>,
 linux-trace-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260428083920.4a64eaf6@gandalf.local.home>
References: <20260428083920.4a64eaf6@gandalf.local.home>
Message-ID: <178647423521.280401.10184675433127100074@163.com>
X-CM-TRANSID:_____wDHScYgb3tqZ4JDOg--.44573S2
X-Coremail-Antispam: 1Uf129KBjvAXoW3Kry3XF47AF4rtrW3XF4fXwb_yoW8Gw4kKo
	Z7u3Wqgw10qF1xG3yfGFW8tay5ZF4FqF4rJ34Fqr4qvF9Fqw1YyayDAwsYv3WUWFs5GrW5
	Za1fXayUtF48GFyrn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUaDDJUUUUU
X-CM-SenderInfo: pfuht3jhqyimi6rwjhhfrp/xtbC6AJdlmp7byLRCgAA3m
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

tracepoint_string() places constant string pointers in __tracepoint_str
and exports their address-to-text mappings through printk_formats. This
lets user space decode pointer fields without copying each string into
every ring buffer record.

The linker collects the built-in __tracepoint_str section, but the
module loader does not collect the corresponding module section.
Consequently, module strings never reach printk_formats and tools such
as trace-cmd show raw addresses when decoding trace.dat.

Collect module __tracepoint_str sections and register one live range for
each module on MODULE_STATE_COMING. Include these ranges in
printk_formats and trace_is_tracepoint_string() lookups.

Reference the module section directly instead of copying its strings,
and remove the range on MODULE_STATE_GOING. The trace event notifier,
which runs at priority 1, removes module events and resets the trace
buffers before this priority-0 notifier drops the mapping.

Serialize range updates and printk_formats iteration with btrace_mutex.
Keep the membership lookup under RCU because the tp_printk path can call
it while holding tracepoint_iter_lock with interrupts disabled. Free the
range descriptor with kfree_rcu(); module teardown waits for an RCU grace
period before freeing the section that backs the range.

Cache the number of successfully inserted module trace_printk formats
and directly index the matching module tracepoint-string range. Extend
the trace_printk sample and ftrace selftest to verify that multiple
module strings are exported while loaded and removed on unload.

Fixes: 102c9323c35a ("tracing: Add __tracepoint_string() to export string pointers")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217196
Link: https://lore.kernel.org/r/41e81533-0fd6-49f5-b7c1-b4e172affd2a@suse.com
Link: https://lore.kernel.org/r/20260428083920.4a64eaf6@gandalf.local.home
Suggested-by: Petr Pavlu <petr.pavlu@suse.com>
Assisted-by: Codex:gpt-5.4
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Cao Ruichuang <create0818@163.com>
---
Changes since v2:
- Capitalize `Export` in the subject as requested.
- Group the two counts and two pointers in struct module.
- Cache only successfully inserted unique trace_bprintk_fmt entries.
- Skip complete module ranges and directly index the matching range.
- Use guard() and early returns to simplify registry operations.
- Keep the IRQ-safe RCU read side and use kfree_rcu() for removal.
- Document the live module mapping and RCU lifetime.
- Add trace_printk sample coverage and an ftrace regression test.
- Add Fixes, Closes, Suggested-by, and review Link tags.

Testing:
- git diff --check
- scripts/checkpatch.pl --strict --no-tree
- sh -n tools/testing/selftests/ftrace/test.d/event/trace_printk.tc
- x86_64 defconfig W=1 builds of all touched kernel and sample objects
- CONFIG_MODULES=n W=1 build of kernel/trace/trace_printk.o
- Minimal x86_64 bzImage and modules build
- QEMU load/unload test, including 10 insmod/rmmod cycles concurrent with
  100 reads of printk_formats; both module strings were present while the
  module was loaded and absent after unload, with no kernel diagnostics

v2: https://lore.kernel.org/r/20260420061911.97066-1-create0818@163.com

 include/linux/module.h                        |   2 +
 include/linux/tracepoint.h                    |   8 +-
 kernel/module/main.c                          |   4 +
 kernel/trace/trace_printk.c                   | 138 ++++++++++++++++--
 samples/trace_printk/trace-printk.c           |   4 +
 .../ftrace/test.d/event/trace_printk.tc       |   5 +
 6 files changed, 146 insertions(+), 15 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 7566815fa..d9ac1fd6e 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -513,7 +513,9 @@ struct module {
 #endif
 #ifdef CONFIG_TRACING
 	unsigned int num_trace_bprintk_fmt;
+	unsigned int num_tracepoint_strings;
 	const char **trace_bprintk_fmt_start;
+	const char **tracepoint_strings_start;
 #endif
 #ifdef CONFIG_EVENT_TRACING
 	struct trace_event_call **trace_events;
diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index e0d838c9c..2b973cc72 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -508,10 +508,10 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
  * the ASCII strings they represent.
  *
  * The @str used must be a constant string and persistent as it would not
- * make sense to show a string that no longer exists. But it is still fine
- * to be used with modules, because when modules are unloaded, if they
- * had tracepoints, the ring buffers are cleared too. As long as the string
- * does not change during the life of the module, it is fine to use
+ * make sense to show a string that no longer exists. For modules, the string
+ * mapping is exported while the module is loaded. When the module is unloaded,
+ * its trace buffers are cleared before the mapping is removed. As long as the
+ * string does not change during the life of the module, it is fine to use
  * tracepoint_string() within a module.
  */
 #define tracepoint_string(str)						\
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 46dd8d25a..cb0acb2ce 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2729,6 +2729,10 @@ static int find_module_sections(struct module *mod, struct load_info *info)
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
index 98171a239..2aca8d206 100644
--- a/kernel/trace/trace_printk.c
+++ b/kernel/trace/trace_printk.c
@@ -13,21 +13,29 @@
 #include <linux/string.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/rcupdate.h>
 #include <linux/ctype.h>
 #include <linux/list.h>
 #include <linux/slab.h>
 
 #include "trace.h"
 
+static int trace_bprintk_fmt_cnt;
+
 #ifdef CONFIG_MODULES
 
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
+/* serialize updates and printk_formats iteration of the module lists */
 static DEFINE_MUTEX(btrace_mutex);
 
 struct trace_bprintk_fmt {
@@ -35,6 +43,14 @@ struct trace_bprintk_fmt {
 	const char *fmt;
 };
 
+struct tracepoint_mod_str {
+	struct list_head list;
+	struct rcu_head rcu;
+	struct module *mod;
+	const char **start;
+	unsigned int num;
+};
+
 static inline struct trace_bprintk_fmt *lookup_format(const char *fmt)
 {
 	struct trace_bprintk_fmt *pos;
@@ -75,6 +91,7 @@ void hold_module_trace_bprintk_format(const char **start, const char **end)
 			if (fmt) {
 				list_add_tail(&tb_fmt->list, &trace_bprintk_fmt_list);
 				tb_fmt->fmt = fmt;
+				trace_bprintk_fmt_cnt++;
 			} else
 				kfree(tb_fmt);
 		}
@@ -84,16 +101,63 @@ void hold_module_trace_bprintk_format(const char **start, const char **end)
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
+	if (!tp_str)
+		return;
+
+	tp_str->mod = mod;
+	tp_str->start = mod->tracepoint_strings_start;
+	tp_str->num = mod->num_tracepoint_strings;
+
+	guard(mutex)(&btrace_mutex);
+	list_add_tail_rcu(&tp_str->list, &tracepoint_str_list);
+}
+
+static void release_module_tracepoint_strings(struct module *mod)
+{
+	struct tracepoint_mod_str *tp_str;
+
+	if (!mod->num_tracepoint_strings)
+		return;
+
+	guard(mutex)(&btrace_mutex);
+	list_for_each_entry(tp_str, &tracepoint_str_list, list) {
+		if (tp_str->mod != mod)
+			continue;
+
+		list_del_rcu(&tp_str->list);
+		/* Module teardown waits for RCU before freeing the section. */
+		kfree_rcu(tp_str, rcu);
+		return;
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
+		/* Trace event teardown runs first and clears module event buffers. */
+		release_module_tracepoint_strings(mod);
+		break;
 	}
 	return NOTIFY_OK;
 }
@@ -119,7 +183,7 @@ static int module_trace_bprintk_format_notify(struct notifier_block *self,
  * next format in the list.
  */
 static const char **
-find_next_mod_format(int start_index, void *v, const char **fmt, loff_t *pos)
+find_next_mod_format(loff_t start_index, void *v, const char **fmt, loff_t *pos)
 {
 	struct trace_bprintk_fmt *mod_fmt;
 
@@ -158,6 +222,42 @@ find_next_mod_format(int start_index, void *v, const char **fmt, loff_t *pos)
 	return &mod_fmt->fmt;
 }
 
+static const char **
+find_next_mod_tracepoint_str(loff_t start_index, loff_t *pos)
+{
+	struct tracepoint_mod_str *tp_str;
+	loff_t offset = *pos - start_index;
+
+	if (offset < 0)
+		return NULL;
+
+	list_for_each_entry(tp_str, &tracepoint_str_list, list) {
+		if (offset < (loff_t)tp_str->num)
+			return tp_str->start + offset;
+
+		offset -= tp_str->num;
+	}
+
+	return NULL;
+}
+
+static bool is_module_tracepoint_string(const char *str)
+{
+	struct tracepoint_mod_str *tp_str;
+	unsigned int i;
+
+	/* The tracepoint printk path can call this with IRQs disabled. */
+	guard(rcu)();
+	list_for_each_entry_rcu(tp_str, &tracepoint_str_list, list) {
+		for (i = 0; i < tp_str->num; i++) {
+			if (str == tp_str->start[i])
+				return true;
+		}
+	}
+
+	return false;
+}
+
 static void format_mod_start(void)
 {
 	mutex_lock(&btrace_mutex);
@@ -176,10 +276,21 @@ module_trace_bprintk_format_notify(struct notifier_block *self,
 	return NOTIFY_OK;
 }
 static inline const char **
-find_next_mod_format(int start_index, void *v, const char **fmt, loff_t *pos)
+find_next_mod_format(loff_t start_index, void *v, const char **fmt, loff_t *pos)
+{
+	return NULL;
+}
+
+static inline const char **
+find_next_mod_tracepoint_str(loff_t start_index, loff_t *pos)
 {
 	return NULL;
 }
+
+static inline bool is_module_tracepoint_string(const char *str)
+{
+	return false;
+}
 static inline void format_mod_start(void) { }
 static inline void format_mod_stop(void) { }
 #endif /* CONFIG_MODULES */
@@ -194,6 +305,7 @@ void trace_printk_control(bool enabled)
 __initdata_or_module static
 struct notifier_block module_trace_bprintk_format_nb = {
 	.notifier_call = module_trace_bprintk_format_notify,
+	.priority = 0, /* lower than the trace event notifier */
 };
 
 __printf(2, 3)
@@ -259,14 +371,14 @@ bool trace_is_tracepoint_string(const char *str)
 		if (str == *ptr)
 			return true;
 	}
-	return false;
+	return is_module_tracepoint_string(str);
 }
 
 static const char **find_next(void *v, loff_t *pos)
 {
 	const char **fmt = v;
-	int start_index;
-	int last_index;
+	loff_t start_index;
+	loff_t last_index;
 
 	start_index = __stop___trace_bprintk_fmt - __start___trace_bprintk_fmt;
 
@@ -292,7 +404,11 @@ static const char **find_next(void *v, loff_t *pos)
 		return __start___tracepoint_str + (*pos - last_index);
 
 	start_index += last_index;
-	return find_next_mod_format(start_index, v, fmt, pos);
+	if (*pos - start_index < trace_bprintk_fmt_cnt)
+		return find_next_mod_format(start_index, v, fmt, pos);
+
+	start_index += trace_bprintk_fmt_cnt;
+	return find_next_mod_tracepoint_str(start_index, pos);
 }
 
 static void *
diff --git a/samples/trace_printk/trace-printk.c b/samples/trace_printk/trace-printk.c
index cfc159580..54c709c82 100644
--- a/samples/trace_printk/trace-printk.c
+++ b/samples/trace_printk/trace-printk.c
@@ -2,6 +2,7 @@
 #include <linux/module.h>
 #include <linux/kthread.h>
 #include <linux/irq_work.h>
+#include <linux/tracepoint.h>
 
 /* Must not be static to force gcc to consider these non constant */
 char *trace_printk_test_global_str =
@@ -31,6 +32,9 @@ static int __init trace_printk_init(void)
 {
 	init_irq_work(&irqwork, trace_printk_irq_work);
 
+	(void)tracepoint_string("tracepoint_string_test_module_string_1");
+	(void)tracepoint_string("tracepoint_string_test_module_string_2");
+
 	trace_printk("This is a static string that will use trace_bputs\n");
 	trace_printk(trace_printk_test_global_str);
 
diff --git a/tools/testing/selftests/ftrace/test.d/event/trace_printk.tc b/tools/testing/selftests/ftrace/test.d/event/trace_printk.tc
index b02550b42..d66a8134c 100644
--- a/tools/testing/selftests/ftrace/test.d/event/trace_printk.tc
+++ b/tools/testing/selftests/ftrace/test.d/event/trace_printk.tc
@@ -23,5 +23,10 @@ grep -q ": (irq) .* trace_printk" trace
 
 grep -q "This is a %s that will use trace_bprintk" printk_formats
 grep -q "(irq) This is a static string that will use trace_bputs" printk_formats
+grep -q "tracepoint_string_test_module_string_1" printk_formats
+grep -q "tracepoint_string_test_module_string_2" printk_formats
 
 rmmod trace-printk ||:
+
+! grep -q "tracepoint_string_test_module_string_1" printk_formats
+! grep -q "tracepoint_string_test_module_string_2" printk_formats

base-commit: d5b201ed4feb7a11da242a97669424efeb724031
-- 
2.43.5

