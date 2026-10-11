Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAC7456DE6
	for <linux-trace-kernel@vger.kernel.org>; Sun, 11 Oct 2026 19:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791748653; cv=none; b=Jweb36b8V4aN5We7sthVndBKc9+GDqsuLnxxIA9AukO++hpo+8utbm6S5734CXLSO0BpNUR1eIYq4zXbdZ65R2uoDyxak9gmCMSUQMEupZMOXpylK04U+39paRpDMBAN+LvvBFTXBWG4IjOsoQDQYLt/IRMKLdwk/KtJPk54kk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791748653; c=relaxed/simple;
	bh=DkQ0PS3xRigYMKaQC0qEUmMzhvLU40wYfOaQoWfmE8Q=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=nCt/O6LEmvoo9V/RS9MWaeV8kNINNZ3qpTB/bUOWohnZZjywOM5jtMUPsy0V4fKwTGDvu+jnLqPgOkIBEEqRjW08haH57FLNxW5qDA+VpvekOuCVh32h513xMIN63XsY8ullxdRImUO/qgoVCe3UmGra90vUPWazTAYnGgDHa/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eoJOJeXu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eoJOJeXu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7119B1F0089B;
	Sun, 11 Oct 2026 19:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791748652;
	bh=hmQusLFWiRAaxENcsUPoAcCmfBEHFIihraFNdMpEBYM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eoJOJeXunDadjWT/k3hX1iGsucKdYcmVCfdJA7Zv4T6a1WTCI+d2NB1wjuHxEu6c0
	 +YO44U/QnqINHkhirqdG+Bsb44ezPW+KmGlSjA/F3RUPkuyPwfs+DW+AOwP4NVaD0j
	 lqriH3CjCo2g9zTvD+t68ME4JR/tFfB+0meeGskzD3cElzwLKAC7XvJBk1sQZ49LH1
	 toClI/3Jh5vmMnXJGmbAy67z+kUnIWA1wnn/FYwUmMP675aAueRll1HzA/GcBjd6GG
	 RaU+vH4iFA99oUrbVbijpBOtpKUJCWZG5xqqpOpBv9DUePCjEFJ56oJcI841qkh4t/
	 pIfmqXk7VhqxA==
Message-ID: <sashiko-outbox-167432@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 07/14] rv: Introduce DA_MON_ALLOCATION_STRATEGY
Reply-To: sashiko-reviews@lists.linux.dev
To: wen.yang@linux.dev
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <9c482459a4a23c5a240f1911259efcb54fa75898.1791745088.git.wen.yang@linux.dev>
References: <cover.1791745088.git.wen.yang@linux.dev>
 <9c482459a4a23c5a240f1911259efcb54fa75898.1791745088.git.wen.yang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 19:57:32 +0000
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] mm: spinlock_t acquired in tracepoint via DA_ALLOC_POOL
- [High] rcu: unprotected hash_add_rcu() corrupts da_monitor_ht
- [High] rv: execution after free on module unload due to missing rcu_barri=
er()
- [Low] kmemleak: asymmetric kfree() of kmalloc_nolock() storage
--

commit 0a1871af9a55378524a2c76be086f8e3f24c7568
Author: Wen Yang <wen.yang@linux.dev>

rv: Introduce DA_MON_ALLOCATION_STRATEGY

Per-object DA storage allocation is currently limited to kmalloc on
demand. Add a compile-time selector so monitors can choose among three
strategies:

  DA_ALLOC_AUTO   (default) - kmalloc per object on the monitor path
  DA_ALLOC_POOL             - pre-allocated fixed-size mempool;
                              selected by defining DA_MON_POOL_SIZE
  DA_ALLOC_MANUAL           - caller pre-inserts storage; framework
                              only links the target field

nomiss switches from the implicit DA_SKIP_AUTO_ALLOC override to an
explicit DA_MON_ALLOCATION_STRATEGY DA_ALLOC_MANUAL; the behaviours are
equivalent (pre-allocated storage, no allocation on the sched_switch
start path).

> diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
> index 5d3468a7a12b7..7d1026e9edbc6 100644
> --- a/include/rv/da_monitor.h
> +++ b/include/rv/da_monitor.h

[ ... ]

> @@ -563,6 +601,46 @@ static void da_kfree_cb(struct rcu_head *head)

[ ... ]

