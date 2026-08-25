Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E5C386C3B;
	Tue, 25 Aug 2026 13:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787665064; cv=none; b=ngUQkf09mg/WpKYVAWZaeeAtzZXYH53styf6bohr+jLgSoD+0EqaC7ZzWttFwBrYIh9MVXUQZil6ffc1fcsG913rVlXvz23kj8Y+zU5oDN/9uEhnVtlHLndUzj0W+SfHOmcneLoT2skSJCD9eSV7843y6soAGSk3bw9k1coln0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787665064; c=relaxed/simple;
	bh=kp8OWdhQu+ADZeP6ViF5RkBIpPLLX6baIcNWYpZKN0U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GwLkVuHH6U/K+srnGUJEOct9Jx2XmsDgnJAWW7GLuYrWTq0sRQTh1H4szk1XugRwZ5U3wku0Au7sZOcFECi5t5ePeIszfp/44vaDvoAURDaPRGwOh4QPopdr0yF1BcqHQWFO47uPzUQKbLSW+IZUUCveWLALvQ5JMgCqPhQ5dmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=MCghFixd; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="MCghFixd"
Received: from omf20.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 350234041B;
	Tue, 25 Aug 2026 13:37:40 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id 609FE20025;
	Tue, 25 Aug 2026 13:37:38 +0000 (UTC)
Date: Tue, 25 Aug 2026 09:38:21 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: henry martin <bsdhenrymartin@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Fix use-after-free on field name/type of
 dynamic probe events
Message-ID: <20260825093821.2378c018@gandalf.local.home>
In-Reply-To: <CAEnQdOo0qHQK5veJp0Ybf3Hm3Gn2iUicL9Xj_bTNZKhoMfFOTw@mail.gmail.com>
References: <20260824071011.3507735-1-bsdhenrymartin@gmail.com>
	<20260824144356.1f61aea2@gandalf.local.home>
	<CAEnQdOo0qHQK5veJp0Ybf3Hm3Gn2iUicL9Xj_bTNZKhoMfFOTw@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: dsq1bg8qwgbfxz5wjx6qwqnqts59etpj
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 609FE20025
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19ZXxu6eEYKiVGPPqOGng/oujXELo81r68=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=HQMdWbidnSAWUC2jPJuD3zppnSl8XpmVMrwYm+1q+FM=; b=MCghFixdsuGW5jve92Td8vCGWPHFwinbWSX+JUHz/LgDKeS4KQr/TzP71UX7WmnrjyUGsvqy1mF0rxsw/75UgADDqsCPKsh95GEz19bUaWKge+tFJEOQJk/vZLKC7Zo7lKlhjPHxd4d99TjSgfDNtwp9/IkzqDZ+xmpuXsXbWzA=
X-HE-Tag: 1787665058-648790
X-HE-Meta: U2FsdGVkX1/+2C+Y2gbWp6R2J3Emqw5KHc2B25Bcngekrjyh/U+zvCnLOW2gkbDcBrHihZIPEfCbn3iuipmInGRLG4GGXZmCui6kNc1OZfSM22W7bCldAC+K6LWwurHzrtlOEeSjAt/roP+KipObHHSqP2yQ9MMJObtJ3icL7KueqoDzbB7BOWwVw/lLfg5xCLQRkpBBjx6ydUrshJN8s6vww7d7ohjD4DMcLqIpSETnEfJoXzHlc4TgCJ9IoaBtDKoLgwk42qfOwMnY2jbq65OzCjvB665EB9rKy0VWwudwess1w9OZcVzc3SrWpSouJtQ3wP/3P2JnWIRqznqk2JYMHBe7t+bc

On Tue, 25 Aug 2026 19:03:03 +0800
henry martin <bsdhenrymartin@gmail.com> wrote:

> > >
> > > When several probes are appended to the same event, they share the
> > > trace_event_call and its field list, which stays the one defined by
> > > the primary probe. Deleting just the primary probe with  
> >
> > What do you mean by "appended to the same event"? Do you mean eprobes?
> >  
> 
> Not eprobes -- I mean the kprobe multi-probe-per-event feature from the
> Fixes: commit (append_trace_kprobe()): two probes registered under one
> event name with identical arg names/types but different symbols, so they
> share a single trace_event_call. eprobe/uprobe/fprobe are affected too
> only because they all define their fields through the same helper
> (traceprobe_define_arg_fields()), but the reproducer below is plain
> kprobe.
> 
> > Can you post a reproducer for this?  
> 
> Run as root with KASAN, inside the guest:

