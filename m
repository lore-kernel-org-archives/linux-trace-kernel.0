Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF413F5BF3
	for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Aug 2026 10:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786961698; cv=none; b=mY2WLV+6CotwP/lG4/aqt4mwXoUL8jfXsExrBfRAd5ndG0rKy9Onqub1xIGnxO+OupAJyVimS8y8T3Z9MrwiVi5S04lUNzUv8oKNoILMKn+3cBdWiyJtXaR54z485/wd/9Qi29cgSI4tYnsOXjp1Wbb+zn/Q60OfxWcvNK3DX38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786961698; c=relaxed/simple;
	bh=jEtdv8cixT4yT8CUzlCKJ298vzSvS3wb33Tb68PE/XE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KyUwxvF2+K83R3Xb9Eyqya60Wa47cd7fR+wPawOXqWnR9ppjjzczy7dnvcScMAK7NSpHbkPQc25vm+YEmE9jSNp86dIpNLxCT2eOLpJJNDvQ6Yry0ly87cpQtWnx+c2BexTUQgCET6alC1chCvkEvP62AZNs7ZW+VBJs1FV8Tk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kT2a3HlV; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kT2a3HlV"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-499840a2575so23907965e9.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Aug 2026 03:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786961691; x=1787566491; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WkV77Z8Ixwaqf7EeDyRNAP+C+NWCpS3WdahE3ARQznE=;
        b=kT2a3HlVBavcvdorkOFoxSgI55qUU7NXKNozxZamOh2ueTSQkGqZbT9UzGYncoHXeq
         vHPvAtoFXcVibFYLW+xmlJvuidv2D/LPwTh+DCdtWYwEBTxbV2DPzVagJEYr5tjs+lWq
         kHaIS4eoRVVbHxStfMQJjnppxvGGWfRgvtI39oAOag2OWDjeYDaQbvOi/KCB8ojV3CLA
         ALskrhuVPd2X8h0e4SccgSL95K4NKcrjgg53rVkQTQMM52+ffIJPj8vlaLey7oX9bCnr
         A8ruBxwLef308776ki1HoZNuUhH3Fu2z9BRvTzgUZLU4TzKSfRMEQiDUv+s/VCzJu+a9
         j5EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786961691; x=1787566491;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WkV77Z8Ixwaqf7EeDyRNAP+C+NWCpS3WdahE3ARQznE=;
        b=Gzs7c+u7Ccj67f1riC6dXEfvpWlaaVwMHcKedjw2a4rw65KXHQvSWDEzje6zXQodmx
         bfoai9jPf1xkNGghuYvl3BRlayViEiqe/O/sCeXWZNfBWiD5IXx7AFvTTeztUt2Jz/bG
         q+pP7ctbAbw70Fx3qTtAR8Wqoi3DjEdBH7DHyo3kGyFJhvASPuHqW31Rdoo5I8s/Taa0
         nLv/OGz82RdUfjRy3znYw9mKj1wPkJ4GL2gUKw/IJcuCb63ny0sPnvb9z68DN2VHCekz
         /1AMRa4RTsTy/cKY4kAppZTnGlN295ffZHVoo7/B7M+1B4vHqlsGt8Mt5CnUMyl+gSVD
         R9Rg==
X-Gm-Message-State: AOJu0Yxb/EcyRR/ptuZC4Efr8iMQIJqcI0MSwqsMdfmmHaj7rFjIBA1z
	2LmCJctgJQm5g3YzyY/uaDXA3miSvCA/4acIeZu3+xl3lgN+aP0lIfcLD9Tb/bas088JDUsfZ20
	urqPO2w==
