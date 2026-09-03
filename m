Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DBD4EBACA
	for <linux-trace-kernel@vger.kernel.org>; Thu,  3 Sep 2026 17:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788455220; cv=none; b=M5dU4tQqVCmmASfpqATjkIvtavVmihDarHzyJKAJY2hBfo7vtLVkkdajnAUTfDl3CKib8lm2KCQ92gxcK3q6Xbjn+HQkw4Vq7eipAwUb6NotvNFy5eZgOaL2Ad7H7BOQ8XvOSL60PtOvVv2h7RA7iFfqsEeBhqFpyupEqQbqFbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788455220; c=relaxed/simple;
	bh=/tlIv2SGGUkoL2UqKX+4qHVEPNSQGE/X4rdnsJAU7MA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=few+07d9dC8uyfvJLUtOI+6vEHo5rgbUSF1cK8pqffnv5oKklUje2YlvfgFD9zckCfql7EFdJe8p6WRkgETrD6c9D0nyIUuTAtjSlAPWT/rlbB4IJb118mgxGtMlUTp4+i+60LU+0EVbw/+T8oT2Fn25Ac4Qcaf+wSXSSHPeP4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jy0m5w3V; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jy0m5w3V"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49b96837ca3so732495e9.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 03 Sep 2026 10:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788455217; x=1789060017; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lG2K8f3DLSAPU8vIl2cNtziQ9OMdBwPe3JQsdDV9ax8=;
        b=Jy0m5w3VBqFWYxx1xr9o1/6Rw3l51AJq9Er6X8Sb4LF0+6VUFki2z5GwfwUJi5qaCn
         +cZ6byxIM743AOgZFjQLJraRo9eP+KS/6BHv1HWjbXq/5pTthF6a7pBxfs4eL+1QNW+5
         Xo/KZ0L2iQZSF5NxpLIol6RsECQIt319VVBn5P07oQRUjSVS7nUpztoNftHrNOiVWiDc
         y+pBGJqlSKt4dpV1cFsmNN82DAQ8gQfYjaZbyjSL3K6DVfZOKRyPfixqcWQgfzD3nD1A
         G/efntZz8j4hdyqZFntAHpwJGKPuQ0ZWmvu1blOZJ50tK4rC2wda2/b/cSbiCqykAB3y
         Kdxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788455217; x=1789060017;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lG2K8f3DLSAPU8vIl2cNtziQ9OMdBwPe3JQsdDV9ax8=;
        b=QFJokVQrH4aMaWgeGhsxsmx3frG1Jm0OEJG+4BfYqB+PAMm6rX0eGtgxLBK1V9uR5s
         mSLnSTdFS8ix0pBCP5ZSFOxN7vlFrCdK89lrt8ECQpvgnVLUdTmsfws/t5yy5fFmGCNW
         n6AbMRaL5GstANB3NFw2kb7ZfAI1VCTXc9k+45ejsupyOOVvQOq8GTnEYgWSJMwu/mmm
         YqUuc2f9yUcokYC4l5R+pIq3+66eRR7tUtxS6Sd/WF0/PngS4bLzsc56Hee/dp7MkUZ/
         qtjZd7e1KjhkOAB/YevXDrr6SNKeIElicbURppbP/cOZ27Nb1x9A1hd6ydy5oMmI9N9K
         awFA==
X-Forwarded-Encrypted: i=1; AKwUvByQxX/8L/lo0wJCDb9o/HFJ9ncdTmlb0IlCYgRE0fSGpINkrBz4ddLb4dsyDjLanIO50kQEq7k57sgAXMxPtVfvQp0=@vger.kernel.org
X-Gm-Message-State: AFuF++lrr+A8QntE49FQlp7O1IPRI+iIy2xoEndpnpswLezLPycZsp/y
	UlNBISwWD+duNDwNF2iI5C/lFMcNhy7E4CNURmRRgqD1NZ09mM/jfOqC+5Op7+DPyQ==
X-Gm-Gg: AYBFou1KqTWEvFxrxi7nnNrOV/Yer7Fp3CK3ePOlcq3uZ9WIWs5D7DTJl5PP3aHR9sL
	ALqmaMb9lbfPpIhWcyAx0dXEmmR1ne5n1WwH1FPoLbDlrHV2Ylnd/dsZCNxsZfjv0tKE2KiAZHM
	3VZtsXRUtJLVKhkinMv03kz0ccN5oHRNyEHeyOm8agosPUWALpn3/gBLln1SMZYYG0728RSuwSS
	KPi2fqGSvsgZjfXh6UGqkU6DO1Nd2svOftORfIwFHY9u0rdIKYCaYeK9a7B22OFQ2DB0wRQ3kMi
	utlSSS3aCS11b+D3xJ+T1JPGarOQd14TJuRW39ftT6dwg+Xe9N9Z+2rn9gijh36LL2ev0mqqkLv
	Uei1044dRVx6gIUuOsDiHm3f55N/7HNLLt1XA4nur+i5YFgKH0VCYuZsrk79F7x0CFU3OfDfABY
	IYTO2l+spjSxUgZGueIXphyhspKtUt5CWI7IiiPbZ/qNQnVI0GWrB8AOiPBnZ2PC7HwXqqSw4c6
	AYrEsS5z0dpj9mjnCXpG7P5lvwbHDMK
X-Received: by 2002:a05:600d:8487:10b0:49c:f5bf:e8fb with SMTP id 5b1f17b1804b1-49cf5bfea1dmr25552835e9.5.1788455216326;
        Thu, 03 Sep 2026 10:06:56 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee5f912esm86009355e9.4.2026.09.03.10.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 10:06:55 -0700 (PDT)
Date: Thu, 3 Sep 2026 18:06:51 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com, kernel-team@android.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 3/4] ring-buffer: Cap static ring buffer nr_pages
Message-ID: <apmpK_QncDwqxE2B@google.com>
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

ack

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

Yeah, I wasn't sure... It's so pedantic, we have no user with a small size :-(

But that would make sense to fold that into this patch, right?

> 
> -- Steve
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
