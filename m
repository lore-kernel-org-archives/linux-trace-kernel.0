Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A901B28F5;
	Fri, 17 Apr 2026 16:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776442592; cv=none; b=OeyJ9nUcMYw5h/ba99c6FrSUji6YI3grZvi7z/1rJH3WvmArgOyUnClN2YtPJwlAVTlxwzBorjsxxaVOF2hdOlJHihTkWKg5ohA1z4a9/yh5CbbkZnmuew5H94L5yZMe/UkmReM5CPXRxOf+TzwuPqf7gagCkQdl7jYtRDMvh6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776442592; c=relaxed/simple;
	bh=lFfXDprj5M0wVr/gGY0MPW9GOZ3AnfosZxz97RIxw5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D1WbF33zsLaEE1Sb0j4s5z7i/i6sl9ofa/fLuoOUy8qVd6YZaLpsyGyJbFsNgBMkkG+F0q8PoQwirVIxg864rLo40w2cWgmxcI/X4hQYdUwWv+zGtjMaoQQWo1AaXka/iccOa36KdzpaL1aRifbz6Oj5BJl0boNMb/CfglxIHMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 4CCDC1A016C;
	Fri, 17 Apr 2026 16:16:28 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id 2202120013;
	Fri, 17 Apr 2026 16:16:25 +0000 (UTC)
Date: Fri, 17 Apr 2026 12:16:18 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Tom Zanussi
 <tom.zanussi@linux.intel.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] tracing: Bound synthetic-field strings with seq_buf
Message-ID: <20260417121618.0e20c7a7@fedora>
In-Reply-To: <20260417223001.1-tracing-synth-v4-pengpeng@iscas.ac.cn>
References: <20260329030950.32503-2-pengpeng@iscas.ac.cn>
	<20260401112224.85582-2-pengpeng@iscas.ac.cn>
	<20260409103001.1-tracing-hist-synth-v3-pengpeng@iscas.ac.cn>
	<20260417223001.1-tracing-synth-v4-pengpeng@iscas.ac.cn>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 8ybo976kwyh6wqt44n3q6iyi6x3zr8ud
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 2202120013
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/qAuL2WvMjolJz8NlrEFKZ69KaBK0Jgm4=
X-HE-Tag: 1776442585-220402
X-HE-Meta: U2FsdGVkX1/cVV/nHOMcxbWe54jwgCnVyyfssaXZLz4WNiWUkAjm3qEfc+kvyd0N5MZTGhl1vd4=

On Fri, 17 Apr 2026 20:20:00 +0800
Pengpeng Hou <pengpeng@iscas.ac.cn> wrote:

> @ -2962,14 +2963,22 @@ find_synthetic_field_var(struct hist_trigger_data *target_hist_data,
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

newline

> +	/* Terminate synthetic_name with a NUL. */
> +	seq_buf_str(&s);

newline

> +	if (seq_buf_has_overflowed(&s)) {
> +		kfree(synthetic_name);
> +		return ERR_PTR(-E2BIG);
> +	}
>  
>  	event_var = find_event_var(target_hist_data, system, event_name, synthetic_name);
>  
> @@ -3014,7 +3023,7 @@ create_field_var_hist(struct hist_trigger_data *target_hist_data,
>  	struct trace_event_file *file;
>  	struct hist_field *key_field;
>  	struct hist_field *event_var;
> -	char *saved_filter;
> +	struct seq_buf s;
>  	char *cmd;
>  	int ret;
>  
> @@ -3059,28 +3068,35 @@ create_field_var_hist(struct hist_trigger_data *target_hist_data,
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
> -	if (saved_filter) {
> -		strcat(cmd, " if ");
> -		strcat(cmd, saved_filter);
> +	{
> +		char *saved_filter = find_trigger_filter(hist_data, file);
> +
> +		if (saved_filter)
> +			seq_buf_printf(&s, " if %s", saved_filter);
> +	}
> +

Different function. Should have the comment about adding nul here too.

> +	seq_buf_str(&s);

newline

> +	if (seq_buf_has_overflowed(&s)) {
> +		kfree(cmd);
> +		kfree(var_hist);
> +		return ERR_PTR(-E2BIG);
>  	}

-- Steve
