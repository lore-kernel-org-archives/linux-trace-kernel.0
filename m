Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89AC482CD;
	Fri, 18 Oct 2024 14:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729260173; cv=none; b=uYS1t7VHOd5Dr3/R0Z8Y3ECpFd+eBOoaody5D28QxuSuCwCKXCoc8NKdnwEzKYb8Wx54M5Yj1nq2CAQThA8+/k/+RLF85vTVj4Wt99PsnhVeqbZYIfOiMoLUjO/wLoI/6oS5eARG/9EavfEI1wbZj/AjFClnw2I1TJJPNo+OuYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729260173; c=relaxed/simple;
	bh=K4tYDhHsveWZmm3WdwnUqB5IZiZ3moW/VVhB4u5iRiU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=U48CnR2n67lhepNErHPi2dM89zKpfCV+wTZ3J+D1gQ3Kka3jAfZccN+5KFg73j/rjhlkk/djU8jkRaVhQHtsb0P+g7GSAByCdnyF0TX6lGvFTEukGNa+Ic+SxUhKRO1+2JqrX5UX72CLLNsjMvUTuE7abItFhLgLOrZRY6UpddY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8036C4CEC3;
	Fri, 18 Oct 2024 14:02:52 +0000 (UTC)
Date: Fri, 18 Oct 2024 10:03:18 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Avadhut Naik <avadhut.naik@amd.com>,
 "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
Subject: [PATCH v2] tracing: Add __print_dynamic_array() helper
Message-ID: <20241018100318.0fd3c33b@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Steven Rostedt <rostedt@goodmis.org>

When printing a dynamic array in a trace event, the method is rather ugly.
It has the format of:

  __print_array(__get_dynamic_array(array),
            __get_dynmaic_array_len(array) / el_size, el_size)

Since dynamic arrays are known to the tracing infrastructure, create a
helper macro that does the above for you.

  __print_dynamic_array(array, el_size)

Which would expand to the same output.

Cc: Avadhut Naik <avadhut.naik@amd.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://lore.kernel.org/20240821134843.5faf9a15@gandalf.local.home

- Added parenthesis around el_size parameter in macro

 include/trace/stages/stage3_trace_output.h | 8 ++++++++
 include/trace/stages/stage7_class_define.h | 1 +
 samples/trace_events/trace-events-sample.h | 7 ++++++-
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/trace/stages/stage3_trace_output.h b/include/trace/stages/stage3_trace_output.h
index c1fb1355d309..1e7b0bef95f5 100644
--- a/include/trace/stages/stage3_trace_output.h
+++ b/include/trace/stages/stage3_trace_output.h
@@ -119,6 +119,14 @@
 		trace_print_array_seq(p, array, count, el_size);	\
 	})
 
+#undef __print_dynamic_array
+#define __print_dynamic_array(array, el_size)				\
+	({								\
+		__print_array(__get_dynamic_array(array),		\
+			      __get_dynamic_array_len(array) / (el_size), \
+			      (el_size));				\
+	})
+
 #undef __print_hex_dump
 #define __print_hex_dump(prefix_str, prefix_type,			\
 			 rowsize, groupsize, buf, len, ascii)		\
diff --git a/include/trace/stages/stage7_class_define.h b/include/trace/stages/stage7_class_define.h
index bcb960d16fc0..fcd564a590f4 100644
--- a/include/trace/stages/stage7_class_define.h
+++ b/include/trace/stages/stage7_class_define.h
@@ -22,6 +22,7 @@
 #undef __get_rel_cpumask
 #undef __get_rel_sockaddr
 #undef __print_array
+#undef __print_dynamic_array
 #undef __print_hex_dump
 #undef __get_buf
 
diff --git a/samples/trace_events/trace-events-sample.h b/samples/trace_events/trace-events-sample.h
index 55f9a3da92d5..999f78d380ae 100644
--- a/samples/trace_events/trace-events-sample.h
+++ b/samples/trace_events/trace-events-sample.h
@@ -319,7 +319,7 @@ TRACE_EVENT(foo_bar,
 		__assign_cpumask(cpum, cpumask_bits(mask));
 	),
 
-	TP_printk("foo %s %d %s %s %s %s %s (%s) (%s) %s", __entry->foo, __entry->bar,
+	TP_printk("foo %s %d %s %s %s %s %s %s (%s) (%s) %s", __entry->foo, __entry->bar,
 
 /*
  * Notice here the use of some helper functions. This includes:
@@ -363,6 +363,11 @@ TRACE_EVENT(foo_bar,
 		  __print_array(__get_dynamic_array(list),
 				__get_dynamic_array_len(list) / sizeof(int),
 				sizeof(int)),
+
+/*     A shortcut is to use __print_dynamic_array for dynamic arrays */
+
+		  __print_dynamic_array(list, sizeof(int)),
+
 		  __get_str(str), __get_str(lstr),
 		  __get_bitmask(cpus), __get_cpumask(cpum),
 		  __get_str(vstr))
-- 
2.45.2

