Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2CF1D7E3E;
	Mon,  7 Oct 2024 18:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728326039; cv=none; b=rqopzaC8AI6jZxhWTpWTCXoyYT9wlys8NRBjIPd5j5lU0duIiVchZP73cd0JByqZOEChbpekoiz1C/qZHJIvExF7LPAbk1uI0fnATC+FGpeEI9XPsvkp8d7uUNgeVytcCAbqKGRJUZe2ptwjxnK4vCyo//YlIuXEn3Wh6xE68V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728326039; c=relaxed/simple;
	bh=JWCtP8+ONZZ8jKaQa5JVkWMfLqF4aHvVyvY+2UjhF8M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WbUoZJ3n9e2cuYQjkOSgmJgYAxhcvOg6u0q6+BUH9lafHxM1Msuq1yo2e4GKh+L6TT0onJFk3ko5io5RHJh7MeNjBC8QxXytRUrfj2TKjyxMiQjij/f6G4tLFIYtLKXiH5XwPh6evomqwqyfjVIDKxM/EwDDEn8TiIz4O9ZEcSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQ+9+fNa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQ+9+fNa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EA09C4CEC6;
	Mon,  7 Oct 2024 18:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728326038;
	bh=JWCtP8+ONZZ8jKaQa5JVkWMfLqF4aHvVyvY+2UjhF8M=;
	h=From:To:Cc:Subject:Date:From;
	b=TQ+9+fNan8lhlwR84JQOt0Os1qE6dNy+jKooSfJfppQSS4QMpl8HeXXrHOL26kL79
	 tQu/kSSyQYnYyBKFmk+kIvAu8I3V+qfPnwbxcTNXPrDhteIl/G8ZcdaUbigoRnPnKg
	 vBlOv9abzvcgH+/lroFNOykl8eo7vkDaq6osgVPuadTOknYaf2ekEHoOf8U6pbTbuU
	 35LRUZXSdKax/+8amBWCsawnbykcnmnGRJCkRQCsX5+ENUrFxxfy84A8Qv7Cm9VpQt
	 obCCmDWXoMq7uNAqZ5ZqSTT5v4Z8jYjpB2A0ATUj2lpK0UtD60C8CO1YoojoCemsvb
	 HoDiy0zQmcZIA==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Alice Ryhl <aliceryhl@google.com>
Subject: [PATCH v2] tracepoints: Use new static branch API
Date: Mon,  7 Oct 2024 11:33:45 -0700
Message-ID: <c4de1761253ae9758fb954e96e07f895f5b9015f.1728325964.git.jpoimboe@kernel.org>
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
v2: fix CONFIG_HIST_TRIGGERS build failure

 include/linux/tracepoint-defs.h  | 4 ++--
 include/linux/tracepoint.h       | 8 ++++----
 kernel/trace/trace_events_hist.c | 2 +-
 kernel/tracepoint.c              | 4 ++--
 4 files changed, 9 insertions(+), 9 deletions(-)

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

