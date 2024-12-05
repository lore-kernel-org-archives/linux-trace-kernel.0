Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7786B218E98;
	Thu,  5 Dec 2024 17:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733420804; cv=none; b=Lmdx5WKvWW/rd2RpxzNo450RS5CQ1KwuMQJTMNbdKsZr6OjoSVz8U3HSBMLcCgfpEZk/BzDWRQh1zuOCtlRP9jsYuUk/3845vyVTMo8NoRWg3fDqV3Tne3HcYI2bX9P2JFF0DO7KT4x9eFUHM0xKKqffW8hDVU60yAVHZvjRQIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733420804; c=relaxed/simple;
	bh=1GB7GH1J9M+3yZmb5D+sIaRJ5z6tUwPPtG6cgVQchio=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BUvmIqpPib/4IUJFGYN/VSIoSAsiVJbkzM8/MFVRFVn393vrNH7+jTSK+z0cId9YGrM70KtZMRmx2AdJOFn2Ng/2mUB+xYT/U8GmINqKM7x/T5933U8Z1+F/GSzRI+ZxPWADDAOCYiA8niT1wVlkkcRZGN6bdNwAoHB0gLt+W5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8A19C4CED1;
	Thu,  5 Dec 2024 17:46:39 +0000 (UTC)
Date: Thu, 5 Dec 2024 12:46:45 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Raghavendra K T <raghavendra.kt@amd.com>
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <gourry@gourry.net>, <nehagholkar@meta.com>, <abhishekd@meta.com>,
 <david@redhat.com>, <ying.huang@intel.com>, <nphamcs@gmail.com>,
 <akpm@linux-foundation.org>, <hannes@cmpxchg.org>, <feng.tang@intel.com>,
 <kbusch@meta.com>, <bharata@amd.com>, <Hasan.Maruf@amd.com>,
 <sj@kernel.org>, <willy@infradead.org>, <kirill.shutemov@linux.intel.com>,
 <mgorman@techsingularity.net>, <vbabka@suse.cz>, <hughd@google.com>,
 <rientjes@google.com>, <shy828301@gmail.com>, <Liam.Howlett@Oracle.com>,
 <peterz@infradead.org>, <mingo@redhat.com>, "Masami Hiramatsu"
 <mhiramat@kernel.org>, <linux-trace-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH V0 09/10] trace/kmmscand: Add tracing of scanning
 and migration
Message-ID: <20241205124645.0d56ea57@gandalf.local.home>
In-Reply-To: <20241201153818.2633616-10-raghavendra.kt@amd.com>
References: <20241201153818.2633616-1-raghavendra.kt@amd.com>
	<20241201153818.2633616-10-raghavendra.kt@amd.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 1 Dec 2024 15:38:17 +0000
Raghavendra K T <raghavendra.kt@amd.com> wrote:

