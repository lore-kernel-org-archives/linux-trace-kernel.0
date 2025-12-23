Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC1B311C2D;
	Tue, 23 Dec 2025 21:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766526310; cv=none; b=TGjOIGw8ohkNTfQ1Ctp5rsvFrInvQyB8qvAjunnjCu22kOTL7obINE/qRQ1aJpstqQUIrdJxrbFwA+2yz1xaz7MdnS718DnAseNLSOnq9kUBb2OZEMZdgPMqs+TeKnvJNEYghXy2uaPOtlTfzgORY0ximym0fei1iSbd7qudrzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766526310; c=relaxed/simple;
	bh=sfzuRuk+UOBMLPZ0+imQ0/voj6VeAer1i+3vBQijXv8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FGjRR+F2KuxuOMccjTai/Oo7w1zId3mHTXCfuVAkPEvJOJjZIY0RU+pqmUM+dUh4OSsI/ROkCyjvzYu6hO4koPm9FlETr+cSjc/NmI4TgaSjkp4ezMmpsLnUIryS9beRK4pDcXKRHrD6C6AV/FhCQi+HPDuZa4fZgZVORw2nPbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 0622A13A774;
	Tue, 23 Dec 2025 21:45:03 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id 852422002D;
	Tue, 23 Dec 2025 21:45:01 +0000 (UTC)
Date: Tue, 23 Dec 2025 16:46:52 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH] tracing: Do not register unsupported perf events
Message-ID: <20251223164652.6153a392@gandalf.local.home>
In-Reply-To: <aUrd2k8ckouCB_bQ@google.com>
References: <20251216182440.147e4453@gandalf.local.home>
	<aUrd2k8ckouCB_bQ@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 852422002D
X-Stat-Signature: x9o3m3ka46bkty7et3gr8xox9cpbg85w
X-Rspamd-Server: rspamout08
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/wnd6O0YGQsrjukynqkKILuponOMRM/8E=
X-HE-Tag: 1766526301-769476
X-HE-Meta: U2FsdGVkX189JFg0arIfdIt9nXHzbK6kVX7PPAqw4q3ZlefaJjxwNKK6l5tUzKjfYZ7QBOOhHxUSA+bE70AbHuaPIBVdmYXl7w+ah75s7epCnRkW6gV6eOpmvm8blR7c5TFdz/0QpG8H6+rTvCYWHVb9rIsMxEo67QhPjZO2CFN5c73huLtNcW36NMA/0NnsQhX9k9HEuM65nJkHF4ckk8JnS+b7zp5qqrWCavWZR+6eE7AkkuFHF6N2UjCqNp2uTUyCQEow1/tixLBNsu96ndQ88uV2heOQjTnJkHrwH2AxJ13Bx5hoR48j5Raq3cNcrx5skh1RlWTYp+JO0dgE4zm0LC1cedGL

On Tue, 23 Dec 2025 10:22:18 -0800
Namhyung Kim <namhyung@kernel.org> wrote:

> Reviewed-by: Namhyung Kim <namhyung@kernel.org>
> 
> Thanks,
> Namhyung
> 
> > ---
> >  kernel/trace/trace_events.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> > index a5a93d243047..754b14ca87a7 100644
> > --- a/kernel/trace/trace_events.c
> > +++ b/kernel/trace/trace_events.c
> > @@ -710,6 +710,8 @@ int trace_event_reg(struct trace_event_call *call,
> >  
> >  #ifdef CONFIG_PERF_EVENTS
> >  	case TRACE_REG_PERF_REGISTER:
> > +		if (!call->class->perf_probe)
> > +			return -ENODEV;

Thanks Namhyung (and Jiri), but this actually already made it upstream as
it was a bug fix and I wanted to get it into the next rc release (rc2).

But, the real fix is having perf be able to handle synthetic_events as real
events.

Can you please review this patch:

  https://lore.kernel.org/linux-trace-kernel/20251217113920.50b56246@gandalf.local.home/

I plan on queuing that for the next merge window.

Thanks,

-- Steve


> >  		return tracepoint_probe_register(call->tp,
> >  						 call->class->perf_probe,
> >  						 call);
> > -- 
