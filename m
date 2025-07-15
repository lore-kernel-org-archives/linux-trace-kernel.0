Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E64A42A83;
	Tue, 15 Jul 2025 10:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752576965; cv=none; b=MjLlnNZdjzZuZrKUfP5mCLZ2c3LtW9QfeI5GxyblyGzxt7hFgM08FgQwo1y0OSpYFFRegM06akKKDPb4qFCWoafmyFPiSN5yDHVgjkpP3VgacQNJq+Nu/13LTsslJgQZpGDS+M1d6yCgU8Ze7rAPu7CEuyax3tSxYrRly/jrLu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752576965; c=relaxed/simple;
	bh=aaklRxaPTUR8EbW69n2ak7r+p6YjH7Y9zUA4a///7FY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H1v8gHOaPwqT+uPP3hANyTLmuD7GG/vsdxhBKJRtM+yRb4s0ke8E/PISaa3J7sOpCb7n5oE25+LHFf5Wk7WeuZOUQeiT4iplM6Rl3HRjuvwv8ed/RUhP/Mt1YZUquUSiUkKXgQE5pL/Od8j6El6hM5OJsfqu61veE6y4mRsrSig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPVy2jm8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPVy2jm8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05C7BC4CEE3;
	Tue, 15 Jul 2025 10:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752576964;
	bh=aaklRxaPTUR8EbW69n2ak7r+p6YjH7Y9zUA4a///7FY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mPVy2jm821I5bKjgXW6jkGAJZtaZUHDXPQaAETpGCUw7dxCvPwSA9IubwPnE4I5YX
	 HwDfNkZilT2UBXglDp+ueKeaByFSCCmWvZtQJA06WDJ1K6CDMLaJDcqI4wu2hQqKzb
	 PJIuL7FF4PhpT1OipdKXFzgzZZ6B1w4mpXlkdz7yhi1k7hofMopYEYrxwevkq4fJhr
	 GOyy2atzPSALW96uP4G9AVR/v2SuQdKmnxrA0fsbH0XvEGD2P5EUBHD0ePdvJHiygJ
	 pUCWzYFJCWGFYrEz2ShHASPpe0znigzyvF5f3QyOpxnpgYFPbDu6ON1XDwm/n0WS96
	 msdmCgp+X+gHQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3 1/1] tracing: Remove "__attribute__()" from the type field of event format
Date: Tue, 15 Jul 2025 19:56:02 +0900
Message-ID:  <175257696222.1655692.4019049819386139160.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To:  <175257695307.1655692.4466186614215884669.stgit@mhiramat.tok.corp.google.com>
References:  <175257695307.1655692.4466186614215884669.stgit@mhiramat.tok.corp.google.com>
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
 kernel/trace/trace.c        |   23 ++++-----
 kernel/trace/trace.h        |    4 +
 kernel/trace/trace_events.c |  115 +++++++++++++++++++++++++++++++++++++------
 3 files changed, 112 insertions(+), 30 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 95ae7c4e5835..37e930631ceb 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5937,17 +5937,20 @@ static inline void trace_insert_eval_map_file(struct module *mod,
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
-
 	map = start;
 
-	trace_event_eval_update(map, len);
+	/* This must run always for sanitizing. */
+	trace_event_update_all(map, len);
+
+	if (len <= 0)
+		return;
 
 	trace_insert_eval_map_file(mod, start, len);
 }
@@ -10335,7 +10338,7 @@ static void __init eval_map_work_func(struct work_struct *work)
 	int len;
 
 	len = __stop_ftrace_eval_maps - __start_ftrace_eval_maps;
-	trace_insert_eval_map(NULL, __start_ftrace_eval_maps, len);
+	trace_event_update_with_eval_map(NULL, __start_ftrace_eval_maps, len);
 }
 
 static int __init trace_eval_init(void)
@@ -10388,9 +10391,6 @@ bool module_exists(const char *module)
 
 static void trace_module_add_evals(struct module *mod)
 {
-	if (!mod->num_trace_evals)
-		return;
-
 	/*
 	 * Modules with bad taint do not have events created, do
 	 * not bother with enums either.
@@ -10398,7 +10398,8 @@ static void trace_module_add_evals(struct module *mod)
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
index 120531268abf..5289e2032678 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -3264,41 +3264,115 @@ static void add_str_to_module(struct module *module, char *str)
 	list_add(&modstr->next, &module_strings);
 }
 
+#define ATTRIBUTE_STR "__attribute__"
+#define ATTRIBUTE_STR_LEN (sizeof(ATTRIBUTE_STR) - 1)
+
+/* Remove all __attribute__() from type */
+static void sanitize_field_type(char *type)
+{
+	char *attr, *tmp, *next;
+	int depth;
+
+	next = type;
+	while ((attr = strstr(next, ATTRIBUTE_STR))) {
+		next = attr + ATTRIBUTE_STR_LEN;
+
+		/* Retry if __attribute__ is a part of type name. */
+		if ((attr != type && !isspace(attr[-1])) ||
+		    *next != '(')
+			continue;
+
+		depth = 0;
+		while ((tmp = strpbrk(next, "()"))) {
+			if (*tmp == '(')
+				depth++;
+			else
+				depth--;
+			next = tmp + 1;
+			if (depth == 0)
+				break;
+		}
+		next = skip_spaces(next);
+		strcpy(attr, next);
+		next = attr;
+	}
+}
+
+static bool need_sanitize_field_type(const char *type)
+{
+	return !!strstr(type, ATTRIBUTE_STR);
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
+	bool need_sanitize;
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
 
-		if (!isalpha(*ptr) && *ptr != '_')
-			continue;
-
-		if (strncmp(map->eval_string, ptr, len) != 0)
+		/* Check the field has bad string or eval. */
+		need_sanitize = need_sanitize_field_type(field->type);
+		ptr = find_replacable_eval(field->type, eval_string, len);
+		if (likely(!need_sanitize && !ptr))
 			continue;
 
 		str = kstrdup(field->type, GFP_KERNEL);
 		if (WARN_ON_ONCE(!str))
 			return;
-		ptr = str + (ptr - field->type);
-		ptr = eval_replace(ptr, map, len);
-		/* enum/sizeof string smaller than value */
-		if (WARN_ON_ONCE(!ptr)) {
-			kfree(str);
-			continue;
+
+		if (ptr) {
+			ptr = str + (ptr - field->type);
+
+			ptr = eval_replace(ptr, map, len);
+			/* enum/sizeof string smaller than value */
+			if (WARN_ON_ONCE(!ptr) && !need_sanitize) {
+				kfree(str);
+				continue;
+			}
+		}
+		if (need_sanitize) {
+			sanitize_field_type(str);
+			/* Update field type */
+			if (field->filter_type == FILTER_OTHER)
+				field->filter_type = filter_assign_type(str);
 		}
 
 		/*
@@ -3313,11 +3387,13 @@ static void update_event_fields(struct trace_event_call *call,
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
 
@@ -3330,6 +3406,7 @@ void trace_event_eval_update(struct trace_eval_map **map, int len)
 			last_system = call->class->system;
 		}
 
+		updated = false;
 		/*
 		 * Since calls are grouped by systems, the likelihood that the
 		 * next call in the iteration belongs to the same system as the
@@ -3349,8 +3426,12 @@ void trace_event_eval_update(struct trace_eval_map **map, int len)
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

