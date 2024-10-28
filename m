Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6684B188737;
	Mon, 28 Oct 2024 07:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730099539; cv=none; b=k9Avq3K6pQ2T1yoJxdML9d9UvVv0U9jLfpxpia3IAIFq/dMXpvZPjDBXkaqh3oPD8dQsgmtfdjlxUuzjbO5c0tGuweLgVbKwrrVEJOrc7ah+bmW5muBK6p7vFKNmTy24dsuVFF2VfGqqjofEvhbs0zfsfxPrQEFYBOzE5nCzKic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730099539; c=relaxed/simple;
	bh=KsohIQAJFRxFyrJE+8Xs1vbrzneRIvJPl7fp30prFUk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=VhX0SaGhg9LJ41DaPpSEus2uE+x/+7Af4PH4uxh5inMMf5gHPo+QfV+PZPR9WkvGK10n32m/5r3wa2uAHDsFKQ+qWuYjTkoJJFjz2cOaq0UyFxZnnwmiXzScau7ffL3gQyCRkz2CdDdrSq4vDXnoWZBTIbiFJyCm04TXuc81DYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23475C4CEC7;
	Mon, 28 Oct 2024 07:12:19 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1t5Jw3-000000053D3-3oGh;
	Mon, 28 Oct 2024 03:13:07 -0400
Message-ID: <20241028071307.770550792@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 28 Oct 2024 03:12:29 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 1/5] fgraph: Use guard(mutex)(&ftrace_lock) for unregister_ftrace_graph()
References: <20241028071228.575900713@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The ftrace_lock is held throughout unregister_ftrace_graph(), use a guard
to simplify the error paths.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/fgraph.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 001abf376c0c..0bf78517b5d4 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -1381,17 +1381,17 @@ void unregister_ftrace_graph(struct fgraph_ops *gops)
 {
 	int command = 0;
 
-	mutex_lock(&ftrace_lock);
+	guard(mutex)(&ftrace_lock);
 
 	if (unlikely(!ftrace_graph_active))
-		goto out;
+		return;
 
 	if (unlikely(gops->idx < 0 || gops->idx >= FGRAPH_ARRAY_SIZE ||
 		     fgraph_array[gops->idx] != gops))
-		goto out;
+		return;
 
 	if (fgraph_lru_release_index(gops->idx) < 0)
-		goto out;
+		return;
 
 	fgraph_array[gops->idx] = &fgraph_stub;
 
@@ -1413,7 +1413,5 @@ void unregister_ftrace_graph(struct fgraph_ops *gops)
 		unregister_pm_notifier(&ftrace_suspend_notifier);
 		unregister_trace_sched_switch(ftrace_graph_probe_sched_switch, NULL);
 	}
- out:
 	gops->saved_func = NULL;
-	mutex_unlock(&ftrace_lock);
 }
-- 
2.45.2


