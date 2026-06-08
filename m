Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA493BBFBF;
	Mon,  8 Jun 2026 14:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780928732; cv=none; b=SYe8muEDYEFDdlgteFWgDIr93uqU/4KJgd/7PXe7BagUb4zY4T5j7BJPmzLhxRfE5ISEhbssjboE0bmPfGDWqtxfDQnesnBl+Mnm1TO2tsAnHuK4saFJoxMytjwjjnFZlbfIVcUH9AIyUaTvDY46/N2LqYpZ5araKNVDR+tlPxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780928732; c=relaxed/simple;
	bh=OUIfpm4yjESU1AoCPcmkXCaC7HzyHnY3p+M2tI4H2Uw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=btygi2q5l/A9YdNoFvixVAIlgGXz6vUo1JjPH799gDt+7WSHzXFA0DMfhqbaNoPuopKkoc7iOUQ2HdCCak9SR89DM1sWDlQmABqyVvTzb2PXRTfZbl4cg22tv29jOyGOLNNMmcBg0QrT8u1mzloZpRPecbo9wNipYgdadlby9kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=POvJmeMY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="POvJmeMY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 484AC1F00893;
	Mon,  8 Jun 2026 14:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780928730;
	bh=LXebLbU2PlO++pXKjvrv4XdGUtGGv/sVqpWNGZI12mI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=POvJmeMYSx9UAj3HfJbX4UIIte/iPDJNRUJhZM9IzDYz/oDcVE6URGfU+d1nJrcKe
	 ZXtDMBhfgr2Y7DbV1TS+NXJRMTYhXvns+p+TigtDhfuTfA6hixbsfiFqkK8xHWTN8J
	 RrpUApPFVi+AwTTjRJBF/e8fS7NFcn7uXG8EJFaJ5Uj9S5qgznR04rqVYHTfWheqeS
	 amuKcmhirwSZEAT6UOuy1BzoAsEKsH4ZpjBblT+SsUb8p4rEd8VS4Sqb7ay377YwyH
	 36J5EBi2TK0KQ6+lcNeIoLyS+UxjLpi6C+Yg42J1nFzuQfIBOf990eWgzE1C2E7LsE
	 A7Ph4C33Sz46A==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [RFC PATCH 7/7] tracing/probes: Add a new testcase for BTF typecasts
Date: Mon,  8 Jun 2026 23:25:26 +0900
Message-ID: <178092872598.163648.6705606677777891702.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178092865666.163648.10457567771536160909.stgit@devnote2>
References: <178092865666.163648.10457567771536160909.stgit@devnote2>
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

With the introduction of container_of-style BTF typecasting and
per-CPU variable access support in trace probes, we need a way to
verify their functionality and prevent regressions.

Add a new ftrace kselftest and update the trace event sample module to
test and validate these features.

Specifically, update the trace-events-sample module to set up a periodic
timer whose callback accesses a per-CPU counter. Introduce a new sample
trace event, foo_timer_fn, to trace this callback and log the current
counter value.

Then, add a new test case, btf_probe_event.tc, which defines a dynamic
probe on the timer callback. The probe uses BTF typecasting to recover
the parent structure from the timer argument and +CPU() to fetch the
per-CPU counter. The test verifies the integrity of the implementation
by ensuring the values recorded by the dynamic probe match those from
the static tracepoint.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 samples/trace_events/trace-events-sample.c         |   38 ++++++++++++++-
 samples/trace_events/trace-events-sample.h         |   34 ++++++++++++-
 .../ftrace/test.d/dynevent/btf_probe_event.tc      |   52 ++++++++++++++++++++
 3 files changed, 120 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/btf_probe_event.tc

diff --git a/samples/trace_events/trace-events-sample.c b/samples/trace_events/trace-events-sample.c
index ecc7db237f2e..770315812218 100644
--- a/samples/trace_events/trace-events-sample.c
+++ b/samples/trace_events/trace-events-sample.c
@@ -94,6 +94,20 @@ static int simple_thread_fn(void *arg)
 static DEFINE_MUTEX(thread_mutex);
 static int simple_thread_cnt;
 
+static struct foo_timer_data *foo_timer_data;
+
+static void sample_timer_cb(struct timer_list *t)
+{
+	struct foo_timer_data *data = container_of(t, struct foo_timer_data, timer);
+
+	get_cpu();
+	trace_foo_timer_fn(data);
+	(*this_cpu_ptr(data->counter))++;
+	put_cpu();
+
+	mod_timer(t, jiffies + HZ);
+}
+
 int foo_bar_reg(void)
 {
 	mutex_lock(&thread_mutex);
@@ -128,9 +142,27 @@ void foo_bar_unreg(void)
 
 static int __init trace_event_init(void)
 {
+	foo_timer_data = kzalloc_obj(*foo_timer_data, GFP_KERNEL);
+	if (!foo_timer_data)
+		return -ENOMEM;
+
+	foo_timer_data->name = "sample_timer_counter";
+	foo_timer_data->counter = alloc_percpu(int);
+	if (!foo_timer_data->counter) {
+		kfree(foo_timer_data);
+		return -ENOMEM;
+	}
+
+	timer_setup(&foo_timer_data->timer, sample_timer_cb, 0);
+	mod_timer(&foo_timer_data->timer, jiffies + HZ);
+
 	simple_tsk = kthread_run(simple_thread, NULL, "event-sample");
-	if (IS_ERR(simple_tsk))
+	if (IS_ERR(simple_tsk)) {
+		timer_delete_sync(&foo_timer_data->timer);
+		free_percpu(foo_timer_data->counter);
+		kfree(foo_timer_data);
 		return -1;
+	}
 
 	return 0;
 }
@@ -143,6 +175,10 @@ static void __exit trace_event_exit(void)
 		kthread_stop(simple_tsk_fn);
 	simple_tsk_fn = NULL;
 	mutex_unlock(&thread_mutex);
+
+	timer_delete_sync(&foo_timer_data->timer);
+	free_percpu(foo_timer_data->counter);
+	kfree(foo_timer_data);
 }
 
 module_init(trace_event_init);
