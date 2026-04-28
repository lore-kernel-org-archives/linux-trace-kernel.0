Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6F324677F;
	Tue, 28 Apr 2026 17:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777397535; cv=none; b=OMBohSJRpL5cdhkdN0lDwEDw2Zaho9Pcl4q17bfbZmsWyQiJ6mA07uveGc5N9eFAbdO2zQCNOoyQR/qGxAke+7ufTT6gaQIrlTSUgz0ElTdT8GrhLAwQ8cRATpbFQqz+HG4hQb5iIfpMsBYuyYSdXLTEnXR11bkWHfxYpzrUL0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777397535; c=relaxed/simple;
	bh=DkdHCs8ZNafeqnZEGWNoFb0/+1xrUHpCXBGXqKNVuoM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jOafCLuGGngp8JSazIjDdgOkztLwsrQ1CZfbI1Th4QqY1+GZEd9aJEV+qPpEZxhFYvUOEUL/fjystpOF+MoQw2H/otTJwXiYvJ24ITZHNZSOI1kM7RUqeiwQMtYhAShhYOMfO5lXvkPi2ffuhtrhlaaxRdmqSxaRF5wiLhWM3t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 2CE68C1966;
	Tue, 28 Apr 2026 17:32:12 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id 649BF2E;
	Tue, 28 Apr 2026 17:32:10 +0000 (UTC)
Date: Tue, 28 Apr 2026 13:32:25 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Tom Zanussi
 <tom.zanussi@linux.intel.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] tracing: Bound synthetic-field strings with seq_buf
Message-ID: <20260428133216.55ef9027@gandalf.local.home>
In-Reply-To: <20260424070104.1-tracing-synth-v5-pengpeng@iscas.ac.cn>
References: <20260329030950.32503-2-pengpeng@iscas.ac.cn>
	<20260401112224.85582-2-pengpeng@iscas.ac.cn>
	<20260409103001.1-tracing-hist-synth-v3-pengpeng@iscas.ac.cn>
	<20260417223001.1-tracing-synth-v4-pengpeng@iscas.ac.cn>
	<20260424070104.1-tracing-synth-v5-pengpeng@iscas.ac.cn>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: ws3dajdjc4wn4yndgjmwj3mc7ymyozqg
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 649BF2E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19cC8h5BZqADlVd8ZkfGOs2Vmfe6pim4Pk=
X-HE-Tag: 1777397530-108285
X-HE-Meta: U2FsdGVkX1+kNB6aA36PLnhCnuy3qo2nCVrUceWsVDM1omnwSj8cOw5HissO78CqQQ/9fiqv3Nmd7nFA+1ZnA3dB0w/SCPG58sYu35LcFbrL6q3CVIUqy5PryqK0xdRNaJHdO5OjL5nhLTdUT+DSsoytVeZrQA2KwFrIGHvg7YtuaPN6mkE3UqU64mJGBFUzna0i2CgRsPZzSLs5v5S3JAULL7uE/uhUamCqm5g4j4vhAzo2CSqUDZ5TNt8aaBSMyFH2SOVi2QCQq5EW8CMTMd+co5NADqBZoRhgZ3SmgBhIMr48b7B0YRkBO/tgVCirU2Zm8LpLFGpLyfhwreCTWY9RTzz64CSqARTESS7uml9pJNVMm71RRAqFr4rtwCMF


I should have also mentioned. Please, new versions of a patch should always
start a new thread. Don't reply to the previous version. That makes it very
difficult to find which is the latest version.

On Thu, 23 Apr 2026 23:33:00 +0800
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
> Fixes: 02205a6752f2 ("tracing: Add support for 'field variables'")
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
> Changes since v4:

To keep a link to the previous version, use lore links to access it (the
message ID of the previous version attached to
"https://lore.kernel.org/all/$message-id")

 Changes since v4: https://lore.kernel.org/all/20260417223001.1-tracing-synth-v4-pengpeng@iscas.ac.cn/


> - add the requested blank lines around seq_buf_str() comments
> - add the seq_buf_str() comment for the generated command buffer too
> - keep saved_filter scoped next to its point of use
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 0dbbf6cca9bc..87429567417f 100644
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
> @@ -2968,14 +2969,24 @@ find_synthetic_field_var(struct hist_trigger_data *target_hist_data,
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

Hmm, the above is probably simpler with:

	seq_buf_printf(&s, "synthetic_%s", field_name);

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
> @@ -3020,7 +3031,7 @@ create_field_var_hist(struct hist_trigger_data *target_hist_data,
>  	struct trace_event_file *file;
>  	struct hist_field *key_field;
>  	struct hist_field *event_var;

> -	char *saved_filter;

Don't remove this for an anonymous block.

> +	struct seq_buf s;
>  	char *cmd;
>  	int ret;
>  
> @@ -3065,28 +3076,37 @@ create_field_var_hist(struct hist_trigger_data *target_hist_data,
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

We don't add anonymous blocks in the kernel (with the exception of needing
to be around #ifdefs).

-- Steve

> +		char *saved_filter = find_trigger_filter(hist_data, file);
> +
> +		if (saved_filter)
> +			seq_buf_printf(&s, " if %s", saved_filter);
> +	}
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

