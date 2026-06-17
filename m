Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621EF282F25;
	Wed, 17 Jun 2026 01:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781658235; cv=none; b=Tk8jUH0bK62dgMSG2bN7c6hBLcoeVk9qImXM/urovLVehQhYyB+KJ9+ZZXYI4kHs9q8GTMHYZ/J5XfA+x7DLqEg8MdfbMJnYOicx5IwkY3IFydOwkBHWpnPDYjToSkeQc5+3FENEPDy6zvxAesraNKUZ8ySkYn+rSnqpvZOP+sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781658235; c=relaxed/simple;
	bh=pQfl3Q6VVzfNh7ktCNcwVvAPXPyk6mW2Bg1rXZdNEAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VUbftQiAIhR3lfdmEX4DEv17Cwhck6nwZkLNap3L0bf2D70TbxTITngsEhinto0WF/rODqzkqcDTWsoN8YMVMCAL6o7hVVkzTQ9HbuqOEojPADJVtdrkKg+KGB1uR+NomPtMqrXLp66XPk9hieuGnpuhVMFlxakyiuDcOkNsw3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZTmJeyJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZTmJeyJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F6D1F000E9;
	Wed, 17 Jun 2026 01:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781658234;
	bh=LLJg6d7dC/gvs51xJLvTitv8jujCadoEJi3+5sjiC4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IZTmJeyJ8Fd9qflAh5jszmgF2ZbOInJu8q1e8rSNfyYdkQdYc9NXOCEHvdUymv5AD
	 IMsfisAic/QqEWgWwhMsf3wSHEKw2iFoR8agMfUHXXwhgPe9tfqI0NdEXvWJnFM/fY
	 vh/Haf2m4TJpJ4P7w9UbLx/Lwb7OfQ5b1h9fsUv0VBfAukCQwijo7Frn4ta2HIOj6O
	 ke3lI3XGCz9jmV8B08ZO1tGmv4meq/mQutIGW0KCI/PrF/XjPGbpRSwQms2Y0xReUD
	 kL+vwCSXoi19FFNwMUZZ15+zwXR/rLVkvzD4vy5vGWK5E+ah4+DPgu8Ek1qaGEh635
	 uLBMxEoO+jXAw==
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
Subject: [PATCH v5 7/7] tracing/probes: Add a new testcase for BTF typecasts
Date: Wed, 17 Jun 2026 10:03:50 +0900
Message-ID: <178165822999.269421.3650241506657907944.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178165816303.269421.7302603996990753309.stgit@devnote2>
References: <178165816303.269421.7302603996990753309.stgit@devnote2>
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

Add a new ftrace kselftest and update the trace event sample module
to test and validate these features.

Specifically, update the trace-events-sample module to set up a
periodic timer whose callback accesses a per-CPU counter. Introduce
a new sample trace event, foo_timer_fn, to trace this callback
and log the current counter value.

Then, add a new test case, btf_probe_event.tc, which defines a
dynamic probe on the timer callback. The probe uses BTF typecasting
to recover the parent structure from the timer argument and
this_cpu_read() to fetch the per-CPU counter. The test verifies
the integrity of the implementation by ensuring the values
recorded by the dynamic probe match those from the static tracepoint.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v5:
  - Add more syntax test cases.
 Changes in v4:
  - Fix uprobe $current test.
 Changes in v3:
  - Add syntax test case.
  - Update testcase to use this_cpu_read()
 Changes in v2:
  - Use timer_shutdown_sync() instead of timer_delete_sync() for teardown.
---
 samples/trace_events/trace-events-sample.c         |   40 +++++++++++++++-
 samples/trace_events/trace-events-sample.h         |   34 ++++++++++++-
 .../ftrace/test.d/dynevent/btf_probe_event.tc      |   51 ++++++++++++++++++++
 .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |   11 ++++
 .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc   |   11 ++++
 .../ftrace/test.d/kprobe/uprobe_syntax_errors.tc   |    5 ++
 6 files changed, 147 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/btf_probe_event.tc

diff --git a/samples/trace_events/trace-events-sample.c b/samples/trace_events/trace-events-sample.c
index 0b7a6efdb247..ca5d98c360cb 100644
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
@@ -132,9 +146,27 @@ void foo_bar_unreg(void)
 
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
-		return -1;
+	if (IS_ERR(simple_tsk)) {
+		timer_shutdown_sync(&foo_timer_data->timer);
+		free_percpu(foo_timer_data->counter);
+		kfree(foo_timer_data);
+		return PTR_ERR(simple_tsk);
+	}
 
 	return 0;
 }
@@ -147,6 +179,10 @@ static void __exit trace_event_exit(void)
 		kthread_stop(simple_tsk_fn);
 	simple_tsk_fn = NULL;
 	mutex_unlock(&thread_mutex);
