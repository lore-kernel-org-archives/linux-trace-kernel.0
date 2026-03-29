Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6240536C9C1;
	Sun, 29 Mar 2026 18:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774810131; cv=none; b=C0zwXhXQ6y8ntWg+oxM+uhDKKdTHte8uSmL1ZJLyJZMiPHJ9Sh+fqz9XizEN+PFDE4TzATHu1rppHAXVdqk4uRsXPgckxuggKAXFgtFKprBDdv0puAf2oq727JvHvPtnKvqiyxiSQdYDejn7F8CevBFel0v+TVuvVeY8IWAlx20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774810131; c=relaxed/simple;
	bh=oBFIfXp5lQAp915nPhmlHS+Wpla6OlTbZx/45OLvopc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OOPKqXixcjzGW21SqTQavJqpWOEoECl54ffmkyPwllFTNE0L6QHCUv8aCNz3a52AGRIy+33kOp4CSzuMCb6Iz43Gzl5NCQKPhCC1VIMm0cF1WUnSf+VecYkDXp6RHmqHJ+rMPmxsYi/7wPlNv2cn+OC4C8agqDbD9W84jUV41XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id EC3C9E0857;
	Sun, 29 Mar 2026 18:48:47 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 1F81B20029;
	Sun, 29 Mar 2026 18:48:46 +0000 (UTC)
Date: Sun, 29 Mar 2026 14:49:39 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 tom.zanussi@linux.intel.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] tracing/hist: allocate synthetic-field command
 buffers to fit
Message-ID: <20260329144939.55cdf935@gandalf.local.home>
In-Reply-To: <20260329030950.32503-2-pengpeng@iscas.ac.cn>
References: <20260329030950.32503-2-pengpeng@iscas.ac.cn>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 1F81B20029
X-Rspamd-Server: rspamout06
X-Stat-Signature: iujhnd6jqeyb44y5t77o7ntqt4ahexig
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18Op/iMd74LZtqGLyQguq0SqPH9sjEwYaI=
X-HE-Tag: 1774810126-128758
X-HE-Meta: U2FsdGVkX19a+eWGLJDzLlZw9M7UFVvH+qL8agt3avS7Yh7QYfz3K1kfy6r156Zlzv3k+6giX/KRFuIKgIuWYUammQaEXaQmSNFnA5mMV/84KDoi8vGZfjz78mygng4rbB6X/tOMXxl7Ktm/cH7SVs8+sE4PDt8qLrbqhYJwIZjdrqwhKwE8erj/S4n6lVg9XK5lgHdbJ/+oW7e/SCKlJCOq/xr5BXjmw1Dc+QqHvBmAPhtO1TRBSQNLFapbQmEpWNV+vNn+gXujr9OrrZqMyPCkRXA3xd1tw72AR1WREew5YZd9rDYP7qrQaSoI/zXq

On Sun, 29 Mar 2026 11:09:50 +0800
Pengpeng Hou <pengpeng@iscas.ac.cn> wrote:

> The synthetic field helpers currently build temporary names and trigger
> commands in fixed MAX_FILTER_STR_VAL buffers with strcpy() and strcat().
> Long field names, key lists, or saved filters can therefore overrun
> those staging buffers while constructing the synthetic histogram
> command.
> 
> Allocate the synthetic name and command buffers to the exact size
> required by the current histogram instead of relying on fixed-size
> scratch storage.

No, the names should never be greater than the max value defined. If they
are, then it should error out.

> 
> Fixes: 02205a6752f2 ("tracing: Add support for 'field variables'")
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>  kernel/trace/trace_events_hist.c | 46 +++++++++++++++++++-------------
>  1 file changed, 28 insertions(+), 18 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 4a27da628a71..1883bd6d9b95 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -2964,13 +2964,10 @@ find_synthetic_field_var(struct hist_trigger_data *target_hist_data,
>  	struct hist_field *event_var;
>  	char *synthetic_name;
>  

Should be preceded with:

	if (strlen("synthetic_") + strlen(field_name) >= MAX_FILTER_STR_VAL)
		return ERR_PTR(-E2BIG);


> -	synthetic_name = kzalloc(MAX_FILTER_STR_VAL, GFP_KERNEL);
> +	synthetic_name = kasprintf(GFP_KERNEL, "synthetic_%s", field_name);
>  	if (!synthetic_name)
>  		return ERR_PTR(-ENOMEM);
>  
> -	strcpy(synthetic_name, "synthetic_");
> -	strcat(synthetic_name, field_name);
> -
>  	event_var = find_event_var(target_hist_data, system, event_name, synthetic_name);
>  
>  	kfree(synthetic_name);
> @@ -3016,6 +3013,8 @@ create_field_var_hist(struct hist_trigger_data *target_hist_data,
>  	struct hist_field *event_var;
>  	char *saved_filter;
>  	char *cmd;
> +	size_t cmdlen;
> +	size_t off;
>  	int ret;
>  
>  	if (target_hist_data->n_field_var_hists >= SYNTH_FIELDS_MAX) {
> @@ -3053,35 +3052,46 @@ create_field_var_hist(struct hist_trigger_data *target_hist_data,
>  	if (!var_hist)
>  		return ERR_PTR(-ENOMEM);
>  
> -	cmd = kzalloc(MAX_FILTER_STR_VAL, GFP_KERNEL);
> +	saved_filter = find_trigger_filter(hist_data, file);
> +
> +	cmdlen = strlen("keys=") + strlen(":synthetic_") +
> +		 strlen(field_name) + strlen("=") + strlen(field_name) + 1;
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

Length should be checked. There shouldn't be huge strings for filters.
Perhaps in the future we may make them bigger but for now, 256 bytes should
be the limit.

-- Steve


> +	cmd = kzalloc(cmdlen, GFP_KERNEL);
>  	if (!cmd) {
>  		kfree(var_hist);
>  		return ERR_PTR(-ENOMEM);
>  	}
>  
>  	/* Use the same keys as the compatible histogram */
> -	strcat(cmd, "keys=");
> +	off = scnprintf(cmd, cmdlen, "keys=");
> +	first = true;
>  
>  	for_each_hist_key_field(i, hist_data) {
>  		key_field = hist_data->fields[i];
> -		if (!first)
> -			strcat(cmd, ",");
> -		strcat(cmd, key_field->field->name);
> +		off += scnprintf(cmd + off, cmdlen - off, "%s%s",
> +				 first ? "" : ",",
> key_field->field->name); first = false;
>  	}
>  
>  	/* Create the synthetic field variable specification */
> -	strcat(cmd, ":synthetic_");
> -	strcat(cmd, field_name);
> -	strcat(cmd, "=");
> -	strcat(cmd, field_name);
> +	off += scnprintf(cmd + off, cmdlen - off, ":synthetic_%s=%s",
> +			 field_name, field_name);
>  
>  	/* Use the same filter as the compatible histogram */
> -	saved_filter = find_trigger_filter(hist_data, file);
> -	if (saved_filter) {
> -		strcat(cmd, " if ");
> -		strcat(cmd, saved_filter);
> -	}
> +	if (saved_filter)
> +		scnprintf(cmd + off, cmdlen - off, " if %s",
> saved_filter); 
>  	var_hist->cmd = kstrdup(cmd, GFP_KERNEL);
>  	if (!var_hist->cmd) {

