Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793911012;
	b=dxBwrT0FQrVSzUnZmtp5FZUT72fsgMUrJEFvPJXUuGqHwN6v0OgQyS/4ZVAWOqQLUR6L
	 +ADUCo1jF84NyIdltnrElpDSQl3ujY9g+AW/XmAFi49V7GlgKFd2UzT+UkXdFsC7Vczkn
	 J+axqtgEbhb8n9dTjaDoL5GR3jiK3G78ID3tLGev/q13phi5YCp/8n59DPXfHgH8yRQVN
	 dqLRR0BbJ8dVqaHioUowrmd3UrFcOPUnbpkIZHH6MsU6VSkFPdUWDoBU4Vkg1tQgLlQ+z
	 JvewDb7KMw2rTqpiLfF0pJpToRazaTdhcXHp8GsuuEGPHY0v6ixfEq8Sk866LRLH4vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793911012;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=G0WVyU8Un4WAL07LgGPKN8XU7yNyVH1mBvR0bHvznHQ=;
	b=jCO7jQgJACquB9JuucXjUDPVmQPMxCsJNh/mBTSBAzQztTk4V3OPVFVdmhS9gc5L4R6d
	 cm3FKVFGKDSwd1Ub1b/mqPrcD9pdtWzKbaF/b36/EaH8UvK0IQGwplWpKf7qLfIytdfWc
	 6Z0gLxGugNixSlVU7tpcZwKM2FHgFd/leb8YsS51nhOW1G0GGlIBu9zxZw1FcD2BEtO2C
	 kDhpx5R5vbzL/PZVIxxNlPMkrd6d6RCNkMXYGqwmhhwZThzJcjZ9ieg5eul3E4AhqIsCO
	 q4zi7qq4R2Tp3zpx1JxfFL3Bi4WS02Ukr/jdYkDhL6SA0iMWQyIEy0f3fcQ1f5qeaMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=WL6PU8V6;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF7B606D826;
	Thu,  5 Nov 2026 20:36:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DF7B606D826
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=WL6PU8V6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1793911009;
	bh=G0WVyU8Un4WAL07LgGPKN8XU7yNyVH1mBvR0bHvznHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WL6PU8V6xR42qUbWCNtbIbLtRPeNC3or5BwyPo+WXFBjfS8JUmHvPKnS027BtAnyx
	 5CYyBklEb1I9305/HOyfc/HSgj3lKQAQszFLsrSI3bzcl2p7FNT5KJ8yoTlLNgMkT7
	 0fZi6iYBK67K0al36VZ0OxtZLuLG1B5MhzQgYQ7qolNeDRTlIcJL60OoPEsEvQLrVe
	 xSWUUK8UhOksiqWpXnWljV5AT6HrUNEsW26w+BatZMX2itfpuC7CyoD3zJ6GFj8eun
	 2KnWpEUDZjLFYIizWciPaTlhqPAiHZmYQy/uJYooZws+Em+Uao9NmPDzQ2S8oPfOAp
	 2ttfBgeRztBPQ==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jLDcd1DrJzLrQ;
	Thu, 05 Nov 2026 15:36:49 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: David Hildenbrand <david@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>,
	Martin Liu <liumartin@google.com>,
	David Rientjes <rientjes@google.com>,
	christian.koenig@amd.com,
	Shakeel Butt <shakeel.butt@linux.dev>,
	SeongJae Park <sj@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Yu Zhao <yuzhao@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Aboorva Devarajan <aboorvad@linux.ibm.com>,
	David Carlier <devnexen@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-doc@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Kees Cook <kees@kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Oleg Nesterov <oleg@redhat.com>
Subject: [RFC PATCH v24 09/10] mm: add the rss_stat_batch boot parameter
Date: Thu,  5 Nov 2026 15:36:38 -0500
Message-Id: <20261105203639.1459524-10-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261105203639.1459524-1-mathieu.desnoyers@efficios.com>
References: <20261105203639.1459524-1-mathieu.desnoyers@efficios.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RSS counters use a batch size of 32: each CPU accumulates up to 31
pages in either direction before propagating a carry into the counter
tree.  A smaller batch improves the accuracy of the approximate RSS, and
a larger batch reduces the cost of updates.

Add the rss_stat_batch= boot parameter to compare batch sizes on a
given machine, along with the percpu_counter_tree.arity= boot parameter
for the tree shape.  It accepts a power of 2 between 2 and 128, and is
ignored with a warning otherwise.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 .../admin-guide/kernel-parameters.txt         | 10 ++++++++
 kernel/fork.c                                 | 23 ++++++++++++++++---
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index c368affa2115..ba2bdeb1480b 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6792,6 +6792,16 @@ Kernel parameters
 			debug mode. Defaults to CONFIG_RSEQ_DEBUG_DEFAULT_ENABLE.
 			Format: <bool>
 
+	rss_stat_batch=	[KNL,SMP]
+			Format: <integer>
+			Batch size of the per-mm RSS counters: the number of
+			pages a CPU accumulates before propagating them into
+			the counter tree. A power of 2 between 2 and 128.
+			A smaller batch improves the accuracy of the
+			approximate RSS, a larger batch reduces the update
+			cost. Default: 32.
+			This parameter is meant for performance comparison.
+
 	rt_group_sched=	[KNL] Enable or disable SCHED_RR/FIFO group scheduling
 			when CONFIG_RT_GROUP_SCHED=y. Defaults to
 			!CONFIG_RT_GROUP_SCHED_DEFAULT_DISABLED.
diff --git a/kernel/fork.c b/kernel/fork.c
index ac4eb1370e62..d0641700cd9c 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -138,9 +138,26 @@
 #define MAX_THREADS FUTEX_TID_MASK
 
 /*
- * Batch size of rss stat approximation
+ * Batch size of rss stat approximation, tunable with the rss_stat_batch=
+ * boot parameter to compare batch sizes on a given machine.
  */
-#define RSS_STAT_BATCH_SIZE	32
+static unsigned int rss_stat_batch_size __ro_after_init = 32;
+
+static int __init setup_rss_stat_batch(char *str)
+{
+	unsigned int batch;
+
+	if (kstrtouint(str, 0, &batch) || batch < 2 || !is_power_of_2(batch) ||
+	    batch > PERCPU_COUNTER_TREE_MAX_BATCH) {
+		pr_warn("rss_stat_batch: expecting a power of 2 between 2 and %u\n",
+			PERCPU_COUNTER_TREE_MAX_BATCH);
+		return 1;
+	}
+	rss_stat_batch_size = batch;
+	pr_info("rss_stat_batch: %u\n", batch);
+	return 1;
+}
+__setup("rss_stat_batch=", setup_rss_stat_batch);
 
 /*
  * Protected counters by write_lock_irq(&tasklist_lock)
@@ -1149,7 +1166,7 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p)
 	if (mm_alloc_sched(mm))
 		goto fail_sched;
 
-	if (percpu_counter_tree_init_many_lazy(mm->rss_stat, NR_MM_COUNTERS, RSS_STAT_BATCH_SIZE))
+	if (percpu_counter_tree_init_many_lazy(mm->rss_stat, NR_MM_COUNTERS, rss_stat_batch_size))
 		goto fail_pcpu;
 
 	lru_gen_init_mm(mm);
-- 
2.47.3

