Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8171117FD;
	Tue,  1 Oct 2024 13:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727790414; cv=none; b=LEG8//aC259PWq4wI63vOAavroVLf1wAhR8ehHg2ew4hcmAK1HFJAFfJdNr7AWLsA/5pcoE9+yPotzNOzFWPXTbbg88cPeY/PYENSYg22kaDF4oEqBE1DVbHxu09HZxmzbgn/VjEr79RUJ5pzPvB4fn1DZnbMY2FBPXUw0pcqpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727790414; c=relaxed/simple;
	bh=VOwizr58+KJxA4KMlG2E00oPghiL9j7wzXU5Y4ngGD4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F6K9FnQyaln3M/XutBNEq0tN2anQewR13hYy57myjSoMEZTbAeoX1Dl5Mh/jt1/YDaijYA16IEbUV5zyJWPdRn6JBDJApgO9gODofoRhkiWIAOE/O20zXrg7/Z1duuYMwtjdwG21YRMkyW4UNWZOcT9gihdgl87eJ9WuReMXvT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71B87C4CEC6;
	Tue,  1 Oct 2024 13:46:53 +0000 (UTC)
Date: Tue, 1 Oct 2024 09:47:42 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: ts <tatsuya.s2862@gmail.com>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ftrace: Hide a extra entry in stack trace
Message-ID: <20241001094742.1282d2ad@gandalf.local.home>
In-Reply-To: <509829ab-98b5-4429-ba59-e1fc7b300682@gmail.com>
References: <20240926061311.25625-1-tatsuya.s2862@gmail.com>
	<20240930085139.5d34f28236a67ef1e9143655@kernel.org>
	<509829ab-98b5-4429-ba59-e1fc7b300682@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Oct 2024 22:27:03 +0900
ts <tatsuya.s2862@gmail.com> wrote:

> > ...
> >                sh-140     [001] ...1.    18.352601: myevent: (vfs_write+0x4/0x560)
> >                sh-140     [001] ...1.    18.352602: <stack trace>  
> >   => ksys_write
> >   => do_syscall_64
> >   => entry_SYSCALL_64_after_hwframe  
> >                sh-140     [001] ...1.    18.352602: vfs_write <-ksys_write
> >                sh-140     [001] ...1.    18.352604: <stack trace>  
> >   => ftrace_regs_call
> >   => vfs_write
> >   => ksys_write
> >   => do_syscall_64
> >   => entry_SYSCALL_64_after_hwframe  
> > ------
> > As you can see, myevent skips "vfs_write".
> > (and function tracer still have ftrace_regs_call() )  
> 
> Thanks for the other tests. This issue may be function_trace_call() 
> specific problem.
> 
> So I will change the place to increment skip number.

My fear is that we are going to just break it elsewhere. The problem with
the "skip" is that there's so many configurations when we get here, we may
not really know what to skip. If the compiler inlines something, then we
may skip something we do not want to.

I rather have extra information than not enough.

-- Steve
