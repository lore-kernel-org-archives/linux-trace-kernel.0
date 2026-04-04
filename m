Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B5D3A1CD;
	Sat,  4 Apr 2026 00:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775261896; cv=none; b=N4ej0ayuIi9EmzVPozyIx5PjJ+eTX1e+4dMRdy8gYa37Kh270W3Xs0IKltehW6K9q88TSI+HzBYixM57HQb8o0gDf6LmPzyBrDawB21u7ap7c+Z4GRHz+Y2mZSfFY7sYn+BQHdnuM91blBpcLg0k2CDcoRM/dRf7VPnydkxxfZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775261896; c=relaxed/simple;
	bh=OUdk6/KYGiJSQ4Bp5xqyGgBh96STibS3cXwgpm6N0cE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Mbqq86wUdMFn5OMcsdYV6TbIi/jX7yYM4dT5wlcHYCXfGljL1mCusDodRfMbLUBbUn6JXbeG2IizsGBllWqoQRyi4C7jYz+l+1mA5iXxOhuCLxBn+vmGuaoImNwjgZYZwqhV+ievwlqbsbHuMIdfBtuYNX0X1GuVypev5ZiMbBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bzkm+i/6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bzkm+i/6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2543AC4CEF7;
	Sat,  4 Apr 2026 00:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775261895;
	bh=OUdk6/KYGiJSQ4Bp5xqyGgBh96STibS3cXwgpm6N0cE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Bzkm+i/6WyyeQyiyjvyg9OHz7+Ck2DyNrhA/KWjmrQrFInZs0ldDNw832dsW61JHB
	 79mSTxFojbdOyrZ72iC/ADdJkyNJUu+Q5qNOUDwToIl4XKxeHsqSPe96APlgpuXTIX
	 j7X0yf7JIpe9SlY+t5qO2+HaSUzn1dIBp4+DObAn8bdhlPeTKg+sVXbZw7DVaASuwq
	 nHqQSQjIwSJ7YbvYbFysVcjwp2DlmEFoVQ4VV6OdjfoQDvGfDHDOUNyUDdCFVIZ1qo
	 zEFq2RGLCZ++9wTR6xzMWp53P46gV91e3sUuBtLzHTTGX032JpP7pjuOyi0eU9hGrk
	 i0K9v0X2qMheg==
Date: Sat, 4 Apr 2026 09:18:06 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: abhijithsriram95@gmail.com
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org (open
 list:TRACING), linux-trace-kernel@vger.kernel.org (open list:TRACING)
Subject: Re: [PATCH] kernel/trace: fixed static warnings
Message-Id: <20260404091806.4e1cf73d2775d128f1dc5277@kernel.org>
In-Reply-To: <20260402195405.21316-1-abhijithsriram95@gmail.com>
References: <20260402195405.21316-1-abhijithsriram95@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  2 Apr 2026 21:54:04 +0200
abhijithsriram95@gmail.com wrote:

> From: Abhijith Sriram <abhijithsriram95@gmail.com>
> 
> The change in the function argument description
> was due to the static code checker script reading
> the word filter back to back
> 
> Signed-off-by: Abhijith Sriram <abhijithsriram95@gmail.com>
> ---
>  kernel/trace/trace_events_trigger.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
> index 655db2e82513..477d8dee3362 100644
> --- a/kernel/trace/trace_events_trigger.c
> +++ b/kernel/trace/trace_events_trigger.c
> @@ -246,7 +246,7 @@ event_triggers_post_call(struct trace_event_file *file,
>  }
>  EXPORT_SYMBOL_GPL(event_triggers_post_call);
>  
> -#define SHOW_AVAILABLE_TRIGGERS	(void *)(1UL)
> +#define SHOW_AVAILABLE_TRIGGERS	((void *)(1UL))

This is OK.

>  
>  static void *trigger_next(struct seq_file *m, void *t, loff_t *pos)
>  {
> @@ -325,6 +325,7 @@ static const struct seq_operations event_triggers_seq_ops = {
>  static int event_trigger_regex_open(struct inode *inode, struct file *file)
>  {
>  	int ret;
> +	struct seq_file *m = NULL;
>  
>  	ret = security_locked_down(LOCKDOWN_TRACEFS);
>  	if (ret)
> @@ -351,7 +352,7 @@ static int event_trigger_regex_open(struct inode *inode, struct file *file)
>  	if (file->f_mode & FMODE_READ) {
>  		ret = seq_open(file, &event_triggers_seq_ops);
>  		if (!ret) {
> -			struct seq_file *m = file->private_data;
> +			*m = file->private_data;

Why is this change required?

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

What is this change?

Thanks,

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
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