diff --git a/samples/trace_events/trace-events-sample.h b/samples/trace_events/trace-events-sample.h
index 1a05fc153353..816848a456a2 100644
--- a/samples/trace_events/trace-events-sample.h
+++ b/samples/trace_events/trace-events-sample.h
@@ -247,12 +247,14 @@
  */
 
 /*
- * It is OK to have helper functions in the file, but they need to be protected
- * from being defined more than once. Remember, this file gets included more
- * than once.
+ * It is OK to have helper functions and data structures in the file, but they
+ * need to be protected from being defined more than once. Remember, this file
+ * gets included more than once.
  */
 #ifndef __TRACE_EVENT_SAMPLE_HELPER_FUNCTIONS
 #define __TRACE_EVENT_SAMPLE_HELPER_FUNCTIONS
+#include <linux/timer.h>
+
 static inline int __length_of(const int *list)
 {
 	int i;
@@ -270,6 +272,13 @@ enum {
 	TRACE_SAMPLE_BAR = 4,
 	TRACE_SAMPLE_ZOO = 8,
 };
+
+struct foo_timer_data {
+	const char		*name;
+	struct timer_list	timer;
+	int __percpu		*counter;
+};
+
 #endif
 
 /*
@@ -595,6 +604,25 @@ TRACE_EVENT(foo_rel_loc,
 		  __get_rel_bitmask(bitmask),
 		  __get_rel_cpumask(cpumask))
 );
+
+TRACE_EVENT(foo_timer_fn,
+
+	TP_PROTO(struct foo_timer_data *data),
+
+	TP_ARGS(data),
+
+	TP_STRUCT__entry(
+		__string(	name,			data->name	)
+		__field(	int,			count		)
+	),
+
+	TP_fast_assign(
+		__assign_str(name);
+		__entry->count	= *this_cpu_ptr(data->counter);
+	),
+
+	TP_printk("name=%s count=%d", __get_str(name), __entry->count)
+);
 #endif
 
 /***** NOTICE! The #if protection ends here. *****/
diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/btf_probe_event.tc b/tools/testing/selftests/ftrace/test.d/dynevent/btf_probe_event.tc
new file mode 100644
index 000000000000..f1980650dbe2
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/btf_probe_event.tc
@@ -0,0 +1,52 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: BTF event with typecast and percpu access
+# requires: dynamic_events " +CPU(<fetcharg>)":README "[(structname[,field])]<argname>[->field[->field|.field...]]":README
+
+# Check if the sample module is loaded
+if ! lsmod | grep -q trace_events_sample; then
+  modprobe trace-events-sample || exit_unsupported
+fi
+
+echo 0 > events/enable
+echo > dynamic_events
+
+# The sample_timer_cb(struct timer_list *t) is called.
+# We want to check (STRUCT,FIELD)VAR typecast and +PCPU() dereference.
+# (foo_timer_data,timer)t converts t to struct foo_timer_data * using container_of.
+# data->counter is a per-cpu pointer to int.
+# +PCPU(data->counter) should give the per-cpu address of the counter.
+# *+PCPU(data->counter) should give the value of the counter.
+
+echo 'f:mysample/myevent sample_timer_cb name=(foo_timer_data,timer)t->name:string count=+CPU((foo_timer_data,timer)t->counter)' >> dynamic_events
+
+echo 1 > events/mysample/myevent/enable
+echo 1 > events/sample-trace/foo_timer_fn/enable
+
+sleep 2
+
+echo 0 > events/mysample/myevent/enable
+echo 0 > events/sample-trace/foo_timer_fn/enable
+
+# Compare the values.
+MATCH=0
+while read line; do
+  if echo $line | grep -q "foo_timer_fn:"; then
+    NAME=`echo $line | sed 's/.*name=\([^ ]*\) .*/\1/'`
+    COUNT=`echo $line | sed 's/.*count=\([^ ]*\).*/\1/'`
+    if grep -q "myevent:.*name=\"${NAME}\" count=$COUNT" trace; then
+       MATCH=$((MATCH+1))
+    fi
+  fi
+done < trace
+
+if [ $MATCH -eq 0 ]; then
+  echo "No matching events found"
+  exit_fail
+fi
+
+# Clean up
+echo 0 > events/mysample/myevent/enable
+echo 0 > events/sample-trace/foo_timer_fn/enable
+echo > dynamic_events
+clear_trace

