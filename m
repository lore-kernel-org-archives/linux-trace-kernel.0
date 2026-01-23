Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F58B3246F4;
	Fri, 23 Jan 2026 00:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769129889; cv=none; b=bxfqThKhUNSwQ0NViXDUmTeiTH2ieEAQZhNFvA7wx31iGleidVH1iXQJGpfUE9621/u5sWOW3NcFSqYHnHG4n+5kLR2Q4ol4Gvl4X8AzIMQLJWMlWlaouomEKcfgP1/q1Ag86/X6udzbHpuuhIbCaHN/vQLSLl+AaqszxUqQ1VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769129889; c=relaxed/simple;
	bh=qgL7FZ0DNWS9nbyiP9Nfnt7F4EOwvjKaKslGp4Bbajs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=JB0kdHPPB2AVfrvDx2rZc8jxq8E1/z7E8J8363ZoSUJQpaXQXzAhDmwTjEsZCroz23bzwXuZF+AtGHcsLEBjKOU7WfWmu/ULLauk4FyDgj3J8YI+aGkuCWeaptJqsDbu4tSehIXPGrU1arLDhOVx17AhywxTxM+KJewFTBtXWhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 2CF195F128;
	Fri, 23 Jan 2026 00:48:00 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id 8A0FB20028;
	Fri, 23 Jan 2026 00:47:58 +0000 (UTC)
Date: Thu, 22 Jan 2026 19:48:24 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH] tracing: Fix crash on synthetic stacktrace field usage
Message-ID: <20260122194824.6905a38e@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: mzkgd1o7abcwsozqss6ug58pra14umze
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 8A0FB20028
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19XjIryVSgTh+y87Ff+DJgOtQB9TsUSTwo=
X-HE-Tag: 1769129278-223430
X-HE-Meta: U2FsdGVkX1+RxbThYWzw5YE7Tdd+kOXyeVaBvgKC2Q0MsBDA5n3W3Pcz7J6IxwZOmRcmaAt+KgpbtKoDU+JPRBkRU13SgmS2MvoTHCfU0liZxWGAQWW0Pt21ghpMfk31nqS7ww/dJa1uaLdqU5NMKnB8tDpSTmpEz56cIQz5u5BFtMMicnWvBmX61K5+QxVOtEg0TLH/xMSnB9lFam6IZEomtA9Ua5oX9bTVKHenBAUl3ZfwFPOjaY4xxvUrCLg3wmpgS4xAKHR6SBR0gZkk8sutZZ0y0eztoX1v8oWWYuhmyQjsVliken3z6LuHkcMSKl0nj1TIXNt/bhgo3U1pGurP4NjdRsT9ctPJBmZgJrIjXO0j/1JLqElFzMv7fhoaHeaQeKhWUsb+cjFGtwpurg==

From: Steven Rostedt <rostedt@goodmis.org>

When creating a synthetic event based on an existing synthetic event that
had a stacktrace field and the new synthetic event used that field a
kernel crash occurred:

 ~# cd /sys/kernel/tracing
 ~# echo 's:stack unsigned long stack[];' > dynamic_events
 ~# echo 'hist:keys=prev_pid:s0=common_stacktrace if prev_state & 3' >> events/sched/sched_switch/trigger
 ~# echo 'hist:keys=next_pid:s1=$s0:onmatch(sched.sched_switch).trace(stack,$s1)' >> events/sched/sched_switch/trigger

The above creates a synthetic event that takes a stacktrace when a task
schedules out in a non-running state and passes that stacktrace to the
sched_switch event when that task schedules back in. It triggers the
"stack" synthetic event that has a stacktrace as its field (called "stack").

 ~# echo 's:syscall_stack s64 id; unsigned long stack[];' >> dynamic_events
 ~# echo 'hist:keys=common_pid:s2=stack' >> events/synthetic/stack/trigger
 ~# echo 'hist:keys=common_pid:s3=$s2,i0=id:onmatch(synthetic.stack).trace(syscall_stack,$i0,$s3)' >> events/raw_syscalls/sys_exit/trigger

The above makes another synthetic event called "syscall_stack" that
attaches the first synthetic event (stack) to the sys_exit trace event and
records the stacktrace from the stack event with the id of the system call
that is exiting.

When enabling this event (or using it in a historgram):

 ~# echo 1 > events/synthetic/syscall_stack/enable

