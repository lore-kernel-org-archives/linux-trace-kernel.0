Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CE9283CA3
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Jan 2026 23:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768865858; cv=none; b=ldfFQYMeCR6USZixHLNNUGe2PpKYlL1RaReCEZU36rAGpf+qj4L+GgtJ9VGJhvpp2Nw+lHS9MIkyDCLDUNOpor+eD3lGHewWhpM/Hy02/cMgkZh3C/8CIOhjGZiIs0D9UGWKCVCadiGMIF8bQJNS2ym5WAh8Ow8WfcSGEWHXw8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768865858; c=relaxed/simple;
	bh=aDfnM7i9GGpQDHaGMBkiIsynJa7STOxJiG3hr1rIu1s=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tow/5AhRTrIPNdbz46RDVFDDk53WJF2VOVVZLCFOZcc7vZFbZS1gtiM8cGZZIGojLS39PxhApoebLFswGrzN/w1vbcTIqV7TKT9F4P1Ggxz0HM+SUpaYVrdRd9lswC3slG+kbkG74pnPnYBpAanM6A5wXTTU5bRtAnOEysV6QtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z5DMl1E0; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5DMl1E0"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-432755545fcso2697320f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Jan 2026 15:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768865855; x=1769470655; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1JfOnVqkCeNateHhFiNeNhXc5NJwePi9FKodOPEv0No=;
        b=Z5DMl1E08+VNpnLOt3VF/wp6VswTXOu5UPnjlsugmANXWk4rLdDmGwYuqxUcQyXljx
         94Vfyto/XIfZ+ivUu3TGcDltzD/yUJELkTbsh9LpcnCNo43W7u7qLgdcnd8CRKv34JaA
         /xw/ZNw4BOkXGRpNbmPfRa1cA2qqEVm1Jmgw8gFcW3YEbUX6L1PDPiNME0c4tDjH/UGQ
         oV3IZbS1A8e8FF5fipkE3+08f8oTIJSw2OP9tSrgd4MWn335h4m7yo6MPH40K2EFp2Hf
         D8TCk/KetpLdnxE5hK7a1YXtkVs15fnvmLwLyGxjhqOerDYe50o58lXDv3G0vBHEzyz9
         LdpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768865855; x=1769470655;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1JfOnVqkCeNateHhFiNeNhXc5NJwePi9FKodOPEv0No=;
        b=XbmKM+uVyEBS0LsQd1G7qYsw0iAnyPJ0IMp2LzItwUAQ4U/UsBCksj2Ym4Hzmhf1mo
         hW/8ELdzOnt4LrCtdtlZySEXUT4FB5K3iwz45B1wpIWcELNl7xEpPCg5nSttyC9t9VKr
         izmUV/59aMvVglBh7S/U6PJv5UsH92pliLfoMc+HNu5iUJ/eE7N9xZ9DW4islRC7lUBe
         EibhcBfSjAyubdOOXvIyUYYZ0qw53EHa6xSKW4VynW5su1GuxNm4KHsxBPT8zih196XS
         z0hy6ZINs0A7TGTI98L6QxeVH6KghU7cUZ8feqEDfnC/YGO1KL+hXpga7a73CWn7zSeB
         Se6g==
X-Forwarded-Encrypted: i=1; AJvYcCXL+EUtrY+6tT6uOkY9crDEPADOB1QPyIzTA4aYxyNMM4P30m7Pgte2PYNIJtPPqaA3VP5uz8RDe4805GI6aDgx2w8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJAKPBLrhky6YhXb5HSgS+t/wBgE50ODgSfxlbXxKEuFMXAPl5
	nMZDhbtjDK+KNH6ykjK+jcOJ4I/NFu4MpWqE2xbDIp91Vk6vbWmuf1fl
X-Gm-Gg: AZuq6aJAlKZCk60NOrz8xlIfvAOXjuBAQXzoGIVDDTkxIKl0dSr5qeRs1t6AvGfIHJQ
	8dUZdrjMUhEzSYQmWJvBBJJyLGxrEKP8Sy9tzsiGoumdpxUAO9PCwdlVKUxutcspSBlOFU3LprL
	1Z+Cfz8Fk6/CdG5tyhNg5AsJkQ8GjyrjH4hh1CoAveJ8DGxxfPHL69QklbkDc8yKhA5Vd2XDPpd
	UL0ulxmw8QW1QvuUjEHmI+S7wvwFktIsKsSjPxypNx9PLS+u87UIJSKtn8Ka9WmxhLwj7YG5bWq
	5mvzBuRkcylgNqvUcoto/R1B74I4woInbq2IHBOPlAuF/oyklpa9Lm5jIS7yfnkTRV1g99GhKz7
	2+hmbf5drMpFUsiTP9raLStSS3YCri0J/hn4jOWlyVaUNFcPjlzBD98z/WTJrPZpkHOLIp39svF
	auE2pj7Jlzxw==
