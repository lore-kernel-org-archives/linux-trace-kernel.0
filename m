Received: from sender-pp-o91.zoho.in (sender-pp-o91.zoho.in [103.117.158.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B920D248F64
	for <linux-trace-kernel@vger.kernel.org>; Sun, 19 Jul 2026 18:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=103.117.158.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784487385; cv=pass; b=QXiiUZe9FRDNBvNZlHRk9Jh0a9PTses5nc5kiPO5guAbnCtLeYENWbUVFXUz/C/htjXu6IJAQ8q6o9pIXeLgU9+WvuJdtSUViD2mGvsbrbBKWk+SNz+VmQu4G+YsbJ2+15aEpOmqmI7yIdkBOSlHqei0VuW/4QffYPfpWkpT0rU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784487385; c=relaxed/simple;
	bh=r5G2wi50yD8h9o+0dBa0rO1l4YvK8s1tJBUzz2j94yk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B3mISkIRoWBlywnCFbRLgTqLkCSjnZRFWDedHVNx+mXv2Oba2OjZxXRoIxO5r538au63dJdFRhSLAJeCwojyMmaZwKr+2pzVCdCzTf9CsdP8gNyQvrTpV+PjJeGwRJuePd2EKTFeLgvdwCVDobrXEo6XuTj1CzGlrWlBCkh92b4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in; spf=pass smtp.mailfrom=zohomail.in; dkim=pass (1024-bit key) header.d=zohomail.in header.i=adi.sharma@zohomail.in header.b=YnW8pALY; arc=pass smtp.client-ip=103.117.158.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.in header.i=adi.sharma@zohomail.in header.b="YnW8pALY"
ARC-Seal: i=1; a=rsa-sha256; t=1784487288; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=Hg3KfhqrSbZ77reLafznqJhwV1LJSzO5mmcoXRp+JmqH1LlItiJruE8VW/W/1aDyRAoqh32F1e48HM1XC6ohw4TLFQjiziV78DYDC+bnMar0lNCcJK2p0MPrTBWUOPNklKb3SyVaCTNCvqhS7AxZdMjJFes5otKZ64i9Ee2gl2w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1784487288; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=oj9fDzX1wMrErAiwiqiXxnM4cGXgD5lIVRx7urULVtQ=; 
	b=G/beN0jv6Q8FIOuAqbFFROOF1nkiv8xTb2iZishK3qidN0iSg/pHWKgLGCi2cSPRRcx/PoGu+D/Hc+EUabM3CYQA6LTskvx/cNIZAN2bvTTbmphlPzxx2NKKkjHZqVFiScJ0IqHidhneoVhmN3C2H+bfSgTH8Gm7dcMh+8nUiwo=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=zohomail.in;
	spf=pass  smtp.mailfrom=adi.sharma@zohomail.in;
	dmarc=pass header.from=<adi.sharma@zohomail.in>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784487288;
	s=zoho; d=zohomail.in; i=adi.sharma@zohomail.in;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=oj9fDzX1wMrErAiwiqiXxnM4cGXgD5lIVRx7urULVtQ=;
	b=YnW8pALYKS+7BrhWfZSMS4owuUZYNoMgUCQiPgBceYMAA9mcp7oH2vkTqn7Azxuq
	HATY+/+WkSG7WqveYQ/CJRAqclFelyYI+bNA/Ud7IurKaWNtDInCNL26LMPBf8xJEIN
	hKMVys2fVq4gSF0M638PiWT2OJ7rM3PdtgMuUWV8=
Received: by mx.zoho.in with SMTPS id 1784487286510813.0873877162367;
	Mon, 20 Jul 2026 00:24:46 +0530 (IST)
From: Aditya Sharma <adi.sharma@zohomail.in>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>
Cc: David Rientjes <rientjes@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Kees Cook <kees@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imbrenda@linux.ibm.com,
	Aditya Sharma <adi.sharma@zohomail.in>
Subject: [RFC PATCH 6/7] mm: add tracepoints and vmstat counters for async teardown
Date: Mon, 20 Jul 2026 00:24:08 +0530
Message-Id: <20260719185409.409685-7-adi.sharma@zohomail.in>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260719185409.409685-1-adi.sharma@zohomail.in>
References: <20260719185409.409685-1-adi.sharma@zohomail.in>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Add observability for the deferred teardown path:

  - vmstat (CONFIG_ASYNC_MM_TEARDOWN, in /proc/vmstat):
    async_mm_teardown_queued   - deferred to the mm_reaper kthread
    async_mm_teardown_sync     - torn down inline on the exit path:
                                 feature off, mm below the RSS
                                 threshold, MMF_OOM_SKIP or
                                 MMF_OOM_TARGETED set, or rejected by
                                 backpressure. Counts only teardowns
                                 reaching mmput_exit(); final drops via
                                 mmput()/mmput_async() elsewhere in the
                                 kernel are inline but not counted here.
    async_mm_teardown_rejected - subset of the above that was eligible
                                 but lost to async_mm_teardown_reserve()
                                 (counted for both this and sync, so
                                 sync stays the total for the exit path)
  - tracepoints in a new include/trace/events/mm_reaper.h:
    mm_async_teardown_queue  at enqueue, and
    mm_async_teardown_reap   when the reaper picks an mm up, just before
                             __mmput(). queue carries the mm, its RSS,
                             and the exiting task's pid/comm, captured
                             while current is still that task, plus the
                             node of the exiting task. reap carries the
                             mm, the charged RSS (mm->async_reap_rss, the
                             amount mmput_exit() reserved and what the
                             pending-pages accounting releases), a fresh
                             live RSS read taken just before __mmput(),
                             and the node of the reaper. The gap between
                             charged and live measures how much reclaim
                             ate out of the queue before the reaper got
                             to it.

reap is emitted before __mmput() because the final mmdrop() inside
__mmput() may free the mm.

Signed-off-by: Aditya Sharma <adi.sharma@zohomail.in>
---
 include/linux/vm_event_item.h    |  5 +++
 include/trace/events/mm_reaper.h | 73 ++++++++++++++++++++++++++++++++
 kernel/fork.c                    | 14 +++++-
 mm/vmstat.c                      |  5 +++
 4 files changed, 95 insertions(+), 2 deletions(-)
 create mode 100644 include/trace/events/mm_reaper.h

diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index 2628ccda0..de4dc20b7 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -179,6 +179,11 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		NRSWPIN,
 		NRSWPOUT,
 #endif /* CONFIG_SWAP */
+#ifdef CONFIG_ASYNC_MM_TEARDOWN
+		ASYNC_MM_TEARDOWN_QUEUED,
+		ASYNC_MM_TEARDOWN_SYNC,
+		ASYNC_MM_TEARDOWN_REJECTED,
+#endif
 		NR_VM_EVENT_ITEMS
 };
 
diff --git a/include/trace/events/mm_reaper.h b/include/trace/events/mm_reaper.h
new file mode 100644
index 000000000..315bced7c
--- /dev/null
+++ b/include/trace/events/mm_reaper.h
@@ -0,0 +1,73 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM mm_reaper
+
+#if !defined(_TRACE_MM_REAPER_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_MM_REAPER_H
+
+#include <linux/tracepoint.h>
+#include <linux/sched.h>
+#include <linux/topology.h>
+
+TRACE_EVENT(mm_async_teardown_queue,
+
+	TP_PROTO(struct mm_struct *mm, unsigned long rss),
+
+	TP_ARGS(mm, rss),
+
+	TP_STRUCT__entry(
+		__field(struct mm_struct *, mm)
+		__field(int, pid)
+		__array(char, comm, TASK_COMM_LEN)
+		__field(unsigned long, rss)
+		__field(int, node)
+	),
+
+	TP_fast_assign(
+		__entry->mm = mm;
+		__entry->pid = current->pid;
+		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
+		__entry->rss = rss;
+		__entry->node = numa_node_id();
+	),
+
+	TP_printk("mm=%p pid=%d comm=%s rss=%lukB node=%d",
+		__entry->mm,
+		__entry->pid,
+		__entry->comm,
+		__entry->rss << (PAGE_SHIFT - 10),
+		__entry->node
+	)
+);
+
+TRACE_EVENT(mm_async_teardown_reap,
+
+	TP_PROTO(struct mm_struct *mm, unsigned long charged_rss, unsigned long live_rss),
+
+	TP_ARGS(mm, charged_rss, live_rss),
+
+	TP_STRUCT__entry(
+		__field(struct mm_struct *, mm)
+		__field(unsigned long, charged_rss)
+		__field(unsigned long, live_rss)
+		__field(int, node)
+	),
+
+	TP_fast_assign(
+		__entry->mm = mm;
+		__entry->charged_rss = charged_rss;
+		__entry->live_rss = live_rss;
+		__entry->node = numa_node_id();
+	),
+
+	TP_printk("mm=%p charged_rss=%lukB live_rss=%lukB node=%d",
+		__entry->mm,
+		__entry->charged_rss << (PAGE_SHIFT - 10),
+		__entry->live_rss << (PAGE_SHIFT - 10),
+		__entry->node
+	)
+);
+
+#endif /* _TRACE_MM_REAPER_H */
+
+#include <trace/define_trace.h>
diff --git a/kernel/fork.c b/kernel/fork.c
index 0976770db..4bdffa188 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -126,6 +126,9 @@
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/task.h>
+#ifdef CONFIG_ASYNC_MM_TEARDOWN
+#include <trace/events/mm_reaper.h>
+#endif
 
 #include <kunit/visibility.h>
 
@@ -3461,8 +3464,10 @@ static bool async_mm_teardown_reserve(unsigned long rss)
 	return true;
 }
 
