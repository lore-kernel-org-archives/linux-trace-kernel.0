Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5150C3BBA17;
	Mon, 13 Apr 2026 12:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776083715; cv=none; b=bjZCNJDM2+ShNA7Q3f3INMJW/Pz2PgW0/M6P1UxAjESkXJQNgEI1q4/8L8zFUKLL7i3ktCASx2T0jwH6W/U1Nmu0t3a5G1hQ4rFwSFALtv0/9W669KI8cL8Xm5cai5pdwyGtncuhav058Odn8aL30YEIt/RH9o/WpgtqIX0u+DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776083715; c=relaxed/simple;
	bh=UDvQEDzACJaIGhbKUuVN22MGWQ63Mq6g0ApY5MwLZPM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IxK58huzWG/ihqKX9bNN2bLViyYqm0SETPQVFvx+rCsoKZoq5CNhAvjXz+ZicISvw1C9SowZv4MJX83g3s1Zagwnwa3CkD1bTkARtCLrNfdvZy34btWPO+qcPjNm0OkrPGX6xQJkLxirilp7GS/wWyJ9fzuo/W4pkEH6Iy11JwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=qGwjJx/S; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="qGwjJx/S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ly
	eFqWeoKodPerbWa60q7LIpP05vh+z9Tryut9Xskk0=; b=qGwjJx/SaQge9o51vu
	KxsBnS2zE7VfpSqEOIQ2XkFbUsD+8wMkl5vEyj9/cBDQHi31bIqh5GzqbRy+F3Bx
	E0zq6dqwb7RrD6cbFJ2mUM1YEuCGidqQUfgNNIOOSQBFeq0Je8OpFSfIiC4tfwRb
	LL0/ydNm5sagWxRIwRQNXxHBw=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wAnJqbH4txprg+pEw--.12037S2;
	Mon, 13 Apr 2026 20:34:40 +0800 (CST)
From: Cao Ruichuang <create0818@163.com>
To: petr.pavlu@suse.com
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mhiramat@kernel.org,
	Cao Ruichuang <create0818@163.com>
Subject: [PATCH] tracing: separate module tracepoint strings from trace_printk formats
Date: Mon, 13 Apr 2026 20:33:59 +0800
Message-Id: <20260413123359.32517-1-create0818@163.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <41e81533-0fd6-49f5-b7c1-b4e172affd2a@suse.com>
References: <41e81533-0fd6-49f5-b7c1-b4e172affd2a@suse.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAnJqbH4txprg+pEw--.12037S2
X-Coremail-Antispam: 1Uf129KBjvAXoW3CF4rWw1fKrWDtryrtr1xAFb_yoW8GFWxZo
	W7Z3Z0vw10gF1xJayxG34kJa1rZFW0gFW5J34Fqr4q9Fyvqw1rJ3y7AwsYv3W5GF45JFW5
	Za17Xay5JF48JFyfn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjTRqFALUUUUU
X-CM-SenderInfo: pfuht3jhqyimi6rwjhhfrp/xtbCvwKCu2nc4uIn6AAA3+

The previous module tracepoint_string() fix took the smallest
implementation path and reused the existing module trace_printk format
storage.

That was enough to make module __tracepoint_str entries show up in
printk_formats and be accepted by trace_is_tracepoint_string(), but it
also made those copied mappings persist after module unload. That does
not match the expected module lifetime semantics.

Handle module tracepoint_string() mappings separately instead of mixing
them into the module trace_printk format list. Keep copying the strings
into tracing-managed storage while the module is loaded, but track them
on their own list and drop them again on MODULE_STATE_GOING.

Keep module trace_printk format handling unchanged.

This split is intentional: module trace_printk formats and module
tracepoint_string() mappings do not have the same lifetime requirements.
Keeping them in one shared structure would either preserve
tracepoint_string() mappings too long again, or require mixed
ownership/refcount rules in a trace_printk-oriented structure.

