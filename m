Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1485019C556;
	Sat, 10 May 2025 03:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746848687; cv=none; b=NntXdyuu2JlHzRp1B7kqT+PANW3yoFxTs7CdFQxYxNRu8dzSicRJ9QVGf47UmkuT3XzJDXZVB/dZMg7A6bRF77bfz/arGf6OSRe+FY/EBII9BVVaaVeqBTDEzimEpJzofs9BPsW8HvcjlVmzf8DhGC3DLtXQxQQTTquff/Sreyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746848687; c=relaxed/simple;
	bh=lJZMKARAdrlkZTQd04Ofxb+YfDhSi6CN4YD16dHYFsE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EISq90KH2XtVuB0L9J9KgGsrVvAnapfyr0WhdSttlcQHm8XdO4wAZZSp1msrAYr0Yq6vIIoJIH3uvw5/UPtzHM1o1H700qdvJJ60x+kw0DiBh23TOjpA2C/M7zdm4FIPvtHB7UFQ+fzqzexRKhNdf/ji/bro9ewoUddb8VzXsXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0B7rA63; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0B7rA63"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB9E2C4CEE2;
	Sat, 10 May 2025 03:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746848685;
	bh=lJZMKARAdrlkZTQd04Ofxb+YfDhSi6CN4YD16dHYFsE=;
	h=From:To:Cc:Subject:Date:From;
	b=Y0B7rA632mHKyXt7Vt4nCU2+YBEpSzFc4SWaYnxjjFWcb21ZS9ynLWOIueEx6I7z5
	 y+pfKiaRe8U1QJXfjXAfmgG80HWxEV+0rMG9I+nWQ9EWCjVLPeu9En2L5KfRqw/qHa
	 t7PNLxXqQcN6qbMr17mX9AnXziuNHNBjGbrHzhYfsrTaBoopFWcnreHaIC/DEG3pRT
	 byh7psw4HItZQMPQp6C16nEXnxEXaBZ9qjaC66032FPm74JTvONHdgQr3bj0WIgAaY
	 WmoceLpSrqNXf2dO5dJLTyhfPy456DbJOCHcHGftZsTaJHsr/4aET53UQlgWKQ0xl5
	 zJj2P16U2pFeQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Paul Cacheux <paulcacheux@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing: probes: Fix a possible race in trace_probe_log APIs
Date: Sat, 10 May 2025 12:44:41 +0900
Message-ID: <174684868120.551552.3068655787654268804.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Since the shared trace_probe_log variable can be accessed and
modified via probe event create operation of kprobe_events,
uprobe_events, and dynamic_events, it should be protected.
In the dynamic_events, all operations are serialized by
`dyn_event_ops_mutex`. But kprobe_events and uprobe_events
interfaces are not serialized.

To solve this issue, introduces dyn_event_create(), which runs
create() operation under the mutex, for kprobe_events and
uprobe_events. This also uses lockdep to check the mutex is
held when using trace_probe_log* APIs.

Reported-by: Paul Cacheux <paulcacheux@gmail.com>
Closes: https://lore.kernel.org/all/20250510074456.805a16872b591e2971a4d221@kernel.org/
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_dynevent.c |   16 +++++++++++++++-
 kernel/trace/trace_dynevent.h |    1 +
 kernel/trace/trace_kprobe.c   |    2 +-
 kernel/trace/trace_probe.c    |    9 +++++++++
 kernel/trace/trace_uprobe.c   |    2 +-
 5 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
index a322e4f249a5..5d64a18cacac 100644
--- a/kernel/trace/trace_dynevent.c
+++ b/kernel/trace/trace_dynevent.c
@@ -16,7 +16,7 @@
 #include "trace_output.h"	/* for trace_event_sem */
 #include "trace_dynevent.h"
 
-static DEFINE_MUTEX(dyn_event_ops_mutex);
+DEFINE_MUTEX(dyn_event_ops_mutex);
 static LIST_HEAD(dyn_event_ops_list);
 
 bool trace_event_dyn_try_get_ref(struct trace_event_call *dyn_call)
