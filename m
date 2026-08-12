Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EE046AA7F
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 16:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786553091; cv=none; b=tb/cx1HyRmicAQptHd4/GKC1kNyrzKjzbF6QyjHrjK3wCiUkr95PMew1H7iXcO7TOGpn6PH8e60p1QUD2iLajB/kHwL//XVrcPfM3BbT3hqB0I4j6iAIH8ufGvlFZ4rvZZRkrR7vKm3b+umZiGsNdlNvl8FXvbPP2Xy8dXh0uwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786553091; c=relaxed/simple;
	bh=Uc6d1JmE8vFz0jcinRPk+LTNIi3qbY4xnAX+AuHLtUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qMuk75qr3Pz3CnCrg+7J/gHFMM/DFavEiw4oB8riyvvmszCquhDmZy2q4s8aD5isoIbRy7l1LRZMV7BP4zYE45b2W7lzzJ6C9Gsa76mN0O/etajkxyEGHXzLh6om5u5sgKDdLmIX1Y/UjCAD+m9ri81P+fo9mHVlrjNaF6itCf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e4yEXp40; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e4yEXp40"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4956242332dso11004485e9.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 09:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786553086; x=1787157886; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oHbwVhKHiepnO85KbGfGGDjglAmQPanCzzbHx9mANVw=;
        b=e4yEXp40/WxQ1/xIY4rPqKCH1vI8RUpEi9GH9c/X+QhOeDYP2mTDmDmFpeQIf99cUU
         L/tox80YOoWIXQVy/Q51XhtGb6Lv0ji3pGhtZwX1AHuESZvXxYGpINI+rfdbtCjnKoa2
         wo51I5Kdx0AjvQ1/Q0AXH0T+iT8zGAbVwv6S0WQNy3f3TqOPnNoe66ongrLkpy6y29R6
         Vg6AyeDfVJQR2DkiXlC8CC1Zf6YQRrZNkVisy9fBB78y6UwhoSnCxO2s5TITNgkErYH3
         0yhPHFbffXT3oUxfJ0FaXcmAa32eBvA51LEg+q+afawlpGWHzKc2ur/3R0enLKng95ZB
         85/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786553086; x=1787157886;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=oHbwVhKHiepnO85KbGfGGDjglAmQPanCzzbHx9mANVw=;
        b=YgCGnw7kUsUJAJzLhqg89fuyZfmDH+F7xecQ6cXK8vHTHtIaSG6bJwSQtnlJ2o2jig
         rPbiVlBA+9hactFO9gMQVLxNEPkE8g1TQSQuSe62PaprkWqJTgPylzIGPJuMjZn6I0JI
         qz8xZH9LY33s1WCt6GQLAhH8ubfuYlKl8p+TDIMuUGhT60aw6P+D1QBLtqT7gHkGJuux
         5CJMuezDeQbWLQCaw2ZPN6JeVWTdrmNjiNfuH+Yv5GwabUAkRXW3TOnOpqOAHYNeeC7l
         WDWlgszIFepJhHxm5XhLK/bnawSSVbNt4MJUw6Qej7w6+jTReNO3SmvrN7gZ9xgt93nj
         Awkg==
X-Gm-Message-State: AOJu0Yy3HAPXkykVBgIt3jvsGZ5btIXZs6i9KGMb0LVYLhwUEeWlGf4n
	C4mk3cSAoChc8o2EdIGi3QEx9vkn9Yqulh1ywsAY/mv5n4tHPYgrFKHASFEZb6IdQOB8BJvQm8l
	GPcRMJA==
