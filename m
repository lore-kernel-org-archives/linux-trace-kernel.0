Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520A447F79
	for <linux-trace-kernel@vger.kernel.org>; Fri, 16 Feb 2024 16:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708101162; cv=none; b=ERm4ao7z6iWc4uqGY2JEYLBStP/mpUpSDXLAcIn36G4qP1cuxu86pJxLJ6c2c26QA0NL5165iCDkFBB0LmRtUQL2lobG3wvOYjiIC0cWycLTYSYev2n1CBpXkFLeMTooxp9z/2iD1dx+DywVHeZ5d+x+a2Em6ta/FaNW2lf7+FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708101162; c=relaxed/simple;
	bh=nbS+DWL4hB3shfwO1v5rkV0F8YJT3g5jzIQJ4pwcCuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NnmTfpylamK2jE6JSlZwv9UcnBHjNdUn1qDETFoHwT/rMPkNVPxIp7G6sJ6r0I6QHKwdNT0/TPMPFG9E+JxyclcbgmfM9VQ9GMb1BVA7qpNDFS56GA40nt3K+GA8fTrCLovOCYO33YNboVx183BrMOV3gZnHQY+KqHbaAejKvEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=b4d0IJIY; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="b4d0IJIY"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4123e958215so2368965e9.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 16 Feb 2024 08:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1708101158; x=1708705958; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SgQeh6gny5JrINPGAEJwqjErNXlFS7uJm/gN6H25Wl4=;
        b=b4d0IJIY1V5SNnB4q1eHpb6d0DnFgLeUnH/UW++qfDunEVC3jUWYGX1jvzYRt8Gy2b
         W3ZVFrMne6tBPNJw+gMD3dL01pPcyZq8DijwoTt11K5F8/VPpirLx/FsOuwfbpkBalDJ
         wBMWts03hSMBZy4dmncjS3XpRESUSaBXz8wWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708101158; x=1708705958;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SgQeh6gny5JrINPGAEJwqjErNXlFS7uJm/gN6H25Wl4=;
        b=wRRFLpXNQyO9BcQ5XOpy31FV4WqjsV0GHDdGNYrjfFN71WkX8sI9BMviJVWV8IezSr
         QPPu9COyjYAj9+MiUKPHox8INzUdSGwusrrgsDthaEATZQmfL2YzpmJ1cxSFq6Ci2fJq
         2C/owrIhzeSAljxV0D3LF527rT9ybhifI9kIZBWN9NPLYnd80gA1RxMnd4uenSLWJWlr
         9XyA9UqNUwwVVqnhiYBApRh85fg8shAz3QDIOv3tSV2U9cx9B2MM2FNPIJYXM7U5FHmj
         Z6f36gJUXiXqr4QZznL51M3zGf3ZKC7MLBKYdhnVV3R1gLrz7NYHJ4fd18Sv85mDi2W4
         dKbA==
X-Forwarded-Encrypted: i=1; AJvYcCWoa8CkZZuBK6RIhPAUOTKolgkCJ9qr+OAQI9rnBiOjitIS1Savoz33t4XE9q/F4+5OqKEjKe8AayxcvKQ6RCIvCdf86h9L1CXgHXF5PcDvdoG8
X-Gm-Message-State: AOJu0Yyf3BflI0e8D5k16cOgp7rHt6VQob7ffak7oMoS7ShhYA7JII1t
	SUlpOdzz+nHop/Jq+W94rMzZlIW6aE/H5g86diKxDvyYhZUybRMXoz9rg/PGmuw=
X-Google-Smtp-Source: AGHT+IFE0jwLawnXRHSScGe2ockTGkEpG5gU+Fwm8RLqeKicUfmzpG/tRRmoFIyQP2z5PdY038vGLA==
X-Received: by 2002:a05:600c:510a:b0:411:de28:bb52 with SMTP id o10-20020a05600c510a00b00411de28bb52mr3914738wms.4.1708101158500;
        Fri, 16 Feb 2024 08:32:38 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id j6-20020a05600c190600b00411d0b58056sm2932741wmq.5.2024.02.16.08.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 08:32:38 -0800 (PST)
