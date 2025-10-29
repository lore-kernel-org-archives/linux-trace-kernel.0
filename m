Received: from localhost.localdomain (unknown [147.136.157.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80062139CE;
	Wed, 29 Oct 2025 13:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.136.157.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761744201; cv=none; b=bD88G4KXyAxddKx1SxVooGVvbNqpIbh66MX1kNOiS/VkMJFVoEFyfyFLGl5wqB4YIEREICI6lg41GlklDLP2nUk3OhsWcH547CaYj3+2PuxTTDaDqLLEvXn38Qw8FXGEJ4r9FnnKm5Ww44s1e8gMucM1PSl19BB5LoqIiwJfQrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761744201; c=relaxed/simple;
	bh=pchtt63Oh3F2HNObMqsCdLZ8QHoH/Yw2B2nuwJg8ogw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bhYN8eZkSShuhX7e0xjZPKg5MjOObLSpD01JQ59DBMa4TXcjvRDrXa8qYg/WRzS6lG8gRO+K6juevPOvCeg0x3AzFBPuvapYzq4QiIcGU8GaxkjCFLyPP5m6rJs08M9sXX06TYbDYR9A/CAP/Mq68F0Ek5GwBeYDFtEj2SfAZPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=none smtp.mailfrom=localhost.localdomain; arc=none smtp.client-ip=147.136.157.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=localhost.localdomain
Received: by localhost.localdomain (Postfix, from userid 1007)
	id C6E1F8B2A0E; Wed, 29 Oct 2025 21:23:11 +0800 (+08)
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Libo Chen <libo.chen@oracle.com>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v1] sched/numa: Add tracepoint to track NUMA migration cost
Date: Wed, 29 Oct 2025 21:22:55 +0800
Message-ID: <20251029132300.23519-1-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiayuan Chen <jiayuan.chen@shopee.com>

In systems with multiple NUMA nodes, memory imbalance between nodes often
occurs.  To address this, we typically tune parameters like scan_size_mb or
scan_period_{min,max}_ms to allow processes to migrate pages between NUMA
nodes.

Currently, the migration task task_numa_work() holds the mmap_lock during
the entire migration process, which can significantly impact process
performance, especially for memory operations. This patch introduces a new
tracepoint that records the migration duration, along with the number of
scanned pages and migrated pages. These metrics can be used to calculate
efficiency metrics similar to %vmeff in 'sar -B'.

These metrics help evaluate whether the adjusted NUMA balancing parameters
are properly tuned.

Here's an example bpftrace script:
```bash

bpftrace -e '
tracepoint:sched:sched_numa_balance_start
{
    @start_time[cpu] = nsecs;
}

tracepoint:sched:sched_numa_balance_end {
    if (@start_time[cpu] > 0) {
        $cost = nsecs - @start_time[cpu];
        printf("task '%s' migrate cost %lu, scanned %lu, migrated %lu\n",
               args.comm, $cost, args.scanned, args.migrated);
    }
}
'
```
Sample output:
Attaching 2 probes...
task 'rs:main Q:Reg' migrate cost 5584655, scanned 24516, migrated 22373
task 'systemd-journal' migrate cost 123191, scanned 6308, migrated 0
task 'wrk' migrate cost 894026, scanned 5842, migrated 5841

Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
---
 include/trace/events/sched.h | 60 ++++++++++++++++++++++++++++++++++++
 kernel/sched/fair.c          | 14 +++++++--
 2 files changed, 72 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 7b2645b50e78..e24bf700a614 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -804,6 +804,66 @@ TRACE_EVENT(sched_skip_cpuset_numa,
 		  __entry->ngid,
 		  MAX_NUMNODES, __entry->mem_allowed)
 );
