Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0883630B3;
	Thu,  3 Sep 2026 18:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788460156; cv=none; b=qOPD30gqMqTNE3TYCWs5JJ2nxt82xfB2lQ6QPkAfdwKVxfwxvSRaSvxbt3Dsjrm8yqb7C4yGRw15GVPxlXconFnFoXzlTgvECzw+Pw0XUkmHdDa//Y5OgVUCUsAU2u6Is7/Mk10r58/pL3nwzcFzCbzAx0LpUoRSWI1K/p+pUnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788460156; c=relaxed/simple;
	bh=Ep3jtkS57sFuTNOwlOGRYF5czvDRE5v4rodsQ9qthIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fS0pU9eezrpbD1kc+0akDO8sroNjVMGDzdBKa6hSGjifqBluemIipZkM4JourqP76Grd9mTC2XtRenFz+Hjs2bS6pubzKfFzB75MOyqjeE6gs8uThL21wDvYcH5wC369yF/yIlxDqj4S7fbHRqRWuMm4v5KpVCr5npisgyZ+Hjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=aEaF+Php; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="aEaF+Php"
Received: from CPC-beaub-VBQ1L.localdomain (unknown [70.37.26.63])
	by linux.microsoft.com (Postfix) with ESMTPSA id B338220B7166;
	Thu,  3 Sep 2026 11:28:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B338220B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1788460113;
	bh=O3M4JsqWoYQ8EQJC8k/Da4yhDi3jSkzWDS5OauMn9oI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aEaF+Php9gSN1IIqaYYWf6Fugl0LX8a5ah/Gcm4atpVWBgLWf3HmjNPiG88VyXVJ/
	 PxpKZvYsXTe1rcM8WmDFGTj5ZrQgVkPvk8NqmfA7YqO/B2sTg/zqhvfbGMy/zofGnd
	 dEiEe/w0Bp0CTdOk7P1KNXdpsHEGssKponGrIJH4=
Date: Thu, 3 Sep 2026 18:29:03 +0000
From: Beau Belgrave <beaub@linux.microsoft.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Henry Martin <bsdhenrymartin@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/user_events: Don't destroy fields when event
 removal fails
Message-ID: <20260903182903.GA62-beaub@linux.microsoft.com>
References: <20260824102907.4173063-1-bsdhenrymartin@gmail.com>
 <20260824163955.522cb5b0@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824163955.522cb5b0@gandalf.local.home>

On Mon, Aug 24, 2026 at 04:39:55PM -0400, Steven Rostedt wrote:
> 
> Beau,
> 
> Can you review this patch?
> 

Sure thing.

> Thanks,
> 
> -- Steve
> 
> 
> On Mon, 24 Aug 2026 18:29:07 +0800
> Henry Martin <bsdhenrymartin@gmail.com> wrote:
> 

Hey Henry, thanks for this!

> > destroy_user_event() destroys the event's fields before attempting to
> > remove the trace event call. If user_event_set_call_visible() fails,
> > e.g. because the event is still enabled and trace_remove_event_call()
> > returns -EBUSY, the event is left registered with an irreversibly
> > destroyed field list. Any subsequent interaction with the event then
> > operates on an empty field list while it is still fully visible in
> > tracefs.
> > 
> > Move the field destruction after the call removal, and splice the
> > field list back onto the event when the removal fails so the event
> > remains in a consistent state.
> > 
> > Fixes: 7f5a08c79df35 ("user_events: Add minimal support for trace_event into ftrace")
> > Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
> > ---
> >  kernel/trace/trace_events_user.c | 16 ++++++++++------
> >  1 file changed, 10 insertions(+), 6 deletions(-)
> > 
> > diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
> > index 8c82ecb735f41..0b021c212995a 100644
> > --- a/kernel/trace/trace_events_user.c
> > +++ b/kernel/trace/trace_events_user.c
> > @@ -1119,10 +1119,9 @@ static void user_event_destroy_validators(struct user_event *user)
> >  	}
> >  }
> >  
> > -static void user_event_destroy_fields(struct user_event *user)
> > +static void user_event_destroy_fields(struct list_head *head)
> >  {
> >  	struct ftrace_event_field *field, *next;
> > -	struct list_head *head = &user->fields;
> >  
> >  	list_for_each_entry_safe(field, next, head, link) {
> >  		list_del(&field->link);
> > @@ -1499,17 +1498,21 @@ static int user_event_set_call_visible(struct user_event *user, bool visible)
> >  
> >  static int destroy_user_event(struct user_event *user)
> >  {
> > +	LIST_HEAD(fields);
> >  	int ret = 0;
> >  
> >  	lockdep_assert_held(&event_mutex);
> >  
> > -	/* Must destroy fields before call removal */

We really need a comment to stick around, it's not going to be obvious
why we have to remove the fields before destroy (It's because removing
the event frees the list memory, which are owned by user_events).

> > -	user_event_destroy_fields(user);
> > +	list_splice_init(&user->fields, &fields);
> >  
> >  	ret = user_event_set_call_visible(user, false);
> >  
> > -	if (ret)
> > +	if (ret) {

Would be good to get a comment on here stating why we are putting the
fields back. We have to recover them.

> > +		list_splice(&fields, &user->fields);
> >  		return ret;
> > +	}
> > +
> > +	user_event_destroy_fields(&fields);
> >  
> >  	dyn_event_remove(&user->devent);
> >  	hash_del(&user->node);
> > @@ -2209,7 +2212,7 @@ static int user_event_parse(struct user_event_group *group, char *name,
> >  put_user_lock:
> >  	mutex_unlock(&event_mutex);
> >  put_user:
> > -	user_event_destroy_fields(user);
> > +	user_event_destroy_fields(&user->fields);
> >  	user_event_destroy_validators(user);
> >  	kfree(user->call.print_fmt);
> >  

Thanks,
-Beau
