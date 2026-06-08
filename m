Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7185410D15;
	Mon,  8 Jun 2026 15:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780930978; cv=none; b=RDnzHqNB9woO/EAJCsYK2ietbl1tLg5MC5c5hN3dv58hVhg/BYqLkV59+sPNyajmS9KzVJdAj2ZL+8FyTq3c2CA9QUvYFd5QD4uTIcJYbsHdASgeNaQdNKHcRY40imJlXvf2xQABi6gufI0o9ulpThDOqo1y3tR+JnEy6v7rnyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780930978; c=relaxed/simple;
	bh=F+cqJiAqbjmDqc1ICxBYmiqgg+UjAe3s2eQS+FQnPcQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=l3b5Ia+VZscDmeHRnn4GS0fuYCo6Dhqe7zY1b1u8UxjBxpdxdMxQCsaPdFQ3gaWEatznVsJtUwNSZSipgRkqC2hRgreHG9zGXLcQU4yEIJqeJfnEuVZKmzyvqzQHS5eHRDGnBby77EDitrxGr31b7aiVBhYNyS0iA/75gxh8Jfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=mtZ5CeuF; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="mtZ5CeuF"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=PF89iBFGZWTNZRK9VOfuJ1iPwj8Hi/GsMeo0UG2WBCE=;
	b=mtZ5CeuF6orVQ8hpQLYEJu0b0OkRqsBoQGAcM5HSEYbGfbzHZRvVNamgEmVHYtipNU6uOLKnJ
	2qXRIISO7Qhep9R6d0mHmJxefwMHzDdSSX3Cg4q0HawYRJKVNuXFASkIGc634AzQ9k+Ndd/bDrQ
	Uz/sYg8gx0Tbp4V+QxDOJFg=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4gYw7P4JdWzpStt;
	Mon,  8 Jun 2026 22:54:57 +0800 (CST)
Received: from dggpemf100008.china.huawei.com (unknown [7.185.36.138])
	by mail.maildlp.com (Postfix) with ESMTPS id 4597E40569;
	Mon,  8 Jun 2026 23:02:45 +0800 (CST)
Received: from mdc.huawei.com (10.50.87.204) by dggpemf100008.china.huawei.com
 (7.185.36.138) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 8 Jun
 2026 23:02:44 +0800
From: Chen Jun <chenjun102@huawei.com>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>
CC: <chenjun102@huawei.com>
Subject: [PATCH] tracing: Add "within" filter for call-stack-based event filtering
Date: Mon, 8 Jun 2026 22:55:56 +0800
Message-ID: <20260608145556.94931-1-chenjun102@huawei.com>
X-Mailer: git-send-email 2.22.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf100008.china.huawei.com (7.185.36.138)

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
Signed-off-by: Chen Jun <chenjun102@huawei.com>
---
 Documentation/trace/events.rst     | 12 +++++++++
 include/linux/trace_events.h       |  1 +
 kernel/trace/trace.h               |  3 ++-
 kernel/trace/trace_events.c        |  3 +++
 kernel/trace/trace_events_filter.c | 41 ++++++++++++++++++++++++++++--
 5 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/Documentation/trace/events.rst b/Documentation/trace/events.rst
index 18d112963dec..6e3877d376a9 100644
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
index 40a43a4c7caf..9ed22c210add 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -851,6 +851,7 @@ enum {
 	FILTER_COMM,
 	FILTER_CPU,
 	FILTER_STACKTRACE,
+	FILTER_WITHIN,
 };
 
 extern int trace_event_raw_init(struct trace_event_call *call);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 80fe152af1dd..a383da42badf 100644
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
index c46e623e7e0d..b7d681e55b0c 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -199,6 +199,9 @@ static int trace_define_generic_fields(void)
 	__generic_field(char *, comm, FILTER_COMM);
 	__generic_field(char *, stacktrace, FILTER_STACKTRACE);
 	__generic_field(char *, STACKTRACE, FILTER_STACKTRACE);
+#ifdef CONFIG_STACKTRACE
+	__generic_field(char *, within, FILTER_WITHIN);
+#endif
 
 	return ret;
 }
diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 609325f57942..34e1a7f0b3cd 100644
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
@@ -1617,6 +1634,8 @@ static int filter_pred_fn_call(struct filter_pred *pred, void *event)
 		return filter_pred_cpumask_cpu(pred, event);
 	case FILTER_PRED_FN_FUNCTION:
 		return filter_pred_function(pred, event);
+	case FILTER_PRED_FN_WITHIN:
+		return filter_pred_within(pred, event);
 	case FILTER_PRED_TEST_VISITED:
 		return test_pred_visited_fn(pred, event);
 	default:
@@ -2002,10 +2021,28 @@ static int parse_pred(const char *str, void *data,
 
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
2.43.0

