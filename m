Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB8739183A;
	Wed,  8 Apr 2026 20:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775679832; cv=none; b=PFzqHPBtwbfx2iPQqOHTIJ3/WLl0CBSFT8tj/WUPUZoBacKLfZ9sm+BX/FBKcBjEV0PBhtPznhvyaZy5ViDruE1yLu7lXa6jCKSQB31e6XQLI1oGo1OlyGmLeAk19mgciNkVC4fwRQeGC4v3HxKdT7D4rm3fZyWeccqzt+EBIxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775679832; c=relaxed/simple;
	bh=6hchUHPBWNltcVqXDOinPWMbWFynq+4Kg5g1kDB7ZJA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SD4BKtaUFIxljvjF8RpFfyWsNHQ9i+afYTm7vtGGnes25MHxMnVZu3tO3Fzv59y2zxmcEuRxdK5C/XqC7hc/4BdziDbRSk4JGSYeRcwDT+CJqFgxFu7PqO0mgYW/9ASHz9zgEerYF5pQBP/uMYOdo7v9uEJmHz2fwgKR93hlsF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 2B71A1B44D4;
	Wed,  8 Apr 2026 20:23:44 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id 5CA702E;
	Wed,  8 Apr 2026 20:23:42 +0000 (UTC)
Date: Wed, 8 Apr 2026 16:24:59 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: abhijithsriram95@gmail.com
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org (open
 list:TRACING), linux-trace-kernel@vger.kernel.org (open list:TRACING)
Subject: Re: [PATCH v4] kernel/trace: fixed static warnings
Message-ID: <20260408162459.6b8f4b01@gandalf.local.home>
In-Reply-To: <20260406072834.243491-2-abhijithsriram95@gmail.com>
References: <20260406072834.243491-2-abhijithsriram95@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5CA702E
X-Stat-Signature: nnz6dpwbeymgbcz6z43rit9ain6mrxn3
X-Rspamd-Server: rspamout03
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19G/5FHFKUhUcofEssekgIdJ5DPAaYzZV8=
X-HE-Tag: 1775679822-120174
X-HE-Meta: U2FsdGVkX18zRVtd3Q/xgBGRYWom4HmaBQSZ2spJCVxSY7wMh7oV16e+S1L4MSnyk2SMQCwOnjgS0G6aI73ZbgUIQBuMKVWZTEBXLm9H/KbufCY4Q8Ux9fQNnbFSiCewnIGEc7hyWJxFJ5jaqbJ6A5Ia1WwyhbtnTgqgjrw7fGIhzH9du5jMWZS0a9q59sySeGQeebPShzWWm56zrufIJ86+P19cx3vkdxM7FmnlKhtcimAaGHv7bA2k/N8zu3g8NlKQ7+gB0mzHp2xvLtwPBu7jrIUjFlOdit14UaRigNtA/1wIkrFX4UJX4V/9oPndQ6V4BuV7MOXOQkfHWCNX/Py0blUYyoZAaW1re4tanZ+kzQ0KyN9FCA==


Subject should be:

 tracing: Fixed static checker warnings

On Mon,  6 Apr 2026 09:28:34 +0200
abhijithsriram95@gmail.com wrote:

> From: Abhijith Sriram <abhijithsriram95@gmail.com>
> 
> The change in the function argument description
> was due to the static code checker script reading
> the word filter back to back
> 

The below changes should be beneath the '---'

> Changes in v2:

The last change should be first. In fact, I only care about the last change
as the previous versions should have the description of what changed.

> - corrected *m = file->private_data to m = file->private_data
> 
> Changes in v3:
> - reverted the changes for struct seq_file *m and
>   added a new empty line instead
> 
> Changes in v4:

That said, this should really be:

 Changes since v3: https://lore.kernel.org/all/20260406060046.223496-2-abhijithsriram95@gmail.com/


> - added a new empty line before char *buf ...
>   previously this line was relocated to avoid the
>   static check warning.
> 
> Signed-off-by: Abhijith Sriram <abhijithsriram95@gmail.com>
> ---
>  kernel/trace/trace_events_trigger.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
> index 655db2e82513..664283bcd9ea 100644
> --- a/kernel/trace/trace_events_trigger.c
> +++ b/kernel/trace/trace_events_trigger.c
> @@ -246,7 +246,7 @@ event_triggers_post_call(struct trace_event_file *file,
>  }
>  EXPORT_SYMBOL_GPL(event_triggers_post_call);
>  
> -#define SHOW_AVAILABLE_TRIGGERS	(void *)(1UL)
> +#define SHOW_AVAILABLE_TRIGGERS	((void *)(1UL))
>  
>  static void *trigger_next(struct seq_file *m, void *t, loff_t *pos)
>  {
> @@ -352,6 +352,7 @@ static int event_trigger_regex_open(struct inode *inode, struct file *file)
>  		ret = seq_open(file, &event_triggers_seq_ops);
>  		if (!ret) {
>  			struct seq_file *m = file->private_data;
> +

This blank line makes the code look worse. Yes, we usually want a blank
line between the variable declarations and the code, but when it comes to
code blocks (not functions) that rule is not as strict.

Get rid of this newline.


>  			m->private = file;
>  		}
>  	}
> @@ -390,6 +391,7 @@ static ssize_t event_trigger_regex_write(struct file *file,
>  {
>  	struct trace_event_file *event_file;
>  	ssize_t ret;
> +
>  	char *buf __free(kfree) = NULL;

The char *buf is a declaration. It no new line is expected before it.

>  
>  	if (!cnt)
> @@ -633,6 +635,7 @@ clear_event_triggers(struct trace_array *tr)
>  
>  	list_for_each_entry(file, &tr->events, list) {
>  		struct event_trigger_data *data, *n;
> +

Again, if it's in a code block, don't change it.

-- Steve

>  		list_for_each_entry_safe(data, n, &file->triggers, list) {
>  			trace_event_trigger_enable_disable(file, 0);
>  			list_del_rcu(&data->list);
> @@ -785,7 +788,7 @@ static void unregister_trigger(char *glob,
>   *   cmd               - the trigger command name
>   *   glob              - the trigger command name optionally prefaced with '!'
>   *   param_and_filter  - text following cmd and ':'
> - *   param             - text following cmd and ':' and stripped of filter
> + *   param             - text following cmd and ':' and filter removed
>   *   filter            - the optional filter text following (and including) 'if'
>   *
>   * To illustrate the use of these components, here are some concrete

