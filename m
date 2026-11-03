Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793746153;
	b=f27D0jlTSkuGRkGGRkVlwqJwsR2Zf93ZJCJSSYLEc19gaxBFZ0vNWAvrlpdK46mlzA1c
	 jFA4JMKJpl28Khb7MFOL2/sFSybqDrdnBxXnIuMTG1XphI35yxX/ETU3I6miuNmZlPcRX
	 9g9SZ87IRSz3fbItIUiPJW6vOeTEcdtEeJK/X25Nzn40MA1axYLhO9QYE8DKjwwDEiRZp
	 64Bw5Ot6WZ2K5QoGp1ylL+2mYYE70PA+5ugHA0mTxiVNtcmgL4VRqQM3HAkIvtcyo1A7e
	 JeOXVX4z62/fr+H6sucY6ZIkmehC13bVe6PvKhf6HurqsuCsPoqOBh7Mew9DOrXnGBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793746153;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id:X-Stat-Signature:
	 X-Spam-Status:X-Rspamd-Server:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=7Bv4uIPH4jycZavdA81c44cec7fLZfXG94061QEMmk8=;
	b=l9MiBs9pYBnQCQ/pASaD8a6y+iSRfpgRPO5cvWgBAGMe+j/pwdD3qATmnjGsHSV8cowX
	 XEEl2m+iFq7InxOPAThrjJa3Pj3oxPwGG+R7Ba5kRsg5ZQVKSyQ5tGKrCafxBBqOY77rQ
	 TB5SRY0jF9cB0CVnuauMxzDiezeIXiD6VwNMo+V9+sizlQRY35k/kVJW6WBmOBHp7XInZ
	 rQbjV+k5QF3gv3QlGBrkVrzTjxATtAWpymZzfjXntwcN84/agUqRsH284IyECtPH/2SX6
	 INTwilekU4Of+UONgGYdTKQJ3SpZJdnNyQOaqfbNZ+fkfFlgXUfSccrS9/x5SIzaReQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=F+g0H8b5;
	arc=none smtp.remote-ip=216.40.44.14
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D8B606A31B;
	Tue,  3 Nov 2026 22:49:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60D8B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=F+g0H8b5
Received: from omf09.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 43785140517;
	Tue,  3 Nov 2026 22:49:09 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id 898E820028;
	Tue,  3 Nov 2026 22:49:06 +0000 (UTC)
Date: Tue, 3 Nov 2026 17:49:05 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Li Pengfei <ljdlns1987@gmail.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 mark.rutland@arm.com, corbet@lwn.net, skhan@linuxfoundation.org,
 lkp@intel.com, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, zhangbo56@xiaomi.com,
 lipengfei28@xiaomi.com
Subject: Re: [RFC PATCH v7 01/10] trace: add lock-free stackmap for stack
 trace deduplication
Message-ID: <20261103174905.701e078a@gandalf.local.home>
In-Reply-To: <20260912083753.3426176-2-lipengfei28@xiaomi.com>
References: <20260912083753.3426176-1-lipengfei28@xiaomi.com>
	<20260912083753.3426176-2-lipengfei28@xiaomi.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 898E820028
X-Stat-Signature: a84icrzy68b39ydirj6xgofcnuo19nn8
X-Rspamd-Server: rspamout08
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19WfArU04gXBD54ymb/WuRIfWQkwp66jso=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=7Bv4uIPH4jycZavdA81c44cec7fLZfXG94061QEMmk8=; b=F+g0H8b5gI7dP4vU2DinFzTrdZY8g3cack8qzwUk9wbaRfXcDy9hrDIDj5sVrbhFJgl3Y1cUflpG8QushTjxEPj1ydJeFq81aCYZxGnGK2TVoatCAW95SfYxCG896jpdcuD+m3Ow7Sg9QGmaopHy4rnMvNZatL2TJVaYGmqz8x8=
X-HE-Tag: 1793746146-745656
X-HE-Meta: U2FsdGVkX1+ZbPZyWLenvL/Okl7ggpDuS1DkCPXc8oKpR9oBtY+KokIwomwwoSBlmrUjaE9sXtkv8f7oFc9+9/UN1Z6cN2MUe0zF4TGe/XjX+Z7hxyyyeayxO2BI+wtvtiTb5LpXXkmTjwaS5f0pW9PfIZX7Vy9IqzlZxJIDdcTZKA988MGwujC5VAqct1/ZAlT3DWH9KKLJS8o3oJeOm14hoE4HJRatGI2KfLhCv34XVLFWV7jkTmp9f5jdA0tr1K7S0XxrDKA8ucCaZVMvmZhSimy60ILdRRhsxKd1Jx14OcYdV7ATauRGR/BgszFasjvXD/vjJwrvIUy1lZmQFA1eIDl1YH0NJalV57eDcXcTYEutHX0MjA==

