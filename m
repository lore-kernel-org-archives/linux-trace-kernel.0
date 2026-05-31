Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4492537E300;
	Sun, 31 May 2026 23:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780270807; cv=none; b=fct7yJSjkeX7UT0jml218M8LSxUK3FdkD/cYZu1t0jrZ9xB8OThVk7ouzUGFdRflAarXwx4JB7gWg71UXlieFr+E2Iklv5OZz4Bw0bxxgJnKD8iCYIz7EgiibukcTOpxZMmiJaRvPjYhaYaVA7H4sJm2wv2OY+sNSYIV298DcvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780270807; c=relaxed/simple;
	bh=rsl8EB/9i5DDqqR5myHTe944xl2yDbGGQg3MMqZYzeo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=L5leHVNLU3p9xhq1xjPjbuzWF/GaHOc544MnYdlxXP6up7/3CpFeRzJRPD9q9/xDNW4kBa+zocbNGS46Fy3eLIKxsSpGWjzWA5MwzG22DumK5CsGOYNYEJVK/aHs5TCz6dLP+L+wjfY1RhDOUsjvJbmrJCRHJei6Y7fHkkB+o+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZhxlOQNu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZhxlOQNu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB8D91F00893;
	Sun, 31 May 2026 23:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780270805;
	bh=EJtVgyNJg/4b6Ce7odUiVtGO8Owgd7hNSEuaH9GDClg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZhxlOQNuVGwHiU9U/LH01TmoLHRRi4wnH1YbnYDu+Zd7owJ6+neuXf55LK9IIHp8y
	 32eG7Rhur3GXkYKi06MYv5lGRq/TZT3TuNp9KHuNTRLXGmbiLtgkoyVrX/iYGsXDOe
	 jFAOrQF/AQZ7C/6rNNbFd+CHN1vqkuwoYF33Jj/eX+P815hRUIBHfgwI4M6vhtzYNq
	 UF6gZPRshpqLzp1YBbgQGpdE0iEdhOXguBBWQzO+ri9jRA6Ojro8uxruA+gZ00Rwer
	 qR8fvIGqSJ/N6d+YQraCALRA3fmnlYxesJJC7N/qAUC31WhO5ZY8bBDOR/rG1NYizr
	 IaxZtnyj6Butw==
Date: Mon, 1 Jun 2026 08:40:01 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Tengda Wu <wutengda@huaweicloud.com>, Peter Zijlstra
 <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Alexei Starovoitov <ast@kernel.org>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rethook: Use tsk->on_cpu to check task execution state
Message-Id: <20260601084001.9566b443746447ec2bb1a9fb@kernel.org>
In-Reply-To: <94179dab-ffb7-4fab-af45-b20bfb686ab3@huaweicloud.com>
References: <20260525132253.1889726-1-wutengda@huaweicloud.com>
	<20260526123719.482f07a3843e207e22d95378@kernel.org>
	<94179dab-ffb7-4fab-af45-b20bfb686ab3@huaweicloud.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 May 2026 11:39:49 +0800
Tengda Wu <wutengda@huaweicloud.com> wrote:

> > We also should not use tsk->on_cpu, but should use task_on_cpu(tsk).
> > 
> > BTW, should task_on_cpu() use READ_ONCE() etc?
> > wait_task_inactive() seems a bit fragile.
> > 
> > Thanks,
> > 
> 
> It seems that using task_on_cpu() is not necessary here because:
> 
> 1. It requires an additional 'rq' parameter not available in the rethook context.
> 2. It just returns p->on_cpu, which is identical to our current use of tsk->on_cpu.

OK. We may need to cleanup task_on_cpu() to remove unused rq, which
was historically introduced by commit 029632fbb7b7 ("sched: Make
separate sched*.c translation units") as a parameter for "task_running()"
because it called task_current(), but was cleaned by commit 0b9d46fc5ef7
("sched: Rename task_running() to task_on_cpu()") and now it is not
used.

> 
> /* file: kernel/sched/sched.h */
> static inline int task_on_cpu(struct rq *rq, struct task_struct *p)
> {
> 	return p->on_cpu;
> }
> 
> Given these constraints, staying with tsk->on_cpu seems more straightforward
> for the rethook context.

The reason I asked you to use a wrapper function instead of directly
accessing that on_cpu is to ensure that this part isn't overlooked when
changing the scheduler's behavior in the future.

They may be equivalent at this point in time, but that doesn't necessarily
mean they will remain so in the future.

IMHO, an API interface should represent the behavior and resources
required for that operation, and when accessing it from outside the
subsystem, we should use that API whenever possible. Otherwise, even
if we want to update the internal implementation of one subsystem,
we will have to make changes to other subsystems as well.

Peter, is it OK to drop @rq from task_on_cpu()? Then we can use
it from rethook.

Thank you,

> 
> Thanks,
> Tengda
> 
> >>
> >> Fixes: 54ecbe6f1ed5 ("rethook: Add a generic return hook")
> >> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
> >> ---
> >>  kernel/trace/rethook.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/kernel/trace/rethook.c b/kernel/trace/rethook.c
> >> index 5a8bdf88999a..bd5e5f455e85 100644
> >> --- a/kernel/trace/rethook.c
> >> +++ b/kernel/trace/rethook.c
> >> @@ -250,7 +250,7 @@ unsigned long rethook_find_ret_addr(struct task_struct *tsk, unsigned long frame
> >>  	if (WARN_ON_ONCE(!cur))
> >>  		return 0;
> >>  
> >> -	if (tsk != current && task_is_running(tsk))
> >> +	if (tsk != current && tsk->on_cpu)
> >>  		return 0;
> >>  
> >>  	do {
> >> -- 
> >> 2.34.1
> >>
> >>
> > 
> > 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
