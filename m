Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA88476CEB
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Aug 2026 13:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786629328; cv=none; b=tfYdK6MrmvUb/KBjjupDu8PfYeujjq4DZ+9Nwx/WVT6v2/xlraVDYc4f8lig3/T09vCTA7tOG5nxMWEE+6vIFV/iOroNPtnw1nYF2T1RQ8rVnPi8MjTByZB/Qh10nShpWJcqHXW57tXME/Ng7BF70niT2EbA16+fUvW0bLaJsAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786629328; c=relaxed/simple;
	bh=Aps5dTXGjSkrn4kMCRHqVuAZeO9Iz0iw8WOANvjtXZo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=A0KLPUHUAXduyCFGWyjZCoBJOE8VJRbZ9QTnd/9z9G6OGFeZGsN6AJrE1Uoy2OJMSSBGPFIXsZYDENLIY7MnH4sf/q7LkwWIq4oMC+NR3zuIlp/1Xyf24KC+zWBg0UMgVccbA14SsdnyVIGy4T6IHE29wojQjGrlaXpgjPw3Lh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fdX79nG/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fdX79nG/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF9CF1F000E9;
	Thu, 13 Aug 2026 13:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786629327;
	bh=37N9euT9+6NP48QpVQ803FmwfTFFCpvFW5YXm8o/XeI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fdX79nG/lv6v9nLyweYzB7YC309osQypZguD5zDZT+w6rP9SCdl/w+yDnm1m9ZQiH
	 KMX8Chd+x68qAx+Qi3Jbl1fdjR0SeUptWpVupuB5ImfF8vOOqcxdEEzqVo/qpz4y6U
	 SdKlxl34QH4keZ1rVCcxYe10zBZLOZhThbf6VoF2p7RXgFObAfOy0aw/vJfb0w46n6
	 OvyQZj8k+imaRMlLNI8+vA/AA4Npo6TvPAehegR7vf4VSBZduAfLWVDOye6bI7lEyB
	 eMXrfSSA5OZ1CoMuTG4Yqs2yvTYgkHHr2lONbY4eaAxW4B0lQRMjncJw+KEDz9osIA
	 P0TVrqXFeYquw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 10/10] ring-buffer: Make nr_pages unsigned int
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Donnefort" <vdonnefort@google.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260813131152.3589632-11-vdonnefort@google.com>
References: <20260813131152.3589632-1-vdonnefort@google.com>
 <20260813131152.3589632-11-vdonnefort@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 13:55:26 +0000
Message-Id: <20260813135526.EF9CF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Integer overflow in ring_buffer_resize() allows an attacker to=
 bypass allocation checks and trigger a massive out-of-bounds ring buffer s=
hrink, leading to a Use-After-Free.
- [Medium] 32-bit shift overflow in __rb_map_vma() truncates the mapped pag=
e count for huge ring buffers, causing mmap to fail.
--

--- Patch [10]: [PATCH v5 10/10] ring-buffer: Make nr_pages unsigned int ---
commit 25e7b6bfdf3741f228ceb9dc41c8bbf6e253f525
Author: Vincent Donnefort <vdonnefort@google.com>

ring-buffer: Make nr_pages unsigned int
   =20
nr_pages is an int or unsigned int almost everywhere already. Also, all
the meta-data ring_buffer_desc, ring_buffer_cpu_meta and
trace_buffer_meta allowing to share information about the ring buffer
are already capping this value to 32-bits.

> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 79459c99ce9a0..d9dcd6d4e7cc4 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -561,7 +561,7 @@ struct ring_buffer_per_cpu {
>  	struct ring_buffer_remote	*remote;
> =20
>  	/* ring buffer pages to update, > 0 to add, < 0 to remove */
> -	long				nr_pages_to_update;
> +	int				nr_pages_to_update;
>  	struct list_head		new_pages; /* new pages to add */
>  	struct work_struct		update_pages_work;
>  	struct completion		update_done;

[ ... ]

> @@ -3264,7 +3263,7 @@ int ring_buffer_resize(struct trace_buffer *buffer,=
 unsigned long size,
>  			int cpu_id)
>  {
>  	struct ring_buffer_per_cpu *cpu_buffer;
> -	unsigned long nr_pages;
> +	unsigned int nr_pages;

[Severity: Critical]
If a huge value is written to buffer_size_kb, could the unsigned
difference between nr_pages and cpu_buffer->nr_pages overflow when
assigned to the now 32-bit signed cpu_buffer->nr_pages_to_update?

Later in this function, we do:

    cpu_buffer->nr_pages_to_update =3D nr_pages - cpu_buffer->nr_pages;
    if (cpu_buffer->nr_pages_to_update <=3D 0)
        continue;

If the difference overflows into a negative integer, wouldn't it skip this
allocation limits check but still schedule the worker thread (since it is
non-zero)?

The worker thread calls rb_update_pages():

    success =3D rb_remove_pages(cpu_buffer, -cpu_buffer->nr_pages_to_update=
);

This would pass a large positive count to rb_remove_pages(). As it wildly
wraps around the small circular list:

    for (nr_removed =3D 0; nr_removed < nr_pages; nr_removed++) {
        to_remove =3D rb_list_head(to_remove)->next;
        head_bit |=3D (unsigned long)to_remove & RB_PAGE_HEAD;
    }

Could this unlink and double-free actively used pages, leaving ring buffer
structures pointing to freed memory and causing a use-after-free?

>  	int cpu, err;
> =20
>  	/*

[ ... ]

> @@ -7708,8 +7708,8 @@ static int __rb_inc_dec_mapped(struct ring_buffer_p=
er_cpu *cpu_buffer,
>  static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
>  			struct vm_area_struct *vma)
>  {
> -	unsigned long nr_subbufs, nr_pages, nr_vma_pages, pgoff =3D vma->vm_pgo=
ff;
> -	unsigned int subbuf_pages, subbuf_order;
> +	unsigned long nr_pages, nr_vma_pages, pgoff =3D vma->vm_pgoff;
> +	unsigned int nr_subbufs, subbuf_pages, subbuf_order;

[Severity: Medium]
Since nr_subbufs is now an unsigned int, could the bitwise shift operation
later in this function silently truncate for exceptionally large ring buffe=
rs?

__rb_map_vma() later computes:

    nr_pages =3D ((nr_subbufs + 1) << subbuf_order) - 1;

Because the operands are now 32-bit, the shift is computed entirely in
32-bit math before assignment to the unsigned long nr_pages.=20

If a buffer is large enough to overflow 32-bits, will this cause bounds
checks to fail and mmap to return -EINVAL?

>  	struct page **pages __free(kfree) =3D NULL;
>  	int p =3D 0, s =3D 0;
>  	int err;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813131152.3589=
632-1-vdonnefort@google.com?part=3D10
