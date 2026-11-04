Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793751169;
	b=A5yuw144KcSbu5Luj3MjjRlprwQsmQnQ88y77LgljVc9Hv+DvKXGMUONRbCcuuFlIDSZ
	 PawkWFdu8R/9FvgEJ6rRu9HJI1phzsOX4AuuHycjG/+YpnIrlhWW7ejuE0FjWrgpzEAbk
	 8dp1ldfsEAtYkxQowHnHT2QfpqLIr3YbNGL4SbSBDSCpVsJiFAvB2dev7OYwK/gRTpPPE
	 yB3fqCN18dry+0VWsAbGE1N5WN29PpwP64fHWpVGm1yWyabJdfNKJta9jP2Bb2CqLZAht
	 OvgRYYGx6AAfkHhNzV3vLT/F23W4FQE6MaprJ9WL/74ZDC7WoUeJyirkHLNJONsANsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793751169;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WungCBcVsLr6W2N8V26tJpvl38GWQ8cxeRedqfrVCmo=;
	b=xfynVGH0pnxXBJWrESU/p55w5vFSr1Orxcbv1M6l8Ryz4eCE/c6kPvfY2hVuHvr/UlWy
	 qlCwW0xcyJYcDdEE1X2psooNVN11vJSo0C1xTmW+erqIKmDHYosn7S/l6g8H+aPqSRhzt
	 60o35vjvwbgmsxbnPE731IuXk+ITqlyf3mft8imNvj25J0umOIQ+dQ21A6tP69kvyoFO4
	 x6A2BDLHq1GC39YdwWs17nMrRqd9Up8YNnRK3z9fQM0Wc1wvb8Jp9pud+9uWZmL76V6S3
	 JEa+UVabLKwFQhbjq9oodQfh3DwLB4PvQ0Rd9qHXnLmdogYXzrVmOAX2ybOgpc+PF8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k08JJQp7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9C8606A31B
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Nov 2026 00:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k08JJQp7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9DE11F000C1;
	Wed,  4 Nov 2026 00:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793751169;
	bh=WungCBcVsLr6W2N8V26tJpvl38GWQ8cxeRedqfrVCmo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k08JJQp79BWX+lPw0juBs0jXnyohZzfWLjYe5MkuXg5SBr9698TLFlh0hOPIZIZT5
	 5L/Z0sXvBsELJo9H6HhkhdftHnYmWpR/6h1EoTxJa7irBHykLlQc5s0zzBD1aBHUXs
	 abmIs4M2PmSxPGrXLPUHTmLBTHaGcZliczKAAGtGq4N/aJvOQxUIeYT8lNIJtZ/hOM
	 oATpZ0f8F0lM4x2W1FtYh9W4HQGV9jX4Na1Poc2BK40tJdbVVayr1dLsNZ6CcQ+JHj
	 Q8xbfkTp2RtxbCCxkrWkwYJeH2c235FHZ3V655XWx4KKTELT9l69iOoFmvV35r05ui
	 GhYwI7zrxsgWA==
Message-ID: <sashiko-outbox-196290@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/8] kprobes: Do not overwrite jump instruction when
 re-arming unoptimizing probe
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <179375035312.247640.1506834064717441186.stgit@devnote2>
References: <179375029807.247640.13024754173032838618.stgit@devnote2>
 <179375035312.247640.1506834064717441186.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 00:12:48 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] kprobes: unoptimize_kprobe() unhashes reused aggrprobe with post_h=
andler
--

commit 9db5fa1da3716f288258348f174e01fe00a6f383
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

kprobes: Do not overwrite jump instruction when re-arming unoptimizing probe

This commit avoids calling arch_arm_kprobe() in __arm_kprobe() when a
probe is queued for unoptimization so that the existing jump instruction
is not overwritten with a software breakpoint. It also stops
reuse_unused_kprobe() from clearing KPROBE_FLAG_DISABLED or calling
optimize_kprobe() early, deferring arming and optimization to
register_aggr_kprobe().

> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index ceacd56245c24..0ef3a8701edad 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1059,19 +1059,11 @@ static int reuse_unused_kprobe(struct kprobe *ap)
>  {
>  	struct optimized_kprobe *op;
> =20
> -	/*
> -	 * Unused kprobe MUST be on the way of delayed unoptimizing (means
> -	 * there is still a relative jump) and disabled.
> -	 */
>  	op =3D container_of(ap, struct optimized_kprobe, kp);
>  	WARN_ON_ONCE(list_empty(&op->list));
> -	/* Enable the probe again */
> -	ap->flags &=3D ~KPROBE_FLAG_DISABLED;
> -	/* Optimize it again. (remove from 'op->list') */
>  	if (!kprobe_optready(ap))
>  		return -EINVAL;
> =20
> -	optimize_kprobe(ap);
>  	return 0;
>  }

[Severity: High]
Can leaving KPROBE_FLAG_DISABLED set and op->list queued here cause
unoptimize_kprobe() to unhash ap from kprobe_table when reusing an unused
aggrprobe for a new kprobe with a post_handler?

In kernel/kprobes.c, register_aggr_kprobe() calls reuse_unused_kprobe(ap)
and then calls add_new_kprobe(ap, p) before clearing KPROBE_FLAG_DISABLED:

register_aggr_kprobe(ap, p)
  if (kprobe_unused(ap)) {
      ret =3D reuse_unused_kprobe(ap);
      ...
  }
  ...
  add_new_kprobe(ap, p);
  if (kprobe_disabled(ap) && !kprobe_disabled(p)) {
      ap->flags &=3D ~KPROBE_FLAG_DISABLED;
      if (!kprobes_all_disarmed)
          ret =3D arm_kprobe(ap);
  }

Inside add_new_kprobe(), if p->post_handler is set, it calls
unoptimize_kprobe(ap, true) before adding p to ap->list:

static void add_new_kprobe(struct kprobe *ap, struct kprobe *p)
{
	if (p->post_handler)
		unoptimize_kprobe(ap, true);	/* Fall back to normal kprobe */

	list_add_rcu(&p->list, &ap->list);
}

Because KPROBE_FLAG_DISABLED is still set on ap, ap->list is still empty,
and op->list is still on unoptimizing_list (or cooling_list),
kprobe_unused(&op->kp) evaluates to true inside unoptimize_kprobe(ap, true):

	if (!list_empty(&op->list)) {
		if (optprobe_queued_unopt(op)) {
			if (force) {
				force_unoptimize_kprobe(op);
				if (kprobe_unused(&op->kp)) {
					if (!kprobe_gone(&op->kp))
						arch_disarm_kprobe(&op->kp);
					hlist_del_init_rcu(&op->kp.hlist);
					list_move(&op->list, &cur->freeing_list);
				} else {
					list_move(&op->list, &cur->cooling_list);
				}
				kick_kprobe_optimizer();
			}
		} else if (optprobe_queued_cooling(op)) {
			if (force && kprobe_unused(&op->kp)) {
				if (!kprobe_gone(&op->kp))
					arch_disarm_kprobe(&op->kp);
				hlist_del_init_rcu(&op->kp.hlist);
				list_move(&op->list, &cur->freeing_list);
				kick_kprobe_optimizer();
			}
		}

It looks like unoptimize_kprobe() will delete ap from kprobe_table via
hlist_del_init_rcu(&op->kp.hlist) and move op->list to cur->freeing_list.
Immediately after, add_new_kprobe() links p onto ap->list and
register_aggr_kprobe() clears KPROBE_FLAG_DISABLED and calls arm_kprobe(ap),
which writes a software breakpoint at ap->addr for a probe that is no longer
in kprobe_table, leading to an unhandled breakpoint trap when ap->addr is
executed and a warning in do_free_cleaned_kprobes().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179375029807.247640=
.13024754173032838618.stgit@devnote2?part=3D6
