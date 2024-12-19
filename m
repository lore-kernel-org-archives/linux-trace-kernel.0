Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9261C07EC;
	Thu, 19 Dec 2024 20:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734639184; cv=none; b=VKDrvsJwuJXjK6VtLcLkYtji5BP6RgLjQIUa5uV5rqVKVsjnGs3qnE0YNdXgXy5ECkprI5WCm5nEZ2uujHmvNIUJEimP7l7wkUnapvFHBXmRvX1BKTUsiQ3rw1caFh76bRVNrUn4bvEVQ9CRBBpzcWR4HrSUmwljf1acDwoIz4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734639184; c=relaxed/simple;
	bh=SxuPi4pF6bvQvYOwfbCABkPx3ULSFwz7pSiOJZzr5xs=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ruklHqtXTHdW9Kk+HJBUBc41JCmYs/9i74DQ4FoGUXpv0JJWAwUDtpb/eJS8U9JIapImgC6otWzP4vdiVimrT6IRdrXlL5iBSMLMXeB5AZKQQYloUuYNCuMFDBJG8gIRgOIhZr5/DHrLhCSLujn4YMZ52DoKiUxKFXSpVTvM3bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EF7CC4CEE5;
	Thu, 19 Dec 2024 20:13:04 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tOMu1-0000000AOJv-3WP5;
	Thu, 19 Dec 2024 15:13:45 -0500
Message-ID: <20241219201345.694601480@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 19 Dec 2024 15:12:05 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 07/14] tracing: Switch trace_events_hist.c code over to use guard()
References: <20241219201158.193821672@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

There are a couple functions in trace_events_hist.c that have "goto out" or
equivalent on error in order to release locks that were taken. This can be
error prone or just simply make the code more complex.

Switch every location that ends with unlocking a mutex on error over to
using the guard(mutex)() infrastructure to let the compiler worry about
releasing locks. This makes the code easier to read and understand.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 32 ++++++++++----------------------
 1 file changed, 10 insertions(+), 22 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 9c058aa8baf3..879b58892b9d 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -5594,25 +5594,19 @@ static int hist_show(struct seq_file *m, void *v)
 {
 	struct event_trigger_data *data;
 	struct trace_event_file *event_file;
-	int n = 0, ret = 0;
+	int n = 0;
 
-	mutex_lock(&event_mutex);
+	guard(mutex)(&event_mutex);
 
 	event_file = event_file_file(m->private);
-	if (unlikely(!event_file)) {
-		ret = -ENODEV;
-		goto out_unlock;
-	}
+	if (unlikely(!event_file))
+		return -ENODEV;
 
 	list_for_each_entry(data, &event_file->triggers, list) {
 		if (data->cmd_ops->trigger_type == ETT_EVENT_HIST)
 			hist_trigger_show(m, data, n++);
 	}
-
- out_unlock:
-	mutex_unlock(&event_mutex);
-
-	return ret;
+	return 0;
 }
 
 static int event_hist_open(struct inode *inode, struct file *file)
@@ -5873,25 +5867,19 @@ static int hist_debug_show(struct seq_file *m, void *v)
 {
 	struct event_trigger_data *data;
 	struct trace_event_file *event_file;
-	int n = 0, ret = 0;
+	int n = 0;
 
-	mutex_lock(&event_mutex);
+	guard(mutex)(&event_mutex);
 
 	event_file = event_file_file(m->private);
-	if (unlikely(!event_file)) {
-		ret = -ENODEV;
-		goto out_unlock;
-	}
+	if (unlikely(!event_file))
+		return -ENODEV;
 
 	list_for_each_entry(data, &event_file->triggers, list) {
 		if (data->cmd_ops->trigger_type == ETT_EVENT_HIST)
 			hist_trigger_debug_show(m, data, n++);
 	}
-
- out_unlock:
-	mutex_unlock(&event_mutex);
-
-	return ret;
+	return 0;
 }
 
 static int event_hist_debug_open(struct inode *inode, struct file *file)
-- 
2.45.2


