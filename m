Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE3737A484
	for <linux-trace-kernel@vger.kernel.org>; Wed, 14 Jan 2026 07:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768376474; cv=none; b=M2uLekmhTxm4FMEbeKpX82eiqJyjVInmAxLWYR0+xhjZuyM9iJnelK790nHY+PFgfNkoxqwh6+H/1xiT/Vba96wfRrpq4UmJpYXWqM/7UjplozS4gY8tvqzV8FXj0AYoExJwlPP/4gXXciSWqH2dJlFwH5kkRFcsbvH6yGpwtfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768376474; c=relaxed/simple;
	bh=wkOQlNTiV/F2ep1q8rT2plAHtuzk5WG00HEpaf/4E10=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SkLV5N+SF3hi+wIemRwbWZIp660foM0NBYtVCqRifqD9JWMs052aKw2s7izoDkxFI1PBJCz8lm4+2DgT5BTI8u7bUCctS8QKM800n1bteplVrp0u5bInU7yEFs8AvySxZ8paUmY485HfE/Frcoqpqt/FX3MdrR5rNfbeSyrTz9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qbtaZJTR; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qbtaZJTR"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768376467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4x1WKLBadjpEQ3Km12q1uw9Rkf2I+GKwMESTXQhTwz0=;
	b=qbtaZJTR3LvAkz+81bdXF0KphGoGYZa2i+C7bhOLOM2TKPD3oVYRtJr/ZN7/wk5KOnbB86
	envUAFzPxp4pb+C/3cc3zJWfB6a+mLcg7W/zqn+iVK18C84WhLg9s81cbT4FCkTq+azXho
	HGbbIbxafS8U3GD56NMPS1DtHRq8FwM=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: linux-mm@kvack.org,
	shakeel.butt@linux.dev
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
	Jiayuan Chen <jiayuan.chen@shopee.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] mm/vmscan: mitigate spurious kswapd_failures reset and add tracepoints
Date: Wed, 14 Jan 2026 15:40:34 +0800
Message-ID: <20260114074049.229935-1-jiayuan.chen@linux.dev>
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
v2 -> v3: https://lore.kernel.org/all/20251226080042.291657-1-jiayuan.chen@linux.dev/
  - Add tracepoints for kswapd_failures reset and reclaim failure
  - Expand commit message with test results

v1 -> v2: https://lore.kernel.org/all/20251222122022.254268-1-jiayuan.chen@linux.dev/

Jiayuan Chen (2):
  mm/vmscan: mitigate spurious kswapd_failures reset from direct reclaim
  mm/vmscan: add tracepoint and reason for kswapd_failures reset

 include/linux/mmzone.h        |  9 +++++++
 include/trace/events/vmscan.h | 51 +++++++++++++++++++++++++++++++++++
 mm/memory-tiers.c             |  2 +-
 mm/page_alloc.c               |  2 +-
 mm/vmscan.c                   | 33 ++++++++++++++++++++---
 5 files changed, 91 insertions(+), 6 deletions(-)

-- 
2.43.0

