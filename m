Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B382E2D9EDC
	for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Jun 2026 09:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781517420; cv=none; b=RO6FyRFqpRtFCXqlmGsR1LhQM8qvuunGZede+aSvBU1ug3i98NatjaXzi/xtP9UhsvCeZHt+tNhmArml6tjSQI21nB4FUKi11y50lvpXzlFbaTzhHLwGafp7GAAr+Z5QXJsEbE4G7ybjfqeNA3ufE6lSwWYt7wmnZKS/pX9AtpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781517420; c=relaxed/simple;
	bh=EX1QBW2Zn0BVDtuCduA9wEF5d0HWmdsgLO05qkdV3HQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U6GWT8DxB85KK0mduZfWu+Igi++OG/TMAzGCB+jcngqh7xxjUvZHRzxNJuv9OE8CG2kGNpSXKwYsKu7U5psmR8OnSlrivbYcOmwfOhdRJ13BXE6GOvp94N6LzSfzzSfmx2N0Sr+JU32tRplnbgn0dV09xMnqW7uRDNJnqZCna9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RigLX31X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RigLX31X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781517417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T/PwRg718kogBMCY/fjDomNjGg31W98QX4Wq2qV0nkI=;
	b=RigLX31XoLLXM/cM0PCmzQUgfdp7dKL2hR3w5uf/txf81PqmHM9ub41xSMKzfuAEVSzMiy
	y116duXEsU4VcoOIaBUvj2wGRwPbCXSOljBzHK0Z8QTs9d+pqLMCOTC6OQYA6yjsZ4J404
	1hvImV8Wsk+dJHkmNqWw4l6DLH4QPKY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-LRyAVpx4NNKAI3YVAmWQZg-1; Mon, 15 Jun 2026 05:56:56 -0400
X-MC-Unique: LRyAVpx4NNKAI3YVAmWQZg-1
X-Mimecast-MFC-AGG-ID: LRyAVpx4NNKAI3YVAmWQZg_1781517415
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490b5d2e394so21152975e9.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Jun 2026 02:56:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781517415; x=1782122215;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hdVZ8Zm6R4iX8++LAiMGKRGC+5n+aNHI7iGhJHzDLTU=;
        b=Dt09suJq0LYsnbd9rRpgHWEHbFipa3mtAqmwseTRT3yYQUzO0bKP7aIP7dKu6BPAui
         dgXG4XNAS0JP+789KYTVTFhRIwiQVhYKfxOkx3Wd5Jfj12PN+TSLwFGXgDWOxWIVaiIj
         XRCnD9cXL1FnOuzzO58YXv5xg7/OErNu86/MRrFZtFGVR9ldqXXavJqW29e8xZK0OUBp
         hKXz3jybTbn3KP8XLs0hldR8Tj9RByqE0FiGGF7yIqRNGEO/6oIaTNkcMgpn+xbzsrqa
         cDO6QoZg5ZBW2qISGGohImt+I38pAVIGy0i6v97gDJsTjcxNmscD+1qqqXArccnBhYxt
         iwaA==
X-Forwarded-Encrypted: i=1; AFNElJ+8i7ep7mqENw3f9bO89/EzwaHihRbi8711Ouwq4RQW0yASh1KoB7hICs3kjJ4wPW3v1KJL5LDBkAFaq1yj2OZ5WHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXeiBCNpJXld7CVk6zaOpCkg2C57/2FYdf8q+oviYMPTBBmMnT
	ZuMJGzcGCTLwXvlfcIx6R01Si4jz/XwQ29DLRWFgue3hFRxQffwUDOk6/1eNxye567OhDIC4Db1
	iQxoKRDsPGQoQewFEicsVslcoK1AuYQow0xX/qJDxZDLbBkhW9GWvnTsMJtCwo7n8LbEfwtHNNq
	yg5wv1SA==
X-Gm-Gg: Acq92OGC4p3zE6WAt5adjNceTuUyQc/wGMuOsPxvzVrvDtPzcU6rO4GTqi1BFjNqxsn
	gx787kElYNFlZguTS1myeFQZ1RX8HYpz4d/hRDV9truAKnAg7RtDmZwjtbP5PJPH2oOOAd+oUNA
	ncp/CDgbMepj/bA+1uP7HplscuzbO+DAsTrn+FfRQUZzbI97wkcQCVJEW9+Vb8Uj7dFupDwL5tk
	nIwYUJgXjN9tIsmS9tK5KTKzFC79Nvko2w/Pspydzh/xlg8e2kjGIojaXIKgr7Jh/ZMwY7tnIFJ
	7q92lNeDVd2ImIBfh0svNij9slPxvXhvong+LDrfHh3DLUR4Kypi0IdAYnPOWBQ6c+UD7gzFcxM
	BO+KNb2vFAcQcDMAbTe8ABcNGgQ==
X-Received: by 2002:a05:600c:5394:b0:492:29a1:98c4 with SMTP id 5b1f17b1804b1-49229a1991emr51447835e9.8.1781517415033;
        Mon, 15 Jun 2026 02:56:55 -0700 (PDT)
