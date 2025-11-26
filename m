Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BEECA4E;
	Wed, 26 Nov 2025 09:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764149772; cv=none; b=PFNCdsRhZ3qmI3qVMF68IjzUC+7VhFoHwG89BhgH/E09gTXt303exOcXnI8ONdYJYgKhtd9vVc/TunjgO3RZD/zcCdCXRhdl4DWMWUZ//6NVeWP6qwLXWrxD3rpOEAepzqutQWEDFONLFasjg0cQOp+Gk/9xGsn6XAFny5KLXk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764149772; c=relaxed/simple;
	bh=4LAMaG47gRXDPCLwrq5B6EQpVTnMgHX8SMFuApNYACI=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=B4I4LUx3QJCiMK+2IqwhGRdoDkqodSQJ5zDO7ZsqkhBUpDihwS4mlhlVeXHE7DVbb6ZBC3jAMjFTIJnwxuB3r5wXaHEX0mU2XU/xyj16n+sE87AHg0SFd5DWV5yeNOO69QHs1IcuYsszMzzfxbWaH5YI6ORyc3Yeg4MRYK3sTig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4dGZF317yBz6Fy6K;
	Wed, 26 Nov 2025 17:36:07 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl2.zte.com.cn with SMTP id 5AQ9Znur087149;
	Wed, 26 Nov 2025 17:35:50 +0800 (+08)
	(envelope-from wang.yaxin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 26 Nov 2025 17:35:52 +0800 (CST)
Date: Wed, 26 Nov 2025 17:35:52 +0800 (CST)
X-Zmail-TransId: 2afa6926c9f8bf4-1e0f0
X-Mailer: Zmail v1.0
Message-ID: <20251126173552333XoJZN20143fWbsdTEtWoU@zte.com.cn>
In-Reply-To: <20251126172445319I7DWJm-KEEuCmqtLupteE@zte.com.cn>
References: 20251126172445319I7DWJm-KEEuCmqtLupteE@zte.com.cn
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <wang.yaxin@zte.com.cn>
To: <wang.yaxin@zte.com.cn>
Cc: <rostedt@goodmis.org>, <mhiramat@kernel.org>, <mark.rutland@arm.com>,
        <mathieu.desnoyers@efficios.com>, <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <hu.shengming@zte.com.cn>,
        <zhang.run@zte.com.cn>, <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIHYyIDMvM10gZmdyYXBoOiBSZW1vdmUgY29hcnNlIFBJRCBmaWx0ZXJpbmcgZnJvbSBncmFwaF9lbnRyeSgp?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 5AQ9Znur087149
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: wang.yaxin@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Wed, 26 Nov 2025 17:36:07 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6926CA07.000/4dGZF317yBz6Fy6K

From: Shengming Hu <hu.shengming@zte.com.cn>

With PID filtering working via ftrace_pids_enabled() and fgraph_pid_func,
the coarse-grained ftrace_trace_task() check in graph_entry() is obsolete.

It was only a fallback for uninitialized op->private (now fixed), and its
removal ensures consistent PID filtering with standard function tracing.

Also remove unused ftrace_trace_task() definition from trace.h.

Signed-off-by: Shengming Hu <hu.shengming@zte.com.cn>
---
 kernel/trace/trace.h                 | 9 ---------
 kernel/trace/trace_functions_graph.c | 3 ---
 2 files changed, 12 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 58be6d741..2bc985739 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1159,11 +1159,6 @@ struct ftrace_func_command {
 					char *params, int enable);
 };
 extern bool ftrace_filter_param __initdata;
-static inline int ftrace_trace_task(struct trace_array *tr)
-{
-	return this_cpu_read(tr->array_buffer.data->ftrace_ignore_pid) !=
-		FTRACE_PID_IGNORE;
-}
 extern int ftrace_is_dead(void);
 int ftrace_create_function_files(struct trace_array *tr,
 				 struct dentry *parent);
@@ -1181,10 +1176,6 @@ void ftrace_clear_pids(struct trace_array *tr);
 int init_function_trace(void);
 void ftrace_pid_follow_fork(struct trace_array *tr, bool enable);
 #else
-static inline int ftrace_trace_task(struct trace_array *tr)
-{
-	return 1;
-}
 static inline int ftrace_is_dead(void) { return 0; }
 static inline int
 ftrace_create_function_files(struct trace_array *tr,
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 44d5dc503..cb9aef060 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -233,9 +233,6 @@ static int graph_entry(struct ftrace_graph_ent *trace,
 		return 1;
 	}

-	if (!ftrace_trace_task(tr))
-		return 0;
-
 	if (ftrace_graph_ignore_func(gops, trace))
 		return 0;

-- 
2.25.1
