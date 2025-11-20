Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0041B368E15;
	Thu, 20 Nov 2025 20:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763672198; cv=none; b=j9XWZcrfIk5fgFzXY+jfqUwNxEp5QmzEH0ENs61tGl3axJ5qqdq54R+3kA8m/XNBWO5pE4Osndidoa4laktNO2B9hJa8iToGc8ldnZa2StJTwaYkmeOOUkDm6YKU2XqtNlwY10Pl7EsdkR3y6Vv0oI+Nn5ZJHjDxEsjN+nLyVGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763672198; c=relaxed/simple;
	bh=GVzzXYkl5wHRslHDTIcDpnGGeSvmX5YX+CNNDxLB77c=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=pZqMHESlnECcrCYLwjkdcriGq9rXkB6Mp62Ws7kdy8fei3ZSwsBYCV7ZGys7BkXaVO95yQkNvu4g7Xin2D5hBuv03KA970V04zWaF9dsfsBFvrGewDMf8CyR5F+TkwfQJh8dQFZrctBneg5xVNSYNEtf9Ouub8BWXkUkfyVlW3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ptgx4EUm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ptgx4EUm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95940C116C6;
	Thu, 20 Nov 2025 20:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763672197;
	bh=GVzzXYkl5wHRslHDTIcDpnGGeSvmX5YX+CNNDxLB77c=;
	h=Date:From:To:Cc:Subject:References:From;
	b=ptgx4EUmbl9s3QPEolP8Fu/2glAVCzhchz4L3avHetcPWzrYs+icLmCJEXJrSi4Y6
	 6PQTZ85PobejfpxfhDN4XjlaqXSuL/4zKYfbVvRccV5UXF1kkLy72LsZwoVYiQGRrC
	 Cm+8+JgufcNpmrTKQAQsxO+kyUg0qgMJo0Yu9L3O3OpLjR/nIwBFfkdlVx1I5fDmLe
	 QMd3SdjlHc6l8UiuIENJQO1wp/WItcMXfb6cdoM86x21/nGc9nzQYO+I/6unR1Ntxr
	 4bPfOM1txW8GjX0ZpDStWBSb/odFcs3Uk0ZZGIydKmM2CZtDyLrSMxrhr+FiXPh4IQ
	 XTq10TtFGBXkA==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vMBiI-00000003zBu-1Egz;
	Thu, 20 Nov 2025 15:57:10 -0500
Message-ID: <20251120205710.151041470@kernel.org>
User-Agent: quilt/0.68
Date: Thu, 20 Nov 2025 15:56:02 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH 2/3] tracing: Add bulk garbage collection of freeing event_trigger_data
References: <20251120205600.570673392@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The event trigger data requires a full tracepoint_synchronize_unregister()
call before freeing. That call can take 100s of milliseconds to complete.
In order to allow for bulk freeing of the trigger data, it can not call
the tracepoint_synchronize_unregister() for every individual trigger data
being free.

Create a kthread that gets created the first time a trigger data is freed,
and have it use the lockless llist to get the list of data to free, run
the tracepoint_synchronize_unregister() then free everything in the list.

By freeing hundreds of event_trigger_data elements together, it only
requires two runs of the synchronization function, and not hundreds of
runs. This speeds up the operation by orders of magnitude (milliseconds
instead of several seconds).

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.h                |  1 +
 kernel/trace/trace_events_trigger.c | 56 +++++++++++++++++++++++++++--
 2 files changed, 54 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 5863800b1ab3..fd5a6daa6c25 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1808,6 +1808,7 @@ struct event_trigger_data {
 	char				*name;
 	struct list_head		named_list;
 	struct event_trigger_data	*named_data;
+	struct llist_node		llist;
 };
 
 /* Avoid typos */
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index e5dcfcbb2cd5..16e3449f3cfe 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -6,26 +6,76 @@
  */
 
 #include <linux/security.h>
+#include <linux/kthread.h>
 #include <linux/module.h>
 #include <linux/ctype.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
 #include <linux/rculist.h>
+#include <linux/llist.h>
 
 #include "trace.h"
 
 static LIST_HEAD(trigger_commands);
 static DEFINE_MUTEX(trigger_cmd_mutex);
 
+static struct task_struct *trigger_kthread;
+static struct llist_head trigger_data_free_list;
+static DEFINE_MUTEX(trigger_data_kthread_mutex);
+
+/* Bulk garbage collection of event_trigger_data elements */
+static int trigger_kthread_fn(void *ignore)
+{
+	struct event_trigger_data *data, *tmp;
+	struct llist_node *llnodes;
+
+	/* Once this task starts, it lives forever */
+	for (;;) {
+		set_current_state(TASK_INTERRUPTIBLE);
+		if (llist_empty(&trigger_data_free_list))
+			schedule();
+
+		__set_current_state(TASK_RUNNING);
+
+		llnodes = llist_del_all(&trigger_data_free_list);
+
+		/* make sure current triggers exit before free */
+		tracepoint_synchronize_unregister();
+
+		llist_for_each_entry_safe(data, tmp, llnodes, llist)
+			kfree(data);
+	}
+
+	return 0;
+}
+
 void trigger_data_free(struct event_trigger_data *data)
 {
 	if (data->cmd_ops->set_filter)
 		data->cmd_ops->set_filter(NULL, data, NULL);
 
-	/* make sure current triggers exit before free */
-	tracepoint_synchronize_unregister();
+	if (unlikely(!trigger_kthread)) {
+		guard(mutex)(&trigger_data_kthread_mutex);
+		/* Check again after taking mutex */
+		if (!trigger_kthread) {
+			struct task_struct *kthread;
+
+			kthread = kthread_create(trigger_kthread_fn, NULL,
+						 "trigger_data_free");
+			if (!IS_ERR(kthread))
+				WRITE_ONCE(trigger_kthread, kthread);
+		}
+	}
+
+	if (!trigger_kthread) {
+		/* Do it the slow way */
+		tracepoint_synchronize_unregister();
+		kfree(data);
+		return;
+	}
 
-	kfree(data);
+	llist_add(&data->llist, &trigger_data_free_list);
+	wake_up_process(trigger_kthread);
 }
 
 static inline void data_ops_trigger(struct event_trigger_data *data,
-- 
2.51.0


