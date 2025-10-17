Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B391C285406;
	Fri, 17 Oct 2025 16:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760717745; cv=none; b=oDWcXmsulAZ3+5d7QjNZ0JyFz1tn5Krfxpr+PlOwDzWAZQSXme/BKN/84q0wA1omT69LmZQltiBotNMLs0ums5Bx48VikyAb3xDfEl17Hyg83Uphsa5GpgKdSDmlagcPhbLlhaaD3y/3iQ4CWnBkPgWAILaOygP9OuPAwm/567c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760717745; c=relaxed/simple;
	bh=4cvVL4IFJ70nn5sLgf+do2jK+w7Uh0UpstqAKSxIB3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V2JYrPxWn6retLXIz2Sd1UDABkjxATFW90TBCYFiq9RJj5OoPuWL3UXLNX1janc+rfz88PbYgh9RURlma7gTU68QjzRO6G6MzROvROeVz2gAQe9VRDYV/JxNSinxxKD3ZbYGL4c7l1OG7fBJg9QUmFsbvRiAQ1lWKINGuXPfGi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VaQG34U7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VaQG34U7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A75C1C4CEE7;
	Fri, 17 Oct 2025 16:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760717745;
	bh=4cvVL4IFJ70nn5sLgf+do2jK+w7Uh0UpstqAKSxIB3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VaQG34U7HoAwFgMVGt2PiyhnNnvX+hXBh0MPFKc2jZikC7TdKWOwP6OOHkRK6G8hR
	 mGr1DwrAugLUSHMXCPVEdqLFWy/S5mCNuYqnQz2v3z0yUIsk61C9cDh3l88yq0HRg4
	 BwTjFRaODxYEAZ/PQ4ituYQ8WTlAp1VkB1QsjFzizDnfHg/i7nx2k48VtgVW5YZ0DH
	 TCsP4MRTfmmuNrtnvDBDZyvxOZL8vkAW0c6l8JJnYNZu9O7bwoztnCQlY/b/C5V1gK
	 W7edP5vTrj8wUPYXdh06rfL5Y+NgCEiqFitMJ3Syv/B7uLW4gTAwMblCBOSJKIiS4b
	 RzoQdZPjWq/vg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] tracing: Allow tracer to add more than 32 options
Date: Sat, 18 Oct 2025 01:15:41 +0900
Message-ID: <176071774097.175601.10233017390618260565.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <176071773144.175601.17884676964675287059.stgit@devnote2>
References: <176071773144.175601.17884676964675287059.stgit@devnote2>
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

Since enum trace_iterator_flags is 32bit, the max number of the
option flags is limited to 32 and it is fully used now. To add
a new option, we need to expand it.

Use enum ... : uint64_t {...} syntax which is introduced by
C++11 and GCC/Clang extensions.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v4:
  - Use enum ... : type {} instead of const variables.
 Changes in v3:
  - Make TRACE_ITER_* to global.
---
 kernel/trace/trace.c              |   17 +++++++++--------
 kernel/trace/trace.h              |   14 +++++++-------
 kernel/trace/trace_irqsoff.c      |    2 +-
 kernel/trace/trace_sched_wakeup.c |    2 +-
 4 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 4283ed4e8f59..2b3fe0a30c7d 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5144,7 +5144,7 @@ static int tracing_trace_options_show(struct seq_file *m, void *v)
 	trace_opts = tr->current_trace->flags->opts;
 
 	for (i = 0; trace_options[i]; i++) {
-		if (tr->trace_flags & (1 << i))
+		if (tr->trace_flags & (1ULL << i))
 			seq_printf(m, "%s\n", trace_options[i]);
 		else
 			seq_printf(m, "no%s\n", trace_options[i]);
@@ -5197,7 +5197,7 @@ static int set_tracer_option(struct trace_array *tr, char *cmp, int neg)
 }
 
 /* Some tracers require overwrite to stay enabled */
-int trace_keep_overwrite(struct tracer *tracer, u32 mask, int set)
+int trace_keep_overwrite(struct tracer *tracer, u64 mask, int set)
 {
 	if (tracer->enabled && (mask & TRACE_ITER_OVERWRITE) && !set)
 		return -1;
@@ -5205,7 +5205,7 @@ int trace_keep_overwrite(struct tracer *tracer, u32 mask, int set)
 	return 0;
 }
 
