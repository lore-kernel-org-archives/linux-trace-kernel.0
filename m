Received: from mta1.migadu.com (out-44.mta1.migadu.com [95.215.58.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C324637BE93
	for <linux-trace-kernel@vger.kernel.org>; Wed, 19 Aug 2026 17:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787160538; cv=none; b=ho0IuqkbIoP+J687GNBf1m3wNzIq4Zx+2xpq7DF3h0Mn5e1Yt+llWAD0ntfEy4Al09cicRCC0JyGSPUcGuQ3Vj+8oWg3b5XWF30kWsM3R/bDDmzHolYTnvu3xEYMctBnLV6r5MDyYf4WjWhzV7Gc+d8VO3Kq2JVGrVkxP1zR8Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787160538; c=relaxed/simple;
	bh=g3lcXJeSq1Zk4YQXSbf7TCZ5uXRcVcwca2QGvEtKrpY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kEew2i++fE+sL28693Yri5aJCEzXkB4+1GwNUfTzcmJq8ZkSchwzUeK8ccRSNWiN/mMB/LnNrvJjSHpZYk+DjOEWRjUvkZbnY+vPIXVx/UrJjZ92ppiXQ6yWu17moPDl6B6nddqQoBjKwPGzev4IxL1wF+Gho6718OyZQOIpG4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OeQK1TDB; arc=none smtp.client-ip=95.215.58.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OeQK1TDB"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=g3lcXJeSq1Zk4YQXSbf7TCZ5uXRcVcwca2QGvEtKrpY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787160532; v=1; x=1787765332;
 b=OeQK1TDBjnE3Jowkmp37QWNDgqeQj6RXoIfxiEqn+Z0KXsRCOXQI5XlrgM5r8eVOgTqU7nkj
 gV5Sq2Uvo99HZkYs8dUM9VdVo4G234CMH+D1gB2PSVcVH7oYUOkfnzOLAwgnGKn8ECtE/VH2s0u
 DDTQR9UgA2GVoViDn/8yO8L0=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: from [192.168.1.71] (218.1.223.168)
	by smtp.migadu.com with ESMTPS id 2a23afa2a303163f;
	Wed, 19 Aug 2026 17:28:52 +0000
X-Mizu-Trace-ID: 2a23afa2a303163f
X-Migadu-Flow: FLOW_OUT
Message-ID: <d72daef4-5d68-49e4-a264-3f813d897813@linux.dev>
Date: Thu, 20 Aug 2026 01:28:45 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] rv/reactors: use context-sensitive lockdep wait
 type in rv_react()
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1786294920.git.wen.yang@linux.dev>
 <26526e555baa5118325b2383e9f7f0f8f9b6a199.1786294920.git.wen.yang@linux.dev>
 <38decc4f7ef5b6f03b37705c7e97f22a7e40d7e2.camel@redhat.com>
 <87zeylnos3.fsf@yellow.woof>
 <b6de8228ee3045104a03ab4754e5ecc50e67f627.camel@redhat.com>
 <20260819112038-e7b033f8-3711-4acd-ba05-dbef015c6fc8@linutronix.de>
Content-Language: en-US
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <20260819112038-e7b033f8-3711-4acd-ba05-dbef015c6fc8@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/19/26 17:24, Thomas Weißschuh wrote:
> On Wed, Aug 19, 2026 at 09:12:43AM +0200, Gabriele Monaco wrote:
>> On Mon, 2026-08-17 at 10:18 +0200, Nam Cao wrote:
>>> Gabriele Monaco <gmonaco@redhat.com> writes:
>>>
>>>> On Mon, 2026-08-10 at 01:10 +0800, wen.yang@linux.dev wrote:
>>>>> From: Wen Yang <wen.yang@linux.dev>
>>>>>
>>>>> Reactors must not explicitly take locks, so they should comply with
>>>>> LD_WAIT_FREE.  However, reactor callbacks can run with preemption
>>>>> enabled on any kernel (not just PREEMPT_RT).  If a timer interrupt
>>>>> fires during the callback, the interrupt exit path schedules and
>>>>> acquires rq->__lock (LD_WAIT_SPIN) while the lockdep override map that
>>>>> declared LD_WAIT_FREE is still held, triggering a spurious
>>>>> "Invalid wait context" warning:
>>> ...
>>>> Anyway, I'd appreciate comments/acks from the other folks in the loop
>>>
>>> Sorry, I do not know enough about lockdep to comment on this.
>>>
>>> FWIW, I would rather just use LD_WAIT_SPIN and keep things
>>> simple. Context-sensitive code paths "feels wrong" to me. Spinning
>>> should either be allowed or forbidden. Making it dynamic "feels like" it
>>> will bring further complications down the road.
> 
> To me the dynamic logic also feels quite complicated.
> We could also disable preemption before overriding the lockdep context
> when lockdep is enabled to avoid the observed issue.
> 

Thanks,

rv_react() already has two callers in this tree that land in very
different places.
nrp attaches to local_timer_entry, which fires from inside the hardirq 
handler itself:

     DEFINE_IDTENTRY_SYSVEC(sysvec_apic_timer_interrupt)
       irq_enter_rcu()                  -> 
preempt_count_add(HARDIRQ_OFFSET)
       trace_local_timer_entry()
         handle_vector_irq_entry() -> da_handle_event() -> rv_react()

in_hardirq() is true for the whole of that rv_react() call.

While pagefault, on the other hand, attaches to page_fault_user, which 
only fires when the interrupted context was user mode -- i.e. 
preempt_count is guaranteed 0:

     exc_page_fault()
       trace_page_fault_user()
         handle_page_fault() -> ltl_atom_pulse() -> ... -> rv_react()

A timer tick can land inside that second one and there's nothing wrong
with it doing so.

So I don't think LD_WAIT_SPIN for everything is safe, it's not just 
"less strict on paper".
If a reactor ever does raw_spin_lock() by mistake while running from 
nrp's path, check_wait_context() takes the wait type straight from the 
override map:

     if (unlikely(class->lock_type == LD_LOCK_WAIT_OVERRIDE))
             curr_inner = prev_inner;        /* SPIN */
     if (next_outer > curr_inner)
             return print_lock_invalid_wait_context(...);

SPIN nested in SPIN is 2 > 2, which is false, so it just passes.
We'd be silently giving up the one case (hardirq/NMI) where the "no 
locks" rule for reactors actually matters, which is the same thing that 
bit you with the signal reactor.

And for what it's worth, checking context to decide the wait type isn't 
something we'd be introducing -- lockdep does the same thing to get the 
baseline before any override is applied, in the exact function that 
produced this splat:

     static inline short task_wait_context(struct task_struct *curr)
     {
             if (lockdep_hardirq_context()) {
                     if (curr->hardirq_threaded || curr->irq_config)
                             return LD_WAIT_CONFIG;
                     return LD_WAIT_SPIN;
             } else if (curr->softirq_context) {
                     return LD_WAIT_CONFIG;
             }
             return LD_WAIT_MAX;
     }

That's four cases. Our in_nmi() || in_hardirq() is a simplification of
what's already there, not a new habit.

Thomas, on disabling preemption instead: it does fix the pagefault
case, and it's a no-op for nrp since preempt_count is already elevated 
there. But it changes what a reactor is allowed to do, for every 
reactor, not just the two above.cspin_lock() on RT checks 
might_resched() before it even looks at thevlock:

     static __always_inline void __rt_spin_lock(spinlock_t *lock)
     {
             rtlock_might_resched();   /* unconditional */
             rtlock_lock(&lock->lock);
     }

so any future reactor using a plain spinlock would hit that every single 
time, lock contended or not, on top of whatever it's already called for. 
That seems worse than the thing we're trying to fix.

Since neither struct rv_reactor nor rv_react() actually documents what
context a callback may run in, maybe that's worth spelling out
separately regardless of what we do here -- something close to what
printk already does for the same reason (reactor_printk's
vprintk_deferred() leans on this internally: is_printk_legacy_deferred()
checks in_nmi() to decide whether it's safe to take console_lock or
whether it has to go through the lock-free irq_work path instead).

A reactor that wants to do more than printk/panic would follow the same 
shape:

     static void some_reactor(const char *msg, va_list args)
     {
             if (atomic_cmpxchg(&pending, 0, 1) == 0)
                     irq_work_queue(&my_irq_work);   /* NMI-safe */
     }

     static void some_irq_work_fn(struct irq_work *work)
     {
             schedule_work(&my_work);   /* spin_lock()/mutex_lock() now 
fine */
     }


Please let me know if there are any concerns or if further changes are 
needed.


--
Best wishes,
Wen


>>> But that's just my intuition.
>>
>> I don't have a strong opinion on this, but since there's no one in the kernel
>> using LD_WAIT_FREE as inner type, that feels like a hint to go down the simple
>> route too and allow LD_WAIT_SPIN.
>>
>> If a reactor ever uses spinlocks, lockdep would already complain on its own if
>> that ends up being an issue, wouldn't it?
> 
> Only if that reactor is actually triggered by a tracepoint in the wrong context.
> This might not happen during testing. This happened to me in my signal reactor
> patch, which is why I added the lockdep override.
> 
> 
> Thomas
