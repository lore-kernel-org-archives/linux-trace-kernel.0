Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DD215746F
	for <linux-trace-kernel@vger.kernel.org>; Mon,  3 Nov 2025 06:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762150683; cv=none; b=SZAhXiY0aVQUSLvjhThbbU/vU80c6/zKtcXrqbA5hnbZWY4Qsk/JrI/j9+DMWyOojyA5dGYUcgfcQFtanVDmrhFAreoE/9YLd1/RuSaiVuPbVs96/MJwp0wJcxXUPKr2ybay2eRAIKyrqbnsQAqZ3Wn4MaV2Vd0T+fLiHo9Bxx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762150683; c=relaxed/simple;
	bh=9XEJ/+L+tM5QumuVcWBLQA0YcE5iAE46128KMHjyP7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rwYcSwlz0R0OOFKhA3iNEiNzztftc4YKfsBTTERyH+h/sEsNZetktN/ArLEFeCy8e2rWUx2aZ03x+DSYK42pUd62+wb6xkSLxmyGYHEEwHkR2hStG5JA9Mn9knNPEfsErX448bsDPs7hdLPlyW9Bp35S6NkpQIBER/yEWMv6sJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QJQzHPFv; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QJQzHPFv"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762150669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fqouM6qKRMgY2U9Z2FXjNEnIWORGK9ov4B1na6iFogg=;
	b=QJQzHPFvcWIDu+3FqY3s3k5YmcTUMsAJ1XqeK3b+VWYzTbWDcHolZvA/FTAaq0gfjLxqY2
	D2LIAxWA1qaeLUzTex/cROrfObwbCfDZLY0wdYDduwbpSV8d0JbG9rDdkWB8R4LDO4y8vF
	Xz5FGZYYUXCgaRAXgBwnN5VGmHc+MT4=
From: Menglong Dong <menglong.dong@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>,
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: rostedt@goodmis.org, jolsa@kernel.org, mathieu.desnoyers@efficios.com,
 jiang.biao@linux.dev, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject:
 Re: [PATCH v2] tracing: fprobe: use ftrace if CONFIG_DYNAMIC_FTRACE_WITH_ARGS
Date: Mon, 03 Nov 2025 14:17:39 +0800
Message-ID: <2803973.mvXUDI8C0e@7950hx>
In-Reply-To: <20251103121606.bb5b1405e1e64267f7f3ebe5@kernel.org>
References:
 <20251031024038.19176-1-dongml2@chinatelecom.cn>
 <20251103121606.bb5b1405e1e64267f7f3ebe5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/11/3 11:16, Masami Hiramatsu wrote:
