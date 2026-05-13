Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB55246766
	for <linux-trace-kernel@vger.kernel.org>; Wed, 13 May 2026 13:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778680250; cv=none; b=IK0Ig8UY32ofjsF468NoTD4hIbz2rOHjqUMC+lrnLrynLw+MlEm/UXdA/oqkNDt4eT4j6Y0wdS6ogASya2rhc4oTPWKYn8rEBRh6D8VnGoSv+I1DZREjpEAhRhaivWDhcADSrFZ9QeMNjGS8p4A3S03DKR/B/BjnbHMvf4BEl9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778680250; c=relaxed/simple;
	bh=qxYDjg20Dpv+T12VaLFXfMicooCde1h2OZiYqiL2710=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rsLk9AmU+bkIRNsscuZsqimL/ijopy/mGEGg7b1aWHvKOkwp57JmhGYN/zU+KE/5vuHqw4oqhYCcmo9H9muXmd6MlXAHRx+rxR+Zm0qE1A7fSV/+V2uZpayk2DTJu+Tus8K3/PejQTZ6LFpDLR7oHgjv4XZp6tQRSqo45R4ckAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NUuf8WMY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NUuf8WMY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778680247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qxYDjg20Dpv+T12VaLFXfMicooCde1h2OZiYqiL2710=;
	b=NUuf8WMYPfs84fQ7vuAAp5m/AoXM7ctpJ2i9oYbe7Hu7UNhNwmo44Ror6zNJsNW+eP4xI3
	w+WUH0IMhuFppZ63X6TlxR3EW1MojhdVEBdzu/XfBW/vhCPbSAOmrZDvLWjKsIgqBg50d2
	gK0fDV7rGsa0N4Eaks1UqIQy9ezIOTk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-9uOUwSNoNNGmHOSC--Yy1g-1; Wed, 13 May 2026 09:50:46 -0400
X-MC-Unique: 9uOUwSNoNNGmHOSC--Yy1g-1
X-Mimecast-MFC-AGG-ID: 9uOUwSNoNNGmHOSC--Yy1g_1778680245
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48fd3449e6dso2226165e9.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 13 May 2026 06:50:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778680245; x=1779285045;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qxYDjg20Dpv+T12VaLFXfMicooCde1h2OZiYqiL2710=;
        b=LDy4NNpYKL1Vp/ndJnvaf2pIyyFuH7Osyxx7KcVpNen80eVkNX/JDOj/p9vTCrDTcZ
         NzWcn1L9Lu5rxobDoCCoEzqmVIYYtbyadnLxWB0Eg8aZNX48q6pVIhHFl7geC/rrfyuf
         Szg1GMYFGh8LBj2N5tL1UV8WmA1t7OaiJ8NzgElkjBGmrJ/cBA/rBy+qbkciy1tLZwSn
         rTrorrFrGQdha4aaZQ94ZUX29IT3CBGvCFevv3Cq1ccMgm0z5actQCWv9gVdRLY637wm
         4iKSmm110fA0qZkkkfyb7ABoq4h5jfqYpcePCCNVQlvB0RIEqhv1P5moQDHT/aE9cE/5
         2Okw==
X-Gm-Message-State: AOJu0YzojclWVqj4gowe97bbgyAPqQV0RZ1+1exiooSKcCo7ZeNawTtP
	bmRUzQ7mcV7NEQ/5FSazFdLld5PebqckdyxBQY2LlCf05aKKpYG679cVl7pa+UzFLpxahxN3dvL
	ISTasAc3tvKhnRPGTGFKCmYXwnTfRQzrXrBItrZuovpVKvynagKVxT3kE3i686BEmyNdw1CRPMQ
	==
