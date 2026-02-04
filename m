Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07A52DC336
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Feb 2026 21:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770241717; cv=none; b=OpIyrdUJnFbhDKLvrj7uGgdThES1fENMJSO1ruGBTKk52yXzcTQgvmwdJC52PyorYq7yN++NiNFA0LGNYN1UPtn/BRqod3yQhTHSxjz6BSypqFbHjCBshOLFN0SKgI2ts91aPrKWjzJGZ0rN0dj59zABDyg/W9hG3ajTtA4pwVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770241717; c=relaxed/simple;
	bh=1KZ018kUPMw9qI792KpGBlzWvomYWl41XVcfUw8LMrk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KowBRGbd9bw6Rx5F6/wSc4ucF85PcEhXZ7sMNFrCvFqHqT8noKnG7okrxQ+Pk/xJT1z1+vEuTJcWgk35T6TaC6zoFCjI5XmMcXcfrywTJb6bKw/k1ie2me9eiKJed/6/7Ko2iVn5Q18XElZooXc4DRWoY/YNVJGdywb0jQ0+J8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lWsjvGht; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lWsjvGht"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47edd9024b1so1792415e9.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 04 Feb 2026 13:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770241715; x=1770846515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zcPMojFtNP9Jk9YNPT9Fw7Ym2BA0Ww8jL8JoDbOk6HI=;
        b=lWsjvGht7TvNVjEPEmKCuvFwyjYLbspdoOxaun+4aF4eEkZY0+1K0WP4QSRFUFeZ7H
         M4XyMUfOf8o3oGx1lFcoA1tTFCOyBzMd5z/adUcLd2oalH7avUNX0wqQmAdPoYNogjbm
         qu4OO41bzHUXk102rfiqe3xbrcStJekbmya9mQt9QYjm19VGyb/YrWn+WhzDEN0M9CiF
         oeqjVXF4mvzcG4OKqpbTCKljaKVN5kWYycnUUPpZPa42ZPXoJZFxhzM68doTzk5k/gWQ
         jwVoUV43Mu7cuXnpSqeC58l81AuSogknyHkEUgCniCmfeouEisyIpygEHydDLcjurxlR
         UInA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770241715; x=1770846515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zcPMojFtNP9Jk9YNPT9Fw7Ym2BA0Ww8jL8JoDbOk6HI=;
        b=WQBaBW/QrdqhH9Jrsd21Bt5ovMeQAMgj1E//SiBvWDuZzLWif1SYbG90PQBw5wnlMm
         ieFupRVBFT+VLLPfDmKnixTBZEX/HLmhXKggBofTRrYGeJQ+coCoTMMMg8pc0sHeqSz/
         grMdPJx8UKLiRL+2d2z4jofW5Xnz8d0gXvRCGvqUH/IU27GFYB1F5sNBIpOxNwRMOeYS
         KHHsg17JQrzYYVhr69mXmiJCzr78mKmmRRGz8x8akJcVQxTRzW0qRWcXLPUVp0C41iF1
         sUvS+lwyoaTSI0yZJ3Og0LDyX0Pu+FFClK3rdybCzSxxNQHAxIeRL3ylc00Bb19wG5AW
         Uqig==
X-Forwarded-Encrypted: i=1; AJvYcCVtIlT0poeZ5b7s0zh4OTvNzQGYONfV2oj2xJifwIw6dUWkfD+S7xjxoytIjkl8RoU060+u77ybiWFJkV6v7FOdllI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvdqESgR2QdoWEMRl0/BfAXtsaGpbrHtJgfBFsyyyX5/tnjvD1
	i3D9gO3U78bbrG9aYT3wHDGmzZzXUmW8osqCBSL9f7Ex+6nnN924aNa7
