Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16983208D0;
	Tue, 18 Nov 2025 00:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763426108; cv=none; b=FHS0jWumAWr4daD7JxrL9TkY42yBjkefg509hbE3Nj6eMvCA+m3cxFhHwSzwqQN8i7/1+qJwkxA/5PLFB4geWWbCHiI1o6iMZszqhOdrj524iMutDzhZgJ0zME7vuW21eLzDHFgAOJv/HkWFJJtjo747IaLCFT1o0BUtfFiadek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763426108; c=relaxed/simple;
	bh=oC+Ulzp97dIDwxpUsxsEETc/+xJVXDYRMxLtCVkv3AY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=OOVyJFtgcnmoUD7LOm5tc0QDZf4DvHB6R/80cYLYtxRJmW0vwLTjnnrbllATAZFYOt0vNXfeC1KZUAdJrkQKf2TUgdTPPp1r2Z+Gnjt3qae+1LHZsSQxqANh9ecJz8Pjr7rJ8UNbBXik03heX73ipN+JyKQ8cqadUtBbtjICnOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iz/p/as8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iz/p/as8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35386C2BCB3;
	Tue, 18 Nov 2025 00:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763426106;
	bh=oC+Ulzp97dIDwxpUsxsEETc/+xJVXDYRMxLtCVkv3AY=;
	h=Date:From:To:Cc:Subject:References:From;
	b=Iz/p/as8dBHuwlL8CrKuGtV+9YowSs0TEcU5vMgZPwysHNjmE4egW/y0mGIc3AW0P
	 tHGjCYMHi1k6mylwLty8sy7Yk75p7nWJcAvpFVKllLcxVjrjnfHL58inxG/7cADas/
	 qUPyZljgCQuUrMainpTIYU0QSF6uJTTe/x/2f9kSfESHd8ITAu40JeFHHuNmlEQQsW
	 OBluGHW9mwUiYiZkC4kPH/cQRO236M5g1P/fH1jO7E+w0gq4Mz6ldNI53/Ts5nfi/I
	 hPQjzGqAx0PYIUiP3mfeSlAAoJy/senJWV6NbImRulIuOkQpmM7kEqWCo8NiWnrA76
	 JCXr+AnKtTdNw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vL9gx-00000002zJz-3Iup;
	Mon, 17 Nov 2025 19:35:31 -0500
Message-ID: <20251118003531.644484343@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 17 Nov 2025 19:29:51 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Ian Rogers <irogers@google.com>,
 Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>,
 Douglas Raillard <douglas.raillard@arm.com>
Subject: [POC][RFC][PATCH 1/3] tracing: Add perf events
References: <20251118002950.680329246@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Add perf events into the ftrace ring buffer. Create a new ftrace event
called a "perf_event". This event contains a dynamic array of u64 words.
Each entry allows to read 56 bits of the raw content of a perf PMU value
into the word leaving 8 bits as an identifier for what word that is.

One may ask "what happens when the counter is greater than 56 bits". The
answer is that you really shouldn't care. The value is written for user
space to consume and do any calculations. If one wants to see the
difference between two events, they can simply subtract the previous one
from the next one. If there is a wrap over the 56 bits, then adding a
"1ULL << 56" to the second value if it is less than the first will give
the correct result.

"What happens if the difference of the counters is 1 << 55 apart?"
Let's look at CPU cycles, as they probably go up the quickest. At 4GHz,
that would be 4,000,000,000 times a second.

  1 << 55 / 400000000 = 9007199 seconds
  9007199 / 60 = 150119 minutes
  150119 / 60 = 2501 hours
  2501 / 24 = 104 days!

This will not work if you want to see the number of cycles between two
events if those two events are 104 days apart. Do we care?

Currently only cpu cycles and cache misses are supported, but more can be
added in the future.

Two new options are added: event_cache_misses and event_cpu_cycles

 # cd /sys/kernel/tracing
 # echo 1 > options/event_cache_misses
 # echo 1 > events/syscalls/enable
 # cat trace
[..]
  bash-1009    [005] .....   566.863956: sys_write -> 0x2
  bash-1009    [005] .....   566.863973: cache_misses: 26544738
  bash-1009    [005] .....   566.864003: sys_dup2(oldfd: 0xa, newfd: 1)
  bash-1009    [005] .....   566.864004: cache_misses: 26546241
  bash-1009    [005] .....   566.864021: sys_dup2 -> 0x1
  bash-1009    [005] .....   566.864022: cache_misses: 26549598
  bash-1009    [005] .....   566.864059: sys_fcntl(fd: 0xa, cmd: 1, arg: 0)
  bash-1009    [005] .....   566.864060: cache_misses: 26558778

