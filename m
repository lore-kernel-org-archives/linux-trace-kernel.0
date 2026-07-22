Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [45.157.188.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078B943CE70
	for <linux-trace-kernel@vger.kernel.org>; Wed, 22 Jul 2026 17:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784740358; cv=none; b=PnnzUzmfVYjmPC8y3IyUxDIZDtzKj/Q2tuzwvsrGo9GRbIgvLygFl4O8rWP4fcnzzzMMkCjeOCRNQThGKGJUgyyCT8zPWPSxOtqdOvIkaiUtEmAjnumgL3fkRQm2cOSZpYlNK0sbx0n5rrhhZgDrM0NEDGqDz1GxzFgo04luPJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784740358; c=relaxed/simple;
	bh=eA64fAcu3eda68Ms6cMpv3Np2q2Rp7OU/6aMwgsQg98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hO3++ry9ekj395KPSEak1SNv11DSIbxg8OaH9Ui1WM9CScOUP5HALMyiq4zaZNCNvwaFmwggrnXQHQlGHEEBwJfbPxd2ApWaWgRZ6bEe5kxFkIgLV912ExeNduQ6OZ/HbtehjMzwPZlCyaMFkWUZburzLEXnAtV6dkVgFmtBY0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=NehlVoUe; arc=none smtp.client-ip=45.157.188.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="NehlVoUe"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4h515f6Yn0zrkJ;
	Wed, 22 Jul 2026 19:12:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1784740342;
	bh=lbAK7cLdqqWUFp03v03vs6BR7pLRrduEWKGnD5D39Ik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NehlVoUeLewKAzdkrwMIG872kL0MbDF3BGM1LiQvz8gXjW2xI9KD/shnEBmqy2NtN
	 UdDpFyqrW2VTK5jUq7ThH4o3p3hzuxUZ1W1XXmH/QwSMGt1mFBurE/kieL7GfmkcC1
	 byFBMbxeXqmyal3sxe3EPVXTBsgGD9D7Nz9UoxWc=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4h515d675kzy18;
	Wed, 22 Jul 2026 19:12:21 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Christian Brauner <brauner@kernel.org>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Tingmao Wang <m@maowtm.org>,
	kernel-team@cloudflare.com,
	linux-security-module@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3 07/20] tracing: Add __print_untrusted_str()
Date: Wed, 22 Jul 2026 19:11:39 +0200
Message-ID: <20260722171159.2776765-8-mic@digikod.net>
In-Reply-To: <20260722171159.2776765-1-mic@digikod.net>
References: <20260722171159.2776765-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Landlock tracepoints expose filesystem paths and process names that may
contain spaces, equal signs, or other characters that break ftrace field
parsing.

Add a __print_untrusted_str() TP_printk helper that escapes separators
(space, equal sign), quotes, backslashes, and non-printable bytes via
string_escape_mem(), so an untrusted string cannot inject field
separators or control characters into the ftrace output and can be
unambiguously recovered.

This guarantee applies to the in-kernel ftrace text output (trace,
trace_pipe).  Userspace libtraceevent (perf, trace-cmd) does not yet
parse this helper, so a companion libtraceevent change is needed for
those consumers to pretty-print the field.

Cc: Günther Noack <gnoack@google.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Tingmao Wang <m@maowtm.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v2:
https://patch.msgid.link/20260406143717.1815792-6-mic@digikod.net
- Add a Return: kdoc for trace_print_untrusted_str_seq() and rename its
  declaration parameter to src.

Changes since v1:
https://patch.msgid.link/20250523165741.693976-4-mic@digikod.net
- Remove WARN_ON() (pointed out by Steven Rostedt).
---
 include/linux/trace_events.h               |  2 +
 include/trace/stages/stage3_trace_output.h |  4 ++
 include/trace/stages/stage7_class_define.h |  1 +
 kernel/trace/trace_output.c                | 44 ++++++++++++++++++++++
 4 files changed, 51 insertions(+)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 308c76b57d13..4ece9b8d9d6b 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -60,6 +60,8 @@ trace_print_hex_dump_seq(struct trace_seq *p, const char *prefix_str,
 			 int prefix_type, int rowsize, int groupsize,
 			 const void *buf, size_t len, bool ascii);
 
