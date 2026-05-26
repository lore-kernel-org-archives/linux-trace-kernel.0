Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8123B47CD;
	Tue, 26 May 2026 03:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779766643; cv=none; b=S+4a1AP7/LFtoUeHRKgPfk6PT/jf3aNJuKk5DaPPKFEGooiw0n5i6KI+C8tlhf2kopHIf7xHCWcsyHstW+X8Aq0fmRVWXRUsZvKZkIHdXkajteICKjAVvJihr2ftzDU4j4g2Uj0cVDSb2RTA/nThKQ/9e6S9Dm5BC46MtbiQCHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779766643; c=relaxed/simple;
	bh=EpL+9Qejiv2ZMqb0i8xsEkdBDYkez4MvBgLbanNUvpU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=PsD1cRrIDhlpmBzYRJUa9hS6Ze1ucazRBAlg/E/z7ZHnNzqtWfCcYG7JtuC8syaxm1BwZYCRQG1jANlaQBzl7KiTELRccqALzNvq5fYvj71sXEJMy97IQwRNKehszW2gIodhi1hQPRUe88gtMCB8sSES3EGiZntZF1+kMzE9qNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aavppjgV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aavppjgV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6CF81F000E9;
	Tue, 26 May 2026 03:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779766641;
	bh=zHomq5l5G1JwcHxq1NOOdtQEfJ19e2qQx0JlHzuabQc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aavppjgVfYjgU2IhX1hljRh/73iAOZ/CJp+5O6HtkkF5Jt8DNomQwLdNKGv7OBFK6
	 fflmXGrKzv0zORXSlvErXLuzHM90hj4XB4+dJt2g0FeXKMbFGdUYznW/SREjn6Vzoa
	 /zEueEWFs5Ixupte3DKDsNgi5jS6wq3ajtvywwUwL0KqzfteDTXomnw1ejy6VvOo+2
	 9u40E/5DW6cND39U4PFTx990jQskGu9sM/KRO52swU+5M7jLIboUDva/XyqrX2mKeI
	 nQ1eYj75NtDXThk0G8pv1p4yFwPeFf0ylCCS6RWJEqND7ujASrDGlZQ+4rJzmPkVfI
	 ijBoYtUzxUTeA==
Date: Tue, 26 May 2026 12:37:19 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Alexei Starovoitov <ast@kernel.org>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rethook: Use tsk->on_cpu to check task execution state
Message-Id: <20260526123719.482f07a3843e207e22d95378@kernel.org>
In-Reply-To: <20260525132253.1889726-1-wutengda@huaweicloud.com>
References: <20260525132253.1889726-1-wutengda@huaweicloud.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 May 2026 21:22:53 +0800
Tengda Wu <wutengda@huaweicloud.com> wrote:

> When a task calls schedule() to yield the CPU, its state remains
> TASK_RUNNING, but its stack is frozen and safe to walk.
> 
> Replace task_is_running(tsk) with tsk->on_cpu to avoid overly
> conservative rejections.

Please see the Sashiko's comment.

https://sashiko.dev/#/patchset/20260525132253.1889726-1-wutengda%40huaweicloud.com

When calling Unwind on a task other than the current, IMHO, it is
the responsibility of the caller of this function to ensure that the
stack trace of that task is safe.
We also should not use tsk->on_cpu, but should use task_on_cpu(tsk).

BTW, should task_on_cpu() use READ_ONCE() etc?
wait_task_inactive() seems a bit fragile.

Thanks,

> 
> Fixes: 54ecbe6f1ed5 ("rethook: Add a generic return hook")
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
> ---
>  kernel/trace/rethook.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/rethook.c b/kernel/trace/rethook.c
> index 5a8bdf88999a..bd5e5f455e85 100644
> --- a/kernel/trace/rethook.c
> +++ b/kernel/trace/rethook.c
> @@ -250,7 +250,7 @@ unsigned long rethook_find_ret_addr(struct task_struct *tsk, unsigned long frame
>  	if (WARN_ON_ONCE(!cur))
>  		return 0;
>  
> -	if (tsk != current && task_is_running(tsk))
> +	if (tsk != current && tsk->on_cpu)
>  		return 0;
>  
>  	do {
> -- 
> 2.34.1
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
