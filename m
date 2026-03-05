Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7790F33689C;
	Thu,  5 Mar 2026 15:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772726331; cv=none; b=E+zRDYAOc/5q/+rSDnrD2BxbF/ZJ+H7WHEXJtoB28y0hdy1nnItavtNMscjJp6ddp5Z1CqlNUo4lgW69Q+B/6FKsS4Qexd2LVDjxze3w5UZHTbvd4X6g7Y5mQ/o2JoIOc+4SbupcgHAfCc+Y7ynZ6O3P8wlAKo/j9oopMjF785c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772726331; c=relaxed/simple;
	bh=2rbKRtvP/fO1tQTvYJnyVAD/pJAjh95vP/nbvilcgwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YonPGXpke3jCo7x/GnOpNJ82uWWcIgcb4p3mKdXPbRkX/EmLdiHDI9tzFWvbimMUP6Y9fu6QXcuo/w2dH0QxItS30rC8ucMM5xb5Ji1jXLXqhejt0xwIwnMX3+/g4O/v7Os46ukx8nNDN0aFLzItcKCHa8NhBBFoBUSaz0G7D6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 8FEE21A01EE;
	Thu,  5 Mar 2026 15:58:48 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id 80C301A;
	Thu,  5 Mar 2026 15:58:45 +0000 (UTC)
Date: Thu, 5 Mar 2026 10:59:24 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Dmitry Ilvokhin <d@ilvokhin.com>
Cc: Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph
 Lameter <cl@gentwo.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon
 <will@kernel.org>, Boqun Feng <boqun@kernel.org>, Waiman Long
 <longman@redhat.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH RFC 3/3] locking: Wire up contended_release tracepoint
Message-ID: <20260305105924.7069eb23@gandalf.local.home>
In-Reply-To: <8298e098d3418cb446ef396f119edac58a3414e9.1772642407.git.d@ilvokhin.com>
References: <cover.1772642407.git.d@ilvokhin.com>
	<8298e098d3418cb446ef396f119edac58a3414e9.1772642407.git.d@ilvokhin.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 80C301A
X-Stat-Signature: wg8y4ji7phmjbi18xw7uwombfdkzuy1z
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18MWtLS1l3pUKaex0nFw2Vfl7EBIcRPyp4=
X-HE-Tag: 1772726325-806204
X-HE-Meta: U2FsdGVkX1/IZPjkWRcCvIJ192zG9pkiKp9riLkJeEEB12m4PIrK+XsSVGFmyjEBtSKnYXGbmq4fmXU4d9HZMRfHJo+LIXYoI5bQpOxWtm5mYldXLedVkCnRMeKd2JKSibFruN/kJ11iQ0ereZziADPsiwEip059oSTmSJ2lIaiQiYQK6Zmq3gu23WJeiLOjE+ItRBr5udxCP7OYs7U9RIqDLuHIRwXi5niNS9dY8GbU41//fmJnT07YZBdy2hqEPhpIP9sDaPeSsUU9Ceuxkv5oxQ5BU4VS4Ml30I7B4YiOJD2HrZNdkgH7P7FQhLya7SPlJpGpELX/Kmp79ro1/l6DZwheeJOqGeuFzBG+i+cRqSQUA2V9IYK9m1k2MlzR

On Wed,  4 Mar 2026 16:56:17 +0000
Dmitry Ilvokhin <d@ilvokhin.com> wrote:

> @@ -204,6 +206,8 @@ static inline void rwbase_write_unlock(struct rwbase_rt *rwb)
>  	unsigned long flags;
>  
>  	raw_spin_lock_irqsave(&rtm->wait_lock, flags);
> +	if (rt_mutex_has_waiters(rtm))
> +		trace_contended_release(rwb);

Hmm, if statements should never be used just for tracepoints without a
static branch. The above should be:

	if (trace_contended_release_enabled() && rt_mutex_has_waiters(rtm))
		trace_contended_release(rwb);

The above "trace_contened_release_enabled()" is a static_branch where it
turns the if statement into a nop when the tracepoint is not enabled, and a
jmp when it is.


>  	__rwbase_write_unlock(rwb, WRITER_BIAS, flags);
>  }
>  
> @@ -213,6 +217,8 @@ static inline void rwbase_write_downgrade(struct rwbase_rt *rwb)
>  	unsigned long flags;
>  
>  	raw_spin_lock_irqsave(&rtm->wait_lock, flags);
> +	if (rt_mutex_has_waiters(rtm))
> +		trace_contended_release(rwb);

Same here.

-- Steve

>  	/* Release it and account current as reader */
>  	__rwbase_write_unlock(rwb, WRITER_BIAS - 1, flags);
>  }
> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> index 24df4d98f7d2..4e61dc0bb045 100644
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -1360,6 +1360,7 @@ static inline void __up_read(struct rw_semaphore *sem)
>  	if (unlikely((tmp & (RWSEM_LOCK_MASK|RWSEM_FLAG_WAITERS)) ==
>  		      RWSEM_FLAG_WAITERS)) {
>  		clear_nonspinnable(sem);
> +		trace_contended_release(sem);
>  		rwsem_wake(sem);
>  	}
>  	preempt_enable();
> @@ -1383,8 +1384,10 @@ static inline void __up_write(struct rw_semaphore *sem)
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
> @@ -1407,8 +1410,10 @@ static inline void __downgrade_write(struct rw_semaphore *sem)
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
> index 3ef032e22f7e..3cef5ba88f7e 100644
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

