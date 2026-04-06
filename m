Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EE2361DA5;
	Mon,  6 Apr 2026 07:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775459884; cv=none; b=fIdct6B0O+QONj9/UcqZE2KFZhpW8BcDnXi8lzIU6zqcuHbdLjbCj9AskK9jx38YuUadIhFT/C0XMXOxpvxH227G+Pyp9Yl77TLH4GQoMxKt0tyTa4h71deWpIZmyMTYqqElRK+LlWrwJcUG6MeI1rqbzEGxjy5QFeppt2OVryM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775459884; c=relaxed/simple;
	bh=PoPMwQRyvHTBmc6cVyuohPk1DulnBp9Sz+W4FtxhSJg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ij7XK+Y3xfItskqlaWMcT4dtX/086c/YwEGIOSjk7NS1Bv8VJrM6yRIDRSnVajxIzrKxx9GBg8K9oaogFMro09BiTKoXiteeZAfoimw4EUaw7V6CAwgLP5TUzR0YyZW/xST9QFdai+yV5AvofQ+mBySb3ImG1bBoMhYAsJoVUD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ery4pkzc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ery4pkzc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7BBEC2BC9E;
	Mon,  6 Apr 2026 07:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775459883;
	bh=PoPMwQRyvHTBmc6cVyuohPk1DulnBp9Sz+W4FtxhSJg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ery4pkzc9DgwGNDoP/Iax1jzWZ6I7XYCeVKi/HGsDYBhVnxDRnWj2uHXMdsC2gGsC
	 +/d6XFEOCYBOvuLB/JHZAmP6gRpxmC1sVxuGLlf93dA1sLb5cdRwFNLSHjM0fiV6gV
	 64UbSSL0GXMuGJNe+1DWrUoTKYxX9Kzh70mLLFpPOb/WYzLO/6phMdXepJ4MVBszJ/
	 65TF33BFOEGCuS8zqrEhU0hPGWH2P55vqO/N9tmQRM/6PbKZwuv3fqfhM/TZbxn7Fo
	 bsfB9esQ5RcmuEYOcVarsQ83KzwvE+e1mbXY9Ie9DOrkFqZgSIHIvZK7JE7nShUzEp
	 IgwPxqdDdAmyg==
Date: Mon, 6 Apr 2026 16:18:01 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: abhijithsriram95@gmail.com
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org (open list),
 linux-trace-kernel@vger.kernel.org (open list:TRACING)
Subject: Re: [PATCH v3] kernel/trace: fixed static warnings
Message-Id: <20260406161801.d507eeb247eb8b3b17f490a8@kernel.org>
In-Reply-To: <20260406060046.223496-2-abhijithsriram95@gmail.com>
References: <20260406060046.223496-2-abhijithsriram95@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  6 Apr 2026 08:00:36 +0200
abhijithsriram95@gmail.com wrote:

> From: Abhijith Sriram <abhijithsriram95@gmail.com>
> 
> The change in the function argument description
> was due to the static code checker script reading
> the word filter back to back
> 
> Changes in v2:
> - corrected *m = file->private_data to m = file->private_data
> 
> Changes in v3:
> - reverted the changes for struct seq_file *m and
>   added a new empty line instead
> 
> Signed-off-by: Abhijith Sriram <abhijithsriram95@gmail.com>
> ---
>  kernel/trace/trace_events_trigger.c | 8 +++++---
>  new-changes                         | 6 ++++++
>  2 files changed, 11 insertions(+), 3 deletions(-)
>  create mode 100644 new-changes
> 
> diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
> index 655db2e82513..08adb593fcd9 100644
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
>  			m->private = file;
>  		}
>  	}
> @@ -388,9 +389,9 @@ static ssize_t event_trigger_regex_write(struct file *file,
>  					 const char __user *ubuf,
>  					 size_t cnt, loff_t *ppos)
>  {
> +	char *buf __free(kfree) = NULL;
>  	struct trace_event_file *event_file;
>  	ssize_t ret;
> -	char *buf __free(kfree) = NULL;

Again, this is not OK. Even if checkpatch.pl complained against this,
there should be no problem. Only if you think this is not sorted by
length, you can do:

 	struct trace_event_file *event_file;
+	char *buf __free(kfree) = NULL;
 	ssize_t ret;
-	char *buf __free(kfree) = NULL;

This change is acceptable as a cosmetic change.

>  
>  	if (!cnt)
>  		return 0;
> @@ -633,6 +634,7 @@ clear_event_triggers(struct trace_array *tr)
>  
>  	list_for_each_entry(file, &tr->events, list) {
>  		struct event_trigger_data *data, *n;
> +
>  		list_for_each_entry_safe(data, n, &file->triggers, list) {
>  			trace_event_trigger_enable_disable(file, 0);
>  			list_del_rcu(&data->list);
> @@ -785,7 +787,7 @@ static void unregister_trigger(char *glob,
>   *   cmd               - the trigger command name
>   *   glob              - the trigger command name optionally prefaced with '!'
>   *   param_and_filter  - text following cmd and ':'
> - *   param             - text following cmd and ':' and stripped of filter
> + *   param             - text following cmd and ':' and filter removed
>   *   filter            - the optional filter text following (and including) 'if'
>   *
>   * To illustrate the use of these components, here are some concrete
> diff --git a/new-changes b/new-changes
> new file mode 100644
> index 000000000000..9e3a24de3033
> --- /dev/null
> +++ b/new-changes
> @@ -0,0 +1,6 @@
> +Line 25 -> adding const to the pointer address as well.
> +
> +linw 1193 -> removing else because there is a return statement in the if condition
> +line 1727 -> adding new line after statement
> +line 1800 -> reordering to solve missing a blank line warning
> +line 12364 -> changed the function to kstrtoul
> \ No newline at end of file

Is this your working note?
Please remove it.

Thank you,

> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
