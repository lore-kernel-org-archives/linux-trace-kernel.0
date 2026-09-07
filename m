Received: from mta1.migadu.com (out-86.mta1.migadu.com [95.215.58.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E522DC79F
	for <linux-trace-kernel@vger.kernel.org>; Mon,  7 Sep 2026 04:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788755123; cv=none; b=bctkjAZtJAw9Z1ovhg06MWX/spPAkhX2+7tWFYAaNVayMCQMQFnMmGlNRwktsk7DPpRMA2L7cdygppDmMgxo2I8AMQ46BN8XTHZ8mDqwDtuE54cSWgfIhZOJ0OAM/fk4IQYe7MnBo5FlxDMj9Arg3IES2bs6sIX2ycbdlfj9ZcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788755123; c=relaxed/simple;
	bh=wrEi0IGqv2yk5i4rOkFtPT9EzmwLrTae/tEdHh6Nk9w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k/muHXP1xpKRw4crOjSbsg0PkLsKcTltNGW6aqWRYZrG1XynKyNqvV+9uphDGyONkoLZ4jmDbr0g6L93MdJmXdiyx91bXQMUhBdWWFlwBXWVZvDlmdm6ZbB53Mmy5B+igxrIS8CGVWS7FNUXWr4reRN3gkI//ThKAqaRhbJaKNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UVCP0cdg; arc=none smtp.client-ip=95.215.58.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UVCP0cdg"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=wrEi0IGqv2yk5i4rOkFtPT9EzmwLrTae/tEdHh6Nk9w=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788755119; v=1; x=1789359919;
 b=UVCP0cdg8F9A6AEDfl+JNr/VXO5ni2NBRpMIRV+SJyLZJ4zXgjt5l2fdDkybsjoPpLjnchQG
 9zjydrXsOgt6J2fGOothQf1NG6S9DRy5DU8sN7e//4Mt6rkla7hlGoYlxEECv/ZURpkXhBa1NUD
 Nh+5we06EsoPWOnamzRjIwLQ=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 0a9229bad07e1de1;
	Mon, 07 Sep 2026 04:25:08 +0000
X-Mizu-Trace-ID: 0a9229bad07e1de1
X-Migadu-Flow: FLOW_OUT
From: Ridong Chen <ridong.chen@linux.dev>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	David Hildenbrand <david@kernel.org>,
	Michal Hocko <mhocko@kernel.org>,
	Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Barry Song <baohua@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Ridong Chen <ridong.chen@linux.dev>,
	Ridong Chen <chenridong@xiaomi.com>
Subject: [PATCH RFC 0/2] mm/mglru: add tracepoints for aging and isolation
Date: Mon,  7 Sep 2026 12:24:45 +0800
Message-Id: <20260907042447.2450663-1-ridong.chen@linux.dev>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ridong Chen <chenridong@xiaomi.com>

MGLRU currently has no tracepoints of its own. The scan and evict paths
reuse the classic-LRU tracepoints (trace_mm_vmscan_lru_isolate() and
trace_mm_vmscan_lru_shrink_inactive()), which predate MGLRU and carry no
generation, sequence, memcg or swappiness context. A trace of a running
system therefore cannot tell which memcg a given scan/evict belongs to,
how far reclaim has progressed through the generations, or when a new
generation is created - so how MGLRU actually operates is effectively
invisible.

Add two tracepoints on the two paths that define an MGLRU cycle:

  - mm_mglru_isolate_folios, on the isolation (eviction) path, carrying
    the memcg id, the type scanned, the effective swappiness, the
    scanned/isolated counts, and the anon/file min_seq and max_seq.

  - mm_mglru_inc_max_seq, on the aging path, emitted when a new youngest
    generation is created, carrying the memcg id, the new max_seq, and
    the anon/file min_seq.

Both live at MGLRU-specific layers with no classic-LRU counterpart, so
they neither change nor duplicate the existing tracepoints. Paired, they
make the full aging-to-eviction window observable per memcg: aging
advances max_seq (the leading edge), isolation consumes the oldest
generations, and the min_seq/max_seq pair on each event shows how the
generation window moves over time.

A sample trace, with the classic-LRU tracepoints left enabled to show
how they interleave:

  mm_mglru_inc_max_seq: memcg_id=1085 max_seq=7 anon_min_seq=4 file_min_seq=5
  mm_vmscan_lru_isolate: classzone=4 order=0 nr_requested=17 nr_scanned=17 nr_skipped=0 nr_taken=0 lru=inactive_file
  mm_vmscan_lru_isolate: classzone=4 order=0 nr_requested=17 nr_scanned=17 nr_skipped=0 nr_taken=0 lru=inactive_file
  mm_mglru_isolate_folios: memcg_id=1085 type=file swappiness=0 nr_scanned=34 nr_isolated=0 anon_min_seq=4 file_min_seq=5 max_seq=7
  mm_vmscan_lru_isolate: classzone=4 order=0 nr_requested=64 nr_scanned=64 nr_skipped=0 nr_taken=21 lru=inactive_file
  mm_mglru_isolate_folios: memcg_id=73 type=file swappiness=0 nr_scanned=64 nr_isolated=21 anon_min_seq=7 file_min_seq=8 max_seq=10
  mm_vmscan_lru_shrink_inactive: nid=0 nr_scanned=64 nr_reclaimed=21 nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activate_anon=0 nr_activate_file=0 nr_ref_keep=0 nr_unmap_fail=0 priority=4 flags=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
  mm_mglru_inc_max_seq: memcg_id=73 max_seq=11 anon_min_seq=8 file_min_seq=8
  mm_vmscan_lru_isolate: classzone=4 order=0 nr_requested=64 nr_scanned=10 nr_skipped=0 nr_taken=10 lru=inactive_file
  mm_mglru_isolate_folios: memcg_id=73 type=file swappiness=0 nr_scanned=10 nr_isolated=10 anon_min_seq=8 file_min_seq=8 max_seq=11
  mm_vmscan_lru_shrink_inactive: nid=0 nr_scanned=10 nr_reclaimed=7 nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activate_anon=0 nr_activate_file=3 nr_ref_keep=0 nr_unmap_fail=0 priority=4 flags=RECLAIM_WB_FILE|RECLAIM_WB_ASYNC

The two mm_mglru_isolate_folios lines tell memcg 1085 and memcg 73
apart, and show one making no progress (nr_isolated=0 against min_seq=4/5)
while the other evicts and then ages (max_seq 10 -> 11, min_seq catching
up to 8). The bare mm_vmscan_lru_isolate lines above carry none of that
context - they cannot even say which memcg they came from.

Sent as RFC to get feedback on the choice of tracepoint sites and fields
before proposing them as stable ABI.

Ridong Chen (2):
  mm/mglru: add tracepoint for folio isolation
  mm/mglru: add tracepoint for inc_max_seq

 include/trace/events/vmscan.h | 77 +++++++++++++++++++++++++++++++++++
 mm/vmscan.c                   | 13 +++++-
 2 files changed, 89 insertions(+), 1 deletion(-)

-- 
2.34.1

