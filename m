Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED4742BC4E;
	Tue, 14 Jul 2026 21:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784063514; cv=none; b=FjQGII15T0fjw6inQ7f2Itcs7u3ivABvO25LYn2rwx7Lif0jFN2KgejXTxVi4k0i2wDQwjB/TdJOGrUiX02PyIyAlYX27QQc8rJnlvJrA49BGzbfzBkEHJ8Gu1OdJmvk44857X69szCe/8y5H5yFbNoSmnkD+ZWBZhIgDZOGoQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784063514; c=relaxed/simple;
	bh=Zd9eAlLVXyNNl61fUgOQ8GCY+lS8MAq+ffw0kle62t4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IQTWczPJ+a93ON2ZA75Lsdy0kDS/4x+X/F1muehUD5AZHg7EaSK/TN//Vv6rLLWUa9UDGb9fYhmvcfmwtv3bk9A1/T7C8/xM1OWDXBiNKiLMJE5XJCgnqNOm1PzERKQKhM7EyvEqP7Sj+y4KVrRJp0LtGpAV7zNCcA4eMxakcFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 5F06A1A0523;
	Tue, 14 Jul 2026 21:11:43 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id CD08931;
	Tue, 14 Jul 2026 21:11:40 +0000 (UTC)
Date: Tue, 14 Jul 2026 17:11:44 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Li Pengfei <ljdlns1987@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 lipengfei28@xiaomi.com, zhangbo56@xiaomi.com
Subject: Re: [RFC PATCH v4 1/3] trace: add lock-free stackmap for stack
 trace deduplication
Message-ID: <20260714171144.4537f163@gandalf.local.home>
In-Reply-To: <20260616064119.438063-2-lipengfei28@xiaomi.com>
References: <20260616064119.438063-1-lipengfei28@xiaomi.com>
	<20260616064119.438063-2-lipengfei28@xiaomi.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: CD08931
X-Stat-Signature: z7zuy5xwhszmp464ai1awd36ynrei459
X-Rspamd-Server: rspamout07
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+c4VAIsAAvWIvWcw35zZooPEN79d34dFI=
X-HE-Tag: 1784063500-193937
X-HE-Meta: U2FsdGVkX19ksaaJy3IbdL7zbgHHDTQg4IlSQWefywsD4y/FRsWVWTnsHC2fgyM1247hw5tsmeD7gFFOt4Ux1reXrZfJy872cEePHW23R2Nm/81WqIB072lR/qBrDExVRTasf0WwMdGGSEI0OiyVIu5En1qsnhukXcLozacZ5aL9LMi5QDDrycV62UxuME5T5HLnztFntPQgQDvzdYNQK8WpQuhvlQeYF9XON/1ZEcoEtToUskcTkUASoM5GhZy5kEUfitgObkGH1sZOozJ9uhNmV+c9aIz66d1ixNMSljklDXP7Pv+CnEjFFjTCjCPVpZOapeYDe1mUNDSnJcGBkwrqYCDuPMAd

On Tue, 16 Jun 2026 14:41:17 +0800
Li Pengfei <ljdlns1987@gmail.com> wrote:

