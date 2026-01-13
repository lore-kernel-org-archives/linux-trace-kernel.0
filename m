Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C30199920;
	Tue, 13 Jan 2026 01:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768268337; cv=none; b=c9RpYliLvZjvSbAuqCEh8W8D4RfIrl1vMuwPrCYcIA6omBXzReBsgksKP9BKA9nUc2o74pzrmIb6tisHUcTess/tTf9Wsl3UXgnP6jGw82Gsrd202ChY8hkHuVrlqQ98TZaxAhWTUsckaY9MBXQkZOq86fQjfrycW24d51GQRPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768268337; c=relaxed/simple;
	bh=OhjzEMjQ6hmTlPkBultci1tk0Nk/5I/qmP0gmq8S+Tc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LHfxmLtK838taHzUz7Vc6pncvep0J1KbDW2sZ4kbGA4IOWtzzLANk5NXjeLtLR7cCkHqaeBh+yg/QPA4Rko/REcs7Q9GkURNTpg44eYPYyMlymj43WMk78eIrBrL1zJlT0Y6GoBTDhH448BP9N0rLcBxzXH+HnDkUhNv6NiB8jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 2F0EC13C9A3;
	Tue, 13 Jan 2026 01:38:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id 49B0C80012;
	Tue, 13 Jan 2026 01:38:52 +0000 (UTC)
Date: Mon, 12 Jan 2026 20:38:56 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ftrace: Do not over-allocate ftrace memory
Message-ID: <20260112203856.0805eefb@gandalf.local.home>
In-Reply-To: <bde55f7c-7f13-4bb3-8a54-942704d4fe37@roeck-us.net>
References: <20260107022221.2907717-1-linux@roeck-us.net>
	<bde55f7c-7f13-4bb3-8a54-942704d4fe37@roeck-us.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: y4f7683sck1zyasehoytaariyk1xxgr9
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 49B0C80012
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18FwX6ERmlzOwMBpqGTLzivGuI1tvQiYN8=
X-HE-Tag: 1768268332-590844
X-HE-Meta: U2FsdGVkX18usPuoeAlg7U5lFGBLpLb+7SO2UXWHXLI5v/rlGZ/W0JMkhvxEF+wLVuMx60tR1EjUa6DZ7V7s6o835GD6/VDj6t1K1IJMNVCysTGsIjOME9PkoXt4QsqtwT/9OIpzriqPgv6jMBHK0vW1KooVsf+3G0EBDRMG+mrKqRCObKLHDDJboA5OdJifkyMueK4e2vUDBXL9Z5LsAXpmrceOCO4rbrIBbKpk0Sn9d3mE4VTo+w9QlmTnLUlJeZAIIm9uL4Gh84Aj2hEFcuEtDH9IyraiUSgdiKGdBvYrk5m3TVGAeV+IkcAK+vSiE0skq/PzO17X0sFSvV5QCQHu1SgiSajXIPVYA/mffaBmXuFQi1N1LHqBF2ivxAIQ

On Mon, 12 Jan 2026 16:15:56 -0800
Guenter Roeck <linux@roeck-us.net> wrote:

> > v3: Restore the code calculating the number of unused pages due to skipped
> >      entries. Use the actual number of entries per page group when
> >      calculating the number of entries in unused page groups.
> > v2: Have ftrace_allocate_pages() return the number of allocated pages,
> >      and drop the page count calculation code as well as the associated
> >      warnings from ftrace_process_locs().  
> 
> Any additional feedback / comments / suggestions ?

Yeah, sorry got caught up in other work.


