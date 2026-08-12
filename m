Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F326638E129
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 15:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786549994; cv=none; b=iEEiN5a2e6Ke+jacoJl5/uwkBW3xgIUkxHfGEaXFHoIGjyDMPbBiJAeOU7s3++t6aYzhwTd3jfV2XZ9bnT8LXl7xPi/WfanMBFrg/wWRogncImwpf7GuJbedWUE/j2Go7EgvhkBDx6lx+vt6R6d5suFLZtJpsr6i0vhAV5b4TSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786549994; c=relaxed/simple;
	bh=q4ClozkPqFSAkizwV+N0SE/T36x2ONBI0LEsMcT/Dos=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qFKhAPuQ13WQWGX8r82rE2VV6nSMPMswXILENOF1wGqUv11S5uR0lc61+PG//zA2WFMgWK0+NZl9PP3ECHxUfBIrukhW6I5djR2SY6EaPbSznah9Gbe7cxUEDw4xSyyZ58E2aozhoBZOmLW1vE9lHeP3jbtnxtnrpjN0XGIOVFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPp8OELY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPp8OELY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADF031F000E9;
	Wed, 12 Aug 2026 15:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786549992;
	bh=0P3j5zrNqfdc0HrMlmyh+6Lu4rhk6KVL59HtSU2frD4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NPp8OELYB3yYMQzv/EcEsfogxKXvWaC9xueEGsBuvYo6VM+q2GXlukkSF4lqsNL8M
	 eGAB3BGmHVoR5idYf0UZwqTCDvxQKTw5kk4CL5rlRrUuYafI5A6Yk6gV4nFdRuJQmc
	 rf195YQsL8PxLMZjA5DlaIRU9miLYZbUOHKs4AIammHyKkS4zkJPoWnR4gKWfGVQQu
	 vrNoD6yg9T7fatWBqBNCelo0gXpXVlo8NI2rh3tZ1hgdu3jx354WbgMgj67tJ/+SO6
	 +WR27PTwwQhw0XKHNrSImSJ8S6hbYxhX/xCcpRnlvBX7wtsNtPKoxJuXGKnmzDuNrE
	 t3XkNdWnrld6A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/9] ring-buffer: Fix subbuf resize race with ring
 buffer readers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Donnefort" <vdonnefort@google.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260812153311.2328812-4-vdonnefort@google.com>
References: <20260812153311.2328812-1-vdonnefort@google.com>
 <20260812153311.2328812-4-vdonnefort@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 15:53:12 +0000
Message-Id: <20260812155312.ADF031F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Use-After-Free dereference of `reader_page` in `ring_buffer_read_s=
tart()` when bypassing buffer mutex.

Pre-existing issues:
- [High] 32-bit integer overflow in ring buffer capacity calculation trunca=
tes large trace buffers.
- [High] Out-of-bounds kernel memory write and VMAP flush in `ring_buffer_m=
ap_get_reader()` due to global capacity TOCTOU race.
--

--- Patch [3]: [PATCH v4 3/9] ring-buffer: Fix subbuf resize race with ring=
 buffer readers ---
commit 9618f28d9a6939c645e7579fa798c42557eb075c
Author: Vincent Donnefort <vdonnefort@google.com>

ring-buffer: Fix subbuf resize race with ring buffer readers

This commit changes the trace_buffer to use bpage order instead of
trace_buffer::subbuf_size in ring_buffer_read_start() and
ring_buffer_read_page(). It also removes trace_buffer::subbuf_size and
introduces capacity accessors.

> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index ec4f5a0c93e85..97449423d3a68 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
[ ... ]
> @@ -6380,36 +6417,44 @@ EXPORT_SYMBOL_GPL(ring_buffer_consume);
>  struct ring_buffer_iter *
>  ring_buffer_read_start(struct trace_buffer *buffer, int cpu, gfp_t flags)
>  {
> +	struct ring_buffer_iter *iter __free(kfree) =3D kzalloc_obj(*iter, flag=
s);
>  	struct ring_buffer_per_cpu *cpu_buffer;
> -	struct ring_buffer_iter *iter;
> -
> -	if (!cpumask_test_cpu(cpu, buffer->cpumask))
> -		return NULL;
> =20
> -	iter =3D kzalloc_obj(*iter, flags);
>  	if (!iter)
>  		return NULL;
> =20
> -	/* Holds the entire event: data and meta data */
> -	iter->event_size =3D buffer->subbuf_size;
> -	iter->event =3D kmalloc(iter->event_size, flags);
> -	if (!iter->event) {
> -		kfree(iter);
> +	if (!cpumask_test_cpu(cpu, buffer->cpumask))
>  		return NULL;
> -	}
> =20
>  	cpu_buffer =3D buffer->buffers[cpu];
> =20
> -	iter->cpu_buffer =3D cpu_buffer;
> +	/*
> +	 * Only KDB is using GFP_ATOMIC, for the others, lock the buffer to
> +	 * prevent concurrent resizing.
> +	 */
> +	if (gfpflags_allow_blocking(flags))
> +		mutex_lock(&buffer->mutex);
> =20
>  	atomic_inc(&cpu_buffer->resize_disabled);
> =20
> +	if (gfpflags_allow_blocking(flags))
> +		mutex_unlock(&buffer->mutex);
> +
> +	/* Holds the entire event: data and meta data. */
> +	iter->event_size =3D rb_page_capacity(READ_ONCE(cpu_buffer->reader_page=
));

[Severity: High]
Can this result in a use-after-free dereference of the reader page?

When ring_buffer_read_start() is called with GFP_ATOMIC, it skips acquiring
buffer->mutex and only increments cpu_buffer->resize_disabled.

If a concurrent ring_buffer_subbuf_order_set() has already passed its
resize_disabled check, it will proceed to allocate new pages and free the o=
ld
reader page.

A thread executing ring_buffer_read_start() could load the old reader page
pointer just before it is freed by the other CPU, dereferencing freed memory
when accessing the order field.

> +	iter->event =3D kmalloc(iter->event_size, flags);
> +	if (!iter->event) {
> +		atomic_dec(&cpu_buffer->resize_disabled);
> +		return NULL;
> +	}
[ ... ]
> @@ -7367,8 +7413,8 @@ int ring_buffer_subbuf_order_set(struct trace_buffe=
r *buffer, int order)
>  		}
> =20
>  		/* Update the number of pages to match the new size */
> -		nr_pages =3D old_size * buffer->buffers[cpu]->nr_pages;
> -		nr_pages =3D DIV_ROUND_UP(nr_pages, buffer->subbuf_size);
> +		nr_pages =3D old_capacity * buffer->buffers[cpu]->nr_pages;

[Severity: High]
This is a pre-existing issue, but can this 32-bit integer capacity calculat=
ion
truncate large trace buffers?

For buffers larger than 4GB, the multiplication of old_capacity and
buffer->buffers[cpu]->nr_pages can exceed 32 bits. Because nr_pages is a
32-bit signed integer, the result is truncated, and the buffer is shrunk to=
 a
tiny fraction of its intended size during a resize operation.

> +		nr_pages =3D DIV_ROUND_UP(nr_pages, rb_subbuf_capacity(buffer));
> =20
>  		/* we need a minimum of two pages */
>  		if (nr_pages < 2)
[ ... ]
> @@ -7896,7 +7941,7 @@ int ring_buffer_map_get_reader(struct trace_buffer =
*buffer, int cpu)
>  			 * missed events, then record it there.
>  			 */
>  			commit =3D rb_page_size(reader);
> -			if (buffer->subbuf_size - commit >=3D sizeof(missed_events)) {
> +			if (rb_subbuf_capacity(buffer) - commit >=3D sizeof(missed_events)) {

[Severity: High]
This is a pre-existing issue, but does this create a time-of-check to
time-of-use race leading to an out-of-bounds kernel memory write and
VMAP flush?

During a sub-buffer order resize, ring_buffer_subbuf_order_set() modifies
buffer->subbuf_order globally before verifying if resize_disabled is set. If
the buffer is currently mapped, the resize aborts and restores the old orde=
r.

In that race window, a concurrent ring_buffer_map_get_reader() call will see
the new, larger capacity via rb_subbuf_capacity(buffer) here. It could then
write missed_events past the end of the old, smaller reader page, and
subsequently flush memory beyond the mapped VMAP range.

>  				memcpy(&dpage->data[commit], &missed_events,
>  				       sizeof(missed_events));
>  				local_add(RB_MISSED_STORED, &dpage->commit);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812153311.2328=
812-1-vdonnefort@google.com?part=3D3
