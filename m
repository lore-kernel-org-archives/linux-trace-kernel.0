Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B07C3B6347;
	Tue, 14 Apr 2026 08:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776157138; cv=none; b=i8uQIKR/PvK0zcW57aVUEamzTDe1oY3ioolU2iB+Jt0nkfe9G5IPbzVNm3ED1Xkv4ly2aAFk54yFYOmHIU5oMHqTjiDPqlTmfzwpc8PrDuwfhjM/wuv37nFnXhoB+wl3c/lFMiloqspiEce65KWwT4/8hfUmA/hdEsejcIjGlQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776157138; c=relaxed/simple;
	bh=IuOOkPXsj4e2HOsaeRBKmn5S8Lv7l2tZGXBhnKZxPkw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XwaODWoPy76Mgcwjll/cnkzNwJxJhvOs1uYTaterd2PaH7Du18feUybNVYehBwJ6zlLmWYwdr5prlGmceOcEKRU4mdvRnViKqboPlRLah5ZtYg7jexS/UOGLqNsEDNKboBUfBnKfx+rdQFJVraEj9m78UqH/+Qzf7YOfor6c6Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 960DEE38D0;
	Tue, 14 Apr 2026 08:58:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id 4C8C420012;
	Tue, 14 Apr 2026 08:58:52 +0000 (UTC)
Date: Tue, 14 Apr 2026 04:58:48 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Tom Zanussi
 <tom.zanussi@linux.intel.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] tracing/hist: bound synthetic-field strings with
 seq_buf
Message-ID: <20260414045848.23c82548@robin>
In-Reply-To: <20260409103001.1-tracing-hist-synth-v3-pengpeng@iscas.ac.cn>
References: <20260329030950.32503-2-pengpeng@iscas.ac.cn>
	<20260401112224.85582-2-pengpeng@iscas.ac.cn>
	<20260409103001.1-tracing-hist-synth-v3-pengpeng@iscas.ac.cn>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: rpnnbjhr5fdoz5yixoa4hda9y5u31sg7
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 4C8C420012
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18gKX1bR7+Lo9qiVsLC/KPbxQNXM1nC9Lo=
X-HE-Tag: 1776157132-198335
X-HE-Meta: U2FsdGVkX18PbFAm5lws+YUFULo0Y1BTDH4DKX3os5fuCIr4xYPtx/bBAQmPu0DTxcYRRGVNQpWzbkccOIUDhm0p2aVxZt3lwaA+XrfMVkL0nylpL8t5u5m1Q9LP45ELwkyPdrZr0urWUwOiJw0HX8Mw0EMuRO+jAXnQ/NWXwlV/N4Tjja0L9nw1esFURUyEOsRvtkdKl5cidzfz/BASwnmp/8lm2zWUqquPFhQJunDWqtqZaw9x9CGnTusHOmCtSXcDk1rKBW3e4/IB3HanY89u1DWqwNHXUNJYpLrk5F9yW8XSXk/CkM/0VDoa8/bYatMxf7sLdYxkpIFIyMRg7geWE4jUq8CX

On Thu, 9 Apr 2026 10:19:43 +0800
Pengpeng Hou <pengpeng@iscas.ac.cn> wrote:

Hi Pengpeng,

Note, the tracing subsystem uses capital letters in the subject:

 Subject: tracing: Bound synthetic-field strings with seq_buf


