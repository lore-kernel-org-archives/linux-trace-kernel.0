Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2AE31A571;
	Thu,  8 Jan 2026 23:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767916420; cv=none; b=sGEFdLSoRhoBklnF6IVKcTLVpZlO5DFqASfLM9cLXiBxXeBXZgOwCIRbMX+JDppqPuiRWmKwhlRSt8Ql9gJGd7rpTrToGOZZelRHouir7/WzEoZlPlcxQgMBNUZACwfPE/MKKLDS+u9kDr+WDTTv6ZvWMuSdnilrIP2HrbX1pHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767916420; c=relaxed/simple;
	bh=tSMqM944aeT3qF/Uo49fQKvMJhC9hrcOrjpKlK23pQ4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=HogbCEuck3u8zJ7bJYI08q9Zwywrja+uXD188peHKrH7Sqz3+X8bi49zTmiaE4yTCJi53rWeR+HHQxuGPfq0maUko3s/A/5KoTa6DwEVJgjmu+GZRBulHMmovuYSII/9YLMhP3nwqbVWSck8Dqi9XZApbxj+nbmaZMAlADNEvko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4q5c2Gp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4q5c2Gp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9FC9C19422;
	Thu,  8 Jan 2026 23:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767916420;
	bh=tSMqM944aeT3qF/Uo49fQKvMJhC9hrcOrjpKlK23pQ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H4q5c2GpWFTwusZNYhZTz5rDrJ+mZ+fmZcU1KBT7fh0zQSaJ1ulStl3JwyR8npl2O
	 tDu8SLecyXvziWPQWvJBzj1s0ews90aaQq34uC4Xj/T0dtACgMSuSz+/+KO2LKHnSE
	 3Of1Dk9UzUtSHE5vsLoCcfWjO+qLgo/3xv2QVQY3RMU7lPXeZiTPRGVxM77WBXYWQ2
	 Maovxz8Luioycgn73s/PHUbC/TBTKPMCFTri8o6spZO+MnJ71sCvbewm3+VUWQgQzH
	 y0rIA+1Fw3BQdQZ0H/vLaH297B/saqFtw//cXTVeOFBxvigjGUcMGtwRNzR7dyemRm
	 fJCY3U5PsxX4w==
Date: Fri, 9 Jan 2026 08:53:36 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Miaoqian Lin <linmq006@gmail.com>
Subject: Re: [PATCH] tracing: Remove redundant call to
 event_trigger_reset_filter() in event_hist_trigger_parse()
Message-Id: <20260109085336.6b3819d734cd96dc9e73be83@kernel.org>
In-Reply-To: <20260108174429.2d9ca51f@gandalf.local.home>
References: <20260108174429.2d9ca51f@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 8 Jan 2026 17:44:29 -0500
Steven Rostedt <rostedt@kernel.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> With the change to replace kfree() with trigger_data_free(), which starts
> out doing the exact same thing as event_trigger_reset_filter(), there's no
> reason to call event_trigger_reset_filter() before calling
> trigger_data_free(). Remove the call to it.
> 
> Link: https://lore.kernel.org/linux-trace-kernel/20251211204520.0f3ba6d1@fedora/
> 

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace_events_hist.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index f9886fff7123..4a7f945e368d 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -6898,8 +6898,6 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
>   out_unreg:
>  	event_trigger_unregister(cmd_ops, file, glob+1, trigger_data);
>   out_free:
> -	event_trigger_reset_filter(cmd_ops, trigger_data);
> -
>  	remove_hist_vars(hist_data);
>  
>  	trigger_data_free(trigger_data);
> -- 
> 2.51.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
