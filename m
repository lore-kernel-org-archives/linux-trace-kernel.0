Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415983CD8CA;
	Thu,  5 Mar 2026 16:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772728981; cv=none; b=crLHAPrNXCUG+wSQ7X5tUV0OtuRi4HFWQRf8PmboGgk+ETnMXueSmXILl7HoOtF/A9OezrnpM54f4GNmwvlLQsU1XKPGwvbV0ZhMmAd6ZmuFKa2hi4xnNs62kR303/Si8f612YsgRDN5BMmthqi1XDRsY130mCBvxR3kiWk3lnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772728981; c=relaxed/simple;
	bh=tQ79inxwyG9CT6W+N61KZ5CtYJK1Zvi8x4of16Z4mVY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O8ty90lD72gVpnlr27mLV6s4LtpdHqe7PeT1MkOlOtQX8fz9WXG9lbq/qR4RkicW1HV80xihWe5xQspJ7UOwX8HI+PqNaLyI2pWmHRWZxYTBSBvqQwXq9UjSpxAW5DaeV7hW2mE5V3PiCM72/VLL0dGcnydSy+t1/ZGivIntemk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id EFAD2C03FE;
	Thu,  5 Mar 2026 16:42:58 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id 2655D1A;
	Thu,  5 Mar 2026 16:42:57 +0000 (UTC)
Date: Thu, 5 Mar 2026 11:43:36 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Miaoqian Lin <linmq006@gmail.com>
Subject: Re: [PATCH] tracing: Do not call trigger_data_free with NULL data
 pointer
Message-ID: <20260305114336.0f2710eb@gandalf.local.home>
In-Reply-To: <20260305163633.2782210-1-linux@roeck-us.net>
References: <20260305163633.2782210-1-linux@roeck-us.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: jyde5h8ssqc1jny7qxcc4aqrtnpk9ohx
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 2655D1A
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19IjZlU+XJmbuMRPbtbBCUlEtQL4e6Gens=
X-HE-Tag: 1772728977-317649
X-HE-Meta: U2FsdGVkX1+/MowH5GFMx5mXKlsrTHeIUuu2drHDukFNYfH2z3xi2ugSUAzZ9FF9aP2QBEnCZLi3NuUWRgsn/PY6YRSs173mql6TL930WxrLfgIspzvGlIuycYRclLf4C4SwqwjIREbD8FcR9SGK3Q2zr/BKuYDIYXW8PQEG4pLEgKtI8jqHY1/Zsvj1C38sgHKKZ4uDhksPgFzL7tWKyShDjuYXNOIkPC1zA02VVoLX0RwZkS/m3yrxm/sc0beJgQbgWkwsqjPL0I573pVrzoER56i07E5caXZYsV5Eukv3T+VzVVrb3I+Lzg+FJISsBTrymGcEEnWlGdGnXFjrEH79X4E6YSd3sho786hoqqcsaBHWEFZDfnpIH9yjBf+l9GDdS2IXkWZWvxzLm+/HAL3t2hfMru965ge0mTuIgBYpAUn/4rkOT3Z8UAeOYfipyQ9rj8C6D8al1vzg8WqdXg==

On Thu,  5 Mar 2026 08:36:33 -0800
Guenter Roeck <linux@roeck-us.net> wrote:

> If trigger_data_alloc() fails and returns NULL, event_hist_trigger_parse()
> jumps to the out_free error path. While kfree() safely handles a NULL
> pointer, trigger_data_free() does not. This causes a NULL pointer
> dereference in trigger_data_free() when evaluating
> data->cmd_ops->set_filter.
> 
> Fix the problem by adding a new goto label and jumping to it if
> trigger_data_alloc() returns NULL.
> 
> The problem was found by an experimental code review agent based on
> gemini-3.1-pro while reviewing backports into v6.18.y.
> 
> Assisted-by: Gemini:gemini-3.1-pro
> Cc: Miaoqian Lin <linmq006@gmail.com>
> Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
> Fixes: 0550069cc25f ("tracing: Properly process error handling in event_hist_trigger_parse()")
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  kernel/trace/trace_events_hist.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 73ea180cad55..a2abdfe19281 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -6874,7 +6874,7 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
>  	trigger_data = trigger_data_alloc(cmd_ops, cmd, param, hist_data);
>  	if (!trigger_data) {
>  		ret = -ENOMEM;
> -		goto out_free;
> +		goto out_destroy;
>  	}
>  
>  	ret = event_trigger_set_filter(cmd_ops, file, filter, trigger_data);
> @@ -6942,7 +6942,7 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
>  	remove_hist_vars(hist_data);
>  
>  	trigger_data_free(trigger_data);

I rather make trigger_data_free() more robust by starting it with:

	if (!data)
		return;

-- Steve

> -
> +out_destroy:
>  	destroy_hist_data(hist_data);
>  	goto out;
>  }

