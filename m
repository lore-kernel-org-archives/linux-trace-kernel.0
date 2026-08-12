Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A89420479
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 16:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786552919; cv=none; b=HL4b2UFuaNtgpPg6sOzgaGWaruXWEox0X3PMMMuvROLqtXu+ucN+/9aHfVQuhiLleMJJRRETMzLNB6JV8MRGjl9Nw4Za4YpCDrNYsB2qpmSpY3SETtOZ0Yat9ZG7vVxOtEoD2hT2VN6kv7xnSgnSI2K+Ryk6+7ahNDP1Hutel+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786552919; c=relaxed/simple;
	bh=PjVol4Tb65djtG82OoMJft4ncg82OzrKc1EnjHQJyOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GwB7ZioQyeJP4WO9Wpz91xjAdFzT6SYx3kxHDCPrEL2OjS2J6fpXs1o2v+0cDGQyyrfWZ/pHm9uQXdCWyS3nmJZjUlSMR89rACRY4Pv4pBtZSPI+85VlqD7yQgQyCZ2uMpKP0tbZpNF3yWAyp/NXMwVcpIWT0GWwsi1Ms0tgU/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=msDuUrO1; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="msDuUrO1"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47f84023916so1012664f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 09:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786552916; x=1787157716; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wVgq/pUAW2YVRGzzvc+9i8P+jYOJxwDdDeiAi7vwOC8=;
        b=msDuUrO1HJTos0s9U7T9IZQh1P2WjNLa0IdEbVOFHovwoRUTJE+BEB2+y1OXxTXsY2
         Emq+fWMNtSXc6ix2xMgYWt8hkBf+cLXWSK+FmyVe81/tnzHYKDKVUxeuZ+OGO327r37y
         XVUmKRswTLHJF86uABr322oEsxkyijKimZRORSbhcoP3e4DXToeYkSmqW88BwdK+QKxx
         AUCJBdfwEcZxPAPXQjPdG1eDDXv1JXWyEHS20LEYvcHkripJk7JvvHFoklpYbeay97J3
         9kwf5VCkuKWFHm05rRNxEi5+DVmhVp6mD8MAu9WfqKO6Dh6yXY7GRjrAGm1zKPXH8kae
         Ol1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786552916; x=1787157716;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wVgq/pUAW2YVRGzzvc+9i8P+jYOJxwDdDeiAi7vwOC8=;
        b=WbF628RSduCib8U5CO53yZmOvgK+DVQ0SvTjq8QtjsgpkjorSuUjJzvBx0Fa0UPEUa
         +xKNXWaFlAzvusJ490n/g//B9j+/hmtbTnnOpB2pZyd7GDhjTvgiEbjjwemuSwXjnoov
         tq2Na+SW9kGhmbqn6yrACLf+oJAuc4FIUd3VWjiW1FRCAouse7V3ZWEwTiXk5L+qcA97
         SMkYqNB9t6CeGS8yo1r7WYv2Wexi0Gjkj13QHGF6RZKO9PLVpJYzaH5YtDlVyZHFjqmQ
         IRZap0UhUI1eGuZFwvTu+OsYYgz3la2935pMMUYIuBUv0K8SKdaEtg68TRO6TCQ6O9si
         Zv2w==
X-Gm-Message-State: AOJu0YzGHshui5iA/S1uhFHocupymw2PO5QzyjHlzrAfBr8864y5+lyY
	HASk4MkelGfnOqpjRrheeJzv9tWv5WNVaEpNj+CDj1hMONmJ41xGk5keYdHovT2UXw==
X-Gm-Gg: AR+sD10gBlwdhox/t9TfX7pPrR4jNS3X5Psp7g8wCRoeExwqJHVCDN1hkxWSsykCya0
	ee2HtCukD2HAtRUgALQtYPGzTHp7m9M/oMdpXUbCZ0BouVtTDPQKeknU/RzHTtqgiGvRdnMG+bJ
	ea4YUXT/Uiv9vbAd3ZrA4vk9VjLWdPKT9+lMpJ3WYxifL8D3fr60spK2DvlGDD99LH+972ylSNI
	uyW6G41pcjyCMVyj2gWox1N9Ab0F32mduWQ2NG7whZDOf2kTMVwX3dpAxh55Jc3svop0OflCC5A
	zCK6oayYjVbpUvz3EWEer2Yo30DsfwxKRZszMq0zlK4ckrQOoDlD4IcUxfqav54Pazqm1ep8y5V
	9uyyw4jN0GDbUe57WWaXAy4tG8MFSBKqgv6GdrpcrqqCGxyR5KviBvAeSOBT2Bh51NTivFJOKSt
	UyWI8vSt1yBNmGGkOJPKBSR9qoGYVThtswUrB3QoWNZ5M+QILiQv+IphqJ/09GqZgjPPF6YA2aD
	8pyfoQWu8CWY8hdFv24AzEDGSR0XX7g
X-Received: by 2002:a05:6000:250e:b0:480:2fd:96a6 with SMTP id ffacd0b85a97d-481528b9df6mr9204800f8f.7.1786552915607;
        Wed, 12 Aug 2026 09:41:55 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48150d4e675sm9197192f8f.23.2026.08.12.09.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 09:41:55 -0700 (PDT)
Date: Wed, 12 Aug 2026 17:41:51 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/9] ring-buffer: Hold cpu_buffer::lock when resizing
 a subbuf
