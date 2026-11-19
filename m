Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=168.119.38.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795103503;
	b=1N6w2Bv5AQmgBVAq2wDzWyCYwjrv2//ClBXjqLRhip30IYiajt4IphKkOX1qVbQo40FA
	 I4FV3U/Svc9Jjgq5hK3a+MCy5XvT8mRjMohXD6dBdo7bVywFgFyfZCSRZ+GMcl8H4ngNc
	 VGF421p6ACOclj13Hqohc9AYJxZK3zMAsmLPzWrXClkk9OnM8HvmrJ04nkzDBfmiFi2N2
	 LaxUxFFyO7j5ciiXQokhPc+EBULC46ty0Qwn4WhFIxqFxdWCug4FCXXCE/WB8wApKhn/4
	 JSjT5K8ZMXgHjo2wuiblQPuQmJ9PweNiMsFnXsksYg2jcqpJr3/Rg0a8qK/+eVesWpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795103503;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Q9SdkFGT/gBrnMxj+Pqz+O0itxugWygmCJxKG76BRkY=;
	b=3cU/Wopr4OZwfyaeD01RC4sB/uX8Fcefb5vuxKcVc1WpmgC7LxRgzjfWxHOeBDUbHYcR
	 NfTt+3Tcro45tA2njNSrllHmtrMAxEWMW/vMYGKXKQWwhAZNOmF6iDlc3r3cwBEkwZKwW
	 i63Zk8ZwCwKdkkE1FqKhBK7m/awExenEGb7m7uza3TlBpIL5nfGEcJoAiXmIHMC+NANcI
	 CwhFwNzqU1euNKFDkZLlpj9TujtUghta9b1h70+FEjr7PJEBvtbtjZCXghaxPU0TW+m9G
	 yHY+f3tA2DnoiSzwXP6/1r0c6SlTKvCOwoocdpizVuJfrXBwy1Y22Kz+QQHYTNLp3zQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=permerror header.from=sipsolutions.net;
	spf=pass smtp.mailfrom=sipsolutions.net;
	dkim=pass header.d=sipsolutions.net header.i=@sipsolutions.net header.a=rsa-sha256 header.s=mail header.b=pNqYoOjw;
	arc=none smtp.remote-ip=168.119.38.16
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B806D60A2608;
	Thu, 19 Nov 2026 15:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.a=rsa-sha256 header.s=mail header.b=pNqYoOjw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Q9SdkFGT/gBrnMxj+Pqz+O0itxugWygmCJxKG76BRkY=;
	t=1795103502; x=1796313102; b=pNqYoOjwnBX4qQp9tSJc/+X+tpOSoWfr9lrajrPYICpGEaz
	fbVGYcvDF/UZycExM8cIS4SKYR/1okUojXA4moic70vju5JrlV+MZZuXddj2QhL/GCriI8+vR08Kj
	iAgLrcZxjaVihIShxnrNvsuya+vMdRfVR1op0hcnraJCjfxkQ7uV46ycSJ92pCFcbolVUDVFWwx1k
	4RE8TtXS1tq5ugN9pS7tOU9HyUD21xuUzFxp1SK3V81a7Lsa7N9yrbZ8Rtq5BG387idwawzdLVf6v
	tGnbvOF5rIdc2El/LPZxZUGQS1A5MvYoByz4pI2P5OcLDKR9t/cb+7Fxxwh7NePA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1xU4QD-00000004ZOV-3Sb3;
	Thu, 19 Nov 2026 16:51:38 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	dev@openvswitch.org,
	Adrian Moreno <amorenoz@redhat.com>,
	Antoine Tenart <atenart@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v8 1/4] tracing: add __print_sym() to replace __print_symbolic()