X-Gm-Gg: Acq92OG5fMPiiTBm9YM+UOP0WS6strmrDQU6dasU+PHC/24jfUgT340NvQvolThqyd6
	Tg1WtkaUeDc/8O/zVZiQpQu/NNLbAiN88BI6truo2EAmwim6THZsJxG0SkPAIVumgIG4RIeJB68
	wul94KWHHQIL523YGuEll0dcerrUe8VXPoWRKSt7ygAcDvQE4CpITiAYYUU0RzR3wRnR1cID1Gm
	9zZdAdZOcEA59lvaAearABwP5jebQwclxOD9nvQFsvEBk528b+YAZXWTkW2pKyk3i/knYoY3K1s
	CXiDxB5D4oGbktN2fHqYloypis5aFYHTjB9Hp0vGWDRcgmV2/RWl9yBAP0ullr5TPTYnehn4voG
	RtzRcWB1nMea13LtIGtC+XVMJNeeR6fIvj+ILcYPWx3GEAJN+7AnlHHHfHTQ3lVefjBjcT80FRU
	J/k+eveGcxwvllhKw=
X-Received: by 2002:a05:600c:3e87:b0:48e:8499:4be0 with SMTP id 5b1f17b1804b1-48fce9eec6dmr40731015e9.15.1778680244691;
        Wed, 13 May 2026 06:50:44 -0700 (PDT)
X-Received: by 2002:a05:600c:3e87:b0:48e:8499:4be0 with SMTP id 5b1f17b1804b1-48fce9eec6dmr40730515e9.15.1778680244267;
        Wed, 13 May 2026 06:50:44 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548ec6aea4sm47122913f8f.10.2026.05.13.06.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 06:50:43 -0700 (PDT)
Message-ID: <a6534a228702cd5e8eb6721a2afb1f0ba2b93aac.camel@redhat.com>
Subject: Re: [RFC PATCH v2 04/10] rv/da: add pre-allocated storage pool for
 per-object monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: wen.yang@linux.dev
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>
Date: Wed, 13 May 2026 15:50:42 +0200
In-Reply-To: <2774332570ee823be60cfe84ba85e9573b4df478.1778522945.git.wen.yang@linux.dev>
References: <cover.1778522945.git.wen.yang@linux.dev>
		 <2774332570ee823be60cfe84ba85e9573b4df478.1778522945.git.wen.yang@linux.dev>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bYSes7-QeCjaFAOAhKNtzh76PQSRv_Oy3C0TvTuAS4E_1778680245
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-05-12 at 02:24 +0800, wen.yang@linux.dev wrote:
> From: Wen Yang <wen.yang@linux.dev>
>=20
> da_create_empty_storage() uses kmalloc_nolock(), which requires
> CONFIG_HAVE_ALIGNED_STRUCT_PAGE; on UML and some PREEMPT_RT
> configurations it always returns NULL.=C2=A0 Calling kmalloc from schedul=
er
> tracepoint handlers also adds unwanted latency and can fail under
> memory pressure.
>=20
> Add da_monitor_init_prealloc(N) as an opt-in alternative to
> da_monitor_init().=C2=A0 It allocates N da_monitor_storage slots with
> GFP_KERNEL up-front and manages them on a LIFO free-stack protected
> by a spinlock, so da_create_or_get() never calls kmalloc on the hot
> path.
>=20
> Monitors that do not call da_monitor_init_prealloc() are unaffected.

That's definitely a good addition, kmalloc_nolock was not that good already=
 so I
tried some way have a preallocation, though I realise it isn't really flexi=
ble.

Since you're using spinlocks, isn't that going to sleep on PREEMPT_RT?

Isn't this similar to what you'd do with a kmem_cache. That was my original=
 idea
although that uses spinlocks too.

I quickly tried an implementation like yours using
mempool_create_slab_pool(prealloc_count) and mempool_alloc_preallocated() a=
nd it
still explodes with my monitors, but perhaps now that tracepoints no longer
disable preemption it could play well with some monitors.

The selftests with tlob seem to work just the same with this kmem_cache (up=
 to
the unrelated RCU stall). To be fair since you only allocate from the uprob=
e
handler, you'd probably be just fine with kmalloc_nolock, but let's continu=
e
with the preallocation logic.


