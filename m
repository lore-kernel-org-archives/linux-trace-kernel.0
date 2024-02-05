Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD516135A6C
	for <linux-trace-kernel@vger.kernel.org>; Mon,  5 Feb 2024 20:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707165487; cv=none; b=KF08Wvt70mK/7Ur3g/XJzFi9vygY2JiK3P3EblKmcg1/LN6dbS2xkpAJqHn6FhRaO61ocXhJo+X3nB+6MrEAlXON1fbDIz06X/V/ODSC8j0z678TAUcJ4wTXox6kaBKsi5UCcVcrwNe+aqFhYWAFouesMw6WqP2fxStLIPw4YnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707165487; c=relaxed/simple;
	bh=FkaCPPY+yFxG1dBqRLvK4B5HaNh0fUzHJekCjedzjhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iPHfKHTs+OJOe+LMcv2KJp0xEmudP7Uj5ydUF1NXs8WDKwhJcerdgkOWh810nrk+dsi6+c/RqVwghRq4eQfbLXrANdSY6q7xu4jKsUUTgH25V7O3USF3fMk8T4fJt6xGgsjVoZkBLb3LX3rTNpYAVeXPIveR4JaPrRhmjXotL0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VRGTl9qW; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VRGTl9qW"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40fdf2b69b2so3165735e9.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 05 Feb 2024 12:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707165484; x=1707770284; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LCIET90ETC7SgPWApGZWClXqn8NAi7LR1Ka+mUuA/6g=;
        b=VRGTl9qWyqqXaOHXMnWLvCnv5ZeJrMH0yJJ4MPcr9LoZoxqq81v0zvpv1J1LxcdmPz
         yjJeQFL2tsBbUfpx5XWj/XYaAsK64Jp3wGN8DUy1edWju9ZVrmkEmI3LiVwhVoU4DS5T
         RTw7BGI5APbxcOwP4eL322gAgjJM1KNKW5Nh5WmNHJGoM5TrIgw3sXd9hujG+/bqTtfg
         kIZY36P7bxk+P3PNSYb8EDOIorWwaYeuZHUqUQcLJJ51X1qcRtMwkbN/ljVCoWfy2Q28
         a+NRYW7uW9pJ4wk27r3w+fCSrf1NTZ4QBjW462NiMlyWJNxTIT0eAZYLmfp4WGp4ZLrU
         lO4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707165484; x=1707770284;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LCIET90ETC7SgPWApGZWClXqn8NAi7LR1Ka+mUuA/6g=;
        b=sXrMB+nVlHKcyGURhwfu75Q1SgmzFeBBBO5k/m0P/tZ+n2zOs9732WrLeNcsD01oQ5
         RhA5Cw4FP+5BUhkM6KCTGaUjZ9Uc8+5QeE3RMBoQbWJy8uqXXUP5xryKLzpmZnLDCWzE
         NSJ8sR0P4VioLlMJuhM7ApqOgsny/yfl0wp/HyOw144t7MYKPG2M8K1ekra6mV5VyVhB
         fux85HfHit35sOxVoxyPDiBzhiqpGIbadNmq8zvon9PwpdRkvG9XyFayQ2gslfex2OZv
         +pzhvKZlu/rLQY1csI07l3kAwh72Vq9Bkwn0Z9G4R1AhbwJmF6veFzqGYJqOl1VK/U+y
         t2Sw==
X-Gm-Message-State: AOJu0YxYGRB8dYqugxQhRwLGaxCAbktwhcotwvk0cPMC+KgrNekICKSY
	3Wh09zr7kSYTnaLatIQXsxjq0XRvY9Uuxm1c6tOOkXeNIPRxmRri4z80DgB93w==