X-Gm-Gg: AR+sD10EM0e4vHqQETTlP3IO5El4lQPoeR1yX4Kaf3NwQL2bThrOOUMb83DSlsBGbKZ
	wdPfMvgNDI5bBvGWncxtzJHpl8JV6Q8mCnPyAYwuIhHDMEAJomQ+DeIiCLKvyvPRWfsk/I6leYV
	I6CyZE2kaonB6w1SBbyECHZULU041gNOfkHn1KVg+yTX09PXx7vw7Cp594VmyXBHp8pK1t0Pg4I
	uFxkzFukogBg5e2EwuP0fS8+445EYc141YeYFZvtx6AoyrqNX3iXPZAXbM65oKE9CrKMKqe69LW
	Zx8Lf/qgOpy+0TrrSBDpMkwnwJZD397IeoJkdMrTHFnXfCXDdiGw2jTg7NaHM5DLspP0SHrV314
	bafCXe4P3i2uot0qoYyI79SxbpQjhm4s0ieBuJbYvqrZCQx6HHaNBccH6q8mtVq+3RGBLep88f0
	sX7EychfNVRTKPh6HyYRDrUN9KFgughYAFPcAiQ/okoqRiKIld2BVd1WklKGjrsIK8DDmA/Bb1m
	NaTkKj3MUcEgOfqGOSMJYAzJ2JQuM5m
X-Received: by 2002:a05:600c:3796:b0:495:4811:7998 with SMTP id 5b1f17b1804b1-49987993e08mr307088115e9.17.1786961690475;
        Mon, 17 Aug 2026 03:14:50 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49996109652sm169231445e9.4.2026.08.17.03.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 03:14:49 -0700 (PDT)
Date: Mon, 17 Aug 2026 11:14:46 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] ring-buffer: Improve nr_pages type
Message-ID: <aoLfFtBTvvyvI_Wu@google.com>
References: <20260814154823.755406-1-vdonnefort@google.com>
 <20260814154823.755406-3-vdonnefort@google.com>
 <20260814155944.F017E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260814155944.F017E1F000E9@smtp.kernel.org>

