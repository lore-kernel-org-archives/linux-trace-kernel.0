Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F15B2F90E0;
	Wed, 14 Jan 2026 14:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768402762; cv=none; b=dyvfjcqCePteU9kIqjWI/ws4Ahh9/U5PDVvPwyNpSTtAWt0gDT4E1SpBcMnQU7jbXLWGnqUvc6TTvlbUIrasFnq15Uv8w5R6j8rgzVO+djQ9T3/qiFLCMPJ1tug+2bIt3cMU6WwGQX+CTE+mNtJAlynNXVcKAcBVW9ABUT5Egqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768402762; c=relaxed/simple;
	bh=f8KxKxUhrmg9qpYVR2Ttw+Tqn+BmnGT7lyNSIYQ+mxo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iLzq+cdDOf42ds+7xpV+wYlLBAw4mPAlyg7xTkuKjkH4ZeC//1oi2Uvn0gy2DfIsE601Yzc61GoYwuAmWnBqj9aE4iEWaef/vqEN9wLuoEJsOhD1w5MOfuFUIYEZDugjoqYSHaHzotB1Ty3/Z7Hu/fxAMcfI/dpsRZ/d4h85RMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=EgpdmmB0; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="EgpdmmB0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1768402760;
	bh=gmDWQxZXl+iq5JtzXMv1UfK4Kj8WDaLba3HxCXNbTAQ=;
	h=From:To:Cc:Subject:Date:From;
	b=EgpdmmB0iMS3s52XNQ4OgK/nv1/dt8wN4bABj6J/VpYqJeI+Lwqj6hh/z22KzuxbP
	 D6VTr8rQAP07R2bVV3x7I8EvA50BSRZK9xTbbr6fZJ0J7gjOgIGDXUO88eKKlcYz1+
	 MbBLEcMlJGKQ/pCMgU+fY/bsJBXBDmla5XwPscX4mBRUZphWBCU4yCnbzrvRyuCrVq
	 JsEvgMAbJM5OQYBYpIhaidMLaCaOpo9DDEnyH/TNZ78Y/DX45AUhiAVF2gCVXiF/Fh
	 KaD6/13uRKUplAwxGTUm6/bKtq7d1jnydfPPube5mmOxltUe7YTZ6/GpBiR6H3lY1e
	 qmCxRnV3dyRnw==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4drq5N0jGHzkxF;
	Wed, 14 Jan 2026 09:59:20 -0500 (EST)
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
Subject: [PATCH v16 0/3] Improve proc RSS accuracy and OOM killer latency
Date: Wed, 14 Jan 2026 09:59:12 -0500
Message-Id: <20260114145915.49926-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series use the hierarchical tree counter approximation (hpcc) to:

* Increase accuracy of approximated RSS counters exposed through proc
  interfaces:

With a test program hopping across CPUs doing frequent mmap/munmap
operations, the upstream implementation approximation reaches a 1GB
delta from the precise value after a few minutes, compared to a 80MB
delta with the hierarchical counter. The hierarchical counter provides a
guaranteed maximum approximation inaccuracy of 192MB on that hardware
topology.
 
* Implement the OOM killer task selection with a 2-pass algorithm. This
  is a latency reduction improvement of the OOM killer task selection:

Testing the execution time of select_bad_process() with a single
tail -f /dev/zero:

    AMD EPYC 9654 96-Core (2 sockets)
    Within a KVM, configured with 256 logical cpus.

                                      | precise sum |   hpcc   |
    ----------------------------------|-------------|----------|
    nr_processes=40                   |    0.5 ms   |   0.3 ms |
    nr_processes=10000                |   80.0 ms   |   7.9 ms |

I'm sending this series to gather feedback. I plan to re-submit it for
inclusion into mm-new _after_ the next merge window closes, so the bug
fix "mm: Fix OOM killer inaccuracy on large many-core systems" can be
tested in the current release cycle.

Andrew, if you have a prior version of this specific series in mm-new,
please drop it for now.

This series is based on v6.19-rc4, on top of the following three
preparation series:

https://lore.kernel.org/linux-mm/20251224173358.647691-1-mathieu.desnoyers@efficios.com/T/#t
https://lore.kernel.org/linux-mm/20251224173810.648699-1-mathieu.desnoyers@efficios.com/T/#t
https://lore.kernel.org/linux-mm/20260114143642.47333-1-mathieu.desnoyers@efficios.com/

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
  mm: Improve RSS counter approximation accuracy for proc interfaces
  mm: Reduce latency of OOM killer task selection with 2-pass algorithm

 .../core-api/percpu-counter-tree.rst          |  75 ++
 fs/proc/base.c                                |   2 +-
 include/linux/mm.h                            |  49 +-
 include/linux/mm_types.h                      |  54 +-
 include/linux/oom.h                           |  11 +-
 include/linux/percpu_counter_tree.h           | 367 ++++++++++
 include/trace/events/kmem.h                   |   2 +-
 init/main.c                                   |   2 +
 kernel/fork.c                                 |  22 +-
 lib/Makefile                                  |   1 +
 lib/percpu_counter_tree.c                     | 679 ++++++++++++++++++
 mm/oom_kill.c                                 |  84 ++-
 12 files changed, 1295 insertions(+), 53 deletions(-)
 create mode 100644 Documentation/core-api/percpu-counter-tree.rst
 create mode 100644 include/linux/percpu_counter_tree.h
 create mode 100644 lib/percpu_counter_tree.c

-- 
2.39.5
