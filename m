Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400672797AD;
	Tue,  5 Aug 2025 15:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754407124; cv=none; b=ldmJ8yJTR+Fj8VXziHmUkoXIaXE2FrDHNcl+1fNRvq8cvamUSp0f493n4xUZ9/h8f/D2rWxdceSGjAR8HnlEoVVchBfpU377rhGmU8lso0LScS6tsTuiMJqCIKAIhtl+k4EivW9lcecLZJwLY16eK2DjJsTPmQ1w+SQO9870wcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754407124; c=relaxed/simple;
	bh=pDE7fSiYl1/mCF0GA3dI0d52Bsae8iJN6UgVNKXIgOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OLZDB8QuOSgleGsqxxEZuZix4Ir7xyIMqoQ3Rsg3HBEfvtyZA3h6jjzkkAM2pJd79uV9oCoZutyWEVXtQ2+lmcoQDwNhnI0hGnhE4LjpkhCbOdQfDwBbCJ1uUU01mnzVLX8uSKCtrKhiiUY9ScTl4agoieIsSec4A/laAbZDIq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 350D5B624B;
	Tue,  5 Aug 2025 15:18:35 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id 7E7C11D;
	Tue,  5 Aug 2025 15:18:33 +0000 (UTC)
Date: Tue, 5 Aug 2025 11:19:03 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Zero-initialize parser->buffer to avoid OOB
 access
Message-ID: <20250805111903.3114427b@gandalf.local.home>
In-Reply-To: <20250805151203.1214790-1-pulehui@huaweicloud.com>
References: <20250805151203.1214790-1-pulehui@huaweicloud.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 7E7C11D
X-Stat-Signature: 7rneqf3fhmfy5sxdiymbicjajfu4drht
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18uIjbFd+mgPW3433ZyClr4cyagnhZhg6I=
X-HE-Tag: 1754407113-973937
X-HE-Meta: U2FsdGVkX1/y73NjOqs/z96wfe/BAl/izjehKV0AATZ18Wy+3fkitZKLmNscbyGNYcV+X+HoQ1MIY6mkmuWM27/w+4azIbWP/nAu8N5rFQz50Z1mn4W54H+7+VGPsDxGkmvXRbIgZd9wUPqbwpa5EDbAOUO1IwrXnYphnQWZYHwHlCEn9wp6ylFmujCTpn5r5EQXUq7aQY7SvxVlmQECB6pOa/JfNN1nimqIfgOrZsAd8ybG3ikIOVYw1PrUaSwJw3yQ8UcTDh7Gjt0oX9YkNAtK1q+aOS1WvvqOrqXizqFU69R1qnvATRIbbX5SiZM8uM9K4StGh57ZvzJ/fjwKVxezy7JluLOVBIBJP2kAxaDThYWUi82BYg==

On Tue,  5 Aug 2025 15:12:03 +0000
Pu Lehui <pulehui@huaweicloud.com> wrote:

> From: Pu Lehui <pulehui@huawei.com>
> 
> When the length of the string written to set_ftrace_filter exceeds
> FTRACE_BUFF_MAX, the following KASAN alarm will be triggered:
> 
> BUG: KASAN: slab-out-of-bounds in strsep+0x18c/0x1b0
> Read of size 1 at addr ffff0000d00bd5ba by task ash/165
> 
> CPU: 1 UID: 0 PID: 165 Comm: ash Not tainted 6.16.0-g6bcdbd62bd56-dirty #3 NONE
> Hardware name: linux,dummy-virt (DT)
> Call trace:
>  show_stack+0x34/0x50 (C)
>  dump_stack_lvl+0xa0/0x158
>  print_address_description.constprop.0+0x88/0x398
>  print_report+0xb0/0x280
>  kasan_report+0xa4/0xf0
>  __asan_report_load1_noabort+0x20/0x30
>  strsep+0x18c/0x1b0
>  ftrace_process_regex.isra.0+0x100/0x2d8
>  ftrace_regex_release+0x484/0x618
>  __fput+0x364/0xa58
>  ____fput+0x28/0x40
>  task_work_run+0x154/0x278
>  do_notify_resume+0x1f0/0x220
>  el0_svc+0xec/0xf0
>  el0t_64_sync_handler+0xa0/0xe8
>  el0t_64_sync+0x1ac/0x1b0
> 
> The reason is that trace_get_user will fail when processing a string
> longer than FTRACE_BUFF_MAX, but not set the end of parser->buffer
> to 0. Then an oob access will be triggered in ftrace_regex_release->
> ftrace_process_regex->strsep->strpbrk. We can solve this problem by
> zero-initializing parser->buffer.
> 
> Fixes: 8c9af478c06b ("ftrace: Handle commands when closing set_ftrace_filter file")

Fix one bug then create another!!!

> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> ---
>  kernel/trace/trace.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 4283ed4e8f59..97e66cbd3617 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -1776,7 +1776,7 @@ int trace_parser_get_init(struct trace_parser *parser, int size)
>  {
>  	memset(parser, 0, sizeof(*parser));
>  
> -	parser->buffer = kmalloc(size, GFP_KERNEL);
> +	parser->buffer = kzalloc(size, GFP_KERNEL);
>  	if (!parser->buffer)
>  		return 1;
>  
> @@ -1860,13 +1860,10 @@ int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
>  
>  	/* We either got finished input or we have to wait for another call. */
>  	if (isspace(ch) || !ch) {
> -		parser->buffer[parser->idx] = 0;
>  		parser->cont = false;
>  	} else if (parser->idx < parser->size - 1) {
>  		parser->cont = true;
>  		parser->buffer[parser->idx++] = ch;
> -		/* Make sure the parsed string always terminates with '\0'. */
> -		parser->buffer[parser->idx] = 0;

The returned buffer is expected to end with a '0'. This now removes that if
the idx is the length of the parser.

>  	} else {
>  		return -EINVAL;
>  	}

The real fix would be:

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index d0b1964648c1..422224a55f1d 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -815,7 +815,7 @@ int trace_pid_write(struct trace_pid_list *filtered_pids,
 	loff_t pos;
 	pid_t pid;
 
-	if (trace_parser_get_init(&parser, PID_BUF_SIZE + 1))
+	if (trace_parser_get_init(&parser, PID_BUF_SIZE))
 		return -ENOMEM;
 
 	/*
@@ -1776,7 +1776,7 @@ int trace_parser_get_init(struct trace_parser *parser, int size)
 {
 	memset(parser, 0, sizeof(*parser));
 
-	parser->buffer = kmalloc(size, GFP_KERNEL);
+	parser->buffer = kmalloc(size + 1, GFP_KERNEL);
 	if (!parser->buffer)
 		return 1;
 
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 05447b958a1a..a3ce88a48947 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1507,7 +1507,7 @@ ftrace_event_write(struct file *file, const char __user *ubuf,
 	if (ret < 0)
 		return ret;
 
-	if (trace_parser_get_init(&parser, EVENT_BUF_SIZE + 1))
+	if (trace_parser_get_init(&parser, EVENT_BUF_SIZE))
 		return -ENOMEM;
 
 	read = trace_get_user(&parser, ubuf, cnt, ppos);

-- Steve
