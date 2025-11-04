Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898ED2D94A2;
	Tue,  4 Nov 2025 12:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762260933; cv=none; b=XIQXgJ2F2AtyvchDHWYXoliuMaETTsX/kfeID0gE8NvyBoUijeZv15z1vZ3gkry4tnc1uxhfhlwOUdA8tnuzzSXL3VUXGqOi2BvFq2bPFDxxGfGBcFrX8t2XOO/PJnnOfk1Tmloq4Qs86aTynDeZUApipB2YRNUaC7AG3nwUG/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762260933; c=relaxed/simple;
	bh=MhCUTbVX6LKHf/ue6j/1JMNY3Ke/+4td5QlIn2Fw5gY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=SqmMlrhmChbKc4cdGqeXgbCY8jgs+/iOYN+NY+gDHArK67FvHkST8f52yz/YuIEtx6MCkmPXotIDlMtTzxPpRndJ0AYJ02Hq5Boj8rH1MpohjJh4F4uEDJWuF79qH+n+wpeyumdd9UtqrqCImDotEAQB/qUW++Ot2sGrzWv8iL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VNGKxpSU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNGKxpSU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52800C4CEF7;
	Tue,  4 Nov 2025 12:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762260932;
	bh=MhCUTbVX6LKHf/ue6j/1JMNY3Ke/+4td5QlIn2Fw5gY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VNGKxpSUNN3xx9jruSUVlky+bfMmaZPeQ3SIXsy6Gjg96ckzSr2516QjcJdDOECyk
	 RlPiyL1aqHRQaW8bYkAkdmM0okg9e22+UWl3gqkozos9HOHnNMdxGQ10VZMrjLxy9N
	 sLC9vcIFGOUk/ifc2WZXC5wlDhUtkDzSalJMk6eq7DwcMetYjiWVrdMVhuBgFH44Ki
	 Nl2sTmivjMEd1phVbu0VYrZl4UfXJjRnfuzwohxaCBPwTf5yjMGqTDJuju6QoAXY7l
	 bnnTYfRA7TewQ69BIIlVwAe6WvcNUHs0tfA3c684V8DxbE5bf5ICt5Yvd9xjTfVGIW
	 A9FAFbZm7cnYQ==
Date: Tue, 4 Nov 2025 21:55:27 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/2] tracing: Add an option to show symbols in
 _text+offset for function profiler
Message-Id: <20251104215527.bb43e070a540d58674d8e109@kernel.org>
In-Reply-To: <176187876133.994619.14047043856461447890.stgit@devnote2>
References: <176187876133.994619.14047043856461447890.stgit@devnote2>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Steve,

I've pushed these 2 patches (with Link tag) into:

https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git/log/?h=topic/func-profiler-offset

So feel free to merge that branch.
Also, let me send a wprobe patch for this change.

Thank you,


On Fri, 31 Oct 2025 11:46:01 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> Hi,
> 
> This series implements an option to show symbols in _text+OFFSET
> format instead of symbol name in the function profiler.
> This is the 7th version, the previous one is here;
> 
> https://lore.kernel.org/all/176179500583.960652.5730113001091388258.stgit@devnote2/
> 
> This version is rebased on top of v6.19-rc3 and introduces wrapper
> functions of seq_print_ip_sym() for showing offset or not.
> 
> Thank you,
> 
> ---
> 
> Masami Hiramatsu (Google) (2):
>       tracing: Allow tracer to add more than 32 options
>       tracing: Add an option to show symbols in _text+offset for function profiler
> 
> 
>  kernel/trace/blktrace.c              |    6 +
>  kernel/trace/ftrace.c                |   26 ++++++
>  kernel/trace/trace.c                 |  154 +++++++++++++++++-----------------
>  kernel/trace/trace.h                 |   40 +++++----
>  kernel/trace/trace_events.c          |    4 -
>  kernel/trace/trace_events_synth.c    |    2 
>  kernel/trace/trace_fprobe.c          |    6 +
>  kernel/trace/trace_functions_graph.c |   18 ++--
>  kernel/trace/trace_irqsoff.c         |   30 +++----
>  kernel/trace/trace_kdb.c             |    2 
>  kernel/trace/trace_kprobe.c          |    6 +
>  kernel/trace/trace_output.c          |   18 ++--
>  kernel/trace/trace_output.h          |   11 ++
>  kernel/trace/trace_sched_wakeup.c    |   24 +++--
>  kernel/trace/trace_syscalls.c        |    2 
>  15 files changed, 196 insertions(+), 153 deletions(-)
> 
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
