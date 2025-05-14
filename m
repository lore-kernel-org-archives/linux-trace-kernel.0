Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABBF2F42;
	Wed, 14 May 2025 01:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747185275; cv=none; b=shh9OwTMdYQYzejmTHIwB+SE3pqSfBsINWsQJ2JWfOEUnhnSIVfGI5QEB/MFs6UO6dh0mW1+D5FPK1UZSXd/1asWM8kxhbagfRiuR4nLto5WEywdzUzgPYPsKUdUsVysgankB6aztuozKiT8RTe29eAe1lnBOL5dty8rkxZ3Vgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747185275; c=relaxed/simple;
	bh=CzeDfW6P7QbovukrEwnJdSGdw85sjKnjpjgPD0DzpxM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=jNVkOOnVmnjhYBYkXJxD+VKz0F+rS+gTXZA94ZUiyQh/s8NFgGaOWDNPGs868+ecYUQXiH2KxG1hNS3SHoplbaJLvuVcDo4R9nRBc/suLRBtc9pmfNvQ+kUqFiZ7ecBhQ5Hy5Lb8ZZRybVC/c3l23h91NDdSQMXIr2l1bsxrtlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ayf+nUsr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayf+nUsr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B27C4CEED;
	Wed, 14 May 2025 01:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747185275;
	bh=CzeDfW6P7QbovukrEwnJdSGdw85sjKnjpjgPD0DzpxM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ayf+nUsrqtO2rN9/PTKGFg8PvTmjpXsBhMjdP0KspbY5OYGK4+wEAklQvQuvMUGLO
	 nGN3rHI4b4BrzAqKcvX8J8Z5ftw7w/TgJAwrhsnb1y0tbgPOQnpnPnhn+MFxFa/1QT
	 BklgL/T3p/1FBhoA8vF4Mw8NW5klGQ1DOLtHZ0WVVMPvHMc+IDRvYBftrOzptTVwD6
	 ocGCidol/AzaGM1ALVZIClp5+yuPyX8l8NJKCiMyvSYR6Js9LXJBiGAwXjQFCwKct3
	 S1NsXjXYFwtvPw8IZVO32mgp3zjpjiVLqzAw/6ZpqyZ/Uv33+ubOzEx7u/3H9tyqNt
	 Garsk6Qyn0bjA==
Date: Wed, 14 May 2025 10:14:31 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3] tracing: Record trace_clock and recover when reboot
Message-Id: <20250514101431.e1363d1a60ed2548feb4cef0@kernel.org>
In-Reply-To: <20250513135652.7cb970cf@gandalf.local.home>
References: <174709628747.1945884.11884057542151507891.stgit@mhiramat.tok.corp.google.com>
	<20250513135652.7cb970cf@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 May 2025 13:56:51 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 13 May 2025 09:31:27 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Record trace_clock information in the trace_scratch area and recover
> > the trace_clock when boot, so that reader can docode the timestamp
> > correctly.
> > Note that since most trace_clocks records the timestamp in nano-
> > seconds, this is not a bug. But some trace_clock, like counter and
> > tsc will record the counter value. Only for those trace_clock user
> > needs this information.
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  Changes in v3:
> >    - Save clock_id instead of its name.
> >  Changes in v2:
> >    - instead of exposing it via last_boot_info, set the current
> >      trace_clock as the same clock we used in the last boot.
> > ---
> >  kernel/trace/trace.c |   16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > index cf51c30b137f..2a060c62d686 100644
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> > @@ -6066,6 +6066,7 @@ struct trace_mod_entry {
> >  };
> >  
> >  struct trace_scratch {
> > +	int			clock_id;
> 
> Should be "unsigned int"

OK.

> 
> >  	unsigned long		text_addr;
> >  	unsigned long		nr_entries;
> >  	struct trace_mod_entry	entries[];
> > @@ -6181,6 +6182,7 @@ static void update_last_data(struct trace_array *tr)
> >  	if (tr->scratch) {
> >  		struct trace_scratch *tscratch = tr->scratch;
> >  
> > +		tscratch->clock_id = tr->clock_id;
> >  		memset(tscratch->entries, 0,
> >  		       flex_array_size(tscratch, entries, tscratch->nr_entries));
> >  		tscratch->nr_entries = 0;
> > @@ -7403,6 +7405,12 @@ int tracing_set_clock(struct trace_array *tr, const char *clockstr)
> >  	tracing_reset_online_cpus(&tr->max_buffer);
> >  #endif
> >  
> > +	if (tr->scratch && !(tr->flags & TRACE_ARRAY_FL_LAST_BOOT)) {
> > +		struct trace_scratch *tscratch = tr->scratch;
> > +
> > +		tscratch->clock_id = i;
> > +	}
> > +
> >  	mutex_unlock(&trace_types_lock);
> >  
> >  	return 0;
> > @@ -9628,6 +9636,14 @@ static void setup_trace_scratch(struct trace_array *tr,
> >  
> >  	/* Scan modules to make text delta for modules. */
> >  	module_for_each_mod(make_mod_delta, tr);
> > +
> > +	/* Set trace_clock as the same of the previous boot. */
> > +	if (tscratch->clock_id != tr->clock_id) {
> > +		if (tracing_set_clock(tr, trace_clocks[tscratch->clock_id].name) < 0) {
> 
> In case the tscratch->clock_id gets corrupted, we better make sure it
> doesn't overflow:
> 
> 		if (tscratch->clock_id >= ARRAY_SIZE(trace_clocks) ||
> 		    tracing_set_clock(tr, trace_clocks[tscratch->clock_id].name) < 0) {

Good catch! BTW, don't we have any check about scratch area?
(e.g. adding a checksum)

Thank you,

> 
> -- Steve
> 
> 
> > +			pr_info("the previous trace_clock info is not valid.");
> > +			goto reset;
> > +		}
> > +	}
> >  	return;
> >   reset:
> >  	/* Invalid trace modules */
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
