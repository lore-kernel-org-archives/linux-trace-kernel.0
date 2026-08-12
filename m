Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884E12045AD
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 15:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786550204; cv=none; b=qIQ75c5SP3+9KQ5vruAlzn4l0baaN9CBc0jp6uGPtq4Na47omUSpOTyxz7CCxiorHDX6KDCBPyMRriSbWS7tJVx0IKDFizRPHEuXHXXu7Cz/XI6amwlozk5OYwf3Nw1Y+sM0gLSLMa/vm9zSYTQZxKzocfk+Nfcwq1k12tZGFfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786550204; c=relaxed/simple;
	bh=EaUKbF5RZ3WFlP/1JzmNFLPxjRuQ6JVGrkR3oA7YjSU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y6bdiBb1D9ltM8ybogIBH2IsDdv19eeNv8dSUd3WsYmnu1Nhkny3OCXClBay5oNTT9b5vLrB2L1X7cax7PH8DDrXzYyeCProANHyGaV+fjCY/2G5a7h+O+8sPIfgwcT/P2Q07LdMijU33IDCjJJqEfPN73fvEXUVTEUIyZubC0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EAejKfJx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EAejKfJx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A6D71F000E9;
	Wed, 12 Aug 2026 15:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786550203;
	bh=COae/Ley4u52IOteiX2roidTVK1mdJAxoUuwrd029L8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EAejKfJxZPpU9n7/PsnGoiMTiqQPO9c7Tb7OAbI+/CSBBMRfRh88VPeSqxC2pCpot
	 btCxNNaCbDOsfGqj5ZTSK6rtLc2TV+cXZd8LTKr0ifAuTcXhZ/cNlM+dSlYbXX20Di
	 IpUEMUkT8EgAPwj+edbEATTG2ihZaCkAj1EVQq22SEjsT0erDq/IFVeovYUOmwQsSw
	 YX9pc6rlpEEV3e8KQ6YTgULG3in6q7QgvN4MbbIta/Z/FV0KACaJpKDi4pS+kcOR6Y
	 BlrKfS3yZFIIuem5gDq43wDzrl7nfNQf9uU8KeJMudAuS/q/tk5g8ZO6q/h06SrmpP
	 aF9dZLSQ0J3yg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 6/9] ring-buffer: Dynamically calculate max_data_size
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Donnefort" <vdonnefort@google.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260812153311.2328812-7-vdonnefort@google.com>
References: <20260812153311.2328812-1-vdonnefort@google.com>
 <20260812153311.2328812-7-vdonnefort@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 15:56:42 +0000
Message-Id: <20260812155643.1A6D71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Concurrent execution of ring_buffer_alloc_read_page() and ring=
_buffer_subbuf_order_set() leads to buddy allocator corruption and potentia=
l OOB memory access due to a mismatched page order when taking cpu_buffer->=
free_page.
--

--- Patch [6]: [PATCH v4 6/9] ring-buffer: Dynamically calculate max_data_s=
ize ---
commit a7794ac711440e6d89d8e099e4a88707ad083ed7
Author: Vincent Donnefort <vdonnefort@google.com>

ring-buffer: Dynamically calculate max_data_size

The ring buffer order can be dynamically modified and temporarily
disables writing to do so. It is therefore safe to use the updated value
to calculate the maximum event size which can be written onto the ring
buffer.

> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index f62d6853ee5c0..64bf4ac853f57 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -598,7 +598,6 @@ struct trace_buffer {
>  	struct ring_buffer_meta		*meta;
> =20
>  	unsigned int			subbuf_order;
> -	unsigned int			max_data_size;
>  };
> =20
>  static __always_inline unsigned int rb_subbuf_size(struct trace_buffer *=
buffer)

[ ... ]

[Severity: Critical]
This is a pre-existing issue, but can concurrent execution of
ring_buffer_alloc_read_page() and ring_buffer_subbuf_order_set() lead to bu=
ddy
allocator corruption and potential out-of-bounds memory access?

When a user reads /sys/kernel/tracing/per_cpu/cpuX/trace_pipe_raw, it calls
ring_buffer_alloc_read_page(). If another thread concurrently resizes the r=
ing
buffer via /sys/kernel/tracing/buffer_subbuf_order, it calls
ring_buffer_subbuf_order_set().

In ring_buffer_subbuf_order_set(), buffer->subbuf_order is updated lockless=
ly
with respect to the reader:

kernel/trace/ring_buffer.c:ring_buffer_subbuf_order_set() {
    ...
	buffer->subbuf_order =3D order;

	/* Make sure all new buffers are allocated, before deleting the old ones */
	for_each_buffer_cpu(buffer, cpu) {
    ...
}

Before ring_buffer_subbuf_order_set() reaches its second loop to clear
cpu_buffer->free_page, ring_buffer_alloc_read_page() can fetch the new
order, grab the old page from cpu_buffer->free_page, and assign the new
order to bpage->order:

kernel/trace/ring_buffer.c:ring_buffer_alloc_read_page() {
    ...
	if (cpu_buffer->free_page) {
		bpage->data =3D cpu_buffer->free_page;
		cpu_buffer->free_page =3D NULL;
	}
    ...
}

When this page is later freed or swapped into the ring buffer, could this
cause memory corruption because writers believe the subbuffer size is the
new order, leading them to overwrite past the old order page?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812153311.2328=
812-1-vdonnefort@google.com?part=3D6
