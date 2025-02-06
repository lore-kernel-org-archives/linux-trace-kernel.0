Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FC22248B2;
	Thu,  6 Feb 2025 08:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738830406; cv=none; b=aQ0VS8xnVCfpzKnetSRtpHsDkY7tGuQNJVRFerONWI5Hc3E6qYEIKVSdN/tEaUPFuYBH4FhRPodoeTk/FtFCw1/AvxA/R5tOsdOjWKTDLuYi8vP7WiQOjdZlnrkhvXPHyIBEG8k6EmXRMvi/ChXB8J9Pv+9liQUcB6+dez6ADf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738830406; c=relaxed/simple;
	bh=T5UOvt5rBtRb9ezz2YfV0roQ9+rJUKYAr8x++BCEjzA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=KmMDvpd0XIDYBmGqTHYNHQe/rEPkfzCYTI+HminVYC7YO1NnbgwfBljylHiRkGbWkToxpVWa7mK/r7xQ1wJDZ5MGf2/qSUcvPDhkfG8AgVzBohUJs/g317FA+UZsa9deL4ZWiHQyThkTBQiXhHqNtzK0EbFUWdE+BMsOcTDvprc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHlDfvQE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHlDfvQE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88F11C4CEDD;
	Thu,  6 Feb 2025 08:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738830405;
	bh=T5UOvt5rBtRb9ezz2YfV0roQ9+rJUKYAr8x++BCEjzA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GHlDfvQEaJHR/DX7qUansSDeG0WNfMBEDVbiWCcODxi5f8vjUc+MPD81ZqrMKsVwb
	 L8UPXWf2OHRF1EGxN6gCCegJ9L8Nfop2tBmL0KVXeKTwYE6uHYaBlE0/jOVasjd0dC
	 qgvTMfIBhGYfgzkdSG4LovWnbWoIS/y6k6GniLeBOx+AFJ1Ir3JqGK8ev9MWoohWXk
	 Mvx5DTX8oHLtrIAvQ9YSs3y7sr1+cIVmssc8vm/QTN4ho8pvnaylOmJvFeI9tS1lvF
	 BfHFiRt+zbu7k2qsmrqCEfIcIoYT88dK16GxPS41I3zLYs/UuXvqmLvbvk1MZv3cKy
	 hYWbWfVscqexQ==
Date: Thu, 6 Feb 2025 17:26:42 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>
Subject: Re: [PATCH 6/8] tracing: Have persistent trace instances save
 module addresses
Message-Id: <20250206172642.391c16d75dbce00518ef9688@kernel.org>
In-Reply-To: <20250205225103.930895467@goodmis.org>
References: <20250205225031.799739376@goodmis.org>
	<20250205225103.930895467@goodmis.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 05 Feb 2025 17:50:37 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> For trace instances that are mapped to persistent memory, have them use
