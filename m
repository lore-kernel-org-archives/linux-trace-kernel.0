Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0D33BCD15
	for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Aug 2026 08:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786957166; cv=none; b=YEe2NjyguS1AD+KUV8EvDSHQ29Q06g1QivSCRyl4VYRVrL08CkebnXzzid4XnsDXzN32CpwvXjSGDxXknEOK2oRxRdrmHysWC+xNwbsF9sqwlMZcQOZzPi7ewo++zLcS1cRmONIbO9NrUZVifevhy7WznyFsRNVpQ6dQPwv9Otk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786957166; c=relaxed/simple;
	bh=xJIEeihHO4dBb8t+tKQl49oNaKaV3U2o+zVIOGTcnDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gZUlx9qqCmvxXQbFmoVZtE9PojbVp1CUPUYrbcdhQOa8S4Ye/jJ0qEHpz0U9gTUe9HUa1erRqA3RDqr3dtc4UZ/R3b3MI2Ftg04IylZ+NxR/1PlE+NtZxI9WzHVOOR60yAVcNWO0AHHAGhW+aihZ23lp08hF/VkIzoK+OFCtYlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v+5WJVLm; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v+5WJVLm"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47de0093c42so2797803f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Aug 2026 01:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786957163; x=1787561963; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FOD9TYZLxF2wuWdQdal4PAnTjp03fbomEm3+kFwX6Ec=;
        b=v+5WJVLmBVE/986BdhshJhAzboLm66qelcLUbeA4yRYs8AW9CfaKydhTZ/mJj9SMu9
         kIMFwa2CI08a5KfyerFPOx6QC+OjGbr/22rkaJ6+EVwNgKvWIbwOKVvhYdcWDd0dVFxP
         c2DRriv6ekdbr5B5Ri8WZYB+sRv9SG62ivubHAt36Q0MDvNYvSmMBli940o1scckFOja
         ankj/ae4OwzkjPgcrvXMZykQ2X/iPXd9wzZ+ONV/lWCxJQmJ9Vfv7aF4DXN6dkSOJBiH
         Bx8Fr837+lnjkU2OL6+/50vg17E/mYW4SovfkvmVGQBFIaSNt78coa62blI+wxlYkm+f
         abyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786957163; x=1787561963;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FOD9TYZLxF2wuWdQdal4PAnTjp03fbomEm3+kFwX6Ec=;
        b=Z1GCAxfx1MpiHjdeaUNYO7xK9w8EmCKc9nL99QTWREXtEnIeLJugKcbVZP0QtVWavY
         Vgb4TTf0w/zY/8x9QU5HEIl4hkBCTfUNbFqWkvgofhtUg5bmaGssUDTn7A6Vn3hZ1NFC
         gD05lFI9RLjE04PnWoH6y5a9JpQJM+AHigIl6qJ0gwNg5AwJDb3rmMtm7iqdawS/YrgY
         dD1rSul+W+SUKZ4nRuRuPkEEewccW/PS2I7lMoBrEKrZcQ0zxVT2bed1s6syAf4L90vO
         uZWnxNCRxfGUu/cAzEC5jlqk5TXWI6w9fP009lBG5VAPddKwxsfQfBVHD2PWVMRvTvAP
         rkUQ==
X-Gm-Message-State: AOJu0YyafUr0lwHas/LWeKx20E/zeIOaz3JGbPETq/ri4gH5owp1rgq5
	b0ZqO6fS5SrYADCkTUtDtIbGrOOpjQMO8p3L3eF/h1Kbax2VjlfEo0CMf5Jnxcq32g==
X-Gm-Gg: AR+sD13GJGrBUs+FvOBT4EFTj28Y2CuPfkFZNahwlAVMORxjsLdOLUXosE5HG2+auES
	PoYUGnLVKDpQjpZXUBnNCN+S5dwB0RbxBmvrBVTgdUGcOhjM5wPqT4a9fKVrdyJXOiK8AmzodBx
	pfmCoK0WEkIWh2mX3fhM5AoDz2I/79+4owBOl5yDF8GhbN/LfRTHszkfTvxGXVSRXhcNsAXrZ7y
	xkBnymYOaHpReg4hvRvIkJeFYWDUrGwltsBnZX9f2a8O5S3x9m9PxwbdM8Q1a/zLjGR7/eCrL5E
	JqlVYkQgoAH3X3pAjgPuGZYCfNz4mhvD8nZm1QlGm19tezSXCdnw3BEM6heq0yhmnMjH02pufS2
	WYp/UlonO/Fg1tu7M3IjC0tuwLEOGGDxWVZwMHsK0b+HwslfTVkc7qj1cT8QboiMz/i8kC5cZbS
	vnvD3OjGbusuwTKW814kYm8OnrAdwNlfPJWdyLb9E9yg7mHcomQCTTJPC3nxe6/Pn6odS7/LoUA
	0Pt6jUiZTguEZwNdhF4fMUW5YfzrFm5fCcXTQ==
X-Received: by 2002:a05:600c:6089:b0:499:86ce:465e with SMTP id 5b1f17b1804b1-49987941e38mr410987395e9.4.1786957162597;
        Mon, 17 Aug 2026 01:59:22 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49996188217sm290360645e9.13.2026.08.17.01.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 01:59:22 -0700 (PDT)