X-Gm-Gg: AZuq6aLDVNhzNRMDlIGyyi30Vt9HHBdCQF3LWPvzI5i7qKBJezqoCSGJ1/4axBP32Kh
	lN9E6FvpII5P9AyxamOoXkBdctbN9Cq1flRetA9BlXkrxN9U9bacWLdEyBGXz91Yxds426ziE2E
	UQbLnDagp5v1EEg59XxpBonMmYpdLOBglY+2fyz9hVIToN5nDL27OLnDy60HvK89MHh2KA1VgCP
	Czs26T8ISiJ2pq8JXtTk8I7L2n5OgnbYy0jit6Fz7iRv+kNDjOfFIIL5NuXG2Hvf40W9tqxhxQl
	hFc9OVEjWliC6we5A24vuREBeTIaDj7MfPPlcfmSDJdX2FnRWV7Kd+uWZmCykaCEjJPqEpAUPHE
	VUGdkH0PFRHeS0d+l6RYPUbQil3qjlIFNZUvrL21NSADJzGfNUN+E2eGhg18XMlI0qoZ4ZyQRDK
	VJ+E4CHzXGBQqE1JIFKe1S2T4bxG10xrGZ0JMy5X5VneKYtngI6NzA
X-Received: by 2002:a05:600c:1e1d:b0:47a:814c:ee95 with SMTP id 5b1f17b1804b1-4830e94d478mr60878595e9.12.1770241714807;
        Wed, 04 Feb 2026 13:48:34 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43617e250b2sm10401456f8f.8.2026.02.04.13.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 13:48:34 -0800 (PST)
Date: Wed, 4 Feb 2026 21:48:32 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Anna Schumaker <anna.schumaker@oracle.com>, Jeff
 Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, Simon
 Horman <horms@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Yury Norov <ynorov@nvidia.com>, Randy
 Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] tracing: move __printf() attribute on
 __ftrace_vbprintk()
Message-ID: <20260204214832.238f159b@pumpkin>
In-Reply-To: <20260203164545.3174910-1-arnd@kernel.org>
References: <20260203164545.3174910-1-arnd@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  3 Feb 2026 17:45:29 +0100
Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> The sunrpc change to use trace_printk() for debugging caused
> a new warning for every instance of dprintk() in some configurations,
> when -Wformat-security is enabled:
> 
> fs/nfs/getroot.c: In function 'nfs_get_root':
> fs/nfs/getroot.c:90:17: error: format not a string literal and no format arguments [-Werror=format-security]
>    90 |                 nfs_errorf(fc, "NFS: Couldn't getattr on root");
> 
> I've been slowly chipping away at those warnings over time with the
> intention of enabling them by default in the future. While I could not
> figure out why this only happens for this one instance, I see that the
> __trace_bprintk() function is always called with a local variable as
> the format string, rather than a literal.
> 
> Move the __printf(2,3) annotation on this function from the declaration
> to the caller. As this is can only be validated for literals, the
         ^ definition ?

	David

> attribute on the declaration causes the warnings every time, but
> removing it entirely introduces a new warning on the __ftrace_vbprintk()
> definition.
> 
> The format strings still get checked because the underlying literal keeps
> getting passed into __trace_printk() in the "else" branch, which is not
> taken but still evaluated for compile-time warnings.
> 
> Fixes: ec7d8e68ef0e ("sunrpc: add a Kconfig option to redirect dfprintk() output to trace buffer")
> Acked-by: Jeff Layton <jlayton@kernel.org>
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: included fix for regression reported by kernel test robot <lkp@intel.com>
> ---
>  include/linux/trace_printk.h | 1 -
>  kernel/trace/trace_printk.c  | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/trace_printk.h b/include/linux/trace_printk.h
> index bb5874097f24..2670ec7f4262 100644
> --- a/include/linux/trace_printk.h
> +++ b/include/linux/trace_printk.h
> @@ -107,7 +107,6 @@ do {									\
>  		__trace_printk(_THIS_IP_, fmt, ##args);			\
>  } while (0)
>  
> -extern __printf(2, 3)
>  int __trace_bprintk(unsigned long ip, const char *fmt, ...);
>  
>  extern __printf(2, 3)
> diff --git a/kernel/trace/trace_printk.c b/kernel/trace/trace_printk.c
> index 29f6e95439b6..48c085fcae7a 100644
> --- a/kernel/trace/trace_printk.c
> +++ b/kernel/trace/trace_printk.c
> @@ -197,6 +197,7 @@ struct notifier_block module_trace_bprintk_format_nb = {
>  	.notifier_call = module_trace_bprintk_format_notify,
>  };
>  
> +__printf(2, 3)
>  int __trace_bprintk(unsigned long ip, const char *fmt, ...)
>  {
>  	int ret;

