Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0BA72634;
	Tue, 29 Jul 2025 05:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753765838; cv=none; b=CQMivFns7bGQb0C9lmQAbESYkbRBFstkd0j9atfWaVnpcu5AVboWiBDymXLXvn0XJn062AJWSBhjfRINWKupIoKPJxMXyGiU8yGaiB1NOhaiwvAbXE2tx6K1Gj7fPVcMBOoxWgsuWaSRoXPR195HJLk6VlMD6ohGkqkb1jaym0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753765838; c=relaxed/simple;
	bh=dLFCLzCQoLKMIXrIRtIQKOk27HbnKl9yUAAwBqKblyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iZ0c0dsagfFf8KRTh/IZ32hcbsj8W7kgefKvb+/qHNuKCwjcfNtj4NIEbcS4984Q8L1bwNZjoCaJkvYe9h0tSETuk6roan8B7VlQf/MLNVES35roklsv/3eFNd41Eh/El5bH80/DdEZFvqpJQwEtLA8ZSc8S0h/D1jAegy+ZdBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YsXdrFEv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YsXdrFEv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A82DAC4CEEF;
	Tue, 29 Jul 2025 05:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753765837;
	bh=dLFCLzCQoLKMIXrIRtIQKOk27HbnKl9yUAAwBqKblyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YsXdrFEvvwq+K8KnE5PFUmwcd2x7kPysbmXmV2rcYAJ41pCHXisyAiNX47DIG4RNV
	 LUElk3PAQkxdjXWLi8F4hSJGx1obcwKpgODVmJHsSzE43KloUGO/9emkvIsPqbULnI
	 V2iB8PpOgcaB5BEM1VAm/13Hyfg8VQzWdPME+tLigbjiXciE24N3H3HEix6NXQV42t
	 cxivFywwH4zdZhxrgRAixgO7YQSM0G/JvaNt6/ZMMSitZY5gxP+XANUUfdcDjkimvR
	 YM2eRKoT234IFvekTBpu/mjDPHO/HLSGih4Zr21TqQ+MycJ91jDLgeqZpEbRuolsix
	 SdjSmZwdXdLtA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v5 1/1] tracing: Remove "__attribute__()" from the type field of event format
Date: Tue, 29 Jul 2025 14:10:35 +0900
Message-ID:  <175376583493.1688759.12333973498014733551.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
In-Reply-To:  <175376582586.1688759.2122686728240441891.stgit@mhiramat.tok.corp.google.com>
References:  <175376582586.1688759.2122686728240441891.stgit@mhiramat.tok.corp.google.com>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

With CONFIG_DEBUG_INFO_BTF=y and PAHOLE_HAS_BTF_TAG=y, `__user` is
converted to `__attribute__((btf_type_tag("user")))`. In this case,
some syscall events have it for __user data, like below;

/sys/kernel/tracing # cat events/syscalls/sys_enter_openat/format
name: sys_enter_openat
ID: 720
format:
        field:unsigned short common_type;       offset:0;       size:2; signed:0;
        field:unsigned char common_flags;       offset:2;       size:1; signed:0;
        field:unsigned char common_preempt_count;       offset:3;       size:1; signed:0;
        field:int common_pid;   offset:4;       size:4; signed:1;

        field:int __syscall_nr; offset:8;       size:4; signed:1;
        field:int dfd;  offset:16;      size:8; signed:0;
        field:const char __attribute__((btf_type_tag("user"))) * filename;      offset:24;      size:8; signed:0;
        field:int flags;        offset:32;      size:8; signed:0;
        field:umode_t mode;     offset:40;      size:8; signed:0;


Then the trace event filter fails to set the string acceptable flag
(FILTER_PTR_STRING) to the field and rejects setting string filter;

 # echo 'filename.ustring ~ "*ftracetest-dir.wbx24v*"' \
    >> events/syscalls/sys_enter_openat/filter
 sh: write error: Invalid argument
 # cat error_log
 [  723.743637] event filter parse error: error: Expecting numeric field
   Command: filename.ustring ~ "*ftracetest-dir.wbx24v*"

Since this __attribute__ makes format parsing complicated and not
needed, remove the __attribute__(.*) from the type string.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v5:
 - Simplify the btf_type_tag check.
 - Include '(' to ATTRIBUTE_STR so that we can skip the first '('.
 - Run sanitize_field_type() first to avoid strstr() check and remove
   need_sanitize flag.
 - Also, simplify error handling. If failed to allocate memory, return
   immediately, but if there is any wrong string etc, it just skips the
   field.
Changes in v4:
 - Run sanitizer only if btf_type_tag() attribute is defined.
Changes in v3:
 - Sanitize field in update_event_field() to avoid boottime performance
   overhead.
 - Change the function names because those are not always require eval
   maps.
 - Remove unneeded alloc_type flag.
