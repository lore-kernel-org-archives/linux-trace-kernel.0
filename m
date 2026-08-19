Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02DD3C1D44
	for <linux-trace-kernel@vger.kernel.org>; Wed, 19 Aug 2026 18:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787164208; cv=none; b=LT1HbhKpbWsaB8lAEZ3XQk8E/TGrytqBctz0PPKrCCMuhvZS7w/RXhGSGehslJjfhPeSHsNdhrIS2rtbh3+WJhvvUD3s8V9b/VXFGIdecwwxBIwy64TgQiNlk0f4+G2+RFb5mbg5ZDPj7h4vgAEqcUIgBNXfI+rU3zxAyusCW3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787164208; c=relaxed/simple;
	bh=RkgBLzumQmoVG41GSZIIvEVarFMqEuEa9pfmMh5INus=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EmbL7jwOTpqXnXC/b+Fm7rQ/oZPyJ6IYYPCgbFSlJ8NQqyfU/2R1Hlomw1Zy+kOWTpa+nXi65T6AxMccMeidaxs1Rtz5tN0VEarSbZvM7hSniwPfbDlev8t6t7BMF7qjud7/lLxfJ0oXbUGf71Z0AiWPZCuHlnbcSsYzmcwdPAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bvkxl4If; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bvkxl4If"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4324E1F000E9;
	Wed, 19 Aug 2026 18:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787164207;
	bh=TRqu/PaNShjfCPjZQl75KH0XhqSvGdBBAdWfWtj+E8Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bvkxl4If+7l+Z2LPr3Nf22SpAa93p4tR7i/xmetFRD5sRDsYmbLPFBZWgoKgjGaPr
	 /vX7E5qbEhbc4LdD+J3HQ4EZjWM2dfUhRT0pYTC7WN+JpivItS9+ZmRUeM5NJ+rL/T
	 em19fgCQR2CopZpP3X2Su7aMTwvioV+NzEnxl0RzftmwJS8OxtRx2lCILBgaRvEEvB
	 zwHLJvR4u7WIRFV9dFO180yvLy8sSLNmaTRsbinYqlLqX9BgoY+CARNtIMw0PJuYLs
	 LmFKNBKY+nCxkcT0UyvD4M3Vk21P2H5ZNqN9B68IT7vJub9DyidfuBC9SDym2GFXMu
	 1uLWPocBZaFCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/9] rv: Introduce DA_MON_ALLOCATION_STRATEGY
Reply-To: sashiko-reviews@lists.linux.dev
To: wen.yang@linux.dev
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <60632bdb34707ffde64381549f1ce09118bd8f5f.1787161646.git.wen.yang@linux.dev>
References: <cover.1787161646.git.wen.yang@linux.dev>
 <60632bdb34707ffde64381549f1ce09118bd8f5f.1787161646.git.wen.yang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 18:30:06 +0000
Message-Id: <20260819183007.4324E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] DA_ALLOC_POOL strategy causes lockdep 'Invalid wait context' warni=
ngs and crashes on PREEMPT_RT when used in tracepoints that hold raw spinlo=
cks.
--

--- Patch [1]: [PATCH v5 1/9] rv: Introduce DA_MON_ALLOCATION_STRATEGY ---
commit e8961cb4205551f74e01ec6b7818734bafc846f3
Author: Wen Yang <wen.yang@linux.dev>

rv: Introduce DA_MON_ALLOCATION_STRATEGY

This patch introduces a compile-time selection for per-object deterministic
automata (DA) monitor allocation strategies. It adds DA_ALLOC_AUTO,
DA_ALLOC_POOL, and DA_ALLOC_MANUAL to handle contexts where dynamic memory
allocation is problematic.

> diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
> index e3cf85c9ce556..48c534324cbb2 100644
> --- a/include/rv/da_monitor.h
> +++ b/include/rv/da_monitor.h
[ ... ]
> @@ -543,6 +596,59 @@ static inline monitor_target da_get_target_by_id(da_=
id_type id)
>  	return mon_storage->target;
>  }
> =20
> +/*
> + * Pre-allocated mempool for DA_ALLOC_POOL monitors: DA_MON_POOL_SIZE
> + * slots, eager-allocated at init.  mempool_alloc_preallocated() pops a
> + * slot without touching the allocator (bounded start latency; NULL when
> + * exhausted).  mempool_free() is safe from RCU-callback context.
> + * Non-pool monitors get a zero-initialised mempool_t; pool paths compile
> + * away.
> + */
> +static mempool_t da_monitor_pool;
[ ... ]
> +/*
> + * da_create_pool_storage - pop a free pool slot and insert it into the =
hash.
> + *
> + * Returns the new da_monitor, or NULL if the pool is exhausted.  Finding
> + * an existing entry for the same id fires WARN_ON_ONCE (double-start bu=
g).
> + *
> + * Caller must hold an RCU read-side CS and the monitor's serialisation =
lock.
> + */
> +static inline struct da_monitor *
> +da_create_pool_storage(da_id_type id, monitor_target target,
> +		       struct da_monitor *da_mon)
> +{
> +	struct da_monitor_storage *mon_storage, *existing;
> +
> +	if (da_mon)
> +		return da_mon;
> +
> +	mon_storage =3D mempool_alloc_preallocated(&da_monitor_pool);

[Severity: High]
Will this cause an "Invalid wait context" lockdep warning or a kernel panic
on PREEMPT_RT systems when executed from tracepoints holding raw spinlocks?

The patch describes DA_ALLOC_POOL as being useful for contexts problematic
for allocation, such as scheduling. If a monitor uses this pool strategy in
a tracepoint like sched_switch, it will be called while holding a
raw_spinlock_t (like rq->lock).

Looking at mempool_alloc_preallocated(), it unconditionally acquires the
pool lock, which is a spinlock_t. On PREEMPT_RT, spinlock_t maps to a
sleepable rt_mutex. Acquiring a sleeping lock while holding a raw_spinlock_t
is a strict wait-context locking violation.

Is there a way to manage the pre-allocated pool in da_create_pool_storage()
without relying on locks that sleep on PREEMPT_RT?

> +	if (!mon_storage)
> +		return NULL;
> +	memset(mon_storage, 0, sizeof(*mon_storage));
> +
> +	mon_storage->id =3D id;
> +	mon_storage->target =3D target;
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787161646.gi=
t.wen.yang@linux.dev?part=3D1