> --- /dev/null
> +++ b/kernel/trace/trace_stackmap.c
> @@ -0,0 +1,889 @@
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
> + * Reset is a control-path operation, only allowed when tracing is
> + * stopped on the owning trace_array. The protocol is:
> + *
> + *   - atomic_cmpxchg(&resetting, 0, 1) atomically claims reset rights
> + *     and blocks new get_id() callers (they observe resetting=3D1 and
> + *     return -EINVAL).
> + *   - trace_types_lock serializes the tracer_tracing_is_on() check and
> + *     the destructive ring-buffer reset against tracefs writes to
> + *     tracing_on.
> + *   - synchronize_rcu() drains in-flight get_id() callers from the
> + *     ftrace callback path, which runs with preemption disabled.
> + *
> + * Online reset (with tracing active) is intentionally not supported
> + * to keep the design simple and the proof obligations small.
> + *
> + * The 32-bit jhash of the stack IPs is the hash table key. On hash
> + * collision, linear probing finds the next slot and full memcmp
> + * confirms the match.
> + *
> + * Concurrent userspace readers (cat stack_map / stack_map_bin) get
> + * a best-effort snapshot. They are coherent with the hot path
> + * (smp_load_acquire on entry->val); they are also serialized
> + * against reset via smap->reader_sem (readers take it in shared
> + * mode, reset in exclusive mode), so a reset cannot tear an
> + * iteration in progress -- it waits for active readers to drop
> + * the rwsem before clearing the map. The hot path is coordinated
> + * with reset separately, via acquire/release on smap->resetting.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/jhash.h>
> +#include <linux/seq_file.h>
> +#include <linux/kallsyms.h>
> +#include <linux/vmalloc.h>
> +#include <linux/atomic.h>
> +#include <linux/local_lock.h>
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
> + * that dereferences the elt (get_id, seq_show, bin_open). This pairs
> + * the writes to elt->{nr,ips,ref_count} (initialized BEFORE the
> + * publish) with the reads of those fields (which happen AFTER the
> + * load). seq_start / seq_next only test val for NULL and use the
> + * acquire load purely to keep memory ordering symmetric.
> + */
> +
> +/*
> + * Each pre-allocated element holds one unique stack trace.
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
> +	 * across seq_file iteration and binary snapshot construction;
> +	 * held in exclusive mode (write lock) by reset's clearing
> +	 * phase. The hot path (get_id) does not take this lock =E2=80=94 it
> +	 * uses smp_load_acquire/smp_store_release on entry->val and
> +	 * the resetting flag for the lock-free protocol.
> +	 */
> +	struct rw_semaphore	reader_sem;
> +	/*
> +	 * Per-CPU counters using local_t. local_t increments are NMI-
> +	 * safe on all architectures (single-instruction or interrupt-
> +	 * masked) and avoid the raw_spinlock_t fallback that
> +	 * atomic64_t uses on 32-bit GENERIC_ATOMIC64 =E2=80=94 which would
> +	 * deadlock if an NMI hit while the spinlock was held.
> +	 */
> +	local_t __percpu	*successes;	/* events served (hits + new inserts) */
> +	local_t __percpu	*drops;
> +};
> +
> +/*
> + * Cap the bits parameter to keep worst-case allocations bounded:
> + *   bits=3D18 =E2=86=92 256K elts, 512K slots, ~130 MB elt pool, ~130 M=
B bin
> + *             export.
> + * Smaller workloads should use the default (14) which gives 16K elts
> + * (~8 MB pool); bump bits via the ftrace_stackmap.bits=3D kernel
> + * parameter for higher unique-stack capacity.
> + */
> +#define FTRACE_STACKMAP_BITS_MIN	10
> +#define FTRACE_STACKMAP_BITS_MAX	18
> +#define FTRACE_STACKMAP_BITS_DEFAULT	14
> +
> +static unsigned int stackmap_map_bits =3D FTRACE_STACKMAP_BITS_DEFAULT;
> +static int __init stackmap_bits_setup(char *str)
> +{
> +	unsigned long val;
> +
> +	if (kstrtoul(str, 0, &val))
> +		return -EINVAL;
> +	val =3D clamp_val(val, FTRACE_STACKMAP_BITS_MIN, FTRACE_STACKMAP_BITS_M=
AX);
> +	stackmap_map_bits =3D val;
> +	return 0;
> +}
> +early_param("ftrace_stackmap.bits", stackmap_bits_setup);
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
> +	unsigned int bits;
> +
> +	smap =3D kzalloc_obj(*smap, GFP_KERNEL);
> +	if (!smap)
> +		return ERR_PTR(-ENOMEM);
> +
> +	/* Defensive clamp: reject bogus bits even if early_param is bypassed. =
*/
> +	bits =3D clamp_val(stackmap_map_bits,
> +			 FTRACE_STACKMAP_BITS_MIN,
> +			 FTRACE_STACKMAP_BITS_MAX);
> +
> +	smap->tr =3D tr;
> +	smap->map_bits =3D bits;
> +	smap->max_elts =3D 1U << bits;
> +	smap->map_size =3D 1U << (bits + 1);	/* 2x over-provision */
> +
> +	smap->entries =3D vzalloc(sizeof(*smap->entries) * smap->map_size);

