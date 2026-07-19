Received: from sender-pp-o93.zoho.in (sender-pp-o93.zoho.in [103.117.158.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45517175A6D
	for <linux-trace-kernel@vger.kernel.org>; Sun, 19 Jul 2026 18:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=103.117.158.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784487388; cv=pass; b=u8ndH2A+4j0dHhhQ+xqifCAkYmhtgzByeaLEoT3XIWUbdh7MK/XWYT/yKdBwOsdWXwKmcdVl+hbqP2cNJJ7NXplhcXlI8ielhYU2Y2Oj2uuxVo0f+hQMPPC0GxVQGy14S5dedaggpTkU3TPr1GzF2G+vaUuOPgdLGzOpAIgKBz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784487388; c=relaxed/simple;
	bh=3/mkKGY1KKGShGekYRFi86SXXcR4hbBr5b3gtObgjXg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UgJOOdcmR9BF5qb1Is579WFF7xfPGDpP/4MeXqjfDNSj5lVj/mHz4yuLXmXeXx8nNUjt7PLyNhWQPALb7zenbYe6/aJbkboFZ5Qm+OK4bkeVumPo+zPWLoQZIqMcNOuk2RuxBOl0JKWftGqD04weyf7cF1mh0hqDKkfHjxv9Wi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in; spf=pass smtp.mailfrom=zohomail.in; dkim=pass (1024-bit key) header.d=zohomail.in header.i=adi.sharma@zohomail.in header.b=v7KWe0ya; arc=pass smtp.client-ip=103.117.158.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.in header.i=adi.sharma@zohomail.in header.b="v7KWe0ya"
ARC-Seal: i=1; a=rsa-sha256; t=1784487277; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=eADGpvPKqBmRx//mlXz6ZS+Q879VocnOr6FEgDl93ukHoLT7gGL16wBJNJ4HLq0xG7aMJrE0HcC8wS1719On4J4BmLOz0AtzeCtuglnmon8ABOIU+nEjdOBymadtZqynCjE3aSdlWJ4fIYq+2w7ps4ojYWukf4jJlz8PX5bPpq8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1784487277; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=0FeTMTDD8CXH5mUF9MMn1eL3ko/Vd1ugJfS/I5MuAt0=; 
	b=Uc65Vqr3aWu5PDhfPCrHHwKtTtXkmOVihyoLEpqj54XfEiNG1Ig6K1vlPN1gZ5dUdZvdpp1UbEG6bj6DZ1wvNxws7zpX17XT4qFMfovvsYSGUPcw18jYFSzrJBJB7QsKSzuxkP/+ZJmttJF7xLdJL7cWNBIBYd5+4Mrxrtt+ZhU=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=zohomail.in;
	spf=pass  smtp.mailfrom=adi.sharma@zohomail.in;
	dmarc=pass header.from=<adi.sharma@zohomail.in>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784487277;
	s=zoho; d=zohomail.in; i=adi.sharma@zohomail.in;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=0FeTMTDD8CXH5mUF9MMn1eL3ko/Vd1ugJfS/I5MuAt0=;
	b=v7KWe0ya+8wYxAWW6YSOR2hqgB87TyhJdxcKTV1OBvuNhn3h8zFgYNkpFOnzqpui
	3vwdYbIiyMSoBDa/OZakd8stxTABaiYvQq4Py/90D+pw29V7JoCOqu/wHK/eREILp+n
	h+hJ0oLR8ii6Ev6tbvf+P+RdO8uYG+dnuq1ysswQ=
Received: by mx.zoho.in with SMTPS id 1784487276470954.0360801039974;
	Mon, 20 Jul 2026 00:24:36 +0530 (IST)
From: Aditya Sharma <adi.sharma@zohomail.in>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>
Cc: David Rientjes <rientjes@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
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
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imbrenda@linux.ibm.com,
	Aditya Sharma <adi.sharma@zohomail.in>
Subject: [RFC PATCH 0/7] mm: defer address-space teardown of large exiting processes to a kthread
Date: Mon, 20 Jul 2026 00:24:02 +0530
Message-Id: <20260719185409.409685-1-adi.sharma@zohomail.in>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Address-space teardown on process exit runs synchronously in the dying
task's context: exit_mm() -> mmput() -> __mmput() -> exit_mmap() walks
page tables, updates rmap, frees the RSS and drops file references, all
on the exiting CPU. For a multi-GB process that is hundreds of
milliseconds of exit-path latency, paid by whoever is waiting on the
death: a supervisor's kill-and-respawn cycle, a shell's waitpid(), an
orchestrator reaping a fleet of workers. On the test box below, killing
a 16GB process costs ~280ms before the parent's waitpid() returns.

This series adds CONFIG_ASYNC_MM_TEARDOWN: an opt-in, default-off path
that defers __mmput() of large exiting processes to a dedicated kernel
thread (mm_reaper), so the exiting CPU is released as soon as the task
is reaped and the teardown runs off to the side.

Design
======

 - A single freezable kthread, mm_reaper, modeled on oom_reaper, fed
   through a lock-free llist + waitqueue. llist rather than oom_reaper's
   spinlock+list so many-core parallel exits do not serialize on a
   global lock at enqueue. The kthread runs at nice 19; its affinity is
   a preference (kthread_affine_preferred()) for the HK_TYPE_KTHREAD
   housekeeping mask, so it keeps off isolcpus= and cpuset-isolated
   CPUs without the hard bind of kthread_bind_mask() --
   PF_NO_SETAFFINITY would leave admins unable to re-affine it.

 - mmput_exit(), called only from exit_mm()'s final reference drop
   (patch 7). Every other mmput() caller (get_task_mm() users such as
   ptrace and /proc, kthread_unuse_mm(), ...) is unchanged and still
   tears down inline if it happens to hold the last reference.

 - Deferral only when ALL of the following hold, else inline __mmput():
     * vm.async_mm_teardown=1 (static key, default off)
     * RSS >= vm.async_mm_teardown_thresh_pages (default 64MB)
     * the mm is not an OOM-kill target (MMF_OOM_TARGETED, patch 3) and
       not already reaped (MMF_OOM_SKIP)
     * charging the RSS to a pending-pages budget stays under
       vm.async_mm_teardown_max_pending_pages (add-then-check: can
       over-reject under concurrency, never over-admit)

 - exit_aio() is pulled forward: mmput_exit() runs it eagerly on the
   exiting task before reserving/queuing. exit_aio() can block
   indefinitely waiting for in-flight AIO to drain; run eagerly, a
   stuck AIO context stalls only that task -- exactly what a
   synchronous mmput() would do -- instead of blocking the single
   reaper and stranding every teardown queued behind it. It is
   idempotent (a no-op once ioctx_table is gone), so __mmput() calling
   it again later is harmless.

 - OOM exclusion: an OOM victim's memory must come back promptly, not
   sit behind a nice-19 kthread working against the oom_reaper.
   MMF_OOM_TARGETED is mm-scoped (not per-task) because the final
   mm_users drop can come from a CLONE_VM sharer in another thread
   group that mark_oom_victim() never sees; it is set before any
   SIGKILL for the kill event is dispatched, and the marking and the
   eligibility check cannot overlap in time (see patch 3 for the
   ordering argument). That argument is belt-and-suspenders, not a
   correctness dependency: a missed flag would only defer the
   victim's teardown (a latency/priority-inversion regression), never
   corrupt anything, and the oom_reaper reaps the victim
   independently either way. An LKMM litmus test for the
   CLONE_VM-sharer case is available on request.

 - No extra mm refcounting: deferring __mmput() keeps the mm_count
   reference that mm_users > 0 stands for, exactly as mmput_async()
   does; the mm and its embedded llist node stay alive until the
   kthread runs.

 - Observability: three vmstat counters (queued / sync / rejected) and
   two tracepoints. queue carries pid/comm/rss/node of the exiting
   task; reap carries the charged RSS vs a fresh RSS read plus the
   reaper's node, so the gap measures how much reclaim ate out of the
   queue, and queue-vs-reap node mismatches expose NUMA-remote
   teardown.


The work is moved, not eliminated. Measured checks (same box
as below):

 - Freeing latency: with async on, a killed 16GB region is freed on
   the same timescale as inline teardown -- nr_free_pages recovers
   within ~300ms of the kill in both configurations (single-rep
   watcher readings of 240ms async vs 283ms inline, within run-to-run
   variance; not a claim that async frees faster). Deferral does not
   delay the return of memory; it makes the exit path stop waiting
   for it.

 - CPU conservation: 5 consecutive 4GB inline teardowns cost 372ms of
   exit-path CPU; mm_reaper spends 440ms of kthread CPU draining the
   same five, read from its schedstat over a fully drained window
   (ratio 1.18, nice-19 kthread, cache-cold on another CPU).

 - Pages queued for teardown are invisible to reclaim until the reaper
   frees them. The pending cap bounds that exposure coarsely; it is not
   a reclaim mechanism. Reclaim integration (unmap-first draining, a
   shrinker) is future work, and is also an answer to the cap
   sizing question below.

Scope of the claims: what this series claims today is the common-case
exit-latency win under a modest threshold and a conservative cap. It
deliberately does not claim the multi-GB-teardown-under-memory-pressure
regime: until the queue is visible to reclaim, that regime is exactly
where the cap must stay conservative, and the 16GB+ numbers below are
capability demonstrations, run with the cap deliberately raised on an
otherwise idle machine -- not a recommended production configuration.
Open question 1 is where this either gets fixed (reclaim integration)
or stays scoped.

Numbers
=======

Bare metal, 32 CPUs / 32GB RAM (31 GiB usable), single NUMA node,
performance governor, medians, THP off unless noted. reap = SIGKILL -> waitpid()
returns. For all async-on runs vm.async_mm_teardown_max_pending_pages
was raised to 3/4 of RAM so the measurements exercise the reaper, not
the backpressure fallback: with the RAM/4 default, a single 16GB mm on
this box (8GB cap) -- or the 64GB guest case -- exceeds the cap and
falls back to sync teardown by design. See open question 1.

  kill, async off -> on:
    1GB      18.01 ms   ->  0.14 ms
    4GB      73.71 ms   ->  0.14 ms
    16GB    282.16 ms   ->  0.15 ms
    16GB     27.68 ms   ->  0.13 ms    (THP on)
  voluntary exit (_exit() -> reap), 16GB:
            271.27 ms   ->  0.12 ms
  M simultaneous 0.5GB exits, tail until ALL reaped:
    M=8      40.64 ms   ->  0.15 ms
    M=16     79.99 ms   ->  0.17 ms
    M=32    157.42 ms   ->  0.32 ms
  below-threshold 30MB process, feature ON vs OFF:
              0.56 ms   ->  0.60 ms    (sync path, within noise)
  file-backed (tmpfs) 4GB mapping, kill:
             35.34 ms   ->  0.12 ms
  real workload -- redis-server with a 16GB populated dataset
  (DEBUG POPULATE, VmRSS ~16.2GB), kill:
            292.97 ms   ->  0.24 ms

The redis point (5 reps/pass, sync spread 288.5-309.2ms, async
0.12-0.32ms) lands within ~3% of the synthetic 16GB per-GB rate, so
the benchmark's memset region is a fair proxy for a real heap, and
the async side carries over unchanged.

CONFIG=n control: the same driver on a =n build of the same tree
(interface verified fully absent: no sysctls, no vmstat counters, no
kthread, no tracepoints) reproduces the =y async-off column within
noise -- 18.01 vs 18.01 ms at 1GB kill, 282.14 vs 282.16 ms at 16GB
kill -- so with the key off, the config costs nothing measurable.

Single-reaper drain throughput: 16.4GB backlog (32 x 0.5GB) returned in
650ms, ~25GB/s on this box. For scale, a 32-vCPU/88GB QEMU guest,
pinned to one NUMA node of its host (vCPUs and preallocated guest RAM
both bound node-local; guest numbers, same kernel/config): 16GB kill
426.15ms -> 0.13ms, a 64GB backlog (32 x 2GB) drained in ~2.1s
(~31GB/s), a 16GB shmem inode evicted in reaper context, and the
pm_test freezer cycle passed with the full 64GB backlog queued.

Robustness testing (driver script, all sections pass, dmesg clean)
==================================================================

 - Backpressure: with the cap forced to 1GB, 8 parallel 0.5GB exits
   produce queued += 4, sync fallbacks += 12; the cap is respected and
   fallback is graceful.
 - OOM killer firing while 8GB of teardowns are queued: 3/3 reps clean,
   backlog drains in ~650ms alongside the kill.
 - Targeted MMF_OOM_TARGETED probes, verified per-pid against the
   tracepoints (a positive control first proves a plain large exit of
   the same binary IS seen as queued): a ~512MB memcg OOM victim is
   never queued; a CLONE_VM pair sharing one mm, swept by the same
   kill, produces no queue event from either thread group. Two claims
   are documented as untestable from userspace rather than tested:
   task_will_free_mem() fast-path marking, and flag stickiness/fork
   non-inheritance (no userspace process can survive owning a targeted
   mm: oom_score_adj writes propagate across mm sharers, and the
   __oom_kill_process() sweep kills every sharer unconditionally).
 - unlink-while-mapped tmpfs file: the VMA's fput at teardown is the
   last reference, so the final iput -> shmem_evict_inode of a 4GB
   shmem inode runs in reaper context; tmpfs is empty 212ms after the
   reap. Note: a kthread's fput cannot use task_work, so the evict
   actually executes in the (bound) delayed_fput workqueue -- see open
   question 4.
 - Toggling: disabling mid-drain still drains the backlog (8.0GB in
   670ms) while new exits take the sync path; 50 rapid static-key
   flip cycles under concurrent exits, clean.
 - pm_test freezer cycle with a 16GB backlog queued: completes, and
   the async path works after thaw. Caveat in open question 6.

NOT tested: NUMA. I have no bare-metal access to a multi-node machine;
all bare-metal numbers above are single-node, and the QEMU guests
present a single node too. The driver has a ready-to-run NUMA section
(reaper pinned to node 0, victim on node 0 vs node 1, kthread_tail
compared, tracepoints capture queue-vs-reap node) that skips on
single-node systems. Numbers from a multi-node box would be very
welcome and directly feed open question 2.

Open questions, input wanted
============================

1. The default for vm.async_mm_teardown_max_pending_pages. It is
   currently totalram_pages()/4, an explicitly marked placeholder.
   A static fraction of RAM is arbitrary; but making it a dynamic
   function of available RAM is wrong in a different way: high
   occupancy is not load. A box full of page cache or running a
   legitimately large in-memory workload is not necessarily under
   pressure, and those are exactly the boxes that want async teardown.
   Under real pressure the cap is the wrong tool anyway, because the
   queued pages are invisible to reclaim regardless of the cap value;
   the correct fix there is reclaim integration (above).

   The default also cuts against the feature: RAM/4 rejects any
   single mm larger than a quarter of RAM from deferral entirely --
   the exact processes with the worst exit latency are the first ones
   sent back to the sync path. Every async number above needed the
   cap raised to 3/4 of RAM to be measurable at all.

   And the loose end of the range bites in practice: in a large
   guest with the cap at that same 3/4 of RAM, a stress run that
   started a new round of large exits before the previous round had
   drained ran the box into OOM kills. That is what the design
   predicts: queued mms are invisible to reclaim and unreachable by
   the OOM killer -- their tasks are already dead, so they appear in
   no task dump and the oom_reaper has no task to reap; only
   mm_reaper can free them. The kills do resolve the pressure (OOM
   victims are MMF_OOM_TARGETED, so their teardown is sync), but
   tasks die on a box that is not really out of memory -- the memory
   is in the queue. With the RAM/4 default the same pattern
   self-limits: reservation fails and exits fall back to sync
   teardown, which is its own backpressure.
   Note the motivating workload (kill-and-respawn) is exactly the
   pattern that re-faults immediately after reap, so transient demand
   approaches old+new RSS; the cap bounds the old half. So: is RAM/4
   acceptable as a coarse safety bound for now? Should the cap react
   to watermarks or PSI instead? Should out_of_memory() drain or
   expedite the pending queue before picking a victim, the way it
   already coordinates with the oom_reaper? That last one is
   attractive because every queued mm is already dead: draining is
   guaranteed-progress reclaim with no victim to choose. But an
   unbounded synchronous drain inside the allocation path is its own
   stall (seconds for a large backlog), so it would need a budget.
   Or stay dumb until the shrinker exists?

   The shape I have in mind for the real fix: a shrinker whose
   count_objects() reports the pending pages and whose scan path
   kicks the reaper and switches it to unmap-first draining, so
   memory returns ahead of the slow metadata teardown. Running full
   __mmput()s inside direct reclaim would trade one latency cliff for
   another, so the shrinker's job is to accelerate and prioritize the
   drain, not to execute it in the caller's context. If the consensus
   is that reclaim visibility must land before exit_mm() is routed
   (patch 7), I would make that the centerpiece of v2.

2. One reaper vs per-node reapers vs an unbound workqueue. One thread
   sustains ~25GB/s on this box and a 64GB backlog still drains in
   ~2.1s in the big guest, but all of that is node-local. The tracepoint
   node fields exist precisely to evaluate this once multi-node
   numbers exist.

3. CPU accounting. Teardown CPU moves from the exiting task (charged
   to its cgroup) to a root-cgroup kthread. That is the same class of
   escape as kswapd or the oom_reaper, but this extends it to routine
   process exit. Patch 5's admin docs state the escape explicitly so
   nobody enables this blind; the open question is whether that
   suffices for an opt-in feature or whether cgroup-aware charging of
   the reaper's CPU is a prerequisite.

4. The delayed_fput hop. Because mm_reaper is a kthread, the final
   fput() it drops cannot use task_work and is punted to the bound
   delayed_fput workqueue -- so a multi-GB shmem inode evict runs on a
   bound system_wq worker (the workqueue watchdog already complains:
   "delayed_fput hogged CPU for >13333us, consider switching to
   WQ_UNBOUND"). Should the reaper drain its own fput backlog inline,
   or is this an argument for making delayed_fput unbound generally?

5. memcg zombies. Deferring teardown also defers the final uncharge,
   so a dying memcg can be pinned a little longer by a queued mm
   (bounded by the pending cap and measured drain times, i.e.
   normally milliseconds). I believe this is acceptable.

6. Freezing. The drain loop calls try_to_freeze() after every entry,
   so a freeze request is honoured between mms mid-batch, and the
   pm_test freezer cycle passes with a 16GB backlog queued. What
   remains is that a single in-flight __mmput() cannot freeze
   mid-teardown, so one sufficiently large mm could still exceed the
   freeze timeout -- but that is equally true of the same exit_mmap()
   running synchronously in the exiting task today. Is per-mm
   granularity enough?

Related work
============
 - "Two alternatives for mm async teardown" (Claudio Imbrenda, 2021,
   https://lore.kernel.org/all/20211111095008.264412-1-imbrenda@linux.ibm.com/
   ): an earlier RFC with the same
   goal, motivated by huge s390 KVM guest address spaces. It offered
   either an arch hook in exit_mm() or a process_mmput_async syscall
   that runs the teardown in another process's context, plus an OOM
   notifier to shield the teardown from the OOM killer. Neither
   variant was merged; the s390 protected-guest case was later
   addressed with KVM-specific asynchronous destruction. This series
   is arch-independent, needs no syscall or userspace agent (kernel
   kthread plus an eligibility gate), and integrates with the OOM
   killer by exclusion (MMF_OOM_TARGETED keeps victims synchronous)
   rather than by blocking it.
 - oom_reaper: same kthread pattern, but it strips memory from a
   victim that cannot exit; this series is about not making healthy
   exits pay the teardown latency.
 - process_mrelease(2): userspace-driven reaping of a killed process.
   It needs a daemon to issue it per-kill, only helps the kill case
   (not voluntary exit), and does not remove the exit-path work from
   the dying task -- it races it. This series needs no userspace
   agent and covers both exit flavors.
 - mmput_async(): existing deferral of __mmput() to a workqueue for
   contexts that cannot sleep; this series reuses its lifetime
   argument but adds gating, backpressure, OOM exclusion and a
   dedicated low-priority thread, none of which mmput_async() has.

Patches
=======

 1  mm: add CONFIG_ASYNC_MM_TEARDOWN scaffolding for off-CPU exit
    teardown -- config, mm_struct::async_reap_node, mmput_exit()
    fallback; no functional change.
 2  mm: dispatch __mmput() to an mm_reaper kthread via llist -- the
    kthread and queue; built but unreferenced.
 3  mm/oom_kill: mark an OOM victim's mm with MMF_OOM_TARGETED -- the
    mm-scoped victim flag and its visibility/ordering argument;
    nothing reads it yet.
 4  mm: gate async teardown on RSS with pending-pages backpressure --
    eligibility predicate + budget reservation; charge memoized at
    enqueue because RSS keeps shrinking after mm_users hits zero;
    exit_aio() pulled forward onto the exiting task.
 5  mm: add runtime toggle and sysctls for async teardown -- static
    key, three vm.* sysctls, admin-guide docs.
 6  mm: add tracepoints and vmstat counters for async teardown.
 7  exit: route exit_mm()'s final mmput() through mmput_exit() -- the
    switch that makes 1-6 operative.

Patches 1-6 are individually inert (each is either scaffolding or
dead code until patch 7), so the series bisects cleanly with the
feature dark until the last commit, and the runtime default is off
even then.

The benchmark (exit_latency.c) and the driver that produced every
number above (sanity/headline/wait-free/CPU-conservation/reuse/
parallel/backpressure/numa/smallproc/oom/oom-targeted/file-backed/
toggle/freezer sections, ~2k lines total), plus the standalone redis
driver behind the real-workload number, are available on request; if
there is interest I am happy to rework them into
tools/testing/selftests/mm for a later revision.

Based on mm-unstable, commit 890f8c4e827c
("mm/secretmem: don't allow highmem folios").

Aditya Sharma (7):
  mm: add CONFIG_ASYNC_MM_TEARDOWN scaffolding for off-CPU exit teardown
  mm: dispatch __mmput() to an mm_reaper kthread via llist
  mm/oom_kill: mark an OOM victim's mm with MMF_OOM_TARGETED
  mm: gate async teardown on RSS with pending-pages backpressure
  mm: add runtime toggle and sysctls for async teardown
  mm: add tracepoints and vmstat counters for async teardown
  exit: route exit_mm()'s final mmput() through mmput_exit()

 Documentation/admin-guide/sysctl/vm.rst |  38 +++++
 include/linux/mm_types.h                |  15 ++
 include/linux/sched/mm.h                |   6 +
 include/linux/vm_event_item.h           |   5 +
 include/trace/events/mm_reaper.h        |  73 +++++++++
 kernel/exit.c                           |   2 +-
 kernel/fork.c                           | 199 ++++++++++++++++++++++++
 mm/Kconfig                              |  12 ++
 mm/oom_kill.c                           |  61 ++++++++
 mm/vmstat.c                             |   5 +
 10 files changed, 415 insertions(+), 1 deletion(-)
 create mode 100644 include/trace/events/mm_reaper.h


base-commit: 890f8c4e827c918dac668a12eaf63180ba8a9e6d
-- 
2.34.1

