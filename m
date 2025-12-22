Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD9C310645
	for <linux-trace-kernel@vger.kernel.org>; Mon, 22 Dec 2025 09:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766395671; cv=none; b=EglPIxsnykL80QHP8x0kyHIdC1MrEAbqvYDcf40vlZLnn2kl6EK6KLWIw4N+Sw9HmhsyqI/NZTH0zEjmzYWr66F0wMcZ/kNmGGogXcfmq+3cZZz6ekJMybZjuIoLqjZ3WJm15m6LcPvSQ2zdkaGc6ro7PRp+xxXDNE+o+f568rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766395671; c=relaxed/simple;
	bh=JYH5/bu4ImYZ50fvBX4wjzWj9z0o4KHDLPg9xM69O8M=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RvXEvshgXCGj85MWELtoYSAx3FhhrqapMBZ+xdDoDaRWxSlkJH/z7l14fkkZO8WVEcqMdwMjshjawBC3A+fXegNYAHpt4AypowO6VmrV0JHzKR6dFM9/Wdy3cFCeTRGsth0DNHbTCLoyWK0IXAoTjejO6NTda9DsVi0pjq1QiSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L/zK2NeC; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/zK2NeC"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4779a4fc95aso22698895e9.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 22 Dec 2025 01:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766395668; x=1767000468; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PI5uGQTHunOKVcPfjgmxdvLikWa4j+3IXZjeFwdnqhk=;
        b=L/zK2NeC/k+BfubqrIv+ndOeeUir0DPXsNpNkxS6iykY1uAAAvOQcRDmDEMcMqLJwb
         wRNMoyP+g1NVCOd/5tOpWsAZIG0/cfWbu1mgoVaM/S9kiledYnaDZqoiibTqpEraVWy0
         HxsS9wIKzSUG/r89+/DGpqtvSb5WHpqOUVk4IkKX/TuOUaB5mnrTQkPcG4MamkFpdunP
         RibD9TM4SwHDob+lngxZJN6u5Bjgf1UKVzFJ5ePgt4psGnH+exXaD+EPZ9KGRaTm9jhL
         OJCp7WeMna8McSbTGiHReM4nroD22JFJjaEGl5KKpNrVLTf3V7VrMi16j1zgW53Cxgeo
         WjTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766395668; x=1767000468;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PI5uGQTHunOKVcPfjgmxdvLikWa4j+3IXZjeFwdnqhk=;
        b=W4dxp4b+izUQOvphU4aSjiISzJT6st5XFEzPK5+AjNJwddODgNvLszL+HWaEDwGLGn
         6y6+SJof1inUaLWaUaBfobo9t0HpflgpSpX8R3PLQY9v7tIZITZHHlhjwdhx5XTdBHWS
         gEapDe7vIlWjp1IX3jIbkjT5bGUeX1ZnI3ejcMlqvak8h+E4e14PE7PCzcJvrkoBO7zT
         PqXOP+IBWO+l0C5+/Y2PLNqTz3kGHt1CPfVPnSWG4Q62FQxDsdx/z2FVhIHrJVGHlujw
         TmeYmO4HVJ3RPN+g5GEaQ14WNW7iU2hpOsZrNxkFTrKDotf18lIXwLBbo3mU8rjoHX46
         E+dw==
X-Forwarded-Encrypted: i=1; AJvYcCUgYQNhps8vsqxlR14ubGcNmX9OnVDF1QXtVCLqZcm9kcfkUY/HTd2/45bR6qrpIHPuUdJCP/Ucra9JMs169bsMUKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOjNUUhjpbwUTxZlzZU7vTQDjcCckbiwqV5tW2FAoBOtcxgaXj
	4vmZFWFHlGrUc/EEiwFvJWVyQNV64sj6ehQ3MoKinSZxavPG8cJ1Iehm
X-Gm-Gg: AY/fxX756QTcC/c5cnw1dbqJ5JVct6yLq94UGyk2bJE6rXdxLoV+wU50SQ2Ds9pJXDR
	MZguIe7tY0uNqllwt2siorTV4Ycd7Jg0gOaq8RlEwF0V8y+CQguU+rYDfLO3xsBSTb9FAFU9lIK
	cBKWoIKLxnF/JgT89QdxqhDcfHFVTmhGKu5iatto3yR4RVkbqVftiWKWj/NIEms6neiMTmvRKBR
	0WcWnvxpeR+Va7/cxm7zuqguyHeD0VbIlpUvwMWE2UMrOuIOIFvpAnb+hutA8g3S0C5C4N+NahK
	4LGZ1ISXX6hlS12TEMZwjsb9mB4aBOv4N6JSAGT1ik0CqxG08JDCNFSVtHvxzncpKb6OMsHy+QD
	j6XR+m6HE1A08rhNL86EXopmYJsyuneGbFDJamW6HuyMbB85cDCS38S7Nl7QbqkqcSbGEaBqf15
	Y=
X-Google-Smtp-Source: AGHT+IEV55ZOQdP5o3JyrZrQINeo+FQb70WvZndOhaibUFm8fNqn9704FtARzro8T+eZCxCMAym3og==
X-Received: by 2002:a05:600c:444d:b0:475:ddad:c3a9 with SMTP id 5b1f17b1804b1-47d18bdfc61mr114991725e9.13.1766395667950;
        Mon, 22 Dec 2025 01:27:47 -0800 (PST)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d19346d33sm185415365e9.3.2025.12.22.01.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 01:27:47 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 22 Dec 2025 10:27:40 +0100
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH] tracing: Do not register unsupported perf events
Message-ID: <aUkPDKzUc72nMFlR@krava>
References: <20251216182440.147e4453@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216182440.147e4453@gandalf.local.home>

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

lgtm

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka


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
