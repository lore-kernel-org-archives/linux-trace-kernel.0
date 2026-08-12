Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9953264CC
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 15:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786549627; cv=none; b=fWQWQ0Le9mkCWaumWXFFjkBQmJWMibQrki7WoDFIWAC8heDNNontwd+l7bD3Wh8iuGQTDtGX/qLZNSB/Nfzv7RNvuji4w5Fm7haVAvA96INQzMY7LEVxr1KYnwtRUHe6kYDgJQE3KHH4y2gEa70Lt8QjeEIYBQFnnaCPvFyH3ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786549627; c=relaxed/simple;
	bh=bBYwN34GZAZcfcipGZe/f2EL76t0JAtgVtWbD2pY+vI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s8HZKwkpuh+YJaHqN4Ixl6uIcjSCS8x9/Pnzy12rLNU6DK0zLrpOzFPLNo9X8+wemxY0pjDEkLSWgEvfG2mCYf1xwX/ukNjrJi8FJXbdu2HrJ89nVMRBQuebnG1jL8IUptgLmiS4N4Yj74hFKfy3KVfpmqv3G4EpYTJ2T/L20kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qmm8N01u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qmm8N01u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 486061F000E9;
	Wed, 12 Aug 2026 15:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786549626;
	bh=8VF2nnlvbumUzDJiXDn/ou4E7fIPmpG8itsw+ucKZR4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qmm8N01uxWHqVyrOzuVncyMhu8ZUTNo5HrAl8tcWINABPscTphYWj0WmLSN5aqVBb
	 EvtUdzhDXX26NDdxhT4Vc4CckKraLDUEuejYm+8EmXITM45MDXxFdDSC2mJzmMgVT1
	 BpoGlGxxgk1D1/hJuqasnie1ZVb136aPT++lm2fxwofFx9WEzN8rYmMphUFUHAb59b
	 c+9T/ob/ox3SN0f0mpYJxOAaMNrhcQeUeP4d2pNBIOEPYxw6DgMrEljiHtsFOPSpEC
	 Wh2HQ7kOGApvERa6VDNA+JukVn5Dz3V8ugCm5qx+LziyEUlhqgnHgiD3TgWa5farBO
	 xrSJ/zm0tNGAg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/9] tracing: Fix subbuf resize races in
 trace_pipe_raw readers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Donnefort" <vdonnefort@google.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260812153311.2328812-6-vdonnefort@google.com>
References: <20260812153311.2328812-1-vdonnefort@google.com>
 <20260812153311.2328812-6-vdonnefort@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 15:47:05 +0000
Message-Id: <20260812154706.486061F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] A logic error in the retry loop of `tracing_buffers_read()` bypass=
es `ring_buffer_read_page()` on retry, leaking uninitialized or stale kerne=
l memory to userspace.

Pre-existing issues:
- [Critical] A race condition during subbuffer resize causes `cpu_buffer->f=
ree_page` to retain an old allocation size while `buffer->subbuf_order` ref=
lects the new order, leading to a kernel buffer overflow.
--

--- Patch [5]: [PATCH v4 5/9] tracing: Fix subbuf resize races in trace_pip=
e_raw readers ---
commit c5c1a16fabb91c8f580283f14e5e76cc1ccb99b0
Author: Vincent Donnefort <vdonnefort@google.com>

tracing: Fix subbuf resize races in trace_pipe_raw readers

Concurrent subbuffer resizes may crash trace_pipe_raw readers or leak
uninitialized memory to userspace due to stale size values.

> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 94552a433228d..f62d6853ee5c0 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c

[ ... ]

