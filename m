Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CFB299A84;
	Fri, 26 Jun 2026 04:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782447722; cv=none; b=nRrsJmaZcuCZVOrBVY37c/TH4zXiwfyEqkBgBjC8yVtj7TDFvI77qOuKzdwYj054MAarZL/yrn+STbvvncDRpadnLndYbQNa5Z5IPazB94EBTq0PknKu9Px+e2T0Hwh8HiJX97SJhKxiJAR53J46UkqNdkiucGQjayj0w3NIiwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782447722; c=relaxed/simple;
	bh=vQt1zQJyRQfEl2acGBDluDu+vJHou3h5qnY+UOnNAdI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ljp4UU5R6PYpZraJFPvQeZnhpFD6TejLrIym2JI0bZDNuh3SIxLVunJeYj95XYBSRnezCNNwHLENQyIZHmkpxCh5NO2ltnXlKKnz9ajsTgBoWeyvhJ16hAkIBnyTI64zhYidmPLDQEJQzjylh+BMP90ZObPIP3ssunT15RoALws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NTj4ORRe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTj4ORRe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 689651F000E9;
	Fri, 26 Jun 2026 04:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782447720;
	bh=NgpGfnaGf0s6dkB20MORwvNu5upIcXZDlJMSoBLrFm4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NTj4ORRe6yN+Y9X+Y0HwzRu6EunpRYovHud4BBpcgAPxYIi2U8k5ilA6OLzG7yjM/
	 KxzsvQ11DYoCUct1ydku1waJNRWPTyKaKDOqCNYLrQNbAQAuj/W3k6FeaQz1qko24M
	 KvnxCmcbQ806C6TTC9zV4z4/Mv76d3QK69glskEp9b8O7+brMDDnhdOJua/wUHX33y
	 sf3A9KfqOIVrcKa6TqcjBrhhzUhwkzGaSzIYA8xWpWAG3uG6VzM58FINooLE5caKSb
	 wufopDe4w9jurKnelvA1jrdwvJP9G8LsrpdvViyIxAjdD4JRYA+h1MHbBWxKPi4WY5
	 wW5+fooJlLnBg==
Date: Fri, 26 Jun 2026 13:21:56 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v10 2/9] tracing/probes: Support dumping fetcharg
 program for debugging dynamic events
Message-Id: <20260626132156.5fe3c5daee235a8a3b1739d6@kernel.org>
In-Reply-To: <178243984380.790911.16958862880276016609.stgit@devnote2>
References: <178243982430.790911.17439694390021542101.stgit@devnote2>
	<178243984380.790911.16958862880276016609.stgit@devnote2>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Sashiko made a good comment:

> commit ce5985c5ce46daa952ae907992e02e403e601c04
> Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> tracing/probes: Support dumping fetcharg program for debugging dynamic events
> This commit introduces a new configuration option
> CONFIG_PROBE_EVENTS_DUMP_FETCHARG to debug dynamic events. When enabled, it
> appends commented lines containing the fetch instructions to dynamic events in
> tracefs files. This helps in verifying the compiled fetch instructions for
> each probe argument.
> > diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> > index a8420e6abb56a..cfa807d8e760f 100644
> > --- a/kernel/trace/trace_kprobe.c
> > +++ b/kernel/trace/trace_kprobe.c
> > @@ -1320,6 +1320,8 @@ static int trace_kprobe_show(struct seq_file *m, struct dyn_event *ev)
> >  		seq_printf(m, " %s=%s", tk->tp.args[i].name, tk->tp.args[i].comm);
> >  	seq_putc(m, '\n');
> >  
> > +	trace_probe_dump_args(m, &tk->tp);
> > +
> Does enabling CONFIG_PROBE_EVENTS_DUMP_FETCHARG break in-tree userspace tools
> that parse kprobe_events?
> For example, perf probe reads the kprobe_events file directly. It passes
> the unexpected # lines to parse_probe_trace_command() in
> tools/perf/util/probe-file.c:__probe_file__get_namelist(), which returns
> -EINVAL and immediately aborts the event listing process.
> Similarly, the ftrace2bconf script does not ignore # lines when reading
> kprobe_events, which leads it to mistakenly emit invalid bootconfig syntax
> in tools/bootconfig/scripts/ftrace2bconf.sh:kprobe_event_options()
> (e.g. ftrace.event.kprobes.#.probes += ...).

Yeah, those tools needs to be updated. Anyway, the tools which reads the
files in tracefs should skip the lines started with #, Those are comment
lines. (e.g. trace file, hist file, etc.)

Thanks,

-- 
Masami Hiramatsu
