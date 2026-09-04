Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00142D47FF
	for <linux-trace-kernel@vger.kernel.org>; Fri,  4 Sep 2026 13:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788527091; cv=none; b=oB7XaJFFN4mbDy1HNn1BARtsLKfRePw+YgaDCMeDVW9t80/qq1qBYlCUotFKDKqdMEmE64H4IkqKc+txEwltjnwzh1umjvO2csEql2I5lVXa87UfkNIUdQDu0Jr4LOj0P5Kx+bSKS54V5y3J45dDWFC0IayeErY0U0kAI5nBu74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788527091; c=relaxed/simple;
	bh=/sa41UtzfZD0TugafCryUEevgoDGEdxb9eKqb+bLE7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PCl1obDkzShsX9NCoXcCP+7/YsM8XjgKVdMBcURW4HdNvk1CxxC6Jt75rNWo4JSyH6Ev9kn9LiGHUlkZxBC6JyF2xxMP/ARm9Mx212Sfklzym/hWmPikyfua0s7PWEC6PJ7lvWxn7LMgvq1svnedsckchRE+DvcUO/RZdTmUjwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vHJjiLVg; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vHJjiLVg"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4858303de5dso1223471f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 04 Sep 2026 06:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788527087; x=1789131887; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SSjeK+InEOwSMEtUuIYSIw3wke/FpQf6/uQzbB1tv10=;
        b=vHJjiLVgIlFZHymZALAGImgxHdRGMAhWKfaotJbHF6MU/4v+cEwgacSttZ6R+B84xp
         2eYF1s5XY/0Rv3V/vfrLYeDvC5Yh33E/3DX7zZFrJg3xoeEEfZzGdBkkh8Mu0GzdS5eX
         DEGXCjbd/PS6BxJL4C82Ln9xEaArAACZdzWFcB5pdaiyuIi6YJdyYTYQNcq7nJcnk67a
         RQQ9gO1vYYyL1aLTTNewopxj0K6w6s9xrUU0a4c9P6+udQ9XAME9rO2oH+lsW1jE0u/6
         GwW9EFFG9OHzIAsEOPn9eqCzuIfqHp9h4WMjqlEdbUComJwnnOR1XT21NOtOA59KNQTS
         oKMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788527087; x=1789131887;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SSjeK+InEOwSMEtUuIYSIw3wke/FpQf6/uQzbB1tv10=;
        b=S5xGKB258Ls756qNYmEfECOYSTER8whXBHai4tjnKAv4evJeM8Qp2+nZERQNcMKXFn
         HqPmjy1rdVQ3aNS9lu3b/vi/VnY86jz+Q4+T/tK4YiKsvD32cimr7Nd/+lKxlLF0Vrih
         z9vb+DJYykHc4LXhgC9G86XgDLFbQYQah8zuXHM2TFETD9C38FebCWDDXtK94y4JP/02
         oX7YOGY6AGkK0cB7lKGOfZGj8eqjwDn9sdj2FdmqVArPaUtKgUY/cIOA8KILol4ppQi4
         AUSQhaOV1KgPzLJDgfGksHQ56+MhmUpqOIF+1kjn2JN+4nCvIgfAK7YvFiwjhgHavpQs
         Wing==
X-Forwarded-Encrypted: i=1; AKwUvBzkKMC5/vZ78LdH/BRGq6JwKeTr7Bi73jbAnhVVBM/LlEazrSHnWWUMdnbmzkc95Sgb3RJDTepD2XsfrHOX7ob8vxc=@vger.kernel.org
X-Gm-Message-State: AFuF++m9yqWy0enrzkYZ3FRPLmBorkBbnBWYCLCZR3MUUReUK2Pf6Uhz
	XBP57AxgKAFNLPXxZUVTgMf8I1uR5DOT15+Vxl3qSLszI94tYtGtxQRyka9abtSOEg==
X-Gm-Gg: AYBFou1wF/n3gtq7KU5ESbiJcw66sH1WvomJOxr2rWOCVI5ETChtcayfdUirrX++Vya
	jlJFB1kuobwHwWFTGDPmnFe5ZjoE+hi1ME0cFchmzTLA7a2xfkmsEg9Q0PKSmSfn6CnOnE7g0jf
	y2v1RcM3plpqqllcIqQ9HlTytbqYhDogKumuIzapaHiJSFQKuEPriC4mstSBQomwACFTzo0rjg1
	+U7mVAUf+5Rd1m42M3+nbes37Ny+ynb/ue/pm9toRcxQKRyBJhGXkZzgPzIY/EAFlNQoOATDeoE
	/DU0oOV0doyUCa2K3Pj1NoNOmzliibgCLrgBR+jnBalrZdDcNKGHtFliW7sWCVy1EnSVPoWEKI2
	Ic1Brwfa4HL7q7gL5O/1dBB/12VMAqTPa/VoAnJBaniD8nxxvOe+wVdLF+UAGM+44EeiKW4L+qb
	NHJy6UO4SN8ECzOrD8ag0V26tP0XIvqnxLIAJMFgSyT52AnyFJsqLuSwLHLFxUTSBO/2Dtw5sfA
	DyuR5W7C6UplPLbiUXLcieMzEV5qLWN
