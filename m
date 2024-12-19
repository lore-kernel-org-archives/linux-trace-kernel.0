Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89C41D79B8;
	Thu, 19 Dec 2024 20:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734639185; cv=none; b=pH5C+/S9lghDAgwvcSrZgHAnn3cM070+WHk7p1q5LX2Ydd9dYjno8/X7bxyl1xRXZTYsC9cXZP3+LJpl8eln+ikFH/I7Hkbv++7He+/WtqXGrHs3mWslVeulg9P5oL618wblddIuJqXV+xLd29zwr/B57BJyps/7RzUMVn6ncM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734639185; c=relaxed/simple;
	bh=ESOYR1Qzbg00EG7EwDSgN9QMFrTfsKOxEZnk3eqUmM4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=SZ+S+rNJbJLIPmclyA6CocSCvQrAsk4QADGBmeUDAlYQ1dC/St/40e/F8P90eYEqQ/NaEamkw8d6NE7EzSASFq67HwqM/J0WHYx84heR5cjm7k6NQ5+rAZ8tPIHN0AZKFESxOVmcyj+KASmfcE3lIWRX2QMcgEUrvmTZLDfLoLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FAB9C4CEE0;
	Thu, 19 Dec 2024 20:13:05 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tOMu3-0000000AONT-05IU;
	Thu, 19 Dec 2024 15:13:47 -0500
Message-ID: <20241219201346.870318466@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 19 Dec 2024 15:12:12 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 14/14] tracing: Switch trace_stat.c code over to use guard()
References: <20241219201158.193821672@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

There are a couple functions in trace_stat.c that have "goto out" or
equivalent on error in order to release locks that were taken. This can be
error prone or just simply make the code more complex.

Switch every location that ends with unlocking a mutex on error over to
using the guard(mutex)() infrastructure to let the compiler worry about
releasing locks. This makes the code easier to read and understand.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_stat.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/kernel/trace/trace_stat.c b/kernel/trace/trace_stat.c
index bb247beec447..b3b5586f104d 100644
--- a/kernel/trace/trace_stat.c
+++ b/kernel/trace/trace_stat.c
@@ -128,7 +128,7 @@ static int stat_seq_init(struct stat_session *session)
 	int ret = 0;
 	int i;
 
-	mutex_lock(&session->stat_mutex);
+	guard(mutex)(&session->stat_mutex);
 	__reset_stat_session(session);
 
 	if (!ts->stat_cmp)
@@ -136,11 +136,11 @@ static int stat_seq_init(struct stat_session *session)
 
 	stat = ts->stat_start(ts);
 	if (!stat)
-		goto exit;
+		return 0;
 
 	ret = insert_stat(root, stat, ts->stat_cmp);
 	if (ret)
-		goto exit;
+		return ret;
 
 	/*
 	 * Iterate over the tracer stat entries and store them in an rbtree.
@@ -157,13 +157,10 @@ static int stat_seq_init(struct stat_session *session)
 			goto exit_free_rbtree;
 	}
 
-exit:
-	mutex_unlock(&session->stat_mutex);
 	return ret;
 
 exit_free_rbtree:
 	__reset_stat_session(session);
-	mutex_unlock(&session->stat_mutex);
 	return ret;
 }
 
@@ -308,7 +305,7 @@ static int init_stat_file(struct stat_session *session)
 int register_stat_tracer(struct tracer_stat *trace)
 {
 	struct stat_session *session, *node;
-	int ret = -EINVAL;
+	int ret;
 
 	if (!trace)
 		return -EINVAL;
@@ -316,18 +313,18 @@ int register_stat_tracer(struct tracer_stat *trace)
 	if (!trace->stat_start || !trace->stat_next || !trace->stat_show)
 		return -EINVAL;
 
+	guard(mutex)(&all_stat_sessions_mutex);
+
 	/* Already registered? */
-	mutex_lock(&all_stat_sessions_mutex);
 	list_for_each_entry(node, &all_stat_sessions, session_list) {
 		if (node->ts == trace)
-			goto out;
+			return -EINVAL;
 	}
 
-	ret = -ENOMEM;
 	/* Init the session */
 	session = kzalloc(sizeof(*session), GFP_KERNEL);
 	if (!session)
-		goto out;
+		return -ENOMEM;
 
 	session->ts = trace;
 	INIT_LIST_HEAD(&session->session_list);
@@ -336,16 +333,13 @@ int register_stat_tracer(struct tracer_stat *trace)
 	ret = init_stat_file(session);
 	if (ret) {
 		destroy_session(session);
-		goto out;
+		return ret;
 	}
 
-	ret = 0;
 	/* Register */
 	list_add_tail(&session->session_list, &all_stat_sessions);
- out:
-	mutex_unlock(&all_stat_sessions_mutex);
 
-	return ret;
+	return 0;
 }
 
 void unregister_stat_tracer(struct tracer_stat *trace)
-- 
2.45.2


