Received: from mta0.migadu.com (out-98.mta0.migadu.com [91.218.175.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6CD437118
	for <linux-trace-kernel@vger.kernel.org>; Fri, 11 Sep 2026 10:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789122603; cv=none; b=RTtEDhBHWuBG8EuBEG4vcySii5Rn4iy4cZyko+k5VKhdULD+1PlacBXaFOFaASqJolD0SoUYujqhIFjM6zvXAR/gPByFOllY7n5URDXcNXHHkhI9IK1OqbIESlYwRc6uxdqgCLI7Em0cZe6vNxhlPxUycLNKNZFlaHSlYLF1EV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789122603; c=relaxed/simple;
	bh=eZtumF7gD/yN9q4V8RaI4UNr8jIZL+PASXDDcBgG0Is=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f5ATtNQtSJQDj3r1VVP1ZKNP0KTdH0WLIY9QhY76YMRjV8enrFfki7Lbnk7jyI91nolff09Jdl+esGtlrryqH7ne34TrUC0LjIh14c9jVkjUyRzXv+iR6RIP1IO4/QRLIuwwFxa7c2xs4E5e9zPq0sUpmq0xcc5NklgqC1gFhAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=auYVOSVU; arc=none smtp.client-ip=91.218.175.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="auYVOSVU"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=eZtumF7gD/yN9q4V8RaI4UNr8jIZL+PASXDDcBgG0Is=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789122598; v=1; x=1789727398;
 b=auYVOSVUiW2Mukc647VZ5OpxMcTiKgVt0DtNLoiy/mN/2WkNswugxI8CRsFHB/ichYjaaPyj
 lrhDKiiVWRQ5LMkzwoJQta9kR+rj+ubiNZbw198zK3XOx3HLpngJjGfC4OY/cuKvX3aK0nIvmfF
 eq/joxy0QqRE74ZZIPu8p/9E=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 482c8db3fc73cf4c;
	Fri, 11 Sep 2026 10:29:58 +0000
X-Mizu-Trace-ID: 482c8db3fc73cf4c
X-Migadu-Flow: FLOW_OUT
From: Ridong Chen <ridong.chen@linux.dev>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Kairui Song <kasong@tencent.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Hildenbrand <david@kernel.org>,
	Michal Hocko <mhocko@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org (open list:MEMORY MANAGEMENT - MGLRU (MULTI-GEN LRU)),
	Ridong Chen <ridong.chen@linux.dev>,
	Ridong Chen <chenridong@xiaomi.com>
Subject: [PATCH v2 0/3] mm/mglru: add tracepoints for scan and aging paths
Date: Fri, 11 Sep 2026 18:29:36 +0800
Message-Id: <20260911102939.2485750-1-ridong.chen@linux.dev>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ridong Chen <chenridong@xiaomi.com>

Background
==========

MGLRU currently has no tracepoints of its own. The scan and evict paths
reuse the classic-LRU tracepoints (trace_mm_vmscan_lru_isolate() and
trace_mm_vmscan_lru_shrink_inactive()), which predate MGLRU and carry no
generation, sequence, memcg or swappiness context. A trace of a running
system therefore cannot tell which memcg a given scan belongs to, how far
reclaim has progressed through the generations, or when a new generation
is created - so how MGLRU actually operates is effectively invisible.

Implementation
==============

Patch 1 is a cleanup that factors the per-generation page-count
summation into a helper, lru_gen_seq_nr_pages(), reused by patch 3.

Patch 2 adds mm_mglru_scan_folios on the scan path, and patch 3 adds
mm_mglru_inc_max_seq on the aging path. Both carry the memcg id and the
generation window (min_seq/max_seq), live at MGLRU-specific layers with
no classic-LRU counterpart, and are guarded so the hot paths stay
zero-cost when disabled.

Effect
======

Paired, the two tracepoints make the full aging-to-eviction window
observable per memcg: aging advances max_seq (the leading edge), scanning
consumes the oldest generations, and the min_seq/max_seq pair on each
event shows how the generation window moves over time.

A sample trace, with the classic-LRU tracepoints left enabled to show
how they interleave:

  mm_vmscan_lru_isolate: classzone=4 order=0 nr_requested=36 nr_scanned=31 nr_skipped=0 nr_taken=29 lru=inactive_file
  mm_mglru_scan_folios: memcg_id=73 classzone=4 order=0 nr_requested=36 nr_scanned=31 nr_sorted=2 nr_skipped=0 nr_taken=29 lru=inactive_file max_seq=3 tier=3 min_seq=0
  mm_vmscan_lru_shrink_inactive: nid=0 nr_scanned=31 nr_reclaimed=29 nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activate_anon=0 nr_activate_file=0 nr_ref_keep=0 nr_unmap_fail=0 priority=5 flags=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
  mm_mglru_inc_max_seq: memcg_id=73 max_seq=4 anon_min_seq=1 file_min_seq=1 nr_anon={0x0,0x0,0x1,0x0} nr_file={0x0,0x427,0x6,0x4a}
  mm_vmscan_lru_isolate: classzone=4 order=0 nr_requested=5 nr_scanned=5 nr_skipped=0 nr_taken=1 lru=inactive_file
  mm_mglru_scan_folios: memcg_id=73 classzone=4 order=0 nr_requested=5 nr_scanned=5 nr_sorted=4 nr_skipped=0 nr_taken=1 lru=inactive_file max_seq=4 tier=3 min_seq=1
  mm_vmscan_lru_shrink_inactive: nid=0 nr_scanned=5 nr_reclaimed=1 nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activate_anon=0 nr_activate_file=0 nr_ref_keep=0 nr_unmap_fail=0 priority=5 flags=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC

The mm_mglru_scan_folios lines carry the memcg id and the generation
window (max_seq/min_seq) that the bare mm_vmscan_lru_isolate lines above
them cannot - those cannot even say which memcg they came from. The
mm_mglru_inc_max_seq line then shows a new generation being created
(max_seq 3 -> 4) with the per-generation page counts for both types.

---
v2: address Sashiko AI review [1] - pass struct lruvec * into the tracepoints
    and do the memcg lookup inside TP_fast_assign.

[1] https://sashiko.dev/#/patchset/20260911072848.2346073-1-ridong.chen@linux.dev?part=2

Ridong Chen (3):
  mm/mglru: factor out lru_gen_seq_nr_pages()
  mm/mglru: add tracepoint for scan_folios()
  mm/mglru: add tracepoint for inc_max_seq()

 include/trace/events/vmscan.h | 101 ++++++++++++++++++++++++++++++++++
 mm/vmscan.c                   |  53 +++++++++++++++---
 2 files changed, 146 insertions(+), 8 deletions(-)

-- 
2.34.1

