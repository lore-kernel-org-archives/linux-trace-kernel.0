Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D80470E85
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 17:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786554731; cv=none; b=uvKn5EzIzgkneTP++dvp6VCMin4EnJl0o2QYno/wijbzsfZf5zTMFrTznVq+phq5koQQeOJMa+XMMVZ+8DccSsQlAj0d0zFWqD/i5T3nmvLrIdgBoCMuMVnvq+j9x1ajgITNJRKGv6O+qdBBMJjP4dWrF32YcOOVRygDpxNmXV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786554731; c=relaxed/simple;
	bh=rqwlOq92I7cuDiuf8w5pty+c2+C2G6VIPKgJG/DFOdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dWNfkto20RRSrgLB5AqFkw1bXaNXpPzpxa7bX7nfz+JyzAfhZ0eyjFKk9vd0hIWXULeP0S8TCwj3yXGCL1bOogZKLT0FwMVoUgPP3zY8fYLQOzof7Wo9y7G2ouAD2HPgHeG37w/YFz3587pnzIKjyZWjVRlvjdt7rPl6DPYfuC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CeLHMsyu; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CeLHMsyu"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4954d29264cso6257135e9.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 10:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786554727; x=1787159527; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EsahJiz4yxbPgD3b0qmgAoU22rS/dqIIjVwmpwb6x7s=;
        b=CeLHMsyul29Dy1A69+ahYxU3DD9ZGpCjr2+PC62RVySQPZpfR/rIhuogsaKEZM8z7Z
         eAp5eaJj17Qe3CvTTLjO+wgzDJtFoAj38+VSROCrm9QzfIHbYgt3t8ZLXTstfv2EIHGV
         pxrn3WRe2eQbuNtcct51VzMh2EU2MFpuUl6SljwUHu8JPXbhwyj1EFF/a8TTitNLstII
         TYxp2PUdDoQIUu+YPUCE0r604a2yP34fHGq8ruro8pIH0GJ0bBGdzU3zJhmlq3QjqjEa
         FMhTIg0ze4VWmFQ5eZuR1KuzJWkoS2vRpgadkS8OnT4kk6mCYIkE3l9lxPAys0tzID83
         zcDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786554727; x=1787159527;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EsahJiz4yxbPgD3b0qmgAoU22rS/dqIIjVwmpwb6x7s=;
        b=UQ5u0nxKW+Zz5ZoP7BxT4lG3QMH8GhHCpDU5KyxqTrJ/N0Q0OcfjtgSaDjzo/WAGPL
         TnUDfhQzJSXmaPmG8pxyIc1cI3e3IpP5/lb/q38WVfxL8X4jQ8A8ZTM20H1gOaZVQqk0
         EQR4Fg6yjsqWayoioFBgJmPj2sKLxSKXol9eC4ZhnTdDqgocwUGnnjzEwFvPAkDb4L+W
         tW518Gqsnh76c5X/0DGNHVNbvD+WNq4HdK2lSMw/xqk7D0/WWje3KshzKbpPCulcjhXh
         TMsPHRb2+L2FLNieUmuy7pavlhhpnrWrDNDOhAUMoyDQajn0kI76gPRhflxNfJ4sd04m
         Y6QQ==
X-Gm-Message-State: AOJu0YxJuJeJLshufg+Bj1G4Q6j8sN00lLO5QeLW6MvEqA+U6VVPHwgO
	hJApe8XfUHf/XvC/ZP2Xu8ZRyZ7CMVWZHv1/9AJPy76dl9hKsd/7Z20S2OXgcLMnC2Z2IcQ5Rdq
	RQPo4uQ==
X-Gm-Gg: AR+sD13pZ5fFy174s89nYY/8GNpRI/Q53EW9Ig82Q+Zjtmf5f8SaT8f/klnJr8jQHHK
	D9zhCvFI7oENejjGnMBMWTuq+/Pg2T0G1SE4QM0qMSDBxg8ryrIyIcDlqEvhQWuNlMdWW8PJyaf
	fKAVF5FPPwbIVOcVRlXjlUeRAToISH4nYpQascvtPziLr6+diuv827wz2OLE3Zcye1aajrNx5l0
	4eZCJGtCwlvm1dDG/hYwYRKJeEyyWXXtjkzajMzbFjnlgY4bsbr7aCv2fQxYHtk1l+o1o8mhadK
	vUpJYzDOk+QTYAyAK94PbdLELtdd2DrxtHUTrR3fZ4fGZJh2FV6BMgcwPA7GJhr9zI5XqDd3L0Y
	fjlUrH3CYzZ4S7bvfTTFF+UAZQzqKZJG+My/oT2EuwnYJrbpJrWNzw0wDmGWNaDtue3/hyYAuOz
	a5OxqZaYdS0rxRy6quU/zUcfOuzLde8JjG255Q0VjFBDu5tfMw/Hvp9HJ4loRDTbr2oBZ5vu5R6
	hAxeqEzrDwvdKX4mwkf7bZa8BDbTikv
