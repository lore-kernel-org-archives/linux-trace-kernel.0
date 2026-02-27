Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A099643D50C;
	Fri, 27 Feb 2026 15:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772206665; cv=none; b=ADznv/mWh9+zDhSMWLh0qxUC+dF6GJMCO9QND4wpNQcbLJsdd9w/wHFuFvQJHDRRatremu9Mm/oix7XQJN3fQKeOsXhVRX1oFV3Dh/wZDoF0SUyewZkDechIPAxABoaFyYH7Bi9rXNrTJdjuCi/UwywtCKNuM9biDiWgh18pd4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772206665; c=relaxed/simple;
	bh=N2R00FJ+7d1k7JQ+iW5UMQ3SU4AEK5/LGNavzwQ8RVs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GtgkyiU/Bnzvavp0sphS8CgHeLpDxhMn1nw7m/mEhDOOCfrn9726ivqj8vBFK5QsiygEgDB7hGc5qcWFEJEuiQJX5Jtrvded2jd2JrV2JrTXC7TOQVJUUNGME90cR77AYl1bq0Cx2TZVxuq3/5JLFf4cPDN+P09VDTiD1Z/1K40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=QMHLFA8U; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="QMHLFA8U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1772206656;
	bh=9FzERZOw4BS/qsQeVuofTxgYvCh8L3A5wSs6tnpu+HI=;
	h=From:To:Cc:Subject:Date:From;
	b=QMHLFA8UAdseSJWA+md/FvYuNDIJQ3lNdNBHgLQ3wBFeovfETUv+ev1bfYcvuin35
	 VwnVuUFoj/D92Sb9pQga5XPLxqmfN7q2slrBask0AXvmtKMnzwF1n0CksVXGs+fBIU
	 4u7bW44PFrb7H54b2XUCya/33rEoUgwAUAO/h/3UxkJuVKLkvX0PqPq0ECxf3TeUSI
	 OuAUmNGQJTwQShuh0wgH8l1RzV/SGBP6WUM4rg97jRqcSR1bwSACYcfXAwiHoOP5ZW
	 JuyS3f5epdYk6PKQnPmn0iRKF8+7xkabufclZCpgx6jqarS0igGhji6Y/yS9Py7Kdp
	 36Gd6lVEPdzCg==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4fMssD4BkMzKM1;
	Fri, 27 Feb 2026 10:37:36 -0500 (EST)
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
Subject: [PATCH v18 0/3] Improve proc RSS accuracy
Date: Fri, 27 Feb 2026 10:37:27 -0500
Message-Id: <20260227153730.1556542-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series introduces the hierarchical tree counter (hpcc) to increase
accuracy of approximated RSS counters exposed through proc interfaces.

With a test program hopping across CPUs doing frequent mmap/munmap
operations, the upstream implementation approximation reaches a 1GB
delta from the precise value after a few minutes, compared to a 80MB
delta with the hierarchical counter. The hierarchical counter provides a
guaranteed maximum approximation inaccuracy of 192MB on that hardware
topology.

This series is based on tag v7.0-rc1.

The main changes since v17:
- Fix patch series bissectability.
- Export GPL symbols for kunit tests.
- Improve kunit tests coverage.
- Fix kunit tests wait queue head reinit bug.
- Fix an out-of-bound on bootup on configurations where nr_cpu_ids is
  close to NR_CPUS.

Andrew, this series targets 7.1.

Thanks!

Mathieu

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
  lib: Test hierarchical per-cpu counters
  mm: Improve RSS counter approximation accuracy for proc interfaces

 .../core-api/percpu-counter-tree.rst          |  75 ++
 include/linux/mm.h                            |  19 +-
 include/linux/mm_types.h                      |  54 +-
 include/linux/percpu_counter_tree.h           | 367 +++++++++
 include/trace/events/kmem.h                   |   2 +-
 init/main.c                                   |   2 +
 kernel/fork.c                                 |  22 +-
 lib/Kconfig                                   |  12 +
 lib/Makefile                                  |   1 +
 lib/percpu_counter_tree.c                     | 702 ++++++++++++++++++
 lib/tests/Makefile                            |   2 +
 lib/tests/percpu_counter_tree_kunit.c         | 399 ++++++++++
 12 files changed, 1627 insertions(+), 30 deletions(-)
 create mode 100644 Documentation/core-api/percpu-counter-tree.rst
 create mode 100644 include/linux/percpu_counter_tree.h
 create mode 100644 lib/percpu_counter_tree.c
 create mode 100644 lib/tests/percpu_counter_tree_kunit.c

-- 
2.39.5