Changes in v2:
 - Add memory allocation check flag.
 - Check the flag in update_event_fields() to avoid memory leak.
 - Fix 'static const int ... strlen()' issue.
 - Fix to find 2nd __attribute__ correctly. (adjust next after strcpy)
---
 kernel/trace/trace.c        |   28 ++++++---
 kernel/trace/trace.h        |    4 +
 kernel/trace/trace_events.c |  128 ++++++++++++++++++++++++++++++++++++-------
 3 files changed, 127 insertions(+), 33 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 95ae7c4e5835..e992a9ba8281 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5937,17 +5937,27 @@ static inline void trace_insert_eval_map_file(struct module *mod,
 			      struct trace_eval_map **start, int len) { }
 #endif /* !CONFIG_TRACE_EVAL_MAP_FILE */
 
-static void trace_insert_eval_map(struct module *mod,
-				  struct trace_eval_map **start, int len)
+static void
+trace_event_update_with_eval_map(struct module *mod,
+				 struct trace_eval_map **start,
+				 int len)
 {
 	struct trace_eval_map **map;
 
-	if (len <= 0)
-		return;
+	/* Always run sanitizer only if btf_type_tag attr exists. */
+	if (len <= 0) {
+		if (!(IS_ENABLED(CONFIG_DEBUG_INFO_BTF) &&
+		      IS_ENABLED(CONFIG_PAHOLE_HAS_BTF_TAG) &&
+		      __has_attribute(btf_type_tag)))
+			return;
+	}
 
 	map = start;
 
-	trace_event_eval_update(map, len);
+	trace_event_update_all(map, len);
+
+	if (len <= 0)
+		return;
 
 	trace_insert_eval_map_file(mod, start, len);
 }
@@ -10335,7 +10345,7 @@ static void __init eval_map_work_func(struct work_struct *work)
 	int len;
 
 	len = __stop_ftrace_eval_maps - __start_ftrace_eval_maps;
-	trace_insert_eval_map(NULL, __start_ftrace_eval_maps, len);
+	trace_event_update_with_eval_map(NULL, __start_ftrace_eval_maps, len);
 }
 
 static int __init trace_eval_init(void)
@@ -10388,9 +10398,6 @@ bool module_exists(const char *module)
 
 static void trace_module_add_evals(struct module *mod)
 {
-	if (!mod->num_trace_evals)
-		return;
-
 	/*
 	 * Modules with bad taint do not have events created, do
 	 * not bother with enums either.
@@ -10398,7 +10405,8 @@ static void trace_module_add_evals(struct module *mod)
 	if (trace_module_has_bad_taint(mod))
 		return;
 
-	trace_insert_eval_map(mod, mod->trace_evals, mod->num_trace_evals);
+	/* Even if no trace_evals, this need to sanitize field types. */
+	trace_event_update_with_eval_map(mod, mod->trace_evals, mod->num_trace_evals);
 }
 
 #ifdef CONFIG_TRACE_EVAL_MAP_FILE
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index bd084953a98b..1dbf1d3cf2f1 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -2125,13 +2125,13 @@ static inline const char *get_syscall_name(int syscall)
 
 #ifdef CONFIG_EVENT_TRACING
 void trace_event_init(void);
-void trace_event_eval_update(struct trace_eval_map **map, int len);
+void trace_event_update_all(struct trace_eval_map **map, int len);
 /* Used from boot time tracer */
 extern int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set);
 extern int trigger_process_regex(struct trace_event_file *file, char *buff);
 #else
 static inline void __init trace_event_init(void) { }
-static inline void trace_event_eval_update(struct trace_eval_map **map, int len) { }
+static inline void trace_event_update_all(struct trace_eval_map **map, int len) { }
 #endif
 
 #ifdef CONFIG_TRACER_SNAPSHOT
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 120531268abf..a47869f8650e 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -3264,43 +3264,120 @@ static void add_str_to_module(struct module *module, char *str)
 	list_add(&modstr->next, &module_strings);
 }
 
