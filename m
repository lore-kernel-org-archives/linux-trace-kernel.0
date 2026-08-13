Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401BD47CA86
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Aug 2026 13:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786629104; cv=none; b=lOu1Rz3DVz0ohd/d9ylz+AJUsAcYyUqulpUEd2jd0AasSol9RvcKu47scLZj9C3s4YoxBSaXzVbApidVKhUiQtJ5c/Kl4oaHgmld1p/koDAvS6h+o83lowZOq8UaMnwEVwolcbo6HtqPTZnyZvLWpTTwbqkvMB0lhvWNVH+XVKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786629104; c=relaxed/simple;
	bh=Dxd8oFk63Dr4IJQC/81yB0ws8vysbyQrrlccUUBkZPk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aIH8zcnl8kE+JDCESnKLgcZOK/6DkGFboGAvPul7VEp5VMf3oOsm4dBNiimJeFNTCX8zOfE2Z8G4GRE30rX0JLaS0W6tEmLZKo02QeQ5wKnfGiJAaFyONPVFOv/JDAvrlicGAnrUQNOYsMGSaTj2RgVRe3eUoxzJ5QgB2SjSd+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l8UtNiQi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l8UtNiQi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C27031F000E9;
	Thu, 13 Aug 2026 13:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786629102;
	bh=+81OSdIn/ORsjZJoJQVEcD305TusyyU97nTp7ZKo8ZM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l8UtNiQiFWKNYqAl6/vxwCLPxvlnixGXp1By4OruAVrU/ANvqyCypXfBC/igTqQ+S
	 xaQqDpZE8X4sohRK8uGkJCkJa1kq+4o82AZwkz2+pC9ZPAbplF3S/pAr/Zqu8hG68C
	 pPqMqd0LS2p0tNTDaHa+JYmIsDRIBRwsfOSBy1U6bvNnXqWrggyN8p3aKRLx1Ecq/M
	 6EZV0+9y5FvVp1OCYlAcNXalJ3fyMe8momtjKtwbuBwtbUd9S7fKSrxjVIWrFZs3IO
	 ktVvOPHOwlKmsPW2RCkQaPWkDeClMSsUo3dQuuxo+PkV8B0eG4FV7waoppYPmTweVI
	 XsePHo+ZbQU5Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 04/10] ring-buffer: Fix subbuf resize race with ring
 buffer readers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Donnefort" <vdonnefort@google.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260813131152.3589632-5-vdonnefort@google.com>
References: <20260813131152.3589632-1-vdonnefort@google.com>
 <20260813131152.3589632-5-vdonnefort@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 13:51:42 +0000
Message-Id: <20260813135142.C27031F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] `ring_buffer_read_start()` introduces a Use-After-Free vulnerabili=
ty for callers using `GFP_ATOMIC`.

Pre-existing issues:
- [High] Race condition and Out-of-Bounds write in `ring_buffer_map_get_rea=
der()` due to evaluating the global `buffer->subbuf_order`.
--

--- Patch [4]: [PATCH v5 04/10] ring-buffer: Fix subbuf resize race with ri=
ng buffer readers ---
commit 71a276d1d136c0fb8371689f58251aa6fc99f54c
Author: Vincent Donnefort <vdonnefort@google.com>

    ring-buffer: Fix subbuf resize race with ring buffer readers

This commit replaces the lockless read of trace_buffer::subbuf_size with
bpage::order in ring_buffer_read_start() and ring_buffer_read_page() to
prevent races during resizing. It also removes subbuf_size entirely and
introduces new capacity accessors.

> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index b6fa258aafe2c..ec520c72124e5 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c

[ ... ]

> @@ -6380,36 +6417,44 @@ EXPORT_SYMBOL_GPL(ring_buffer_consume);
>  struct ring_buffer_iter *
>  ring_buffer_read_start(struct trace_buffer *buffer, int cpu, gfp_t flags)
>  {

[ ... ]

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
Can this cause a use-after-free when called with GFP_ATOMIC?

If this is called with GFP_ATOMIC, it skips taking buffer->mutex and
increments resize_disabled without synchronization. If a concurrent
ring_buffer_subbuf_order_set() evaluated resize_disabled to 0 just before
this increment, it can proceed to replace and free the reader_page.

The lockless dereference of bpage->order inside rb_page_capacity() on the
freed reader_page would then access freed memory. Prior to this patch, it
read the scalar buffer->subbuf_size which was safe from this use-after-free.

[ ... ]

> @@ -7340,18 +7383,21 @@ int ring_buffer_subbuf_order_set(struct trace_buf=
fer *buffer, int order)

[ ... ]

>  	/* prevent another thread from changing buffer sizes */
>  	guard(mutex)(&buffer->mutex);
> +
> +	old_order =3D buffer->subbuf_order;
> +	if (old_order =3D=3D order)
> +		return 0;
> +
> +	old_capacity =3D rb_subbuf_capacity(buffer);
> +
>  	atomic_inc(&buffer->record_disabled);
> =20
>  	/* Make sure all commits have finished */
>  	synchronize_rcu();
> =20
>  	buffer->subbuf_order =3D order;

[ ... ]

> @@ -7896,7 +7941,7 @@ int ring_buffer_map_get_reader(struct trace_buffer =
*buffer, int cpu)
>  			 * missed events, then record it there.
>  			 */
>  			commit =3D rb_page_size(reader);
> -			if (buffer->subbuf_size - commit >=3D sizeof(missed_events)) {
> +			if (rb_subbuf_capacity(buffer) - commit >=3D sizeof(missed_events)) {

[Severity: High]
This is a pre-existing issue, but can this lead to an out-of-bounds write?

Since ring_buffer_map_get_reader() does not hold buffer->mutex, it can run
concurrently with ring_buffer_subbuf_order_set(). As shown in the hunk abov=
e,
ring_buffer_subbuf_order_set() updates the global buffer->subbuf_order befo=
re
checking if resize_disabled is set on the CPU buffers.

If ring_buffer_map_get_reader() reads this temporarily inflated global
capacity while processing an older, smaller reader_page, the capacity check
could incorrectly pass. This would allow the following memcpy() to write
missed_events out of bounds.

Should this use rb_page_capacity(reader) instead of the global
rb_subbuf_capacity(buffer), similar to the fix applied to
ring_buffer_read_page()?

>  				memcpy(&dpage->data[commit], &missed_events,
>  				       sizeof(missed_events));
>  				local_add(RB_MISSED_STORED, &dpage->commit);

[ ... ]

> @@ -7928,7 +7973,7 @@ int ring_buffer_map_get_reader(struct trace_buffer =
*buffer, int cpu)
>  out:
>  	/* Some archs do not have data cache coherency between kernel and user-=
space */
>  	flush_kernel_vmap_range(cpu_buffer->reader_page->page,
> -				buffer->subbuf_size + BUF_PAGE_HDR_SIZE);
> +				rb_subbuf_size(buffer));

[Severity: High]
This isn't a bug introduced by this patch, but could this flush more memory
than is actually mapped?

Similar to the check above, if this reads a temporarily inflated global
capacity while flushing an older, smaller reader_page, the flush range
might exceed the actual allocated page bounds.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813131152.3589=
632-1-vdonnefort@google.com?part=3D4
