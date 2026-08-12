Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD0A46EF9D
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 16:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786552655; cv=none; b=HMZEp4i5MDmT7RNlTritLtVSaXLsE+XMbXC6aOE/kFFQ9lwSM/pPOiZTOyOB3aBIgT8DsdDfN+SHgDC3PmHeuaG/2R683XbuUNB5PLVn7WhnPF7IeC2YOI95zEXOsZ7wTd06Ea7hUIO5+tUDUpS8CjYevvrzA1xdIN/imN/YQyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786552655; c=relaxed/simple;
	bh=pj5O4LEs5W4iN3YPfoHEuQ24FsCcXPftRsRTMhlNqgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nkfYzSdRljvpemOY3Slre4KNV86luyW4oMO9/BbzRBmydDCDpTlJxJvB1LGQZy2djw5HHkpa/Vsi5pqplEGTdklNmQ+xzz9mt3HtFGmJAm786OTFbanL/nTxEOFLpgm0MA7lwGCfnNwpSf1lnzzaIWgseRKDy/6uD+hJJHNXYWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sBXGk5oM; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sBXGk5oM"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4954df200ddso8777455e9.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 09:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786552649; x=1787157449; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4rPsIUEiOqHTIYgBrX4TJ7V/UTjBQeQ8ZzjczPhnr18=;
        b=sBXGk5oMsU/wIygTijZ/fG3VBugL7gRz57awYvx0YHDDznUKpuipmi7mujxiP49b84
         aE2+trqeU4omN7Okcrh9wNCNS1DYuTo18FCAMyz0ETMFVNAm+v8FG1xrcoh/AVcN/5TO
         nbNUMtb+6nLnDpDjOlQtVf2hnVUXcZSD7dH48N3FDS2/rFHEHQEd8poBKGcNM2zbm2qJ
         wbUE0fmuLTKlRtu/hYnFY7+b+cQFVjTjHQFhyjC4UKIUZ6PcXg9d40+Boa0WGAMJPqTH
         xP87XZOcLRHpLxY1u08I9Oigv7grE5eW0W/w+dzSzuG3QnAbTwxR6hPSZ65JwBBdjUYd
         7v3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786552649; x=1787157449;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4rPsIUEiOqHTIYgBrX4TJ7V/UTjBQeQ8ZzjczPhnr18=;
        b=PbpNK5Y+Yw64S7c47a1ymKRoiegVJbyUyoePsKDyq999ZjrMQ2ELRPnQfLkhWCcUyi
         KjaFg5i958skBscrUU8yScxaE/h8Ams/3jnmmh7JEfoxS/M5De4CKT/lq2duRi+OBPrP
         aLlkfRyiy5CpfELpanl2GSJqUnWQiAs2tzK/1nfryWuEcLIEx5XXGdxJkJSl9yqkGkRW
         JETUkS7qwlrgm/kExuc4lqO3I8gOksiQNUQ4N7F9Mlqxc+JnYRmtH/tqxhGq8S6pMBm+
         Y0imwnVXWAiqnDtNh9viHknJ0Lm5ISH2lTbEK2C+dTsV0ZAqsuHi00fW4mL7dx1YIObF
         eH/w==
X-Gm-Message-State: AOJu0YwbARM4V9ESKyMCtMknVhVP2hN2rYe5MrxSLnZTnKll/isvaDD2
	jRkP+/TPPd50u6aYbkQnQs+m9auHIvFuJ06CWnZ9FbmTaNDXmN794ARkds3cBKl4+BJ70CByXOj
	h/VE0Zg==
X-Gm-Gg: AR+sD120bzU32gbt3cpjP6J8fe/rsrgnUiUYQYzBuYOiTUAynl2TOwQ5t8RoapM9MAZ
	S0/CTilvMeAHBgZKWILTRaFUYSDeeXVTfPgj3+QeEcWVCx1wVzX60RZSxsr4zSH5JEzUYTl6Xvg
	P07hRg2OE+QwxwWoveC6QoHoiEqO5oWQimVy5aXYc60ezrl2qhox+3U9zJMsBXZX27MGZSyUKJe
	D3exquLrkL4t+QTeIgJ7RI4HA0tJTT92XTWOGHrVpX0CkMsCQXv6x47yc93fby0JQsVgpEY+Dvu
	wNdEA3b7O/uH+m4aMgP0NJ/NKWB8CHyvlj6qCResTYgPuCfIJqrt69w8P0kHCcT9dTr0ykmGdr3
	rNdRIf4jPnBNAv4uP0VhEdb+IT4CHaOF4d09W2+ZL226R6O+k4e7moVUAeSqz2OuctERteH4hk3
	9/FULd1G39QRU3tCxFBlGPtVden9aYSgewknwgShTd1P/I8qfGR/yp51LDjFhjHVFl3AWuz2hml
	eiZXHASzpbWJEW4/0Ms33DWEpuMHjmL
