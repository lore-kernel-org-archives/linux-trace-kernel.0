Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793911009;
	b=n2aSC6PwLtreKraQ+a9QKs76dZuikPJRAdEoC5pXSbbBnb3CoACiE6vci6ZE6rFyNqSU
	 HMskgI90sd38Fu5zhMeeFY0Zwmqq8QE6I7PIt7kYrxXtnnNdgxknhzMz+rO/MRkJWH0+G
	 nN2EViQh3prY55eFcVW0KafMqvpSxo8q64LNObVUvCJRvUDY6kpkmDc9m+MjKf+pX2zk1
	 YSOcKNxuJU2wSzNkELDLOVK6VQxhzlWH47x7CVYTHYjDD/Jrl5U6+218T3sopAN1vkgvH
	 8AQbUSpAwoJhDm5Qu1jWAsOwGNph+PUVJXi+pyGDCHltikXzZOW9eZahXDVFoBx5E2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793911009;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ZQPXM1FTewVZS/83sB0Ec0VTDBGQfcoM690LbZEKVQU=;
	b=Cylu7drocawn8Pv1Dp50b4O36U9KKvgUfUQAMhcbyWQRCvMfUkPmCXpfwDph4eVKZ4p8
	 rS8C2syAbg3iDdLSSthRLUpmiY5zRwZemnGnfIZXCx6dlbtHk3onZtuymESPzuY9y5SOs
	 A569A6BakBk956DwJ6vwvCPj23uEFlgFW4a5FNd154R2wurqL6rSrE2CXnd4q3lih/z4Q
	 iPY8yF3KXJwED5XxS6KZBqc2pMbCS5jkL1VTyqRfhrsMd5Qwjmk/mjBoMxXwO81DHQBRF
	 sJIyeZPfiHjPRnkKSsAXvpF8dKDxkAePaJW7iTp2AM7jdArdJ3CHLCKqmfApeOS8SBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=iUGBWdlH;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CA8606A326;
	Thu,  5 Nov 2026 20:36:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41CA8606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=iUGBWdlH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1793911007;
	bh=ZQPXM1FTewVZS/83sB0Ec0VTDBGQfcoM690LbZEKVQU=;
	h=From:To:Cc:Subject:Date:From;
	b=iUGBWdlHAlSbnHErEYzQi/NKQzj3wzm4ZGAYXiJ/pqNbSSfAORxBgHl39fnZWJptC
	 gTBMGXigq1JLi/koCN8m82rr0PeQuXVNF89mMEuivq9LI1t9cuOPcs9ELjJhtZfWNu
	 gEBxC6SeY0/f/fX3SLh9xVFPFMKoMsxB7CiJtaSWI7An6apscDOxgVtwrcFI5kAKFy
	 l0bQ/oNSJc2TZnRjUAnBl+PFcc8919kK8uvw7sKJKjYp1j8t2hYxFyc2cCbPld4mw5
	 1lri7IBw0vGln3ud+CEFqgBAHEHGnAtmyK3iRozJKbp+uRQBpwFYaLJvqPYB41/1QN
	 GHurq29h8shgw==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jLDcZ6rbLzLfK;
	Thu, 05 Nov 2026 15:36:46 -0500 (EST)
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
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Kees Cook <kees@kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Oleg Nesterov <oleg@redhat.com>
Subject: [RFC PATCH v24 00/10] Hierarchical Percpu Counters for RSS
Date: Thu,  5 Nov 2026 15:36:29 -0500
Message-Id: <20261105203639.1459524-1-mathieu.desnoyers@efficios.com>
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

Here is the hierarchical per-cpu counters series for the RSS counters,
based on v7.4-rc1.  It is an RFC because of the questions at the end,
and because of the significant changes since v22 [1], notably the
per-cpu counter size (long -> byte), the configuration heuristics, and
the lazy activation introduced by patches 6 and 7.  v24 fixes the bugs
found by the Sashiko review of v23 [2], including a NULL pointer
dereference in patches 3 to 5 on sparc64.

The problem
-----------