Produces a kernel crash!

 BUG: unable to handle page fault for address: 0000000000400010
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 0 P4D 0
 Oops: Oops: 0000 [#1] SMP PTI
 CPU: 6 UID: 0 PID: 1257 Comm: bash Not tainted 6.16.3+deb14-amd64 #1 PREEMPT(lazy)  Debian 6.16.3-1
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
 RIP: 0010:trace_event_raw_event_synth+0x90/0x380
 Code: c5 00 00 00 00 85 d2 0f 84 e1 00 00 00 31 db eb 34 0f 1f 00 66 66 2e 0f 1f 84 00 00 00 00 00 66 66 2e 0f 1f 84 00 00 00 00 00 <49> 8b 04 24 48 83 c3 01 8d 0c c5 08 00 00 00 01 cd 41 3b 5d 40 0f
 RSP: 0018:ffffd2670388f958 EFLAGS: 00010202
 RAX: ffff8ba1065cc100 RBX: 0000000000000000 RCX: 0000000000000000
 RDX: 0000000000000001 RSI: fffff266ffda7b90 RDI: ffffd2670388f9b0
 RBP: 0000000000000010 R08: ffff8ba104e76000 R09: ffffd2670388fa50
 R10: ffff8ba102dd42e0 R11: ffffffff9a908970 R12: 0000000000400010
 R13: ffff8ba10a246400 R14: ffff8ba10a710220 R15: fffff266ffda7b90
 FS:  00007fa3bc63f740(0000) GS:ffff8ba2e0f48000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000400010 CR3: 0000000107f9e003 CR4: 0000000000172ef0
 Call Trace:
  <TASK>
  ? __tracing_map_insert+0x208/0x3a0
  action_trace+0x67/0x70
  event_hist_trigger+0x633/0x6d0
  event_triggers_call+0x82/0x130
  trace_event_buffer_commit+0x19d/0x250
  trace_event_raw_event_sys_exit+0x62/0xb0
  syscall_exit_work+0x9d/0x140
  do_syscall_64+0x20a/0x2f0
  ? trace_event_raw_event_sched_switch+0x12b/0x170
  ? save_fpregs_to_fpstate+0x3e/0x90
  ? _raw_spin_unlock+0xe/0x30
  ? finish_task_switch.isra.0+0x97/0x2c0
  ? __rseq_handle_notify_resume+0xad/0x4c0
  ? __schedule+0x4b8/0xd00
  ? restore_fpregs_from_fpstate+0x3c/0x90
  ? switch_fpu_return+0x5b/0xe0
  ? do_syscall_64+0x1ef/0x2f0
  ? do_fault+0x2e9/0x540
  ? __handle_mm_fault+0x7d1/0xf70
  ? count_memcg_events+0x167/0x1d0
  ? handle_mm_fault+0x1d7/0x2e0
  ? do_user_addr_fault+0x2c3/0x7f0
  entry_SYSCALL_64_after_hwframe+0x76/0x7e

The reason is that the stacktrace field is not labeled as such, and is
treated as a normal field and not as a dynamic event that it is.

In trace_event_raw_event_synth() the event is field is still treated as a
dynamic array, but the retrieval of the data is considered a normal field,
and the reference is just the meta data:

// Meta data is retrieved instead of a dynamic array
  str_val = (char *)(long)var_ref_vals[val_idx];

// Then when it tries to process it:
  len = *((unsigned long *)str_val) + 1;

It triggers a kernel page fault.

To fix this, first when defining the fields of the first synthetic event,
set the filter type to FILTER_STACKTRACE. This is used later by the second
synthetic event to know that this field is a stacktrace. When creating
the field of the new synthetic event, have it use this FILTER_STACKTRACE
to know to create a stacktrace field to copy the stacktrace into.

Cc: stable@vger.kernel.org
Fixes: 00cf3d672a9d ("tracing: Allow synthetic events to pass around stacktraces")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c  | 9 +++++++++
 kernel/trace/trace_events_synth.c | 8 +++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 5e6e70540eef..c97bb2fda5c0 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -2057,6 +2057,15 @@ static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
 			hist_field->fn_num = HIST_FIELD_FN_RELDYNSTRING;
 		else
 			hist_field->fn_num = HIST_FIELD_FN_PSTRING;
+	} else if (field->filter_type == FILTER_STACKTRACE) {
+		flags |= HIST_FIELD_FL_STACKTRACE;
+
+		hist_field->size = MAX_FILTER_STR_VAL;
+		hist_field->type = kstrdup_const(field->type, GFP_KERNEL);
+		if (!hist_field->type)
+			goto free;
+
+		hist_field->fn_num = HIST_FIELD_FN_STACK;
 	} else {
 		hist_field->size = field->size;
 		hist_field->is_signed = field->is_signed;
diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 4554c458b78c..45c187e77e21 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -130,7 +130,9 @@ static int synth_event_define_fields(struct trace_event_call *call)
 	struct synth_event *event = call->data;
 	unsigned int i, size, n_u64;
 	char *name, *type;
+	int filter_type;
 	bool is_signed;
+	bool is_stack;
 	int ret = 0;
 
 	for (i = 0, n_u64 = 0; i < event->n_fields; i++) {
@@ -138,8 +140,12 @@ static int synth_event_define_fields(struct trace_event_call *call)
 		is_signed = event->fields[i]->is_signed;
 		type = event->fields[i]->type;
 		name = event->fields[i]->name;
+		is_stack = event->fields[i]->is_stack;
+
+		filter_type = is_stack ? FILTER_STACKTRACE : FILTER_OTHER;
+
 		ret = trace_define_field(call, type, name, offset, size,
-					 is_signed, FILTER_OTHER);
+					 is_signed, filter_type);
 		if (ret)
 			break;
 
-- 
2.51.0

