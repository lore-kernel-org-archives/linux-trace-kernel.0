Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC46F2E5B02;
	Thu,  7 May 2026 04:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778127259; cv=none; b=S1Ii1+Kh0RMiUAHZ2LzYFuwOwiFxyWL3BCAphyCTtpA93B4j+JQkAVaUusIb1jpRuZdkjCwB26HT5LinbMNMgWJZJinfawyiFGT8sCHJH/vhU+FUPLbPvyLj/Uol1WDCJLKPmU45m4PWhyngqPWhrALm2u3nJnvPhvu3Q1vsEW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778127259; c=relaxed/simple;
	bh=N3+MD8teZfj8M3IcjL1QaKuP26duMfx7mziauhL1yWI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=PUoGs61VbXMkhG1S4xGEJMPC2+Hr0uTafqg/cZrhJ6Pr/auMUITBq3omxawjZQLOE/KdDb2jVI4ncHeLXQ6DRSFjePdixaKnlEj8elhkRSHvxS31ijL1Ohoc7pz2aWhMyhvOHaG8KPEOf+O09yYPF31s9gf4FsVYwH7izJ061rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TuqHI9rN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TuqHI9rN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38117C2BCC7;
	Thu,  7 May 2026 04:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778127259;
	bh=N3+MD8teZfj8M3IcjL1QaKuP26duMfx7mziauhL1yWI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TuqHI9rN2EF7G8y22fyB9UEo+J25HaaUc2pLAajvvEAjm3dFFh4dUCwe89ep65fBx
	 oziDSaCE9M1Bd3ZHNq3BxpKaxrUfQO14SHdIyjXLiuhxGjef4hEGfTL//Seskza7FZ
	 cndJAtzIEkufVu6e34ZO+kLK0DuXofGzjWCJo9qDnTOv2xd36pUJsOCRE8B6kkVm8v
	 ieHqYH8O/E3LvzFdOqs2zVF+E1tuTkiPPignNVHIojWniQdz/QGo63ohu5OGu5kMJ+
	 lSe+/0MbggHpHh4G5ag6swRgs5nEtaeRcdlEcTlqEw6cZcnevUkRabUHEbx3V7Q1YL
	 wAUeKFHVl7QHA==
Date: Thu, 7 May 2026 13:14:16 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Ian
 Rogers <irogers@google.com>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v19 0/7] ring-buffer: Making persistent ring buffers
 robust
Message-Id: <20260507131416.35bc304d89f974ae3b33d20b@kernel.org>
In-Reply-To: <20260502181619.7f5003dc@robin>
References: <177751968499.2136606.17388366710182662849.stgit@mhiramat.tok.corp.google.com>
	<20260502152304.560a5954@robin>
	<20260502181619.7f5003dc@robin>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 2 May 2026 18:17:06 -0400
Steven Rostedt <rostedt@kernel.org> wrote:

> On Sat, 2 May 2026 15:23:04 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > Hi Masami,
> > 
> > I applied your patches and enabled your ptracingtest code. I noticed
> > that when there's dropped pages, the trace output is not in order:
> > 
> >  # trace-cmd start -B ptracingtest -e all -v -e '*lock*'
> >  # taskset -c 5 echo c > /proc/sysrq-trigger
> > 
> > On reboot, I ran:
> > 
> >  # trace-cmd show -B ptracingtest > /tmp/trace.out
> > 
> > Then executed the attached perl program:
> > 
> >   # ./read-ts.pl < /tmp/trace.out
> > 
> > And it errors our:
> > 
> >  30.212495 < 30.213534
> >            <...>-1048    [005] d....    30.212495: irq_enable: caller=irqentry_exit+0xf5/0x710 parent=0x0
> > 
> > That is, I think the zero timestamps may be messing with the order.
> > 
> 
> Ah, I think I found the problem. The iterator needs the same logic you
> added for the consuming read:
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 7bfbed0ac90c..90a7fa772fe3 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -6105,12 +6105,14 @@ rb_iter_peek(struct ring_buffer_iter *iter, u64 *ts)
>  	struct ring_buffer_per_cpu *cpu_buffer;
>  	struct ring_buffer_event *event;
>  	int nr_loops = 0;
> +	int max_loops;
>  
>  	if (ts)
>  		*ts = 0;
>  
>  	cpu_buffer = iter->cpu_buffer;
>  	buffer = cpu_buffer->buffer;
> +	max_loops = cpu_buffer->ring_meta ? cpu_buffer->nr_pages : 3;
>  
>  	/*
>  	 * Check if someone performed a consuming read to the buffer
> @@ -6133,7 +6135,7 @@ rb_iter_peek(struct ring_buffer_iter *iter, u64 *ts)
>  	 * the ring buffer with an active write as the consumer is.
>  	 * Do not warn if the three failures is reached.
>  	 */
> -	if (++nr_loops > 3)
> +	if (++nr_loops > max_loops)
>  		return NULL;
>  
>  	if (rb_per_cpu_empty(cpu_buffer))
> 
> 
> I'll test this some more, and make a proper patch.

Ah, indeed. Thanks for fixing!

BTW, shouldn't we unify common logic of those functions?

Thank you,

> 
> -- Steve
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
