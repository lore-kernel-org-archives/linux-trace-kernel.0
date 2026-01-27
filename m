Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29882DC77B
	for <linux-trace-kernel@vger.kernel.org>; Tue, 27 Jan 2026 05:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769492387; cv=none; b=PYyIYlmCTJofBHtJ50qxvOZ5IyyMd5Ylz+nxDNaZfzI9pDQmJv8uhk7eHKRHT1DBaJdV5rX+WTAOiZt9BVZdjd5S+ahzoSfwx3rr3RDqCPgfprWYVGgNgUsejX8zOrKq/8I8qj4WfMPjLWe0Lb7cX9POTNg5fXs8KWtS4AjibYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769492387; c=relaxed/simple;
	bh=qfou8ULj+m4l7j190/CEAYVfPTCQPL3uKczrWOPclKA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ONyEbRBhFpp0pySLsqFvFxe6wkcx0A3kkwEOrphj0xUN2c+r4AmJK3/8BWCZl22uDXCHn0DoGCYFzSgjvjgU+lF2EE9OUf9SVHThlc/+FKiK/MaEoSNqr1k0EV02/kQKosu+2R0Zs7g+G/ClzhNoEOet6OOTwx5ZYOAlCVzKQPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ma6mC5YB; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ma6mC5YB"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769492382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CRsyKsTEWsn2PzWUB/t8s6VSNDnrUc/YcsOZrnmr/X0=;
	b=ma6mC5YBkTpH+UQoD0oQsP+tD6wkgB69Fd9HUVJ//+jWt9jZ4fTEYGVCG2bsnjC4ROgAde
	9EaHA7zGFV5wWZnxNM3acZ0QHmP62xbA8mfJbmdKRpOr93/Y7HiS0GoXdtvKviMFvHmq5U
	m729V3TCiTUWXbtwhG4rxHsTv7rUz3k=
From: sunliming@linux.dev
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	sunliming <sunliming@kylinos.cn>
Subject: [PATCH v2] tracing: kprobe-event: Return directly when trace kprobes is empty
Date: Tue, 27 Jan 2026 13:38:48 +0800
Message-Id: <20260127053848.108473-1-sunliming@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: sunliming <sunliming@kylinos.cn>

In enable_boot_kprobe_events(), it returns directly when trace kprobes is
empty, thereby reducing the function's execution time. This function may
otherwise wait for the event_mutex lock for tens of milliseconds on certain
machines, which is unnecessary when trace kprobes is empty.

Signed-off-by: sunliming <sunliming@kylinos.cn>
---
v2:
- wrap the the null check for the dyn_event_list with macro trace_kprobe_list_empty
---
 kernel/trace/trace_kprobe.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 9953506370a5..95f2c42603d5 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -82,6 +82,7 @@ static struct trace_kprobe *to_trace_kprobe(struct dyn_event *ev)
 #define for_each_trace_kprobe(pos, dpos)	\
 	for_each_dyn_event(dpos)		\
 		if (is_trace_kprobe(dpos) && (pos = to_trace_kprobe(dpos)))
+#define trace_kprobe_list_empty() list_empty(&dyn_event_list)
 
 static nokprobe_inline bool trace_kprobe_is_return(struct trace_kprobe *tk)
 {
@@ -1982,6 +1983,9 @@ static __init void enable_boot_kprobe_events(void)
 	struct trace_kprobe *tk;
 	struct dyn_event *pos;
 
+	if (trace_kprobe_list_empty())
+		return;
+
 	guard(mutex)(&event_mutex);
 	for_each_trace_kprobe(tk, pos) {
 		list_for_each_entry(file, &tr->events, list)
-- 
2.25.1

