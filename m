Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F65C193418;
	Mon, 21 Oct 2024 07:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729494963; cv=none; b=TtQkl/eGit+45+dNloLAjrXoecTzyNNvyNu/jw7mzc5L71kHs99p5LdhaaFwxgA/WDT6SHvuni7DSA7BWcfRGNIefYehoUfluV2x1ee0eDDjZEQ/AQrlCzZmFZyzYuDUTY0VE4JxycsGEVEiUnzERUMdga8+UnyfB+dzqB2CDuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729494963; c=relaxed/simple;
	bh=stmi8jNPm+XSpfCOyseBZ1GAQeQm/1gSsdudIfusCVs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XXNs/n40zxImOqhhYwRSv7E3w5/9JVVCCt0qG2rHvxAOzjj+5mudrYO26C6ZaGGPP+Ytbf5D6XBH2R+GixIn+NhrlXdVtzhhxKPiW8OlfDSJCsZa0Ee0KxmVhk65IWhWmlgcraEN3pcrhU0qXLWBSqWWDRwrJdD4A4w+0NtBzzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cXzoQUyA; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXzoQUyA"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20c8b557f91so41421445ad.2;
        Mon, 21 Oct 2024 00:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729494961; x=1730099761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=05HpxlcvEDSLHnaT2VzQ3T5z3IDIHapxjdfQdH0wXWM=;
        b=cXzoQUyAivCmrOefo2Ek6Ycr9tA9qEk55D/73in8+on3uX3onLfdc5D4ztVcTX+RIS
         SceLIba14zOOQspUv/fGHpKj1kPnEqwzsxxVzdYHbuPwNBONQbrYqzMRSPq+UX9YPh7k
         h7vAI9J9BN7kpJ3Ilezro5uAl0aKaBKoB7bQR0+6B0EG5dQjDg3HOoRlqGczH9ZGzZxa
         gky8CJZEP7gcdr6tMYfPrJfQ8AzPdaektBDPVI4szQjxYHrJPDm1aAfKmwOmKuPczaSc
         241QeMEmVg2KLUuviIaox7gqgzzH0N3e5APh7rTo/g4pOKY0fdmNR7/JguVgzkuoWBKZ
         ckiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729494961; x=1730099761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=05HpxlcvEDSLHnaT2VzQ3T5z3IDIHapxjdfQdH0wXWM=;
        b=NQU8iHhWg13AFK3iNRVKHkNIf1P6TF51mJs9MUtVR1vLtJ7oX8fq87bYSojy0eVoY0
         TAoXy6G8NlQp1DRZGmPG9wqwky7On3WFghcewOTNOs+oL/TGWojy0/fde6bCDyBwxB0D
         6R9f1D7hdP5g87Tn5pAftlZxzUSDIGyAjjWBL70aufVXPOLpP1ErdWRlLyUQYzEMpPuf
         El8Not0rnGnWfaCqNcpZ+BZdfvumfZd/IkXOnUMgAg5NlmBR4ngNpGbQa0W2ppefmepO
         vWUipcAqXudUxyksR5hQaVcnjpKKyH2t+lXPqRlzT3SkLMipIN21DEwXMBF57U/N+nZt
         95sg==
X-Forwarded-Encrypted: i=1; AJvYcCUuBI+UG5Ul4UQw+KlcPBln1mYFpE9kUfbQRIC4HTunozBON/wVmnN/cptK/whNmI29MjUp71vgO/4g/LyPqfDbNvH/@vger.kernel.org, AJvYcCXaomVoyzfOlkXPmasjBuDeMS4Dps0g6p8cdnnrVXPHKcLkLWIhYgM78d+R1tpNqhl6K8bvCQAsTQD9flY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFELzWJSFm/xpribR5wSJSkN47igUBM280OJciIyIqmKsWYx79
	Y41Wume1TA8LD0rAKpRS2JELZYsr6pa/8TrmRUKgHN6h/EibgMjK
X-Google-Smtp-Source: AGHT+IHQ6d23cgASsji3tJL0vdjnxisyG0rD0fKe2yjezrz/zLFxRHCByh95SmRmJGuE+/5NRp8jIg==
X-Received: by 2002:a17:903:2307:b0:20c:f3cf:50e6 with SMTP id d9443c01a7336-20e5a8ee77bmr157351215ad.38.1729494960747;
        Mon, 21 Oct 2024 00:16:00 -0700 (PDT)
Received: from localhost.localdomain ([240d:1a:13a:f00:56be:6d28:be7e:522d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0f363esm19579395ad.269.2024.10.21.00.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 00:15:58 -0700 (PDT)
From: Tatsuya S <tatsuya.s2862@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Tatsuya S <tatsuya.s2862@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v4] tracing: Fix function name for trampoline
Date: Mon, 21 Oct 2024 07:14:53 +0000
Message-ID: <20241021071454.34610-2-tatsuya.s2862@gmail.com>
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
V3 -> V4: Change header file to define FTRACE_TRAMPOLINE_MARKER.
	  Rename category name of commit message.
V2 -> V3: Instead of saving the trampoline address, marker was introduced.
V1 -> V2: Instead of checking trampoline when displaying "trace" results,
	  it stores trampoline when generating the stacktrace entry.

 kernel/trace/trace.c        | 33 +++++++++++++++++++++++++--------
 kernel/trace/trace.h        |  7 +++++++
 kernel/trace/trace_output.c |  4 ++++
 3 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index a8f52b6527ca..3d86937da610 100644
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
 
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index c866991b9c78..30d6675c78cf 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -2176,4 +2176,11 @@ static inline int rv_init_interface(void)
 }
 #endif
 
+/*
+ * This is used only to distinguish
+ * function address from trampoline code.
+ * So this value has no meaning.
+ */
+#define FTRACE_TRAMPOLINE_MARKER  ((unsigned long) INT_MAX)
+
 #endif /* _LINUX_KERNEL_TRACE_H */
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

