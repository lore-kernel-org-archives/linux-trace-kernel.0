Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52E537F324
	for <linux-trace-kernel@vger.kernel.org>; Mon, 14 Sep 2026 18:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789409950; cv=none; b=q8voBYngHHryCwqT0QG5J+1gSNgYwf2ZlB8NowbH0Zufqvlok6Gsm8LHXF59I5UQ/85ejr1PzjcP1H3dGx5PH564Ci6+WBYV79UJygBoj8mC0dPi9oAzqYt7x6AdYf3e6exsqa7KoXFmpXJ61NoheXkTsGIWzykDoAJgxcE3Tog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789409950; c=relaxed/simple;
	bh=sFKCnLSvEuAVKGL4NX617NcQz2IADyOJpo5x0ZHrFm8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NIgVwopIjshY1hMcdTPUySFDeYDQGPhVYN/JWn7/99dsKitLivot+jdK5vBPgfSr2f/Qq5u3REEecFPh3FDcjrMB2NSwJZjg4B2YeXUboNQwLYXsegH2i8raYRSabj9GodSOB7hZX7Ls3OHbsIOA8RIAbw5eEfZdO6miejbjUmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cOGsSHeJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cOGsSHeJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AA891F000FF;
	Mon, 14 Sep 2026 18:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789409948;
	bh=FdfXQfLKWJ8uu7oOACSqJpMnb09gFJv6T11QeN9DHq4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cOGsSHeJDL92AHtSjSTGNvl5nCLYVDu50YK7/LjS0BsWBxTxJfPFqcmeoSiIpQoOL
	 qxoTG7f4kAalmAdIyFbJByxCAqcZzPsOIjrnXCmKfbQKNvZmqsBmjNdhsPFMp+LPEc
	 jLAbUc0vQN4B0DKmOlXbR1D4bOdQY5kZ/Hv8bCTrf7toRf+8+WAPWtU+w+ls2zKM/B
	 tdQKDR/GHditVgjTIxbvzy0bgAPfRdxeGwFWqFXOuD9a92atw+1P+4AA0nRKpplHQU
	 It3q4QCSoUg7By5IY5yl3Ucz4/zwRaWhUr4kRTmOjpZYKxLgSqz/hwRgqoOp1VPdB5
	 gRTiHDKO68tRQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] ring-buffer: Clean up resize_disabled checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Donnefort" <vdonnefort@google.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260914175907.1027349-1-vdonnefort@google.com>
References: <20260914175907.1027349-1-vdonnefort@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 18:19:08 +0000
Message-Id: <20260914181908.6AA891F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing CPU hotplug lock in ring_buffer_subbuf_order_set() causes =
NULL/poison pointer dereference on concurrent hotplug.
--

commit 6a990a7dda41a1ef54e4e559d824ba3e1166dfe2
Author: Vincent Donnefort <vdonnefort@google.com>

ring-buffer: Clean up resize_disabled checks

This patch creates a common helper rb_resize_disabled() to refactor duplica=
te
checks in ring_buffer_subbuf_order_set() and ring_buffer_resize(). It also
removes an unnecessary cpumask_test_cpu() in ring_buffer_subbuf_order_set().

> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 04bb94c29f587..37801ac5e92e2 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c

[ ... ]

> @@ -7473,13 +7475,9 @@ int ring_buffer_subbuf_order_set(struct trace_buff=
er *buffer, int order)
> =20
>  	old_capacity =3D rb_subbuf_capacity(buffer);
> =20
> -	/* The mmap fast path reads subbuf_order without buffer->mutex. */
> -	for_each_buffer_cpu(buffer, cpu) {
> -		if (!cpumask_test_cpu(cpu, buffer->cpumask))
> -			continue;
> -		if (atomic_read(&buffer->buffers[cpu]->resize_disabled))
> -			return -EBUSY;
> -	}
> +	/* Check it is resizable before we touch subbuf_order */
> +	if (rb_resize_disabled(buffer, RING_BUFFER_ALL_CPUS))
> +		return -EBUSY;
> =20
>  	atomic_inc(&buffer->record_disabled);

[Severity: High]
This is a pre-existing issue, but since we are modifying
ring_buffer_subbuf_order_set(), is there a missing CPU hotplug lock here
that could cause a crash?

Unlike ring_buffer_resize() which takes cpus_read_lock(), this function
takes buffer->mutex but fails to protect buffer->cpumask against
concurrent hotplug modifications.

> =20
> @@ -7490,17 +7488,8 @@ int ring_buffer_subbuf_order_set(struct trace_buff=
er *buffer, int order)
> =20
>  	/* Make sure all new buffers are allocated, before deleting the old one=
s */
>  	for_each_buffer_cpu(buffer, cpu) {
> -
> -		if (!cpumask_test_cpu(cpu, buffer->cpumask))
> -			continue;
> -
>  		cpu_buffer =3D buffer->buffers[cpu];
> =20
> -		if (atomic_read(&cpu_buffer->resize_disabled)) {
> -			err =3D -EBUSY;
> -			goto error;
> -		}
> -

[Severity: High]
This is a pre-existing issue related to the missing hotplug lock above.
In this first loop of ring_buffer_subbuf_order_set(), new pages are allocat=
ed
only for CPUs present in the mask at this point:

	for_each_buffer_cpu(buffer, cpu) {
		...
		/* Allocate the new size buffer */
		INIT_LIST_HEAD(&cpu_buffer->new_pages);
		if (__rb_allocate_pages(cpu_buffer, nr_pages,
					&cpu_buffer->new_pages)) {
			...
		}
	}

Later, the second loop iterates over the cpumask again:

	for_each_buffer_cpu(buffer, cpu) {
		...
		/* One page was allocated for the reader page */
		cpu_buffer->reader_page =3D list_entry(cpu_buffer->new_pages.next,
						     struct buffer_page, list);
		list_del_init(&cpu_buffer->reader_page->list);

If the cpumask expands between the two loops due to concurrent hotplug,
the second loop will process the newly added CPU.

However, for that new CPU, the new_pages list was not populated by the
first loop. Instead, trace_rb_cpu_prepare() will have left it in a
LIST_POISON1 state (via list_del()), causing a deterministic kernel crash
when dereferencing new_pages.next.

Could cpus_read_lock() be added at the beginning of
ring_buffer_subbuf_order_set() to protect against this?

>  		/* Update the number of pages to match the new size */
>  		nr_pages =3D old_capacity * buffer->buffers[cpu]->nr_pages;
>  		nr_pages =3D DIV_ROUND_UP(nr_pages, rb_subbuf_capacity(buffer));

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914175907.1027=
349-1-vdonnefort@google.com?part=3D1
