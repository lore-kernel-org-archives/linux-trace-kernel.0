Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6763D26ED51;
	Fri, 31 Oct 2025 02:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761876788; cv=none; b=VibLnFmwQmg+9VfUaXwPL7r/WQXRAGGyU0c4e+AYNKBfABG9HeDjhQyKYbIH8AGIcjMeKmqSjXbulGe0uBM6S50K4YAxF6QDZDIMmHP63Ci2ioChaK8YHzgvqrM8BYckmMr4A36xAvGvXzJs2VGjK9pA2jlTtan2+y9/nb3dIR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761876788; c=relaxed/simple;
	bh=+WcBso6J6LHQRJ4EScB/fJYa5oFGrBCc0QPlOxkJw1g=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Nt45RbiGuwCIGaSA+c2drcY2sew9cIOitnEE1RIk+FQa/hhIJ5YMyM9NdFQdjX/OP2l2eeSZZK7+VVHWt0a8ddLtrfv9d9fmxCeuYOl9ULskAVIXDg+RRZu9uqyoozHrZeXuolvOzWzZHRLIDTTaoJ8Xblgs0TPg/ZKaNl7ptwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBvkmt3N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBvkmt3N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DB1CC113D0;
	Fri, 31 Oct 2025 02:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761876786;
	bh=+WcBso6J6LHQRJ4EScB/fJYa5oFGrBCc0QPlOxkJw1g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MBvkmt3NuXwki28bwNSFGA3le6EkiRx7VsSJ6W1jakfMK8tPeh/7kI87/BqtR9Pnr
	 gHPCHCqqQDMDY321w4JWTijdqM3IZWnWZVq+Am9DphD2aLHP5H5mw2A8dp7bTW36vG
	 SwMnQkrNlLqdaZ3xeZi50Gdsd6P7/3EgtalETCzw/HJrMj0mfYiAj+DwWiIEoMRQBf
	 VArzOuILX+PGubnoC7lmKMcFSFnwo1UPFcEUU+vmrWhBeLzoejLb1XcZ7Iwur3J7a1
	 F7t0gBMFShiyHbPWZqIaRLz9gWHJDzRgqwDW8pjmTmgslpSqrh9Hq3JF8xnOSdk3hY
	 75opi9XMgW20A==
Date: Fri, 31 Oct 2025 11:13:02 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/2] tracing: Add an option to show symbols in
 _text+offset for function profiler
Message-Id: <20251031111302.43c44a032d350bc0fd3ac791@kernel.org>
In-Reply-To: <20251030052548.31130e33@gandalf.local.home>
References: <176179500583.960652.5730113001091388258.stgit@devnote2>
	<20251030052548.31130e33@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Oct 2025 05:25:48 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 30 Oct 2025 12:30:05 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> >  kernel/trace/blktrace.c              |    6 +
> >  kernel/trace/ftrace.c                |   26 ++++++
> >  kernel/trace/trace.c                 |  154 +++++++++++++++++-----------------
> >  kernel/trace/trace.h                 |   40 +++++----
> >  kernel/trace/trace_events.c          |    4 -
> >  kernel/trace/trace_events_synth.c    |    2 
> >  kernel/trace/trace_fprobe.c          |    6 +
> >  kernel/trace/trace_functions_graph.c |   18 ++--
> >  kernel/trace/trace_irqsoff.c         |   30 +++----
> >  kernel/trace/trace_kdb.c             |    2 
> >  kernel/trace/trace_kprobe.c          |    6 +
> >  kernel/trace/trace_output.c          |   18 ++--
> >  kernel/trace/trace_sched_wakeup.c    |   24 +++--
> >  kernel/trace/trace_syscalls.c        |    4 -
> >  kernel/trace/trace_wprobe.c          |    2 
> 
> I didn't realize this affected your branch too. Which means I can't apply
> this to any branch.
> 
> Also, could you make a helper function...
> 
> +++ b/kernel/trace/trace_wprobe.c
> @@ -260,7 +260,7 @@ print_wprobe_event(struct trace_iterator *iter, int flags,
>  
>         trace_seq_printf(s, "%s: (", trace_probe_name(tp));
>  
> -       if (!seq_print_ip_sym(s, field->ip, flags | TRACE_ITER_SYM_OFFSET))
> +       if (!seq_print_ip_sym(s, field->ip, flags | TRACE_ITER(SYM_OFFSET)))
>                 goto out;
>  
>         trace_seq_putc(s, ')');
> 
> that both fprobe and wprobe use? And then you don't need to have this open
> coded everywhere.
> 
> That is, add this patch:
> 
> diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
> index 591adc9bb1e9..bd26004cc320 100644
> --- a/kernel/trace/trace_probe.h
> +++ b/kernel/trace/trace_probe.h
> @@ -598,3 +598,9 @@ struct uprobe_dispatch_data {
>  	struct trace_uprobe	*tu;
>  	unsigned long		bp_addr;
>  };
> +
> +static inline int probe_print_ip_sym(struct trace_seq *s, unsigned long ip,
> +				     int flags)
> +{
> +	retun seq_print_ip_sym(s, field->ip, flags | TRACE_ITER_SYM_OFFSET);
> +}
> 
> And use that instead.

I would like to use more generic wrappers:

static inline int seq_print_ip_sym_offset(struct trace_seq *s, unsigned long ip,
					   unsigned long sym_flags)
{
	return seq_print_ip_sym(s,ip, sym_flags | TRACE_ITER(SYM_OFFSET));
}
static inline int seq_print_ip_sym_no_offset(struct trace_seq *s, unsigned long ip,
					   unsigned long sym_flags)
{
	return seq_print_ip_sym(s,ip, sym_flags & ~TRACE_ITER(SYM_OFFSET));
}

In trace_output.h, since this is also used in function_graph tracer.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
