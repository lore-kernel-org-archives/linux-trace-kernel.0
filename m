Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553973546E9;
	Fri, 16 Oct 2026 14:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792162267; cv=none; b=X+1+j5G33zQi6T1kPxc0+yH1LnHz83AUCBRUoTKy2QIMecB9xxTTYVn9IE9LIg6nTSMsdPxTv3Ig2dKH/24w3KklKnP+5aK0Jcinwf8fVTqqwC1nQ05UINQZJKnT7JNbNJwTAX5xUNEie/JXrA4DGOrYSBOM4Yaj7bVPUcfj9K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792162267; c=relaxed/simple;
	bh=2LeLKrAB0SM89vaOubLuuMmKaZxzT9UXR2eofWzyb4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A9hb1PCaA0ODB+UcnvzoRd7esHaJ6dD3dStlfm6iTObPKaxp70E31KrsDIcYR/7Rv/RcFYXUUDh91QUSD3LyBw+2PnmIv9EaZjxpXNf1rFhvW1AUwsNMkviALgj6dmKx2KvmdCe4Z6Pws27d/sYZi7eXz11uS74ZTWZxR9fyWfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=optfVY8E; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="optfVY8E"
Received: from omf02.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id AD2C5A7C00;
	Fri, 16 Oct 2026 14:51:03 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id DA5F18000F;
	Fri, 16 Oct 2026 14:51:01 +0000 (UTC)
Date: Fri, 16 Oct 2026 10:51:00 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Haoran Wang <haoranwangsec@gmail.com>, Beau Belgrave
 <beaub@linux.microsoft.com>
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com
Subject: Re: [PATCH] tracing: guard trace_event_get_offsets() against an
 empty fields list
Message-ID: <20261016105100.7a64aa51@gandalf.local.home>
In-Reply-To: <20261016102249.090d33af@gandalf.local.home>
References: <6ad1f2ca.6048f038.32d739.a530@mx.google.com>
	<20261016102249.090d33af@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: DA5F18000F
X-Stat-Signature: aunfz9xp14ibqmok9qu1sz6tegonztqb
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19DTezdcAWQfVWYMcQCBrLBPB2C2f9gLqw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=2NztRXb9DoBF3/gKBHv3YiWVSXvknwy3KzRir8wbGpM=; b=optfVY8Eu9yVH8Zx9fKfl0s/qTyfcXVZnPLCKG0jWmoUohppyXVtKsxvyLKbOe/dYL3nK8sdE17BNj+mHaIC4SbjffKVQcq03NCzuYCSLhG2KUoRiXNR96UqA564oAL51ZpMxFjgXGNjqyfm1mVh9PIHInMXoDzctQLlWgd/NMM=
X-HE-Tag: 1792162261-449970
X-HE-Meta: U2FsdGVkX18zScwSp8Y17154QIG6IVLrMCXKwwRbuddZf7SlNKEyPYG9reNe147qktWCe6bWmwuX9Eo74+soJgCp7bqfhLocRhbbNjGhMe52iPM95OW59B7gcUlcs8EUNQ6f6OJTONuxIFctjVAILqmPaFTPGXz8TLMBMTHHQcQGbX32wPIhxa0n9shFYz44fkv1XRW014dEK73DUhHPjZjHOgrf+yeb+JpmOycbjQsSD0aDvQeNUGbS25meEPjcw4Fw9iApsI5bD8qxzmocvFV/lLfCFH7Ig/l9aPlQIqFxK3GZE/ZtjR8RrbTtW2VCwDBi0VbZeahptngsWsMWG8MpkbNtffyZ3N+qaRwuqfRJNrGeAo78+FKdlKmhSWCuGxlC+aihvxTNMA7tUSRZrA==

On Fri, 16 Oct 2026 10:22:56 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 16 Oct 2026 17:47:51 +0800
> Haoran Wang <haoranwangsec@gmail.com> wrote:
> 
> > From 0000000000000000000000000000000000000000 Mon Sep 17 00:00:00 2001
> > From: Haoran Wang <haoranwangsec@gmail.com>
> > Date: Fri, 16 Oct 2026 16:30:00 +0800
> > Subject: [PATCH] tracing: guard trace_event_get_offsets() against an empty fields list
> > 
> > trace_event_get_offsets() dereferences the first entry of the fields list
> > returned by trace_get_fields() via list_first_entry().  list_first_entry()
> > then returns the list head itself, and tail->offset + tail->size reads past
> > it.  The corrupted result is used as the BPF context-size bound in
> > __perf_event_set_bpf_prog():
> > 
> >     int off = trace_event_get_offsets(event->tp_event);
> >     if (prog->aux->max_ctx_offset > off)
> >             return -EACCES;
> > 
> > so a context-reading BPF program that ought to be rejected can instead be
> > attached to a zero-field tracepoint (which still carries
> > TRACE_EVENT_FL_TRACEPOINT) and read adjacent kernel memory when the
> > tracepoint fires, bypassing the verifier's context-size confinement.
> > 
> > This is reachable through user_events: a user can register an event with no
> > fields (e.g. `echo u:my_event > dynamic_events`), which leaves user->fields
> > empty while the event remains a BPF-attachable tracepoint,
> > trace_get_fields() then routes through user_event_get_fields() to that
> > empty list. The corrupted
> > result after list_first_entry is then used as the BPF context-size bound in
> > __perf_event_set_bpf_prog(), which lets context-reading BPF programs attach
> > to a zero-field tracepoint when they should be rejected with -EACCES.
> >   
> 
> Hmm, so user events can have empty events. :-/

I meant "empty fields".

> 
> Beau, Is that a thing?

-- Steve
