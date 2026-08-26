Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB6A3C454E
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 10:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787738539; cv=none; b=UJJ3W6S7pCWiILqDKoeThFT1VAPT3Gc1h1F/K+bvY7w1qcz/9sXjQoNAfWUwf2kapTdMirswXRe256PdHDq4A4REuBDDP0fwx2pJh+RVIjz9dedBCTrO2Iu/6LqLLlrKn19nk4PHjYgvcE0ZRFgH0We/c/ICN5oeyI83H6lqy5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787738539; c=relaxed/simple;
	bh=ew70hCoJNsTTICgk44XSZWNBtyb6U+JWQye3DsQIylc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=svy78UTCxvbI7XC2oEoKYaRDMK+Fr09KJi+LS4XVoU0tGt9XD7D2fi9j+g7kaq1r4dk/Yc8HjlAM8+vAkkXdYzT2q10MJh3D9AV8nXsvBzoAq25V+BtXBvv6BNnnhWh9YYKiMIIz5DInIri1uu0SMIYHa88LKUxng65SMf51J0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QM0sIlBa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QM0sIlBa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 234A61F000E9;
	Wed, 26 Aug 2026 10:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787738538;
	bh=fhz15VjKB70xjk7PgOzySOedUoBO0TLk4qjVXmlSqXk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QM0sIlBaGfBh8Cv6ZpcTQg9Q09XCLK2ASkzaoKhUr9oeSQmNQA+dU+ipf1J7HDEb5
	 EdMJIbhjZ0Wh7n6ObRIA/nYqD67H1VHYij7Uk1+U9YcfLSwz7FwKTnkHvsfyJysun5
	 +jEwtxMGDrIHJV3iiIbW5cmSfkml9a+fj6X7X8Ue/putg17wF0rdrHawCl2/QIgyuz
	 uknskfHO7KMSJAKLCeFo8jrBXUqymz4JLM+PmF1q9UU6Pkx6k/rlZdgyTLntX4IUe0
	 +lS4GnrzwVc9Vjo6RsOb/tOw3uKumJcfVHg2dAbSMlDFIwLL91ldds1nRO2CHHeBR2
	 zPB2vpo3LP1FQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 3/3] ring-buffer: Prevent truncation of nr_pages /
 nr_subbufs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Donnefort" <vdonnefort@google.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260826094528.3738023-4-vdonnefort@google.com>
References: <20260826094528.3738023-1-vdonnefort@google.com>
 <20260826094528.3738023-4-vdonnefort@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 10:02:17 +0000
Message-Id: <20260826100218.234A61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The kernel fails to validate the untrusted `meta->nr_subbufs` valu=
e from persistent memory against the expected `nr_pages + 1`, leading to ar=
bitrary heap out-of-bounds writes and potential arbitrary kernel memory cor=
ruption.
--

commit 5ed0ab549782b2ff87e1bd2394abb78b10c4b602
Author: Vincent Donnefort <vdonnefort@google.com>

ring-buffer: Prevent truncation of nr_pages / nr_subbufs

Although ring_buffer_per_cpu::nr_pages is defined as unsigned long, it
is capped to 32-bits in a few places, limiting the operations possible
on a very large buffer. Use unsigned long where appropriate and
prevent truncation of values using nr_pages (or nr_subbufs).

While at it, subbuf_size must be at least unsigned int.

Note that persistent, remote and user-mapped ring buffers are capping
the number of pages to 31 bits already, making "int" safe in many
places.

> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 6089fcc67e2b6..1fcf55e2ca81f 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -1745,7 +1744,7 @@ static void *rb_range_meta(struct trace_buffer *buf=
fer, int nr_pages, int cpu)
>  /* Return the start of subbufs given the meta pointer */
>  static void *rb_subbufs_from_meta(struct ring_buffer_cpu_meta *meta)
>  {
> -	int subbuf_size =3D meta->subbuf_size;
> +	unsigned int subbuf_size =3D meta->subbuf_size;
>  	unsigned long ptr;
> =20
>  	ptr =3D (unsigned long)meta;

[Severity: High]
This isn't a bug introduced by this patch, but does the next line in this
function perform pointer arithmetic using an unvalidated meta->nr_subbufs?

	ptr =3D rb_range_align_subbuf(ptr, subbuf_size, meta->nr_subbufs);

Could this yield a corrupted or attacker-controlled subbuf base pointer if
meta->nr_subbufs is read from persistent memory without being checked again=
st
expected limits?

[ ... ]

> @@ -1854,13 +1853,13 @@ static bool rb_meta_init(struct trace_buffer *buf=
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
This isn't a bug introduced by this patch, but is there a risk of an
out-of-bounds heap write further down in this function?

The subbuf_mask is allocated with nr_pages + 1 bits in rb_range_meta_init(),
but later in rb_cpu_meta_valid() operations use the unvalidated
meta->nr_subbufs value read from persistent memory:

	bitmap_clear(subbuf_mask, 0, meta->nr_subbufs);

	/*
	 * Ensure the meta::buffers array has correct data. The data in each subbu=
fs
	 * are checked later in rb_meta_validate_events().
	 */
	for (i =3D 0; i < meta->nr_subbufs; i++) {
		if (meta->buffers[i] < 0 ||
		    meta->buffers[i] >=3D meta->nr_subbufs) {
			pr_info("Ring buffer boot meta [%d] array out of range\n", cpu);
			return false;
		}

		if (test_bit(meta->buffers[i], subbuf_mask)) {
			pr_info("Ring buffer boot meta [%d] array has duplicates\n", cpu);
			return false;
		}

		set_bit(meta->buffers[i], subbuf_mask);
	}

If meta->nr_subbufs is larger than nr_pages + 1, could this write out of
bounds and corrupt kernel memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826094528.3738=
023-1-vdonnefort@google.com?part=3D3
