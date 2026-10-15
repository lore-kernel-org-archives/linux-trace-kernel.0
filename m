Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEAC4AA402;
	Thu, 15 Oct 2026 10:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792059584; cv=none; b=rUoaoMuo4k7FaHPHvVud2ft8hZ01kc71dPAaJ/jz1zT0FqkKvaojcMKWQdw7Sev37BRi2lhyXeGYmMVzJu/yx9q5wJk8VMUJ4Yu610eK2wu/daqUNLB3CCF9HrwI+xJsS5a2fgBf5i/us7Nrmtuqio/khFMvf9eaXvb+cEuvm9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792059584; c=relaxed/simple;
	bh=X1ZF0LLFhol9KjZa8UOMA49zTXjSj4IBB1MItfhLxY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WmaEG6uiz080RI0NBLwWvvOANXV74JwmPV7eZ9SXUk0miRK9QmFXoGrbh/3YNSXPtgwPBDHEzk9EbCe0Nkix6WX2U5RgWSK/2a5X8ODuS9s7TOk3FuSv4gGiPWm7CFSgTXRolGson3tDS8UgBUquK6wmwZEiK/TldoxP7s06Tog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SnddUJuq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SnddUJuq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A14E71F000C4;
	Thu, 15 Oct 2026 10:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792059583;
	bh=qbAnPY0k2WYMu3kZPxGLJ3wr9dUW8E/gwCbxpaea4sE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SnddUJuqX5+NBkZhnXsn7mc4ngH6wAlCu9wJUk57h0U/UWcuFIjimHtQ/q4kRKRNR
	 InvOJWrqeZUlSt3DmbV6HZAsbRWoITw2ZX8iR4uOv52jdzP6sJhNaiPhR8GO00UHjQ
	 37AckAchSny9X0Dte5svmuh5TMJiF02buCPU2wQui06n8/mrYGyQnVwYnWlBVLWepR
	 FrtUZM/kyaL3wYQJMqa4iHtYuiE800GbsZOP3+Mog4FaIgzXOcvBulYmrnEJYTKZ0x
	 Noc+Atdme6XfPWktBhl9KbRNxzhfvJbzNYUPPjdSHDC8YOAG7hCIsvJQSFJIG4Xyqy
	 yPCjdCQZ4ELPA==
Date: Thu, 15 Oct 2026 11:19:39 +0100
From: Lee Jones <lee@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tom Zanussi <tom.zanussi@linux.intel.com>,
	Fengguang Wu <fengguang.wu@intel.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/histograms: Verify event_call identity when
 updating synth_event refcount
Message-ID: <20261015101939.GF1182143@google.com>
References: <20261014103012.744589-1-lee@kernel.org>
 <20261014141000.6091c0c5@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014141000.6091c0c5@gandalf.local.home>

On Wed, 14 Oct 2026, Steven Rostedt wrote:

> On Wed, 14 Oct 2026 10:30:12 +0000
> Lee Jones <lee@kernel.org> wrote:
> 
> > In event_hist_trigger_parse() and hist_unreg_all(), the histogram
> > registration and unregistration paths look up find_synth_event() using
> > trace_event_name(file->event_call) and adjust se->ref if a match is
> > found.
> > 
> > Because find_synth_event() only compares the event basename, registering
> > or removing a histogram on a non-synthetic trace event whose basename
> > matches a synthetic event erroneously modifies the synthetic event's
> > reference count.  If a histogram is registered on the non-synthetic
> > event before the synthetic event is created and removed afterwards,
> > se->ref is decremented without a matching increment, allowing the
> > synthetic event to be freed while an active histogram action still holds
> > a pointer to it.
> > 
> > Verify that &se->call matches file->event_call before adjusting se->ref.
> > 
> > Fixes: 4b147936fa50 ("tracing: Add support for 'synthetic' events")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Lee Jones <lee@kernel.org>
> 
> Hi,
> 
> Thanks for the patch...
> 
> > ---
> >  kernel/trace/trace_events_hist.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> > index 00a1d8522036..71b240b609ea 100644
> > --- a/kernel/trace/trace_events_hist.c
> > +++ b/kernel/trace/trace_events_hist.c
> > @@ -6807,7 +6807,7 @@ static void hist_unreg_all(struct trace_event_file *file)
> >  
> >  			se_name = trace_event_name(file->event_call);
> >  			se = find_synth_event(se_name);
> > -			if (se)
> > +			if (se && &se->call == file->event_call)
> >  				se->ref--;
> >  
> >  			update_cond_flag(file);
> > @@ -6926,7 +6926,7 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
> >  		event_trigger_unregister(cmd_ops, file, glob+1, trigger_data);
> >  		se_name = trace_event_name(file->event_call);
> >  		se = find_synth_event(se_name);
> > -		if (se)
> > +		if (se && &se->call == file->event_call)
> >  			se->ref--;
> >  		ret = 0;
> >  		goto out_free;
> > @@ -6962,7 +6962,7 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
> >  
> >  	se_name = trace_event_name(file->event_call);
> >  	se = find_synth_event(se_name);
> > -	if (se)
> > +	if (se && &se->call == file->event_call)
> >  		se->ref++;
> >   out:
> >  	if (ret == 0 && glob[0])
> 
> Instead of open coding each of these, can we add a new helper function:
> 
> struct synth_event *find_synth_event_call(struct trace_event_call *call)
> {
> 	struct synth_event *se;
> 	const char *name;
> 
> 	name = trace_event_name(call);
> 	se = find_synth_event(name);
> 	return se && se->call == call ? se : NULL;
> }
> 
> The above can be defined in trace_events_synth.c and exported like
> find_synth_event() is.
> 
> Then we can remove the se_name from each of these functions.

Thanks for the pointer.  I'll look into it.

-- 
Lee Jones
