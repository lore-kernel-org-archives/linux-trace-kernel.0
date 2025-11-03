Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17FC8248C;
	Mon,  3 Nov 2025 03:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762139773; cv=none; b=naGBE01PrfaPtqupYiQ007sJDqnMax6Wz/s8v/5UoeepJveijV3nzbzjVEFSWDI0syuZXc6ap7jfyf3ktYzaXeMTkR69V5pWUoU8dsxwij4uF48Bztaake1sZckM+T9HyYsVwbfT+enxE6mua6FKL/nw2N1pwwbRYhywtf/NEIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762139773; c=relaxed/simple;
	bh=q+uKLEAXf2uLQtF4OkAZ7zdOsNGLQtv7zATZ7AydPrc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=mlpyz5Ynr5qyMNDLsyVU5ZMK+JsvzeBVIRCGOuyNs/WceQiojOmxd7IR/WKrXQ8TbMv7OqqOVLX1x0v9yykKqZeoUmg6f6mkS/QiHiGwG8BVXugHnDgI/8cw6EsJP+G+Bd8yHl1dIQ5QfufDWDdTBEGKMSLQzJ484orZjh1phkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X8YhopaT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X8YhopaT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BFD2C4CEE7;
	Mon,  3 Nov 2025 03:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762139770;
	bh=q+uKLEAXf2uLQtF4OkAZ7zdOsNGLQtv7zATZ7AydPrc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X8YhopaTexz0VzaZilFrwr9sXcLAPQxfok5OBDssfz2JO9AGkFSfBvfFoiiD+Czes
	 m1QXkTuoWNfIB3vzkwyrGQ/H9NvsKG6zU//FdqyiaGttl5hnjnqlYH4nIQ+mMst1cx
	 DJ/Yposizph2yqpQRn+RwlIa2qiZn3hAbqosh5sEgmJbOA0EcqCfnjm3b7GrtYN52D
	 TA/kxhAvLGYovhYT7SZ3r3CInx3NPJ9UgS46jOoFBJ6D0tx5SI+uBTaakKf3G8FefD
	 jGIyI8LX+gxgPE00fRPSkEnR8Gpn30k1SzmpzpwubP7IH3xl1wnx8kUwmPcyEUjzGC
	 ZUIEDoB2kZmKw==
Date: Mon, 3 Nov 2025 12:16:06 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: rostedt@goodmis.org, jolsa@kernel.org, mathieu.desnoyers@efficios.com,
 jiang.biao@linux.dev, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing: fprobe: use ftrace if
 CONFIG_DYNAMIC_FTRACE_WITH_ARGS
Message-Id: <20251103121606.bb5b1405e1e64267f7f3ebe5@kernel.org>
In-Reply-To: <20251031024038.19176-1-dongml2@chinatelecom.cn>
References: <20251031024038.19176-1-dongml2@chinatelecom.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 Oct 2025 10:40:38 +0800
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
> v2:
> - remove the definition of FPROBE_USE_FTRACE
> ---
>  kernel/trace/fprobe.c | 30 +++++++++++++++++++-----------
>  1 file changed, 19 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> index ecd623eef68b..742ad5a61d46 100644
> --- a/kernel/trace/fprobe.c
> +++ b/kernel/trace/fprobe.c
> @@ -44,6 +44,7 @@
>  static struct hlist_head fprobe_table[FPROBE_TABLE_SIZE];
>  static struct rhltable fprobe_ip_table;
>  static DEFINE_MUTEX(fprobe_mutex);
> +static struct fgraph_ops fprobe_graph_ops;
>  
>  static u32 fprobe_node_hashfn(const void *data, u32 len, u32 seed)
>  {
> @@ -254,7 +255,7 @@ static inline int __fprobe_kprobe_handler(unsigned long ip, unsigned long parent
>  	return ret;
>  }
>  
> -#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> +#if defined(CONFIG_DYNAMIC_FTRACE_WITH_ARGS) || defined(CONFIG_DYNAMIC_FTRACE_WITH_REGS)
>  /* ftrace_ops callback, this processes fprobes which have only entry_handler. */
>  static void fprobe_ftrace_entry(unsigned long ip, unsigned long parent_ip,
>  	struct ftrace_ops *ops, struct ftrace_regs *fregs)
> @@ -295,7 +296,7 @@ NOKPROBE_SYMBOL(fprobe_ftrace_entry);
>  
>  static struct ftrace_ops fprobe_ftrace_ops = {
>  	.func	= fprobe_ftrace_entry,
> -	.flags	= FTRACE_OPS_FL_SAVE_REGS,
> +	.flags	= FTRACE_OPS_FL_SAVE_ARGS,
>  };
>  static int fprobe_ftrace_active;
>  
> @@ -335,6 +336,13 @@ static bool fprobe_is_ftrace(struct fprobe *fp)
>  {
>  	return !fp->exit_handler;
>  }
> +

Ah, the new function depends on MODULES. 

#ifdef CONFIG_MODULES

> +static void fprobe_set_ips(unsigned long *ips, unsigned int cnt, int remove,
> +			   int reset)
> +{
> +	ftrace_set_filter_ips(&fprobe_graph_ops.ops, ips, cnt, remove, reset);
> +	ftrace_set_filter_ips(&fprobe_ftrace_ops, ips, cnt, remove, reset);
> +}

#endif	/* CONFIG_MODULES */

>  #else

#ifdef CONFIG_MODULES

>  static int fprobe_ftrace_add_ips(unsigned long *addrs, int num)
>  {
> @@ -349,7 +357,13 @@ static bool fprobe_is_ftrace(struct fprobe *fp)
>  {
>  	return false;
>  }

#endif	/* CONFIG_MODULES */

are needed.

Thank you,

> -#endif
> +
> +static void fprobe_set_ips(unsigned long *ips, unsigned int cnt, int remove,
> +			   int reset)
> +{
> +	ftrace_set_filter_ips(&fprobe_graph_ops.ops, ips, cnt, remove, reset);
> +}
> +#endif /* !CONFIG_DYNAMIC_FTRACE_WITH_ARGS && !CONFIG_DYNAMIC_FTRACE_WITH_REGS */
>  
>  /* fgraph_ops callback, this processes fprobes which have exit_handler. */
>  static int fprobe_fgraph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
> @@ -596,14 +610,8 @@ static int fprobe_module_callback(struct notifier_block *nb,
>  	} while (node == ERR_PTR(-EAGAIN));
>  	rhashtable_walk_exit(&iter);
>  
> -	if (alist.index > 0) {
> -		ftrace_set_filter_ips(&fprobe_graph_ops.ops,
> -				      alist.addrs, alist.index, 1, 0);
> -#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> -		ftrace_set_filter_ips(&fprobe_ftrace_ops,
> -				      alist.addrs, alist.index, 1, 0);
> -#endif
> -	}
> +	if (alist.index > 0)
> +		fprobe_set_ips(alist.addrs, alist.index, 1, 0);
>  	mutex_unlock(&fprobe_mutex);
>  
>  	kfree(alist.addrs);
> -- 
> 2.51.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
