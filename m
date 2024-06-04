Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8221514C586;
	Tue,  4 Jun 2024 21:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717536534; cv=none; b=HanW1ngPgTheoI6CnA1CNQI/VI0L/VT26VKHKzwDONf61QKz2CMXL2OpbXoTe1PalrOaNJrQXbCRc5lBQmrtyV39EBiclUyLjL1lKOM2tYJUE3EHtLXPzk5tm9ZS7NAv9VN95k88lNveRfV23ujH4PPFTe5yKSsaLOc+hmfKKJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717536534; c=relaxed/simple;
	bh=JhvSJxkMdY2PHLlJ3j/YPU1BE6x6XkU5wBZAtk/6Go4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=u6AwpmUv9jrsaU16hfydixf6eklXSOVksOVMQ3OlmxDl/CYngSdG/X06PZbUAsarFFnbS4mqFoQlNGyPDSbdY8YYv5nRE6DZUFu3+cDHDkj689kK+mCdjOqPA0uMsprns+2lnEbtGKUtAbX3ZC0VYmUN3XBGpt0ebWJ2gZXZXf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23302C4AF0B;
	Tue,  4 Jun 2024 21:28:54 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sEbiB-00000000bEK-06a2;
	Tue, 04 Jun 2024 17:28:55 -0400
Message-ID: <20240604212854.883675803@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 04 Jun 2024 17:28:20 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 3/5] ftrace: Remove "filter_hash" parameter from
 ftrace_hash_rec_disable/enable()
References: <20240604212817.384103202@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The functions ftrace_hash_rec_disable() and ftrace_hash_rec_enable()
always has 1 passed to its "ftrace_hash" parameter. Remove the parameter
and pass in true to __ftrace_hash_rec_update().

Also add some comments to both those functions explaining what they do.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 93c7c5fd4249..de652201c86c 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1895,16 +1895,24 @@ static bool __ftrace_hash_rec_update(struct ftrace_ops *ops,
 	return update;
 }
 
-static bool ftrace_hash_rec_disable(struct ftrace_ops *ops,
-				    int filter_hash)
+/*
+ * This is called when an ops is removed from tracing. It will decrement
+ * the counters of the dyn_ftrace records for all the functions that
+ * the @ops attached to.
+ */
+static bool ftrace_hash_rec_disable(struct ftrace_ops *ops)
 {
-	return __ftrace_hash_rec_update(ops, filter_hash, 0);
+	return __ftrace_hash_rec_update(ops, true, 0);
 }
 
-static bool ftrace_hash_rec_enable(struct ftrace_ops *ops,
-				   int filter_hash)
+/*
+ * This is called when an ops is added to tracing. It will increment
+ * the counters of the dyn_ftrace records for all the functions that
+ * the @ops attached to.
+ */
+static bool ftrace_hash_rec_enable(struct ftrace_ops *ops)
 {
-	return __ftrace_hash_rec_update(ops, filter_hash, 1);
+	return __ftrace_hash_rec_update(ops, true, 1);
 }
 
 static void ftrace_hash_rec_update_modify(struct ftrace_ops *ops,
@@ -3062,7 +3070,7 @@ int ftrace_startup(struct ftrace_ops *ops, int command)
 		return ret;
 	}
 
-	if (ftrace_hash_rec_enable(ops, 1))
+	if (ftrace_hash_rec_enable(ops))
 		command |= FTRACE_UPDATE_CALLS;
 
 	ftrace_startup_enable(command);
@@ -3104,7 +3112,7 @@ int ftrace_shutdown(struct ftrace_ops *ops, int command)
 	/* Disabling ipmodify never fails */
 	ftrace_hash_ipmodify_disable(ops);
 
-	if (ftrace_hash_rec_disable(ops, 1))
+	if (ftrace_hash_rec_disable(ops))
 		command |= FTRACE_UPDATE_CALLS;
 
 	ops->flags &= ~FTRACE_OPS_FL_ENABLED;
-- 
2.43.0