X-Received: by 2002:a05:600c:474c:b0:499:7f38:d77 with SMTP id 5b1f17b1804b1-4997f380e1bmr38827795e9.6.1786554726938;
        Wed, 12 Aug 2026 10:12:06 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997b34afe3sm72654905e9.2.2026.08.12.10.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 10:12:06 -0700 (PDT)
Date: Wed, 12 Aug 2026 18:12:02 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v4 6/9] ring-buffer: Dynamically calculate max_data_size
Message-ID: <anypYj3B7ASbtoCQ@google.com>
References: <20260812153311.2328812-1-vdonnefort@google.com>
 <20260812153311.2328812-7-vdonnefort@google.com>
 <20260812155643.1A6D71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260812155643.1A6D71F000E9@smtp.kernel.org>

On Wed, Aug 12, 2026 at 03:56:42PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [Critical] Concurrent execution of ring_buffer_alloc_read_page() and ring_buffer_subbuf_order_set() leads to buddy allocator corruption and potential OOB memory access due to a mismatched page order when taking cpu_buffer->free_page.
> --
> 
> --- Patch [6]: [PATCH v4 6/9] ring-buffer: Dynamically calculate max_data_size ---
> commit a7794ac711440e6d89d8e099e4a88707ad083ed7
> Author: Vincent Donnefort <vdonnefort@google.com>
> 
> ring-buffer: Dynamically calculate max_data_size
> 
> The ring buffer order can be dynamically modified and temporarily
> disables writing to do so. It is therefore safe to use the updated value
> to calculate the maximum event size which can be written onto the ring
> buffer.
> 
> > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > index f62d6853ee5c0..64bf4ac853f57 100644
> > --- a/kernel/trace/ring_buffer.c
> > +++ b/kernel/trace/ring_buffer.c
> > @@ -598,7 +598,6 @@ struct trace_buffer {
> >  	struct ring_buffer_meta		*meta;
> >  
> >  	unsigned int			subbuf_order;
> > -	unsigned int			max_data_size;
> >  };
> >  
> >  static __always_inline unsigned int rb_subbuf_size(struct trace_buffer *buffer)
> 
> [ ... ]
> 
> [Severity: Critical]
> This is a pre-existing issue, but can concurrent execution of
> ring_buffer_alloc_read_page() and ring_buffer_subbuf_order_set() lead to buddy
> allocator corruption and potential out-of-bounds memory access?
> 
> When a user reads /sys/kernel/tracing/per_cpu/cpuX/trace_pipe_raw, it calls
> ring_buffer_alloc_read_page(). If another thread concurrently resizes the ring
> buffer via /sys/kernel/tracing/buffer_subbuf_order, it calls
> ring_buffer_subbuf_order_set().
> 
> In ring_buffer_subbuf_order_set(), buffer->subbuf_order is updated locklessly
> with respect to the reader:
> 
> kernel/trace/ring_buffer.c:ring_buffer_subbuf_order_set() {
>     ...
> 	buffer->subbuf_order = order;
> 
> 	/* Make sure all new buffers are allocated, before deleting the old ones */
> 	for_each_buffer_cpu(buffer, cpu) {
>     ...
> }
> 
> Before ring_buffer_subbuf_order_set() reaches its second loop to clear
> cpu_buffer->free_page, ring_buffer_alloc_read_page() can fetch the new
> order, grab the old page from cpu_buffer->free_page, and assign the new
> order to bpage->order:
> 
> kernel/trace/ring_buffer.c:ring_buffer_alloc_read_page() {
>     ...
> 	if (cpu_buffer->free_page) {
> 		bpage->data = cpu_buffer->free_page;
> 		cpu_buffer->free_page = NULL;
> 	}
>     ...
> }
> 
> When this page is later freed or swapped into the ring buffer, could this
> cause memory corruption because writers believe the subbuffer size is the
> new order, leading them to overwrite past the old order page?
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260812153311.2328812-1-vdonnefort@google.com?part=6

Ha this is something I was meant to fix as well... we can't just blindly take
cpu_buffer::free_page! 

I think the best is to make cpu_buffer->free_page a buffer_data_read_page so we
have an order associated to it!

-- 
Vincent
