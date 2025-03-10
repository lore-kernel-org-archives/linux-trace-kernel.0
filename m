Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7A51B4153;
	Mon, 10 Mar 2025 05:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741586106; cv=none; b=WUOifg7B7prVPfCHecfJOPylpjv9KDAAQRkco3X2iZOFIVCCNjz9h9FmAcmkDp1P+HoHMJf58ktr0PtWYgucH/Rfjj5WjRe25nuEMYyEg4E1oim2vqBybuIncHF6s9dgRJ7k/BhP0beRG8AmA/ZOSTSmgac57Ew2A2f164ze+PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741586106; c=relaxed/simple;
	bh=b7scm8QvqEOvTUxbRDNpSia23VgYgAxSNIx2p167awc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=olHxRa4OxD3p1Ex76Xg1KbuowfMXXExiOsFPsuxnrmzAc6a2+i+ROSbHFXlsUTJMR/sBXNnLb0HrnW6vF/+1Z4lxZx1QhT/ZvQNVxlJfIybPl9Rsmu+3ewodQbW4MSR8/HPYv6fX+4sZOHKtK7CKBIm01b48ihxTxsEfqFULB5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M3CNeaOt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3CNeaOt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E3D4C4CEE5;
	Mon, 10 Mar 2025 05:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741586105;
	bh=b7scm8QvqEOvTUxbRDNpSia23VgYgAxSNIx2p167awc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M3CNeaOtBguFzh4d/CKYVrT6h/uvYJoasMX4j3q2Nc4b+2LhxUgPP3pg2oluvUJVn
	 PJea6Ki4ifcfYCm1DJcI02Q3h21S+O+9VdIXbOBfs2MNJ7mryK1pLKGoBYQIMXrbS5
	 I5hLtG9953mmhTB3lb3eWjA75m86it1PMuA95nbkTfNJYUC1shad9YDa/C2SkdSmlj
	 RhuXQC0eCSYOSkL66812cpozlGRgHmd25ak9MRretXAnv1/fBnk7UCFMdHWdrkVdmb
	 UUS1zpi39joamja5oG5qqLKGaJ3I3dd3c+21kFM2BbOIzYNaSGkHwT6voeNkRRKDWJ
	 lN9/neQw7s3BQ==
Date: Mon, 10 Mar 2025 14:55:02 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: tprobe-events: Fix to clean up tprobe
 correctly when module unload
Message-Id: <20250310145502.2340b2fd7d559164479eb4f4@kernel.org>
In-Reply-To: <20250307122000.3087782f@gandalf.local.home>
References: <174124210422.3014222.12363751066695445786.stgit@mhiramat.tok.corp.google.com>
	<20250307122000.3087782f@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Mar 2025 12:20:00 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu,  6 Mar 2025 15:21:44 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > When unloading module, the tprobe events are not correctly cleaned