+#define ATTRIBUTE_STR "__attribute__("
+#define ATTRIBUTE_STR_LEN (sizeof(ATTRIBUTE_STR) - 1)
+
+/* Remove all __attribute__() from @type. Return allocated string or @type. */
+static char *sanitize_field_type(const char *type)
+{
+	char *attr, *tmp, *next, *ret = (char *)type;
+	int depth;
+
+	next = (char *)type;
+	while ((attr = strstr(next, ATTRIBUTE_STR))) {
+		/* Retry if "__attribute__(" is a part of another word. */
+		if (attr != next && !isspace(attr[-1])) {
+			next = attr + ATTRIBUTE_STR_LEN;
+			continue;
+		}
+
+		if (ret == type) {
+			ret = kstrdup(type, GFP_KERNEL);
+			if (WARN_ON_ONCE(!ret))
+				return NULL;
+			attr = ret + (attr - type);
+		}
+
+		/* the ATTRIBUTE_STR already has the first '(' */
+		depth = 1;
+		next = attr + ATTRIBUTE_STR_LEN;
+		do {
+			tmp = strpbrk(next, "()");
+			/* There is unbalanced parentheses */
+			if (WARN_ON_ONCE(!tmp)) {
+				kfree(ret);
+				return (char *)type;
+			}
+
+			if (*tmp == '(')
+				depth++;
+			else
+				depth--;
+			next = tmp + 1;
+		} while (depth > 0);
+		next = skip_spaces(next);
+		strcpy(attr, next);
+		next = attr;
+	}
+	return ret;
+}
+
+static char *find_replacable_eval(const char *type, const char *eval_string,
+				  int len)
+{
+	char *ptr;
+
+	if (!eval_string)
+		return NULL;
+
+	ptr = strchr(type, '[');
+	if (!ptr)
+		return NULL;
+	ptr++;
+
+	if (!isalpha(*ptr) && *ptr != '_')
+		return NULL;
+
+	if (strncmp(eval_string, ptr, len) != 0)
+		return NULL;
+
+	return ptr;
+}
+
 static void update_event_fields(struct trace_event_call *call,
 				struct trace_eval_map *map)
 {
 	struct ftrace_event_field *field;
+	const char *eval_string = NULL;
 	struct list_head *head;
+	int len = 0;
 	char *ptr;
 	char *str;
-	int len = strlen(map->eval_string);
 
 	/* Dynamic events should never have field maps */
-	if (WARN_ON_ONCE(call->flags & TRACE_EVENT_FL_DYNAMIC))
+	if (call->flags & TRACE_EVENT_FL_DYNAMIC)
 		return;
 
+	if (map) {
+		eval_string = map->eval_string;
+		len = strlen(map->eval_string);
+	}
+
 	head = trace_get_fields(call);
 	list_for_each_entry(field, head, link) {
-		ptr = strchr(field->type, '[');
-		if (!ptr)
-			continue;
-		ptr++;
-
-		if (!isalpha(*ptr) && *ptr != '_')
-			continue;
+		str = sanitize_field_type(field->type);
+		if (!str)
+			return;
 
-		if (strncmp(map->eval_string, ptr, len) != 0)
-			continue;
+		ptr = find_replacable_eval(str, eval_string, len);
+		if (ptr) {
+			if (str == field->type) {
+				str = kstrdup(field->type, GFP_KERNEL);
+				if (WARN_ON_ONCE(!str))
+					return;
+				ptr = str + (ptr - field->type);
+			}
 
-		str = kstrdup(field->type, GFP_KERNEL);
-		if (WARN_ON_ONCE(!str))
-			return;
-		ptr = str + (ptr - field->type);
-		ptr = eval_replace(ptr, map, len);
-		/* enum/sizeof string smaller than value */
-		if (WARN_ON_ONCE(!ptr)) {
-			kfree(str);
-			continue;
+			ptr = eval_replace(ptr, map, len);
+			/* enum/sizeof string smaller than value */
+			if (WARN_ON_ONCE(!ptr)) {
+				kfree(str);
+				continue;
+			}
 		}
 
+		if (str == field->type)
+			continue;
 		/*
 		 * If the event is part of a module, then we need to free the string
 		 * when the module is removed. Otherwise, it will stay allocated
@@ -3310,14 +3387,18 @@ static void update_event_fields(struct trace_event_call *call,
 			add_str_to_module(call->module, str);
 
 		field->type = str;
+		if (field->filter_type == FILTER_OTHER)
+			field->filter_type = filter_assign_type(field->type);
 	}
 }
 
-void trace_event_eval_update(struct trace_eval_map **map, int len)
+/* Update all events for replacing eval and sanitizing */
+void trace_event_update_all(struct trace_eval_map **map, int len)
 {
 	struct trace_event_call *call, *p;
 	const char *last_system = NULL;
 	bool first = false;
+	bool updated;
 	int last_i;
 	int i;
 
@@ -3330,6 +3411,7 @@ void trace_event_eval_update(struct trace_eval_map **map, int len)
 			last_system = call->class->system;
 		}
 
+		updated = false;
 		/*
 		 * Since calls are grouped by systems, the likelihood that the
 		 * next call in the iteration belongs to the same system as the
@@ -3349,8 +3431,12 @@ void trace_event_eval_update(struct trace_eval_map **map, int len)
 				}
 				update_event_printk(call, map[i]);
 				update_event_fields(call, map[i]);
+				updated = true;
 			}
 		}
+		/* If not updated yet, update field for sanitizing. */
+		if (!updated)
+			update_event_fields(call, NULL);
 		cond_resched();
 	}
 	up_write(&trace_event_sem);

