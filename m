Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7520E242910;
	Sun,  4 Oct 2026 08:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791100826; cv=none; b=N4Eh32N+VexUuBT44o+h4ZrzGQFxuAFct+Ytr9kRWw6b+dNPyTD3m7a5TUnYfDUNM9HpI8UbNjGs0/jr4vmMi6BR5gXGwb1H5nnU70rVbpcIlswHzNn9e5IQTXQa1uMWK8+/KBB9FOpLZwPTP10xUFVECb8eFRal4enKYeLluYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791100826; c=relaxed/simple;
	bh=Jl0QUKYPMtqla6gmPzUJ5UFFsRghDd02m5R/6Q4bkNw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ai8oCiGz5CuD9mqta4ROK3XODJDH3KOw8rkP09koLFdHV1RtGgIiBFYHWwPkfjdB3meddee8X+2CGRT4LEa4/OWmM7rUk+N56IEhEKlzZQ+1TUNb7nfK3kYRbelgu+bDdup1dVzNNj+s9iOWcDgyFMb1DwUgugQ5BtEYnnKNqcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=W1OGuJho; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="W1OGuJho"
Received: from omf20.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id D18571C3EC8;
	Sun,  4 Oct 2026 08:00:22 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id D202F20028;
	Sun,  4 Oct 2026 08:00:19 +0000 (UTC)
Date: Sun, 4 Oct 2026 04:00:16 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Beau Belgrave <beaub@linux.microsoft.com>
Cc: Jeff Barnes <jeffbarnes@linux.microsoft.com>,
 linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, kees@kernel.org
Subject: Re: [PATCH] tracing/user_events: Fail fork when event state
 duplication fails
Message-ID: <20261004040016.73e9d705@fedora>
In-Reply-To: <20261002222639.1964370-1-jeffbarnes@linux.microsoft.com>
References: <20261002222639.1964370-1-jeffbarnes@linux.microsoft.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 1i31w1no6s4f9ttqy1bp4h1d4ofyjmj1
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: D202F20028
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18fjA6zdy2JHpUiLYwyhxgfp5zsBh3V518=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=jY0zActzIiPPhJb0/A11zbtc3xvaDD0iYdW7j1Sh59E=; b=W1OGuJhoYIsLiMcYyfGhHHiDu1ocVrz7GZmJRonF8zPY2ERVZ4/9SJl/JGnvQGsD5UFvD1qsl1+uyxGOb2Z3Rn+BCggh0DZ2pZvZzCdgTlFV+fjIhfBPoy1caQZut8YRhSaXWCwmRfhofK4JhcT3OZFu+4WQhwquN9t57BR86aE=
X-HE-Tag: 1791100819-689535
X-HE-Meta: U2FsdGVkX1+gTjfo3ihDbWEy5974jSLU8pi2jAygXJZJWIMX0c5+KagDeKWSxJr4QDotZrEhvB743aJGMYcgYn4UCENV1O3h9VLtoeYAJY8hXr7sdgav7mZEUGOrpZn6Dy3Rl0yWJHexxuO5yJ2G4yoEUqs+c4aFj4RQg3fM/3jDvYa2dWPp57yQVAE0Zp/B8iyrl4mDdM1p1NEoSKWlWKPscojkEvfzAiMkaJarpScBVRzOJgXq+Eq+ZUkB4p1J43duHhsi+gSLvMTwUXXKQVDIe7PYJ0ev7FcZ/ZH5brgFbamGkBcLKiDvR56U6lE1qALObtPAHjNMgxjlIc9VDEj7H1vUholN1+dS1DEBkDX/vPpYWuWsJQ==

Beau,

Can you review this?

Thanks,

-- Steve


On Fri,  2 Oct 2026 18:26:39 -0400
Jeff Barnes <jeffbarnes@linux.microsoft.com> wrote:

