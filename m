Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4A5495036
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Aug 2026 16:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786638613; cv=none; b=f1nbetvqzl8572BmTq4MnsPqdrdXTcbhe0SETknBPDDJ4+s06D0PK9+9KhtwfpniXDuqw/aA+mZkmU/MmVy8plEJvg9f+1LOOKbrCl464rh9b0I6wJZK7fHjLTZvnctOkpstIizQxnKpiohRzYh97ShzGyzykDJAE8oqQ+Bb4Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786638613; c=relaxed/simple;
	bh=tPcwVL1dcbHW9FMH5PfsaG7hpzCrErea9417fqDLAD4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZxzUsq5kFO3IIp9mTXa+OC6at9AeyNiRAa2u5xhk3oY1shq4X2ElvkGiVG04hGuRbVxHJ1KkJnxnqKhw9mLhn19i3Z8jlJARZN0y9SlDk1nyaeWt33/58vJsql48oqm1d5AJw/SZPh1laQIdon/aCtaekFkmNLFkTGOUO5TRAGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hh7lzCMS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hh7lzCMS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16F161F000E9;
	Thu, 13 Aug 2026 16:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786638611;
	bh=RDDKXE0AOT85JPew9DTiZ34LCT2LkJNVR0XmlIWLWFk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Hh7lzCMSJc0eWMs9KBqNQ249KYbn0H7EKajGU2k/Ao5r3IKZ9gAaZ9JswrqojIl01
	 TdloNI/5V2N9OX+mtNgnrxfTjQp8ql+GKSDVKuyY4T9T0KQL5yO4ZZ8BdIwCow3B0z
	 ybGHn/6PPoRaMQuFGOa9cQsrG+Nrppmt9VUEoT5q15GrCBSqxG5mfXC5tQADR4XTlf
	 b0/ofimFoAkFXoJN0ObTxg2eoXpRWSVEEVk11AC5kK2W2Ezl7EHqu2RpOH2GUHlj2v
	 3uEdawOIDznvQwgyY0zFUUWLqzqrKuEe/uzEoNHfZKNd6ngPr4smEqSSITJQWSORIv
	 TcohS20aqq4LQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ring-buffer: Fix race between
 ring_buffer_subbuf_order_set() and readers
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <178663777320.475864.4716637934003507750.stgit@devnote2>
References: <178663776361.475864.7685868697103378735.stgit@devnote2>
 <178663777320.475864.4716637934003507750.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 16:30:10 +0000
Message-Id: <20260813163011.16F161F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Structural TOCTOU race: global order and size are updated befo=
re replacing per-CPU buffer pages, leading to Heap Buffer Overflow.
- [High] Incomplete TOCTOU fix: alloc_cpu_data() evaluates buffer->subbuf_o=
rder locklessly, causing bpage->order mismatch.
- [High] Race window between pre-flush loop and buffer->subbuf_order update=
 allows caching undersized pages.
- [High] Post-update flush loop unconditionally frees newly cached pages us=
ing old_order.
- [High] Error path fails to flush cached pages when rolling back to old_or=
der.
--

--- Patch [1]: [PATCH] ring-buffer: Fix race between ring_buffer_subbuf_ord=
er_set() and readers ---
commit d1c3f71c852aab912bda60e5894b681e43da7c7b
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

ring-buffer: Fix race between ring_buffer_subbuf_order_set() and readers

This commit attempts to fix a TOCTOU race condition in the ring buffer code
by ensuring that the per-CPU free_page cache is flushed and protected by
the cpu_buffer lock during order changes. It also updates reader functions
to validate the page order under the same lock to prevent using mismatched
page sizes.

> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index c2c57fbf6f448..9a11c663cff5b 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -6957,11 +6957,11 @@ ring_buffer_alloc_read_page(struct trace_buffer *=
buffer, int cpu)
>  	if (!bpage)
>  		return ERR_PTR(-ENOMEM);
> =20
> -	bpage->order =3D buffer->subbuf_order;
>  	cpu_buffer =3D buffer->buffers[cpu];
>  	local_irq_save(flags);
>  	arch_spin_lock(&cpu_buffer->lock);
> =20
> +	bpage->order =3D buffer->subbuf_order;
>  	if (cpu_buffer->free_page) {
>  		bpage->data =3D cpu_buffer->free_page;
>  		cpu_buffer->free_page =3D NULL;
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but does this locklessly evaluate
buffer->subbuf_order after dropping the lock?

Looking at the code just below this hunk in ring_buffer_alloc_read_page():

	arch_spin_unlock(&cpu_buffer->lock);
	local_irq_restore(flags);

	if (bpage->data) {
		rb_init_data_page(bpage->data);
	} else {
		bpage->data =3D alloc_cpu_data(cpu, cpu_buffer->buffer->subbuf_order);
		...

If a concurrent writer changes the global order after the lock is dropped b=
ut
before alloc_cpu_data() evaluates the argument, the allocated page size will
mismatch the stored bpage->order.

When ring_buffer_free_read_page() later frees this page using bpage->order,=
 it
could free a mismatched page size and corrupt the buddy allocator.

[ ... ]
> @@ -7350,6 +7350,27 @@ int ring_buffer_subbuf_order_set(struct trace_buff=
er *buffer, int order)
>  	/* Make sure all commits have finished */
>  	synchronize_rcu();
> =20
> +	/* Flush any cached free_page allocated with old_order */
> +	for_each_buffer_cpu(buffer, cpu) {
> +		struct buffer_data_page *old_free;
> +		unsigned long flags;
> +
> +		if (!cpumask_test_cpu(cpu, buffer->cpumask))
> +			continue;
> +
> +		cpu_buffer =3D buffer->buffers[cpu];
> +
> +		local_irq_save(flags);
> +		arch_spin_lock(&cpu_buffer->lock);
> +		old_free =3D cpu_buffer->free_page;
> +		cpu_buffer->free_page =3D NULL;
> +		arch_spin_unlock(&cpu_buffer->lock);
> +		local_irq_restore(flags);
> +
> +		if (old_free)
> +			free_pages((unsigned long)old_free, old_order);
> +	}
> +
>  	buffer->subbuf_order =3D order;
>  	buffer->subbuf_size =3D psize - BUF_PAGE_HDR_SIZE;

[Severity: High]
This isn't a bug introduced by this patch, but does updating the global ord=
er
after the flush loop leave a race window?

During the unprotected window between the flush loop completing and updating
buffer->subbuf_order, the global order is still old_order.

A concurrent reader could call ring_buffer_free_read_page(), see that
data_page->order matches buffer->subbuf_order (both old), and cache an
old_order page back into cpu_buffer->free_page.

Once the order is updated below, subsequent readers might extract this cach=
ed
old_order page, tag it with the new order, and eventually free it with the =
new
order, causing buddy allocator corruption.

[Severity: Critical]
This isn't a bug introduced by this patch, but does updating the global ord=
er
and size here, before replacing per-CPU buffer pages, create a structural
race?

If a concurrent reader calls ring_buffer_read_page(), it validates its
new-order data_page against the new global order and swaps it into the ring
buffer. It extracts the old, unreplaced reader->page into dpage.

If the buffer is expanding, dpage is an undersized old-order page.

However, the reader executes memset() using the prematurely updated global
buffer->subbuf_size:

ring_buffer_read_page():
	if (size < buffer->subbuf_size)
		memset(&dpage->data[size], 0, buffer->subbuf_size - size);

This would blindly write zeroes far beyond the bounds of the extracted
old-order dpage, resulting in a heap buffer overflow reachable via
unprivileged tracefs reads.

[ ... ]
> @@ -7431,8 +7452,10 @@ int ring_buffer_subbuf_order_set(struct trace_buff=
er *buffer, int order)
>  		cpu_buffer->nr_pages =3D cpu_buffer->nr_pages_to_update;
>  		cpu_buffer->nr_pages_to_update =3D 0;
> =20
> +		arch_spin_lock(&cpu_buffer->lock);
>  		old_free_data_page =3D cpu_buffer->free_page;
>  		cpu_buffer->free_page =3D NULL;
> +		arch_spin_unlock(&cpu_buffer->lock);
> =20
>  		rb_head_page_activate(cpu_buffer);

[Severity: High]
This isn't a bug introduced by this patch, but does this second flush loop
unconditionally free potentially new-order pages with old_order?

After the global order is set to new_order, this function performs a sleepa=
ble
allocation loop (__rb_allocate_pages). During this time, concurrent readers
can allocate and free new_order pages, successfully caching them into
cpu_buffer->free_page.

When this code extracts cpu_buffer->free_page and subsequently frees it down
below:

	free_pages((unsigned long)old_free_data_page, old_order);

It blindly forces what could be a new_order page to be freed with old_order,
corrupting the buddy allocator.

[Severity: High]
This isn't a bug introduced by this patch, but does the error path fail to
flush cached pages when rolling back?

If __rb_allocate_pages() fails, the code jumps to the error label and resto=
res
buffer->subbuf_order =3D old_order:

ring_buffer_subbuf_order_set():
error:
	buffer->subbuf_order =3D old_order;
	buffer->subbuf_size =3D old_size;

During the window where it was new_order, concurrent readers may have cached
new_order pages into cpu_buffer->free_page. The error path returns without
flushing cpu_buffer->free_page.

Subsequent readers would extract these new_order pages, tag them as old_ord=
er,
and free them with old_order, causing a memory leak (if expanding) or alloc=
ator
corruption (if shrinking).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178663777320.475864=
.4716637934003507750.stgit@devnote2?part=3D1