X-Gm-Gg: AR+sD10eTdWOQwrNa6AzUgkBl3gbKsXtMFP96zhJwzs72VAU9tb+g2WHNIScWtpCrph
	kAXdmFodDxkwyq1gGuGnEd2YtJR88SVsUW0HHokA4PqFDsIO+o9qoASOCBoaI3d1aNW23TDITO2
	qKWHO84TMfh2dhtCID3CtOwUVSOpqOyxARvUqoh22THswSh1KaBggwjBrIX4A3kYDorICbzBdQ2
	TrXoTPRch070EZLMHw44Dy/GsfCwai870rU6YEU5O5AbU1CJLimVjKIHUn+mBszF3ix1yWwJcfC
	SBGxfCk9D/N1Oz4rBgkBq0/sVyrDJxqgTarvp67ylCSCVSC2FMmfLVd0QPRGyt45DfSkTruZeWE
	FSDpkLdhhZPKfGVhmCnV+eIB4YPJjS8wMrgxYTZ+Grwqxdwx+tHqTbfaSvWzZKb1gReBSwM/KtG
	D/fdwpFUOrn4+1dWaLzc+3JJyJ+Z6I9J4oNEI5XZXJaWR9Yw2gPs42pzfShsanuX++MA63+2NhC
	7fBhcu6dHTLrXrMKl33pa18EA8SyGbe
X-Received: by 2002:a05:600c:a213:b0:499:737c:8a8b with SMTP id 5b1f17b1804b1-4997c12c7e8mr61050435e9.12.1786553085965;
        Wed, 12 Aug 2026 09:44:45 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997b238a9asm57102355e9.3.2026.08.12.09.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 09:44:44 -0700 (PDT)
Date: Wed, 12 Aug 2026 17:44:41 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/9] ring-buffer: Fix subbuf resize race with ring
 buffer readers
Message-ID: <anyi-W-fZHqCPRZd@google.com>
References: <20260812153311.2328812-1-vdonnefort@google.com>
 <20260812153311.2328812-4-vdonnefort@google.com>
 <20260812155312.ADF031F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260812155312.ADF031F000E9@smtp.kernel.org>

On Wed, Aug 12, 2026 at 03:53:12PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> New issues:
> - [High] Use-After-Free dereference of `reader_page` in `ring_buffer_read_start()` when bypassing buffer mutex.
> 
> Pre-existing issues:
> - [High] 32-bit integer overflow in ring buffer capacity calculation truncates large trace buffers.
> - [High] Out-of-bounds kernel memory write and VMAP flush in `ring_buffer_map_get_reader()` due to global capacity TOCTOU race.
> --
> 
> --- Patch [3]: [PATCH v4 3/9] ring-buffer: Fix subbuf resize race with ring buffer readers ---
> commit 9618f28d9a6939c645e7579fa798c42557eb075c
> Author: Vincent Donnefort <vdonnefort@google.com>
> 
> ring-buffer: Fix subbuf resize race with ring buffer readers
> 
> This commit changes the trace_buffer to use bpage order instead of
> trace_buffer::subbuf_size in ring_buffer_read_start() and
> ring_buffer_read_page(). It also removes trace_buffer::subbuf_size and
> introduces capacity accessors.
> 
> > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > index ec4f5a0c93e85..97449423d3a68 100644
> > --- a/kernel/trace/ring_buffer.c
> > +++ b/kernel/trace/ring_buffer.c
> [ ... ]
> > @@ -6380,36 +6417,44 @@ EXPORT_SYMBOL_GPL(ring_buffer_consume);
> >  struct ring_buffer_iter *
> >  ring_buffer_read_start(struct trace_buffer *buffer, int cpu, gfp_t flags)
> >  {
> > +	struct ring_buffer_iter *iter __free(kfree) = kzalloc_obj(*iter, flags);
> >  	struct ring_buffer_per_cpu *cpu_buffer;
> > -	struct ring_buffer_iter *iter;
> > -
> > -	if (!cpumask_test_cpu(cpu, buffer->cpumask))
> > -		return NULL;
> >  
> > -	iter = kzalloc_obj(*iter, flags);
> >  	if (!iter)
> >  		return NULL;
> >  
> > -	/* Holds the entire event: data and meta data */
> > -	iter->event_size = buffer->subbuf_size;
> > -	iter->event = kmalloc(iter->event_size, flags);
> > -	if (!iter->event) {
> > -		kfree(iter);
> > +	if (!cpumask_test_cpu(cpu, buffer->cpumask))
> >  		return NULL;
> > -	}
> >  
> >  	cpu_buffer = buffer->buffers[cpu];
> >  
> > -	iter->cpu_buffer = cpu_buffer;
> > +	/*
> > +	 * Only KDB is using GFP_ATOMIC, for the others, lock the buffer to
> > +	 * prevent concurrent resizing.
> > +	 */
> > +	if (gfpflags_allow_blocking(flags))
> > +		mutex_lock(&buffer->mutex);
> >  
> >  	atomic_inc(&cpu_buffer->resize_disabled);
> >  
> > +	if (gfpflags_allow_blocking(flags))
> > +		mutex_unlock(&buffer->mutex);
> > +
> > +	/* Holds the entire event: data and meta data. */
> > +	iter->event_size = rb_page_capacity(READ_ONCE(cpu_buffer->reader_page));
> 
> [Severity: High]
> Can this result in a use-after-free dereference of the reader page?
> 
> When ring_buffer_read_start() is called with GFP_ATOMIC, it skips acquiring
> buffer->mutex and only increments cpu_buffer->resize_disabled.
> 
> If a concurrent ring_buffer_subbuf_order_set() has already passed its
> resize_disabled check, it will proceed to allocate new pages and free the old
> reader page.
> 
> A thread executing ring_buffer_read_start() could load the old reader page
> pointer just before it is freed by the other CPU, dereferencing freed memory
> when accessing the order field.

Yep, as the comment says, we only bypass for KDB.

> 
> > +	iter->event = kmalloc(iter->event_size, flags);
> > +	if (!iter->event) {
> > +		atomic_dec(&cpu_buffer->resize_disabled);
> > +		return NULL;
> > +	}
> [ ... ]
> > @@ -7367,8 +7413,8 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
> >  		}
> >  
> >  		/* Update the number of pages to match the new size */
> > -		nr_pages = old_size * buffer->buffers[cpu]->nr_pages;
> > -		nr_pages = DIV_ROUND_UP(nr_pages, buffer->subbuf_size);
> > +		nr_pages = old_capacity * buffer->buffers[cpu]->nr_pages;
> 
> [Severity: High]
> This is a pre-existing issue, but can this 32-bit integer capacity calculation
> truncate large trace buffers?
> 
> For buffers larger than 4GB, the multiplication of old_capacity and
> buffer->buffers[cpu]->nr_pages can exceed 32 bits. Because nr_pages is a
> 32-bit signed integer, the result is truncated, and the buffer is shrunk to a
> tiny fraction of its intended size during a resize operation.

