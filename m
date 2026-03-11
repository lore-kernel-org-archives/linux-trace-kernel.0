Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4163C9ED6;
	Wed, 11 Mar 2026 10:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773224182; cv=none; b=T454OylCRax+m3g+Lx5d5mWQpjjKaagMk7iAiR7MDKOq7A0WGWbnEEXszmQuF86kBHD0sOYbzP0lhqi140zWtMGHQIUFd+0NJ0V3s3r7A3laiXMfm+U3um/nsKQ1FJKpjYAq/Zadz0woYFfNl5Ufsr/DwAI8oG4I17jmbbtPqwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773224182; c=relaxed/simple;
	bh=l/6PPioz7XUAIf9K5t4D5qRSQiDICVhNnTBRg93So4k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ibWZdv6B1x4CLQ6J2rGwzAlmsfLWmJdtTSyxQczheEEwld8LtuWQ4UaogaRvEg+3UD4/aUPK/wlr9G9IN1HyGlPE8FR2yUH+0aKNsfiv82vJqppYA7NM5i89JdQgoCqjdIiAxLaN6zEtZGYe8Mw//r1aPMgKq6Ds8BZiAYtMKDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mtO9d9xc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=biD5OHeR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mtO9d9xc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="biD5OHeR"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh_=28Schneider_Electric=29?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773224179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q5k89UukUYoQ08hlFR/70ql+PrIS9Rbff4VgpCkXn34=;
	b=mtO9d9xcRjcGNh2CsK5gjKa+yeYGviqg3oLb0cEsm75mODvvxopnofXIFtl18vAedBvmRo
	pA/2eQQvQwiEDdQGjqS+RvaN8VHumfGSS2tmPweF57PN4ZbzUGYFt6ixge9YPOkA3ZHPVx
	aqqUQF725tVw1EhUuU7IVoLm6mMO0nsB40R1jNgAhkkS+PG1oeBf/HHZRUllnR3T9j6alv
	pzXfk6qvKfuK2l7ypfuYGK61PYVMQ5LaBKuSClqFqsxlqwPegonphqMqhs+YrU089OoDcT
	pftj2CuVXbrCdm3bX3E+UMol2mNkADXKXHnQITFs7b4lWTerqeB3FmvSeaxlQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773224179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q5k89UukUYoQ08hlFR/70ql+PrIS9Rbff4VgpCkXn34=;
	b=biD5OHeRAY4KsI4KwDEcNDT/0e5QWgPZjNcr0dWsClOCQQEz7dhKRyLdp2boiVEbuu1/as
	PFTMge4P047Fv0Ag==
Date: Wed, 11 Mar 2026 11:15:11 +0100
Subject: [PATCH 02/12] tracing: Use explicit array size instead of sentinel
 elements in symbol printing
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260311-hrtimer-cleanups-v1-2-095357392669@linutronix.de>
References: <20260311-hrtimer-cleanups-v1-0-095357392669@linutronix.de>
In-Reply-To: <20260311-hrtimer-cleanups-v1-0-095357392669@linutronix.de>
To: Jan Kiszka <jan.kiszka@siemens.com>, 
 Kieran Bingham <kbingham@kernel.org>, John Stultz <jstultz@google.com>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Frederic Weisbecker <frederic@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh_=28Schneider_Electric=29?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773224171; l=8745;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=l/6PPioz7XUAIf9K5t4D5qRSQiDICVhNnTBRg93So4k=;
 b=S4E2SX+3ZcwI9BQ9hz3sGrK9zF5AjIVUZIQaWus0wdfL5dY/wIWhsMYAQ7dp2KWMMbXHPx8tF
 P42xjFp6X+PBzZ+oseeMXMoxHqvw5rR32vObeioB7EIZXbhl0GtOKcv
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The sentinel value added by the wrapper macros __print_symbolic() et al
prevents the callers from adding their own trailing comma. This makes
constructing symbol list dynamically based on kconfig values tedious.

Drop the sentinel elements, so callers can either specify the trailing
comma or not, just like in regular array initializers.

