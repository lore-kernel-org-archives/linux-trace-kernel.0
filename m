Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2E42561A7;
	Tue,  6 Oct 2026 12:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791288086; cv=none; b=b7+4yfBiI6ec+nIsQ2ByRKKMSGN29PQGik3xVCXTfioRFs+yPEMdePBZ6+wMoNBI78HSrS3p6Dami1cFttaMxJ5ijIY0Wj6JzuAgVpkhHtWsqMRZk0ETo0uHckhmspS1D5N4H+NYF1IDq6DaL1W4ywJIUb9x6ShSNDAhh/XraLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791288086; c=relaxed/simple;
	bh=R3JKeaZVCTMvkffLgQN6Yc1zONqg+nf18LkyY1JH9Dg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Disposition; b=HNg5UAFZQyUWTH7WeeD1j8xcJdAm7wnpxbsjUbTaORpHglr0W8XbMRxph1AwmJvS5EmODtUXzkYIg7jZrGlR4dLoGj2TtyhpZp5wPk3AuzC1bJ+X2nX/JDjnadNu2FefVmNcJy3SA4TZvtv3k4te+JFke/FWlB8HXyT+kH4n+P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Te7ChjNw; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Te7ChjNw"
Received: from [100.96.208.29] (unknown [52.177.6.198])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1E8CB20B7168;
	Tue,  6 Oct 2026 05:00:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1E8CB20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791288022;
	bh=uyo+1i1VugDbz0nz9Pjq+ekdMi4PpfOiWUBDGB59w0c=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Te7ChjNwl80sLBcXvJNAG/dKSfAoF+eL9rDYW04z/b6AriE0UZGLw8cKVKiRTNP1A
	 uRNPrmdKIzZd08VuIkiwDDsKqyQO81YCFT4wysZ+1oBAQjscZfEEGqWsGDihxTaGck
	 EfgksYvHLvMUiL3uqkxOajqsKP8+d0eq4MCMKdSM=
Date: Tue, 6 Oct 2026 08:01:14 -0400
From: Jeff Barnes <jeffbarnes@linux.microsoft.com>
To: Beau Belgrave <beaub@linux.microsoft.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
 "=?utf-8?Q?linux-trace-kernel=40vger.kernel.org?="
 <linux-trace-kernel@vger.kernel.org>, 
 "=?utf-8?Q?mhiramat=40kernel.org?=" <mhiramat@kernel.org>, 
 "=?utf-8?Q?mathieu.desnoyers=40efficios.com?="
 <mathieu.desnoyers@efficios.com>, 
 "=?utf-8?Q?linux-kernel=40vger.kernel.org?="
 <linux-kernel@vger.kernel.org>, 
 "=?utf-8?Q?akpm=40linux-foundation.org?=" <akpm@linux-foundation.org>, 
 "=?utf-8?Q?kees=40kernel.org?=" <kees@kernel.org>
Message-ID: <B502490D-E683-4401-A06F-067B47CBC2E6@getmailspring.com>
In-Reply-To: <20261005215619.GA404-beaub@linux.microsoft.com>
References: <20261005215619.GA404-beaub@linux.microsoft.com>
Subject: Re: [PATCH] tracing/user_events: Fail fork when event state
 duplication fails
X-Mailer: Mailspring
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline



On Oct 5 2026, at 5:56 pm, Beau Belgrave <beaub@linux.microsoft.com> wrote:

> On Sun, Oct 04, 2026 at 04:00:16AM -0400, Steven Rostedt wrote:
>> Beau,
>> 
>> Can you review this?
>> 
> 
> Sure thing.
> 
>> Thanks,
>> 
>> -- Steve
>> 
>> 
>> On Fri,  2 Oct 2026 18:26:39 -0400
>> Jeff Barnes <jeffbarnes@linux.microsoft.com> wrote:
>> 
>> > Registered user events are retained across fork, but duplicating their
>> > state for a child with a separate mm can fail. Both
>> user_event_mm_dup() and
>> > user_events_fork() currently return void, so allocation failure silently
>> > creates a child without the inherited registration state.
>> > 
>> > The child can consequently retain a stale copy-on-write enable word and
>> > miss later event enable and disable updates.
>> > 
> 
> This code makes fork fail if we cannot duplicate the user_event
> enablements, uprobes just warns in these cases. The changes introduced
> look correct if that's what we want (to fail fork() when enablements
> would have been left behind).
> 
> If we do not want the fork to actually fail, a simple call to
> user_event_mm_remove() within user_event_mm_dup() would address the
> inconsistency. However, it would be silent. Some questions follow.
> 
> Steve, is it fine to have fork() fail when we cannot copy state? Uprobe
> seems to just warn here.
> 
> Jeff, I assume we have cases in mind where we really prefer fork() to
> fail when user_events cannot be propogated? (For sure we want the
> inconsistency fixed, just not sure about if silent is OK or not).
> 
> Thanks,
> -Beau

