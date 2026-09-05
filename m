Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F10D24C06A
	for <linux-trace-kernel@vger.kernel.org>; Sat,  5 Sep 2026 11:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788608324; cv=none; b=U3juqF8sQN+PQ65CuEM7mL9+3yifN4uu7J3CpOlDE7WDXzvZayz3wilj/Powi0FaAPG36SnfbFEWQ+ZXr9yJKa83xhMQ8TuYMOD0Q6XQrqHTWyxQFUmm6RbU5cENYr9/o0xxhpEpruKcevARi7+GzF0oDRRgpSNmJVGnzUSGhsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788608324; c=relaxed/simple;
	bh=i23O8iOz3ltxtARdHc3lFAkpzshBshk1QDKqhuNSDlw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nKtWarQCxbY4e76ZzaHGzTnbC/LhM9RnNp+t7MorYBI9M9zzWZ9tqBIq86rb7VPUTy892BvfH2HjbGQBZQE/wBCvTCWS7DEUrZLmDHUhkKijqsu/5wf4uoIzFisqRnp3g2n2b4lkih9fiWlOXOFuNoQ0A0GEzpbIP2lkddYj568=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJzV6/0q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJzV6/0q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7599E1F00A3D;
	Sat,  5 Sep 2026 11:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788608322;
	bh=zwxGLNyODVdBmClo9pdWwuiIcx6d5LwtgJKCLC6BxG8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bJzV6/0qNy9vHFUCBaeXduOu9pmEaqSukzsKgH/V6bDAFNnJppJkTDI+6o/4p68VX
	 UY04Ftt0bVcr3DgoJm8/K8KcHoKNrLiuKGaN5E7E5CHJIh/iEkDyJqYXZZi1ZU/Ahe
	 KqlZC1M+Ri9jK/S33OqmTwdUx5O5/D4KNd9pNp7O5zEb/mHTsYH7n9NHAj1rOHAhQe
	 mBo4EFxQNy+6ZjlCEAKJ7Y+vC6ip6Fmbcz6qDA4v24DAGCHbUMsa2P1SF5XxKiqyDp
	 iwykpcCgZMTQF2cZ6/fgk+p/2GP6KI/51tMLAloTVQ+tqGNvKNI9vgZElC/NUyKF2S
	 PvVHyo3j2SKTQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] tracing: add ring-buffer memory usage statistics in
 tracefs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xiang Gao" <gxxa03070307@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260905112732.3705405-2-gaoxiang17@xiaomi.com>
References: <20260905112732.3705405-1-gaoxiang17@xiaomi.com>
 <20260905112732.3705405-2-gaoxiang17@xiaomi.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 11:38:41 +0000
Message-Id: <20260905113842.7599E1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Compilation failure due to evaluating a struct type in a boolean co=
ntext.
--

commit 59684c76ae178c23d488e6128dbc2d350cbbec1d
Author: Xiang Gao <gxxa03070307@gmail.com>

tracing: add ring-buffer memory usage statistics in tracefs

This commit adds memory consumption statistics for tracing ring buffers to
tracefs. It reports the memory consumed by the main and snapshot buffers
across all instances, tracking the full pages backing the sub-buffers.

> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 5fc009edc1ec9..4579053d34ec4 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c

[ ... ]

> @@ -6526,6 +6526,47 @@ unsigned long ring_buffer_size(struct trace_buffer=
 *buffer, int cpu)

[ ... ]

> +unsigned long ring_buffer_memory_size(struct trace_buffer *buffer, int c=
pu)
> +{
> +	struct ring_buffer_per_cpu *cpu_buffer;
> +	unsigned long subbuf_size;
> +	unsigned long size;
> +
> +	if (!cpumask_test_cpu(cpu, buffer->cpumask))
> +		return 0;
> +
> +	/* Range and remote buffers use externally owned memory. */
> +	if (buffer->range_addr_start || buffer->remote)
> +		return 0;
> +
> +	cpu_buffer =3D buffer->buffers[cpu];
> +	subbuf_size =3D PAGE_SIZE << buffer->subbuf_order;
> +
> +	/* Data sub-buffers plus the reader page. */
> +	size =3D (cpu_buffer->nr_pages + 1) * subbuf_size;
> +
> +	/* The cached read page, if present, is a full sub-buffer page. */
> +	if (cpu_buffer->free_page)

[Severity: Low]
Does this code cause a compilation failure?

The free_page member of struct ring_buffer_per_cpu is an embedded struct
(struct buffer_data_read_page), rather than a pointer. Evaluating it
directly in a boolean context will cause a compiler error because a scalar
value is required.

Should this condition check a field within the struct instead, such as
cpu_buffer->free_page.data?

> +		size +=3D subbuf_size;
> +
> +	/* The mmap metadata page is a single system page. */
> +	if (cpu_buffer->meta_page)
> +		size +=3D PAGE_SIZE;
> +
> +	return size;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905112732.3705=
405-1-gaoxiang17@xiaomi.com?part=3D1
