Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E6838DF9;
	Sat, 12 Oct 2024 12:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728736904; cv=none; b=qD9J3347VwtMXBdmAHZgwxcYhD5GqXr1kd9GY8fdAFKfzeAExBjWUGqkyOcQavOxngiPsNl5+doSBYDozEJ60R/HPJawCY0RxAXQdwM5elIBri3T4NiXvTRTDSU6roXjHDLY+m1bAfwwAUE4dcm3AJwdBIz4HNbvLl6BLa6u8qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728736904; c=relaxed/simple;
	bh=bIfNOF6Jk/MXPc4iLJ77NvfIvrKcQSCzG5poXqD/Has=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y6h+x1ezgWE7dpjNfDWEzkOBINqPFAEDfV2kY6tepBwjZqyw6XfR5fTVtuQUOSNsLcuYpxFxpsG3CdxTS11Mv76l2uvV7kvKDgaP5IFtwoBDdOwh3pxb0GMyIOP4t9YJI+Xb32Mua2+YCaCVJdqB8KhDzkN0+Ux0IW9AM18FmdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I679Wmet; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I679Wmet"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-718e9c8bd83so2492867b3a.1;
        Sat, 12 Oct 2024 05:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728736901; x=1729341701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4FD2wGJZT6I9y7WNlt+/YB0Oal9xLTsrHNVQtFhZohE=;
        b=I679WmetpooS/ymmGvfy0lK10QzmCwF2UaYloMHc7A3+r0VVsPosi7Elrn0XCXCgdP
         KMAK3CLQleNRlpNjAY+TkWOi4CupIgn8EApug1URGkPeEPWbMkdhkqGsTCgEoFsS8/1K
         NF+agn1+QYO+uOvuYkaN3dZgFB5Gc3Ttpm62ndP0gUyI258XvFw6stdxXzvLG9gpcIK6
         +DC5IBKN0otl7MW97Dff219uFjMv1/feZ2WaQh1kopoau09+9wUhqnRXQiQhbwqWQxNN
         RJkH4wVVmF8F1iZ0fess5z75DhrC1ZEyeBwSUf73TDzfWFtrYSkvacCwVoSqzJVlClJQ
         +9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728736901; x=1729341701;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4FD2wGJZT6I9y7WNlt+/YB0Oal9xLTsrHNVQtFhZohE=;
        b=ahDRwFGHjzDGmn++9+NqoaQt0ZUOMRKquBxun93T7t/kFbK4397zlXEM1WZMbgo8XV
         vrOT+d9uHzjH4nhNoHgogdMe0YjO8fC5JBxXuJRBoDTuV5P511vMoaWv9lc96v9VE3UE
         leGLjlnJf3+wrP7V894bjAoQqM4UcP2Jidn6mrWz3EDg2pXx3Bi1n0xBsyW9uEPLI7Ry
         +7TKBP36BclPhTiF5laREX0bSXsK+xUDpWdoSqHB/whoaWyUARy3RDKsCil0W5A8Bwbc
         VmKtxMTuECcAMjmZIq46G+gWBkfWdk/UygRSh+UUW03xhiD5XLrlpw9iLrCOOINtVGGk
         EzfQ==
X-Forwarded-Encrypted: i=1; AJvYcCU63NRSzhaHsWyzL4qOxDY0xt6XAu7UgqeWzPTMnS0DNRyta71YARqwpsKUKcms/o2Z+wPWJH1HW/Ep1e/63+CM5DMd@vger.kernel.org, AJvYcCVEqaksqBDhQXxRsMGXqzEUEAe6c+3WZicAC8eKN1+uFxslmJBebUeHFx+hRX9+rkMRU7cE0PSQSCLbwts=@vger.kernel.org
X-Gm-Message-State: AOJu0YySpC6VXMWUAJI2zyoYTAwf+J9SmC4rGB9+oQx76oe3CMHw9fR6
	6MwHstA0bM0WqZgsdY78emZfY6SxY/L9trGL1VnLnttkAQ1jeN34
X-Google-Smtp-Source: AGHT+IHcM0JqqDd0asn12HnxhrTExL2cgKA2A+vtYxbib3UbJVwToHvWvJlto+y7b4bs9pZkigiXCA==
X-Received: by 2002:a05:6a20:f82:b0:1d8:d194:b11 with SMTP id adf61e73a8af0-1d8d1940b38mr522449637.2.1728736901392;
        Sat, 12 Oct 2024 05:41:41 -0700 (PDT)
Received: from localhost.localdomain ([240d:1a:13a:f00:4b94:68e0:2d8b:3983])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e4ad1b9f7sm1437423b3a.190.2024.10.12.05.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 05:41:41 -0700 (PDT)
From: Tatsuya S <tatsuya.s2862@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Tatsuya S <tatsuya.s2862@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2] ftrace: Fix function name for trampoline
Date: Sat, 12 Oct 2024 21:41:51 +0900
Message-ID: <20241012124152.2078-1-tatsuya.s2862@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The issue that unrelated function name is shown on stack trace like
following even though it should be trampoline code address is caused by
the creation of trampoline code in the area where .init.text section
of module was freed after module is loaded.

bash-1344    [002] .....    43.644608: <stack trace>
  => (MODULE INIT FUNCTION)
  => vfs_write
  => ksys_write
  => do_syscall_64
  => entry_SYSCALL_64_after_hwframe

To resolve this, when function address of stack trace entry is in
trampoline, output without looking up symbol name.

