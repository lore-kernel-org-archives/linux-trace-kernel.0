Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82159364052
	for <linux-trace-kernel@vger.kernel.org>; Fri,  4 Sep 2026 17:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788541445; cv=none; b=TfqaMa3GP7k32J494AMGyGFgKj1seo6Ek8y6NdaExA0z4XblDHxyi97X+Sm3yPEe2X9RBaVJ7jkZH1nSKNai6f5TRf5AqViguGifzbLsOkfdCZtlobNWorUfdogcEVCVaUFpl9WruCnBptzNB6bLpgdqJSW2JptcGOlKCwCykKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788541445; c=relaxed/simple;
	bh=lXNeeKItB1L+g+gSuN9IBRD98qraUudrk2Che2t/xw0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JexVWxebJCb2voHNjpLTUnSo7d/AeT8Wd8tcCh6/06Eoc7B6XaZYmWxbWnbsCElMHiqFqR0eBz7Z2HWFzGyf/WuuyGYc3LC4UTL1of9Z4I0dHpZXhBRvjZIgo3cz277GacRbrDYbzGfHMqkvr6GjGseESj7NTWV1bi5f9NqmI5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W0SzG4Ov; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W0SzG4Ov"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 463961F00A3D;
	Fri,  4 Sep 2026 17:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788541444;
	bh=/eY+3eh1bztPTkBvwpPt/gyFkmJ/p6YSo3/udQlHAqE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W0SzG4OvZLIGznRYHTRDi5abxe7NYQdPAsHy4lMPGjqRglK6kvABWCqSbiX6frFB8
	 Njno0NfEjb4N1Gaw1LffTkO3JL5Kh8+43k5VR0EZWJj+gSNujMDFBa7J7M2nx3jewW
	 TVSaXS/vEGBebF0j2nY/0w4EIpgxSDfwkIH7v2gl9H16sWYWxvuisJ62a9IUR7HEZO
	 eOPd29v85uS9viljYHmcb783nnE/jF/LczxqxYG83HGsocXzxiYn0BadyBSv6Vg/2x
	 qbNAMlUlQf/uuxjGLcFCr/tKz7zrM86ns4816OQIVkhXWJ9F408x0a299ImTsk5rL4
	 nNA5YW6irHtpg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 3/4] ring-buffer: Cap static ring buffer nr_pages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Donnefort" <vdonnefort@google.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260904164450.1345852-4-vdonnefort@google.com>
References: <20260904164450.1345852-1-vdonnefort@google.com>
 <20260904164450.1345852-4-vdonnefort@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 17:04:03 +0000
Message-Id: <20260904170404.463961F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Integer underflow in size calculation bypasses the max pages limit=
 on 32-bit systems, leading to massive out-of-bounds memory initialization.
- [High] Unchecked return value from `ring_buffer_desc()` leading to a NULL=
 pointer dereference in remote buffer allocation.
--

commit be7971253ae6dad60dcb1cc2d29fe4019ffb6e16
Author: Vincent Donnefort <vdonnefort@google.com>

ring-buffer: Cap static ring buffer nr_pages

This commit introduces a limit on the number of pages for static ring
buffers to ensure the page count fits within the bpage::id field. It
adds bounds checks during ring buffer creation and mapping to prevent
exceeding this maximum limit.

> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 2f61cb510b0ac..6b914abd80e3c 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c

[ ... ]

> @@ -2833,6 +2842,8 @@ static struct trace_buffer *alloc_buffer(unsigned l=
ong size, unsigned flags,
>  		size =3D end - buffers_start;
>  		size =3D size / nr_cpu_ids;
> =20
> +		if (size < sizeof(struct ring_buffer_cpu_meta))
> +			goto fail_free_buffers;

[Severity: High]
This is a pre-existing issue, but could this size calculation result in
an integer underflow if a user configures a small range size where end
is less than buffers_start?

On 32-bit systems, the unsigned subtraction would wrap around to a huge
positive integer. Because the resulting size is massive, the new size
less than sizeof(struct ring_buffer_cpu_meta) check would pass.

Since nr_pages would become approximately 262,144 in this wrapped state,
it would also bypass the newly added nr_pages > rb_static_max_pages()
limit. Could this loop then accumulate pointers wrapping around the 32-bit
address space, bypassing the bounds check and leading to massive
out-of-bounds memory initialization?

>  		/*
>  		 * The number of sub-buffers (nr_pages) is determined by the
>  		 * total size allocated minus the meta data size.
> @@ -2842,6 +2853,10 @@ static struct trace_buffer *alloc_buffer(unsigned =
long size, unsigned flags,
>  		 */
>  		nr_pages =3D (size - sizeof(struct ring_buffer_cpu_meta)) /
>  			(subbuf_size + sizeof(int));
> +
> +		if (nr_pages > rb_static_max_pages())
> +			goto fail_free_buffers;
> +
>  		/* Need at least two pages plus the reader page */
>  		if (nr_pages < 3)
>  			goto fail_free_buffers;

[ ... ]

> @@ -2874,6 +2889,10 @@ static struct trace_buffer *alloc_buffer(unsigned =
long size, unsigned flags,
>  		/* The writer is remote. This ring-buffer is read-only */
>  		atomic_inc(&buffer->record_disabled);
>  		nr_pages =3D desc->nr_page_va - 1;

[Severity: High]
This isn't a bug introduced by this patch, but is it possible for
ring_buffer_desc() to return NULL here if the provided remote descriptor
lacks an entry for the currently executing CPU?

If the descriptor does not have an entry for the executing CPU,
unconditionally dereferencing desc->nr_page_va would cause a NULL pointer
dereference.

Other functions in this file, such as __rb_allocate_pages(), appear to
check if desc is NULL before proceeding. Could this lead to a kernel panic
if an untrusted hypervisor or client provides an incomplete remote trace
descriptor?

> +
> +		if (nr_pages > rb_static_max_pages())
> +			goto fail_free_buffers;
> +
>  		if (nr_pages < 2)
>  			goto fail_free_buffers;
>  	} else {

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904164450.1345=
852-1-vdonnefort@google.com?part=3D3