+
+	timer_shutdown_sync(&foo_timer_data->timer);
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
index 000000000000..96791e120b7d
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/btf_probe_event.tc
@@ -0,0 +1,51 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: BTF event with typecast and percpu access
+# requires: dynamic_events "this_cpu_read(<fetcharg>)":README "[(structname[,field])]<argname>[->field[->field|.field...]]":README
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
+# We want to check (STRUCT,FIELD)VAR typecast and this_cpu_read() access.
+# (foo_timer_data,timer)t converts t to struct foo_timer_data * using container_of.
+# data->counter is a per-cpu pointer to int.
+# this_cpu_read(data->counter) should give the value of the counter.
+
+echo 'f:mysample/myevent sample_timer_cb name=(foo_timer_data,timer)t->name:string count=this_cpu_read((foo_timer_data,timer)t->counter)' >> dynamic_events
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
diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
index fee479295e2f..0402d0271bfe 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
@@ -112,6 +112,17 @@ check_error 'f vfs_read%return $retval->^foo'	# NO_PTR_STRCT
 check_error 'f vfs_read file->^foo'		# NO_BTF_FIELD
 check_error 'f vfs_read file^-.foo'		# BAD_HYPHEN
 check_error 'f vfs_read ^file:string'		# BAD_TYPE4STR
+if grep -qF "[(structname" README ; then
+check_error 'f vfs_read arg1=(task_struct)file^'		# TYPECAST_REQ_FIELD
+check_error 'f vfs_read arg1=(f)((f)((f)((f)^((f)file->f)->f)->f)->f)->f'	# TOO_MANY_NESTED
+check_error 'f vfs_read arg1=(task_struct,^in_execve)file->comm'	# TYPECAST_NOT_ALIGNED
+check_error 'f vfs_read arg1=(task_struct,^foo_bar)file:u8'	# NO_BTF_FIELD
+check_error 'f vfs_read arg1=(^task_struct1234)file:u8'		# NO_PTR_STRCT
+check_error 'f vfs_read arg1=(task_struct,se^->group_node)file->comm'	# TYPECAST_BAD_ARROW
+check_error 'f vfs_read arg1=(task_struct,^->pid)file->comm'	# NO_BTF_FIELD
+check_error 'f vfs_read arg1=(task_struct,^.pid)file->comm'	# NO_BTF_FIELD
+check_error 'f vfs_read arg1=(task_struct,^.)file->comm'	# NO_BTF_FIELD
+fi
 fi
 
 else
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
index 8f1c58f0c239..742b342e4930 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
@@ -115,6 +115,17 @@ check_error 'p vfs_read+20 ^$arg*'		# NOFENTRY_ARGS
 check_error 'p vfs_read ^hoge'			# NO_BTFARG
 check_error 'p kfree ^$arg10'			# NO_BTFARG (exceed the number of parameters)
 check_error 'r kfree ^$retval'			# NO_RETVAL
+if grep -qF "[(structname" README ; then
+check_error 'p vfs_read arg1=(task_struct)file^'		# TYPECAST_REQ_FIELD
+check_error 'p vfs_read arg1=(f)((f)((f)((f)^((f)file->f)->f)->f)->f)->f'	# TOO_MANY_NESTED
+check_error 'p vfs_read arg1=(task_struct,^in_execve)file->comm'	# TYPECAST_NOT_ALIGNED
+check_error 'p vfs_read arg1=(task_struct,^foo_bar)file:u8'	# NO_BTF_FIELD
+check_error 'p vfs_read arg1=(^task_struct1234)file:u8'		# NO_PTR_STRCT
+check_error 'p vfs_read arg1=(task_struct,se^->group_node)file->comm'	# TYPECAST_BAD_ARROW
+check_error 'p vfs_read arg1=(task_struct,^->pid)file->comm'	# NO_BTF_FIELD
+check_error 'p vfs_read arg1=(task_struct,^.pid)file->comm'	# NO_BTF_FIELD
+check_error 'p vfs_read arg1=(task_struct,^.)file->comm'	# NO_BTF_FIELD
+fi
 else
 check_error 'p vfs_read ^$arg*'			# NOSUP_BTFARG
 fi
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/uprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/kprobe/uprobe_syntax_errors.tc
index c817158b99db..e12dc967ec76 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/uprobe_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/uprobe_syntax_errors.tc
@@ -28,4 +28,9 @@ if grep -q ".*symstr.*" README; then
 check_error 'p /bin/sh:10 $stack0:^symstr'	# BAD_TYPE
 fi
 
+# $current is not supported by uprobe
+if grep -q "\$current.*" README; then
+check_error 'p /bin/sh:10 ^$current:u8'	# BAD_VAR
+fi
+
 exit 0

