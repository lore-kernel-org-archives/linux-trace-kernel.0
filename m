Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B5A1531C1;
	Wed, 28 Jan 2026 02:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769569186; cv=none; b=PU5OenNAd4bBaunEQv5vAlQSvTBoePwkAcmS8aejKnl/q4nIEfdR8H8DFXr+6rRdEyXiNdCjW9YLsg2w9QKwMhuhuqWA9HORAtBnx4UrX67EUoju3WG2Br2vvFr5oE19zjCbaMySXzn+bPqU6TsTm44Xu2crdKTrSgF0bvcO7II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769569186; c=relaxed/simple;
	bh=kDSv7xVE9FycSipUh7Uvx7IAebNnWsGpAEIwjjyV2Mg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=gvGeEeTTYLgY8Xy5q8XLxDhd25EW/OTWmWEXB/yOai5skrdYOEYahgWRXd358xPIgIj6gA0Y53gI8USn1KdF0k/ZTDhkTMG3NSk/aCgsiPwFMyK6AVc47KGkgq6Wns+aXS/bHtnhLUK+kHV12SndZeeMrI9voZlu1LZGJXg3riE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=noVevVAH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="noVevVAH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 511DEC116D0;
	Wed, 28 Jan 2026 02:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769569186;
	bh=kDSv7xVE9FycSipUh7Uvx7IAebNnWsGpAEIwjjyV2Mg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=noVevVAHG7hjHqislbPkGxScpwNOih1hS6Fi23gY1sju3SFE8JksSq5hC/il3Tq+P
	 FUHe6CYiUpXL2tuMlixL5AUHvlD2k7OILiuZ6CTk4X4ONTCxGnIApPQZ0/RapBDEyH
	 EYqLflB79hSDSwp+BrVHyHpDUVp7XQ2CY6gaYLNHhn70iQLaoxuhdu6g96RGuU4Dey
	 5KYzotvnh0NrL8oE/HPpXzwtf1IrNXnfdkUGO7stzgVJOP3h0ZFLMazs1hcfhV/E1N
	 qJ2nVixemtxEdjBaIkcxsAWlwnVKCI07r3MQKGR3yIiLUr1qGLapqJ5RpMLANTr1aX
	 axPFozLu+HFBw==
Date: Wed, 28 Jan 2026 11:59:43 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: sunliming@linux.dev
Cc: rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, sunliming
 <sunliming@kylinos.cn>
Subject: Re: [PATCH v2] tracing: kprobe-event: Return directly when trace
 kprobes is empty
Message-Id: <20260128115943.a752b539ba787c726bbabdfb@kernel.org>
In-Reply-To: <20260127053848.108473-1-sunliming@linux.dev>
References: <20260127053848.108473-1-sunliming@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Jan 2026 13:38:48 +0800
sunliming@linux.dev wrote:

> From: sunliming <sunliming@kylinos.cn>
> 
> In enable_boot_kprobe_events(), it returns directly when trace kprobes is
> empty, thereby reducing the function's execution time. This function may
> otherwise wait for the event_mutex lock for tens of milliseconds on certain
> machines, which is unnecessary when trace kprobes is empty.
> 
> Signed-off-by: sunliming <sunliming@kylinos.cn>

Looks good to me. Let me pick it.

Thanks, 


> ---
> v2:
> - wrap the the null check for the dyn_event_list with macro trace_kprobe_list_empty
> ---
>  kernel/trace/trace_kprobe.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index 9953506370a5..95f2c42603d5 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -82,6 +82,7 @@ static struct trace_kprobe *to_trace_kprobe(struct dyn_event *ev)
>  #define for_each_trace_kprobe(pos, dpos)	\
>  	for_each_dyn_event(dpos)		\
>  		if (is_trace_kprobe(dpos) && (pos = to_trace_kprobe(dpos)))
> +#define trace_kprobe_list_empty() list_empty(&dyn_event_list)
>  
>  static nokprobe_inline bool trace_kprobe_is_return(struct trace_kprobe *tk)
>  {
> @@ -1982,6 +1983,9 @@ static __init void enable_boot_kprobe_events(void)
>  	struct trace_kprobe *tk;
>  	struct dyn_event *pos;
>  
> +	if (trace_kprobe_list_empty())
> +		return;
> +
>  	guard(mutex)(&event_mutex);
>  	for_each_trace_kprobe(tk, pos) {
>  		list_for_each_entry(file, &tr->events, list)
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
