Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2AA3DFC7C
	for <linux-trace-kernel@vger.kernel.org>; Wed, 27 May 2026 08:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779872348; cv=none; b=uzILxoJ0gBJWxj3wagpdW/6Xxzss9QMI1dlqxTfTfD/5VWIZSSwQSJASD8+u0YI3BZt54NhjdNpfi1yBOGFt4NdZh3aOGwd5B+PCDV31TvCSzQUn4rs3Q6S3PrPigmHjRidiB+y05ZgCdHvqZftj4zj+uDhPgwqLk8DROwd4cmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779872348; c=relaxed/simple;
	bh=6OBZoCSq1eBzVuZoO5mnx5tqo/HNYIF/juzQ4/NPuwc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HUMFK+TsGtNz0nIwz1qOexpyAR7kNZprNxSIDG3PZTSfqD+DHPp6+WwmvsAzFyc7zhEfV5iv4+PDrZF9BXGBuN/jyby97s66e/OvRpkaXfN+VarmYJQSn6SY0ewdQ787O/XL3UwaaNkKbnav0A9AIvXhYEESaoPFZGEcrDcN6so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E+KMAX2v; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+KMAX2v"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-44e5624c053so6833449f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 27 May 2026 01:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779872345; x=1780477145; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ke8JjnRD7ShO76lQpq1z4WWUNsFFn+xm7G1XcSMQ0cw=;
        b=E+KMAX2v5sKs5cep0V+VuGDCGxBWErurA1gYkP+iL9AqGTkOXtBDB5eNaM4aqh10jf
         TsMuZThenRv9SJZ0dR25q1C5hw5vWdA29yYXc3km9o12msU13GrTYv3mYvXZIBsfT+QX
         D3DF9P88ReRHSAmXJMOrpcHx7OWXNvjzsw1TJMMvw5k8ZtI62TdL1cvs4WsZL81bRqCR
         oYljgZ0bOCN6IEnMfNygmN2d3PUL840zIsFvZHfRxhYgji9JMttXx5tUnoj14+5zxaB5
         W4ZVZTpVs3hGutkqEcrFJdUdLNOW3FaGY6ipVKkF1LZ6wHQdPcAVSBtL4j1V0v1WaXvS
         ri/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779872345; x=1780477145;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ke8JjnRD7ShO76lQpq1z4WWUNsFFn+xm7G1XcSMQ0cw=;
        b=bWJ2Z2FtI/mdn68hqbIrYdN9+BD/etWa20sPTc2/hpuAGYqQGsQV5eGwA9hDurLQtH
         Q9IjxYr1F7AYUvRsN2CmLYYfLHrsvxiKnfgoLmfdK+53sWwQr14rgd1bglfObMrBGto9
         Mt+4tc7pahad77o/naeJSIt4oFr67cPDuR1v3pPU59pm25fV0Sf1xAeyca4gwm9rcoYp
         PdNPGCp7ZP0GayCpCP9kFu4us7Vr8+UqvQc1z9hojol+DFSBu/vpsYRYRcvQAWIsN6Xn
         OBv7NKrPcSli0UrIYL3hL3CqDFN1jNIGBPk1ACfOUMe0WIX9XKFEttFiXfzQ6YMDEgB5
         Dgtg==
X-Forwarded-Encrypted: i=1; AFNElJ96lGf72fIUshOXvM6X1veduLQY627Cz2j3N2lPYU+kwS63go8ZopQpAIDZ8sCcX+5rcmAGkARu/My9XEf20cg3kQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxceqG53T1ru42hq5ijhH6ovXoJShctLX+j8o54tqQ/Q0n9610W
	OVPClkDlIGEaI6fH0sWtI0NzriGTjNVL1tFBdja0KS30ReQJgtDNEot8
X-Gm-Gg: Acq92OEq7uUPmcolMomAqISxxSkNfB98Mb3kx9Lql4us7HRqNZNlSgLCXJUFfG2em/s
	IX5q8lWLCsbTPEqqNxxlq4rqpk7W3jogwJHBa/f/EgI/h28OLNADt4JTq5SMnO2HEvlomPts/rt
	tZyNKJfZQvEA/7pu1mhdapvb+K4K7gys4OuNKrlnkJAVpAWZ6Nyv16IpcgRkvZIp1AeIJEC88n8
	zGW3QWX5juKSmj9W2sBZgmwY6U+LMMt/ihBCAXVWx7eI3hvY3Xjw+hKcqjyP1ev12/6WvHsIYRq
	+fq1QsPHvrdA1eiJApy/2ayhvjxWXFoRcXknulRXO6x6PFd4IdISAlGuenUaAqDLuEodg9Gddw3
	HDiba+K9UkeKX1vNrE2Qqd83dYytUzHbvDdYwk8/taYihwlnuXAtOtH29Dbn9OYYnKZRvJwQipB
	ESLuMX4AyXuZQ3Gm6advT97pRTNVx/3OPOtPPU
X-Received: by 2002:a05:6000:41c9:b0:45d:4a00:b927 with SMTP id ffacd0b85a97d-45eb38a1840mr37164038f8f.31.1779872344742;
        Wed, 27 May 2026 01:59:04 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200:b655:ff13:e355:16a3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb5b314dsm4052782f8f.30.2026.05.27.01.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 01:59:04 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 27 May 2026 10:59:02 +0200
To: Steven Rostedt <rostedt@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Takaya Saeki <takayas@google.com>,
	Douglas Raillard <douglas.raillard@arm.com>,
	Tom Zanussi <zanussi@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <olsajiri@gmail.com>
