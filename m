Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794665856;
	b=XAA+B5Fk9f64VUAvguiYAQjKhMrN19iBVl/14nujJwY6bJG1f8injH6Lz6AqZcCHOpvt
	 HYWNJ2j/BuaYhrpqVnMzFQREXp5/5MOXDANuK7JLkJB1IyIW182w0nL5+CrO3/4dG4GHh
	 gyrFUidvz6u7DMJnARpmpHnLF7a8JFAvWU+wiw2wDnb0upPSQ9TRsdunuzYqSNbzPkZ5E
	 DcJpafuvSpGOcrIzqoZuMhJ7iXS9ies17L+3t+e5nk0iDCD4nIHDxt8l/4mgpTiBi7BDo
	 3hLJyeZSzMxPTZjzguQ5e+1CFQiQyyjOBtq7vbp7GIWsUkvTqN+8UeJXkSNrcfOrEyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794665856;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=GS4jbtYtW/yhZKnq1AkXrMxrXCWzFQup/7DDpI9kC2U=;
	b=bRCNEqxE2w0YXEtrYy2WZ/SJqXnBVfXkDPHb2jzGAvzzF9ham4Y6gRkFpyipL7i753lN
	 c/AeO4a8uRAVt8r1PNpA8AR4eCCc2+jYwLefZLe4MTs8JtR6jvu5+K/7s2Y3g0WI7OE0f
	 RjQ6jtckeFIWoEK1QlRoudDFq2etOsJYITwbVcZSQoJ7W0XIR5mivrurofjqgX5fkzzSb
	 Jq4VY4aaIP3/waEgPqVfteCdjQ0h0PXkVh29TlojTSAuM4uUoxf54CnVk0T4lFdZaXD+T
	 UTXDp+fkWGP284nhOPTCT9LuGEelBfgRXsGc2sEXmaB0A0PvwXhQZeNyEFrsAHXCcbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=joGTMJS1;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49359606A327
	for <linux-trace-kernel@vger.kernel.org>; Sat, 14 Nov 2026 14:17:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49359606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=joGTMJS1
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48dee593f18so2368387f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Sat, 14 Nov 2026 06:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794665854; x=1795270654; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GS4jbtYtW/yhZKnq1AkXrMxrXCWzFQup/7DDpI9kC2U=;
        b=joGTMJS19VoihDS1FaYgbHhavZw44ArpFI5chZKmCDeCxGbMady8B4QB8gbDqXqQwM
         Te4gPj1Z4ZBdNO2lJipqJ5Y9luQ7hBLY78HmbUYSwoRTL86jhq4BpK1kl/pJYCiBQ+9u
         fZ0JooljA3GAIZ6E+Vawp7UnZU9ZARtxB5iyAzxHNqy4dJ1bQeQNqNLU37R5/c6Y7w5K
         KsrHRR+h97bltBOXI6rN1QyCdba3k9UdL4QV+BYCW/GmA9GHKnlBuC1mf+NG/bxaZ5SE
         /n+x/FotCth5AivPyOk1/34jcr+cUKmBv76FMXaVgX8jERX6Xv3lnaDIMJ6syxehaMXE
         Isdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794665854; x=1795270654;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GS4jbtYtW/yhZKnq1AkXrMxrXCWzFQup/7DDpI9kC2U=;
        b=LcJJB19gy1slyNDXFy5gSAvmXytEpvRuiHoWIYIlyo0OaCEIxeayLeI9YRlD1pt9XW
         annEos5XO6qObqC2I51YWjf8xlaZ1BmZjUTFBXsVKU+fzkvTpkT91kZ2yIzcD3lLw1Uh
         X1JJ4lHtxpTHGChoz+QbnNg2g73HsDIVBwFhysJXZw+bl7gFCpRtH79QQG9707SSoOju
         ttbcwE6HbElIeaxT31VWykXSxmYNizYelktVxh1M/o5PDAXzM8v20+yDYWgz1dPC7d1B
         d2q2cGhp9rdD/2qKsmsB/GDrhHM9DR4I7jXGbSG+2jqcupu/VRBMDbUAkgFipTlAXEMh
         X2vQ==