Date: Mon, 17 Aug 2026 09:59:18 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] tracing: Fix subbuf resize races with
 trace_pipe_raw readers
Message-ID: <aoLNZqmXWwac39yW@google.com>
References: <20260814154823.755406-1-vdonnefort@google.com>
 <20260814154823.755406-2-vdonnefort@google.com>
 <20260814160130.E69F21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260814160130.E69F21F000E9@smtp.kernel.org>

On Fri, Aug 14, 2026 at 04:01:30PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] The local variable `spare_size` is left uninitialized via `goto read;` in `tracing_buffers_read()`, resulting in a kernel memory leak to userspace.
> --
> 
> --- Patch [1]: [PATCH v6 1/2] tracing: Fix subbuf resize races with trace_pipe_raw readers ---
> commit bdc760fe7b1aa6eb8c8a8b8c38e9fd02d25051b6
> Author: Vincent Donnefort <vdonnefort@google.com>
> 
> tracing: Fix subbuf resize races with trace_pipe_raw readers
> 
> Concurrent subbuffer resizes may crash trace_pipe_raw readers or leak
> uninitialized memory to userspace due to stale size values. This commit
> modifies ring_buffer_alloc_read_page() to handle resizing and introduces
> ring_buffer_read_page_size().
> 
> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > index 395238b2b715c..355278083b3fb 100644
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> [ ... ]
> > @@ -7091,36 +7091,21 @@ ssize_t tracing_buffers_read(struct file *filp, char __user *ubuf,
> >  	if (iter->snapshot && tracer_uses_snapshot(iter->tr->current_trace))
> >  		return -EBUSY;
> >  
> > -	page_size = ring_buffer_subbuf_size_get(iter->array_buffer->buffer);
> > -
> > -	/* Make sure the spare matches the current sub buffer size */
> > -	if (info->spare) {
> > -		if (page_size != info->spare_size) {
> > -			ring_buffer_free_read_page(iter->array_buffer->buffer,
> > -						   info->spare_cpu, info->spare);
> > -			info->spare = NULL;
> > -		}
> > -	}
> > +again:
> > +	/* Do we have previous read data to read? */
> > +	if (info->spare && (info->read < ring_buffer_read_page_size(info->spare)))
> > +		goto read;
> >  
> > -	if (!info->spare) {
> > -		info->spare = ring_buffer_alloc_read_page(iter->array_buffer->buffer,
> > -							  iter->cpu_file);
> > -		if (IS_ERR(info->spare)) {
> > -			ret = PTR_ERR(info->spare);
> > -			info->spare = NULL;
> > -		} else {
> > -			info->spare_cpu = iter->cpu_file;
> > -			info->spare_size = page_size;
> > -		}
> > -	}
> > -	if (!info->spare)
> > +	/* Make sure the read page order is aligned with the current buffer subbuf order */
> > +	ret = ring_buffer_alloc_read_page(iter->array_buffer->buffer, iter->cpu_file,
> > +					  &info->spare);
> > +	if (ret < 0)
> >  		return ret;
> >  
> > -	/* Do we have previous read data to read? */
> > -	if (info->read < page_size)
> > -		goto read;
> > +	spare_size = ring_buffer_read_page_size(info->spare);
> > +	info->read = spare_size;
> > +	info->spare_cpu = iter->cpu_file;
> >  
> > - again:
> >  	trace_access_lock(iter->cpu_file);
> >  	ret = ring_buffer_read_page(iter->array_buffer->buffer,
> >  				    info->spare,
> [ ... ]
> > @@ -7146,8 +7133,9 @@ ssize_t tracing_buffers_read(struct file *filp, char __user *ubuf,
> >  	}
> >  
> >  	info->read = 0;
> > +
> >   read:
> > -	size = page_size - info->read;
> > +	size = spare_size - info->read;
> 
> [Severity: High]
> Can this regression leak uninitialized stack memory to userspace?
> 
> If a userspace process does a partial read (consuming fewer bytes than a full
> subbuffer page), the next read syscall will take the goto read; branch at the
> top of tracing_buffers_read().
> 
> When that branch is taken, spare_size is completely uninitialized stack memory.
> 
> Could size end up being a large garbage value (or underflow if spare_size <
> info->read), causing copy_to_user() below to read beyond the bounds of
> info->spare and leak arbitrary kernel memory?

sigh... I hope I will eventually get this right!

	 again:
	-       /* Do we have previous read data to read? */
	-       if (info->spare && (info->read < ring_buffer_read_page_size(info->spare)))
	-               goto read;
	+       if (info->spare) {
	+               spare_size = ring_buffer_read_page_size(info->spare);
	+               /* Do we have previous read data to read? */
	+               if (info->read < spare_size)
	+                       goto read;
	+       }

This should do.

> 
> >  	if (size > count)
> >  		size = count;
> >  	trace_data = ring_buffer_read_page_data(info->spare);
> >  	ret = copy_to_user(ubuf, trace_data + info->read, size);
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260814154823.755406-1-vdonnefort@google.com?part=1

-- 
Vincent
