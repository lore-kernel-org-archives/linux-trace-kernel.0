Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DD647010C
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Aug 2026 14:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786629664; cv=none; b=gaWWsXgPy3BJo6u8DfNPoxykonh6auUnp2cPq5hs/EJ52NAQfdyPRP7emeNPBqrJfQlpO6AhibmncCqXVEP4W6KgWrRmBxYEDONgjsG7t0dgPe9kFgKT9dhzvgK1MIs6EH/0gBVKdluBPK25cxeZw+AARpnMqkgmRywHLbJCJOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786629664; c=relaxed/simple;
	bh=GJ5DDp9SEDXzT1x1BWAFTX885EkPyknLYhkQNnzhic0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pg+bhCAr97YsI6g3TzTxh4u/QDCzkTvJQMjkNtdI8CP+n2wTcYk1wYj0jlI8S05rLaaO6ISmsGhXFy+vvoNGAr0VyBiWgBsuiPU49ckmz+72T1BnugNM2edremcnkrHhfsvO7OroljHMgabLy+fKpeYW9yiq+Ld4YxaaB+Efilg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jhUFkGmk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jhUFkGmk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AA1C1F00A3A;
	Thu, 13 Aug 2026 14:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786629662;
	bh=jajIPAKnNd+yeRSxcSvaJ6TnlWr0Q0apVOv7fTUGxRA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jhUFkGmkipGsN+elYUTVI0YdPYlSNRz5Kjx1w80cma5v7DqqfJPrV9i6Ac84SFtrp
	 SXZOIyYDf+pc/7+KQkfwCJmnqWHNH1BhNSmIOOlRRQXvFd0mjJROzSfWa2POAqkyda
	 srdmYaElqKy1iwyAvZ6eJgYCi/qqTTLI6txhfrqTOZCk8KyJVBMll/ki8mbg1ooaw5
	 FHFoemrqHRMMGg4CoPI7Lzn6428UfcTJWFB61pMyYAmLLIRGEtaBJhNtAaKXw38pbZ
	 IMPd1QkcZYy3IgDcBk3IGz8ugfXQgVmWGkUWVslL0RKwZTGC5dAGrMQR7xvDqtEuDH
	 8pvR5/MD8Su3Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 02/10] ring-buffer: Hold cpu_buffer::lock when
 resizing a subbuf
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Donnefort" <vdonnefort@google.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260813131152.3589632-3-vdonnefort@google.com>
References: <20260813131152.3589632-1-vdonnefort@google.com>
 <20260813131152.3589632-3-vdonnefort@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 14:01:01 +0000
Message-Id: <20260813140102.6AA1C1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Race condition during ring buffer resize leads to mismatched s=
ubbuffer order, causing heap overflow and buddy allocator corruption.
--

--- Patch [2]: [PATCH v5 02/10] ring-buffer: Hold cpu_buffer::lock when res=
izing a subbuf ---
commit b0f06308baef769af600659941453301acb7bea1
Author: Vincent Donnefort <vdonnefort@google.com>

ring-buffer: Hold cpu_buffer::lock when resizing a subbuf

This commit adds locking around the clearing of cpu_buffer->free_page in
ring_buffer_subbuf_order_set() to prevent races with readers allocating
or freeing read pages.

> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index a3d28b2e2c94a..ec4f5a0c93e85 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -7431,8 +7431,10 @@ int ring_buffer_subbuf_order_set(struct trace_buff=
er *buffer, int order)
>  		cpu_buffer->nr_pages =3D cpu_buffer->nr_pages_to_update;
>  		cpu_buffer->nr_pages_to_update =3D 0;
> =20
> +		arch_spin_lock(&cpu_buffer->lock);
>  		old_free_data_page =3D cpu_buffer->free_page;
>  		cpu_buffer->free_page =3D NULL;
> +		arch_spin_unlock(&cpu_buffer->lock);

[Severity: Critical]
This is a pre-existing issue, but does adding this lock fully close the race
window with ring_buffer_alloc_read_page()?

Looking at ring_buffer_subbuf_order_set(), buffer->subbuf_order =3D order; =
is
set much earlier in the function, before allocating the new pages for each
CPU.

During this window, a concurrent reader calling ring_buffer_alloc_read_page=
()
can see the new global order but still claim the old, smaller free_page
from the per-CPU buffer:

ring_buffer_alloc_read_page() {
    bpage->order =3D buffer->subbuf_order; // gets new, larger order
    ...
    if (cpu_buffer->free_page) {
        bpage->data =3D cpu_buffer->free_page; // gets old, smaller page
        cpu_buffer->free_page =3D NULL;
    }
}

Later, if ring_buffer_free_read_page() is called, it will use the mismatched
bpage->order to free the old page, corrupting the buddy allocator.

Similarly, if ring_buffer_read_page() swaps this undersized page into the
ring buffer, producers will overflow the heap.

Should buffer->subbuf_order be updated after the per-CPU free pages are
safely cleared or replaced?

> =20
>  		rb_head_page_activate(cpu_buffer);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813131152.3589=
632-1-vdonnefort@google.com?part=3D2
