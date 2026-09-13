Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54852374A02
	for <linux-trace-kernel@vger.kernel.org>; Sun, 13 Sep 2026 20:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789332082; cv=none; b=olEclmlsfKLrW7m35aDzBmxWJjJXI5HUtl5vgjCuj32/rihM4MLl+zBX4V/j/AqKN6EwRbOd4oZPZukQJKI5OSYu+Fih6fiG6yoQnpu1DCxRsk7qmHKp93NOsQsTj7A2Bc7A3JDd7nxU+HiEu1qH5v7SKtjAK2Jv07vG08otyRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789332082; c=relaxed/simple;
	bh=C5DsJkXIJoZlAT7IjZCC8I/UwHv4oDRaj3MSbn6+mgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jjHn2MeLNZTQA+hpT9PDSXjN5yvo9fAyhpE2LvV0+Omzw2ZPLM4kiXZQngfbYamQoVs0lZuXoftvPRt+JFX0Ajk9WercseDvXQuO7UMPjxp31v6/2iEv4ZYvsHwaZsi84k2xDzPRnsggLHLt6Nuo736YyHtXtJ/8qnEN/ZygtQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jsOv9Cud; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jsOv9Cud"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843378fb37so542602f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Sun, 13 Sep 2026 13:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789332078; x=1789936878; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=R6YGWhzsvFbV+PYiTdLNQJwYPXDHjuNqpkT5NJtjU/o=;
        b=jsOv9CudMOlRXkR4JjxnGu+OLi3A3Msfo0S51B8gssBl7FYemkqXvbUIgWCj0cWNXz
         gAa6GvzFWJGGxUbOIL/M9ieKZWaPjr1lzC8A93iQjGZ6l2T3n7jsKnhFqGR2KYAfXJrK
         Gj0JXt3SkzQRvQTL27LrRDQ3QWEk8Jo848FWAzoCssR8+RM4Q++azIkpxFKr37aPurkP
         QYP0l9euwK0uQKdAe4cr3NJn3I7gXAM1hIC7uYSkadxsw0/I7W4H93NzKriAYjRzWYdC
         nicdY96yxGeEM81j65CpN8XmA3vsQFtVIsF+A+teAStU7E6mitnGpG206xgBGkHunZGe
         f93Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789332078; x=1789936878;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R6YGWhzsvFbV+PYiTdLNQJwYPXDHjuNqpkT5NJtjU/o=;
        b=ojomlBtNc7a402EeaCauSUvJv3y9gRcQ9i9dxHLR2HCge+L7svCq+A66E0fnHPjPIv
         VT/iSSR8nuVT3XWeKImbqtbkzorgLU0d4nInXk5rdW8sQO+FsVRcRXniRk0h/EPuZU7Q
         lY3kasSuzUt0ZB3F9uUfL3N1/D+Q9Ldbw4+qEdwwMG8jOeozbhwiSEWen/Quw7q3Pi+x
         z5mEfATUjy1QarE+wiAgHtcFPaRA7rgH6CiKZg1Pv21LbG3OxPtYNpyEFWnk68SAE936
         pt03AkHSJX7Ebsjkfsl33Mys6x84tJN2/IVs0HW/tOjiO87ltOdxETAWmXxEWM9/d8Xt
         Qvqw==
X-Forwarded-Encrypted: i=1; AKwUvByhWmQ3fDmoxyk6fIZ//dxwUQE5UqOj3AHG1XJk6R7qm0JzrIBuH8OWkHTeEZcAU8EtoLo4hPwaDgCvYTADUaEuBds=@vger.kernel.org
X-Gm-Message-State: AFuF++mq2MS9lQSdEQopSB+pyXnvX9EfhT+MpBe1sd2dj56Z9OgcDpZN
	g4j7qMtq5FO7iU0UvYH7dlExvumfdstuyO7tnPuQxr3NUZbsoIaYb8nJOW3YQ53TJQ==
