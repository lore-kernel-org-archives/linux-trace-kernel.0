Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B7E86346;
	Fri, 14 Feb 2025 14:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739543777; cv=none; b=VvXx0NEa8gjH3f+WPVeT8AkmJDFfxKVGK/iGJRUx6qaUuyAdXc16hgL1U6NpJ7nYE9f7tepZoyi5Qw5cpBzOgmKXmD19c/5hWPz5WFqSCorp06p38S8E0SxDH7b2fltQo9kCwWNfb2iva6o2lANJ0IfcooyK6EyehSGdZlMvJWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739543777; c=relaxed/simple;
	bh=orzrmR8/qa3ucQ6xBucX3yLnXyJJkOmswiAW80DJzOg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=PxmAnnAMCV4tbcS5k5+iyuixqSiROR90gwDbvjaRM6dFZgGVBnAoNyHjBt0n7kUPstcR+j2fhnluZ6jYE0LbBjBp+WnzdcLpc2Y/qxmsoNAGB3V4eq8Y+RrzBe+SG109A0s1ygoyYlvgT0dGsAveuMG/zxbIAvJyForitpC07MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sUdwSNmi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sUdwSNmi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33702C4CED1;
	Fri, 14 Feb 2025 14:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739543776;
	bh=orzrmR8/qa3ucQ6xBucX3yLnXyJJkOmswiAW80DJzOg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sUdwSNmi9mJ266fAiUgl02jrqwzA+1PSgpPBfhQ4S48lhs/3VJZg8vvGe1TTvVuYK
	 sM81w7QkbytNeBvYs3RGDH9sJAaUS/7R1T+i4XQvr+w+A/MmuCNZ6+mLp1Zg/ZKePh
	 ZnSJuj9rXsM6H8J5N/AWz51qa6NY3xUrHTEJ/eDvdmNTbBqSTHPt1r6MulzqV39vYx
	 boLcdboOnTg2cOioiiB5clgazbEqDXix/kdZDi8aAqDHQf/EGpgzgJVhzbXCa3rRpS
	 fnAV0x1x8TMdFy2jXZisJENWAdc2VFa6NXwbP5xNB7I59Rxl+80DiMpNH5JCV8BMEw
	 4JjVNFSK/Vx0g==
Date: Fri, 14 Feb 2025 23:36:13 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Vincent Donnefort <vdonnefort@google.com>
Subject: Re: [PATCH] tracing: Do not allow mmap() of persistent ring buffer
Message-Id: <20250214233613.bde0638f393186f56f0b30eb@kernel.org>
In-Reply-To: <20250214070712.01997ea1@gandalf.local.home>
References: <20250213180737.061871ae@gandalf.local.home>
	<20250214110722.7eaf35b42c4858e6b74500f7@kernel.org>
	<20250213212147.6511b235@gandalf.local.home>
	<20250214161332.8797b20f09e068c33f872698@kernel.org>
	<20250214070712.01997ea1@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Feb 2025 07:07:12 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 14 Feb 2025 16:13:32 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > On Thu, 13 Feb 2025 21:21:47 -0500
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > > On Fri, 14 Feb 2025 11:07:22 +0900
> > > Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> > >   
> > > > This may be good for fixing crash short term but may not allow us to read the
> > > > subbufs which is read right before crash. Can we also add an option to reset
> > > > the read pointer in the previous boot for the persistent ring buffer?  
> > > 
> > > I'm not sure what you mean here.
> > > 
> > > Note, this is just for mmapping the buffers. Currently we never tried it as
> > > if we did, it would have crashed. But this does not affect normal reads.  
> > 
> > But reading buffer via mmap() is already supported. Can we read all pages,
> > which had been read by trace_pipe_raw in previous boot, again on this boot?
> 
> It's not supported. If you try it, it will crash. This prevents reading via
> mmap() on a boot buffer. I don't know what you are asking. Once this patch
> is applied, mmap() will always fail on the boot buffer before or after you
> start it.

