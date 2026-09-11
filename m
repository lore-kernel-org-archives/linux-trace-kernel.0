Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3B83B38AF
	for <linux-trace-kernel@vger.kernel.org>; Fri, 11 Sep 2026 17:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789147386; cv=none; b=N0lbf9O3d5SpvW2HDmG+uqrAhsXTmT6OPosqGPfDmvOSgAY0a75tkM98qTbweMHHsA1BxXHgErQnYpdqBlEKlwRpSeXc5V5LNtUpNKjy2so4logCtMmcGX1Z2fZurbQK3iOkpDlC3TWU7rb/htd5aqisXDX78BI17W6JfAEpGMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789147386; c=relaxed/simple;
	bh=qIYU1MO0sijHfVdNSQ+Hm4R8rpjO/e9JudMeQRnZ9Q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sGO7d5FlXPJcL+p24DvFRdhSEf+vbVsHaVvknNHYy/GaOzI4oHH24k7rmhri3CuueuzQVnmvl9ZSvLWON7Mnwi8v4ha8HrqruhHeyIDWv8wAvjw/BsGjbSIxCDfSby0YfKq6OR86QsF305OL73AkhD/1ndWB8S9WToThwUkRi+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IlpRSs0Y; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IlpRSs0Y"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49cca4ffdcfso10028555e9.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 11 Sep 2026 10:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789147383; x=1789752183; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xQGFbAKMzrECW+70hXJrrw/HwpzyGAxZIlkWvSuSMU0=;
        b=IlpRSs0YXO7KYPxYHsiL2va+0N8VtEmucgi60EDw96Z37mq2xNZFwdoDQueHTKUtBg
         gUkW+M74FFmNcoFWEi2EDnXmyWItWHdk/UFzicu4O3H6AhCQu+op3LRaRR/NqY9T7YF3
         jl7I7R8l+Mv39qUoq+1KBwoUs7+l/CD0x91DC7y0s5BvjBEQwoqrbegVnnZdmkZ2DnhW
         cbUyBdS5zMtfCQpGHadTJ5WYyF0r+mRNdCAXyyUBeJ5POeWUH737eoHRKpzfvKnXGryW
         HBB4aU3gVuR4NsmQM56XwQmI5wxUjVnwb0MFOo7F3+X40hXYZeDMhTrPYJ7E5c25i5Td
         7tcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789147383; x=1789752183;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xQGFbAKMzrECW+70hXJrrw/HwpzyGAxZIlkWvSuSMU0=;
        b=YhNpM52MrG1r+S+K4fdMWCLP/4lDKTf5ZZAOejU4eWmuVUFee7eNvUw498zL1aGmip
         sH5ZMTNkYPbX+ZCUFJsYDoXATM4VKgApWgW3k6m8FgHMHkx9ezdPfI3spWJTpRKflbwM
         wL/W5ojIB7j5BZ3Gh/EvidOQxv6SDlgzZ3vwbqMC5drVMR8BRQfbk7x1k4ResdcUkSrY
         Dtk/ntgDkgPwKtNl26NltFFCwImJOy5RsPyL1iChwJIz/42buktPCVe6oHPCtfd1Fudy
         /VUSOWJJjlXz4OZvUu6I+EObKEMBx4ucS+TCKsJDyOQ2j9IRnMvSeuCVPvPHLtmDsTZV
         vlhg==
X-Forwarded-Encrypted: i=1; AKwUvBw2GDT9eKjmGwmjACKgCqR9h4PkQl4Sk9Rcn+5SfQmNStP66rHJdFnXH4IM01hQvcy5c+r4tRUr191siJd/kOtZuTo=@vger.kernel.org
X-Gm-Message-State: AFuF++njWhgLmIJ/Es8O+t0uJ3c0z5pshupjy0MTbFw0w2MwBWLSS4N9
	rfi3QFFS7B45vAoeHtqG9JI57rzJ58H0UDmCziEpU3DcCx6YH8JlZHqvgE35WNAtWw==
