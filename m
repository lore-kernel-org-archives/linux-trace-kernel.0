Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45566C139;
	Mon,  3 Feb 2025 13:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738588474; cv=none; b=OZgdlc+ean3WH9MWqNTFPV4no8okLmKEcTnfuEOuHcWGNyzTroYxk7loD4dZCIHHG5aN2HGopFWgh7sdIsTOMnD6J2a+eCa6MDhcTsQ4ZFJ+8yrz8He8VIWwhVi+YaegOY/RV4GjhANaGIUkQjUngKh7ykU8ywMdlzydDoc7iB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738588474; c=relaxed/simple;
	bh=+NfmGvN2gosbrEcfAH28Y+dERHmzZHo9CpvkcW9ohNs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eamF9GzrN8ww4fL0BpNy7ZroFsru8u6ms2Lqo/Li/I5RZn7P97bPBbpi31cC8nUGwLUDlZFiHmITlb65beIu4I3JOGDkbbXVSQ6cUDH5q0EKJo4aNVXPlPDPo9z5C/B0cbcRfk10BS8OX3fsBSBZN7Tm3Gd/OTdJ8ABAkJUsL3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A59C0C4CED2;
	Mon,  3 Feb 2025 13:14:31 +0000 (UTC)
Date: Mon, 3 Feb 2025 08:15:05 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Wander Lairson Costa <wander@redhat.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand
 <david@redhat.com>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, "Darrick J. Wong" <djwong@kernel.org>, Richard
 Chang <richardycc@google.com>, Johannes Weiner <hannes@cmpxchg.org>, "open
 list:TRACING" <linux-kernel@vger.kernel.org>, "open list:TRACING"
 <linux-trace-kernel@vger.kernel.org>, David Rientjes <rientjes@google.com>,
 Christoph Lameter <cl@gentwo.org>, Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: Re: [PATCH] kmem/tracing: Add kmem name to kmem_cache_alloc
 tracepoint
Message-ID: <20250203081505.675e52af@gandalf.local.home>
In-Reply-To: <46e70b3c-6d96-4507-ba17-a52e8362873d@suse.cz>
References: <20250130181639.58280-1-wander@redhat.com>
	<46e70b3c-6d96-4507-ba17-a52e8362873d@suse.cz>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Feb 2025 09:34:29 +0100
Vlastimil Babka <vbabka@suse.cz> wrote:

> On 1/30/25 19:16, Wander Lairson Costa wrote:
> > The kmem_cache_free tracepoint includes a "name" field, which allows
> > for easy identification and filtering of specific kmem's. However, the
> > kmem_cache_alloc tracepoint lacks this field, making it difficult to
> > pair corresponding alloc and free events for analysis.  
> 
> Hm yeah looks like the free one was added in commit 3544de8ee6e48 and their
> use case didn't need alloc too, but it makes sense.
> 
> > Add the "name" field to kmem_cache_alloc to enable consistent tracking
> > and correlation of kmem alloc and free events.
> > 
> > Signed-off-by: Wander Lairson Costa <wander@redhat.com>  
> 
> I will take this in the slab tree, unless Steven objects.

No objections but...

> 
> Thanks,
> Vlastimil
> 
> > ---
> >  include/trace/events/kmem.h | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
> > index b37eb0a7060f..8ffb022f024c 100644
> > --- a/include/trace/events/kmem.h
> > +++ b/include/trace/events/kmem.h
> > @@ -22,6 +22,7 @@ TRACE_EVENT(kmem_cache_alloc,
> >  	TP_STRUCT__entry(
> >  		__field(	unsigned long,	call_site	)
> >  		__field(	const void *,	ptr		)
> > +		__string(	name,		s->name		)

The string place holder in the "struct" is 4 bytes and not a pointer. So I
would place it either at the end or next to another "int" to avoid any
holes caused by it being placed next to a 8 byte field.

-- Steve


> >  		__field(	size_t,		bytes_req	)
> >  		__field(	size_t,		bytes_alloc	)
> >  		__field(	unsigned long,	gfp_flags	)
> > @@ -32,6 +33,7 @@ TRACE_EVENT(kmem_cache_alloc,
> >  	TP_fast_assign(
> >  		__entry->call_site	= call_site;
> >  		__entry->ptr		= ptr;
> > +		__assign_str(name);
> >  		__entry->bytes_req	= s->object_size;
> >  		__entry->bytes_alloc	= s->size;
> >  		__entry->gfp_flags	= (__force unsigned long)gfp_flags;
> > @@ -41,9 +43,10 @@ TRACE_EVENT(kmem_cache_alloc,
> >  					  (s->flags & SLAB_ACCOUNT)) : false;
> >  	),
> >  
> > -	TP_printk("call_site=%pS ptr=%p bytes_req=%zu bytes_alloc=%zu gfp_flags=%s node=%d accounted=%s",
> > +	TP_printk("call_site=%pS ptr=%p name=%s bytes_req=%zu bytes_alloc=%zu gfp_flags=%s node=%d accounted=%s",
> >  		(void *)__entry->call_site,
> >  		__entry->ptr,
> > +		__get_str(name),
> >  		__entry->bytes_req,
> >  		__entry->bytes_alloc,
> >  		show_gfp_flags(__entry->gfp_flags),  