> The synthetic field helpers build a prefixed synthetic variable name and
> a generated hist command in fixed MAX_FILTER_STR_VAL buffers. The
> current code appends those strings with raw strcat(), so long key lists,
> field names, or saved filters can run past the end of the staging
> buffers.
> 
> Build both strings with seq_buf and propagate -E2BIG if either the
> synthetic variable name or the generated command exceeds
> MAX_FILTER_STR_VAL. This keeps the existing tracing-side limit while
> using the helper intended for bounded command construction.
> 
> Fixes: 02205a6752f2 ("tracing: Add support for 'field variables'")
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
> Changes since v2: https://lore.kernel.org/all/20260401112224.85582-2-pengpeng@iscas.ac.cn/
> 
> - switch the synthetic name and generated command construction to seq_buf
>   as suggested by Steven Rostedt
> - keep MAX_FILTER_STR_VAL as the tracing-side limit and return -E2BIG on
>   overflow
> 
>  kernel/trace/trace_events_hist.c | 44 ++++++++++++++++++++++----------
>  1 file changed, 30 insertions(+), 14 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 73ea180cad55..7c3873719beb 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -8,6 +8,7 @@
>  #include <linux/module.h>
>  #include <linux/kallsyms.h>
>  #include <linux/security.h>
> +#include <linux/seq_buf.h>
>  #include <linux/mutex.h>
>  #include <linux/slab.h>
>  #include <linux/stacktrace.h>
> @@ -2962,14 +2963,21 @@ find_synthetic_field_var(struct hist_trigger_data *target_hist_data,
>  			 char *system, char *event_name, char *field_name)
>  {
>  	struct hist_field *event_var;
> +	struct seq_buf s;
>  	char *synthetic_name;
>  
>  	synthetic_name = kzalloc(MAX_FILTER_STR_VAL, GFP_KERNEL);
>  	if (!synthetic_name)
>  		return ERR_PTR(-ENOMEM);
>  
> -	strcpy(synthetic_name, "synthetic_");
> -	strcat(synthetic_name, field_name);
> +	seq_buf_init(&s, synthetic_name, MAX_FILTER_STR_VAL);
> +	seq_buf_puts(&s, "synthetic_");
> +	seq_buf_puts(&s, field_name);

Should have a comment here specifying what the seq_buf_str() is doing:

	/* Terminate synthetic_name with a nul */
> +	seq_buf_str(&s);

> +	if (seq_buf_has_overflowed(&s)) {
> +		kfree(synthetic_name);
> +		return ERR_PTR(-E2BIG);
> +	}
>  
>  	event_var = find_event_var(target_hist_data, system, event_name, synthetic_name);
>  
> @@ -3014,6 +3022,7 @@ create_field_var_hist(struct hist_trigger_data *target_hist_data,
>  	struct trace_event_file *file;
>  	struct hist_field *key_field;
>  	struct hist_field *event_var;
> +	struct seq_buf s;
>  	char *saved_filter;
>  	char *cmd;
>  	int ret;
> @@ -3046,41 +3055,48 @@ create_field_var_hist(struct hist_trigger_data *target_hist_data,
>  	/* See if a synthetic field variable has already been created */
>  	event_var = find_synthetic_field_var(target_hist_data, subsys_name,
>  					     event_name, field_name);


> -	if (!IS_ERR_OR_NULL(event_var))
> +	if (IS_ERR(event_var))
> +		return event_var;
> +	if (event_var)
>  		return event_var;

Note, the above is equivalent to:

	if (event_var)
		return event_var;

And since it is a separate issue than the bounding of the string, it
should be a separate patch.

>  
>  	var_hist = kzalloc_obj(*var_hist);
>  	if (!var_hist)
>  		return ERR_PTR(-ENOMEM);
>  
> +	saved_filter = find_trigger_filter(hist_data, file);

Why did you move this up here?

> +
>  	cmd = kzalloc(MAX_FILTER_STR_VAL, GFP_KERNEL);
>  	if (!cmd) {
>  		kfree(var_hist);
>  		return ERR_PTR(-ENOMEM);
>  	}
>  
> +	seq_buf_init(&s, cmd, MAX_FILTER_STR_VAL);
> +
>  	/* Use the same keys as the compatible histogram */
> -	strcat(cmd, "keys=");
> +	seq_buf_puts(&s, "keys=");
>  
>  	for_each_hist_key_field(i, hist_data) {
>  		key_field = hist_data->fields[i];
>  		if (!first)
> -			strcat(cmd, ",");
> -		strcat(cmd, key_field->field->name);
> +			seq_buf_putc(&s, ',');
> +		seq_buf_puts(&s, key_field->field->name);
>  		first = false;
>  	}
>  
>  	/* Create the synthetic field variable specification */
> -	strcat(cmd, ":synthetic_");
> -	strcat(cmd, field_name);
> -	strcat(cmd, "=");
> -	strcat(cmd, field_name);
> +	seq_buf_printf(&s, ":synthetic_%s=%s", field_name, field_name);
>  
>  	/* Use the same filter as the compatible histogram */
> -	saved_filter = find_trigger_filter(hist_data, file);

It makes more sense to define saved_filter next to where it is used.

> -	if (saved_filter) {
> -		strcat(cmd, " if ");
> -		strcat(cmd, saved_filter);
> +	if (saved_filter)
> +		seq_buf_printf(&s, " if %s", saved_filter);
> +
> +	seq_buf_str(&s);
> +	if (seq_buf_has_overflowed(&s)) {
> +		kfree(cmd);
> +		kfree(var_hist);
> +		return ERR_PTR(-E2BIG);
>  	}
>  
>  	var_hist->cmd = kstrdup(cmd, GFP_KERNEL);

-- Steve
