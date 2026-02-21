Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14D82264D3;
	Sat, 21 Feb 2026 03:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771644803; cv=none; b=QLL4/VQwBM+Ik6A+YukL3nGKbowzuzer9OkizyyJePWkIHUz5EsRy10Y3o5VJBi6hjU9KPzLJOrTbJSzutggALsGWEG7oKj/YnGgNgD4MpUPMeo9Rjw13soQOqXuUEnWogC8YO17uzcGcoj4qwO+hapGsXFT5mhvAaWZn6gRp4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771644803; c=relaxed/simple;
	bh=qxFRjHjdvICMbUDSmKNdsW34v1XIvHUXQxsCkOxUrjA=;
	h=Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=okelpv4fMTQH1BxPvHW5IMl5MVXzGqAKm2qcy2bkzrT7hd26MEVGB7i2C2Mfe6n6DjHVlR/Ii3eFukwhJzVyg1MwhOf8Kc1ov5YPaygfjMmZL0Cytkn7yQhH2rBGFfknDRbIa1Tr6EsmwBk3UPI+ZKBRED2TXgb+n5qtI9b7QAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4fHt4F2Z6dz4xPRx;
	Sat, 21 Feb 2026 11:33:17 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 61L3XE9V070971;
	Sat, 21 Feb 2026 11:33:14 +0800 (+08)
	(envelope-from hu.shengming@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 21 Feb 2026 11:33:14 +0800 (CST)
X-Zmail-TransId: 2afc6999277a718-e66aa
X-Mailer: Zmail v1.0
Message-ID: <20260221113314048jE4VRwIyZEALiYByGK0My@zte.com.cn>
In-Reply-To: <202602211116123227p4Je6QELxr2byqvy9kTE@zte.com.cn>
References: 202602211116123227p4Je6QELxr2byqvy9kTE@zte.com.cn
Date: Sat, 21 Feb 2026 11:33:14 +0800 (CST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <hu.shengming@zte.com.cn>
To: <hu.shengming@zte.com.cn>
Cc: <rostedt@goodmis.org>, <mhiramat@kernel.org>,
        <mathieu.desnoyers@efficios.com>, <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <zhang.run@zte.com.cn>,
        <yang.tao172@zte.com.cn>, <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIDIvMl0gZmdyYXBoOiBmaXggdGhyZXNoX3JldHVybiBub3NsZWVwdGltZSBkb3VibGUtYWRqdXN0?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 61L3XE9V070971
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: hu.shengming@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Sat, 21 Feb 2026 11:33:17 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6999277D.000/4fHt4F2Z6dz4xPRx

From: Shengming Hu <hu.shengming@zte.com.cn>

trace_graph_thresh_return() called handle_nosleeptime() and then
delegated to trace_graph_return(), which calls
handle_nosleeptime() again. When sleep-time accounting is
disabled this double-adjusts calltime and can produce bogus
durations (including underflow).

Fix this by computing rettime once, applying
handle_nosleeptime() only once, using the adjusted calltime
for threshold comparison, and writing the return event
directly via __trace_graph_return() when the threshold is met.

Fixes: 3c9880f3ab52b ("ftrace: Use a running sleeptime instead of
saving on shadow stack")
Signed-off-by: Shengming Hu <hu.shengming@zte.com.cn>
---
 kernel/trace/trace_functions_graph.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index cbe43680c..b9c81fbd9 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -403,8 +403,12 @@ static void trace_graph_thresh_return(struct ftrace_graph_ret *trace,
 	unsigned long *task_var = fgraph_get_task_var(gops);
 	struct fgraph_times *ftimes;
 	struct trace_array *tr;
+	unsigned int trace_ctx;
+	u64 calltime, rettime;
 	int size;

+	rettime = trace_clock_local();
+
 	ftrace_graph_addr_finish(gops, trace);

 	if (*task_var & TRACE_GRAPH_NOTRACE) {
@@ -419,11 +423,13 @@ static void trace_graph_thresh_return(struct ftrace_graph_ret *trace,
 	tr = gops->private;
 	handle_nosleeptime(tr, trace, ftimes, size);

-	if (tracing_thresh &&
-	    (trace_clock_local() - ftimes->calltime < tracing_thresh))
+	calltime = ftimes->calltime;
+
+	if (tracing_thresh && (rettime - calltime < tracing_thresh))
 		return;
-	else
-		trace_graph_return(trace, gops, fregs);
+
+	trace_ctx = tracing_gen_ctx();
+	__trace_graph_return(tr, trace, trace_ctx, calltime, rettime);
 }

 static struct fgraph_ops funcgraph_ops = {
-- 
2.25.1
