Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B08E2FFDD5;
	Wed,  8 Apr 2026 21:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775683806; cv=none; b=nxOPDUFE4+Mf401ojuGbiWOihcSsvpzHHiEC/IEOiX9uk+OJp86brkKyiDDMitnIc7/UU1DNYeOf+tMbglpMIWG5MmiY2Srdh+1SnH/podr8Rw/XuYeCPdow+srNkVeY/RUY9L/hwCDAbReeGcuzBUtLvE5jtaLzbob0DPN6H3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775683806; c=relaxed/simple;
	bh=e+H+pT7DJH5FA4+4N9KpAxaND6EfhsMTWu6Z4Fqn8Ak=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oZLJm+YFcHojlSmVvGRlvZhbpAGruGljm+k8fr+qP+NwBoLWcMzCF2qd4vxU/O+GEdJ9m0gojgzLCb64tJ2VkFPpwmgGtaYSY5hdua+sHmGJ1LnncmO+/k/c72Yh/qhZF1qtq5Pe4CWbao/hwyZH3V+J3tzgKp0D+MEgW0mUs/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id D80F78AB8F;
	Wed,  8 Apr 2026 21:30:03 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 18F9D2002B;
	Wed,  8 Apr 2026 21:30:02 +0000 (UTC)
Date: Wed, 8 Apr 2026 17:31:18 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 tom.zanussi@linux.intel.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] tracing/hist: reject synthetic-field strings
 that exceed MAX_FILTER_STR_VAL
Message-ID: <20260408173118.25aa80b8@gandalf.local.home>
In-Reply-To: <20260401112224.85582-2-pengpeng@iscas.ac.cn>
References: <20260401112224.85582-2-pengpeng@iscas.ac.cn>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 18F9D2002B
X-Stat-Signature: kgf5i4xu64pfgzbprctj5awn6drw1y7p
X-Rspamd-Server: rspamout03
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+EtflEPkF6Bl7iXtJq8ZU8gTJVTe2tCns=
X-HE-Tag: 1775683802-823175
X-HE-Meta: U2FsdGVkX1/iNYvhWMncvMIWHMg+h7oQf33AShEWBGYSTchOXH4IuTMJ/gY5Gk0y2pAK04NE75avBN90PTBWZQ/A7/6BxEO0MB4qd5rnl5LWuUVbXe3kwUTedxJVHl2QJej+XzXleAhf10fxfYY9CsiltHLccqWSQRSnXLo4vNK4gETtAaukiz3+Og3TWamh4ZyKZB4TMEq8iQzcM0HHRd2vkHEXn/OM+dcxC1CmIAUqGr/oomeqPVvdo7UZCyncEmAMVlwi29PARfF4NKFgv6b87knD9zLKByhc1uJNmDnYkF7YOURwolbKNG353MJd

On Wed,  1 Apr 2026 19:22:24 +0800
Pengpeng Hou <pengpeng@iscas.ac.cn> wrote:

> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index f9c8a4f078ea..4172c91605af 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -2966,12 +2966,16 @@ find_synthetic_field_var(struct hist_trigger_data *target_hist_data,
>  	struct hist_field *event_var;
>  	char *synthetic_name;
>  
> +	if ((sizeof("synthetic_") - 1) + strlen(field_name) >=
> +	    MAX_FILTER_STR_VAL)
> +		return ERR_PTR(-E2BIG);
> +
>  	synthetic_name = kzalloc(MAX_FILTER_STR_VAL, GFP_KERNEL);
>  	if (!synthetic_name)
>  		return ERR_PTR(-ENOMEM);
>  
> -	strcpy(synthetic_name, "synthetic_");
> -	strcat(synthetic_name, field_name);
> +	scnprintf(synthetic_name, MAX_FILTER_STR_VAL, "synthetic_%s",
> +		  field_name);
>  
>  	event_var = find_event_var(target_hist_data, system, event_name, synthetic_name);
>  
> @@ -3018,6 +3022,8 @@ create_field_var_hist(struct hist_trigger_data *target_hist_data,
>  	struct hist_field *event_var;
>  	char *saved_filter;
>  	char *cmd;
> +	size_t cmdlen;
> +	size_t off;
>  	int ret;
>  
>  	if (target_hist_data->n_field_var_hists >= SYNTH_FIELDS_MAX) {
> @@ -3048,13 +3054,36 @@ create_field_var_hist(struct hist_trigger_data *target_hist_data,
>  	/* See if a synthetic field variable has already been created */
>  	event_var = find_synthetic_field_var(target_hist_data, subsys_name,
>  					     event_name, field_name);
> -	if (!IS_ERR_OR_NULL(event_var))
> +	if (IS_ERR(event_var))
> +		return event_var;
> +	if (event_var)
>  		return event_var;
>  
>  	var_hist = kzalloc_obj(*var_hist);
>  	if (!var_hist)
>  		return ERR_PTR(-ENOMEM);
>  
> +	saved_filter = find_trigger_filter(hist_data, file);
> +
> +	cmdlen = strlen("keys=") + strlen(":synthetic_") +
> +		 strlen(field_name) + strlen("=") + strlen(field_name);

Instead of doing all this complex updates, let's use seq_buf in this patch
instead. That's what it's for.

I'll take patch 1 as is, just update this patch.

Thanks,

-- Steve


> +	first = true;
> +	for_each_hist_key_field(i, hist_data) {
> +		key_field = hist_data->fields[i];
> +		if (!first)
> +			cmdlen++;
> +		cmdlen += strlen(key_field->field->name);
> +		first = false;
> +	}
> +
> +	if (saved_filter)
> +		cmdlen += strlen(" if ") + strlen(saved_filter);
> +
> +	if (cmdlen >= MAX_FILTER_STR_VAL) {
> +		kfree(var_hist);
> +		return ERR_PTR(-E2BIG);
> +	}
> +
>  	cmd = kzalloc(MAX_FILTER_STR_VAL, GFP_KERNEL);
>  	if (!cmd) {
>  		kfree(var_hist);
> @@ -3062,28 +3091,24 @@ create_field_var_hist(struct hist_trigger_data *target_hist_data,
>  	}
>  
>  	/* Use the same keys as the compatible histogram */
> -	strcat(cmd, "keys=");
> +	off = scnprintf(cmd, MAX_FILTER_STR_VAL, "keys=");
> +	first = true;
>  
>  	for_each_hist_key_field(i, hist_data) {
>  		key_field = hist_data->fields[i];
> -		if (!first)
> -			strcat(cmd, ",");
> -		strcat(cmd, key_field->field->name);
> +		off += scnprintf(cmd + off, MAX_FILTER_STR_VAL - off, "%s%s",
> +				 first ? "" : ",", key_field->field->name);
>  		first = false;
>  	}
>  
>  	/* Create the synthetic field variable specification */
> -	strcat(cmd, ":synthetic_");
> -	strcat(cmd, field_name);
> -	strcat(cmd, "=");
> -	strcat(cmd, field_name);
> +	off += scnprintf(cmd + off, MAX_FILTER_STR_VAL - off,
> +			 ":synthetic_%s=%s", field_name, field_name);
>  
>  	/* Use the same filter as the compatible histogram */
> -	saved_filter = find_trigger_filter(hist_data, file);
> -	if (saved_filter) {
> -		strcat(cmd, " if ");
> -		strcat(cmd, saved_filter);
> -	}
> +	if (saved_filter)
> +		scnprintf(cmd + off, MAX_FILTER_STR_VAL - off, " if %s",
> +			  saved_filter);
>  
>  	var_hist->cmd = kstrdup(cmd, GFP_KERNEL);
>  	if (!var_hist->cmd) {

