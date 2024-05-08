Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A6933F6;
	Wed,  8 May 2024 02:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715135645; cv=none; b=GYsyQWc2XASXFHvsgt2cH7fZeZz/lcXn/0D3Yy8ZFH9RYsft9UZv1Dmb8vnhj0opqupgRLWkKsz5DncRW/VBKmKYqqGX77s8nS6FQuOpfBkAvC2Cc1Mrmg1BAdAnUbK4Jwd6xc2rfMj5U+IKR5GZ7bmGE8we29785Xb2GX+LsBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715135645; c=relaxed/simple;
	bh=XqLmS+NnYzieGgIHHNfIjpnIZWhpWQO/SKwBKozBE3M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hHd7yReiz9OlnBCkY/OKERF1dg3Ju4+lGSg6DG5OkNkd4jZruQr6p2omHd7EdeD/xWXkrdplzcnDHfu9AlsVRkbGM1gTsf9UY0FScV7Y+BNDTJvlc9C3DsMZ63gfBFchEllv7ks2XdxgNGKBinZtd6zqOdM3VUVBgXdLHbE56Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5434DC2BBFC;
	Wed,  8 May 2024 02:34:04 +0000 (UTC)
Date: Tue, 7 May 2024 22:34:02 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 kernel-team@android.com, rdunlap@infradead.org, rppt@kernel.org,
 david@redhat.com, linux-mm@kvack.org
Subject: Re: [PATCH v22 2/5] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <20240507223402.206d6ddc@rorschach.local.home>
In-Reply-To: <20240430111354.637356-3-vdonnefort@google.com>
References: <20240430111354.637356-1-vdonnefort@google.com>
	<20240430111354.637356-3-vdonnefort@google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Apr 2024 12:13:51 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> +#ifdef CONFIG_MMU
> +static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
> +			struct vm_area_struct *vma)
> +{
> +	unsigned long nr_subbufs, nr_pages, vma_pages, pgoff = vma->vm_pgoff;
> +	unsigned int subbuf_pages, subbuf_order;
> +	struct page **pages;
> +	int p = 0, s = 0;
> +	int err;
> +
> +	/* Refuse MP_PRIVATE or writable mappings */
> +	if (vma->vm_flags & VM_WRITE || vma->vm_flags & VM_EXEC ||
> +	    !(vma->vm_flags & VM_MAYSHARE))
> +		return -EPERM;
> +
> +	/*
> +	 * Make sure the mapping cannot become writable later. Also tell the VM
> +	 * to not touch these pages (VM_DONTCOPY | VM_DONTEXPAND). Finally,
> +	 * prevent migration, GUP and dump (VM_IO).
> +	 */
> +	vm_flags_mod(vma, VM_DONTCOPY | VM_DONTEXPAND | VM_IO, VM_MAYWRITE);

Do we really need the VM_IO?

When testing this in gdb, I would get:

(gdb) p tmap->map->subbuf_size
Cannot access memory at address 0x7ffff7fc2008

It appears that you can't ptrace IO memory. When I removed that flag,
gdb has no problem reading that memory.

I think we should drop that flag.

Can you send a v23 with that removed, Shuah's update, and also the
change below:

> +
> +	lockdep_assert_held(&cpu_buffer->mapping_lock);
> +
> +	subbuf_order = cpu_buffer->buffer->subbuf_order;
> +	subbuf_pages = 1 << subbuf_order;
> +
> +	nr_subbufs = cpu_buffer->nr_pages + 1; /* + reader-subbuf */
> +	nr_pages = ((nr_subbufs) << subbuf_order) - pgoff + 1; /* + meta-page */
> +
> +	vma_pages = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
> +	if (!vma_pages || vma_pages > nr_pages)
> +		return -EINVAL;
> +
> +	nr_pages = vma_pages;
> +
> +	pages = kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
> +	if (!pages)
> +		return -ENOMEM;
> +
> +	if (!pgoff) {
> +		pages[p++] = virt_to_page(cpu_buffer->meta_page);
> +
> +		/*
> +		 * TODO: Align sub-buffers on their size, once
> +		 * vm_insert_pages() supports the zero-page.
> +		 */
> +	} else {
> +		/* Skip the meta-page */
> +		pgoff--;
> +
> +		if (pgoff % subbuf_pages) {
> +			err = -EINVAL;
> +			goto out;
> +		}
> +
> +		s += pgoff / subbuf_pages;
> +	}
> +
> +	while (s < nr_subbufs && p < nr_pages) {
> +		struct page *page = virt_to_page(cpu_buffer->subbuf_ids[s]);
> +		int off = 0;
> +
> +		for (; off < (1 << (subbuf_order)); off++, page++) {
> +			if (p >= nr_pages)
> +				break;
> +
> +			pages[p++] = page;
> +		}
> +		s++;
> +	}

The above can be made to:

	while (p < nr_pages) {
		struct page *page;
		int off = 0;

		if (WARN_ON_ONCE(s >= nr_subbufs))
			break;

		page = virt_to_page(cpu_buffer->subbuf_ids[s]);
		for (; off < (1 << (subbuf_order)); off++, page++) {
			if (p >= nr_pages)
				break;

			pages[p++] = page;
		}
		s++;
	}

Thanks.

-- Steve

> +
> +	err = vm_insert_pages(vma, vma->vm_start, pages, &nr_pages);
> +
> +out:
> +	kfree(pages);
> +
> +	return err;
> +}
> +#else
> +static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
> +			struct vm_area_struct *vma)
> +{
> +	return -EOPNOTSUPP;
> +}
> +#endif
