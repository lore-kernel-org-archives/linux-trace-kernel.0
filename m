Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10F02DF6E3;
	Tue, 25 Nov 2025 21:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764106788; cv=none; b=Irjno0ppioXpQfWWWjFghDzdlEYV5fDJD9mC95mui263sUliz/fEoPzYBj8UQ5XHE/2ue0Bl8xwWqKwMIXb3r9F1ll09z2tHP8yM2Bd5E7cVrsj1URbBO6SsO3YgyFmr+2BGRh4s6GKlZTIE+Q4dDnZcinrdhGTFEVRZ1QngXQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764106788; c=relaxed/simple;
	bh=+SI/WIpvJonjM4T+po4ooc5wwIDV9ayQnk7qM0Lhgug=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=kNEi7nxtvAqYWxwTdhi6ktVWNqYCn4XyIOHMGqHpxcmrO4As6uhnL94mpS0xuJHB5F6LIvilJSkfS8s6aS3aAfMp2wRQ3znNsecarzQ97M1pzUFj+6ESzvplWJmQ4t7lQkWpe/UVOSqKo1PiftVx3TPvEoimoRRK1fuGLTRqaAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VshoEn7t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VshoEn7t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A27ABC19423;
	Tue, 25 Nov 2025 21:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764106787;
	bh=+SI/WIpvJonjM4T+po4ooc5wwIDV9ayQnk7qM0Lhgug=;
	h=Date:From:To:Cc:Subject:References:From;
	b=VshoEn7tEbORXhs2WyRX2y2lIFw3FJvxy4G/hIF+oeFMgql2Z3SkBAC1wFH30sOgK
	 v6AmRrbUQhoE0Ko/SMQTvzosRZ1xU/Qdsgjs03PRDXSOHXqiOM5mx64RN78UR27ZMJ
	 ecHnicNOk8fewoGPZi/I+tqRJsLTP+1vpfDQvCGMzAfhYbKBu1E3Ohbias3GdDK/vD
	 rf0x49RVepQ7BOiFLYumuZdYCSmuylZVHUtZBKWMuLbqr4D9HxUH2w0cKqZkXwVVnI
	 4gXDgpJKh9WtUXSMHW37cdp5qys2H3UpuONLL4yFjyHBXkiXxgXPHystiWCu/quT+p
	 fmIWOTd9z+g5w==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vO0m0-00000005rOP-1H0F;
	Tue, 25 Nov 2025 16:40:32 -0500
Message-ID: <20251125214032.151674992@kernel.org>
User-Agent: quilt/0.68
Date: Tue, 25 Nov 2025 16:40:06 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH v2 2/3] tracing: Add bulk garbage collection of freeing event_trigger_data
References: <20251125214004.396482401@kernel.org>
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

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://patch.msgid.link/20251120205710.151041470@kernel.org

- Moved include of llist.h to trace.h as it is used there (Masami Hiramatsu)

 kernel/trace/trace.h                |  2 ++
 kernel/trace/trace_events_trigger.c | 55 +++++++++++++++++++++++++++--
 2 files changed, 54 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 5863800b1ab3..911fc75dc6c4 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -22,6 +22,7 @@
 #include <linux/ctype.h>
 #include <linux/once_lite.h>
 #include <linux/ftrace_regs.h>
+#include <linux/llist.h>
 
 #include "pid_list.h"
 
@@ -1808,6 +1809,7 @@ struct event_trigger_data {
 	char				*name;
 	struct list_head		named_list;
 	struct event_trigger_data	*named_data;
+	struct llist_node		llist;
 };
 
 /* Avoid typos */
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index e5dcfcbb2cd5..3b97c242b795 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/security.h>
+#include <linux/kthread.h>
 #include <linux/module.h>
 #include <linux/ctype.h>
 #include <linux/mutex.h>
@@ -17,15 +18,63 @@
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