X-Google-Smtp-Source: AGHT+IFXgAFv0t6Z5BJcW0zDTPKXQm9HGkpvxeQ9RnxL+RNpdvDhKG13rqujDxVjoItwx8eBE6TQfA==
X-Received: by 2002:a05:600c:3b19:b0:40e:45c0:ad64 with SMTP id m25-20020a05600c3b1900b0040e45c0ad64mr617796wms.14.1707165483954;
        Mon, 05 Feb 2024 12:38:03 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXuK7G1136CvcXV0SqbJwlIu89EagR7Yxa7m5sGBZRqm3853j8fWkDafNa9dduwIyQ/2TQjcpb2SOAzeC3nUSWSrSR+Ljq1yPXn0rAEPrIW14hG3SDv6aVjLidt81gBpfuNnu9pzrQyoKejUk1itDCj57iKlj3KEkdPUILZp1cqg5xRJ52/EUKQdill52JxFOS25AUydi2vQLv9FrqmvA==
Received: from google.com (185.83.140.34.bc.googleusercontent.com. [34.140.83.185])
        by smtp.gmail.com with ESMTPSA id h16-20020a05600c315000b0040fde4451e2sm2192988wmo.0.2024.02.05.12.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 12:38:03 -0800 (PST)
Date: Mon, 5 Feb 2024 20:37:59 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v14 4/6] tracing: Allow user-space mapping of the
 ring-buffer
Message-ID: <ZcFHJ75PzEUvIyaf@google.com>
References: <20240205163410.2296552-1-vdonnefort@google.com>
 <20240205163410.2296552-5-vdonnefort@google.com>
 <3c16bee0-70b7-420f-a085-c9e09e293fe2@efficios.com>
 <ZcEqLmyi3fEMOSIl@google.com>
 <d1aa52b9-d2a5-4315-b39d-d2784cece3f4@efficios.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1aa52b9-d2a5-4315-b39d-d2784cece3f4@efficios.com>

On Mon, Feb 05, 2024 at 01:44:47PM -0500, Mathieu Desnoyers wrote:
> On 2024-02-05 13:34, Vincent Donnefort wrote:
> > On Mon, Feb 05, 2024 at 11:55:08AM -0500, Mathieu Desnoyers wrote:
> [...]
> 
> > > 
> > > How are the kernel linear mapping and the userspace mapping made coherent
> > > on architectures with virtually aliasing data caches ?
> > > 
> > > Ref. https://lore.kernel.org/lkml/20240202210019.88022-1-mathieu.desnoyers@efficios.com/T/#t
> > 
> > Hi Mathieu,
> > 
> > Thanks for the pointer.
> > 
> > We are in the exact same problem as DAX. We do modify the data through the
> > kernel linear mapping while user-space can read it through its own. I should
> > probably return an error when used with any of the arch ARM || SPARC || MIPS,
> > until cpu_dcache_is_aliasing() introduces a fine-grain differentiation.
> 
> You might want to use LTTng's ring buffer approach instead. See
> 
> https://github.com/lttng/lttng-modules/blob/master/src/lib/ringbuffer/ring_buffer_frontend.c#L1202
> 
> lib_ring_buffer_flush_read_subbuf_dcache()

Thanks!

> 
> Basically, whenever user-space grabs a sub-buffer for reading (through
> lttng-modules's LTTNG_KERNEL_ABI_RING_BUFFER_GET_SUBBUF ioctl), lttng
> calls flush_dcache_page() on all pages of this subbuffer (I should
> really change this for a call to flush_dcache_folio() which would be
> more efficient).
> 
> Note that doing this is not very efficient on architectures which have
> coherent data caches and incoherent dcache vs icache: in that case,
> we issue the flush_dcache_page uselessly. I plan on using the new
> cpu_dcache_is_aliasing() check once/if it makes it way upstream to
> remove those useless flushes on architectures which define
> ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE, but do not virtually alias the
> data cache.

I believe the aim is to use the mapping by default in libtracefs and fallback to
splice whenever not available...  But for those arch, I guess that might be a
mistake. Wonder if then it isn't just better to return ENOTSUPP?

> 
> The equivalent of LTTng's "get subbuf" operation would be
> the new TRACE_MMAP_IOCTL_GET_READER ioctl in ftrace AFAIU.

That is correct!

> 
> Thanks,
> 
> Mathieu
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
> 
