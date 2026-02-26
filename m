Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C452441A6;
	Thu, 26 Feb 2026 18:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772130418; cv=none; b=S80LQeDByyE9OWSxujkZN9txuVUNhegGZLvHY7mpGusnRzC7nDbx7DpsIOuGW9JFPLJRyCimiJUENTRlXupCpvzmvBX0l2Unc0XY06nVldPj1zVTw0rDoCXA5eLaTzI20RprRM/zeMkUY6F/YNVbo+0yo24FZftNNh8L68SQc2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772130418; c=relaxed/simple;
	bh=YHY812of0YW32itNYVi2K4uelZBdm4N2w0Ll5jEDGQU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nJPM4dLooc9C6WNEPz0GAWazoi2PRacwZ56g29QgFVXwSsggSO4qdu9fyR1Ac1F6uQVLPaV1PSKkxmiP2c9dePHLFK2MHKoi0IZYDUjHSaZcUh2wJMUYoi2Bddx3egNthRNeeaDVmc3dV3sYkP62i4uTAKbDOJpCRkB91Nu8kyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=OXH8f7Fl; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="OXH8f7Fl"
Received: from localhost.localdomain (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id 34E3CB2CD9;
	Thu, 26 Feb 2026 18:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1772130414;
	bh=LlCjj+3UcXvXvqd5PfGg5q5chZ1QMHNerBnuWirnbHA=;
	h=From:To:Cc:Subject:Date;
	b=OXH8f7FlOnxRA+eanQJnKn/eZc8rUSUG5RNK9MOQAg1wdyf1WUHzZIzq119NaxEQg
	 ITICJ0B0MOIR43D4yzTWI/bnDjH040u5352TQ9ixNzCkSMxAM9ZJRitpZ2GIFMg3B9
	 cDltXdx1xa7+0bG+P6hLsjU6iLNzNFb0TvLgrM18=
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: Andrew Morton <akpm@linux-foundation.org>,
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
	Oscar Salvador <osalvador@suse.de>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Shakeel Butt <shakeel.butt@linux.dev>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	kernel-team@meta.com,
	Benjamin Cheatham <benjamin.cheatham@amd.com>,
	Dmitry Ilvokhin <d@ilvokhin.com>
Subject: [PATCH v3 0/5] mm: zone lock tracepoint instrumentation
Date: Thu, 26 Feb 2026 18:26:17 +0000
Message-ID: <cover.1772129168.git.d@ilvokhin.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Zone lock contention can significantly impact allocation and
reclaim latency, as it is a central synchronization point in
the page allocator and reclaim paths. Improved visibility into
its behavior is therefore important for diagnosing performance
issues in memory-intensive workloads.

On some production workloads at Meta, we have observed noticeable
zone lock contention. Deeper analysis of lock holders and waiters
is currently difficult with existing instrumentation.

While generic lock contention_begin/contention_end tracepoints
cover the slow path, they do not provide sufficient visibility
into lock hold times. In particular, the lack of a release-side
event makes it difficult to identify long lock holders and
correlate them with waiters. As a result, distinguishing between
short bursts of contention and pathological long hold times
requires additional instrumentation.

This patch series adds dedicated tracepoint instrumentation to
zone lock, following the existing mmap_lock tracing model.

The goal is to enable detailed holder/waiter analysis and lock
hold time measurements without affecting the fast path when
tracing is disabled.

The series is structured as follows:

  1. Introduce zone lock wrappers.
  2. Mechanically convert zone lock users to the wrappers.
  3. Convert compaction to use the wrappers (requires minor
     restructuring of compact_lock_irqsave()).
  4. Rename zone->lock to zone->_lock.
  5. Add zone lock tracepoints.

The tracepoints are added via lightweight inline helpers in the
wrappers. When tracing is disabled, the fast path remains
unchanged.

Changes in v3:
- Split compact_lock_irqsave() to compact_zone_lock_irqsave() and 
  compact_lruvec_lock_irqsave().
- Rename zone->lock to zone->_lock.

Changes in v2:
- Move mecanical changes from mm/compaction.c to different commit.
- Removed compact_do_zone_trylock() and compact_do_raw_trylock_irqsave().

v1: https://lore.kernel.org/all/cover.1770821420.git.d@ilvokhin.com/
v2: https://lore.kernel.org/all/cover.1772030186.git.d@ilvokhin.com/

Dmitry Ilvokhin (5):
  mm: introduce zone lock wrappers
  mm: convert zone lock users to wrappers
  mm: convert compaction to zone lock wrappers
  mm: rename zone->lock to zone->_lock
  mm: add tracepoints for zone lock

 MAINTAINERS                      |   3 +
 include/linux/mmzone.h           |   7 ++-
 include/linux/zone_lock.h        | 100 +++++++++++++++++++++++++++++++
 include/trace/events/zone_lock.h |  64 ++++++++++++++++++++
 mm/Makefile                      |   2 +-
 mm/compaction.c                  |  58 +++++++++++-------
 mm/internal.h                    |   2 +-
 mm/memory_hotplug.c              |   9 +--
 mm/mm_init.c                     |   3 +-
 mm/page_alloc.c                  |  89 +++++++++++++--------------
 mm/page_isolation.c              |  23 +++----
 mm/page_owner.c                  |   2 +-
 mm/page_reporting.c              |  13 ++--
 mm/show_mem.c                    |   5 +-
 mm/vmscan.c                      |   5 +-
 mm/vmstat.c                      |   9 +--
 mm/zone_lock.c                   |  31 ++++++++++
 17 files changed, 326 insertions(+), 99 deletions(-)
 create mode 100644 include/linux/zone_lock.h
 create mode 100644 include/trace/events/zone_lock.h
 create mode 100644 mm/zone_lock.c

-- 
2.47.3

