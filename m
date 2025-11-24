Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD53F8634F;
	Mon, 24 Nov 2025 20:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764016378; cv=none; b=kAV2Z+WLnsZI3lECpk2BjnohZa1d0q8L6sVL1GFC13wkUYj3jCRz+TN6obD2nRiQ1p7OzBCV5P7CdLC2i2dnR/pWcPA2gJUvIMKtGtPQ6W9RBdE5XdHlGuhiWV6U0Cu1q1PvaAbMvxHVIteLc/MXnQy846IVJ63WF8Va0QVkILk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764016378; c=relaxed/simple;
	bh=SW5mB19KcCbD517Tw6GcZnSp8cmMmirUCnlI5rVt2dI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K+i8pD8ujOPdjVyndltUDfOmGFLQTXuZWG8OYkKoSZTkUxmzROUmBPusNSSNwfaFXkSDMwJGl6ogitjYQDVzSmguKlcGsbkikThdZTmP+ZEG03cmYn9sZqMwxShUWFtuiI+gSgB0V3nQpgHdb8bghu7pfKYSxEIednOu+o70ch0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id A703C13095E;
	Mon, 24 Nov 2025 20:32:53 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id 108BB18;
	Mon, 24 Nov 2025 20:32:49 +0000 (UTC)
Date: Mon, 24 Nov 2025 15:33:31 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: linux-kernel@vger.kernel.org, Jiayuan Chen <jiayuan.chen@shopee.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel Gorman
 <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Andrii
 Nakryiko <andrii@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Gabriele
 Monaco <gmonaco@redhat.com>, Libo Chen <libo.chen@oracle.com>,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v1] sched/numa: Add tracepoint to track NUMA migration
 cost
Message-ID: <20251124153331.465306a2@gandalf.local.home>
In-Reply-To: <20251029132300.23519-1-jiayuan.chen@linux.dev>
References: <20251029132300.23519-1-jiayuan.chen@linux.dev>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 5bxtt6nigocbr7xqwy1jeo9ueac67jy6
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 108BB18
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/evyh+gor9tOSSSwJdOQYB4Ah5gXylHTY=
X-HE-Tag: 1764016369-195077
X-HE-Meta: U2FsdGVkX18Q8xMcQfgsS+nsd0Il0bBrvD2T8DfAxxa+1wjX2340nKgxXzuKXUkBHJSZ8JDi8NpNhx3JZcbyKyaM/vuECpRc5KGDWMFZeRVNZfjm5+gRrNqkQmXyGFMDJeByt0m9wz5HgCaDklFdRaeH8AKd6ZO4sB+fsgoHPeNqJgALkX7DFXU9NnoDdMQ8KNw6S1rTsuhQyWkCiSTtBs65KNufMWjBYYhm+RUJX6dmxOp/ha/ziFRoa0Ybd0tCsi9ZsQ/g4foOgQf0O9Zxbb7awGarXO1EQ90sJWYxKQrtQfV2Di7rYYbl3XBu/0KnM90kXibsd74l6PhMSXn09eIM0LW20eTLAVwK12qF8BMBBI9W+hVhyYGcDN7RXjPO

On Wed, 29 Oct 2025 21:22:55 +0800
Jiayuan Chen <jiayuan.chen@linux.dev> wrote:

> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> 
> In systems with multiple NUMA nodes, memory imbalance between nodes often
> occurs.  To address this, we typically tune parameters like scan_size_mb or
> scan_period_{min,max}_ms to allow processes to migrate pages between NUMA
> nodes.
> 
> Currently, the migration task task_numa_work() holds the mmap_lock during
> the entire migration process, which can significantly impact process
> performance, especially for memory operations. This patch introduces a new
> tracepoint that records the migration duration, along with the number of
> scanned pages and migrated pages. These metrics can be used to calculate
> efficiency metrics similar to %vmeff in 'sar -B'.
> 
> These metrics help evaluate whether the adjusted NUMA balancing parameters
> are properly tuned.
> 
> Here's an example bpftrace script:
> ```bash
> 
> bpftrace -e '
> tracepoint:sched:sched_numa_balance_start
> {
>     @start_time[cpu] = nsecs;
> }
> 
> tracepoint:sched:sched_numa_balance_end {
>     if (@start_time[cpu] > 0) {
>         $cost = nsecs - @start_time[cpu];
>         printf("task '%s' migrate cost %lu, scanned %lu, migrated %lu\n",
>                args.comm, $cost, args.scanned, args.migrated);
>     }
> }
> '

BTW, you don't need bpf for this either:

  # trace-cmd sqlhist -e -n numa_balance SELECT end.comm, TIMESTAMP_DELTA_USECS as cost, \
            end.scanned, end.migrated FROM sched_numa_balance_start AS start \
            JOIN sched_numa_balance_end AS end ON start.common_pid = end.common_pid

  # trace-cmd start -e numa_balance

[ I'd show the output, but my test boxes don't have NUMA ]

You could also make a histogram with it:

  # trace-cmd sqlhist -e SELECT start.comm, 'CAST(start.cost AS BUCKETS=50)' FROM numa_balance AS start

And then cat /sys/kernel/tracing/events/synthetic/numa_balance/hist

Just to give you an idea.


> ```
> Sample output:
> Attaching 2 probes...
> task 'rs:main Q:Reg' migrate cost 5584655, scanned 24516, migrated 22373
> task 'systemd-journal' migrate cost 123191, scanned 6308, migrated 0
> task 'wrk' migrate cost 894026, scanned 5842, migrated 5841
> 
> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
> ---
>  include/trace/events/sched.h | 60 ++++++++++++++++++++++++++++++++++++
>  kernel/sched/fair.c          | 14 +++++++--
>  2 files changed, 72 insertions(+), 2 deletions(-)
> 
> diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> index 7b2645b50e78..e24bf700a614 100644
> --- a/include/trace/events/sched.h
> +++ b/include/trace/events/sched.h
> @@ -804,6 +804,66 @@ TRACE_EVENT(sched_skip_cpuset_numa,
>  		  __entry->ngid,
>  		  MAX_NUMNODES, __entry->mem_allowed)
>  );
> +
> +TRACE_EVENT(sched_numa_balance_start,
> +
> +	TP_PROTO(struct task_struct *tsk),
> +
> +	TP_ARGS(tsk),
> +
> +	TP_STRUCT__entry(
> +		__array(char,	comm, TASK_COMM_LEN)

Please use __string() and not __array(). I'm trying to get rid of these for
task comm.

> +		__field(pid_t,	pid)
> +		__field(pid_t,	tgid)
> +		__field(pid_t,	ngid)
> +	),
> +
> +	TP_fast_assign(
> +		memcpy(__entry->comm, tsk->comm, TASK_COMM_LEN);
> +		__entry->pid		 = task_pid_nr(tsk);
> +		__entry->tgid		 = task_tgid_nr(tsk);
> +		__entry->ngid		 = task_numa_group_id(tsk);
> +	),
> +
> +	TP_printk("comm=%s pid=%d tgid=%d ngid=%d",
> +		  __entry->comm,
> +		  __entry->pid,
> +		  __entry->tgid,
> +		  __entry->ngid)
> +);
> +
> +TRACE_EVENT(sched_numa_balance_end,
> +
> +	TP_PROTO(struct task_struct *tsk, unsigned long scanned, unsigned long migrated),
> +
> +	TP_ARGS(tsk, scanned, migrated),
> +
> +	TP_STRUCT__entry(
> +		__array(char,		comm, TASK_COMM_LEN)
> +		__field(pid_t,		pid)
> +		__field(pid_t,		tgid)
> +		__field(pid_t,		ngid)
> +		__field(unsigned long,	migrated)
> +		__field(unsigned long,	scanned)
> +	),
> +
> +	TP_fast_assign(
> +		memcpy(__entry->comm, tsk->comm, TASK_COMM_LEN);
> +		__entry->pid		 = task_pid_nr(tsk);
> +		__entry->tgid		 = task_tgid_nr(tsk);
> +		__entry->ngid		 = task_numa_group_id(tsk);
> +		__entry->migrated	 = migrated;
> +		__entry->scanned	 = scanned;
> +	),
> +
> +	TP_printk("comm=%s pid=%d tgid=%d ngid=%d scanned=%lu migrated=%lu",
> +		  __entry->comm,
> +		  __entry->pid,
> +		  __entry->tgid,
> +		  __entry->ngid,
> +		  __entry->scanned,
> +		  __entry->migrated)
> +);
>  #endif /* CONFIG_NUMA_BALANCING */
>  
>  /*
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 25970dbbb279..173c9c8397e2 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3294,6 +3294,9 @@ static void task_numa_work(struct callback_head *work)
>  	struct vm_area_struct *vma;
>  	unsigned long start, end;
>  	unsigned long nr_pte_updates = 0;
> +	unsigned long nr_scanned = 0;
> +	unsigned long total_migrated = 0;
> +	unsigned long total_scanned = 0;
>  	long pages, virtpages;
>  	struct vma_iterator vmi;
>  	bool vma_pids_skipped;
> @@ -3359,6 +3362,7 @@ static void task_numa_work(struct callback_head *work)
>  	if (!mmap_read_trylock(mm))
>  		return;
>  
> +	trace_sched_numa_balance_start(p);
>  	/*
>  	 * VMAs are skipped if the current PID has not trapped a fault within
>  	 * the VMA recently. Allow scanning to be forced if there is no
> @@ -3477,6 +3481,10 @@ static void task_numa_work(struct callback_head *work)
>  			end = min(end, vma->vm_end);
>  			nr_pte_updates = change_prot_numa(vma, start, end);
>  
> +			nr_scanned = (end - start) >> PAGE_SHIFT;
> +			total_migrated += nr_pte_updates;
> +			total_scanned += nr_scanned;
> +

This will require the scheduler maintainers agreeing on this for acceptance.

Will kprobes not due?

-- Steve


>  			/*
>  			 * Try to scan sysctl_numa_balancing_size worth of
>  			 * hpages that have at least one present PTE that
> @@ -3486,8 +3494,8 @@ static void task_numa_work(struct callback_head *work)
>  			 * areas faster.
>  			 */
>  			if (nr_pte_updates)
> -				pages -= (end - start) >> PAGE_SHIFT;
> -			virtpages -= (end - start) >> PAGE_SHIFT;
> +				pages -= nr_scanned;
> +			virtpages -= nr_scanned;
>  
>  			start = end;
>  			if (pages <= 0 || virtpages <= 0)
> @@ -3528,6 +3536,8 @@ static void task_numa_work(struct callback_head *work)
>  		mm->numa_scan_offset = start;
>  	else
>  		reset_ptenuma_scan(p);
> +
> +	trace_sched_numa_balance_end(p, total_scanned, total_migrated);
>  	mmap_read_unlock(mm);
>  
>  	/*