X-Gm-Gg: AYBFou1oOVU+pKuB5c5vsQIIe9uzG6ZGSa1elGReG75yxb2N8Vk3JAcxbh31uX6/FQS
	e3ZVZROxD+Ko66AIAMQi7AFjGHO/4p7BNgi+FZBaPz3eGdcZ4ktR/PwLkbdtTZHggkeSeidLIPa
	KH+NWKQobFWyJkgvEiVB7dr2DmYzgQ/sTLPhP/KNfmII/+N1C+mgMVWVs9RM/c5lRDWgmzPBzjq
	f+iVjXYrhWWe9DrScsC4pLHhv/3+KscaVl85z1du5unUl0hixVVqv8JrmVT1iCK5o8BRD+Kpbic
	y6ocOf0g+4OCYGUxv/uOmUbHQ6GZyZNEYFB0/a1zEvsCyxkFqCT93XrLEronG4DHHC7Meagjo6Y
	RpZzsQ55SF0PwlVrIwV4rtjGH7aqDOjR/g3T86k3TQxu1WbVHFmPI8TZ+DLMlfzF6EOtEB5ZerN
	mK0/DVSF9fV22+j3K21KWS9edr7zLHPIuaEn9Rs6j68wK5TMijjj8WoVag+/tRmo33l7mJPREBF
	xE/xgTaMq3xMHc2Tc7NFYuJJc9XPzHqMBT7KK3M1cA=
X-Received: by 2002:a05:6000:2082:b0:484:3f15:15f2 with SMTP id ffacd0b85a97d-486f6c17cdbmr7177342f8f.24.1789332078141;
        Sun, 13 Sep 2026 13:41:18 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb34f1f7sm21666477f8f.24.2026.09.13.13.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 13:41:17 -0700 (PDT)
Date: Sun, 13 Sep 2026 21:41:14 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: David Carlier <devnexen@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ring-buffer: Check resize_disabled before publishing the
 new subbuf order
Message-ID: <aqcKav91XJsCLxPJ@google.com>
References: <20260912103938.1127021-1-devnexen@gmail.com>
 <aqcJq1-R-LaK9uBi@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqcJq1-R-LaK9uBi@google.com>

On Sun, Sep 13, 2026 at 09:38:03PM +0100, Vincent Donnefort wrote:
> On Sat, Sep 12, 2026 at 11:39:38AM +0100, David Carlier wrote:
> > ring_buffer_subbuf_order_set() stores the new order and only then walks
> > the CPUs, returning -EBUSY if any of them has resizing disabled. A user
> > mapped buffer has resizing disabled, and __rb_map_vma() reads
> > buffer->subbuf_order without buffer->mutex, so an mmap of an already
> > mapped CPU racing the failing order change sizes the mapping with the
> > new order and inserts pages past the sub-buffer into the VMA.
> > 
> > Check the CPUs before storing the new order.
> > 
> > Fixes: 117c39200d9d ("ring-buffer: Introducing ring-buffer mapping functions")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: David Carlier <devnexen@gmail.com>
> > ---
> >  kernel/trace/ring_buffer.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > index 9c03a555a6ba..d7e5e4620d09 100644
> > --- a/kernel/trace/ring_buffer.c
> > +++ b/kernel/trace/ring_buffer.c
> > @@ -7474,6 +7474,14 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
> >  
> >  	old_capacity = rb_subbuf_capacity(buffer);
> >  
> > +	/* The mmap fast path reads subbuf_order without buffer->mutex. */
> > +	for_each_buffer_cpu(buffer, cpu) {
> > +		if (!cpumask_test_cpu(cpu, buffer->cpumask))
> > +			continue;
> > +		if (atomic_read(&buffer->buffers[cpu]->resize_disabled))
> > +			return -EBUSY;
> > +	}
> > +
> >  	atomic_inc(&buffer->record_disabled);
> >  
> >  	/* Make sure all commits have finished */
> > -- 
> > 2.55.0
> >
> 
> I do not think this is correct.
> 
> __rb_map_vma() reads subbuf_order without the the buffer lock __only__ if it is
> already ->user_mapped, which means it has already the resized disabled.
> 
> During the first setup, it takes buffer->mutex.
> 
> -- 
> Vincent

Ha my bad, that function also modifies the subbuf_order __before__ checking the
resize_disabled.

Could we also clean the later resize_disabled check in the following loop?

-- 
Vincent