Since commit f1a7941243c1 ("mm: convert mm's rss stats into
percpu_counter"), the RSS counters are struct percpu_counter with a
batch size of max(32, 2 * nr_cpus): their approximation error grows with
O(nr_cpus^2), up to 1.1GB per counter at 384 logical CPUs.
/proc/PID/status, /proc/PID/statm and the OOM killer moved to precise
sums (commits 82241a83cd15 and 5898aa8f9a0b), but the other readers
still use the approximation: the RSS high watermark (VmHWM, the
ru_maxrss reported as "Maximum resident set size" by /usr/bin/time -v,
taskstats), /proc/PID/stat (ps, top, monitoring agents), the taskstats
RSS-time integral (coremem, sampled at each tick), NUMA balancing and
the mark_victim tracepoint.  On the test machine below, the
/proc/PID/stat RSS of a test process was off by 17MB while
single-threaded, and by up to 134MB with 64 threads.

Precise sums cannot fix the high watermark or the RSS-time integral:
update_hiwater_rss() samples the RSS on every unmap path, and the
integral at each tick, while a precise sum reads every possible CPU,
about 4us per counter at 384 logical CPUs.  A smaller struct
percpu_counter batch takes the counter spinlock on every carry: at batch
32, an update of the counters of a shared mm costs 4.4 to 69us with one
thread per CPU, compared to 26ns to 1.2us with this series.

The series
----------

Patches 1 to 5 replace struct percpu_counter for the RSS counters with
hierarchical per-cpu counters: per-cpu bytes carry into a tree of atomic
counters shaped at boot from nr_cpu_ids, with a fixed batch of 32, an
error bound in O(n*log(n)) and no global lock.  Each level carries only
once its residual reaches the batch in either direction, so updates
going back and forth around a boundary do not climb the tree.  The
comparison functions have no user in this series; a follow-up will use
them for a faster OOM killer task selection.

Patches 6 and 7 keep the RSS counters of single-threaded processes exact
and without per-cpu memory: until a second thread shares the mm, the
task running on the mm adds to the bias of each counter without atomic
instructions, and other tasks add to its atomic bias, both read in O(1).
Creating the second thread allocates the per-cpu counters and tree
items, and activates the tree.  struct percpu_counter cannot do this as
is: its count is an s64 under a raw spinlock, which the remote updates
(reclaim, khugepaged, remote GUP) would then take.

Patches 8 to 10 are the tools to tune the tree shape on other hardware:
the percpu_counter_tree.arity= and rss_stat_batch= boot parameters, and
a KUnit benchmark.  The default shapes were measured on one machine,
with up to 384 logical CPUs, so results from other hardware are welcome.

Results
-------

2-socket AMD EPYC 9654, 192 cores, 384 logical CPUs with SMT (the CPU
counts in this letter are logical CPUs, as in nr_cpu_ids), tree 8,8,8,
batch 32, whole series; details in patches 3 and 7.  The bare-metal
results were measured on v7.3: the rebase onto v7.4-rc1 had no conflict,
and the hpcc update costs of the series as sent, measured in a pinned
384-vCPU guest, match the bare-metal ones within 2%.

  Accuracy per counter: bound, and largest |approximate - precise| seen
  by get_mm_counter() while a process hops across all CPUs doing
  mmap/munmap of 1 to 16 pages (384-vCPU KVM guest pinned to the host):

                                        hpcc   upstream
    bound                            158.5MB      1.1GB
    measured, single-threaded      0 (exact)      841MB
    measured, with a second thread      96MB      845MB

  Update cost, ns per update per thread, one thread per CPU, bare metal
  (mm: the 4 counters of one mm; private: one counter per thread; batch
  32: local change of the benchmark, bound 46.5MB):

                                              upstream   upstream
                                       hpcc  batch 768   batch 32
    mm, +1                               26        288       4370
    mm, random +-32                     135        385      69171
    mm, random +-512                   1174      20229      69186
    private, random +-32                 31         20          -

  /proc/PID/statm read with 1000 to 16000 processes, bare metal:
  5.3-6.5us vs 16.5-19.0us for single-threaded processes, on par for
  multi-threaded ones (14.4-16.0us vs 14.5-17.1us, guest).  fork + exit
  of a single-threaded child: 116us vs 139us.  will-it-scale
  page_fault1, 2 and 3: no regression (-0.6% to +5.1%, one boot each,
  the upstream one on the previous day).

  Memory per mm, counting the slab objects of mm_struct and of the tree
  items, and the per-cpu memory of the RSS counters, in bytes (guest,
  v7.4-rc1):

                  single-threaded   threaded   upstream
    16 CPUs                  1820       1948       2076
    384 CPUs                 1928       8145       8072
    1024 CPUs                2185      17204      18569

  The tree items are allocated with the per-cpu counters when the second
  thread is created, and the mm_struct slab object keeps its upstream
  size.

Behavior changes
----------------

- The allocation of the per-cpu counters and tree items moves from
  fork() to the second thread (clone() with CLONE_VM, without
  CLONE_VFORK), which can then fail with -ENOMEM.
- mm_struct gains rss_owner, the task running on the mm, compared with
  current and never dereferenced, and rss_stat_mutex, which serializes
  the activations of the tree, as mm_cid.mutex serializes the mode
  changes of mm_cid at fork and exit.
- The precise sums (/proc/PID/status, /proc/PID/statm, the OOM killer)
  take no lock: under concurrent updates of a multi-threaded process,
  they can miss a carry on its way up the tree, where upstream counts
  each concurrent update either whole or not at all.  They are exact for
  a process at rest.
- The rss_stat tracepoint reports the approximation (patch 5): exact for
  single-threaded processes, within the bound otherwise.
- Like struct percpu_counter, the tree is sized at boot and not
  reshaped on hotplug; its shape and bound depend on nr_cpu_ids, while
  the default upstream batch follows the online CPUs.

Caveats
-------

- From 33 to 39 CPUs, up to 1.37 times less accurate than upstream.
- The tree is shaped for the number of CPUs rounded up to a power of 2:
  just above a power of 2, the RSS counters of a threaded process, with
  rss_owner and the mutex, use up to 1.50 times the memory of upstream
  (129 CPUs, 1.28 times at 65 and 1.38 times at 257), compared to at
  most 0.90 times at a power of 2, and 1.02 times at 384 logical CPUs.
- Private counters with random +-32 updates: 31ns vs 20ns, the price of
  a 7 times tighter bound.
- A multi-threaded process which ran on few CPUs can hold more error
  than upstream: 2047 pages per CPU path vs 767 at 384 logical CPUs.  A
  follow-up could index the counters by concurrency ID (mm_cid) instead
  of CPU, so the accuracy bound and the precise sums would scale with
  the concurrency the process uses.
- Before activation, concurrent remote updates of a single-threaded
  process contend on one atomic per counter.
- The second thread allocates per-cpu memory, which the per-cpu
  allocator serializes, as it does upstream at every fork: with 384
  threads at once, init + destroy of 4 counters takes 874us per
  operation (1004us upstream, 6.0us alone).  Tree item slab objects
  owning their per-cpu counters, with slab destructors, could avoid it.
- The accuracy was measured in a guest, with a debug patch and a test
  program which are not part of the series.  The bound is analytic and
  tested in both directions.

Changes since v23 [2]
---------------------

- Patch 1: percpu_counter_tree_approximate_sum() reads a zeroed counter
  as 0, like a zeroed struct percpu_counter, as its kerneldoc now says.
  sparc64 init_new_context() reads the RSS counters after mm_init()
  zeroes them, before their initialization: patches 3 to 5 dereferenced
  a NULL pointer there on sparc64 SMP (noted in Sashiko's review data,
  not in its report). The KUnit test checks it.
- Patch 2 (Sashiko): the single-threaded tests select the first online
  CPU with the CPU hotplug lock held; the contended carries test
  publishes its start flag with release/acquire; the saturated compare
  test checks that every possible CPU is online with the CPU hotplug
  lock held.
- Patch 4 (Sashiko): no counter leak when an initialization fails.
- Patch 10 (Sashiko): the lifecycle and churn sets of counters are no
  longer on the stack, where debugobjects warns about a struct
  percpu_counter.
- Not changed (Sashiko, patch 10): percpu_counter_tree_bench.batch is
  not listed in kernel-parameters.txt, like the parameters of other test
  modules (test_vmalloc, test_lockup); MODULE_PARM_DESC and the Kconfig
  help document it.

Changes since v22 [1]
---------------------

- Per-cpu byte counters with hysteresis, updated with
  this_cpu_try_cmpxchg(); the tree items of counters initialized
  together share cache lines; the library allocates the per-cpu
  counters and tree items, so struct percpu_counter_tree has a fixed
  size of 40 bytes, like struct percpu_counter, and mm_struct no longer
  embeds tree items.
- Flat tree up to 32 CPUs, 16,4 up to 64, fan-out 8 beyond, with a root
  fan-out of 16 when one order remains (8,16 at 128 CPUs, 8,8,16 at
  1024).
- New patches 6 and 7, for single-threaded processes.
- Fixed approximation margins in the comparison functions; hysteresis
  on the intermediate levels, so the accuracy range is exact and
  symmetric.
- Userspace test of every tree configuration, KUnit tests on per-CPU
  workqueues, Sashiko review comments, MAINTAINERS entry.

Testing: every commit builds without warnings on x86_64 (SMP and UP),
arm64, ppc64le, 32-bit powerpc and sparc64, sparse adds no warnings,
KUnit passes on bare metal (v7.3), in guests with 1, 16 and 384 vCPUs,
and on big-endian sparc64 in qemu (1 CPU), the userspace test passes on
simulated topologies up to 65536 CPUs, and the RSS counters match a page
table walk from 1 to 64 threads.  KUnit and the RSS check also pass with
lockdep (PROVE_LOCKING) in guests with 16 and 64 vCPUs, without report.

Starting from v22, which I wrote, an LLM coding assistant drove the
implementation of this revision from my design decisions: it wrote the
code, the tests, the benchmark and the measurement scripts, ran the
measurements in guests and prepared the bare-metal ones, and drafted the
comments, the changelogs and this letter.  I made the design decisions,
reviewed every change and directed the rework through my review
comments.

Questions
---------

1. Is mm->rss_owner acceptable, or would you prefer current->mm == mm
   (without PF_KTHREAD) and an "activated" flag?
2. Is moving the -ENOMEM from fork() to the second thread acceptable?
3. Would you rather take the single-threaded mode first, on its own?
4. Should the rss_stat tracepoint report the approximation, stay
   precise, or report both?
5. Should the tuning tools be merged, built only with the benchmark
   config, or dropped later?  Who could run them on non-AMD, 4-socket,
   arm64 or POWER machines?
6. Is tools/testing/hpcc the right home for the topology test?

Thanks,

Mathieu

[1] https://lore.kernel.org/lkml/20260227153730.1556542-1-mathieu.desnoyers@efficios.com/
[2] https://lore.kernel.org/lkml/20261102190708.1287100-1-mathieu.desnoyers@efficios.com/

Mathieu Desnoyers (10):
  lib: introduce hierarchical per-cpu counters
  lib: test hierarchical per-cpu counters
  mm: use hierarchical per-cpu counters for the RSS counters
  tools/testing/hpcc: add userspace test of hierarchical per-CPU
    counters
  mm: report the approximate RSS in the rss_stat tracepoint
  lib: percpu_counter_tree: add lazy tree activation
  mm: keep the RSS counters of single-threaded processes exact
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
 include/linux/percpu_counter_tree.h           |  372 +++++
 include/trace/events/kmem.h                   |    3 +-
 init/main.c                                   |    3 +
 kernel/exit.c                                 |    3 +
 kernel/fork.c                                 |   61 +-
 lib/Kconfig                                   |   27 +
 lib/Makefile                                  |    1 +
 lib/percpu_counter_tree.c                     | 1450 +++++++++++++++++
 lib/tests/Makefile                            |    3 +
 lib/tests/percpu_counter_tree_bench.c         |  610 +++++++
 lib/tests/percpu_counter_tree_kunit.c         | 1063 ++++++++++++
 tools/testing/hpcc/.gitignore                 |    2 +
 tools/testing/hpcc/Makefile                   |   18 +
 tools/testing/hpcc/include/hpcc_shim.h        |  203 +++
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
 tools/testing/hpcc/main.c                     |  550 +++++++
 36 files changed, 4632 insertions(+), 12 deletions(-)
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
 create mode 100644 tools/testing/hpcc/main.c


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.47.3

