Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8408041441C;
	Mon,  5 Oct 2026 21:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791237387; cv=none; b=Fw9qrFB4GFys5SfF3iZIH2tkXG4356q05awGqq9M6m4giLT1mATMgHhkGMyV/lrMXHxQqx+OuEK2ESA0ApqPtsyXksqZGcYzTxO4AjRRN6+X3T4ZSUKkirCMpcDVVddjOuNITcwN2H1AMZ5qvjV7RsY6eAmxe9HDmJYJQouKYKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791237387; c=relaxed/simple;
	bh=FbP2ch66dC3cc/NTJjxa33z3u7/rOe3RIRoTjCDidsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YYVtq7YugEa4CoTh0yhIJY8a9SXAZPuW4Zj76MIcERNjAwQDSuDyPjggbfORu/8ltJ5oFQKtHml0ZGYJcJSgIu7kPsUCNJv1U4KIG2n6dCKlGHXQQwRqNNr52VMBgYIXjTgszISSz8XFDh/AmYKk6/apexaAYYCUfQiWTJOF8zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=l62QHvzQ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="l62QHvzQ"
Received: from CPC-beaub-VBQ1L.localdomain (unknown [70.37.26.65])
	by linux.microsoft.com (Postfix) with ESMTPSA id A1A9920B7168;
	Mon,  5 Oct 2026 14:55:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A1A9920B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791237329;
	bh=YaYPfGrT8pb6peFO0ifPaeJLF06E4n0OBiG5vN39X4M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l62QHvzQTxiZgRdtj6s5Xbd9XFCN0txFVXOUqjaApY9smgGF2JwSrlhfl0wfSJcEe
	 79gFbePlFTstVTi7msqfL/PFyI/nCR3Oe3yGz/IwkKNoIKi8bcLjSNvj77+2RWElZj
	 kefidcH4OEJTYDIbSHk/PQOaeqYwpy4+T+cqSjEM=
Date: Mon, 5 Oct 2026 21:56:19 +0000
From: Beau Belgrave <beaub@linux.microsoft.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jeff Barnes <jeffbarnes@linux.microsoft.com>,
	linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, kees@kernel.org
Subject: Re: [PATCH] tracing/user_events: Fail fork when event state
 duplication fails
Message-ID: <20261005215619.GA404-beaub@linux.microsoft.com>
References: <20261002222639.1964370-1-jeffbarnes@linux.microsoft.com>
 <20261004040016.73e9d705@fedora>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261004040016.73e9d705@fedora>

On Sun, Oct 04, 2026 at 04:00:16AM -0400, Steven Rostedt wrote:
> Beau,
> 
> Can you review this?
> 

Sure thing.

> Thanks,
> 
> -- Steve
> 
> 
> On Fri,  2 Oct 2026 18:26:39 -0400
> Jeff Barnes <jeffbarnes@linux.microsoft.com> wrote:
> 
> > Registered user events are retained across fork, but duplicating their
> > state for a child with a separate mm can fail. Both user_event_mm_dup() and
> > user_events_fork() currently return void, so allocation failure silently
> > creates a child without the inherited registration state.
> > 
> > The child can consequently retain a stale copy-on-write enable word and
> > miss later event enable and disable updates.
> > 

This code makes fork fail if we cannot duplicate the user_event
enablements, uprobes just warns in these cases. The changes introduced
look correct if that's what we want (to fail fork() when enablements
would have been left behind).

If we do not want the fork to actually fail, a simple call to
user_event_mm_remove() within user_event_mm_dup() would address the
inconsistency. However, it would be silent. Some questions follow.

Steve, is it fine to have fork() fail when we cannot copy state? Uprobe
seems to just warn here.

Jeff, I assume we have cases in mind where we really prefer fork() to
fail when user_events cannot be propogated? (For sure we want the
inconsistency fixed, just not sure about if silent is OK or not).

Thanks,
-Beau