@@ -116,6 +116,20 @@ int dyn_event_release(const char *raw_command, struct dyn_event_operations *type
 	return ret;
 }
 
+/*
+ * Locked version of event creation. The event creation must be protected by
+ * dyn_event_ops_mutex because of protecting trace_probe_log.
+ */
+int dyn_event_create(const char *raw_command, struct dyn_event_operations *type)
+{
+	int ret;
+
+	mutex_lock(&dyn_event_ops_mutex);
+	ret = type->create(raw_command);
+	mutex_unlock(&dyn_event_ops_mutex);
+	return ret;
+}
+
 static int create_dyn_event(const char *raw_command)
 {
 	struct dyn_event_operations *ops;
diff --git a/kernel/trace/trace_dynevent.h b/kernel/trace/trace_dynevent.h
index 936477a111d3..beee3f8d7544 100644
--- a/kernel/trace/trace_dynevent.h
+++ b/kernel/trace/trace_dynevent.h
@@ -100,6 +100,7 @@ void *dyn_event_seq_next(struct seq_file *m, void *v, loff_t *pos);
 void dyn_event_seq_stop(struct seq_file *m, void *v);
 int dyn_events_release_all(struct dyn_event_operations *type);
 int dyn_event_release(const char *raw_command, struct dyn_event_operations *type);
+int dyn_event_create(const char *raw_command, struct dyn_event_operations *type);
 
 /*
  * for_each_dyn_event	-	iterate over the dyn_event list
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 2703b96d8990..3e5c47b6d7b2 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1089,7 +1089,7 @@ static int create_or_delete_trace_kprobe(const char *raw_command)
 	if (raw_command[0] == '-')
 		return dyn_event_release(raw_command, &trace_kprobe_ops);
 
-	ret = trace_kprobe_create(raw_command);
+	ret = dyn_event_create(raw_command, &trace_kprobe_ops);
 	return ret == -ECANCELED ? -EINVAL : ret;
 }
 
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 2eeecb6c95ee..424751cdf31f 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -154,9 +154,12 @@ static const struct fetch_type *find_fetch_type(const char *type, unsigned long
 }
 
 static struct trace_probe_log trace_probe_log;
+extern struct mutex dyn_event_ops_mutex;
 
 void trace_probe_log_init(const char *subsystem, int argc, const char **argv)
 {
+	lockdep_assert_held(&dyn_event_ops_mutex);
+
 	trace_probe_log.subsystem = subsystem;
 	trace_probe_log.argc = argc;
 	trace_probe_log.argv = argv;
@@ -165,11 +168,15 @@ void trace_probe_log_init(const char *subsystem, int argc, const char **argv)
 
 void trace_probe_log_clear(void)
 {
+	lockdep_assert_held(&dyn_event_ops_mutex);
+
 	memset(&trace_probe_log, 0, sizeof(trace_probe_log));
 }
 
 void trace_probe_log_set_index(int index)
 {
+	lockdep_assert_held(&dyn_event_ops_mutex);
+
 	trace_probe_log.index = index;
 }
 
@@ -178,6 +185,8 @@ void __trace_probe_log_err(int offset, int err_type)
 	char *command, *p;
 	int i, len = 0, pos = 0;
 
+	lockdep_assert_held(&dyn_event_ops_mutex);
+
 	if (!trace_probe_log.argv)
 		return;
 
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 3386439ec9f6..35cf76c75dd7 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -741,7 +741,7 @@ static int create_or_delete_trace_uprobe(const char *raw_command)
 	if (raw_command[0] == '-')
 		return dyn_event_release(raw_command, &trace_uprobe_ops);
 
-	ret = trace_uprobe_create(raw_command);
+	ret = dyn_event_create(raw_command, &trace_uprobe_ops);
 	return ret == -ECANCELED ? -EINVAL : ret;
 }
 

