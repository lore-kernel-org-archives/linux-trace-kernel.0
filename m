Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D3C3CD8D4;
	Fri, 21 Aug 2026 23:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787355016; cv=none; b=tgNia8P3XrQ/YZSKuYWF89+4wCBNMkJn2owQofMPpIK0l7J1m9K4LRvfdoQ1tlNMBcL4a7y1WVsYFvBWk6QIzaL9zum0VRA6q05MitkEBlMJZmcbQYlWi0i/uVCKuPLnGxc5bVfFTUJ1nPtRrJQTax/PPnfnNQMNeiKQRwSMLCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787355016; c=relaxed/simple;
	bh=cgB+yW7CnQOvvU7s4uZkYnzgBjqhRrKiDtupeCT6VQQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=HjaNH5PviinyVFWTRPJOxKPtMQwyKcOc+2Co6qVHt3jKZnfde3E3vtR9mlgkm/fPbwpT0LR7HxQ3yjuIKTfi2xcB6iBRHkye1bqOXjUQhSHrlY6KfxsCX8RARp5xBpyvpgvGXAsv/VJNBMW+ccpTAggA5hrot1dnhaAv0vW2TvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gprebwiX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gprebwiX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B9631F00A3E;
	Fri, 21 Aug 2026 23:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787355015;
	bh=2pL3RrCCrfq8gY4ns3n3oiNtBRHRtNg5z+ZdoLXJHfg=;
	h=Date:From:To:Cc:Subject:References;
	b=gprebwiXG3xXtsE3C1VaZvP/pGGpTO9bsGOjYvZbKv7odK/d9v7ivHSkI546fIs5a
	 RD5TBruwgJyKhNzMaAoFhPuUO+X3oi+nattGMKv6mv2txxwUre3a9ZYFSWiCPSnnso
	 Zen4wa6bO9oQu33V1BNtenDJL5wS4r+SH9YRkrgrRMJc5aBjJCxJRU9NhZVBqhF+XI
	 h2zOcOLxwyjo8U6HPysziVCsdfC5ODek3CJviHj1eBwUNv2XNQ3S16HWHBR6zpoeFl
	 3tvsNh9Z4Rn3q4EqkJMHfndzy2W8i2sBLJdahUtu6MwhMYILtXqJCyfAwti/CuQrH4
	 kBLzTrEqAwoUw==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1wxYhG-00000005rjM-1ypC;
	Fri, 21 Aug 2026 19:30:50 -0400
Message-ID: <20260821233050.335986786@kernel.org>
User-Agent: quilt/0.69
Date: Fri, 21 Aug 2026 19:28:21 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Chen Jun <chenjun102@huawei.com>
Subject: [PATCH v2 1/2] tracing: Add "within" filter for call-stack-based event filtering
References: <20260821232820.717143516@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Chen Jun <chenjun102@huawei.com>

Low-level kernel functions are called from many different paths.
When debugging, it is often useful to filter trace events to only
those occurring within a specific call chain.

Add a "within" filter predicate that tests whether a given function
appears in the current call stack at event time. The function name
is resolved to its address range via kallsyms during filter setup;
at runtime, stack_trace_save() captures the call stack and compares
each return address against the stored range.

Example:
  echo 'within == "vfs_read"' > events/sched/sched_switch/filter

Only "==" and "!=" operators are supported. The filter depends on
CONFIG_STACKTRACE.

Link: https://patch.msgid.link/20260608145556.94931-1-chenjun102@huawei.com
Signed-off-by: Chen Jun <chenjun102@huawei.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 Documentation/trace/events.rst     | 12 +++++++++
 include/linux/trace_events.h       |  1 +
 kernel/trace/trace.h               |  3 ++-
 kernel/trace/trace_events.c        |  3 +++
 kernel/trace/trace_events_filter.c | 41 ++++++++++++++++++++++++++++--
 5 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/Documentation/trace/events.rst b/Documentation/trace/events.rst
index 581f2260614b..a1a219208ecc 100644
--- a/Documentation/trace/events.rst
+++ b/Documentation/trace/events.rst
@@ -243,6 +243,18 @@ the function "security_prepare_creds" and less than the end of that function.
 The ".function" postfix can only be attached to values of size long, and can only
 be compared with "==" or "!=".
 