> > Return an error from user_event_mm_dup() and user_events_fork(), and
> > perform the duplication in copy_process() while failure can still be
> > unwound. Return -ENOMEM when the child user_event_mm or any of its enablers
> > cannot be duplicated.
> > 
> > Add a cleanup path so successfully acquired user-events state is removed if
> > a later fork operation fails. Preserve the existing CLONE_VM behavior and
> > its task reference accounting.
> > 
> > A deterministic allocation-failure test on upstream master previously
> > allowed fork() to succeed while the child missed an enablement update. With
> > this change, the same fork fails with ENOMEM. The complete user_events ABI
> > suite passes.
> > 
> > Fixes: 7235759084a4 ("tracing/user_events: Use remote writes for event enablement")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jeff Barnes <jeffbarnes@linux.microsoft.com>
> > ---
> >  include/linux/user_events.h      | 16 +++++++---------
> >  kernel/fork.c                    |  8 ++++++--
> >  kernel/trace/trace_events_user.c |  8 +++++---
> >  3 files changed, 18 insertions(+), 14 deletions(-)
> > 
> > diff --git a/include/linux/user_events.h b/include/linux/user_events.h
> > index 57d1ff006090..75f184126727 100644
> > --- a/include/linux/user_events.h
> > +++ b/include/linux/user_events.h
> > @@ -27,28 +27,26 @@ struct user_event_mm {
> >  	struct rcu_work		put_rwork;
> >  };
> >  
> > -extern void user_event_mm_dup(struct task_struct *t,
> > -			      struct user_event_mm *old_mm);
> > +int user_event_mm_dup(struct task_struct *t, struct user_event_mm *old_mm);
> >  
> >  extern void user_event_mm_remove(struct task_struct *t);
> >  
> > -static inline void user_events_fork(struct task_struct *t,
> > -				    u64 clone_flags)
> > +static inline int user_events_fork(struct task_struct *t, u64 clone_flags)
> >  {
> >  	struct user_event_mm *old_mm;
> >  
> >  	if (!t || !current->user_event_mm)
> > -		return;
> > +		return 0;
> >  
> >  	old_mm = current->user_event_mm;
> >  
> >  	if (clone_flags & CLONE_VM) {
> >  		t->user_event_mm = old_mm;
> >  		refcount_inc(&old_mm->tasks);
> > -		return;
> > +		return 0;
> >  	}
> >  
> > -	user_event_mm_dup(t, old_mm);
> > +	return user_event_mm_dup(t, old_mm);
> >  }
> >  
> >  static inline void user_events_execve(struct task_struct *t)
> > @@ -67,9 +65,9 @@ static inline void user_events_exit(struct task_struct *t)
> >  	user_event_mm_remove(t);
> >  }
> >  #else
> > -static inline void user_events_fork(struct task_struct *t,
> > -				    u64 clone_flags)
> > +static inline int user_events_fork(struct task_struct *t, u64 clone_flags)
> >  {
> > +	return 0;
> >  }
> >  
> >  static inline void user_events_execve(struct task_struct *t)
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index 10f2d05d816a..9e3da2e6059f 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -2311,9 +2311,12 @@ __latent_entropy struct task_struct *copy_process(
> >  	retval = copy_mm(clone_flags, p);
> >  	if (retval)
> >  		goto bad_fork_cleanup_signal;
> > -	retval = copy_namespaces(clone_flags, p);
> > +	retval = user_events_fork(p, clone_flags);
> >  	if (retval)
> >  		goto bad_fork_cleanup_mm;
> > +	retval = copy_namespaces(clone_flags, p);
> > +	if (retval)
> > +		goto bad_fork_cleanup_user_events;
> >  	retval = copy_io(clone_flags, p);
> >  	if (retval)
> >  		goto bad_fork_cleanup_namespaces;
> > @@ -2575,7 +2578,6 @@ __latent_entropy struct task_struct *copy_process(
> >  
> >  	trace_task_newtask(p, clone_flags);
> >  	uprobe_copy_process(p, clone_flags);
> > -	user_events_fork(p, clone_flags);
> >  
> >  	copy_oom_score_adj(clone_flags, p);
> >  
> > @@ -2602,6 +2604,8 @@ __latent_entropy struct task_struct *copy_process(
> >  		exit_io_context(p);
> >  bad_fork_cleanup_namespaces:
> >  	exit_nsproxy_namespaces(p);
> > +bad_fork_cleanup_user_events:
> > +	user_events_exit(p);
> >  bad_fork_cleanup_mm:
> >  	sched_cache_fork_cleanup(p);
> >  	if (p->mm) {
> > diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
> > index f658c3a77aa7..8941c8d7c193 100644
> > --- a/kernel/trace/trace_events_user.c
> > +++ b/kernel/trace/trace_events_user.c
> > @@ -863,7 +863,7 @@ void user_event_mm_remove(struct task_struct *t)
> >  	queue_rcu_work(system_percpu_wq, &mm->put_rwork);
> >  }
> >  
> > -void user_event_mm_dup(struct task_struct *t, struct user_event_mm *old_mm)
> > +int user_event_mm_dup(struct task_struct *t, struct user_event_mm *old_mm)
> >  {
> >  	struct user_event_mm *mm = user_event_mm_alloc(t);
> >  	struct user_event_enabler *enabler;
> > @@ -872,7 +872,7 @@ void user_event_mm_dup(struct task_struct *t, struct user_event_mm *old_mm)
> >  	t->user_event_mm = NULL;
> >  
> >  	if (!mm)
> > -		return;
> > +		return -ENOMEM;
> >  
> >  	rcu_read_lock();
> >  
> > @@ -884,10 +884,12 @@ void user_event_mm_dup(struct task_struct *t, struct user_event_mm *old_mm)
> >  	rcu_read_unlock();
> >  
> >  	user_event_mm_attach(mm, t);
> > -	return;
> > +	return 0;
> >  error:
> >  	rcu_read_unlock();
> >  	user_event_mm_destroy(mm);
> > +
> > +	return -ENOMEM;
> >  }
> >  
> >  static bool current_user_event_enabler_exists(unsigned long uaddr,
