Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A06E1D79B7
	for <linux-trace-kernel@vger.kernel.org>; Tue,  5 Nov 2024 13:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730813789; cv=none; b=ns0yvT9kypl4fD+ALjP/w6F64VRgpBumL3BCxRrqsRqZHqn7mnXEHqtiUD2VZlUPf6f/cxlg1G7AguzlsFLprkbyC43zM9O06QOnmsgVwvspzKBHPxO/rMhPS0fYH0I4jWbUXH2L9LKDXIDwQ1u/99sU4geveEe0Lqc7WWn5rIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730813789; c=relaxed/simple;
	bh=3HF8W615YIQH27qpi/MuRMrPrtTX8FxvK/iubXHz8WI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=A5CoXMnQVpHNoKcmsQCqnLsAa7QD32i9CcoA28t8iNDbKMOhORn2DdDpVl0yIjZnlo4BtMvwtkdijoTr5jI83K12lEWwg4e0KHrctXTOm4PNWztef+MIjQC97Nhd/mf21SHZLr8l1ssmkUEIGMbrUqEaOMSovlOu343xYluh4Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z2IbX7vt; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z2IbX7vt"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-37d609ef9f7so2832043f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 05 Nov 2024 05:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730813784; x=1731418584; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Q96ispV8rCEDjpMmWoKujMwIU41P/PM6SRfoGhF4WFA=;
        b=z2IbX7vtm4+qgqglCbxGd0NCjWPuRKqGs8NdwMnidVe60/EgHfdqWBaolEVWXEgove
         IkyakTV0yNVBJ2eQo1Rz8kQVp6dxtsvBcOE7zj6YFAXjPCq4Y/qmv4KjFiWvEBA27kiN
         0/DvfvItzFKqrtAlhBYeMfeogFfgbdRkqfwN0SqO5R7bfxqd8l+SzIaRzsegSUm/0A0O
         jgN75z8fGbAei/lk2VSlQhx+d9YDZ3Rq391K6OQd84QY7v4PqABUaL85pYN/utWvD0hJ
         EOx2ZNxHw7j9k4JLwB7TOfKHo4R3uXIvM98C+Fya5NpU4J9y1v5kNjcO2+d9C4KoKEfY
         42Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730813784; x=1731418584;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q96ispV8rCEDjpMmWoKujMwIU41P/PM6SRfoGhF4WFA=;
        b=HpymMP33fn4DTFawX+XC//1dDsAWFeq4jbVhot9TBXMMAm6vX82ois1hWE29V5aFkF
         n0enw/N+sQVufyyO6JHs26lahq22qAvGwiX4gjrlbbjmZXanphrGiM+kxDssRVsxY+RW
         sMNFBW7YKIhff213F61QaLuRap7sG4lXGHvQDPHj+55FV3b1F0LrBf0r/EHItlM/R4NH
         swLwiWowUFQTGNP3aqRAEdcmN6NfeELsP80SXWO/QpsQJm5jakb25Onxna0L6EIDpBhe
         RwF99ozMd7Tc27KA+0z/yBU5gZQeTXrdLSmYmMj41eXiFmCNeFz9CDhGQSRMcUQuKk8l
         d2uA==
X-Forwarded-Encrypted: i=1; AJvYcCVIGcrbnXYBpZHQlhBinm/3013wC017tF2FFXTeftZuqGg0M9KzV3nUWbg+I8k4zh/C0Id1MbM6df72nQVs1iWdpJU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8MFJ5Tkf0T4RajkEL9B1q9FHBHFfVO6xkWVegjc/53TzMJ6ev
	mWvt4wNCC4ykRJ7ugoUS4OE59pDSJNRuSPrL18SZSoSF+3jnZsr7HO40Gwz1adFLL0uoeYGtMg=
	=
X-Google-Smtp-Source: AGHT+IHeIx1mRV757t8a9+XUCffxyz1khi103kOYCrCUejQ36UPQ7ByMyuZygUVd+7ExhKpgJ9DVX6eqbQ==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:3bed:38bc:b99e:8acb])
 (user=elver job=sendgmr) by 2002:adf:f00b:0:b0:374:cc7a:d8e0 with SMTP id
 ffacd0b85a97d-381be7d0165mr8626f8f.7.1730813784559; Tue, 05 Nov 2024 05:36:24
 -0800 (PST)
