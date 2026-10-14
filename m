Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A62947F3BD;
	Wed, 14 Oct 2026 18:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792001092; cv=none; b=FB0FF3LwxPfzABChdgISsjilJe/2eOu+Ali8kdb+gOdHeHrEKxdvhnh+gyHGVdgEaRThRwoTP3YLPFxHXxGlErC+Y5Jxvox58vx/TXdGWdoUlxvzhK6iQYlcJ3nQXhyHihtlgM/0088d3Zrc9OuusfSizNaNlDKwZINYNMyPH+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792001092; c=relaxed/simple;
	bh=W82k30HwN+QQ9RO4gtpgsHX7igVRhsRCnChkADygNJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nVaS4tRLUjl6bWciigtBoccK3G3m1EQxi9kX+3kpzAd48+9tfhwPBcIjM6PwdBp3rZbNK/xsEq/ASYhD+0yaIpVevW6ds4p9LNq39L0e2BHKm4/BrCZx1NHFAt8/Gg3P79CXgM3d0FDBMb6nxmjxdEh9K/0F9GepeLNSjvBuEPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=MqJPLya9; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="MqJPLya9"
Received: from omf19.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 66049140711;
	Wed, 14 Oct 2026 17:58:31 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id 5493620026;
	Wed, 14 Oct 2026 17:58:29 +0000 (UTC)
Date: Wed, 14 Oct 2026 14:10:00 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Lee Jones <lee@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Tom Zanussi
 <tom.zanussi@linux.intel.com>, Fengguang Wu <fengguang.wu@intel.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/histograms: Verify event_call identity when
 updating synth_event refcount
Message-ID: <20261014141000.6091c0c5@gandalf.local.home>
In-Reply-To: <20261014103012.744589-1-lee@kernel.org>
References: <20261014103012.744589-1-lee@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: c7qitex5anihzkyxy7cqp9fiht7buprd
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 5493620026
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18dI8PUxHTycJ9hd9Mlw1avj6RZnydDPmc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=yOOmlqMyv9Qa0HdrnonKwaPW/RrCU/rw3vzXVT/B4b4=; b=MqJPLya9aPbTPs1RJHinniAIeZgEGahk1srFntN8Lo+8m+6SC5qKVAMiHXlvr9SvnMdpnEqiphyx2ZhKQQqogksnbvL/8qzy4aox6hNKVBFzFuh7m8WZa5jlFYp7HPNKgaYzJ/y1tUXPsNKEXU9YnTWTfvKJBinU31AFQfB0jCc=
X-HE-Tag: 1792000709-806186
X-HE-Meta: U2FsdGVkX1/Dy2ThiDiLQp7S9YD8klUKHtpq8FAWQW3bH4L/cqCXnX2ZtuctobD3W1quJ7Nm36swoKzY5/hvW9tmCc9sfp3noT8mr7604t5imkqjtgS2ZM6ULPuY34t6p1iojGv9VPSewQyjPYv+Jt7Mw3XHf4KpQ2VAV8CGKn4RpZxpEgAiW3EE4xKk5rk2f4wnn2hFub+8NH2T1kLH2mEyuDfXyTaegSC3Ijoqd7uRXuAFYDliNP9qGtAyITteknwx+xdBxz73pzeBdDpfkBlU79nS8s6rkI6/Yd/XdAvDq8z9H9u0vewngBBOVqaxX6fpA7vIv7IOuvbtQ6lr+x6Fpca538K9

On Wed, 14 Oct 2026 10:30:12 +0000
Lee Jones <lee@kernel.org> wrote:

> In event_hist_trigger_parse() and hist_unreg_all(), the histogram
> registration and unregistration paths look up find_synth_event() using
> trace_event_name(file->event_call) and adjust se->ref if a match is
> found.
> 
> Because find_synth_event() only compares the event basename, registering
> or removing a histogram on a non-synthetic trace event whose basename
> matches a synthetic event erroneously modifies the synthetic event's
> reference count.  If a histogram is registered on the non-synthetic
> event before the synthetic event is created and removed afterwards,
> se->ref is decremented without a matching increment, allowing the
> synthetic event to be freed while an active histogram action still holds
> a pointer to it.
> 
> Verify that &se->call matches file->event_call before adjusting se->ref.
> 
> Fixes: 4b147936fa50 ("tracing: Add support for 'synthetic' events")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>

Hi,

Thanks for the patch...

> ---
>  kernel/trace/trace_events_hist.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 00a1d8522036..71b240b609ea 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -6807,7 +6807,7 @@ static void hist_unreg_all(struct trace_event_file *file)
>  
>  			se_name = trace_event_name(file->event_call);
>  			se = find_synth_event(se_name);
> -			if (se)
> +			if (se && &se->call == file->event_call)
>  				se->ref--;
>  
>  			update_cond_flag(file);
> @@ -6926,7 +6926,7 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
>  		event_trigger_unregister(cmd_ops, file, glob+1, trigger_data);
>  		se_name = trace_event_name(file->event_call);
>  		se = find_synth_event(se_name);
> -		if (se)
> +		if (se && &se->call == file->event_call)
>  			se->ref--;
>  		ret = 0;
>  		goto out_free;
> @@ -6962,7 +6962,7 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
>  
>  	se_name = trace_event_name(file->event_call);
>  	se = find_synth_event(se_name);
> -	if (se)
> +	if (se && &se->call == file->event_call)
>  		se->ref++;
>   out:
>  	if (ret == 0 && glob[0])

Instead of open coding each of these, can we add a new helper function:

struct synth_event *find_synth_event_call(struct trace_event_call *call)
{
	struct synth_event *se;
	const char *name;

	name = trace_event_name(call);
	se = find_synth_event(name);
	return se && se->call == call ? se : NULL;
}

The above can be defined in trace_events_synth.c and exported like
find_synth_event() is.

Then we can remove the se_name from each of these functions.

-- Steve