Date: Thu, 19 Nov 2026 16:48:41 +0100
Message-ID: <20261119155133.355849-7-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119155133.355849-6-johannes@sipsolutions.net>
References: <20261119155133.355849-6-johannes@sipsolutions.net>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The way __print_symbolic() works is limited and inefficient
in multiple ways:
 - you can only use it with a static list of symbols, but
   e.g. the SKB dropreasons are now a dynamic list

 - it builds the list in memory _three_ times, so it takes
   a lot of memory:
   - The print_fmt contains the list (since it's passed to
     the macro there). This actually contains the names
     _twice_, which is fixed up at runtime.
   - TRACE_DEFINE_ENUM() puts a 24-byte struct trace_eval_map
     for every entry, plus the string pointed to by it, which
     cannot be deduplicated with the strings in the print_fmt
   - The in-kernel symbolic printing creates yet another list
     of struct trace_print_flags for trace_print_symbols_seq()

 - it also requires runtime fixup during init, which is a lot
   of string parsing due to the print_fmt fixup

Introduce __print_sym() to - over time - replace the old one.
We can easily extend this also to __print_flags later, but I
cared only about the SKB dropreasons for now, which has only
__print_symbolic().

This new __print_sym() requires only a single list of items,
created by TRACE_DEFINE_SYM_LIST(), or can even use another
already existing list by using TRACE_DEFINE_SYM_FNS() with
lookup and show methods.

Then, instead of doing an init-time fixup, just do this at the
time when userspace reads the print_fmt. This way, dynamically
updated lists are possible.

For userspace, nothing actually changes, because the print_fmt
is shown exactly the same way the old __print_symbolic() was.

This adds about 4k .text in my test builds, but that'll be
more than paid for by the actual conversions.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
v8: fix it to use TRACE_SYM_VAR, add a sample
v7: address sashiko's alignment concern
v6: don't place data needed at runtime in .init sections,
    fixing the crash Steven reported with v1:
    https://lore.kernel.org/r/20240819182340.3bd23d67@gandalf.local.home/
    (yes, it's been over 2 years ... my bad)
---
 include/asm-generic/vmlinux.lds.h          |  4 +
 include/linux/module.h                     |  2 +
 include/linux/trace_events.h               |  7 ++
 include/linux/tracepoint.h                 | 20 +++++
 include/trace/stages/init.h                | 55 ++++++++++++
 include/trace/stages/stage2_data_offsets.h |  6 ++
 include/trace/stages/stage3_trace_output.h |  9 ++
 include/trace/stages/stage7_class_define.h |  3 +
 kernel/module/main.c                       |  3 +
 kernel/trace/trace_events.c                | 99 +++++++++++++++++++++-
 kernel/trace/trace_output.c                | 45 ++++++++++
 samples/trace_events/trace-events-sample.c | 30 +++++++
 samples/trace_events/trace-events-sample.h | 47 +++++++++-
 13 files changed, 327 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 3eb732942d69..ba2d8234aecb 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -275,9 +275,12 @@
 #define FTRACE_EVENTS()							\
 	. = ALIGN(8);							\
 	BOUNDED_SECTION(_ftrace_events)					\
+	. = ALIGN(8);							\
 	BOUNDED_SECTION_BY(_ftrace_eval_map, _ftrace_eval_maps)
+#define FTRACE_SYM_DEFS()	BOUNDED_SECTION(_ftrace_sym_defs)
 #else
 #define FTRACE_EVENTS()
+#define FTRACE_SYM_DEFS()
 #endif
 
 #ifdef CONFIG_TRACING
@@ -391,6 +394,7 @@
 	TRACE_PRINTKS()							\
 	BPF_RAW_TP()							\
 	TRACEPOINT_STR()						\
+	FTRACE_SYM_DEFS()						\
 	KUNIT_TABLE()
 
 /*
diff --git a/include/linux/module.h b/include/linux/module.h
index 76f4f3596477..244edf26ad10 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -520,6 +520,8 @@ struct module {
 	unsigned int num_trace_events;
 	struct trace_eval_map **trace_evals;
 	unsigned int num_trace_evals;
+	struct trace_sym_def **trace_sym_defs;
+	unsigned int num_trace_sym_defs;
 #endif
 #ifdef CONFIG_DYNAMIC_FTRACE
 	unsigned int num_ftrace_callsites;
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 321f2f3a6c8e..793fc1d7030a 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -29,6 +29,13 @@ const char *trace_print_symbols_seq(struct trace_seq *p, unsigned long val,
 				    const struct trace_print_flags *symbol_array,
 				    size_t symbol_array_size);
 
+const char *trace_print_sym_seq(struct trace_seq *p, unsigned long long val,
+				const char *(*lookup)(unsigned long long val));
+const char *trace_sym_lookup(const struct trace_sym_entry *list,
+			     size_t len, unsigned long long value);
+void trace_sym_show(struct seq_file *m,
+		    const struct trace_sym_entry *list, size_t len);
+
 #if BITS_PER_LONG == 32
 const char *trace_print_flags_seq_u64(struct trace_seq *p, const char *delim,
 		      unsigned long long flags,
diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index e0d838c9ce93..05c45a72756c 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -32,6 +32,24 @@ struct trace_eval_map {
 	unsigned long		eval_value;
 };
 
+struct trace_sym_def {
+	const char		*system;
+	const char		*symbol_id;
+	/* may return NULL, called under rcu_read_lock() */
+	const char *		(*lookup)(unsigned long long);
+	/*
+	 * Must print the list: ', { val, "name"}, ...'
+	 * with no trailing comma, but with the leading ', '
+	 * to simplify things:
+	 */
+	void 			(*show)(struct seq_file *);
+};
+
+struct trace_sym_entry {
+	unsigned long long	value;
+	const char		*name;
+};
+
 #define TRACEPOINT_DEFAULT_PRIO	10
 
 extern int
