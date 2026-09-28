Received: from mail-dl2-f41.google.com (mail-dl2-f41.google.com [74.125.229.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EF2485CF7
	for <linux-trace-kernel@vger.kernel.org>; Mon, 28 Sep 2026 08:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790584897; cv=none; b=QJGM1BhizRzmpTmEvSSIJHoCv9He1jenrXERMx2yv15I2Y0B6tLV9cmhpovP4P95/lG4ld6N2UCug5xMhdovHOgDOr5pBMzwiCrnkuW+F+ZDQo4vYQDcrknpE821rQIaEzSJZDcY1ZFsRob7YhrC4KyIfa8aIjQotnbPGi3hDFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790584897; c=relaxed/simple;
	bh=ob8zfl2qTTQMgUGsXIAqphHzf5jGvjQPSu/HppepdjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YOOJ+gQwT0H0c0bHLKIcd8QNBkYnGjTtQufhUSJYPjGZtL+IRjEhFUcdUCVqlIhAgbRkKpOfX0j5hg/nb+4W+qWq5rFC0AlbhOLSva2dnS/cIdserlHKwMpG3JWBrOzSFqxog+9KEih6kK9DwKItJoHQlcow2LL6ENfKu4MX+YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jUxfthWc; arc=none smtp.client-ip=74.125.229.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jUxfthWc"
Received: by mail-dl2-f41.google.com with SMTP id a92af1059eb24-148c3a4733fso189334c88.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 28 Sep 2026 01:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790584894; x=1791189694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8OtAgysbv5smRsBCe0qSS4OMSMdlbSGAEUJ4rbmx5Ts=;
        b=jUxfthWcntrkppiqqQGw47njLPyfAIo0gKA7EckXR4OA1mCAlWPOeAhCeaSocNe4BG
         gJ/Asg8UZEEHPw5+GydqqN1PMj07jUBBsMrz8e+Tn1GYo5Cr2Xe6TZUPuOU4X4EpDWQy
         EjcuY2c+Ck3u85MdcMOvgAp+KOSvlTvOSiY3+RqJ+ef1XrXnEMhC7k7d/bs4pz73eGFM
         mxOKa5iMG/PdIiIUspAJS+pGYsQ6d1QFRqQmWyQ27Wf0PJG0eWw+4k52g4B7QS9mCVBO
         ScA6FmPZc8CU5PU/Wcubi0PPUXlv6mRzUGC0RhE+8Y8RdGjIGYb8tT9YCwQWoqiTiWOH
         aBmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790584894; x=1791189694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8OtAgysbv5smRsBCe0qSS4OMSMdlbSGAEUJ4rbmx5Ts=;
        b=RQdjogkmqxWDb9X7SMdGr92tiSNugQdlhe/NcUcM6xefEZzEeFt0bGROQo4Bh4VE8O
         4XGPiDBorlKxiFFZ8PxqCgbZGmk+KhgKy/5R9P4d2LBl3rTGba/ueEZhnFFvL8FHBSY4
         G82Ht0epkeXhSmRdUZU+UdIA/5QbLLtK2tQ2ZahkeFI2mM0iVlqwn1fKYVuLJDRv5LTF
         /ii0BUc3eA6M+m7jTbhZVHOuo5Dha4WkmaUrZuNX3jYmoQ5vr44kmle5nm/jdASPw1e2
         VjKiAZNRtGyB6XLaRv5G+ff5p+yCxVu/bcO78+qBUpLAtrtlNyizuRI1aX7xbtfqi0Ew
         yaNA==
X-Forwarded-Encrypted: i=1; AKwUvByhlBuRyGzd3xQ9Z+Iu54IFfwWlnhHvcxMMXzoz5Mc5kV2syiAeQk82Q0OdSQzUwm2VTqYf3nYs0LmEnStIG6wYH0c=@vger.kernel.org
X-Gm-Message-State: AFuF++l+tA+e2AFaNlX1blMl8fkjU+ciAKvgmWla93ZVTXfVHCHDKwYR
	NHTwOAYJw4HJbso+aBIxs5/ItGTqLEnObTNkPypvCdXrW7KgIyfSxyVD
X-Gm-Gg: AYBFou0ZpsRHYgYQDKS1YPdXjTTKdp6yQpnYWol2RivgUl7OOY36z0PbEqjqrotUZLG
	Sqq5/8KwjRt647Q7vmwB8wR0ZrI89ge7micdQ4f0wXeN03amDTlPmbx4PBucmAS14lLFeq0biqT
	YwP3PkaZDh2p/hl5ZEM3Tb6XfhteiYL5LZWSh0PqwbauOKYVfMTAz0d/HmvaOOF1QMWrbB9bcSa
	BKbIzDpQge03rP//4dKmLh6jZCAja/byI40bmf4Owl08vdXS3KiFQXBay2DPbyBI5/yvK6piTFD
	cM/dcCFYXnjnBeIgvcAtJHtmNGUepc9v/HZRU4oPl73TU/V0MfDEusxL6DvObmn/wsGQIMpAbDZ
	qCfr5HCZwdxhPmW892VHt24cp/5WIuINJCqUF+HGCmDUu+xiJBeAR7r+FUGQnYaKDx8bo+JAkLr
	wOskTNsWun2zeuU4N00hY8QVbNO0k4AIwkNyeWjuOJ0NwqrnQCFr1AwTGrSXHMLLpzXgkNHgzZz
	aHMJ9H7ozWPMM5K1WVSV2a/dga3HLmrofGKktFf9KKO+DYYZDWcUzHYwB3+avqF2DLCUjZ3kQ79
	tyX9GleMPOtglt4+MCPz+Vp06W2UK2gz3kWUYgy2n1FgfYAltVZ3ZKEGQxyblUlwZ5vX1tjb3Q=
	=
X-Received: by 2002:a05:7023:907:b0:144:fb71:dbd5 with SMTP id a92af1059eb24-146cf02c021mr10538118c88.21.1790584893326;
        Mon, 28 Sep 2026 01:41:33 -0700 (PDT)
Received: from FT6N242TWK ([223.181.116.210])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145ac67c505sm22947647c88.5.2026.09.28.01.41.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 28 Sep 2026 01:41:32 -0700 (PDT)
From: Shashank Mohan Jain <jain.sm@gmail.com>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Matt Wu <wuqiang.matt@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] objpool: keep objpool_push() correct when a push from NMI nests in it
Date: Mon, 28 Sep 2026 14:11:24 +0530
Message-ID: <20260928084125.67104-2-jain.sm@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260928084125.67104-1-jain.sm@gmail.com>
References: <20260928084125.67104-1-jain.sm@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

objpool_push() adds an object to the slot of the local CPU with
interrupts disabled. It reserves an entry with a cmpxchg() on
slot->tail, writes the entry, and publishes it with
smp_store_release(&slot->last, tail + 1).

A push from NMI context can still interrupt it and push to the same
slot. kretprobes may run in NMI context since commit e03b4a084ea6
("kprobes: Remove NMI context check"). At the time, kretprobe instances
came from a CAS-based lockless freelist, which tolerates that. Commit
4bbd93455659 ("kprobes: kretprobe scalability improvement") moved
kretprobes and rethook to objpool.

With rethook, rethook_trampoline_handler() recycles instances with
objpool_push() after the user handler has run, when no kprobe is marked
running anymore; rethook_flush_task() does the same. An NMI that arrives
during such a push and runs a function probed by the same kretprobe takes
an instance in pre_handler_kretprobe(), and when the function returns
inside the NMI, pushes it back to the same slot. This needs a kretprobe
on a function that runs both in NMI context and outside it, for instance
one that perf calls from the PMU NMI handler on x86. Before v6.14, fprobe
also used rethook and could push from NMI the same way, with one pool
shared by all functions of an fprobe.

kretprobes without rethook are not affected: kretprobe_trampoline_handler()
and kprobe_flush_task() run under kprobe_busy_begin(), so a kprobe hit in
NMI context is counted as missed.

If the NMI lands between the reservation and the publication of the
interrupted push, it reserves the next entry, writes it and moves
slot->last past the entry of the interrupted push, which is not written
yet:

  CPU0 (irqs off)          CPU0 NMI              CPU1
  ---------------          --------              ----
  reserve entry t
                           reserve entry t+1
                           write entry t+1
                           last = t+2
                                                 pop: t < last,
                                                 returns entries[t]
  write entry t
  last = t+1

This has three effects:

- A pop on another CPU can take entry t before it is written. It gets
  whatever the ring held at that position: NULL, or a stale pointer to
  an object that was popped earlier and may still be in use, so the same
  object is handed out twice. The object pushed at t can never be popped
  again, so it is lost to the pool.
- The interrupted push moves slot->last backwards. If both entries were
  popped in between, head is now ahead of last, and
  __objpool_try_get_slot() spins with interrupts disabled until the next
  push to that slot. Only the owning CPU pushes there, so a pop on that
  CPU never comes back.
- Even without a concurrent pop, the entry of the NMI stays invisible
  until the next push. The WARN_ON_ONCE() sanity check can also fire
  spuriously, because it compares a snapshot of tail taken before the
  NMI with head read after it.

During the review of objpool, nested pushes were assumed not to happen
because the push runs with interrupts disabled. kretprobes push from NMI
context, though.

Publish the entries in order instead:

- A push advances slot->last only while last points at its own entry,
  meaning all earlier entries are written. It then also publishes the
  entries of pushes that interrupted it, which have completed by the
  time it resumes.
- A push that interrupted another one leaves slot->last alone. The
  interrupted push publishes both entries when it resumes.
- This needs a cmpxchg(). Masami sketched a plain-store version of
  this catch-up loop during the objpool review [1]. With a plain store,
  a nested push can take over as soon as last reaches its entry and
  publish it, and the store of an older tail by the interrupted push
  then moves last backwards, below head if a remote pop took the
  entries meanwhile. A pop from NMI on this CPU would then spin
  forever, as the interrupted push cannot resume to repair last.
- Read head for the sanity check only once the entry is reserved.

Without nesting, the push now costs one cmpxchg() and one extra read of
tail instead of one store.

Found with a TLA+ model of the push and pop paths (sequentially
consistent memory, one level of nesting), with a task push that an NMI
push can interrupt at every step and pops on another CPU. TLC finds pops
of unwritten entries, objects handed out twice and last moving backwards
with the current code. With this change it finds no violation for up to
five objects, four task pushes, three nested pushes and five remote
pops. In the same model, the plain-store variant hands out no bad
objects but lets last fall behind head.

On 4-CPU UML, the KUnit test added in the next patch lets an hrtimer
push while a task push is in progress. Before this change, it leaves
6960 to 7053 entries unpublished in 5 seconds. With a popper on another
CPU, it hands out objects twice and loses them until all 30 objects of
the task are gone. After this change, none of these happen (3 runs
each).

Link: https://lore.kernel.org/all/20231012230237.45726dfad125cf0e8d00ba53@kernel.org/ [1]
Fixes: b4edb8d2d464 ("lib: objpool added: ring-array based lockless MPMC")
Cc: stable@vger.kernel.org
Assisted-by: LLM TLC
Signed-off-by: Shashank Mohan Jain <jain.sm@gmail.com>
---
Notes (not part of the changelog):

Tested (master 72d3fcf802c4, v7.3-rc5):
- KUnit on UML x86_64 with ncpus=4 (CONFIG_SMP=y, HIGH_RES_TIMERS),
  with patch 2/2 applied, 3 runs each:
  - Without this patch, both cases fail every run. Local case: 6960-7053
    unpublished entries (8230-8391 timer pushes nested in a task push).
    Remote-pop case: 142-187 unpublished entries, 30 double handouts and
    30 objects lost (all of the task's objects). The spurious
    WARN_ON_ONCE() at objpool.h:202 fires in every run.
  - With this patch, both cases pass every run: 0 unpublished, 0 double
    handouts, 0 lost, with 5013-5237 (local) and 32994-35223 (remote
    pop) real nestings, and no WARN.
- KUnit on UML with ncpus=1: the local case fails without this patch
  (7112 unpublished entries) and passes with it (4972 nestings); the
  remote-pop case is skipped. With CONFIG_SMP=n it passes with this
  patch (72123 nestings).
- W=1 build of lib/objpool.o, lib/test_objpool.o,
  lib/tests/objpool_kunit.o, kernel/kprobes.o and kernel/trace/rethook.o
  for x86_64_defconfig and i386_defconfig (plus KPROBES, KRETPROBES,
  KRETPROBE_ON_RETHOOK, KUNIT, OBJPOOL_KUNIT_TEST=m, TEST_OBJPOOL=m):
  no warnings.
- checkpatch.pl --strict: clean apart from the missing Signed-off-by.
- git apply --check of this patch against include/linux/objpool.h of
  v6.12, v6.18 and v7.2: applies. It was not built or tested there.

Not tested:
- Real NMIs. The failure was not reproduced through a kretprobe on real
  hardware; an hrtimer on UML stands in for the NMI. The reachability
  argument (rethook recycles with no kprobe marked running) comes from
  reading the code. The hard lockup of a pop on the owning CPU follows
  from the code and the TLA+ model; it was not reproduced.
- Weakly ordered architectures. The pop side still reads slot->last
  without acquire; that is pre-existing and not addressed here.
- Performance in the kernel. A userspace model of the fast path on an
  i7-11700F goes from ~14 to ~22 ns per push+pop pair (one more locked
  cmpxchg); not measured in the kernel. lib/test_objpool.c was not run.
- The Link: message id was taken from patchwork; the lore URL was not
  opened.

An alternative would be to mark a kprobe busy around the recycle loops
in rethook_trampoline_handler() and rethook_flush_task(), as the
non-rethook kretprobe path does. That would not cover fprobe before
v6.14 and would keep objpool unsafe for pushes from NMI, so this fixes
objpool itself.

This patch was prepared with Claude Code (Anthropic), model Claude Opus
5.5 (claude-opus-5-5): the code and the changelog were written with the
assistant. The TLA+ model checker TLC found the race.

 include/linux/objpool.h | 37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/include/linux/objpool.h b/include/linux/objpool.h
index b713a1fe7521..b86225e32ebe 100644
--- a/include/linux/objpool.h
+++ b/include/linux/objpool.h
@@ -193,19 +193,40 @@ __objpool_try_add_slot(void *obj, struct objpool_head *pool, int cpu)
 	struct objpool_slot *slot = pool->cpu_slots[cpu];
 	uint32_t head, tail;
 
-	/* loading tail and head as a local snapshot, tail first */
+	/*
+	 * Only the local CPU pushes to its slot, with irqs disabled, but a
+	 * push from NMI context (a kretprobe'd function returning in NMI)
+	 * can interrupt this one at any point.
+	 */
 	tail = READ_ONCE(slot->tail);
+	while (!try_cmpxchg_acquire(&slot->tail, &tail, tail + 1))
+		;
 
-	do {
-		head = READ_ONCE(slot->head);
-		/* fault caught: something must be wrong */
-		WARN_ON_ONCE(tail - head > pool->nr_objs);
-	} while (!try_cmpxchg_acquire(&slot->tail, &tail, tail + 1));
+	/*
+	 * fault caught: something must be wrong.  Read head only after the
+	 * reservation: a nested push and a pop on another CPU could have
+	 * moved head past an older snapshot of tail.
+	 */
+	head = READ_ONCE(slot->head);
+	WARN_ON_ONCE(tail - head > pool->nr_objs);
 
 	/* now the tail position is reserved for the given obj */
 	WRITE_ONCE(slot->entries[tail & slot->mask], obj);
-	/* update sequence to make this obj available for pop() */
-	smp_store_release(&slot->last, tail + 1);
+
+	/*
+	 * Update 'last' to make this obj available for pop(), in order:
+	 * 'last' must never move past an entry that is not written yet.
+	 * If this push interrupted another push to this slot, the entry of
+	 * the interrupted push comes first and is not written yet: leave
+	 * 'last' alone, the interrupted push publishes both when it resumes.
+	 * Pushes that interrupted this one have completed by now, so publish
+	 * their entries too.  A plain store is not enough: another nested
+	 * push can take over publishing as soon as 'last' reaches its entry.
+	 */
+	while (try_cmpxchg_release(&slot->last, &tail, tail + 1)) {
+		if (++tail == READ_ONCE(slot->tail))
+			break;
+	}
 
 	return 0;
 }
-- 
2.43.0

