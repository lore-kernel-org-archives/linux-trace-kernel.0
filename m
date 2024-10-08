Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88BF1F472B;
	Tue,  8 Oct 2024 19:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728415048; cv=none; b=tdfw1GwtlVRfEt/MdfNc7f9lobSBWJYFD4xFdU3yMJFknLDPFyFT/T3mkWs5+0tuIauFwM7C50wuFwmtcxvdHttl3izde9wNcbr4lwS6tD+x5Kfwi+ZTVBvJL82vQ3RLL1F5dAhQC0sehxj6eIiH8fzYGh6YP1SxsY3CWMPmuTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728415048; c=relaxed/simple;
	bh=Im3Wb0BE1gCm1511GCSPk39xhrX/ifJqxV+8+v7ISgc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lRTBC53yFPJv0KERm6gVEDS5WPvwEyh8rcIVxjY1eI8H7E/wq/jHVSfb1pjvFyNGZPIbfJZT7QLCNFfSnuLYnrWOgSd9MjyzgA5fC2OOSakCKbYJDNzbPeZ5KlXvuyGW61aUVUd5IKsn/FaY0o+QL7Lk8s3vnB6TtdB6denmLMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dytzaYdJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dytzaYdJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFA81C4CEC7;
	Tue,  8 Oct 2024 19:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728415048;
	bh=Im3Wb0BE1gCm1511GCSPk39xhrX/ifJqxV+8+v7ISgc=;
	h=From:To:Cc:Subject:Date:From;
	b=dytzaYdJzzM/6QEvvFY5cOcAAPKqVfIq83uLep/yVDnKaBx3m/QHa1sDY46rGzSph
	 QdzSxM8rBH9vmpVdmhFMueHa0SNniB4iTiVROCL1Htrz7j4PzWBKY0HvYXBKz4ICD8
	 1WV5TA+iJPnEl5ADSAFCcrR3S1ErVb+oneonOm3I/FxuFDOwpekIAP1n68owYZvGO2
	 VW1zb8KjZOHW5Nls83s5G25e+3hW3GlBHLYbcdlSxQKB0HUW8D5dY4BGj+7Vgi6vhX
	 R79RZqp8svuv5tYzN+R/2tc5AKRMEfd0nPROsWyC2ULZsQFa2VLAij3zPkno3QmDCo
	 BnwlMjZLPhpeA==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Alice Ryhl <aliceryhl@google.com>
