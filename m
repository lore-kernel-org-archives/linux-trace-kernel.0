Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459DD3803EF
	for <linux-trace-kernel@vger.kernel.org>; Thu, 30 Jul 2026 08:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785399198; cv=none; b=fOA+AZgvwAFUURWB2I39UpNuBGfe909mkc36gNJbdw86LaEGZKTF/bfGBOA0ZdfNuJbrvgZkBayMA8q4oX7k0flJBobQH9imLt4bcfrldHLZdCJS8fuLcXoQMDCgM2Rm7MC1GZHA2ff6Svc+BNFwtIpuwTJgZLt0wt1jEmN8GAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785399198; c=relaxed/simple;
	bh=4UjqegiqqkwQLGcObgsAsaBlVRRZB81Kadcu/mnixzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CTNFz7rVYfJ9/FxNsIGhS1bqijycLRsy9oDQT+m8CHOtpbNs1JIwTWH85KGQ2bc3AllWtbZNdRj/y2uFie7mZtLjmlU6fOX95oi0ZDTIlI9TIl6p/kLER1MEbfjiezfJuR6eShNlUlGoR7/yszjIiZtfGq0nZKfPQfFzwrLVOdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=POypOINP; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="POypOINP"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c15d47266baso229094466b.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 30 Jul 2026 01:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785399193; x=1786003993; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=t1c3TMYJPV/i4q6IntYhww97ey3M9wPjCcBpkAHl8jU=;
        b=POypOINPvPHviSPNB7B9JfNECnfv0Vp8HmtJp99Yz2bExxNqZ1lH/a1WzA7NFJDe13
         4kYPqUDM1y/MRFh33wDsv3XK9LH+gtFoBG6l6RoJV7AiOSUw8vkSUgMIi6Huc056+PMv
         RWHNghMckIl7S+qprUt8pd7T44q7B1YmDJ0LeQyIqa56VaExLPKW4iua+F/jtCl/Y5Xz
         guFEY3kDSxCenPaq0Q3R7JX0GEN9XYewTIXq8+mFQcID3l75RoJpoJk69RzrW38TY+5T
         Gao9Ruy1ET2YfoxHteQCjpQ3mb4spTgciNZWoliUcKEelPNExhbIJUO4VXA+EblTwXy7
         MafQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785399193; x=1786003993;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t1c3TMYJPV/i4q6IntYhww97ey3M9wPjCcBpkAHl8jU=;
        b=ps5ew/R1rqkKRaKiEX+MP7KkOEhNqo7I2QxqtSVg30kUAVqQvVlhRokwTu8DPr5P5m
         JHa9qSUVmyINpFPTCi39yg1ZLL2IZdXPnxcY0I0WvC1jVc0lLuJsxqLNFyLLsnKuzkwv
         j0yNOJGjR+Jn9ZfNSFUD+ozsf/YmMxxIAFn7ydylNQ4ipWcqSCg/bYhPQq/PtVQFf5aq
         1gsX0i7wRXLOSaq6uz+ckYcX7BX/3+E5vBoe1w1s3l13YV8NwN1+K0l32MhBEYJEOKxG
         hgUk2+k4clQB8x+ILyXc9/7t3LluQFnvpcR8+zQQJy9935u2SVEsrc+3Z0fkLCDkuAQT
         mD4w==
X-Forwarded-Encrypted: i=1; AHgh+RoWuUkFQ8LxKWM1vGUG+Ut5wsK0Qfxh6EzamQzDqI6nocYhBS9dAXzTx1LjGZ1Y5Yj/LaxEqxMFrJwsT0v8KjYE1Mc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWglDuNpdMnML+A3SRZ+WwxJZN/+GY+/omNTiR7ISpBUqCfAKm
	CZWrUGadwvFZK9qQ1qZqet0Jkgfq/yW+1gQwEQnRLc4LZbcF2bAfuTqwu5qhwPgyUg==
X-Gm-Gg: AR+sD11NhYZdQRZIUU7xtl87Q1mg6IVfJoLkH7nrNLcGO5CYixG7qrazfouWfYLjeKD
	XAA98QygLzBt2E+bSudC4YScHNHw5i7Jp9dYeRlJgrsqQtfS2FZNaGZtDLWRgcr+qRcqgc+pbBY
	PP1fPCAmQQTyUuAcYgaZ8+VLLgFbPummO827N1Pyigc7eDTUIRnKr0XZhBbwhQs8W8/kIEHoIrr
	JcWN9FGS0a+5FclFgjaPFYKby9iD9W+pEOA7lWQbNBCUyi9vT9/n+9K5bYIEHNEapfQUolZ6gMV
	lfUCqKN5iR33oCNefV6fBD2+gdQ1BhaUE1p5YTn0V38zuzUD9jl7OkYLZrcMwEUWG69BdmTe3Sq
	l+3JtdT+KvEt4UfCCs+qBhMCjTRQG7yp576z4CUTuf3ejCTVsn6OaB+XYMO6KE240V2FPSmYrf7
	4Y2fSLiL6zLhqtgHk8zsL5I9dsScKgqqcANlckzJugqmNYxr2nTSh4oC20DSERvPhmLOKa8ttnD
	7bcCxhBn8hg/3a7nZ27G7dsylyitCzK
X-Received: by 2002:a17:906:9f92:b0:c16:9ca5:e551 with SMTP id a640c23a62f3a-c1fa55d53c2mr81676266b.14.1785399193003;
        Thu, 30 Jul 2026 01:13:13 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fa8577e6dsm37228166b.22.2026.07.30.01.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 01:13:12 -0700 (PDT)
Date: Thu, 30 Jul 2026 09:13:08 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] ring-buffer: Fix subbuf_ids memory leak in
 rb_allocate_cpu_buffer() error path
Message-ID: <amsHlMCNHV9JWA0l@google.com>
References: <178539491147.180138.1181424244288838594.stgit@devnote2>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178539491147.180138.1181424244288838594.stgit@devnote2>

On Thu, Jul 30, 2026 at 04:01:51PM +0900, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> In rb_allocate_cpu_buffer(), cpu_buffer->subbuf_ids is allocated using
> kcalloc() when buffer->remote is non-NULL. If a subsequent page allocation
> fails (e.g., ring_buffer_desc_page() returns NULL or rb_allocate_pages()
> fails), execution jumps to fail_free_reader.
> 
> While __free(kfree) automatically frees the outer cpu_buffer structure
> at scope exit, kfree(cpu_buffer) does not recursively free nested heap
> pointers such as cpu_buffer->subbuf_ids, resulting in a memory leak.
> 
> Fix this by explicitly freeing cpu_buffer->subbuf_ids in the
> fail_free_reader error unwinding path when cpu_buffer->remote is set.
> 
> Fixes: 2e67fabd8b77 ("ring-buffer: Introduce ring-buffer remotes")
> Assisted-by: Antigravity:gemini-3.6-flash
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  kernel/trace/ring_buffer.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 78d3875a47a5..03f6baf6a5f5 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -2599,6 +2599,8 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
>  	return_ptr(cpu_buffer);
>  
>   fail_free_reader:
> +	if (cpu_buffer->remote)
> +		kfree(cpu_buffer->subbuf_ids);

alloc_cpu_buffer() being kzalloc, I suppose here we could just unconditionally
call kfree(cpu_buffer->subbuf_ids) ?

>  	free_buffer_page(cpu_buffer->reader_page);
>  
>  	return NULL;
> 

-- 
Vincent