On Sat, 12 Sep 2026 16:37:44 +0800
Li Pengfei <ljdlns1987@gmail.com> wrote:

=3D> diff --git a/kernel/trace/trace_stackmap.c b/kernel/trace/trace_stackm=
ap.c
> new file mode 100644
> index 000000000000..b2e2115a15f9
> --- /dev/null
> +++ b/kernel/trace/trace_stackmap.c
> @@ -0,0 +1,718 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Ftrace Stack Map - Lock-free stack trace deduplication for ftrace
> + *
> + * Modeled after tracing_map.c (used by hist triggers), this provides
> + * a lock-free hash map optimized for the ftrace hot path. The design
> + * is based on Dr. Cliff Click's non-blocking hash table algorithm.
> + *
> + * Key properties:
> + * - Lock-free insert via cmpxchg, safe in NMI/IRQ/any context
> + * - Pre-allocated element pool (zero allocation on hot path)
> + * - Linear probing with 2x over-provisioned table; probe length
> + *   bounded by FTRACE_STACKMAP_MAX_PROBE to keep worst-case lookup
> + *   cost constant even when the table is heavily loaded
> + * - Single global instance (initialized for the global trace array)
> + *
> + * Reset is a control-path operation that clears the map only. It
> + * does not touch the ring buffer and does not require tracing to be
> + * stopped. The protocol is:
> + *
> + *   - Every admitted get_id() operation enters an explicit notrace
> + *     RCU-sched read-side section before checking resetting. A caller
> + *     that observes resetting=3D1 returns -EINVAL.
> + *   - synchronize_rcu_tasks_rude() drains callers running where RCU is

Let's get rid of using rcu_tasks_rude. If RCU isn't watching, then we
simply discard the stack trace. We do not want to add any more code that
relies on it. If an architecture wants this feature, then it needs to
update to not allow tracing without RCU watching.


