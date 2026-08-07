Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972C1153BE9
	for <linux-trace-kernel@vger.kernel.org>; Fri,  7 Aug 2026 09:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786095800; cv=none; b=EhqKLmjdbZhAcOkITAek1WvvzBmhk+mDAifdApHHe1Fg4Fs151VUaYEODzuW4O7YYVhBLvwfek6OZVv5vxjaAuvERDnP8NHdxXowjU9Q0BcQF5/aZEexqxcRhh1z/qC6l6xoeoOa7NhSSpKxF+JpdZmotmB1l9T9JYBZgjY+MD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786095800; c=relaxed/simple;
	bh=j2eOaWnvU2KJhWx8NMfzCfYofi5p7LfuzO4wpDMwkK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aVjQAHdzAxwRdmgz3o2hcld3Uz2QUAyjUYQT0F5x6ailKYG+ViQocOu9aWr9kYJxlUY/k/fvjenfBqPSLzShX4mjrwIAQ0ygF6m91HSIXOxB+1+v6nbxT3x681beftPwZ9q79xW5y+u2tySzMEirl4yAvkB9GH8X3ZpHSIClpJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dF4FahK5; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dF4FahK5"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c1677c91969so374187166b.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 07 Aug 2026 02:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786095797; x=1786700597; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HbE2bwnVMi7D8tqiB/gbTbPGphKHmCKr06HT/XDSX9o=;
        b=dF4FahK5v6IvxnK5kR+TXDjUw5DyqYT4URFNoLKZPY0Jq8WtpU2qcPdIivXHvciFc1
         uQJky6Ygmpq1WFwLfdQJ5XWSjJCi4lKQAb6qYxFGtuu5XuPJV136hvpIK2HoKE6yEBDi
         bPkkT1w0HNVsNqI2knJX2dO1mNdGv8IHQ/WyhE36xUI3GqYv4rmdLNJj1Zr7jmB8A8BZ
         glaWYnlFKqzrrp/UaYbokx4M4tjWZTjYj4BieSGKnYguzPGA/QpUtWHMulZ18KmqqJu3
         45Wl4HBgEy2t8z/YFhAvqvXhhd/Y6PYfBy8lvdabwP3esGm807XKH38NjBFWcye+ED5B
         PWMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786095797; x=1786700597;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HbE2bwnVMi7D8tqiB/gbTbPGphKHmCKr06HT/XDSX9o=;
        b=T3sHBYXqx44oBNApUuccl/UlgWIzWkFzfn6puyNRPws1Th1SK510jz5C2hZno+xJx2
         HXp8VVZHFJ7gH85kKHYiwP+8ScPVgE3nYl/Xe6UZErCHyU45WU8f4dBpkGHjpjgrbe1g
         EUwOUwWnM/1ByTFvB+YI3fMqCHB4/1MrkYZu95wgrZZAQYbsI16kWKwtefjDTZwdV9gk
         AdEuQM3n9B0fn0j4sj88VSqdYC6xM97grUycpDUg2u0/d3rOyU1AfrLbjtsU9yfFiTN0
         6lNJC2rqie+5FF5nLDE4qkQ3OM8GhCXQOP7vv42LLnz0xy4mhZKp+6722dv1LLLHtaAD
         2qKA==
X-Forwarded-Encrypted: i=1; AHgh+RrSCyG5DnaHVL07HutWY8apdjBAWLXgD5tZwx093tGaewrdM+/vjLDO8XEDPOQYXu/Jei3mgA1/RRgIWWYwkqvq3fw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTmi/tTsLu5kVBI04mDOFxcU/yGagGY+8ODLK12QvS8oda27pd
	0oqRqU1NnpYKDKPHzBV0rlT0wdUn1Az9JtgchCneRq9bK3mapztIGFwz9SnMUYkwqA==
