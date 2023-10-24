Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7837498
	for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Oct 2023 11:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GkjvdFRd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D36BC433C9;
	Tue, 24 Oct 2023 11:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698145436;
	bh=YE9bMIc2HSQ9hhEnE16aYubKooXIYsxIKCdopNX1Sr8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GkjvdFRdPqaP3rncjFxg107KXGxETu4jiB0moWlX6pxvHN5tdaDqJmk1400p2kSfm
	 CORHjxCM525rBhwAtoOYkGKNo2w5u6QMOvu7gq0rph2TLQVPyCWHCSK7RdFCsgGSAT
	 JI5Ewy+C5kR0tOPu/s7OTYfq8hZOXgaXETnS/7rZ2HkdjYbIPa8EkUorJ+jqhQZA0/
	 VRLBk9sxWMyT6EJDluXPHceDVtYLDMEWvqXTOvmQxKJiQ9AJKYQM62YxwDe09dylWB
	 oAPnuaJ9cLUYeJV+2pi23jYFSMZ8DOCvXdcys7WD9cJhJcwxPtd62IpYyTN+LVqXF2
	 NO94Xt9K388fg==
Date: Tue, 24 Oct 2023 20:03:52 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "wuqiang.matt" <wuqiang.matt@bytedance.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 linux-trace-kernel@vger.kernel.org, davem@davemloft.net,
 anil.s.keshavamurthy@intel.com, naveen.n.rao@linux.ibm.com,
 peterz@infradead.org, akpm@linux-foundation.org, sander@svanheule.net,
 ebiggers@google.com, dan.j.williams@intel.com, jpoimboe@kernel.org,
 linux-kernel@vger.kernel.org, lkp@intel.com, mattwu@163.com
Subject: Re: [PATCH v1] lib,kprobes: using try_cmpxchg_local in objpool_push
Message-Id: <20231024200352.845f42812d9ef3dda0a18a79@kernel.org>
In-Reply-To: <ca8d6571-a67d-bc3c-5d34-2eae623bf985@bytedance.com>
References: <20231023112452.6290-1-wuqiang.matt@bytedance.com>
	<20231023114304.1bebb327@gandalf.local.home>
	<20231024100134.2dbabbf01f968a000507ba94@kernel.org>
	<ca8d6571-a67d-bc3c-5d34-2eae623bf985@bytedance.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Oct 2023 09:57:17 +0800
"wuqiang.matt" <wuqiang.matt@bytedance.com> wrote:

> On 2023/10/24 09:01, Masami Hiramatsu (Google) wrote:
> > On Mon, 23 Oct 2023 11:43:04 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> >> On Mon, 23 Oct 2023 19:24:52 +0800
> >> "wuqiang.matt" <wuqiang.matt@bytedance.com> wrote:
> >>
> >>> The objpool_push can only happen on local cpu node, so only the local
> >>> cpu can touch slot->tail and slot->last, which ensures the correctness
> >>> of using cmpxchg without lock prefix (using try_cmpxchg_local instead
> >>> of try_cmpxchg_acquire).
> >>>
> >>> Testing with IACA found the lock version of pop/push pair costs 16.46
> >>> cycles and local-push version costs 15.63 cycles. Kretprobe throughput
> >>> is improved to 1.019 times of the lock version for x86_64 systems.
> >>>
> >>> OS: Debian 10 X86_64, Linux 6.6rc6 with freelist
> >>> HW: XEON 8336C x 2, 64 cores/128 threads, DDR4 3200MT/s
> >>>
> >>>                   1T         2T         4T         8T        16T
> >>>    lock:    29909085   59865637  119692073  239750369  478005250
> >>>    local:   30297523   60532376  121147338  242598499  484620355
> >>>                  32T        48T        64T        96T       128T
> >>>    lock:   957553042 1435814086 1680872925 2043126796 2165424198
> >>>    local:  968526317 1454991286 1861053557 2059530343 2171732306
> >>>
> >>> Signed-off-by: wuqiang.matt <wuqiang.matt@bytedance.com>
> >>> ---
> >>>   lib/objpool.c | 2 +-
> >>>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/lib/objpool.c b/lib/objpool.c
> >>> index ce0087f64400..a032701beccb 100644
> >>> --- a/lib/objpool.c
> >>> +++ b/lib/objpool.c
> >>> @@ -166,7 +166,7 @@ objpool_try_add_slot(void *obj, struct objpool_head *pool, int cpu)
> >>>   		head = READ_ONCE(slot->head);
> >>>   		/* fault caught: something must be wrong */
> >>>   		WARN_ON_ONCE(tail - head > pool->nr_objs);
> >>> -	} while (!try_cmpxchg_acquire(&slot->tail, &tail, tail + 1));
> >>> +	} while (!try_cmpxchg_local(&slot->tail, &tail, tail + 1));
> >>>   
> >>>   	/* now the tail position is reserved for the given obj */
> >>>   	WRITE_ONCE(slot->entries[tail & slot->mask], obj);
> >>
> >> I'm good with the change, but I don't like how "cpu" is passed to this
> >> function. It currently is only used in one location, which does:
> >>
> >> 	rc = objpool_try_add_slot(obj, pool, raw_smp_processor_id());
> >>
> >> Which makes this change fine. But there's nothing here to prevent someone
> >> for some reason passing another CPU to that function.
> >>
> >> If we are to make that change, I would be much more comfortable with
> >> removing "int cpu" as a parameter to objpool_try_add_slot() and adding:
> >>
> >> 	int cpu = raw_smp_processor_id();
> >>
> >> Which now shows that this function *only* deals with the current CPU.
> > 
> > Oh indeed. It used to search all CPUs to push the object, but
> > I asked him to stop that because there should be enough space to
> > push it in the local ring. This is a remnant of that time.
> 
> Yes, good catch. Thanks for the explanation.
> 
> > Wuqiang, can you make another patch to fix it?
> 
> I'm thinking of removing the inline function objpool_try_add_slot and merging
> its functionality to objpool_push, like the followings:

Looks good.

> 
> 
> /* reclaim an object to object pool */
> int objpool_push(void *obj, struct objpool_head *pool)
> {
> 	struct objpool_slot *slot;
> 	uint32_t head, tail;
> 	unsigned long flags;
> 
> 	/* disable local irq to avoid preemption & interruption */
> 	raw_local_irq_save(flags);
> 
> 	slot = pool->cpu_slots[raw_smp_processor_id()];
> 
> 	/* loading tail and head as a local snapshot, tail first */
> 	tail = READ_ONCE(slot->tail);
> 
> 	do {
> 		head = READ_ONCE(slot->head);
> 		/* fault caught: something must be wrong */
> 		WARN_ON_ONCE(tail - head > pool->nr_objs);
> 	} while (!try_cmpxchg_local(&slot->tail, &tail, tail + 1));
> 
> 	/* now the tail position is reserved for the given obj */
> 	WRITE_ONCE(slot->entries[tail & slot->mask], obj);
> 	/* update sequence to make this obj available for pop() */
> 	smp_store_release(&slot->last, tail + 1);
> 
> 	raw_local_irq_restore(flags);
> 
> 	return 0;
> }
> 
> I'll prepare a new patch for this improvement.

Thanks!

> 
> > Thank you,
> > 
> >>
> >> -- Steve
> > 
> 
> Thanks for your time,
> wuqiang


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