Date: Tue,  5 Nov 2024 14:34:05 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241105133610.1937089-1-elver@google.com>
Subject: [PATCH] tracing: Add task_prctl_unknown tracepoint
From: Marco Elver <elver@google.com>
To: elver@google.com, Steven Rostedt <rostedt@goodmis.org>, 
	Kees Cook <keescook@chromium.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

prctl() is a complex syscall which multiplexes its functionality based
on a large set of PR_* options. Currently we count 64 such options. The
return value of unknown options is -EINVAL, and doesn't distinguish from
known options that were passed invalid args that also return -EINVAL.

To understand if programs are attempting to use prctl() options not yet
available on the running kernel, provide the task_prctl_unknown
tracepoint.

Note, this tracepoint is in an unlikely cold path, and would therefore
be suitable for continuous monitoring (e.g. via perf_event_open).

While the above is likely the simplest usecase, additionally this
tracepoint can help unlock some testing scenarios (where probing
sys_enter or sys_exit causes undesirable performance overheads):

  a. unprivileged triggering of a test module: test modules may register a
     probe to be called back on task_prctl_unknown, and pick a very large
     unknown prctl() option upon which they perform a test function for an
     unprivileged user;

  b. unprivileged triggering of an eBPF program function: similar
     as idea (a).

Example trace_pipe output:

  <...>-366     [004] .....   146.439400: task_prctl_unknown: pid=366 comm=a.out option=1234 arg2=101 arg3=102 arg4=103 arg5=104

Signed-off-by: Marco Elver <elver@google.com>
---
 include/trace/events/task.h | 43 +++++++++++++++++++++++++++++++++++++
 kernel/sys.c                |  3 +++
 2 files changed, 46 insertions(+)

diff --git a/include/trace/events/task.h b/include/trace/events/task.h
index 47b527464d1a..ab711e581094 100644
--- a/include/trace/events/task.h
+++ b/include/trace/events/task.h
@@ -56,6 +56,49 @@ TRACE_EVENT(task_rename,
 		__entry->newcomm, __entry->oom_score_adj)
 );
 
+/**
+ * task_prctl_unknown - called on unknown prctl() option
+ * @task:	pointer to the current task
+ * @option:	option passed
+ * @arg2:	arg2 passed
+ * @arg3:	arg3 passed
+ * @arg4:	arg4 passed
+ * @arg5:	arg5 passed
+ *
+ * Called on an unknown prctl() option.
+ */
+TRACE_EVENT(task_prctl_unknown,
+
+	TP_PROTO(struct task_struct *task, int option, unsigned long arg2, unsigned long arg3,
+		 unsigned long arg4, unsigned long arg5),
+
+	TP_ARGS(task, option, arg2, arg3, arg4, arg5),
+
+	TP_STRUCT__entry(
+		__field(	pid_t,		pid		)
+		__string(	comm,		task->comm	)
+		__field(	int,		option)
+		__field(	unsigned long,	arg2)
+		__field(	unsigned long,	arg3)
+		__field(	unsigned long,	arg4)
+		__field(	unsigned long,	arg5)
+	),
+
+	TP_fast_assign(
+		__entry->pid = task->pid;
+		__assign_str(comm);
+		__entry->option = option;
+		__entry->arg2 = arg2;
+		__entry->arg3 = arg3;
+		__entry->arg4 = arg4;
+		__entry->arg5 = arg5;
+	),
+
+	TP_printk("pid=%d comm=%s option=%d arg2=%ld arg3=%ld arg4=%ld arg5=%ld",
+		  __entry->pid, __get_str(comm), __entry->option,
+		  __entry->arg2, __entry->arg3, __entry->arg4, __entry->arg5)
+);
+
 #endif
 
 /* This part must be outside protection */
diff --git a/kernel/sys.c b/kernel/sys.c
index 4da31f28fda8..dd0a71b68558 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -75,6 +75,8 @@
 #include <asm/io.h>
 #include <asm/unistd.h>
 
+#include <trace/events/task.h>
+
 #include "uid16.h"
 
 #ifndef SET_UNALIGN_CTL
@@ -2785,6 +2787,7 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 		error = RISCV_SET_ICACHE_FLUSH_CTX(arg2, arg3);
 		break;
 	default:
+		trace_task_prctl_unknown(me, option, arg2, arg3, arg4, arg5);
 		error = -EINVAL;
 		break;
 	}
-- 
2.47.0.199.ga7371fff76-goog

