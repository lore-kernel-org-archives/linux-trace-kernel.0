Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B50153BFF
	for <linux-trace-kernel@vger.kernel.org>; Mon, 22 Apr 2024 18:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713810058; cv=none; b=jKjG4n8GVudgPqMeHkX9QLcP6Do+elfBeKXNdXeO2npfLjm3DKjgfRKY3Wob+/GLQsQW0ILngYDkl7dwRr8MsSloVpD1ofUxLKhoNKBXzxcihYp3fn8xVl/aU0IiWHLkCHmrL3SKTDpBSqWWdst5RHJ/JHF4+mNeUPAZy4mPcRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713810058; c=relaxed/simple;
	bh=/OlYd1BdXRj0OH7ZJ9bzg53Eu7yIMWR2EuOQzOePrkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OXpt877QXqJWSAdhwda40slm+56cZsXS2/pqDjA4LFl/GU3zZJr6yj4XiY7GG8v2V2PHMlMY3xaL/2GWN8M2ALiobt9kjMG3hsPM4roiTZFBtLnf1j7zVa97/NV0gRhldrZe2QDYtZjjJ91Tqx7M8BDi6Jw2WOL5coo/K+X3Sbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J1qEoAq2; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J1qEoAq2"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4196c62bb4eso23084755e9.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 22 Apr 2024 11:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713810053; x=1714414853; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wZjtUG1a/GbcMMV+5gh6qXmWbPxih3XxuMfN7gw2rBM=;
        b=J1qEoAq2XUNVhG+23/0U4NQIISWPUBBbQIHK74M5sRNGuqbel7XfQX9mih7zEuy+5U
         rcCvIiCEtDM7mnrHIPpcy4Ij5y3lHH0Bq1O29KdYLgbxLyXIQ61UeHSKTbD0OUhH8wrH
         IM5vPxPMbF/7sETxRdY4RWJ8piDIhoqIneaDEZgs0EEI/zGMC+pp1BmJ2TK1B7UT0r8d
         /uX59ugbuyepOsCtLrloDmWF/UZEt/6EXE6w0DRQJPqX8k4i1P0t1jScuNIuS5Qr1okn
         YqJjaXJMwJiXqho9FJywytdDqfvtn0Ub80sOWytL8PAchZMt12LM3aRfs1SaCXm8Kovr
         73Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713810053; x=1714414853;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wZjtUG1a/GbcMMV+5gh6qXmWbPxih3XxuMfN7gw2rBM=;
        b=HFA501iMLbxudz8NZlJDNiffyhCc9X1a/MxLhN58KZylXubFrICg9GNsRFCsqm6lvr
         GOJd9IgGjBz/mLl+xrPQGmxrGpejEquoIIN++mFcpIXh4X2/v3d+pH7WtveY5GR9/1VZ
         pz+o5SVURNmP0iP6Eh7XlV0Dj6fhGSWFxblJVvA7mo+8whssWQl291Thyqgn/V5Cp5Bi
         v8ASiniRs3DhUImkbewrVknynvvEjxZD3bZzTlpMC7jIqKcAX18dSqY79LQQd1WUR6+u
         vybe0hHp0/6bhnfR8qgKFkYEla7FndVLe3dCdFWE3NF9enyg0pNorHGANHNjzjt9oGiU
         +pRg==
X-Forwarded-Encrypted: i=1; AJvYcCUN2eLcMkfhGSLlkfj802Qy3d9K86SwzQE6oyh5DBKIfiIvoufb9jwV8X6H3y9m+eiJdq22CJ4C8W7xTHw0ypG/d/SUZ6m0BFGu7ZSdEKHywk2K
X-Gm-Message-State: AOJu0YySP6/116cRg4O6y0x9zifbmOT7+TwppQD1pNnIdr72EWDRmofD
	rOdHl42/PP7YvXK+Kg8Wuuu8KmkRKtx2nCG1pNgFUX2IHTTkmR+YCqg+Uwn8fg==
