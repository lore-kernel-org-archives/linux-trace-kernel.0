Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A7220B807;
	Tue, 18 Mar 2025 18:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742321306; cv=none; b=M2+Kc8VYuqvR+RkqJWnhO0D0Rx5C65ktxAILfcMzyCw9YedekblS0NiLJ1iFrIPgCESwFav5Q16HSUOH59a8R0sBrSBdSn2adcb4VexvAig1KXt2PUfhePT/u6TCMUl7ZDYa9rurVIl24ksnut1mdVL8h3pS2pzNr83b09KGPRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742321306; c=relaxed/simple;
	bh=V+vhLflQe8SoONzGndBpNmZuBsHX7Q94126ykNZwbL8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k6OUmwDarWKGPX17nHyU8OBMo+ilBJM/CEB2Z+qdCPWyHi9OJolLocIQkd0nvTD8BSJbwAfu3EEZCx+YmvdIubehUq0xcpwi17GmU39ZqYnyyOk/RJnHj/U6Xk5tRsJb7aNQyjE6wcL6Yj6gR3YG/2oZ9wpWRPhFKRullNzsQoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 28E1F13D5;
	Tue, 18 Mar 2025 11:08:31 -0700 (PDT)
Received: from e132430.arm.com (unknown [10.57.85.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 14F6E3F694;
	Tue, 18 Mar 2025 11:08:20 -0700 (PDT)
From: Douglas RAILLARD <douglas.raillard@arm.com>
To: rostedt@goodmis.org
Cc: douglas.raillard@arm.com,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 1/3] tracing: Expose functions to trace a synth event
Date: Tue, 18 Mar 2025 18:08:10 +0000
Message-ID: <20250318180814.226644-1-douglas.raillard@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Douglas Raillard <douglas.raillard@arm.com>

The current API for synth event only allow tracing by getting a "struct
trace_event_file *", which is associated with a specific ftrace instance
that has to be looked up ahead of time. In order to be able to emit such
synth event in all instances where the event has been enabled by a user,
another function is required, using a "struct synth_event *" that then
uses the underlying tracepoint system that the tracefs interface
manipulates.

Such function already exists for the histogram feature, so simply move
it to the common trace_events_synth.c code.

Signed-off-by: Douglas Raillard <douglas.raillard@arm.com>
---
 include/linux/trace_events.h      |  7 +++++++
 kernel/trace/trace_events_hist.c  | 27 ---------------------------
 kernel/trace/trace_events_synth.c | 29 +++++++++++++++++++++++++++++
 kernel/trace/trace_synth.h        |  2 --
 4 files changed, 36 insertions(+), 29 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 5caea596fef0..cbe389d0e144 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -517,6 +517,13 @@ struct dynevent_cmd {
 
 extern int dynevent_create(struct dynevent_cmd *cmd);
 
+struct synth_event;
+
+extern struct synth_event *find_synth_event(const char *name);
+
+extern void trace_synth(struct synth_event *event, u64 *var_ref_vals,
+			       unsigned int *var_ref_idx);
+
 extern int synth_event_delete(const char *name);
 
 extern void synth_event_cmd_init(struct dynevent_cmd *cmd,
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 53dc6719181e..a2bc7a972763 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -814,33 +814,6 @@ static void hist_err_clear(void)
 	last_cmd_loc[0] = '\0';
 }
 
-typedef void (*synth_probe_func_t) (void *__data, u64 *var_ref_vals,
-				    unsigned int *var_ref_idx);
-
-static inline void trace_synth(struct synth_event *event, u64 *var_ref_vals,
-			       unsigned int *var_ref_idx)
-{
-	struct tracepoint *tp = event->tp;
-
-	if (unlikely(static_key_enabled(&tp->key))) {
-		struct tracepoint_func *probe_func_ptr;
-		synth_probe_func_t probe_func;
-		void *__data;
-
-		if (!(cpu_online(raw_smp_processor_id())))
-			return;
-
-		probe_func_ptr = rcu_dereference_sched((tp)->funcs);
-		if (probe_func_ptr) {
-			do {
-				probe_func = probe_func_ptr->func;
-				__data = probe_func_ptr->data;
-				probe_func(__data, var_ref_vals, var_ref_idx);
-			} while ((++probe_func_ptr)->func);
-		}
-	}
-}
-
 static void action_trace(struct hist_trigger_data *hist_data,
 			 struct tracing_map_elt *elt,
 			 struct trace_buffer *buffer, void *rec,
diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index e3f7d09e5512..9f0817eec3c2 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -845,6 +845,35 @@ struct synth_event *find_synth_event(const char *name)
 
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(find_synth_event);
+
+typedef void (*synth_probe_func_t) (void *__data, u64 *var_ref_vals,
+				    unsigned int *var_ref_idx);
+
+void trace_synth(struct synth_event *event, u64 *var_ref_vals,
+			       unsigned int *var_ref_idx)
+{
+	struct tracepoint *tp = event->tp;
+
+	if (unlikely(static_key_enabled(&tp->key))) {
+		struct tracepoint_func *probe_func_ptr;
+		synth_probe_func_t probe_func;
+		void *__data;
+
+		if (!(cpu_online(raw_smp_processor_id())))
+			return;
+
+		probe_func_ptr = rcu_dereference_sched((tp)->funcs);
+		if (probe_func_ptr) {
+			do {
+				probe_func = probe_func_ptr->func;
+				__data = probe_func_ptr->data;
+				probe_func(__data, var_ref_vals, var_ref_idx);
+			} while ((++probe_func_ptr)->func);
+		}
+	}
+}
+EXPORT_SYMBOL_GPL(trace_synth);
 
 static struct trace_event_fields synth_event_fields_array[] = {
 	{ .type = TRACE_FUNCTION_TYPE,
diff --git a/kernel/trace/trace_synth.h b/kernel/trace/trace_synth.h
index 43f6fb6078db..425a0ec7c773 100644
--- a/kernel/trace/trace_synth.h
+++ b/kernel/trace/trace_synth.h
@@ -36,6 +36,4 @@ struct synth_event {
 	struct module				*mod;
 };
 
-extern struct synth_event *find_synth_event(const char *name);
-
 #endif /* __TRACE_SYNTH_H */
-- 
2.43.0