> > -static int ftrace_allocate_records(struct ftrace_page *pg, int count)
> > +static int ftrace_allocate_records(struct ftrace_page *pg, int count,
> > +				   unsigned long *num_pages)
> >   {
> >   	int order;
> >   	int pages;
> > @@ -3844,7 +3844,7 @@ static int ftrace_allocate_records(struct ftrace_page *pg, int count)
> >   		return -EINVAL;
> >   
> >   	/* We want to fill as much as possible, with no empty pages */
> > -	pages = DIV_ROUND_UP(count, ENTRIES_PER_PAGE);
> > +	pages = DIV_ROUND_UP(count * ENTRY_SIZE, PAGE_SIZE);
> >   	order = fls(pages) - 1;
> >   
> >    again:
> > @@ -3859,6 +3859,7 @@ static int ftrace_allocate_records(struct ftrace_page *pg, int count)
> >   	}
> >   
> >   	ftrace_number_of_pages += 1 << order;
> > +	*num_pages += 1 << order;
> >   	ftrace_number_of_groups++;
> >   
> >   	cnt = (PAGE_SIZE << order) / ENTRY_SIZE;
> > @@ -3887,12 +3888,14 @@ static void ftrace_free_pages(struct ftrace_page *pages)
> >   }
> >   
> >   static struct ftrace_page *
> > -ftrace_allocate_pages(unsigned long num_to_init)
> > +ftrace_allocate_pages(unsigned long num_to_init, unsigned long *pages)

Small nit.

Can you rename this to num_pages? That way it is consistent with the above.
Both this function and ftrace_allocate_records() has this as a pointer,
whereas below it's an unsigned long. I rather have the pointer names be
consistent than having "pages" be a pointer here and an unsigned long where
it is called.

Thanks,

-- Steve


> >   {
> >   	struct ftrace_page *start_pg;
> >   	struct ftrace_page *pg;
> >   	int cnt;
> >   
> > +	*pages = 0;
> > +
> >   	if (!num_to_init)
> >   		return NULL;
> >   
> > @@ -3906,7 +3909,7 @@ ftrace_allocate_pages(unsigned long num_to_init)
> >   	 * waste as little space as possible.
> >   	 */
> >   	for (;;) {
> > -		cnt = ftrace_allocate_records(pg, num_to_init);
> > +		cnt = ftrace_allocate_records(pg, num_to_init, pages);
> >   		if (cnt < 0)
> >   			goto free_pages;
> >   
> > @@ -7192,8 +7195,6 @@ static int ftrace_process_locs(struct module *mod,
> >   	if (!count)
> >   		return 0;
> >   
> > -	pages = DIV_ROUND_UP(count, ENTRIES_PER_PAGE);
> > -
> >   	/*
> >   	 * Sorting mcount in vmlinux at build time depend on
> >   	 * CONFIG_BUILDTIME_MCOUNT_SORT, while mcount loc in
> > @@ -7206,7 +7207,7 @@ static int ftrace_process_locs(struct module *mod,
> >   		test_is_sorted(start, count);
> >   	}
> >   
> > -	start_pg = ftrace_allocate_pages(count);
> > +	start_pg = ftrace_allocate_pages(count, &pages);
> >   	if (!start_pg)
> >   		return -ENOMEM;
> >   
> > @@ -7305,27 +7306,27 @@ static int ftrace_process_locs(struct module *mod,
> >   	/* We should have used all pages unless we skipped some */
> >   	if (pg_unuse) {
> >   		unsigned long pg_remaining, remaining = 0;
> > -		unsigned long skip;
> > +		long skip;
> >   
> >   		/* Count the number of entries unused and compare it to skipped. */
> > -		pg_remaining = (ENTRIES_PER_PAGE << pg->order) - pg->index;
> > +		pg_remaining = (PAGE_SIZE << pg->order) / ENTRY_SIZE - pg->index;
> >   
> >   		if (!WARN(skipped < pg_remaining, "Extra allocated pages for ftrace")) {
> >   
> >   			skip = skipped - pg_remaining;
> >   
> > -			for (pg = pg_unuse; pg; pg = pg->next)
> > +			for (pg = pg_unuse; pg && skip > 0; pg = pg->next) {
> >   				remaining += 1 << pg->order;
> > +				skip -= (PAGE_SIZE << pg->order) / ENTRY_SIZE;
> > +			}
> >   
> >   			pages -= remaining;
> >   
> > -			skip = DIV_ROUND_UP(skip, ENTRIES_PER_PAGE);
> > -
> >   			/*
> >   			 * Check to see if the number of pages remaining would
> >   			 * just fit the number of entries skipped.
> >   			 */
> > -			WARN(skip != remaining, "Extra allocated pages for ftrace: %lu with %lu skipped",
> > +			WARN(pg || skip > 0, "Extra allocated pages for ftrace: %lu with %lu skipped",
> >   			     remaining, skipped);
> >   		}
> >   		/* Need to synchronize with ftrace_location_range() */  

