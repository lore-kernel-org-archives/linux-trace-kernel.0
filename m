Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57940AD2D;
	Tue, 10 Dec 2024 16:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733848291; cv=none; b=p887GBsGlYaeowODSQEvPMP+U1wzO4sv2uIWft+Sttr1NpRYaocJZl6y640P67tyy1KQ+pXDbMoQPzXPyWdDAi7gcGiK/Rs5PVXqdC9HReDvFH6YuMJlmyu8sN9lZ50UCfBVJmaE2Zva7jJZSg9FgQIGZuGoNbrI/SzX7/WApaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733848291; c=relaxed/simple;
	bh=JgOclP1fUXYqFaWQhda6xIuJNbx6MkpVTlQNSqwvCts=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=di/CZxAOneCsmTY1yp/DFhaAVQILfBoUG7lPIqFkTOzxaFTPiqbfAhEMCqc3PZutzUMWV0a0nbTWhcpCNYt1TW0h5uI9lJrvKsZlH0oEpvsAmtB4FP3yOzHlTHQdOj+9MMqwn98LPOJKwyRSzJcysiU0mxNsUJX3FKQYrI4o57s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E9EDC4CED6;
	Tue, 10 Dec 2024 16:31:30 +0000 (UTC)
Date: Tue, 10 Dec 2024 11:31:28 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] fgraph: Use CPU hotplug mechanism to initialize idle
 shadow stacks
Message-ID: <20241210113128.223f1724@batman.local.home>
In-Reply-To: <CACRpkdaTBrHwRbbrphVy-=SeDz6MSsXhTKypOtLrTQ+DgGAOcQ@mail.gmail.com>
References: <20241018214300.6df82178@rorschach>
	<CACRpkdaTBrHwRbbrphVy-=SeDz6MSsXhTKypOtLrTQ+DgGAOcQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Dec 2024 16:11:16 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

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

Thanks for the report. I'm currently at the ELISA workshop this week,
but will try to reproduce it.

-- Steve
