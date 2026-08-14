Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11A5430782
	for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Aug 2026 08:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786694620; cv=none; b=iTT4Hv8bVJot7N0wHs4u+ADwHM42HTr6XbZkvtsrBisHiI47Gete8ZS7cuvLZbjLraq7cYshQP7xq6nT6jqNnbMvgZvmu8Wf3OlGfCYsvcjUfAOPJsTjqLLoZ6Q43Goisjill5mkbL53o2QnGaFpyZbwiCX/tXtbybWfyUxEhSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786694620; c=relaxed/simple;
	bh=HZPcZn6KVzUbjUq4/fHah+/C47ftJLRPnev0e4deQd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K1qxDUCjFj7GITm+5XiJarwmSK8/moPZpa7E5dtYW8OE3tPvEN/79Xz4440Ocp97Pg26OoWvB5msTiES/sxdPXLATvyXg8hrs0+Fmngdboyuo0w99L67O2SvpJvbn+W0JemsVDvz19N9BUK9OZyNNdRgodwLZGwi6rXb4WlNwpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JaZK+RSv; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JaZK+RSv"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-69c600f76ccso1054518a12.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Aug 2026 01:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786694617; x=1787299417; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Qfga6kTEgNRkec+hK5oUCTaxG2BZlPVkrA02S50FL+E=;
        b=JaZK+RSvHZMRSUyHdCrn9l7vODLtg3hDkDGWzBHRDWinhyfaZvUVcZES5fClVYKY/5
         Qosrj8AypMedXyKb2suNwdJQ5+RG/pfnIE2gwnKRjeeh20gDr/CvkUWzAVBvAHFU1LAt
         GKSek359Mf8lcHfedL1cvzblK8d7dwi+2VT4VGbDvSFcWfDqVKbbuYwoi9aJYuHwS9eL
         Pl0+wXGBAIwCzlgAkrPfw6hWZiI0ZqifLBc9LGeHPjPBn2W3g971vzgJuUg91i43F2Iv
         fM1vfZQ5MN1MgmdtsxyYooAjzXHjO04j5S3EGUV14cJdPRkUB1oDZtBDKU86FmyD/0v8
         C6Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786694617; x=1787299417;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qfga6kTEgNRkec+hK5oUCTaxG2BZlPVkrA02S50FL+E=;
        b=qABE9H6CGApVrizNU4xkuIYURebPm4R+mpxkHdKOQpLtzIrRjU/3/53+R9JW7y1Z5h
         OEpXFqO4oFLS5nYvRGqnWdNlItITowKS5KkDZDXsO9BSqsXYyRRMcXGbCyspYzEz/Ydk
         a5zTCeuc4pp9Eu7pHLJ+a7RLum7/aiOJk6b8Y22fPxFGXYIXhwjWxpOTgGDXXbksZ+ce
         dImUdSILJly/ZZkadUCHJVlPALj0gm2R5AP4qxhPybTB19ga9LtdeQGY81vENX+jE7Yd
         I3RMQBHjc/NmhRXmCSUbuWHEjbW+pzJJSgH+Ix+wSlVU/1tVA62u4VhFTiCnU8OicuFc
         SoLQ==
X-Forwarded-Encrypted: i=1; AHgh+RoRVLcnJUMQsnvkzFR8UE88DND0ARClyuF6/P1TG1vVqWhKuNBgy/mnjmh8r8rC+a8ycQa47dCT5LTuh6KimTXSnCA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yytbi55R3zlHwXNeNhAQoMSLH62bHNHQk2FOQyfBHxHmtHbgLjR
	92ArevbohECaN7YNm48513u6DPfNkGWHWyMKQqnYaQ0YlFN1l3gS7WQ1Etzm5mRtkQ==