X-Received: by 2002:a05:600c:5394:b0:492:29a1:98c4 with SMTP id 5b1f17b1804b1-49229a1991emr51447505e9.8.1781517414624;
        Mon, 15 Jun 2026 02:56:54 -0700 (PDT)
Received: from [192.168.1.167] ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490ea95c51dsm227714945e9.1.2026.06.15.02.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 02:56:54 -0700 (PDT)
Message-ID: <a1d868cc9352b28f7309353a43c6759420b02b2c.camel@redhat.com>
Subject: Re: [PATCH v3 1/9] rv/da: introduce DA_MON_ALLOCATION_STRATEGY
From: Gabriele Monaco <gmonaco@redhat.com>
To: wen.yang@linux.dev
Cc: Steven Rostedt <rostedt@goodmis.org>,
 linux-trace-kernel@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Mon, 15 Jun 2026 11:56:53 +0200
In-Reply-To: <496394879a590b4d7bafdb2f13618d2e30be982f.1780847473.git.wen.yang@linux.dev>
References: <cover.1780847473.git.wen.yang@linux.dev>
	 <496394879a590b4d7bafdb2f13618d2e30be982f.1780847473.git.wen.yang@linux.dev>
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Ck4pTq_6sqI1MKv-httSW35YJWsQsu_ISBWMsjPWbrQ_1781517415
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-06-08 at 00:13 +0800, wen.yang@linux.dev wrote:

> +#ifndef DA_MON_ALLOCATION_STRATEGY
> +# define DA_MON_ALLOCATION_STRATEGY DA_ALLOC_AUTO
> +#endif

I'm not sure the space goes there according to kernel coding style, we
don't use it in this file and clang-format removes it. I'd keep
consistency.

...

> =C2=A0
> +/*
> + * DA_MON_POOL_SIZE must be defined before this header is included

I don't think we need to be this verbose (also, ha_monitor may not even
be included if that's a da_monitor). I would stop at the line above.

> (directly or
> + * transitively via ha_monitor.h) when DA_ALLOC_POOL is selected.=C2=A0
> In practice
> + * this means defining it after the monitor's model header (which
> supplies the
> + * capacity constant) and before the ha_monitor.h include.
> + */

> +#if DA_MON_ALLOCATION_STRATEGY =3D=3D DA_ALLOC_POOL &&
> !defined(DA_MON_POOL_SIZE)
> +# error "DA_ALLOC_POOL requires DA_MON_POOL_SIZE to be defined
> before including this header"

Same here I'd keep consistency and remove the space before error.

> +#endif

...
 =C2=A0
> +/*
> + * Per-object pool state.
> + *
> + * Zero-initialised by default (storage =3D=3D NULL =E2=9F=B9 kmalloc mo=
de).=C2=A0 A

Mmh, =E2=9F=B9  doesn't seem to print that well on my terminal, let's perha=
ps
use plain old ASCII =3D> . Also I don't find what you put in parentheses
to be adding much value, we could even omit it.

I remember discussing about this so I may have missed your answer, but
why don't we handle this pool as a simple kmem_cache/mempool instead of
implementing a similar logic from scratch?

> monitor
> + * opts into pool mode by defining DA_MON_ALLOCATION_STRATEGY
> DA_ALLOC_POOL
> + * and DA_MON_POOL_SIZE before including this header;
> da_monitor_init() then
> + * pre-allocates the pool internally.
> + *
> + * Because every field is wrapped in this struct and the struct
> itself is a
> + * per-TU static, each monitor that includes this header gets a
> completely
> + * independent pool.=C2=A0 A kmalloc monitor (e.g. nomiss) and a pool
> monitor
> + * (e.g. tlob) therefore coexist without any interference.
> + *
> + * da_pool_return_cb runs from softirq (non-PREEMPT_RT) or rcuc
> kthread
> + * (PREEMPT_RT); spin_lock_irqsave handles both.
> + */
> +struct da_per_obj_pool {
> +=09struct da_monitor_storage=C2=A0 *storage;=C2=A0 /* non-NULL =E2=9F=B9=
 pool
> mode */
> +=09struct da_monitor_storage **free;=C2=A0=C2=A0=C2=A0=C2=A0 /* kmalloc'=
d pointer
> stack */
> +=09unsigned int=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 free_top;
> +=09unsigned int=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 capacity; /* total number of
> slots */
> +=09spinlock_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lock;
> +};
> +
> +static struct da_per_obj_pool da_pool =3D {
> +=09.lock =3D __SPIN_LOCK_UNLOCKED(da_pool.lock),
> +};

...

