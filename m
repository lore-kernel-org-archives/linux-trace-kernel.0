Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D0634F46F
	for <linux-trace-kernel@vger.kernel.org>; Fri, 23 Jan 2026 01:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769132281; cv=none; b=AtL5Ww97qEaFUPE+gD2h3grFZklTTfPWpiSkBqPmq/QjgIiBTFpTTAvQ7ePxB24VU1P44haa54DHhU3WmyBf0IGHShkrI0qUGx3viU1LJbrHEzlCTki2kCJd4jhApN4CLRAxjBmuz50FbqEmAT/OPZV+tul7LF7zTk0iUOHtVtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769132281; c=relaxed/simple;
	bh=TY36GsA8W9nb4mC7QAdd0hDSUk/fRcT92jP9uPFGf/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RKS8GduYpxStgbkwyoev2ClpSJUQXpJuxsTCiCgG5wZ/GsFCiBfR7kxV8to2r27ju6XJqrb5+H64oXdxctHIMR5cfP0Hm4zr6vn9lpGV1p517Msn7dl/KboRCKGoaNIliz332V9yoYWH8XgVifdksG7mQgWB4TumoHz63TWURoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=V0vN3tIN; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="V0vN3tIN"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769132260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4O4Ge5/fIG0Aa5SD1NQnMhtx6yMljK0jnKcfCz7GpIw=;
	b=V0vN3tINRA1gwYe30odBdN0ZrQ9NQIQsuISYnwGnFuCbk4Qfw0LvN7lUY2MB7l92nKD+dZ
	BOcCPqW/+kXA4+snQpYbvpiDBlA1MCG2rDzuJVibrKgXwGPvCiybu/LsINPnK06G0wjiDC
	fQg4VeuAdQ4z8Sx2Dciti1EEiJV033w=
From: sunliming@linux.dev
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	sunliming <sunliming@kylinos.cn>
Subject: [PATCH] tracing: kprobe-event: Return directly when dyn_event_list is empty
Date: Fri, 23 Jan 2026 09:36:41 +0800
Message-Id: <20260123013641.23066-1-sunliming@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: sunliming <sunliming@kylinos.cn>

In enable_boot_kprobe_events(), it returns directly when dyn_event_list is
empty, thereby reducing the function's execution time. This function may
otherwise wait for the event_mutex lock for tens of milliseconds on certain
machines, which is unnecessary when dyn_event_list is empty.

Signed-off-by: sunliming <sunliming@kylinos.cn>
---
 kernel/trace/trace_kprobe.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 9953506370a5..d89a403c99d4 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1982,6 +1982,9 @@ static __init void enable_boot_kprobe_events(void)
 	struct trace_kprobe *tk;
 	struct dyn_event *pos;
 
+	if (list_empty(&dyn_event_list))
+		return;
+
 	guard(mutex)(&event_mutex);
 	for_each_trace_kprobe(tk, pos) {
 		list_for_each_entry(file, &tr->events, list)
-- 
2.25.1

