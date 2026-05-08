Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BD32F8E99;
	Fri,  8 May 2026 12:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778243535; cv=none; b=KHVB+WQTgh9U7ODwEDuVByrxupwYrISg82uuU+H18IEl12TLMvP5pqjhTpxH2ogqLpcTZdSCXpigvQhUmY/fGtDXs7U7/oS3jNYTC9wteG14GIYqlT00+2jRCfNH6Gp198hDtZXXyzy7mqhuTi8R7iaREB++0CB7ye+spXAcW+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778243535; c=relaxed/simple;
	bh=plfyk/TrAz40I93O4nh1R71kQdghuovb5in/6BPamUI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hV7yqf7ddfmKU3QecDtKpyPdIeu4YxKE2TiLlC5Rrori6O45ThRvQvpMpeic2JbdQjVp3tnE6PNa4Y5XMM9SRTf3TAODsEokGPgrgkfbYjJKirRMbITMpY7W8IRdqhbdBtFt+F4TtH5cOI+IDlW/yKgRHnpAUN1L7sx7V+cqzOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Zq+JYcrS; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Zq+JYcrS"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=fCGrgN0EMikwS3Zxxo/jIhUp30pLmtvgsNzlpXGk82A=;
	b=Zq+JYcrSpr0zoIv6yOn3HSjRG63nuKglJP5H9/kERhsYdTq1FP6wA0FOEblak3HPVATz7amqj
	fAxJ9leN0tf/DQRToAYEFUhW7CHm/st5/iP0WFElUiq83Yfqi7dcYcKJT3h5RSu85ELgLdADOac
	2rtUqrGh/A+n/Z+ihzJ2Hi0=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4gBpGb6PmhzcZyh;
	Fri,  8 May 2026 20:24:55 +0800 (CST)
Received: from dggpemf100008.china.huawei.com (unknown [7.185.36.138])
	by mail.maildlp.com (Postfix) with ESMTPS id 4E99240569;
	Fri,  8 May 2026 20:32:08 +0800 (CST)
Received: from mdc.huawei.com (10.50.87.204) by dggpemf100008.china.huawei.com
 (7.185.36.138) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 8 May
 2026 20:32:07 +0800
From: Chen Jun <chenjun102@huawei.com>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>
CC: <chenjun102@huawei.com>
Subject: [RFC PATCH] trace: Introduce a new filter_pred "caller"
Date: Fri, 8 May 2026 20:26:23 +0800
Message-ID: <20260508122623.74290-1-chenjun102@huawei.com>
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

Low-level functions have many call paths, and sometimes
we only care about the calls on a specific call path.
Add a new filter to filter based on the call stack.

Usage:
1. echo 'caller=="$function_name"' > events/../filter

Only support OP_EQ and OP_NE

Signed-off-by: Chen Jun <chenjun102@huawei.com>
---
 include/linux/trace_events.h       |  1 +
 kernel/trace/trace.h               |  3 ++-
 kernel/trace/trace_events.c        |  1 +
 kernel/trace/trace_events_filter.c | 40 ++++++++++++++++++++++++++++--
 4 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 40a43a4c7caf..1f109669a391 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -851,6 +851,7 @@ enum {
 	FILTER_COMM,
 	FILTER_CPU,
 	FILTER_STACKTRACE,
+	FILTER_CALLER,
 };
 
 extern int trace_event_raw_init(struct trace_event_call *call);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 80fe152af1dd..4e4b92ce264f 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1825,7 +1825,8 @@ static inline bool is_string_field(struct ftrace_event_field *field)
 	       field->filter_type == FILTER_RDYN_STRING ||
 	       field->filter_type == FILTER_STATIC_STRING ||
 	       field->filter_type == FILTER_PTR_STRING ||
-	       field->filter_type == FILTER_COMM;
+	       field->filter_type == FILTER_COMM ||
+	       field->filter_type == FILTER_CALLER;
 }
 
 static inline bool is_function_field(struct ftrace_event_field *field)
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index c46e623e7e0d..6d220d7eec73 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -199,6 +199,7 @@ static int trace_define_generic_fields(void)
 	__generic_field(char *, comm, FILTER_COMM);
 	__generic_field(char *, stacktrace, FILTER_STACKTRACE);
 	__generic_field(char *, STACKTRACE, FILTER_STACKTRACE);
+	__generic_field(char *, caller, FILTER_CALLER);
 
 	return ret;
 }
diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 609325f57942..1cf040065abe 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -72,6 +72,7 @@ enum filter_pred_fn {
 	FILTER_PRED_FN_CPUMASK,
 	FILTER_PRED_FN_CPUMASK_CPU,
 	FILTER_PRED_FN_FUNCTION,
+	FILTER_PRED_FN_CALLER,
 	FILTER_PRED_FN_,
 	FILTER_PRED_TEST_VISITED,
 };
@@ -1009,6 +1010,21 @@ static int filter_pred_function(struct filter_pred *pred, void *event)
 	return pred->op == OP_EQ ? ret : !ret;
 }
 
+/* Filter predicate for caller. */
+static int filter_pred_caller(struct filter_pred *pred, void *event)
+{
+	unsigned long entries[32];
+	unsigned int nr_entries;
+	int i;
+
+	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 0);
+	for (i = 0; i < nr_entries ; i++)
+		if (pred->val <= entries[i] && entries[i] < pred->val2)
+			return !pred->not;
+
+	return pred->not;
+}
+
 /*
  * regex_match_foo - Basic regex callbacks
  *
@@ -1617,6 +1633,8 @@ static int filter_pred_fn_call(struct filter_pred *pred, void *event)
 		return filter_pred_cpumask_cpu(pred, event);
 	case FILTER_PRED_FN_FUNCTION:
 		return filter_pred_function(pred, event);
+	case FILTER_PRED_FN_CALLER:
+		return filter_pred_caller(pred, event);
 	case FILTER_PRED_TEST_VISITED:
 		return test_pred_visited_fn(pred, event);
 	default:
@@ -2002,10 +2020,28 @@ static int parse_pred(const char *str, void *data,
 
 		} else if (field->filter_type == FILTER_DYN_STRING) {
 			pred->fn_num = FILTER_PRED_FN_STRLOC;
-		} else if (field->filter_type == FILTER_RDYN_STRING)
+		} else if (field->filter_type == FILTER_RDYN_STRING) {
 			pred->fn_num = FILTER_PRED_FN_STRRELLOC;
-		else {
+		} else if (field->filter_type == FILTER_CALLER) {
+			unsigned long caller;
+
+			if (op == OP_GLOB)
+				goto err_free;
 
+			pred->fn_num = FILTER_PRED_FN_CALLER;
+			caller = kallsyms_lookup_name(pred->regex->pattern);
+			if (!caller) {
+				parse_error(pe, FILT_ERR_NO_FUNCTION, pos + i);
+				goto err_free;
+			}
+			/* Now find the function start and end address */
+			if (!kallsyms_lookup_size_offset(caller, &size, &offset)) {
+				parse_error(pe, FILT_ERR_NO_FUNCTION, pos + i);
+				goto err_free;
+			}
+			pred->val = caller - offset;
+			pred->val2 = pred->val + size;
+		} else {
 			if (!ustring_per_cpu) {
 				/* Once allocated, keep it around for good */
 				ustring_per_cpu = alloc_percpu(struct ustring_buffer);
-- 
2.22.0

