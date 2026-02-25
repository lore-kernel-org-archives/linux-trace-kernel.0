Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C04396D2A;
	Wed, 25 Feb 2026 14:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772030656; cv=none; b=gjD4mxc/yr+npNa30DZEY6MOvfaDSjzujVgR6c6IlW38/Femg48ioHEC2e3LqQfztrSIRpKV44pICEXjlIhn+SiGOUknnJ+KDt/W2dgjhbfvJ+UT0EZpfr68ehr09giAYTbnSwJVuRuvFuce2Gl+dzh5Bg1j8N6EVkoZU67Hvhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772030656; c=relaxed/simple;
	bh=6qKfmHVo0n6GQ+gGZ30QgYaGfhDMQFs8Ct8plpoDBUw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eCXmVtrdlKX/aSGXvLw7HxyGDEzn/P3dG/hvGsNphCzoCnwof5kgg0kCK1YQvuEGg2R3jqvxBfHu54hUvWu5aufE9x8nbXKtQfpKBuyFESb7aw+d9oHfmLiwvvqQOCHhau6XlGnh/VKQPbmy/UdaxWRMGI44awBi3kQculMjAAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=dpyHCzsr; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="dpyHCzsr"
Received: from localhost.localdomain (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id 2B50BB2C25;
	Wed, 25 Feb 2026 14:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1772030647;
	bh=QC896ptdoNlPjD8cLAaltMQp2bbytEcY+6oAad9VY0I=;
	h=From:To:Cc:Subject:Date;
	b=dpyHCzsrq1PL9pMzfm9Tsig1czhXhFsKwmupRA2E7bQbmPy/1cSxCV/OIXCaW4PXi
	 fTDIU/dMBx+M8nj+j7clH33eHwebJcm29qlLSUk0a2Re9ASFppNeOcfzNtIKNwacGy
	 VgqjeQJ773HiexHF6AIc4zVv5xDLKuABUkt/zlmk=
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	Oscar Salvador <osalvador@suse.de>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	kernel-team@meta.com,
	Benjamin Cheatham <benjamin.cheatham@amd.com>,
	Dmitry Ilvokhin <d@ilvokhin.com>
Subject: [PATCH v2 0/4] mm: zone lock tracepoint instrumentation
Date: Wed, 25 Feb 2026 14:43:02 +0000
Message-ID: <cover.1772030186.git.d@ilvokhin.com>
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
  4. Add zone lock tracepoints.

The tracepoints are added via lightweight inline helpers in the
wrappers. When tracing is disabled, the fast path remains
unchanged.

The compaction changes required abstracting compact_lock_irqsave() away from
raw spinlock_t. I chose a small tagged struct to handle both zone and LRU
locks uniformly. If there is a preferred alternative (e.g. splitting helpers
or using a different abstraction), I would appreciate feedback.

Changes in v2:

- Move mecanical changes from mm/compaction.c to different commit.
- Removed compact_do_zone_trylock() and compact_do_raw_trylock_irqsave().

Dmitry Ilvokhin (4):
  mm: introduce zone lock wrappers
  mm: convert zone lock users to wrappers
  mm: convert compaction to zone lock wrappers
  mm: add tracepoints for zone lock

 MAINTAINERS                      |   3 +
 include/linux/zone_lock.h        | 100 +++++++++++++++++++++++++++++++
 include/trace/events/zone_lock.h |  64 ++++++++++++++++++++
 mm/Makefile                      |   2 +-
 mm/compaction.c                  |  96 +++++++++++++++++++++++------
 mm/memory_hotplug.c              |   9 +--
 mm/mm_init.c                     |   3 +-
 mm/page_alloc.c                  |  73 +++++++++++-----------
 mm/page_isolation.c              |  19 +++---
 mm/page_reporting.c              |  13 ++--
 mm/show_mem.c                    |   5 +-
 mm/vmscan.c                      |   5 +-
 mm/vmstat.c                      |   9 +--
 mm/zone_lock.c                   |  31 ++++++++++
 14 files changed, 348 insertions(+), 84 deletions(-)
 create mode 100644 include/linux/zone_lock.h
 create mode 100644 include/trace/events/zone_lock.h
 create mode 100644 mm/zone_lock.c

-- 
2.47.3

