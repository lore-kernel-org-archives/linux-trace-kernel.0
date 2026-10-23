Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792739606;
	b=IBqfuD4hSh18CqhTN9+8zR1EvWvDXTZ4u1zBYaViILJqfVs4qSJbHvO7OKGYSaWjvg+L
	 tUe6Rg2Gvb+YUyGOdm+fNEa4p8CF/X2UOjbzQkWWn6mt85o8JhJG253gzrMAr2U0nZ9rk
	 ZlfHT+bMLyEciPwVHFcgM49RPu34wpxKxRL7v7Otzoq7ZPfz5K6dbOhVg82s3o83nxNaQ
	 JZamMMwjDIbC/y7ZMpI80upMr90rrqUSRngz45XTXOsZK5BZdS3mdP5Gety7wYkP8Shpd
	 552a11NGEo9OajzzEaBth8x1cS3CQtzn7qZNuIq4raSyQ7Cj9shWxkdgrVXL/AQjT7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792739606;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=wq7uJPFcmgA9r58RX9y8WD41guFgFXDdj9tzjsOmuN4=;
	b=ZvsbAA/Qt+CJ8FNcPGvE8v2U27b99DfL2TvnSlqthFPZiLCCqzoyH9AX7JQ3xYwQCsPp
	 2rCnPVTEuoPjqNDskl/+WGoWFCB7m/KHbN0ZJSnZ4MV7Ej5qKfMtno644CFlzx87lwpRv
	 uKq9tuocVTwU6T1BskgHIHEL1hRJEbXceaMduINwqOh7A4fz4vvMQC/alOXHBmNtiFZMA
	 MWWjFfr92hVx3tU6bxGk4LrBjfpK8fz0RUgK0gkbSIPTkHLA5/ONgOjSGrkq8sinzAl9G
	 4m5FV3Z42FgmWcZz/JyiaC2qy45kYnc6p9qnC+hrnHWQhne4Nk2CF7wP2A4qS8DZQww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=P+OLg24T;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C20606A31B
	for <linux-trace-kernel@vger.kernel.org>; Fri, 23 Oct 2026 07:13:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10C20606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=P+OLg24T
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48e00eee27dso302025f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 23 Oct 2026 00:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792739604; x=1793344404; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wq7uJPFcmgA9r58RX9y8WD41guFgFXDdj9tzjsOmuN4=;
        b=P+OLg24T2DE6IMHyEqMBpfaLZ19LKpR99sGMlJRmiYlyCBdb0kxRQwF4u/Uew8jBoE
         Kd967OujE2M3LR224GaT+vNY7a6ZVHhrYJaukdiTOprNNmrWe53mJkSvCILgqLFmUbFR
         xAKVDBE62GKFuNc4XlUB0vJSlY8sWaBxty6dB2u00s2qirUGX8n35La49WgHBOgYh7wn
         o5YV8/MG448i6CwxxFKntlyeREqUinFv328e9m465xH8Mu84saZRUnUVglkRJmqlz5bA
         uPmq6WOxIxjriPMmY9rWdzTIfjkHiONHvkGU/mtHlDPEfQiHG1ckLYBc+S6X/Fbln8qO
         yQPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792739604; x=1793344404;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wq7uJPFcmgA9r58RX9y8WD41guFgFXDdj9tzjsOmuN4=;
        b=bO3FU5Sw692b7D8Ui2OcNajG7Dy8ekHjtHy18ZmTuh7WwLGyYlRdAY0CZeY6x+xvDf
         ftdw9RDpRkhyou6uzu84P5iasOSTdUnuE45UkIURbA6hFfTe/dSpm7qSDZCwje5pUXVj
         e6AtuacBvlPcGY7C9yRRFHvJ4hy1VmNpbV1Yrdb7wqVv5xxE7Ao0BNIyXnfvdUkx5eqc
         Y+5J1o/kGHqmqg5mtsR4b/eFx+wA6qurlPT20eUQSCi8nl1Cg2YXewNXR59cTdTqDKm7
         F0xqL4D48gRUQVaTgEaPBAAfp8FLIf7ForyglhK71ERc71nxZ92ebIPJhVYXwN3R/U8R
         g66Q==
X-Forwarded-Encrypted: i=1; AKwUvBysZMgUx3aWr3tbpbrEvpKVBR08LBWKV2dL5WpGesr7Lb0NAtkFaQBLrWQjptfBO3xfj0tNfUeSq3j43ibLvYtq7H0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJs9u3c3MjSaSIRVRhfguKPJuut+h3TXELtg2FHvjertL8rxGNb
	vTKxtSZRYa2MfzcN7r7PQPIqA+jFDtR/EocH744P4M5zJP85E2XtGMUw
