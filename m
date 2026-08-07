Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FBD38238A
	for <linux-trace-kernel@vger.kernel.org>; Fri,  7 Aug 2026 16:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786121467; cv=none; b=smTDqYqplDQ0O4JZNi34MVF8ttAcrZ+I8EB2baPoKEHQrxmADbnH4jQx1XqSucDDqWNtlswVY4eH+k2jGWSquxkjZ/ce2U4myNBezNSxhVBti4iRCmo5YtMkqzzQwWogXI8dOV5vGYpJaRE+lseqfrdE9xI/hyWh3BUxdrHosPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786121467; c=relaxed/simple;
	bh=IJCwJQiUguUfBhKCDYdBFJgM3eIUSZS7XYSJDOV7g4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=II1qUtedZFXHvqDWc67GYIawle5B57TWo8Xb+MF+CuwuaF49UAholiggsnp44uzewvpx6zUPgUKx8ajiW9Z9z9FTCpmXwOuRAtd+CRZpMhlp4BxC1P45siOS3YsWnA0w6lIEiAM5u9R7vbXtq4juaOxXmU0hwGjjm5Jiml7oaSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i0sIN2jI; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i0sIN2jI"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6a1542cdb53so3512543a12.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 07 Aug 2026 09:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786121464; x=1786726264; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MLgJCZYd3TMgBvl5sFO1jBIW+z0hNDyfctOH/YLI138=;
        b=i0sIN2jI/3E3Kw0hL/PmXBcZSlQyFOEzg/GRnTTqmIvAqzbXEr5nYAEGePLwH6Gr1v
         Qr94pLLB9LXvBI+2o8mZ1808vKj0n7tAjnDl140sl5w9mTSolFmpDGk7cZP2/KykFW3s
         AqEzdsG5/1WfSD+Xylumi+rto40wKRJgKK1uGrgulTzdAZX4ldu81UOQui3aEvDisGMS
         3OsGs3U+I9IVY1+1kin9xJHJCKskFBDLaJHWXthTQo/DbqEDXUcKNmqsharjgx9SmVJR
         TMzw0M6B0eSfyEucWAF38i8R3kYNP7KJ9UTxZVcBnNMZJRMFNKQ6Slvxqdcw+RfhJ5Go
         iTMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786121464; x=1786726264;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MLgJCZYd3TMgBvl5sFO1jBIW+z0hNDyfctOH/YLI138=;
        b=KhJxjYzw+d5hz/A/xjqCRb03KCrO9lr7g1ZOPo+bDtGvd0tuOkdnwuYxX4uSpCsOdp
         KWg+s4hPxTewcX8IL+gzamp0XSl+3WxZjzvr03uuJjG3+POPudmg0VnZjexgNxTaK+hG
         4m+wPFNcFjTtQx+pApX+qJZTW1xUkmw5DoiILDKZWmtcldSdCa74dQIK92iOACSm3K8t
         cFeoh8RGzbFe0s55EAbWT3VwyKgcAS4FaTrSrgQx1uA9JwoIU4hgBnhb+5zRN4LzSMqo
         lkJ40+SlBGa614TRHwJ8CrFyAZB6FxhFqe38HOVgk8MjRq12Yz/VTr7VmP9brpBbb7uF
         cccw==
X-Forwarded-Encrypted: i=1; AHgh+RqOljH9UwniNSHg/UuSRuKM1OpeP3wIru4Pv6ouAE0Q39hpe0vXeB2YzGQg6R172d3yNLjSypscbjAN3OyBV/BB+PM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvWnhI3Cos58HI5LUDjdLxUJLnqpl5yLgvHuVoSmkj5TLG5mtO
	lcg5H0cYqDrGavSK0xS6rv/EL8tDGrF0JXErAgbcbweKxLZPLwJ8+9v+1ogCa0dZGw==
