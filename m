Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793751096;
	b=GgXcqtUMOr8ePRP20KoVrXioCOkqIvqVKRVXe+1bjZQE2r2r57ND1t1pq79hY/CoTGNH
	 6HnNvFPTh5WPPq9qViKjonsul5v9cVrl1zrHMz9jDIIzBTUeA96t8/ojBB3Bpkctwhi4t
	 g+NAkz+KSZULqnsPK1v+ArQ8SAPC9Mk3zgWNZ9hXT4qG6P+a/SiKfEi/FSmC0TcsyaPfh
	 sFDGESq3r3G2HQmUjG2SKwp477NM1Ew5T3d5zFvzktBc7ExRPOzZt+EfGwvg6LcS1yO+B
	 2X9+w0X1Ehe34HcYE6xiPojBagJX0CIAg07GyN4hapxmAQ2fUaEWJudALcjv7F3Cf2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793751096;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pw92iIg2DB7z6uRR4STU70B5VWO8DJd0BxVcHbTrbfU=;
	b=mS2z7cSsI5Ry/QOFVJHskQz8mooQ4o3AXPtNWEugX/Lqj0zy1z37i4ef2NtwN8UizR2N
	 jNITRxp1IX0ljDEceLjL2qZz4QdJB7NGNjp3U/H4BxLL1jsigAKWun6Yy8cXETQ8khfcN
	 Iq+cenpxgLrfhukFqE2osyrwUlQmJC01xiD32DBsGw5Le4OUkaF3DjHPcDocht4QBBuX1
	 b5p/tcRQ0Va7R6Ju25ke4iCdyjwMaQ8eoELz4wgQoexcQaX5vC39WXf+NT+iewd93ZZWG
	 brlVke2s2Ad51PJ6LSCv7fUDf/mQAN2XZ0EoB5khxcGlaWBp6LDanmb+v8175eTWpOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dcx7XAId;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5465D606A31B
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Nov 2026 00:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dcx7XAId
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD6D1F000C1;
	Wed,  4 Nov 2026 00:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793751096;
	bh=pw92iIg2DB7z6uRR4STU70B5VWO8DJd0BxVcHbTrbfU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dcx7XAIdrW3Cw2NfJpAO9625PzIqGK5lIsC+MP3VRXhgqbL34MIu3NTlTRibcH/Np
	 cZ/wfXH0FfVH0mBuYcjSWdkSBn4uBVxoSwb/Sdce+Fl/VJiUXqlMJ29QHiLeKvAr9x
	 Ntsyu/5AT3pe4EOCtyJrY+SIQOKoZyltdQl3XeM73ZHoRP/I0lRYhASYJoqwVDl+oA
	 q/q8DoB7qioUTokM3svMZ1Ni3TWPAqsUfVxuXJct+phqyWM7aySsJvGsa2GUdDQabt
	 DH4LMwj2N137glkljq1sYkEmTp2B1zpBhiRUjKKJAuo9Rfe5HgMZj8954Pmxrgrgzz
	 CR8ql4Hh2f/GQ==
Message-ID: <sashiko-outbox-196280@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/8] kprobes: Switch ftrace ops when adding probe with
 post_handler
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <179375033462.247640.15676311043239442590.stgit@devnote2>
References: <179375029807.247640.13024754173032838618.stgit@devnote2>
 <179375033462.247640.15676311043239442590.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 00:11:35 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] kprobes: premature kprobe publication onto ap->list in register_ag=
gr_kprobe()
- [High] kprobes: unchecked rollback arm_kprobe_ftrace() in register_aggr_k=
probe()
--

commit 90db6f90ad3cb02409cec15b4dabeb1b192665e6
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

kprobes: Switch ftrace ops when adding probe with post_handler

This commit switches an armed ftrace-based kprobe from kprobe_ftrace_ops to
kprobe_ipmodify_ops in register_aggr_kprobe() when a new kprobe with a
post_handler is added to an aggregated kprobe that previously had no
post_handler. It also restores the ftrace ops registration and counter if
ftrace_set_filter_ip() fails in __disarm_kprobe_ftrace().

> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 0b41d69540ae4..135fec5d49cf5 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c

[ ... ]