X-Gm-Gg: AYBFou12lpXPEKFLA8k8TxNEEBAPV28F3xuFspPZe84DrQjWDG502J0liuCLfTCJ2mo
	vTUtqg6aSTDLRH75U836sjptv9Qrh7WrztzQcwR8TXmjOUFSBqB07S8sN/3tzYMzfI9CbfTEiRj
	hcUyblkA3YbWGFqQgkVxbhbF5VaLM812uTcRdai9cSPuCxnEslWgOUXdBBMH+JrmZMFyrOykOtP
	BexAx1DqqV3z7HCndetbYlQIL56AoQhSOGhEbYEKISeucj2MyQeET+WBHP0008Qj8pafFWya9j5
	mm7A7bVYUUZwzWyGUZAsnuAwLGf8IhOMcS/bL1v2eOXAqbZRAW5JFdYFkD/VMSLxC+9jeP7iffY
	5OlmTFT7TRFr2aO5pxhvY674BIAXPqsc5NNAczKXbgARr3Yjb1RLo8tf4aXfEfv8ud++ob2odyD
	VXfIL2JwefK3Pn8s/rq52adF3hlYS2cKxizj5AmVLwQ++y+1L283M2VZU3eT1/lBry1zLT/bV9d
	NWtSfjCiDi4IjFYHAQBV33BTLzkIwrgodkAAvoFeOXRBunXbRyUPQ==
X-Received: by 2002:a05:600c:4687:b0:49d:2625:1b0f with SMTP id 5b1f17b1804b1-49e619e7090mr62693815e9.31.1789147382199;
        Fri, 11 Sep 2026 10:23:02 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26be3e0asm184389015e9.1.2026.09.11.10.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 10:23:01 -0700 (PDT)
Date: Fri, 11 Sep 2026 18:22:58 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Xiang Gao <gxxa03070307@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lorenzo Stoakes <ljs@kernel.org>, gao xu <gaoxu2@honor.com>,
	yinchuang1@xiaomi.com, linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Xiang Gao <gaoxiang17@xiaomi.com>
Subject: Re: [PATCH 0/2] tracing: add ring-buffer memory usage statistics
Message-ID: <aqQ48rGDhQka916N@google.com>
References: <20260905112732.3705405-1-gaoxiang17@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260905112732.3705405-1-gaoxiang17@xiaomi.com>

On Sat, Sep 05, 2026 at 07:27:30PM +0800, Xiang Gao wrote:
> Report the memory consumed by the tracing ring buffers, rather than the
> usable data capacity exposed by buffer_size_kb. Android low-memory
> diagnostics need this to attribute the memory used by tracing when
> calculating lost RAM.
> 
> The buffers can be spread across the global trace array, dynamically
> created instances, and snapshot buffers. Userspace currently has to
> discover and sum every instance, and snapshot memory is not exposed by
> the per-instance totals.
> 
> Patch 1 adds:
> 
>   /sys/kernel/tracing/trace_stats/memory_usage_kb
> 
> reporting:
> 
>   buffers: ...
>   snapshot_buffers: ...
> 
> covering the global trace array and all instances across all CPUs.
> 
> Patch 2 adds the per-CPU view under
> trace_stats/per_cpu/cpuN/memory_usage_kb.
> 
> The values account for the full pages backing the data sub-buffers and
> reader page, plus the cached read page and mmap metadata page when
> present. Slab-allocated ring-buffer metadata is not included.
> 
> Xiang Gao (2):
>   tracing: add ring-buffer memory usage statistics in tracefs
>   tracing: add per-CPU memory usage statistics in tracefs
> 
>  Documentation/trace/ftrace.rst |  15 +++++
>  include/linux/ring_buffer.h    |   1 +
>  kernel/trace/ring_buffer.c     |  41 +++++++++++++
>  kernel/trace/trace.c           | 104 +++++++++++++++++++++++++++++++++
>  4 files changed, 161 insertions(+)
> 
> -- 
> 2.34.1
> 
> 

It looks like you have sent the same v1 again.

-- 
Vincent