On Fri, Aug 14, 2026 at 03:59:44PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> 
> New issues:
> - [High] When `nr_pages` is exactly `U32_MAX - 1`, the expression `meta->nr_subbufs + 1` overflows to 0, silently skipping persistent ring buffer validation and wiping data.
> 
> Pre-existing issues:
> - [Critical] Loop counters iterating over `meta->nr_subbufs` are typed as `signed int`, which wrap to negative values for extremely large buffers, leading to out-of-bounds memory accesses.
> - [Critical] The `meta->nr_subbufs` field is read from potentially corrupted persistent memory and used without validation against `nr_pages`, causing a heap out-of-bounds write in `bitmap_clear()`.
> - [High] Multiplication of `subbuf_size` and `idx` overflows 32 bits for ring buffers > 4GB, causing severe memory aliasing.
> --
> 
> --- Patch [2]: [PATCH v6 2/2] ring-buffer: Improve nr_pages type ---
> commit 030ec6a7ceec6e71123077bd1fc64e0cf5c27cc8
> Author: Vincent Donnefort <vdonnefort@google.com>
> 
> ring-buffer: Improve nr_pages type
> 
> If ring_buffer_per_cpu::nr_pages is defined as unsigned long, it is
> capped to 32-bits in a few places, limiting the operations possible on a
> very large buffer.
> 
> [ ... ]
> 
> > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > index ec13779922ffb..ec127e2ad0527 100644
> > --- a/kernel/trace/ring_buffer.c
> > +++ b/kernel/trace/ring_buffer.c
> 
> [ ... ]
> 
> > @@ -1746,8 +1745,8 @@ static void *rb_subbufs_from_meta(struct ring_buffer_cpu_meta *meta)
> >  static void *rb_range_buffer(struct ring_buffer_per_cpu *cpu_buffer, int idx)
> >  {
> >  	struct ring_buffer_cpu_meta *meta;
> > +	unsigned int subbuf_size;
> >  	unsigned long ptr;
> > -	int subbuf_size;
> >  
> >  	meta = rb_range_meta(cpu_buffer->buffer, 0, cpu_buffer->cpu);
> >  	if (!meta)
> 
> [Severity: High]
> This is a pre-existing issue, but does the multiplication of subbuf_size and
> idx overflow 32 bits for ring buffers larger than 4GB?
> 
> In rb_range_buffer(), we have:
> 
>     subbuf_size = meta->subbuf_size;
>     idx = meta->buffers[idx];
>     ptr = (unsigned long)rb_subbufs_from_meta(meta);
>     ptr += subbuf_size * idx;
> 
> Since subbuf_size is an unsigned int and idx is an int, the multiplication
> evaluates as a 32-bit unsigned integer. For ring buffers over 4GB, this can
> overflow and wrap around before being zero-extended and added to the 64-bit
> ptr, causing memory aliasing by overwriting earlier subbuffers.

I can add this to this patch/

> 
> [ ... ]
> 
> > @@ -1840,10 +1839,10 @@ static bool rb_meta_init(struct trace_buffer *buffer, int scratch_size)
> >   * must be the same.
> >   */
> >  static bool rb_cpu_meta_valid(struct ring_buffer_cpu_meta *meta, int cpu,
> > -			      struct trace_buffer *buffer, int nr_pages,
> > +			      struct trace_buffer *buffer, unsigned long nr_pages,
> >  			      unsigned long *subbuf_mask)
> >  {
> > -	int subbuf_size = PAGE_SIZE;
> > +	unsigned int subbuf_size = PAGE_SIZE;
> >  	unsigned long buffers_start;
> >  	unsigned long buffers_end;
> >  	int i;
> 
> [Severity: Critical]
> This is a pre-existing issue, but will loop counters iterating over
> meta->nr_subbufs wrap to negative values for extremely large buffers?
> 
> In rb_cpu_meta_valid():
> 
>     for (i = 0; i < meta->nr_subbufs; i++) {
>         if (meta->buffers[i] < 0 || ...
> 
> And in rb_range_meta_init():
> 
>     for (i = 0; i < meta->nr_subbufs; i++) {
>         meta->buffers[i] = i;
> 
> The loop counter i is a signed int. Since nr_pages can now go up to
> U32_MAX - 1, if the buffer size pushes meta->nr_subbufs past INT_MAX, i
> will wrap to negative. i < meta->nr_subbufs will promote i to unsigned,
> evaluating to true, and the negative index will be sign-extended on 64-bit
> architectures, causing out-of-bounds reads and writes.

Yeah sure, I'll make it unsigned int... doesn't sound too critical though!

> 
> [Severity: Critical]
> This is a pre-existing issue, but could meta->nr_subbufs cause a heap
> out-of-bounds write if it doesn't match nr_pages?
> 
> In rb_cpu_meta_valid():
> 
>     bitmap_clear(subbuf_mask, 0, meta->nr_subbufs);
> 
>     for (i = 0; i < meta->nr_subbufs; i++) {
>         ...
>         set_bit(meta->buffers[i], subbuf_mask);
> 
> meta->nr_subbufs is read directly from persistent memory and used without
> being validated against the dynamically allocated subbuf_mask size, which is
> based on nr_pages + 1. If meta->nr_subbufs is maliciously or accidentally set
> larger than nr_pages + 1, bitmap_clear() and set_bit() will write zeroes and
> ones past the end of the bitmap allocation.

Sure, but that'll be another patch.

> 
> [ ... ]
> 
> > @@ -2837,6 +2837,10 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
> >  		 */
> >  		nr_pages = (size - sizeof(struct ring_buffer_cpu_meta)) /
> >  			(subbuf_size + sizeof(int));
> > +
> > +		/* limited by ring_buffer_cpu_meta::nr_subbufs */
> > +		if (nr_pages > U32_MAX - 1)
> > +			goto fail_free_buffers;
> >  		/* Need at least two pages plus the reader page */
> >  		if (nr_pages < 3)
> >  			goto fail_free_buffers;
> 
> [Severity: High]
> Does meta->nr_subbufs + 1 overflow when nr_pages is exactly U32_MAX - 1?
> 
> If nr_pages is exactly U32_MAX - 1, meta->nr_subbufs becomes U32_MAX.
> In rb_meta_validate_events(), there are loops with this condition:
> 
>     for (i = 0; i < meta->nr_subbufs + 1; i++, rb_dec_page(&head_page)) {
> 
> U32_MAX + 1 overflows to 0 in 32-bit unsigned arithmetic. This makes the loop
> condition i < 0, causing the loops to terminate immediately without rewinding
> and validating the persistent ring buffer from a previous boot.

Sure, this can be  unsigned it as well...

And there are plenty of other functions that need fixing then.
rb_meta_subbuf_idx, rb_cpu_meta_valid, __rb_get_reader_page, rb_iter_peek... 

I need a bit more time to audit what must be modified.

-- 
Vincent

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260814154823.755406-1-vdonnefort@google.com?part=2
