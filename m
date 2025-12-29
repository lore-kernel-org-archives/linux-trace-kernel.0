Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4889F125B2;
	Mon, 29 Dec 2025 21:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767044115; cv=none; b=GIglEisF9sD8AlmqttgMnAw5Ysa80o5vHdXl/W8asSz1CrFLGcR5PY5TbSDp9zinZg1eWZSk0cvNiq5UPN+YetwSXwYOruHiuHv5WVptbaGw2vueGzgYlVF6isosKGx9F+wIV648BG1en1Yll8oCP96Q9uoC7ZWhK9DFmtwtFFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767044115; c=relaxed/simple;
	bh=SO8t7QnJwih/QKJfn3HQw1+TBnCcRiOlF+z7gCW4zRs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=VUARx9NW4K8u3pY5hf7NF3EOyqSDnrRFjI5eb2lvAjk/gpX6GoZIZuQBHQtlVvoFzqVNtPxMUFWcJ1EEZUbKHRNAt1fwIjkUytKD6eDtvzq3E7DhO2bnVwI0ZdoWmOFOZxbAK58YROmSE5ck1xYdcikjgTjNU7nP6uXQnB5/xEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id D83AD1A635B;
	Mon, 29 Dec 2025 21:35:10 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id 2D02F20027;
	Mon, 29 Dec 2025 21:35:09 +0000 (UTC)
Date: Mon, 29 Dec 2025 16:35:15 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Thomas Ballasi
 <tballasi@linux.microsoft.com>, Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] tracing: Add __event_in_*irq() helpers
Message-ID: <20251229163515.3d1b0bba@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 2D02F20027
X-Stat-Signature: mmg1mqzahqdoeuhw6zjrdho3o9p6s6wr
X-Rspamd-Server: rspamout08
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+9YblZEktJ8OdSqbHqd/BQp1XtVdLWBqU=
X-HE-Tag: 1767044109-673832
X-HE-Meta: U2FsdGVkX187UPkluNOivEYAprESfQFbaVLp38ZwVAtsdLaIhd1PbfdYofrGEytErGWo+XEJBsZOazodMtxDCKEOW/hZaZkWHPGFv2TLCacPVfZ+7YiQxCbh8sskp8u005OqYm0zToo3k8r0nXJ6eqwzFR+TYx51KFQUZWGO6VKo2j3VRsBq+jgu3njQ4UAGh4GFlYXGzSs12POI6wccRSCJtd1XJvOq8e5nHsr1BON3uFnxjMiXPzzWOzkk7PpHxHQDUFbgRofLrXVDN1rGgubc18WZFG3xoMudLV0sS1pZQAcbDF0XPl8c+Iqj7BoRkXXrS/eYEBYZK3iXBVrGmW8Y/hRzY7QzA276O0sO3Ijy1Ru/RQ9ot11atyyvYTF7uCoaKNXCbN/pMZ7tgUgEdw==

From: Steven Rostedt <rostedt@goodmis.org>

Some trace events want to expose in their output if they were triggered in
an interrupt or softirq context. Instead of recording this in the event
structure itself, as this information is stored in the flags portion of
the event header, add helper macros that can be used in the print format:

  TP_printk("val=%d %s", __entry->val, __entry_in_irq() ? "(in-irq)" : "")

This will output "(in-irq)" for the event in the trace data if the event
was triggered in hard or soft interrupt context.

Link: https://lore.kernel.org/all/20251229132942.31a2b583@gandalf.local.home/

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/trace/stages/stage3_trace_output.h |  8 ++++++++
 include/trace/stages/stage7_class_define.h | 19 +++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/include/trace/stages/stage3_trace_output.h b/include/trace/stages/stage3_trace_output.h
index 1e7b0bef95f5..53a23988a3b8 100644
--- a/include/trace/stages/stage3_trace_output.h
+++ b/include/trace/stages/stage3_trace_output.h
@@ -150,3 +150,11 @@
 
 #undef __get_buf
 #define __get_buf(len)		trace_seq_acquire(p, (len))
+
+#undef __event_in_hardirq
+#undef __event_in_softirq
+#undef __event_in_irq
+
+#define __event_in_hardirq()	(__entry->ent.flags & TRACE_FLAG_HARDIRQ)
+#define __event_in_softirq()	(__entry->ent.flags & TRACE_FLAG_SOFTIRQ)
+#define __event_in_irq()	(__entry->ent.flags & (TRACE_FLAG_HARDIRQ | TRACE_FLAG_SOFTIRQ))
diff --git a/include/trace/stages/stage7_class_define.h b/include/trace/stages/stage7_class_define.h
index fcd564a590f4..47008897a795 100644
--- a/include/trace/stages/stage7_class_define.h
+++ b/include/trace/stages/stage7_class_define.h
@@ -26,6 +26,25 @@
 #undef __print_hex_dump
 #undef __get_buf
 
+#undef __event_in_hardirq
+#undef __event_in_softirq
+#undef __event_in_irq
+
+/*
+ * The TRACE_FLAG_* are enums. Instead of using TRACE_DEFINE_ENUM(),
+ * use their hardcoded values. These values are parsed by user space
+ * tooling elsewhere so they will never change.
+ *
+ * See "enum trace_flag_type" in linux/trace_events.h:
+ *   TRACE_FLAG_HARDIRQ
+ *   TRACE_FLAG_SOFTIRQ
+ */
+
+/* This is what is displayed in the format files */
+#define __event_in_hardirq()	(REC->common_flags & 0x8)
+#define __event_in_softirq()	(REC->common_flags & 0x10)
+#define __event_in_irq()	(REC->common_flags & 0x18)
+
 /*
  * The below is not executed in the kernel. It is only what is
  * displayed in the print format for userspace to parse.
-- 
2.51.0

