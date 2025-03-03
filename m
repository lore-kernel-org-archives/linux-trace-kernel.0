Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C762A15853B;
	Mon,  3 Mar 2025 06:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740983771; cv=none; b=L+8/4X5Lua77SF/9kmJLUbbwKsgzOsk1os8VIgDwWpEBmnKSiGWfTJ/a0YiOOqL3i+Z8xHFXdbSwNw+V+CpPkINEBVh5VVqhxgfT5WNJ+sZeJeR0NfkR+itBgik3TBhc4Z0aienNQR8yF9XqemLOOFPIpuzEA/xyYnZqIP40hms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740983771; c=relaxed/simple;
	bh=HqvhAMtCZRjUm1Q7HW15Lf7hRzeADdKMZCORIoQCpHc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=YtrFJWFq8EwmEXMbmTy6UOOIEtsIXC2FJ1KdlXax4kM2DhdTPcj5dEcn8i8+MX7rwYIzt1rRpzL0abZPfS0EW/P53TfLbd3oLjTkHpc2X0jWNNRCTh8fMPa0aOqG2vC9++GOhGreJZxB6vewfQ1t7iMlXmI/5xnhMYPlq3RRZs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PDg5OUbF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PDg5OUbF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E43E7C4CED6;
	Mon,  3 Mar 2025 06:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740983771;
	bh=HqvhAMtCZRjUm1Q7HW15Lf7hRzeADdKMZCORIoQCpHc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PDg5OUbFhLhIGRt0iZtKwAJGKJARFmkHwRTABE4PQcFkz5oGSu5M52IvQNaRtAmN9
	 9D8ML9Arf8xYZcttdA+TcgpUSiwWEBA71Es+MUw0TRzeTcHaFJaj8N8yoqqkzoxK9T
	 E27WJt4Av62moJ5tKzK5osfeQeiXVeH0HR4dGHBPPTGz3waD4Aa0vfcKi0Adh9QV1n
	 Fm34uaEje9EpzyCQIkwUpH0P3//aJNP6ih0Wa2bZKfcqFmUyZ5M5PF08PHTWT7pZGg
	 QEAGzW6j361Kp81iqkXpLccnQjn4Zu/r08c4QhurVA1/9/YLEMYr4N1T6AN+l1v9lC
	 +fwUB6WtfhtaA==
Date: Mon, 3 Mar 2025 15:36:07 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: probe-events: Add comments about entry data
 storing code
Message-Id: <20250303153607.da48fad3e90a28bc8c7f50e6@kernel.org>
In-Reply-To: <20250228174712.44e03694@gandalf.local.home>
References: <174061715004.501424.333819546601401102.stgit@devnote2>
	<20250228174712.44e03694@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Feb 2025 17:47:12 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 27 Feb 2025 09:45:50 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Add comments about entry data storing code to __store_entry_arg() and
> > traceprobe_get_entry_data_size(). These are a bit complicated because of
> > building the entry data storing code and scanning it.
> > 
> > This just add comments, no behavior change.
> > 
> > Reported-by: Steven Rostedt <rostedt@goodmis.org>
> > Closes: https://lore.kernel.org/all/20250226102223.586d7119@gandalf.local.home/
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  kernel/trace/trace_probe.c |   28 ++++++++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> > 
> > diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> > index 8f58ee1e8858..2eeecb6c95ee 100644
> > --- a/kernel/trace/trace_probe.c
> > +++ b/kernel/trace/trace_probe.c
> > @@ -770,6 +770,10 @@ static int check_prepare_btf_string_fetch(char *typename,
> >  
> >  #ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
> >  
> > +/*
> > + * Add the entry code to store the 'argnum'th parameter and return the offset
> > + * in the entry data buffer where the data will be stored.
> > + */
> >  static int __store_entry_arg(struct trace_probe *tp, int argnum)
> >  {
> >  	struct probe_entry_arg *earg = tp->entry_arg;
> > @@ -793,6 +797,20 @@ static int __store_entry_arg(struct trace_probe *tp, int argnum)
> >  		tp->entry_arg = earg;
> >  	}
> >  
> > +	/*
> > +	 * The entry code array is repeating the pair of
> > +	 * [FETCH_OP_ARG(argnum)][FETCH_OP_ST_EDATA(offset of entry data buffer)]
> > +	 * and the rest of entries are filled with [FETCH_OP_END].
> > +	 *
> > +	 * To reduce the redundant function parameter fetching, we scan the entry
> > +	 * code array to find the FETCH_OP_ARG which already fetches the 'argnum'
> > +	 * parameter. If it doesn't match, update 'offset' to find the last
> > +	 * offset.
> > +	 * If we find the FETCH_OP_END without matching FETCH_OP_ARG entry, we
> > +	 * will save the entry with FETCH_OP_ARG and FETCH_OP_ST_EDATA, and
> > +	 * return data offset so that caller can find the data offset in the entry
> > +	 * data buffer.
> > +	 */
> 
> So I'm still not 100% sure what is happening here, but at least these
> comments can help me figure it out if I spend some time gawking at the code
> a bit more ;-)

I think the code is a bit complicated too. I will rewrite it a bit.

> 
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Thanks you!

> 
> -- Steve
> 
> 
> >  	offset = 0;
> >  	for (i = 0; i < earg->size - 1; i++) {
> >  		switch (earg->code[i].op) {
> > @@ -826,6 +844,16 @@ int traceprobe_get_entry_data_size(struct trace_probe *tp)
> >  	if (!earg)
> >  		return 0;
> >  
> > +	/*
> > +	 * earg->code[] array has an operation sequence which is run in
> > +	 * the entry handler.
> > +	 * The sequence stopped by FETCH_OP_END and each data stored in
> > +	 * the entry data buffer by FETCH_OP_ST_EDATA. The FETCH_OP_ST_EDATA
> > +	 * stores the data at the data buffer + its offset, and all data are
> > +	 * "unsigned long" size. The offset must be increased when a data is
> > +	 * stored. Thus we need to find the last FETCH_OP_ST_EDATA in the
> > +	 * code array.
> > +	 */
> >  	for (i = 0; i < earg->size; i++) {
> >  		switch (earg->code[i].op) {
> >  		case FETCH_OP_END:
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