Hmm, I meant it is supported for other non-persisten ring buffer, isn't it?

> 
> > 
> > Anyway, I made another patch to fix it to allow mmap() on persistent ring
> > buffer here. I thought I can get the phys_addr from struct vm_area, but
> > it could not for vmap()'d area. So this stores the phys_addr in trace_buffer.
> 
> Which is way too complex and intrusive. If you want to allow mapping, all
> it needs is this:

Ah, vmalloc_to_page() works, I see.

> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 07b421115692..9339adc88ad5 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -5927,12 +5941,18 @@ static void rb_clear_buffer_page(struct buffer_page *page)
>  static void rb_update_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
>  {
>  	struct trace_buffer_meta *meta = cpu_buffer->meta_page;
> +	struct page *page;
>  
>  	if (!meta)
>  		return;
>  
>  	meta->reader.read = cpu_buffer->reader_page->read;
> -	meta->reader.id = cpu_buffer->reader_page->id;
> +	/* For boot buffers, the id is the index */
> +	if (cpu_buffer->ring_meta)
> +		meta->reader.id = rb_meta_subbuf_idx(cpu_buffer->ring_meta,
> +						     cpu_buffer->reader_page->page);
> +	else
> +		meta->reader.id = cpu_buffer->reader_page->id;
>  	meta->reader.lost_events = cpu_buffer->lost_events;
>  
>  	meta->entries = local_read(&cpu_buffer->entries);
> @@ -5940,7 +5960,12 @@ static void rb_update_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
>  	meta->read = cpu_buffer->read;
>  
>  	/* Some archs do not have data cache coherency between kernel and user-space */
> -	flush_dcache_folio(virt_to_folio(cpu_buffer->meta_page));
> +	if (virt_addr_valid(cpu_buffer->meta_page))
> +		page = virt_to_page(cpu_buffer->meta_page);
> +	else
> +		page = vmalloc_to_page(cpu_buffer->meta_page);
> +
> +	flush_dcache_folio(page_folio(page));
>  }
>  
>  static void
> @@ -7041,7 +7066,10 @@ static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
>  			goto out;
>  		}
>  
> -		page = virt_to_page((void *)cpu_buffer->subbuf_ids[s]);
> +		if (virt_addr_valid(cpu_buffer->subbuf_ids[s]))
> +			page = virt_to_page((void *)cpu_buffer->subbuf_ids[s]);
> +		else
> +			page = vmalloc_to_page((void *)cpu_buffer->subbuf_ids[s]);
>  
>  		for (; off < (1 << (subbuf_order)); off++, page++) {
>  			if (p >= nr_pages)
> @@ -7187,6 +7215,7 @@ int ring_buffer_map_get_reader(struct trace_buffer *buffer, int cpu)
>  	unsigned long missed_events;
>  	unsigned long reader_size;
>  	unsigned long flags;
> +	struct page *page;
>  
>  	cpu_buffer = rb_get_mapped_buffer(buffer, cpu);
>  	if (IS_ERR(cpu_buffer))
> @@ -7255,7 +7291,12 @@ int ring_buffer_map_get_reader(struct trace_buffer *buffer, int cpu)
>  
>  out:
>  	/* Some archs do not have data cache coherency between kernel and user-space */
> -	flush_dcache_folio(virt_to_folio(cpu_buffer->reader_page->page));
> +	if (virt_addr_valid(cpu_buffer->meta_page))
> +		page = virt_to_page(cpu_buffer->meta_page);
> +	else
> +		page = vmalloc_to_page(cpu_buffer->meta_page);
> +
> +	flush_dcache_folio(page_folio(page));
>  
>  	rb_update_meta_page(cpu_buffer);
>  
> But this still doesn't work, as the index is still off (I'm still fixing it).

Ah, OK. Thanks for fixing it.

> 
> The persistent ring buffer uses the page->id for one thing but the user
> space mmap() uses it for something else.

Thanks you,

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