> On Fri, 31 Oct 2025 10:40:38 +0800
> Menglong Dong <menglong8.dong@gmail.com> wrote:
> 
> > For now, we will use ftrace for the fprobe if fp->exit_handler not exists
> > and CONFIG_DYNAMIC_FTRACE_WITH_REGS is enabled.
> > 
> > However, CONFIG_DYNAMIC_FTRACE_WITH_REGS is not supported by some arch,
> > such as arm. What we need in the fprobe is the function arguments, so we
> > can use ftrace for fprobe if CONFIG_DYNAMIC_FTRACE_WITH_ARGS is enabled.
> > 
> > Therefore, use ftrace if CONFIG_DYNAMIC_FTRACE_WITH_REGS or
> > CONFIG_DYNAMIC_FTRACE_WITH_ARGS enabled.
> > 
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > ---
> > v2:
> > - remove the definition of FPROBE_USE_FTRACE
> > ---
> >  kernel/trace/fprobe.c | 30 +++++++++++++++++++-----------
> >  1 file changed, 19 insertions(+), 11 deletions(-)
> > 
> > diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> > index ecd623eef68b..742ad5a61d46 100644
> > --- a/kernel/trace/fprobe.c
> > +++ b/kernel/trace/fprobe.c
> > @@ -44,6 +44,7 @@
> >  static struct hlist_head fprobe_table[FPROBE_TABLE_SIZE];
> >  static struct rhltable fprobe_ip_table;
> >  static DEFINE_MUTEX(fprobe_mutex);
> > +static struct fgraph_ops fprobe_graph_ops;
> >  
> >  static u32 fprobe_node_hashfn(const void *data, u32 len, u32 seed)
> >  {
> > @@ -254,7 +255,7 @@ static inline int __fprobe_kprobe_handler(unsigned long ip, unsigned long parent
> >  	return ret;
> >  }
> >  
> > -#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> > +#if defined(CONFIG_DYNAMIC_FTRACE_WITH_ARGS) || defined(CONFIG_DYNAMIC_FTRACE_WITH_REGS)
> >  /* ftrace_ops callback, this processes fprobes which have only entry_handler. */
> >  static void fprobe_ftrace_entry(unsigned long ip, unsigned long parent_ip,
> >  	struct ftrace_ops *ops, struct ftrace_regs *fregs)
> > @@ -295,7 +296,7 @@ NOKPROBE_SYMBOL(fprobe_ftrace_entry);
> >  
> >  static struct ftrace_ops fprobe_ftrace_ops = {
> >  	.func	= fprobe_ftrace_entry,
> > -	.flags	= FTRACE_OPS_FL_SAVE_REGS,
> > +	.flags	= FTRACE_OPS_FL_SAVE_ARGS,
> >  };
> >  static int fprobe_ftrace_active;
> >  
> > @@ -335,6 +336,13 @@ static bool fprobe_is_ftrace(struct fprobe *fp)
> >  {
> >  	return !fp->exit_handler;
> >  }
> > +
> 
> Ah, the new function depends on MODULES. 
> 
> #ifdef CONFIG_MODULES
> 
> > +static void fprobe_set_ips(unsigned long *ips, unsigned int cnt, int remove,
> > +			   int reset)
> > +{
> > +	ftrace_set_filter_ips(&fprobe_graph_ops.ops, ips, cnt, remove, reset);
> > +	ftrace_set_filter_ips(&fprobe_ftrace_ops, ips, cnt, remove, reset);
> > +}
> 
> #endif	/* CONFIG_MODULES */

Yeah, I saw the CI's build warning. I'll send a V3 to fix
this issue.

Thanks!
Menglong Dong

> 
> >  #else
> 
> #ifdef CONFIG_MODULES
> 
> >  static int fprobe_ftrace_add_ips(unsigned long *addrs, int num)
> >  {
> > @@ -349,7 +357,13 @@ static bool fprobe_is_ftrace(struct fprobe *fp)
> >  {
> >  	return false;
> >  }
> 
> #endif	/* CONFIG_MODULES */
> 
> are needed.
> 
> Thank you,
> 
> > -#endif
> > +
> > +static void fprobe_set_ips(unsigned long *ips, unsigned int cnt, int remove,
> > +			   int reset)
> > +{
> > +	ftrace_set_filter_ips(&fprobe_graph_ops.ops, ips, cnt, remove, reset);
> > +}
> > +#endif /* !CONFIG_DYNAMIC_FTRACE_WITH_ARGS && !CONFIG_DYNAMIC_FTRACE_WITH_REGS */
> >  
> >  /* fgraph_ops callback, this processes fprobes which have exit_handler. */
> >  static int fprobe_fgraph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
> > @@ -596,14 +610,8 @@ static int fprobe_module_callback(struct notifier_block *nb,
> >  	} while (node == ERR_PTR(-EAGAIN));
> >  	rhashtable_walk_exit(&iter);
> >  
> > -	if (alist.index > 0) {
> > -		ftrace_set_filter_ips(&fprobe_graph_ops.ops,
> > -				      alist.addrs, alist.index, 1, 0);
> > -#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> > -		ftrace_set_filter_ips(&fprobe_ftrace_ops,
> > -				      alist.addrs, alist.index, 1, 0);
> > -#endif
> > -	}
> > +	if (alist.index > 0)
> > +		fprobe_set_ips(alist.addrs, alist.index, 1, 0);
> >  	mutex_unlock(&fprobe_mutex);
> >  
> >  	kfree(alist.addrs);
> 
> 
> 




