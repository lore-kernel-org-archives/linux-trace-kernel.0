Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEC72E7F39
	for <linux-trace-kernel@vger.kernel.org>; Fri, 11 Sep 2026 16:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789142643; cv=none; b=F5+ZfkCvdDMXGLIHI0MTd9tRuSbqBCB3atJ3NmoCaaUvmnLBGR1Ez1rIcLt0SfSymfOwvrVP6wbe+/iYCeXhneUoFuE8XNLSQkttQ4G4AEp922Mi4Ora8vvAUQjOBaeCPvzaucTi+0wiHkjz9Ynu8nRwcekHXNXOCN8n1mqdqP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789142643; c=relaxed/simple;
	bh=TzhXSUyC+YT7sZPZoc+ZofKh6sYTPNX4cJRtMjQl9Os=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Kx7GwkVPrJfs1nHLGpnFpNmY/QDMDNmbr5b83IC4Nw/TOBMksoAnZzy0T5TTwl0dKjm5i3EgDkPnmf+ji1kJaZ9Qh997kd1tzjVlP2IJOEYeffvN9C82lNLIr0GdPo4nu6dqRB74UHmkbXTrd6vsUqik+mt2HYXCmkd9PuOAqLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cWGCA8Ur; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cWGCA8Ur"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 917071F000FF;
	Fri, 11 Sep 2026 16:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789142641;
	bh=++FlJyVVW7K3nHa8uMo5N4ycPjKluZj3OHRZPoTJfWE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cWGCA8UrD67mPgOauuAwhIGRUhyatdg+hczr8Mz6+VXdAE1oM7RhS6TYaNlC3Uc7M
	 R4D+7GdioMsnf174AEbQEL4ZHG/2K3U448VOib9rczXaGV1zVtKQefJbz578fzGB1V
	 o7PQS9MM899X8Sn6a4fi/f2DIm2YyvdR7l3tfBOkQiteI0S/A79x6KeZPKVL/PkwEc
	 T+4KVktFt6knBEm1nwj2PWnKgHB82A/61qFCrQtCgLPi0l00aE92tGWRv0wgVP3hmO
	 4LhyhNBzYSgpEMd/2UnqtN25uaViuwTGOxF4E3PZCUw+Gso507BX4JwZErqmstnuNS
	 1viaILqr8wMvg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] tracing: add ring-buffer memory usage statistics
 in tracefs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xiang Gao" <gxxa03070307@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260911155017.3377254-2-gaoxiang17@xiaomi.com>
References: <20260905112732.3705405-1-gaoxiang17@xiaomi.com>
 <20260911155017.3377254-1-gaoxiang17@xiaomi.com>
 <20260911155017.3377254-2-gaoxiang17@xiaomi.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 16:04:01 +0000
Message-Id: <20260911160401.917071F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Persistent memory-mapped trace buffers are incorrectly accounted=
 as page-allocator memory, leading to double-counting in lost RAM calculati=
ons.
- [Low] Evaluation of a struct type as a boolean condition causes a hard co=
mpilation error.
--

commit 339a95b19ea8f13ff179992c9814bfee94fa38b3
Author: Xiang Gao <gxxa03070307@gmail.com>

tracing: add ring-buffer memory usage statistics in tracefs

This commit adds memory usage reporting for tracing ring buffers to calcula=
te
memory footprint more accurately than relying on buffer capacity. It exposes
a new memory_usage_kb file in tracefs which sums up the page allocator memo=
ry
used by the data pages and reader pages.

> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 9c03a555a6ba2..73e79c86035c2 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
[ ... ]
> @@ -6560,6 +6560,47 @@ unsigned long ring_buffer_size(struct trace_buffer=
 *buffer, int cpu)
>  }
>  EXPORT_SYMBOL_GPL(ring_buffer_size);
> =20
> +/**
> + * ring_buffer_memory_size - return the memory used by the buffer (in by=
tes)
[ ... ]
> + */
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
> +	/* Remote buffers use externally owned memory. */
> +	if (buffer->remote)
> +		return 0;

[Severity: Medium]
Does this check also need to exclude persistent memory-mapped trace buffers
where buffer->range_addr_start is set? Since those buffers also use
externally owned or reserved memory bypassing the page-allocator, not
skipping them here might result in double-counting their memory in lost
RAM calculations.

> +
> +	cpu_buffer =3D buffer->buffers[cpu];
> +	subbuf_size =3D PAGE_SIZE << READ_ONCE(buffer->subbuf_order);
> +
> +	/* Data sub-buffers plus the reader page. */
> +	size =3D (cpu_buffer->nr_pages + 1) * subbuf_size;
> +
> +	/* The cached read page, if present, is a full sub-buffer page. */
> +	if (cpu_buffer->free_page)
> +		size +=3D subbuf_size;

[Severity: Low]
Does evaluating cpu_buffer->free_page directly as a boolean condition
cause a compiler error here, since free_page is an embedded struct
(struct buffer_data_read_page) rather than a pointer? Should this check its
internal data pointer instead, such as if (cpu_buffer->free_page.data)?

> +
> +	/* The mmap metadata page is a single system page. */
> +	if (cpu_buffer->meta_page)
> +		size +=3D PAGE_SIZE;
> +
> +	return size;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911155017.3377=
254-1-gaoxiang17@xiaomi.com?part=3D1
