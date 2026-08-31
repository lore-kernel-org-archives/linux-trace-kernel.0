Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F336F39CD1E;
	Mon, 31 Aug 2026 10:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788172905; cv=none; b=JPtjJYzNEMbfAO9WZWljmKcptW+TgCqs/VgXmybkpXOAJmUHk5BD92I+Im7zsimn3Ytz0hf3nFpHNodIYg/4+OCM/4KvHfazbECYO3X3ven4W+p50qyc+TIgbGhQzeqtucXlfWVx9EX4FozEcQc7cbIStjKGbHn6tJOxIeddkZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788172905; c=relaxed/simple;
	bh=suL+s9BotwZwxJIz5p0LXcdBnprSV2qHihd9mkbvKq0=;
	h=Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=uEyeHBnt88Z//kT17tVZXqWxCgV1DNrMjJ+QMeFzHIauqYSXBDi7BLnWD1QvA2hckDBr8JxXrzw3ff0zHyONJnjhm4IIOw9I8mgBB5ZwVVIGuabNgWpkckbt5av3J0oSgiQmAALoU7/253IN9FaxCXzVNkzb8VjW/8cSZo79o7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4hYQXG4NXXz55y1s;
	Mon, 31 Aug 2026 18:41:34 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 67VAfRbd011322;
	Mon, 31 Aug 2026 18:41:27 +0800 (+08)
	(envelope-from hu.shengming@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 31 Aug 2026 18:41:30 +0800 (CST)
X-Zmail-TransId: 2af96a955a5aaab-8c47f
X-Mailer: Zmail v1.0
Message-ID: <20260831184130077NszBddcqeMjSj8i-E-6gf@zte.com.cn>
In-Reply-To: <20260831102042.6f91bd1e35691ea2d1ac808d@kernel.org>
References: 20260830190743637MhXoixrAPc1rfm-G8eIcg@zte.com.cn,20260831102042.6f91bd1e35691ea2d1ac808d@kernel.org
Date: Mon, 31 Aug 2026 18:41:30 +0800 (CST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <hu.shengming@zte.com.cn>
To: <mhiramat@kernel.org>, <xu.xin16@zte.com.cn>
Cc: <rostedt@goodmis.org>, <mathieu.desnoyers@efficios.com>,
        <mark.rutland@arm.com>, <corbet@lwn.net>, <skhan@linuxfoundation.org>,
        <rdunlap@infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <ran.xiaokai@zte.com.cn>, <zhang.run@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtSRkMgUEFUQ0ggMC80XSBmdHJhY2U6IEFkZCB0YXNrIGNvbW0gZmlsdGVyaW5nIGZvciBmdW5jdGlvbiB0cmFjaW5n?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 67VAfRbd011322
X-TLS: YES
X-ENVELOPE-SENDER: hu.shengming@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Mon, 31 Aug 2026 18:41:34 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A955A5E.000/4hYQXG4NXXz55y1s

Masami wrote:

> On Sun, 30 Aug 2026 19:07:43 +0800 (CST)
> <hu.shengming@zte.com.cn> wrote:
> 
> > Hi Steven and Masami,
> > 
> > This series adds two comm-based task filters for the function and
> > function_graph tracers:
> > 
> >   set_ftrace_comm
> >   set_ftrace_notrace_comm
> > 
> > Function tracing currently supports selecting tasks by PID. This makes
> > it difficult to configure tracing before a service starts, because it
> > does not have a PID yet. It is also inconvenient to keep tracing the
> > same service across restarts, as its PID may change. This use case was
> > suggested by Xuxin, a KSM reviewer.
> 
> Thanks for the idea. I thought we can use `pidof` but it is for running
> processes.
> 

Yes, exactly. The main use case is to configure tracing before the
target task starts, when there is no PID for pidof to return. Thanks,
Xuxin! :)

> > 
> > The new filters match task comm names exactly. When both PID and comm 
> > include filters are active, a task must match both to be traced. A
> > match in either the PID or comm notrace filter excludes the task.
> > 
> > To avoid string matching in the function tracing fast path, the filters
> > are evaluated when a task is scheduled in. The result is stored in the
> > existing per-CPU cache used by PID filtering. Changing a filter refreshes
> > the cached result for currently running tasks. If a task's comm changes,
> > the new name is used the next time the task is scheduled in.
> 
> OK, but can trace scheduler event (or add a new event) that we just convert
> comm to PID when the comm is changed and add/remove it to pid filter?
> If that works, we can also extend generic event trigger to set ftrace pid
> filter. Using this allows you to add or remove processes as ftrace targets
> at runtime—not only based on comm, but for other reasons as well.
> (of course, setting per-cpu cache requires to kick a worker...)
> 
> This will leak the pid via set_ftrace_pid, but that is good from the
> monitoring point of view.
> 
> Thank you,
> 

Thank you for the suggestion!

My understanding is that, instead of adding comm-specific function
filters, we could add generic event-trigger actions that update the
existing function PID filter.

For example, the task_rename event already observes task comm changes.
Conceptually, a user could configure something like:

  ftrace_pid_add:pid if newcomm == "foo"
  ftrace_pid_del:pid if oldcomm == "foo" && newcomm != "foo"

The command names and syntax above are only examples. The PID field
would be selected from the event record, so the same actions could be
used with other events and filters, rather than being tied to comm or
task_rename.

I think the trigger actions could update the same PID list used by
set_ftrace_pid. A PID added by a trigger would then become a normal
set_ftrace_pid entry and would be visible when the file is read. The
list would be shared state, without tracking whether an entry came from
a user or a particular trigger. Removing a trigger would stop future
updates but would not roll back PIDs that it had already added.

Since an event trigger may run in a context where the PID list and
per-CPU cache cannot be updated directly, the trigger could queue the
operation to a worker. The worker would update the PID list and refresh
the cached task-filter result.

For the comm use case, a delete action on task_rename would remove a PID
when the task no longer has the selected comm. A delete action on
sched_process_exit could also remove stale PIDs when matching tasks
exit.

This would primarily support rules installed before a task starts or
before the relevant event occurs. It would not discover tasks that
already match when the trigger is installed unless they generate the
event again.

Does this shared PID-list and generic add/delete trigger model match
what you had in mind?

--
With Best Regards,
Shengming
