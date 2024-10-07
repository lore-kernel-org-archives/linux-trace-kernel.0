Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40031189BBD;
	Mon,  7 Oct 2024 21:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728335433; cv=none; b=m/8WqiPyURVqPaseIyVoD3yEt0xWU24oo3emyMFOETN9Q1RAFTLP2MlVjfQR9A5rpYYgoxxbLS8tisAuX61M+laQqhN2BmE0MmnaONQCojptIMUas9CW1jCdxHKU2TnOrER9p3b8W862slJroRE6nJ38MgOI8RY2o8GV7xgH81M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728335433; c=relaxed/simple;
	bh=xGN35DS+Reg5MuMSn2us7xaD9u0dVlS84VO+lKwKRig=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tSIK5rF8FJ13Z+rq/0i0dfTUQy1M8FcIOnjA/tsApdZc2qnlfjGjEVmy7MC5IUEB5tgwNyDT0nU1vLOFpq8KpRpmeEWs/jgoIzoA/D1vTZYlb95A5CkmoZ187Qt8dH1jyVgicS8HmS7Vc7FeFmcJH2Nw2wb/zQ5ccobg+EglvPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EABE3C4CEC6;
	Mon,  7 Oct 2024 21:10:31 +0000 (UTC)
Date: Mon, 7 Oct 2024 17:10:27 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jeff Xie <jeff.xie@linux.dev>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 xiehuan09@gmail.com, dolinux.peng@gmail.com, chensong_2000@189.cn
Subject: Re: [PATCH v3] ftrace: Get the true parent ip for function tracer
Message-ID: <20241007171027.629bdafd@gandalf.local.home>
In-Reply-To: <20241005101320.766c1100@rorschach.local.home>
References: <20240910133620.19711-1-jeff.xie@linux.dev>
	<20241005101320.766c1100@rorschach.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 5 Oct 2024 10:13:20 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> The crash happened here:

This has been bothering me all weekend so I dug more into it.

The reason it was bothering me is because we use current later on, and it
has no issue. But then I noticed the real bug!

I was confused because the crashed instruction pointer was in the
get_current() code. But that's not where the crash actually happened.

> 
> static __always_inline unsigned long
> function_get_true_parent_ip(unsigned long parent_ip, struct ftrace_regs *fregs)
> {
>         unsigned long true_parent_ip;
>         int idx = 0;
> 
>         true_parent_ip = parent_ip;
>         if (unlikely(parent_ip == (unsigned long)&return_to_handler))
>                 true_parent_ip = ftrace_graph_ret_addr(current, &idx, parent_ip,  <<<----- CRASH

That's not the crash

>                                 (unsigned long *)fregs->regs.sp);

The above is!

fregs should *NEVER* be used directly. OK, I need to make:

struct ftrace_regs {
	void *nothing_here[];
};

Now, to stop bugs like this.

fregs is unique by architecture, and may not even be defined! That is, it
can pass NULL for fregs. And only x86 has fregs->regs available. Other
archs do not.

You must use the fregs helper functions, thus the above can be:


static __always_inline unsigned long
function_get_true_parent_ip(unsigned long parent_ip, struct ftrace_regs *fregs)
{
	unsigned long true_parent_ip;
	int idx = 0;

	true_parent_ip = parent_ip;
	if (unlikely(parent_ip == (unsigned long)&return_to_handler) && fregs)
		true_parent_ip = ftrace_graph_ret_addr(current, &idx, parent_ip,
				(unsigned long *)ftrace_regs_get_stack_pointer(fregs));

	return true_parent_ip;
}

So you can make a v5 with this update. And I'll go and make the empty
ftrace_regs structure.

Thanks!

-- Steve


>         return true_parent_ip;
> }
> 
> It appears that on some archs (x86 32 bit) the function tracer can be
> called when "current" is not set up yet, and can crash when accessing it.
> 
> So perhaps we need to add:
> 
> #ifdef CONFIG_ARCH_WANTS_NO_INSTR
> static __always_inline unsigned long
> function_get_true_parent_ip(unsigned long parent_ip, struct ftrace_regs *fregs)
> {
>         unsigned long true_parent_ip;
>         int idx = 0;
> 
>         true_parent_ip = parent_ip;
>         if (unlikely(parent_ip == (unsigned long)&return_to_handler))
>                 true_parent_ip = ftrace_graph_ret_addr(current, &idx, parent_ip,  <<<----- CRASH
>                                 (unsigned long *)fregs->regs.sp);
>         return true_parent_ip;
> }
> #else
> # define function_get_true_parent_ip(parent_ip, fregs)  parent_ip
> #endif
> 
> That is, if the arch has noinstr implemented, it should always be safe
> to access current, but if not, then there's no guarantee.
> 
> ?