X-Gm-Gg: AR+sD119eejehrktskHociDW5WK35Y93AeCOGxMGKo/TjWUOBuCQqZHa+kbj5u9SblZ
	rXI1WXpVTcDYeIWdMTjgG0Rwo9ezSN5WdYIAbzJ+F8P7h8L5zOPOOT3nnSW+YuIrT21V68BjHsF
	xI6odUPjm6hMxyLCRpmOpVI2nfTgmCMLXqnKlyJXKllkXZ/nUcDTxjbm3/qtStVonAgqE89XMy3
	xeA8vw0cRq+iOxtReJdXw0t9Kqsdb5Ve/6bDnl9I/zsWCNRGhc8Z5T/eXpBV6db1o753ggHHyms
	QvZuh3z1MRq5jWBJgrnWKTkd0AeC/j+suMUC1kTaloTGS8twwYZ9giy3QPA7N1hxsqajITZdym5
	pVca1YstUT1vFYi2P3XIJw+L0k09eTkg99jD+EdiJEtUGl+TUr9EID+3GcSZxTO9gIqSDbBs8ll
	gETnVM4dm3oNMgcX2clu3mFgg0FZK0+yWvagiGrzbkov8EjvgUHR9NSWaRTxIBBbuOfBdMgwIQg
	YBTMrRLQEs6JImvV+iUWVRTwc78GK/t
X-Received: by 2002:a05:6402:a5cf:20b0:6a1:8d1a:816b with SMTP id 4fb4d7f45d1cf-6a18d1a82e5mr6538410a12.11.1786121461958;
        Fri, 07 Aug 2026 09:51:01 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a1e7d73f57sm749588a12.29.2026.08.07.09.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 09:51:01 -0700 (PDT)
Date: Fri, 7 Aug 2026 17:50:58 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Hui Su <sh_def@163.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] ring-buffer: Fix crash passing ERR_PTR to kthread_stop()
Message-ID: <anYM8rwjZC8a6Jl6@google.com>
References: <20260807154145.2846521-2-sh_def@163.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807154145.2846521-2-sh_def@163.com>

On Fri, Aug 07, 2026 at 11:41:46PM +0800, Hui Su wrote:
> In test_ringbuffer()'s out_free cleanup loop, the check
> `!rb_threads[cpu]` only catches NULL entries and misses entries that
> hold an ERR_PTR.
> 
> rb_threads[] is static, so unassigned slots are NULL. But when
> kthread_run_on_cpu() fails for a cpu, it stores ERR_PTR(-ENOMEM) (or
> -EINTR) in rb_threads[cpu] before the creation loop jumps to out_free.
> That entry is non-NULL, so the old `!ptr` check does not break, and the
> cleanup proceeds to call kthread_stop() on the ERR_PTR. kthread_stop()
> then dereferences the bogus pointer, crashing the kernel during the
> late_initcall self-test.
> 
> crash logs:
>   BUG: kernel NULL pointer dereference, address: 000000000000001c
>   Oops: 0002 [#1] SMP NOPTI
>   CPU: 1 PID: 1 Comm: swapper/0 Not tainted 7.2.0-rc6-dirty #7 PREEMPT(lazy)
>   RIP: 0010:kthread_stop+0x2e/0x220
>   RBX: fffffffffffffff4
>   CR2: 000000000000001c
>   Call Trace:
>    <TASK>
>    test_ringbuffer+0x1ec/0x650
>    do_one_initcall+0x6c/0x2c0
>    kernel_init_freeable+0x21d/0x420
>    kernel_init+0x15/0x1c0
>    ret_from_fork+0x21b/0x320
>    </TASK>
>   Kernel panic - not syncing: Fatal exception
> 
> Fixes: 64ed3a049e3e ("ring-buffer: make use of the helper function kthread_run_on_cpu()")
> Signed-off-by: Hui Su <sh_def@163.com>
> ---
>  kernel/trace/ring_buffer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 8e2485bb3aa8..6af7e36ca526 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -8214,7 +8214,7 @@ static __init int test_ringbuffer(void)
>  
>   out_free:
>  	for_each_online_cpu(cpu) {
> -		if (!rb_threads[cpu])
> +		if (IS_ERR_OR_NULL(rb_threads[cpu]))
>  			break;
>  		kthread_stop(rb_threads[cpu]);
>  	}
> -- 
> 2.43.0
> 
>

Reviewed-by: Vincent Donnefort <vdonnefort@google.com>
