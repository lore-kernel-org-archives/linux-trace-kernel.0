Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF773E3169
	for <linux-trace-kernel@vger.kernel.org>; Wed, 14 Oct 2026 21:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792014220; cv=none; b=dExG0i0EOs91k1pAWQ2tmuOL9zSNxL9qnKW/4ThI698BBs1OIphmk95ajo+hwpdRBt+GdxZzEXwdLe2YUSysaXR4+WzUjkHXRcxQiSp4yo6oYNMQ7zlYbOVsKteK+3iCtKGnnLjQ1H+KkX2E68Guodnx7WIXxjRZiwwiqDQ2W+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792014220; c=relaxed/simple;
	bh=e+rpqIT4zirx0GVPRZ66xQhWi5rRXE9U3uulpMKKe1I=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jbeCI+ATFnPmhUlNschatDL6O3XxWhn0kRRvvwnY9yg4qJQYbFtddLjTe4VxBxwmQnCw5rFK4oZH/+N75lKwPdp1Ovv4u0rqu6G6iMQcVlRw6VG1V4ATdSD+w+R4538MI0I0PoMd+QtrYoWHrRYNtUFhMak/Ytkl2GbkXHWLTqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=snNf3p3b; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="snNf3p3b"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a02667ccebso33753155e9.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 14 Oct 2026 14:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792014217; x=1792619017; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QUGjx1llrTDfPWrErlxQ+ApKB29LYnD9ZO445JdHHZk=;
        b=snNf3p3bwGCR4dibLc5GAnYl0JJ8iBqp4C3q8RW03SuUcXZF/DYo0LnZLawnx2k2Ly
         gfPghXSwhfEtF2744wIEevr3crQUeAvM/6czt4/bbPw5Hs8oKrmFciQt+sPXPnodnkQf
         SWl9KZ3RZtHOINKufPtYUDVwPEk9kzlBtDCnhTWz/Ngk4L8WL9/cMeL8UDsBiRmaAvCC
         AHelCPEPJjeN+acE1M0QmhEQEgNoGgWX71zflMM+sQ7cbiFTh7Un/uPW3gBqTE/5Fjqz
         p7O33utQWOc1XXpUosagySu/VZNmWa04LR0cYXsSNDzAmJ9GX5BtYgqMfyrMAW1pW9rx
         XMOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792014217; x=1792619017;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QUGjx1llrTDfPWrErlxQ+ApKB29LYnD9ZO445JdHHZk=;
        b=hdBoPTDMDVyTjT71rK1ndBxrGsbkDS+ft919JlouTMylMtRy5Ec0t9DuLhZMB+6GuO
         OMGMPDkuX887eq6X8rlz224FvEMOcRpnZbgY0UrG5LSYwn3yZ/MrlOOCTjI0hrHO35DM
         +Ee2TdopLgqBqcgBi9lnWJHK62K9LfzEc0byKjzUtAdlMYgvNI/CHgvfOq4CMwchlduN
         SvqnMHXTePycD9JxTb1Y7U8//DS55lhGBwWM03G7FqbxWNC/h2hzp+X/BZpPAHUB7SbN
         8SAjM5IMZqx9jRP0IyKiqAwKrsr1oXQMCoHWLN/AmZ5q4/y6Sx328EyGNE0jL2G5JrCE
         ncnw==
X-Forwarded-Encrypted: i=1; AKwUvBw6EH7jWieZDdMzohOpr85UTJGL3aCElmSamO9BeMdck3i2Rfnc33rRJm5Sd4JVvSTZLNh/WNcU3fr5ozSaLfNB8D0=@vger.kernel.org
X-Gm-Message-State: AFq9FYI8OtgEzSZ5JZPzkY4VCUD75L9EQrW9H6DJv/Q0uZMF1MSTR0zC
	+QaN+7IL0d32xYPo77ipzJKkm4cV/u5zW1+KKSURznOQtOqnoZNMSywH
