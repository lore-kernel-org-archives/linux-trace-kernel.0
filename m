Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793058830;
	b=03vpQKx6Za9SOvx0VCmdigXsZ+fXPOyO3vc0FjTjBpySI6v4mR7EhV+J7gRZDtN8ycKz
	 KywNJuV9S2uwsstWRYiW4EDSBMxRSmJX369uTOVgE0AMb0lggoharWmallMEUDeLztwkv
	 KcMcu98TrpoajlES41+CVOkWfVCgGXTKEY6DAJyqH0ALKPpz8mq9m7XlUbdTdFqDd/qqR
	 iV+PLXuxG0XBi3WbF81I9cPw69nNwE7DgtYhSI+03I/DMvS8YSrd1UzosHrr1vvFyTksF
	 4xXPwnenIrsYcNpBOz3RzSHWEkBJhbwYqCyKrL2oRS1peCi1eoMfEvEGUPJIGwiXZcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793058830;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=PmF4pFDTWVfRk9VwnvwOLzqp+cbYioNIQEmFKh6Wsbo=;
	b=Af9o/DMPXjCAQE+rJxpRYSTTCvKlCYVYHTSE/HCVea5p1mDB1C9rLjF/fFEaBPz/BpOS
	 7AzcyUm9zenD+C8bHO48aQPO583688NnX33g75zl9wKXwAYL+4iwhe8Y24mBY6F9mS+R6
	 LtvlRvlvRke8+vVtZuwisnSPPLUx4rI1Bh5RfHNEt6AJ3yfJDZVqexKbgHqwHCJkuJTDG
	 65l6Twgk8IoS90rnttfk+hsqUSA8lpTm1Asc2vvuHXWHz80IfDe6QF/fQHa6hllMwJmsf
	 3gWzJkr+gNub8plw8sLZsJTj3crKWPgJJ5rCBEhji2LmEfjyp7BfWNSjfskYuHULodg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mjSgjfpX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EF4606A31A;
	Mon, 26 Oct 2026 23:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mjSgjfpX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 347811F01825;
	Mon, 26 Oct 2026 23:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793058829;
	bh=PmF4pFDTWVfRk9VwnvwOLzqp+cbYioNIQEmFKh6Wsbo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mjSgjfpX+iKdI+lEz2Meif1r6g/wl979HYK4oNQihAFrb8aYon4Pp3E8i6m0agPgH
	 Vg9v8ZbXDx0WLrulvHPUYAeCnVW2aRDMT1F1wGIW8I0n1DxRfZj27KAP0OS7DV6DoA
	 3z5uofYerhtYC5Iyprmx4g1Ytn8haQpO0iGjOiTjJklJCoUQe1ojIWBd/rJFHM69QO
	 ZZOsM01E4DIRqDO2e5K3azbenG60+4odEolGlkxtWOhSHBpZlEWfYdCUvDp8FdiTwa
	 JnVFfw4Tlnx9NMjdfwcGfgQxsDkZ8M/BzXS3zTBBsc9MvSNBK5f8ZOOcx7POvAamw0
	 7ne8/mLfgmMKg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Shuah Khan <shuah@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 8/9] tracing/filters: Terminate filter string at first newline
Date: Tue, 27 Oct 2026 08:53:46 +0900
Message-ID: <undine-1793058826691817022-492dfd11556f9184@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <20261026164957.0e498c52@gandalf.local.home>
References: <179291742944.492959.11659339795290028998.stgit@devnote2> <179291750264.492959.17808238344327959450.stgit@devnote2> <20261026164957.0e498c52@gandalf.local.home>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Mon, 26 Oct 2026 16:49:57 -0400, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Sun, 25 Oct 2026 17:38:22 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Each trace event or subsystem only holds a single filter, and
> > append_filter_err() / tracing_log_err() caret placement assumes a
> > single-line filter string. However, apply_event_filter() and
> > apply_subsystem_event_filter() only call strstrip(), which strips
> > trailing newlines but leaves embedded newlines intact.
> > 
> > An embedded newline in a filter string (for example inside 'CPUS{0\n"}')
> > causes cpulist_parse() / bitmap_parselist() to treat '\n' as the end of
> > the cpulist and ignore trailing characters before '}', desynchronizing
> > quote tracking between calc_stack() and parse_pred() and misaligning
> > error_log caret reporting.
> > 
> > Terminate filter_string at the first '\n' in apply_event_filter(),
> > apply_subsystem_event_filter(), and create_filter_start() so only the
> > first line is parsed.
> 
> How about also checking if there's any non white space after the newline,
> and if so, fail the filter outright with -EINVAL?

Hm, indeed. That sounds good to me, because user gave a wrong input.

Thanks!

> 
> -- Steve
> 
> 
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  kernel/trace/trace_events_filter.c |   15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> > 
> > diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
> > index 8d7fb6e9d7f8..14afcca7a444 100644
> > --- a/kernel/trace/trace_events_filter.c
> > +++ b/kernel/trace/trace_events_filter.c
> > @@ -2426,10 +2426,15 @@ static int create_filter_start(char *filter_string, bool set_str,
> >  	struct event_filter *filter;
> >  	struct filter_parse_error *pe = NULL;
> >  	int err = 0;
> > +	char *p;
> >  
> >  	if (WARN_ON_ONCE(*pse || *filterp))
> >  		return -EINVAL;
> >  
> > +	p = strchr(filter_string, '\n');
> > +	if (p)
> > +		*p = '\0';
> > +
> >  	filter = kzalloc_obj(*filter);
> >  	if (filter && set_str) {
> >  		filter->filter_string = kstrdup(filter_string, GFP_KERNEL);
> > @@ -2543,11 +2548,16 @@ int apply_event_filter(struct trace_event_file *file, char *filter_string)
> >  {
> >  	struct trace_event_call *call = file->event_call;
> >  	struct event_filter *filter = NULL;
> > +	char *p;
> >  	int err;
> >  
> >  	if (file->flags & EVENT_FILE_FL_FREED)
> >  		return -ENODEV;
> >  
> > +	p = strchr(filter_string, '\n');
> > +	if (p)
> > +		*p = '\0';
> > +
> >  	if (!strcmp(strstrip(filter_string), "0")) {
> >  		filter_disable(file);
> >  		filter = event_filter(file);
> > @@ -2595,6 +2605,7 @@ int apply_subsystem_event_filter(struct trace_subsystem_dir *dir,
> >  	struct trace_array *tr = dir->tr;
> >  	struct event_filter *filter = NULL;
> >  	int err = 0;
> > +	char *p;
> >  
> >  	guard(mutex)(&event_mutex);
> >  
> > @@ -2602,6 +2613,10 @@ int apply_subsystem_event_filter(struct trace_subsystem_dir *dir,
> >  	if (!dir->nr_events)
> >  		return -ENODEV;
> >  
> > +	p = strchr(filter_string, '\n');
> > +	if (p)
> > +		*p = '\0';
> > +
> >  	if (!strcmp(strstrip(filter_string), "0")) {
> >  		filter_free_subsystem_preds(dir, tr);
> >  		remove_filter_string(system->filter);
> 
> 
>

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
