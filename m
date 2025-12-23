Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB101FA272;
	Tue, 23 Dec 2025 18:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766514142; cv=none; b=BYbmL6XZZ6aTo60UZ4O2E16xiMiT5EngZCjA1zdo/G9o0FDDksNUP8dhOY50sZ5tCKLITnIM1pMAWOah+dn4u7VFppod8GNSDjHVUgyllg7Lqdb674YQjZW1/uBCVr8tQqBaPP8O4IyrA7g7v/R/PWUUTsgjKivftMHc5ToEjEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766514142; c=relaxed/simple;
	bh=qzXy3vZ2NxiofSqsliizvp6iFGXMCb3s6t8khArZR8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ht5kJDUHYoneCOgBymGxiE62oTyn7HoXiTPnsGekuRELWJ7XHy9O2Hvkuhhv+VWf5rHsdBQNYsTlrgjsHAkEJPzNRiLU/hPuwh2PrJTLHCgUBZR6jBKOkQhDvOUKB+iAMzKdl61/TMSMXM84ogbQ5eYYg3LsEbKks3yRDZxsIuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OcFb8zdn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OcFb8zdn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22EC6C113D0;
	Tue, 23 Dec 2025 18:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766514141;
	bh=qzXy3vZ2NxiofSqsliizvp6iFGXMCb3s6t8khArZR8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OcFb8zdn6sBzkrAxMiq0Y5dS5NE9GSkBAoVzdx3QjucXeiI2x3hZbKq1MDEOCPf2Q
	 R9D9EC4T0XIC2UtFTkMNydw2hupmbfA0KvRa8Fo5jtsCIFM3+cLf3cj44u0xd+3h2R
	 yGIQ6Abi/gTjKYayx7Wo7ZG5uSpTOxXHfZjyZhVDWZq2DcNLOOLPhDjdfZS8EWMq3X
	 5g1WKFbokzw/cCJZmnAk1/xKoYhXfee/r6lzKkdW1P0h6YIkAfMDL9QVxvtogwvkND
	 DfPNn72yVmhOmial4zyXOXX8qqdaDHPOc40U7zzpSD8VuWb07sB0Sym0666rqpqSFG
	 phM2u/9x77amQ==
Date: Tue, 23 Dec 2025 10:22:18 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH] tracing: Do not register unsupported perf events
Message-ID: <aUrd2k8ckouCB_bQ@google.com>
References: <20251216182440.147e4453@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251216182440.147e4453@gandalf.local.home>

Hi Steve,

On Tue, Dec 16, 2025 at 06:24:40PM -0500, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> Synthetic events currently do not have a function to register perf events.
> This leads to calling the tracepoint register functions with a NULL
> function pointer which triggers:
> 
>  ------------[ cut here ]------------
>  WARNING: kernel/tracepoint.c:175 at tracepoint_add_func+0x357/0x370, CPU#2: perf/2272
>  Modules linked in: kvm_intel kvm irqbypass
>  CPU: 2 UID: 0 PID: 2272 Comm: perf Not tainted 6.18.0-ftest-11964-ge022764176fc-dirty #323 PREEMPTLAZY
>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
>  RIP: 0010:tracepoint_add_func+0x357/0x370
>  Code: 28 9c e8 4c 0b f5 ff eb 0f 4c 89 f7 48 c7 c6 80 4d 28 9c e8 ab 89 f4 ff 31 c0 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc cc <0f> 0b 49 c7 c6 ea ff ff ff e9 ee fe ff ff 0f 0b e9 f9 fe ff ff 0f
>  RSP: 0018:ffffabc0c44d3c40 EFLAGS: 00010246
>  RAX: 0000000000000001 RBX: ffff9380aa9e4060 RCX: 0000000000000000
>  RDX: 000000000000000a RSI: ffffffff9e1d4a98 RDI: ffff937fcf5fd6c8
>  RBP: 0000000000000001 R08: 0000000000000007 R09: ffff937fcf5fc780
>  R10: 0000000000000003 R11: ffffffff9c193910 R12: 000000000000000a
>  R13: ffffffff9e1e5888 R14: 0000000000000000 R15: ffffabc0c44d3c78
>  FS:  00007f6202f5f340(0000) GS:ffff93819f00f000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 000055d3162281a8 CR3: 0000000106a56003 CR4: 0000000000172ef0
>  Call Trace:
>   <TASK>
>   tracepoint_probe_register+0x5d/0x90
>   synth_event_reg+0x3c/0x60
>   perf_trace_event_init+0x204/0x340
>   perf_trace_init+0x85/0xd0
>   perf_tp_event_init+0x2e/0x50
>   perf_try_init_event+0x6f/0x230
>   ? perf_event_alloc+0x4bb/0xdc0
>   perf_event_alloc+0x65a/0xdc0
>   __se_sys_perf_event_open+0x290/0x9f0
>   do_syscall_64+0x93/0x7b0
>   ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
>   ? trace_hardirqs_off+0x53/0xc0
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> Instead, have the code return -ENODEV, which doesn't warn and has perf
> error out with:
> 
>  # perf record -e synthetic:futex_wait
> Error:
> The sys_perf_event_open() syscall returned with 19 (No such device) for event (synthetic:futex_wait).
> "dmesg | grep -i perf" may provide additional information.
> 
> Ideally perf should support synthetic events, but for now just fix the
> warning. The support can come later.
> 
> Cc: stable@vger.kernel.org
> Fixes: 4b147936fa509 ("tracing: Add support for 'synthetic' events")
> Reported-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  kernel/trace/trace_events.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index a5a93d243047..754b14ca87a7 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -710,6 +710,8 @@ int trace_event_reg(struct trace_event_call *call,
>  
>  #ifdef CONFIG_PERF_EVENTS
>  	case TRACE_REG_PERF_REGISTER:
> +		if (!call->class->perf_probe)
> +			return -ENODEV;
>  		return tracepoint_probe_register(call->tp,
>  						 call->class->perf_probe,
>  						 call);
> -- 
> 2.51.0
> 