X-Received: by 2002:a05:600c:4504:b0:495:737a:7afe with SMTP id 5b1f17b1804b1-4997c12592cmr91297785e9.15.1786552648825;
        Wed, 12 Aug 2026 09:37:28 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997809c720sm58638035e9.4.2026.08.12.09.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 09:37:28 -0700 (PDT)
Date: Wed, 12 Aug 2026 17:37:23 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/9] ring-buffer: Free cpu_buffer->free_page with
 subbuf_order
Message-ID: <anyhQ_3EsG-RrAqS@google.com>
References: <20260812153311.2328812-1-vdonnefort@google.com>
 <20260812153311.2328812-2-vdonnefort@google.com>
 <20260812155038.516A31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260812155038.516A31F000E9@smtp.kernel.org>

On Wed, Aug 12, 2026 at 03:50:37PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [Critical] Concurrent execution of sub-buffer order resizing (`ring_buffer_subbuf_order_set`) and read operations (`ring_buffer_alloc_read_page`, `ring_buffer_read_page`) can lead to out-of-bounds writes, use-after-free, and page allocator corruption due to mismatched synchronization.
> --
> 
> --- Patch [1]: [PATCH v4 1/9] ring-buffer: Free cpu_buffer->free_page with subbuf_order ---
> commit 4100674474d6bd293fb872fecb17fc781ca58502
> Author: Vincent Donnefort <vdonnefort@google.com>
> 
> ring-buffer: Free cpu_buffer->free_page with subbuf_order
>     
> When sub-buffers use an order greater than 0, cpu_buffer->free_page is
> allocated with subbuf_order. Use the correct order for
> cpu_buffer->free_page.
> 
> > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > index 2667992f0aa29..a3d28b2e2c94a 100644
> > --- a/kernel/trace/ring_buffer.c
> > +++ b/kernel/trace/ring_buffer.c
> > @@ -2631,7 +2631,7 @@ static void rb_free_cpu_buffer(struct ring_buffer_per_cpu *cpu_buffer)
> >  		free_buffer_page(bpage);
> >  	}
> >  
> > -	free_page((unsigned long)cpu_buffer->free_page);
> > +	free_pages((unsigned long)cpu_buffer->free_page, cpu_buffer->buffer->subbuf_order);
> 
> [Severity: Critical]
> This isn't a bug introduced by this patch, but is it possible for a race
> condition between resizing and reading to lead to memory corruption?
> 
> If thread A changes the sub-buffer size via
> /sys/kernel/tracing/buffer_subbuf_size_kb, ring_buffer_subbuf_order_set()
> updates buffer->subbuf_order locklessly globally before tearing down the CPU
> buffers and clearing their free_page.
> 
> If thread B concurrently reads /sys/kernel/tracing/per_cpu/cpu0/trace_pipe_raw
> via tracing_buffers_read(), it observes the new order and calls
> ring_buffer_alloc_read_page().
> 
> Because ring_buffer_subbuf_order_set() hasn't yet cleared
> cpu_buffer->free_page for this CPU (they use distinct locks), thread B pops
> the old page from free_page but tags it with the new order:
> 
> kernel/trace/ring_buffer.c:ring_buffer_alloc_read_page() {
>     ...
>     bpage->order = buffer->subbuf_order;
>     ...
>     if (cpu_buffer->free_page) {
>         bpage->data = cpu_buffer->free_page;
>         cpu_buffer->free_page = NULL;
>     }
>     ...
> }
> 
> Thread B then calls ring_buffer_read_page(). The lockless check passes
> because both match the new order:
> 
> kernel/trace/ring_buffer.c:ring_buffer_read_page() {
>     ...
>     if (data_page->order != buffer->subbuf_order)
>         return -1;
>     ...
>     reader->page = data_page->data;
> }
> 
> Could this allow the undersized old page to be swapped into the ring buffer
> as the reader_page, leading to an out-of-bounds write when a writer attempts
> to write large events? 
> 
> It seems it could also cause page allocator corruption when a smaller page
> is later passed to free_pages() with a larger order.
> 
> >  	kfree(cpu_buffer);
> >  }
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260812153311.2328812-1-vdonnefort@google.com?part=1

All that is hopefully fixed in one of the later patch of the series

-- 
Vincent