X-Gm-Gg: AR+sD11xR6DJeqEJMkWFA/iEd7ASEHXQW1ZEHkYWnoyLODpnRt/hxd/RKtsYAISWpLZ
	ZQipqB2GwUVRirF1JHm9DH/Kt+d8XOd/iDNrZCXoERADUqaSMN4jZ2/HreF2kOX6iCfY4r8jaMY
	EJiMNEHZP/tposoE+K93EUGPgTEI2RRJJNtX9qS3qXVXmaTXvVK1ABLOfW707pX0J1s2dN5fE20
	vKjoFOPAHC2GX7fL7e9XbDQxX02z8TlcVugu5oZBlg/e1cRuDoWgrbo/GiS4i4eIKY1QvxILVCT
	I0A2hjf0W/j1Mwp/3RiUSATU+TiBOtK3UJ8uy2fLwZ1/HnhE8+rdT5XfFeQtaW0QGe7dBGIRWBB
	oUGKO1EoI1cdLLmJxk8Ap/lTOlMmWpERQfekQlKtJeCEe58ITb0ZY0KMZRp7Xdls/deHbaOi/80
	Ym+P1Q0eHCR3zuiWZPs+S6kIJ2IqOCDuQWHdrpWGm+MKGrp5sROXY0Y412Ai02E8VR71tGX5M6d
	sYpoayOKp5GyK+Gl193DLxMbxQZo4AL
X-Received: by 2002:a17:907:d08:b0:c12:9b98:209e with SMTP id a640c23a62f3a-c212a2d8028mr127457966b.23.1786694579960;
        Fri, 14 Aug 2026 01:02:59 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2b1d9bsm6154877f8f.24.2026.08.14.01.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 01:02:59 -0700 (PDT)
Date: Fri, 14 Aug 2026 09:02:55 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com, kernel-team@android.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 06/10] tracing: Fix subbuf resize races with
 trace_pipe_raw readers
Message-ID: <an7Lr4wMOwg_-vgX@google.com>
References: <20260813131152.3589632-1-vdonnefort@google.com>
 <20260813131152.3589632-7-vdonnefort@google.com>
 <20260813213153.4ac1e1ff@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813213153.4ac1e1ff@gandalf.local.home>

On Thu, Aug 13, 2026 at 09:31:53PM -0400, Steven Rostedt wrote:
> On Thu, 13 Aug 2026 14:11:48 +0100
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
> > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > index a00ab8a9cbd0..83292d90599e 100644
> > --- a/kernel/trace/ring_buffer.c
> > +++ b/kernel/trace/ring_buffer.c
> > @@ -6976,34 +6976,52 @@ EXPORT_SYMBOL_GPL(ring_buffer_swap_cpu);
> >   * ring_buffer_alloc_read_page - allocate a page to read from buffer
> >   * @buffer: the buffer to allocate for.
> >   * @cpu: the cpu buffer to allocate.
> > + * @prev: The previous page to be repurposed (can be NULL).
> >   *
> > - * This function is used in conjunction with ring_buffer_read_page.
> > + * This function is used in conjunction with ring_buffer_read_page().
> >   * When reading a full page from the ring buffer, these functions
> >   * can be used to speed up the process. The calling function should
> >   * allocate a few pages first with this function. Then when it
> >   * needs to get pages from the ring buffer, it passes the result
> > - * of this function into ring_buffer_read_page, which will swap
> > + * of this function into ring_buffer_read_page(), which will swap
> >   * the page that was allocated, with the read page of the buffer.
> >   *
> > + * If @prev is provided, and it has a different order than the current
> > + * subbuffer order, its payload will be freed and re-allocated. If it
> > + * already matches the order, it is simply returned.
> > + *
> >   * Returns:
> >   *  The page allocated, or ERR_PTR
> >   */
> > -struct buffer_data_read_page *
> > -ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu)
> > +struct buffer_data_read_page *ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu,
> > +							  struct buffer_data_read_page *prev)
> 
> I think we should do this differently. I don't like the "prev" argument.
> Instead, let's pass by address.
> 
> int ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu, struct buffer_data_read_page **rpage)
> 
>

ack.

