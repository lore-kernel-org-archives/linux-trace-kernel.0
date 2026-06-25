Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A21A288BA;
	Thu, 25 Jun 2026 01:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782350842; cv=none; b=U8Z88aLaEBs911QwxVrZfwn/PGXOFvqQDSiLoj6b1KzWAR7LVc6gi/8yrhqeXeYaX8FN/u/BjedjSGYcO6b91GGta4E1vAk3FXgsolNofa3VtViIF94wu+pTvfbhsER+JPFyQoLyqT/ZwLMTabn8YbUFG+3qlEJS20eSTMmIjRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782350842; c=relaxed/simple;
	bh=LpUUCDpoIwkkOFjRNcBYvLv1rOvIr0Y1zQ81QXZeXdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n2H41OxbKZRd+GFOHBpZIaLFTgVc6T+ctsZmvWZgqpy4CYp+hiRBWS1VW1ZXuKHjgbN9cY2sVCxaOydfg/QPLV1N3E+TP6YMV0eYhZ0uBla32zel/sO5Ig8sSA9vIcu96PpIDBs6N+S6UaD3b95+4SfgJViOrL5MbYA0qL+jg3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWciSQbP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWciSQbP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E79241F000E9;
	Thu, 25 Jun 2026 01:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782350841;
	bh=mtng3axioRLCWyuOlv6YOv0APH9Y/77gn1Kwcj2kCzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZWciSQbPzV07KOaFqpJ0nVxMTF9Yi53E9iwkRXMJOFdxKtTd9/DkzQdidp4z3M1+f
	 FrZ8g7mo/r/s8RGT2YssiuXJ3IT6hXjif1hpolCZm9a/bYD4OZnTQbc/83S5P9j5Zr
	 rtQOFnOSfP18NZpV5k2ywc4L+vN0joaCW4nWCyWXxVeOobxt9loLQw8x16cKZnrmn3
	 KQinwmu6ILmxMPdMfrGchzLR022gKm90+jKwHku2adC51Dg3MtsmLaIkovw0Qojvvt
	 /hV1FJBTwmQtJDCmCi1dKtp9ZmO1p+BvQ/O9K3ASByB3l72hktmzydO4onZRixgl7+
	 GfdZQKW+v6WOA==
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
Subject: [PATCH v9 9/9] tracing/probes: Add a new testcase for BTF typecasts
Date: Thu, 25 Jun 2026 10:27:16 +0900
Message-ID: <178235083660.766912.16473770007686715516.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178235074943.766912.25308838431649508.stgit@devnote2>
References: <178235074943.766912.25308838431649508.stgit@devnote2>
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
 Changes in v9:
  - Add a testcase for checking new syntax.
 Changes in v8:
  - Add more test cases.
 Changes in v6:
  - Update testcase according to changes.
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
 samples/trace_events/trace-events-sample.c         |   40 +++++++
 samples/trace_events/trace-events-sample.h         |   34 ++++++
 .../ftrace/test.d/dynevent/btf_probe_event.tc      |   51 ++++++++++
 .../test.d/dynevent/btf_typecast_accepted.tc       |  107 ++++++++++++++++++++
 .../test.d/dynevent/eprobes_syntax_errors.tc       |    3 +
 .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |   12 ++
 .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc   |   12 ++
 .../ftrace/test.d/kprobe/uprobe_syntax_errors.tc   |    5 +
 8 files changed, 259 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/btf_probe_event.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/btf_typecast_accepted.tc

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
diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/btf_typecast_accepted.tc b/tools/testing/selftests/ftrace/test.d/dynevent/btf_typecast_accepted.tc
new file mode 100644
index 000000000000..acf0b5a917d3
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/btf_typecast_accepted.tc
@@ -0,0 +1,107 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: BTF typecast and percpu access syntax validation
+# requires: dynamic_events "this_cpu_read(<fetcharg>)":README "[(structname[,field])]<argname>[->field[->field|.field...]]":README
+
+KPROBES=
+FPROBES=
+
+if grep -qF "p[:[<group>/][<event>]] <place> [<args>]" README ; then
+  KPROBES=yes
+fi
+if grep -qF "f[:[<group>/][<event>]] <func-name>[%return] [<args>]" README ; then
+  FPROBES=yes
+fi
+
+if [ -z "$KPROBES" -a -z "$FPROBES" ] ; then
+  exit_unsupported
+fi
+
+echo 0 > events/enable
+echo > dynamic_events
+
+# Load trace-events-sample module if available to have per-CPU counter structure defined
+if ! lsmod | grep -q trace_events_sample; then
+  modprobe trace-events-sample || true
+fi
+
+if [ "$FPROBES" ] ; then
+  # 1. Test basic typecast on fprobe
+  echo 'f:fpevent1 vfs_read name=(file)file->f_path.dentry->d_name.name:string' >> dynamic_events
+  # 2. Test parenthesized typecast target on fprobe
+  echo 'f:fpevent2 vfs_read name=(file)(file)->f_path.dentry->d_name.name:string' >> dynamic_events
+  # 3. Test nested typecasts on fprobe
+  echo 'f:fpevent3 vfs_read name=(dentry)((file)file->f_path.dentry)->d_name.name:string' >> dynamic_events
+  # 4. Test container_of-style typecast with field option on fprobe
+  echo 'f:fpevent4 vfs_read name=(file,f_path)file->f_mode' >> dynamic_events
+  # 5. Test typecast on return value on fprobe
+  echo 'f:fpevent5 vfs_read%return name=(file)$retval->f_path.dentry->d_name.name:string' >> dynamic_events
+  # 6. Test $current variable support on fprobe
+  echo 'f:fpevent6 vfs_read pid=$current->pid' >> dynamic_events
+  echo 'f:fpevent7 vfs_read pid=(task_struct)$current->pid' >> dynamic_events
+  echo 'f:fpevent8 vfs_read pid=(task_struct,group_leader)$current->pid' >> dynamic_events
+
+  # Test this_cpu_read and this_cpu_ptr on fprobe
+  if lsmod | grep -q trace_events_sample; then
+    echo 'f:fpevent9 sample_timer_cb name=(foo_timer_data,timer)t->name:string count=this_cpu_read((foo_timer_data,timer)t->counter)' >> dynamic_events
+    echo 'f:fpevent10 sample_timer_cb ptr=this_cpu_ptr((foo_timer_data,timer)t->counter)' >> dynamic_events
+  fi
+fi
+
+if [ "$KPROBES" ] ; then
+  # 7. Test basic typecast on kprobe
+  echo 'p:kpevent1 vfs_read name=(file)file->f_path.dentry->d_name.name:string' >> dynamic_events
+  # 8. Test parenthesized typecast target on kprobe
+  echo 'p:kpevent2 vfs_read name=(file)(file)->f_path.dentry->d_name.name:string' >> dynamic_events
+  # 9. Test nested typecasts on kprobe
+  echo 'p:kpevent3 vfs_read name=(dentry)((file)file->f_path.dentry)->d_name.name:string' >> dynamic_events
+  # 10. Test container_of-style typecast with field option on kprobe
+  echo 'p:kpevent4 vfs_read name=(file,f_path)file->f_mode' >> dynamic_events
+  # 11. Test typecast on return value on kretprobe
+  echo 'r:kpevent5 vfs_read name=(file)$retval->f_path.dentry->d_name.name:string' >> dynamic_events
+  # 12. Test $current variable support on kprobe
+  echo 'p:kpevent6 vfs_read pid=$current->pid' >> dynamic_events
+  echo 'p:kpevent7 vfs_read pid=(task_struct)$current->pid' >> dynamic_events
+  echo 'p:kpevent8 vfs_read pid=(task_struct,group_leader)$current->pid' >> dynamic_events
+
+  # Test this_cpu_read and this_cpu_ptr on kprobe
+  if lsmod | grep -q trace_events_sample; then
+    echo 'p:kpevent9 sample_timer_cb name=(foo_timer_data,timer)t->name:string count=this_cpu_read((foo_timer_data,timer)t->counter)' >> dynamic_events
+    echo 'p:kpevent10 sample_timer_cb ptr=this_cpu_ptr((foo_timer_data,timer)t->counter)' >> dynamic_events
+  fi
+fi
+
+# Verify the events exist in dynamic_events
+if [ "$FPROBES" ] ; then
+  grep -q "fpevent1 " dynamic_events
+  grep -q "fpevent2 " dynamic_events
+  grep -q "fpevent3 " dynamic_events
+  grep -q "fpevent4 " dynamic_events
+  grep -q "fpevent5 " dynamic_events
+  grep -q "fpevent6 " dynamic_events
+  grep -q "fpevent7 " dynamic_events
+  grep -q "fpevent8 " dynamic_events
+  if lsmod | grep -q trace_events_sample; then
+    grep -q "fpevent9 " dynamic_events
+    grep -q "fpevent10 " dynamic_events
+  fi
+fi
+
+if [ "$KPROBES" ] ; then
+  grep -q "kpevent1 " dynamic_events
+  grep -q "kpevent2 " dynamic_events
+  grep -q "kpevent3 " dynamic_events
+  grep -q "kpevent4 " dynamic_events
+  grep -q "kpevent5 " dynamic_events
+  grep -q "kpevent6 " dynamic_events
+  grep -q "kpevent7 " dynamic_events
+  grep -q "kpevent8 " dynamic_events
+  if lsmod | grep -q trace_events_sample; then
+    grep -q "kpevent9 " dynamic_events
+    grep -q "kpevent10 " dynamic_events
+  fi
+fi
+
+# Clean up
+echo > dynamic_events
+clear_trace
diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/eprobes_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/dynevent/eprobes_syntax_errors.tc
index 0e65e787e426..ae17eb344bf7 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/eprobes_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/eprobes_syntax_errors.tc
@@ -21,6 +21,9 @@ check_error 'e:foo/^bar.1 syscalls/sys_enter_openat'	# BAD_EVENT_NAME
 
 check_error 'e:foo/bar syscalls/sys_enter_openat arg=^$foo'	# BAD_ATTACH_ARG
 
