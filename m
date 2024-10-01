Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBD318754F;
	Tue,  1 Oct 2024 22:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727821453; cv=none; b=Uf9q1iguY7uZ3y+LQuJuT/1sIOYAYJgOsw1XBHVCZ0u6Op1+PFFVGtDHp8F9HwjSMvS1KgKSbF6XXsfl5+SNl+79Kxv5QDFOcJX3fET4v12UgEYULGVAsgPwCM/kYkgubMy6kxku1ecd51SHBIekaev6nt/rYwaP4SyrzDqaRDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727821453; c=relaxed/simple;
	bh=4R7pYlKOszuJiy1Kcuzstu3b3sGDugsks6KTwrgnmIc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J1d7T5Ldg+RdSM36/sMqimApLurBBTL1gr87C+0lBhqx9XaHm4InE/3JDZm3KUyJTp5ARzy0lND2arm9X42tipfeFJAu7DEm70JxsbUPS19X/7oiKXe66msNwy4ufS78XzLKhjopx8VkxRrZomMflycDZZkkqwK+vordydaAHGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpycLX0l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpycLX0l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D24C4CEC6;
	Tue,  1 Oct 2024 22:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727821453;
	bh=4R7pYlKOszuJiy1Kcuzstu3b3sGDugsks6KTwrgnmIc=;
	h=From:To:Cc:Subject:Date:From;
	b=kpycLX0lae07qpU/QD+mp3fABHYzGr8nMw7SNNQwL1SZH8/M8VOfKRl0LA1RmzUoP
	 XcL3VfoPCHsmbUJkEd7hKPhaFcDCAV6XduGxWp86ShyMklT/yoj3I9he/nq7fjeMd2
	 vtOSk6bfRi6/FbMJiLEc92jml/FaN0eWg44IcsfReafsll1yobp3NHam2vICwvuN/9
	 swq3wjJZ3NQ9N3bqmrf46Bcd3f6qqJmrfizNRrbIL9QmgjSmhh/TI6vInb3y3BY6xg
	 CQbd5AstIr8B1Z7qcqOMb4qd3pCSOEkA6g1aMUEbAGODU8luvbZWsSckhZc55G3NUw
	 ZKtGt8veTqTNg==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Alice Ryhl <aliceryhl@google.com>
Subject: [PATCH] tracepoints: Use new static branch API
Date: Tue,  1 Oct 2024 15:24:01 -0700
Message-ID: <03da49e81c50eb2a9f47918409e4c590c0f28060.1727817249.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The old static key API based on 'struct static_key' is deprecated.
Convert tracepoints to use the new API.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 include/linux/tracepoint-defs.h | 4 ++--
 include/linux/tracepoint.h      | 8 ++++----
 kernel/tracepoint.c             | 4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

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
index 6be396bb4297..ab5162fc3e4a 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -228,7 +228,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 #define __DECLARE_TRACE_RCU(name, proto, args, cond)			\
 	static inline void trace_##name##_rcuidle(proto)		\
 	{								\
-		if (static_key_false(&__tracepoint_##name.key))		\
+		if (static_branch_unlikely(&__tracepoint_##name.key))	\
 			__DO_TRACE(name,				\
 				TP_ARGS(args),				\
 				TP_CONDITION(cond), 1);			\
@@ -254,7 +254,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 	extern struct tracepoint __tracepoint_##name;			\
 	static inline void trace_##name(proto)				\
 	{								\
-		if (static_key_false(&__tracepoint_##name.key))		\
+		if (static_branch_unlikely(&__tracepoint_##name.key))	\
 			__DO_TRACE(name,				\
 				TP_ARGS(args),				\
 				TP_CONDITION(cond), 0);			\
@@ -291,7 +291,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 	static inline bool						\
 	trace_##name##_enabled(void)					\
 	{								\
-		return static_key_false(&__tracepoint_##name.key);	\
+		return static_branch_unlikely(&__tracepoint_##name.key);\
 	}
 
 /*
@@ -308,7 +308,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 	struct tracepoint __tracepoint_##_name	__used			\
 	__section("__tracepoints") = {					\
 		.name = __tpstrtab_##_name,				\
-		.key = STATIC_KEY_INIT_FALSE,				\
+		.key = STATIC_KEY_FALSE_INIT,				\
 		.static_call_key = &STATIC_CALL_KEY(tp_func_##_name),	\
 		.static_call_tramp = STATIC_CALL_TRAMP_ADDR(tp_func_##_name), \
 		.iterator = &__traceiter_##_name,			\
diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 8d1507dd0724..dc160cc0b616 100644
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