X-Received: by 2002:a05:6000:2903:b0:432:c05b:d8c7 with SMTP id ffacd0b85a97d-43569bc7761mr15761095f8f.49.1768865855030;
        Mon, 19 Jan 2026 15:37:35 -0800 (PST)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356992c6f2sm25306953f8f.19.2026.01.19.15.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 15:37:34 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 20 Jan 2026 00:37:32 +0100
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
	john.fastabend@gmail.com, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
	sdf@fomichev.me, haoluo@google.com, mattbobrowski@google.com,
	rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 1/2] bpf: support bpf_get_func_arg() for
 BPF_TRACE_RAW_TP
Message-ID: <aW7APKlKCgg2_YvW@krava>
References: <20260119023732.130642-1-dongml2@chinatelecom.cn>
 <20260119023732.130642-2-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119023732.130642-2-dongml2@chinatelecom.cn>

On Mon, Jan 19, 2026 at 10:37:31AM +0800, Menglong Dong wrote:
> For now, bpf_get_func_arg() and bpf_get_func_arg_cnt() is not supported by
> the BPF_TRACE_RAW_TP, which is not convenient to get the argument of the
> tracepoint, especially for the case that the position of the arguments in
> a tracepoint can change.
> 
> The target tracepoint BTF type id is specified during loading time,
> therefore we can get the function argument count from the function
> prototype instead of the stack.
> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
> v3:
> - remove unnecessary NULL checking for prog->aux->attach_func_proto
> 
> v2:
> - for nr_args, skip first 'void *__data' argument in btf_trace_##name
>   typedef
> ---
>  kernel/bpf/verifier.c    | 32 ++++++++++++++++++++++++++++----
>  kernel/trace/bpf_trace.c |  4 ++--
>  2 files changed, 30 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index faa1ecc1fe9d..4f52342573f0 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -23316,8 +23316,20 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
>  		/* Implement bpf_get_func_arg inline. */
>  		if (prog_type == BPF_PROG_TYPE_TRACING &&
>  		    insn->imm == BPF_FUNC_get_func_arg) {
> -			/* Load nr_args from ctx - 8 */
> -			insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
> +			if (eatype == BPF_TRACE_RAW_TP) {
> +				int nr_args = btf_type_vlen(prog->aux->attach_func_proto);
> +
> +				/*
> +				 * skip first 'void *__data' argument in btf_trace_##name
> +				 * typedef
> +				 */
> +				nr_args--;
> +				/* Save nr_args to reg0 */
> +				insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, nr_args);
> +			} else {
> +				/* Load nr_args from ctx - 8 */
> +				insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
> +			}
>  			insn_buf[1] = BPF_JMP32_REG(BPF_JGE, BPF_REG_2, BPF_REG_0, 6);
>  			insn_buf[2] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_2, 3);
>  			insn_buf[3] = BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_1);
> @@ -23369,8 +23381,20 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
>  		/* Implement get_func_arg_cnt inline. */
>  		if (prog_type == BPF_PROG_TYPE_TRACING &&
>  		    insn->imm == BPF_FUNC_get_func_arg_cnt) {
> -			/* Load nr_args from ctx - 8 */
> -			insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
> +			if (eatype == BPF_TRACE_RAW_TP) {
> +				int nr_args = btf_type_vlen(prog->aux->attach_func_proto);
> +
> +				/*
> +				 * skip first 'void *__data' argument in btf_trace_##name
> +				 * typedef
> +				 */
> +				nr_args--;
> +				/* Save nr_args to reg0 */

I think we can attach single bpf program to multiple rawtp tracepoints,
in which case this would not work properly for such program links on
tracepoints with different nr_args, right?

jirka


> +				insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, nr_args);
> +			} else {
> +				/* Load nr_args from ctx - 8 */
> +				insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
> +			}
>  
>  			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, 1);
>  			if (!new_prog)
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 6e076485bf70..9b1b56851d26 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1734,11 +1734,11 @@ tracing_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>  	case BPF_FUNC_d_path:
>  		return &bpf_d_path_proto;
>  	case BPF_FUNC_get_func_arg:
> -		return bpf_prog_has_trampoline(prog) ? &bpf_get_func_arg_proto : NULL;
> +		return &bpf_get_func_arg_proto;
>  	case BPF_FUNC_get_func_ret:
>  		return bpf_prog_has_trampoline(prog) ? &bpf_get_func_ret_proto : NULL;
>  	case BPF_FUNC_get_func_arg_cnt:
> -		return bpf_prog_has_trampoline(prog) ? &bpf_get_func_arg_cnt_proto : NULL;
> +		return &bpf_get_func_arg_cnt_proto;
>  	case BPF_FUNC_get_attach_cookie:
>  		if (prog->type == BPF_PROG_TYPE_TRACING &&
>  		    prog->expected_attach_type == BPF_TRACE_RAW_TP)
> -- 
> 2.52.0
> 
