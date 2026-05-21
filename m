Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3F833C1B7;
	Thu, 21 May 2026 03:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779332993; cv=none; b=Xy1W7+08ejc3hHMlFg/TgBK0yTRUrGQHChewlSkhrxY5LeHWbE+b6df2fqGPcIVGwLkAIXKUUFfycDmsHc8IFJMXc1SfYEfJG7lU0W9d0giv18N/Mc0WMHt9Rj0NBmHz0outVrvIZWOakYKeSbMVMyEX9Un2Ixwu3xp9rRQjnjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779332993; c=relaxed/simple;
	bh=PyCogTZLqe1oYQBon/CXpNsZwPGKbaLmRJUHRCcKoAc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=DIVIYqBYgmv6CWz8ZqiD6xkM2/kqkrz3KCPR5Hsig6WkY+SAPP2gah85xkHjb3nC+AoFAqxgRXuOwVSH3nR0jxQ95u/8P0MIGxQSdCXkDJTBKq5TGL0ckqxT4UkuJytU32QEHR/WMpRuzBuSVOUt+atkCSmYuOrhT/4KwzGEb0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZXpky9JN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZXpky9JN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB2B1F000E9;
	Thu, 21 May 2026 03:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779332991;
	bh=lw7Y3cTnSkm8o3kNd4EremV9Sd2MHFAezFWfaNvBFXs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZXpky9JNK9TTmZzhp7qSFzG7Pv1bOBmChhxIBkv5x8LjiSVubNtyTFIR3M3UjRizt
	 dTQttGJP2LUd9WpMmiaE3DozQmSfexj4FzcOKgVTYL7F68zjy8vKRnfj1giQnKq8EJ
	 AJNpUQ1kH22XOrEGquCoAhw5Uu+kExjF3mrfOUMUx0ZxzYr+OEuTwzQre22pQ+7mUZ
	 9RHpv1T0ZYXNT/Uwh0JaskklPWR8Ciq1aDdx08sBwoTp+x1vUipE5IV6Ov5EE790js
	 a5UpCE14KCMxN6CGEUS5VbkcgcNvOuLfP4ujrU6cn3945cvO+wp+zYeP/HjgmRC2Mo
	 Mrdj44ERfWPSg==
Date: Thu, 21 May 2026 12:09:47 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-kernel@vger.kernel.org
 (open list:TRACING), linux-hardening@vger.kernel.org (open list:KERNEL
 HARDENING (not covered by other
 areas):Keyword:\b__counted_by(_le|_be|_ptr)?\b)
Subject: Re: [PATCH] tracing: Use flexible array for entry fetch code
Message-Id: <20260521120947.08f00bd4d7445bc6abc98ce0@kernel.org>
In-Reply-To: <20260520215817.16560-1-rosenp@gmail.com>
References: <20260520215817.16560-1-rosenp@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 May 2026 14:58:17 -0700
Rosen Penev <rosenp@gmail.com> wrote:

> Store probe entry fetch instructions in the probe_entry_arg
> allocation instead of allocating a separate instruction array.
> 
> This keeps the entry fetch code tied to the entry argument lifetime while
> leaving regular probe_arg instruction arrays separately allocated and
> freed.
> 

Thanks, this looks good to me.

> Assisted-by: Codex:GPT-5.5
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  kernel/trace/trace_probe.c | 8 +-------
>  kernel/trace/trace_probe.h | 2 +-
>  2 files changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index e0d3a0da26af..39f040c863e8 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -838,15 +838,10 @@ static int __store_entry_arg(struct trace_probe *tp, int argnum)
>  	int i, offset, last_offset = 0;
>  
>  	if (!earg) {
> -		earg = kzalloc_obj(*tp->entry_arg);
> +		earg = kzalloc_flex(*earg, code, 2 * tp->nr_args + 1);
>  		if (!earg)
>  			return -ENOMEM;
>  		earg->size = 2 * tp->nr_args + 1;
> -		earg->code = kzalloc_objs(struct fetch_insn, earg->size);
> -		if (!earg->code) {
> -			kfree(earg);
> -			return -ENOMEM;
> -		}
>  		/* Fill the code buffer with 'end' to simplify it */
>  		for (i = 0; i < earg->size; i++)
>  			earg->code[i].op = FETCH_OP_END;
> @@ -2051,7 +2046,6 @@ void trace_probe_cleanup(struct trace_probe *tp)
>  		traceprobe_free_probe_arg(&tp->args[i]);
>  
>  	if (tp->entry_arg) {
> -		kfree(tp->entry_arg->code);
>  		kfree(tp->entry_arg);
>  		tp->entry_arg = NULL;
>  	}
> diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
> index 262d8707a3df..1076f1df347b 100644
> --- a/kernel/trace/trace_probe.h
> +++ b/kernel/trace/trace_probe.h
> @@ -238,8 +238,8 @@ struct probe_arg {
>  };
>  
>  struct probe_entry_arg {
> -	struct fetch_insn	*code;
>  	unsigned int		size;	/* The entry data size */
> +	struct fetch_insn	code[] __counted_by(size);
>  };
>  
>  struct trace_uprobe_filter {
> -- 
> 2.54.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
