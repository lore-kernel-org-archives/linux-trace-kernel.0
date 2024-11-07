Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346D41DBB37
	for <linux-trace-kernel@vger.kernel.org>; Thu,  7 Nov 2024 12:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730982415; cv=none; b=KcHOyoc4GAy1P4r3QLyM+AO9aKQrRhjsoeYLu7B4wbBGAhn8UDtj9UCwlfJb3w9erXDKriCrnc5FUQh+JS21NXYB9HvL38Y44b4i9qcbk+xjU4gYQ+YlHD7UC9YjUY2wG+OMkoWFfHAZarEFDwpVsmfMvFy1UqTyyrEICyJrKmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730982415; c=relaxed/simple;
	bh=A0VfKAleihx1EMEUoscIiv/CHmMns3Muxrz4zcDZXeU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=thRPhLMSCFJdqWRwfqEiCCSArhCVz+CIZ6ndbTIAea/16v+KxFO1RmtRTKMtKiE9ZKunqBW4bwocx1GvrCiRBiEnA2htMKuN7XEo0cmoAdKGulwG+6wQn1a3WWOkrbSpuWwlKssKK+6AtJyJKhdezJXWD43pS/Qv4chO6Pf1X0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B3U41K8h; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B3U41K8h"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ea8a5e83a3so17041007b3.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 07 Nov 2024 04:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730982413; x=1731587213; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CeVyxMRNAu4YKoFjlmD4iAHOUci1C9nw6Nm/olK2Dyk=;
        b=B3U41K8hfK+DdZtjcl6iemI8UNgy0cUd7I8PMyHB5UNqaplGEwiM+DhAp4iy2a4M8P
         Qtg++BSE/yzZHY85VycKWRNWFrXiTdh+EKwW1uQVvZnpO9N9pkMpDVZfQQUC59yULXdA
         M13p66P8sxCJyGGoA7Dfm7l+J+mSF6XCRhYkZgCsOBxTdnCOqOB1yA17QG6Unag3KSBR
         47djc2ZjfUu4gvVjF28r10HTPHOKElwrWxmgMTgGvAb9HjTdQ0emBpJSJQVbTAUJY1Ml
         o+GVfU9x7Pgf5AaCI+DVKrPhj7TZjUXERydHwH/kzc3F0ucTGDLKJ+vCOJRBkYkX4rEd
         MzAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730982413; x=1731587213;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CeVyxMRNAu4YKoFjlmD4iAHOUci1C9nw6Nm/olK2Dyk=;
        b=tm73dYH/qrvRzZnb/KU0WIQSqOJMj0lFuSgyCyRQ9NuDFmWmBbAy6Sw/ZoZHJeNhJ1
         OB2OJ99PLoLeWBfDQ2L1GpNbFPSZgq0Y4VYqwmcdiSP90GTjrhpNdA2dBo8BDiXI9rb0
         1bI33hf3ya14xZVtz5odgzL8ZMUJW/oLGtWdL0+BdGtc9b4otGQbwkd9AMcA4NniEnNl
         Gr/qYvuNmFoes/7/ybto1RPG2hPAZHH1ijtQ1aAw0I0eKPegodysAMcmdK4MFSfjQAdo
         n6E0VqHRU1MQAZk84SUUc05D2M7d/gjMHf+7x6yUQUsxCM527F3E4kV6X2mfomwhqdJ4
         U+YA==
X-Forwarded-Encrypted: i=1; AJvYcCW7WH8kmds2Q8ZHZ7IMtXNBPSIuHOP1e2RQUOl7RIpTg5fQGjsMqe4TjQsPF3PCNUU3hlSsoPdvbr9fDJjKuJTj4ZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIorEph/LhoyKpAFZgvcXcmRxOYuJTz1Le3Pi6VB6m0lg7dCPJ
	6ZNofahh/x0jTHA/C4REHj5pccEhHn66HT2h5elqMeuvywfh6QFApNWH2Z6rd2TaNWrGXONsww=
	=
X-Google-Smtp-Source: AGHT+IHAaCphbzYBfN2ZqsZ6KqEVUVWc73fWv9n5cAThWoTgGo/xdN93gLJ3pq7vr0POVvX6B9e4s+kBFg==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:8fd5:be93:a8c0:7566])
 (user=elver job=sendgmr) by 2002:a05:690c:2906:b0:6ea:4983:7cbd with SMTP id
 00721157ae682-6ead60d4cedmr11427b3.7.1730982413177; Thu, 07 Nov 2024 04:26:53
 -0800 (PST)
Date: Thu,  7 Nov 2024 13:25:47 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241107122648.2504368-1-elver@google.com>
Subject: [PATCH v2 1/2] tracing: Add task_prctl_unknown tracepoint
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

  test-484     [000] .....   631.748104: task_prctl_unknown: comm=test option=1234 arg2=101 arg3=102 arg4=103 arg5=104

Signed-off-by: Marco Elver <elver@google.com>
---
v2:
* Remove "pid" in trace output (suggested by Steven).
---
 include/trace/events/task.h | 41 +++++++++++++++++++++++++++++++++++++
 kernel/sys.c                |  3 +++
 2 files changed, 44 insertions(+)

diff --git a/include/trace/events/task.h b/include/trace/events/task.h
index 47b527464d1a..9202cb2524c4 100644
--- a/include/trace/events/task.h
+++ b/include/trace/events/task.h
@@ -56,6 +56,47 @@ TRACE_EVENT(task_rename,
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
+		__string(	comm,		task->comm	)
+		__field(	int,		option)
+		__field(	unsigned long,	arg2)
+		__field(	unsigned long,	arg3)
+		__field(	unsigned long,	arg4)
+		__field(	unsigned long,	arg5)
+	),
+
+	TP_fast_assign(
+		__assign_str(comm);
+		__entry->option = option;
+		__entry->arg2 = arg2;
+		__entry->arg3 = arg3;
+		__entry->arg4 = arg4;
+		__entry->arg5 = arg5;
+	),
+
+	TP_printk("comm=%s option=%d arg2=%ld arg3=%ld arg4=%ld arg5=%ld",
+		  __get_str(comm), __entry->option,
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