Why not:

	smap->entries =3D vcalloc(smap->map_size, sizeof(*smap->entries));

?

> +	if (!smap->entries) {
> +		kfree(smap);
> +		return ERR_PTR(-ENOMEM);
> +	}

Make the error paths have:

	if (!smap->entries)
		goto fail;

> +
> +	/*
> +	 * Single large vmalloc of the element pool, indexed flat.
> +	 * At bits=3D18 this is 256K * sizeof(struct stackmap_elt). The
> +	 * struct is ~520 B (8 + 4 + 4 + 64*8), so total ~135 MB.
> +	 */
> +	smap->elts =3D vzalloc(sizeof(*smap->elts) * (size_t)smap->max_elts);

vcalloc()?

> +	if (!smap->elts) {

		goto fail;

> +		vfree(smap->entries);
> +		kfree(smap);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	smap->successes =3D alloc_percpu(local_t);
> +	if (!smap->successes) {

		goto fail;

> +		vfree(smap->elts);
> +		vfree(smap->entries);
> +		kfree(smap);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +	smap->drops =3D alloc_percpu(local_t);
> +	if (!smap->drops) {

		goto fail;

> +		free_percpu(smap->successes);
> +		vfree(smap->elts);
> +		vfree(smap->entries);
> +		kfree(smap);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	smap->hash_seed =3D get_random_u32();
> +	atomic_set(&smap->next_elt, 0);
> +	atomic_set(&smap->resetting, 0);
> +	init_rwsem(&smap->reader_sem);
> +
> +	return smap;

fail:

	if (smap) {
		free_percpu(smap->successes);
		vfree(smap->elts);
		vfree(smap->entries);
		kfree(smap);

// As all the above handle passing in NULL just fine.

	}

	return ERR_PTR(-ENOMEM);



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
> +}
> +
> +/**
> + * ftrace_stackmap_reset - clear all entries in the stackmap
> + * @smap: the stackmap to reset
> + *
> + * Returns 0 on success, -EBUSY if another reset is already in
> + * progress, or if tracing is currently active on the owning
> + * trace_array.
> + *
> + * Online reset (with tracing active) is not supported. Caller must
> + * stop tracing first (echo 0 > tracing_on).
> + *
> + * Caller is process context (typically sysfs write handler).
> + *
> + * Protocol:
> + *   1. Atomically claim reset rights via cmpxchg on @resetting.
> + *   2. Take trace_types_lock to serialize against tracefs writes to
> + *      tracing_on.
> + *   3. Verify tracing is stopped on @smap->tr; if not, release the
> + *      claim and return -EBUSY. The resetting flag itself blocks
> + *      any subsequent get_id() callers.
> + *   4. synchronize_rcu() drains in-flight get_id() callers from the
> + *      ftrace callback path (which runs preempt-disabled).
> + *   5. Reset the ring buffer(s), then memset entries, elts, and
> + *      counters.
> + *   6. Release the resetting flag with release semantics so any new
> + *      get_id() observes a fully cleared map.
> + */
> +int ftrace_stackmap_reset(struct ftrace_stackmap *smap)
> +{
> +	struct trace_array *tr;
> +	int ret =3D 0;
> +
> +	if (!smap)
> +		return 0;
> +
> +	if (atomic_cmpxchg(&smap->resetting, 0, 1) !=3D 0)
> +		return -EBUSY;
> +
> +	mutex_lock(&trace_types_lock);
> +
> +	tr =3D smap->tr;
> +	if (tr && tracer_tracing_is_on(tr)) {
> +		ret =3D -EBUSY;
> +		goto out_unlock;
> +	}
> +
> +	/*
> +	 * synchronize_rcu() itself is a full barrier; no extra smp_mb()
> +	 * is needed before it. It drains in-flight ftrace callbacks that
> +	 * may have already passed the resetting check with the old value.
> +	 */
> +	synchronize_rcu();
> +
> +	/*
> +	 * Take the reader_sem in exclusive mode. This serializes the
> +	 * memset against any tracefs reader (seq_file iteration or
> +	 * stack_map_bin snapshot) that may currently hold the rwsem
> +	 * for read. synchronize_rcu() already drained the hot path;
> +	 * this rwsem covers process-context readers that aren't
> +	 * preempt-disabled.
> +	 */
> +	down_write(&smap->reader_sem);
> +
> +	/*
> +	 * Clear the ring buffer(s) BEFORE the map, both under the write
> +	 * lock. The ring buffer may still hold TRACE_STACK_ID events
> +	 * whose stack_id points at slots we are about to free/reuse.
> +	 * Resetting the buffer first guarantees an external observer
> +	 * never sees the inconsistent "trace still has <stack_id N> but
> +	 * the map is already empty" window: it sees either (old buffer,
> +	 * old map) or (cleared buffer, old map) or (cleared buffer,
> +	 * cleared map) -- never (old buffer, cleared map).
> +	 *
> +	 * Use tracing_reset_all_cpus() (not _online_cpus) so per-CPU
> +	 * buffers belonging to currently offline CPUs are also cleared.
> +	 * The ring buffer is allocated per-possible-CPU; an offline CPU's
> +	 * buffer can still hold a TRACE_STACK_ID event written before
> +	 * the CPU went offline. tracing_reset_online_cpus() iterates
> +	 * for_each_online_buffer_cpu() and would leave that data behind
> +	 * to be observed once the CPU comes back online (or by the
> +	 * trace reader, which iterates all allocated CPU buffers),
> +	 * recreating the stale-stack_id window we are trying to close.
> +	 *
> +	 * Since reset requires tracing to be stopped, this makes "reset"
> +	 * an explicitly destructive operation on the owning trace_array,
> +	 * keeping ring-buffer stack_ids and the map coherent.
> +	 */
> +	if (tr) {
> +		tracing_reset_all_cpus(&tr->array_buffer);
> +#ifdef CONFIG_TRACER_SNAPSHOT
> +		if (tr->allocated_snapshot)
> +			tracing_reset_all_cpus(&tr->snapshot_buffer);
> +#endif
> +	}
> +
> +	memset(smap->entries, 0, sizeof(*smap->entries) * smap->map_size);
> +	memset(smap->elts, 0, sizeof(*smap->elts) * (size_t)smap->max_elts);
> +
> +	atomic_set(&smap->next_elt, 0);
> +	{

Do not add anonymous blocks in functions.

> +		int cpu;

Just declare cpu at the beginning of the function.

> +
> +		for_each_possible_cpu(cpu) {
> +			local_set(per_cpu_ptr(smap->successes, cpu), 0);
> +			local_set(per_cpu_ptr(smap->drops, cpu), 0);
> +		}
> +	}
> +
> +	up_write(&smap->reader_sem);
> +
> +out_unlock:
> +	mutex_unlock(&trace_types_lock);
> +
> +	/* Release resetting=3D0 so new get_id() observes a cleared map. */
> +	atomic_set_release(&smap->resetting, 0);
> +	return ret;
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
> +
> +	/*
> +	 * atomic_read_acquire() pairs with atomic_set_release() in the
> +	 * reset path. This ensures that subsequent reads of entry->key
> +	 * and entry->val are ordered after this check; without acquire,
> +	 * the CPU would only have a control dependency, which orders
> +	 * subsequent stores but not loads (per LKMM).
> +	 */
> +	if (!smap || !nr_entries || atomic_read_acquire(&smap->resetting))
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
> +			 * the seq_show / bin_open readers. nr is write-once
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
> +				 * successes/drops are best-effort throughput
> +				 * counters. Saturate at LONG_MAX so they do
> +				 * not wrap on long runs (notably where local_t
> +				 * is 32-bit), matching ref_count's behaviour.
> +				 */
> +				local_add_unless(this_cpu_ptr(smap->successes),
> +						 1, LONG_MAX);
> +				return (int)idx;
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
> +					 * Pool exhausted. We claimed this
> +					 * slot with cmpxchg but cannot fill
> +					 * it. Leave key set so the slot
> +					 * stays "claimed but empty" =E2=80=94 future
> +					 * lookups treat val=3D=3DNULL as a miss
> +					 * and probe past it. Cannot revert
> +					 * key=3D0 without racing other CPUs.
> +					 */
> +					local_add_unless(this_cpu_ptr(smap->drops),
> +							 1, LONG_MAX);
> +					return -ENOSPC;
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
> +				local_add_unless(this_cpu_ptr(smap->successes),
> +						 1, LONG_MAX);
> +				return (int)idx;
> +			}
> +			/* cmpxchg failed; another CPU claimed this slot. */
> +		}
> +
> +		idx++;
> +		probes++;
> +	}
> +
> +	local_add_unless(this_cpu_ptr(smap->drops), 1, LONG_MAX);
> +	return -ENOSPC;
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
> +	u32 i;
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
> +	u32 i;
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
> +	struct stackmap_seq_private *priv;
> +	struct seq_file *m;
> +	int ret;
> +
> +	ret =3D seq_open_private(file, &stackmap_seq_ops,
> +			       sizeof(struct stackmap_seq_private));
> +	if (ret)
> +		return ret;
> +	m =3D file->private_data;
> +	priv =3D m->private;
> +	priv->smap =3D inode->i_private;
> +	return 0;
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
> +	 * cmpxchg and returns -EBUSY if another reset is in progress
> +	 * or if tracing is active.
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
> +	.release	=3D seq_release_private,
> +};
> +
> +/* --- Stats --- */
> +
> +static int stackmap_stat_show(struct seq_file *m, void *v)
> +{
> +	struct ftrace_stackmap *smap =3D m->private;
> +	u64 successes =3D 0, drops =3D 0;
> +	u32 entries;
> +	int cpu;
> +
> +	if (!smap) {
> +		seq_puts(m, "stackmap not initialized\n");
> +		return 0;
> +	}
> +
> +	entries =3D atomic_read(&smap->next_elt);
> +	for_each_possible_cpu(cpu) {
> +		successes +=3D local_read(per_cpu_ptr(smap->successes, cpu));
> +		drops +=3D local_read(per_cpu_ptr(smap->drops, cpu));
> +	}
> +
> +	seq_printf(m, "entries:      %u / %u\n", entries, smap->max_elts);
> +	seq_printf(m, "table_size:   %u\n", smap->map_size);
> +	seq_printf(m, "successes:    %llu\n", successes);
> +	seq_printf(m, "drops:        %llu\n", drops);
> +	if (successes + drops > 0)
> +		seq_printf(m, "success_rate: %llu%%\n",
> +			   successes * 100 / (successes + drops));
> +	return 0;
> +}
> +
> +static int stackmap_stat_open(struct inode *inode, struct file *file)
> +{
> +	return single_open(file, stackmap_stat_show, inode->i_private);
> +}
> +
> +const struct file_operations ftrace_stackmap_stat_fops =3D {
> +	.open		=3D stackmap_stat_open,
> +	.read		=3D seq_read,
> +	.llseek		=3D seq_lseek,
> +	.release	=3D single_release,
> +};
> +
> +/* --- Binary export --- */
> +
> +struct stackmap_bin_snapshot {
> +	/*
> +	 * Use u64 (not size_t) so data[] is 8-byte aligned on both
> +	 * 32-bit and 64-bit architectures. The IP array within data[]
> +	 * is accessed as u64*, which would alignment-fault on strict
> +	 * architectures (e.g. older ARM, SPARC) if data[] started at
> +	 * a 4-byte boundary.
> +	 */
> +	u64	size;
> +	char	data[];
> +};
> +
> +static int stackmap_bin_open(struct inode *inode, struct file *file)
> +{
> +	struct ftrace_stackmap *smap =3D inode->i_private;
> +	struct stackmap_bin_snapshot *snap;
> +	struct ftrace_stackmap_bin_header *hdr;
> +	size_t alloc_size, off;
> +	u32 nr_entries, i, nr_stacks;
> +
> +	if (!smap)
> +		return -ENODEV;
> +
> +	/*
> +	 * Worst-case allocation size: every populated entry uses a
> +	 * full-depth stack. The (+1) gives one slack slot in case a
> +	 * concurrent insert lands between this snapshot and iteration.
> +	 * The loop below performs an explicit bounds check anyway.
> +	 *
> +	 * At bits=3D18 this caps at ~135 MB. The file is mode 0440
> +	 * (TRACE_MODE_READ), so only privileged users can open it.
> +	 */
> +	nr_entries =3D atomic_read(&smap->next_elt);
> +	alloc_size =3D sizeof(*hdr) + (nr_entries + 1) *
> +		     (sizeof(struct ftrace_stackmap_bin_entry) +
> +		      FTRACE_STACKMAP_MAX_DEPTH * sizeof(u64));

Really should have ftrace_stackmap_bin_entry have a flexible array:

(move struct ftrace_stackmap_bin_entry *e to top)

	alloc_size =3D sizeof(*hdr) + (nr_entries + 1) *
		struct_size(e, ips, FTRACE_STACKMAP_MAX_DEPTH);

> +
> +	snap =3D vmalloc(sizeof(*snap) + alloc_size);
> +	if (!snap)
> +		return -ENOMEM;
> +
> +	hdr =3D (struct ftrace_stackmap_bin_header *)snap->data;
> +	hdr->magic =3D FTRACE_STACKMAP_BIN_MAGIC;
> +	hdr->version =3D FTRACE_STACKMAP_BIN_VERSION;
> +	hdr->reserved =3D 0;
> +	off =3D sizeof(*hdr);
> +	nr_stacks =3D 0;
> +
> +	/*
> +	 * Take reader_sem to serialize against ftrace_stackmap_reset(),
> +	 * which clears the table and elt pool under the write lock.
> +	 */
> +	down_read(&smap->reader_sem);
> +
> +	for (i =3D 0; i < smap->map_size; i++) {
> +		struct stackmap_entry *entry =3D &smap->entries[i];
> +		struct stackmap_elt *elt;

> +		struct ftrace_stackmap_bin_entry *e;

move to top of function.

> +		u64 *ips_out;
> +		u32 k, nr;
> +
> +		if (!READ_ONCE(entry->key))
> +			continue;
> +		elt =3D stackmap_load_elt(entry);
> +		if (!elt)
> +			continue;
> +
> +		nr =3D READ_ONCE(elt->nr);
> +		if (nr > FTRACE_STACKMAP_MAX_DEPTH)
> +			nr =3D FTRACE_STACKMAP_MAX_DEPTH;
> +
> +		/* Bounds check: stop if we would overflow the allocation. */
> +		if (off + sizeof(*e) + nr * sizeof(u64) > alloc_size)

		if (off + struct_size(e, ips, nr) > alloc_size)

> +			break;
> +
> +		e =3D (struct ftrace_stackmap_bin_entry *)(snap->data + off);
> +		e->stack_id =3D i;
> +		e->nr =3D nr;
> +		e->ref_count =3D atomic_read(&elt->ref_count);
> +		e->reserved =3D 0;

> +		off +=3D sizeof(*e);

delete the above.

> +
> +		ips_out =3D (u64 *)(snap->data + off);

		ips_out =3D e->ips;

> +		for (k =3D 0; k < nr; k++) {
> +			unsigned long ip =3D elt->ips[k];
> +
> +			/*
> +			 * Emit the trampoline marker verbatim so userspace
> +			 * can render it as [FTRACE TRAMPOLINE]; pass every
> +			 * other address through trace_adjust_address() so the
> +			 * binary export follows the same address-adjustment
> +			 * rules as the text export.
> +			 */
> +			if (ip =3D=3D FTRACE_TRAMPOLINE_MARKER)
> +				ips_out[k] =3D (u64)FTRACE_TRAMPOLINE_MARKER;
> +			else
> +				ips_out[k] =3D (u64)trace_adjust_address(smap->tr, ip);
> +		}
> +		off +=3D nr * sizeof(u64);

		off +=3D struct_size(e, ips, nr);

> +		nr_stacks++;
> +	}
> +
> +	up_read(&smap->reader_sem);
> +
> +	hdr->nr_stacks =3D nr_stacks;
> +	snap->size =3D off;
> +	file->private_data =3D snap;
> +	return 0;
> +}
> +
> +static ssize_t stackmap_bin_read(struct file *file, char __user *ubuf,
> +				 size_t count, loff_t *ppos)
> +{
> +	struct stackmap_bin_snapshot *snap =3D file->private_data;
> +
> +	if (!snap)
> +		return -EINVAL;
> +	return simple_read_from_buffer(ubuf, count, ppos, snap->data, snap->siz=
e);
> +}
> +
> +static int stackmap_bin_release(struct inode *inode, struct file *file)
> +{
> +	vfree(file->private_data);
> +	return 0;
> +}
> +
> +const struct file_operations ftrace_stackmap_bin_fops =3D {
> +	.open		=3D stackmap_bin_open,
> +	.read		=3D stackmap_bin_read,
> +	.llseek		=3D default_llseek,
> +	.release	=3D stackmap_bin_release,
> +};
> diff --git a/kernel/trace/trace_stackmap.h b/kernel/trace/trace_stackmap.h
> new file mode 100644
> index 000000000000..7c2e5ab9d36d
> --- /dev/null
> +++ b/kernel/trace/trace_stackmap.h
> @@ -0,0 +1,57 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _TRACE_STACKMAP_H
> +#define _TRACE_STACKMAP_H
> +
> +#include <linux/types.h>
> +#include <linux/atomic.h>
> +
> +#define FTRACE_STACKMAP_MAX_DEPTH	64
> +
> +/* Binary export format */
> +#define FTRACE_STACKMAP_BIN_MAGIC	0x46534D42	/* 'FSMB' */
> +#define FTRACE_STACKMAP_BIN_VERSION	1
> +
> +struct ftrace_stackmap_bin_header {
> +	u32 magic;
> +	u32 version;
> +	u32 nr_stacks;
> +	u32 reserved;
> +};
> +
> +struct ftrace_stackmap_bin_entry {
> +	u32 stack_id;
> +	u32 nr;
> +	u32 ref_count;
> +	u32 reserved;
> +	/* followed by u64 ips[nr] */

Why not make this a flexible array?

	u64 ips[];

Then the code can be simpler as described above.

-- Steve


> +};
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
> +int ftrace_stackmap_reset(struct ftrace_stackmap *smap);
> +
> +extern const struct file_operations ftrace_stackmap_fops;
> +extern const struct file_operations ftrace_stackmap_stat_fops;
> +extern const struct file_operations ftrace_stackmap_bin_fops;
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
> +static inline int ftrace_stackmap_reset(struct ftrace_stackmap *s) { ret=
urn 0; }
> +
> +#endif
> +#endif /* _TRACE_STACKMAP_H */

