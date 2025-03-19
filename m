Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA3D1DEFE3;
	Wed, 19 Mar 2025 19:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742411159; cv=none; b=aX2SWxy34HAL3taZ7b81UI5Qu7u7iTxgFx1g91kDG0oRA+azXrKc03AZCy4Gy4tbnt6ubT+5WDwsyBKUmsipgt7s9wDvSpaVFlgIlA0HsxMQr2MN/lD89DEZXMyy6poZQ76+eRLuycF+wsEcLM0rhXzipv06OTzFmTVDvm91HYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742411159; c=relaxed/simple;
	bh=sJawFSll4DDsNbIIypsVF/1RVSmQdUWhzvkwBwTdtok=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L2+HGvoAFl3pGKgFnqIQjr47R0EM9RVGMt+6jum+Na9XY5uhaNQOGlAUGzrmzAoBnFqrCYE0QvF5yKjIfwKlg1kS72iK9n7EXHtoGwxRROXcSVVU6CTZupjmATgwQbgvBggUb/VEMbpQXYlQCyzl9ibAuEwkIHXUWXcfYYfAQJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FHeyzWpf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHeyzWpf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C819C4CEE9;
	Wed, 19 Mar 2025 19:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742411159;
	bh=sJawFSll4DDsNbIIypsVF/1RVSmQdUWhzvkwBwTdtok=;
	h=From:To:Cc:Subject:Date:From;
	b=FHeyzWpf4Q5nWCbA04lQuh1lhTD2pPBfcwxwG8c0GbN676xoXViNH061I3S8X5hta
	 0MWnIvE3gbipN0oLMn4+u3QwK/xyWR6w5iNKNUTtXtTjLp2LrWYK/D8F3eMlFPeWGh
	 A3wKw7QEwvx5oo2v+wcdubx2V2cPRqfzNnLDiGcxDe6KifPot3vGlBcMBU6VKTn4t+
	 OdrD0R59GjY4kziUrSslijgjzBvMCBxTDuQ/fo3GWIZ5mHrQeAbL+VHLMpjWcPkAF0
	 IESQGOM+E9ZdNUbhr7jvV9KMa+dKokAb1dPXbdv9HRzBsxJTEW4FzWj6Dy1eHrvCfZ
	 qvOAlsVUYAApQ==
From: Sasha Levin <sashal@kernel.org>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH] tracing: Use hashtable.h for event_hash
Date: Wed, 19 Mar 2025 15:05:45 -0400
Message-Id: <20250319190545.3058319-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the event_hash array in trace_output.c to use the generic
hashtable implementation from hashtable.h instead of the manually
implemented hash table.

This simplifies the code and makes it more maintainable by using the
standard hashtable API defined in hashtable.h.

Rename EVENT_HASHSIZE to EVENT_HASH_BITS to properly reflect its new
meaning as the number of bits for the hashtable size.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_output.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 03d56f711ad14..3144d020e6c6f 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -12,15 +12,16 @@
 #include <linux/sched/clock.h>
 #include <linux/sched/mm.h>
 #include <linux/idr.h>
+#include <linux/hashtable.h>
 
 #include "trace_output.h"
 
-/* must be a power of 2 */
-#define EVENT_HASHSIZE	128
+/* 2^7 = 128 */
+#define EVENT_HASH_BITS 7
 
 DECLARE_RWSEM(trace_event_sem);
 
-static struct hlist_head event_hash[EVENT_HASHSIZE] __read_mostly;
+static DEFINE_HASHTABLE(event_hash, EVENT_HASH_BITS);
 
 enum print_line_t trace_print_bputs_msg_only(struct trace_iterator *iter)
 {
@@ -694,11 +695,8 @@ int trace_print_lat_context(struct trace_iterator *iter)
 struct trace_event *ftrace_find_event(int type)
 {
 	struct trace_event *event;
-	unsigned key;
 
-	key = type & (EVENT_HASHSIZE - 1);
-
-	hlist_for_each_entry(event, &event_hash[key], node) {
+	hash_for_each_possible(event_hash, event, node, type) {
 		if (event->type == type)
 			return event;
 	}
@@ -753,7 +751,6 @@ void trace_event_read_unlock(void)
  */
 int register_trace_event(struct trace_event *event)
 {
-	unsigned key;
 	int ret = 0;
 
 	down_write(&trace_event_sem);
@@ -786,9 +783,7 @@ int register_trace_event(struct trace_event *event)
 	if (event->funcs->binary == NULL)
 		event->funcs->binary = trace_nop_print;
 
-	key = event->type & (EVENT_HASHSIZE - 1);
-
-	hlist_add_head(&event->node, &event_hash[key]);
+	hash_add(event_hash, &event->node, event->type);
 
 	ret = event->type;
  out:
@@ -803,7 +798,7 @@ EXPORT_SYMBOL_GPL(register_trace_event);
  */
 int __unregister_trace_event(struct trace_event *event)
 {
-	hlist_del(&event->node);
+	hash_del(&event->node);
 	free_trace_event_type(event->type);
 	return 0;
 }
-- 
2.39.5