> Add tracing support to track
>  - start and end of scanning.
>  - migration.
> 
> CC: Steven Rostedt <rostedt@goodmis.org>
> CC: Masami Hiramatsu <mhiramat@kernel.org>
> CC: linux-trace-kernel@vger.kernel.org
> 
> Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
> ---
>  include/trace/events/kmem.h | 99 +++++++++++++++++++++++++++++++++++++
>  mm/kmmscand.c               | 12 ++++-
>  2 files changed, 110 insertions(+), 1 deletion(-)
> 
> diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
> index b37eb0a7060f..80978d85300d 100644
> --- a/include/trace/events/kmem.h
> +++ b/include/trace/events/kmem.h
> @@ -9,6 +9,105 @@
>  #include <linux/tracepoint.h>
>  #include <trace/events/mmflags.h>
>  
> +TRACE_EVENT(kmem_mm_enter,
> +
> +	TP_PROTO(struct task_struct *t,
> +		 struct mm_struct *mm),
> +
> +	TP_ARGS(t, mm),
> +
> +	TP_STRUCT__entry(
> +		__array(	char, comm, TASK_COMM_LEN	)

Is there a reason to record "comm"? There's other ways to retrieve it than
to always write it to the ring buffer.

> +		__field(	struct mm_struct *, mm		)
> +	),
> +
> +	TP_fast_assign(
> +		memcpy(__entry->comm, t->comm, TASK_COMM_LEN);
> +		__entry->mm = mm;
> +	),
> +
> +	TP_printk("kmmscand: mm_enter comm =%s mm=%p", __entry->comm, __entry->mm)
> +);
> +
> +TRACE_EVENT(kmem_scan_mm_start,
> +
> +	TP_PROTO(struct task_struct *t,
> +		 struct mm_struct *mm),
> +
> +	TP_ARGS(t, mm),
> +
> +	TP_STRUCT__entry(
> +		__array(	char, comm, TASK_COMM_LEN	)
> +		__field(	struct mm_struct *, mm		)
> +	),
> +
> +	TP_fast_assign(
> +		memcpy(__entry->comm, t->comm, TASK_COMM_LEN);
> +		__entry->mm = mm;
> +	),
> +
> +	TP_printk("kmmscand: scan_mm_start comm =%s mm=%p", __entry->comm, __entry->mm)

No need to write the event name into the TP_printk(). That's redundant.

Also, the above two events are pretty much identical. Please use
DECLARE_EVENT_CLASS().

> +);
> +
> +TRACE_EVENT(kmem_scan_mm_end,
> +
> +	TP_PROTO(struct task_struct *t,
> +		 struct mm_struct *mm,
> +		 unsigned long start,
> +		 unsigned long total,
> +		 unsigned long scan_size,
> +		 unsigned long scan_period),
> +
> +	TP_ARGS(t, mm, start, total, scan_period, scan_size),
> +
> +	TP_STRUCT__entry(
> +		__array(	char, comm, TASK_COMM_LEN	)

Again, why comm?

> +		__field(	struct mm_struct *, mm		)
> +		__field(	unsigned long,   start		)
> +		__field(	unsigned long,   total		)
> +		__field(	unsigned long,   scan_period	)
> +		__field(	unsigned long,   scan_size	)
> +	),
> +
> +	TP_fast_assign(
> +		memcpy(__entry->comm, t->comm, TASK_COMM_LEN);
> +		__entry->mm = mm;
> +		__entry->start = start;
> +		__entry->total = total;
> +		__entry->scan_period = scan_period;
> +		__entry->scan_size = scan_size;
> +	),
> +
> +	TP_printk("kmmscand: scan_mm_end comm =%s mm=%p, start = %ld, total = %ld, scan_period = %ld, scan_size = %ld",
> +			__entry->comm, __entry->mm, __entry->start,
> +			__entry->total, __entry->scan_period, __entry->scan_size)
> +);
> +
> +TRACE_EVENT(kmem_scan_mm_migrate,
> +
> +	TP_PROTO(struct task_struct *t,
> +		 struct mm_struct *mm,
> +		 int rc),
> +
> +	TP_ARGS(t, mm, rc),
> +
> +	TP_STRUCT__entry(
> +		__array(	char, comm, TASK_COMM_LEN	)
> +		__field(	struct mm_struct *, mm		)
> +		__field(	int,   rc			)
> +	),
> +
> +	TP_fast_assign(
> +		memcpy(__entry->comm, t->comm, TASK_COMM_LEN);
> +		__entry->mm = mm;
> +		__entry->rc = rc;
> +	),
> +
> +	TP_printk("kmmscand: scan_mm_migrate comm =%s mm=%p rc=%d", __entry->comm,
> +			__entry->mm, __entry->rc)
> +);
> +
> +
>  TRACE_EVENT(kmem_cache_alloc,
>  
>  	TP_PROTO(unsigned long call_site,
> diff --git a/mm/kmmscand.c b/mm/kmmscand.c
> index 682c0523c0b4..70f588a210dd 100644
> --- a/mm/kmmscand.c
> +++ b/mm/kmmscand.c
> @@ -668,8 +668,10 @@ static void kmmscand_migrate_folio(void)
>  			WRITE_ONCE(kmmscand_cur_migrate_mm, info->mm);
>  			spin_unlock(&kmmscand_migrate_lock);
>  
> -			if (info->mm)
> +			if (info->mm) {
>  				ret = kmmscand_promote_folio(info);
> +				trace_kmem_scan_mm_migrate(info->mm->owner, info->mm, ret);
> +			}
>  
>  			/* TBD: encode migrated count here, currently assume folio_nr_pages */
>  			if (!ret)
> @@ -828,6 +830,9 @@ static unsigned long kmmscand_scan_mm_slot(void)
>  		goto outerloop;
>  	}
>  
> +	if (mm->owner)
> +		trace_kmem_scan_mm_start(mm->owner, mm);
> +
>  	now = jiffies;
>  	/*
>  	 * Dont scan if :
> @@ -868,6 +873,10 @@ static unsigned long kmmscand_scan_mm_slot(void)
>  
>  	update_mmslot_info = true;
>  
> +	if (mm->owner)
> +		trace_kmem_scan_mm_end(mm->owner, mm, address, total,
> +					mm_slot_scan_period, mm_slot_scan_size);

Please do not add conditions that is used just for calling a tracepoint.
That takes away the "nop" of the function. You can either use
TRACE_EVENT_CONDITION() or DEFINE_EVENT_CONDITION(), or you can hard code
it here:

	if (trace_kmem_scan_mm_end_enabled()) {
		if (mm->owner)
			trace_kmem_scan_mm_end(mm->owner, mm, address, total,
						mm_slot_scan_period, mm_slot_scan_size);
	}

But since it is a single condition, I would prefer the *_CONDITION() macros
above.

-- Steve

> +
>  	count_kmmscand_mm_scans();
>  
>  outerloop:
> @@ -1020,6 +1029,7 @@ void __kmmscand_enter(struct mm_struct *mm)
>  	spin_unlock(&kmmscand_mm_lock);
>  
>  	mmgrab(mm);
> +	trace_kmem_mm_enter(mm->owner, mm);
>  	if (wakeup)
>  		wake_up_interruptible(&kmmscand_wait);
>  }

