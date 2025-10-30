Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90071F37A1;
	Thu, 30 Oct 2025 00:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761784852; cv=none; b=ByABgKwLl4DXxkxb/nWmVjg5JBzqjLe952uVOsydJyJAD79zPEPPFyOlZYaa0AR9UsxJDu8JYjjgNefrCB+Hw/ksRLa6scsU0wzdzPQKBJZnO/bl52qDJwIE5UldoDAlvi4IKuusxXAnWOJD92Lf+uc8X1wBkJuOf84XPHx870I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761784852; c=relaxed/simple;
	bh=oZ1MuwwgBFJ3S6hPGHwDpv+4ZVl2r99X4sC8O8habo4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=e8THFeA+uhrIC2HhN7zcjsSKVHA8uBDkYG3aOcoA2DkqCONuScoZbMpW/5oA5wMuUUFiSKfh4RPrwyPf3t/P33dY6hF284oEEdMsHJ+buH7m+ZlkOZTYQt/OCDjiAsfAbtB6VCNbowAyGoOoXCIvKkIe4xiN3PA2X+Ap640VY1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vDdIlnwY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vDdIlnwY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A8F5C4CEF7;
	Thu, 30 Oct 2025 00:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761784852;
	bh=oZ1MuwwgBFJ3S6hPGHwDpv+4ZVl2r99X4sC8O8habo4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vDdIlnwYqSt9Yzw3zneDQjoeO1Ioffs04ODe92gQmS4nOQgM36CcGgGFiKxwuJTGR
	 06Gdjla70NfKzKhySzKcyAdRnJrbCeAz3hKQwtyHHPrEvbvfABwFs/A/ak+rf7vpsQ
	 2Yq5DZNKr95aKlpyj7DexeOReFee9otJ8vdN5r3moSEhYR0YJOFADKwxu3fvgQOsnY
	 bh60eiYcGXxZxcU2fECfLB0crNvWiAIuezwWrKhdrIbX8eVxEofZSpzABCMoKhVqvx
	 tyxYq72zsX49EuUZ39TLcIERCtX7P8SlftH9PnQ7xogfyxHj72PN97yD9WJJ87//Ra
	 Zs/+4bkfWz46Q==
Date: Thu, 30 Oct 2025 09:40:47 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: rostedt@goodmis.org, jolsa@kernel.org, mathieu.desnoyers@efficios.com,
 jiang.biao@linux.dev, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: fprobe: use ftrace if
 CONFIG_DYNAMIC_FTRACE_WITH_ARGS
Message-Id: <20251030094047.9f8aa77cb90897a14c8adada@kernel.org>
In-Reply-To: <20251029021514.25076-1-dongml2@chinatelecom.cn>
References: <20251029021514.25076-1-dongml2@chinatelecom.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Oct 2025 10:15:14 +0800
Menglong Dong <menglong8.dong@gmail.com> wrote:

> For now, we will use ftrace for the fprobe if fp->exit_handler not exists
> and CONFIG_DYNAMIC_FTRACE_WITH_REGS is enabled.
> 
> However, CONFIG_DYNAMIC_FTRACE_WITH_REGS is not supported by some arch,
> such as arm. What we need in the fprobe is the function arguments, so we
> can use ftrace for fprobe if CONFIG_DYNAMIC_FTRACE_WITH_ARGS is enabled.
> 
> Therefore, use ftrace if CONFIG_DYNAMIC_FTRACE_WITH_REGS or
> CONFIG_DYNAMIC_FTRACE_WITH_ARGS enabled.
> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
>  kernel/trace/fprobe.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> index ecd623eef68b..9fad0569f521 100644
> --- a/kernel/trace/fprobe.c
> +++ b/kernel/trace/fprobe.c
> @@ -254,7 +254,11 @@ static inline int __fprobe_kprobe_handler(unsigned long ip, unsigned long parent
>  	return ret;
>  }
>  
> -#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> +#if defined(CONFIG_DYNAMIC_FTRACE_WITH_ARGS) || defined(CONFIG_DYNAMIC_FTRACE_WITH_REGS)
> +#define FPROBE_USE_FTRACE
> +#endif
> +
> +#ifdef FPROBE_USE_FTRACE
>  /* ftrace_ops callback, this processes fprobes which have only entry_handler. */
>  static void fprobe_ftrace_entry(unsigned long ip, unsigned long parent_ip,
>  	struct ftrace_ops *ops, struct ftrace_regs *fregs)
> @@ -295,7 +299,7 @@ NOKPROBE_SYMBOL(fprobe_ftrace_entry);
>  
>  static struct ftrace_ops fprobe_ftrace_ops = {
>  	.func	= fprobe_ftrace_entry,
> -	.flags	= FTRACE_OPS_FL_SAVE_REGS,
> +	.flags	= FTRACE_OPS_FL_SAVE_ARGS,
>  };
>  static int fprobe_ftrace_active;
>  
> @@ -349,7 +353,7 @@ static bool fprobe_is_ftrace(struct fprobe *fp)
>  {
>  	return false;
>  }
> -#endif
> +#endif /* !FPROBE_USE_FTRACE */
>  
>  /* fgraph_ops callback, this processes fprobes which have exit_handler. */
>  static int fprobe_fgraph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
> @@ -599,7 +603,7 @@ static int fprobe_module_callback(struct notifier_block *nb,
>  	if (alist.index > 0) {
>  		ftrace_set_filter_ips(&fprobe_graph_ops.ops,
>  				      alist.addrs, alist.index, 1, 0);
> -#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> +#ifdef FPROBE_USE_FTRACE
>  		ftrace_set_filter_ips(&fprobe_ftrace_ops,
>  				      alist.addrs, alist.index, 1, 0);
>  #endif

Instead of introducing FPROBE_USE_FTRACE, I think it is better to add another
wrapper to be called here.

#if defined(CONFIG_DYNAMIC_FTRACE_WITH_ARGS) || defined(CONFIG_DYNAMIC_FTRACE_WITH_REGS)

static void fprobe_set_ips(unsigned long *ips, unsigned int cnt, int remove, int reset)
{
		ftrace_set_filter_ips(&fprobe_graph_ops.ops,
				      alist.addrs, alist.index, 1, 0);
		ftrace_set_filter_ips(&fprobe_ftrace_ops,
				      alist.addrs, alist.index, 1, 0);
}
...
#else
static void fprobe_set_ips(unsigned long *ips, unsigned int cnt, int remove, int reset)
{
		ftrace_set_filter_ips(&fprobe_graph_ops.ops,
				      alist.addrs, alist.index, 1, 0);
}
#endif

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