+The special field "within" can be used to filter events based on whether
+a specific function appears in the current call stack::
+
+  within == "function_name"
+  within != "function_name"
+
+For example, to only trace events where "vfs_read" is in the call stack::
+
+  # echo 'within == "vfs_read"' > events/sched/sched_switch/filter
+
+The within field supports only the "==" and "!=" operators.
+
 Cpumask fields or scalar fields that encode a CPU number can be filtered using
 a user-provided cpumask in cpulist format. The format is as follows::
 
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 5cbd09c8be8d..d0259a515a83 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -872,6 +872,7 @@ enum {
 	FILTER_COMM,
 	FILTER_CPU,
 	FILTER_STACKTRACE,
+	FILTER_WITHIN,
 };
 
 extern int trace_event_raw_init(struct trace_event_call *call);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 74a7a50d1e78..92eee3eca43a 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1825,7 +1825,8 @@ static inline bool is_string_field(struct ftrace_event_field *field)
 	       field->filter_type == FILTER_RDYN_STRING ||
 	       field->filter_type == FILTER_STATIC_STRING ||
 	       field->filter_type == FILTER_PTR_STRING ||
-	       field->filter_type == FILTER_COMM;
+	       field->filter_type == FILTER_COMM ||
+	       field->filter_type == FILTER_WITHIN;
 }
 
 static inline bool is_function_field(struct ftrace_event_field *field)
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 7313eb1361c9..874c0c023eb1 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -201,6 +201,9 @@ static int trace_define_generic_fields(void)
 	__generic_field(char *, comm, FILTER_COMM);
 	__generic_field(char *, stacktrace, FILTER_STACKTRACE);
 	__generic_field(char *, STACKTRACE, FILTER_STACKTRACE);
+#ifdef CONFIG_STACKTRACE
+	__generic_field(char *, within, FILTER_WITHIN);
+#endif
 
 	return ret;
 }
diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 6385cd662d8d..297bf156ea65 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -72,6 +72,7 @@ enum filter_pred_fn {
 	FILTER_PRED_FN_CPUMASK,
 	FILTER_PRED_FN_CPUMASK_CPU,
 	FILTER_PRED_FN_FUNCTION,
+	FILTER_PRED_FN_WITHIN,
 	FILTER_PRED_FN_,
 	FILTER_PRED_TEST_VISITED,
 };
@@ -1009,6 +1010,22 @@ static int filter_pred_function(struct filter_pred *pred, void *event)
 	return pred->op == OP_EQ ? ret : !ret;
 }
 
+/* Filter predicate for within. */
+static int filter_pred_within(struct filter_pred *pred, void *event)
+{
+#ifdef CONFIG_STACKTRACE
+	unsigned long entries[16];
+	unsigned int nr_entries;
+	int i;
+
+	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 0);
+	for (i = 0; i < nr_entries; i++)
+		if (pred->val <= entries[i] && entries[i] < pred->val2)
+			return !pred->not;
+#endif
+	return pred->not;
+}
+
 /*
  * regex_match_foo - Basic regex callbacks
  *
@@ -1615,6 +1632,8 @@ static int filter_pred_fn_call(struct filter_pred *pred, void *event)
 		return filter_pred_cpumask_cpu(pred, event);
 	case FILTER_PRED_FN_FUNCTION:
 		return filter_pred_function(pred, event);
+	case FILTER_PRED_FN_WITHIN:
+		return filter_pred_within(pred, event);
 	case FILTER_PRED_TEST_VISITED:
 		return test_pred_visited_fn(pred, event);
 	default:
@@ -2000,10 +2019,28 @@ static int parse_pred(const char *str, void *data,
 
 		} else if (field->filter_type == FILTER_DYN_STRING) {
 			pred->fn_num = FILTER_PRED_FN_STRLOC;
-		} else if (field->filter_type == FILTER_RDYN_STRING)
+		} else if (field->filter_type == FILTER_RDYN_STRING) {
 			pred->fn_num = FILTER_PRED_FN_STRRELLOC;
-		else {
+		} else if (field->filter_type == FILTER_WITHIN) {
+			unsigned long func;
+
+			if (op == OP_GLOB)
+				goto err_free;
 
+			pred->fn_num = FILTER_PRED_FN_WITHIN;
+			func = kallsyms_lookup_name(pred->regex->pattern);
+			if (!func) {
+				parse_error(pe, FILT_ERR_NO_FUNCTION, pos + i);
+				goto err_free;
+			}
+			/* Now find the function start and end address */
+			if (!kallsyms_lookup_size_offset(func, &size, &offset)) {
+				parse_error(pe, FILT_ERR_NO_FUNCTION, pos + i);
+				goto err_free;
+			}
+			pred->val = func - offset;
+			pred->val2 = pred->val + size;
+		} else {
 			if (!ustring_per_cpu) {
 				/* Once allocated, keep it around for good */
 				ustring_per_cpu = alloc_percpu(struct ustring_buffer);
-- 
2.53.0


