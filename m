Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39390242D95;
	Tue, 27 Jan 2026 02:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769479341; cv=none; b=KBVF6kj/vkhOP+vJo1K8VmkxijRmznffcIVRASrN3vj7QFNUuL8X1vLA60TW3jcygOl4f9UcPC4c/KtJ34TMSZcn57FMgrk/mX5qHw2YnusH3kAhvOt1ouTL/kLwFQR2Iw/GQKTEguaDjQ1I9P6E87CHva9d0tImxxaq08+v9YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769479341; c=relaxed/simple;
	bh=F7ByjcefmErwR8fgIjz9N2nmR3wWC/KU+r40tshjBL0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YWhXbpyYr5eX7OKX566SiuBlkixZ/sLzO6CJqNM1Gj2luQ/+W+D4mugasZMjgi9e23gGn7qdtrczKU7O0wjiXttiepgpaqRDgEV2+0qCS2c9jCWC/BGHogoeFTF9PPnmDOm1obQHhLbgLDG+GIxZC5ZoOYaxeBgF34cUypMaIVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WDlqV08W; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WDlqV08W"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769479337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ix3WwbBztojb0QhDABHdVdmywKVtOHJqzuEyksoALmI=;
	b=WDlqV08WY/LHKlndBYb12yFMQMA+eLFFUNAN/2fcrnOJkVNvGk7XE6Sjks2Q+L7h3z4D5v
	qItR2+h44zUZ7J4IV5OaEATfoGWNQfMNoFaJEVhUpg+oeW8Q4rHig2rvRWclhwBHlm0DHP
	JxtWQ9mxL2UlsvrrK/9SoKwABpnyzto=
From: sunliming@linux.dev
To: ostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	sunliming <sunliming@kylinos.cn>
Subject: [PATCH] tracing: kprobe-event: Return directly when trace kprobes is empty
Date: Tue, 27 Jan 2026 10:01:37 +0800
Message-Id: <20260127020137.90205-1-sunliming@linux.dev>
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

