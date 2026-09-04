Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB6A3E9F8D
	for <linux-trace-kernel@vger.kernel.org>; Fri,  4 Sep 2026 17:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788541243; cv=none; b=o45HTVCnxZTjiXA+DRovWC9o5BRUHM0Ojv8DhqTE+zzE6U+M35SYWsbnSrVpacVtCOy3vHRf6TiJT0eVqr/nOGvWzYpTI10H4Ea6rRbXg+CTX2rjT5Y9C0iT9wWwXGUdUFBS+OuBsnViZ8UKy3hIyVAKQr5L9inKIVYdizcFfq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788541243; c=relaxed/simple;
	bh=ze9gOVOaqPDw6CAjtzIGvsi6jSYdkiqUK1IKTVHCw/A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pHQJzH9Wct2Om5ofJgfQ19WOqA5mv8W99VXasLM0VkQGsoIDi10RmOOvkvkA3MRa+ICTfVdPZp9TkRQRvwdYwQ4WXUVOxbT6zfUK9+Fum4lT/iEZv24w1RPdP83wfDY5fy0prSi3gGEHTcFyUqOCtccinotprtKmpAQyaXDA8Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C95NSafA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C95NSafA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E09B11F00A3D;
	Fri,  4 Sep 2026 17:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788541242;
	bh=J7S0LOC0F5eXyfXXGcZBaHoL3UjPfNDI9D/mhorC43U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C95NSafAbjrpksKQ4XA6365KjDyV7Wlt9MNBOoZm2A0Kl22IvVpo+QeBQCamIkkqt
	 fXsvd1hK2enPJ2z+HzoC5fTBJk92Bm5NGm8Tl6kcYRvOsg6KJTDo/FlAxjH1+ElJf0
	 ua965gLkU7teyrd4rAr0HLodxgSkjrDN6/zt5NGGGxg2Nf+JabSnMGvpJJbufU+Jhx
	 AseDspgefTNT26rSncX5kseopVcV6ZLMSJXfEBoOyjf8F89PInhTOGBDKbrrguec8P
	 G9Znb3mr86UADZae0+O5Pby/XNqIbDebs9RruA0JkGLqZtU85ozh0HO8gpfagY9czD
	 9cG3f9vrDEjlQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 4/4] ring-buffer: Prevent truncation of nr_pages /
 nr_subbufs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Donnefort" <vdonnefort@google.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260904164450.1345852-5-vdonnefort@google.com>
References: <20260904164450.1345852-1-vdonnefort@google.com>
 <20260904164450.1345852-5-vdonnefort@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 17:00:41 +0000
Message-Id: <20260904170041.E09B11F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Untrusted meta->nr_subbufs from persistent trace buffer memory=
 is used without bounds checking against the allocated mask size, causing a=
 heap out-of-bounds write.
- [High] Incorrect offset calculation in rb_meta_subbuf_idx omits the size =
of the ring_buffer_cpu_meta structure, which can cause the function to retu=
rn a corrupted subbuffer index (off-by-one).
--

commit 0ea297fd27320f1e57a1d58538c8b811080de4c8
Author: Vincent Donnefort <vdonnefort@google.com>

ring-buffer: Prevent truncation of nr_pages / nr_subbufs

Although ring_buffer_per_cpu::nr_pages is defined as unsigned long, it
is capped to 32-bits in a few places, limiting the operations possible
on a very large buffer. Use unsigned long where appropriate and
prevent truncation of values using nr_pages (or nr_subbufs).

> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 6b914abd80e3c..504a01a1d3807 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
[ ... ]
> @@ -1871,7 +1869,7 @@ static bool rb_cpu_meta_valid(struct ring_buffer_cp=
u_meta *meta, int cpu,
>  	}
> =20
>  	buffers_start =3D meta->first_buffer;
> -	buffers_end =3D meta->first_buffer + (subbuf_size * meta->nr_subbufs);
> +	buffers_end =3D meta->first_buffer + (meta->nr_subbufs * PAGE_SIZE);
> =20
>  	/* Is the head and commit buffers within the range of buffers? */
>  	if (meta->head_buffer < buffers_start ||

[Severity: Critical]
This is a pre-existing issue, but does rb_cpu_meta_valid() lack bounds
checking on the untrusted meta->nr_subbufs before it is used?

A bit further down in this function, the code does:

        bitmap_clear(subbuf_mask, 0, meta->nr_subbufs);

and then loops up to meta->nr_subbufs doing:

                set_bit(meta->buffers[i], subbuf_mask);

Since subbuf_mask is allocated in rb_range_meta_init() using nr_pages + 1,
and meta->nr_subbufs is read directly from persistent memory, could a larger
meta->nr_subbufs value from a previous boot cause a heap out-of-bounds
write when clearing and setting bits?

[ ... ]
> @@ -2345,8 +2344,8 @@ static int rbm_show(struct seq_file *m, void *v)
>  			   rb_meta_subbuf_idx(meta, (void *)meta->head_buffer));
>  		seq_printf(m, "commit_buffer: %d\n",
>  			   rb_meta_subbuf_idx(meta, (void *)meta->commit_buffer));
> -		seq_printf(m, "subbuf_size:   %d\n", meta->subbuf_size);
> -		seq_printf(m, "nr_subbufs:    %d\n", meta->nr_subbufs);
> +		seq_printf(m, "subbuf_size:   %u\n", meta->subbuf_size);
> +		seq_printf(m, "nr_subbufs:    %u\n", meta->nr_subbufs);
>  		return 0;
>  	}

[Severity: High]
This is a pre-existing issue, but is the calculation in rb_meta_subbuf_idx()
omitting the size of the ring_buffer_cpu_meta structure?

Looking at rb_meta_subbuf_idx():

        subbuf_array =3D (void *)meta + sizeof(int) * meta->nr_subbufs;
        subbuf_array =3D (void *)ALIGN((unsigned long)subbuf_array, meta->s=
ubbuf_size);

Does this missing sizeof(struct ring_buffer_cpu_meta) cause the function to
return an off-by-one subbuffer index for specific persistent trace buffer
sizes?

If sizeof(int) * meta->nr_subbufs modulo PAGE_SIZE is between
PAGE_SIZE - sizeof(struct ring_buffer_cpu_meta) and PAGE_SIZE - 1, the
alignment might mask the offset differently, returning a corrupted index.
Could this trigger the WARN_ON in rb_setup_ids_meta_page() and lead to a
NULL pointer dereference when mapping the persistent ring buffer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904164450.1345=
852-1-vdonnefort@google.com?part=3D4
