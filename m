Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A9E313526;
	Mon, 16 Feb 2026 15:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771254587; cv=none; b=eWU51ddyn6g9O61/RVWyxvlm4NCVdqBvHCJB2P+pkRNkYFsF4JErd8CCiGI9CFm7MvhTmyiSzPYcsuPFgeBw4DZYWzQKPI6xYA82pLaZec84jB9usXDU3H20ccRGfv4a8blzUea2EzZzk8GvHEdTaTaVGg/nK1NzDwSAkErOWLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771254587; c=relaxed/simple;
	bh=rhlBZ61/uRZ47Itp/8aq1hFqwaSpQrPWdsBn+npED/s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n6pei60ehPcbLq/6jU+m7FfQYA6uyazIbrgACDpi6UuzPZOP+1uKaL3MITN2EMcskHAYXsIqLhG4+TGtxxV7gCs3hXle72ds9grPfxPfGOePh548PYLmMAFRRmCp7+G53buTqM93xnYNjJsRkF1r0cBhfX0dcWhOzuVRnnMUcPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id B8CD75D5C9;
	Mon, 16 Feb 2026 15:09:38 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id 1B6012003A;
	Mon, 16 Feb 2026 15:09:36 +0000 (UTC)
Date: Mon, 16 Feb 2026 10:09:35 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-trace-kernel
 <linux-trace-kernel@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>
Subject: Re: Enhancing Conditional Filtering for Function Graph Tracer
Message-ID: <20260216100935.645ea614@gandalf.local.home>
In-Reply-To: <CAErzpmtMrHWQVAQx=jiq_sWo=+c_JOUoQmPafo-fq+Q3qi+BBw@mail.gmail.com>
References: <CAErzpmtMrHWQVAQx=jiq_sWo=+c_JOUoQmPafo-fq+Q3qi+BBw@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: i5bkd3nkh6bb4jambyic19zfq85dhgon
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 1B6012003A
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18JRe5d19xPkhPSzj6rSoVtAbRiV/PANKo=
X-HE-Tag: 1771254576-803904
X-HE-Meta: U2FsdGVkX19WVUfGIUSTxR11KrjWx6CTaFGHZM1BnpwBZkdRWipUuav8ppilus4jN6N6tDPVyvlqB7erOV1+CTFAfvc/glzOv0xSoDq1vE2xnRXQyYybIEQ6+2/UKDLPbw1EBjfFJl7CKLw0u2whfa0dm6qpb+WRk+mQKb/4c+RSwSIBeU6QWSFoQumNGxRt5KacH1hG6ufvB+eaOlxn0qvbcZzotP1y5tL37dHAjva6mmOBmdUd2QIhBvz1gzZFfK4AtKN3tCQiawVv2kTEswvSvqP0umzokb/gB1SKzq9oovdtTGFEoSXWXhL2mOEIPOGzUh+9W+45kZW93qsLrHlkgrQm8MbQ

On Sat, 14 Feb 2026 18:36:24 +0800
Donglin Peng <dolinux.peng@gmail.com> wrote:

> To simplify implementation, I propose extending a new trigger type
> (e.g., "funcgraph").
> In ftrace_graph_ignore_func, we could look up the corresponding trace_fprobe and
> trace_event_file based on trace->func, then decide whether to trace
> the function using
> a helper like the following:
> 
> static bool ftrace_graph_filter(struct trace_fprobe *tf, struct
> ftrace_regs *fregs,
>                                struct trace_event_file *trace_file)
> {
>     struct fentry_trace_entry_head *entry;
>     struct trace_event_buffer fbuffer;
>     struct event_trigger_data *data;
>     int dsize;
> 
>     dsize = __get_data_size(&tf->tp, fregs, NULL);
>     entry = trace_event_buffer_reserve(&fbuffer, trace_file,
>                                        sizeof(*entry) + tf->tp.size + dsize);
>     if (!entry)
>         return false;
> 
>     entry = ring_buffer_event_data(fbuffer.event);
>     store_trace_args(&entry[1], &tf->tp, fregs, NULL, sizeof(*entry), dsize);
> 
>     list_for_each_entry_rcu(data, &trace_file->triggers, list) {
>         if (data->cmd_ops->trigger_type == TRIGGER_TYPE_FUNCGRAPH) {
>             struct event_filter *filter = rcu_dereference_sched(data->filter);
>             if (filter && filter_match_preds(filter, entry))
>                 return true; // Allow tracing
>         }
>     }
>     return false; // Skip tracing
> }
> 
> Does this approach make sense? Any suggestions or concerns?

My biggest concern is with performance. You want to run this against all
functions being traced?

How is this different than just using fprobes?

-- Steve
