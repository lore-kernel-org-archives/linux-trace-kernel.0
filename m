Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793733167;
	b=M25kjnUdSLGbzbmDpQc56z5V2c1NlsyEkaVxs/Lc9VxPsxoM6/YPmqUzqFl9SfHk5pul
	 PJ3huMlv0WmquLDjnFDxpCVCP5kjowrnxl0FO+fHVTvOJzJJFjFFN8w0kX08au4tyFdAX
	 WRo3wWsv9VLx9tdaaoUag83zFVe8+k09DCCobN8d8jSTMurCfiCNrkJZu0xg/1Se47GX8
	 3rAFvHq+NqUdpzd4pPKqLWJvHHSpo3Wb2bKxc10Rir8e1H0zrcE3CmhXru9PFo5F6FjOr
	 DVhctkcivLSU7x3x5IJcs2rWllJfxTN06h19htxVG684YNw8R7TORhPrTVQYlQNOMUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793733167;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5Yq5VvxEmv53ds/rIgb2dzacOIX5pqmv6SRkWQjU/1E=;
	b=4tuf3/wbR/48Pyo7BsBI+4uRKItw8hjYUV856vSVjhi4FdNVUq+SO9HvFQNP25Z2Rwv4
	 r+JNNEHYLhL5iAzzAXj3jf/KaLujC1iYNvSg7BS1CfonDFN7BWAjpnyoZ5qdp9vfXBKg6
	 zcdvMfgBgvWdY8YYpgvJmbnIO9EfnLU5+JH59D35kPu/8vt1KKrOS1AbUa7nHimeF3ERg
	 tLMcvfhaCZBdjRT0UcSYKnlLvQBXt3l/e/+0To6xb6ReuAIFUHjD/9TYyxeFIaSx3jOXI
	 scKi1cMTvKuVmO7b+RGuIN7sL1CNgh6YkaGsqn8D9lppVit0gtQLXiTe9KaC4CpvE5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LaWkXRzz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C26E606A31B
	for <linux-trace-kernel@vger.kernel.org>; Tue,  3 Nov 2026 19:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LaWkXRzz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B57371F000C1;
	Tue,  3 Nov 2026 19:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793733166;
	bh=5Yq5VvxEmv53ds/rIgb2dzacOIX5pqmv6SRkWQjU/1E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LaWkXRzzwzI43j0PoPIUUUAqzTrBhl/moZYMVtgbdu4k5fBc4SOLokAXuSbDsfUW2
	 BJ3gVDDEK7TL8Y9cOD0v9rmruMo18Yl9r3+VzyC02fbKB6SSNpFA8APzwQby5rRjXL
	 04IWuEXHeA+MsPdswsWYb+Ov8oN4IujD5PkmSm8ybVHkiWGkzydq72zGarvYVtKKfV
	 7LIpl7FWYxsepTLOg6LiAzawk+kyWbplg8QjDGlzvJR/9yMWhki8m4Fh/shT8UosqO
	 gk2wVTPeI/aGmRmGXbGMiljRgbe9wjeHdWPjtNX+DZeQH9k/m4HDlfOyqY35SCu0Ma
	 HZkdiWCFz9HWw==
Message-ID: <sashiko-outbox-195906@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] kprobes: Arm reused optprobe on cooling list
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mani Tofigh" <mt4022@columbia.edu>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261103-kprobes-optprobe-state-v1-3-6aaac612abe6@columbia.edu>
References: <20261103-kprobes-optprobe-state-v1-0-6aaac612abe6@columbia.edu>
 <20261103-kprobes-optprobe-state-v1-3-6aaac612abe6@columbia.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 19:12:46 +0000
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
- [High] kprobes: reuse_unused_kprobe() arms cooling probe when new probe i=
s disabled
--

commit c03ba118d217fb856e6a911233d52037e4e98250
Author: Mani Tofigh <mt4022@columbia.edu>

kprobes: Arm reused optprobe on cooling list

This commit arms an unused aggregator kprobe in reuse_unused_kprobe() when
it is still on an optprobe cooling list so that a newly registered probe
at the same address will fire before optimization finishes.

> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 84a5f68476eb1..59c5689299ce3 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c

[ ... ]

> @@ -1067,6 +1068,13 @@ static int reuse_unused_kprobe(struct kprobe *ap)
>  	if (!kprobe_optready(ap))
>  		return -EINVAL;
> =20
> +	if (optprobe_queued_cooling(op)) {
> +		/* Already disarmed. It will be optimized again upon finalize */
> +		if (!kprobes_all_disarmed)
> +			__arm_kprobe(ap);
> +		return 0;
> +	}

[Severity: High]
What happens here if the newly registered kprobe has KPROBE_FLAG_DISABLED
set, such as when __register_trace_kprobe() registers a new tracefs
kprobe_events entry before enabling it?

In __register_kprobe() -> register_aggr_kprobe(), reuse_unused_kprobe(ap)
is called before checking whether the new probe p is disabled:

kernel/kprobes.c:register_aggr_kprobe() {
	...
		} else if (kprobe_unused(ap)) {
			/* This probe is going to die. Rescue it */
			ret =3D reuse_unused_kprobe(ap);
			if (ret)
				return ret;
		}
	...
	if (ret =3D=3D 0 && kprobe_disabled(ap) && !kprobe_disabled(p)) {
		ap->flags &=3D ~KPROBE_FLAG_DISABLED;
		if (!kprobes_all_disarmed) {
			/* Arm the breakpoint again. */
			ret =3D arm_kprobe(ap);
	...
}

Because reuse_unused_kprobe(ap) unconditionally clears KPROBE_FLAG_DISABLED
on ap and calls __arm_kprobe(ap) when op is on a cooling_list, it bypasses
the !kprobe_disabled(p) check in register_aggr_kprobe(). This arms a
breakpoint in kernel text (and later jump-optimizes ap in
optprobe_finalize_generation()) even though all child probes on ap->list
are disabled.

Furthermore, if the disabled child probe p is later unregistered without
ever being enabled, __unregister_kprobe_top() calls __disable_kprobe(p),
which sees kprobe_disabled(p) and returns early without setting
KPROBE_FLAG_DISABLED on ap or disarming it:

kernel/kprobes.c:__disable_kprobe() {
	...
	if (kprobe_disabled(p))
		return orig_p;
	...
}

Then in __unregister_kprobe_top(), kprobe_disarmed(ap) is false because
KPROBE_FLAG_DISABLED is not set on ap:

kernel/kprobes.c:__unregister_kprobe_top() {
	...
	if (ap =3D=3D p ||
		(list_is_singular(&ap->list) && kprobe_disarmed(ap))) {
		/*
		 * !disarmed could be happen if the probe is under delayed
		 * unoptimizing.
		 */
		hlist_del_rcu(&ap->hlist);
		return 0;
	}
	...
}

Does this leave the aggregator struct optimized_kprobe permanently hashed
and leaked in kprobe_table with an empty ap->list and an active breakpoint
or jump instruction patched into kernel text?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-kprobes-op=
tprobe-state-v1-0-6aaac612abe6@columbia.edu?part=3D3
