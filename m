Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134B042122D;
	Thu,  6 Aug 2026 21:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786052475; cv=none; b=l1yw5M5EjXZ0d0hbqPcBxWHJ7629DH4GZJrs/7PSpP+PFtgfYNGxRDObknOxlBO1lfCWObZvMdxK3weV9y8+t8yL0qCmZCR3JGZpeZY9vAIK7cgJNpw7FsySPBYdOWjpBsIp8XWGfiLe7yHhm+wQOPqZGkclX7PMqzkGB1Vd9lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786052475; c=relaxed/simple;
	bh=2059UvzVy2fTJZSkXT5cmIeP0B0YcuicIhxl4ZM5ns0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W8zqSwnGVPjuTGGFo4PhL0WJbse7o18OyPi+I34lHhUl2j3FPY8pmJY/Nbls32zpsU8v1NivW//9chx6yqGfRbrrccOfxSypP2bkB8RVS9qsrbyRgHWoa8+s2QUFPcnWBeV0xDogsIPrtISqjJ1MZz47e1rS5deRwkrwSsDUp28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf11.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 9BB4740302;
	Thu,  6 Aug 2026 21:41:11 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id C3A7C20029;
	Thu,  6 Aug 2026 21:41:09 +0000 (UTC)
Date: Thu, 6 Aug 2026 17:41:10 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: David Carlier <devnexen@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Report TP_printk double dereference with
 pr_warn()
Message-ID: <20260806174110.11fcd317@gandalf.local.home>
In-Reply-To: <20260806050716.16612-1-devnexen@gmail.com>
References: <20260806050716.16612-1-devnexen@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: a66kyw4fw5bzrdz9fzf4n4imkqj4wdgj
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: C3A7C20029
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/Vd6dPW2F+9+BGdpcfnNhllw5pYGLi+Ks=
X-HE-Tag: 1786052469-122285
X-HE-Meta: U2FsdGVkX1875b5qojOzgagTvgfJ1QN95Ien6dv+qKL9nrocqKufPaILFYTXI/QN34W9NtKDy65+RlNX5Ui3eZd8ZCjh8iv3KTgfbgXIaFAJpGQEjHXANTFmEfMGmlfw6O07KaBb66xtCbnLBEHUPwvcFD5F836LLJH81w0ihPKrVOS6D43RcFEKJxKQM92XsYEmGYzm8i7/Eg8GJUtVZNHJFoHi6A8VNJ1vKphmFxO7kRH5N7MfiZk4C26kQGB4VQstBcqoD0mnUrlrcsRa4LE3e5gX+4N+5luOmFuDVQdemCoMtkqhfevWZcI3t4Z+UOHv1UvEtBWLcR0urERDP+xH3GYOKugO

On Thu,  6 Aug 2026 06:07:16 +0100
David Carlier <devnexen@gmail.com> wrote:

> test_double_dereference() uses WARN_ONCE(), which is per-call-site. Only
> the first offending event in the kernel is ever reported, and the tree
> still has six: ice_{rx,tx}_dim_template, two hfi1 txq events, mtu3_ep and
> edma_log_io. Whichever registers first hides the rest, and it taints the
> kernel for what is a source-level mistake.
> 
> Use pr_warn() instead, matching the "TRACE EVENT ERROR:" report that
> handle_dereference_arg() already emits for the same class of problem.
> All offenders are now listed on one boot.

NAK!

> 
> Fixes: b5cc230af5e5 ("tracing: Warn when an event dereferences a pointer in TP_printk()")

This is by no way a fix!

I want a big splat when this is triggered. It is a bug and needs to be
fixed immediately. pr_warn() does not make tests fail. I want this to fail
tests. I want this to panic when panic_on_warn is set.

> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
>  kernel/trace/trace_events.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index a8590d2394e3..53f32752edc0 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -415,8 +415,8 @@ static void test_double_dereference(const char *str, int len,
>  		ptr += 5;
>  		for (; ptr < end; ptr++) {
>  			if (ptr[0] == '-' && ptr[1] == '>') {
> -				WARN_ONCE(1, "Event %s has double dereference in TP_printk: %.*s\n",
> -					  trace_event_name(call), len, str);
> +				pr_warn("TRACE EVENT ERROR: Event %s has double dereference in TP_printk: %.*s\n",
> +					trace_event_name(call), len, str);

Now I am OK with adding a pr_warn() with the WARN_ONCE() but the
WARN_ONCE() must stay. But leave off the fixes tag.

-- Steve


>  				return;
>  			}
>  			if (!isalnum(*ptr) && *ptr != '_')

