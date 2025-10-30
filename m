Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2930F23E33D;
	Thu, 30 Oct 2025 03:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761794949; cv=none; b=tbbhg8MbMbxZSly9colIB8bb/5ArJJVQVplBASo2RFb1dj8qWifcxpYJs4LGYrtIvM8TqXt+5IO3tW8+hHpEbM9BqoxY0sRZ3iP7+3K1Cd1Qa47xug1zvZ6waT3XmN0h5ypgpwSqKq3QMrORKGAT/U4nxNZ03Gl2L5Axk8LPc/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761794949; c=relaxed/simple;
	bh=9YGk7nC5zxruIR9JOvTtGAvEO338uvKvfB3Fx9gx+u0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=be9vKYQkw429JHhJ0iR5uRdFw0sxULFBpLOkLUaoWyW1e+itplQp/xyckyxFluoBEF0VU2xGCeyz3KcDfN0gZ69maEgqVl4z2YjHG/teP7QY7FXEdfDnBseZLC2w1vX7T/1FFsJCe6tqiaIx/Q8OuSOlFVq5l84buTDmhzqbPcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cuFLiSEx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cuFLiSEx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1A58C4CEF7;
	Thu, 30 Oct 2025 03:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761794945;
	bh=9YGk7nC5zxruIR9JOvTtGAvEO338uvKvfB3Fx9gx+u0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cuFLiSExx29MvGAti99VsaK1b3zwEUsWh7/BrMy3PqWxZFHV0QgNq4maFTWVa5JI0
	 U/ylEeqZezYCjMSCEwUYS6VrZkTRHVipWhUOFr5PWRJC003wPQIdl7frKiVRxjHA7Y
	 zitqtjrxrzgEXW4ZXbrhtz+ukriSSt0ovR6rbSZW21H58T+8b1GGoQb1GaQuxCRWvf
	 RPpxoS+tVWc80LVRhX5/wTDNKFp8O1YbuWsYDvMNi6xlSf7u/1S8f4FAvgp/AWcRTJ
	 5DeZ9QTpUkPLppnzAY4fT74tIQGEps6a+StVIxC4Wswcey2DnYIOjrw0gsZWKBOb5D
	 tnM+Zkz5Z9XGQ==
Date: Thu, 30 Oct 2025 12:29:01 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/2] tracing: Add an option to show symbols in
 _text+offset for function profiler
Message-Id: <20251030122901.46a51bfe643daa9910ad4110@kernel.org>
In-Reply-To: <176179330871.957820.2367690308433599462.stgit@devnote2>
References: <176179330871.957820.2367690308433599462.stgit@devnote2>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Oops, I missed to update the version in the subject. Let me update it.

On Thu, 30 Oct 2025 12:01:48 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> Hi,
> 
> This series implements an option to show symbols in _text+OFFSET
> format instead of symbol name in the function profiler.
> This is the 6th version, the previous one is here;
> 
> https://lore.kernel.org/all/176114747153.315239.6863821259073466010.stgit@devnote2/
> 
> This version is rebased on top of linux-trace/for-next branch
> and modify offset format to hex.
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
>  kernel/trace/trace_sched_wakeup.c    |   24 +++--
>  kernel/trace/trace_syscalls.c        |    4 -
>  kernel/trace/trace_wprobe.c          |    2 
>  15 files changed, 187 insertions(+), 155 deletions(-)
> 
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
