Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFC21494A6;
	Fri,  4 Apr 2025 18:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743790744; cv=none; b=KAnXdQMCYrQyvrfL+K9QOQA24B6SRhLKnH3cqdjhxuF1xcuY+6EHcuZYZY3Q6KTf7aDBG330HDNtvW1KfJqLDYG+/ObikAEDT+2EXIjDprV1i2MyPsBx8JCiZL+9w8z0JMrrAB3XGJ3s1tStzizofU5NCHEhOJTvAdhVkI+4u0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743790744; c=relaxed/simple;
	bh=fQ1ojn52AM70H1Vacbctyym8O6FScLm48lKuOs8h9FU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KdN1Ss4Fl5YePLAa+UGAzD8BA8W5cW2HwjPbcBaOEqo0o7rqHk6lHcVxiMrAvx70GffEgJ6IKmu7H8SXu1dQCZUONZfE57AFOok1Loj4HVGeNR5GPog/aaadkMV9MJHSrmtUPcuR9+2mXzdI4ziss22KrxQx+UEjCt8porzqp8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD61FC4CEDD;
	Fri,  4 Apr 2025 18:19:02 +0000 (UTC)
Date: Fri, 4 Apr 2025 14:20:10 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Devaansh Kumar <devaanshk840@gmail.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v3] tracing: Replace deprecated strncpy() with strscpy()
 for stack_trace_filter_buf
Message-ID: <20250404142010.4af17918@gandalf.local.home>
In-Reply-To: <20250404135850.2695211-1-devaanshk840@gmail.com>
References: <20250404135850.2695211-1-devaanshk840@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  4 Apr 2025 19:28:48 +0530
Devaansh Kumar <devaanshk840@gmail.com> wrote:

> --- a/kernel/trace/trace_stack.c
> +++ b/kernel/trace/trace_stack.c
> @@ -543,8 +543,10 @@ static __init int enable_stacktrace(char *str)
>  {
>  	int len;
>  
> -	if ((len = str_has_prefix(str, "_filter=")))
> -		strncpy(stack_trace_filter_buf, str + len, COMMAND_LINE_SIZE);
> +	len = str_has_prefix(str, "_filter=");
> +
> +	if (len)
> +		strscpy(stack_trace_filter_buf, str + len, sizeof(stack_trace_filter_buf));
>  
>  	stack_tracer_enabled = 1;
>  	return 1;

BTW, why separate out the len? I use this notation quite a bit for
str_has_prefix() checks.

$ git grep '(len = str_has_pref' kernel/trace
kernel/trace/trace_events.c:    if (!(len = str_has_prefix(fmt, "REC->")))
kernel/trace/trace_events_filter.c:     if ((len = str_has_prefix(str + i, ".ustring"))) {
kernel/trace/trace_events_filter.c:     if ((len = str_has_prefix(str + i, ".function"))) {
kernel/trace/trace_events_hist.c:       if ((len = str_has_prefix(str, "key=")) ||
kernel/trace/trace_events_hist.c:           (len = str_has_prefix(str, "keys="))) {
kernel/trace/trace_events_hist.c:       } else if ((len = str_has_prefix(str, "val=")) ||
kernel/trace/trace_events_hist.c:                  (len = str_has_prefix(str, "vals=")) ||
kernel/trace/trace_events_hist.c:                  (len = str_has_prefix(str, "values="))) {
kernel/trace/trace_events_hist.c:       } else if ((len = str_has_prefix(str, "sort="))) {
kernel/trace/trace_events_hist.c:       } else if ((len = str_has_prefix(str, "clock="))) {
kernel/trace/trace_events_hist.c:       } else if ((len = str_has_prefix(str, "size="))) {
kernel/trace/trace_events_hist.c:               if ((len = str_has_prefix(str, "onmatch(")))
kernel/trace/trace_events_hist.c:               else if ((len = str_has_prefix(str, "onmax(")))
kernel/trace/trace_events_hist.c:               else if ((len = str_has_prefix(str, "onchange(")))
kernel/trace/trace_stack.c:     if ((len = str_has_prefix(str, "_filter=")))

It's fine being in the if statement as the if is more about "does this have
this prefix" and the length is just a side effect of it to use it to
extract the rest.

This patch is only about removing strncpy(), it doesn't need to modify the
format.

-- Steve
