Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5B71E47C4
	for <linux-trace-kernel@vger.kernel.org>; Fri,  8 Nov 2024 11:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731065710; cv=none; b=kp0FzTUl4VjKsccL9GgEZTMyKcML2Fm2ZBHVatIlVJQYOu+LMIyKXqmrLMXPdKmKJ1fVrJLO3lJw5b9aeHsB47ejunYQC8tGVxWedZfg5W4NDwzQXa9s1qIk/T6uABdknfJXuxPsuDs0vgScALZPc9xsKRU1Fg6GMED5cfdAX/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731065710; c=relaxed/simple;
	bh=hEHya/EWTyjGrJkb2WFQ/xz8flII2H8gY8bYE4SYXJc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=trr8rw0jISIOznGbRSkUzDL4NA0Lo2JpCDfm+hS/t5qiIJBfiM1jUTro+YedZTp5tyRvWypLfkeO/VGKcCltXw6yPvmnYlTI/qXUwTHhEUzeoItRUgZXQf//T+7klp0dy4vD4A8QvzIAEXomXnpNbjC55JDbC+xmMMalCDB1rpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fcpF/lF/; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fcpF/lF/"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-a9a004bfc1cso151814666b.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 08 Nov 2024 03:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731065707; x=1731670507; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WmVAOqvZ/Tu1S1PwD7c/mNbANvvbo6/nc3HYAPUr/Js=;
        b=fcpF/lF/VD2YmfRPWkre+ZbqYng2N6TmHsRh79VKcKAvNoBX4bhXTFjiZRjEeMa/HV
         eRjE7dMJTT8mG3hWHX4OnDjKTl4rFOqob5nV1NLKO2SJFgXNw9XzbW+afASmMDpnZx+5
         XVNYp74WsG57RcYJWjEPkINX80BBTZdmkRRWquibZ7xM3NSA6/qouLGHW4yiSACFMF1y
         WYdXPDI7dpTqrppTOjrwPfVJF7qOD0A4wOqNL6sCxf71fpLgV7i1b/AMRMk+17gttAs7
         GHavfKCsyq/c6k1UqjyuWYFLHiTB46W3JhjSdLXZTDQnIuKO4oAHcOqfh9Pbo+VUcezL
         PvMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731065707; x=1731670507;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WmVAOqvZ/Tu1S1PwD7c/mNbANvvbo6/nc3HYAPUr/Js=;
        b=YFdE1dSCSJkRXS9lpLdEWSuTGH70n2J+wblaiFrboUEyO19KUfdR5POfLs6gIJQVMk
         V+Bw1pVu0yaSRxoB762pfoILPS82aUSU9e1lt6Wa4mouBa5/cGTAL27qphdE/e0XR/ss
         zg/ixXwvABe3ychDVU4r3EU6A5e3zECgna/FVKoNS94O/cMlUfCFvTS1YCL98AHz0hzz
         NLdTKp0gtNk79wemiVqWtVug1Jfhg1ue4d1AxICXAYLZ1yeR+oXAEikhNop4JIRMt8QC
         wUwJt/z7gbWFdU68m7O1Mh/MnVV/oyfN0Xv43tVqdU/fBPjR/zzVbQvvkaQS4TtAtbmS
         pqpw==
X-Forwarded-Encrypted: i=1; AJvYcCW+RSHx2SajuhS/+YFWo6iqzX9nXsyfo9wKE9YUQGR3VUnSOohlYVF2VdlZ7kNPOKusADkFMiXDaRHH7VyTpnK9Ssc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoLsaUiQ15u7M0/nJqWcR9kHtYRZYqoCcsfDd0+O+ROQ/cjhyq
	iX5jt4hKIZKdqbIRUd+sOJYkG5AJEtKdh2+GiyDNw0ZAYobz+bqXAousfNOwOdMwraXlAnD+FQ=
	=
X-Google-Smtp-Source: AGHT+IG2mwQUKoRUSpKj9hUWjVgwtRnTOzorVQZkyuHXLrzTO0C2kG5XBaRDL6I4WJyy3fUtsdzTNRaa+A==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:1d41:9aa5:8c04:911])
 (user=elver job=sendgmr) by 2002:a17:906:2557:b0:a9a:1769:f4db with SMTP id
 a640c23a62f3a-a9eeff38838mr49766b.5.1731065707141; Fri, 08 Nov 2024 03:35:07
 -0800 (PST)
Date: Fri,  8 Nov 2024 12:34:25 +0100
In-Reply-To: <20241108113455.2924361-1-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241108113455.2924361-1-elver@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241108113455.2924361-2-elver@google.com>
Subject: [PATCH v3 2/2] tracing: Remove pid in task_rename tracing output
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
index 209d315852fb..af535b053033 100644
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
2.47.0.277.g8800431eea-goog