X-Received: by 2002:a05:6000:2486:b0:485:8c16:a32c with SMTP id ffacd0b85a97d-4858c16a6f4mr3003582f8f.33.1788527086016;
        Fri, 04 Sep 2026 06:04:46 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885b1320sm6312696f8f.27.2026.09.04.06.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 06:04:44 -0700 (PDT)
Date: Fri, 4 Sep 2026 14:04:40 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com, kernel-team@android.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 3/4] ring-buffer: Cap static ring buffer nr_pages
Message-ID: <aprB6OE1juuopC7q@google.com>
References: <20260901155445.1475405-1-vdonnefort@google.com>
 <20260901155445.1475405-4-vdonnefort@google.com>
 <20260903125621.36cd33b8@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903125621.36cd33b8@gandalf.local.home>

On Thu, Sep 03, 2026 at 12:56:21PM -0400, Steven Rostedt wrote:
> On Tue,  1 Sep 2026 16:54:44 +0100
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
> > Static ring buffers (i.e. persistent, user-mapped and remote) rely on
> > the bpage::id field. The number of pages for those ring buffers must fit
> > into that variable. Enforce this limit on ring buffer creation or
> > user-mapping.
> > 
> > While at it, make buffer_page::id 31 bits. This does not change the
> > struct buffer_page size.
> 
> Let's not add that change to this patch. Especially since this has a fixes
> tag to it. That change has nothing to do with the fix.
> 
> The reason I had it as 30 to begin with was to reserve a bit in case I
> found another reason for it. If 1<<30 is too small for the number of boot
> buffer pages, we can always up in another order in the future.
> 
> > 
> > Fixes: be68d63a139b ("ring-buffer: Add ring_buffer_alloc_range()")
> > Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> > 
> > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > index 28dd76edfecf..c4260d6ecdfc 100644
> > --- a/kernel/trace/ring_buffer.c
> > +++ b/kernel/trace/ring_buffer.c
> > @@ -350,7 +350,7 @@ struct buffer_page {
> >  	local_t		 entries;	/* entries on this page */
> >  	unsigned long	 real_end;	/* real end of data */
> >  	unsigned	 order;		/* order of the page */
> > -	u32		 id:30;		/* ID for external mapping */
> > +	u32		 id:31;		/* ID for external mapping */
> >  	u32		 range:1;	/* Mapped via a range */
> >  	struct buffer_data_page *page;	/* Actual data page */
> >  };
> > @@ -657,6 +657,15 @@ static bool rb_is_static(struct ring_buffer_per_cpu *cpu_buffer)
> >  	return cpu_buffer->user_mapped || cpu_buffer->remote || cpu_buffer->ring_meta;
> >  }
> >  
> > +static unsigned long rb_static_max_pages(void)
> > +{
> > +	/*
> > +	 * Static ring buffers are using bpage::id and must account for the
> > +	 * reader page.
> > +	 */
> > +	return (1UL << 31) - 1;
> > +}
> > +
> >  struct ring_buffer_iter {
> >  	struct ring_buffer_per_cpu	*cpu_buffer;
> >  	unsigned long			head;
> > @@ -2842,6 +2851,10 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
> >  		 */
> >  		nr_pages = (size - sizeof(struct ring_buffer_cpu_meta)) /
> >  			(subbuf_size + sizeof(int));
> > +
> > +		if (nr_pages > rb_static_max_pages())
> > +			goto fail_free_buffers;
> > +
> 
> If you want to add something, we could add to the beginning of this
> function:
> 
> 	/* Prevent ridiculously small sizes */
> 	if (size < PAGE_SIZE)
> 		return NULL;
> 
> to shut up Sashiko about overflows :-p
> 
> -- Steve

tracer_alloc_buffers() uses size of 1 for non-expanded buffers.

I'll test size just before 

  nr_pages = (size - sizeof(struct ring_buffer_cpu_meta)) /
  	(subbuf_size + sizeof(int));

> 
> 
> 
> >  		/* Need at least two pages plus the reader page */
> >  		if (nr_pages < 3)
> >  			goto fail_free_buffers;
> > @@ -2874,6 +2887,10 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
> >  		/* The writer is remote. This ring-buffer is read-only */
> >  		atomic_inc(&buffer->record_disabled);
> >  		nr_pages = desc->nr_page_va - 1;
> > +
> > +		if (nr_pages > rb_static_max_pages())
> > +			goto fail_free_buffers;
> > +
> >  		if (nr_pages < 2)
> >  			goto fail_free_buffers;
> >  	} else {
> > @@ -7836,6 +7853,9 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu,
> >  	/* prevent another thread from changing buffer/sub-buffer sizes */
> >  	guard(mutex)(&buffer->mutex);
> >  
> > +	if (cpu_buffer->nr_pages > rb_static_max_pages())
> > +		return -E2BIG;
> > +
> >  	err = rb_alloc_meta_page(cpu_buffer);
> >  	if (err)
> >  		return err;
> 