Signed-off-by: Thomas Weißschuh (Schneider Electric) <thomas.weissschuh@linutronix.de>
---
 include/linux/trace_events.h               | 13 ++++++----
 include/trace/stages/stage3_trace_output.h | 40 +++++++++++++++---------------
 kernel/trace/trace_events_synth.c          |  4 +--
 kernel/trace/trace_output.c                | 20 +++++++++------
 kernel/trace/trace_syscalls.c              |  3 +--
 5 files changed, 43 insertions(+), 37 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 37eb2f0f3dd8..40a43a4c7caf 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -22,20 +22,23 @@ union bpf_attr;
 
 const char *trace_print_flags_seq(struct trace_seq *p, const char *delim,
 				  unsigned long flags,
-				  const struct trace_print_flags *flag_array);
+				  const struct trace_print_flags *flag_array,
+				  size_t flag_array_size);
 
 const char *trace_print_symbols_seq(struct trace_seq *p, unsigned long val,
-				    const struct trace_print_flags *symbol_array);
+				    const struct trace_print_flags *symbol_array,
+				    size_t symbol_array_size);
 
 #if BITS_PER_LONG == 32
 const char *trace_print_flags_seq_u64(struct trace_seq *p, const char *delim,
 		      unsigned long long flags,
-		      const struct trace_print_flags_u64 *flag_array);
+		      const struct trace_print_flags_u64 *flag_array,
+		      size_t flag_array_size);
 
 const char *trace_print_symbols_seq_u64(struct trace_seq *p,
 					unsigned long long val,
-					const struct trace_print_flags_u64
-								 *symbol_array);
+					const struct trace_print_flags_u64 *symbol_array,
+					size_t symbol_array_size);
 #endif
 
 struct trace_iterator;
diff --git a/include/trace/stages/stage3_trace_output.h b/include/trace/stages/stage3_trace_output.h
index fce85ea2df1c..b7d8ef4b9fe1 100644
--- a/include/trace/stages/stage3_trace_output.h
+++ b/include/trace/stages/stage3_trace_output.h
@@ -64,36 +64,36 @@
 #define __get_rel_sockaddr(field)	((struct sockaddr *)__get_rel_dynamic_array(field))
 
 #undef __print_flags
