Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CDD27147B;
	Tue,  8 Jul 2025 11:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751975692; cv=none; b=jcb3URyAeiDH8TXzdk4agHSY1aB0Bs5S5+cfzBgMBcl1Se7uTpx7o0p31Tge/aRXRXfFR8xXFcqxcZwTLQyRNQh2EXuawMCWF1BuktrAXdFAiphnu+RZEY7QkBqWkubKQbYZPVVLNr24+Fsi6fvVsrB9inHdirxkZK/WDrNG/Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751975692; c=relaxed/simple;
	bh=fQG3kKSUJ3BfktkgBw3TMCoEtNHEtHrhF4SWHgF05b4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BZ/BxO4JjAX3EtsOL4tI+NeiuAXTNUev4lH5Jlak9f2olhuh8Ii0qrRV3tdbgE1GA6YTo+96d3RWrvnexYW9F0c8wn6hZPXv03TLlEJJvlZaRq8S1SdRzCRzjQXPliCo3JMvI3tIZ1/9vE7ayxXa2pnDKyXP6alISyofWThPmH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MoEqo5J0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MoEqo5J0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA90C4CEED;
	Tue,  8 Jul 2025 11:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751975691;
	bh=fQG3kKSUJ3BfktkgBw3TMCoEtNHEtHrhF4SWHgF05b4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MoEqo5J0kQ6oL7VHdaTEjzWaH/glDW1SVG8i5xoeDR0IAaRT8RxSFCON9VPKoNGtO
	 EeLnLUeJ2ZcrwZCVgyHsXzqibHnY/CnLqwDqk41pjt5DOzyyWm7vQfNLNVee86EQET
	 pzvCIf82mq9c4ba2ycOzbYG9uOyFeSeLiWvXC+Mvi168uQyIYI0yM1GPPDeaIGf1FC
	 if9QIRmQQqitBkZrjuwGBl9SOfIByOlwL5RgCpOZicdvhe3IH5FOhwXeWyP7R/Za+K
	 FzexdhYyUF91O4OKxYxgCS0oztpQ5MsHyJeZWfxgwWk0Ahkq4tPgD+vLmxTFhJe6fU
	 6i3mzSWcoTixw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 1/2] tracing: Remove "__attribute__()" from the type field of event format
Date: Tue,  8 Jul 2025 20:54:49 +0900
Message-ID:  <175197568917.977073.2201559708302320631.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To:  <175197567999.977073.8989204607899013923.stgit@mhiramat.tok.corp.google.com>
References:  <175197567999.977073.8989204607899013923.stgit@mhiramat.tok.corp.google.com>
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
 kernel/trace/trace_events.c |   44 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 120531268abf..2f950aceb783 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -112,18 +112,59 @@ trace_find_event_field(struct trace_event_call *call, char *name)
 	return __find_event_field(&ftrace_common_fields, name);
 }
 
-static int __trace_define_field(struct list_head *head, const char *type,
+#define ATTRIBUTE_STR "__attribute__"
+
+/* Remove all __attribute__() from type */
+static void sanitize_field_type(char *type)
+{
+	static const int attr_len = strlen(ATTRIBUTE_STR);
+	char *attr, *tmp, *next;
+	int depth;
+
+	next = type;
+	while ((attr = strstr(next, ATTRIBUTE_STR))) {
+		next = attr + attr_len;
+
+		/* Retry if __attribute__ is a part of type name. */
+		if ((attr != type && !isspace(attr[-1])) ||
+		    attr[attr_len] != '(')
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
+	}
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
+
+	type = kstrdup(__type, GFP_KERNEL);
+	if (!type) {
+		kfree(field);
+		return -ENOMEM;
+	}
+	sanitize_field_type(type);
 	field->type = type;
 
 	if (filter_type == FILTER_OTHER)
@@ -225,6 +266,7 @@ static void trace_destroy_fields(struct trace_event_call *call)
 	head = trace_get_fields(call);
 	list_for_each_entry_safe(field, next, head, link) {
 		list_del(&field->link);
+		kfree(field->type);
 		kmem_cache_free(field_cachep, field);
 	}
 }