Message-ID: <anyiT3KzVIm-4ZeD@google.com>
References: <20260812153311.2328812-1-vdonnefort@google.com>
 <20260812153311.2328812-3-vdonnefort@google.com>
 <20260812154659.3E3081F00A3F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260812154659.3E3081F00A3F@smtp.kernel.org>

On Wed, Aug 12, 2026 at 03:46:58PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [Critical] The patch attempts to fix a race with `cpu_buffer->free_page` by adding an `arch_spin_lock(&cpu_buffer->lock)`, but it leaves a severe Time-Of-Check to Time-Of-Use (TOCTOU) race unaddressed. `buffer->subbuf_order` and `buffer->subbuf_size` are updated globally outside of any per-CPU lock. If a reader (like `tracing_buffers_splice_read`) calls `ring_buffer_alloc_read_page()` concurrently, it locklessly reads the NEW `buffer->subbuf_order` but then retrieves the OLD, incorrectly-sized `free_page` from the locked cache. When `ring_buffer_read_page()` uses this page, it copies data up to the NEW `buffer->subbuf_size`, leading to a heap buffer overflow if the new order is larger. Similarly, `ring_buffer_free_read_page()` validates `data_page->order` locklessly; if the global order changes just after the check, it inserts a new-order page into `free_page`, which `ring_buffer_subbuf_order_set()` will later free using the `old_order`, corrupting the page allocator.
> - [High] The patch adds an unconditional `arch_spin_lock(&cpu_buffer->lock)` to `ring_buffer_subbuf_order_set()`. This creates an NMI deadlock window. If an NMI (e.g., from a watchdog or an Oops triggering `ftrace_dump_on_oops`) fires on the same CPU while this lock is held, the NMI handler may attempt to read the ring buffer. The read path (via `ring_buffer_peek()` -> `rb_buffer_peek()` -> `__rb_get_reader_page()`) unconditionally acquires the same `cpu_buffer->lock` using `arch_spin_lock()` without an NMI-safe trylock fallback. Because the interrupted context holds the lock, the NMI handler will spin forever, causing a hard lockup.
> --
> 
> --- Patch [2]: [PATCH v4 2/9] ring-buffer: Hold cpu_buffer::lock when resizing a subbuf ---
> commit 1db68f92346fd21f55d54529fb97b920f02a0136
> Author: Vincent Donnefort <vdonnefort@google.com>
> 
> ring-buffer: Hold cpu_buffer::lock when resizing a subbuf
> 
> This commit adds an arch_spin_lock() around the clearing of
> cpu_buffer->free_page in ring_buffer_subbuf_order_set(). This aims to
> prevent races with ring_buffer_alloc_read_page() and
> ring_buffer_free_read_page() during sub-buffer resizing.
> 
> > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > index a3d28b2e2c94a..ec4f5a0c93e85 100644
> > --- a/kernel/trace/ring_buffer.c
> > +++ b/kernel/trace/ring_buffer.c
> > @@ -7431,8 +7431,10 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
> >  		cpu_buffer->nr_pages = cpu_buffer->nr_pages_to_update;
> >  		cpu_buffer->nr_pages_to_update = 0;
> >  
> > +		arch_spin_lock(&cpu_buffer->lock);
> 
> [Severity: Critical]
> This is a pre-existing issue, but is there a Time-Of-Check to Time-Of-Use
> (TOCTOU) race between the global order updates and this per-CPU lock?
> 
> Earlier in ring_buffer_subbuf_order_set(), buffer->subbuf_order and
> buffer->subbuf_size are updated globally outside of any per-CPU lock.
> 
> If a reader like tracing_buffers_splice_read() calls
> ring_buffer_alloc_read_page() concurrently, can it locklessly read the new
> buffer->subbuf_order, but then retrieve the old, incorrectly-sized
> free_page from the locked cache?
> 
> When ring_buffer_read_page() uses this page, wouldn't it copy data up to
> the new buffer->subbuf_size, leading to a heap buffer overflow if the new
> order is larger?
> 
> Similarly, ring_buffer_free_read_page() validates data_page->order against
> buffer->subbuf_order locklessly. If the global order changes right after
> the check, could it insert a new-order page into free_page, which
> ring_buffer_subbuf_order_set() will later free using the old order,
> corrupting the page allocator?

This is hopefully fixed in one of the following patch of this series.

> 
> [Severity: High]
> This is also a pre-existing issue, but does adding this unconditional
> arch_spin_lock() widen an NMI deadlock window?
> 
> If an NMI (such as a watchdog or an Oops triggering ftrace_dump_on_oops)
> fires on the same CPU while this lock is held, the NMI handler may attempt
> to read the ring buffer.
> 
> The read path via __rb_get_reader_page() unconditionally acquires the same
> cpu_buffer->lock using arch_spin_lock() without an NMI-safe trylock
> fallback.

This is under raw_spin_lock_irqsave(). I believe the panic path will first try
to issue normal IPIs.

-- 
Vincent

> 
> Because the interrupted context holds the lock, will the NMI handler spin
> forever, causing a hard lockup?
> 
> >  		old_free_data_page = cpu_buffer->free_page;
> >  		cpu_buffer->free_page = NULL;
> > +		arch_spin_unlock(&cpu_buffer->lock);
> >  
> >  		rb_head_page_activate(cpu_buffer);
> >
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260812153311.2328812-1-vdonnefort@google.com?part=2