X-Forwarded-Encrypted: i=1; AL+hErHc6HXlbs5hOcs8DVvK86iE5PAat1SPB/JnhSWOJ1wd9ow4TbCO0o8YUXkxml/K8FNtpIdHcCCtW6kc031Qks2jfIk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/LR7dJFO5VBB8EFst66YvAVBYLYtCwx+Jz2dXXhURm3ngTkpRD
	neTbKClmE4Kp7abwL4pnBDhIELxxzPRdBMr4nW/VzXYGDvvcZd2cAk4c6CpI6S1ndA==
X-Gm-Gg: AYBFou3JBu5OaHELS6d379M9FM2wI38Qgy/A8a1+9LiXJClsF8RTvZpVfreibh3vaX5
	J444eHIT53wFg88bEVVsMToAUA0N6bDMKbeLxFfTcCjoq16RtWQVGPl/ijUebYuDEI/Q3IC5q2G
	y5YWhpBQ47DHgeh2WUIipBxQ37zXsr2ZpXSmMisQsOQc8K/JOCABJH8cVHHhX6S0By3Yv3l52Yn
	ee/c/QWBq9Cq+Zome1F3SZ6Nnlt8Ln96xvuR/veattZUz5aJIwYCBITv9CQnmEl6UAPiedsor+q
	pU6NlRmWvvD4kfGdUCCjDivVjMnZdCrcUOH43QbH5OcDfowuTgrEERLoLNsCv2W30u7QpT+xVf8
	Fb1zOeup0NjUH2l5FnXCmgiraFuEiVgSXSmm4RXCVTGmMB7pDpJVgAVYxiLG9GJvpiJV+PqTcl+
	ho8FF2DGKNGwlNZ2Q4UH7vuGRaUM3kLKrBVHaMhuuFhJXbFZN6S0ulCFWoeUd28XklF20ZXDKmu
	Ialz0TquZHzRelCQ1HG+zYNWVxCG3gzqseqGmPx/yKWgXt4MiI6Z8YFms6G2oixRxxDrxpYFJtm
	WG7h+3cN2fzvvyIYrTCaAdVbKugeAUSKkc+XRlKgeg4CBtIeubraiMB/a6Jp3mj/EZ7K2En2MBB
	L9wdUUi35Hhw=
X-Received: by 2002:a5d:5c05:0:b0:49d:8d2e:40e with SMTP id ffacd0b85a97d-49d8d2e0438mr7872479f8f.16.1794665853122;
        Sat, 14 Nov 2026 06:17:33 -0800 (PST)