+
+TRACE_EVENT(sched_numa_balance_start,
+
+	TP_PROTO(struct task_struct *tsk),
+
+	TP_ARGS(tsk),
+
+	TP_STRUCT__entry(
+		__array(char,	comm, TASK_COMM_LEN)
+		__field(pid_t,	pid)
+		__field(pid_t,	tgid)
+		__field(pid_t,	ngid)
+	),
+
+	TP_fast_assign(
+		memcpy(__entry->comm, tsk->comm, TASK_COMM_LEN);
+		__entry->pid		 = task_pid_nr(tsk);
+		__entry->tgid		 = task_tgid_nr(tsk);
+		__entry->ngid		 = task_numa_group_id(tsk);
+	),
+
+	TP_printk("comm=%s pid=%d tgid=%d ngid=%d",
+		  __entry->comm,
+		  __entry->pid,
+		  __entry->tgid,
+		  __entry->ngid)
+);
+
+TRACE_EVENT(sched_numa_balance_end,
+
+	TP_PROTO(struct task_struct *tsk, unsigned long scanned, unsigned long migrated),
+
+	TP_ARGS(tsk, scanned, migrated),
+
+	TP_STRUCT__entry(
+		__array(char,		comm, TASK_COMM_LEN)
+		__field(pid_t,		pid)
+		__field(pid_t,		tgid)
+		__field(pid_t,		ngid)
+		__field(unsigned long,	migrated)
+		__field(unsigned long,	scanned)
+	),
+
+	TP_fast_assign(
+		memcpy(__entry->comm, tsk->comm, TASK_COMM_LEN);
+		__entry->pid		 = task_pid_nr(tsk);
+		__entry->tgid		 = task_tgid_nr(tsk);
+		__entry->ngid		 = task_numa_group_id(tsk);
+		__entry->migrated	 = migrated;
+		__entry->scanned	 = scanned;
+	),
+
+	TP_printk("comm=%s pid=%d tgid=%d ngid=%d scanned=%lu migrated=%lu",
+		  __entry->comm,
+		  __entry->pid,
+		  __entry->tgid,
+		  __entry->ngid,
+		  __entry->scanned,
+		  __entry->migrated)
+);
 #endif /* CONFIG_NUMA_BALANCING */
 
 /*
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 25970dbbb279..173c9c8397e2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3294,6 +3294,9 @@ static void task_numa_work(struct callback_head *work)
 	struct vm_area_struct *vma;
 	unsigned long start, end;
 	unsigned long nr_pte_updates = 0;
+	unsigned long nr_scanned = 0;
+	unsigned long total_migrated = 0;
+	unsigned long total_scanned = 0;
 	long pages, virtpages;
 	struct vma_iterator vmi;
 	bool vma_pids_skipped;
@@ -3359,6 +3362,7 @@ static void task_numa_work(struct callback_head *work)
 	if (!mmap_read_trylock(mm))
 		return;
 
+	trace_sched_numa_balance_start(p);
 	/*
 	 * VMAs are skipped if the current PID has not trapped a fault within
 	 * the VMA recently. Allow scanning to be forced if there is no
@@ -3477,6 +3481,10 @@ static void task_numa_work(struct callback_head *work)
 			end = min(end, vma->vm_end);
 			nr_pte_updates = change_prot_numa(vma, start, end);
 
+			nr_scanned = (end - start) >> PAGE_SHIFT;
+			total_migrated += nr_pte_updates;
+			total_scanned += nr_scanned;
+
 			/*
 			 * Try to scan sysctl_numa_balancing_size worth of
 			 * hpages that have at least one present PTE that
@@ -3486,8 +3494,8 @@ static void task_numa_work(struct callback_head *work)
 			 * areas faster.
 			 */
 			if (nr_pte_updates)
-				pages -= (end - start) >> PAGE_SHIFT;
-			virtpages -= (end - start) >> PAGE_SHIFT;
+				pages -= nr_scanned;
+			virtpages -= nr_scanned;
 
 			start = end;
 			if (pages <= 0 || virtpages <= 0)
@@ -3528,6 +3536,8 @@ static void task_numa_work(struct callback_head *work)
 		mm->numa_scan_offset = start;
 	else
 		reset_ptenuma_scan(p);
+
+	trace_sched_numa_balance_end(p, total_scanned, total_migrated);
 	mmap_read_unlock(mm);
 
 	/*
-- 
2.43.0

