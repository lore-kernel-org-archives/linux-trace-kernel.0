Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794429412;
	b=qsgZdlhDLesScKfnHEM2aQiX29pjmy+k1w46+tNxqqgRVUDkIyV+Oe3mVGJaKooSGGd6
	 6anZYlIfD9i44kxDevJeCQxRidmzVckq4ZN9qZVTpOIdMLpECqsIK8SBfn2ttAg4ROE3M
	 CyOljKvxRNICjLb8AupDKetdJT/VyjdsxhR54iZ8ofYa8RTyoNoRYujYEfTyOrZdsjuES
	 FjvJ+IYh1ceALyE0od0kw8FSjIgi466GO+Id1pZ2dhzNrn/gg8OG6PIp0I7Va6eYf4DOe
	 KvpS8fMwfTHNm9KW9vomos+tr00FmDMQSEo/VdiLxo5LjniAMGz96j7zqsEL0fUYpiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794429412;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=iNelVVVQ6UGMHgjtzzgPBEP9I9g97zvZFPWu2zPDn+Q=;
	b=uIOSIXu60bTF99hHIWDzvUY4aC5EnRjrtD+/apOqYS4NACLti5iJ65PLNqiZGzALPb0o
	 Ci7boyiCbhQUYPWmkLDyR00Rg2og2ctBlypBcQ1jZwDdxEVNVmvUNtn+bYY/CgioSp/dd
	 Va45uJENhCKpaaRnpkAvWuSHA9V+ZZGNSVNx0S7ZUUWyMa3K1uD9Thg4zXKp7B/Moysuq
	 FmgwQ6KnsLs75hs/dks/qUMRkHDBVQVWPTPb24rOJNwGstaTDzMiBv3Qd462TPJ4vBbpQ
	 AA/l4iq2kPRK1ZDoLiLriuHngWEq5rC7EqTLlwVbI7IE0FpMn3hEV4GTCDwNPtVJU5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=DysndmlN;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFF7606A324;
	Wed, 11 Nov 2026 20:36:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EFF7606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=DysndmlN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1794429404;
	bh=iNelVVVQ6UGMHgjtzzgPBEP9I9g97zvZFPWu2zPDn+Q=;
	h=From:To:Cc:Subject:Date:From;
	b=DysndmlNPCYGZnFFIoSjZ6ntTNq+Fb5zqeWwYA4WwXJJbIF6d/3NBzeJiokBOC8u5
	 0w+9FKhpwCK7S++HYy2dE+3EmSvWT4DN4yW3o1yOzO+leAaTh9BcWFLicG4+51A61U
	 gHYJH2iW1Dhv+SZZGZcwSvj976YuWLvTlNRIhqwoO8/RajIOcdW8G5GdZJOP/5B9Z/
	 R+J8zPI5rnU8KfOJhcfr0wBGhhqVekwO+sT1kH9VaqNUM0HvjalfGsqR6qwkfXIZET
	 71DGVmLe3WXMzGZk01c8z5sYu5Hy8toc+SwEMkDfnABYH9+mQB0ciW/xWVSOQeeaLp
	 D1SmjIga6Ez3g==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jPwKm0dZZzNJW;
	Wed, 11 Nov 2026 15:36:44 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: David Hildenbrand <david@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>,
	Martin Liu <liumartin@google.com>,
	David Rientjes <rientjes@google.com>,
	christian.koenig@amd.com,
	Shakeel Butt <shakeel.butt@linux.dev>,
	SeongJae Park <sj@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Yu Zhao <yuzhao@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Aboorva Devarajan <aboorvad@linux.ibm.com>,
	David Carlier <devnexen@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-doc@vger.kernel.org,
	Harry Yoo <harry@kernel.org>,
	Hao Li <hao.li@linux.dev>,
	Kees Cook <kees@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	linux-trace-kernel@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Oleg Nesterov <oleg@redhat.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Andrea Parri <parri.andrea@gmail.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Hugh Dickins <hughd@google.com>
Subject: [RFC PATCH v25 00/14] Hierarchical Percpu Counters for RSS and tmpfs
Date: Wed, 11 Nov 2026 15:36:12 -0500
Message-Id: <20261111203626.95838-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi David,

