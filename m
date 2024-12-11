Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108E11D5CDD;
	Wed, 11 Dec 2024 16:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733933397; cv=none; b=ctXO8yEwXGU6AQDaQGQZB6TQECl8MSvRTYLpMcNw+U/Uus3I1DJIW/IemGtDELHjxonhEQSL5u8JiPjbfkml5ZZtK1yjpuXtV+7iFjASeXtDeVJ2uhHiIOWMVRR7AYS7sqKBjF+3ndy30dvVqncM+IGKK6GiANj3XNKC/C5KyyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733933397; c=relaxed/simple;
	bh=e7Bl6Cb/5z1UBwu0TtPLrts9zF7L2AqUtvtZt5smbn4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ftAtuSTJ2cVjSnwlLiOcfLO2eThzlhrjp56LGPo6I7TQe0Yj9n/U6Wf7TOHrindMrtPTvK8gmmSdUGLJRX6J6XJbazUutuZoIY8qyUECowBbru+tzXjKSS1OQoGPZxAmm+OPDekG77A5V9Jaxq6YV4WJiPhNv6pQzRWcztRjVks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B408AC4CED2;
	Wed, 11 Dec 2024 16:09:55 +0000 (UTC)
Date: Wed, 11 Dec 2024 11:09:52 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] fgraph: Use CPU hotplug mechanism to initialize idle
 shadow stacks
Message-ID: <20241211110952.6d89e0d8@batman.local.home>
In-Reply-To: <CACRpkdaEXUxSuVzztcVOh2VMzPHr+6jsrEC1w6ecWEd0qzgU4w@mail.gmail.com>
References: <20241018214300.6df82178@rorschach>
	<CACRpkdaTBrHwRbbrphVy-=SeDz6MSsXhTKypOtLrTQ+DgGAOcQ@mail.gmail.com>
	<20241211082427.01208632d3dd5486abb3e090@kernel.org>
	<CACRpkdaEXUxSuVzztcVOh2VMzPHr+6jsrEC1w6ecWEd0qzgU4w@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Dec 2024 15:23:05 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> If I boot without any tracing enabled from the cmdline and:
> 
> echo 0 > tracing_on
> echo function_graph > current_tracer
> echo do_idle > set_graph_function
> echo 1 > tracing_on
> 
> I don't get any output either.
> 
> It works for other functions, such as
> 
> echo ktime_get > set_graph_function
> 
> It seems it's the set_graph_function thing that isn't working
> with do_idle at all after this patch. Why just this function...
> The function is clearly there:
> 
> cat available_filter_functions | grep do_idle
> do_idle
> 
> I can also verify that this function is indeed getting invoked
> by adding prints to it (it's invoked all the time on any normal
> system). Does this have something to do with the context
> where do_idle is called? It's all really confusing...

Yeah, I figured it out. That commit moved the initialization before
fgraph was registered, and we had in ftrace_graph_init_idle_task():

        if (ftrace_graph_active) {
                unsigned long *ret_stack;
                        
                ret_stack = per_cpu(idle_ret_stack, cpu);
                if (!ret_stack) {
                        ret_stack = kmalloc(SHADOW_STACK_SIZE, GFP_KERNEL);
                        if (!ret_stack)
                                return;
                        per_cpu(idle_ret_stack, cpu) = ret_stack;
                }
                graph_init_task(t, ret_stack);
        }

But because ftrace_graph_active was not set yet, the initialization
didn't happen.

Can you try this patch?

-- Steve

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 43f4e3f57438..4706a7dce93a 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -1160,13 +1160,19 @@ void fgraph_update_pid_func(void)
 static int start_graph_tracing(void)
 {
 	unsigned long **ret_stack_list;
-	int ret;
+	int ret, cpu;
 
 	ret_stack_list = kmalloc(SHADOW_STACK_SIZE, GFP_KERNEL);
 
 	if (!ret_stack_list)
 		return -ENOMEM;
 
+	/* The cpu_boot init_task->ret_stack will never be freed */
+	for_each_online_cpu(cpu) {
+		if (!idle_task(cpu)->ret_stack)
+			ftrace_graph_init_idle_task(idle_task(cpu), cpu);
+	}
+
 	do {
 		ret = alloc_retstack_tasklist(ret_stack_list);
 	} while (ret == -EAGAIN);
