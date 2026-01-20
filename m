Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FEC1F8755
	for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Jan 2026 02:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768877090; cv=none; b=oXxQkLMAZPMb5uIIWbiOH37Z3afy4Qle0jgD6dKeQRPhwQc+aFfyAQKflOEmn2JYcrCCAP9SwAkeCyf3N9qOFJ7mxXG0DM4BdKGLsjqqgcblEufN/FrC4KirdsJpcpbFCYQ5kNKWYvhNIvReNRWSItHGHoapIaB5hThbcsgqdSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768877090; c=relaxed/simple;
	bh=+L+klLM2g3vueGNUW2hvkwGcgNbfXOlUTP5lniiA8m4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hMtWbTfWW1qrsruwiJ1Szoth0S93ag3osV+UPMNqq50CFcdc3WZBh0zvuPrrlCbsENiZgMUHk6gnXmp3OM6hfWJrugb9SHW1wzhUuPQ7h8m5FeUqyC2+jCYAapUjRJvu6gjIn937iz5gTgLy8z6/Mja3xi3C5LFTqRRZ7byZxMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QUyaBr+Z; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QUyaBr+Z"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768877076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=K6wbMkRwjKapK5CoBKSnPQTD2eR277R70T25OkML4K4=;
	b=QUyaBr+Zbc1RpsjkBxPDIQhd9bVXyI/ftOUnCU4cBBZ02m5kSTnVOQXr6Qn2AttbjeE7sY
	Y7Cqo9hS00h++vca6yMk5n/Lh7a8dubUI3CEJmyWwp+PRN01xmw1gaLQ7ugKVeFvpFYnic
	OrK+shqWr2bTuYNdZKk2VPLMslNftQs=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: linux-mm@kvack.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] mm/vmscan: mitigate spurious kswapd_failures reset and add tracepoints
Date: Tue, 20 Jan 2026 10:43:47 +0800
Message-ID: <20260120024402.387576-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

== Problem ==

We observed an issue in production on a multi-NUMA system where kswapd
runs endlessly, causing sustained heavy IO READ pressure across the
entire system.

The root cause is that direct reclaim triggered by cgroup memory.high
keeps resetting kswapd_failures to 0, even when the node cannot be
balanced. This prevents kswapd from ever stopping after reaching
MAX_RECLAIM_RETRIES.

```bash
bpftrace -e '
 #include <linux/mmzone.h>
 #include <linux/shrinker.h>
kprobe:balance_pgdat {
	$pgdat = (struct pglist_data *)arg0;
	if ($pgdat->kswapd_failures > 0) {
		printf("[node %d] [%lu] kswapd end, kswapd_failures %d\n",
                       $pgdat->node_id, jiffies, $pgdat->kswapd_failures);
	}
}
tracepoint:vmscan:mm_vmscan_direct_reclaim_end {
	printf("[cpu %d] [%ul] reset kswapd_failures %d \n", cpu, jiffies,
               args.nr_reclaimed)
}
'
```

The trace results showed that when kswapd_failures reaches 15, continuous
direct reclaim keeps resetting it to 0. This was accompanied by a flood of
kswapd_failures log entries, and shortly after, we observed massive
refaults occurring.

== Solution ==

Patch 1 fixes the issue by only resetting kswapd_failures when the node
is actually balanced. This introduces pgdat_try_reset_kswapd_failures()
as a wrapper that checks pgdat_balanced() before resetting.

Patch 2 extends the wrapper to track why kswapd_failures was reset,
adding tracepoints for better observability:
  - mm_vmscan_reset_kswapd_failures: traces each reset with reason
  - mm_vmscan_kswapd_reclaim_fail: traces each kswapd reclaim failure

---

v3 -> v4: https://lore.kernel.org/linux-mm/20260114074049.229935-1-jiayuan.chen@linux.dev/
  - Add Acked-by tags
  - Some modifications suggested by Johannes Weiner 
v2 -> v3: https://lore.kernel.org/all/20251226080042.291657-1-jiayuan.chen@linux.dev/
  - Add tracepoints for kswapd_failures reset and reclaim failure
  - Expand commit message with test results

v1 -> v2: https://lore.kernel.org/all/20251222122022.254268-1-jiayuan.chen@linux.dev/

Jiayuan Chen (2):
  mm/vmscan: mitigate spurious kswapd_failures reset from direct reclaim
  mm/vmscan: add tracepoint and reason for kswapd_failures reset

 include/linux/mmzone.h        | 17 ++++++++++--
 include/trace/events/vmscan.h | 51 +++++++++++++++++++++++++++++++++++
 mm/memory-tiers.c             |  2 +-
 mm/page_alloc.c               |  4 +--
 mm/show_mem.c                 |  3 +--
 mm/vmscan.c                   | 45 +++++++++++++++++++++++++------
 mm/vmstat.c                   |  2 +-
 7 files changed, 108 insertions(+), 16 deletions(-)

-- 
2.43.0