The API is starting to get complex (well, not that it wasn't already).
We have essentially 3 ways to allocate:
 * fully automatic with kmalloc_nolock
 * semi-automatic with pool preallocation
 * manual with direct storage preallocation

We can have a macro DA_MON_ALLOCATION_STRATEGY =3D {DA_MON_AUTO, DA_MON_POO=
L,
DA_MON_MANUAL} where DA_MON_POOL also requires DA_MON_POOL_SIZE to be defin=
e
(force that with an #error).

>=20
> Signed-off-by: Wen Yang <wen.yang@linux.dev>
> ---
> =C2=A0include/rv/da_monitor.h | 208 +++++++++++++++++++++++++++++++++++--=
---
> =C2=A01 file changed, 186 insertions(+), 22 deletions(-)
>=20
> diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
> index d04bb3229c75..7d6f62766251 100644
> --- a/include/rv/da_monitor.h
> +++ b/include/rv/da_monitor.h
> @@ -433,18 +433,6 @@ static inline da_id_type da_get_id(struct da_monitor
> *da_mon)
> =C2=A0 return container_of(da_mon, struct da_monitor_storage, rv.da_mon)-=
>id;
> =C2=A0}
> =C2=A0
> -/*
> - * da_create_or_get - create the per-object storage if not already there
> - *
> - * This needs a lookup so should be guarded by RCU, the condition is che=
cked
> - * directly in da_create_storage()
> - */
> -static inline void da_create_or_get(da_id_type id, monitor_target target=
)
> -{
> - guard(rcu)();
> - da_create_storage(id, target, da_get_monitor(id, target));
> -}
> -
> =C2=A0/*
> =C2=A0 * da_fill_empty_storage - store the target in a pre-allocated stor=
age
> =C2=A0 *
> @@ -475,15 +463,121 @@ static inline monitor_target
> da_get_target_by_id(da_id_type id)
> =C2=A0 return mon_storage->target;
> =C2=A0}
> =C2=A0
> +/*
> + * Per-object pool state.
> + *
> + * Zero-initialised by default (storage =3D=3D NULL =E2=9F=B9 kmalloc mo=
de).=C2=A0 A monitor
> + * opts into pool mode by calling da_monitor_init_prealloc(N) instead of
> + * da_monitor_init(), which sets storage to a non-NULL kcalloc'd array.
> + *
> + * Because every field is wrapped in this struct and the struct itself i=
s a
> + * per-TU static, each monitor that includes this header gets a complete=
ly
> + * independent pool.=C2=A0 A kmalloc monitor (e.g. nomiss) and a pool mo=
nitor
> + * (e.g. tlob) therefore coexist without any interference.
> + *
> + * da_pool_return_cb runs from softirq on non-PREEMPT_RT, so irqsave is
> + * required to prevent deadlock with task-context callers.=C2=A0 On PREE=
MPT_RT
> + * it runs from an rcuc kthread where spinlock_t is a sleeping lock.
> + */
> +struct da_per_obj_pool {
> + struct da_monitor_storage=C2=A0 *storage;=C2=A0 /* non-NULL =E2=9F=B9 p=
ool mode */
> + struct da_monitor_storage **free;=C2=A0=C2=A0=C2=A0=C2=A0 /* kmalloc'd =
pointer stack */
> + unsigned int=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 free_top;
> + spinlock_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lock;
> +};
> +
> +static struct da_per_obj_pool da_pool =3D {
> + .lock =3D __SPIN_LOCK_UNLOCKED(da_pool.lock),
> +};
> +
> +static void da_pool_return_cb(struct rcu_head *head)
> +{
> + struct da_monitor_storage *ms =3D
> + container_of(head, struct da_monitor_storage, rcu);
> + unsigned long flags;
> +
> + spin_lock_irqsave(&da_pool.lock, flags);
> + da_pool.free[da_pool.free_top++] =3D ms;
> + spin_unlock_irqrestore(&da_pool.lock, flags);
> +}
> +
> +/* Pops a slot from the pre-allocated pool; returns -ENOSPC if exhausted=
. */
> +static inline int da_create_or_get_pool(da_id_type id, monitor_target ta=
rget)
> +{
> + struct da_monitor_storage *mon_storage;
> + unsigned long flags;
> +
> + spin_lock_irqsave(&da_pool.lock, flags);
> + if (!da_pool.free_top) {
> + spin_unlock_irqrestore(&da_pool.lock, flags);
> + return -ENOSPC;
> + }
> + mon_storage =3D da_pool.free[--da_pool.free_top];
> + spin_unlock_irqrestore(&da_pool.lock, flags);
> +
> + mon_storage->id =3D id;
> + mon_storage->target =3D target;
> + guard(rcu)();
> + hash_add_rcu(da_monitor_ht, &mon_storage->node, id);
> + return 0;
> +}
> +
> +/*
> + * Tries da_create_storage() first (lock-free via kmalloc_nolock); falls=
 back
> + * to kmalloc(GFP_KERNEL).=C2=A0 Must be called from task context.
> + */
> +static inline int da_create_or_get_kmalloc(da_id_type id, monitor_target
> target)
> +{
> + struct da_monitor_storage *mon_storage;
> +
> + scoped_guard(rcu) {
> + if (da_create_storage(id, target, da_get_monitor(id, target)))
> + return 0;
> + }
> +
> + /*
> + * da_create_storage() failed because kmalloc_nolock() returned NULL.
> + * Allocate with GFP_KERNEL outside the RCU read section: GFP_KERNEL
> + * may sleep for memory reclaim, which is illegal while the RCU read
> + * lock is held (preemption disabled on !PREEMPT_RT).
> + */
> + mon_storage =3D kmalloc_obj(*mon_storage, GFP_KERNEL | __GFP_ZERO);
> + if (!mon_storage)
> + return -ENOMEM;
> + mon_storage->id =3D id;
> + mon_storage->target =3D target;
> +
> + /*
> + * Re-check for a concurrent insertion before linking: another
> + * caller may have succeeded while we slept in kmalloc().
> + * Discard our allocation and let the winner's entry stand.
> + */
> + scoped_guard(rcu) {
> + if (da_get_monitor(id, target)) {
> + kfree(mon_storage);
> + return 0;
> + }
> + hash_add_rcu(da_monitor_ht, &mon_storage->node, id);
> + }
> + return 0;
> +}
> +
> +/* Create the per-object storage if not already there. */
> +static inline int da_create_or_get(da_id_type id, monitor_target target)
> +{
> + if (da_pool.storage)
> + return da_create_or_get_pool(id, target);
> + return da_create_or_get_kmalloc(id, target);
> +}
> +
> =C2=A0/*
> =C2=A0 * da_destroy_storage - destroy the per-object storage
> =C2=A0 *
> - * The caller is responsible to synchronise writers, either with locks o=
r
> - * implicitly. For instance, if da_destroy_storage is called at sched_ex=
it
> and
> - * da_create_storage can never occur after that, it's safe to call this
> without
> - * locks.
> - * This function includes an RCU read-side critical section to synchroni=
se
> - * against da_monitor_destroy().
> + * Pool mode: removes from hash and returns the slot via call_rcu().
> + * Kmalloc mode: removes from hash and frees via kfree_rcu().
> + *
> + * Includes an RCU read-side critical section to synchronise against
> + * da_monitor_destroy().
> =C2=A0 */
> =C2=A0static inline void da_destroy_storage(da_id_type id)
> =C2=A0{
> @@ -491,15 +585,17 @@ static inline void da_destroy_storage(da_id_type id=
)
> =C2=A0
> =C2=A0 guard(rcu)();
> =C2=A0 mon_storage =3D __da_get_mon_storage(id);
> -
> =C2=A0 if (!mon_storage)
> =C2=A0 return;
> =C2=A0 da_monitor_reset_hook(&mon_storage->rv.da_mon);
> =C2=A0 hash_del_rcu(&mon_storage->node);
> - kfree_rcu(mon_storage, rcu);
> + if (da_pool.storage)
> + call_rcu(&mon_storage->rcu, da_pool_return_cb);
> + else
> + kfree_rcu(mon_storage, rcu);
> =C2=A0}
> =C2=A0
> -static void da_monitor_reset_all(void)
> +static __maybe_unused void da_monitor_reset_all(void)
> =C2=A0{
> =C2=A0 struct da_monitor_storage *mon_storage;
> =C2=A0 int bkt;
> @@ -510,13 +606,65 @@ static void da_monitor_reset_all(void)
> =C2=A0 rcu_read_unlock();
> =C2=A0}
> =C2=A0
> +/*
> + * da_monitor_init_prealloc - initialise with a pre-allocated storage po=
ol
> + *
> + * Allocates @prealloc_count storage slots up-front so that
> da_create_or_get()
> + * and da_destroy_storage() never call kmalloc/kfree.=C2=A0 Must be call=
ed instead
> + * of da_monitor_init() for monitors that require pool mode.
> + */
> +static inline int da_monitor_init_prealloc(unsigned int prealloc_count)
> +{
> + hash_init(da_monitor_ht);
> +
> + da_pool.storage =3D kcalloc(prealloc_count, sizeof(*da_pool.storage),
> + =C2=A0 GFP_KERNEL);
> + if (!da_pool.storage)
> + return -ENOMEM;
> +
> + da_pool.free =3D kmalloc_array(prealloc_count, sizeof(*da_pool.free),
> + =C2=A0=C2=A0=C2=A0=C2=A0 GFP_KERNEL);
> + if (!da_pool.free) {
> + kfree(da_pool.storage);
> + da_pool.storage =3D NULL;
> + return -ENOMEM;
> + }
> +
> + da_pool.free_top =3D 0;
> + for (unsigned int i =3D 0; i < prealloc_count; i++)
> + da_pool.free[da_pool.free_top++] =3D &da_pool.storage[i];
> + return 0;
> +}
> +
> +/*
> + * da_monitor_init - initialise in kmalloc mode (no pre-allocation)
> + */
> =C2=A0static inline int da_monitor_init(void)
> =C2=A0{
> =C2=A0 hash_init(da_monitor_ht);
> =C2=A0 return 0;
> =C2=A0}
> =C2=A0
> -static inline void da_monitor_destroy(void)
> +static inline void da_monitor_destroy_pool(void)
> +{
> + WARN_ON_ONCE(!hash_empty(da_monitor_ht));
> + /*
> + * Wait for all in-flight da_pool_return_cb() callbacks to
> + * complete before freeing da_pool.free.=C2=A0 synchronize_rcu() is
> + * not sufficient: it only waits for callbacks registered before
> + * it was called, but call_rcu() from concurrent da_destroy_storage()
> + * calls may have been enqueued later.=C2=A0 rcu_barrier() drains every
> + * pending callback.
> + */
> + rcu_barrier();
> + kfree(da_pool.storage);
> + da_pool.storage =3D NULL;
> + kfree(da_pool.free);
> + da_pool.free =3D NULL;
> + da_pool.free_top =3D 0;
> +}
> +
> +static inline void da_monitor_destroy_kmalloc(void)
> =C2=A0{
> =C2=A0 struct da_monitor_storage *mon_storage;
> =C2=A0 struct hlist_node *tmp;
> @@ -534,6 +682,22 @@ static inline void da_monitor_destroy(void)
> =C2=A0 }
> =C2=A0}
> =C2=A0
> +/*
> + * da_monitor_destroy - tear down the per-object monitor
> + *
> + * Pool mode: the hash must already be empty (caller must have drained a=
ll
> + * tasks first); calls rcu_barrier() to drain all pending da_pool_return=
_cb()
> + * callbacks before freeing pool arrays.
> + * Kmalloc mode: drains any remaining entries after synchronize_rcu().
> + */
> +static inline void da_monitor_destroy(void)
> +{
> + if (da_pool.storage)
> + da_monitor_destroy_pool();
> + else
> + da_monitor_destroy_kmalloc();
> +}
> +
> =C2=A0/*
> =C2=A0 * Allow the per-object monitors to run allocation manually, necess=
ary if the
> =C2=A0 * start condition is in a context problematic for allocation (e.g.
> scheduling).

