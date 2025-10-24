Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5EE15DBC1
	for <linux-trace-kernel@vger.kernel.org>; Fri, 24 Oct 2025 11:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761306196; cv=none; b=UUBuMF1l86KWzmcSsYS4pmtoo9cR8mnx8Vtmj3l4qjbBSksR3dCEL5XQK1WuMbaw1+mB7nV61btDX5ksjchwO76TjyANpAzfbasWkhSK9IFvhzqK/rUw4Tau0AWtqJwBs493nV5tCJSQbasc5GBOBUYy09+/VredSSpK7khuAxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761306196; c=relaxed/simple;
	bh=CZui3p+NqHREMsGpHs7m0KywPm9p3i9nKNibsoLTXQk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pd/QrHJrlvpEx7PWLtch0r+258Pyj5xNPJqb5cD0Nf7vA/gSJKHd959i3L0AQ/5eJhn/vIHkVoB63NLFJy1gza+SNXvgBoTT5wrWFCKduyDUe19zI6ppain9dm5IrCSODH1U2i+PtRE17Uw9cjcdbPxZttGvVgyTj9P0Jxl8BxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W2hd5zi8; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W2hd5zi8"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47495477241so16402095e9.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 24 Oct 2025 04:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761306193; x=1761910993; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b18S4CmbOg3TG3MbWQlCwD9e5ZRL2nAAZ1ZNc6R+a5o=;
        b=W2hd5zi8mg9GtsRG5T91H58HFZto2aJJx+TPEEcWinUhJfscrbebdirdaztL8iBBS2
         mw/KUhLy4BG62nc8GorAjoQM1JoiZhCT2rpNnTc5ggz0eGyIPMgAD5evmWpC40TBV1SX
         uqHnb7nMAb1dV8z5OpMGAkzPZOBKTf7ujwKGxsGgKItVNTKbirf/vAd3Q+OZer7yo51L
         InjYzdk+yTBxIhOW/9utgvKaF7oubSHVA3Kseydg7Ad0iQVDAj+Dj4P99evsN6WFtxF+
         iVZMpjv7stUYIBOjX4dqEcgxZPVJSsVkKAigz2/3Qt+98thKCW9szTMeNcOEUUU8iBC1
         S9Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761306193; x=1761910993;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b18S4CmbOg3TG3MbWQlCwD9e5ZRL2nAAZ1ZNc6R+a5o=;
        b=LutQ/ubnFZzkpbtLA7w1ZAO8najRxAks0Yboj4kBCjViue0yKmMOP06zA3IT15XXN8
         nCPXl6UdvOmuT4a0AwMJ1Pp1/duoo0OOLDvwVdJMDDHEoQW+SnasiD7EIuYvF+PKMbR3
         DRoag6pDjqLQI4xRZsqtfaXgjqVG6gemk14eO1FE6xYJIkXro56Ts9cpxupkBTZGjWgJ
         5AseC+8x2XPxIqcGXzjx4Xxc0K1H6P8s/oyHci/E1dHuQXgbsdQuYmL1qj4uNeU58A2R
         MMXnTc7oxf1p4EwmM3JQSwWcbOR18GfJbGsKeMR+dAchEER3zgslJ0AkTAwQCNGsIAbc
         MUlw==
X-Forwarded-Encrypted: i=1; AJvYcCUgBkbLumPPHI/vFYA3eUBM02c/wKNZKKZJ4ueyW8xhPtQMZrCaAVWAZYUnkVPz0ETalYN2/L7wPVTDZGtmDnijllU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrUOPn7uItb83dEnr7iX81zRzNIDdQ3jjQ+guPdDjAgSS+tnS0
	c9uYqHCOxLf+LjGoMyOK2/YHF/xuJVl2agPN9b/qfygNxAsUDND2DhGX
X-Gm-Gg: ASbGnctP4bjwjeHMmbtW3/rmEozdXte+QbO6DkVJk3teywG7LSGcdjBvqbWWzpjExW6
	IA6huc7knv3NbQjuG9UplYfZmSEJ/t17FRcivuqsd0tZYBqqyLZ6Px0cXOFTAxuaAlmpxNW64C7
	Qs+VWrfIK1EJN0LS00WFPpIaCpvkRvaMZJi9b/E0fxkGroxZHUg671x+ffCjTnXg/U1Hj2CzL7p
	zR2Y7q38ZPSVBuzEh05W0yclXRiRVQdlYcl9cDNEdDJ43CzUAm7/2UMvh2+jST/dKkNqlR2WM5f
	k4cfYtH+9jtOTT0Nkdf3qXpU5agytqynh9t/p32EL0QFgrbHvCjmajqY/8GA6UmdXHmz0LKNCm6
	ygxG+tAPAICehvz+xCrjt8RB7ZxOWd29tP4CthUx9pb+JmOaETw==