> +/*
> + * da_create_pool_storage - pop a free pool slot and insert it into the =
hash.
> + * Returns NULL if the pool is exhausted.  Caller holds an RCU read-side=
 CS
> + * and the monitor's serialisation lock.
> + */
> +static inline struct da_monitor *
> +da_create_pool_storage(da_id_type id, monitor_target target,
> +		       struct da_monitor *da_mon)
> +{
> +	struct da_monitor_storage *mon_storage;
> +
> +	if (da_mon)
> +		return da_mon;
> +
> +	mon_storage =3D mempool_alloc_preallocated(&da_monitor_pool);
> +	if (!mon_storage)
> +		return NULL;

[Severity: High]
Does this code acquire a spinlock_t inside an atomic context?

Tracepoint handlers, such as sched_switch handled by nomiss, execute in an
atomic context with preemption disabled.

The mempool_alloc_preallocated() function internally acquires the pool's
spinlock_t lock.

On preempt-rt kernels, spinlock_t maps to a sleeping rt_mutex. Acquiring it
inside an atomic, preemption-disabled context violates the nesting hierarch=
y,
resulting in "Invalid wait context" lockdep splats and a sleep-in-atomic pa=
nic.

> +	memset(mon_storage, 0, sizeof(*mon_storage));
> +
> +	mon_storage->id =3D id;
> +	mon_storage->target =3D target;
> +
> +	hash_add_rcu(da_monitor_ht, &mon_storage->node, id);
> +	return &mon_storage->rv.da_mon;
> +}

[Severity: High]
Will concurrent modifications corrupt the global da_monitor_ht?

Tracepoint handlers execute concurrently across multiple CPUs. When startin=
g a
new monitor for an object, the caller only holds an RCU read lock, providin=
g no
mutual exclusion against concurrent writers on other CPUs.

Because hash_add_rcu() uses hlist_add_head_rcu() which modifies the global
bucket's head pointer, simultaneous unprotected writes from different CPUs
tracking different targets could corrupt the bucket's linked list structure
and cause traversal hangs or lost objects.

[ ... ]

> @@ -584,7 +662,10 @@ static inline void da_destroy_storage(da_id_type id)
>  		return;
>  	da_monitor_reset_hook(&mon_storage->rv.da_mon);
>  	hash_del_rcu(&mon_storage->node);
> -	call_rcu(&mon_storage->rcu, da_kfree_cb);
> +	if (DA_MON_ALLOCATION_STRATEGY =3D=3D DA_ALLOC_POOL)
> +		call_rcu(&mon_storage->rcu, da_pool_return_cb);
> +	else
> +		call_rcu(&mon_storage->rcu, da_kfree_cb);
>  }

[Severity: Low]
Are there kmemleak warnings triggered by this asymmetric free?

Monitor storage for DA_ALLOC_AUTO and DA_ALLOC_MANUAL is allocated using
kmalloc_nolock() inside da_create_empty_storage().

This path queues da_kfree_cb() which frees the memory using the standard
kfree() API.

Allocations made with kmalloc_nolock() must be paired precisely with
kfree_nolock(). Mixing them bypasses the kmemleak tracking hooks unevenly,
which can cause "Trying to color unknown object" warnings or false memory l=
eak
reports.

[ ... ]

> @@ -629,20 +717,33 @@ static inline void da_monitor_destroy(void)
>  	hash_for_each_safe(da_monitor_ht, bkt, tmp, mon_storage, node) {
>  		da_monitor_free_hook(&mon_storage->rv.da_mon);
>  		hash_del_rcu(&mon_storage->node);
> -		kfree(mon_storage);
> +		if (DA_MON_ALLOCATION_STRATEGY =3D=3D DA_ALLOC_POOL)
> +			mempool_free(mon_storage, &da_monitor_pool);
> +		else
> +			kfree(mon_storage);
> +	}
> +
> +	if (DA_MON_ALLOCATION_STRATEGY =3D=3D DA_ALLOC_POOL) {
> +		rcu_barrier();
> +		mempool_exit(&da_monitor_pool);
>  	}
>  }

[Severity: High]
Is it safe to skip rcu_barrier() for the other allocation strategies?

For DA_ALLOC_AUTO and DA_ALLOC_MANUAL, call_rcu() is used to queue da_kfree=
_cb.
Because da_kfree_cb is declared as static inside include/rv/da_monitor.h, i=
ts
text is compiled directly into the dynamically loaded RV monitor module.

If da_destroy_storage() is called shortly before the module is unloaded, the
callbacks will be queued. If da_monitor_destroy() doesn't call rcu_barrier(=
) to
wait for pending callbacks, the module will be unloaded and the RCU softirq
will jump to an unmapped callback address, causing a kernel panic.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791745088.gi=
t.wen.yang@linux.dev?part=3D7