Does it matter being inside a guest?

> 
>   cd /sys/kernel/tracing
>   # primary A: fields are defined from A's args
>   echo 'p:kprobes/ev vfs_read  a1=$arg1' >  kprobe_events
>   # append B: shares A's event call
>   echo 'p:kprobes/ev vfs_write a1=$arg1' >> kprobe_events
>   # delete ONLY A (matched by symbol), B survives
>   echo '-:kprobes/ev vfs_read'           >> kprobe_events
>   # field lookup -> strcmp() on the freed name
>   echo 'a1 == 1' > events/kprobes/ev/filter
> 
>   BUG: KASAN: slab-use-after-free in strcmp+0xa7/0xb0
>    trace_find_event_field
>    parse_pred
>    process_preds
>    create_filter
>    apply_event_filter
>    event_filter_write
> 
>   Freed by: traceprobe_free_probe_arg / trace_probe_cleanup /
>             free_trace_kprobe / ... / dyn_event_release

The above is useful information to include in the change log.

> 
> Deleting A runs trace_probe_cleanup(A), which frees A's args, then
> trace_probe_unlink(A) keeps the trace_probe_event because B is still on
> the probe list. The event survives via B while its fields still point at
> A's freed arg->name (and, for array args, arg->fmt). Both the delete and
> the filter write hold event_mutex, so it is a dangling reference after
> removal, not a race -- it triggers every time.
> 
> >  
> > > "-:group/event symbol" frees the trace_probe and its argument
> > > strings, while the event call is kept registered by the remaining
> > > sibling probes. field->name and field->type are left dangling, and
> > > any field lookup - e.g. writing to events/<grp>/<ev>/filter - reads
> > > freed memory:
> > >
> > >   BUG: KASAN: slab-use-after-free in strcmp+0xa7/0xb0
> > >   Call trace:
> > >    trace_find_event_field+0xd6/0x220
> > >    parse_pred
> > >    process_preds
> > >    create_filter
> > >    apply_event_filter
> > >    event_filter_write
> > >
> > > Make the field own its strings: duplicate name and type with
> > > kstrdup_const() in __trace_define_field() and release them with
> > > kfree_const() in trace_destroy_fields(). Fields of static trace
> > > events still reference their kernel/module rodata string literals
> > > directly, as kstrdup_const()/kfree_const() only touch memory that
> > > was actually allocated.  
> >
> > Wrong fix.
> >  
> > >
> > > The issue was found by the autokbug dynamic kernel fuzzer at Tencent
> > > Yunding Lab.
> > >
> > > Fixes: ca89bc071d5e4 ("tracing/kprobe: Add multi-probe per event  
> support")
> > > Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
> > > ---
> > >  kernel/trace/trace_events.c | 14 ++++++++++++--
> > >  1 file changed, 12 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> > > index c01b10b99f67e..ee3b93fa09ee8 100644
> > > --- a/kernel/trace/trace_events.c
> > > +++ b/kernel/trace/trace_events.c  
> >
> > This is a bug with trace_probes.c and not trace_events.c. This should be
> > fixed without touching trace_events.c. That is, the trace_probes.c code
> >  
> (or
> > trace_eprobes.c if it's only affects eprobes) should handle this issue.
> >  
> 
> Agreed, that was the wrong place. v3 keeps trace_define_field() and all
> static events untouched and fixes it where the borrowing happens:
> traceprobe_define_arg_fields() now kstrdup()s the name/type, and the
> copies are owned by the trace_probe_event (which embeds the event call
> and outlives every individual probe), freed in trace_probe_event_free().
> It is one helper plus its teardown, both in trace_probe.c, plus two
> fields on struct trace_probe_event.
> 
> v3 is posted as a reply in this thread, tested with KASAN +

Please post new versions as a separate thread. It helps with tooling.

> kasan_multi_shot. The reproducer above triggers the UAF reliably on the
> unpatched tree; with the patch, deleting the primary probe leaves
> format/filter intact on the surviving event and the report is gone. I
> also checked the array-arg
> case (arr=+0($arg1):u64[2]), where field->type borrows the kmalloc'd
> parg->fmt: the type string survives the primary delete and full teardown
> afterwards shows no double-free.
> 
> Thanks for the review.

I'll look at your other patch.

Thanks,

-- Steve