Here is the hierarchical per-cpu counters series, based on v7.4-rc2.
After your review of v24 [3], v25 adds a second user in patches 8 to
11. This user is the tmpfs size limit. It is still an RFC because of the
questions at the end.

The problem
-----------

The RSS counters are struct percpu_counter since
commit f1a7941243c1 ("mm: convert mm's rss stats into percpu_counter").
Their batch size is max(32, 2 * nr_cpus). So their error grows with
nr_cpus^2. At 384 logical CPUs, it reaches 1.1GB per counter.

/proc/PID/status, /proc/PID/statm and the OOM killer now use precise
sums (commits 82241a83cd15 and 5898aa8f9a0b). Other readers still use
the approximation:

- the RSS high watermark (VmHWM, ru_maxrss, taskstats);
- /proc/PID/stat (ps, top, monitoring agents);
- the taskstats RSS-time integral (coremem);
- NUMA balancing and the mark_victim tracepoint.

On the test machine below, /proc/PID/stat was off by 17MB for a
single-threaded process. It was off by up to 134MB with 64 threads.

Precise sums cannot fix the high watermark or the integral. They are
sampled on every unmap and at each tick. A precise sum reads every
possible CPU: about 4us per counter at 384 logical CPUs. A smaller batch
takes the counter spinlock on every carry. At batch 32, an update of a
shared mm costs 4.4 to 69us with one thread per CPU. With this series,
it costs 26ns to 1.2us.

The tmpfs size limit has the same problem in another form.
percpu_counter_limited_add() takes no lock only while the mount is more
than batch * nr_cpus pages below its size. This is 1.1GB at 384 logical
CPUs. A smaller mount, such as a 64MB /dev/shm, takes the counter
spinlock and sums all CPUs for each page.

The series
----------

Patches 1 to 5 use hierarchical per-cpu counters for the RSS counters.
Per-cpu bytes carry into a tree of atomic counters. The tree is shaped
at boot from nr_cpu_ids. The batch is 32 and the error bound is in
O(n*log(n)). There is no global lock. A follow-up will use the
comparison functions for the OOM killer task selection.

Patches 6 and 7 keep the RSS counters of single-threaded processes
exact, without per-cpu memory. Until a second thread shares the mm, the
counters are a plain bias and an atomic bias. Creating the second
thread allocates the per-cpu counters and activates the tree. Most
processes never need that per-cpu memory, so process creation gets
cheaper. In a 384-vCPU guest, posix_spawn() of a static program gains
22 to 42% over patches 1 to 5.

Patch 8 adds limit counters on the tree. A limit counter splits the
value into two counters which only grow: the additions and the
subtractions. Their carries are ordered so that each sum errs in one
direction only. An addition then checks the limit without a lock. It
sums the CPUs only within the accuracy of the limit. The limit stays
strict. Patch 9 tests the limit counters, and patch 10 checks their
memory ordering with litmus tests. Patch 11 uses a limit counter for
the tmpfs size limit.

Patches 12 to 14 are tools to check the tree shape on other hardware:
two boot parameters and a KUnit benchmark. I measured the defaults on
one machine only, so results from other hardware are welcome.

Results
-------

The machine is a 2-socket AMD EPYC 9654 with 384 logical CPUs. The
tree is 8,8,8 with batch 32. Patches 3, 7 and 11 have the details. The
bare-metal results were measured on v7.3.

  Accuracy per counter, bound and largest error seen, while a process
  hops across all CPUs (384-vCPU guest pinned to the host):

                                        hpcc   upstream
    bound                            158.5MB      1.1GB
    measured, single-threaded      0 (exact)      841MB
    measured, with a second thread      96MB      845MB

  Update cost, ns per update, one thread per CPU, bare metal (mm: the 4
  counters of one mm; private: one counter per thread):

                                              upstream   upstream
                                       hpcc  batch 768   batch 32
    mm, +1                               26        288       4370
    mm, random +-32                     135        385      69171
    mm, random +-512                   1174      20229      69186
    private, random +-32                 31         20          -

  Memory per mm, in bytes (guest, v7.4-rc1):

                  single-threaded   threaded   upstream
    16 CPUs                  1820       1948       2076
    384 CPUs                 1928       8145       8072
    1024 CPUs                2185      17204      18569

  tmpfs, fallocate() of one page at a time, in thousands of calls per
  second (384-vCPU guest, v7.4-rc2):

    size=  processes   upstream    hpcc
    64MB           1        208     483
    64MB         384        126   54275
    1GB          384        125   93879
    2GB          384      93851   93476