X-Gm-Gg: AR+sD13ddvQ/idNiH3NREAsKVFSjvHqt77/WOl40WQRbzI0tPk1NvDTRrUrRNSTYFIQ
	Vy1e3rDuMO/N6ZT74YydNcGOy7cHqLGu6OpRXNpvD4XSEsdvXHvOFyVssEU2igfdAGuC+reV5r8
	sAmxUqjnHAJEuzWJZst4zqKyr3dzUEH3cQa3J6t+xl7x3cXpcMaXwGPit3bOhl3mh1PDE6B9Ein
	PUcmJrK0d1lPoGG2opMf8cB/gdCJUnm55HjyF18DOtgeZweKC/mPsr6bAOD30DHaBwOKKRjQ5bw
	yGDRnEQqCp9720dHnGoS6j0OtOkaF057wEyROfd35Q4+aM8AfswJvCJEV697VdUyVTlFzj28Ktg
	XhxotKBetsTe+wmvetp7MW7/VzH3HEyaAOhPY+C7bc1SVZXmP88gQP0Vn/wCg9qXTkVLof0bGQ7
	g5UqV4KAGm7lAmrDFMnVEukthV04ywX3NAEOQAbf2TUCkLqGybC8PycHs92UnEBeIbWoD+8Ey6Q
	IVoFeGP/9yf20sIF4ucwSpv/X/2zXFb
X-Received: by 2002:a17:907:72d5:b0:c16:16b9:98fa with SMTP id a640c23a62f3a-c2039afa743mr957100566b.5.1786095796229;
        Fri, 07 Aug 2026 02:43:16 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2080a6e657sm33479666b.14.2026.08.07.02.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 02:43:15 -0700 (PDT)
Date: Fri, 7 Aug 2026 10:43:12 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com, kernel-team@android.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] ring-buffer: Prevent resizing of persistent ring
 buffer
Message-ID: <anWosNi-U8lVqBZP@google.com>
References: <20260806211306.3704194-1-vdonnefort@google.com>
 <20260806211306.3704194-2-vdonnefort@google.com>
 <20260807111808.d5dc1a48b080d241100f4a57@kernel.org>
 <anWT4heM5Z--A1Mo@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anWT4heM5Z--A1Mo@google.com>

On Fri, Aug 07, 2026 at 09:14:26AM +0100, Vincent Donnefort wrote:
> On Fri, Aug 07, 2026 at 11:18:08AM +0900, Masami Hiramatsu wrote:
> > On Thu,  6 Aug 2026 22:13:01 +0100
> > Vincent Donnefort <vdonnefort@google.com> wrote:
> > 
> > > Dynamically resizing a persistent ring buffer is not possible. Disable
> > > the feature.
> > 
> > Is it true? Of course there is meaningless to resize the persistent
> > ring buffer (because it makes the buffer none-persistent), we are currently
> > allows user to resize it (like for resizing unused persistent ring buffer)
> 
> __rb_allocate_pages() in ring_buffer_resize() would call for a persistent buffer
> rb_range_buffer(), which IIUC, is just reusing the same ring buffer pages as the
> one already in the persistent buffer.

I have just tried and if reducing the size works, increasing fails in both
rb_set_head_page() and rb_insert_pages() with a warning, which I believe is
expected.

We could improve that, but it feels like it is a lot of work for a meaningless
feature which we should just disable?

-- 
Vincent

> 
> So, reducing the size would surely work, however increasing it, would most
> likely mean having buffer_page pointing to the same buffer_data_page?
> 
> Also, the comment
> 
>   /* 
>    * Range mapped buffers have the same restrictions as memory
>    * mapped ones do.
>    */
> 
> Made me think that resize_disabled was omitted.
> 
> > 
> > Thank you,
> > 
> > > 
> > > Fixes: be68d63a139b ("ring-buffer: Add ring_buffer_alloc_range()")
> > > Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> > > 
> > > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > > index 8e2485bb3aa8..afe75ad2bbf2 100644
> > > --- a/kernel/trace/ring_buffer.c
> > > +++ b/kernel/trace/ring_buffer.c
> > > @@ -2528,6 +2528,8 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
> > >  		if (cpu_buffer->ring_meta->head_buffer)
> > >  			rb_meta_buffer_update(cpu_buffer, bpage);
> > >  		bpage->range = 1;
> > > +
> > > +		atomic_inc(&cpu_buffer->resize_disabled);
> > >  	} else if (buffer->remote) {
> > >  		struct ring_buffer_desc *desc = ring_buffer_desc(buffer->remote->desc, cpu);
> > >  
> > > -- 
> > > 2.55.0.654.g21b8a5bc05-goog
> > > 
> > 
> > 
> > -- 
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> -- 
> Vincent