+check_error 'e:foo/bar syscalls/sys_enter_openat arg=^COMM'	# NO_EVENT_FIELD
+check_error 'e:foo/bar syscalls/sys_enter_openat arg=^current'	# NO_EVENT_FIELD
+
 if grep -q '<attached-group>\.<attached-event>.*\[if <filter>\]' README; then
   check_error 'e:foo/bar syscalls/sys_enter_openat if ^'	# NO_EP_FILTER
 fi
diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
index fee479295e2f..e9d7e6919c7f 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
@@ -112,6 +112,18 @@ check_error 'f vfs_read%return $retval->^foo'	# NO_PTR_STRCT
 check_error 'f vfs_read file->^foo'		# NO_BTF_FIELD
 check_error 'f vfs_read file^-.foo'		# BAD_HYPHEN
 check_error 'f vfs_read ^file:string'		# BAD_TYPE4STR
+if grep -qF "[(structname" README ; then
+check_error 'f vfs_read arg1=(task_struct)file^'		# TYPECAST_REQ_FIELD
+check_error 'f vfs_read arg1=(a)((b)((c)(^(d)file->d)->c)->b)->a'	# TOO_MANY_NESTED
+check_error 'f vfs_read arg1=(task_struct,^in_execve)file->comm'	# TYPECAST_NOT_ALIGNED
+check_error 'f vfs_read arg1=(task_struct,^foo_bar)file->pid'	# NO_BTF_FIELD
+check_error 'f vfs_read arg1=(^task_struct1234)file->pid'	# NO_PTR_STRCT
+check_error 'f vfs_read arg1=(task_struct,se^->group_node)file->comm'	# TYPECAST_BAD_ARROW
+check_error 'f vfs_read arg1=(task_struct,^->pid)file->comm'	# NO_BTF_FIELD
+check_error 'f vfs_read arg1=(task_struct,^.pid)file->comm'	# NO_BTF_FIELD
+check_error 'f vfs_read arg1=(task_struct,^.)file->comm'	# NO_BTF_FIELD
+check_error 'f vfs_read arg1=(task_struct)^@symbol+10->comm'	# TYPECAST_SYM_OFFSET
+fi
 fi
 
 else
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
index 8f1c58f0c239..21ce8414459f 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
@@ -115,6 +115,18 @@ check_error 'p vfs_read+20 ^$arg*'		# NOFENTRY_ARGS
 check_error 'p vfs_read ^hoge'			# NO_BTFARG
 check_error 'p kfree ^$arg10'			# NO_BTFARG (exceed the number of parameters)
 check_error 'r kfree ^$retval'			# NO_RETVAL
+if grep -qF "[(structname" README ; then
+check_error 'p vfs_read arg1=(task_struct)file^'		# TYPECAST_REQ_FIELD
+check_error 'p vfs_read arg1=(a)((b)((c)(^(d)file->d)->c)->b)->a'	# TOO_MANY_NESTED
+check_error 'p vfs_read arg1=(task_struct,^in_execve)file->comm'	# TYPECAST_NOT_ALIGNED
+check_error 'p vfs_read arg1=(task_struct,^foo_bar)file->pid'	# NO_BTF_FIELD
+check_error 'p vfs_read arg1=(^task_struct1234)file->pid'		# NO_PTR_STRCT
+check_error 'p vfs_read arg1=(task_struct,se^->group_node)file->comm'	# TYPECAST_BAD_ARROW
+check_error 'p vfs_read arg1=(task_struct,^->pid)file->comm'	# NO_BTF_FIELD
+check_error 'p vfs_read arg1=(task_struct,^.pid)file->comm'	# NO_BTF_FIELD
+check_error 'p vfs_read arg1=(task_struct,^.)file->comm'	# NO_BTF_FIELD
+check_error 'p vfs_read arg1=(task_struct)^@symbol+10->comm'	# TYPECAST_SYM_OFFSET
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

