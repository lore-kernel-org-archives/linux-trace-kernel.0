Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C860296BBF;
	Tue,  6 Jan 2026 21:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767734310; cv=none; b=o9caOJd9usp4UN60RA4yW640qIyT5lqYX4EGICOpJvMAmWIkni/3bSl7N6NfIQo4iuqaUgnc3gIuMbPx1g3jG6f1+Hz4pNn7d8fatkRoj7AOJoFssgAS3vLdylrHf29tMw0LirZbYBt408YK0vBWixc8FBrLGle6X9WVkdWjGKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767734310; c=relaxed/simple;
	bh=4k8pp7RYpa+kEn6UqKaH7bDYj/7ND3lIXvybvb6n87I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K39itcltx2DAH8xtIAwGiE8d3wobR9tbrwMH3VMLFoIFT4u6ynBLTgrCDIdjmVTVPLGVcbkfQaOzVi4BfJdwrNRI1ZmjPVKaGcxOp+dsSyiwHifpYgF3dLoNwhFNttKyg7RU5uF15/mw6NcqFYWAWwzA9pl1KXyztWI9xTYXFu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 10DC75CCC3;
	Tue,  6 Jan 2026 21:18:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id 3CB0920028;
	Tue,  6 Jan 2026 21:18:19 +0000 (UTC)
Date: Tue, 6 Jan 2026 16:18:44 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] ftrace: Do not over-allocate ftrace memory
Message-ID: <20260106161844.02ab387f@gandalf.local.home>
In-Reply-To: <20260106203533.2896197-1-linux@roeck-us.net>
References: <20260106203533.2896197-1-linux@roeck-us.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 398iag6mazp4rdij8qg3apdgjqftjbia
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 3CB0920028
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19czADcrVFk8rSlwAWhMKb1wN7KbRAMzoI=
X-HE-Tag: 1767734299-726801
X-HE-Meta: U2FsdGVkX19O8ru7Kuun4NpJAL151HKe9hKOvGoS+x/g755WicpqI0e1/VOYpJQaNanasrbYXt1VFGjN5GW0+IL1sMQXU3eLa83Z9MU3Dup/Froguaj5Ip07HLzwYLK38aVm2DNayACvKuB2OgCLlRCox20rrO5RVon5CwGgBXKGHleZg016cOgP78qMmHp1WA8WWVzAgHrjPZB7mPpuDgylUx32iGnaSHHHgbR5KYulaRXIekbjVoYuALINlfuausN9TVMBDc4cDHzhMgGJFiFy5flX3N4Hga5vgWLPUAw38exGJvqRkNuwJxHq5d49m6MkVG9GUgpRAJ9x94172DdQ1PN6h5wQEOesu+SkDZwgEk7ZCrcdl97riLlawqDDfhb2Q1li5I9Bl7oRAo8eAqHFwW5MgdPVX8lIAPdr4ajFazNRBKWJPfe5d5gpxlrc

On Tue,  6 Jan 2026 12:35:33 -0800
Guenter Roeck <linux@roeck-us.net> wrote:

> The pg_remaining calculation in ftrace_process_locs() assumes that
> ENTRIES_PER_PAGE multiplied by 2^order equals the actual capacity of the
> allocated page group. However, ENTRIES_PER_PAGE is PAGE_SIZE / ENTRY_SIZE
> (integer division). When PAGE_SIZE is not a multiple of ENTRY_SIZE (e.g.
> 4096 / 24 = 170 with remainder 16), high-order allocations (like 256 pages)
> have significantly more capacity than 256 * 170. This leads to pg_remaining
> being underestimated, which in turn makes skip (derived from skipped -
> pg_remaining) larger than expected, causing the WARN(skip != remaining)
> to trigger.

Nice catch! I guess you have a machine that allows much higher order
allocations than I do ;-)