> =C2=A0/*
> =C2=A0 * da_destroy_storage - destroy the per-object storage
> =C2=A0 *
> - * The caller is responsible to synchronise writers, either with
> locks or
> - * implicitly. For instance, if da_destroy_storage is called at
> sched_exit and
> - * da_create_storage can never occur after that, it's safe to call
> this without
> - * locks.
> - * This function includes an RCU read-side critical section to
> synchronise
> - * against da_monitor_destroy().
> + * Pool mode: removes from hash and returns the slot via call_rcu().
> + * Kmalloc mode: removes from hash and frees via kfree_rcu().
> + *
> + * Includes an RCU read-side critical section to synchronise against
> + * da_monitor_destroy().
> =C2=A0 */
> =C2=A0static inline void da_destroy_storage(da_id_type id)
> =C2=A0{
> @@ -558,7 +670,11 @@ static inline void da_destroy_storage(da_id_type
> id)
> =C2=A0=09=09return;
> =C2=A0=09da_monitor_reset_hook(&mon_storage->rv.da_mon);
> =C2=A0=09hash_del_rcu(&mon_storage->node);
> +#if DA_MON_ALLOCATION_STRATEGY =3D=3D DA_ALLOC_POOL
> +=09call_rcu(&mon_storage->rcu, da_pool_return_cb);
> +#else

ifdeffery in functions is discouraged as quite unreadable. Since
DA_MON_ALLOCATION_STRATEGY is guaranteed to be defined, simple C ifs are
going to be mostly equivalent (the compiler will cut instead of the
preprocessor, but still).

> =C2=A0=09kfree_rcu(mon_storage, rcu);
> +#endif
> =C2=A0}

...

> +
> +/*
> + * da_monitor_init - initialise the per-object monitor
> + *
> + * Selects the allocation path at compile time based on
> DA_MON_ALLOCATION_STRATEGY:
> + *=C2=A0=C2=A0 DA_ALLOC_POOL=C2=A0=C2=A0 - pre-allocates DA_MON_POOL_SIZ=
E storage slots.
> + *=C2=A0=C2=A0 DA_ALLOC_AUTO / DA_ALLOC_MANUAL - initialises the hash ta=
ble
> only.
> + */
> =C2=A0static inline int da_monitor_init(void)
> =C2=A0{
> =C2=A0=09hash_init(da_monitor_ht);
> +#if DA_MON_ALLOCATION_STRATEGY =3D=3D DA_ALLOC_POOL
> +=09return __da_monitor_init_pool(DA_MON_POOL_SIZE);
> +#else

Same here, use if()

> =C2=A0=09return 0;
> +#endif
> =C2=A0}
> =C2=A0
> -static inline void da_monitor_destroy(void)
> +static inline void da_monitor_destroy_pool(void)
> +{
> +=09struct da_monitor_storage *ms;
> +=09struct hlist_node *tmp;
> +=09int bkt;
> +
> +=09/*
> +=09 * Ensure all in-flight tracepoint handlers that may hold a
> raw pointer
> +=09 * to a pool slot (e.g. tlob_stop_task after its RCU guard
> exits) have
> +=09 * completed before we begin tearing down the pool.=C2=A0 Mirrors
> the same
> +=09 * call in da_monitor_destroy_kmalloc().
> +=09 */
> +=09tracepoint_synchronize_unregister();
> +

This is common between the pool and kmalloc flavours, you can leave it
in da_monitor_destroy() before branching.

> +=09/*
> +=09 * Drain any entries that were not stopped before destroy
> (e.g.
> +=09 * uprobe-started sessions whose stop probe never fired).=C2=A0
> Call
> +=09 * da_extra_cleanup() before hash_del_rcu() so the hook may
> safely
> +=09 * call ha_cancel_timer_sync() while the monitor is still
> reachable.
> +=09 */
> +=09hash_for_each_safe(da_monitor_ht, bkt, tmp, ms, node) {
> +=09=09da_extra_cleanup(&ms->rv.da_mon);
> +=09=09hash_del_rcu(&ms->node);
> +=09=09call_rcu(&ms->rcu, da_pool_return_cb);
> +=09}

Cannot you make also this common? da_extra_cleanup() should be called in
all flavours and the only difference I see here is the rcu callback.

Also do you really need call_rcu() ? Since we should already have waited
for a grace period, you can probably call the function directly. If not,
I'd still try and make both flavours consistent (sync + free OR call_rcu
+ barrier, not both).

> +
> +=09/*
> +=09 * rcu_barrier() drains every pending call_rcu() callback,
> including
> +=09 * both da_pool_return_cb() and any monitor-specific free
> callbacks
> +=09 * (e.g. tlob_free_rcu) enqueued by da_extra_cleanup().
> +=09 */
> +=09rcu_barrier();
> +=09kfree(da_pool.storage);
> +=09da_pool.storage =3D NULL;
> +=09kfree(da_pool.free);
> +=09da_pool.free =3D NULL;
> +=09da_pool.free_top =3D 0;
> +=09da_pool.capacity =3D 0;

Only this part is really specific to this allocation flavour, if you
want it in a separate function, go ahead, but the rest should probably
share as much code as possible (especially the cleanup/synchronisation
mess we just worked out).

Thanks,
Gabriele

