Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E864430E0EB
	for <linux-trace-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761554910; cv=none; b=SvPOgjlaZPMGH1Rn2HraIXWNp6edhOZKAbJbogVVd24/O7N0nM2cL//PAY1MHwxH1iD+e08wOw/8yVTH8QKJq2a7imrt+NVlltgS3dcUeSYW/kRDoRFNljGzTvi0QN8/s+jUsQX1epH0XOeduoS6vdku1id12lySSeSU8FcJ+Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761554910; c=relaxed/simple;
	bh=PmYS6PWxr9X5njumKahKuZHCdaqOv/MkOKIGh/4DVSQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=APhOUF6nV0LdNOpk4FzQMCMRo0oGskYpjgcCZ/F09bvI+PHpa1wKWn1azsIjPh2vwm6oO0Ebaq8SligJN+RMCXumxSmWvxcRWGwwMRdjC/ANTbIMHviY45mrkWwCY+5MawqEN3r4EF2+rhO/NTzBt82aPaodIBpD6YLAY5gFQuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lwMTYGAW; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwMTYGAW"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-474975af41dso30597095e9.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 27 Oct 2025 01:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761554907; x=1762159707; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FHn4VCXJ8SziL5HVs3tOncztpHETMhRaig+hCm1znNA=;
        b=lwMTYGAWb99TokaCQqpwCaBPW/gX12s6MlcZNow0YudLP8bl/uTaOyjhFrwsZXsiaZ
         So7FIqDiFwJf0eF+Tre895PY+Ye0WT5iOeeyQ33RPLPCuzdigjV5ALXIDPvjiQLzi7tf
         afh2Qk8BdqAwF5DA1PECXgT/qLFruyDnYI/axfe0nrs5L08bien/BESoXdTA3Z+n2vKi
         zLPC/VhFQkiTk7uQxvuMfHd/qPLAGnxnZFIIUxKJiE3hi68uKeAB3TcHzgWwhk8DNXcQ
         GoL0W5yj2YQh/7Ctyu3gLrOtIul+2ZfMdXsfgbE/yFXY0xQYDZs53xCrj4HhfMASG/Xi
         5sFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761554907; x=1762159707;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FHn4VCXJ8SziL5HVs3tOncztpHETMhRaig+hCm1znNA=;
        b=mDskkyVRX097/q8vbYvaqTmgT3gG44JAXHHU9JYyPw6PW2ZPzErlnPBYAqitMZ8CT3
         zq9gfVchLv4uSnOtd1pAL9dvPXXTu4Mc1q9/hSwBYKTKP7yUmDYuLXilSWSTtlYwFIHx
         CinAJbheXDpsIGkdSnM/7tHJ9p2OOytak6g90JNtKZz9JTRIC8Sh6NY3yqgnAws70pWy
         n3LDaRNqtLZ4RN1dP5pSlUsgsGDfAXsViW4qIXFufhy/Nzkpfk1L9pmSltWJFKL6BYPj
         0Re9X9xL95TUHLKPdCLPBxNX8ml36rfqfV63gcp3VsvJi02mUUIUxVr/lK8U8kjm1lc+
         QRYA==
X-Forwarded-Encrypted: i=1; AJvYcCUgEv9WfEoW2P0fAYopdE5f1cAyP6PwGGLytjSWJcTZ/3Vk+dnsuKCes467U0xqrog2GpdnPf6iO15qZ6rmR0LQZ/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpY3zBohGo/YPA5akjprMm8BQ1P7jHFePYfrVAikvzXSJ7gwho
	YkqQe6JxIqq+C1eqcl0mcsfkhP1MWnkihb51TOQU9BgStgcyhhf192/c
