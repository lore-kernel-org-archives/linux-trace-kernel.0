Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C313019A9;
	Fri, 16 Oct 2026 13:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792158746; cv=none; b=ZuFBoL28VhPC5QODqLJ4Hg2NimtgwhUyB7/rYbt+lAB21OEU5VRo72MsIQvsYemj4/a176JaLABf61BhngWl3LVBIZdO1p0S3j1igJ/dgEihLDit4D7ncyIIDzXo3H4vGHWL5eDjUqGxHalV4zajUElHjet2SYKGDOWxO9sS6zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792158746; c=relaxed/simple;
	bh=x8ixfYCeBxcWJG8wmxGyuCi0Er2FjsK4suizocaFIwQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=FJe5fQVRHdNTgmrXBdMympyzPVkEIEd21Oqk2l3Ew5LXroAHwKO/k3KuL970T86o0BctAzPL6Qp0AjcqIQX0YCupDK6CA2F/bvYNZ0tP3tjN1b6dG2BqlADWyI7jmt2bt8YpwWKtc7nMzRJqWd7/n+D4KrP5JqN4fbuVd+J9Fsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ko+TqwJN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ko+TqwJN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3EA71F000C4;
	Fri, 16 Oct 2026 13:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792158745;
	bh=g7bfjPOfLeDj0DiLcofzTar8DP7jmKGvhjriI0QbT28=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ko+TqwJNlzXU7bQPMwHAdHbwdiZnsatYDjbnYz7A4Qq/9axutcVCwshFWsO6Ekqwq
	 5epomeW/jjSknb0OGVAoj/2T3Z+PlmZavqBAKDBOzYaq5SrUIpa4CQe66O2WPq8wvk
	 FKuNNRX2fdUEFVj4pptbPhOSzdnT7BHDZkCGND9gEetl5DQzGwLAXKEtqjmgUBWNVG
	 DMNQH2NkrKZHkIkTPOYdS25zLz3QBsf3ol1Ix4swDa9vd99CDqOLGws9xmkh+Vs/an
	 xf/PQ0NRNXjLTHGXe/DEGgVXiOUqH40RH8Yid3NJ0yrssdH/dqqGf1FkkZAqvN7bkc
	 e5qrEe2PAjznQ==
Message-ID: <sashiko-outbox-174412@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] ring-buffer: Do not check si_mem_available() before
 deferred init completes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amit Machhiwal" <amachhiw@linux.ibm.com>, linux-trace-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org
In-Reply-To: <20261016134247.70722-1-amachhiw@linux.ibm.com>
References: <20261009163557.88467-3-amachhiw@linux.ibm.com>
 <20261016134247.70722-1-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 13:52:24 +0000
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] mm/trace: OOM panic via GFP_KERNEL metadata allocations
--

commit 5164ff519a3f7b78b5e2f07fc662c8cbbef0267e
Author: Amit Machhiwal <amachhiw@linux.ibm.com>

ring-buffer: Do not check si_mem_available() before deferred init completes

During early boot, si_mem_available() can return a false negative on kernels
built with CONFIG_DEFERRED_STRUCT_PAGE_INIT. Skip the si_mem_available()
check until SYSTEM_FREEING_INITMEM, when deferred pages are fully
initialized.

Link: https://lore.kernel.org/all/arYskzbiaNzBR9MD@kunlun.suse.cz/

> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 04bb94c29f587..aa877a272c894 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -2452,10 +2452,24 @@ static int __rb_allocate_pages(struct ring_buffer=
_per_cpu *cpu_buffer,
>  	 * memory. It may not be accurate. But we don't care, we just want
>  	 * to prevent doing any allocation when it is obvious that it is
>  	 * not going to succeed.
> +	 *
> +	 * With CONFIG_DEFERRED_STRUCT_PAGE_INIT, NR_FREE_PAGES only reflects
> +	 * the initial non-deferred pool during early boot and throughout SMP
> +	 * bring-up (smp_init() runs before page_alloc_init_late() completes
> +	 * deferred initialization). si_mem_available() returns a false negative
> +	 * across this entire window while actual allocations succeed by growing
> +	 * the zone on demand via deferred_grow_zone(). Only re-enable the check
> +	 * from SYSTEM_FREEING_INITMEM onward, after page_alloc_init_late() has
> +	 * finished and si_mem_available() is accurate.
>  	 */
>  	i =3D si_mem_available();
> +#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
> +	if (system_state >=3D SYSTEM_FREEING_INITMEM && i < nr_pages)
> +		return -ENOMEM;

[Severity: High]
Does bypassing the si_mem_available() check during early boot expose the
kernel to an out of memory panic?

By skipping this check, __rb_allocate_pages() will proceed to the allocation
loop even if the requested nr_pages exceeds available memory. The loop
contains metadata allocations via alloc_cpu_page():

kernel/trace/ring_buffer.c:__rb_allocate_pages() {
    ...
    for (i =3D 0; i < nr_pages; i++) {
        bpage =3D alloc_cpu_page(cpu_buffer->cpu);
        if (!bpage)
            goto free_pages;
    ...
}

alloc_cpu_page() uses GFP_KERNEL without __GFP_RETRY_MAYFAIL:

#define alloc_cpu_page(cpu) (struct buffer_page *)          \
    kzalloc_node(ALIGN(sizeof(struct buffer_page),          \
               cache_line_size()), GFP_KERNEL, cpu_to_node(cpu))

If the loop exhausts the buddy allocator, won't the slab allocator's
subsequent attempt to allocate a new page for the metadata struct using
GFP_KERNEL trigger a kernel panic during early boot?

> +#else
>  	if (i < nr_pages)
>  		return -ENOMEM;
> +#endif
> =20
>  	/*
>  	 * If a user thread allocates too much, and si_mem_available()

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016134247.7072=
2-1-amachhiw@linux.ibm.com?part=3D1