X-Google-Smtp-Source: AGHT+IFigyt7KOsWRb7b2XYfKCpySPBXaDuxvFhCB5q8z7NpeV7MdkMOxGA/MzqqiUk+HpelgcScvQ==
X-Received: by 2002:a05:600c:1988:b0:418:bbb6:95b3 with SMTP id t8-20020a05600c198800b00418bbb695b3mr8286466wmq.0.1713810052535;
        Mon, 22 Apr 2024 11:20:52 -0700 (PDT)
Received: from google.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id e15-20020a05600c218f00b004146e58cc35sm20744546wme.46.2024.04.22.11.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 11:20:52 -0700 (PDT)
Date: Mon, 22 Apr 2024 19:20:48 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: David Hildenbrand <david@redhat.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
	kernel-team@android.com, rdunlap@infradead.org, linux-mm@kvack.org
Subject: Re: [PATCH v20 2/5] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <ZiaqgNFLOwimE2Me@google.com>
References: <20240406173649.3210836-1-vdonnefort@google.com>
 <20240406173649.3210836-3-vdonnefort@google.com>
 <9c553dae-5395-4ec9-b41c-a4decc37acf2@redhat.com>
 <06c6b023-6cdc-430d-be0b-086fd6453aeb@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06c6b023-6cdc-430d-be0b-086fd6453aeb@redhat.com>

Hi David,

Thanks for having a look, very much appreciated!

