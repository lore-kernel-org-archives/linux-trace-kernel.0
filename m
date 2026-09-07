Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2432F3AB5DE
	for <linux-trace-kernel@vger.kernel.org>; Mon,  7 Sep 2026 19:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788810129; cv=none; b=ZBYpAV5TauTajjCt/9+emG8Eqi7sak7v9M8AchSHc5t9dksj4St9u315KuLZ8Cw4MYoupkG5bqZQpcIPL/x+JLqUB+8NZ+09ed0n5uQiaQJwUIkzVR/jE0uAjY4K2n2cEbqkzVEqzMnkh0b+YgV12QwnP0lpHOBxXPMDfDJKoOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788810129; c=relaxed/simple;
	bh=m2UY8BFvJpZvuA+NSZ6i71ePqMySFvPVUAarmZA9JM0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sPsz0w+BznA62rr0AOuwQnYFjd9Zixo11VyBnZH8j9qY7a7KM25OmDIdUOaMQZRCeFYMiRqXLr96le+nSORMnA79ffqU+HU8bAc+cqiUGhoMAS7Yt0kdYUNyrfcBGrKhI1cFYvUSrNjZovyqAI6Vk3pzIJPPaLX9F06CkltfMUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KAUj3s+z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KAUj3s+z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8281D1F00A3A;
	Mon,  7 Sep 2026 19:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788810127;
	bh=n8BDEye/Jgc0TiLkdFkooi+5UmvPKtndORXksI9R528=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KAUj3s+zCnwbgXQUz8i9QoPXNKK/kAORK5uuEf442ST1Op1i4DH9rU2MDMF2ZqYqZ
	 2zhYVRHPkgWr3LmK1qYD1MegtPHDOZh7ujvDij92Fg84nTWBbZLA/zGiVag1msaf3z
	 QzAGS1kZZY+gnsBPOhVOzyGX/RCPjq/v+7g0BEOMNsDcrd1SS+l7il2gxDMzOjrqL5
	 skAzRo6Ane2Z/3oLS/nWH/0xpjBBXQ9HowfLdhlKo6SW6+8OJQcHGp2D0Ctv3MAj3x
	 oMy5AgqLuqy/J4c2I8thx8Hu/Pmz6uZkdpWEXGzGDx7zqNTQ0JiWxsgI5iYcfe/NDD
	 h5cETijYQWilg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/2] tracing/remotes: Account for ring buffer page
 header in size calculation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Donnefort" <vdonnefort@google.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260907192643.42513-2-vdonnefort@google.com>
References: <20260907192643.42513-1-vdonnefort@google.com>
 <20260907192643.42513-2-vdonnefort@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 19:42:07 +0000
Message-Id: <20260907194207.8281D1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Integer overflow in DIV_ROUND_UP macro when buffer_size is near UL=
ONG_MAX, resulting in silently undersized trace buffer allocation and bypas=
sing the nr_pages overflow check.
--

commit 5b0a9673088fdd2f5832774541f4590e32126561
Author: Vincent Donnefort <vdonnefort@google.com>

tracing/remotes: Account for ring buffer page header in size calculation

This commit adjusts the trace buffer size calculation to account for the ri=
ng
buffer page header size. It also introduces bounds checking for the number =
of
pages to prevent out-of-bounds calculations.

> diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
> index afc7daa6ee7dc..7a1a92f876503 100644
> --- a/include/linux/ring_buffer.h
> +++ b/include/linux/ring_buffer.h
[ ... ]
> @@ -281,9 +283,14 @@ static inline struct ring_buffer_desc *__first_ring_=
buffer_desc(struct trace_buf
> =20
>  static inline size_t trace_buffer_desc_size(size_t buffer_size, unsigned=
 int nr_cpus)
>  {
> -	unsigned int nr_pages =3D max(DIV_ROUND_UP(buffer_size, PAGE_SIZE), 2UL=
) + 1;
> +	unsigned long nr_pages =3D
> +		max(DIV_ROUND_UP(buffer_size, PAGE_SIZE - BUF_PAGE_HDR_SIZE), 2UL) + 1;

[Severity: High]
This isn't a bug introduced by this patch, but is there an integer overflow
when evaluating DIV_ROUND_UP() with a very large buffer_size?

If a privileged user writes a near-maximum value (like ULONG_MAX - 1023) to
the tracefs buffer_size_kb file, it passes the earlier check_shl_overflow()
because the top 10 bits are zero.

When calculating the pages here:

    DIV_ROUND_UP(buffer_size, PAGE_SIZE - BUF_PAGE_HDR_SIZE)

the macro expands to adding (PAGE_SIZE - BUF_PAGE_HDR_SIZE - 1) to
buffer_size. This addition overflows the 64-bit integer, wrapping around
to a small number.

This causes nr_pages to be miscalculated as a tiny value (like 3), complete=
ly
bypassing the newly added "> UINT_MAX" safety check.

Since the backing pages might be sized based on a PAGE_ALIGN() wrap, while
nr_page_va is set to 3, could this discrepancy cause out-of-bounds hypervis=
or
memory accesses on systems with >=3D 64 CPUs?

>  	struct ring_buffer_desc *rbdesc;
> =20
> +	/* Capped by ring_buffer_desc::nr_page_va */
> +	if (nr_pages > UINT_MAX)
> +		return SIZE_MAX;
> +
>  	return size_add(offsetof(struct trace_buffer_desc, __data),
>  			size_mul(nr_cpus, struct_size(rbdesc, page_va, nr_pages)));
>  }
> diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
> index 75fa1ffc4c96d..2e0fdbb730b7b 100644
> --- a/kernel/trace/trace_remote.c
> +++ b/kernel/trace/trace_remote.c
[ ... ]
> @@ -991,6 +994,7 @@ int trace_remote_alloc_buffer(struct trace_buffer_des=
c *desc, size_t desc_size,
>  	desc->struct_len =3D min_desc_size;
> =20
>  	rb_desc =3D __first_ring_buffer_desc(desc);
> +	nr_pages =3D max(DIV_ROUND_UP(buffer_size, PAGE_SIZE - BUF_PAGE_HDR_SIZ=
E), 2UL) + 1;

[Severity: High]
This is a pre-existing issue, but are we exposing the same wrapping
vulnerability here?

Since the same macro is used to compute the actual page allocation loop
bounds, would it duplicate the same integer overflow when calculating the
loop limit for allocating the buffer?

> =20
>  	for_each_cpu(cpu, cpumask) {
>  		unsigned int id;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907192643.4251=
3-1-vdonnefort@google.com?part=3D1
