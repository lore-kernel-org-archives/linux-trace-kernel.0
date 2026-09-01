Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51B7485CDD
	for <linux-trace-kernel@vger.kernel.org>; Tue,  1 Sep 2026 16:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788280537; cv=none; b=IBew6QALXSteTST9jBAorjoaIbIe6UsdnKW5aeHp648yUrhpn0JcS2bMU4qyKQOCfm31tMdF8Cd8tsqsZM6KbagIhaIUowq3ZDQo/DF+a2xfMG3gWlL4+CiWV5d36rqxPcgjBx6dAWphGUXT+vBdPUIU2g9f4pS3dWIZAK9YZ0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788280537; c=relaxed/simple;
	bh=c7dGkGTCcrrjE4ZJA25GPNmzM3Y8ze07SBJhDWAG7SI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fxV+0YbJLy5Vik2VOtlXg4RQcp/lTAQB3++Y8mPZ8erL1W+1nBkL6zfBH5AZKivmKXnMvGYV/TcNgCbDxtwqqRTN1FisyYfNIgho+iyzxrYXgBKC6pLYki2Pmp7RLNrTnD3kyGLO+1j+KMrQqU0XP5KZV5ErWDiz4mmPGPquQuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=litvB0pR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="litvB0pR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A4D51F000E9;
	Tue,  1 Sep 2026 16:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788280535;
	bh=LHxZeHUl2fHi5QxJJEOedKDVl6Ac20sQq0pshd5jFdE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=litvB0pRhuExCvJ2fHlLPhf9LfbYM9dxXrrX2MGCPKvWZaZKTwzndDUVx6Z3JAj1k
	 eOOKfo7hTZQdsSEGb9jZFAgW1BHKARaS3+ISIhZCHlMmFiaHbhxuGKZGzZw9RJAqwL
	 pzrtFcfXwzyv+8ynuyOFKKCohHa/L8ctxlkhHQd5S7kNYNg/nVEFQIQRhcki4OPrba
	 spoLS8fqNAWz/sNyxO+UUlYM3dBFggPFKqTUXJjiw8+g8cpf2Ywps049ISpm0B1CaQ
	 JC34Yr5zQkzyNBPw96QwU4xm50I8iRSnAnXLRr4u8UH1dJwohPKfNZMUyktwZxLD6y
	 keV8ZtOY4hI+g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 3/4] ring-buffer: Cap static ring buffer nr_pages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Donnefort" <vdonnefort@google.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260901155445.1475405-4-vdonnefort@google.com>
References: <20260901155445.1475405-1-vdonnefort@google.com>
 <20260901155445.1475405-4-vdonnefort@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 16:35:34 +0000
Message-Id: <20260901163535.4A4D51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Potential integer underflow in nr_pages calculation is not caught =
by the new static limit on 32-bit systems, allowing bounds-check bypass and=
 memory corruption.
--

commit bfd768f8d8a3d8fc68b36abf088742ebd0904911
Author: Vincent Donnefort <vdonnefort@google.com>

ring-buffer: Cap static ring buffer nr_pages

This commit introduces a limit on the number of pages for static ring
buffers to ensure they fit into the 31-bit bpage::id field. The limit is
enforced on ring buffer creation or user-mapping.

> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c

[ ... ]

> @@ -2842,6 +2851,10 @@ static struct trace_buffer *alloc_buffer(unsigned =
long size, unsigned flags,
>  		 */
>  		nr_pages =3D (size - sizeof(struct ring_buffer_cpu_meta)) /
>  			(subbuf_size + sizeof(int));
> +
> +		if (nr_pages > rb_static_max_pages())
> +			goto fail_free_buffers;
> +

[Severity: High]
This is a pre-existing issue, but does this new check fully protect 32-bit
systems from an integer underflow here?

If an administrator specifies a small ring buffer size (e.g., < 40 bytes)
via the trace_instance boot parameter, the calculation
size - sizeof(struct ring_buffer_cpu_meta) will underflow.

On 32-bit systems, this underflow results in a huge unsigned value that,
when divided by subbuf_size, yields an nr_pages value around 1,047,552.
This easily passes the new rb_static_max_pages() limit of (1UL << 31) - 1.

Later in alloc_buffer(), the pointer calculation wraps around the 32-bit
address space:

        for (n =3D 0, ptr =3D buffers_start; n < nr_cpu_ids; n++) {
                ptr +=3D sizeof(struct ring_buffer_cpu_meta) +
                        sizeof(int) * nr_pages;
                ptr =3D ALIGN(ptr, subbuf_size);
                ptr +=3D subbuf_size * nr_pages;
        }
        if (ptr > end) {

Because of the wrap around, it bypasses the physical bounds check=20
if (ptr > end) and proceeds to rb_range_meta_init(), which then executes=20
a negative-length memset and panics the kernel.

While this patch successfully catches the underflow on 64-bit systems
because the massive nr_pages exceeds the 31-bit limit, 32-bit systems
remain exposed. Could we add an explicit check to ensure size is larger
than sizeof(struct ring_buffer_cpu_meta) before the subtraction?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901155445.1475=
405-1-vdonnefort@google.com?part=3D3