Date: Fri, 16 Feb 2024 17:32:36 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Alex Deucher <alexander.deucher@amd.com>,
	amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH v2 1/6] tracing, dma-buf: add a trace_dma_fence_sync_to
 event
Message-ID: <Zc-OJAXlApzcOfYQ@phenom.ffwll.local>
References: <20240117184329.479554-1-pierre-eric.pelloux-prayer@amd.com>
 <20240213155112.156537-1-pierre-eric.pelloux-prayer@amd.com>
 <20240213155112.156537-2-pierre-eric.pelloux-prayer@amd.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213155112.156537-2-pierre-eric.pelloux-prayer@amd.com>
X-Operating-System: Linux phenom 6.6.11-amd64 

On Tue, Feb 13, 2024 at 04:50:26PM +0100, Pierre-Eric Pelloux-Prayer wrote:
> This new event can be used to trace where a given dma_fence is added
> as a dependency of some other work.

How?

What I'd expected here is that you add a dependency chain from one fence
to another, but this only has one fence. How do you figure out what's the
next dma_fence that will stall on this dependency? Like in the gpu
scheduler we do know what will be the fence that userspace gets back, so
we can make that connection. And same for the atomic code (although you
don't wire that up at all).

I'm very confused on how this works and rather worried it's a brittle
amdgpu-only solution ...
-Sima

> I plan to use it in amdgpu.
> 
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> ---
>  drivers/dma-buf/dma-fence.c      |  1 +
>  include/trace/events/dma_fence.h | 34 ++++++++++++++++++++++++++++++++
>  2 files changed, 35 insertions(+)
> 
> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
> index e0fd99e61a2d..671a499a5ccd 100644
> --- a/drivers/dma-buf/dma-fence.c
> +++ b/drivers/dma-buf/dma-fence.c
> @@ -23,6 +23,7 @@
>  EXPORT_TRACEPOINT_SYMBOL(dma_fence_emit);
>  EXPORT_TRACEPOINT_SYMBOL(dma_fence_enable_signal);
>  EXPORT_TRACEPOINT_SYMBOL(dma_fence_signaled);
> +EXPORT_TRACEPOINT_SYMBOL(dma_fence_sync_to);
>  
>  static DEFINE_SPINLOCK(dma_fence_stub_lock);
>  static struct dma_fence dma_fence_stub;
> diff --git a/include/trace/events/dma_fence.h b/include/trace/events/dma_fence.h
> index 3963e79ca7b4..9b3875f7aa79 100644
> --- a/include/trace/events/dma_fence.h
> +++ b/include/trace/events/dma_fence.h
> @@ -83,6 +83,40 @@ DEFINE_EVENT(dma_fence, dma_fence_wait_end,
>  	TP_ARGS(fence)
>  );
>  
> +DECLARE_EVENT_CLASS(dma_fence_from,
> +
> +	TP_PROTO(struct dma_fence *fence, const char *reason),
> +
> +	TP_ARGS(fence, reason),
> +
> +	TP_STRUCT__entry(
> +		__string(driver, fence->ops->get_driver_name(fence))
> +		__string(timeline, fence->ops->get_timeline_name(fence))
> +		__field(unsigned int, context)
> +		__field(unsigned int, seqno)
> +		__string(reason, reason)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(driver, fence->ops->get_driver_name(fence));
> +		__assign_str(timeline, fence->ops->get_timeline_name(fence));
> +		__entry->context = fence->context;
> +		__entry->seqno = fence->seqno;
> +		__assign_str(reason, reason);
> +	),
> +
> +	TP_printk("driver=%s timeline=%s context=%u seqno=%u reason=%s",
> +		  __get_str(driver), __get_str(timeline), __entry->context,
> +		  __entry->seqno, __get_str(reason))
> +);
> +
> +DEFINE_EVENT(dma_fence_from, dma_fence_sync_to,
> +
> +	TP_PROTO(struct dma_fence *fence, const char *reason),
> +
> +	TP_ARGS(fence, reason)
> +);
> +
>  #endif /*  _TRACE_DMA_FENCE_H */
>  
>  /* This part must be outside protection */
> -- 
> 2.40.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