X-Google-Smtp-Source: AGHT+IHpcyD6w06WvdrfkL+V8Avu/JoPzLSg/RttGHw9HhPaiYsYuNKZcx58iYrmG4o++/6PM8eOHg==
X-Received: by 2002:a05:600c:4f09:b0:471:a73:9c49 with SMTP id 5b1f17b1804b1-475caf930dfmr55560595e9.2.1761306192938;
        Fri, 24 Oct 2025 04:43:12 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47494ac30b4sm82187635e9.2.2025.10.24.04.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 04:43:12 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 24 Oct 2025 13:43:10 +0200
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	live-patching@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, rostedt@goodmis.org,
	andrey.grodzovsky@crowdstrike.com, mhiramat@kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH bpf-next 2/3] ftrace: bpf: Fix IPMODIFY + DIRECT in
 modify_ftrace_direct()
Message-ID: <aPtmThVpiCrlKc0b@krava>
References: <20251024071257.3956031-1-song@kernel.org>
 <20251024071257.3956031-3-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024071257.3956031-3-song@kernel.org>

On Fri, Oct 24, 2025 at 12:12:56AM -0700, Song Liu wrote:
> ftrace_hash_ipmodify_enable() checks IPMODIFY and DIRECT ftrace_ops on
> the same kernel function. When needed, ftrace_hash_ipmodify_enable()
> calls ops->ops_func() to prepare the direct ftrace (BPF trampoline) to
> share the same function as the IPMODIFY ftrace (livepatch).
> 
> ftrace_hash_ipmodify_enable() is called in register_ftrace_direct() path,
> but not called in modify_ftrace_direct() path. As a result, the following
> operations will break livepatch:
> 
> 1. Load livepatch to a kernel function;
> 2. Attach fentry program to the kernel function;
> 3. Attach fexit program to the kernel function.
> 
> After 3, the kernel function being used will not be the livepatched
> version, but the original version.
> 
> Fix this by adding ftrace_hash_ipmodify_enable() to modify_ftrace_direct()
> and adjust some logic around the call.
> 
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  kernel/bpf/trampoline.c | 12 +++++++-----
>  kernel/trace/ftrace.c   | 12 ++++++++++--
>  2 files changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index 5949095e51c3..8015f5dc3169 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -221,6 +221,13 @@ static int register_fentry(struct bpf_trampoline *tr, void *new_addr)
>  
>  	if (tr->func.ftrace_managed) {
>  		ftrace_set_filter_ip(tr->fops, (unsigned long)ip, 0, 1);
> +		/*
> +		 * Clearing fops->trampoline_mutex and fops->NULL is

s/trampoline_mutex/trampoline/

> +		 * needed by the "goto again" case in
> +		 * bpf_trampoline_update().
> +		 */
> +		tr->fops->trampoline = 0;
> +		tr->fops->func = NULL;

IIUC you move this because if modify_fentry returns -EAGAIN
we don't want to reset the trampoline, right?

>  		ret = register_ftrace_direct(tr->fops, (long)new_addr);
>  	} else {
>  		ret = bpf_arch_text_poke(ip, BPF_MOD_CALL, NULL, new_addr);
> @@ -479,11 +486,6 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
>  		 * BPF_TRAMP_F_SHARE_IPMODIFY is set, we can generate the
>  		 * trampoline again, and retry register.
>  		 */
> -		/* reset fops->func and fops->trampoline for re-register */
> -		tr->fops->func = NULL;
> -		tr->fops->trampoline = 0;
> -
> -		/* free im memory and reallocate later */
>  		bpf_tramp_image_free(im);
>  		goto again;
>  	}
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 7f432775a6b5..370f620734cf 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -2020,8 +2020,6 @@ static int __ftrace_hash_update_ipmodify(struct ftrace_ops *ops,
>  				if (is_ipmodify)
>  					goto rollback;
>  
> -				FTRACE_WARN_ON(rec->flags & FTRACE_FL_DIRECT);

why is this needed?

thanks,
jirka

> -
>  				/*
>  				 * Another ops with IPMODIFY is already
>  				 * attached. We are now attaching a direct
> @@ -6128,6 +6126,15 @@ __modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
>  	if (err)
>  		return err;
>  
> +	/*
> +	 * Call ftrace_hash_ipmodify_enable() here, so that we can call
> +	 * ops->ops_func for the ops. This is needed because the above
> +	 * register_ftrace_function_nolock() worked on tmp_ops.
> +	 */
> +	err = ftrace_hash_ipmodify_enable(ops);
> +	if (err)
> +		goto out;
> +
>  	/*
>  	 * Now the ftrace_ops_list_func() is called to do the direct callers.
>  	 * We can safely change the direct functions attached to each entry.
> @@ -6149,6 +6156,7 @@ __modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
>  
>  	mutex_unlock(&ftrace_lock);
>  
> +out:
>  	/* Removing the tmp_ops will add the updated direct callers to the functions */
>  	unregister_ftrace_function(&tmp_ops);
>  
> -- 
> 2.47.3
> 
> 
