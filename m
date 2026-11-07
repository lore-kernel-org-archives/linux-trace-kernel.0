Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794062956;
	b=Q32bjZvQLfhbpHwZqAF8H00IrZ+rlGjGoWL6rO3e4mlPij2J+dGtygd9R6LEZkppjT6m
	 5kpXElj+UgB/hGqk8bYfxZ1W4dYFaB4oSD1NshTSscWQyxarAxkf2LHdItgWHy4za1fRX
	 k4K/AOMZvJCf6p9zaYngrAvAa2iORDQ5B7qW76Jbsylg3fzeKaCwk6drV3OgjESJaRQwX
	 AH9XiaCN8kdlNasrN16nlin2IBehCrDz95FCOpf6hrPt6nICfRNJ/bK+SIbABOaRkiAQG
	 1OordrYluzDWIxKgTI+sfCnqOuy1bvywQp1gnbAGVfcoBk853gt+J062ZjcZY2pmkcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794062956;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=8qyCzlOCl9bU9afDLyhWqixwH5pt3+yWnVmKw7yb1QE=;
	b=dg7z14h9WfnvtIhWbcfJ/G0eUzF9AUIsk6IOitENa6mfzw6hqRGlTHgaFDyWQulqfHy8
	 xpo4t+aRH/fu34SlJqppmMdW75vQ6h8CoOSkdiL+VjeqTE2tl5ijqoxNUb9aiq57Cxn8r
	 h6/nFF4/8w56s1cdDYi5+4RIn6Syv2V9e/YY46kiGRsCfsLly0hxWuSWzfyOS6jdnpG7r
	 HW7bcnCFugEgIm0qkqd4IMTCqedW03HCWeZBA4C+C9TihFAjulvKTz7/XN+YvZ+YgX3Rr
	 aF5Ops3l2mutLtguIFC15EQ0aBndPEmDii9sqG9tN3a63FgRJIOxcViv4iQ4ISUdL6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JcuwyR6B;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548D0606A33E;
	Sat,  7 Nov 2026 14:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JcuwyR6B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D13DE1F008A1;
	Sat,  7 Nov 2026 14:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794062955;
	bh=8qyCzlOCl9bU9afDLyhWqixwH5pt3+yWnVmKw7yb1QE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JcuwyR6BOH5/K8uSNfbDQtBS4do2OAMqYN4B72utk0P9aP0rd0djoWrvFn9OvTYDT
	 aOp5L69j6KRctzgpUIw3PnI6QUewYm37QADNBQf5cOCyH9vY9OmCiOKbtt25E7h2KS
	 n9QOaHkMR6LKLbKr0N1PVlreex7byjGI4zT3oJqrEVeAhOXh84J6l0g4buy9BlAnYT
	 AX4scoeKyDufAqxyFj8OYWWHHOn421utMStiVYp48jkweM9SFOh9oZaUfxZjndAqzZ
	 eZUtSKxie9KG9bZP5pZawu1CuUjoIWs6bTPmsXhOaHJJRG4t74HpN7IvgXRE/oAi8F
	 bhOyFW/I9CRZg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Yifan Zhang <yfzhang23@stu.pku.edu.cn>
Cc: linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org, mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] tracing/probes: bound symstr stores to reserved length
Date: Sat, 07 Nov 2026 23:49:12 +0900
Message-ID: <undine-1794062952872987224-6d2052c48f198876@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <179378621331.55520.2052332247156241151@stu.pku.edu.cn>
References: <179367391951.8187.17152618045554425533@stu.pku.edu.cn> <179378621331.55520.2052332247156241151@stu.pku.edu.cn>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Wed, 04 Nov 2026 17:56:53 +0800, Yifan Zhang <yfzhang23@stu.pku.edu.cn> wrote:
> Traceprobe calculates dynamic string sizes before storing the values.  A
> probed pointer can change between those passes, so
> fetch_store_symstrlen() can reserve space for a short symbol while
> fetch_store_symstring() observes a longer one.  The store path then
> overwrites the trace record.
>
> Format the symbol into a temporary KSYM_SYMBOL_LEN buffer and copy only
> the bytes that fit in the reserved field, including a trailing NUL.
> Update __data_loc with the length actually stored so consumers do not
> read beyond the truncated value.

Good catch! This looks good to me. Let me pick it to probes/fixes.

Thanks!

>
> Fixes: b26a124cbfa8 ("tracing/probes: Add symstr type for dynamic events")
> Signed-off-by: Yifan Zhang <yfzhang23@stu.pku.edu.cn>
> ---
> Changes in v3:
> - encode the actual stored length in __data_loc after truncation
> - encode a zero length if symbol formatting fails
>
>  kernel/trace/trace_probe_tmpl.h | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_tmpl.h
> index 8db12f758fdae..8acc0f0ebd7a6 100644
> --- a/kernel/trace/trace_probe_tmpl.h
> +++ b/kernel/trace/trace_probe_tmpl.h
> @@ -87,15 +87,27 @@ fetch_store_symstrlen(unsigned long addr)
>  static nokprobe_inline int
>  fetch_store_symstring(unsigned long addr, void *dest, void *base)
>  {
> +	char namebuf[KSYM_SYMBOL_LEN];
>  	int maxlen = get_loc_len(*(u32 *)dest);
>  	void *__dest;
> +	int len;
>  
>  	if (unlikely(!maxlen))
>  		return -ENOMEM;
>  
>  	__dest = get_loc_data(dest, base);
> +	len = sprint_symbol(namebuf, addr);
> +	if (len < 0) {
> +		*(u32 *)dest = make_data_loc(0, __dest - base);
> +		return 0;
> +	}
> +
> +	len = min(len, maxlen - 1);
> +	memcpy(__dest, namebuf, len);
> +	((char *)__dest)[len] = '\0';
> +	*(u32 *)dest = make_data_loc(len + 1, __dest - base);
>  
> -	return sprint_symbol(__dest, addr);
> +	return len + 1;
>  }
>  
>  /* common part of process_fetch_insn*/
>

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