Subject: [PATCH v3] tracepoints: Use new static branch API
Date: Tue,  8 Oct 2024 12:17:19 -0700
Message-ID: <7a08dae3c5eddb14b13864923c1b58ac1f4af83c.1728414936.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The old static key API is deprecated.  Switch to the new one.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
v3: fix CONFIG_USER_EVENTS build failure
v2: fix CONFIG_HIST_TRIGGERS build failure

 include/linux/tracepoint-defs.h  | 4 ++--
 include/linux/tracepoint.h       | 8 ++++----
 kernel/trace/trace_events_hist.c | 2 +-
 kernel/trace/trace_events_user.c | 4 ++--
 kernel/tracepoint.c              | 4 ++--
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/linux/tracepoint-defs.h b/include/linux/tracepoint-defs.h
index 4dc4955f0fbf..60a6e8314d4c 100644
--- a/include/linux/tracepoint-defs.h
+++ b/include/linux/tracepoint-defs.h
@@ -31,7 +31,7 @@ struct tracepoint_func {
 
 struct tracepoint {
 	const char *name;		/* Tracepoint name */
-	struct static_key key;
+	struct static_key_false key;
 	struct static_call_key *static_call_key;
 	void *static_call_tramp;
 	void *iterator;
@@ -83,7 +83,7 @@ struct bpf_raw_event_map {
 
 #ifdef CONFIG_TRACEPOINTS
 # define tracepoint_enabled(tp) \
-	static_key_false(&(__tracepoint_##tp).key)
+	static_branch_unlikely(&(__tracepoint_##tp).key)
 #else
 # define tracepoint_enabled(tracepoint) false
 #endif
diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 93a9f3070b48..2a29334bbc02 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -248,7 +248,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 #define __DECLARE_TRACE_RCU(name, proto, args, cond)			\
 	static inline void trace_##name##_rcuidle(proto)		\
 	{								\
-		if (static_key_false(&__tracepoint_##name.key))		\
+		if (static_branch_unlikely(&__tracepoint_##name.key))	\
 			__DO_TRACE(name,				\
 				TP_ARGS(args),				\
 				TP_CONDITION(cond), 1);			\
@@ -274,7 +274,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 	extern struct tracepoint __tracepoint_##name;			\
 	static inline void trace_##name(proto)				\
 	{								\
-		if (static_key_false(&__tracepoint_##name.key))		\
+		if (static_branch_unlikely(&__tracepoint_##name.key))	\
 			__DO_TRACE(name,				\
 				TP_ARGS(args),				\
 				TP_CONDITION(cond), 0);			\
@@ -311,7 +311,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 	static inline bool						\
 	trace_##name##_enabled(void)					\
 	{								\
-		return static_key_false(&__tracepoint_##name.key);	\
+		return static_branch_unlikely(&__tracepoint_##name.key);\
 	}
 
 /*
@@ -328,7 +328,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 	struct tracepoint __tracepoint_##_name	__used			\
 	__section("__tracepoints") = {					\
 		.name = __tpstrtab_##_name,				\
-		.key = STATIC_KEY_INIT_FALSE,				\
+		.key = STATIC_KEY_FALSE_INIT,				\
 		.static_call_key = &STATIC_CALL_KEY(tp_func_##_name),	\
 		.static_call_tramp = STATIC_CALL_TRAMP_ADDR(tp_func_##_name), \
 		.iterator = &__traceiter_##_name,			\
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 5f9119eb7c67..cc2924ad32a3 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -822,7 +822,7 @@ static inline void trace_synth(struct synth_event *event, u64 *var_ref_vals,
 {
 	struct tracepoint *tp = event->tp;
 
-	if (unlikely(atomic_read(&tp->key.enabled) > 0)) {
+	if (unlikely(static_key_enabled(&tp->key))) {
 		struct tracepoint_func *probe_func_ptr;
 		synth_probe_func_t probe_func;
 		void *__data;
diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 42b0d998d103..17bcad8f79de 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -1676,7 +1676,7 @@ static void update_enable_bit_for(struct user_event *user)
 	struct tracepoint *tp = &user->tracepoint;
 	char status = 0;
 
-	if (atomic_read(&tp->key.enabled) > 0) {
+	if (static_key_enabled(&tp->key)) {
 		struct tracepoint_func *probe_func_ptr;
 		user_event_func_t probe_func;
 
@@ -2280,7 +2280,7 @@ static ssize_t user_events_write_core(struct file *file, struct iov_iter *i)
 	 * It's possible key.enabled disables after this check, however
 	 * we don't mind if a few events are included in this condition.
 	 */
-	if (likely(atomic_read(&tp->key.enabled) > 0)) {
+	if (likely(static_key_enabled(&tp->key))) {
 		struct tracepoint_func *probe_func_ptr;
 		user_event_func_t probe_func;
 		struct iov_iter copy;
diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 8879da16ef4d..1e3de77ea6b3 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -358,7 +358,7 @@ static int tracepoint_add_func(struct tracepoint *tp,
 		tracepoint_update_call(tp, tp_funcs);
 		/* Both iterator and static call handle NULL tp->funcs */
 		rcu_assign_pointer(tp->funcs, tp_funcs);
-		static_key_enable(&tp->key);
+		static_branch_enable(&tp->key);
 		break;
 	case TP_FUNC_2:		/* 1->2 */
 		/* Set iterator static call */
@@ -414,7 +414,7 @@ static int tracepoint_remove_func(struct tracepoint *tp,
 		if (tp->unregfunc && static_key_enabled(&tp->key))
 			tp->unregfunc();
 
-		static_key_disable(&tp->key);
+		static_branch_disable(&tp->key);
 		/* Set iterator static call */
 		tracepoint_update_call(tp, tp_funcs);
 		/* Both iterator and static call handle NULL tp->funcs */
-- 
2.46.0