@@ -163,6 +181,8 @@ extern void syscall_unregfunc(void);
 
 #define TRACE_DEFINE_ENUM(x)
 #define TRACE_DEFINE_SIZEOF(x)
+#define TRACE_DEFINE_SYM_FNS(...)
+#define TRACE_DEFINE_SYM_LIST(...)
 
 #ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
 static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
diff --git a/include/trace/stages/init.h b/include/trace/stages/init.h
index 000bcfc8dd2e..03a7898cc84a 100644
--- a/include/trace/stages/init.h
+++ b/include/trace/stages/init.h
@@ -23,6 +23,61 @@ TRACE_MAKE_SYSTEM_STR();
 	__section("_ftrace_eval_map")			\
 	*TRACE_SYSTEM##_##a = &__##TRACE_SYSTEM##_##a
 
+/*
+ * Define a symbol for __print_sym by giving lookup and
+ * show functions. See &struct trace_sym_def.
+ */
+#undef TRACE_DEFINE_SYM_FNS
+#define TRACE_DEFINE_SYM_FNS(_symbol_id, _lookup, _show)		\
+	_TRACE_DEFINE_SYM_FNS(TRACE_SYSTEM_VAR, _symbol_id, _lookup, _show)
+#define _TRACE_DEFINE_SYM_FNS(_system, _symbol_id, _lookup, _show)	\
+	__TRACE_DEFINE_SYM_FNS(_system, _symbol_id, _lookup, _show)
+#define __TRACE_DEFINE_SYM_FNS(_system, _symbol_id, _lookup, _show)	\
+	___TRACE_DEFINE_SYM_FNS(_system ## _ ## _symbol_id, _symbol_id,	\
+				_lookup, _show)
+#define ___TRACE_DEFINE_SYM_FNS(_name, _symbol_id, _lookup, _show)	\
+	static struct trace_sym_def					\
+	__trace_sym_def_ ## _name = {					\
+		.system = TRACE_SYSTEM_STRING,				\
+		.symbol_id = #_symbol_id,				\
+		.lookup = _lookup,					\
+		.show = _show,						\
+	};								\
+	static struct trace_sym_def __used				\
+	__section("_ftrace_sym_defs")					\
+	*__trace_sym_def_p_ ## _name = &__trace_sym_def_ ## _name
+
+/*
+ * Define a symbol for __print_sym by giving lookup and
+ * show functions. See &struct trace_sym_def.
+ */
+#undef TRACE_DEFINE_SYM_LIST
+#define TRACE_DEFINE_SYM_LIST(_symbol_id, ...)				\
+	_TRACE_DEFINE_SYM_LIST(TRACE_SYSTEM_VAR, _symbol_id, __VA_ARGS__)
+#define _TRACE_DEFINE_SYM_LIST(_system, _symbol_id, ...)		\
+	__TRACE_DEFINE_SYM_LIST(_system, _symbol_id, __VA_ARGS__)
+#define __TRACE_DEFINE_SYM_LIST(_system, _symbol_id, ...)		\
+	___TRACE_DEFINE_SYM_LIST(_system ## _ ## _symbol_id, _symbol_id,\
+				 __VA_ARGS__)
+#define ___TRACE_DEFINE_SYM_LIST(_name, _symbol_id, ...)		\
+	static struct trace_sym_entry					\
+	__trace_sym_list_ ## _name[] = { __VA_ARGS__ };			\
+	static const char *						\
+	__trace_sym_lookup_ ## _name(unsigned long long value)		\
+	{								\
+		return trace_sym_lookup(__trace_sym_list_ ## _name,	\
+			ARRAY_SIZE(__trace_sym_list_ ## _name), value);	\
+	}								\
+	static void							\
+	__trace_sym_show_ ## _name(struct seq_file *m)			\
+	{								\
+		trace_sym_show(m, __trace_sym_list_ ## _name,		\
+			       ARRAY_SIZE(__trace_sym_list_ ## _name));	\
+	}								\
+	___TRACE_DEFINE_SYM_FNS(_name, _symbol_id,			\
+				__trace_sym_lookup_ ## _name,		\
+				__trace_sym_show_ ## _name)
+
 #undef TRACE_DEFINE_SIZEOF
 #define TRACE_DEFINE_SIZEOF(a)				\
 	static struct trace_eval_map __used __initdata	\
diff --git a/include/trace/stages/stage2_data_offsets.h b/include/trace/stages/stage2_data_offsets.h
index 8b0cff06d346..5afd9de7deb3 100644
--- a/include/trace/stages/stage2_data_offsets.h
+++ b/include/trace/stages/stage2_data_offsets.h
@@ -5,6 +5,12 @@
 #undef TRACE_DEFINE_ENUM
 #define TRACE_DEFINE_ENUM(a)
 
+#undef TRACE_DEFINE_SYM_FNS
+#define TRACE_DEFINE_SYM_FNS(_symbol_id, _lookup, _show)
+
+#undef TRACE_DEFINE_SYM_LIST
+#define TRACE_DEFINE_SYM_LIST(_symbol_id, ...)
+
 #undef TRACE_DEFINE_SIZEOF
 #define TRACE_DEFINE_SIZEOF(a)
 
diff --git a/include/trace/stages/stage3_trace_output.h b/include/trace/stages/stage3_trace_output.h
index 181b81335781..eb34b43147a1 100644
--- a/include/trace/stages/stage3_trace_output.h
+++ b/include/trace/stages/stage3_trace_output.h
@@ -79,6 +79,15 @@
 		trace_print_symbols_seq(p, value, symbols, ARRAY_SIZE(symbols));	\
 	})
 
+#undef __print_sym
+#define __print_sym(value, symbol_id)					\
+	___print_sym(TRACE_SYSTEM_VAR, value, symbol_id)
+#define ___print_sym(sys, value, symbol_id)				\
+	____print_sym(sys, value, symbol_id)
+#define ____print_sym(sys, value, symbol_id)				\
+	trace_print_sym_seq(p, value,					\
+		__trace_sym_def_p_ ## sys ## _ ## symbol_id->lookup)
+
 #undef __print_flags_u64
 #undef __print_symbolic_u64
 #if BITS_PER_LONG == 32
diff --git a/include/trace/stages/stage7_class_define.h b/include/trace/stages/stage7_class_define.h
index 47008897a795..936b9fa08cea 100644
--- a/include/trace/stages/stage7_class_define.h
+++ b/include/trace/stages/stage7_class_define.h
@@ -45,6 +45,9 @@
 #define __event_in_softirq()	(REC->common_flags & 0x10)
 #define __event_in_irq()	(REC->common_flags & 0x18)
 
+#undef __print_sym
+#define __print_sym(value, symbol_id)	__print_sym(value:symbol_id)
+
 /*
  * The below is not executed in the kernel. It is only what is
  * displayed in the print format for userspace to parse.
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 34e0204ea37c..b75a01536647 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2751,6 +2751,9 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 	mod->trace_evals = section_objs(info, "_ftrace_eval_map",
 					sizeof(*mod->trace_evals),
 					&mod->num_trace_evals);
+	mod->trace_sym_defs = section_objs(info, "_ftrace_sym_defs",
+					   sizeof(*mod->trace_sym_defs),
+					   &mod->num_trace_sym_defs);
 #endif
 #ifdef CONFIG_TRACING
 	mod->trace_bprintk_fmt_start = section_objs(info, "__trace_printk_fmt",
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 49d135bc2fbf..cea71270e651 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2148,6 +2148,102 @@ static void *f_next(struct seq_file *m, void *v, loff_t *pos)
 		return node;
 }
 
+extern struct trace_sym_def *__start_ftrace_sym_defs[];
+extern struct trace_sym_def *__stop_ftrace_sym_defs[];
+
+/* note: @name is not NUL-terminated */
+static void show_sym_list(struct seq_file *m, struct trace_event_call *call,
+			  const char *name, unsigned int name_len)
+{
+	struct trace_sym_def **sym_defs;
+	unsigned int n_sym_defs, i;
+
+	if ((call->flags & TRACE_EVENT_FL_DYNAMIC) || !call->module) {
+		sym_defs = __start_ftrace_sym_defs;
+		n_sym_defs = __stop_ftrace_sym_defs - __start_ftrace_sym_defs;
+	} else {
+#ifdef CONFIG_MODULES
+		struct module *mod = call->module;
+
+		sym_defs = mod->trace_sym_defs;
+		n_sym_defs = mod->num_trace_sym_defs;
+#else
+		return;
+#endif /* CONFIG_MODULES */
+	}
+
+	for (i = 0; i < n_sym_defs; i++) {
+		unsigned int sym_len;
+
+		if (!sym_defs[i])
+			continue;
+		if (sym_defs[i]->system != call->class->system)
+			continue;
+		sym_len = strlen(sym_defs[i]->symbol_id);
+		if (name_len != sym_len)
+			continue;
+		if (strncmp(sym_defs[i]->symbol_id, name, sym_len))
+			continue;
+		if (sym_defs[i]->show)
+			sym_defs[i]->show(m);
+		break;
+	}
+}
+
+static void show_print_fmt(struct seq_file *m, struct trace_event_call *call)
+{
+	char *ptr = call->print_fmt;
+	bool in_print_sym = false;
+	int quote = 0;
+
+	seq_puts(m, "\nprint fmt: ");
+	while (*ptr) {
+		if (*ptr == '\\') {
+			seq_putc(m, *ptr);
+			ptr++;
+			/* paranoid */
+			if (!*ptr)
+				break;
+			goto next;
+		}
+		if (*ptr == '"') {
+			quote ^= 1;
+			goto next;
+		}
+		if (quote)
+			goto next;
+
+		if (in_print_sym && *ptr != ':')
+			goto next;
+
+		if (in_print_sym && *ptr == ':') {
+			const char *name;
+
+			ptr++;
+			name = ptr;
+			/* skip the name */
+			while (*ptr && *ptr != ')')
+				ptr++;
+			/* and show the actual list inline now */
+			show_sym_list(m, call, name, ptr - name);
+			in_print_sym = false;
+			continue;
+		}
+
+		if (strncmp(ptr, "__print_sym(", 12) == 0) {
+			ptr += 12;
+			seq_puts(m, "__print_symbolic(");
+			in_print_sym = true;
+			continue;
+		}
+next:
+		seq_putc(m, *ptr);
+		ptr++;
+	}
+
+	seq_putc(m, '\n');
+}
+
 static int f_show(struct seq_file *m, void *v)
 {
 	struct trace_event_file *file = event_file_data(m->private);
@@ -2167,8 +2263,7 @@ static int f_show(struct seq_file *m, void *v)
 		return 0;
 
 	case FORMAT_PRINTFMT:
-		seq_printf(m, "\nprint fmt: %s\n",
-			   call->print_fmt);
+		show_print_fmt(m, call);
 		return 0;
 	}
 
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index a5ad76175d10..0850b3ad5707 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -131,6 +131,51 @@ trace_print_symbols_seq(struct trace_seq *p, unsigned long val,
 }
 EXPORT_SYMBOL(trace_print_symbols_seq);
 
+const char *trace_sym_lookup(const struct trace_sym_entry *list,
+			     size_t len, unsigned long long value)
+{
+	size_t i;
+
+	for (i = 0; i < len; i++) {
+		if (list[i].value == value)
+			return list[i].name;
+	}
+	return NULL;
+}
+EXPORT_SYMBOL(trace_sym_lookup);
+
+void trace_sym_show(struct seq_file *m,
+		    const struct trace_sym_entry *list, size_t len)
+{
+	size_t i;
+
+	for (i = 0; i < len; i++)
+		seq_printf(m, ", { %lld, \"%s\" }",
+			   list[i].value, list[i].name);
+}
+EXPORT_SYMBOL(trace_sym_show);
+
+const char *
+trace_print_sym_seq(struct trace_seq *p, unsigned long long val,
+		    const char *(*lookup)(unsigned long long val))
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+	const char *name;
+
+	rcu_read_lock();
+	name = lookup(val);
+	if (name)
+		trace_seq_puts(p, name);
+	else
+		trace_seq_printf(p, "0x%llx", val);
+	rcu_read_unlock();
+
+	trace_seq_putc(p, 0);
+
+	return ret;
+}
+EXPORT_SYMBOL(trace_print_sym_seq);
+
 #if BITS_PER_LONG == 32
 const char *
 trace_print_flags_seq_u64(struct trace_seq *p, const char *delim,
diff --git a/samples/trace_events/trace-events-sample.c b/samples/trace_events/trace-events-sample.c
index ca5d98c360cb..26948306f6dd 100644
--- a/samples/trace_events/trace-events-sample.c
+++ b/samples/trace_events/trace-events-sample.c
@@ -11,6 +11,36 @@
 #define CREATE_TRACE_POINTS
 #include "trace-events-sample.h"
 
+/* functions for the dynamic __print_sym() example */
+static const struct {
+	unsigned long val;
+	char *name;
+} print_sym_dynamic_names[] = {
+	{ 0, "zero" },
+	{ TRACE_SAMPLE_FOO, "TWO" },
+	{ TRACE_SAMPLE_BAR, "FOUR" },
+	{ TRACE_SAMPLE_ZOO, "EIGHT" },
+	{ 10, "TEN" }
+};
+
+const char *sample_names_dynamic_lookup(unsigned long long value)
+{
+	for (int i = 0; i < ARRAY_SIZE(print_sym_dynamic_names); i++) {
+		if (print_sym_dynamic_names[i].val == value)
+			return print_sym_dynamic_names[i].name;
+	}
+
+	return NULL;
+}
+
+void sample_names_dynamic_show(struct seq_file *m)
+{
+	for (int i = 0; i < ARRAY_SIZE(print_sym_dynamic_names); i++)
+		seq_printf(m, ", { %lu, \"%s\" }",
+			   print_sym_dynamic_names[i].val,
+			   print_sym_dynamic_names[i].name);
+}
+
 static const char *random_strings[] = {
 	"Mother Goose",
 	"Snoopy",
diff --git a/samples/trace_events/trace-events-sample.h b/samples/trace_events/trace-events-sample.h
index 816848a456a2..38d6bf808de6 100644
--- a/samples/trace_events/trace-events-sample.h
+++ b/samples/trace_events/trace-events-sample.h
@@ -297,6 +297,33 @@ TRACE_DEFINE_ENUM(TRACE_SAMPLE_FOO);
 TRACE_DEFINE_ENUM(TRACE_SAMPLE_BAR);
 TRACE_DEFINE_ENUM(TRACE_SAMPLE_ZOO);
 
+/*
+ * define the names as { value, "name" } tuples for __print_sym() below,
+ * same as the inline list for __print_dynamic()
+ */
+TRACE_DEFINE_SYM_LIST(sample_names_static,
+	{ 0, "zero" },
+	{ TRACE_SAMPLE_FOO, "TWO" },
+	{ TRACE_SAMPLE_BAR, "FOUR" },
+	{ TRACE_SAMPLE_ZOO, "EIGHT" },
+	{ 10, "TEN" }
+);
+
+/*
+ * Alternatively, you could define a function for the names:
+ *
+ * The _lookup() function returns the string for the given value.
+ *
+ * The _show() function must
+ *	seq_printf(m, ", { %u, \"%s\" }", value, name);
+ * for each value that userspace should be able to parse.
+ */
+const char *sample_names_dynamic_lookup(unsigned long long value);
+void sample_names_dynamic_show(struct seq_file *m);
+TRACE_DEFINE_SYM_FNS(sample_names_dynamic,
+		     sample_names_dynamic_lookup,
+		     sample_names_dynamic_show);
+
 TRACE_EVENT(foo_bar,
 
 	TP_PROTO(const char *foo, int bar, const int *lst,
@@ -328,7 +355,7 @@ TRACE_EVENT(foo_bar,
 		__assign_cpumask(cpum, cpumask_bits(mask));
 	),
 
-	TP_printk("foo %s %d %s %s %s %s %s %s (%s) (%s) %s [%d] %*pbl",
+	TP_printk("foo %s %d %s %s %s %s %s %s %s %s (%s) (%s) %s [%d] %*pbl",
 		  __entry->foo, __entry->bar,
 
 /*
@@ -340,6 +367,9 @@ TRACE_EVENT(foo_bar,
  *    the variable matches one of the values, then it will print the
  *    string in that pair. If non are matched, it returns a string
  *    version of the number (if __entry->bar == 7 then "7" is returned).
+ *
+ * NOTE: This variant is deprecated, it uses more space than the below
+ *	 __print_sym() which is identical to this for userspace.
  */
 		  __print_symbolic(__entry->bar,
 				   { 0, "zero" },
@@ -349,6 +379,21 @@ TRACE_EVENT(foo_bar,
 				   { 10, "TEN" }
 			  ),
 
+/*
+ *  __print_sym( variable, symbol_list_definition ),
+ *
+ *    The variable is tested against each value of the symbol list.
+ *    The symbol list can be built statically (sample_names_static) or
+ *    dynamically (sample_names_dynamic). If the variable matches one
+ *    of the values, then it will print the string in that pair. If
+ *    no entry matches, the number itself is printed (e.g. here if
+ *    if __entry->bar == 7 then "7" is shown).
+ *
+ *    See above for the declaration of sample_names_{static,dynamic}.
+ */
+		  __print_sym(__entry->bar, sample_names_static),
+		  __print_sym(__entry->bar, sample_names_dynamic),
+
 /*
  *  __print_flags( variable, "delim", { value, "flag" }, ... ),
  *
-- 
2.56.1

