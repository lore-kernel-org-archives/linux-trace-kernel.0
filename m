Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98126486BBA
	for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Aug 2026 15:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786723187; cv=none; b=jsS9UQDK5y7Hd1jWC9h9EqkSZ2EW+32bCooVi5umtxjDeXOrypaOCZlYnxM435EQO2M53HTTSJIn70MTJbZyGdp6Qij98lzNXceSqoC5b7xD5GWYt4zn16wbDXNDBwH3AMBO+7o2MlqTiZfLm4Trwb1R0RuiBOjouNBlPcuMHy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786723187; c=relaxed/simple;
	bh=7/91fIQbOYqTGB00EFIG7wog3kt+oZ6kt39bVbwoJfA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=t2BMsbr56qBsJFA9otopA5rxfSNCIm8NfY67jcKWAQepIKXalLqWKARKGyU3snfaIyZaM5IuhFlM4w8bWiGIwK0dWD/SESNHCn6Xkn/L/2cavDsy8IlvGKNi4Ow5Hm+Ew+YfCVvXKIfbweAO9L85+S3tleCoDz/JmHJz9scoA5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QzAUFjXV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QzAUFjXV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F017E1F000E9;
	Fri, 14 Aug 2026 15:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786723185;
	bh=o9dLQ+q4Z+D48fS1PAYM4dac1+79tZoLaX2or9I7PUw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QzAUFjXVFjgrrfhhLI+rSTs8DDHHPC2jqN8++BFk9UNQS8GfXcuKpDn6q+pwDemaP
	 4JVwx/bxBC/TxGB32JNXg1YOL22Wb+fQaYmFrBIAbrSQO5MShaiRoKIXaG820EL94Y
	 a3iDkIQaPaZYXP+0CcEpUPTswzpOCgT4wCcFGkBzbw5G2EABUek/KjWcwtnyV+Unoc
	 DYaDxocp/yTMBSZororaexSkBzFiyvIXiDoFQvmT8PlUUqdW0jPsL0AT0B0lWtwax6
	 elBBKrw570RQEVjfG0LDbDdbqiv5+hKFpTq8R5upTkohbIvRHqeWu0FzfA0Ss0PJEm
	 moR+KXFqUuApQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/2] ring-buffer: Improve nr_pages type
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Donnefort" <vdonnefort@google.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260814154823.755406-3-vdonnefort@google.com>
References: <20260814154823.755406-1-vdonnefort@google.com>
 <20260814154823.755406-3-vdonnefort@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 15:59:44 +0000
Message-Id: <20260814155944.F017E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] When `nr_pages` is exactly `U32_MAX - 1`, the expression `meta->nr=
_subbufs + 1` overflows to 0, silently skipping persistent ring buffer vali=
dation and wiping data.

Pre-existing issues:
- [Critical] Loop counters iterating over `meta->nr_subbufs` are typed as `=
signed int`, which wrap to negative values for extremely large buffers, lea=
ding to out-of-bounds memory accesses.
- [Critical] The `meta->nr_subbufs` field is read from potentially corrupte=
d persistent memory and used without validation against `nr_pages`, causing=
 a heap out-of-bounds write in `bitmap_clear()`.
- [High] Multiplication of `subbuf_size` and `idx` overflows 32 bits for ri=
ng buffers > 4GB, causing severe memory aliasing.
--

--- Patch [2]: [PATCH v6 2/2] ring-buffer: Improve nr_pages type ---
commit 030ec6a7ceec6e71123077bd1fc64e0cf5c27cc8
Author: Vincent Donnefort <vdonnefort@google.com>

ring-buffer: Improve nr_pages type

If ring_buffer_per_cpu::nr_pages is defined as unsigned long, it is
capped to 32-bits in a few places, limiting the operations possible on a
very large buffer.

[ ... ]

> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index ec13779922ffb..ec127e2ad0527 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c

[ ... ]

> @@ -1746,8 +1745,8 @@ static void *rb_subbufs_from_meta(struct ring_buffe=
r_cpu_meta *meta)
>  static void *rb_range_buffer(struct ring_buffer_per_cpu *cpu_buffer, int=
 idx)