On Mon, Apr 22, 2024 at 11:27:11AM +0200, David Hildenbrand wrote:
> On 19.04.24 20:25, David Hildenbrand wrote:
> > On 06.04.24 19:36, Vincent Donnefort wrote:
> > > In preparation for allowing the user-space to map a ring-buffer, add
> > > a set of mapping functions:
> > > 
> > >     ring_buffer_{map,unmap}()
> > > 
> > > And controls on the ring-buffer:
> > > 
> > >     ring_buffer_map_get_reader()  /* swap reader and head */
> > > 
> > > Mapping the ring-buffer also involves:
> > > 
> > >     A unique ID for each subbuf of the ring-buffer, currently they are
> > >     only identified through their in-kernel VA.
> > > 
> > >     A meta-page, where are stored ring-buffer statistics and a
> > >     description for the current reader
> > > 
> > > The linear mapping exposes the meta-page, and each subbuf of the
> > > ring-buffer, ordered following their unique ID, assigned during the
> > > first mapping.
> > > 
> > > Once mapped, no subbuf can get in or out of the ring-buffer: the buffer
> > > size will remain unmodified and the splice enabling functions will in
> > > reality simply memcpy the data instead of swapping subbufs.
> > > 
> > > CC: <linux-mm@kvack.org>
> > > Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> > > 
> > > diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
> > > index dc5ae4e96aee..96d2140b471e 100644
> > > --- a/include/linux/ring_buffer.h
> > > +++ b/include/linux/ring_buffer.h
> > > @@ -6,6 +6,8 @@
> > >    #include <linux/seq_file.h>
> > >    #include <linux/poll.h>
> > > +#include <uapi/linux/trace_mmap.h>
> > > +
> > >    struct trace_buffer;
> > >    struct ring_buffer_iter;
> > > @@ -223,4 +225,8 @@ int trace_rb_cpu_prepare(unsigned int cpu, struct hlist_node *node);
> > >    #define trace_rb_cpu_prepare	NULL
> > >    #endif
> > > +int ring_buffer_map(struct trace_buffer *buffer, int cpu,
> > > +		    struct vm_area_struct *vma);
> > > +int ring_buffer_unmap(struct trace_buffer *buffer, int cpu);
> > > +int ring_buffer_map_get_reader(struct trace_buffer *buffer, int cpu);
> > >    #endif /* _LINUX_RING_BUFFER_H */
> > > diff --git a/include/uapi/linux/trace_mmap.h b/include/uapi/linux/trace_mmap.h
> > > new file mode 100644
> > > index 000000000000..ffcd8dfcaa4f
> > > --- /dev/null
> > > +++ b/include/uapi/linux/trace_mmap.h
> > > @@ -0,0 +1,46 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > > +#ifndef _TRACE_MMAP_H_
> > > +#define _TRACE_MMAP_H_
> > > +
> > > +#include <linux/types.h>
> > > +
> > > +/**
> > > + * struct trace_buffer_meta - Ring-buffer Meta-page description
> > > + * @meta_page_size:	Size of this meta-page.
> > > + * @meta_struct_len:	Size of this structure.
> > > + * @subbuf_size:	Size of each sub-buffer.
> > > + * @nr_subbufs:		Number of subbfs in the ring-buffer, including the reader.
> > > + * @reader.lost_events:	Number of events lost at the time of the reader swap.
> > > + * @reader.id:		subbuf ID of the current reader. ID range [0 : @nr_subbufs - 1]
> > > + * @reader.read:	Number of bytes read on the reader subbuf.
> > > + * @flags:		Placeholder for now, 0 until new features are supported.
> > > + * @entries:		Number of entries in the ring-buffer.
> > > + * @overrun:		Number of entries lost in the ring-buffer.
> > > + * @read:		Number of entries that have been read.
> > > + * @Reserved1:		Reserved for future use.
> > > + * @Reserved2:		Reserved for future use.
> > > + */
> > > +struct trace_buffer_meta {
> > > +	__u32		meta_page_size;
> > > +	__u32		meta_struct_len;
> > > +
> > > +	__u32		subbuf_size;
> > > +	__u32		nr_subbufs;
> > > +
> > > +	struct {
> > > +		__u64	lost_events;
> > > +		__u32	id;
> > > +		__u32	read;
> > > +	} reader;
> > > +
> > > +	__u64	flags;
> > > +
> > > +	__u64	entries;
> > > +	__u64	overrun;
> > > +	__u64	read;
> > > +
> > > +	__u64	Reserved1;
> > > +	__u64	Reserved2;
> > > +};
> > > +
> > > +#endif /* _TRACE_MMAP_H_ */
> > > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > > index cc9ebe593571..793ecc454039 100644
> > > --- a/kernel/trace/ring_buffer.c
> > > +++ b/kernel/trace/ring_buffer.c
> > > @@ -9,6 +9,7 @@
> > >    #include <linux/ring_buffer.h>
> > >    #include <linux/trace_clock.h>
> > >    #include <linux/sched/clock.h>
> > > +#include <linux/cacheflush.h>
> > >    #include <linux/trace_seq.h>
> > >    #include <linux/spinlock.h>
> > >    #include <linux/irq_work.h>
> > > @@ -26,6 +27,7 @@
> > >    #include <linux/list.h>
> > >    #include <linux/cpu.h>
> > >    #include <linux/oom.h>
> > > +#include <linux/mm.h>
> > >    #include <asm/local64.h>
> > >    #include <asm/local.h>
> > > @@ -338,6 +340,7 @@ struct buffer_page {
> > >    	local_t		 entries;	/* entries on this page */
> > >    	unsigned long	 real_end;	/* real end of data */
> > >    	unsigned	 order;		/* order of the page */
> > > +	u32		 id;		/* ID for external mapping */
> > >    	struct buffer_data_page *page;	/* Actual data page */
> > >    };
> > > @@ -484,6 +487,12 @@ struct ring_buffer_per_cpu {
> > >    	u64				read_stamp;
> > >    	/* pages removed since last reset */
> > >    	unsigned long			pages_removed;
> > > +
> > > +	unsigned int			mapped;
> > > +	struct mutex			mapping_lock;
> > > +	unsigned long			*subbuf_ids;	/* ID to subbuf VA */
> > > +	struct trace_buffer_meta	*meta_page;
> > > +
> > >    	/* ring buffer pages to update, > 0 to add, < 0 to remove */
> > >    	long				nr_pages_to_update;
> > >    	struct list_head		new_pages; /* new pages to add */
> > > @@ -1599,6 +1608,7 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
> > >    	init_irq_work(&cpu_buffer->irq_work.work, rb_wake_up_waiters);
> > >    	init_waitqueue_head(&cpu_buffer->irq_work.waiters);
> > >    	init_waitqueue_head(&cpu_buffer->irq_work.full_waiters);
> > > +	mutex_init(&cpu_buffer->mapping_lock);
> > >    	bpage = kzalloc_node(ALIGN(sizeof(*bpage), cache_line_size()),
> > >    			    GFP_KERNEL, cpu_to_node(cpu));
> > > @@ -1789,8 +1799,6 @@ bool ring_buffer_time_stamp_abs(struct trace_buffer *buffer)
> > >    	return buffer->time_stamp_abs;
> > >    }
> > > -static void rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer);
> > > -
> > >    static inline unsigned long rb_page_entries(struct buffer_page *bpage)
> > >    {
> > >    	return local_read(&bpage->entries) & RB_WRITE_MASK;
> > > @@ -5211,6 +5219,22 @@ static void rb_clear_buffer_page(struct buffer_page *page)
> > >    	page->read = 0;
> > >    }
> > > +static void rb_update_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
> > > +{
> > > +	struct trace_buffer_meta *meta = cpu_buffer->meta_page;
> > > +
> > > +	meta->reader.read = cpu_buffer->reader_page->read;
> > > +	meta->reader.id = cpu_buffer->reader_page->id;
> > > +	meta->reader.lost_events = cpu_buffer->lost_events;
> > > +
> > > +	meta->entries = local_read(&cpu_buffer->entries);
> > > +	meta->overrun = local_read(&cpu_buffer->overrun);
> > > +	meta->read = cpu_buffer->read;
> > > +
> > > +	/* Some archs do not have data cache coherency between kernel and user-space */
> > > +	flush_dcache_folio(virt_to_folio(cpu_buffer->meta_page));
> > > +}
> > > +
> > >    static void
> > >    rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
> > >    {
> > > @@ -5255,6 +5279,9 @@ rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
> > >    	cpu_buffer->lost_events = 0;
> > >    	cpu_buffer->last_overrun = 0;
> > > +	if (cpu_buffer->mapped)
> > > +		rb_update_meta_page(cpu_buffer);
> > > +
> > >    	rb_head_page_activate(cpu_buffer);
> > >    	cpu_buffer->pages_removed = 0;
> > >    }
> > > @@ -5469,6 +5496,12 @@ int ring_buffer_swap_cpu(struct trace_buffer *buffer_a,
> > >    	cpu_buffer_a = buffer_a->buffers[cpu];
> > >    	cpu_buffer_b = buffer_b->buffers[cpu];
> > > +	/* It's up to the callers to not try to swap mapped buffers */
> > > +	if (WARN_ON_ONCE(cpu_buffer_a->mapped || cpu_buffer_b->mapped)) {
> > > +		ret = -EBUSY;
> > > +		goto out;
> > > +	}
> > > +
> > >    	/* At least make sure the two buffers are somewhat the same */
> > >    	if (cpu_buffer_a->nr_pages != cpu_buffer_b->nr_pages)
> > >    		goto out;
> > > @@ -5733,7 +5766,8 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
> > >    	 * Otherwise, we can simply swap the page with the one passed in.
> > >    	 */
> > >    	if (read || (len < (commit - read)) ||
> > > -	    cpu_buffer->reader_page == cpu_buffer->commit_page) {
> > > +	    cpu_buffer->reader_page == cpu_buffer->commit_page ||
> > > +	    cpu_buffer->mapped) {
> > >    		struct buffer_data_page *rpage = cpu_buffer->reader_page->page;
> > >    		unsigned int rpos = read;
> > >    		unsigned int pos = 0;
> > > @@ -5956,6 +5990,11 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
> > >    		cpu_buffer = buffer->buffers[cpu];
> > > +		if (cpu_buffer->mapped) {
> > > +			err = -EBUSY;
> > > +			goto error;
> > > +		}
> > > +
> > >    		/* Update the number of pages to match the new size */
> > >    		nr_pages = old_size * buffer->buffers[cpu]->nr_pages;
> > >    		nr_pages = DIV_ROUND_UP(nr_pages, buffer->subbuf_size);
> > > @@ -6057,6 +6096,358 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
> > >    }
> > >    EXPORT_SYMBOL_GPL(ring_buffer_subbuf_order_set);
> > > +static int rb_alloc_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
> > > +{
> > > +	struct page *page;
> > > +
> > > +	if (cpu_buffer->meta_page)
> > > +		return 0;
> > > +
> > > +	page = alloc_page(GFP_USER | __GFP_ZERO);
> > > +	if (!page)
> > > +		return -ENOMEM;
> > > +
> > > +	cpu_buffer->meta_page = page_to_virt(page);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static void rb_free_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
> > > +{
> > > +	unsigned long addr = (unsigned long)cpu_buffer->meta_page;
> > > +
> > > +	free_page(addr);
> > > +	cpu_buffer->meta_page = NULL;
> > > +}
> > > +
> > > +static void rb_setup_ids_meta_page(struct ring_buffer_per_cpu *cpu_buffer,
> > > +				   unsigned long *subbuf_ids)
> > > +{
> > > +	struct trace_buffer_meta *meta = cpu_buffer->meta_page;
> > > +	unsigned int nr_subbufs = cpu_buffer->nr_pages + 1;
> > > +	struct buffer_page *first_subbuf, *subbuf;
> > > +	int id = 0;
> > > +
> > > +	subbuf_ids[id] = (unsigned long)cpu_buffer->reader_page->page;
> > > +	cpu_buffer->reader_page->id = id++;
> > > +
> > > +	first_subbuf = subbuf = rb_set_head_page(cpu_buffer);
> > > +	do {
> > > +		if (WARN_ON(id >= nr_subbufs))
> > > +			break;
> > > +
> > > +		subbuf_ids[id] = (unsigned long)subbuf->page;
> > > +		subbuf->id = id;
> > > +
> > > +		rb_inc_page(&subbuf);
> > > +		id++;
> > > +	} while (subbuf != first_subbuf);
> > > +
> > > +	/* install subbuf ID to kern VA translation */
> > > +	cpu_buffer->subbuf_ids = subbuf_ids;
> > > +
> > > +	/* __rb_map_vma() pads the meta-page to align it with the sub-buffers */
> > > +	meta->meta_page_size = PAGE_SIZE << cpu_buffer->buffer->subbuf_order;
> > > +	meta->meta_struct_len = sizeof(*meta);
> > > +	meta->nr_subbufs = nr_subbufs;
> > > +	meta->subbuf_size = cpu_buffer->buffer->subbuf_size + BUF_PAGE_HDR_SIZE;
> > > +
> > > +	rb_update_meta_page(cpu_buffer);
> > > +}
> > > +
> > > +static struct ring_buffer_per_cpu *
> > > +rb_get_mapped_buffer(struct trace_buffer *buffer, int cpu)
> > > +{
> > > +	struct ring_buffer_per_cpu *cpu_buffer;
> > > +
> > > +	if (!cpumask_test_cpu(cpu, buffer->cpumask))
> > > +		return ERR_PTR(-EINVAL);
> > > +
> > > +	cpu_buffer = buffer->buffers[cpu];
> > > +
> > > +	mutex_lock(&cpu_buffer->mapping_lock);
> > > +
> > > +	if (!cpu_buffer->mapped) {
> > > +		mutex_unlock(&cpu_buffer->mapping_lock);
> > > +		return ERR_PTR(-ENODEV);
> > > +	}
> > > +
> > > +	return cpu_buffer;
> > > +}
> > > +
> > > +static void rb_put_mapped_buffer(struct ring_buffer_per_cpu *cpu_buffer)
> > > +{
> > > +	mutex_unlock(&cpu_buffer->mapping_lock);
> > > +}
> > > +
> > > +/*
> > > + * Fast-path for rb_buffer_(un)map(). Called whenever the meta-page doesn't need
> > > + * to be set-up or torn-down.
> > > + */
> > > +static int __rb_inc_dec_mapped(struct ring_buffer_per_cpu *cpu_buffer,
> > > +			       bool inc)
> > > +{
> > > +	unsigned long flags;
> > > +
> > > +	lockdep_assert_held(&cpu_buffer->mapping_lock);
> > > +
> > > +	if (inc && cpu_buffer->mapped == UINT_MAX)
> > > +		return -EBUSY;
> > > +
> > > +	if (WARN_ON(!inc && cpu_buffer->mapped == 0))
> > > +		return -EINVAL;
> > > +
> > > +	mutex_lock(&cpu_buffer->buffer->mutex);
> > > +	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
> > > +
> > > +	if (inc)
> > > +		cpu_buffer->mapped++;
> > > +	else
> > > +		cpu_buffer->mapped--;
> > > +
> > > +	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
> > > +	mutex_unlock(&cpu_buffer->buffer->mutex);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +#define subbuf_page(off, start) \
> > > +	virt_to_page((void *)((start) + ((off) << PAGE_SHIFT)))
> > > +
> > > +#define foreach_subbuf_page(sub_order, start, page)		\
> > > +	page = subbuf_page(0, (start));				\
> > > +	for (int __off = 0; __off < (1 << (sub_order));		\
> > > +	     __off++, page = subbuf_page(__off, (start)))
> > > +
> > > +/*
> > > + *   +--------------+  pgoff == 0
> > > + *   |   meta page  |
> > > + *   +--------------+  pgoff == 1
> > > + *   |   000000000  |
> > > + *   +--------------+  pgoff == (1 << subbuf_order)
> > > + *   | subbuffer 0  |
> > > + *   |              |
> > > + *   +--------------+  pgoff == (2 * (1 << subbuf_order))
> > > + *   | subbuffer 1  |
> > > + *   |              |
> > > + *         ...
> > > + */
> > > +static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
> > > +			struct vm_area_struct *vma)
> > > +{
> > > +	unsigned long nr_subbufs, nr_pages, vma_pages, pgoff = vma->vm_pgoff;
> > > +	unsigned int subbuf_pages, subbuf_order;
> > > +	struct page **pages;
> > > +	int p = 0, s = 0;
> > > +	int err;
> > > +
> > > +	lockdep_assert_held(&cpu_buffer->mapping_lock);
> > > +
> > > +	subbuf_order = cpu_buffer->buffer->subbuf_order;
> > > +	subbuf_pages = 1 << subbuf_order;
> > > +
> > > +	if (subbuf_order && pgoff % subbuf_pages)
> > > +		return -EINVAL;
> > > +
> > > +	nr_subbufs = cpu_buffer->nr_pages + 1;
> > > +	nr_pages = ((nr_subbufs + 1) << subbuf_order) - pgoff;
> > > +
> > > +	vma_pages = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
> > > +	if (!vma_pages || vma_pages > nr_pages)
> > > +		return -EINVAL;
> > > +
> > > +	nr_pages = vma_pages;
> > > +
> > > +	pages = kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
> > > +	if (!pages)
> > > +		return -ENOMEM;
> > > +
> > > +	if (!pgoff) {
> > > +		unsigned long meta_page_padding;
> > > +
> > > +		pages[p++] = virt_to_page(cpu_buffer->meta_page);
> > > +
> > > +		/*
> > > +		 * Pad with the zero-page to align the meta-page with the
> > > +		 * sub-buffers.
> > > +		 */
> > > +		meta_page_padding = subbuf_pages - 1;
> > > +		while (meta_page_padding-- && p < nr_pages)
> > > +			pages[p++] = ZERO_PAGE(0);
> > 
> > Using the shared zeropage in a MAP_SHARED mapping that is neither VM_IO
> > nor VM_PFNMAP can be problematic. So we really need patch #3 logic to
> > use VM_PFNMAP.
> > 
> > It would be cleaner/more obvious if these VMA flag setting would reside

tracing_buffers_mmap() sets both VM_IO and VM_PFNMAP. But, yeah as vma is
already passed to ring_buffer_map(). The flags could be set here as this
function is what sets the requirements really.

> > here, if possible.
> > 
> > > +	} else {
> > > +		/* Skip the meta-page */
> > > +		pgoff -= subbuf_pages;
> > > +
> > > +		s += pgoff / subbuf_pages;
> > > +	}
> > > +
> > > +	while (s < nr_subbufs && p < nr_pages) {
> > > +		struct page *page;
> > > +
> > > +		foreach_subbuf_page(subbuf_order, cpu_buffer->subbuf_ids[s], page) {
> > > +			if (p >= nr_pages)
> > > +				break;
> > > +
> > > +			pages[p++] = page;
> > > +		}
> > > +		s++;
> > > +	}
> > > +
> > > +	err = vm_insert_pages(vma, vma->vm_start, pages, &nr_pages);
> > 
> > I think Linus suggested it ("avoid all the sub-page ref-counts entirely
> > by using VM_PFNMAP, and use vm_insert_pages()"), but ...
> > vm_insert_pages() will:
> > * Mess with mapcounts
> > * Mess with refcounts
> > 
> > See
> > insert_pages()->insert_page_in_batch_locked()->insert_page_into_pte_locked().
> > 
> > So we'll mess with the mapcount and refcount of the shared zeropage ...
> > hmmmm
> > 
> > If I am not wrong, vm_normal_page() would not return the shared zeropage
> > in case we don't have CONFIG_ARCH_HAS_PTE_SPECIAL ... so
> > unmap()->...->zap_present_ptes() would not decrement the refcount and we
> > could overflow it. ... we also shouldn't ever mess with the mapcount of
> > the shared zeropage in the first place.
> > 
> > vm_insert_page() is clearer on that: "This allows drivers to insert
> > individual pages they've allocated into a user vma". You didn't allocate
> > the shared zeropage.
> > 
> > I'm wondering if we even expect VM_MIXEDMAP and VM_PFNMAP to be set at
> > the same time? vm_insert_pages() would BUG_ON in case VM_PFNMAP is
> > already set and it would set VM_MIXEDMAP ... similarly
> > vmf_insert_pfn_prot() would not be happy about that at all ...
> > 
> > BUG_ON((vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)) ==
> > (VM_PFNMAP|VM_MIXEDMAP));
> > 
> > ... remap_pfn_range() is used by io_uring_mmap for a similar purpose.
> > But it only supports a single PFN range at a time and requires the
> > caller to handle refcounting of pages.
> > 
> > It's getting late in Germany, so I might be missing something; but using
> > the shared zeropage here might be a problem.
> > 
> 
> I was just about to write code to cleanly support vm_insert_pages() to
> consume zeropages ... when I started to wonder about something else:

Alternatively, we could at the moment allocate a meta-page of the same size than
the subbufs? (of course the downside is to waste a bit of memory)

> 
> 
> +	if (vma->vm_flags & VM_WRITE || vma->vm_flags & VM_EXEC ||
> +	    !(vma->vm_flags & VM_MAYSHARE))
> +		return -EPERM;
> +
> 
> You disallow writable mappings. But what about using mprotect() afterwards
> to allow for write permissions?
> 
> Likely you'd want to remove VM_MAYWRITE from the flags, otherwise mprotect()
> might alter succeed.

The vm_flags_mod below is clearing VM_MAYWRITE already. Isn't it enough? 

> 
> -- 
> Cheers,
> 
> David / dhildenb
> 