Yes, that was intentional. My concern with allowing fork() to succeed
after removing the child's user_events state is that the allocation
failure then becomes a silent loss of inherited tracing state.

The enable word is the userspace-visible indication that an event is
enabled. If the child loses its inherited enablers, later enable and
disable changes will no longer be reflected in that child. Removing the
state fixes the stale-value inconsistency, but userspace has no
indication from fork() that the child is no longer following the
inherited tracing state.

I also think there is a potential security implication here. If
user_events are being used for tracing or auditing, an allocation
failure could result in a successfully created child silently no longer
following subsequent enablement changes. I don't want to characterize
that as a security vulnerability without a demonstrated security
boundary, but silently losing that state seems undesirable for auditing
in particular.

That is why I favored returning -ENOMEM: either the child is created
with the inherited user_events state intact, or the failure is visible
to userspace and the fork is unwound.

I agree that uprobes provides a useful comparison. If you think
user_events should likewise be best-effort across fork, then removing
the state on duplication failure would address the inconsistency without
introducing the new fork() failure path.

Thanks,
Jeff
> 
>> > Return an error from user_event_mm_dup() and user_events_fork(), and
>> > perform the duplication in copy_process() while failure can still be
>> > unwound. Return -ENOMEM when the child user_event_mm or any of its enablers
>> > cannot be duplicated.
>> > 
>> > Add a cleanup path so successfully acquired user-events state is
>> removed if
>> > a later fork operation fails. Preserve the existing CLONE_VM
>> behavior and
>> > its task reference accounting.
>> > 
>> > A deterministic allocation-failure test on upstream master previously
>> > allowed fork() to succeed while the child missed an enablement
>> update. With
>> > this change, the same fork fails with ENOMEM. The complete
>> user_events ABI
>> > suite passes.
>> > 
>> > Fixes: 7235759084a4 ("tracing/user_events: Use remote writes for
>> event enablement")
>> > Cc: stable@vger.kernel.org
>> > Signed-off-by: Jeff Barnes <jeffbarnes@linux.microsoft.com>
>> > ---
>> >  include/linux/user_events.h      | 16 +++++++---------
>> >  kernel/fork.c                    |  8 ++++++--
>> >  kernel/trace/trace_events_user.c |  8 +++++---
>> >  3 files changed, 18 insertions(+), 14 deletions(-)
>> > 
>> > diff --git a/include/linux/user_events.h b/include/linux/user_events.h
>> > index 57d1ff006090..75f184126727 100644
>> > --- a/include/linux/user_events.h
>> > +++ b/include/linux/user_events.h
>> > @@ -27,28 +27,26 @@ struct user_event_mm {
>> >  	struct rcu_work		put_rwork;
>> >  };
>> >  
>> > -extern void user_event_mm_dup(struct task_struct *t,
>> > -			      struct user_event_mm *old_mm);
>> > +int user_event_mm_dup(struct task_struct *t, struct user_event_mm *old_mm);
>> >  
>> >  extern void user_event_mm_remove(struct task_struct *t);
>> >  
>> > -static inline void user_events_fork(struct task_struct *t,
>> > -				    u64 clone_flags)
>> > +static inline int user_events_fork(struct task_struct *t, u64 clone_flags)
>> >  {
>> >  	struct user_event_mm *old_mm;
>> >  
>> >  	if (!t || !current->user_event_mm)
>> > -		return;
>> > +		return 0;
>> >  
>> >  	old_mm = current->user_event_mm;
>> >  
>> >  	if (clone_flags & CLONE_VM) {
>> >  		t->user_event_mm = old_mm;
>> >  		refcount_inc(&old_mm->tasks);
>> > -		return;
>> > +		return 0;
>> >  	}
>> >  
>> > -	user_event_mm_dup(t, old_mm);
>> > +	return user_event_mm_dup(t, old_mm);
>> >  }
>> >  
>> >  static inline void user_events_execve(struct task_struct *t)
>> > @@ -67,9 +65,9 @@ static inline void user_events_exit(struct
>> task_struct *t)
>> >  	user_event_mm_remove(t);
>> >  }
>> >  #else
>> > -static inline void user_events_fork(struct task_struct *t,
>> > -				    u64 clone_flags)
>> > +static inline int user_events_fork(struct task_struct *t, u64 clone_flags)
>> >  {
>> > +	return 0;
>> >  }
>> >  
>> >  static inline void user_events_execve(struct task_struct *t)
>> > diff --git a/kernel/fork.c b/kernel/fork.c
>> > index 10f2d05d816a..9e3da2e6059f 100644
>> > --- a/kernel/fork.c
>> > +++ b/kernel/fork.c
>> > @@ -2311,9 +2311,12 @@ __latent_entropy struct task_struct *copy_process(
>> >  	retval = copy_mm(clone_flags, p);
>> >  	if (retval)
>> >  		goto bad_fork_cleanup_signal;
>> > -	retval = copy_namespaces(clone_flags, p);
>> > +	retval = user_events_fork(p, clone_flags);
>> >  	if (retval)
>> >  		goto bad_fork_cleanup_mm;
>> > +	retval = copy_namespaces(clone_flags, p);
>> > +	if (retval)
>> > +		goto bad_fork_cleanup_user_events;
>> >  	retval = copy_io(clone_flags, p);
>> >  	if (retval)
>> >  		goto bad_fork_cleanup_namespaces;
>> > @@ -2575,7 +2578,6 @@ __latent_entropy struct task_struct *copy_process(
>> >  
>> >  	trace_task_newtask(p, clone_flags);
>> >  	uprobe_copy_process(p, clone_flags);
>> > -	user_events_fork(p, clone_flags);
>> >  
>> >  	copy_oom_score_adj(clone_flags, p);
>> >  
>> > @@ -2602,6 +2604,8 @@ __latent_entropy struct task_struct *copy_process(
>> >  		exit_io_context(p);
>> >  bad_fork_cleanup_namespaces:
>> >  	exit_nsproxy_namespaces(p);
>> > +bad_fork_cleanup_user_events:
>> > +	user_events_exit(p);
>> >  bad_fork_cleanup_mm:
>> >  	sched_cache_fork_cleanup(p);
>> >  	if (p->mm) {
>> > diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
>> > index f658c3a77aa7..8941c8d7c193 100644
>> > --- a/kernel/trace/trace_events_user.c
>> > +++ b/kernel/trace/trace_events_user.c
>> > @@ -863,7 +863,7 @@ void user_event_mm_remove(struct task_struct *t)
>> >  	queue_rcu_work(system_percpu_wq, &mm->put_rwork);
>> >  }
>> >  
>> > -void user_event_mm_dup(struct task_struct *t, struct user_event_mm *old_mm)
>> > +int user_event_mm_dup(struct task_struct *t, struct user_event_mm *old_mm)
>> >  {
>> >  	struct user_event_mm *mm = user_event_mm_alloc(t);
>> >  	struct user_event_enabler *enabler;
>> > @@ -872,7 +872,7 @@ void user_event_mm_dup(struct task_struct *t,
>> struct user_event_mm *old_mm)
>> >  	t->user_event_mm = NULL;
>> >  
>> >  	if (!mm)
>> > -		return;
>> > +		return -ENOMEM;
>> >  
>> >  	rcu_read_lock();
>> >  
>> > @@ -884,10 +884,12 @@ void user_event_mm_dup(struct task_struct *t,
>> struct user_event_mm *old_mm)
>> >  	rcu_read_unlock();
>> >  
>> >  	user_event_mm_attach(mm, t);
>> > -	return;
>> > +	return 0;
>> >  error:
>> >  	rcu_read_unlock();
>> >  	user_event_mm_destroy(mm);
>> > +
>> > +	return -ENOMEM;
>> >  }
>> >  
>> >  static bool current_user_event_enabler_exists(unsigned long uaddr,
> 
