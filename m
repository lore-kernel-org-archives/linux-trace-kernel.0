Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBC8434990
	for <linux-trace-kernel@vger.kernel.org>; Thu, 17 Sep 2026 06:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789628139; cv=none; b=Oql093HNL81Cp36ip9v2Sqx6rJCQlOn3f7FyrzFUSENbErc0XwJLFU7XoAWM6ypr6sM3iON5L+Q6YGZkV08EtCIFB1iI+eI98x9T5Ek/SEfNgkE3JiK3ZBVJoljJEQiQ7TBRkCWrtb0+f/SnrJ2s8iHsIQsvHN0pnIJFmogHTYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789628139; c=relaxed/simple;
	bh=CS2cwFdXUqiLJJhG9B82sxQOgAkaZzVT0GzQwzD3wv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iWs1HpUHjuCNgEPm03QGRHhFKbtUcRenw+chXIbozmQsQpRBkDrSrgsIAo5fmXn+Nn2TAEOUhFV9FUApDyEGZsJ+bxA25fHwml81BA4cVggi4QnzZzRW7BcUiYW4P6PXLGOnX7nidSoRZTiNgDNP3OSc9mjIUyLj0uTz+2Cq8io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DpS/eJq8; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DpS/eJq8"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cc9f581c4so1718975e9.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Sep 2026 23:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789628135; x=1790232935; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=30cUCuKfgfqmVMRq8leKktvsIG+ddt8eRO9Ay65U310=;
        b=DpS/eJq8R5txoU+RHSEOI3RxJDzcL/t1LE9cAdXUBhg5DrJj7MX1/b0uXgIobQRJAH
         zm4N7vxDBI0vaEkVXaWwPI0N++USG8+U+PQsB6DT5TG7WX6z3TBrB4WHk82A/dodgjsV
         6Kbv6HRlXlmAoRsAET+KNFOhkwUHlz7uT+UeRF4A8lLh6VmxLt+70naEBjDmZl+hZnA2
         42kFdEWnqMrLvsNowyHf8nP2vXuCMQtDdra2oToSyRNgFekGeEyhxwPSwGcCeluaqJ+o
         35cRKlJxL8MymA2YtSzvNAJI1I/aREexMr92N7CFQGz20I5nX/7TruS06jF++ax11Fnq
         vfjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789628135; x=1790232935;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=30cUCuKfgfqmVMRq8leKktvsIG+ddt8eRO9Ay65U310=;
        b=u0HOhp/pdp5V7d8QB9XztWSrTC8/bZDtJzGhMpR4NGiHc1ihcmxmuOYi+czlZLpYzI
         4+Ze422ajOroC1HZpZFik70ouuI+Aya4SsI6XjR/ZkyQAgzXoEr0oROQNnQdeKY6I+DI
         /Wdn+Cdeva9s5EMuUTznaTmd26/51NeMSHD8f23y2J2BTUyv527QlpHCD/ld3ODeVLU8
         nG1njtkbvKn/NdHBpWz8ow787LYe64imbJaK19c1TP6ZChtMerLUXJoZdkY1GvMLsV3w
         ByTnDKvYwNavhSXQ+KRW+oMEZi3coDc87XTWySt4sKHGhvERZ3sel+ZntoOiMrRqiyZB
         OZnw==
X-Forwarded-Encrypted: i=1; AKwUvBzMol7wH8LZCqSX61MFmJ291pyElAAe+r5sALWkSvOE1bLOB2znD2xNIquusIMOKQ4cTjLfw6S4h9ZhsoQ3tU5LUVo=@vger.kernel.org
X-Gm-Message-State: AFuF++m4bg+8LQ706PvtQlM8v9PIB1dVhQbKZhEC5ZcvDrJQNfauq+iT
	tZ1kxiA5EriCKF8Ef+sU80TvQsaoRe9g7YHcjwZ305Nld2FOrYR6KK+w72OHEFuYsw==
X-Gm-Gg: AYBFou0ykbPv5VuVIZOvjyXYLQFZRUmquebKEsp5RoEtOXROrYol04yXTm4sxNOUyPo
	1BgGNtmzv14dj3avKEPlUu0OZLJpzUFetLWWz5iZhElJzKgjxl5KjfC9xwpM6B75yW/dE8c3Tdz
	wTxSxyfbsqAkHKSOTaO5emwrxGioHpO/gk1YW2NTEteaCt1Hl/2xOlb1e3ozCQLMAKcQUTHDhDt
	PuUjmdOeaniBtsVO1tYl0NZNZSk8yFpxNmflrpOHQ1JDKXgT8cSh9yai2iJLBIAD2fCAyAbw/UM
	6T1iVIvi6oN370b8VhPyVwTjKz7zaV2gJcf6nVoE2uUWphz+2vaxpASQOLqGNA8zrsJLMzWMLpE
	7ioeuNPydbW/HfdRcVigJU/LH0+CbLEbix5MyZgNLI5olu34sTspxEE0ImEF2KkQSCDW4A/r+E0
	oby3dUT/z3PtJ5lbyy2VL2AVPsDK5jrAcjm0S/vEB3PeeBCP0sQW7SrZr26YOFCWAR6HUFGBL9+
	HgAQUkytEI+83PfcRge225boGtFPGk5D409ZM+eb9k=
X-Received: by 2002:a05:600c:1992:b0:49b:8f5e:51fb with SMTP id 5b1f17b1804b1-49fbd1af43dmr28764665e9.3.1789628133837;
        Wed, 16 Sep 2026 23:55:33 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd23a815sm54524765e9.14.2026.09.16.23.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 23:55:32 -0700 (PDT)
Date: Thu, 17 Sep 2026 07:55:29 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: David Carlier <devnexen@gmail.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] ring-buffer: Take cpus_read_lock() when changing the
 subbuf order
Message-ID: <aquO4fKay-7zTBRw@google.com>
References: <20260914182850.21449-1-devnexen@gmail.com>
 <20260916192628.274136-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916192628.274136-1-devnexen@gmail.com>

On Wed, Sep 16, 2026 at 08:26:28PM +0100, David Carlier wrote:
> A CPU coming online for the first time gets its per CPU buffer allocated
> by trace_rb_cpu_prepare(), which then adds it to buffer->cpumask. If that
> happens while ring_buffer_subbuf_order_set() is running, the CPU shows up
> after the allocation loop and the install loop walks it with an empty
> new_pages list, corrupting the buffer.
> 
> Take cpus_read_lock() as ring_buffer_resize() does.
> 
> Fixes: f9b94daa542a ("ring-buffer: Set new size of the ring buffer sub page")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Carlier <devnexen@gmail.com>

It is usually good practice to not link the different versions of patches
together.

Beside,

Reviewed-by: Vincent Donnefort <vdonnefort@google.com>

> ---
> 
> Notes:
>     v2:
>      - Reword the changelog: offlined CPUs stay in ->cpumask, so only a CPU
>        coming online for the first time can appear mid-flight (Vincent)
>      - Drop the comment above guard(cpus_read_lock)() (Vincent)
>     
>     v1: https://lore.kernel.org/linux-trace-kernel/20260914182850.21449-1-devnexen@gmail.com/
> 
>  kernel/trace/ring_buffer.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 04bb94c29f58..e78fb4bb2195 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -7464,6 +7464,8 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
>  	if (psize > RB_WRITE_MASK + 1)
>  		return -EINVAL;
>  
> +	guard(cpus_read_lock)();
> +
>  	/* prevent another thread from changing buffer sizes */
>  	guard(mutex)(&buffer->mutex);
>  
> -- 
> 2.55.0
> 

-- 
Vincent