X-Gm-Gg: AYBFou3gKlORTdqOX8k7sRM85fZY+4ApYFHbVr3FVO5igvjvZECPaa+Kz85BMJzmj6g
	EDg3wRd7iVfFxu4Flefa4dq3vR2SjNosIFUfYzKLuBnznOQTTWgVjMsNK0tEDIK3kAOQ7rZlpcE
	tp+TrSUV4xWDhZd4jZ5G/YIRqHQZJcGtTZLnpyrb1M3Yf3SpbA4ppK9fNA+ZrPJHwuwrRl7q3MY
	9LMmSt0By2aPZ7lZwzTcVyXUjMIt8wLIlYHSdhTSIh32RojQ2VQpOa3vjr44rjfqi5RJqQYHGSW
	FWIubHO7McNdAXjERewvemLGQo6mFKdRt7UreLvniO+fycvfIjSI5TGg6Iaxw8M14DtUA5bUcXq
	ZAncROQIFJHQcL4y9mUL69cr6R7sAw/dHsOyyt+qjI/9bUbK0B5L5LkMR3vXqKfzgPu74x394nK
	Rc2DwSoXhhCWN1aVWc/suT5hfeFaGUO9kRc0XsuZzVX7dZi+wYR//pcahGXdE0bcQ8mo4oJZvqW
	N20XQstRtqjchNRzB/L9I+kAAzw
X-Received: by 2002:a5d:5d03:0:b0:48e:3b48:6f1 with SMTP id ffacd0b85a97d-48e3b480974mr340715f8f.54.1792739604164;
        Fri, 23 Oct 2026 00:13:24 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::25dc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e38025d76sm3155877f8f.13.2026.10.23.00.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 00:13:23 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 23 Oct 2026 09:13:21 +0200
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	eddyz87@gmail.com, memxor@gmail.com, oleg@redhat.com,
	peterz@infradead.org, mhiramat@kernel.org,
	akpm@linux-foundation.org, liam@infradead.org, ljs@kernel.org,
	surenb@google.com, david@kernel.org, vbabka@kernel.org,
	jannh@google.com, hughd@google.com, kees@kernel.org,
	mingo@redhat.com, tglx@kernel.org, x86@kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 4/9] uprobes/x86: Don't WARN if an optimized
 probe can't be written
Message-ID: <atsJEWXk04C4oz4R@krava>
References: <20261022015712.1297331-1-alexei.starovoitov@gmail.com>
 <20261022015712.1297331-5-alexei.starovoitov@gmail.com>
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
In-Reply-To: <20261022015712.1297331-5-alexei.starovoitov@gmail.com>

On Thu, Oct 22, 2026 at 01:57:07AM +0000, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> __arch_uprobe_optimize() and set_orig_insn() do WARN_ON_ONCE() when
> uprobe_write() fails, and user space can make it fail:
> - -EINTR from get_user_pages_remote() when current is being killed.
> - -ENOMEM when COW can't be broken, since memcg is at its limit.
> - -EINVAL from __update_ref_ctr() when the process cleared the semaphore
>   of SDT probe.
> 
> Kill the processes that call probed nop10. It warns in 8 of 8 runs:
> 
>   WARNING: arch/x86/kernel/uprobes.c:1186 at arch_uprobe_optimize+0x291/0x3a0
>    uprobe_notify_resume+0x1c3/0x4c0
>    exit_to_user_mode_loop+0x63/0x4e0
>    exc_int3+0x1f3/0x250
> 
> The next patch calls set_orig_insn() from fork(). Kill the processes that
> fork and keep mmap_lock busy, while a trace event on nop10 is enabled and
> disabled. The kernel with the next two patches and without this one warns
> in 3 of 3 runs. The whole series in 0 of 3:
> 
>   WARNING: arch/x86/kernel/uprobes.c:1161 at set_orig_insn+0x161/0x170
>    register_one_mm+0x154/0x180
>    uprobe_dup_mmap+0x61/0xb0
>    dup_mmap+0x149/0x9f0
> 
> The callers handle the error. arch_uprobe_optimize() marks uprobe as not
> optimizable and byte 0 stays a breakpoint. set_orig_insn() returns
> the error. Drop both WARNs.
> 
> This depends on the previous patch. Without it WARN was the only sign of
> the bytes that set_orig_insn() cannot restore. Hence no Fixes tag.
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka


> ---
>  arch/x86/kernel/uprobes.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> index 62bbe41c6466..33c35bf07801 100644
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
> @@ -1170,11 +1170,8 @@ int set_orig_insn(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
>  		int ret = is_optimized(vma->vm_mm, vaddr);
>  		if (ret < 0)
>  			return ret;
> -		if (ret) {
> -			ret = swbp_unoptimize(auprobe, vma, vaddr);
> -			WARN_ON_ONCE(ret);
> -			return ret;
> -		}
> +		if (ret)
> +			return swbp_unoptimize(auprobe, vma, vaddr);
>  	}
>  	return uprobe_write_opcode(auprobe, vma, vaddr, *(uprobe_opcode_t *)&auprobe->insn,
>  				   false /* is_register */);
> @@ -1197,7 +1194,7 @@ static int __arch_uprobe_optimize(struct arch_uprobe *auprobe, struct mm_struct
>  	if (IS_ERR(tramp))
>  		return PTR_ERR(tramp);
>  	ret = swbp_optimize(auprobe, vma, vaddr, tramp->vm_start);
> -	if (WARN_ON_ONCE(ret) && new_mapping)
> +	if (ret && new_mapping)
>  		WARN_ON_ONCE(do_munmap(mm, tramp->vm_start, PAGE_SIZE, NULL));
>  	return ret;
>  }
> -- 
> 2.55.0
> 