The separate module tracepoint_string() list intentionally keeps one
copied mapping per module entry instead of trying to share copies across
modules by string contents. printk_formats is address-based, and sharing
those copies would add another layer of shared ownership/refcounting
without changing the lifetime rule this fix is trying to restore.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217196
Signed-off-by: Cao Ruichuang <create0818@163.com>
---
 include/linux/tracepoint.h  |   9 +-
 kernel/trace/trace_printk.c | 250 ++++++++++++++++++++++--------------
 2 files changed, 157 insertions(+), 102 deletions(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index f14da542402..aec598a4017 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -479,11 +479,10 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
  *
  * For built-in code, the tracing system uses the original string address.
  * For modules, the tracing code saves tracepoint strings into
- * tracing-managed storage when the module loads, so their mappings remain
- * available through printk_formats and trace string checks even after the
- * module's own memory goes away. As long as the string does not change
- * during the life of the module, it is fine to use tracepoint_string()
- * within a module.
+ * tracing-managed storage while the module is loaded, and drops those
+ * mappings again when the module unloads. As long as the string does not
+ * change during the life of the module, it is fine to use
+ * tracepoint_string() within a module.
  */
 #define tracepoint_string(str)						\
 	({								\
diff --git a/kernel/trace/trace_printk.c b/kernel/trace/trace_printk.c
index 9f67ce42ef6..0420ffcff93 100644
--- a/kernel/trace/trace_printk.c
+++ b/kernel/trace/trace_printk.c
@@ -21,24 +21,24 @@
 
 #ifdef CONFIG_MODULES
 
-/*
- * modules trace_printk() formats and tracepoint_string() strings are
- * autosaved in struct trace_bprintk_fmt, which are queued on
- * trace_bprintk_fmt_list.
- */
+/* module trace_printk() formats are autosaved on trace_bprintk_fmt_list. */
 static LIST_HEAD(trace_bprintk_fmt_list);
+/* module tracepoint_string() copies live on tracepoint_string_list. */
+static LIST_HEAD(tracepoint_string_list);
 
-/* serialize accesses to trace_bprintk_fmt_list */
+/* serialize accesses to module format and tracepoint-string lists */
 static DEFINE_MUTEX(btrace_mutex);
 
 struct trace_bprintk_fmt {
 	struct list_head list;
 	const char *fmt;
-	unsigned int type;
 };
 
-#define TRACE_BPRINTK_TYPE		BIT(0)
-#define TRACE_TRACEPOINT_TYPE		BIT(1)
+struct tracepoint_string_entry {
+	struct list_head list;
+	struct module *mod;
+	const char *str;
+};
 
 static inline struct trace_bprintk_fmt *lookup_format(const char *fmt)
 {
@@ -54,24 +54,21 @@ static inline struct trace_bprintk_fmt *lookup_format(const char *fmt)
 	return NULL;
 }
 
-static void hold_module_trace_format(const char **start, const char **end,
-				     unsigned int type)
+static void hold_module_trace_bprintk_format(const char **start, const char **end)
 {
 	const char **iter;
 	char *fmt;
 
 	/* allocate the trace_printk per cpu buffers */
-	if ((type & TRACE_BPRINTK_TYPE) && start != end)
+	if (start != end)
 		trace_printk_init_buffers();
 
 	mutex_lock(&btrace_mutex);
 	for (iter = start; iter < end; iter++) {
 		struct trace_bprintk_fmt *tb_fmt = lookup_format(*iter);
 		if (tb_fmt) {
-			if (!IS_ERR(tb_fmt)) {
-				tb_fmt->type |= type;
+			if (!IS_ERR(tb_fmt))
 				*iter = tb_fmt->fmt;
-			}
 			continue;
 		}
 
@@ -83,7 +80,6 @@ static void hold_module_trace_format(const char **start, const char **end,
 				list_add_tail(&tb_fmt->list, &trace_bprintk_fmt_list);
 				strcpy(fmt, *iter);
 				tb_fmt->fmt = fmt;
-				tb_fmt->type = type;
 			} else
 				kfree(tb_fmt);
 		}
@@ -93,89 +89,156 @@ static void hold_module_trace_format(const char **start, const char **end,
 	mutex_unlock(&btrace_mutex);
 }
 
+static void hold_module_tracepoint_strings(struct module *mod,
+					   const char **start,
+					   const char **end)
+{
+	const char **iter;
+
+	mutex_lock(&btrace_mutex);
+	for (iter = start; iter < end; iter++) {
+		struct tracepoint_string_entry *tp_entry;
+		char *str;
+
+		tp_entry = kmalloc_obj(*tp_entry);
+		if (!tp_entry)
+			continue;
+
+		str = kstrdup(*iter, GFP_KERNEL);
+		if (!str) {
+			kfree(tp_entry);
+			continue;
+		}
+
+		tp_entry->mod = mod;
+		tp_entry->str = str;
+		list_add_tail(&tp_entry->list, &tracepoint_string_list);
+		*iter = tp_entry->str;
+	}
+	mutex_unlock(&btrace_mutex);
+}
+
+static void release_module_tracepoint_strings(struct module *mod)
+{
+	struct tracepoint_string_entry *tp_entry, *n;
+
+	mutex_lock(&btrace_mutex);
+	list_for_each_entry_safe(tp_entry, n, &tracepoint_string_list, list) {
+		if (tp_entry->mod != mod)
+			continue;
+		list_del(&tp_entry->list);
+		kfree(tp_entry->str);
+		kfree(tp_entry);
+	}
+	mutex_unlock(&btrace_mutex);
+}
+
 static int module_trace_format_notify(struct notifier_block *self,
 				      unsigned long val, void *data)
 {
 	struct module *mod = data;
 
-	if (val != MODULE_STATE_COMING)
-		return NOTIFY_OK;
+	switch (val) {
+	case MODULE_STATE_COMING:
+		if (mod->num_trace_bprintk_fmt) {
+			const char **start = mod->trace_bprintk_fmt_start;
+			const char **end = start + mod->num_trace_bprintk_fmt;
 
-	if (mod->num_trace_bprintk_fmt) {
-		const char **start = mod->trace_bprintk_fmt_start;
-		const char **end = start + mod->num_trace_bprintk_fmt;
+			hold_module_trace_bprintk_format(start, end);
+		}
+
+		if (mod->num_tracepoint_strings) {
+			const char **start = mod->tracepoint_strings_start;
+			const char **end = start + mod->num_tracepoint_strings;
 
-		hold_module_trace_format(start, end, TRACE_BPRINTK_TYPE);
+			hold_module_tracepoint_strings(mod, start, end);
+		}
+		break;
+	case MODULE_STATE_GOING:
+		release_module_tracepoint_strings(mod);
+		break;
 	}
 
-	if (mod->num_tracepoint_strings) {
-		const char **start = mod->tracepoint_strings_start;
-		const char **end = start + mod->num_tracepoint_strings;
+	return NOTIFY_OK;
+}
 
-		hold_module_trace_format(start, end, TRACE_TRACEPOINT_TYPE);
+static const char **find_first_mod_entry(void)
+{
+	struct trace_bprintk_fmt *tb_fmt;
+	struct tracepoint_string_entry *tp_entry;
+
+	if (!list_empty(&trace_bprintk_fmt_list)) {
+		tb_fmt = list_first_entry(&trace_bprintk_fmt_list,
+					  typeof(*tb_fmt), list);
+		return &tb_fmt->fmt;
 	}
 
-	return NOTIFY_OK;
+	if (!list_empty(&tracepoint_string_list)) {
+		tp_entry = list_first_entry(&tracepoint_string_list,
+					    typeof(*tp_entry), list);
+		return &tp_entry->str;
+	}
+
+	return NULL;
 }
 
-/*
- * The debugfs/tracing/printk_formats file maps the addresses with
- * the ASCII formats that are used in the bprintk events in the
- * buffer. For userspace tools to be able to decode the events from
- * the buffer, they need to be able to map the address with the format.
- *
- * The addresses of the bprintk formats are in their own section
- * __trace_printk_fmt. But for modules we copy them into a link list.
- * The code to print the formats and their addresses passes around the
- * address of the fmt string. If the fmt address passed into the seq
- * functions is within the kernel core __trace_printk_fmt section, then
- * it simply uses the next pointer in the list.
- *
- * When the fmt pointer is outside the kernel core __trace_printk_fmt
- * section, then we need to read the link list pointers. The trick is
- * we pass the address of the string to the seq function just like
- * we do for the kernel core formats. To get back the structure that
- * holds the format, we simply use container_of() and then go to the
- * next format in the list.
- */
-static const char **
-find_next_mod_format(int start_index, void *v, const char **fmt, loff_t *pos)
+static struct trace_bprintk_fmt *lookup_mod_format_ptr(const char **fmt_ptr)
 {
-	struct trace_bprintk_fmt *mod_fmt;
+	struct trace_bprintk_fmt *tb_fmt;
 
-	if (list_empty(&trace_bprintk_fmt_list))
-		return NULL;
+	list_for_each_entry(tb_fmt, &trace_bprintk_fmt_list, list) {
+		if (fmt_ptr == &tb_fmt->fmt)
+			return tb_fmt;
+	}
 
-	/*
-	 * v will point to the address of the fmt record from t_next
-	 * v will be NULL from t_start.
-	 * If this is the first pointer or called from start
-	 * then we need to walk the list.
-	 */
-	if (!v || start_index == *pos) {
-		struct trace_bprintk_fmt *p;
-
-		/* search the module list */
-		list_for_each_entry(p, &trace_bprintk_fmt_list, list) {
-			if (start_index == *pos)
-				return &p->fmt;
-			start_index++;
+	return NULL;
+}
+
+static struct tracepoint_string_entry *lookup_mod_tracepoint_ptr(const char **str_ptr)
+{
+	struct tracepoint_string_entry *tp_entry;
+
+	list_for_each_entry(tp_entry, &tracepoint_string_list, list) {
+		if (str_ptr == &tp_entry->str)
+			return tp_entry;
+	}
+
+	return NULL;
+}
+
+static const char **find_next_mod_entry(int start_index, void *v, loff_t *pos)
+{
+	struct trace_bprintk_fmt *tb_fmt;
+	struct tracepoint_string_entry *tp_entry;
+
+	if (!v || start_index == *pos)
+		return find_first_mod_entry();
+
+	tb_fmt = lookup_mod_format_ptr(v);
+	if (tb_fmt) {
+		if (tb_fmt->list.next != &trace_bprintk_fmt_list) {
+			tb_fmt = list_next_entry(tb_fmt, list);
+			return &tb_fmt->fmt;
 		}
-		/* pos > index */
+
+		if (!list_empty(&tracepoint_string_list)) {
+			tp_entry = list_first_entry(&tracepoint_string_list,
+						    typeof(*tp_entry), list);
+			return &tp_entry->str;
+		}
+
 		return NULL;
 	}
 
-	/*
-	 * v points to the address of the fmt field in the mod list
-	 * structure that holds the module print format.
-	 */
-	mod_fmt = container_of(v, typeof(*mod_fmt), fmt);
-	if (mod_fmt->list.next == &trace_bprintk_fmt_list)
+	tp_entry = lookup_mod_tracepoint_ptr(v);
+	if (!tp_entry)
 		return NULL;
 
-	mod_fmt = container_of(mod_fmt->list.next, typeof(*mod_fmt), list);
+	if (tp_entry->list.next == &tracepoint_string_list)
+		return NULL;
 
-	return &mod_fmt->fmt;
+	tp_entry = list_next_entry(tp_entry, list);
+	return &tp_entry->str;
 }
 
 static void format_mod_start(void)
@@ -195,8 +258,8 @@ module_trace_format_notify(struct notifier_block *self,
 {
 	return NOTIFY_OK;
 }
-static inline const char **
-find_next_mod_format(int start_index, void *v, const char **fmt, loff_t *pos)
+static inline const char **find_next_mod_entry(int start_index, void *v,
+					       loff_t *pos)
 {
 	return NULL;
 }
@@ -274,7 +337,7 @@ bool trace_is_tracepoint_string(const char *str)
 {
 	const char **ptr = __start___tracepoint_str;
 #ifdef CONFIG_MODULES
-	struct trace_bprintk_fmt *tb_fmt;
+	struct tracepoint_string_entry *tp_entry;
 #endif
 
 	for (ptr = __start___tracepoint_str; ptr < __stop___tracepoint_str; ptr++) {
@@ -284,8 +347,8 @@ bool trace_is_tracepoint_string(const char *str)
 
 #ifdef CONFIG_MODULES
 	mutex_lock(&btrace_mutex);
-	list_for_each_entry(tb_fmt, &trace_bprintk_fmt_list, list) {
-		if ((tb_fmt->type & TRACE_TRACEPOINT_TYPE) && str == tb_fmt->fmt) {
+	list_for_each_entry(tp_entry, &tracepoint_string_list, list) {
+		if (str == tp_entry->str) {
 			mutex_unlock(&btrace_mutex);
 			return true;
 		}
@@ -297,9 +360,8 @@ bool trace_is_tracepoint_string(const char *str)
 
 static const char **find_next(void *v, loff_t *pos)
 {
-	const char **fmt = v;
 	int start_index;
-	int last_index;
+	int next_index;
 
 	start_index = __stop___trace_bprintk_fmt - __start___trace_bprintk_fmt;
 
@@ -307,25 +369,19 @@ static const char **find_next(void *v, loff_t *pos)
 		return __start___trace_bprintk_fmt + *pos;
 
 	/*
-	 * The __tracepoint_str section is treated the same as the
-	 * __trace_printk_fmt section. The difference is that the
-	 * __trace_printk_fmt section should only be used by trace_printk()
-	 * in a debugging environment, as if anything exists in that section
-	 * the trace_prink() helper buffers are allocated, which would just
-	 * waste space in a production environment.
-	 *
-	 * The __tracepoint_str sections on the other hand are used by
-	 * tracepoints which need to map pointers to their strings to
-	 * the ASCII text for userspace.
+	 * Built-in __tracepoint_str entries are exported directly from the
+	 * core section. Module tracepoint_string() mappings are kept on a
+	 * separate tracing-managed list below, because their lifetime is tied
+	 * to module load/unload and differs from module trace_printk() formats.
 	 */
-	last_index = start_index;
+	next_index = start_index;
 	start_index = __stop___tracepoint_str - __start___tracepoint_str;
 
-	if (*pos < last_index + start_index)
-		return __start___tracepoint_str + (*pos - last_index);
+	if (*pos < next_index + start_index)
+		return __start___tracepoint_str + (*pos - next_index);
 
-	start_index += last_index;
-	return find_next_mod_format(start_index, v, fmt, pos);
+	start_index += next_index;
+	return find_next_mod_entry(start_index, v, pos);
 }
 
 static void *
-- 
2.39.5 (Apple Git-154)

