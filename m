Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BF6566A;
	Sun, 23 Mar 2025 13:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742736483; cv=none; b=LmEfUsLz8rHkOJy2B3tzuACpS1ToU1a/jp+uBHosKcVDsd3VhQu9HDfYSleEl4QTW3r14r5Qmm3nlFFnT1kxmw5HITEMgln6A0Xd1lJpmFismOx9kwlfxEOBZEyA61Nd5w7Gtj/sJrPhnaRDlqWjGjMsNyXSIg395RQhg370YwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742736483; c=relaxed/simple;
	bh=orWFIqCXRc+k3Gv6P6A6r20D9X17+r9B5cXBO83Web0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ReBz7q2dhdPtm4yLHBXd9NtVX0dJ/c+nr2PbMjjEKHYuStuASxXVnCktp8QVTeOS9QH9dKDmMJ67B15s2KfSmz4WC1xvPjvQ+SDxpcq4mQmpzQAUmC7RiTItR0xFjp2jzJhI+wsADGOG+4ZzcKnPfgqk1QID0qBJEYIjNr5KOk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cTf+3Tqq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cTf+3Tqq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CAD3C4CEE2;
	Sun, 23 Mar 2025 13:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742736482;
	bh=orWFIqCXRc+k3Gv6P6A6r20D9X17+r9B5cXBO83Web0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cTf+3TqqZfDlQq23WWJw5/NCklaEue+lfhSyeOmUk9mBgUZZej61Abctfa9ZalaG/
	 odc0/PW/aEJk8+BYZjJH06KQbQFxbmnx2tzDW0Q/Bp9DXTDv9PwF0l/yf2oiPJPgvO
	 lFnclxps1Pmj45fQe/4S51mqPL+3NKpFN3uYj51CFp+kyza6zZE2WRXub/pdIi7Fru
	 +asuaTRLJrLol5HqfhkkkUbQqLtjxH8tN5AiV66QBChz1ZUBD3cbQHIlemPGm20p5y
	 HJPT7PcGhvEXQteyp9SZI6x9WPwjqM61AYx86sssMrCqLBNojsnaP9n0e6TkVKMUks
	 L0gQYkTZZqGpw==
From: Sasha Levin <sashal@kernel.org>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH] tracing: Use hashtable.h for event_hash
Date: Sun, 23 Mar 2025 09:28:00 -0400
Message-Id: <20250323132800.3010783-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250323083938.34aabf97@batman.local.home>
References: <20250323083938.34aabf97@batman.local.home>
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

Link: https://lore.kernel.org/20250319190545.3058319-1-sashal@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_output.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index b51ee93737734..72b699f909e8c 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -14,16 +14,17 @@
 #include <linux/idr.h>
 #include <linux/btf.h>
 #include <linux/bpf.h>
+#include <linux/hashtable.h>
 
 #include "trace_output.h"
 #include "trace_btf.h"
 
-/* must be a power of 2 */
-#define EVENT_HASHSIZE	128
+/* 2^7 = 128 */
+#define EVENT_HASH_BITS 7
 
 DECLARE_RWSEM(trace_event_sem);
 
-static struct hlist_head event_hash[EVENT_HASHSIZE] __read_mostly;
+static DEFINE_HASHTABLE(event_hash, EVENT_HASH_BITS);
 
 enum print_line_t trace_print_bputs_msg_only(struct trace_iterator *iter)
 {
@@ -779,11 +780,8 @@ void print_function_args(struct trace_seq *s, unsigned long *args,
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
@@ -838,7 +836,6 @@ void trace_event_read_unlock(void)
  */
 int register_trace_event(struct trace_event *event)
 {
-	unsigned key;
 	int ret = 0;
 
 	down_write(&trace_event_sem);
@@ -871,9 +868,7 @@ int register_trace_event(struct trace_event *event)
 	if (event->funcs->binary == NULL)
 		event->funcs->binary = trace_nop_print;
 
-	key = event->type & (EVENT_HASHSIZE - 1);
-
-	hlist_add_head(&event->node, &event_hash[key]);
+	hash_add(event_hash, &event->node, event->type);
 
 	ret = event->type;
  out:
@@ -888,7 +883,7 @@ EXPORT_SYMBOL_GPL(register_trace_event);
  */
 int __unregister_trace_event(struct trace_event *event)
 {
-	hlist_del(&event->node);
+	hash_del(&event->node);
 	free_trace_event_type(event->type);
 	return 0;
 }

base-commit: cac258af1363995736fd0d62f80b37e0937ded3f
-- 
2.39.5