+const char *trace_print_untrusted_str_seq(struct trace_seq *s, const char *src);
+
 int trace_raw_output_prep(struct trace_iterator *iter,
 			  struct trace_event *event);
 extern __printf(2, 3)
diff --git a/include/trace/stages/stage3_trace_output.h b/include/trace/stages/stage3_trace_output.h
index 181b81335781..0235dbd11b52 100644
--- a/include/trace/stages/stage3_trace_output.h
+++ b/include/trace/stages/stage3_trace_output.h
@@ -133,6 +133,10 @@
 	trace_print_hex_dump_seq(p, prefix_str, prefix_type,		\
 				 rowsize, groupsize, buf, len, ascii)
 
+#undef __print_untrusted_str
+#define __print_untrusted_str(str)					\
+		trace_print_untrusted_str_seq(p, __get_str(str))
+
 #undef __print_ns_to_secs
 #define __print_ns_to_secs(value)			\
 	({						\
diff --git a/include/trace/stages/stage7_class_define.h b/include/trace/stages/stage7_class_define.h
index 47008897a795..f29a82e7a4c4 100644
--- a/include/trace/stages/stage7_class_define.h
+++ b/include/trace/stages/stage7_class_define.h
@@ -24,6 +24,7 @@
 #undef __print_array
 #undef __print_dynamic_array
 #undef __print_hex_dump
+#undef __print_untrusted_str
 #undef __get_buf
 
 #undef __event_in_hardirq
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index a5ad76175d10..f0a9b29b3e36 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -16,6 +16,7 @@
 #include <linux/btf.h>
 #include <linux/bpf.h>
 #include <linux/hashtable.h>
+#include <linux/string_helpers.h>
 
 #include "trace_output.h"
 #include "trace_btf.h"
@@ -325,6 +326,49 @@ trace_print_hex_dump_seq(struct trace_seq *p, const char *prefix_str,
 }
 EXPORT_SYMBOL(trace_print_hex_dump_seq);
 
+/**
+ * trace_print_untrusted_str_seq - print a string after escaping characters
+ * @s: trace seq struct to write to
+ * @src: The string to print
+ *
+ * Prints a string to a trace seq after escaping all special characters,
+ * including common separators (space, equal sign), quotes, and backslashes.
+ * This transforms a string from an untrusted source (e.g. user space) to make
+ * it:
+ * - safe to parse,
+ * - easy to read (for simple strings),
+ * - easy to get back the original.
+ *
+ * Return: A pointer to the escaped string within the trace seq buffer, or
+ * %NULL if @src is %NULL or the buffer is exhausted.
+ */
+const char *trace_print_untrusted_str_seq(struct trace_seq *s,
+					   const char *src)
+{
+	int escaped_size;
+	char *buf;
+	size_t buf_size = seq_buf_get_buf(&s->seq, &buf);
+	const char *ret = trace_seq_buffer_ptr(s);
+
+	/* Buffer exhaustion is normal when the trace buffer is full. */
+	if (!src || buf_size == 0)
+		return NULL;
+
+	escaped_size = string_escape_mem(src, strlen(src), buf, buf_size,
+		ESCAPE_SPACE | ESCAPE_SPECIAL | ESCAPE_NAP | ESCAPE_APPEND |
+		ESCAPE_OCTAL, " ='\"\\");
+	if (unlikely(escaped_size >= buf_size)) {
+		/* We need some room for the final '\0'. */
+		seq_buf_set_overflow(&s->seq);
+		s->full = 1;
+		return NULL;
+	}
+	seq_buf_commit(&s->seq, escaped_size);
+	trace_seq_putc(s, 0);
+	return ret;
+}
+EXPORT_SYMBOL(trace_print_untrusted_str_seq);
+
 int trace_raw_output_prep(struct trace_iterator *iter,
 			  struct trace_event *trace_event)
 {
-- 
2.54.0

