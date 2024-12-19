Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A5D1B86DC;
	Thu, 19 Dec 2024 20:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734639183; cv=none; b=P6e5KILN7i11noCRQSrWy8neMtHfAJSuOF0y0THzwcAYF8CpNGbCMJDIKW7HDti6SQJHUFZU8So/IGKztnZftW9/i//+kz4EKIBF4JgBs9CjvD9SwFbgU+WIfopj5lFaZaWWlhxti0YM9C6UeMAXBNNyONh0pHwtd7mKVIk4h24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734639183; c=relaxed/simple;
	bh=14SYhqDLJEDxoYJMlw8Vl8cHyPtJkl/4Oi0vpbPbZIg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=q0OKm/mnhnZmAOlNyogbjQPv0dnnepiF849aRSOsH33bpIt3p8Aim0xZnsgpEefds1CYWTnen4+ILS9wmLxu7zUoVkbf1JnzPqbkbWRo9fC/bIZzrb328mFi9lIB35FxHnVqX6N7kXZ51P3PRf/PqwPUtSZAOmHCuQ6E+SpcwwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 986FBC4CED7;
	Thu, 19 Dec 2024 20:13:03 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tOMu1-0000000AOIS-1Ovf;
	Thu, 19 Dec 2024 15:13:45 -0500
Message-ID: <20241219201345.190820140@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 19 Dec 2024 15:12:02 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 04/14] tracing: Simplify event_enable_func() goto out_free logic
References: <20241219201158.193821672@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The event_enable_func() function allocates the data descriptor early in
the function just to assign its data->count value via:

  kstrtoul(number, 0, &data->count);

This makes the code more complex as there are several error paths before
the data descriptor is actually used. This means there needs to be a
goto out_free; to clean it up.

Use a local variable "count" to do the update and move the data allocation
just before it is used. This removes the "out_free" label as the data can
be freed on the failure path of where it is used.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index f4eff49faef6..43e9545b5cf3 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -3758,6 +3758,7 @@ event_enable_func(struct trace_array *tr, struct ftrace_hash *hash,
 	struct trace_event_file *file;
 	struct ftrace_probe_ops *ops;
 	struct event_probe_data *data;
+	unsigned long count = -1;
 	const char *system;
 	const char *event;
 	char *number;
@@ -3798,14 +3799,6 @@ event_enable_func(struct trace_array *tr, struct ftrace_hash *hash,
 
 	ret = -ENOMEM;
 
-	data = kzalloc(sizeof(*data), GFP_KERNEL);
-	if (!data)
-		goto out;
-
-	data->enable = enable;
-	data->count = -1;
-	data->file = file;
-
 	if (!param)
 		goto out_reg;
 
@@ -3813,28 +3806,36 @@ event_enable_func(struct trace_array *tr, struct ftrace_hash *hash,
 
 	ret = -EINVAL;
 	if (!strlen(number))
-		goto out_free;
+		goto out;
 
 	/*
 	 * We use the callback data field (which is a pointer)
 	 * as our counter.
 	 */
-	ret = kstrtoul(number, 0, &data->count);
+	ret = kstrtoul(number, 0, &count);
 	if (ret)
-		goto out_free;
+		goto out;
 
  out_reg:
 	/* Don't let event modules unload while probe registered */
 	ret = trace_event_try_get_ref(file->event_call);
 	if (!ret) {
 		ret = -EBUSY;
-		goto out_free;
+		goto out;
 	}
 
 	ret = __ftrace_event_enable_disable(file, 1, 1);
 	if (ret < 0)
 		goto out_put;
 
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		goto out_put;
+
+	data->enable = enable;
+	data->count = count;
+	data->file = file;
+
 	ret = register_ftrace_function_probe(glob, tr, ops, data);
 	/*
 	 * The above returns on success the # of functions enabled,
@@ -3853,11 +3854,10 @@ event_enable_func(struct trace_array *tr, struct ftrace_hash *hash,
 	return ret;
 
  out_disable:
+	kfree(data);
 	__ftrace_event_enable_disable(file, 0, 1);
  out_put:
 	trace_event_put_ref(file->event_call);
- out_free:
-	kfree(data);
 	goto out;
 }
 
-- 
2.45.2


