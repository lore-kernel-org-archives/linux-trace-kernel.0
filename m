Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9337317DE36;
	Sat, 19 Oct 2024 11:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729339187; cv=none; b=TRfyCB84WO7M6GrEvGES+oFMl11lVfdHmsTnULZntVkVfoSc99aWHUDd9TA8e9PkIgoHYqcc3ZTpMLTtSQZL4ksXCxnnbbLXeEsMOufC9sNl4zsLNEXlJu+ClfO6QJQJWFHAmFkNxnLzUEUUP2cJczYntZH3ynxT+oJQ18TUGMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729339187; c=relaxed/simple;
	bh=kkyrt41Z1CvU5Bb1mYCcD6NSrHvazapNrDER2Tg4+Hc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M6vDddv+SrLHeRNCG1IqZO4DKRB+6PTOrjmNr229h8DCUSgztwXjRsOEuUMc20TmWHga1l9vJ+uE8WEbFOVPiPf4FleRp2elX/obsldVChJ6x4EW9hOYeEPbKN8DUgOI300xGYduIYRQKfYPU/Bf1qEyZeUBvzGheDJH6t2Fvfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=myHywFQ6; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="myHywFQ6"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-71e52582d0bso2329275b3a.3;
        Sat, 19 Oct 2024 04:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729339185; x=1729943985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vHDe0ZEF5teIlXaSR89YAcCY8GV9GVeUfzlRToF0CLY=;
        b=myHywFQ6cSEwzo10m7QpGvMWLwLHKMA/sR7VWABot0DxZNHGvslaPm4NzowPf0GV5z
         eMbTInr6NGNTQQ6u1QyhOiXw7fsDp5Qu7pQyZCwmFgLeQ/1lUehrllCdLaSxHz8A0Ry8
         jgzJKSuqICtv/hhtTnFjES0PhxQb32xDmG0xgH+CtXBfCy1LegphNhW5VpzAdgFUJVuv
         mRCdLdfCVsJ0wfgKULRgUoMYfDtCtW8sSefTSgy0qJq1H2riKJF9ZY/v7kpZvIdXjjcN
         rxMJWPbimEPVL9MjWRA1jf7eAZPrGBuGcbCgDYXKCmanz/xsuWhUYOa29J9VQtsR0H68
         yMHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729339185; x=1729943985;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vHDe0ZEF5teIlXaSR89YAcCY8GV9GVeUfzlRToF0CLY=;
        b=Zm/LEFQHfIUuaNntO5R7TygKP6K0EkNFIWoQOxvCR1ND1+XZc27Z+ox9ww3StzFqAs
         sTyjoKGjKrvrDiVOXHf01TmeX0LAToHjGeJ3T/3O5/5motSIiqKkL2AgLkvQukKtrpnE
         srAPg8PpCg9uXdYFLX8CglHnnDJfEfpIPjM/rkQ0yFrjZBUAMuCjwhqyhUFiu0TH4Ntg
         YNY0lN+goCAWDoXaM6zATHxZF2PLe690va+82PBPqZ0rDRlbRmcjafcm5nKEDqNCYygQ
         dekLk7nZoxfhG+ZZtNr4Dl1AAC5Z7PKWDHKxeFPtDntYh649MvOl9hlY/coYji02oiL/
         NMqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUo3hSqsTRoSBeEftyH2UdeD0QrauldGMH1o9NuJ7p1Fe8G3taJ+PC3fVj60mUK1WFwYFtXcdpr25PP4z/MociMY15L@vger.kernel.org, AJvYcCXF5kKj/9EZp6Prt+snoEUfJne2ptvqewgOMjLw14gFydqke1UMle2D5TR1GDg9TNKiMmeKxUev8WuT68U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE2nH5DneinAUAEzya1I37trJmyj26RgaoTiA5E6MXFRYW2K/s
	dcwg5auOTCRapmjmSBFLafXW3i1hGM8I56qOGrYgJKG08sVa6INYWxsF1iRx
X-Google-Smtp-Source: AGHT+IH3WBgXQLXKxaZKZnjUU3QG0iqwkfcO1mUGhoH4zqEFHM7ThlEpywXt0Pzg708zmA7/4XTq2w==
X-Received: by 2002:a05:6a00:847:b0:71d:eb7d:20e4 with SMTP id d2e1a72fcca58-71ea31dcfbfmr7807565b3a.8.1729339184574;
        Sat, 19 Oct 2024 04:59:44 -0700 (PDT)
