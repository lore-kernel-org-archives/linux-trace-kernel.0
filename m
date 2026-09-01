Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1B71C5D72
	for <linux-trace-kernel@vger.kernel.org>; Tue,  1 Sep 2026 16:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281318; cv=none; b=dl1DHUsx7x1BF1LpwyU+ANZg1A7YUVks7o68sDFHOrIkSV1gOD0TOt1IZp2hiILDuD7UE0epjFaMFDRcAWbTh6HAqMNTlAEw68h4zDChNGyUrao1hira+vqi4RkkisLE1K3wRxgPRMmrOGrxS5y072fN4EpHSP28MZ0Nb4QffhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281318; c=relaxed/simple;
	bh=6I8eG7V87BItXwmEBLrGhQYWEDW51phH6UPTJaHEkUo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ANmZWhTAm4FABuuxa0z6LnnSLv9Dkmrdhpc2ycmq1OhFP39Ph4F1lAa9+4YR1OdAeeYmmz/JhzBiEzTD00yb2eYwS1eNeXH8GNiVlFogTHXTzDZsT0d69dL962ZtH/FHwG45zYwgUrcatw6QtLA7CfR4QdiHGAmBiQNomLPHKCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivdlKVTV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivdlKVTV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D962D1F000E9;
	Tue,  1 Sep 2026 16:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788281317;
	bh=ajlaNQ8kPV8yQOgbL9XGq5nYBzb7oweK9HdfSC2XzeY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ivdlKVTVM/8NhXL5PtCqF1D/KSrfmRapldx83juDeAk++63ayi7LsO1UQsf4bDTlY
	 gM1d9CVyDZoCQg0Lx8IFyK0XLS0EEud+4IaBHxU3GqjvkX0bBXn0O87FLczLG40O0z
	 usbQVM1s8TLKmH2Jjq4KltyLgD4WO2Afn2qLC1EAxlVngYK2RIapxY0ghtxiUrDnU2
	 d+1WroeISgpICrU5g8PwctE98DvRc1I/WTooe3vK8sxZt+FCbvhr8pRA7exJz/wqy6
	 sC13W4NQYpjhqtdYx60+tZrlEgxbTQdId7n9lq9impdecaqe8UhmPHrjsLyaHiyG3b
	 Fnf5uw030HtiA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 4/4] ring-buffer: Prevent truncation of nr_pages /
 nr_subbufs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Donnefort" <vdonnefort@google.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260901155445.1475405-5-vdonnefort@google.com>
References: <20260901155445.1475405-1-vdonnefort@google.com>
 <20260901155445.1475405-5-vdonnefort@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 16:48:36 +0000
Message-Id: <20260901164836.D962D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Heap buffer overflow in rb_cpu_meta_valid due to unvalidated meta-=
>nr_subbufs
--

commit 1ffddb5e98b6cd5a5142af30014e0d2a25f757f8
Author: Vincent Donnefort <vdonnefort@google.com>

ring-buffer: Prevent truncation of nr_pages / nr_subbufs

This commit updates the variables tracking ring buffer pages and sub-buffers
from 32-bit types to unsigned long or unsigned int to prevent truncation
on very large buffers.

> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
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
This is a pre-existing issue, but does this function overflow the
subbuf_mask bitmap?

The size of subbuf_mask is allocated as nr_pages + 1 bits in
rb_range_meta_init(). However, this function unconditionally uses
meta->nr_subbufs from the persistent memory mapped region without
validating it against nr_pages + 1.

If nr_cpu_ids is increased between boots (e.g. by changing the CPU count
or maxcpus=3D boot parameter), the per-CPU buffer size shrinks, leading to a
smaller nr_pages for the current boot. rb_meta_init() will still accept
the persistent memory as valid because the overall total_size is identical.

Consequently, meta->nr_subbufs from the previous boot will be larger than
the newly allocated subbuf_mask size, which can cause bitmap_clear() and
set_bit() to write out of bounds further down in this function:

    bitmap_clear(subbuf_mask, 0, meta->nr_subbufs);

    for (i =3D 0; i < meta->nr_subbufs; i++) {
        ...
        set_bit(meta->buffers[i], subbuf_mask);
    }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901155445.1475=
405-1-vdonnefort@google.com?part=3D4
