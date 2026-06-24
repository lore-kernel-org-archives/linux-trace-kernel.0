Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7F02C032E;
	Wed, 24 Jun 2026 05:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782277390; cv=none; b=dzU89mXiqz0H7VOcwio9gd/5RQB36ad3VVnXpJsZIDWQrszVILSqDac5O6cSuDZkghAfM9lRfJ5c5ZJOpGXxysk0BX6JCYzPFOg2Ud29oCnsWmbi18w8hx0KA8K5e8VXsNCP2OfXQHcwbWc0s+9fMaNNxBauQyJFc/i5GITdoQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782277390; c=relaxed/simple;
	bh=R+429pqsrrwtoJ7O+R+xci3ETjFCL+XKHwd1gisU358=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=XhgeEcH1uqnDCS+hg4TnoXt0ds2Tp4qANkkBDqyWrJ+md0T1wbMMm1hAzwr9OBmtZi1tXZxyOnHikD+/YPMwemyPRLP+Rtwuz9K/BsvuSUNyIjcjnC6PpzcERXNAZ0UQmGNhRNEjoimEMwAlYSLIBbrWztKpY/eGO0/htuPquGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QoAPTeFS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QoAPTeFS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4240F1F000E9;
	Wed, 24 Jun 2026 05:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782277388;
	bh=etJNdBG9SqZBVpsZZzBAhAVFoG3Scky9EQ1NQqsVgKY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QoAPTeFSy04CNMgmiYffzBaHsAkyx9wchogQN4XaR9KxO6voTqDtwFwvbhkScuT58
	 I6XjKwoCHQJo9OAmdQBsjJuHt2/o//O+nMQo9mxniKB7ko+QLmC9wlk2KWvV2O9vgv
	 mwDfiWyTnriaYpPpJyrAxmyB8JQqr0wFLvSjdwfIU6P449r0JERLXDMowAnliJKBJo
	 EjQycuTVukK2xT15/lNc5UQ+lwom3dswCv2uDq04xEG2cNcgwBHtS9zRg5z0NS7NWS
	 505P2rZ7KvumA7sQWkJJSXXtmSwt2OG/66Wp+7O7gSE9wWT95x/ZUj6N4TB3RB3uRt
	 LJwUjaq4FjOsQ==
Date: Wed, 24 Jun 2026 14:03:05 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Woradorn Laodhanadhaworn <woradorn.laon@gmail.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev, shuah@kernel.org,
 skhan@linuxfoundation.org, me@brighamcampbell.com, jkoolstra@xs4all.nl
Subject: Re: [PATCH v3] tracing: Use seq_buf for string concatenation
Message-Id: <20260624140305.3827bbb32f84c62dd9f09222@kernel.org>
In-Reply-To: <20260623145147.12145-1-woradorn.laon@gmail.com>
References: <20260623145147.12145-1-woradorn.laon@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Jun 2026 21:51:47 +0700
Woradorn Laodhanadhaworn <woradorn.laon@gmail.com> wrote:

> In preparation for removing the strlcat API[1],
> replace the string concatenation logic with a struct seq_buf,
> which tracks the current position and the remaining space internally.
> 
> Use seq_buf_str() to NUL-terminate before passing to early_enable_events().
> 
> Link: https://github.com/KSPP/linux/issues/370 [1]
> 

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> Signed-off-by: Woradorn Laodhanadhaworn <woradorn.laon@gmail.com>
> ---
> v1 -> v2: 
> 	- Fixed WARN_ON when booting with empty trace_event.
> v2 -> v3: 
> 	- Addressed Sashiko's concern about the compound literal backing buffer.
> 	- Replaced the compund literal with an explicit declared buffer and pointed
> 	seq_buf.buffer to it. This guarantees the backing storage is placed in 
> 	`.init.data` and reclaimed after boot.
> 
> v1: https://lore.kernel.org/all/20260620175441.223342-1-woradorn.laon@gmail.com
> v2: https://lore.kernel.org/all/20260622094623.18469-1-woradorn.laon@gmail.com
> Sashiko: https://sashiko.dev/#/patchset/20260622094623.18469-1-woradorn.laon%40gmail.com
> 
>  kernel/trace/trace_events.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index c46e623e7e0d..5ab630155ab6 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -22,6 +22,7 @@
>  #include <linux/sort.h>
>  #include <linux/slab.h>
>  #include <linux/delay.h>
> +#include <linux/seq_buf.h>
>  
>  #include <trace/events/sched.h>
>  #include <trace/syscall.h>
> @@ -4501,13 +4502,20 @@ extern struct trace_event_call *__start_ftrace_events[];
>  extern struct trace_event_call *__stop_ftrace_events[];
>  
>  static char bootup_event_buf[COMMAND_LINE_SIZE] __initdata;
> +static struct seq_buf bootup_event_seq __initdata = {
> +	.buffer = bootup_event_buf,
> +	.size = COMMAND_LINE_SIZE,
> +};
>  
>  static __init int setup_trace_event(char *str)
>  {
> -	if (bootup_event_buf[0] != '\0')
> -		strlcat(bootup_event_buf, ",", COMMAND_LINE_SIZE);
> +	if (seq_buf_used(&bootup_event_seq) > 0)
> +		seq_buf_puts(&bootup_event_seq, ",");
> +
> +	seq_buf_puts(&bootup_event_seq, str);
>  
> -	strlcat(bootup_event_buf, str, COMMAND_LINE_SIZE);
> +	if (seq_buf_has_overflowed(&bootup_event_seq))
> +		return -ENOMEM;
>  
>  	trace_set_ring_buffer_expanded(NULL);
>  	disable_tracing_selftest("running event tracing");
> @@ -4766,7 +4774,7 @@ static __init int event_trace_enable(void)
>  	 */
>  	__trace_early_add_events(tr);
>  
> -	early_enable_events(tr, bootup_event_buf, false);
> +	early_enable_events(tr, (char *)seq_buf_str(&bootup_event_seq), false);
>  
>  	trace_printk_start_comm();
>  
> @@ -4794,7 +4802,7 @@ static __init int event_trace_enable_again(void)
>  	if (!tr)
>  		return -ENODEV;
>  
> -	early_enable_events(tr, bootup_event_buf, true);
> +	early_enable_events(tr, (char *)seq_buf_str(&bootup_event_seq), true);
>  
>  	return 0;
>  }
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