X-Gm-Gg: ASbGncvbbIIiDXfUOOaEvLn9iZYcigTpw/ZlphfhR03jwJU1H0StOduIGsb0XoON3Gu
	JbJZWAxOkd6qhQ53BCcH0BfJogN5mrqFmSiFWqSCtOq9HE9K/SOp7qwre8G1MvUsz5EfwNBKG35
	e4R5Gxi/PzdpxDCGcy1BOLAQGi2eGxLAoFxdq0naxDfkDqqOIi8JXVoPcXNu/QVvmyWdNg60PxR
	jNZa3IgXuZjWojVLua3nrwboYDLcGOpDhxoMYsB/xK3oPkjS2M1PiQ1hFu6dtKRzH8iVaisI9Eu
	pNEGBuBdqV80rySrR6uDcp8goiWiFLvbS4qM7SMtTnA8ys0xZyTLwIYpq4MW4QiAuA7GcAhb/h+
	fcFaBrDItMVq76Eaivt8jiduXK0iBjcFWtbeXuQtkAQgmNzsO6A==
X-Google-Smtp-Source: AGHT+IHGcNgsZtpIZ/JkOF1/9PEl8oxrEAXu3mnuSHi1k7QQS73tGtoaR+vym+DbF4opCAfLJwPmKw==
X-Received: by 2002:a05:600c:3548:b0:471:131f:85aa with SMTP id 5b1f17b1804b1-471178a74a2mr226893315e9.13.1761554907197;
        Mon, 27 Oct 2025 01:48:27 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952cbc16sm12690740f8f.15.2025.10.27.01.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 01:48:26 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 27 Oct 2025 09:48:25 +0100
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	live-patching@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, rostedt@goodmis.org,
	andrey.grodzovsky@crowdstrike.com, mhiramat@kernel.org,
	kernel-team@meta.com, olsajiri@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH v3 bpf 1/3] ftrace: Fix BPF fexit with livepatch
Message-ID: <aP8x2VthUhZf4QVv@krava>
References: <20251026205445.1639632-1-song@kernel.org>
 <20251026205445.1639632-2-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251026205445.1639632-2-song@kernel.org>

On Sun, Oct 26, 2025 at 01:54:43PM -0700, Song Liu wrote:
> When livepatch is attached to the same function as bpf trampoline with
> a fexit program, bpf trampoline code calls register_ftrace_direct()
> twice. The first time will fail with -EAGAIN, and the second time it
> will succeed. This requires register_ftrace_direct() to unregister
> the address on the first attempt. Otherwise, the bpf trampoline cannot
> attach. Here is an easy way to reproduce this issue:
> 
>   insmod samples/livepatch/livepatch-sample.ko
>   bpftrace -e 'fexit:cmdline_proc_show {}'
>   ERROR: Unable to attach probe: fexit:vmlinux:cmdline_proc_show...
> 
> Fix this by cleaning up the hash when register_ftrace_function_nolock hits
> errors.
> 
> Also, move the code that resets ops->func and ops->trampoline to
> the error path of register_ftrace_direct().
> 
> Fixes: d05cb470663a ("ftrace: Fix modification of direct_function hash while in use")
> Cc: stable@vger.kernel.org # v6.6+
> Reported-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> Closes: https://lore.kernel.org/live-patching/c5058315a39d4615b333e485893345be@crowdstrike.com/
> Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
> Cc: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Acked-and-tested-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  kernel/bpf/trampoline.c | 5 -----
>  kernel/trace/ftrace.c   | 6 ++++++
>  2 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index 5949095e51c3..f2cb0b097093 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -479,11 +479,6 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
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
> index 42bd2ba68a82..725c224fb4e6 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -6048,6 +6048,12 @@ int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
>  	ops->direct_call = addr;
>  
>  	err = register_ftrace_function_nolock(ops);
> +	if (err) {
> +		/* cleanup for possible another register call */
> +		ops->func = NULL;
> +		ops->trampoline = 0;

nit, we could cleanup also flags and direct_call just to be complete,
but at the same time it does not seem to affect anything

jirka


> +		remove_direct_functions_hash(hash, addr);
> +	}
>  
>   out_unlock:
>  	mutex_unlock(&direct_mutex);
> -- 
> 2.47.3
> 