Signed-off-by: Tatsuya S <tatsuya.s2862@gmail.com>
---
V1 -> V2: Instead of checking trampoline when displaying "trace" results,
	  it stores trampoline when generating the stacktrace entry.

 kernel/trace/trace.c         | 24 ++++++++++++++++--------
 kernel/trace/trace_entries.h |  2 ++
 kernel/trace/trace_output.c  |  7 +++++++
 3 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 1c69ca1f1088..92a8e76a0cd7 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -988,7 +988,8 @@ static inline void trace_access_lock_init(void)
 #endif
 
 #ifdef CONFIG_STACKTRACE
-static void __ftrace_trace_stack(struct trace_buffer *buffer,
+static void __ftrace_trace_stack(struct trace_array *tr,
+				 struct trace_buffer *buffer,
 				 unsigned int trace_ctx,
 				 int skip, struct pt_regs *regs);
 static inline void ftrace_trace_stack(struct trace_array *tr,
@@ -997,7 +998,8 @@ static inline void ftrace_trace_stack(struct trace_array *tr,
 				      int skip, struct pt_regs *regs);
 
 #else
-static inline void __ftrace_trace_stack(struct trace_buffer *buffer,
+static inline void __ftrace_trace_stack(struct trace_array *tr,
+					struct trace_buffer *buffer,
 					unsigned int trace_ctx,
 					int skip, struct pt_regs *regs)
 {
@@ -2928,7 +2930,8 @@ struct ftrace_stacks {
 static DEFINE_PER_CPU(struct ftrace_stacks, ftrace_stacks);
 static DEFINE_PER_CPU(int, ftrace_stack_reserve);
 
-static void __ftrace_trace_stack(struct trace_buffer *buffer,
+static void __ftrace_trace_stack(struct trace_array *tr,
+				 struct trace_buffer *buffer,
 				 unsigned int trace_ctx,
 				 int skip, struct pt_regs *regs)
 {
@@ -2986,6 +2989,11 @@ static void __ftrace_trace_stack(struct trace_buffer *buffer,
 	memcpy(&entry->caller, fstack->calls,
 	       flex_array_size(entry, caller, nr_entries));
 
+#ifdef CONFIG_DYNAMIC_FTRACE
+	entry->trampoline = tr->ops ? tr->ops->trampoline : 0;
+	entry->trampoline_size = tr->ops ? tr->ops->trampoline_size : 0;
+#endif
+
 	if (!call_filter_check_discard(call, entry, buffer, event))
 		__buffer_unlock_commit(buffer, event);
 
@@ -3005,7 +3013,7 @@ static inline void ftrace_trace_stack(struct trace_array *tr,
 	if (!(tr->trace_flags & TRACE_ITER_STACKTRACE))
 		return;
 
-	__ftrace_trace_stack(buffer, trace_ctx, skip, regs);
+	__ftrace_trace_stack(tr, buffer, trace_ctx, skip, regs);
 }
 
 void __trace_stack(struct trace_array *tr, unsigned int trace_ctx,
@@ -3014,7 +3022,7 @@ void __trace_stack(struct trace_array *tr, unsigned int trace_ctx,
 	struct trace_buffer *buffer = tr->array_buffer.buffer;
 
 	if (rcu_is_watching()) {
-		__ftrace_trace_stack(buffer, trace_ctx, skip, NULL);
+		__ftrace_trace_stack(tr, buffer, trace_ctx, skip, NULL);
 		return;
 	}
 
@@ -3031,7 +3039,7 @@ void __trace_stack(struct trace_array *tr, unsigned int trace_ctx,
 		return;
 
 	ct_irq_enter_irqson();
-	__ftrace_trace_stack(buffer, trace_ctx, skip, NULL);
+	__ftrace_trace_stack(tr, buffer, trace_ctx, skip, NULL);
 	ct_irq_exit_irqson();
 }
 
@@ -3048,8 +3056,8 @@ void trace_dump_stack(int skip)
 	/* Skip 1 to skip this function. */
 	skip++;
 #endif
-	__ftrace_trace_stack(printk_trace->array_buffer.buffer,
-			     tracing_gen_ctx(), skip, NULL);
+	__ftrace_trace_stack(printk_trace, printk_trace->array_buffer.buffer,
+				tracing_gen_ctx(), skip, NULL);
 }
 EXPORT_SYMBOL_GPL(trace_dump_stack);
 
diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
index c47422b20908..81b84241e3b3 100644
--- a/kernel/trace/trace_entries.h
+++ b/kernel/trace/trace_entries.h
@@ -190,6 +190,8 @@ FTRACE_ENTRY(kernel_stack, stack_entry,
 
 	F_STRUCT(
 		__field(	int,		size	)
+		__field(	unsigned long,	trampoline	)
+		__field(	unsigned long,	trampoline_size	)
 		__stack_array(	unsigned long,	caller,	FTRACE_STACK_ENTRIES, size)
 	),
 
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 868f2f912f28..fbd066e9c9fa 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -1246,6 +1246,13 @@ static enum print_line_t trace_stack_print(struct trace_iterator *iter,
 			break;
 
 		trace_seq_puts(s, " => ");
+		if (field->trampoline && field->trampoline_size &&
+			(*p) + delta >= field->trampoline &&
+			(*p) + delta < field->trampoline + field->trampoline_size) {
+			trace_seq_printf(s, "0x%08lx", (*p) + delta);
+			trace_seq_puts(s, " [FTRACE TRAMPOLINE]\n");
+			continue;
+		}
 		seq_print_ip_sym(s, (*p) + delta, flags);
 		trace_seq_putc(s, '\n');
 	}
-- 
2.46.2

