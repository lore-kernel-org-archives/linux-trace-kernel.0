Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04B619E839;
	Thu, 30 Apr 2026 05:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777526057; cv=none; b=guoU45KRnen9OsbslidamJbyhh9HnCDHOPYbkGttUMlit6ATbFv4l44xdIzgYHR99xyAY2TQN9IUZij6vqjPepMDzkpbKSGVWmKWfwBwKX4GTiAKIswDpvYdR3g/RtJ/FafxEQz/9S2SbBV5KU1wkZTesqNI+V0rT8uiNK34nqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777526057; c=relaxed/simple;
	bh=1uODezsZQR0ItXq8SMUEEkmY9GDgJCtfOGluj9/Id08=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=HXMQVBMDfrCIsJkp1/JsAcDlIMr3dSygJnQt7I7VuYJwy3ipm0Cn8fhDDNCdoCFsNRo5mvHx3JjOcu6CAi6QuMF4EcFVLnwCzEzQQVzd7J6EoXVGZwDoi0zZZ/cDXBXsMPBx9pp+nBtfQ7rwD+R5YZNlJEEd4TcGKtwIVxMYtnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L3q2z2Tg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3q2z2Tg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 987A1C2BCB8;
	Thu, 30 Apr 2026 05:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777526056;
	bh=1uODezsZQR0ItXq8SMUEEkmY9GDgJCtfOGluj9/Id08=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L3q2z2TgN2t8b7+DaFAdhcdmcuXFu0K8DAMHXBLQ6LTDs3NyOsM5iUHveak+mk5lm
	 XqJEr4zW0yIjmzRIeCsEhrwjmFIlonpi14+E21VkZLe0/gSzSEm8bYVqJsJ+FoUfEa
	 7JrJ8FW4+4Udv/+YVFJNlukZanxl8URseZj8I6dTApM6ga3Z5xfVOBmYfXvKcrDnTv
	 hx3RFdKqx9vuuPog++SzBUj6L1Jcmzv8ZdrqKjeQq7zPpX+KAvpc2VGVcf0L+SwmpI
	 OGyWcWKwelEUf61yFt/q+38mT8YnadkYirqqEzBd/zB49629SgUf1YVtb7r/Xa/Uda
	 D8J0krEh3E0lQ==
Date: Thu, 30 Apr 2026 14:14:14 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Tom Zanussi
 <tom.zanussi@linux.intel.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] tracing: Bound synthetic-field strings with seq_buf
Message-Id: <20260430141414.b6fb7a49f4eae3cac847fb54@kernel.org>
In-Reply-To: <20260430043350.57928-1-pengpeng@iscas.ac.cn>
References: <20260430043350.57928-1-pengpeng@iscas.ac.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Apr 2026 12:33:50 +0800
Pengpeng Hou <pengpeng@iscas.ac.cn> wrote:

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

Good catch! This looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

(BTW, we need to use __free(kfree) in this file too.)

> Fixes: 02205a6752f2 ("tracing: Add support for 'field variables'")
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
> Changes since v5: https://lore.kernel.org/all/20260424070104.1-tracing-synth-v5-pengpeng@iscas.ac.cn/
> - start a new thread for the new patch revision
> - use a lore link for the previous version in the changelog
> - simplify the synthetic-name construction with seq_buf_printf()
> - keep saved_filter as a normal local variable and avoid an anonymous block
> 
>  kernel/trace/trace_events_hist.c | 41 ++++++++++++++++++++++----------
>  1 file changed, 29 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 0dbbf6cca9bc..aa8e7f043ac0 100644
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
> @@ -2968,14 +2969,23 @@ find_synthetic_field_var(struct hist_trigger_data *target_hist_data,
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
> +	seq_buf_printf(&s, "synthetic_%s", field_name);
> +
> +	/* Terminate synthetic_name with a NUL. */
> +	seq_buf_str(&s);
> +
> +	if (seq_buf_has_overflowed(&s)) {
> +		kfree(synthetic_name);
> +		return ERR_PTR(-E2BIG);
> +	}
>  
>  	event_var = find_event_var(target_hist_data, system, event_name, synthetic_name);
>  
> @@ -3020,6 +3030,7 @@ create_field_var_hist(struct hist_trigger_data *target_hist_data,
>  	struct trace_event_file *file;
>  	struct hist_field *key_field;
>  	struct hist_field *event_var;
> +	struct seq_buf s;
>  	char *saved_filter;
>  	char *cmd;
>  	int ret;
> @@ -3065,28 +3076,34 @@ create_field_var_hist(struct hist_trigger_data *target_hist_data,
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
>  	saved_filter = find_trigger_filter(hist_data, file);
> -	if (saved_filter) {
> -		strcat(cmd, " if ");
> -		strcat(cmd, saved_filter);
> +	if (saved_filter)
> +		seq_buf_printf(&s, " if %s", saved_filter);
> +
> +	/* Terminate cmd with a NUL. */
> +	seq_buf_str(&s);
> +
> +	if (seq_buf_has_overflowed(&s)) {
> +		kfree(cmd);
> +		kfree(var_hist);
> +		return ERR_PTR(-E2BIG);
>  	}
>  
>  	var_hist->cmd = kstrdup(cmd, GFP_KERNEL);
> -- 
> 2.50.1 (Apple Git-155)
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