Received: from localhost.localdomain ([240d:1a:13a:f00:56be:6d28:be7e:522d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ea33511f4sm2938083b3a.88.2024.10.19.04.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2024 04:59:43 -0700 (PDT)
From: Tatsuya S <tatsuya.s2862@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Tatsuya S <tatsuya.s2862@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3] ftrace: Fix function name for trampoline
Date: Sat, 19 Oct 2024 11:57:48 +0000
Message-ID: <20241019115749.9499-2-tatsuya.s2862@gmail.com>
X-Mailer: git-send-email 2.47.0
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
V2 -> V3: Instead of saving the trampoline address, marker was introduced.
V1 -> V2: Instead of checking trampoline when displaying "trace" results,
	  it stores trampoline when generating the stacktrace entry.

 include/linux/ftrace.h      |  7 +++++++
 kernel/trace/trace.c        | 33 +++++++++++++++++++++++++--------
 kernel/trace/trace_output.c |  4 ++++
 3 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index fd5e84d0ec47..39a32fd7b116 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -1188,4 +1188,11 @@ unsigned long arch_syscall_addr(int nr);
 
 #endif /* CONFIG_FTRACE_SYSCALLS */
 
+/*
+ * This is used only to distinguish
+ * function address from trampoline code.
+ * So this value has no meaning.
+ */
+#define FTRACE_TRAMPOLINE_MARKER  ((unsigned long) INT_MAX)
+
 #endif /* _LINUX_FTRACE_H */
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 1c69ca1f1088..60d156c34e43 100644
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
@@ -2975,6 +2978,20 @@ static void __ftrace_trace_stack(struct trace_buffer *buffer,
 		nr_entries = stack_trace_save(fstack->calls, size, skip);
 	}
 
+#ifdef CONFIG_DYNAMIC_FTRACE
+	/* Mark entry of stack trace as trampoline code */
+	if (tr->ops && tr->ops->trampoline) {
+		unsigned long tramp_start = tr->ops->trampoline;
+		unsigned long tramp_end = tramp_start + tr->ops->trampoline_size;
+		unsigned long *calls = fstack->calls;
+
+		for (int i = 0; i < nr_entries; i++) {
+			if (calls[i] >= tramp_start && calls[i] < tramp_end)
+				calls[i] = FTRACE_TRAMPOLINE_MARKER;
+		}
+	}
+#endif
+
 	event = __trace_buffer_lock_reserve(buffer, TRACE_STACK,
 				    struct_size(entry, caller, nr_entries),
 				    trace_ctx);
@@ -3005,7 +3022,7 @@ static inline void ftrace_trace_stack(struct trace_array *tr,
 	if (!(tr->trace_flags & TRACE_ITER_STACKTRACE))
 		return;
 
-	__ftrace_trace_stack(buffer, trace_ctx, skip, regs);
+	__ftrace_trace_stack(tr, buffer, trace_ctx, skip, regs);
 }
 
 void __trace_stack(struct trace_array *tr, unsigned int trace_ctx,
@@ -3014,7 +3031,7 @@ void __trace_stack(struct trace_array *tr, unsigned int trace_ctx,
 	struct trace_buffer *buffer = tr->array_buffer.buffer;
 
 	if (rcu_is_watching()) {
-		__ftrace_trace_stack(buffer, trace_ctx, skip, NULL);
+		__ftrace_trace_stack(tr, buffer, trace_ctx, skip, NULL);
 		return;
 	}
 
@@ -3031,7 +3048,7 @@ void __trace_stack(struct trace_array *tr, unsigned int trace_ctx,
 		return;
 
 	ct_irq_enter_irqson();
-	__ftrace_trace_stack(buffer, trace_ctx, skip, NULL);
+	__ftrace_trace_stack(tr, buffer, trace_ctx, skip, NULL);
 	ct_irq_exit_irqson();
 }
 
@@ -3048,8 +3065,8 @@ void trace_dump_stack(int skip)
 	/* Skip 1 to skip this function. */
 	skip++;
 #endif
-	__ftrace_trace_stack(printk_trace->array_buffer.buffer,
-			     tracing_gen_ctx(), skip, NULL);
+	__ftrace_trace_stack(printk_trace, printk_trace->array_buffer.buffer,
+				tracing_gen_ctx(), skip, NULL);
 }
 EXPORT_SYMBOL_GPL(trace_dump_stack);
 
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 868f2f912f28..c14573e5a903 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -1246,6 +1246,10 @@ static enum print_line_t trace_stack_print(struct trace_iterator *iter,
 			break;
 
 		trace_seq_puts(s, " => ");
+		if ((*p) == FTRACE_TRAMPOLINE_MARKER) {
+			trace_seq_puts(s, "[FTRACE TRAMPOLINE]\n");
+			continue;
+		}
 		seq_print_ip_sym(s, (*p) + delta, flags);
 		trace_seq_putc(s, '\n');
 	}
-- 
2.47.0

