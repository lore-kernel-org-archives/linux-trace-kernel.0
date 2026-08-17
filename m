Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07C93F075D
	for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Aug 2026 14:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786975823; cv=none; b=Aj+ToK+w/9yNEx02TK3iapSrh0MhjOc7llAV9hOMJHIfR02pGHF8vMphEZrwagfv2LKTYtoWwHQ63MBgMUZwLTpIuVk5DXD8adN/LEK6Ir0y1Rfua47HsqRZIqLgZ/LRjwQ04PhDD+ldb2H5hD1UVzv6WvlrZoh88eVsR8nqmTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786975823; c=relaxed/simple;
	bh=z5RqbNDAI600Xr1CQeLVwp8JPIYNd1+Tme6aNDAZ3+A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=t+mvYZD1GANpJNDLBiQ7w9AOhqmmeeWQyP522io5+sZFVK4ZtyvIsVCSsVZEXSevensB/3BNDYY+6Xbyna5Su75VbhUJHTIp9Ulz8PjD6MJ9yabmdBu2DhYEETChotdSQLZIhCXwdyztepGAH0SzyfzQRcZu0ezRVLbTG/W9dMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YMb2BKSP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YMb2BKSP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 330011F00A3D;
	Mon, 17 Aug 2026 14:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786975820;
	bh=zq/wr6Yoz+kLVtSGZLfRNmT59h+zS3M8clc38IwOhpo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YMb2BKSPv8THHGFgNDkoXKnonKrC5aiTKkc3tGqCu+tGJFGdu54oPiAWieJzuAkXx
	 eSjPyiE2ouNIwraeQk0vQgO77fvTcck0Jmq77nYW68aE1i2sKBfoLoBqxyssw5ej/H
	 0aNzqSY6M6/FS7+iHkKgrV9PI2UmtpvTSXR5eV2R4auN1qjXnrg2RuavvqoYKGXr+O
	 TvuVbwtKg8S5/eESXyxhawXFEoFeZw8s/wVK9sOdql7yXQWsIYgLoLKs71SImIxbTr
	 zo25dq2dl9yiSpLdJeW8VWafvFGTJgusPA2UOkj+hCenFE4Z6MQby2I00wkOi3utvz
	 0XRIPYS97uO/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 13/18] tracing/remotes: Add dump_on_panic tracefs
 file
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Donnefort" <vdonnefort@google.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260817135517.3919534-14-vdonnefort@google.com>
References: <20260817135517.3919534-1-vdonnefort@google.com>
 <20260817135517.3919534-14-vdonnefort@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 14:10:19 +0000
Message-Id: <20260817141020.330011F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] The panic handler unconditionally attempts to acquire a per-CPU re=
ader spinlock that may be held by a CPU halted by smp_send_stop(), leading =
to a permanent deadlock during kernel panic.
- [High] Missing touch_nmi_watchdog() in the panic dump loop can cause a se=
condary panic or hard reset.
- [Medium] Mixing goto-based error handling with __free() scope-based clean=
up in trace_remote_iter().
- [Low] Missing READ_ONCE() when reading remote->panic_on in dump_on_panic_=
show().
--

--- Patch [13]: [PATCH v6 13/18] tracing/remotes: Add dump_on_panic tracefs=
 file ---
commit 33a5774bde5e05c9ff209cc5026a9b962c22df16
Author: Vincent Donnefort <vdonnefort@google.com>

tracing/remotes: Add dump_on_panic tracefs file

This commit adds a dump_on_panic tracefs file. When enabled, it dumps the
content of the trace remote buffer to the console if the system panics.

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

[Severity: Medium]
This isn't a bug, but this function mixes scope-based cleanup (__free) with
a goto-based error handling pattern. According to the cleanup subsystem
guidelines, mixing goto-based cleanup labels and __free() declarations in
the same function is forbidden because it creates confusing ownership
semantics.

Should this function either use goto-based cleanup exclusively, or be
fully converted to scope-based cleanup?

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
> +		}
> +	}

[Severity: High]
Can this loop deadlock indefinitely during a panic?

If another CPU is actively reading the remote trace buffer and holds its
reader_lock, the panic() function will stop that CPU via smp_send_stop().

When the panicking CPU executes this loop,
ring_buffer_read_remote_meta_page() calls rb_reader_lock(). If in_nmi() is
false (which happens on a normal oops or SysRq-C), rb_reader_lock() will
unconditionally attempt to acquire the lock held by the stopped CPU rather
than using a trylock.

Will this cause the panic recovery process to hang forever?

> +
> +	while (trace_remote_iter_read_event(iter)) {
> +		trace_seq_init(&iter->seq);
> +
> +		trace_remote_iter_print_event(iter);
> +		trace_seq_putc(&iter->seq, 0);
> +		pr_emerg("%s", seq_buf_str(&iter->seq.seq));
> +
> +		trace_remote_iter_move(iter);
> +	}

[Severity: High]
Since serial consoles can be slow and remote trace buffers can contain
many events, could the time spent in this printing loop trigger the NMI
watchdog and cause a hard reset before the panic dump completes?

Does this loop need a call to touch_nmi_watchdog()?

> +
> +	return NOTIFY_DONE;
> +}

[ ... ]

> +static int dump_on_panic_show(struct seq_file *s, void *unused)
> +{
> +	struct trace_remote *remote =3D s->private;
> +
> +	seq_printf(s, "%d\n", remote->panic_on);

[Severity: Low]
Does this unprotected read of remote->panic_on need a READ_ONCE()?

Since dump_on_panic_write() modifies this flag concurrently under
remote->lock, this is formally a data race under the Linux kernel memory
model and might be flagged by KCSAN.

> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817135517.3919=
534-1-vdonnefort@google.com?part=3D13