> @@ -1654,18 +1657,51 @@ static int register_aggr_kprobe(struct kprobe *or=
ig_p, struct kprobe *p)
>  					| KPROBE_FLAG_DISABLED;
>  		}
> =20
> +		if (p->post_handler && !ap->post_handler) {
> +			reset_post_handler =3D true;
> +			if (kprobe_ftrace(ap) && !kprobes_all_disarmed &&
> +			    !kprobe_disabled(ap))
> +				ftrace_switch_ops =3D true;
> +			else
> +				ap->post_handler =3D aggr_post_handler;
> +		}
> +
>  		/* Copy the insn slot of 'p' to 'ap'. */
>  		copy_kprobe(ap, p);
> -		ret =3D add_new_kprobe(ap, p);
> +		add_new_kprobe(ap, p);
> +	}

[Severity: High]
When ftrace_switch_ops is true in register_aggr_kprobe(), add_new_kprobe(ap=
, p)
publishes p onto ap->list via list_add_rcu() while ap is still armed on
kprobe_ftrace_ops and ap->post_handler is still NULL.

If another CPU hits the probed function before disarm_kprobe_ftrace(ap)
finishes updating the ftrace callsite, kprobe_ftrace_handler() will call
aggr_pre_handler() -> p->pre_handler(), and then skip aggr_post_handler()
because ap->post_handler is NULL:

arch/x86/kernel/kprobes/ftrace.c:kprobe_ftrace_handler() {
	...
	if (!p->pre_handler || !p->pre_handler(p, regs)) {
		if (unlikely(p->post_handler)) {
			instruction_pointer_set(regs, ip + MCOUNT_INSN_SIZE);
			kcb->kprobe_status =3D KPROBE_HIT_SSDONE;
			p->post_handler(p, regs, 0);
		}
	...
}

In addition, p->pre_handler() executes under kprobe_ftrace_ops before
arm_kprobe_ftrace(ap) has verified that kprobe_ipmodify_ops
(FTRACE_OPS_FL_IPMODIFY) does not conflict with an active livepatch. A simi=
lar
window also occurs in the error path below if arm_kprobe_ftrace(ap) fails,
where ap->post_handler is reset to NULL and ap is re-armed on
kprobe_ftrace_ops before list_del_rcu(&p->list) removes p.

Could add_new_kprobe(ap, p) be deferred until after ap has been switched to
kprobe_ipmodify_ops, or could p be removed from ap->list before re-arming ap
on rollback?

> +
> +	if (ftrace_switch_ops) {
> +		/*
> +		 * Must switch ftrace ops outside of text_mutex and cpus_read_lock
> +		 * to prevent deadlocks when ftrace code modification acquires text_mu=
tex.
> +		 */
> +		ret =3D disarm_kprobe_ftrace(ap);
> +		if (ret) {
> +			list_del_rcu(&p->list);
> +			synchronize_rcu();
> +			return ret;
> +		}
> +		ap->post_handler =3D aggr_post_handler;
> +		ret =3D arm_kprobe_ftrace(ap);
> +		if (ret) {
> +			ap->post_handler =3D NULL;
> +			arm_kprobe_ftrace(ap);
> +			list_del_rcu(&p->list);
> +			synchronize_rcu();
> +			return ret;
> +		}
>  	}

[Severity: High]
What happens if the rollback call to arm_kprobe_ftrace(ap) in
register_aggr_kprobe() also fails (for example, with -ENOMEM in
ftrace_set_filter_ip() -> alloc_and_copy_ftrace_hash())?

Because the return value of the rollback arm_kprobe_ftrace(ap) is ignored a=
nd
KPROBE_FLAG_DISABLED is not set on ap->flags, ap remains marked as enabled
even though it is no longer registered in kprobe_ftrace_ops's filter hash.

When the remaining probe on ap is later disabled or unregistered via
unregister_kprobe() -> __unregister_kprobe_top() -> __disable_kprobe(),
__disable_kprobe() sees !kprobe_disabled(orig_p) and calls
disarm_kprobe_ftrace(), which fails with -ENOENT in ftrace_set_filter_ip(),
triggers the WARN_ONCE() in __disarm_kprobe_ftrace(), and aborts
unregistration while leaving the probe hashed in kprobe_table:

kernel/kprobes.c:__disable_kprobe() {
	...
	if (!kprobes_all_disarmed && !kprobe_disabled(orig_p)) {
		ret =3D disarm_kprobe(orig_p, true);
		if (ret) {
			p->flags &=3D ~KPROBE_FLAG_DISABLED;
			return ERR_PTR(ret);
		}
	}
	...
}

Should the rollback path check the return value of arm_kprobe_ftrace(ap) and
set KPROBE_FLAG_DISABLED on ap->flags if re-arming fails?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179375029807.247640=
.13024754173032838618.stgit@devnote2?part=3D4
