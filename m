Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EEC3F5BFD
	for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Aug 2026 10:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786962431; cv=none; b=SK+Uz3+ZLxhKlFurWoCxYyHK8vRsqz9vuGyRK1BpoDH+Dk2C7UwtqqLfcCFEw55sUhHenZwTO8eEh+kJBWsrNKbI8R0s9tjY89hpeAd6cAsId0eK39oK4sxHMALuAI3apEsqVRTxis5Chi9KUn8ZHOrTsJW0SVCKLYTQDVjORCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786962431; c=relaxed/simple;
	bh=GmyHdqZmRLI3WI9sTLJ+TBQ84ImAIi3nhCQNwW+JshY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oPbHJLQ4Pwz5+1Lo3r7O2d8JlCqenFUAPKkY8xFAUHo80coBU/F+F1PcS4QWD0Qs0GbD5Cyek3y34tuum4AE1lwL6r0Y2kQ4/d1gnQd3TsJU1fYHGxBbxGni4QzI+1IpUtVlcj5jsUzWWngowHSk0qhg2KeqPa6FBB3Tl/sYoAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OgRxXn0h; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OgRxXn0h"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49545ba3d4eso15206155e9.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Aug 2026 03:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786962426; x=1787567226; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tPiELKIFrUueStBDV+f+2bCYmZSbeJm73pkY576W4Us=;
        b=OgRxXn0hfLV9uehelNYlSMbBbYYwso7JwbEsxuEF8AKZDTTglVX7beSBU6zQ/TxUNN
         8cshUI2878odnw0YnVeXC/P+Jg3oetknyhbryBsisBrShorIoXR+5wK1fvC93pgMZ88h
         AcCIOF1kRNNIhreBStVbMD9JDhCbillOwnEZtLAEgU7kpn1M3AT+ukPk/bF5mGdTOoUL
         i1178H+ttOXJ7BxzVpG6MM/oua/sE2eVC0/0ulGOc1ohgKnqePTgzi990u4rsg7qiyum
         mDb9ojma5n+LFDjF3oDNU5gg8W0ZewJtRtIGt972l4N8YC7auWcAdbpM+6DdjQMXbjbU
         DJUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786962426; x=1787567226;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tPiELKIFrUueStBDV+f+2bCYmZSbeJm73pkY576W4Us=;
        b=StMATq+wqNXdrk1SbhKoCwDm6U8n+kROq59eDeeR8ZaVdT8eZ/bNtGeLfPX7gGLvP1
         LyPvEYrmuyprSWLVCTj8d+3yktFTmwqevoYJd8eBIUTImcWmkl0J9LO0bzBQ9i/UMMuQ
         HIpUpGB7d9X2e2I0/yj2rW/eVl0pK/fJc2AL4hC9BAq9t2Ao9Tlac2zLaNklkz3Wt8Ou
         h7nNj5DnC3Mephai5lJ6+czO1psCFOQQzP0eZNGNI64y7bCk1ys8/mJNTZrsFANEk6KL
         oErTxAgPws/jzu4mcOml/zpXHMxr1jRUVYl50Unn6UxhHGfza6YBB3zVMBnIz1lGAJQL
         50EA==
X-Forwarded-Encrypted: i=1; AHgh+RqgtEHP4V12lkflBXWFn/fFRAkPs5B+YD6RbdpQN9spq1C2pumKiB6hOIEZdzPbwQLQCfamjQL24HGCYsvFthC//DE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzswcgMyDNBqR6YVtRNUaTiGrvJlnlpFTyWOd1wa/Qya6CaLxbn
	NeK3vx7pkuk1WezbRm/gpIMiYAr+m1lQInOrqvTiFyshvAElbI1LZKamAn2mROVo6Ijkre1KNay
	3qiS3RQ==
X-Gm-Gg: AR+sD12g+XFQeYZzkfexK/AJfx9IyDJzbLUVj39ktpjcFXPH97+jCQlzPcgdtkcHBG1
	A1g2pTC9fuZqiOFv9R8g/JppplAz6LGxyILqhWi785Pf6VcTsf/K4XdP9kabBUR+23vfpOnFRwg
	rrQxSZ01m6alqFzK2JyNORPfQK5xA1iT5pIQwHTn8PRaYb7QFxSRxUsGj/GONIP3I7mSW5b+CXM
	bdl1UOdgvWF5Sbf6swPUk/LN0kQlPYH81gwG6/rB7DqSFjiQYamD4Z0aqcB+SZkb4xwN+pRd8Tq
	zktCJcJNk3THpma9x5OO7sF8iKyWxyL7CILIft4LIFeLhskkuziSWSmPBm2xPGx4z8Vi7zkeZRf
	YJ0j5SoAgT6MMpoQjFlfo264NMGQcxysfWxUY/l7JADKwES4LjXFpG+Ud2ByEKb4Lk00f1ffKsl
	qQhF6jnafypsWjVynKmHGfjlcZPVcwkbB8AWb7caCSXqrEaYFgFTaGIX715Xp57WsQAlSwtsf8g
	xH2pXlVBUxjY24OMX/g6hDQb/uuLRE949Wl0eE8LSs=
