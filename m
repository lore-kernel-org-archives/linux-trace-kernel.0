Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5728C34F470
	for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Jan 2026 18:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769106349; cv=none; b=HS+JfWlp9RobiKjbP7ZE1mchjJYyYAT6GLI3JOKfse9V3DQqJ2P+drguCC27YgbRm8ypdhz+0w6Lnd+dlGk6sdoNdh2w//1JQtrzUr8HihJFnAWKcQ5jgvesU4dv2BXFKI0Ax+LvdWDY2P+ttKIHofc4mYEE0vNp9ueEBny4rNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769106349; c=relaxed/simple;
	bh=11k8s9aimnGuWHroczZkJIMmXwBQ4EffC2dYgWAj2oA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VibPftlX0ZFpqxdZJi21ueRi38lXvps1f52vCWaaUdPt1cFkRy8qCRl8uE5ooC24SX4Y6BQRYWWz/x91XS+YXErwEbTS6qs25elfC70uqAL9kK/uZF+tK8NSGI1c9rJf1mT3ehmyX5qDtbYh9ZXMc7AGE+69Y49LKHOAVKsso5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=evo7g+qm; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="evo7g+qm"
Received: from LAPTOP-U3CCR7C6.corp.microsoft.com (unknown [4.255.188.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3D6CA20B716A;
	Thu, 22 Jan 2026 10:25:34 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3D6CA20B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769106334;
	bh=ZLuXLGuYqjOpfqifCcX9gqlKz9yHXRh2qxv6VaQbihU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=evo7g+qmB3X7dHYxjsirQj1/j4/hhcpk85GtEb8SV1ZJLSKal7dnV46Gga5tq1Thp
	 SnJkz7eAbwqhrT3z0ylZx0e8lvUufpKQt7SZLWa5uT3wfpIx0wM4hubdw6xYB9Rita
	 e6fj9SVes/fGafu6fWjCx3l65mMLZUItIdzojsyk=
From: Thomas Ballasi <tballasi@linux.microsoft.com>
To: tballasi@linux.microsoft.com
Cc: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	mhiramat@kernel.org,
	rostedt@goodmis.org
Subject: [PATCH v5 1/3] tracing: Add __event_in_*irq() helpers
Date: Thu, 22 Jan 2026 10:25:08 -0800
Message-Id: <20260122182510.2126-2-tballasi@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260122182510.2126-1-tballasi@linux.microsoft.com>
References: <20260115123809.2257-1-tballasi@linux.microsoft.com>
 <20260122182510.2126-1-tballasi@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index 1e7b0bef95f52..53a23988a3b8a 100644
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
index fcd564a590f43..47008897a7956 100644
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
2.33.8

