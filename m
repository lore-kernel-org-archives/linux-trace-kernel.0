Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28F61B4F28;
	Fri,  4 Oct 2024 22:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728081742; cv=none; b=gm/0u0dtgk2/wBArHaaxyU+q0kbrMHIuQOXuy/z/YOocqWIwIi7EjLpWZsG641/m6dVBMBc4oLlsDrPGkgqiU/4Y6SZkn/cA1htMBRuBk9b/FyqFuGNieVcR6QXmKGwnVE+hXnouJm5pliIlMrJ/Sso4L31e02ZJmVagv7yZtDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728081742; c=relaxed/simple;
	bh=u7x+wAANU9/a0L3wmeiXGK8Rl1V7K1OiXNhm0EjsPlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RMhPBeum6MPxMB2Yzsza7m29K/3mapGQfRCtHxTSCWjMBNRQuGQZy8kK2ShixS/JPjpnyfaUzgabt8JK8JTmuBOVKQLF2S+gVdTHp0FeW3UYuCUVI2Eo5g/gBnwQ0odNwfKm7bkJaUFMj9b7s0ifmSXg8LteNRLTtkQ4L9PVqko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 693D7C4CEC6;
	Fri,  4 Oct 2024 22:42:21 +0000 (UTC)
Date: Fri, 4 Oct 2024 18:43:17 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Zheng Yejian <zhengyejian@huaweicloud.com>
Cc: Sven Schnelle <svens@linux.ibm.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] tracing: add arguments to function tracer
Message-ID: <20241004184317.39199750@gandalf.local.home>
In-Reply-To: <dcac0917-0cb8-c0d1-e5bb-0144c38a65f3@huaweicloud.com>
References: <20240904065908.1009086-1-svens@linux.ibm.com>
	<20240904065908.1009086-8-svens@linux.ibm.com>
	<dcac0917-0cb8-c0d1-e5bb-0144c38a65f3@huaweicloud.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Sep 2024 11:49:10 +0800
Zheng Yejian <zhengyejian@huaweicloud.com> wrote:


> > diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
> > index c47422b20908..f2021ab52da2 100644
> > --- a/kernel/trace/trace_entries.h
> > +++ b/kernel/trace/trace_entries.h
> > @@ -61,8 +61,11 @@ FTRACE_ENTRY_REG(function, ftrace_entry,
> >   	TRACE_FN,
> >   
> >   	F_STRUCT(
> > -		__field_fn(	unsigned long,	ip		)
> > -		__field_fn(	unsigned long,	parent_ip	)
> > +		__field_fn(	unsigned long,		ip		)
> > +		__field_fn(	unsigned long,		parent_ip	)
> > +#ifdef CONFIG_FUNCTION_TRACE_ARGS
> > +		__field_struct( struct ftrace_regs,	regs		)  
> 
> Only function arguments are printed, they are several registers in ftrace_regs,
> would it be better to store what are needed?
> Although different archs save function arguments in different registers, store
> the entire ftrace_regs are much more simple..

Agreed, and I stated as much in my reply to patch 6.

This too will need two versions of the event. One will be function the
other will be function_args. And it will only record the necessary
arguments not the full ftrace_regs structure, as I plan on making that
structure have "zero size".

> 
> > +#endif
> >   	),
> >   
> >   	F_printk(" %ps <-- %ps",  
> 
> F_printk should also match F_STRUCT, otherwise 'format' info may be incorrect,
> it may confuse data parsing in user tools.

Well, it will just ignore the struct part, as its not listed.

-- Steve

> 
> > diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
> > index 3b0cea37e029..7ff651a0b45a 100644
> > --- a/kernel/trace/trace_functions.c
> > +++ b/kernel/trace/trace_functions.c
> > @@ -25,6 +25,9 @@ static void
> >   function_trace_call(unsigned long ip, unsigned long parent_ip,
> >   		    struct ftrace_ops *op, struct ftrace_regs *fregs);
> >   static void
> > +function_args_trace_call(unsigned long ip, unsigned long parent_ip,
> > +			 struct ftrace_ops *op, struct ftrace_regs *fregs);
