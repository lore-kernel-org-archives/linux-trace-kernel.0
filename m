Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FDD35201C
	for <linux-trace-kernel@vger.kernel.org>; Fri, 11 Sep 2026 14:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789137186; cv=none; b=C7OAema4HRA7qP6kpj0wUT4jlzAhHR4lHyqCVNUzr+M4qP+nVXuUDxP1PfoNtrpN3DXNGDAYqqwoV2ePh7gSCfVX7D+nuYUg6CtRp4xaEzc/krrAa6sqeeqb27dRB/JGqsx793zODCtEYGXIe2pL+WRP6imqsQMsL9fGpLCmaBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789137186; c=relaxed/simple;
	bh=7hko7o/H65sdidG9ua5QINwVpPh5lJ1izpv08XBoVOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C2DM5LshlScYmuUh/B/EWDq7rTR1FaRxToEhz4KCUtUP+oetkTudaa1lKsJS9hTYX10fj9JxH08VLWncNpPZ3tIWyy2VyvG6u5rh7plCIggZMYAtfqn45zzu37gDfVb5AeZ1ngvEsm4384wPjee/UZe7ypNlUnPFmiav4tbwHPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hAsXHPb+; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hAsXHPb+"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-484366874b0so533261f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 11 Sep 2026 07:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789137183; x=1789741983; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8KEhl53zkAvqFRN3fbPLduFb215GtLtUWY587bW//Dk=;
        b=hAsXHPb+PUktTLkPSxfx0e5cjZ/fkH3scHXHrcDcaqD1snxseHCXsq4sad+CDNyoJf
         cBeHRTFFz0txWHVDRisL/4ZPedTBiEl/YOeQecTZXQsRAKw+xo3i87de6gxEMjICTcdt
         rWNK4YM6ljPI4SkJpPu2OyESfHVvMYJ40jFWLEEX0c2pgoUravmTYdq6hV2am1YKHF4O
         pmHNI7KumxGDtQgUMl0oo9LiHkb4onAdfNPgheAZqxWL9albD87sml6S0EtiVDx8s4kZ
         xer+azOrTeVzQtpiYXMG+OooJ204wbcYRKBxBfMkyxTkHWx6yQmVJEZHcZ2GClL73y2A
         gKkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789137183; x=1789741983;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8KEhl53zkAvqFRN3fbPLduFb215GtLtUWY587bW//Dk=;
        b=P2wbJL3Z2jJ0PL2gi34f/zWyAneOLuQJqB+vAT5ayjHGwYAOpq8MPi/1UT7TBG2BdJ
         jMEITUIz2+VWnZK1JYUeodlh3kLUEd9iCfbVcv1vaMENl4AB0K0U15vjJyKhDQZq00Uk
         TLAutN5DxtHF797goctZvsRN6GXxnNUfgUS7QCX3U+9rFWj6QAD9i4CqznqgDDOZjQpJ
         hHypXe9B9WT91c6oC7TtKcp2jZ0EIMHcU0vrjUvIDrmJShHCWLBFeSzNI+hm02imRwLX
         qhZ/3yUEahrFAQQwuokvE+g0855hamyvHbCPY+JkT+hYbZDtXv/7lh9h2d5ADsXteXDM
         fL7w==
X-Forwarded-Encrypted: i=1; AKwUvBwhRsUYQNiR4feBZy+cciOLLpX3SSBdGyoX44SWvLGLzZDiC3i0xxB5Gdx4snZp/vnQZGs9KySNWx1FqJeMhm5LLuk=@vger.kernel.org
X-Gm-Message-State: AFuF++mrV52zae/2dwuOp0U/USI1p6WWg32iJIGrAsGO8t8NeS82HsJx
	NopFuxQDTXyrgGi4e9xg68+Eh4Y4y/1YUMHtbMd56hs/5Cil3gzR8ReM9HYBIF7HvQ==
X-Gm-Gg: AYBFou1/K0NZID4B+z3gWeQGVpjGFiHYbPIvr6pUF0PuIhMR+WP61G1LEgNv3TN+t1u
	zNBhv+cnTteMNodNHVWM46Cz0DTKhEN7OVAZIU+MF+oA5DRmelk3MgzzVlXSQttKakkf448kyD5
	Oln8cYpfoGtZ5cm3XwEb9sZulvFPMmkVV9Ay1QzNeBB6K+LLZH7QUb/TGBXBvuCtzm20RMADfW7
	aEyUwVF6t0H8K8M27ll9DujOIBJZXIVQ8rS1VnBta+pehaZb3ZSam/2pblLW0jYAo6wLBLdpS2M
	Id3WiWgQR9V1A3lRHNW+D77M8K4DgRjmCSXAJyBMj7L+2oRbGu41+iRHr1z5EzV6b1LoUAUp0Qn
	ZeqGp7ZGIGrsiW1o5ew73Df4vp4NHjy973CjppUMbI8P+rwoDXxALwO4zZxPzow4j42OOeBpB8a
	HQjsHt2fdlPinKMaqtJjZWyT9o4hxeBRyS8P7IVYIqaxd1bUAHiPZR0a56iX1J2sCY7ZGRXVvnu
	uw3SXaSXz/J+mchJgKI2WDYc0lHVJhyHcGu7jK2L6Q=
X-Received: by 2002:a05:6000:4a1e:b0:485:8542:fee3 with SMTP id ffacd0b85a97d-486eb312fb0mr11837137f8f.16.1789137182139;
        Fri, 11 Sep 2026 07:33:02 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb330bdcsm6594529f8f.13.2026.09.11.07.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 07:33:01 -0700 (PDT)