> > up. Thus it becomes `fprobe-event` and never be enabled again even
> > if loading the same module again.
> > 
> > For example;
> > 
> >  # cd /sys/kernel/tracing
> >  # modprobe trace_events_sample
> >  # echo 't:my_tprobe foo_bar' >> dynamic_events
> >  # cat dynamic_events
> > t:tracepoints/my_tprobe foo_bar
> >  # rmmod trace_events_sample
> >  # cat dynamic_events
> > f:tracepoints/my_tprobe foo_bar
> > 
> > As you can see, the second time my_tprobe starts with 'f' instead
> > of 't'.
> > 
> > This cleans up (unregister) the tprobe events when module is
> > unloaded.
> 
> After applying this, I tried it out:
> 
>  # cd /sys/kernel/tracing
>  # modprobe trace_events_sample
>  # echo 't:my_tprobe foo_bar a=$arg1' > dynamic_events
>  # echo 1 > events/tracepoints/enable
> [wait]
>  # echo 0 > events/tracepoints/enable
>  # cat trace
> # tracer: nop
> #
> # entries-in-buffer/entries-written: 13/13   #P:8
> #
> #                                _-----=> irqs-off/BH-disabled
> #                               / _----=> need-resched
> #                              | / _---=> hardirq/softirq
> #                              || / _--=> preempt-depth
> #                              ||| / _-=> migrate-disable
> #                              |||| /     delay
> #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> #              | |         |   |||||     |         |
>     event-sample-1041    [005] ...1.  1957.632897: my_tprobe: (__probestub_foo_bar+0x4/0x20 [trace_events_sample]) a=0xffffffffc006c186
>     event-sample-1041    [005] ...1.  1958.656935: my_tprobe: (__probestub_foo_bar+0x4/0x20 [trace_events_sample]) a=0xffffffffc006c186
>     event-sample-1041    [005] ...1.  1959.680883: my_tprobe: (__probestub_foo_bar+0x4/0x20 [trace_events_sample]) a=0xffffffffc006c186
>     event-sample-1041    [005] ...1.  1960.704855: my_tprobe: (__probestub_foo_bar+0x4/0x20 [trace_events_sample]) a=0xffffffffc006c186
>     event-sample-1041    [005] ...1.  1961.728977: my_tprobe: (__probestub_foo_bar+0x4/0x20 [trace_events_sample]) a=0xffffffffc006c186
>     event-sample-1041    [005] ...1.  1962.751822: my_tprobe: (__probestub_foo_bar+0x4/0x20 [trace_events_sample]) a=0xffffffffc006c186
>     event-sample-1041    [005] ...1.  1963.776834: my_tprobe: (__probestub_foo_bar+0x4/0x20 [trace_events_sample]) a=0xffffffffc006c186
>     event-sample-1041    [005] ...1.  1964.800748: my_tprobe: (__probestub_foo_bar+0x4/0x20 [trace_events_sample]) a=0xffffffffc006c186
>     event-sample-1041    [005] ...1.  1965.824788: my_tprobe: (__probestub_foo_bar+0x4/0x20 [trace_events_sample]) a=0xffffffffc006c186
>     event-sample-1041    [005] ...1.  1966.848789: my_tprobe: (__probestub_foo_bar+0x4/0x20 [trace_events_sample]) a=0xffffffffc006c186
>     event-sample-1041    [005] ...1.  1967.872902: my_tprobe: (__probestub_foo_bar+0x4/0x20 [trace_events_sample]) a=0xffffffffc006c186
>     event-sample-1041    [005] ...1.  1968.896754: my_tprobe: (__probestub_foo_bar+0x4/0x20 [trace_events_sample]) a=0xffffffffc006c186
>     event-sample-1041    [005] ...1.  1969.920737: my_tprobe: (__probestub_foo_bar+0x4/0x20 [trace_events_sample]) a=0xffffffffc006c186
>  # rmmod trace_events_sample
>  # cat trace
> # tracer: nop
> #
> # entries-in-buffer/entries-written: 13/13   #P:8
> #
> #                                _-----=> irqs-off/BH-disabled
> #                               / _----=> need-resched
> #                              | / _---=> hardirq/softirq
> #                              || / _--=> preempt-depth
> #                              ||| / _-=> migrate-disable
> #                              |||| /     delay
> #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> #              | |         |   |||||     |         |
>     event-sample-1041    [005] ...1.  1957.632897: my_tprobe: (0xffffffffc00620b4) a=0xffffffffc006c186
>     event-sample-1041    [005] ...1.  1958.656935: my_tprobe: (0xffffffffc00620b4) a=0xffffffffc006c186
>     event-sample-1041    [005] ...1.  1959.680883: my_tprobe: (0xffffffffc00620b4) a=0xffffffffc006c186
>     event-sample-1041    [005] ...1.  1960.704855: my_tprobe: (0xffffffffc00620b4) a=0xffffffffc006c186
>     event-sample-1041    [005] ...1.  1961.728977: my_tprobe: (0xffffffffc00620b4) a=0xffffffffc006c186
>     event-sample-1041    [005] ...1.  1962.751822: my_tprobe: (0xffffffffc00620b4) a=0xffffffffc006c186
>     event-sample-1041    [005] ...1.  1963.776834: my_tprobe: (0xffffffffc00620b4) a=0xffffffffc006c186
>     event-sample-1041    [005] ...1.  1964.800748: my_tprobe: (0xffffffffc00620b4) a=0xffffffffc006c186
>     event-sample-1041    [005] ...1.  1965.824788: my_tprobe: (0xffffffffc00620b4) a=0xffffffffc006c186
>     event-sample-1041    [005] ...1.  1966.848789: my_tprobe: (0xffffffffc00620b4) a=0xffffffffc006c186
>     event-sample-1041    [005] ...1.  1967.872902: my_tprobe: (0xffffffffc00620b4) a=0xffffffffc006c186
>     event-sample-1041    [005] ...1.  1968.896754: my_tprobe: (0xffffffffc00620b4) a=0xffffffffc006c186
>     event-sample-1041    [005] ...1.  1969.920737: my_tprobe: (0xffffffffc00620b4) a=0xffffffffc006c186
> 
>  # modprobe trace_events_sample
>  # echo 1 > events/tracepoints/enable
>  # cat trace
> # tracer: nop
> #
> # entries-in-buffer/entries-written: 13/13   #P:8
> #
> #                                _-----=> irqs-off/BH-disabled
> #                               / _----=> need-resched
> #                              | / _---=> hardirq/softirq
> #                              || / _--=> preempt-depth
> #                              ||| / _-=> migrate-disable
> #                              |||| /     delay
> #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> #              | |         |   |||||     |         |
>     event-sample-1041    [005] ...1.  1957.632897: my_tprobe: (0xffffffffc00620b4) a=0xffffffffc006c186
>     event-sample-1041    [005] ...1.  1958.656935: my_tprobe: (0xffffffffc00620b4) a=0xffffffffc006c186
>     event-sample-1041    [005] ...1.  1959.680883: my_tprobe: (0xffffffffc00620b4) a=0xffffffffc006c186
>     event-sample-1041    [005] ...1.  1960.704855: my_tprobe: (0xffffffffc00620b4) a=0xffffffffc006c186
>     event-sample-1041    [005] ...1.  1961.728977: my_tprobe: (0xffffffffc00620b4) a=0xffffffffc006c186
>     event-sample-1041    [005] ...1.  1962.751822: my_tprobe: (0xffffffffc00620b4) a=0xffffffffc006c186
>     event-sample-1041    [005] ...1.  1963.776834: my_tprobe: (0xffffffffc00620b4) a=0xffffffffc006c186
>     event-sample-1041    [005] ...1.  1964.800748: my_tprobe: (0xffffffffc00620b4) a=0xffffffffc006c186
>     event-sample-1041    [005] ...1.  1965.824788: my_tprobe: (0xffffffffc00620b4) a=0xffffffffc006c186
>     event-sample-1041    [005] ...1.  1966.848789: my_tprobe: (0xffffffffc00620b4) a=0xffffffffc006c186
>     event-sample-1041    [005] ...1.  1967.872902: my_tprobe: (0xffffffffc00620b4) a=0xffffffffc006c186
>     event-sample-1041    [005] ...1.  1968.896754: my_tprobe: (0xffffffffc00620b4) a=0xffffffffc006c186
>     event-sample-1041    [005] ...1.  1969.920737: my_tprobe: (0xffffffffc00620b4) a=0xffffffffc006c186
> 
> Tracing doesn't restart.

Ah, I see. __unregister_trace_fprobe() clean up fp.

static void __unregister_trace_fprobe(struct trace_fprobe *tf)
{
	if (trace_fprobe_is_registered(tf)) {
		unregister_fprobe(&tf->fp);
		memset(&tf->fp, 0, sizeof(tf->fp)); <---- this

This will cleanup the callbacks.

Let me update it.

Thanks!

> 
> -- Steve
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
