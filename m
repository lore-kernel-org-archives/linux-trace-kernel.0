Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD419349B1C;
	Fri, 16 Oct 2026 14:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792160590; cv=none; b=X7XSIo3p3dJEv46Y5tKBN5HUo2xDar0f1qKLuWPf6ESTT1IPBO4BMbWqmTfwKTt5zVjjvUtgmPEBYUFrQlc81Mfdpr0EkmeOz3x+h4TLe9AymYCF41kQO9tjpChikyxss0eKjPPfm2cXcc/DMuTjHObdILrEAB2Fd9EvMn6NEx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792160590; c=relaxed/simple;
	bh=BCADDz5G5s4Yo+AnMmRVg2wZjXt7LMOXmKfT1IZuQz0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O5DOmQlATmUuvexDPtABRDJWsKQWk5FzZpZAo4cOvtbmOGCNTVKUzmAQf8xiuDjpGRmoSfvbCVU98Crqa3VTIheLCENtYEgBYjNK1eGlBZeccbF8Bk54UbnKr5w3C193zhCp1gj5xr7w8q2NwBcB7wkohzZrw9RcCyXSe7mrZeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=fIaoVocz; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="fIaoVocz"
Received: from omf18.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 47E67A0455;
	Fri, 16 Oct 2026 14:22:59 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id 82D0630;
	Fri, 16 Oct 2026 14:22:57 +0000 (UTC)
Date: Fri, 16 Oct 2026 10:22:56 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Haoran Wang <haoranwangsec@gmail.com>, Beau Belgrave
 <beaub@linux.microsoft.com>
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com
Subject: Re: [PATCH] tracing: guard trace_event_get_offsets() against an
 empty fields list
Message-ID: <20261016102249.090d33af@gandalf.local.home>
In-Reply-To: <6ad1f2ca.6048f038.32d739.a530@mx.google.com>
References: <6ad1f2ca.6048f038.32d739.a530@mx.google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: wqs95jcojisnrga6piyeatb6zm9pumio
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 82D0630
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19y9wrorSJylcTl9JtRKwKEELZr+rZ/x5s=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=Rwuo9Qyliadw2BRQpfpTJ8iXT6aJ60v+R+Sud5jveq0=; b=fIaoVoczu03OxeqHqX1GYR3MZblaIOy90B1g3UldP5gD3/X16tHhcFjzcyIOd6pgYNKLhTP1joMB+Dh06MY/ekgDxux/q6xu64TBTjE71liy/ZugWMD80zvPPx74dVL63e0b4w8aa8bldrhxCejyvvwrZ2cFgOKWGt+GUdDWUAg=
X-HE-Tag: 1792160577-126157
X-HE-Meta: U2FsdGVkX1+9yXGTHr+9htw8aAuopzhJTXRxp42ysSj9OdBsjJ/LZ54C0tXZ2arD+4ctPUqi2XlptSLf47EiAtmrnHh1eTU80WSvpmdpwapOavOuYhe+oUEa7lQy4GtMq3xi8MlUOMGE3ev4f5e0wfKTVejYthubShg8QDMTEJhZs2Ue/gbSk0yTzyTOP9XQlqtSfzMOC10Xck/KMVsepVYSNKol0KVSGmkYPaqi/auzMmvqP0NPn2vBAYMHdY+Sor4TixqvM8o7eCqKiuJLgMHr8uGIosCCXaaZAMjovlItraPuox4ycOwGLeq8NNE8Hm7GlB42MvqjAzEPlhylBU1lYM786FABAf635yfYrocb4w7XYP5LRQfEYLVVB2Lt

On Fri, 16 Oct 2026 17:47:51 +0800
Haoran Wang <haoranwangsec@gmail.com> wrote:

> From 0000000000000000000000000000000000000000 Mon Sep 17 00:00:00 2001
> From: Haoran Wang <haoranwangsec@gmail.com>
> Date: Fri, 16 Oct 2026 16:30:00 +0800
> Subject: [PATCH] tracing: guard trace_event_get_offsets() against an empty fields list
> 
> trace_event_get_offsets() dereferences the first entry of the fields list
> returned by trace_get_fields() via list_first_entry().  list_first_entry()
> then returns the list head itself, and tail->offset + tail->size reads past
> it.  The corrupted result is used as the BPF context-size bound in
> __perf_event_set_bpf_prog():
> 
>     int off = trace_event_get_offsets(event->tp_event);
>     if (prog->aux->max_ctx_offset > off)
>             return -EACCES;
> 
> so a context-reading BPF program that ought to be rejected can instead be
> attached to a zero-field tracepoint (which still carries
> TRACE_EVENT_FL_TRACEPOINT) and read adjacent kernel memory when the
> tracepoint fires, bypassing the verifier's context-size confinement.
> 
> This is reachable through user_events: a user can register an event with no
> fields (e.g. `echo u:my_event > dynamic_events`), which leaves user->fields
> empty while the event remains a BPF-attachable tracepoint,
> trace_get_fields() then routes through user_event_get_fields() to that
> empty list. The corrupted
> result after list_first_entry is then used as the BPF context-size bound in
> __perf_event_set_bpf_prog(), which lets context-reading BPF programs attach
> to a zero-field tracepoint when they should be rejected with -EACCES.
> 

Hmm, so user events can have empty events. :-/

Beau, Is that a thing?

-- Steve


> Add list empty check to fix this bug.
> 
> Signed-off-by: Haoran Wang <haoranwangsec@gmail.com>
> ---
>  kernel/trace/trace_events.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -239,6 +239,10 @@ int trace_event_get_offsets(struct trace_event_call *call)
>  	struct list_head *head;
>  
>  	head = trace_get_fields(call);
> +
> +	if (list_empty(head))
> +		return sizeof(struct trace_entry);
> +
>  	/*
>  	 * head->next points to the last field with the largest offset,
>  	 * since it was added last by trace_define_field()