Behavior changes
----------------

- The per-cpu counters are allocated by the second thread, not by
  fork(). So clone() with CLONE_VM can now fail with -ENOMEM.
- mm_struct gains rss_owner and rss_stat_mutex. rss_owner is the task
  running on the mm. It is never dereferenced.
- The precise sums take no lock. Under concurrent updates, they can miss
  a carry on its way up the tree. They are exact for a process at rest.
- The rss_stat tracepoint reports the approximation (patch 5).
- tmpfs (patch 11): an allocation near a full mount can fail although
  it fits. This happens while a concurrent allocation which does not
  fit is undone. A remount keeps the batch size of the first size.

Caveats
-------

- From 33 to 39 CPUs, the RSS counters are up to 1.37 times less
  accurate than upstream.
- Just above a power of 2 CPUs, a threaded process uses up to 1.50
  times the memory of upstream for its RSS counters.
- A multi-threaded process which ran on few CPUs can hold more error
  than upstream.
- With 384 threads created at once, the per-cpu allocator serializes
  the allocations, as it does upstream at every fork.
- tmpfs: in the last 1/4 of the size, each allocation sums all CPUs.
  With one process, this is 37% slower than upstream.

Changes since v24 [2]
---------------------

- Rebased onto v7.4-rc2.
- New patches 8 to 11: the tmpfs size limit. In my reply to your review
  [3], I wrote that mounts of 2GB and above lose 1 to 2%. Measured
  again on v7.4-rc2, they are within 1%.
- New litmus tests in patch 10, in tools/testing/hpcc/litmus. They check
  the memory ordering of the limit counters, of the carries and of the
  publication of the tree. Variants without an ordering show that it is
  needed.
- Patch 6 (Sashiko): the activation race test releases its workers with
  release/acquire.
- Patches 12 to 14 were patches 8 to 10, unchanged.

The v24 cover letter [2] lists the earlier changes, since v22 [1].

These tests pass on v7.4-rc2:

- Every commit builds without warnings on x86_64 (SMP and UP), arm64,
  ppc64le, 32-bit powerpc and sparc64. Sparse adds no warnings.
- KUnit passes in guests with 1, 16 and 384 vCPUs. It also passes with
  lockdep with 16 and 64 vCPUs.
- The userspace test passes on simulated topologies up to 65536 CPUs,
  as a 64-bit and a 32-bit build.
- The RSS counters match a page table walk from 1 to 64 threads.
- herd7 checks the memory ordering of the limit counters with litmus
  tests.

I wrote v22. Starting from it, an LLM coding assistant drove the
implementation of this revision from my design decisions. It wrote the
code, the tests, the benchmark and the measurement scripts. It ran the
measurements in guests and prepared the bare-metal ones. It drafted the
comments, the changelogs and this letter. I made the design decisions,
reviewed every change and directed the rework through my review
comments.

Questions
---------

David answered the questions of v24 [3]. These remain open:

1. Fork and exit reviewers: is mm->rss_owner acceptable (patch 7)? The
   alternative is current->mm == mm and an "activated" flag.
2. Martin: the rss_stat tracepoint now reports the approximation (patch
   5). Is that fine for its users, such as Perfetto?
3. Who could run the benchmark of patch 14 on non-AMD, arm64 or POWER
   machines? The defaults were only measured on one machine.
4. tmpfs maintainers: are the behavior changes of patch 11 acceptable?

Thanks,

Mathieu

[1] https://lore.kernel.org/lkml/20260227153730.1556542-1-mathieu.desnoyers@efficios.com/
[2] https://lore.kernel.org/lkml/20261105203639.1459524-1-mathieu.desnoyers@efficios.com/
[3] https://lore.kernel.org/lkml/88a96126-11be-41cc-ab0d-372d32189e79@kernel.org/

