Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A477A36E48B;
	Tue, 17 Feb 2026 16:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771345034; cv=none; b=d025baDUt0thTsA51xgOL4laWWGTeyHO+rhTzbDXdn5RB/yQIubpN6xosJpDLLYEeKQ+xn6ltcohOH2tznr03PLnC+aaxla/bDdLM4N5N5j5HEHg48HrQydAdyROCtzh6/Zi7nQT94vV4gxenEWBzaR0g8VGMPA7O8Yg/CpB6+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771345034; c=relaxed/simple;
	bh=9xtudly2mJ1u2vHo7FyxKYLIqDgx5hdFyDtsYcMtw7w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JkLMmZ6TOsWBzQCXKdLY+d1PRj4WL+hpR58mJb9MMkwI1RXW6KbB/gSjXz8uidD683ymns09yQLsKlx/qYTFFboWksYzGo/JWkU7hmXtsViRnJCDXJCA5N+bYtOY0Vud7q3+3ru2WHGfJTP/S8C2+0r7CTfVXjG7dbXsSwVy/VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=uiYw6nyk; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="uiYw6nyk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1771344616;
	bh=7oSA143xwhlpR+YOhY78eAKWPWQQBvPwfH3/iKdQHP0=;
	h=From:To:Cc:Subject:Date:From;
	b=uiYw6nykBEOTbBd3NOKpiB9QphOhW+vwiQiTPXqz4H8uGpnsbjc+Fq0w8CK2gpp+w
	 GZvzUdguuC4ODm1aNGDOjtOes6HF7kk+Pbus/xn2lJHwHXjCibwYJaXU9w/7/BmXed
	 5KxiI0Z6Pu/eByLlsFeEaOZZAHGAnKGyI0ZAs4VxDPKzydNJyb9aiOR6pftCCZD8tY
	 qv6l7x0uo70/Eh+AB0p8AOjxIxZyBFDhm8NdZ+mclPMp40JETVmaUF5HI8ZnkbP3of
	 3ZacZfK1ILpW8adMk6795otJmIk5CmdSSEPF0MOAjAnNydDAE25J+dKkIxwwj5eouP
	 5NgWTC5HqaQ4w==
Received: from thinkos.internal.efficios.com (unknown [IPv6:2606:6d00:100:4000:1cd8:5cbf:5001:d5b1])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4fFl3X13D5zFT9;
	Tue, 17 Feb 2026 11:10:16 -0500 (EST)
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
Subject: [PATCH v17 0/3] Improve proc RSS accuracy
Date: Tue, 17 Feb 2026 11:10:03 -0500
Message-Id: <20260217161006.1105611-1-mathieu.desnoyers@efficios.com>
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

This series is based on
commit 0f2acd3148e0 Merge tag 'm68knommu-for-v7.0' of git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu

The main changes since v16:
- Dropped OOM killer 2-pass task selection algorithm.
- Introduce Kunit tests.
- Only perform atomic increments of intermediate tree nodes when
  bits which are significant for carry propagation are being changed.

Andrew, this is meant to target 7.1 after the 7.0 merge window closes.

Thanks,

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
 include/linux/percpu_counter_tree.h           | 367 ++++++++++
 include/trace/events/kmem.h                   |   2 +-
 init/main.c                                   |   2 +
 kernel/fork.c                                 |  22 +-
 lib/Kconfig                                   |  12 +
 lib/Makefile                                  |   1 +
 lib/percpu_counter_tree.c                     | 690 ++++++++++++++++++
 lib/tests/Makefile                            |   2 +
 lib/tests/percpu_counter_tree_kunit.c         | 351 +++++++++
 12 files changed, 1567 insertions(+), 30 deletions(-)
 create mode 100644 Documentation/core-api/percpu-counter-tree.rst
 create mode 100644 include/linux/percpu_counter_tree.h
 create mode 100644 lib/percpu_counter_tree.c
 create mode 100644 lib/tests/percpu_counter_tree_kunit.c

-- 
2.39.5