The option will cause the perf event to be triggered after every event.
If cpu_cycles is also enabled:

 # echo 1 > options/event_cpu_cycles
 # cat trace
[..]
  bash-1009    [006] .....   683.223244: sys_write -> 0x2
  bash-1009    [006] .....   683.223245: cpu_cycles: 273245 cache_misses: 40481492
  bash-1009    [006] .....   683.223262: sys_dup2(oldfd: 0xa, newfd: 1)
  bash-1009    [006] .....   683.223263: cpu_cycles: 286640 cache_misses: 40483017
  bash-1009    [006] .....   683.223278: sys_dup2 -> 0x1
  bash-1009    [006] .....   683.223279: cpu_cycles: 301412 cache_misses: 40486560
  bash-1009    [006] .....   683.223309: sys_fcntl(fd: 0xa, cmd: 1, arg: 0)
  bash-1009    [006] .....   683.223310: cpu_cycles: 335188 cache_misses: 40495672
  bash-1009    [006] .....   683.223317: sys_fcntl -> 0x1

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c            | 113 +++++++++++++++++++++-
 kernel/trace/trace.h            |  28 ++++++
 kernel/trace/trace_entries.h    |  13 +++
 kernel/trace/trace_event_perf.c | 162 ++++++++++++++++++++++++++++++++
 kernel/trace/trace_output.c     |  70 ++++++++++++++
 5 files changed, 385 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 59cd4ed8af6d..64d966a3ec8b 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1110,7 +1110,6 @@ void tracing_on(void)
 }
 EXPORT_SYMBOL_GPL(tracing_on);
 
-
 static __always_inline void
 __buffer_unlock_commit(struct trace_buffer *buffer, struct ring_buffer_event *event)
 {
@@ -2915,6 +2914,103 @@ void trace_event_buffer_commit(struct trace_event_buffer *fbuffer)
 }
 EXPORT_SYMBOL_GPL(trace_event_buffer_commit);
 
+#ifdef CONFIG_PERF_EVENTS
+static inline void record_perf_event(struct trace_array *tr,
+				     struct trace_buffer *buffer,
+				     unsigned int trace_ctx)
+{
+	struct ring_buffer_event *event;
+	struct perf_event_entry *entry;
+	int entries = READ_ONCE(tr->perf_events);
+	struct trace_array_cpu *data;
+	u64 *value;
+	int size;
+	int cpu;
+
+	if (!entries)
+		return;
+
+	guard(preempt_notrace)();
+	cpu = smp_processor_id();
+
+	/* Prevent this from recursing */
+	data = per_cpu_ptr(tr->array_buffer.data, cpu);
+	if (unlikely(!data) || local_read(&data->disabled))
+		return;
+
+	if (local_inc_return(&data->disabled) != 1)
+		goto out;
+
+	size = struct_size(entry, values, entries);
+	event = trace_buffer_lock_reserve(buffer, TRACE_PERF_EVENT, size,
+					  trace_ctx);
+	if (!event)
+		goto out;
+	entry			= ring_buffer_event_data(event);
+	value			= entry->values;
+
+	if (tr->trace_flags & TRACE_ITER(PERF_CYCLES)) {
+		*value++ = TRACE_PERF_VALUE(PERF_TRACE_CYCLES);
+		entries--;
+	}
+
+	if (entries && tr->trace_flags & TRACE_ITER(PERF_CACHE)) {
+		*value++ = TRACE_PERF_VALUE(PERF_TRACE_CACHE);
+		entries--;
+	}
+
+	/* If something changed, zero the rest */
+	if (unlikely(entries))
+		memset(value, 0, sizeof(u64) * entries);
+
+	trace_buffer_unlock_commit_nostack(buffer, event);
+ out:
+	local_dec(&data->disabled);
+}
+
+static int handle_perf_event(struct trace_array *tr, u64 mask, int enabled)
+{
+	int ret = 0;
+	int type;
+
+	switch (mask) {
+
+	case TRACE_ITER(PERF_CYCLES):
+		type = PERF_TRACE_CYCLES;
+		break;
+	case TRACE_ITER(PERF_CACHE):
+		type = PERF_TRACE_CACHE;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (enabled)
+		ret = trace_perf_event_enable(type);
+	else
+		trace_perf_event_disable(type);
+
+	if (ret < 0)
+		return ret;
+
+	if (enabled)
+		tr->perf_events++;
+	else
+		tr->perf_events--;
+
+	if (WARN_ON_ONCE(tr->perf_events < 0))
+		tr->perf_events = 0;
+
+	return 0;
+}
+#else
+static inline void record_perf_event(struct trace_array *tr,
+				     struct trace_buffer *buffer,
+				     unsigned int trace_ctx)
+{
+}
+#endif
+
 /*
  * Skip 3:
  *
@@ -2932,6 +3028,8 @@ void trace_buffer_unlock_commit_regs(struct trace_array *tr,
 {
 	__buffer_unlock_commit(buffer, event);
 
+	record_perf_event(tr, buffer, trace_ctx);
+
 	/*
 	 * If regs is not set, then skip the necessary functions.
 	 * Note, we can still get here via blktrace, wakeup tracer
@@ -5287,7 +5385,20 @@ int set_tracer_flag(struct trace_array *tr, u64 mask, int enabled)
 		update_marker_trace(tr, enabled);
 		/* update_marker_trace updates the tr->trace_flags */
 		return 0;
+
+#ifdef CONFIG_PERF_EVENTS
+	case TRACE_ITER(PERF_CACHE):
+	case TRACE_ITER(PERF_CYCLES):
+	{
+		int ret = 0;
+
+		ret = handle_perf_event(tr, mask, enabled);
+		if (ret < 0)
+			return ret;
+		break;
 	}
+#endif
+	} /* switch (mask) */
 
 	if (enabled)
 		tr->trace_flags |= mask;
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 58be6d741d72..094a156b0c70 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -56,6 +56,7 @@ enum trace_type {
 	TRACE_TIMERLAT,
 	TRACE_RAW_DATA,
 	TRACE_FUNC_REPEATS,
+	TRACE_PERF_EVENT,
 
 	__TRACE_LAST_TYPE,
 };
