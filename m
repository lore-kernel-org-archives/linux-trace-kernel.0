Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F46026D4F1;
	Fri, 11 Jul 2025 10:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752231521; cv=none; b=kb5d9c4u7TQzfjcsDhBKllatWEwUbCiRC2sZFJebjCO12xq4wI7/T+G8Rh6UQgfVPpqKBLdha1fWVjAWrs07Ca3M4xVYvCPrM34ZUAl641v+eYOADLmubO7vBKprgiN4z2In+x23o38DkESYiQSwn6wvvl00Xi5AncxzYIQ8Am8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752231521; c=relaxed/simple;
	bh=aVsLb2cOuBff/SLrZpyW5DOCj+eMBrtqOyVzejo0ScA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kPqP2lrpNIvm7EtM7mYg+XNcagaSmjMQHJPo1eb9WT9IRW5uB06Dd2Fqm4h+GFJMomp29Eim2sT8sQ3LGavDkrtCxU6BbQbay3P1ZDZgw53DNsvRDau6YrX9FFvTK/xwiISOrrITanT7JnZCSgMSy5ha4sed323jvgI8H9iUuyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DVxsZK0X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DVxsZK0X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34DADC4CEED;
	Fri, 11 Jul 2025 10:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752231520;
	bh=aVsLb2cOuBff/SLrZpyW5DOCj+eMBrtqOyVzejo0ScA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DVxsZK0XRSjXpQJpWRfnHuOnwV4FBCnv/azvC47iebNT5QD386axCXJ4Bk8Soc0bL
	 sY1XkBQ3B/youNi31Z5TMB5aN06HTPJw/3wl31xw2GRZ+wg/EkTc9BrxJmYXDUMNWv
	 tKwX++L33hacwhYY0Vla7v3zWkHQrtP07eGDeh37f1LULXUzfJiRaePKiNZ+G2fJBc
	 l0jEE6Fu7bNJ+7O4sTOuXcQhdHZyIhNBiij5H+TxwbRuFtmycJkJ3YE4xxeJmij4Ln
	 cM50934kr9jWVGtA7+Hkewtu+oS7Oa+Wy80wQ/4aV0zfsIqloRqPj6MtpJ7uVXspIm
	 0CiYKH008wdlQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] tracing: Remove "__attribute__()" from the type field of event format
Date: Fri, 11 Jul 2025 19:58:38 +0900
Message-ID:  <175223151834.2878276.11017360679500958621.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To:  <175223150823.2878276.5814683250353215724.stgit@mhiramat.tok.corp.google.com>
References:  <175223150823.2878276.5814683250353215724.stgit@mhiramat.tok.corp.google.com>
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
Changes in v2:
 - Add memory allocation check flag.
 - Check the flag in update_event_fields() to avoid memory leak.
 - Fix 'static const int ... strlen()' issue.
 - Fix to find 2nd __attribute__ correctly. (adjust next after strcpy)
---
 kernel/trace/trace.h        |    1 +
 kernel/trace/trace_events.c |   74 ++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 67 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index bd084953a98b..cd7be4ce6ee9 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1468,6 +1468,7 @@ struct ftrace_event_field {
 	int			size;
 	unsigned int		is_signed:1;
 	unsigned int		needs_test:1;
+	unsigned int		alloc_type:1;
 	int			len;
 };
 
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 120531268abf..2e607afefff3 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -112,22 +112,74 @@ trace_find_event_field(struct trace_event_call *call, char *name)
 	return __find_event_field(&ftrace_common_fields, name);
 }
 
-static int __trace_define_field(struct list_head *head, const char *type,
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
+static int __trace_define_field(struct list_head *head, const char *__type,
 				const char *name, int offset, int size,
 				int is_signed, int filter_type, int len,
 				int need_test)
 {
 	struct ftrace_event_field *field;
+	char *type;
 
 	field = kmem_cache_alloc(field_cachep, GFP_TRACE);
 	if (!field)
 		return -ENOMEM;
 
 	field->name = name;
-	field->type = type;
+	if (need_sanitize_field_type(__type)) {
+		type = kstrdup(__type, GFP_KERNEL);
+		if (!type) {
+			kfree(field);
+			return -ENOMEM;
+		}
+		sanitize_field_type(type);
+		field->type = type;
+		field->alloc_type = 1;
+	} else {
+		field->type = __type;
+		field->alloc_type = 0;
+	}
 
 	if (filter_type == FILTER_OTHER)
-		field->filter_type = filter_assign_type(type);
+		field->filter_type = filter_assign_type(field->type);
 	else
 		field->filter_type = filter_type;
 
@@ -225,6 +277,8 @@ static void trace_destroy_fields(struct trace_event_call *call)
 	head = trace_get_fields(call);
 	list_for_each_entry_safe(field, next, head, link) {
 		list_del(&field->link);
+		if (field->alloc_type)
+			kfree(field->type);
 		kmem_cache_free(field_cachep, field);
 	}
 }
@@ -3290,10 +3344,14 @@ static void update_event_fields(struct trace_event_call *call,
 		if (strncmp(map->eval_string, ptr, len) != 0)
 			continue;
 
-		str = kstrdup(field->type, GFP_KERNEL);
-		if (WARN_ON_ONCE(!str))
-			return;
-		ptr = str + (ptr - field->type);
+		if (!field->alloc_type) {
+			str = kstrdup(field->type, GFP_KERNEL);
+			if (WARN_ON_ONCE(!str))
+				return;
+			ptr = str + (ptr - field->type);
+		} else
+			str = (char *)field->type;
+
 		ptr = eval_replace(ptr, map, len);
 		/* enum/sizeof string smaller than value */
 		if (WARN_ON_ONCE(!ptr)) {
@@ -3306,7 +3364,7 @@ static void update_event_fields(struct trace_event_call *call,
 		 * when the module is removed. Otherwise, it will stay allocated
 		 * until a reboot.
 		 */
-		if (call->module)
+		if (!field->alloc_type && call->module)
 			add_str_to_module(call->module, str);
 
 		field->type = str;

