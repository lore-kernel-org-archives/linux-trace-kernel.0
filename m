Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17541474267
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 17:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786554510; cv=none; b=Nyudw8dqKpzhxV9XlT2Mx3bex9U5R4Q+ZxLPsuCCOxGtWoParf9kiJry7Et90j190fgwBTrGiCdDI7jjIrHnJ+8XAteiqAib76FgNrFX5ZQHZUeZ8HCW0b4yT2+PfJ4/zTeKbUQAnZQkXz7/cgoTF5sTggOOHKv3DvGpNd3FbaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786554510; c=relaxed/simple;
	bh=fLehFUnB/z0c7vgWSvParXK3iHwOF4POvDLQcDGd/Lk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qs2fcVJJWOE+rVXvoZ6pZVF6TEGwtpI6Mylkwie7+Kt6ME43b7MGWCljG7DQvYpYoxXABlDysCSCnH5o80iAuQIaDGnmug5rr/WzTWrHeXc6cuTSnPSAIdkGA7dwUlMK0t69TQaNF6v9nVFPiHGuyk/YmnLW4ndI3pw65lqhllg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jqPiZNbg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jqPiZNbg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C0611F000E9;
	Wed, 12 Aug 2026 17:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786554506;
	bh=w06We83ojDMvXNPAMKQOU2maf29Xm4/FS8VQzLkbLrI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jqPiZNbggqzZnN+mYcVswktLAfuyzFJMyzSq7j+F0vCxc9xTer9D6AnV6Thg5pPMk
	 rgFAsTuiWbNfi4ZsUCKujXn2jFmhOk4xXmShS6/h/9aJiNs2piOp500klYIKjGpDzc
	 7d1LGD9H9Rlr8QyuDuucZnm/SFzKnOyxxaZEeFEeXIb3/OXtBY7yglZnUWjmVjsAv/
	 0NIj2lx6J0dY/eniFMMBDblC5FjRvDOeGMle7rqyGSRU72vZAdAlh5m6vIfYK6uIXQ
	 s7aJNKLvpF3O/Bp+LcxY2mmTUA+/ktGyoVDSA4P5J0lmvKM3tJwGlEPZm1tl3BN+iU
	 wEA2Hk+Y8trSA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 13/18] tracing/remotes: Add dump_on_panic tracefs
 file
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Donnefort" <vdonnefort@google.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260812161340.2417322-14-vdonnefort@google.com>
References: <20260812161340.2417322-1-vdonnefort@google.com>
 <20260812161340.2417322-14-vdonnefort@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 17:08:26 +0000
Message-Id: <20260812170826.7C0611F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Deadlock in panic handler due to unconditionally acquiring raw spi=
nlocks that may be held by stopped CPUs.
- [Low] Mixing goto-based error handling with scope-based `__free()` cleanu=
p.
--

--- Patch [13]: [PATCH v5 13/18] tracing/remotes: Add dump_on_panic tracefs=
 file ---
commit 0e10ff19e3851c2a033a99ee96a39ed51f4786e7
Author: Vincent Donnefort <vdonnefort@google.com>

tracing/remotes: Add dump_on_panic tracefs file
   =20
When enabled, dump_on_panic will dump the content of the trace remote
buffer if the system panics.

> diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
> index 9e78267d71f8b..5536e0df43795 100644
> --- a/kernel/trace/trace_remote.c
> +++ b/kernel/trace/trace_remote.c
[ ... ]
> @@ -434,58 +455,68 @@ static void trace_remote_dec_poll(struct trace_remo=
te *remote)
>  static struct trace_remote_iterator
>  *trace_remote_iter(struct trace_remote *remote, int cpu, enum tri_type t=
ype)
>  {
> -	struct trace_remote_iterator *iter =3D NULL;
> +	struct trace_remote_iterator *iter __free(kfree) =3D kzalloc_obj(*iter);
>  	int ret;
> =20
>  	lockdep_assert_held(&remote->lock);
> =20
> -	if (type =3D=3D TRI_NONCONSUMING && !trace_remote_loaded(remote))
> -		return NULL;
> +	if (!iter)
> +		return ERR_PTR(-ENOMEM);
[ ... ]
>  	if (!trace_remote_has_cpu(remote, cpu)) {
>  		ret =3D -ENODEV;
>  		goto err;
                ^^^^^^^^

[Severity: Low]
Does this mix goto-based error handling with scope-based __free() cleanup?

The iter variable was declared with __free(kfree) at the top of the functio=
n,
but this goto jumps to an error label. Mixing goto labels and cleanup scope
decorators in the same function can create confusing ownership semantics and
violates cleanup guidelines.

Could this be converted entirely to scope-based cleanup, or avoid using
__free() here?

[ ... ]
> @@ -989,6 +1024,117 @@ static int dmesg_show(struct seq_file *s, void *un=
used)
>  }
>  DEFINE_TRACE_REMOTE_ATTRIBUTE(dmesg);
> =20
> +static int trace_remote_panic_handler(struct notifier_block *self, unsig=
ned long ev, void *v)
> +{
> +	struct trace_remote *remote =3D container_of(self, struct trace_remote,=
 panic_notifier);
> +	struct trace_remote_iterator *iter =3D smp_load_acquire(&remote->panic_=
iter);
> +	int cpu;
> +
> +	if (!iter) {
> +		pr_warn("Unexpected error: no panic iterator for the trace remote\n");
> +		return NOTIFY_DONE;
> +	}
> +
> +	for_each_possible_cpu(cpu) {
> +		if (iter->rb_iters[cpu]) {
> +			/* No RING_BUFFER_ALL_CPUS to avoid taking cpu_read_lock() */
> +			ring_buffer_read_remote_meta_page(remote->trace_buffer, cpu);
> +			ring_buffer_iter_reset(iter->rb_iters[cpu]);

[Severity: High]
Can these functions deadlock the panic handler?

During a panic, smp_send_stop() halts all other CPUs. If a remote CPU was
reading the trace buffer and holding the reader_lock when it was halted,
won't this spin forever?

ring_buffer_read_remote_meta_page() and ring_buffer_iter_reset() both call
rb_reader_lock(), which unconditionally takes a raw_spin_lock() when not in
NMI context:

kernel/trace/ring_buffer.c:rb_reader_lock() {
    ...
    if (likely(!in_nmi())) {
        raw_spin_lock(&cpu_buffer->reader_lock);
        return true;
    }
    ...
}

Because standard panics do not execute in NMI context, in_nmi() returns fal=
se
here, leading to a hang that prevents kdump or reboot.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812161340.2417=
322-1-vdonnefort@google.com?part=3D13
