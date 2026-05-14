Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF0A355814;
	Thu, 14 May 2026 18:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778784433; cv=none; b=aU8uncaiL9rVmXclMPythC9uIQ2HfLO6hUNPh/1Gp5h+41BDUzAvIaGBtjjO2B76M2ILRvj11xavTH39dzjR3uqotCGfMT4fn/wvEYbM5RHX8vD5Dyx1uDB2sAIhbub6byP4wUIVwIU67R189D8ewCYqRoHbtaB0kEcisAq0mck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778784433; c=relaxed/simple;
	bh=ANCJ2nkmUb7VdeagkAs+34kc9JMaDZALdmfQ4/SYn6g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bQQwXjSv+9Qh/JvZMMP4NQHVY6YOxE622+wKXpQ1b01dpJ9Yswb+Y8Uk6wQ6KIvNFXklyiUfGV/r7aORbrRKSskIPHHknhopmZsDcbn+0cGPIvcx7goNWbVNdM6hDxYhuccMCiE+l6coRUY/ktGFDtIy57WK5yaVN80VYZW/RTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 2EF04160D0E;
	Thu, 14 May 2026 18:47:07 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id 198E730;
	Thu, 14 May 2026 18:47:05 +0000 (UTC)
Date: Thu, 14 May 2026 14:47:10 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim
 <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ian Rogers
 <irogers@google.com>, sashiko@lists.linux.dev
Subject: Re: [PATCH v2] tracing: Allow perf to read synthetic events
Message-ID: <20260514144710.79513174@gandalf.local.home>
In-Reply-To: <20260513150007.3b280e87@gandalf.local.home>
References: <20260513150007.3b280e87@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 198E730
X-Rspamd-Server: rspamout06
X-Stat-Signature: mi7rfsms9p39wffwgzyd3fhryr4jizhe
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19F119g861sKdV1WP8H82FD1sBuqPwvQJ0=
X-HE-Tag: 1778784425-640236
X-HE-Meta: U2FsdGVkX1806ol+eoXflWnfatgXky29o7yaWJZz7W7IfM7qzzU8QfSzfMSCCMrQsAuqF7C7pETfeB23EJT+ZfF2UWrfmSjJx5R4q+0G32hOajJP/tU1U4/nDJkAyC+urL6e+gQm+Q2f/UBqSYrqyHTSiET0ouSM1pL49KbvD59GTDNBN8mF4tX/PdkcS6CAba57Eqkr1rBlH4+7aVwpeYwg187QRX/cbbnHXzMBvcqf1oz3kAEFrsJJTxrzMkJSwtX7IToFhSQxfdQYJVG/T5WuuvD1MQA6SNhzly75yWKphscVfr3Z6fCMu7PTXW0ocRPBzf8wYEESI26NwI39a7UJNHXEkZbWvOrB98ECNysjkWiqOw+dHV/gWz9q8DdAjNtIyG0rwZEeDIfuZZKnzup8xev9znT3OP2EL1hTONneBuFmEwugItpisxwE9I00


Replying to Sashiko's comments:

  https://sashiko.dev/?list=org.kernel.vger.linux-trace-kernel#/patchset/20260513150007.3b280e87%40gandalf.local.home

> commit b3956023bf5f1ccf5838187c1c14f3dcf5e37c3d
> Author: Steven Rostedt <rostedt@goodmis.org>
> tracing: Allow perf to read synthetic events
> This commit adds support for perf to read synthetic events. It extracts the
> field sizing and entry writing logic into separate helper functions, and
> implements a new probe function to attach perf events.
> > diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
> > index 39ac4eba07024..e6871230bde96 100644
> > --- a/kernel/trace/trace_events_synth.c
> > +++ b/kernel/trace/trace_events_synth.c
> > @@ -499,28 +499,19 @@ static unsigned int trace_stack(struct synth_trace_event *entry,
> [ ... ]
> > +static __always_inline void write_synth_entry(struct synth_event *event,
> > +					      struct synth_trace_event *entry,
> > +					      u64 *var_ref_vals,
> > +					      unsigned int *var_ref_idx)
> > +{
> > +	int data_size = 0;
> Since get_field_size() and write_synth_entry() are being refactored here, is
> there a risk of a time-of-check to time-of-use buffer overflow with
> dynamic string fields?
> get_field_size() computes the string length for allocation by calling
> fetch_store_strlen(). The ring buffer event slot is then allocated based on
> this length.
> write_synth_entry() populates the buffer by calling trace_string(), which
> calls fetch_store_strlen() a second time to recalculate the string's length,
> assigning it to data->as_dynamic.len.
> If a string from user space grows between the two fetch_store_strlen() calls,
> fetch_store_string() will blindly copy more bytes than the allocated buffer
> space. Can this cause out-of-bounds writes and corrupt kernel memory?
> This regression wasn't introduced by this patch, but pre-existed in the
> ftrace implementation.

The string cannot grow between the two calls. When a dynamic event is
enabled (as it is required to be here) deleting or modifying it will be
denied via an -EBUSY return. That's the only way I'm aware of that can have
user space change the size of the string.

> [ ... ]
> > +#ifdef CONFIG_PERF_EVENTS
> > +static void perf_event_raw_event_synth(void *__data,
> > +				       u64 *var_ref_vals,
> > +				       unsigned int *var_ref_idx)
> > +{
> [ ... ]
> > +	size = ALIGN(sizeof(*entry) + fields_size, 8);
> > +
> > +	entry = perf_trace_buf_alloc(size, &regs, &context);
> > +
> > +	if (unlikely(!entry))
> > +		return;
> > +
> > +	write_synth_entry(event, entry, var_ref_vals, var_ref_idx);
> > +
> > +	perf_fetch_caller_regs(regs);
> > +
> > +	perf_trace_buf_submit(entry, size, context,
> > +			      call->event.type, 1, regs,
> > +			      perf_head, NULL);
> > +}
> > +#endif
> Could this leak uninitialized per-CPU kernel memory to userspace?
> perf_trace_buf_alloc() and trace_event_buffer_reserve() allocate memory from
> per-CPU buffers without zero-initializing it (except for trailing alignment
> padding).

Both of theses per-CPU memory locations are zeroed when created. It is only
populated with trace data. Yeah, it may leak previous trace data, but that
data should also be visible for whoever created it in the first place.

-- Steve


> write_synth_entry() populates an array of 8-byte union trace_synth_field.
> When a field is smaller than 8 bytes (e.g., as_u8), only those specific bytes
> are written, leaving the remaining padding bytes uninitialized. Similarly, for
> empty stacktraces, get_field_size() reserves 8 bytes, but trace_stack()
> terminates immediately and writes 0 bytes, leaving the 8-byte gap completely
> uninitialized.
> perf_trace_buf_submit() copies the entire requested buffer size to the perf
> ring buffer. Can userspace read this buffer, leaking uninitialized kernel
> memory from previous events or kernel operations?
> This regression also wasn't introduced by this patch, but pre-existed in the
> ftrace implementation.