X-Gm-Gg: AYBFou1JgheZZd6KsQvWh11TjiayTJaS4CXnBBI9WxA41oLb4WxdwZSrodjMRvMFIHc
	fLZIRSnDRNQ2CY52xnzUFp7Pcxt3VAast99VxBEc1m2pLc6xrK8s8gn77Srb84TDF5fAi7LuD0J
	fX88heStRas2y5JZdaufsU3Dt6YuyC4hX6BuGnjRMbLy0MGMGpu49asNZ4zGKNqELdYCrPD+JQz
	rwGlujB59my/S8DZL/0fhxDgPsom1qz6DVSqb4pWUvZHNPRI3Ds6ppwxUwVqCUC1L11fFSMVOGz
	FntWpHduXovRygjiQqfAo/zpyHBEa7SSmc7+xTnOLUepTB/+f3H9lBgZvnaGDcpp6F3Q4/mSJ8L
	035ONoELwIecqC43xwVch1yXDtLQEwajljSFB5rt5QkUB5D4rqBI0xHZ3j8CSrfFPKW6qwaFlC6
	t9sdw4kgk/L4sZwkfWrpEQI+uCkHHCW4rm/mbMMf/ptYxD9kwSJTWHSSNkVk9wSCObyRLQ
X-Received: by 2002:a05:600c:4708:b0:4a0:258a:b25c with SMTP id 5b1f17b1804b1-4a18e4da3c8mr339297955e9.29.1792014216881;
        Wed, 14 Oct 2026 14:43:36 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd66ab3dsm20882205e9.2.2026.10.14.14.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 14:43:36 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 14 Oct 2026 23:43:33 +0200
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Quentin Monnet <qmo@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Avinash Duduskar <avinash.duduskar@gmail.com>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Amery Hung <ameryhung@gmail.com>, Jordan Rife <jordan@jrife.io>,
	Rong Tao <rongtao@cestc.cn>, Eyal Birger <eyal.birger@gmail.com>,
	Pu Lehui <pulehui@huawei.com>, Jingguo Tan <tanjingguo@huawei.com>,
	Lin Ma <malin89@huawei.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 02/21] bpf: Drop unnecessary
 ftrace_location() in register/unregister/modify_fentry_multi()
Message-ID: <as_3hf7hfmaQjBFd@krava>
References: <20261012154024.29423-1-leon.hwang@linux.dev>
 <20261012154024.29423-3-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012154024.29423-3-leon.hwang@linux.dev>

On Mon, Oct 12, 2026 at 11:40:04PM +0800, Leon Hwang wrote:
> Since 'tr->ip' is already a 'ftrace_location()'-ed IP in
> bpf_trampoline_lookup(), it is unnecessary to call ftrace_location() again
> in register/unregister/modify_fentry_multi().
> 
> No functional changes intended.
> 
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  kernel/bpf/trampoline.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index 17f2a8133f61..21d460866dfe 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -1629,8 +1629,8 @@ static void ftrace_hash_add(struct ftrace_hash *hash, struct ftrace_func_entry *
>  static int register_fentry_multi(struct bpf_trampoline *tr, struct bpf_tramp_image *im, void *ptr)
>  {
>  	unsigned long addr = (unsigned long) im->image;
> -	unsigned long ip = ftrace_location(tr->ip);
>  	struct bpf_tracing_multi_data *data = ptr;
> +	unsigned long ip = tr->ip;
>  
>  	/*
>  	 * Different BTF ids get different trampolines, but they can still
> @@ -1651,13 +1651,12 @@ static int register_fentry_multi(struct bpf_trampoline *tr, struct bpf_tramp_ima
>  static int unregister_fentry_multi(struct bpf_trampoline *tr, u32 orig_flags, void *ptr)
>  {
>  	unsigned long addr = (unsigned long) tr->cur_image->image;
> -	unsigned long ip = ftrace_location(tr->ip);
>  	struct bpf_tracing_multi_data *data = ptr;
>  
>  	if (bpf_trampoline_use_jmp(tr->flags))
>  		addr = ftrace_jmp_set(addr);
>  
> -	ftrace_hash_add(data->unreg, data->entry, ip, addr);
> +	ftrace_hash_add(data->unreg, data->entry, tr->ip, addr);
>  	tr->cur_image = NULL;
>  	return 0;
>  }
> @@ -1666,13 +1665,12 @@ static int modify_fentry_multi(struct bpf_trampoline *tr, u32 orig_flags, struct
>  			       bool lock_direct_mutex, void *ptr)
>  {
>  	unsigned long addr = (unsigned long) im->image;
> -	unsigned long ip = ftrace_location(tr->ip);
>  	struct bpf_tracing_multi_data *data = ptr;
>  
>  	if (bpf_trampoline_use_jmp(tr->flags))
>  		addr = ftrace_jmp_set(addr);
>  
> -	ftrace_hash_add(data->modify, data->entry, ip, addr);
> +	ftrace_hash_add(data->modify, data->entry, tr->ip, addr);
>  	tr->cur_image = im;
>  	return 0;
>  }
> -- 
> 2.55.0
> 
