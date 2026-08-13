Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620734772B0
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Aug 2026 13:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786629375; cv=none; b=KuT8W7L/Q5NS29qRDQO3xkkNyY0iWPgVT/3yJVtfS7thtLwSuJ7szJYOYV99JLeD9GQ3xL8zIUn1vWN8PLGR5n6MkA44pW5fal237Z6XoP1oJ8PK8d94o7uH/9wf+/VGdzX+Ci3qNifG4rPB3+1B36vL9YVEMFRK/6h//UTSsSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786629375; c=relaxed/simple;
	bh=ch2m4n9o9CoTNFxw/eK2RhpOt1eLyR2YGeyqD54VlEI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r/vQP2mYrbdF1HSGUJDJwU5QIWUPth5uXTedGbD7rZ3wvZXa/cN6sYZ9r9oxbAgGdLf8x+lWieUin5ni4nQu7kHcB3dEpMmhjIc12fUEYsehnSYUUk3QJiCY6DPeuexjQ7y4WiNit8Gn/kmTb3vxJPqwdu+unCKhbphtzOXw06c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8BZw6qp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8BZw6qp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD3A11F00A3A;
	Thu, 13 Aug 2026 13:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786629373;
	bh=jtp+ExyN0nAS7Uzl9OZ17n755pIps8XjzAvXAoQkA2E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J8BZw6qpurWYVIMQFJjRreuUg6sDy1f6o2jgikWC+KqyJRVa6D4TyO3z6AZOCjt/z
	 fe+BF5CVPbQr2nd4XD7W1+gdu+qThLOLIwY+LSZMamghDEDaK1fesEi+AMgRveCyC6
	 CukzrcvqbN9lLQa/DOhDS6gqECYWOCUOIhwJXWb3OEfuvKmwTxRc6w9yP434vs0qLR
	 PRSq7VJjBSyp2DRH+JWc1j1C6QDzgowxkvxvCZstDpit+IqQ8T0HzYto+yTghNIV56
	 mIC1rEwlMTfrkN++LLi90o4t67i4r1o+ctnPsWlPMSypU5Aor4qV7+ahmqHZE76E0K
	 XSvIT3BVjejdA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 03/10] ring-buffer: Make cpu_buffer::free_page a
 buffer_data_read_page
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Donnefort" <vdonnefort@google.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260813131152.3589632-4-vdonnefort@google.com>
References: <20260813131152.3589632-1-vdonnefort@google.com>
 <20260813131152.3589632-4-vdonnefort@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 13:56:13 +0000
Message-Id: <20260813135613.BD3A11F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] `ring_buffer_alloc_read_page()` returning a cached page with an ob=
solete order causes `tracing_buffers_read()` to permanently return EOF to u=
serspace.
--

--- Patch [3]: [PATCH v5 03/10] ring-buffer: Make cpu_buffer::free_page a b=
uffer_data_read_page ---
commit 19f06657067d8dbcf108f6bacc6885d031739166
Author: Vincent Donnefort <vdonnefort@google.com>

    ring-buffer: Make cpu_buffer::free_page a buffer_data_read_page

This commit changes the free_page cache to store the page order alongside
the page address. This fixes a mismatch when a cached reader page is
discarded after a concurrent ring buffer resize changes the global
subbuf_order.

> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index ec4f5a0c93e85..b6fa258aafe2c 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
[ ... ]
> @@ -6962,9 +6962,9 @@ ring_buffer_alloc_read_page(struct trace_buffer *bu=
ffer, int cpu)
>  	local_irq_save(flags);
>  	arch_spin_lock(&cpu_buffer->lock);
> =20
> -	if (cpu_buffer->free_page) {
> -		bpage->data =3D cpu_buffer->free_page;
> -		cpu_buffer->free_page =3D NULL;
> +	if (cpu_buffer->free_page.data) {
> +		*bpage =3D cpu_buffer->free_page;
> +		cpu_buffer->free_page.data =3D NULL;

[Severity: High]
Does this struct assignment cause tracing_buffers_read() to permanently
return EOF to userspace during a concurrent resize?

When a resize happens in ring_buffer_subbuf_order_set(),
buffer->subbuf_order is updated first:

	buffer->subbuf_order =3D order;

	/* Make sure all new buffers are allocated, before deleting... */
	for_each_buffer_cpu(buffer, cpu) {

This opens a large race window before cpu_buffer->free_page.data is
cleared for each CPU.

If a user reads from trace_pipe_raw during this window,
ring_buffer_alloc_read_page() allocates bpage and initially sets
bpage->order to the new buffer->subbuf_order. However, the struct
assignment *bpage =3D cpu_buffer->free_page copies the old free_page,
overwriting bpage->order with the old order.

Later in tracing_buffers_read(), the caller caches this mismatched page
and sets spare_size to the new size:

		} else {
			info->spare_cpu =3D iter->cpu_file;
			info->spare_size =3D page_size;
		}

Because the orders don't match, ring_buffer_read_page() rejects the page:

	if (data_page->order !=3D buffer->subbuf_order)
		return -1;

This returns -1, which tracing_buffers_read() treats as EOF. Subsequent
reads see info->spare_size =3D=3D page_size, reuse the bad page, and
permanently return EOF.

>  	}
> =20
>  	arch_spin_unlock(&cpu_buffer->lock);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813131152.3589=
632-1-vdonnefort@google.com?part=3D3
