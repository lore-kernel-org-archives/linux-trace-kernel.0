Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B1F2F85B;
	Wed, 29 Oct 2025 14:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761746416; cv=none; b=JDUpvwRlmQCrb0pka0hpucfasgGsFKn9w8eRm4MCkYd7aaMBefeVpKV3r8Y9X5IFIn4bw9yqujjMQxAF6VYBHtO5orGWoyq0jgAfJc1RYQH0oKBKR2H5binXxqIXOGJfeHIjVpznuVy7m6iVralsR0hk1ANWJAb2zfUpmHDftxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761746416; c=relaxed/simple;
	bh=MKQq55ffHbZomesotqaC2+T2E7XA/LvPpVshKS2Y8fI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ETzVIxZ30l13bgDJulWfDCJ8cSOwkRkbeqyp2f4o9I04uPPTM7Tf/jGMuEZc3xdCJF/LztryJZrSK7mugkNciDF9LKxLXT3cxO8v0FdX4fuBoMSPPT+0stRDpxoHIBQrcLU/nMCFhH42JP/oI19GAtMMqlQncfBGFfWG7CZOdpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 0DACDC084B;
	Wed, 29 Oct 2025 14:00:07 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id 192B420012;
	Wed, 29 Oct 2025 14:00:05 +0000 (UTC)
Date: Wed, 29 Oct 2025 10:00:45 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: mhiramat@kernel.org, jolsa@kernel.org, mathieu.desnoyers@efficios.com,
 jiang.biao@linux.dev, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: fprobe: use ftrace if
 CONFIG_DYNAMIC_FTRACE_WITH_ARGS
Message-ID: <20251029100045.1bacc491@gandalf.local.home>
In-Reply-To: <20251029021514.25076-1-dongml2@chinatelecom.cn>
References: <20251029021514.25076-1-dongml2@chinatelecom.cn>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: z7rpo5c7jcywest3ncr4scx6t4pbdug7
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 192B420012
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/iopvWcwJewjP7InqAmXGwM7w53r6524s=
X-HE-Tag: 1761746404-15532
X-HE-Meta: U2FsdGVkX1/QiFkVbLx24yZ41mTDIew/bJCIE3tfRblFRdOYdz0fzf5YiFCfjVxJZbtFHJGAWctLPtdJfhySOrgZ027T9FkczZpMYfePKJu/mpnAoVtsq3oGGSfCjJ45BR2AptVzjwm2M9Xajbi/6bt/WBqEyc/E5VsPx//4VXgO7C3oOPeOtXTdW9xVjdqL84brOh6parSeaJb7zBmRTbODTUnQIokNNdtzQQvYj3yA9GwoueCszgDfpuzCLQ0vzoGaD3nsKN25FX+ZlVMZ+17gf49UHrKzcU37bNmT6vCPv0KGsZHBgEQQq2be3IYJzwbGhK/fXfBjMR/5t9+zSZIed+JCOk5Q

On Wed, 29 Oct 2025 10:15:14 +0800
Menglong Dong <menglong8.dong@gmail.com> wrote:

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

If an arch defines DYNAMIC_FTRACE_WITH_REGS but not
DYNAMIC_FTRACE_WITH_ARGS, then this will fail to build.

>  };
>  static int fprobe_ftrace_active;
>  

Perhaps do:

#ifdef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
# define FPROBE_FTRACE_TYPE FTRACE_OPS_FL_SAVE_ARGS
#elif defined(CONFIG_DYNAMIC_FTRACE_WITH_REGS)
# define FPROBE_FTRACE_TYPE FTRACE_OPS_FL_SAVE_REGS,
#endif

#ifdef FPROBE_FTRACE_TYPE
[..]
static struct ftrace_ops fprobe_ftrace_ops = {
	.func	= fprobe_ftrace_entry,
	.flags	= FTRACE_FTRACE_TYPE,


?

-- Steve