X-Received: by 2002:a05:600c:34ca:b0:499:7f38:d77 with SMTP id 5b1f17b1804b1-49988cab011mr381517215e9.6.1786962425777;
        Mon, 17 Aug 2026 03:27:05 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4999d063a68sm26758815e9.2.2026.08.17.03.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 03:27:05 -0700 (PDT)
Date: Mon, 17 Aug 2026 11:27:01 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] ring-buffer: Improve nr_pages type
Message-ID: <aoLh9djyr-3PFSvj@google.com>
References: <20260814154823.755406-1-vdonnefort@google.com>
 <20260814154823.755406-3-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814154823.755406-3-vdonnefort@google.com>

On Fri, Aug 14, 2026 at 04:48:23PM +0100, Vincent Donnefort wrote:
> If ring_buffer_per_cpu::nr_pages is defined as unsigned long, it is
> capped to 32-bits in a few places, limiting the operations possible on a
> very large buffer.
> 
> Make sure nr_pages is never capped to 32-bits (that includes nr_subbufs)
> and reject a value over 32-bits for the user-mapped, persistent buffer
> and remote buffer cases where the limiting factor is the shared
> meta-data member for the number of pages/subbufs.
> 
> While at it, make sure subbuf_size is 'unsigned int'.
> 
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> ---
>  kernel/trace/ring_buffer.c | 46 ++++++++++++++++++++++++--------------
>  1 file changed, 29 insertions(+), 17 deletions(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index ec13779922ff..ec127e2ad052 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -1669,7 +1669,7 @@ static void rb_check_pages(struct ring_buffer_per_cpu *cpu_buffer)
>   * This is used to help find the next per cpu subbuffer within a mapped range.
>   */
>  static unsigned long
> -rb_range_align_subbuf(unsigned long addr, int subbuf_size, int nr_subbufs)
> +rb_range_align_subbuf(unsigned long addr, unsigned int subbuf_size, unsigned long nr_subbufs)
>  {
>  	addr += sizeof(struct ring_buffer_cpu_meta) +
>  		sizeof(int) * nr_subbufs;
> @@ -1679,13 +1679,12 @@ rb_range_align_subbuf(unsigned long addr, int subbuf_size, int nr_subbufs)
>  /*
>   * Return the ring_buffer_meta for a given @cpu.
>   */
> -static void *rb_range_meta(struct trace_buffer *buffer, int nr_pages, int cpu)
> +static void *rb_range_meta(struct trace_buffer *buffer, unsigned long nr_pages, int cpu)
>  {
> -	int subbuf_size = rb_subbuf_size(buffer);
> +	unsigned int subbuf_size = rb_subbuf_size(buffer);
>  	struct ring_buffer_cpu_meta *meta;
>  	struct ring_buffer_meta *bmeta;
> -	unsigned long ptr;
> -	int nr_subbufs;
> +	unsigned long ptr, nr_subbufs;
>  
>  	bmeta = buffer->meta;
>  	if (!bmeta)
> @@ -1731,7 +1730,7 @@ static void *rb_range_meta(struct trace_buffer *buffer, int nr_pages, int cpu)
>  /* Return the start of subbufs given the meta pointer */
>  static void *rb_subbufs_from_meta(struct ring_buffer_cpu_meta *meta)
>  {
> -	int subbuf_size = meta->subbuf_size;
> +	unsigned int subbuf_size = meta->subbuf_size;
>  	unsigned long ptr;
>  
>  	ptr = (unsigned long)meta;
> @@ -1746,8 +1745,8 @@ static void *rb_subbufs_from_meta(struct ring_buffer_cpu_meta *meta)
>  static void *rb_range_buffer(struct ring_buffer_per_cpu *cpu_buffer, int idx)
>  {
>  	struct ring_buffer_cpu_meta *meta;
> +	unsigned int subbuf_size;
>  	unsigned long ptr;
> -	int subbuf_size;
>  
>  	meta = rb_range_meta(cpu_buffer->buffer, 0, cpu_buffer->cpu);
>  	if (!meta)
> @@ -1840,10 +1839,10 @@ static bool rb_meta_init(struct trace_buffer *buffer, int scratch_size)
>   * must be the same.
>   */
>  static bool rb_cpu_meta_valid(struct ring_buffer_cpu_meta *meta, int cpu,
> -			      struct trace_buffer *buffer, int nr_pages,
> +			      struct trace_buffer *buffer, unsigned long nr_pages,
>  			      unsigned long *subbuf_mask)
>  {
> -	int subbuf_size = PAGE_SIZE;
> +	unsigned int subbuf_size = PAGE_SIZE;
>  	unsigned long buffers_start;
>  	unsigned long buffers_end;
>  	int i;
> @@ -2231,7 +2230,8 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
>  	}
>  }
>  
> -static void rb_range_meta_init(struct trace_buffer *buffer, int nr_pages, int scratch_size)
> +static void rb_range_meta_init(struct trace_buffer *buffer,
> +			       unsigned long nr_pages, int scratch_size)
>  {
>  	struct ring_buffer_cpu_meta *meta;
>  	unsigned long *subbuf_mask;
> @@ -2417,7 +2417,7 @@ static void *ring_buffer_desc_page(struct ring_buffer_desc *desc, unsigned int p
>  }
>  
>  static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
> -		long nr_pages, struct list_head *pages)
> +			       unsigned long nr_pages, struct list_head *pages)
>  {
>  	struct trace_buffer *buffer = cpu_buffer->buffer;
>  	struct ring_buffer_cpu_meta *meta = NULL;
> @@ -2545,7 +2545,7 @@ static int rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
>  }
>  
>  static struct ring_buffer_per_cpu *
> -rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
> +rb_allocate_cpu_buffer(struct trace_buffer *buffer, unsigned long nr_pages, int cpu)
>  {
>  	struct ring_buffer_per_cpu *cpu_buffer __free(kfree) =
>  		alloc_cpu_buffer(cpu);
> @@ -2702,8 +2702,8 @@ static void rb_test_inject_invalid_pages(struct trace_buffer *buffer)
>  	struct ring_buffer_cpu_meta *meta;
>  	struct buffer_data_page *dpage;
>  	unsigned long entry_bytes = 0;
> +	unsigned int subbuf_size;
>  	unsigned long ptr;
> -	int subbuf_size;
>  	int invalid = 0;
>  	int cpu;
>  	int i;
> @@ -2773,8 +2773,8 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
>  					 struct ring_buffer_remote *remote)
>  {
>  	struct trace_buffer *buffer __free(kfree) = NULL;
> -	long nr_pages;
> -	int subbuf_size;
> +	unsigned int subbuf_size;
> +	unsigned long nr_pages;
>  	int bsize;
>  	int cpu;
>  	int ret;
> @@ -2837,6 +2837,10 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
>  		 */
>  		nr_pages = (size - sizeof(struct ring_buffer_cpu_meta)) /
>  			(subbuf_size + sizeof(int));
> +
> +		/* limited by ring_buffer_cpu_meta::nr_subbufs */
> +		if (nr_pages > U32_MAX - 1)
> +			goto fail_free_buffers;
>  		/* Need at least two pages plus the reader page */
>  		if (nr_pages < 3)
>  			goto fail_free_buffers;
> @@ -2869,6 +2873,10 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
>  		/* The writer is remote. This ring-buffer is read-only */
>  		atomic_inc(&buffer->record_disabled);
>  		nr_pages = desc->nr_page_va - 1;
> +
> +		/* limited by ring_buffer_desc::nr_page_va */
> +		if (nr_pages > U32_MAX - 1)
> +			goto fail_free_buffers;
>  		if (nr_pages < 2)
>  			goto fail_free_buffers;
>  	} else {
> @@ -7421,8 +7429,8 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
>  	struct ring_buffer_per_cpu *cpu_buffer;
>  	struct buffer_page *bpage, *tmp;
>  	unsigned int old_capacity;
> +	unsigned long nr_pages;
>  	int old_order;
> -	int nr_pages;
>  	int psize;
>  	int err;
>  	int cpu;
> @@ -7604,7 +7612,7 @@ static void rb_setup_ids_meta_page(struct ring_buffer_per_cpu *cpu_buffer,
>  				   struct buffer_page **subbuf_ids)
>  {
>  	struct trace_buffer_meta *meta = cpu_buffer->meta_page;
> -	unsigned int nr_subbufs = cpu_buffer->nr_pages + 1;
> +	unsigned long nr_subbufs = cpu_buffer->nr_pages + 1;
>  	struct buffer_page *first_subbuf, *subbuf;
>  	int cnt = 0;
>  	int id = 0;
> @@ -7834,6 +7842,10 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu,
>  	/* prevent another thread from changing buffer/sub-buffer sizes */
>  	guard(mutex)(&buffer->mutex);
>  
> +	/* limited by trace_buffer_meta::nr_subbufs */

And actually I have realised the limiting factor is bpage::id which is only
30-bits.

> +	if (cpu_buffer->nr_pages > U32_MAX - 1)
> +		return -E2BIG;
> +
>  	err = rb_alloc_meta_page(cpu_buffer);
>  	if (err)
>  		return err;
> -- 
> 2.55.0.691.gc56d675ccc-goog
> 

-- 
Vincent