> Registered user events are retained across fork, but duplicating their
> state for a child with a separate mm can fail. Both user_event_mm_dup() and
> user_events_fork() currently return void, so allocation failure silently
> creates a child without the inherited registration state.
> 
> The child can consequently retain a stale copy-on-write enable word and
> miss later event enable and disable updates.
> 
> Return an error from user_event_mm_dup() and user_events_fork(), and
> perform the duplication in copy_process() while failure can still be
> unwound. Return -ENOMEM when the child user_event_mm or any of its enablers
> cannot be duplicated.
> 
> Add a cleanup path so successfully acquired user-events state is removed if
> a later fork operation fails. Preserve the existing CLONE_VM behavior and
> its task reference accounting.
> 
> A deterministic allocation-failure test on upstream master previously
> allowed fork() to succeed while the child missed an enablement update. With
> this change, the same fork fails with ENOMEM. The complete user_events ABI
> suite passes.
> 
> Fixes: 7235759084a4 ("tracing/user_events: Use remote writes for event enablement")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jeff Barnes <jeffbarnes@linux.microsoft.com>
> ---
>  include/linux/user_events.h      | 16 +++++++---------
>  kernel/fork.c                    |  8 ++++++--
>  kernel/trace/trace_events_user.c |  8 +++++---
>  3 files changed, 18 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/user_events.h b/include/linux/user_events.h
> index 57d1ff006090..75f184126727 100644
> --- a/include/linux/user_events.h
> +++ b/include/linux/user_events.h
> @@ -27,28 +27,26 @@ struct user_event_mm {
>  	struct rcu_work		put_rwork;
>  };
>  
> -extern void user_event_mm_dup(struct task_struct *t,
> -			      struct user_event_mm *old_mm);
> +int user_event_mm_dup(struct task_struct *t, struct user_event_mm *old_mm);
>  
>  extern void user_event_mm_remove(struct task_struct *t);
>  
> -static inline void user_events_fork(struct task_struct *t,
> -				    u64 clone_flags)
> +static inline int user_events_fork(struct task_struct *t, u64 clone_flags)
>  {
>  	struct user_event_mm *old_mm;
>  
>  	if (!t || !current->user_event_mm)
> -		return;
> +		return 0;
>  
>  	old_mm = current->user_event_mm;
>  
>  	if (clone_flags & CLONE_VM) {
>  		t->user_event_mm = old_mm;
>  		refcount_inc(&old_mm->tasks);
> -		return;
> +		return 0;
>  	}
>  
> -	user_event_mm_dup(t, old_mm);
> +	return user_event_mm_dup(t, old_mm);
>  }
>  
>  static inline void user_events_execve(struct task_struct *t)
> @@ -67,9 +65,9 @@ static inline void user_events_exit(struct task_struct *t)
>  	user_event_mm_remove(t);
>  }
>  #else
> -static inline void user_events_fork(struct task_struct *t,
> -				    u64 clone_flags)
> +static inline int user_events_fork(struct task_struct *t, u64 clone_flags)
>  {
> +	return 0;
>  }
>  
>  static inline void user_events_execve(struct task_struct *t)
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 10f2d05d816a..9e3da2e6059f 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2311,9 +2311,12 @@ __latent_entropy struct task_struct *copy_process(
>  	retval = copy_mm(clone_flags, p);
>  	if (retval)
>  		goto bad_fork_cleanup_signal;
> -	retval = copy_namespaces(clone_flags, p);
> +	retval = user_events_fork(p, clone_flags);
>  	if (retval)
>  		goto bad_fork_cleanup_mm;
> +	retval = copy_namespaces(clone_flags, p);
> +	if (retval)
> +		goto bad_fork_cleanup_user_events;
>  	retval = copy_io(clone_flags, p);
>  	if (retval)
>  		goto bad_fork_cleanup_namespaces;
> @@ -2575,7 +2578,6 @@ __latent_entropy struct task_struct *copy_process(
>  
>  	trace_task_newtask(p, clone_flags);
>  	uprobe_copy_process(p, clone_flags);
> -	user_events_fork(p, clone_flags);
>  
>  	copy_oom_score_adj(clone_flags, p);
>  
> @@ -2602,6 +2604,8 @@ __latent_entropy struct task_struct *copy_process(
>  		exit_io_context(p);
>  bad_fork_cleanup_namespaces:
>  	exit_nsproxy_namespaces(p);
> +bad_fork_cleanup_user_events:
> +	user_events_exit(p);
>  bad_fork_cleanup_mm:
>  	sched_cache_fork_cleanup(p);
>  	if (p->mm) {
> diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
> index f658c3a77aa7..8941c8d7c193 100644
> --- a/kernel/trace/trace_events_user.c
> +++ b/kernel/trace/trace_events_user.c
> @@ -863,7 +863,7 @@ void user_event_mm_remove(struct task_struct *t)
>  	queue_rcu_work(system_percpu_wq, &mm->put_rwork);
>  }
>  
> -void user_event_mm_dup(struct task_struct *t, struct user_event_mm *old_mm)
> +int user_event_mm_dup(struct task_struct *t, struct user_event_mm *old_mm)
>  {
>  	struct user_event_mm *mm = user_event_mm_alloc(t);
>  	struct user_event_enabler *enabler;
> @@ -872,7 +872,7 @@ void user_event_mm_dup(struct task_struct *t, struct user_event_mm *old_mm)
>  	t->user_event_mm = NULL;
>  
>  	if (!mm)
> -		return;
> +		return -ENOMEM;
>  
>  	rcu_read_lock();
>  
> @@ -884,10 +884,12 @@ void user_event_mm_dup(struct task_struct *t, struct user_event_mm *old_mm)
>  	rcu_read_unlock();
>  
>  	user_event_mm_attach(mm, t);
> -	return;
> +	return 0;
>  error:
>  	rcu_read_unlock();
>  	user_event_mm_destroy(mm);
> +
> +	return -ENOMEM;
>  }
>  
>  static bool current_user_event_enabler_exists(unsigned long uaddr,