@@ -363,6 +364,8 @@ struct trace_array {
 
 	int			buffer_disabled;
 
+	int			perf_events;
+
 	struct trace_pid_list	__rcu *filtered_pids;
 	struct trace_pid_list	__rcu *filtered_no_pids;
 	/*
@@ -537,6 +540,7 @@ extern void __ftrace_bad_type(void);
 		IF_ASSIGN(var, ent, struct hwlat_entry, TRACE_HWLAT);	\
 		IF_ASSIGN(var, ent, struct osnoise_entry, TRACE_OSNOISE);\
 		IF_ASSIGN(var, ent, struct timerlat_entry, TRACE_TIMERLAT);\
+		IF_ASSIGN(var, ent, struct perf_event_entry, TRACE_PERF_EVENT);	\
 		IF_ASSIGN(var, ent, struct raw_data_entry, TRACE_RAW_DATA);\
 		IF_ASSIGN(var, ent, struct trace_mmiotrace_rw,		\
 			  TRACE_MMIO_RW);				\
@@ -1382,6 +1386,29 @@ extern int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 # define TRACE_ITER_PROF_TEXT_OFFSET_BIT	-1
 #endif
 
+#ifdef CONFIG_PERF_EVENTS
+#define PERF_MAKE_VALUE(type, val)	(((type) << 56) | ((val) & ~(0xffULL << 56)))
+/* Not required, but keep consistent with include/uapi/linux/perf_event.h */
+#define PERF_TRACE_CYCLES		0ULL
+#define PERF_TRACE_CACHE		5ULL
+#define TRACE_PERF_VALUE(type)		\
+	PERF_MAKE_VALUE((type), do_trace_perf_event(type))
+#define PERF_TRACE_VALUE(val)		((val) & ~(0xffULL << 56))
+#define PERF_TRACE_TYPE(val)		((val) >> 56)
+# define PERF_FLAGS				\
+		C(PERF_CACHE,		"event_cache_misses"),	\
+		C(PERF_CYCLES,		"event_cpu_cycles"),
+
+u64 do_trace_perf_event(int type);
+int trace_perf_event_enable(int type);
+void trace_perf_event_disable(int type);
+#else
+# define PERF_FLAGS
+static inline u64 do_trace_perf_event(int type) { return 0; }
+static inline int trace_perf_event_enable(int type) { return -ENOTSUPP; }
+static inline void trace_perf_event_disable(int type) { }
+#endif /* CONFIG_PERF_EVENTS */
+
 /*
  * trace_iterator_flags is an enumeration that defines bit
  * positions into trace_flags that controls the output.
@@ -1420,6 +1447,7 @@ extern int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 		FUNCTION_FLAGS					\
 		FGRAPH_FLAGS					\
 		STACK_FLAGS					\
+		PERF_FLAGS					\
 		BRANCH_FLAGS					\
 		PROFILER_FLAGS					\
 		FPROFILE_FLAGS
diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
index de294ae2c5c5..ecda463a9d8e 100644
--- a/kernel/trace/trace_entries.h
+++ b/kernel/trace/trace_entries.h
@@ -456,3 +456,16 @@ FTRACE_ENTRY(timerlat, timerlat_entry,
 		 __entry->context,
 		 __entry->timer_latency)
 );
+
+#ifdef CONFIG_PERF_EVENTS
+FTRACE_ENTRY(perf_event, perf_event_entry,
+
+	TRACE_PERF_EVENT,
+
+	F_STRUCT(
+		__dynamic_array(u64,		values		)
+	),
+
+	F_printk("values: %lld\n", __entry->values[0])
+);
+#endif
diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
index a6bb7577e8c5..ff864d300251 100644
--- a/kernel/trace/trace_event_perf.c
+++ b/kernel/trace/trace_event_perf.c
@@ -430,6 +430,168 @@ void perf_trace_buf_update(void *record, u16 type)
 }
 NOKPROBE_SYMBOL(perf_trace_buf_update);
 
+static void perf_callback(struct perf_event *event,
+			  struct perf_sample_data *data,
+			  struct pt_regs *regs)
+{
+	/* nop */
+}
+
+struct trace_perf_event {
+	struct perf_event		*event;
+};
+
+static struct trace_perf_event __percpu *perf_cache_events;
+static struct trace_perf_event __percpu *perf_cycles_events;
+static DEFINE_MUTEX(perf_event_mutex);
+static int perf_cache_cnt;
+static int perf_cycles_cnt;
+
+static inline int set_perf_type(int type, int *ptype, int *pconfig, int **pcount,
+				struct trace_perf_event __percpu ***pevents)
+{
+	switch (type) {
+	case PERF_TRACE_CYCLES:
+		if (ptype)
+			*ptype = PERF_TYPE_HARDWARE;
+		if (pconfig)
+			*pconfig = PERF_COUNT_HW_CPU_CYCLES;
+		*pcount = &perf_cycles_cnt;
+		*pevents = &perf_cycles_events;
+		return 0;
+
+	case PERF_TRACE_CACHE:
+		if (ptype)
+			*ptype = PERF_TYPE_HW_CACHE;
+		if (pconfig)
+			*pconfig = PERF_COUNT_HW_CACHE_MISSES;
+		*pcount = &perf_cache_cnt;
+		*pevents = &perf_cache_events;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+u64 do_trace_perf_event(int type)
+{
+	struct trace_perf_event __percpu **pevents;
+	struct trace_perf_event __percpu *events;
+	struct perf_event *e;
+	int *count;
+	int cpu;
+
+	if (set_perf_type(type, NULL, NULL, &count, &pevents) < 0)
+		return 0;
+
+	if (!*count)
+		return 0;
+
+	guard(preempt)();
+
+	events = READ_ONCE(*pevents);
+	if (!events)
+		return 0;
+
+	cpu = smp_processor_id();
+
+	e = per_cpu_ptr(events, cpu)->event;
+	if (!e)
+		return 0;
+
+	e->pmu->read(e);
+	return local64_read(&e->count);
+}
+
+static void __free_trace_perf_events(struct trace_perf_event __percpu *events)
+{
+	struct perf_event *e;
+	int cpu;
+
+	for_each_online_cpu(cpu) {
+		e = per_cpu_ptr(events, cpu)->event;
+		per_cpu_ptr(events, cpu)->event = NULL;
+		perf_event_release_kernel(e);
+	}
+}
+
+int trace_perf_event_enable(int type)
+{
+	struct perf_event_attr __free(kfree) *attr = NULL;
+	struct trace_perf_event __percpu **pevents;
+	struct trace_perf_event __percpu *events;
+	struct perf_event *e;
+	int *count;
+	int config;
+	int cpu;
+
+	if (set_perf_type(type, &config, &type, &count, &pevents) < 0)
+		return -EINVAL;
+
+	guard(mutex)(&perf_event_mutex);
+
+	if (*count) {
+		(*count)++;
+		return 0;
+	}
+
+	attr = kzalloc(sizeof(*attr), GFP_KERNEL);
+	if (!attr)
+		return -ENOMEM;
+
+	events = alloc_percpu(struct trace_perf_event);
+	if (!events)
+		return -ENOMEM;
+
+	attr->type = type;
+	attr->config = config;
+	attr->size = sizeof(struct perf_event_attr);
+	attr->pinned = 1;
+
+	/* initialize in case of failure */
+	for_each_possible_cpu(cpu) {
+		per_cpu_ptr(events, cpu)->event = NULL;
+	}
+
+	for_each_online_cpu(cpu) {
+		e = perf_event_create_kernel_counter(attr, cpu, NULL,
+						     perf_callback, NULL);
+		if (IS_ERR_OR_NULL(e)) {
+			__free_trace_perf_events(events);
+			return PTR_ERR(e);;
+		}
+		per_cpu_ptr(events, cpu)->event = e;
+	}
+
+	WRITE_ONCE(*pevents, events);
+	(*count)++;
+
+	return 0;
+}
+
+void trace_perf_event_disable(int type)
+{
+	struct trace_perf_event __percpu **pevents;
+	struct trace_perf_event __percpu *events;
+	int *count;
+
+	if (set_perf_type(type, NULL, NULL, &count, &pevents) < 0)
+		return;
+
+	guard(mutex)(&perf_event_mutex);
+
+	if (WARN_ON_ONCE(!*count))
+		return;
+
+	if (--(*count))
+		return;
+
+	events = READ_ONCE(*pevents);
+	WRITE_ONCE(*pevents, NULL);
+
+	__free_trace_perf_events(events);
+}
+
 #ifdef CONFIG_FUNCTION_TRACER
 static void
 perf_ftrace_function_call(unsigned long ip, unsigned long parent_ip,
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index ebbab3e9622b..a0f21cec9eed 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -1661,6 +1661,75 @@ static struct trace_event trace_timerlat_event = {
 	.funcs		= &trace_timerlat_funcs,
 };
 
+/* TRACE_PERF_EVENT */
+
+static enum print_line_t
+trace_perf_event_print(struct trace_iterator *iter, int flags,
+		       struct trace_event *event)
+{
+	struct trace_entry *entry = iter->ent;
+	struct trace_seq *s = &iter->seq;
+	struct perf_event_entry *field;
+	u64 value;
+	u64 *val;
+	u64 *end;
+
+	end = (u64 *)((long)iter->ent + iter->ent_size);
+
+	trace_assign_type(field, entry);
+
+	for (val = field->values; val < end; val++) {
+		if (val != field->values)
+			trace_seq_putc(s, ' ');
+		value = PERF_TRACE_VALUE(*val);
+		switch (PERF_TRACE_TYPE(*val)) {
+		case PERF_TRACE_CYCLES:
+			trace_seq_printf(s, "cpu_cycles: %lld", value);
+			break;
+		case PERF_TRACE_CACHE:
+			trace_seq_printf(s, "cache_misses: %lld", value);
+			break;
+		default:
+			trace_seq_printf(s, "unkown(%d): %lld",
+					 (int)PERF_TRACE_TYPE(*val), value);
+		}
+	}
+	trace_seq_putc(s, '\n');
+	return trace_handle_return(s);
+}
+
+static enum print_line_t
+trace_perf_event_raw(struct trace_iterator *iter, int flags,
+		   struct trace_event *event)
+{
+	struct perf_event_entry *field;
+	struct trace_seq *s = &iter->seq;
+	u64 *val;
+	u64 *end;
+
+	end = (u64 *)((long)iter->ent + iter->ent_size);
+
+	trace_assign_type(field, iter->ent);
+
+	for (val = field->values; val < end; val++) {
+		if (val != field->values)
+			trace_seq_putc(s, ' ');
+		trace_seq_printf(s, "%lld\n", *val);
+	}
+	trace_seq_putc(s, '\n');
+	return trace_handle_return(s);
+}
+
+static struct trace_event_functions trace_perf_event_funcs = {
+	.trace		= trace_perf_event_print,
+	.raw		= trace_perf_event_raw,
+};
+
+static struct trace_event trace_perf_event_event = {
+	.type		= TRACE_PERF_EVENT,
+	.funcs		= &trace_perf_event_funcs,
+};
+
 /* TRACE_BPUTS */
 static enum print_line_t
 trace_bputs_print(struct trace_iterator *iter, int flags,
@@ -1878,6 +1947,7 @@ static struct trace_event *events[] __initdata = {
 	&trace_timerlat_event,
 	&trace_raw_data_event,
 	&trace_func_repeats_event,
+	&trace_perf_event_event,
 	NULL
 };
 
-- 
2.51.0