Received: from google.com (0.182.34.34.bc.googleusercontent.com. [34.34.182.0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c888b90d4sm10147934f8f.9.2026.11.14.06.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 06:17:32 -0800 (PST)
Date: Sat, 14 Nov 2026 14:17:29 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Xiang Gao <gxxa03070307@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lorenzo Stoakes <ljs@kernel.org>, gao xu <gaoxu2@honor.com>,
	yinchuang1@xiaomi.com, linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Xiang Gao <gaoxiang17@xiaomi.com>
Subject: Re: [PATCH v5 1/4] ring-buffer: add ring_buffer_memory_size()
Message-ID: <avhteUQSrWPFuQ3a@google.com>
References: <20261105140221.44614-1-gaoxiang17@xiaomi.com>
 <20261105140221.44614-2-gaoxiang17@xiaomi.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105140221.44614-2-gaoxiang17@xiaomi.com>

On Thu, Nov 05, 2026 at 10:02:18PM +0800, Xiang Gao wrote:
> Add a helper to report the page memory consumed by a ring buffer for a
> given CPU. It accounts for the data sub-buffers, the reader page, the
> cached read page, and the mmap metadata page. Unlike
> ring_buffer_capacity(), which reports the usable data capacity, this
> reports the full pages allocated to the buffer.
> 
> The function is generic and returns a size for any buffer type, so
> callers that need the memory footprint of remote or persistent buffers
> can use it as well.
> 
> Signed-off-by: Xiang Gao <gaoxiang17@xiaomi.com>
> ---
>  include/linux/ring_buffer.h |  1 +
>  kernel/trace/ring_buffer.c  | 37 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 38 insertions(+)
> 
> diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
> index 649b2276b557..e83e94623e76 100644
> --- a/include/linux/ring_buffer.h
> +++ b/include/linux/ring_buffer.h
> @@ -174,6 +174,7 @@ int ring_buffer_iter_empty(struct ring_buffer_iter *iter);
>  bool ring_buffer_iter_dropped(struct ring_buffer_iter *iter);
>  
>  unsigned long ring_buffer_capacity(struct trace_buffer *buffer, int cpu);
> +unsigned long ring_buffer_memory_size(struct trace_buffer *buffer, int cpu);
>  unsigned long ring_buffer_max_event_size(struct trace_buffer *buffer);
>  
>  void ring_buffer_reset_cpu(struct trace_buffer *buffer, int cpu);
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 1fd28a72e6ee..0396ec671998 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -6566,6 +6566,43 @@ unsigned long ring_buffer_capacity(struct trace_buffer *buffer, int cpu)
>  }
>  EXPORT_SYMBOL_GPL(ring_buffer_capacity);
>  
> +/**
> + * ring_buffer_memory_size - return the memory used by the buffer (in bytes)
> + * @buffer: The ring buffer.
> + * @cpu: The CPU to get ring buffer memory from.
> + *
> + * Returns the page memory consumed by @cpu, including the data sub-buffers,
> + * the reader page, the cached read page, and the mmap metadata page. Unlike
> + * ring_buffer_capacity(), which reports the usable data capacity, this
> + * accounts for the full pages allocated to the buffer.
> + */
> +unsigned long ring_buffer_memory_size(struct trace_buffer *buffer, int cpu)

memory_size() may be confusing because we don't account for all the other
kmalloc() allocations. 

I have also just realised, do we really need yet another accessor? With the
existing ones:

  nr_pages = ring_buffer_capacity(buffer, cpu) / (ring_buffer_subbuf_size_get(buffer) - BUF_PAGE_HDR_SIZE);

(Alhough there's a race with ring_buffer_subbuf_size_set() to be resolved!!!)

And if the caller knows if a cpu_buffer is a remote, or a persistent buffer, it
can just add nr_pages++.

This only leaves free_page unaccounted for. But does that really matter if the
other solution would be to have a very racy free_page accounting?

-- 
Vincent

> +{
> +	struct ring_buffer_per_cpu *cpu_buffer;
> +	unsigned long subbuf_size;
> +	unsigned long size;
> +
> +	if (!cpumask_test_cpu(cpu, buffer->cpumask))
> +		return 0;
> +
> +	cpu_buffer = buffer->buffers[cpu];
> +	subbuf_size = PAGE_SIZE << READ_ONCE(buffer->subbuf_order);
> +
> +	/* Data sub-buffers plus the reader page. */
> +	size = (READ_ONCE(cpu_buffer->nr_pages) + 1) * subbuf_size;
> +
> +	/* The cached read page, if present, is a full sub-buffer page. */
> +	if (READ_ONCE(cpu_buffer->free_page.data))
> +		size += subbuf_size;
> +
> +	/* The mmap metadata page is a single system page. */
> +	if (READ_ONCE(cpu_buffer->meta_page))
> +		size += PAGE_SIZE;
> +
> +	return size;
> +}
> +EXPORT_SYMBOL_GPL(ring_buffer_memory_size);
> +
>  /**
>   * ring_buffer_max_event_size - return the max data size of an event
>   * @buffer: The ring buffer.
> -- 
> 2.34.1
> 
