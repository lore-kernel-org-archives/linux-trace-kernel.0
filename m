Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2AF2DA75B;
	Wed, 26 Nov 2025 09:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764149634; cv=none; b=elIdG72wpK78OhPOIZ1N4eHqUcZoF86c4IH1DoUPCcAoZhLVRco1NjJ7Yf53RLk4+9w8bWG5Vy351x1E12GPj8JMjsZ9KJTmpxkq2NDg4dSXY+OgCnnAV8MfqxzNpCZEtH3NxZOBYyoD2koZTdhAqQ0qIhZgrKWLATNxxSen03U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764149634; c=relaxed/simple;
	bh=emByY0jXGzK1DSZ8USjnXnQUHRpmt/3rerWz7U+qx5A=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=AL1Qtwl4+A6mywKjHKb/d26WcudLCHAGEYIzU04D1xH6tqoiRYFoe+Ty4NfUg5jXPRMhKNeAL/c4eTVlDw1DOeo6NI9OvrVikSEJB8VG6UOa+DWKu8AamD6ZEEoG19uCMISuly/p361CpXcpYlDdtrnej1qx506zXajjaPSkMBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mxct.zte.com.cn (unknown [192.168.251.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4dGZBP6vKzz8Xs7M;
	Wed, 26 Nov 2025 17:33:49 +0800 (CST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4dGZBJ0pZWz501bP;
	Wed, 26 Nov 2025 17:33:44 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl1.zte.com.cn with SMTP id 5AQ9XTjq008452;
	Wed, 26 Nov 2025 17:33:29 +0800 (+08)
	(envelope-from wang.yaxin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 26 Nov 2025 17:33:31 +0800 (CST)
Date: Wed, 26 Nov 2025 17:33:31 +0800 (CST)
X-Zmail-TransId: 2afa6926c96bb45-1a045
X-Mailer: Zmail v1.0
Message-ID: <20251126173331679XGVF98NLhyLJRdtNkVZ6w@zte.com.cn>
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
Subject: =?UTF-8?B?W1BBVENIIHYyIDIvM10gZmdyYXBoOiBDaGVjayBmdHJhY2VfcGlkc19lbmFibGVkIG9uIHJlZ2lzdHJhdGlvbiBmb3IgZWFybHkgZmlsdGVyaW5n?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 5AQ9XTjq008452
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: wang.yaxin@zte.com.cn
X-SPF: None
X-SOURCE-IP: 192.168.251.13 unknown Wed, 26 Nov 2025 17:33:49 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6926C97D.006/4dGZBP6vKzz8Xs7M

From: Shengming Hu <hu.shengming@zte.com.cn>
When registering ftrace_graph, check if ftrace_pids_enabled is active.
If enabled, assign entryfunc to fgraph_pid_func to ensure filtering
is performed before executing the saved original entry function.

Signed-off-by: Shengming Hu <hu.shengming@zte.com.cn>
---
 kernel/trace/fgraph.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index f6f25d81a..65ac0f04a 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -1369,6 +1369,13 @@ int register_ftrace_graph(struct fgraph_ops *gops)

 	ftrace_graph_active++;

+	/* Always save the function, and reset at unregistering */
+	gops->saved_func = gops->entryfunc;
+#ifdef CONFIG_DYNAMIC_FTRACE
+	if (ftrace_pids_enabled(&gops->ops))
+		gops->entryfunc = fgraph_pid_func;
+#endif
+
 	if (ftrace_graph_active == 2)
 		ftrace_graph_disable_direct(true);

@@ -1388,8 +1395,6 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 	} else {
 		init_task_vars(gops->idx);
 	}
-	/* Always save the function, and reset at unregistering */
-	gops->saved_func = gops->entryfunc;

 	gops->ops.flags |= FTRACE_OPS_FL_GRAPH;

-- 
2.25.1