-int set_tracer_flag(struct trace_array *tr, unsigned int mask, int enabled)
+int set_tracer_flag(struct trace_array *tr, u64 mask, int enabled)
 {
 	if ((mask == TRACE_ITER_RECORD_TGID) ||
 	    (mask == TRACE_ITER_RECORD_CMD) ||
@@ -5307,7 +5307,7 @@ int trace_set_options(struct trace_array *tr, char *option)
 	if (ret < 0)
 		ret = set_tracer_option(tr, cmp, neg);
 	else
-		ret = set_tracer_flag(tr, 1 << ret, !neg);
+		ret = set_tracer_flag(tr, 1ULL << ret, !neg);
 
 	mutex_unlock(&trace_types_lock);
 	mutex_unlock(&event_mutex);
@@ -9119,7 +9119,7 @@ trace_options_core_read(struct file *filp, char __user *ubuf, size_t cnt,
 
 	get_tr_index(tr_index, &tr, &index);
 
-	if (tr->trace_flags & (1 << index))
+	if (tr->trace_flags & (1ULL << index))
 		buf = "1\n";
 	else
 		buf = "0\n";
@@ -9148,7 +9148,7 @@ trace_options_core_write(struct file *filp, const char __user *ubuf, size_t cnt,
 
 	mutex_lock(&event_mutex);
 	mutex_lock(&trace_types_lock);
-	ret = set_tracer_flag(tr, 1 << index, val);
+	ret = set_tracer_flag(tr, 1ULL << index, val);
 	mutex_unlock(&trace_types_lock);
 	mutex_unlock(&event_mutex);
 
@@ -9312,8 +9312,9 @@ static void create_trace_options_dir(struct trace_array *tr)
 
 	for (i = 0; trace_options[i]; i++) {
 		if (top_level ||
-		    !((1 << i) & TOP_LEVEL_TRACE_FLAGS))
+		    !((1ULL << i) & TOP_LEVEL_TRACE_FLAGS)) {
 			create_trace_option_core_file(tr, trace_options[i], i);
+		}
 	}
 }
 
@@ -9997,7 +9998,7 @@ static int __remove_instance(struct trace_array *tr)
 	/* Disable all the flags that were enabled coming in */
 	for (i = 0; i < TRACE_FLAGS_MAX_SIZE; i++) {
 		if ((1 << i) & ZEROED_TRACE_FLAGS)
-			set_tracer_flag(tr, 1 << i, 0);
+			set_tracer_flag(tr, 1ULL << i, 0);
 	}
 
 	if (printk_trace == tr)
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 1dbf1d3cf2f1..caec534072e7 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -216,7 +216,7 @@ struct array_buffer {
 	int				cpu;
 };
 
-#define TRACE_FLAGS_MAX_SIZE		32
+#define TRACE_FLAGS_MAX_SIZE		64
 
 struct trace_options {
 	struct tracer			*tracer;
@@ -390,7 +390,7 @@ struct trace_array {
 	int			buffer_percent;
 	unsigned int		n_err_log_entries;
 	struct tracer		*current_trace;
-	unsigned int		trace_flags;
+	u64			trace_flags;
 	unsigned char		trace_flags_index[TRACE_FLAGS_MAX_SIZE];
 	unsigned int		flags;
 	raw_spinlock_t		start_lock;
@@ -631,7 +631,7 @@ struct tracer {
 					    u32 old_flags, u32 bit, int set);
 	/* Return 0 if OK with change, else return non-zero */
 	int			(*flag_changed)(struct trace_array *tr,
-						u32 mask, int set);
+						u64 mask, int set);
 	struct tracer		*next;
 	struct tracer_flags	*flags;
 	int			enabled;
@@ -1385,7 +1385,7 @@ extern int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 		C(MARKERS,		"markers"),		\
 		C(EVENT_FORK,		"event-fork"),		\
 		C(TRACE_PRINTK,		"trace_printk_dest"),	\
-		C(COPY_MARKER,		"copy_trace_marker"),\
+		C(COPY_MARKER,		"copy_trace_marker"),	\
 		C(PAUSE_ON_TRACE,	"pause-on-trace"),	\
 		C(HASH_PTR,		"hash-ptr"),	/* Print hashed pointer */ \
 		FUNCTION_FLAGS					\
@@ -1413,7 +1413,7 @@ enum trace_iterator_bits {
 #undef C
 #define C(a, b) TRACE_ITER_##a = (1 << TRACE_ITER_##a##_BIT)
 
-enum trace_iterator_flags { TRACE_FLAGS };
+enum trace_iterator_flags : uint64_t { TRACE_FLAGS };
 
 /*
  * TRACE_ITER_SYM_MASK masks the options in trace_flags that
@@ -2058,8 +2058,8 @@ extern const char *__stop___tracepoint_str[];
 
 void trace_printk_control(bool enabled);
 void trace_printk_start_comm(void);
-int trace_keep_overwrite(struct tracer *tracer, u32 mask, int set);
-int set_tracer_flag(struct trace_array *tr, unsigned int mask, int enabled);
+int trace_keep_overwrite(struct tracer *tracer, u64 mask, int set);
+int set_tracer_flag(struct trace_array *tr, u64 mask, int enabled);
 
 /* Used from boot time tracer */
 extern int trace_set_options(struct trace_array *tr, char *option);
diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index 5496758b6c76..1a65f9f1075c 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -539,7 +539,7 @@ static inline int irqsoff_function_set(struct trace_array *tr, u32 mask, int set
 }
 #endif /* CONFIG_FUNCTION_TRACER */
 
-static int irqsoff_flag_changed(struct trace_array *tr, u32 mask, int set)
+static int irqsoff_flag_changed(struct trace_array *tr, u64 mask, int set)
 {
 	struct tracer *tracer = tr->current_trace;
 
diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
index bf1cb80742ae..45865b4f753f 100644
--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -328,7 +328,7 @@ __trace_function(struct trace_array *tr,
 		trace_function(tr, ip, parent_ip, trace_ctx, NULL);
 }
 
-static int wakeup_flag_changed(struct trace_array *tr, u32 mask, int set)
+static int wakeup_flag_changed(struct trace_array *tr, u64 mask, int set)
 {
 	struct tracer *tracer = tr->current_trace;
 

