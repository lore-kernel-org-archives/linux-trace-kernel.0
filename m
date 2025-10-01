Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC1F18A6AD;
	Wed,  1 Oct 2025 12:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759321939; cv=none; b=aH8TfQAmNWipatreixnEJWBQW+n3ob6dTMbF5bmPP6eHxCkhbe88NQSAPECAK/U0Y9duSCtYDi3LtlDTwOXE186RNP4qLNBu7RnSueF2FZqG40XkkI1BHDZ8rPpvv6pmBJRWDmfEl4LdNGeok1n2HduxjwNe+qa9pWCSb4zDu4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759321939; c=relaxed/simple;
	bh=zhBodAaUMRLLTEJjZ84zcHmUPunWR2jSJR+6q/+3zy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ug77nJ2jYCANBerBPX21B5Znsu95rXcQmG8qkHIFPA+1Rf5Fky1UZeOF9mmUoEbBmUDI4x/izdHAqJreLISbKoKLY7MSoXVFs2CpN1lymjg3J2RKOviHXLQdufb1/9qogJbpyt6y4Vp4QXzMKAurKUK+8RTHDqG4ZUaqrddd6S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DI6Ofelw; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DI6Ofelw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0u5m09Vzu8PbTK3kBSjG60u0Ob5vQXB1hjbsp9cgnns=; b=DI6OfelwGYwznBGRsLAS7vJUIy
	ZhjjFUdec2wZDgdkGOtXyPxqExPzNZBkQkkGqNJDoyC4GQVXkwm3pS5oC5xTYdIMz30ppgZ/JNPiK
	2ny+jypy2akRWf9fsEzTAMVwZ6PKwZ9Jdyslq0zcBk0R31RVGvYvHdpNI3hdUBxUWD5JHI8K2eNGH
	EikT7pL1dOhf0kYL0FupMu/SiEqsRnhZcmn2gNpzdcILKEytzhy5RiZjdbNhwGmM5QqWQDt+dt4zv
	RZKO4XmDBWrfUst+VRj45HaCXCnj4aGv33ZBkh7gMTGUNBZ1gxIaZ+KJPiQbgFhYledjVQ7MS8TXf
	EB2KizSg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3w00-00000000EGZ-1a4A;
	Wed, 01 Oct 2025 12:32:01 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 70EEB303003; Wed, 01 Oct 2025 14:32:00 +0200 (CEST)
Date: Wed, 1 Oct 2025 14:32:00 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: chenyuan_fl@163.com
Cc: mhiramat@kernel.org, bigeasy@linutronix.de, chenyuan@kylinos.cn,
	john.ogness@linutronix.de, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
	rostedt@goodmis.org
Subject: Re: [PATCH v4] tracing: Fix race condition in kprobe initialization
 causing NULL pointer dereference
Message-ID: <20251001123200.GN4067720@noisy.programming.kicks-ass.net>
References: <20251001003707.3eaf9ad062d5cad96f49b9ba@kernel.org>
 <20251001022025.44626-1-chenyuan_fl@163.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001022025.44626-1-chenyuan_fl@163.com>

On Wed, Oct 01, 2025 at 03:20:25AM +0100, chenyuan_fl@163.com wrote:

> 
> v1->v2: Fix race analysis (per Masami) - kprobe arms in class->reg().
> v2->v3: Adopt RELEASE/ACQUIRE semantics per Peter/John's suggestions,
>         aligning with Steven's clarification on barrier purposes.
> v3->v4: Introduce load_flag() (Masami) and optimize barrier usage in
>         checks/clear (Peter).

Stuff like this ought to go below the --- such that git-am and similar
tools throw it out.

> Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
> ---

> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index ccae62d4fb91..b1b793b8f191 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -1813,14 +1813,15 @@ static int kprobe_register(struct trace_event_call *event,
>  static int kprobe_dispatcher(struct kprobe *kp, struct pt_regs *regs)
>  {
>  	struct trace_kprobe *tk = container_of(kp, struct trace_kprobe, rp.kp);
> +	unsigned int flags = trace_probe_load_flag(&tk->tp);
>  	int ret = 0;
>  
>  	raw_cpu_inc(*tk->nhit);
>  
> -	if (trace_probe_test_flag(&tk->tp, TP_FLAG_TRACE))
> +	if (flags & TP_FLAG_TRACE)
>  		kprobe_trace_func(tk, regs);
>  #ifdef CONFIG_PERF_EVENTS
> -	if (trace_probe_test_flag(&tk->tp, TP_FLAG_PROFILE))
> +	if (flags & TP_FLAG_PROFILE)
>  		ret = kprobe_perf_func(tk, regs);
>  #endif
>  	return ret;
> @@ -1832,6 +1833,7 @@ kretprobe_dispatcher(struct kretprobe_instance *ri, struct pt_regs *regs)
>  {
>  	struct kretprobe *rp = get_kretprobe(ri);
>  	struct trace_kprobe *tk;
> +	unsigned int flags;
>  
>  	/*
>  	 * There is a small chance that get_kretprobe(ri) returns NULL when
> @@ -1844,10 +1846,11 @@ kretprobe_dispatcher(struct kretprobe_instance *ri, struct pt_regs *regs)
>  	tk = container_of(rp, struct trace_kprobe, rp);
>  	raw_cpu_inc(*tk->nhit);
>  
> -	if (trace_probe_test_flag(&tk->tp, TP_FLAG_TRACE))
> +	flags = trace_probe_load_flag(&tk->tp);
> +	if (flags & TP_FLAG_TRACE)
>  		kretprobe_trace_func(tk, ri, regs);
>  #ifdef CONFIG_PERF_EVENTS
> -	if (trace_probe_test_flag(&tk->tp, TP_FLAG_PROFILE))
> +	if (flags & TP_FLAG_PROFILE)
>  		kretprobe_perf_func(tk, ri, regs);
>  #endif
>  	return 0;	/* We don't tweak kernel, so just return 0 */


These two are inconsistent in that the first does load_flag before
inc(nhit) while the second does it after. I don't think it matters, but
I noticed the inconsistent style and had to tell.


Anyway, patch looks reasonable now. Rest is up to Steve, this is his
code.
