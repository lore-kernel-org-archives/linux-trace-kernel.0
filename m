Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B6924169E;
	Tue,  8 Apr 2025 23:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744155424; cv=none; b=Mn/9ZTD/d/3ljGme3hBwYPLB29qqynzfaaSfNcQDXlU1eXTnJLKMVSOxlciujlLX6B4zS0HC2lIhTp1IvXzMoEwSXpROT/+d8n9wQ2BwhNAe6RG/mJst2wcfyWy/y3XoMVrw0/w4MEAcxwGxt5RNnLclZYoGGa6e+mDtv2Q+gM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744155424; c=relaxed/simple;
	bh=qeBpWOGfbzJOiCA+hJbPkYPDneCqlrg4wZjdvh8DyT0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Kbvh9MqFXFSdadMvrPQn6T4QYo8Av4xaWjT4DfEUEVyrIKswRvGqQk9/8zSlX5AsPbbHRSice00DfWm3YC0sj7b5WnV+Aqnl18d91vVDq2o9Ddv2xiC7SNZAhi+tSFqzQ7vseztrKCUIPAnz3uLkeh9Bk2hBt8oCuhj+aw3Uvms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJaDqAgD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJaDqAgD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 725E8C4CEE5;
	Tue,  8 Apr 2025 23:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744155424;
	bh=qeBpWOGfbzJOiCA+hJbPkYPDneCqlrg4wZjdvh8DyT0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mJaDqAgDhT7NyTXj0SNQLNfYR7g62SMYxdeXXe5/AGznNqblaZmLUyyXNFVObzMoC
	 dxn0Fihnox9zkhwzcwqXZBoAsQqDlvjQiA/1MPOs9elK8RBNTYCtcfz4KoD2cpdyHa
	 M9NhRTmyLCwMbIn9mqTr7IBkYCUjkUisDotcUK0oxc5oyQfmALq9fm9w5aBRV/VfLr
	 rtsJtkzbPDeh7owLrrA9ipR6pCTiM4kO6nBBVxdw2wfp4V9oIl94p7Uc7HT7070uMg
	 AAaUHoSjTTBKs2fDWAmvL1eZCYVC3fLnnrY/1bM1RSVcnr/69BkWA56sf7VmKreatV
	 rb+nqmNQsAvTw==
Date: Wed, 9 Apr 2025 08:36:58 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Tom Zanussi <zanussi@kernel.org>, Douglas Raillard
 <douglas.raillard@arm.com>
Subject: Re: [PATCH] tracing: Do not add length to print format in synthetic
 events
Message-Id: <20250409083658.25c2687da3fad617514f8b22@kernel.org>
In-Reply-To: <20250407154139.69955768@gandalf.local.home>
References: <20250407154139.69955768@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 7 Apr 2025 15:41:39 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> The following causes a vsnprintf fault:
> 
>   # echo 's:wake_lat char[] wakee; u64 delta;' >> /sys/kernel/tracing/dynamic_events
>   # echo 'hist:keys=pid:ts=common_timestamp.usecs if !(common_flags & 0x18)' > /sys/kernel/tracing/events/sched/sched_waking/trigger
>   # echo 'hist:keys=next_pid:delta=common_timestamp.usecs-$ts:onmatch(sched.sched_waking).trace(wake_lat,next_comm,$delta)' > /sys/kernel/tracing/events/sched/sched_switch/trigger
> 
> Because the synthetic event's "wakee" field is created as a dynamic string
> (even though the string copied is not). The print format to print the
> dynamic string changed from "%*s" to "%s" because another location
> (__set_synth_event_print_fmt()) exported this to user space, and user
> space did not need that. But it is still used in print_synth_event(), and
> the output looks like:
> 
>           <idle>-0       [001] d..5.   193.428167: wake_lat: wakee=(efault)sshd-sessiondelta=155
>     sshd-session-879     [001] d..5.   193.811080: wake_lat: wakee=(efault)kworker/u34:5delta=58
>           <idle>-0       [002] d..5.   193.811198: wake_lat: wakee=(efault)bashdelta=91
>             bash-880     [002] d..5.   193.811371: wake_lat: wakee=(efault)kworker/u35:2delta=21
>           <idle>-0       [001] d..5.   193.811516: wake_lat: wakee=(efault)sshd-sessiondelta=129
>     sshd-session-879     [001] d..5.   193.967576: wake_lat: wakee=(efault)kworker/u34:5delta=50
> 
> The length isn't needed as the string is always nul terminated. Just print
> the string and not add the length (which was hard coded to the max string
> length anyway).
> 

Good catch!

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> Cc: stable@vger.kernel.org
> Fixes: 4d38328eb442d ("tracing: Fix synth event printk format for str fields");
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace_events_synth.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
> index 969f48742d72..33cfbd4ed76d 100644
> --- a/kernel/trace/trace_events_synth.c
> +++ b/kernel/trace/trace_events_synth.c
> @@ -370,7 +370,6 @@ static enum print_line_t print_synth_event(struct trace_iterator *iter,
>  				union trace_synth_field *data = &entry->fields[n_u64];
>  
>  				trace_seq_printf(s, print_fmt, se->fields[i]->name,
> -						 STR_VAR_LEN_MAX,
>  						 (char *)entry + data->as_dynamic.offset,
>  						 i == se->n_fields - 1 ? "" : " ");
>  				n_u64++;
> -- 
> 2.47.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