>  {
>  	struct ring_buffer_cpu_meta *meta;
> +	unsigned int subbuf_size;
>  	unsigned long ptr;
> -	int subbuf_size;
> =20
>  	meta =3D rb_range_meta(cpu_buffer->buffer, 0, cpu_buffer->cpu);
>  	if (!meta)

[Severity: High]
This is a pre-existing issue, but does the multiplication of subbuf_size and
idx overflow 32 bits for ring buffers larger than 4GB?

In rb_range_buffer(), we have:

    subbuf_size =3D meta->subbuf_size;
    idx =3D meta->buffers[idx];
    ptr =3D (unsigned long)rb_subbufs_from_meta(meta);
    ptr +=3D subbuf_size * idx;

Since subbuf_size is an unsigned int and idx is an int, the multiplication
evaluates as a 32-bit unsigned integer. For ring buffers over 4GB, this can
overflow and wrap around before being zero-extended and added to the 64-bit
ptr, causing memory aliasing by overwriting earlier subbuffers.

[ ... ]

> @@ -1840,10 +1839,10 @@ static bool rb_meta_init(struct trace_buffer *buf=
fer, int scratch_size)
>   * must be the same.
>   */
>  static bool rb_cpu_meta_valid(struct ring_buffer_cpu_meta *meta, int cpu,
> -			      struct trace_buffer *buffer, int nr_pages,
> +			      struct trace_buffer *buffer, unsigned long nr_pages,
>  			      unsigned long *subbuf_mask)
>  {
> -	int subbuf_size =3D PAGE_SIZE;
> +	unsigned int subbuf_size =3D PAGE_SIZE;
>  	unsigned long buffers_start;
>  	unsigned long buffers_end;
>  	int i;

[Severity: Critical]
This is a pre-existing issue, but will loop counters iterating over
meta->nr_subbufs wrap to negative values for extremely large buffers?

In rb_cpu_meta_valid():

    for (i =3D 0; i < meta->nr_subbufs; i++) {
        if (meta->buffers[i] < 0 || ...

And in rb_range_meta_init():

    for (i =3D 0; i < meta->nr_subbufs; i++) {
        meta->buffers[i] =3D i;

The loop counter i is a signed int. Since nr_pages can now go up to
U32_MAX - 1, if the buffer size pushes meta->nr_subbufs past INT_MAX, i
will wrap to negative. i < meta->nr_subbufs will promote i to unsigned,
evaluating to true, and the negative index will be sign-extended on 64-bit
architectures, causing out-of-bounds reads and writes.

[Severity: Critical]
This is a pre-existing issue, but could meta->nr_subbufs cause a heap
out-of-bounds write if it doesn't match nr_pages?

In rb_cpu_meta_valid():

    bitmap_clear(subbuf_mask, 0, meta->nr_subbufs);

    for (i =3D 0; i < meta->nr_subbufs; i++) {
        ...
        set_bit(meta->buffers[i], subbuf_mask);

meta->nr_subbufs is read directly from persistent memory and used without
being validated against the dynamically allocated subbuf_mask size, which is
based on nr_pages + 1. If meta->nr_subbufs is maliciously or accidentally s=
et
larger than nr_pages + 1, bitmap_clear() and set_bit() will write zeroes and
ones past the end of the bitmap allocation.

[ ... ]

> @@ -2837,6 +2837,10 @@ static struct trace_buffer *alloc_buffer(unsigned =
long size, unsigned flags,
>  		 */
>  		nr_pages =3D (size - sizeof(struct ring_buffer_cpu_meta)) /
>  			(subbuf_size + sizeof(int));
> +
> +		/* limited by ring_buffer_cpu_meta::nr_subbufs */
> +		if (nr_pages > U32_MAX - 1)
> +			goto fail_free_buffers;
>  		/* Need at least two pages plus the reader page */
>  		if (nr_pages < 3)
>  			goto fail_free_buffers;

[Severity: High]
Does meta->nr_subbufs + 1 overflow when nr_pages is exactly U32_MAX - 1?

If nr_pages is exactly U32_MAX - 1, meta->nr_subbufs becomes U32_MAX.
In rb_meta_validate_events(), there are loops with this condition:

    for (i =3D 0; i < meta->nr_subbufs + 1; i++, rb_dec_page(&head_page)) {

U32_MAX + 1 overflows to 0 in 32-bit unsigned arithmetic. This makes the lo=
op
condition i < 0, causing the loops to terminate immediately without rewindi=
ng
and validating the persistent ring buffer from a previous boot.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814154823.7554=
06-1-vdonnefort@google.com?part=3D2
