Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F05F30C161;
	Tue, 14 Jul 2026 02:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783995204; cv=none; b=N+RP5fkF8XXuZ5LXrsBKiXgSRD+2JjVtSXYjRkLBpy+ivffOhQYulR7//NEbnpV/RACetkmN/Wu7J5Qyrrt9lFDDbr16F0T2PRZKeTBi0M6u2NnmCXXphg9TGYw2qXyw5gYIeq/xiK93dJ/vibIuJiNTxPfFUnCmgGBT+hJp2c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783995204; c=relaxed/simple;
	bh=0MsmYdDs2zxnAGkUdZLdc95fa4TAJ4rC7l6Mp4w/QBI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r77DlKqOTjeqE7q9su9Q6TMSNChrR6IkPkbeyRWUEOgMGX02BwfZuTT8M0lM3jhVZKULUbQ4MD0QwLLNW06d1QNgNtnOV+H85kR9Z7y2Vh03ujeked+ye4UJ4IA1mZwBAInO4QGuRXEhoyWYs0uvhc5PwpfZAavaoI+UxyxpwF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id C67451C0172;
	Tue, 14 Jul 2026 02:13:18 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id EB54D6000A;
	Tue, 14 Jul 2026 02:13:16 +0000 (UTC)
Date: Mon, 13 Jul 2026 22:13:18 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Add mutex to trace_parser to fix concurrent
 write races
Message-ID: <20260713221318.63f741ad@gandalf.local.home>
In-Reply-To: <ae69656e-fc50-4049-94f9-d460c2e1d5b8@huaweicloud.com>
References: <20260713134640.708323-1-wutengda@huaweicloud.com>
	<20260713153624.48fc4be4@robin>
	<ae69656e-fc50-4049-94f9-d460c2e1d5b8@huaweicloud.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: siemi3qrhxuam46hz59sseayyftfxkyo
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: EB54D6000A
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18pKJgEvdohsE0XO93nn+Gk2ePiS0Ckd/0=
X-HE-Tag: 1783995196-644624
X-HE-Meta: U2FsdGVkX1/Vj/xxvcL/srZ0Mihj1zubq/gpgiNq8wsdnG4dmuuIf8/QTOw6OVFB9sloiWjjK0snvcncSWV+XTI92doj/3BqNVY78HCoHk8Un3Ls4P/pArzUR9cx8DkUe/NymQMTl0FcIvPHcsCot1OnHcyO0DDNfDlf2Z3G5QPrqTlvum+x4HF1FTaOpk1HyI5MoowvEI93kqWDC4HZz8IqbgP6xpZuMIyNvoSbbcOQ0YYsV8SDkJmyv0KiK5eKpw4FqxsbxVhaW4ay15zV6tidpPkgg7t4WH167Y+QRKj7tTIeeB4ETaheu90QsuTLF8ZMjh/FKpG/RjmKuKX9WhV2eaR9QieE

On Tue, 14 Jul 2026 09:50:55 +0800
Tengda Wu <wutengda@huaweicloud.com> wrote:

> >> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> >> index f93e34dd2328..ef47e5659283 100644
> >> --- a/kernel/trace/ftrace.c
> >> +++ b/kernel/trace/ftrace.c
> >> @@ -5842,6 +5842,8 @@ ftrace_regex_write(struct file *file, const char __user *ubuf,
> >>  	/* iter->hash is a local copy, so we don't need regex_lock */
> >>  
> >>  	parser = &iter->parser;
> >> +
> >> +	guard(mutex)(&parser->lock);
> >>  	read = trace_get_user(parser, ubuf, cnt, ppos);  
> > 
> > Why are the other users of trace_get_user() not a problem? If
> > anything, trace_get_user() should have a lockdep assert to make sure
> > the lock is held.
> > 
> > I think we need to add a lockdep assertion in all the callers that use
> > the parser and we need to make sure it's taken by every user.
> > 
> > -- Steve  
> 
> Other places that use trace_get_user():
> 
> ftrace_event_write
>     trace_parser_get_init
>     trace_get_user
> 
> trace_pid_write
>     trace_parser_get_init
>     trace_get_user
> 
> In both of these cases, the parser is allocated via trace_parser_get_init()
> before use and freed immediately after, with no multi-threaded sharing.
> 
> However, ftrace_graph_write() and ftrace_regex_write() are different.
> The parser used by these two functions is allocated at open() time and
> retrieved from struct file at write() time. Userspace can have multiple
> threads invoking write() concurrently, e.g.:
> 
>     r0 = openat(AT_FDCWD, path, O_WRONLY | O_CREAT | O_TRUNC |
>                 O_NOCTTY | O_NONBLOCK, 0);
>     r1 = dup(r0);
>     write(r1, data1, len1);        /* thread 1 */
>     pwrite64(r1, data2, len2, offset); /* thread 2 */
> 
> Without proper synchronization in trace_get_user(), the parser state
> becomes undefined.
> 
> We have locally reproduced a slab-out-of-bounds issue with syzkaller [1],
> which appears to be caused by this race.
> 
> Regarding the fix, adding a lockdep assertion to trace_get_user() does
> not seem necessary. As mentioned above, ftrace_event_write() and
> trace_pid_write() do not involve concurrency, so they do not require
> locking, and thus do not need a lockdep assertion.

So basically you want to add this inherit coupling between a user of
"parser" and the "parser" itself? That is just bad design. You created a
lock within the trace_parser struct to be used by a single instance but not
all instances.

It is either added for all users or this is fixed by something else. Yeah,
for now the other users of trace_get_user() do not need locking, but what
happens the usage changes where it adds concurrency? Then it becomes a bug
again. Right?

If one place needs to hold the parser->lock when calling trace_get_user()
and trace_parser_loaded(), then all places should hold that lock. Or we
just need to redesign it better.

Yes, this fixes a race condition when user space does something stupid (and
this is something that requires admin privileges). But if we are going to
fix it, might as well do it properly.

If the issue is only with ftrace, then make the lock part of ftrace and not
the parser. Don't create a lock in parser that is determined by how one
uses it whether the user needs to take the lock or not.

-- Steve
