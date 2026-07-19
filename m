Received: from sender-pp-o91.zoho.in (sender-pp-o91.zoho.in [103.117.158.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91A4230BE9
	for <linux-trace-kernel@vger.kernel.org>; Sun, 19 Jul 2026 18:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=103.117.158.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784487385; cv=pass; b=pHIWFWda0+wjqsBgkXpPXk7Uy+jts9wnv3s0OIuwzckUy+SJTAWfRB8NQJVCuu85BNgzUTz3WvxEa6tsSZ7uLrlgPWfhSyk4DrqH0TGBWhf1C+Jj6rJqUKSwlD6LBygKjnXV3jE5IxFEdf7UpsOek+eXo9PtUBqYyqnqDq1m4xE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784487385; c=relaxed/simple;
	bh=qoHgkdUKWRzS9NepWwg9eepnHtaReUoqGg549GR2i48=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qYX5XhKKspxE+i0syJsJ/xWDjUUH1dc+LfJ/BmQiVXYmVKyI1xSUHZ76VgmY9qChEnwPW5RSJsL5uf08cFgx/leCo8aZzJWT+w/Xh/8EWfEvhzAvCOnCLmx1CFcAGGgVDj7wBYbMjHyyO9kTp1ves68LWyYXpugrBCp4dy1I5do=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in; spf=pass smtp.mailfrom=zohomail.in; dkim=pass (1024-bit key) header.d=zohomail.in header.i=adi.sharma@zohomail.in header.b=wu2EFQEi; arc=pass smtp.client-ip=103.117.158.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.in header.i=adi.sharma@zohomail.in header.b="wu2EFQEi"
ARC-Seal: i=1; a=rsa-sha256; t=1784487282; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=dLhc3+CEGqis5T4rqStjmYcL0cArClyv4uSj5dmJskdIDaS2dkoOkbI5gnFiAaPqppOKOGqybHO6sWjHZchibtxWosF6Siu60p3ZpRkEwteIe9BSQsiJyxpZ/5v9WKPW9VYmdgw0Y62QB/wlXHoOW6YxALeAcU0hIL4sMZbd4JM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1784487282; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=xzuHmVh+q9OHnLUm7h9D4LXtKeaYnS+MienvvkAwdTQ=; 
	b=WvfxIsfbFLFFfwp8Ho0Bg96cN63/PAHN/OsqkROcPTKeEL3ujIsYv/gt9Z1PPA5OnyPUbKHdYWLVK5cukKG9kY7HSOLLm1k1dRFe8WRtGMiFpab+Evceij4BJ6ZhWDCHswk3N28rgqKON34CIKlZdsoXVyg0lUOxOa+v8niJUo8=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=zohomail.in;
	spf=pass  smtp.mailfrom=adi.sharma@zohomail.in;
	dmarc=pass header.from=<adi.sharma@zohomail.in>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784487282;
	s=zoho; d=zohomail.in; i=adi.sharma@zohomail.in;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=xzuHmVh+q9OHnLUm7h9D4LXtKeaYnS+MienvvkAwdTQ=;
	b=wu2EFQEihaI2ze8F242df+yReXM4jf25ryHY4KKKanZgjoR/bZpD3mWFA8kfKM0f
	xR3+l3h/x55psY5nD93Hy8+QyEfe7mO4ZGfhk6o+TWuGgYFXpn8G0krpgYdiq7qy00E
	UTwVTpV6p2zbO/LCM5UiqzVh8xk6KepwdUX3yG3k=
Received: by mx.zoho.in with SMTPS id 1784487280644201.2764833788417;
	Mon, 20 Jul 2026 00:24:40 +0530 (IST)
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
Subject: [RFC PATCH 2/7] mm: dispatch __mmput() to an mm_reaper kthread via llist
Date: Mon, 20 Jul 2026 00:24:04 +0530
Message-Id: <20260719185409.409685-3-adi.sharma@zohomail.in>
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

Introduce a single dedicated, freezable, sleepable kthread (mm_reaper)
modeled on oom_reaper, and the machinery to route the deferrable unit of
teardown -- __mmput() -- to it through a lock-free llist plus waitqueue.
mmput_exit() does llist_add() and wakes the kthread, which drains with
llist_del_all() and runs __mmput() per entry with cond_resched(). The
drain loop also calls try_to_freeze() after each entry, so a freeze
request is honoured mid-batch rather than only at the wait point.

Nothing calls mmput_exit() yet: exit_mm() is not routed to it, and there
is no eligibility check or gate, so it would queue every final-drop mm
unconditionally if invoked. This changes no behavior -- the function is
built but unreferenced, the kthread receives no work, and __mmput() runs
inline on the exiting CPU exactly as today. The exit_mm() hook and the
eligibility/gating policy follow in later patches.

llist (rather than oom_reaper's spinlock+list) avoids a global lock on
the exit path under many-core parallel exits. llist_for_each_entry_safe()
caches the next pointer before __mmput(), so iteration is safe even when
the final mmdrop() inside __mmput() frees mm.

Lifetime: the mm_count reference that mm_users>0 stands for is released
only by that final mmdrop() inside __mmput(). Deferring __mmput() keeps
the reference held, so the mm_struct and its embedded async_reap_node
stay alive until the kthread runs. No extra mmgrab() is needed, for the
same reason mmput_async() needs none.

The kthread is started at subsys_initcall and set to nice 19 to minimize
competition with other EEVDF tasks. Its affinity is expressed as a
preference via kthread_affine_preferred() over the HK_TYPE_KTHREAD
housekeeping mask, so it keeps off isolcpus= and cpuset-isolated CPUs
without the hard binding kthread_bind_mask() would impose --
PF_NO_SETAFFINITY would otherwise leave admins unable to re-affine it.

Signed-off-by: Aditya Sharma <adi.sharma@zohomail.in>
---
 kernel/fork.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/kernel/fork.c b/kernel/fork.c
index f0e2e131a..884e4e767 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -112,6 +112,7 @@
 #include <linux/unwind_deferred.h>
 #include <linux/pgalloc.h>
 #include <linux/uaccess.h>
+#include <linux/sched/isolation.h>
 
 #include <asm/mmu_context.h>
 #include <asm/cacheflush.h>
@@ -3407,3 +3408,56 @@ static int __init init_fork_sysctl(void)
 }
 
 subsys_initcall(init_fork_sysctl);
+
+#ifdef CONFIG_ASYNC_MM_TEARDOWN
+static LLIST_HEAD(mm_reaper_list);
+static DECLARE_WAIT_QUEUE_HEAD(mm_reaper_wait);
+
+static void async_mm_teardown_queue(struct mm_struct *mm)
+{
+	if (llist_add(&mm->async_reap_node, &mm_reaper_list))
+		wake_up(&mm_reaper_wait);
+}
+
+static int mm_reaper(void *unused)
+{
+	set_freezable();
+	while (true) {
+		struct llist_node *batch;
+		struct mm_struct *mm, *n;
+
+		wait_event_freezable(mm_reaper_wait, !llist_empty(&mm_reaper_list));
+		batch = llist_del_all(&mm_reaper_list);
+		llist_for_each_entry_safe(mm, n, batch, async_reap_node) {
+			__mmput(mm); /* may free mm via mmdrop */
+			cond_resched();
+			try_to_freeze();
+		}
+	}
+	return 0;
+}
+
+void mmput_exit(struct mm_struct *mm)
+{
+	might_sleep();
+	if (!atomic_dec_and_test(&mm->mm_users))
+		return;
+	async_mm_teardown_queue(mm);
+}
+
+static int __init mm_reaper_init(void)
+{
+	struct task_struct *th;
+
+	th = kthread_create(mm_reaper, NULL, "mm_reaper");
+	if (IS_ERR(th)) {
+		pr_err("mm_reaper: failed to start kthread: %ld\n", PTR_ERR(th));
+		return PTR_ERR(th);
+	}
+	set_user_nice(th, 19); /* minimize competition with other fair class tasks */
+	kthread_affine_preferred(th, housekeeping_cpumask(HK_TYPE_KTHREAD));
+	wake_up_process(th);
+	return 0;
+}
+subsys_initcall(mm_reaper_init);
+#endif
-- 
2.34.1