Subject: Re: [PATCH v6] tracing/eprobes: Allow use of BTF names to
 dereference pointers
Message-ID: <ahayVg7TvNrf1ama@krava>
References: <20260521225033.56458336@fedora>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521225033.56458336@fedora>

On Thu, May 21, 2026 at 10:50:33PM -0400, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> Add syntax to the parsing of eprobes to be able to typecast a trace event
> field that is a pointer to a structure.
> 
> Currently, a dereference must be a number, where the user has to figure
> out manually the offset of a member of a structure that they want to
> dereference.
> 
> But for event probes that records a field that happens to be a pointer to
> a structure, it cannot dereference these values with BTF naming, but
> must use numerical offsets.
> 
> For example, to find out what device a sk_buff is pointing to in the
> net_dev_xmit trace event, one must first use gdb to find the offsets of the
> members of the structures:
> 
>  (gdb) p &((struct sk_buff *)0)->dev
>  $1 = (struct net_device **) 0x10
>  (gdb) p &((struct net_device *)0)->name
>  $2 = (char (*)[16]) 0x118
> 
> And then use the raw numbers to dereference:
> 
>   # echo 'e:xmit net.net_dev_xmit +0x118(+0x10($skbaddr)):string' >> dynamic_events
> 
> If BTF is in the kernel, then instead, the skbaddr can be typecast to
> sk_buff and use the normal dereference logic.
> 
>   # echo 'e:xmit net.net_dev_xmit (sk_buff)skbaddr->dev->name:string' >> dynamic_events
>   # echo 1 > events/eprobes/xmit/enable
>   # cat trace
> [..]
>     sshd-session-1022    [000] b..2.   860.249343: xmit: (net.net_dev_xmit) arg1="enp7s0"
>     sshd-session-1022    [000] b..2.   860.250061: xmit: (net.net_dev_xmit) arg1="enp7s0"
>     sshd-session-1022    [000] b..2.   860.250142: xmit: (net.net_dev_xmit) arg1="enp7s0"
>     sshd-session-1022    [000] b..2.   860.263553: xmit: (net.net_dev_xmit) arg1="enp7s0"
>     sshd-session-1022    [000] b..2.   860.283820: xmit: (net.net_dev_xmit) arg1="enp7s0"
>     sshd-session-1022    [000] b..2.   860.302716: xmit: (net.net_dev_xmit) arg1="enp7s0"
>     sshd-session-1022    [000] b..2.   860.322905: xmit: (net.net_dev_xmit) arg1="enp7s0"
>     sshd-session-1022    [000] b..2.   860.342828: xmit: (net.net_dev_xmit) arg1="enp7s0"
>     sshd-session-1022    [000] b..2.   860.362268: xmit: (net.net_dev_xmit) arg1="enp7s0"
>     sshd-session-1022    [000] b..2.   860.382335: xmit: (net.net_dev_xmit) arg1="enp7s0"
>     sshd-session-1022    [000] b..2.   860.400856: xmit: (net.net_dev_xmit) arg1="enp7s0"
>     sshd-session-1022    [000] b..2.   860.419893: xmit: (net.net_dev_xmit) arg1="enp7s0"
> 
> The syntax is simply: (STRUCT)(FIELD)->MEMBER[->MEMBER..]
> 
> Also add comments around the #else and #endif of #ifdef CONFIG_PROBE_EVENTS_BTF_ARGS
> to know what they are for.

hi,
this seems to be supported only for argument (pointer) stored in the trace record,
not the actual arguments to the tracepoint, is that right?

so I can deref worker from sched.sched_kthread_work_queue_work, like:

  echo 'e:myprobe sched.sched_kthread_work_queue_work (kthread_worker)worker->flags (kthread_work)work->canceling' > dynamic_events

but I can't deref sched.sched_process_exec p->pid, like:

  # echo 'e:myprobe sched.sched_process_exec (task_struct)p->pid' > dynamic_events
  bash: echo: write error: Invalid argument

SNIP

> +static int handle_typecast(char *arg, struct fetch_insn **pcode,
> +			   struct fetch_insn *end,
> +			   struct traceprobe_parse_context *ctx)
> +{
> +	char *tmp;
> +	int ret;
> +
> +	/* Currently this only works for eprobes */
> +	if (!(ctx->flags & TPARG_FL_TEVENT)) {
> +		trace_probe_log_err(ctx->offset, TYPECAST_NOT_EVENT);
> +		return -EINVAL;
> +	}
> +
> +	tmp = strchr(arg, ')');
> +	if (!tmp) {
> +		trace_probe_log_err(ctx->offset + strlen(arg),
> +				    DEREF_OPEN_BRACE);
> +		return -EINVAL;
> +	}
> +	*tmp = '\0';
> +	ret = query_btf_struct(arg + 1, ctx);
> +	*tmp = ')';
> +
> +	if (ret < 0) {
> +		trace_probe_log_err(ctx->offset + 1, NO_PTR_STRCT);
> +		ret = -EINVAL;
> +		goto out_put;
> +	}
> +
> +	ctx->flags |= TPARG_FL_TYPECAST;
> +	tmp++;
> +
> +	ctx->offset += tmp - arg;
> +	ret = parse_btf_arg(tmp, pcode, end, ctx);
> +	ctx->flags &= ~TPARG_FL_TYPECAST;
> +	ctx->last_struct = NULL;
> +out_put:
> +	btf_put(ctx->struct_btf);


should we zero ctx->struct_btf in case there's more type casts,
so query_btf_struct would re-init it?

jirka
