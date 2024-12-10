Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B3386324;
	Tue, 10 Dec 2024 23:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733873072; cv=none; b=CcmNmPXpOGskVMnUMooqTHB9/OxqYZA8ZaCz+Z0vHL3mpDkwiBvUYK7dDPLzfZTRrpaWUGti8NV9bt8vGDN87G7W1L4rmhAH20otWtB1kmslEtAhG6P86t2ohkJrfNperouE+tHQJ/dxenKk2r4y5496tBd/Cd2I6SOYfpEfHHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733873072; c=relaxed/simple;
	bh=zXqjJHW0daC2JGck9iVAG/iy1PS/85wV/ua7qEP4Rg8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=J5bBENRBc6to446N1BGGdbQfKiDolooZ/8IMPzYgzbHHkGN1XvSPFdELWh5TDHyAKZl8lYbQ6rW43t49UNz8XHvSD975T5UM+YAGQ/TngXMQWc0YD6Vg00gF2SGgps6VGbFTFAHNysLIwFTp3q41wkehKrzh6pykFx8wnL7CatQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yg6c2Za4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yg6c2Za4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2693EC4CED6;
	Tue, 10 Dec 2024 23:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733873072;
	bh=zXqjJHW0daC2JGck9iVAG/iy1PS/85wV/ua7qEP4Rg8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Yg6c2Za4hayBvnc1usX8f2ySJtghlmdTXNL0Je1uStmkKBiFlq0Z6yPz7+zAzB7cZ
	 2fpzU9Rcw9OV1uF10KNzIBGxBR3ZzsE44VBNcs0WTvJoyD7PDN5j0gblzjqTEj3Kiw
	 YqRo2rP0E+pKSPdaoxkvoc7HUw+7nPCE6dyKv98TEwPl28N3FbjnwWvfVmW2kq2+fq
	 GR35KKQSSjngbZdazcEXBnAEhoLZxdAdPAWpceOcGMFLTp+GtzVFQuno6yQ8DUB369
	 upMLhPEYRcogLOOQgrQzAh1ojx4bF6zYnoz3GrVf5PddhvOVfgD6FtBpfZKWljeO59
	 LJXPC6zgN6uFw==
Date: Wed, 11 Dec 2024 08:24:27 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] fgraph: Use CPU hotplug mechanism to initialize idle
 shadow stacks
Message-Id: <20241211082427.01208632d3dd5486abb3e090@kernel.org>
In-Reply-To: <CACRpkdaTBrHwRbbrphVy-=SeDz6MSsXhTKypOtLrTQ+DgGAOcQ@mail.gmail.com>
References: <20241018214300.6df82178@rorschach>
	<CACRpkdaTBrHwRbbrphVy-=SeDz6MSsXhTKypOtLrTQ+DgGAOcQ@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 10 Dec 2024 16:11:16 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> Hi Stephen,
> 
> On Sat, Oct 19, 2024 at 3:43 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > The function graph infrastructure allocates a shadow stack for every task
> > when enabled. This includes the idle tasks. The first time the function
> > graph is invoked, the shadow stacks are created and never freed until the
> > task exits. This includes the idle tasks.
> (...)
> > Cc: stable@vger.kernel.org
> > Fixes: 868baf07b1a25 ("ftrace: Fix memory leak with function graph and cpu hotplug")
> > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> This patch regressed boot-time tracing for me.
> 
> How to reproduce:
> - Enable CONFIG_FTRACE, CONFIG_FUNCTION_TRACER,
>   CONFIG_BOOTTIME_TRACING
> - Pass command line
>   ftrace=function_graph ftrace_graph_filter=do_idle
>   to make ftrace trace this function all through the boot process.
> 
> Before this patch:
> 
> cd /sys/kernel/debug/tracing
> cat trace
> 
> gives a nice trace of all invocations of do_idle() during boot.
> 
> After this patch:
> 
> cd /sys/kernel/debug/tracing
> cat trace
> 
> Gives an empty trace :(
> 
> And:
> 
> cat current_tracer
> function_graph
> cat set_graph_function
> do_idle
> cat tracing_on
> 1
> 
> So all *is* set up, just not performing
> 
> I tried to figure out why this happens but I'm not good with tracing
> internals. Any ideas?

Interesting. Does this happen only on boot-time tracing or after boot too?
If it does not work only for boot-time, cpuhp_setup_state() may not work
before starting boot-time function graph tracing.

Thank you,

> 
> Yours,
> Linus Walleij


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
