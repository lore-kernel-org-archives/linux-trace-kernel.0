Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96417318BA0;
	Tue, 13 Jan 2026 20:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768334684; cv=none; b=WFRtKw8yp62AbjPlqd0T7ytbnmgc1ym/Eb7VMWKAFHCQQOjHHoyrj+6Tyl3HQj9tE6p5hW4c6Q7TW0YSd75p/olrBqCOvWKXBadGnzf1mrGf0xgj/E8Xj1c2WxWKvRuHxmaXUxSP7i9xy+i+wGaWY18vktXTGszzegTV2hGZBnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768334684; c=relaxed/simple;
	bh=ZEboQveir3WP2j8IIWmhpe8yV/dXmnZPtu2hfzYevyw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Td56H6wHYkFgWDXVHkOXIeeyPztZhL/KuU+4xjH7XvEz/ziQaxCpusRr6S6QK+BzSjnxJEB5ONSq2KKrrErD/66XZlBqqmdZzcdhLu4AGg90RETe1sOAn93c2byJv3wTfbYqjGhxAyMrs7A5vYazAmyA1QaX7g6OFtXkYlHYQW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=Cc/12zmg; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Cc/12zmg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1768334675;
	bh=baxDXnLPq9jBBjhsf2/bGL+DnyACXuAEf1JTO7X2B2E=;
	h=From:To:Cc:Subject:Date:From;
	b=Cc/12zmg4YBzrOIs25QxA9HXW/CEntqoDHzIJhMtYIDGYHWFqmIc6UpQQ4leZjZhf
	 AbwCCkb13zWIFTNE0RHNXKEMVJ/KCvf8R7O0U7DL94+/cktRnPr7HlpNRRu/zDInGD
	 vFPwX+uNNoZY2FGUAYLiaW4fZadIInh+7EXNRyWB1Ec33RW/q3+BNYP9F8OUErNLQP
	 m6GYChaSdnW4LXEnS/8qzuErNdX7DyM9b3girAUmmIgG9FOyY6SEuBCk2Vc27kqXja
	 v14Xe6s+odE1CGMVsvp1OepSeOMYgMfB0NyunYv4HnVkSWgboIycYg6a5YHm6l8Jnj
	 kaq86IEVyFtZg==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4drKw34l6dzmFN;
	Tue, 13 Jan 2026 15:04:35 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Martin Liu <liumartin@google.com>,
	David Rientjes <rientjes@google.com>,
	christian.koenig@amd.com,
	Shakeel Butt <shakeel.butt@linux.dev>,
	SeongJae Park <sj@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <liam.howlett@oracle.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	Yu Zhao <yuzhao@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Aboorva Devarajan <aboorvad@linux.ibm.com>
Subject: [PATCH v15 0/3] mm: Reduce latency of OOM killer task selection
Date: Tue, 13 Jan 2026 15:04:25 -0500
Message-Id: <20260113200428.30614-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andrew,

This series use the hierarchical tree counter approximation (hpcc) to
implement the OOM killer task selection with a 2-pass algorithm. This is
a latency reduction improvement of the OOM killer task selection.

Testing the execution time of select_bad_process() with a single
tail -f /dev/zero:

    AMD EPYC 9654 96-Core (2 sockets)
    Within a KVM, configured with 256 logical cpus.

                                      | precise sum |   hpcc   |
    ----------------------------------|-------------|----------|
    nr_processes=40                   |    0.5 ms   |   0.3 ms |
    nr_processes=10000                |   80.0 ms   |   7.9 ms |

Notable changes for v15: This series becomes a OOM killer latency
improvement, rather than a bug fix.

This series is based on v6.19-rc4, on top of the following three
preparation series:

https://lore.kernel.org/linux-mm/20251224173358.647691-1-mathieu.desnoyers@efficios.com/T/#t
https://lore.kernel.org/linux-mm/20251224173810.648699-1-mathieu.desnoyers@efficios.com/T/#t
https://lore.kernel.org/linux-mm/20260113194734.28983-1-mathieu.desnoyers@efficios.com/T/#t

This series replaces v14, aimed at mm-new.

Thanks,

Matheu

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Dennis Zhou <dennis@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: Martin Liu <liumartin@google.com>
Cc: David Rientjes <rientjes@google.com>
Cc: christian.koenig@amd.com
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: SeongJae Park <sj@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Liam R . Howlett" <liam.howlett@oracle.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Wei Yang <richard.weiyang@gmail.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-mm@kvack.org
Cc: linux-trace-kernel@vger.kernel.org
Cc: Yu Zhao <yuzhao@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Mateusz Guzik <mjguzik@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Aboorva Devarajan <aboorvad@linux.ibm.com>

Mathieu Desnoyers (3):
  lib: Introduce hierarchical per-cpu counters
  mm: Use hierarchical per-cpu counters for RSS tracking
  mm: Reduce latency of OOM killer task selection with 2-pass algorithm

 .../core-api/percpu-counter-tree.rst          |  75 ++
 fs/proc/base.c                                |   2 +-
 include/linux/mm.h                            |  46 +-
 include/linux/mm_types.h                      |  54 +-
 include/linux/oom.h                           |  11 +-
 include/linux/percpu_counter_tree.h           | 367 ++++++++++
 include/trace/events/kmem.h                   |   2 +-
 init/main.c                                   |   2 +
 kernel/fork.c                                 |  22 +-
 lib/Makefile                                  |   1 +
 lib/percpu_counter_tree.c                     | 679 ++++++++++++++++++
 mm/oom_kill.c                                 |  84 ++-
 12 files changed, 1296 insertions(+), 49 deletions(-)
 create mode 100644 Documentation/core-api/percpu-counter-tree.rst
 create mode 100644 include/linux/percpu_counter_tree.h
 create mode 100644 lib/percpu_counter_tree.c

-- 
2.39.5