This is fixed in a later patch.

> 
> > +		nr_pages = DIV_ROUND_UP(nr_pages, rb_subbuf_capacity(buffer));
> >  
> >  		/* we need a minimum of two pages */
> >  		if (nr_pages < 2)
> [ ... ]
> > @@ -7896,7 +7941,7 @@ int ring_buffer_map_get_reader(struct trace_buffer *buffer, int cpu)
> >  			 * missed events, then record it there.
> >  			 */
> >  			commit = rb_page_size(reader);
> > -			if (buffer->subbuf_size - commit >= sizeof(missed_events)) {
> > +			if (rb_subbuf_capacity(buffer) - commit >= sizeof(missed_events)) {
> 
> [Severity: High]
> This is a pre-existing issue, but does this create a time-of-check to
> time-of-use race leading to an out-of-bounds kernel memory write and
> VMAP flush?

This is fixed in a later patch.

> 
> During a sub-buffer order resize, ring_buffer_subbuf_order_set() modifies
> buffer->subbuf_order globally before verifying if resize_disabled is set. If
> the buffer is currently mapped, the resize aborts and restores the old order.
> 
> In that race window, a concurrent ring_buffer_map_get_reader() call will see
> the new, larger capacity via rb_subbuf_capacity(buffer) here. It could then
> write missed_events past the end of the old, smaller reader page, and
> subsequently flush memory beyond the mapped VMAP range.
> 
> >  				memcpy(&dpage->data[commit], &missed_events,
> >  				       sizeof(missed_events));
> >  				local_add(RB_MISSED_STORED, &dpage->commit);
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260812153311.2328812-1-vdonnefort@google.com?part=3

-- 
Vincent