> @@ -6988,22 +6988,34 @@ EXPORT_SYMBOL_GPL(ring_buffer_swap_cpu);
>   * Returns:
>   *  The page allocated, or ERR_PTR
>   */
> -struct buffer_data_read_page *
> -ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu)
> +struct buffer_data_read_page *ring_buffer_alloc_read_page(struct trace_b=
uffer *buffer, int cpu,
> +							  struct buffer_data_read_page *prev)
>  {
> +	struct buffer_data_read_page *bpage =3D prev;
>  	struct ring_buffer_per_cpu *cpu_buffer;
> -	struct buffer_data_read_page *bpage =3D NULL;
>  	unsigned long flags;
> +	unsigned int order;
> =20
>  	if (!cpumask_test_cpu(cpu, buffer->cpumask))
>  		return ERR_PTR(-ENODEV);
> =20
> -	bpage =3D kzalloc_obj(*bpage);
> -	if (!bpage)
> -		return ERR_PTR(-ENOMEM);
> -
> -	bpage->order =3D buffer->subbuf_order;
> +	order =3D buffer->subbuf_order;
>  	cpu_buffer =3D buffer->buffers[cpu];
> +
> +	if (!bpage) {
> +		bpage =3D kzalloc_obj(*bpage);
> +		if (!bpage)
> +			return ERR_PTR(-ENOMEM);
> +	} else {
> +		if (bpage->order =3D=3D order)
> +			return bpage;
> +
> +		free_pages((unsigned long)bpage->data, bpage->order);
> +		bpage->data =3D NULL;
> +	}
> +
> +	bpage->order =3D order;
> +
>  	local_irq_save(flags);
>  	arch_spin_lock(&cpu_buffer->lock);
> =20
>  	if (cpu_buffer->free_page) {
>  		bpage->data =3D cpu_buffer->free_page;
>  		cpu_buffer->free_page =3D NULL;
>  	}

[Severity: Critical]
This is a pre-existing issue, but can this lead to an out-of-bounds write
during a subbuffer resize?

In ring_buffer_alloc_read_page(), the newly read buffer->subbuf_order is
assigned to a page stolen from cpu_buffer->free_page without checking if
their size orders match.

If a concurrent call to ring_buffer_subbuf_order_set() updates
buffer->subbuf_order locklessly, and this function is called before
cpu_buffer->free_page is cleared, it will steal the old free_page but assign
it the new size order.

Will this malformed page be swapped into the ring buffer, allowing writers
to write past its actual bounds?

[ ... ]

> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 395238b2b715c..0409d20a168bb 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c

[ ... ]

> @@ -7080,8 +7080,8 @@ ssize_t tracing_buffers_read(struct file *filp, cha=
r __user *ubuf,
>  {
>  	struct ftrace_buffer_info *info =3D filp->private_data;
>  	struct trace_iterator *iter =3D &info->iter;
> -	void *trace_data;
> -	int page_size;
> +	void *trace_data, *prev_spare;
> +	unsigned int spare_size;
>  	ssize_t ret =3D 0;
>  	ssize_t size;
> =20
> @@ -7091,36 +7091,31 @@ ssize_t tracing_buffers_read(struct file *filp, c=
har __user *ubuf,
>  	if (iter->snapshot && tracer_uses_snapshot(iter->tr->current_trace))
>  		return -EBUSY;
> =20
> -	page_size =3D ring_buffer_subbuf_size_get(iter->array_buffer->buffer);
> +again:
> +	prev_spare =3D info->spare;
> +	if (prev_spare) {
> +		spare_size =3D ring_buffer_read_page_size(info->spare);
> =20
> -	/* Make sure the spare matches the current sub buffer size */
> -	if (info->spare) {
> -		if (page_size !=3D info->spare_size) {
> -			ring_buffer_free_read_page(iter->array_buffer->buffer,
> -						   info->spare_cpu, info->spare);
> -			info->spare =3D NULL;
> -		}
> +		/* Do we have previous read data to read? */
> +		if (info->read < spare_size)
> +			goto read;
>  	}

[Severity: High]
Can the retry path bypass the actual read function and copy stale data
to userspace?

When reading from an empty trace_pipe_raw file, ring_buffer_read_page()
returns < 0. The code then blocks in wait_on_pipe(). Once woken up, it
executes a goto again.

At the again label, info->read is 0 and info->spare is already allocated,
so the condition info->read < spare_size will evaluate to true.

Does this cause execution to jump directly to the read label, bypassing
ring_buffer_read_page(), and copy the uninitialized or stale info->spare
page to userspace?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812153311.2328=
812-1-vdonnefort@google.com?part=3D5