-#define __print_flags(flag, delim, flag_array...)			\
-	({								\
-		static const struct trace_print_flags __flags[] =	\
-			{ flag_array, { -1, NULL }};			\
-		trace_print_flags_seq(p, delim, flag, __flags);	\
+#define __print_flags(flag, delim, flag_array...)					\
+	({										\
+		static const struct trace_print_flags __flags[] =			\
+			{ flag_array };							\
+		trace_print_flags_seq(p, delim, flag, __flags, ARRAY_SIZE(__flags));	\
 	})
 
 #undef __print_symbolic
-#define __print_symbolic(value, symbol_array...)			\
-	({								\
-		static const struct trace_print_flags symbols[] =	\
-			{ symbol_array, { -1, NULL }};			\
-		trace_print_symbols_seq(p, value, symbols);		\
+#define __print_symbolic(value, symbol_array...)					\
+	({										\
+		static const struct trace_print_flags symbols[] =			\
+			{ symbol_array };						\
+		trace_print_symbols_seq(p, value, symbols, ARRAY_SIZE(symbols));	\
 	})
 
 #undef __print_flags_u64
 #undef __print_symbolic_u64
 #if BITS_PER_LONG == 32
-#define __print_flags_u64(flag, delim, flag_array...)			\
-	({								\
-		static const struct trace_print_flags_u64 __flags[] =	\
-			{ flag_array, { -1, NULL } };			\
-		trace_print_flags_seq_u64(p, delim, flag, __flags);	\
+#define __print_flags_u64(flag, delim, flag_array...)						\
+	({											\
+		static const struct trace_print_flags_u64 __flags[] =				\
+			{ flag_array };								\
+		trace_print_flags_seq_u64(p, delim, flag, __flags, ARRAY_SIZE(__flags));	\
 	})
 
-#define __print_symbolic_u64(value, symbol_array...)			\
-	({								\
-		static const struct trace_print_flags_u64 symbols[] =	\
-			{ symbol_array, { -1, NULL } };			\
-		trace_print_symbols_seq_u64(p, value, symbols);	\
+#define __print_symbolic_u64(value, symbol_array...)					\
+	({										\
+		static const struct trace_print_flags_u64 symbols[] =			\
+			{ symbol_array };						\
+		trace_print_symbols_seq_u64(p, value, symbols, ARRAY_SIZE(symbols));	\
 	})
 #else
 #define __print_flags_u64(flag, delim, flag_array...)			\
diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 8bb95b2a6fcf..39ac4eba0702 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -395,7 +395,7 @@ static enum print_line_t print_synth_event(struct trace_iterator *iter,
 			n_u64++;
 		} else {
 			struct trace_print_flags __flags[] = {
-			    __def_gfpflag_names, {-1, NULL} };
+			    __def_gfpflag_names };
 			char *space = (i == se->n_fields - 1 ? "" : " ");
 
 			print_synth_event_num_val(s, print_fmt,
@@ -408,7 +408,7 @@ static enum print_line_t print_synth_event(struct trace_iterator *iter,
 				trace_seq_puts(s, " (");
 				trace_print_flags_seq(s, "|",
 						      entry->fields[n_u64].as_u64,
-						      __flags);
+						      __flags, ARRAY_SIZE(__flags));
 				trace_seq_putc(s, ')');
 			}
 			n_u64++;
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 1996d7aba038..96e2d22b4364 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -69,14 +69,15 @@ enum print_line_t trace_print_printk_msg_only(struct trace_iterator *iter)
 const char *
 trace_print_flags_seq(struct trace_seq *p, const char *delim,
 		      unsigned long flags,
-		      const struct trace_print_flags *flag_array)
+		      const struct trace_print_flags *flag_array,
+		      size_t flag_array_size)
 {
 	unsigned long mask;
 	const char *str;
 	const char *ret = trace_seq_buffer_ptr(p);
 	int i, first = 1;
 
-	for (i = 0;  flag_array[i].name && flags; i++) {
+	for (i = 0; i < flag_array_size && flags; i++) {
 
 		mask = flag_array[i].mask;
 		if ((flags & mask) != mask)
@@ -106,12 +107,13 @@ EXPORT_SYMBOL(trace_print_flags_seq);
 
 const char *
 trace_print_symbols_seq(struct trace_seq *p, unsigned long val,
-			const struct trace_print_flags *symbol_array)
+			const struct trace_print_flags *symbol_array,
+			size_t symbol_array_size)
 {
 	int i;
 	const char *ret = trace_seq_buffer_ptr(p);
 
-	for (i = 0;  symbol_array[i].name; i++) {
+	for (i = 0; i < symbol_array_size; i++) {
 
 		if (val != symbol_array[i].mask)
 			continue;
@@ -133,14 +135,15 @@ EXPORT_SYMBOL(trace_print_symbols_seq);
 const char *
 trace_print_flags_seq_u64(struct trace_seq *p, const char *delim,
 		      unsigned long long flags,
-		      const struct trace_print_flags_u64 *flag_array)
+		      const struct trace_print_flags_u64 *flag_array,
+		      size_t flag_array_size)
 {
 	unsigned long long mask;
 	const char *str;
 	const char *ret = trace_seq_buffer_ptr(p);
 	int i, first = 1;
 
-	for (i = 0;  flag_array[i].name && flags; i++) {
+	for (i = 0; i < flag_array_size && flags; i++) {
 
 		mask = flag_array[i].mask;
 		if ((flags & mask) != mask)
@@ -170,12 +173,13 @@ EXPORT_SYMBOL(trace_print_flags_seq_u64);
 
 const char *
 trace_print_symbols_seq_u64(struct trace_seq *p, unsigned long long val,
-			 const struct trace_print_flags_u64 *symbol_array)
+			    const struct trace_print_flags_u64 *symbol_array,
+			    size_t symbol_array_size)
 {
 	int i;
 	const char *ret = trace_seq_buffer_ptr(p);
 
-	for (i = 0;  symbol_array[i].name; i++) {
+	for (i = 0; i < symbol_array_size; i++) {
 
 		if (val != symbol_array[i].mask)
 			continue;
diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index 37317b81fcda..8ad72e17d8eb 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -174,7 +174,6 @@ sys_enter_openat_print(struct syscall_trace_enter *trace, struct syscall_metadat
 			{ O_NOFOLLOW, "O_NOFOLLOW" },
 			{ O_NOATIME, "O_NOATIME" },
 			{ O_CLOEXEC, "O_CLOEXEC" },
-			{ -1, NULL }
 		};
 
 	trace_seq_printf(s, "%s(", entry->name);
@@ -205,7 +204,7 @@ sys_enter_openat_print(struct syscall_trace_enter *trace, struct syscall_metadat
 				trace_seq_puts(s, "O_RDONLY|");
 			}
 
-			trace_print_flags_seq(s, "|", bits, __flags);
+			trace_print_flags_seq(s, "|", bits, __flags, ARRAY_SIZE(__flags));
 			/*
 			 * trace_print_flags_seq() adds a '\0' to the
 			 * buffer, but this needs to append more to the seq.

-- 
2.53.0