> 
> Extra allocated pages for ftrace: 2 with 654 skipped
> WARNING: CPU: 0 PID: 0 at kernel/trace/ftrace.c:7295 ftrace_process_locs+0x5bf/0x5e0
> 
> A similar problem in ftrace_allocate_records() can result in allocating
> too many pages. This can trigger the second warning in
> ftrace_process_locs().
> 
> Extra allocated pages for ftrace
> WARNING: CPU: 0 PID: 0 at kernel/trace/ftrace.c:7276 ftrace_process_locs+0x548/0x580
> 
> Use the actual capacity of a page group to determine if too many pages
> have been allocated to solve the problem. Also use the actual capacity
> of a page group to determine the number of pages needed to avoid over-
> allocations in ftrace_allocate_records().
> 
> Fixes: 4a3efc6baff93 ("ftrace: Update the mcount_loc check of skipped entries")
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  kernel/trace/ftrace.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index ef2d5dca6f70..211ec7a04f7e 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -3844,7 +3844,7 @@ static int ftrace_allocate_records(struct ftrace_page *pg, int count)
>  		return -EINVAL;
>  
>  	/* We want to fill as much as possible, with no empty pages */
> -	pages = DIV_ROUND_UP(count, ENTRIES_PER_PAGE);
> +	pages = DIV_ROUND_UP(count * ENTRY_SIZE, PAGE_SIZE);
>  	order = fls(pages) - 1;
>  
>   again:
> @@ -7308,24 +7308,33 @@ static int ftrace_process_locs(struct module *mod,
>  		unsigned long skip;
>  
>  		/* Count the number of entries unused and compare it to skipped. */
> -		pg_remaining = (ENTRIES_PER_PAGE << pg->order) - pg->index;
> +		pg_remaining = (PAGE_SIZE << pg->order) / ENTRY_SIZE - pg->index;
>  
>  		if (!WARN(skipped < pg_remaining, "Extra allocated pages for ftrace")) {
> +			unsigned long space = 0;
>  
>  			skip = skipped - pg_remaining;
>  
> -			for (pg = pg_unuse; pg; pg = pg->next)
> +			for (pg = pg_unuse; pg; pg = pg->next) {
>  				remaining += 1 << pg->order;
> +				/*
> +				 * The capacity of a page group is
> +				 *     (PAGE_SIZE << order) / ENTRY_SIZE
> +				 * Accumulate the total capacity of unused pages.
> +				 */
> +				space += (PAGE_SIZE << pg->order) / ENTRY_SIZE;
> +			}
>  
>  			pages -= remaining;

I think pages is meaningless here, as it was set in the beginning with:

	pages = DIV_ROUND_UP(count, ENTRIES_PER_PAGE);

Which is incorrect. I wonder if we should set it via:

	/*
	 * Use ftrace_number_of_pages to determine how many pages were
	 * allocated
	 */
	pages = ftrace_number_of_pages;

	start_pg = ftrace_allocate_pages(count);
	if (!start_pg)
		return -ENOMEM;

	/* ftrace_allocate_pages() increments ftrace_number_of_pages */
	pages = ftrace_number_of_pages - pages;

This will make pages equal the number of pages that were allocated. Then
I'm not sure we need this extra logic.

-- Steve


>  
> -			skip = DIV_ROUND_UP(skip, ENTRIES_PER_PAGE);
> -
>  			/*
> -			 * Check to see if the number of pages remaining would
> -			 * just fit the number of entries skipped.
> +			 * Check to see if extra pages have been allocated.
> +			 * Only warn if the number of unused entries is larger
> +			 * than the number of entries per page to avoid false
> +			 * positives due to rounding.
>  			 */
> -			WARN(skip != remaining, "Extra allocated pages for ftrace: %lu with %lu skipped",
> +			WARN(space - skip > ENTRIES_PER_PAGE,
> +			     "Extra allocated pages for ftrace: %lu with %lu skipped",
>  			     remaining, skipped);
>  		}
>  		/* Need to synchronize with ftrace_location_range() */