> + *     not watching on architectures that permit tracing there. A normal
> + *     RCU grace period then drains the explicit read-side sections in
> + *     the RCU-watching tracing path, including interrupt and NMI handle=
rs.
> + *
> + * A trace collected before a reset can therefore still contain
> + * TRACE_STACK_ID records whose id no longer resolves, or resolves to
> + * a slot that has since been reused. That is misleading userspace
> + * output, not corruption; see ftrace_stackmap_reset().
> + *
> + * The 32-bit jhash of the stack IPs is the hash table key. On hash
> + * collision, linear probing finds the next slot and full memcmp
> + * confirms the match.
> + *
> + * Concurrent userspace readers (cat stack_map) get a best-effort
> + * snapshot. They are coherent with the hot path (smp_load_acquire on
> + * entry->val); they are also serialized against reset via
> + * smap->reader_sem (readers take it in shared mode, reset in
> + * exclusive mode), so a reset cannot tear a single seq_file pass --
> + * it waits for the active read() pass to drop the rwsem before clearing
> + * the map. The hot path is coordinated with reset separately, via
> + * acquire/release on smap->resetting.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/jhash.h>
> +#include <linux/seq_file.h>
> +#include <linux/kallsyms.h>
> +#include <linux/vmalloc.h>
> +#include <linux/atomic.h>
> +#include <linux/percpu.h>
> +#include <linux/random.h>
> +#include <linux/rcupdate.h>
> +#include <linux/log2.h>
> +#include <asm/local.h>
> +
> +#include "trace.h"
> +#include "trace_stackmap.h"
> +
> +/*
> + * Bound the linear-probe scan length. With a 2x over-provisioned table,
> + * a well-distributed hash gives very short probe chains. Capping at 64
> + * keeps worst-case lookup O(1) even when the table is heavily loaded
> + * with claimed-but-empty slots from pool exhaustion.
> + */
> +#define FTRACE_STACKMAP_MAX_PROBE	64
> +
> +/*
> + * Memory ordering of entry->val: published with smp_store_release()
> + * by the inserter; consumed with smp_load_acquire() by every reader
> + * that dereferences the elt (get_id, seq_show). This pairs
> + * the writes to elt->{nr,ips,ref_count} (initialized BEFORE the
> + * publish) with the reads of those fields (which happen AFTER the
> + * load). seq_start / seq_next only test val for NULL and use the
> + * acquire load purely to keep memory ordering symmetric.
> + */
> +
> +/*
> + * Each pre-allocated element holds one stack trace record.
> + * Fixed size: MAX_DEPTH entries regardless of actual depth.
> + */
> +struct stackmap_elt {
> +	u32		nr;		/* actual number of IPs */
> +	atomic_t	ref_count;
> +	unsigned long	ips[FTRACE_STACKMAP_MAX_DEPTH];
> +};
> +
> +/*
> + * Hash table entry: a 32-bit key (jhash of stack) + pointer to elt.
> + * key =3D=3D 0 means the slot is free.
> + */
> +struct stackmap_entry {
> +	u32			key;	/* 0 =3D free, non-zero =3D jhash */
> +	struct stackmap_elt	*val;	/* NULL until fully published */
> +};
> +
> +static struct stackmap_elt *stackmap_load_elt(struct stackmap_entry *ent=
ry)
> +{
> +	/*
> +	 * Pairs with the smp_store_release() that publishes entry->val
> +	 * after fully initializing the element payload.
> +	 */
> +	return smp_load_acquire(&entry->val);
> +}
> +
> +struct ftrace_stackmap {
> +	struct trace_array	*tr;		/* owning trace_array */
> +	unsigned int		map_bits;
> +	unsigned int		map_size;	/* 1 << (map_bits + 1) */
> +	unsigned int		max_elts;	/* 1 << map_bits */
> +	u32			hash_seed;	/* per-instance jhash seed */
> +	atomic_t		next_elt;	/* index into elts pool */
> +	struct stackmap_entry	*entries;	/* hash table */
> +	struct stackmap_elt	*elts;		/* flat element pool */
> +	atomic_t		resetting;
> +	/*
> +	 * Reader/reset serialization. Held in shared mode (read lock)
> +	 * across seq_file iteration; held in exclusive mode (write
> +	 * lock) by reset's clearing phase. The hot path (get_id) does
> +	 * not take this lock =E2=80=94 it
> +	 * uses smp_load_acquire/smp_store_release on entry->val and
> +	 * the resetting flag for the lock-free protocol.
> +	 */
> +	struct rw_semaphore	reader_sem;

There's no reason to use a rw semaphore here. Just use a mutex. It's
serializing the reads of the stackmaps from user space right? There's no
reason to have more than one reader at a time.

> +	/*
> +	 * Per-CPU atomic-long counters keep cross-CPU contention out of the
> +	 * NMI-capable hot path. atomic_long_add_unless() uses the native long
> +	 * width, so 32-bit kernels do not enter the generic atomic64_t
> +	 * hashed-spinlock implementation. ARCH_HAVE_NMI_SAFE_CMPXCHG makes
> +	 * the saturating update safe against same-CPU NMI interruption.
> +	 */
> +	atomic_long_t __percpu	*successes;	/* hits + new inserts */
> +	atomic_long_t __percpu	*drops;
> +};
> +
> +/*
> + * Map capacity: 2^FTRACE_STACKMAP_BITS stack records, with the hash
> + * table over-provisioned 2x on top of that. This gives 16K elements
> + * and a ~8 MB element pool, sized for the repetitive-stack workloads
> + * the map targets.
> + */
> +#define FTRACE_STACKMAP_BITS		14
> +
> +/* --- Element pool --- */
> +
> +static struct stackmap_elt *stackmap_get_elt(struct ftrace_stackmap *sma=
p)
> +{
> +	int idx;
> +
> +	/*
> +	 * Fast-path early-out once the pool is fully consumed. Avoids
> +	 * the contended atomic RMW on next_elt for every traced event
> +	 * after the pool is exhausted.
> +	 */
> +	if (atomic_read(&smap->next_elt) >=3D smap->max_elts)
> +		return NULL;
> +
> +	idx =3D atomic_fetch_add_unless(&smap->next_elt, 1, smap->max_elts);
> +	if (idx < smap->max_elts)
> +		return &smap->elts[idx];
> +	return NULL;
> +}
> +
> +/* --- Create / Destroy / Reset --- */
> +
> +struct ftrace_stackmap *ftrace_stackmap_create(struct trace_array *tr)
> +{
> +	struct ftrace_stackmap *smap;
> +	unsigned int bits =3D FTRACE_STACKMAP_BITS;
> +
> +	smap =3D kzalloc_obj(*smap, GFP_KERNEL);
> +	if (!smap)
> +		return ERR_PTR(-ENOMEM);
> +
> +	smap->tr =3D tr;
> +	smap->map_bits =3D bits;
> +	smap->max_elts =3D 1U << bits;
> +	smap->map_size =3D 1U << (bits + 1);	/* 2x over-provision */
> +
> +	smap->entries =3D vcalloc(smap->map_size, sizeof(*smap->entries));
> +	if (!smap->entries)
> +		goto fail;
> +
> +	/*
> +	 * Single large vmalloc of the element pool, indexed flat.
> +	 * At bits=3D18 this is 256K * sizeof(struct stackmap_elt). The
> +	 * struct is ~520 B (8 + 4 + 4 + 64*8), so total ~135 MB.
> +	 */
> +	smap->elts =3D vcalloc(smap->max_elts, sizeof(*smap->elts));
> +	if (!smap->elts)
> +		goto fail;
> +
> +	smap->successes =3D alloc_percpu(atomic_long_t);
> +	if (!smap->successes)
> +		goto fail;
> +	smap->drops =3D alloc_percpu(atomic_long_t);
> +	if (!smap->drops)
> +		goto fail;
> +
> +	smap->hash_seed =3D get_random_u32();
> +	atomic_set(&smap->next_elt, 0);
> +	atomic_set(&smap->resetting, 0);
> +	init_rwsem(&smap->reader_sem);
> +
> +	return smap;
> +
> +fail:
> +	/*
> +	 * free_percpu()/vfree()/kfree() all handle NULL, and smap was
> +	 * zero-initialized, so unwind in reverse allocation order.
> +	 */
> +	free_percpu(smap->drops);
> +	free_percpu(smap->successes);
> +	vfree(smap->elts);
> +	vfree(smap->entries);
> +	kfree(smap);
> +	return ERR_PTR(-ENOMEM);
> +}
> +
> +void ftrace_stackmap_destroy(struct ftrace_stackmap *smap)
> +{
> +	if (!smap || IS_ERR(smap))
> +		return;
> +	free_percpu(smap->drops);
> +	free_percpu(smap->successes);
> +	vfree(smap->elts);
> +	vfree(smap->entries);
> +	kfree(smap);

Instead of duplicating the open coded free in ftrace_stackmap_create(),
move this ftrace_stackmap_destroy() above that function and call it on fail.

fail:
	ftrace_stackmap_destroy(smap);
	return ERR_PTR(-ENOMEM);


> +}
> +
> +/**
> + * ftrace_stackmap_reset - clear all entries in the stackmap
> + * @smap: the stackmap to reset
> + *
> + * Returns 0 on success, or -EBUSY if another reset is already in
> + * progress.
> + *
> + * Clears the map only. The ring buffer is left alone and tracing does
> + * not need to be stopped, so a trace can still contain TRACE_STACK_ID
> + * records after the map has been cleared. Such an id either has no
> + * entry in stack_map, or -- once tracing continues and the slot is
> + * reused -- resolves to an unrelated stack. Both are misleading
> + * userspace output rather than corruption: reset frees nothing, it
> + * only memsets storage the map still owns.

The above paragraph is unnecessary here. If you want to add it to kernel
docs where it is user visible, then fine. (I haven't looked yet if you
already did).

> + *
> + * Caller is process context (the tracefs write handler).
> + *
> + * Protocol:
> + *   1. Atomically claim reset rights via cmpxchg on @resetting, which
> + *      makes subsequent get_id() callers leave their read-side section
> + *      without touching map storage.
> + *   2. synchronize_rcu_tasks_rude() drains callers running where RCU is
> + *      not watching on architectures that allow tracing there. Then
> + *      synchronize_rcu() drains the explicit notrace RCU-sched sections
> + *      in the RCU-watching tracing path, including interrupt and NMI
> + *      handlers.
> + *   3. Take @reader_sem exclusively to exclude tracefs readers, then
> + *      memset entries, elts, and counters.
> + *   4. Release the resetting flag with release semantics so any new
> + *      get_id() observes a fully cleared map.
> + *
> + * Why no get_id() can run concurrently with the memsets, given that its
> + * admission test is a plain flag read rather than a lock. Consider any
> + * get_id() RCU-sched read-side section, and note that the flag store in
> + * step 1 precedes the grace period in step 2:
> + *
> + *   - The section ends before synchronize_rcu() returns. The memsets run
> + *     after it returns, so the two cannot overlap, whichever value of
> + *     resetting that section happened to observe.
> + *   - The section ends after synchronize_rcu() returns. RCU then
> + *     guarantees a full memory barrier between the start of the grace
> + *     period and the start of that section, so the section observes
> + *     resetting =3D=3D 1 and returns -EINVAL without touching map stora=
ge.
> + *
> + * A section that reads a stale zero and still runs during the memsets
> + * would have to satisfy both cases at once, so it cannot exist. See
> + * "Memory-Barrier Guarantees" in
> + * Documentation/RCU/Design/Requirements/Requirements.rst.
> + */
> +static int ftrace_stackmap_reset(struct ftrace_stackmap *smap)
> +{
> +	int cpu;
> +
> +	if (!smap)
> +		return 0;
> +
> +	if (atomic_cmpxchg(&smap->resetting, 0, 1) !=3D 0)
> +		return -EBUSY;
> +
> +	/*
> +	 * Each get_id() operation enters an explicit notrace RCU-sched
> +	 * read-side section before checking resetting. On RCU-watching CPUs,
> +	 * the normal grace period waits for those sections, including callers
> +	 * from interrupt and NMI context. On architectures that permit tracing
> +	 * while RCU is not watching, the rude grace period covers the remaining
> +	 * context; it is intentionally a no-op on ARCH_WANTS_NO_INSTR
> +	 * architectures.
> +	 */
> +	synchronize_rcu_tasks_rude();

Let's make this work with just synchronize_rcu().

> +	synchronize_rcu();
> +
> +	/*
> +	 * Take the reader_sem in exclusive mode. This serializes the
> +	 * memset against any tracefs reader (seq_file iteration) that
> +	 * may currently hold the rwsem for read. The Tasks RCU grace
> +	 * periods already drained the hot path; this rwsem covers
> +	 * process-context export readers.
> +	 */
> +	down_write(&smap->reader_sem);
> +
> +	memset(smap->entries, 0, sizeof(*smap->entries) * smap->map_size);
> +	memset(smap->elts, 0, sizeof(*smap->elts) * (size_t)smap->max_elts);
> +
> +	atomic_set(&smap->next_elt, 0);
> +	for_each_possible_cpu(cpu) {
> +		atomic_long_set(per_cpu_ptr(smap->successes, cpu), 0);
> +		atomic_long_set(per_cpu_ptr(smap->drops, cpu), 0);
> +	}
> +
> +	up_write(&smap->reader_sem);

Again, the rw semaphore is overkill. A mutex is all that is needed.

Thanks,

-- Steve

> +
> +	/* Release resetting=3D0 so new get_id() observes a cleared map. */
> +	atomic_set_release(&smap->resetting, 0);
> +	return 0;
> +}
> +
> +/* --- Core: get_id (lock-free, NMI-safe) --- */
> +
> +int ftrace_stackmap_get_id(struct ftrace_stackmap *smap,
> +			   unsigned long *ips, unsigned int nr_entries)
> +{
> +	u32 key_hash, idx, test_key, trace_len;
> +	struct stackmap_entry *entry;
> +	struct stackmap_elt *val;
> +	int probes =3D 0;
> +	int ret;
> +
> +	if (!smap || !nr_entries)
> +		return -EINVAL;
> +	/*
> +	 * Never truncate: a stack deeper than the map can hold must not be
> +	 * silently shortened, or two distinct traces sharing their first
> +	 * FTRACE_STACKMAP_MAX_DEPTH frames would be merged into one
> +	 * stack_id. The caller is expected to fall back to a full stack
> +	 * trace for such events. Reject defensively in case of a future
> +	 * caller that forgets this contract.
> +	 */
> +	if (nr_entries > FTRACE_STACKMAP_MAX_DEPTH)
> +		return -E2BIG;
> +
> +	/*
> +	 * Enter the read-side section before checking resetting. If reset
> +	 * has already claimed the map, reject the operation. Otherwise the
> +	 * reset grace periods wait until this operation leaves the section
> +	 * before clearing storage. The notrace variant is required because
> +	 * this is part of the tracing hot path.
> +	 */
> +	rcu_read_lock_sched_notrace();
> +	/*
> +	 * atomic_read_acquire() pairs with atomic_set_release() in the
> +	 * reset path. This ensures that subsequent reads of entry->key
> +	 * and entry->val are ordered after this check; without acquire,
> +	 * the CPU would only have a control dependency, which orders
> +	 * subsequent stores but not loads (per LKMM).
> +	 */
> +	if (atomic_read_acquire(&smap->resetting)) {
> +		ret =3D -EINVAL;
> +		goto out;
> +	}
> +
> +	trace_len =3D nr_entries * sizeof(unsigned long);
> +	/*
> +	 * jhash2() requires the length in u32 units and the data to be
> +	 * u32-aligned. On 64-bit kernels sizeof(unsigned long)=3D=3D8, so
> +	 * trace_len is always a multiple of 8 (hence of 4). Use jhash2
> +	 * directly; the cast to u32* is safe because ips[] is naturally
> +	 * aligned to sizeof(unsigned long) >=3D 4.
> +	 */
> +	key_hash =3D jhash2((const u32 *)ips, trace_len / sizeof(u32),
> +			  smap->hash_seed);
> +	if (key_hash =3D=3D 0)
> +		key_hash =3D 1;	/* 0 means free slot */
> +
> +	idx =3D key_hash >> (32 - (smap->map_bits + 1));
> +
> +	while (probes < FTRACE_STACKMAP_MAX_PROBE) {
> +		idx &=3D (smap->map_size - 1);
> +		entry =3D &smap->entries[idx];
> +		/*
> +		 * READ_ONCE() to avoid LKMM data race with concurrent
> +		 * cmpxchg(&entry->key, 0, key_hash) on this slot.
> +		 */
> +		test_key =3D READ_ONCE(entry->key);
> +
> +		if (test_key =3D=3D key_hash) {
> +			val =3D stackmap_load_elt(entry);
> +			/*
> +			 * READ_ONCE(val->nr) keeps style consistent with
> +			 * the seq_show reader. nr is write-once
> +			 * (set before publish, never modified afterwards),
> +			 * so the load is data-race-free, but READ_ONCE
> +			 * silences any analysis tool that flags a plain
> +			 * read of a field that is also read under acquire
> +			 * elsewhere.
> +			 */
> +			if (val && READ_ONCE(val->nr) =3D=3D nr_entries &&
> +			    memcmp(val->ips, ips, trace_len) =3D=3D 0) {
> +				/*
> +				 * ref_count is a best-effort popularity
> +				 * counter. On a long (from-boot, multi-hour)
> +				 * trace a hot stack can be hit billions of
> +				 * times. atomic_add_unless() gives true
> +				 * saturation at INT_MAX even under concurrent
> +				 * hits on multiple CPUs (a plain
> +				 * check-then-inc could let several CPUs past
> +				 * the check near the cap and still wrap).
> +				 */
> +				atomic_add_unless(&val->ref_count, 1, INT_MAX);
> +				/*
> +				 * successes/drops are saturating throughput
> +				 * counters. Keep them per-CPU to avoid
> +				 * cross-CPU cacheline contention.
> +				 */
> +				atomic_long_add_unless(
> +					this_cpu_ptr(smap->successes), 1, LONG_MAX);
> +				ret =3D (int)idx;
> +				goto out;
> +			}
> +			/*
> +			 * val =3D=3D NULL: another CPU is mid-insert, or this
> +			 * slot is "claimed but empty" (pool exhausted).
> +			 * val !=3D NULL but mismatch: 32-bit hash collision
> +			 * with a different stack. In both cases, advance.
> +			 */
> +		} else if (!test_key) {
> +			/*
> +			 * Free slot: try to claim it.
> +			 *
> +			 * If two CPUs race here with the same key_hash
> +			 * (same stack), one loses the cmpxchg, advances,
> +			 * and may insert the same stack at a later slot.
> +			 * This can produce a small number of duplicate
> +			 * entries under heavy contention. The trade-off
> +			 * is accepted to keep the hot path lock-free;
> +			 * ref_count is split across the duplicates and
> +			 * total memory cost is bounded by the element
> +			 * pool size.
> +			 */
> +			if (cmpxchg(&entry->key, 0, key_hash) =3D=3D 0) {
> +				struct stackmap_elt *elt;
> +
> +				elt =3D stackmap_get_elt(smap);
> +				if (!elt) {
> +					/*
> +					 * Pool exhausted. Keep the claimed
> +					 * slot as a gravestone. Readers skip
> +					 * a NULL val, and the explicit probe
> +					 * bound prevents accumulated
> +					 * gravestones from turning a miss
> +					 * into an unbounded table walk.
> +					 */
> +					atomic_long_add_unless(
> +						this_cpu_ptr(smap->drops), 1,
> +						LONG_MAX);
> +					ret =3D -ENOSPC;
> +					goto out;
> +				}
> +
> +				elt->nr =3D nr_entries;
> +				atomic_set(&elt->ref_count, 1);
> +				memcpy(elt->ips, ips, trace_len);
> +
> +				/*
> +				 * Publish elt with release semantics so the
> +				 * reader's smp_load_acquire can safely
> +				 * dereference val->nr / val->ips.
> +				 */
> +				smp_store_release(&entry->val, elt);
> +				atomic_long_add_unless(
> +					this_cpu_ptr(smap->successes), 1, LONG_MAX);
> +				ret =3D (int)idx;
> +				goto out;
> +			}
> +			/* cmpxchg failed; another CPU claimed this slot. */
> +		}
> +
> +		idx++;
> +		probes++;
> +	}
> +
> +	atomic_long_add_unless(this_cpu_ptr(smap->drops), 1, LONG_MAX);
> +	ret =3D -ENOSPC;
> +out:
> +	rcu_read_unlock_sched_notrace();
> +	return ret;
> +}
> +
> +/* --- Text export: /sys/kernel/debug/tracing/stack_map --- */
> +
> +struct stackmap_seq_private {
> +	struct ftrace_stackmap	*smap;
> +};
> +
> +static void *stackmap_seq_start(struct seq_file *m, loff_t *pos)
> +{
> +	struct stackmap_seq_private *priv =3D m->private;
> +	struct ftrace_stackmap *smap =3D priv->smap;
> +	loff_t i;
> +
> +	if (!smap)
> +		return NULL;
> +	/*
> +	 * Take the reader_sem to serialize against ftrace_stackmap_reset(),
> +	 * which holds it for write while clearing the table. Released in
> +	 * stackmap_seq_stop(), which seq_file calls regardless of whether
> +	 * start() returned an element or NULL (per Documentation/filesystems
> +	 * /seq_file.rst: "the iterator value returned by start() or next()
> +	 * is guaranteed to be passed to a subsequent next() or stop()").
> +	 */
> +	down_read(&smap->reader_sem);
> +	for (i =3D *pos; i < smap->map_size; i++) {
> +		if (READ_ONCE(smap->entries[i].key) &&
> +		    stackmap_load_elt(&smap->entries[i])) {
> +			*pos =3D i;
> +			return &smap->entries[i];
> +		}
> +	}
> +	return NULL;
> +}
> +
> +static void *stackmap_seq_next(struct seq_file *m, void *v, loff_t *pos)
> +{
> +	struct stackmap_seq_private *priv =3D m->private;
> +	struct ftrace_stackmap *smap =3D priv->smap;
> +	loff_t i;
> +
> +	if (!smap)
> +		return NULL;
> +	for (i =3D *pos + 1; i < smap->map_size; i++) {
> +		if (READ_ONCE(smap->entries[i].key) &&
> +		    stackmap_load_elt(&smap->entries[i])) {
> +			*pos =3D i;
> +			return &smap->entries[i];
> +		}
> +	}
> +	/*
> +	 * Advance *pos past the end so that on the next read() the
> +	 * subsequent stackmap_seq_start() call returns NULL and the
> +	 * iteration terminates. Without this, seq_read() would loop
> +	 * on the last element.
> +	 */
> +	*pos =3D smap->map_size;
> +	return NULL;
> +}
> +
> +static void stackmap_seq_stop(struct seq_file *m, void *v)
> +{
> +	struct stackmap_seq_private *priv =3D m->private;
> +	struct ftrace_stackmap *smap =3D priv->smap;
> +
> +	/*
> +	 * seq_file invokes stop() unconditionally after each iteration
> +	 * pass (see seq_read_iter / traverse), even when start() returned
> +	 * NULL. Always release here, balanced against the down_read in
> +	 * stackmap_seq_start().
> +	 */
> +	if (smap)
> +		up_read(&smap->reader_sem);
> +}
> +
> +static int stackmap_seq_show(struct seq_file *m, void *v)
> +{
> +	struct stackmap_entry *entry =3D v;
> +	struct stackmap_seq_private *priv =3D m->private;
> +	struct stackmap_elt *elt;
> +	u32 idx =3D entry - priv->smap->entries;
> +	u32 i, nr;
> +
> +	elt =3D stackmap_load_elt(entry);
> +	if (!elt)
> +		return 0;
> +
> +	nr =3D READ_ONCE(elt->nr);
> +	if (nr > FTRACE_STACKMAP_MAX_DEPTH)
> +		nr =3D FTRACE_STACKMAP_MAX_DEPTH;
> +
> +	seq_printf(m, "stack_id %u [ref %u, depth %u]\n",
> +		   idx, atomic_read(&elt->ref_count), nr);
> +	for (i =3D 0; i < nr; i++) {
> +		unsigned long ip =3D elt->ips[i];
> +
> +		/*
> +		 * Mirror trace_stack_print(): __ftrace_trace_stack()
> +		 * may replace trampoline addresses with
> +		 * FTRACE_TRAMPOLINE_MARKER before the stack reaches the
> +		 * map, and normal addresses must go through
> +		 * trace_adjust_address() (KASLR / module text delta)
> +		 * before symbolization. Without this the export would
> +		 * print a bogus symbol for the marker and unadjusted
> +		 * addresses for everything else.
> +		 */
> +		if (ip =3D=3D FTRACE_TRAMPOLINE_MARKER) {
> +			seq_printf(m, "  [%u] [FTRACE TRAMPOLINE]\n", i);
> +			continue;
> +		}
> +		seq_printf(m, "  [%u] %pS\n", i,
> +			   (void *)trace_adjust_address(priv->smap->tr, ip));
> +	}
> +	seq_putc(m, '\n');
> +	return 0;
> +}
> +
> +static const struct seq_operations stackmap_seq_ops =3D {
> +	.start	=3D stackmap_seq_start,
> +	.next	=3D stackmap_seq_next,
> +	.stop	=3D stackmap_seq_stop,
> +	.show	=3D stackmap_seq_show,
> +};
> +
> +static int stackmap_open(struct inode *inode, struct file *file)
> +{
> +	struct ftrace_stackmap *smap =3D inode->i_private;
> +	struct stackmap_seq_private *priv;
> +	struct seq_file *m;
> +	int ret;
> +
> +	if (!smap)
> +		return -ENODEV;
> +
> +	/*
> +	 * The text export symbolizes recorded kernel text addresses and
> +	 * doubles as the reset control file, so it takes the same open-time
> +	 * tracing policy as the other stackmap files: reject the open under
> +	 * LOCKDOWN_TRACEFS or when tracing is globally disabled, and pin the
> +	 * owning trace array for the lifetime of the fd.
> +	 */
> +	ret =3D tracing_check_open_get_tr(smap->tr);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D seq_open_private(file, &stackmap_seq_ops,
> +			       sizeof(struct stackmap_seq_private));
> +	if (ret)
> +		goto put_tr;
> +
> +	m =3D file->private_data;
> +	priv =3D m->private;
> +	priv->smap =3D smap;
> +	return 0;
> +
> +put_tr:
> +	trace_array_put(smap->tr);
> +	return ret;
> +}
> +
> +static int stackmap_release(struct inode *inode, struct file *file)
> +{
> +	struct seq_file *m =3D file->private_data;
> +	struct stackmap_seq_private *priv =3D m->private;
> +	struct ftrace_stackmap *smap =3D priv->smap;
> +	int ret;
> +
> +	ret =3D seq_release_private(inode, file);
> +	trace_array_put(smap->tr);
> +	return ret;
> +}
> +
> +/*
> + * Accept exactly "0" or "reset" (optionally followed by a single newlin=
e).
> + */
> +static bool stackmap_write_is_reset(const char *buf, size_t n)
> +{
> +	if (n > 0 && buf[n - 1] =3D=3D '\n')
> +		n--;
> +	return (n =3D=3D 1 && buf[0] =3D=3D '0') ||
> +	       (n =3D=3D 5 && memcmp(buf, "reset", 5) =3D=3D 0);
> +}
> +
> +static ssize_t stackmap_write(struct file *file, const char __user *ubuf,
> +			      size_t count, loff_t *ppos)
> +{
> +	struct seq_file *m =3D file->private_data;
> +	struct stackmap_seq_private *priv =3D m->private;
> +	char buf[8];
> +	size_t n =3D min(count, sizeof(buf) - 1);
> +	int ret;
> +
> +	if (n =3D=3D 0)
> +		return -EINVAL;
> +	if (copy_from_user(buf, ubuf, n))
> +		return -EFAULT;
> +	buf[n] =3D '\0';
> +
> +	if (!stackmap_write_is_reset(buf, n))
> +		return -EINVAL;
> +
> +	/*
> +	 * ftrace_stackmap_reset() atomically claims reset rights via
> +	 * cmpxchg and returns -EBUSY if another reset is already in
> +	 * progress.
> +	 */
> +	ret =3D ftrace_stackmap_reset(priv->smap);
> +	if (ret)
> +		return ret;
> +	return count;
> +}
> +
> +const struct file_operations ftrace_stackmap_fops =3D {
> +	.open		=3D stackmap_open,
> +	.read		=3D seq_read,
> +	.write		=3D stackmap_write,
> +	.llseek		=3D seq_lseek,
> +	.release	=3D stackmap_release,
> +};
> diff --git a/kernel/trace/trace_stackmap.h b/kernel/trace/trace_stackmap.h
> new file mode 100644
> index 000000000000..979d6fd76460
> --- /dev/null
> +++ b/kernel/trace/trace_stackmap.h
> @@ -0,0 +1,34 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _TRACE_STACKMAP_H
> +#define _TRACE_STACKMAP_H
> +
> +#include <linux/types.h>
> +#include <linux/atomic.h>
> +
> +#define FTRACE_STACKMAP_MAX_DEPTH	64
> +
> +struct trace_array;
> +
> +#ifdef CONFIG_FTRACE_STACKMAP
> +
> +struct ftrace_stackmap;
> +
> +struct ftrace_stackmap *ftrace_stackmap_create(struct trace_array *tr);
> +void ftrace_stackmap_destroy(struct ftrace_stackmap *smap);
> +int ftrace_stackmap_get_id(struct ftrace_stackmap *smap,
> +			   unsigned long *ips, unsigned int nr_entries);
> +
> +extern const struct file_operations ftrace_stackmap_fops;
> +
> +#else
> +
> +struct ftrace_stackmap;
> +static inline struct ftrace_stackmap *
> +ftrace_stackmap_create(struct trace_array *tr) { return NULL; }
> +static inline void ftrace_stackmap_destroy(struct ftrace_stackmap *s) { }
> +static inline int ftrace_stackmap_get_id(struct ftrace_stackmap *s,
> +					 unsigned long *ips, unsigned int n)
> +{ return -EOPNOTSUPP; }
> +
> +#endif
> +#endif /* _TRACE_STACKMAP_H */