> the scratch area to save the currently loaded modules. This will allow
> where the modules have been loaded on the next boot so that their
> addresses can be deciphered by using where they were loaded previously.
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace.c | 99 ++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 87 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index cb9f8e6878a0..a8e5f7ac2193 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -5994,14 +5994,60 @@ ssize_t tracing_resize_ring_buffer(struct trace_array *tr,
>  	return ret;
>  }
>  
> +struct trace_mod_entry {
> +	unsigned long	mod_addr;
> +	char		mod_name[MODULE_NAME_LEN];
> +};
> +
>  struct trace_scratch {
>  	unsigned long		kaslr_addr;
> +	unsigned long		nr_entries;
> +	struct trace_mod_entry	entries[];
>  };
>  
> +static int save_mod(struct module *mod, void *data)
> +{
> +	struct trace_array *tr = data;
> +	struct trace_scratch *tscratch;
> +	struct trace_mod_entry *entry;
> +	unsigned int size;
> +
> +	tscratch = tr->scratch;
> +	if (!tscratch)
> +		return -1;
> +	size = tr->scratch_size;
> +
> +	if (struct_size(tscratch, entries, tscratch->nr_entries + 1) > size)
> +		return -1;
> +
> +	entry = &tscratch->entries[tscratch->nr_entries];
> +
> +	tscratch->nr_entries++;
> +
> +	entry->mod_addr = (unsigned long)mod->mem[MOD_TEXT].base;
> +	strscpy(entry->mod_name, mod->name);
> +
> +	return 0;
> +}
> +
>  static void update_last_data(struct trace_array *tr)
>  {
>  	struct trace_scratch *tscratch;
>  
> +	if (!(tr->flags & TRACE_ARRAY_FL_BOOT))
> +		return;
> +
> +	/* Reset the module list and reload them */
> +	if (tr->scratch) {
> +		struct trace_scratch *tscratch = tr->scratch;
> +
> +		memset(tscratch->entries, 0,
> +		       flex_array_size(tscratch, entries, tscratch->nr_entries));
> +		tscratch->nr_entries = 0;
> +
> +		module_for_each_mod(save_mod, tr);
> +	}

This maybe too frequently scan the module because the update_last_data() is
called when;
- change tracer (this maybe OK)
- update "set_event"
- write 1 to "enable" under events
- change pid filter
- etc.

Once it is scanned, it should not scan again, but update by module
callback, because usually events are enabled individually (thus
write 1 to "event" can happen multiple time online).

I think we can move this after TRACE_ARRAY_FL_LAST_BOOT check,
if TRACE_ARRAY_FL_LAST_BOOT flag is set, that flag should be cleared
with updating the tscratch, and the flag is not set, we can skip updating
the scratch.

Thank you,

> +
>  	if (!(tr->flags & TRACE_ARRAY_FL_LAST_BOOT))
>  		return;
>  
> @@ -9226,6 +9272,46 @@ static struct dentry *trace_instance_dir;
>  static void
>  init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer);
>  
> +static void setup_trace_scratch(struct trace_array *tr, void *scratch, unsigned int size)
> +{
> +	struct trace_scratch *tscratch = scratch;
> +	struct trace_mod_entry *entry;
> +
> +	if (!scratch)
> +		return;
> +
> +	tr->scratch = scratch;
> +	tr->scratch_size = size;
> +
> +#ifdef CONFIG_RANDOMIZE_BASE
> +	if (tscratch->kaslr_addr)
> +		tr->text_delta = kaslr_offset() - tscratch->kaslr_addr;
> +#endif
> +
> +	if (struct_size(tscratch, entries, tscratch->nr_entries) > size)
> +		goto reset;
> +
> +	/* Check if each module name is a valid string */
> +	for (int i = 0; i < tscratch->nr_entries; i++) {
> +		int n;
> +
> +		entry = &tscratch->entries[i];
> +
> +		for (n = 0; n < MODULE_NAME_LEN; n++) {
> +			if (entry->mod_name[n] == '\0')
> +				break;
> +			if (!isprint(entry->mod_name[n]))
> +				goto reset;
> +		}
> +		if (n == MODULE_NAME_LEN)
> +			goto reset;
> +	}
> +	return;
> + reset:
> +	/* Invalid trace modules */
> +	memset(scratch, 0, size);
> +}
> +
>  static int
>  allocate_trace_buffer(struct trace_array *tr, struct array_buffer *buf, int size)
>  {
> @@ -9243,19 +9329,8 @@ allocate_trace_buffer(struct trace_array *tr, struct array_buffer *buf, int size
>  						      tr->range_addr_size);
>  
>  		scratch = ring_buffer_meta_scratch(buf->buffer, &scratch_size);
> -		if (scratch) {
> -			tr->scratch = scratch;
> -			tr->scratch_size = scratch_size;
> +		setup_trace_scratch(tr, scratch, scratch_size);
>  
> -#ifdef CONFIG_RANDOMIZE_BASE
> -			{
> -				struct trace_scratch *tscratch = tr->scratch;
> -
> -				if (tscratch->kaslr_addr)
> -					tr->text_delta = kaslr_offset() - tscratch->kaslr_addr;
> -			}
> -#endif
> -		}
>  		/*
>  		 * This is basically the same as a mapped buffer,
>  		 * with the same restrictions.
> -- 
> 2.45.2
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