> 
> 
> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > index 395238b2b715..f9399f391ac6 100644
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> > @@ -7080,8 +7080,8 @@ ssize_t tracing_buffers_read(struct file *filp, char __user *ubuf,
> >  {
> >  	struct ftrace_buffer_info *info = filp->private_data;
> >  	struct trace_iterator *iter = &info->iter;
> > -	void *trace_data;
> > -	int page_size;
> > +	void *trace_data, *prev_spare;
> > +	unsigned int spare_size;
> >  	ssize_t ret = 0;
> >  	ssize_t size;
> >  
> > @@ -7091,36 +7091,30 @@ ssize_t tracing_buffers_read(struct file *filp, char __user *ubuf,
> >  	if (iter->snapshot && tracer_uses_snapshot(iter->tr->current_trace))
> >  		return -EBUSY;
> >  
> > -	page_size = ring_buffer_subbuf_size_get(iter->array_buffer->buffer);
> > +again:
> 
> 
> > +	prev_spare = info->spare;
> > +	if (prev_spare) {
> > +		spare_size = ring_buffer_read_page_size(info->spare);
> >  
> > -	/* Make sure the spare matches the current sub buffer size */
> > -	if (info->spare) {
> > -		if (page_size != info->spare_size) {
> > -			ring_buffer_free_read_page(iter->array_buffer->buffer,
> > -						   info->spare_cpu, info->spare);
> > -			info->spare = NULL;
> > -		}
> > +		/* Do we have previous read data to read? */
> > +		if (info->read < spare_size)
> > +			goto read;
> >  	}
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
> > +	info->spare = ring_buffer_alloc_read_page(iter->array_buffer->buffer, iter->cpu_file,
> > +						  prev_spare);
> > +	if (IS_ERR(info->spare)) {
> > +		ret = PTR_ERR(info->spare);
> > +		info->spare = NULL;
> > +		ring_buffer_free_read_page(iter->array_buffer->buffer, info->spare_cpu, prev_spare);
> >  		return ret;
> > +	}
> 
> 
> instead of the above:
> 
> 	ret = ring_buffer_alloc_read_page(iter->array_buffer->buffer, iter->cpu_file,
> 					  &info->space);
> 
> Where the above could do (under lock):
> 
> 	if (*rpage) {
> 		if (*rpage)->order == buffer->subbuf_order)
> 			return 0;
> 		ring_buffer_free_read_page(*rpage);
> 		*rpage = NULL;
> 	}
> 
> 	*rpage = all the reader page;
> 
> That is, lets completely remove the responsibility of the user having to
> keep track of the buffer order here.
> 
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
> 
> And if we could make ring_buffer_read_page() return -EAGAIN if the spare is
> not the proper order. And only for that case.

Sounds good.

-- 
Vincent

> 
> 
> > @@ -7129,6 +7123,10 @@ ssize_t tracing_buffers_read(struct file *filp, char __user *ubuf,
> >  	trace_access_unlock(iter->cpu_file);
> >  
> >  	if (ret < 0) {
> > +		/* Did we race with ring_buffer_subbuf_order_set ? */
> > +		if (spare_size != ring_buffer_subbuf_size_get(iter->array_buffer->buffer))
> > +			goto again;
> 
> Then here we can just have:
> 
> 		if (ret == -EAGAIN)
> 			goto again;
> 
> -- Steve
> 
> 
> > +
> >  		if (trace_empty(iter) && !iter->closed) {
> >  			if (update_last_data_if_empty(iter->tr))
> >  				return 0;
> > @@ -7142,12 +7140,14 @@ ssize_t tracing_buffers_read(struct file *filp, char __user *ubuf,
> >  
> >  			goto again;
> >  		}
> > +
> >  		return 0;
> >  	}
> >  
> >  	info->read = 0;
> > +
> >   read:
> > -	size = page_size - info->read;
> > +	size = spare_size - info->read;
> >  	if (size > count)
> >  		size = count;
> >  	trace_data = ring_buffer_read_page_data(info->spare);

