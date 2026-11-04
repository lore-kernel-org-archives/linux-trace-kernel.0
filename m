Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793752243;
	b=TWy9PwrNg75i01IxMc+M4GBjykMMRvEvj/6s0WwcuBWUwbpipjt7gjOhAQzXImpYNTA7
	 5IWGGKlGLshV+/pYgaA56gLKwmNy92uBnCJZTKug4HRpRvaoSKU/El9YcWpBHGwSrnKG3
	 i+1fLQvqnz9tTJ/Gga5/TKWYOLimzUcKzMfnhu52jsAdOz8SPCrPx2+LdoV+2V/ipq30h
	 5xK10c1fPBYRZdq1imzIg+Dz9Au1mIk4MsyZqN+LTosCIwAamfZsOnwDb3ywnNJG6+a5d
	 V2gvaPmlAB2PN21THXVLeXvZrIuQrWBDcGFhN1spisfZxm53ZRWR4YlDWS9vSVr4mlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793752243;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RCeuOn3VA6r3DNgyxLUBP/fIvlI2eQ/ebHYcQ7dZ/SE=;
	b=Xpjhdw3+nPvY15vdUux3g71nknBLOajChBUR4QgaKCRvRb5XXEpe+oF596TFHjAkwY7n
	 sG2tp+UhWnjSXKvLDiK88wJGa9Bw29jSf6FHXGRwQ3wGA6bOiGMkvz6WInlG3TcVEsPLO
	 RDnqitY0heT+MbYLlKf9avTHooiJ9MZ9PNcjWzgFao3Rg1sVKDX1wgPPlN0QhJaxoFBGm
	 jtpdUkAfdZVfBBeZHpK/ua2sDNzBWatY3uIPJti2c4X9A5PGC7ZN1ylhOCnObgTQUbzJT
	 RDQ3qIu4cZlYdmqof8w/f8jDGDWU47sim75CC9ayoime1rW3c7wOjFbt14wCKriL+xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Q/YgNV9Q";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239C0606A324
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Nov 2026 00:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q/YgNV9Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A7591F000C1;
	Wed,  4 Nov 2026 00:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793752242;
	bh=RCeuOn3VA6r3DNgyxLUBP/fIvlI2eQ/ebHYcQ7dZ/SE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q/YgNV9QzrQ0pnFP9e7j3CdILzNB59GGiaaKoMS2ShXlNYb5AF3Vq/hJWuwrhasBD
	 WrmXNBZiPfriahB8Q1mhHqKvn9getTwNOz6LzxzIq5DV+9odwBMMwhOaVE8mY1hU3b
	 mymKwqh3QRkycmEMDCbcTrKtFMKGhv5exIk4oYxvu9iBU4mAkcFfhgw7JEnN6WQR9d
	 +1gNsvnUKWlndHAAIQFmKig6gY/iV96O4y00YHbSpm1Cj1cOSpmKosIcBQonZmVZvf
	 VJJKceTJ0mh8O48l4L6uB9VTPrj/tLiq0T1pbd86DtJap/NqhGy8cmQBkTCdoIBZOs
	 S3T928MQVYiQQ==
Message-ID: <sashiko-outbox-196313@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/8] kprobes: Fix slot reclaim and sibling re-opt in
 optprobe state machine
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <179375036234.247640.2681461872008285645.stgit@devnote2>
References: <179375029807.247640.13024754173032838618.stgit@devnote2>
 <179375036234.247640.2681461872008285645.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 00:30:42 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] kprobes: slot leak and stale optinsn reuse via register_aggr_kprob=
e()
- [High] kprobes: missing arch_disarm_kprobe() in unoptimize_kprobe() on fo=
rce
- [High] kprobes: premature unhash of rescued aggrprobe in add_new_kprobe()
--

commit 1b0eca43598590c99ad643a8f10e407a46a7cbcb
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

kprobes: Fix slot reclaim and sibling re-opt in optprobe state machine

This commit moves gone optimized probes with remaining child probes onto the
cooling list in kill_optimized_kprobe() and reclaims their instruction slots
in optprobe_finalize_generation() after Tasks RCU completes. It also
re-optimizes blocked sibling probes in optprobe_finalize_generation() once a
disabled probe finishes cooling.

> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 0ef3a8701edad..53725c09ef9b0 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -725,10 +725,19 @@ static void optprobe_finalize_generation(struct opt=
probe_generation *gen)
>  			list_move(&op->list, &optprobe_gens[optprobe_cur_gen].freeing_list);
>  			kick_kprobe_optimizer();
>  		} else {
> +			struct kprobe *_p;
> +
>  			/* Still in use; now safely disarmed */
>  			list_del_init(&op->list);
> -			if (!kprobe_disabled(&op->kp))
> +			if (kprobe_gone(&op->kp)) {
> +				arch_remove_optimized_kprobe(op);
> +			} else if (!kprobe_disabled(&op->kp)) {
>  				optimize_kprobe(&op->kp);
> +			} else {
> +				_p =3D get_optimized_kprobe(op->kp.addr);
> +				if (unlikely(_p))
> +					optimize_kprobe(_p);
> +			}

[Severity: High]
Can this re-optimize a sibling probe _p while a software breakpoint is still
armed at op->kp.addr?

When an optimized probe is disabled via disable_kprobe(), __disable_kprobe()
calls __disarm_kprobe(), which calls unoptimize_kprobe(p, false) and skips
arch_disarm_kprobe(p) because kprobe_queued_unopt(p) is true. Because the
disabled child probe remains on op->kp.list, kprobe_disabled(&op->kp) is tr=
ue
while kprobe_unused(&op->kp) is false.

If unoptimize_kprobe(&op->kp, true) is then called with force =3D true befo=
re
do_unoptimize_kprobes() runs (for example, when an overlapping probe is arm=
ed
via __arm_kprobe() -> get_optimized_kprobe() -> unoptimize_kprobe(_p, true),
or when a child probe with a post_handler is added), force_unoptimize_kprob=
e()
replaces the jump at op->kp.addr with a software breakpoint. However, unlike
do_unoptimize_kprobes():

kernel/kprobes.c:do_unoptimize_kprobes() {
	...
		if (kprobe_disabled(&op->kp) && !kprobe_gone(&op->kp))
			arch_disarm_kprobe(&op->kp);
	...
}

unoptimize_kprobe() only calls arch_disarm_kprobe(&op->kp) when
kprobe_unused(&op->kp) is true:

kernel/kprobes.c:unoptimize_kprobe() {
	...
				force_unoptimize_kprobe(op);
				if (kprobe_unused(&op->kp)) {
					if (!kprobe_gone(&op->kp))
						arch_disarm_kprobe(&op->kp);
					hlist_del_init_rcu(&op->kp.hlist);
					list_move(&op->list, &cur->freeing_list);
				} else {
					list_move(&op->list, &cur->cooling_list);
				}
	...
}

When optprobe_finalize_generation() finishes cooling op and runs this else
branch, op->list is emptied (making kprobe_disarmed(&op->kp) true) and
optimize_kprobe(_p) is called on the overlapping probe while the breakpoint=
 at
op->kp.addr is still armed in kernel text. Wouldn't arch_optimize_kprobes()
then copy the undisarmed breakpoint instruction into _p->optinsn.copied_ins=
n,
and leave an orphaned breakpoint in kernel text if op is later unregistered?

[Severity: High]
In the same optprobe state machine, what happens when an unused aggregator
probe on unoptimizing_list or cooling_list is rescued by
register_aggr_kprobe() for a new kprobe p that has a post_handler?

In commit 9db5fa1da371 ("kprobes: Do not overwrite jump instruction when
re-arming unoptimizing probe"), reuse_unused_kprobe() was changed to leave
KPROBE_FLAG_DISABLED set on ap and leave op on unoptimizing_list or
cooling_list:

kernel/kprobes.c:reuse_unused_kprobe() {
	struct optimized_kprobe *op;

	op =3D container_of(ap, struct optimized_kprobe, kp);
	WARN_ON_ONCE(list_empty(&op->list));
	if (!kprobe_optready(ap))
		return -EINVAL;

	return 0;
}

register_aggr_kprobe() then calls add_new_kprobe(ap, p), which calls
unoptimize_kprobe(ap, true) before adding p->list to ap->list:

kernel/kprobes.c:add_new_kprobe() {
	if (p->post_handler)
		unoptimize_kprobe(ap, true);	/* Fall back to normal kprobe */

	list_add_rcu(&p->list, &ap->list);
}

Because ap->list is still empty and KPROBE_FLAG_DISABLED is still set when
unoptimize_kprobe(ap, true) runs, kprobe_unused(&op->kp) evaluates to true =
in
both the optprobe_queued_unopt(op) and optprobe_queued_cooling(op) branches=
 of
unoptimize_kprobe(). Doesn't unoptimize_kprobe(ap, true) then unhash
op->kp.hlist from kprobe_table and move op->list to cur->freeing_list right
before register_aggr_kprobe() arms a breakpoint at ap->addr for the unhashed
probe?

>  		}
>  	}
> =20
> @@ -1084,13 +1093,20 @@ static void kill_optimized_kprobe(struct kprobe *=
p)
>  				list_del_init(&op->list);
>  			}
>  		} else {
> -			list_del_init(&op->list);
> +			if (optprobe_queued_unopt(op)) {
> +				/* Move to cooling list so optinsn slot is cooled down */
> +				list_move(&op->list,
> +					  &optprobe_gens[optprobe_cur_gen].cooling_list);
> +				kick_kprobe_optimizer();
> +			} else if (!optprobe_queued_cooling(op) && !optprobe_queued_freeing(o=
p)) {
> +				list_del_init(&op->list);
> +			}
>  		}
>  	}
>  	op->kp.flags &=3D ~KPROBE_FLAG_OPTIMIZED;
> =20
>  	/*
> -	 * Don't remove the slot if it is queued for freeing or unoptimization;
> +	 * Don't remove the slot if it is queued for freeing, unoptimization, o=
r cooling;
>  	 * the optimizer will reclaim it after the quiescence period.
>  	 */
>  	if (!optprobe_queued_freeing(op) && !optprobe_queued_unopt(op) &&

[Severity: High]
Does deferring arch_remove_optimized_kprobe(op) here leak op->optinsn.insn =
or
reuse a stale optinsn trampoline if a new kprobe is registered at the same
virtual address before cooling completes?

When kill_kprobe() runs on a probe that still has child probes on p->list
(!kprobe_unused(p)) while op is on unoptimizing_list or cooling_list,
kill_optimized_kprobe() now leaves op on cooling_list with op->optinsn.insn
allocated, while ap (&op->kp) remains hashed in kprobe_table with
KPROBE_FLAG_GONE set.

If a module is loaded at the same virtual address and a new kprobe is
registered at ap->addr before optprobe_finalize_generation() runs,
__register_kprobe() finds ap in kprobe_table and calls
register_aggr_kprobe():

kernel/kprobes.c:register_aggr_kprobe() {
	...
		if (kprobe_gone(ap)) {
			ret =3D arch_prepare_kprobe(ap);
			if (ret)
				return ret;

			/* Prepare optimized instructions if possible. */
			prepare_optimized_kprobe(ap);

			ap->flags =3D (ap->flags & ~KPROBE_FLAG_GONE)
					| KPROBE_FLAG_DISABLED;
		}
	...
}

Because register_aggr_kprobe() assumes the old instruction slots were alrea=
dy
freed by kill_kprobe(), it calls prepare_optimized_kprobe(ap) ->
arch_prepare_optimized_kprobe(op, ap) and clears KPROBE_FLAG_GONE:

1. If arch_prepare_optimized_kprobe() allocates a new slot, it overwrites
   op->optinsn.insn without freeing the in-flight cooling slot, leaking the
   old optinsn slot (and since KPROBE_FLAG_GONE is cleared,
   optprobe_finalize_generation() will not reclaim it either).

2. If arch_prepare_optimized_kprobe() fails before writing op->optinsn.insn
   (for example, when can_optimize() rejects the new function at ap->addr),
   op->optinsn.insn still points to the old unloaded module's optinsn slot.
   Once register_aggr_kprobe() clears KPROBE_FLAG_GONE and arms ap, won't
   optprobe_finalize_generation() see !kprobe_gone(&op->kp) and
   !kprobe_disabled(&op->kp), and call optimize_kprobe(&op->kp) using the
   stale optinsn trampoline from the unloaded module?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179375029807.247640=
.13024754173032838618.stgit@devnote2?part=3D7
