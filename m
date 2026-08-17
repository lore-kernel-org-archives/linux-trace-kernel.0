Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA37D285061
	for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Aug 2026 14:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786975390; cv=none; b=aHfBEIfSAWIf270bfHjPE3XM1m2lftlKeuqZfOyGOX+AziYrAgAEVfac2nhSs0/LYUysHJHPW2F7ninpL+w+o7Ey4ZrTj790pvSgowXcHkekEHR4/t8HILNh06k/eCuymtUufJMG+8qZOeuPsBbVwFrtwRJRyRdcsqbKbKbIm9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786975390; c=relaxed/simple;
	bh=LU8VSXbccyZPv+j+DtbZfHW6g+/OfgqAo7C5VrYcH+A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jRYzg1GIluYN96DUv5ZuVxQ2jMNjvPARrJtb5Ypw3VAQaVpCptIYWBC0QJxzG21zqSvK8rPyNabs5foCx3jYsplvVfKiPgeTKYnfDmFoG/TWqoT+Tcs+PX4+Yboq/LMi1td/eJR1SCi5L6UdHU7l99J6Cw2sRxz7zqq8Wx5ertw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMDDJzDT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMDDJzDT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FCC91F00A3A;
	Mon, 17 Aug 2026 14:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786975388;
	bh=ZACqbutiH38IGIk50bn7RB8fMR4kn1R0EbfsLSkTbEE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kMDDJzDTTlzHDHQ/OpJoZe+dhBKK/ZLGriBTtDw+y7W/R7DfuQyH33YBRg6sjztjs
	 VhYJGf8k+3vmA60I2fUqI1JVlRb5Jkoju82bUBJlRfju72C+98fNcCpRdkvz9KNYGI
	 hKSyDdtGm3B9FAqFSnECBwiwQyQC93sQfQhj0w3l9vkyV6AWro4QR3ZG6YnhvXxfH/
	 YkLiOCYavYeaPcez1tYEq/hLkOChi+8eqYiWP/GBuG/1jADy8B0XRUnis1JgsuScAw
	 CJWZxjQ2D30LA44B8kCbFsGRD7p/9TU/NsuK7k3SsHFqNCZdSNgNyGTKL0gVsaWcez
	 MXE8qD33iR37w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/3] ring-buffer: Cap static ring buffer nr_pages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Donnefort" <vdonnefort@google.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260817134750.3909384-3-vdonnefort@google.com>
References: <20260817134750.3909384-1-vdonnefort@google.com>
 <20260817134750.3909384-3-vdonnefort@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 14:03:07 +0000
Message-Id: <20260817140308.5FCC91F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Integer underflow silently bypasses the newly introduced rb_static=
_max_pages() bound check on 32-bit platforms.
- [High] Integer overflow in pointer arithmetic when ring buffer is large c=
auses out-of-bounds memory mapping.
- [Medium] Mixing goto-based error handling with scope-based cleanup (__fre=
e and guard) violates subsystem guidelines.
--

--- Patch [2]: [PATCH v7 2/3] ring-buffer: Cap static ring buffer nr_pages =
---
commit 5ef3e045e7449785cd305ffb3c9bd4573685ad34
Author: Vincent Donnefort <vdonnefort@google.com>

ring-buffer: Cap static ring buffer nr_pages
   =20
This commit introduces a maximum page limit for static ring buffers to
ensure the page count fits within the buffer_page::id field. It enforces
this limit during buffer allocation and user-mapping, while increasing
the id field to 31 bits.

> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index ec13779922ffb..5e26eeff588f2 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
[ ... ]
> @@ -652,6 +652,15 @@ static bool rb_is_static(struct ring_buffer_per_cpu =
*cpu_buffer)
>  	return cpu_buffer->user_mapped || cpu_buffer->remote || cpu_buffer->rin=
g_meta;
>  }
> =20
> +static unsigned long rb_static_max_pages(void)
> +{
> +	/*
> +	 * Static ring buffers are using bpage::id and must account for the
> +	 * reader page.
> +	 */
> +	return (1UL << 31) - 1;
> +}

[Severity: High]
This is a pre-existing issue, but does a maximum page limit this large cause
integer overflow in pointer arithmetic when mapping memory?

While the limit restricts the number of pages to (1UL << 31) - 1, configuri=
ng
a very large memory-mapped trace buffer (e.g., >=3D 2GB per CPU, or ~524,288
pages) can cause multiplication overflows elsewhere:

kernel/trace/ring_buffer.c:rb_range_meta() {
    ...
    ptr +=3D subbuf_size * nr_subbufs;
    ...
}

And similarly in rb_range_buffer():

kernel/trace/ring_buffer.c:rb_range_buffer() {
    ...
    ptr +=3D subbuf_size * idx;
    ...
}

Since the operands are treated as 32-bit signed integers, configuring a
buffer with 524,288 pages causes the multiplication to exceed INT_MAX and
overflow into a negative value. This negative offset is added to the starti=
ng
pointer, resulting in the mapped buffer incorrectly pointing to memory befo=
re
the valid allocation range.

> +
>  struct ring_buffer_iter {
>  	struct ring_buffer_per_cpu	*cpu_buffer;
>  	unsigned long			head;
[ ... ]
> @@ -2837,6 +2846,10 @@ static struct trace_buffer *alloc_buffer(unsigned =
long size, unsigned flags,
>  		 */
>  		nr_pages =3D (size - sizeof(struct ring_buffer_cpu_meta)) /
>  			(subbuf_size + sizeof(int));

[Severity: High]
This is a pre-existing issue, but does an integer underflow here silently
bypass the newly introduced bound check on 32-bit platforms?

If the memory-mapped ring buffer size is extremely small, the calculation of
the available size for per-CPU data underflows, causing the size variable to
become a massive positive value.

On 32-bit architectures, the nr_pages variable evaluates to approximately 1
million pages. Since this is less than the rb_static_max_pages() limit, the
check passes. The subsequent loop calculating subbuffer pointers then
overflows 32-bit arithmetic, bypassing bounds checks and allowing
out-of-bounds memory corruption.

> +
> +		if (nr_pages > rb_static_max_pages())
> +			goto fail_free_buffers;

[Severity: Medium]
This is a pre-existing issue, but does adding new goto error paths here
perpetuate a mixture of goto-based error handling and scope-based cleanup?

The alloc_buffer() function uses scope-based cleanup:

    struct trace_buffer *buffer __free(kfree) =3D NULL;

Mixing __free() declarations and manual goto cleanup labels in the same
function violates subsystem guidelines and increases the risk of memory lea=
ks
or confusing ownership semantics.

> +
>  		/* Need at least two pages plus the reader page */
>  		if (nr_pages < 3)
>  			goto fail_free_buffers;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817134750.3909=
384-1-vdonnefort@google.com?part=3D2
