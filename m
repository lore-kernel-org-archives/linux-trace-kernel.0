Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793047803;
	b=o5+Ws3I9aKmA75jn9adG2yIPDiKrFb1LhxJTCDWxmcuK6EIrCffaGXa029zsyx5VoSzT
	 jEB6zUidNXOjdeUEQUJKGe7Ux6HQFv+1/nQiSPkMDJdEluAvgiCTIOTAbRut97ef01oeW
	 7bH3UL+EeuTNZoGDkfzbGP6uGR30YPaGFCskYxbheQKwEEftTL1xocDcrig7N3xz/bcxx
	 Mw0z+R++mEa9/5txhNnruuML5WFLA0Ms97pmUDwOFjwczXeIm+iTVuxUOcdRVGnoAggdi
	 99p/ep9TLmEBjJLC1hKAZmiQ6+X15kq5M/fB18ninEVQVlIw197JV32lcZMLRNWjGoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793047803;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=2jd+mkuL2nZb30YmIbfDU70Cv7E32fB8YVO8gIjOjXk=;
	b=X0+cKtBp2oPP6cV0iqpeXzAJUvvhpQh4FL6IckLXpDtLSw57oFG2hJV/ko+No2ZxeO59
	 flw4lskExa4p6zE7RrEqApxkZn2cVl3JANknkg2EoJJ9Lt9TzJYuDvkdmma4K8J/N1sHO
	 tsdynjfZvGq+3uP+mtSRWE8jQuWERXT+Svn9AhfSNvzmIZPg/ZyGuXpQfQrrhWq+6RLrI
	 +zZLwGD4tHpFRSA5lm8YnlxhFkkEb+MkQbsCegxXmWU+GzZKReOule6f/JpQuUz47L/G0
	 p1MgfkHtiGAQ0n0aupicOlT4+pZxV3ZJ9oXai1ViSXsFeR/bpRi6hblZZpuu6Vxv7dA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=HRZERKsD;
	arc=none smtp.remote-ip=216.40.44.12
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB62606A31B;
	Mon, 26 Oct 2026 20:50:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BB62606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=HRZERKsD
Received: from omf20.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id A292AA016A;
	Mon, 26 Oct 2026 20:50:00 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id AE1E320026;
	Mon, 26 Oct 2026 20:49:58 +0000 (UTC)
Date: Mon, 26 Oct 2026 16:49:57 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 8/9] tracing/filters: Terminate filter string at
 first newline
Message-ID: <20261026164957.0e498c52@gandalf.local.home>
In-Reply-To: <179291750264.492959.17808238344327959450.stgit@devnote2>
References: <179291742944.492959.11659339795290028998.stgit@devnote2>
	<179291750264.492959.17808238344327959450.stgit@devnote2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: AE1E320026
X-Stat-Signature: tt97z9m3jek3gmiiq3uqz5brk5o6gugd
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/Dgvf7Qh9K0VrzfNNlPZfntkU9YF5rZuM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=2jd+mkuL2nZb30YmIbfDU70Cv7E32fB8YVO8gIjOjXk=; b=HRZERKsD8DG+bYyxBh2r0OtQ3pYRnhPwIocdWUgTe+nXJL5g0gauTy58VLg4TUADdnB6Hieq3OYMJDfdNdKa/1KlA+jyT0+hB+P6lMJbSuliJuxW50L0iiKvQwhP8POiX2i2rFKBoCxvbh8ciJqkmLlED5yQU5D3mTpSCEl1kEk=
X-HE-Tag: 1793047798-192977
X-HE-Meta: U2FsdGVkX1+uKpt7PL378Y6Bym6CKxIdeWaaePIA0xTdvJYpiBgqoVlnAvMGErIKSf/LVvFzEJMQbvLwxmvh5VnvMXs23bpAo22jKsgSnMUvwa0z3UmnM1x+EBXxABjRutIRB9CWcDDvtBHtcGdaSsF3PwQGQL2rfoGf6xFR5+KGbwowEmUSKyuX679M7ABa1mtNvLRbWH4KaLiBVdUlG7HN8XRMmFpZcwAzMTZKcUn7eOJ3u1+ngGylMHEpkfg0lsLcaDH7mU6QNJ/vUpYBdo/z26aXmTf54xOdGhSM9C7Kn5TWzUIkdlKtwSq3bnrwkZ45ScX4E2VeRQNY2rxZIf5pPlQlAvCe

On Sun, 25 Oct 2026 17:38:22 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Each trace event or subsystem only holds a single filter, and
> append_filter_err() / tracing_log_err() caret placement assumes a
> single-line filter string. However, apply_event_filter() and
> apply_subsystem_event_filter() only call strstrip(), which strips
> trailing newlines but leaves embedded newlines intact.
> 
> An embedded newline in a filter string (for example inside 'CPUS{0\n"}')
> causes cpulist_parse() / bitmap_parselist() to treat '\n' as the end of
> the cpulist and ignore trailing characters before '}', desynchronizing
> quote tracking between calc_stack() and parse_pred() and misaligning
> error_log caret reporting.
> 
> Terminate filter_string at the first '\n' in apply_event_filter(),
> apply_subsystem_event_filter(), and create_filter_start() so only the
> first line is parsed.

How about also checking if there's any non white space after the newline,
and if so, fail the filter outright with -EINVAL?

-- Steve


> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  kernel/trace/trace_events_filter.c |   15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
> index 8d7fb6e9d7f8..14afcca7a444 100644
> --- a/kernel/trace/trace_events_filter.c
> +++ b/kernel/trace/trace_events_filter.c
> @@ -2426,10 +2426,15 @@ static int create_filter_start(char *filter_string, bool set_str,
>  	struct event_filter *filter;
>  	struct filter_parse_error *pe = NULL;
>  	int err = 0;
> +	char *p;
>  
>  	if (WARN_ON_ONCE(*pse || *filterp))
>  		return -EINVAL;
>  
> +	p = strchr(filter_string, '\n');
> +	if (p)
> +		*p = '\0';
> +
>  	filter = kzalloc_obj(*filter);
>  	if (filter && set_str) {
>  		filter->filter_string = kstrdup(filter_string, GFP_KERNEL);
> @@ -2543,11 +2548,16 @@ int apply_event_filter(struct trace_event_file *file, char *filter_string)
>  {
>  	struct trace_event_call *call = file->event_call;
>  	struct event_filter *filter = NULL;
> +	char *p;
>  	int err;
>  
>  	if (file->flags & EVENT_FILE_FL_FREED)
>  		return -ENODEV;
>  
> +	p = strchr(filter_string, '\n');
> +	if (p)
> +		*p = '\0';
> +
>  	if (!strcmp(strstrip(filter_string), "0")) {
>  		filter_disable(file);
>  		filter = event_filter(file);
> @@ -2595,6 +2605,7 @@ int apply_subsystem_event_filter(struct trace_subsystem_dir *dir,
>  	struct trace_array *tr = dir->tr;
>  	struct event_filter *filter = NULL;
>  	int err = 0;
> +	char *p;
>  
>  	guard(mutex)(&event_mutex);
>  
> @@ -2602,6 +2613,10 @@ int apply_subsystem_event_filter(struct trace_subsystem_dir *dir,
>  	if (!dir->nr_events)
>  		return -ENODEV;
>  
> +	p = strchr(filter_string, '\n');
> +	if (p)
> +		*p = '\0';
> +
>  	if (!strcmp(strstrip(filter_string), "0")) {
>  		filter_free_subsystem_preds(dir, tr);
>  		remove_filter_string(system->filter);

