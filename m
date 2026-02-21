Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E02B3EBF25;
	Sat, 21 Feb 2026 03:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771644625; cv=none; b=Z6Og26VIftB6gxjPiaMgislh1TkO2r/vKK7Q2pLehLHnmDkWXCkCaWMZoUS3Votkb/Az9cB1vbuSmTtTEsqokeDWKYSsBTAHSsrN/nB3ly0cMRWcxA2JX+JeZedWBqd0rMYvcR34FuFh89j35iO06o64FNYwInJCmgCCCD7rtt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771644625; c=relaxed/simple;
	bh=6UBxq5et4hM01Q0Qa+MVMVTHldhV6OSOtvhdw7sMW2k=;
	h=Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=JgQ3FECay8DtjnHypXRsyXRuNYQjtykhmmr8LZQU13sNvoMzMZ7CIzTgJOEfSrLrYtZ/ZGnHVRIiSZt6zhYRlkO5MJWBVUhHjW+1XW4f3LkXizfuAkXHvw9oleeE5XwPjbLG6zPLWIwuvujE1w6BxloPznWthlkyeyhLmtyKuTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mxct.zte.com.cn (unknown [192.168.251.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4fHt0s170dz5BNS0;
	Sat, 21 Feb 2026 11:30:21 +0800 (CST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4fHt0f1v1fz4xPS1;
	Sat, 21 Feb 2026 11:30:10 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 61L3U6V2070251;
	Sat, 21 Feb 2026 11:30:06 +0800 (+08)
	(envelope-from hu.shengming@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 21 Feb 2026 11:30:07 +0800 (CST)
X-Zmail-TransId: 2afb699926bfe61-e5df4
X-Mailer: Zmail v1.0
Message-ID: <20260221113007819YgrZsMGABff4Rc-O_fZxL@zte.com.cn>
In-Reply-To: <202602211116123227p4Je6QELxr2byqvy9kTE@zte.com.cn>
References: 202602211116123227p4Je6QELxr2byqvy9kTE@zte.com.cn
Date: Sat, 21 Feb 2026 11:30:07 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIDEvMl0gZmdyYXBoOiBmaXggdGhyZXNoX3JldHVybiBjbGVhciBwZXItdGFzayBub3RyYWNl?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 61L3U6V2070251
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: hu.shengming@zte.com.cn
X-SPF: None
X-SOURCE-IP: 192.168.251.13 unknown Sat, 21 Feb 2026 11:30:21 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 699926CD.000/4fHt0s170dz5BNS0

From: Shengming Hu <hu.shengming@zte.com.cn>

When tracing_thresh is enabled, function graph tracing uses
trace_graph_thresh_return() as the return handler. Unlike
trace_graph_return(), it did not clear the per-task
TRACE_GRAPH_NOTRACE flag set by the entry handler for
set_graph_notrace addresses. This could leave the task
permanently in "notrace" state and effectively disable
function graph tracing for that task.

Mirror trace_graph_return()'s per-task notrace handling by
clearing TRACE_GRAPH_NOTRACE and returning early when set.

Fixes: b84214890a9bc ("function_graph: Move graph notrace bit to
shadow stack global var")
Signed-off-by: Shengming Hu <hu.shengming@zte.com.cn>
---
 kernel/trace/trace_functions_graph.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 1de6f1573..cbe43680c 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -400,14 +400,15 @@ static void trace_graph_thresh_return(struct ftrace_graph_ret *trace,
 				      struct fgraph_ops *gops,
 				      struct ftrace_regs *fregs)
 {
+	unsigned long *task_var = fgraph_get_task_var(gops);
 	struct fgraph_times *ftimes;
 	struct trace_array *tr;
 	int size;

 	ftrace_graph_addr_finish(gops, trace);

-	if (trace_recursion_test(TRACE_GRAPH_NOTRACE_BIT)) {
-		trace_recursion_clear(TRACE_GRAPH_NOTRACE_BIT);
+	if (*task_var & TRACE_GRAPH_NOTRACE) {
+		*task_var &= ~TRACE_GRAPH_NOTRACE;
 		return;
 	}

-- 
2.25.1
