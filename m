Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F27621257E
	for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Sep 2025 15:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758728544; cv=none; b=XbS0wzK0tqrxSXnTx0jlcPc2s3+sX+IqHf24S0zTW7u8Ik0ty48ZsZW5FjEv6HPjRb74O91wN+Rlgcaz4Y/GOAjnCwQGG5txMSAyGf2U480R+fsk8XNEFnHy4MmLmNzxaqL/Y4LB3jI+pMupy44aqaGEz/9F1qW+iCLGNb0uD3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758728544; c=relaxed/simple;
	bh=20vf8MIfcOOTOyvo/9xRmTDvKyBmElpBdVToJq0DjdU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KcOzWtqImG2TtKpmJNfR+MoFP/BvIIPeEQVQSDsDd6gYLxI4xCZriyvtMlCLYvkwb+EKQUcej43tihwcp8j3H6uQ/Y0d1jXCwBdIWFN58uRvSfJkM8mvcjsyhkuUuBt9H9f8FH6LRYqp2fVFRA24JgLgyMNBaFgYWcwu8LJxT+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J0Ry6iG2; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0Ry6iG2"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3ee13baf2e1so3583f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758728541; x=1759333341; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L/zCkLJ/tAP0MvUebDdhfKxISOr0VaRLT4RSkHZQ/bE=;
        b=J0Ry6iG2r/SifHFUCWPHtJZ3IX64ZxxR+0cnwmJiHyWVHvNoQFJzurF0RatrAlUlqV
         7iCq8Hu6S9A7N6sUoxB3NAwOm95kEetwkeyjBQYJuTeEuBL//z5VNbc73/U7JL76Pc35
         kpy4iFLJXY59QPX1vuNFF+X/c2chQu+g40z5rOkwiRKEreckxK3A/gGvWvobdu3nIh6T
         pNGkVDV4Nl5eEjCEemXAmoaATtddQww0uBod7gdb0XN5DZrh6NpJmdnpXbnAk+izvvNm
         f0Y3QmR5h9kBjNNk8rdRLQ1OHaND+i6ePj762aOpcwpcbdb+fcyHgjO2OfDnv9iIW/rl
         o6Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758728541; x=1759333341;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L/zCkLJ/tAP0MvUebDdhfKxISOr0VaRLT4RSkHZQ/bE=;
        b=KySMzvPrriTZzh/0vecm7z63W225FqAuqKdxNlr89nBBFUKZxatIP0/HphM7KC8RmJ
         rWW5PU5APbRBzzNyxdocq5KKRewZMXVIvft0KGM9Fqq94dBm1ftUOJy5xr9ZCYL7p9w7
         eU+daZ1auF/njArIzVsmLu9bP4DelWFKlrsV0UMRztgYA/BC0wkAouheaUM5r5THMHYZ
         2I6yVk0a1hQFRPHjkiGftZPlPuBdhNfX+I26YTUvcqyRa2UY40UWV7PAcvShqI4bppO6
         6uUbAPIQDYiZf8jsZYvipMAlFGbfWmeDHgOETN6A/GRTBveAJ7g6Im0wn+9TjuJuUhW3
         gs8A==
X-Forwarded-Encrypted: i=1; AJvYcCXNpFZ+2n2RZioMPv1gRJIbtZ4LsXEOqZ/dJH2GfNS/NOb/adQ34yQasX823enV5P2Bw0q9VRtwdVKVlNBA2gNuONc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt6VcAJqEtKItvLYbgQ/Rl0wl21PT6l5DGyqdqmnFKHMISX7xp
	HMh/1jC8I58x4i8qf5rLVelpUdxLeS2KKkEEy3qdCkagScfGoKitC9e7
X-Gm-Gg: ASbGnct7eVGQ4qizR59bo4wkT3p8Of7SOl0FYCPeKVVIY4fkQw3atk8dme02fV03Amu
	wQHwK38D9VqD74nF0mwa8I6GmcIORe22LiL9cEZazOaOXkoT7PIYEmAzXaqlIapg2nnHn4vbmz2
	88FzLRr2XUAP+PHg9nlMf0J8VRumB3H3WPEQLIxZ6mHTab5ze0uGenBwpgUK5mMFc8SF3CmroU/
	a6ed5zS0ZQOdoiQe6QNxQalGTj4FhyqxK3RLik9m3oujZtYEGC65gP1fTz8b7P/LFHJaTO4GQO9
	obWBLx0F/pbZZIjhZe9zCxzWwgJFFJh0zABIutiJ+9pXpUtGEf+Z+yW/YDmyy9CJ5MYc5uzu
X-Google-Smtp-Source: AGHT+IGLTOf1jm7exVsmcXsctHj+zPS0JPgI2KUuGj0PB5VIe8D8ekaVPCFkj/mn7VqohMIXLmygfw==
X-Received: by 2002:a05:6000:2404:b0:3ea:e0fd:290a with SMTP id ffacd0b85a97d-40e458a947bmr353578f8f.12.1758728541123;
        Wed, 24 Sep 2025 08:42:21 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::31e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2ab61eecsm36596225e9.20.2025.09.24.08.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 08:42:20 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 24 Sep 2025 17:42:18 +0200
To: Feng Yang <yangfeng59949@163.com>
Cc: mhiramat@kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
	ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
	eddyz87@gmail.com, haoluo@google.com, john.fastabend@gmail.com,
	kpsingh@kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, martin.lau@linux.dev,
	sdf@fomichev.me, song@kernel.org, yonghong.song@linux.dev
Subject: Re: [BUG] Failed to obtain stack trace via bpf_get_stackid on ARM64
 architecture
Message-ID: <aNQRWlNIno3ThMkv@krava>
References: <20250924003215.365db154e1fc79163d9d80fe@kernel.org>
 <20250924062536.471231-1-yangfeng59949@163.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924062536.471231-1-yangfeng59949@163.com>

On Wed, Sep 24, 2025 at 02:25:36PM +0800, Feng Yang wrote:

SNIP

> > Hmm, can you also dump the regs and insert pr_info() to find
> > which function fails?
> > 
> > Thanks,
> > 
> 
> After testing, it was found that the stack could not be obtained because user_mode(regs) returned 1. 
> Referring to the arch_ftrace_fill_perf_regs function in your email 
> (https://lore.kernel.org/all/173518997908.391279.15910334347345106424.stgit@devnote2/), 
> I made the following modification: by setting the value of pstate, the stack can now be obtained successfully.
> 
> diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
> index 058a99aa44bd..f2814175e958 100644
> --- a/arch/arm64/include/asm/ftrace.h
> +++ b/arch/arm64/include/asm/ftrace.h
> @@ -159,11 +159,13 @@ ftrace_partial_regs(const struct ftrace_regs *fregs, struct pt_regs *regs)
>  {
>         struct __arch_ftrace_regs *afregs = arch_ftrace_regs(fregs);
>  
>         memcpy(regs->regs, afregs->regs, sizeof(afregs->regs));
>         regs->sp = afregs->sp;
>         regs->pc = afregs->pc;
>         regs->regs[29] = afregs->fp;
>         regs->regs[30] = afregs->lr;
> +       regs->pstate = PSR_MODE_EL1h;
>         return regs;
>  }
> However, I'm not sure if there will be any other impacts...

nice, the test works for me with this change.. could you please send
formal patch? I can polish and send out the test [1]

thanks,
jirka


[1] https://github.com/kernel-patches/bpf/pull/9845/commits/11b31cd465a83b8719cb06331c8e81794cca40fa
