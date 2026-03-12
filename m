Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A34379EEA
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 11:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773315520; cv=none; b=hD76DB5tRTDToygtYbDIGuRjRDrDizQkV0/oQ0UfG6IeP8aVfl/HensRC0jHlN4vx7hT+E4hcKa/sItdij5aROTSqUdslyk9GNWHWJY4WSRN+5dqEh25Zp7tvarjwnfFixAaNQptNkIC2E4H3k8psXlj+5cunJGmgtjgqQr/MGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773315520; c=relaxed/simple;
	bh=iP5CaKCMngvc02WVOGsezV4fLv1v5t0mSCfz6F2I/K8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y00TbMLYXdcjOJ6CLESqYeUwM2BRlUyRn6meUcsnxqLxxzOQ+X1Vcqh2bibytGdsPBnto1nLkBT8rl0hgyUi6YDaCclQhWvn1zs1UpvD50om61d3KPt5N9xJW93uD6E37rked8IlaMdqJo5lweGDrDW0jeDv1zafhHqSAxVjqoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nh5FAB8T; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nh5FAB8T"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773315506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bu5mWobvX4U3cXiyaUbCa8xpuOximkgmKYMfG+Fla8Q=;
	b=nh5FAB8TtEr58qotNI9hqlK7o9elx15QlsZorIirz65yTG5vuq0WaNHIlK2GhbLbLCWHtX
	sf3BDhH2e8K6OF6Gp1caUzDVLIe0dEyOheCOGvZgQ+7cbYdGmHgrKHI6D+jwy9LknsU5IW
	MVtrimwww8LH9Hq5JTFun2xbeOedeic=
From: Usama Arif <usama.arif@linux.dev>
To: Dmitry Ilvokhin <d@ilvokhin.com>
Cc: Usama Arif <usama.arif@linux.dev>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v2 2/2] locking: Add contended_release tracepoint
Date: Thu, 12 Mar 2026 04:38:14 -0700
Message-ID: <20260312113815.2107882-1-usama.arif@linux.dev>
In-Reply-To: <cb89caf58885858433711f0ed6238484f5f1a67f.1773164180.git.d@ilvokhin.com>
References: 
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Tue, 10 Mar 2026 17:49:39 +0000 Dmitry Ilvokhin <d@ilvokhin.com> wrote:

