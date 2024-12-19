Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B357E1C2439;
	Thu, 19 Dec 2024 20:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734639184; cv=none; b=UZZqHMThkGrFRYbWlbqjlJ6aYuIr5cet44xEr+Jhb6+f2tGQkMUrKXEznHgMB+yNctWhvlPc67ey2Xkir8Axx3HA24Xur8ulGQCNShfkZEZCr60f6L0Gby/9I0K5DX8F8+6YNaRGEbGhy416lGXN+jyCHR5jPr88b5bHU4QGafA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734639184; c=relaxed/simple;
	bh=Cw1FsvoYGdtheburEOwZ/bypqkYPYKSx4oXX0Q8tAuk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=JX/QLB9Pmt0yhpsTJYJJhhoYZVnZstseCoDSysmaC1tf5sTzVAxK/sqfydsqEYYkb6O7hNNcs/w1CBm+YzQWcc8m6Hl235qCZWalaIFqHH+xyaQd03O5GQWVgfGXZ0i0ARbVdWCOGtrs1d0L2FEFafu1jcOMK3+aqh76LdbGbys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A6E4C4CEE9;
	Thu, 19 Dec 2024 20:13:04 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tOMu2-0000000AOLT-1T9g;
	Thu, 19 Dec 2024 15:13:46 -0500
Message-ID: <20241219201346.200737679@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 19 Dec 2024 15:12:08 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 10/14] tracing: Switch trace_events_filter.c code over to use guard()
References: <20241219201158.193821672@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

There are a couple functions in trace_events_filter.c that have "goto out"
or equivalent on error in order to release locks that were taken. This can
be error prone or just simply make the code more complex.

Switch every location that ends with unlocking a mutex on error over to
using the guard(mutex)() infrastructure to let the compiler worry about
releasing locks. This makes the code easier to read and understand.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_filter.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 78051de581e7..0993dfc1c5c1 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -2405,13 +2405,11 @@ int apply_subsystem_event_filter(struct trace_subsystem_dir *dir,
 	struct event_filter *filter = NULL;
 	int err = 0;
 
-	mutex_lock(&event_mutex);
+	guard(mutex)(&event_mutex);
 
 	/* Make sure the system still has events */
-	if (!dir->nr_events) {
-		err = -ENODEV;
-		goto out_unlock;
-	}
+	if (!dir->nr_events)
+		return -ENODEV;
 
 	if (!strcmp(strstrip(filter_string), "0")) {
 		filter_free_subsystem_preds(dir, tr);
@@ -2422,7 +2420,7 @@ int apply_subsystem_event_filter(struct trace_subsystem_dir *dir,
 		tracepoint_synchronize_unregister();
 		filter_free_subsystem_filters(dir, tr);
 		__free_filter(filter);
-		goto out_unlock;
+		return 0;
 	}
 
 	err = create_system_filter(dir, filter_string, &filter);
@@ -2434,8 +2432,6 @@ int apply_subsystem_event_filter(struct trace_subsystem_dir *dir,
 		__free_filter(system->filter);
 		system->filter = filter;
 	}
-out_unlock:
-	mutex_unlock(&event_mutex);
 
 	return err;
 }
@@ -2612,17 +2608,15 @@ int ftrace_profile_set_filter(struct perf_event *event, int event_id,
 	struct event_filter *filter = NULL;
 	struct trace_event_call *call;
 
-	mutex_lock(&event_mutex);
+	guard(mutex)(&event_mutex);
 
 	call = event->tp_event;
 
-	err = -EINVAL;
 	if (!call)
-		goto out_unlock;
+		return -EINVAL;
 
-	err = -EEXIST;
 	if (event->filter)
-		goto out_unlock;
+		return -EEXIST;
 
 	err = create_filter(NULL, call, filter_str, false, &filter);
 	if (err)
@@ -2637,9 +2631,6 @@ int ftrace_profile_set_filter(struct perf_event *event, int event_id,
 	if (err || ftrace_event_is_function(call))
 		__free_filter(filter);
 
-out_unlock:
-	mutex_unlock(&event_mutex);
-
 	return err;
 }
 
-- 
2.45.2


