Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF541330B3F;
	Tue,  9 Jun 2026 07:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780989291; cv=none; b=u9xVBY5VJk2GCGtPybYYafmCl7jq2oWO6QAKxReQBAIsG2SOrUYqkNFUEB13CAnyvibtQFcm4UKbByJwyH8HYMKsHsZZiJdYneUcnmZPDRgXQxgqDoNx8VtxdQ+yIp+FSseRCql9MhPLllptjRTXelAEenkzDSGKSybFxXAMNsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780989291; c=relaxed/simple;
	bh=MdBkM61U7sTDtcRQvLs5/JvMzLHogzXyiIVeQk2SPxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZlqhHLUYVhrvxsHqUWel0oIV+M0zel6Oj9u63Zx5BEIY32JlETfmlJsklrkOnDbT9UWPZdtPjbIt+vzu9Q21YsvJjq9yyso9Vte8PtWKd4BTWdo+adcprZjruGngLrGveenf530xY2Lq0TmEw/99ZOV4l7LREDkLXCHbf021s9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wCN6x3PK; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wCN6x3PK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+FA8nZtK13YzWN992j3J00N3xA56+WTGH4iRW2HJn+E=; b=wCN6x3PKw65h4CAgRf7K59WIF+
	vdNoS64miz4/Guif1BwEgi5VkmFedWKN5SwyxVY+5QF4tNhOC5KPrrMKVxtY5Idn8cq6/uHJeS3pe
	DutodxlclmDrIC9pLm7Wi5nyJMefAUJqnEPZsXfypPNfck3NnxGC2g4eH6ASsMq/iUClNuh5XpE8u
	MrUuBt7PXCS+ebDT2Xm0s7oieG8Vx8HBDImuch2YKEDIjJg8iNsXmLxWQFFDMmctX7wdAa1rGKaRc
	DLO6WhgQaXfFavI/NHBBwlK8xpXiJs1p3mqztdMDrOY/fPGa42GxbIINJaphmMe2Y2Vj20D3UHPWT
	MBgXreCw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWqfb-0000000FDbw-13fB;
	Tue, 09 Jun 2026 07:14:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 57E05300642; Tue, 09 Jun 2026 09:14:12 +0200 (CEST)
Date: Tue, 9 Jun 2026 09:14:12 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Alexei Starovoitov <ast@kernel.org>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rethook: Remove the running task check in
 rethook_find_ret_addr()
Message-ID: <20260609071412.GG3102624@noisy.programming.kicks-ass.net>
References: <20260609005728.458962-1-wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609005728.458962-1-wutengda@huaweicloud.com>

On Tue, Jun 09, 2026 at 08:57:28AM +0800, Tengda Wu wrote:
> The current check in rethook_find_ret_addr() prevents obtaining a return
> address when the target task is marked as running. However, this condition
> is both insufficient for safety and unnecessary for its intended purpose.

Depends on what safety means. If safety means not crashing, it is
entirely superfluous. If safety means correctness, then yes, it is
insufficient.

> The check is inherently racy: a task can begin running on another CPU
> immediately after task_is_running() returns false, potentially leading to
> concurrent modification of rethook data structures while the iteration is
> in progress.
> 
> Rather than attempting to fix this unreliable check deep in the unwinding
> path, remove it entirely. Callers that require consistency are expected
> to provide a safe context.

Perhaps also note that unwind_next() will hold RCU and the rethook_node
things are RCU freed, so while the iteration might go off the rails and
return invalid information, it will not crash.


> Fixes: 54ecbe6f1ed5 ("rethook: Add a generic return hook")
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

With clarifications:

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
> v2: Remove the running task check.
> v1: https://lore.kernel.org/all/20260525132253.1889726-1-wutengda@huaweicloud.com/
> 
>  kernel/trace/rethook.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/kernel/trace/rethook.c b/kernel/trace/rethook.c
> index 5a8bdf88999a..f70f11bc6c91 100644
> --- a/kernel/trace/rethook.c
> +++ b/kernel/trace/rethook.c
> @@ -250,9 +250,6 @@ unsigned long rethook_find_ret_addr(struct task_struct *tsk, unsigned long frame
>  	if (WARN_ON_ONCE(!cur))
>  		return 0;
>  
> -	if (tsk != current && task_is_running(tsk))
> -		return 0;
> -
>  	do {
>  		ret = __rethook_find_ret_addr(tsk, cur);
>  		if (!ret)
> -- 
> 2.34.1
> 
