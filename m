Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D92A20F5DE
	for <linux-trace-kernel@vger.kernel.org>; Thu,  7 Nov 2024 12:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730982419; cv=none; b=aYmcZfqWsaCDLWNixb5vWLjjjRXYCV+HQRwAJ3+9mua0XGBUN+yobQhDM1g6jw66UKtT+2g1p4BxkM1puxQidlrs16V3+AUx0KPCv/EcS1TeZlt9cfWS+Kld414HYazQmjImcNgPpr2nsDm/KXnNLaGOM1YNoU3Z16G/PADgPYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730982419; c=relaxed/simple;
	bh=fz8dEln5hGrZlPDA3uJ4PthK2vgrx3tU9QXgcl4xOeY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rhu0S/O9pNK/01XBw+sK3YRJRn+TOuzFGkV7Sd5ijTO0bfcpLqFce+Mzn4hF2PxZ2BAdu7hhOauV6Ml6qX7PNMMFSe1LR2sab2FDCpdwePGZBgTJ4spZDZOp9aq8PD97mzjnwRt69UnHdk2bRp1L4p0aYVp5/lL2Wp8LIiE8uqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oJ0G+TQ9; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oJ0G+TQ9"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-a9a2a81ab82so71477766b.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 07 Nov 2024 04:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730982416; x=1731587216; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9sHGNL7Z8k+ba9HHh8eNNDPID0xL9oZVgVqMixfCZM0=;
        b=oJ0G+TQ9K4x7brHqsIraiP35+bTCcwymfTTmuSIP5VDQ51wVVUNeThWK4O9xG71ZDT
         PnQm8Vvo/x4n/X1kXnFwX1F4HOTWCC28RLhMgNcdUDfZzUL1GgR6dHRbbi32JVNo+yi9
         FKcZywqaeG8KujSzx5mKc97n6O20nzUY8lz5sBrSZogaR9HeCS25VgjJTFbdPqqn9mul
         K39DgOlbK7qytS2FzodxCcS+ySuFcjkMnALRk1vmell0o5ejo9sDuFq0E30D7PyQqtO6
         Qqf1hmcy4UxKLFZFDxj9T9pk6Oz3GBGWho1BqzjXITf4FISsQcIo9NeWyVehvwJnPTUk
         vdUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730982416; x=1731587216;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9sHGNL7Z8k+ba9HHh8eNNDPID0xL9oZVgVqMixfCZM0=;
        b=n3cH89YEgsZWDpol4lw7tqbqf49uORcb63RpJOsLEewCY53vKJ4t4od5rH23FGXleE
         FX6abGlpYZ+MjnEFI7GbY4cAVzIy894ZmqzFEHXGx3S7PEu1N4JP1x5/iPv3WZgR4ilR
         KppJWPultCy8U9v92Z6VKOraUtTrYFgu9t/XmJB2HiRJQh2qt9xrLBccTup17Ze27FsE
         KwOJCt9EAnn3BDCH5MtNtURm8RYimuogCSR1fxunlLOhtQ9KgegAQrPWDuhQenpl5fuc
         JDWK9fYsbgJVw+YKgWp8Kke2VzhuaXuqEhm4mj+aJhW00thC/azpzMmuRS9LwXgahuW2
         eu9w==
X-Forwarded-Encrypted: i=1; AJvYcCVHBaGMjxJDG9vLd9vj4X0P4zZgd545z0IhmEP5fPgz5LuyeadBbrIKdodK7sdBeSNwMdhBrS61pPmAmdjZ1fWLTqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFYNBHtLOsQHfGrfPE2ddK9/w+yNxJyeugQOsjjseo3TgQJAZw
	IPEwzd830cV0JqqQP61S/W2F3pXhsZPCOEDbTzT3DUmeIa3AyzljN4oBmu8bQhXrFuy2tpqTBg=
	=
X-Google-Smtp-Source: AGHT+IF8rH2dVdPY8X0OhEakGQROrqaJ/kgTLUoX5KRP32vaRlqnDo/+DlfBy71KkMigf9oHS00q79hezg==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:8fd5:be93:a8c0:7566])
 (user=elver job=sendgmr) by 2002:a17:906:d108:b0:a9a:1209:c4d with SMTP id
 a640c23a62f3a-a9de6007a5emr1152566b.9.1730982416079; Thu, 07 Nov 2024
 04:26:56 -0800 (PST)
Date: Thu,  7 Nov 2024 13:25:48 +0100
In-Reply-To: <20241107122648.2504368-1-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241107122648.2504368-1-elver@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241107122648.2504368-2-elver@google.com>
Subject: [PATCH v2 2/2] tracing: Remove pid in task_rename tracing output
From: Marco Elver <elver@google.com>
To: elver@google.com, Steven Rostedt <rostedt@goodmis.org>, 
	Kees Cook <keescook@chromium.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Remove pid in task_rename tracepoint output, since that tracepoint only
deals with the current task, and is printed by default. This also saves
some space in the entry and avoids wasted padding.

Link: https://lkml.kernel.org/r/20241105120247.596a0dc9@gandalf.local.home
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Marco Elver <elver@google.com>
---
v2:
* New patch
---
 include/trace/events/task.h | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/trace/events/task.h b/include/trace/events/task.h
index 9202cb2524c4..ee202aafa9fd 100644
--- a/include/trace/events/task.h
+++ b/include/trace/events/task.h
@@ -38,22 +38,19 @@ TRACE_EVENT(task_rename,
 	TP_ARGS(task, comm),
 
 	TP_STRUCT__entry(
-		__field(	pid_t,	pid)
 		__array(	char, oldcomm,  TASK_COMM_LEN)
 		__array(	char, newcomm,  TASK_COMM_LEN)
 		__field(	short,	oom_score_adj)
 	),
 
 	TP_fast_assign(
-		__entry->pid = task->pid;
 		memcpy(entry->oldcomm, task->comm, TASK_COMM_LEN);
 		strscpy(entry->newcomm, comm, TASK_COMM_LEN);
 		__entry->oom_score_adj = task->signal->oom_score_adj;
 	),
 
-	TP_printk("pid=%d oldcomm=%s newcomm=%s oom_score_adj=%hd",
-		__entry->pid, __entry->oldcomm,
-		__entry->newcomm, __entry->oom_score_adj)
+	TP_printk("oldcomm=%s newcomm=%s oom_score_adj=%hd",
+		  __entry->oldcomm, __entry->newcomm, __entry->oom_score_adj)
 );
 
 /**
-- 
2.47.0.199.ga7371fff76-goog