> Add the contended_release trace event. This tracepoint fires on the
> holder side when a contended lock is released, complementing the
> existing contention_begin/contention_end tracepoints which fire on the
> waiter side.
> 
> This enables correlating lock hold time under contention with waiter
> events by lock address.
> 
> Add trace_contended_release() calls to the slowpath unlock paths of
> sleepable locks: mutex, rtmutex, semaphore, rwsem, percpu-rwsem, and
> RT-specific rwbase locks. Each call site fires only when there are
> blocked waiters being woken, except percpu_up_write() which always wakes
> via __wake_up().
> 
> Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
> ---
>  include/trace/events/lock.h   | 17 +++++++++++++++++
>  kernel/locking/mutex.c        |  1 +
>  kernel/locking/percpu-rwsem.c |  3 +++
>  kernel/locking/rtmutex.c      |  1 +
>  kernel/locking/rwbase_rt.c    |  8 +++++++-
>  kernel/locking/rwsem.c        |  9 +++++++--
>  kernel/locking/semaphore.c    |  4 +++-
>  7 files changed, 39 insertions(+), 4 deletions(-)
> 
> diff --git a/include/trace/events/lock.h b/include/trace/events/lock.h
> index 8e89baa3775f..4f28e41977ec 100644
> --- a/include/trace/events/lock.h
> +++ b/include/trace/events/lock.h
> @@ -138,6 +138,23 @@ TRACE_EVENT(contention_end,
>  	TP_printk("%p (ret=%d)", __entry->lock_addr, __entry->ret)
>  );
>  
> +TRACE_EVENT(contended_release,
> +
> +	TP_PROTO(void *lock),
> +
> +	TP_ARGS(lock),
> +
> +	TP_STRUCT__entry(
> +		__field(void *, lock_addr)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->lock_addr = lock;
> +	),
> +
> +	TP_printk("%p", __entry->lock_addr)
> +);
> +
>  #endif /* _TRACE_LOCK_H */
>  
>  /* This part must be outside protection */
> diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
> index 427187ff02db..ff9d07f3e900 100644
> --- a/kernel/locking/mutex.c
> +++ b/kernel/locking/mutex.c
> @@ -992,6 +992,7 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
>  	if (waiter) {
>  		next = waiter->task;
>  
> +		trace_contended_release(lock);
>  		debug_mutex_wake_waiter(lock, waiter);
>  		__clear_task_blocked_on(next, lock);
>  		wake_q_add(&wake_q, next);
> diff --git a/kernel/locking/percpu-rwsem.c b/kernel/locking/percpu-rwsem.c
> index f3ee7a0d6047..1eee51766aaf 100644
> --- a/kernel/locking/percpu-rwsem.c
> +++ b/kernel/locking/percpu-rwsem.c
> @@ -263,6 +263,8 @@ void percpu_up_write(struct percpu_rw_semaphore *sem)
>  {
>  	rwsem_release(&sem->dep_map, _RET_IP_);
>  
> +	trace_contended_release(sem);
> +

Hello!

I saw that you mentioned in the commmit message that you do this for only
blocked waiters except for percpu_up_write(). We can use
waitqueue_active(&sem->waiters) to check for this over here so that
its consistent with every other call?


>  	/*
>  	 * Signal the writer is done, no fast path yet.
>  	 *
> @@ -297,6 +299,7 @@ void __percpu_up_read(struct percpu_rw_semaphore *sem)
>  	 * writer.
>  	 */
>  	smp_mb(); /* B matches C */
> +	trace_contended_release(sem);

Should we do this after this_cpu_dec(*sem->read_count)?

>  	/*
>  	 * In other words, if they see our decrement (presumably to
>  	 * aggregate zero, as that is the only time it matters) they
> diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
> index ccaba6148b61..3db8a840b4e8 100644
> --- a/kernel/locking/rtmutex.c
> +++ b/kernel/locking/rtmutex.c
> @@ -1466,6 +1466,7 @@ static void __sched rt_mutex_slowunlock(struct rt_mutex_base *lock)
>  		raw_spin_lock_irqsave(&lock->wait_lock, flags);
>  	}
>  
> +	trace_contended_release(lock);
>  	/*
>  	 * The wakeup next waiter path does not suffer from the above
>  	 * race. See the comments there.
> diff --git a/kernel/locking/rwbase_rt.c b/kernel/locking/rwbase_rt.c
> index 82e078c0665a..081778934b13 100644
> --- a/kernel/locking/rwbase_rt.c
> +++ b/kernel/locking/rwbase_rt.c
> @@ -162,8 +162,10 @@ static void __sched __rwbase_read_unlock(struct rwbase_rt *rwb,
>  	 * worst case which can happen is a spurious wakeup.
>  	 */
>  	owner = rt_mutex_owner(rtm);
> -	if (owner)
> +	if (owner) {
> +		trace_contended_release(rwb);
>  		rt_mutex_wake_q_add_task(&wqh, owner, state);
> +	}
>  
>  	/* Pairs with the preempt_enable in rt_mutex_wake_up_q() */
>  	preempt_disable();
> @@ -205,6 +207,8 @@ static inline void rwbase_write_unlock(struct rwbase_rt *rwb)
>  	unsigned long flags;
>  
>  	raw_spin_lock_irqsave(&rtm->wait_lock, flags);
> +	if (trace_contended_release_enabled() && rt_mutex_has_waiters(rtm))
> +		trace_contended_release(rwb);
>  	__rwbase_write_unlock(rwb, WRITER_BIAS, flags);
>  }
>  
> @@ -214,6 +218,8 @@ static inline void rwbase_write_downgrade(struct rwbase_rt *rwb)
>  	unsigned long flags;
>  
>  	raw_spin_lock_irqsave(&rtm->wait_lock, flags);
> +	if (trace_contended_release_enabled() && rt_mutex_has_waiters(rtm))
> +		trace_contended_release(rwb);
>  	/* Release it and account current as reader */
>  	__rwbase_write_unlock(rwb, WRITER_BIAS - 1, flags);
>  }
> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> index ba4cb74de064..cf7d8e75ad7b 100644
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -1390,6 +1390,7 @@ static inline void __up_read(struct rw_semaphore *sem)
>  	if (unlikely((tmp & (RWSEM_LOCK_MASK|RWSEM_FLAG_WAITERS)) ==
>  		      RWSEM_FLAG_WAITERS)) {
>  		clear_nonspinnable(sem);
> +		trace_contended_release(sem);
>  		rwsem_wake(sem);
>  	}
>  	preempt_enable();
> @@ -1413,8 +1414,10 @@ static inline void __up_write(struct rw_semaphore *sem)
>  	preempt_disable();
>  	rwsem_clear_owner(sem);
>  	tmp = atomic_long_fetch_add_release(-RWSEM_WRITER_LOCKED, &sem->count);
> -	if (unlikely(tmp & RWSEM_FLAG_WAITERS))
> +	if (unlikely(tmp & RWSEM_FLAG_WAITERS)) {
> +		trace_contended_release(sem);
>  		rwsem_wake(sem);
> +	}
>  	preempt_enable();
>  }
>  
> @@ -1437,8 +1440,10 @@ static inline void __downgrade_write(struct rw_semaphore *sem)
>  	tmp = atomic_long_fetch_add_release(
>  		-RWSEM_WRITER_LOCKED+RWSEM_READER_BIAS, &sem->count);
>  	rwsem_set_reader_owned(sem);
> -	if (tmp & RWSEM_FLAG_WAITERS)
> +	if (tmp & RWSEM_FLAG_WAITERS) {
> +		trace_contended_release(sem);
>  		rwsem_downgrade_wake(sem);
> +	}
>  	preempt_enable();
>  }
>  
> diff --git a/kernel/locking/semaphore.c b/kernel/locking/semaphore.c
> index 74d41433ba13..d46415095dd6 100644
> --- a/kernel/locking/semaphore.c
> +++ b/kernel/locking/semaphore.c
> @@ -231,8 +231,10 @@ void __sched up(struct semaphore *sem)
>  	else
>  		__up(sem, &wake_q);
>  	raw_spin_unlock_irqrestore(&sem->lock, flags);
> -	if (!wake_q_empty(&wake_q))
> +	if (!wake_q_empty(&wake_q)) {
> +		trace_contended_release(sem);
>  		wake_up_q(&wake_q);
> +	}
>  }
>  EXPORT_SYMBOL(up);
>  
> -- 
> 2.52.0
> 
> 
