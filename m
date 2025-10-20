Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206D82E9743
	for <linux-trace-kernel@vger.kernel.org>; Mon, 20 Oct 2025 08:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760948358; cv=none; b=sb3J6/V9s4j1mLfDxEHI5a5EOqvPsnniArCXxy6LHE2OtKk1azS4pIGXdzEfYHtannMme1a4QZO27ZIGxwftwu5Tr5vDj0ygXDYxOmRUa5OOmC9Cc8pSbEO8UpT8xk5TqbcThBTqVwaDxyeCMDqWQoQmqtG2xToS4AOFpOa5TIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760948358; c=relaxed/simple;
	bh=0fXq12iirln66Vse2pGIM6f8XTT1Eb6EvxlqqMLRYUw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=buKjSiBeHrAGtoEGzLqlgJplZXOHOKnvmPsFlMhmDVUGVWH/ChmjUBsot/QVWSvKsi2oHqc1AmFIWnRwSfPeiRALqH6y4sKCJh9cQdgTCKpuCwP2ipJigyWWYhgPEYZMkCkJyLX2f13P8fq8AQAXV6bfOwx+u/enLddJwxQTMZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AFsc/JS0; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFsc/JS0"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4711810948aso26121045e9.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 20 Oct 2025 01:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760948354; x=1761553154; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fazdpRfxsDD7fetjq1w/Glu0iHVJ/m+YWhcBobrHBOU=;
        b=AFsc/JS0u8Dj5b5Enforgj97auzKjJbJSewXFauddiCAFlDL4m85Hm6rTTG9NR6KHy
         Yh26KJcQ5IcQ3LQQGknAxOO7HARsV0TxtSaZqhT0oSH6NhpoJ8CrwJBxqi+rYeH2CWx5
         hG69ZE99F9c0la9R5NXpy/4BIYiw5TqL+BvY6Y1UBZ24WYPcNnQJlSdI0zJjtj/5j2FC
         YodVhpzEXixxwRi4xmuWnBnVur0VWmPXp+KQ8B4TxqqvaO27MTiF6UG2LxxIee8+jaQ9
         PlWNs8DIVSsuzm2yvn4ib9gCNCp+ITCDlRg7W1dRoOOsy3VP2h8nuDei/vi9OWwKz5zA
         7OYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760948354; x=1761553154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fazdpRfxsDD7fetjq1w/Glu0iHVJ/m+YWhcBobrHBOU=;
        b=Eb+fwGy+QA/shJel9Kuh8B0nxC70v6vpbg+jaRE2XoZcUtFNVkFFBGZrCIRpdV1nht
         wEUhsAiD+w7t2K40iCjxk/lvH4NIn6b2nVUpNAfSHfukWY1MpaIBgfcu+4U8Q7LKJYCV
         xKuh8OA1xUNrYi5tJqPUSAjIxND1JuhH8/olirM9sppBvD6OsbyUb5fRGYcuncUtKywC
         l1nFipXDuZoEPu+N9+C3kjvjmXkjeiI5yIQq8v3dhqmmyZu1ryhTC6AujL8/l+UjhdwS
         PF+PEj1O3HbjMRRp1hgWbcVYD4I0F8Jvt7XgeixsWPKEs+7AhQ8amP6FyN6QUaYBSxjC
         TvBA==
X-Forwarded-Encrypted: i=1; AJvYcCVKk55EzJS/tpQF2wrpcNJ9wJMXx6FjAqBf/J9rsJMH+fGaz+Pk2s+GWxEsikGx40r5CDIgci4oZfXrpYkyxndQsWo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu/sNoxHDGPYDcj42rc8L5ZX5YP9LzM4zHjAElhWz5zQFY1fRr
	EBRZjqi81IH5qbytnknirArpLppJ3BU1NFjrTeHrbEQ1wwJB8yobsZg7
X-Gm-Gg: ASbGncvQIOOHEnIzyJtj3tAdGW9bUXerNca5PNHEuuBAh2XscdtREI90HsMeAO9ENUh
	n2OlUPeAApBE5LJGpEF8AZ7vyKhAxXOr7nia9M2fv+05v/8wUceN10Uf/5+fAasJpH1uue6rSni
	NDe0l8Q2CNHYyYgOwUt0s2q2w3zcbGyKqdYmAbPnsq+covAKCpfxsYebiNC4MdhjYb1iUmbd388
	ZPFalpEJnqLEvV+kfVu9a3eax10XwUaCqXlf+Ygjo/mnjxeWDMD2xU0vNL5Ey4okjWqGS2ogGii
	X4Zqcohty90d/ALaaNpSP8QvolULSjMOLIYu8dJ/+id79xZpbzvAcP4icy+8QfKPr71fiWgSp6Q
	JvrHBhU2r0drd4P76nMY1EqlI2QTweSyrjPX5KcIBKMdQJzKjIA==