Mathieu Desnoyers (14):
  lib: introduce hierarchical per-cpu counters
  lib: test hierarchical per-cpu counters
  mm: use hierarchical per-cpu counters for the RSS counters
  tools/testing/hpcc: add userspace test of hierarchical per-CPU
    counters
  mm: report the approximate RSS in the rss_stat tracepoint
  lib: percpu_counter_tree: add lazy tree activation
  mm: keep the RSS counters of single-threaded processes exact
  lib: percpu_counter_tree: add limit counters
  lib: percpu_counter_tree: test the limit counters
  tools/testing/hpcc: add litmus tests of the memory ordering
  mm: shmem: use a limit counter for the tmpfs size limit
  lib: percpu_counter_tree: add the arity boot parameter
  mm: add the rss_stat_batch boot parameter
  lib: add a benchmark of hierarchical per-cpu counters

 .../admin-guide/kernel-parameters.txt         |   24 +
 Documentation/core-api/index.rst              |    1 +
 .../core-api/percpu-counter-tree.rst          |  145 ++
 MAINTAINERS                                   |   12 +
 fs/exec.c                                     |    5 +
 include/linux/mm.h                            |   28 +-
 include/linux/mm_types.h                      |   19 +-
 include/linux/percpu_counter_tree.h           |  445 +++++
 include/linux/shmem_fs.h                      |    3 +-
 include/trace/events/kmem.h                   |    3 +-
 init/main.c                                   |    3 +
 kernel/exit.c                                 |    3 +
 kernel/fork.c                                 |   61 +-
 lib/Kconfig                                   |   27 +
 lib/Makefile                                  |    1 +
 lib/percpu_counter_tree.c                     | 1776 +++++++++++++++++
 lib/tests/Makefile                            |    3 +
 lib/tests/percpu_counter_tree_bench.c         |  610 ++++++
 lib/tests/percpu_counter_tree_kunit.c         | 1240 ++++++++++++
 mm/shmem.c                                    |   33 +-
 tools/testing/hpcc/.gitignore                 |    2 +
 tools/testing/hpcc/Makefile                   |   18 +
 tools/testing/hpcc/include/hpcc_shim.h        |  253 +++
 tools/testing/hpcc/include/kunit/visibility.h |    2 +
 tools/testing/hpcc/include/linux/args.h       |    4 +
 tools/testing/hpcc/include/linux/atomic.h     |    2 +
 tools/testing/hpcc/include/linux/bug.h        |    2 +
 tools/testing/hpcc/include/linux/cache.h      |    2 +
 tools/testing/hpcc/include/linux/cpumask.h    |    2 +
 tools/testing/hpcc/include/linux/errno.h      |    3 +
 tools/testing/hpcc/include/linux/limits.h     |    2 +
 tools/testing/hpcc/include/linux/math.h       |    2 +
 .../testing/hpcc/include/linux/moduleparam.h  |   12 +
 tools/testing/hpcc/include/linux/percpu.h     |    2 +
 .../hpcc/include/linux/percpu_counter_tree.h  |    2 +
 tools/testing/hpcc/include/linux/preempt.h    |    2 +
 tools/testing/hpcc/include/linux/slab.h       |    2 +
 tools/testing/hpcc/litmus/README              |   61 +
 .../leave-first-precise-sum-relaxed.litmus    |   37 +
 .../litmus/leave-first-precise-sum.litmus     |   41 +
 .../litmus/limit-arrive-first-acquire.litmus  |   38 +
 .../limit-arrive-first-unordered.litmus       |   37 +
 .../hpcc/litmus/limit-arrive-first.litmus     |   41 +
 .../hpcc/litmus/limit-free-level0-nomb.litmus |   40 +
 .../hpcc/litmus/limit-free-level0.litmus      |   43 +
 .../hpcc/litmus/limit-free-root.litmus        |   42 +
 .../litmus/limit-last-checker-nomb.litmus     |   28 +
 .../hpcc/litmus/limit-last-checker.litmus     |   33 +
 .../hpcc/litmus/limit-undo-level0.litmus      |   35 +
 .../hpcc/litmus/limit-undo-root-rmb.litmus    |   30 +
 .../litmus/limit-undo-root-unordered.litmus   |   29 +
 .../hpcc/litmus/limit-undo-root.litmus        |   32 +
 .../litmus/publish-approximate-sum.litmus     |   40 +
 .../hpcc/litmus/publish-carry-normb.litmus    |   36 +
 .../testing/hpcc/litmus/publish-carry.litmus  |   43 +
 .../publish-precise-sum-noacquire.litmus      |   38 +
 .../hpcc/litmus/publish-precise-sum.litmus    |   44 +
 .../litmus/publish-update-norelease.litmus    |   34 +
 .../testing/hpcc/litmus/publish-update.litmus |   40 +
 tools/testing/hpcc/main.c                     |  892 +++++++++
 60 files changed, 6467 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/core-api/percpu-counter-tree.rst
 create mode 100644 include/linux/percpu_counter_tree.h
 create mode 100644 lib/percpu_counter_tree.c
 create mode 100644 lib/tests/percpu_counter_tree_bench.c
 create mode 100644 lib/tests/percpu_counter_tree_kunit.c
 create mode 100644 tools/testing/hpcc/.gitignore
 create mode 100644 tools/testing/hpcc/Makefile
 create mode 100644 tools/testing/hpcc/include/hpcc_shim.h
 create mode 100644 tools/testing/hpcc/include/kunit/visibility.h
 create mode 100644 tools/testing/hpcc/include/linux/args.h
 create mode 100644 tools/testing/hpcc/include/linux/atomic.h
 create mode 100644 tools/testing/hpcc/include/linux/bug.h
 create mode 100644 tools/testing/hpcc/include/linux/cache.h
 create mode 100644 tools/testing/hpcc/include/linux/cpumask.h
 create mode 100644 tools/testing/hpcc/include/linux/errno.h
 create mode 100644 tools/testing/hpcc/include/linux/limits.h
 create mode 100644 tools/testing/hpcc/include/linux/math.h
 create mode 100644 tools/testing/hpcc/include/linux/moduleparam.h
 create mode 100644 tools/testing/hpcc/include/linux/percpu.h
 create mode 100644 tools/testing/hpcc/include/linux/percpu_counter_tree.h
 create mode 100644 tools/testing/hpcc/include/linux/preempt.h
 create mode 100644 tools/testing/hpcc/include/linux/slab.h
 create mode 100644 tools/testing/hpcc/litmus/README
 create mode 100644 tools/testing/hpcc/litmus/leave-first-precise-sum-relaxed.litmus
 create mode 100644 tools/testing/hpcc/litmus/leave-first-precise-sum.litmus
 create mode 100644 tools/testing/hpcc/litmus/limit-arrive-first-acquire.litmus
 create mode 100644 tools/testing/hpcc/litmus/limit-arrive-first-unordered.litmus
 create mode 100644 tools/testing/hpcc/litmus/limit-arrive-first.litmus
 create mode 100644 tools/testing/hpcc/litmus/limit-free-level0-nomb.litmus
 create mode 100644 tools/testing/hpcc/litmus/limit-free-level0.litmus
 create mode 100644 tools/testing/hpcc/litmus/limit-free-root.litmus
 create mode 100644 tools/testing/hpcc/litmus/limit-last-checker-nomb.litmus
 create mode 100644 tools/testing/hpcc/litmus/limit-last-checker.litmus
 create mode 100644 tools/testing/hpcc/litmus/limit-undo-level0.litmus
 create mode 100644 tools/testing/hpcc/litmus/limit-undo-root-rmb.litmus
 create mode 100644 tools/testing/hpcc/litmus/limit-undo-root-unordered.litmus
 create mode 100644 tools/testing/hpcc/litmus/limit-undo-root.litmus
 create mode 100644 tools/testing/hpcc/litmus/publish-approximate-sum.litmus
 create mode 100644 tools/testing/hpcc/litmus/publish-carry-normb.litmus
 create mode 100644 tools/testing/hpcc/litmus/publish-carry.litmus
 create mode 100644 tools/testing/hpcc/litmus/publish-precise-sum-noacquire.litmus
 create mode 100644 tools/testing/hpcc/litmus/publish-precise-sum.litmus
 create mode 100644 tools/testing/hpcc/litmus/publish-update-norelease.litmus
 create mode 100644 tools/testing/hpcc/litmus/publish-update.litmus
 create mode 100644 tools/testing/hpcc/main.c


base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
-- 
2.47.3