-static void async_mm_teardown_queue(struct mm_struct *mm)
+static void async_mm_teardown_queue(struct mm_struct *mm, unsigned long rss)
 {
+	count_vm_event(ASYNC_MM_TEARDOWN_QUEUED);
+	trace_mm_async_teardown_queue(mm, rss);
 	if (llist_add(&mm->async_reap_node, &mm_reaper_list))
 		wake_up(&mm_reaper_wait);
 }
@@ -3478,6 +3483,9 @@ static int mm_reaper(void *unused)
 		batch = llist_del_all(&mm_reaper_list);
 		llist_for_each_entry_safe(mm, n, batch, async_reap_node) {
 			unsigned long pages = mm->async_reap_rss;
+			unsigned long live = get_mm_rss(mm);
+
+			trace_mm_async_teardown_reap(mm, pages, live);
 
 			__mmput(mm); /* may free mm via mmdrop */
 			atomic_long_sub(pages, &mm_reaper_pending_pages);
@@ -3515,12 +3523,14 @@ void mmput_exit(struct mm_struct *mm)
 
 			if (async_mm_teardown_reserve(rss)) {
 				mm->async_reap_rss = rss;
-				async_mm_teardown_queue(mm);
+				async_mm_teardown_queue(mm, rss);
 				return;
 			}
+			count_vm_event(ASYNC_MM_TEARDOWN_REJECTED);
 		}
 	}
 
+	count_vm_event(ASYNC_MM_TEARDOWN_SYNC);
 	__mmput(mm);
 }
 
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 4e26e5fd6..e3ff30027 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1494,6 +1494,11 @@ const char * const vmstat_text[] = {
 	[I(NRSWPIN)]				= "nrswpin",
 	[I(NRSWPOUT)]				= "nrswpout",
 #endif /* CONFIG_SWAP */
+#ifdef CONFIG_ASYNC_MM_TEARDOWN
+	[I(ASYNC_MM_TEARDOWN_QUEUED)]	= "async_mm_teardown_queued",
+	[I(ASYNC_MM_TEARDOWN_SYNC)]		= "async_mm_teardown_sync",
+	[I(ASYNC_MM_TEARDOWN_REJECTED)]	= "async_mm_teardown_rejected",
+#endif
 #undef I
 #endif /* CONFIG_VM_EVENT_COUNTERS */
 };
-- 
2.34.1

