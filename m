Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3ED3C81B9
	for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Aug 2026 13:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786975147; cv=none; b=AI/oAyE4gsHgm8nM0B86hoAD4woGB3wT+H9cuImQNf1FrxVRAA1FVU4ZzO3U0/qC7cjc/p5hQwcQbHP+RtrXaN82FlVGtpQI+/4GzpxVOSXaeOf5lORuy0TSkHvsOX3Dedw3VaIPk4GR+gMQYc2H61H1ASAh19/ED/t/aafa9Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786975147; c=relaxed/simple;
	bh=Gn86gQuzduCPi0p/tUUv+6WjpdlJt3gOXiPvLYaZYak=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MegfUfr0E3CwkmF1OljE7jxr7btiCPRsmomRvQgfBQIlsX09trTkvj5MCyKmMkiJt4XbMM8cvXBv7NE9ypNscuZCaRJGQ4+OJC7sOQ7bvvcaDpgJxb4/wrZ+rBAclNeWIjPWIRJSV3pgnDP/U6+v0OMFCS2YAVOz7cJQhJIrX1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jCDhseF6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jCDhseF6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 481481F00A3D;
	Mon, 17 Aug 2026 13:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786975146;
	bh=ANglncdbhwnOhp1aGQDHKVY5h4prbCBLnfsYJ11dX28=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jCDhseF6pnulQE+jT/4c20jULtWXnyiPFeAH+zofC6seeVo9WXMx8owTOWFrn+MOd
	 qxSRcRs48ZCabWPgzvpDCQ/K4WTAuoEpCAiYyHR+ImlNve00f5ArJ9JoJDzI0AR+IO
	 bGfUUl4BnzH78XLvcZNF0oStxoERB+9mLliSMGL1biFWmgzV5tIfC6skryI806oWEu
	 4ju2eUVqHQ/ynh1uHYh5R/tJg8FkYkBWcfmmCkRwBTqjNfdfuqR20WUbIv/4IiMcOt
	 MOFTK48Bmfr81EWpTZLo7hbML5M/i/jU6I/QI0X0JK7e7oy3T/i/SebUfHewHkcvO2
	 wZOLUEnczENXQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/3] ring-buffer: Prevent truncation of nr_pages /
 nr_subbufs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Donnefort" <vdonnefort@google.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260817134750.3909384-4-vdonnefort@google.com>
References: <20260817134750.3909384-1-vdonnefort@google.com>
 <20260817134750.3909384-4-vdonnefort@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 13:59:05 +0000
Message-Id: <20260817135906.481481F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Integer underflow in alloc_buffer() for mapped ring buffers leads =
to memory corruption on 32-bit systems.
- [High] Out-of-bounds memory corruption in rb_cpu_meta_valid during ring b=
uffer boot meta validation due to unvalidated meta->nr_subbufs.
--

--- Patch [3]: [PATCH v7 3/3] ring-buffer: Prevent truncation of nr_pages /=
 nr_subbufs ---
commit ca74d5f745c91c8b4a7ee42fae91ab814132919c
Author: Vincent Donnefort <vdonnefort@google.com>

ring-buffer: Prevent truncation of nr_pages / nr_subbufs

This commit prevents truncation operations on large ring buffers by changing
nr_pages and nr_subbufs definitions to unsigned long. It also upgrades
subbuf_size to unsigned int.

> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c

[ ... ]

> @@ -1849,13 +1848,13 @@ static bool rb_meta_init(struct trace_buffer *buf=
fer, int scratch_size)
>   * must be the same.
>   */
>  static bool rb_cpu_meta_valid(struct ring_buffer_cpu_meta *meta, int cpu,
> -			      struct trace_buffer *buffer, int nr_pages,
> +			      struct trace_buffer *buffer, unsigned long nr_pages,
>  			      unsigned long *subbuf_mask)
>  {
> -	int subbuf_size =3D PAGE_SIZE;
> +	unsigned long subbuf_size =3D PAGE_SIZE;
>  	unsigned long buffers_start;
>  	unsigned long buffers_end;
> -	int i;
> +	unsigned long i;
> =20
>  	if (!subbuf_mask)
>  		return false;

[Severity: High]
This is a pre-existing issue, but can this lead to an out-of-bounds memory
overwrite on the kernel heap?

In rb_range_meta_init(), subbuf_mask is allocated using the current boot's
nr_pages + 1:

    subbuf_mask =3D bitmap_alloc(nr_pages + 1, GFP_KERNEL);

However, later in rb_cpu_meta_valid(), the legacy persistent metadata is us=
ed=20
to clear and set bits in this mask:

    bitmap_clear(subbuf_mask, 0, meta->nr_subbufs);
    ...
    for (i =3D 0; i < meta->nr_subbufs; i++) {
        ...
        set_bit(meta->buffers[i], subbuf_mask);
    }

If the system boots with more CPUs than the previous cycle, the per-CPU
nr_pages constraint decreases. Consequently, the legacy meta->nr_subbufs=20
could be larger than the newly allocated subbuf_mask, causing bitmap_clear()
and set_bit() to overflow the allocation.

[ ... ]

> @@ -2782,8 +2782,8 @@ static struct trace_buffer *alloc_buffer(unsigned l=
ong size, unsigned flags,
>  					 struct ring_buffer_remote *remote)
>  {
>  	struct trace_buffer *buffer __free(kfree) =3D NULL;
> -	long nr_pages;
> -	int subbuf_size;
> +	unsigned int subbuf_size;
> +	unsigned long nr_pages;
>  	int bsize;
>  	int cpu;
>  	int ret;

[Severity: High]
This is a pre-existing issue, but does this function suffer from an integer
underflow that could bypass length boundary validations?

Further down in alloc_buffer(), when calculating the per-CPU size for mapped
buffers:

    size =3D end - buffers_start;
    size =3D size / nr_cpu_ids;
    nr_pages =3D (size - sizeof(struct ring_buffer_cpu_meta)) /
               (subbuf_size + sizeof(int));

If the user-provided mapped range is smaller than the meta structure size,
size - sizeof(struct ring_buffer_cpu_meta) will underflow. On 32-bit system=
s,
this yields a massive nr_pages value that successfully passes the
rb_static_max_pages() threshold check.=20

The subsequently calculated pointers will wrap around the 32-bit address
space, defeating the bounds check against the end boundary, and allowing
mapped metadata structures to be written into arbitrary out-of-bounds memor=
y.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817134750.3909=
384-1-vdonnefort@google.com?part=3D3
