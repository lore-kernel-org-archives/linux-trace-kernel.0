Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794429413;
	b=FZR5GoJVh8KjEmr5pcLfjeqIyhk1oXCRp8TQn0MJopgxFBRLwyVfrJf8bW+W9GtxBvd7
	 eSAE5prIqJozn9xVZ0HEE5HiOqIBUPmoNLcVlg9QgAYiDAfNaIGo2sv7seyQcZf/o1NOk
	 xcm6wrADWq5TFOZgnVL/w5DALICjJpQxCmQ8cmdKtOs4iuiJlA/0hmKdUryv81BJdc+mM
	 vz5mGPxCODRpJsi19cpIUzm2F0G/r6FTdljRG5JRki3qwh12wBk1hWIlGB3mMlKrM9Ot3
	 D+F/DQgkA/yk7AOpo+nHTAsQJVcdtWaUOlykO3iCbByD8B0Y3DMdI4N4aJzU4u7F0sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794429413;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=101mrooLZWOPsx7/vp2ktPFHBHOgSH902fjsFmKKJSA=;
	b=NM4eV8ZdydMDAbb5ri3bcRhODzXQNsUlQW7SEZt/8TAfekLXrCfRkXBobvC+2k02dA/G
	 tL0f32ALNZoE7Kkq86NmgrXfCKhu1dNqKSSZj9QmPDCBkQ2GdWwNZVr7CljMe3yPJpwTc
	 udr2/sLh7xP6yoFPebQO0tKFOWJYZACTeBtbcI523aZvoi3+p5zUGBTz83yM4mo6a189S
	 QGlJo4F1jGPJ669lyPGSy5f2rOwvd3rkH8ZOdosYA2K7Iel/9h76AQPc/jzuaKCuQo83x
	 TywwqDoMo7pyWg5nqi2a7yB/77KWPgQL1Or4diA+stm7EvPzsKzSx1KnP4nZRSfX1bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=skiL+GSZ;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15B7606A88B;
	Wed, 11 Nov 2026 20:36:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F15B7606A88B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=skiL+GSZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1794429407;
	bh=101mrooLZWOPsx7/vp2ktPFHBHOgSH902fjsFmKKJSA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=skiL+GSZod4k/p/6ZwtYyDiXQ4Ju6wFgaVzD1PJEuPmuIxvByK7d9pU3TilgV34p9
	 eWDXDMGKBL7uN9txJqB/n7n99RxxM/Dn1KLjnapFsoPyZkxlBDbWUyLB8X4rJyrK61
	 7c8IigN83ypBo23h9EFz+oB23pjdeLX3aahOXwWDWqgApNMSI3lRkUKVfN80qj8pFO
	 ijYktGFBW0vfmT252gDfU+PiTWrnQ97HrgvUy/Tzjf9JL+lBPxuR4nV1OgFIjm39wk
	 uynHUtXVuyxcEX5YTtvRXRaEf+ficELQFDhxN6wYzcR690u+lqmfZtIlpzbZRLV0fV
	 g+rLoc5bDihag==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jPwKq3VtjzNll;
	Wed, 11 Nov 2026 15:36:47 -0500 (EST)
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
	Harry Yoo <harry@kernel.org>,
	Hao Li <hao.li@linux.dev>,
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
	linux-trace-kernel@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Oleg Nesterov <oleg@redhat.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Andrea Parri <parri.andrea@gmail.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Hugh Dickins <hughd@google.com>
Subject: [RFC PATCH v25 13/14] mm: add the rss_stat_batch boot parameter
Date: Wed, 11 Nov 2026 15:36:25 -0500
Message-Id: <20261111203626.95838-14-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261111203626.95838-1-mathieu.desnoyers@efficios.com>
References: <20261111203626.95838-1-mathieu.desnoyers@efficios.com>
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
index dc1db6cb5da0..f582c1b073fe 100644
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