X-Google-Smtp-Source: AGHT+IHpSaBl/fbDQGboMp5aBmz55psJfILfa3Nr3uL7f9e4C9aGVeEfJJbxbkWC+GMQnBRat0EiFQ==
X-Received: by 2002:a05:600c:3149:b0:470:bcc4:b0a0 with SMTP id 5b1f17b1804b1-47117925919mr99554785e9.34.1760948354254;
        Mon, 20 Oct 2025 01:19:14 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::31e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471556e1892sm130375105e9.18.2025.10.20.01.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 01:19:13 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 20 Oct 2025 10:19:11 +0200
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
	sdf@fomichev.me, haoluo@google.com, mattbobrowski@google.com,
	rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, leon.hwang@linux.dev,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC bpf-next 2/5] bpf: add kfunc bpf_tracing_is_exit for
 TRACE_SESSION
Message-ID: <aPXwfxRvSk63FOxU@krava>
References: <20251018142124.783206-1-dongml2@chinatelecom.cn>
 <20251018142124.783206-3-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018142124.783206-3-dongml2@chinatelecom.cn>

On Sat, Oct 18, 2025 at 10:21:21PM +0800, Menglong Dong wrote:
> If TRACE_SESSION exists, we will use extra 8-bytes in the stack of the
> trampoline to store the flags that we needed, and the 8-bytes lie before
> the function argument count, which means ctx[-2]. And we will store the
> flag "is_exit" to the first bit of it.
> 
> Introduce the kfunc bpf_tracing_is_exit(), which is used to tell if it
> is fexit currently.
> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> Co-developed-by: Leon Hwang <leon.hwang@linux.dev>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  kernel/bpf/verifier.c    |  5 ++++-
>  kernel/trace/bpf_trace.c | 43 +++++++++++++++++++++++++++++++++++++---
>  2 files changed, 44 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 40e3274e8bc2..a1db11818d01 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12284,6 +12284,7 @@ enum special_kfunc_type {
>  	KF___bpf_trap,
>  	KF_bpf_task_work_schedule_signal,
>  	KF_bpf_task_work_schedule_resume,
> +	KF_bpf_tracing_is_exit,
>  };
>  
>  BTF_ID_LIST(special_kfunc_list)
> @@ -12356,6 +12357,7 @@ BTF_ID(func, bpf_res_spin_unlock_irqrestore)
>  BTF_ID(func, __bpf_trap)
>  BTF_ID(func, bpf_task_work_schedule_signal)
>  BTF_ID(func, bpf_task_work_schedule_resume)
> +BTF_ID(func, bpf_tracing_is_exit)
>  
>  static bool is_task_work_add_kfunc(u32 func_id)
>  {
> @@ -12410,7 +12412,8 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
>  	struct bpf_reg_state *reg = &regs[regno];
>  	bool arg_mem_size = false;
>  
> -	if (meta->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx])
> +	if (meta->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx] ||
> +	    meta->func_id == special_kfunc_list[KF_bpf_tracing_is_exit])
>  		return KF_ARG_PTR_TO_CTX;
>  
>  	/* In this function, we verify the kfunc's BTF as per the argument type,
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 4f87c16d915a..6dde48b9d27f 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -3356,12 +3356,49 @@ static const struct btf_kfunc_id_set bpf_kprobe_multi_kfunc_set = {
>  	.filter = bpf_kprobe_multi_filter,
>  };
>  
> -static int __init bpf_kprobe_multi_kfuncs_init(void)
> +__bpf_kfunc_start_defs();
> +
> +__bpf_kfunc bool bpf_tracing_is_exit(void *ctx)
> +{
> +	/* ctx[-2] is the session flags, and the last bit is is_exit */
> +	return ((u64 *)ctx)[-2] & 1;
> +}

I think this could be inlined by verifier

jirka


> +
> +__bpf_kfunc_end_defs();

SNIP
