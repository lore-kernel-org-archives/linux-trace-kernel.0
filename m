Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADC049C4CA
	for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 15:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790262910; cv=none; b=dimOipL2Bx9Cx7Gp5l8HWMrZLqmgkgmPuXcr5BD/c7LYlyDYbMYCONMrNhSRYSJ7Re61KyAZ/Wqi6yXpVocSmDWdha+HAq8p4XaVV9a1tnQ8GevYltroP3iTtJFK4Cz5BPhzKSdZOZfz6BH7RFU4aNYE/cowYZcWsawdSBuw/VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790262910; c=relaxed/simple;
	bh=gsVpgiOorUespZXhKHYWUekaH1nFW80HvdLddAd5SkE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Pet6rwJZ1QZ7MM+CyhFOIipXIFybxlKWVO1Jc65Klph7tpNzVnv40gcO4NlsyUZ3KtVgUM3eaWyC+fH0W7kJvigOaeHST+Habn8mA9nvp246ftNlUaPxYucZW7INLeXHJHryG4SfG9L31wOxlWeEPv0hId6xNRRN7yVMGnZx9dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oThkfO6A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oThkfO6A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23AEE1F000FF;
	Thu, 24 Sep 2026 15:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790262909;
	bh=SYiJo8Sr9pNAaufHoS5aA2rTk/MHhs0RK8hHmH+95qQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oThkfO6ACgu2BGlxhopvtqSTxYsm+NdYnLnqmmj5j7SsrQ5+kmquf6aoBRRIrsFrX
	 heocSTrZXEJRwcUjfJ+qebFlrID3tN6dTtkClaqM1+tATRwAhNJHUw6B6P5IOu/NHa
	 seVq9xeNcYsdhXFiTpzKThQEn0EDEcWGRONYma+8SZpODcOFtUZU6azhy5hWRg79tk
	 zNT0xFP+KZsKNjQLjyEQ/y6QKND/ALYJQUj5VzQFYDNsexI4xZqu4kctpKBeXYs8De
	 aMO1Ll3l7Nmj9/4RRRlJnMByPGhPvYwaDtUbC7tjhCz+5dSqb5Yic+FfTudZgDwYut
	 Y/Be13XLPNSZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 15/20] tracing/remotes: Add dump_on_panic tracefs
 file
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Donnefort" <vdonnefort@google.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260924145754.1285146-16-vdonnefort@google.com>
References: <20260924145754.1285146-1-vdonnefort@google.com>
 <20260924145754.1285146-16-vdonnefort@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 15:15:08 +0000
Message-Id: <20260924151509.23AEE1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] trace: trace_remote_panic_handler deadlocks on rb_reader_lock duri=
ng panic
- [Low] cleanup: mixing goto-based error handling with scope-based cleanup
--

commit 66fa48a367eccf4815a02a5d4904f1fcccdbd1d5
Author: Vincent Donnefort <vdonnefort@google.com>

tracing/remotes: Add dump_on_panic tracefs file

This commit adds a dump_on_panic tracefs file for trace remotes. When enabl=
ed,
it registers a panic notifier that attempts to read and dump the contents of
the remote buffer if the system panics.

> diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
> index ea0fc347dff86..0a360690b174e 100644
> --- a/kernel/trace/trace_remote.c
> +++ b/kernel/trace/trace_remote.c
[ ... ]
> @@ -435,58 +457,68 @@ static void trace_remote_dec_poll(struct trace_remo=
te *remote)
>  static struct trace_remote_iterator
>  *trace_remote_iter(struct trace_remote *remote, int cpu, enum tri_type t=
ype)
>  {
> -	struct trace_remote_iterator *iter =3D NULL;
> +	struct trace_remote_iterator *iter __free(kfree) =3D kzalloc_obj(*iter);

[Severity: Low]
This isn't a functional bug, but does this mix goto-based error handling wi=
th
scope-based cleanup?

The cleanup subsystem guidelines suggest converting all resources in a given
function to scope-based cleanup or converting none, as mixing the paradigms
can create confusing ownership semantics.

[ ... ]
> -		return iter;
>  	}
> -	ret =3D -ENOMEM;
> =20
> -err:
> -	kfree(iter);
> -	trace_remote_put(remote);
> +	return no_free_ptr(iter);
> =20
> +err:
> +	switch (type) {
> +	case TRI_PANIC:
> +		break;
> +	default:
> +		trace_remote_put(remote);
> +	}
>  	return ERR_PTR(ret);
>  }
[ ... ]
> @@ -990,6 +1026,118 @@ static int dmesg_show(struct seq_file *s, void *un=
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
> +
> +	while (trace_remote_iter_read_event(iter)) {
> +		trace_seq_init(&iter->seq);

[Severity: High]
Could this sequence permanently deadlock the system during a kernel panic?

If a panic originates from a non-NMI context (such as a BUG() or sysrq-c),
the panicking CPU halts all other CPUs via smp_send_stop().

If one of those halted CPUs was interrupted while holding its per-CPU
reader_lock, it will never release it. The panicking CPU executing this
handler iterates over all CPUs and calls ring_buffer_read_remote_meta_page(=
).

Looking at ring_buffer_read_remote_meta_page(), it unconditionally acquires
the reader_lock:

int ring_buffer_read_remote_meta_page(struct trace_buffer *buffer, int cpu)
{
	...
	cpu_buffer =3D buffer->buffers[cpu];

	local_irq_save(flags);
	dolock =3D rb_reader_lock(cpu_buffer);
	rb_read_remote_meta_page(cpu_buffer);
	...
}

Furthermore, the loop condition trace_remote_iter_read_event() relies on
ring_buffer_empty_cpu(), which also attempts to acquire reader_lock.

Since rb_reader_lock() acquires a standard spinlock rather than using a
trylock, wouldn't the panicking CPU spin infinitely waiting for the halted
CPU's lock, preventing the crash dump and subsequent reboot?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924145754.1285=
146-1-vdonnefort@google.com?part=3D15