Date: Fri, 11 Sep 2026 15:32:58 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com, kernel-team@android.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] tracing/remotes: Account for ring buffer page
 header in size calculation
Message-ID: <aqQRGv26MEjjl1Br@google.com>
References: <20260907192643.42513-1-vdonnefort@google.com>
 <20260907192643.42513-2-vdonnefort@google.com>
 <20260909181316.676b8c56@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909181316.676b8c56@gandalf.local.home>

On Wed, Sep 09, 2026 at 06:13:16PM -0400, Steven Rostedt wrote:
> On Mon,  7 Sep 2026 20:26:42 +0100
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
> > trace_buffer_desc_size() and trace_remote_alloc_buffer undercount the
> > required pages because every ring buffer page contains a header
> > (BUF_PAGE_HDR_SIZE). Account for that header to ensure allocated remote
> > ring buffers aren't smaller than requested by the user.
> > 
> > While at it, ensure those functions catch nr_pages overflow.
> 
> Fixes patches should never have "while at it". That means it belongs as a
> separate patch. The only "while at it" that is acceptable is white space
> fixes or other formatting changes along with new code that is not a fix.

ack.

> 
> > 
> > Fixes: 2e67fabd8b77 ("ring-buffer: Introduce ring-buffer remotes")
> > Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> > 
> > diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
> > index afc7daa6ee7d..7a1a92f87650 100644
> > --- a/include/linux/ring_buffer.h
> > +++ b/include/linux/ring_buffer.h
> > @@ -8,6 +8,8 @@
> >  
> >  #include <uapi/linux/trace_mmap.h>
> >  
> > +#include <linux/ring_buffer_types.h>
> 
> Hmm, why is this after the uapi header? It should be part of the linux/
> headers.
> 
> > +
> >  struct trace_buffer;
> >  struct ring_buffer_iter;
> >  
> > @@ -281,9 +283,14 @@ static inline struct ring_buffer_desc *__first_ring_buffer_desc(struct trace_buf
> >  
> >  static inline size_t trace_buffer_desc_size(size_t buffer_size, unsigned int nr_cpus)
> >  {
> > -	unsigned int nr_pages = max(DIV_ROUND_UP(buffer_size, PAGE_SIZE), 2UL) + 1;
> > +	unsigned long nr_pages =
> > +		max(DIV_ROUND_UP(buffer_size, PAGE_SIZE - BUF_PAGE_HDR_SIZE), 2UL) + 1;
> 
> This is getting a little unwieldy. Let's break it up:
> 
> 	unsigned long pages_req = DIV_ROUND_UP(buffer_size, PAGE_SIZE - BUF_PAGE_HDR_SIZE);
> 	unsigned long nr_pages = max(pages_req, 2UL) + 1;
> 
> Or better yet, let's add a new helper function:
> 
> static inline unsigned long calculate_nr_pages(size_t buffer_size)
> {
> 	unsigned long req_pages = DIV_ROUND_UP(buffer_size, PAGE_SIZE - BUF_PAGE_HDR_SIZE);
> 	return max(pages_req, 2UL) + 1;
> }

I'll introduce the helper from this patch as suggested.

> 
> Then this could be simply:
> 
> 	unsigned long nr_pages = calculate_nr_pages(buffer_size);
> 
> >  	struct ring_buffer_desc *rbdesc;
> >  
> > +	/* Capped by ring_buffer_desc::nr_page_va */
> > +	if (nr_pages > UINT_MAX)
> > +		return SIZE_MAX;
> 
> Separate patch.
> 
> > +
> >  	return size_add(offsetof(struct trace_buffer_desc, __data),
> >  			size_mul(nr_cpus, struct_size(rbdesc, page_va, nr_pages)));
> >  }
> > diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
> > index 75fa1ffc4c96..2e0fdbb730b7 100644
> > --- a/kernel/trace/trace_remote.c
> > +++ b/kernel/trace/trace_remote.c
> > @@ -980,9 +980,12 @@ int trace_remote_alloc_buffer(struct trace_buffer_desc *desc, size_t desc_size,
> >  			      const struct cpumask *cpumask)
> >  {
> >  	size_t min_desc_size = trace_buffer_desc_size(buffer_size, cpumask_weight(cpumask));
> > -	unsigned int nr_pages = max(DIV_ROUND_UP(buffer_size, PAGE_SIZE), 2UL) + 1;
> >  	struct ring_buffer_desc *rb_desc;
> >  	int cpu, ret = -ENOMEM;
> > +	unsigned int nr_pages;
> > +
> 
> 
> > +	if (min_desc_size == SIZE_MAX)
> > +		return -E2BIG;
> 
> Looks like this should be a separate patch too.
> 
> >  
> >  	if (desc_size < min_desc_size)
> >  		return -EINVAL;
> > @@ -991,6 +994,7 @@ int trace_remote_alloc_buffer(struct trace_buffer_desc *desc, size_t desc_size,
> >  	desc->struct_len = min_desc_size;
> >  
> >  	rb_desc = __first_ring_buffer_desc(desc);
> > +	nr_pages = max(DIV_ROUND_UP(buffer_size, PAGE_SIZE - BUF_PAGE_HDR_SIZE), 2UL) + 1;
> 
> And here we can have;
> 
> 	nr_pages = calculate_nr_pages(buffer_size);
> 
> -- Steve
> 
> >  
> >  	for_each_cpu(cpu, cpumask) {
> >  		unsigned int id;
> 

-- 
Vincent
