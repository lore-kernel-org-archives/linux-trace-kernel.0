Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726D61E991B;
	Wed,  7 Jan 2026 00:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767746643; cv=none; b=Qhyhgw/JlsEFwaBvgPO5J1DIQoiobDPf1NC1xMirAc6CHDEW6FosHEfSt9xVXSL2Ot9vOLIvfuHLlSGsgmqd+xVPu0oU4z6MSyUwbeHvxVt7ui9AxeEXw91X332ludUfKXa80LkDGVTKpJXNX0PjDg55pbEbMVERHi8JykqsAH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767746643; c=relaxed/simple;
	bh=KPgSHWwBfTyXnhlVZsxXsQuFw36XifQrU5KVnoDpHFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b1G6Lj31MlnMbpTget+0sL8eQThIVhYF/COrg4RRHRHBjhmy6RAl/jiR4KSf6DR3lUnaXntsbtEOFJ/O8yvSmfsldSb95DI5sZFv3WvXJIEJXiY38iEWesbZVXfEUqxT7WlrefBdW7aSK/XygRCeh9aEhvu9zrOXkCLvW0wfKD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 2EACB1AD880;
	Wed,  7 Jan 2026 00:43:59 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id 689208000E;
	Wed,  7 Jan 2026 00:43:57 +0000 (UTC)
Date: Tue, 6 Jan 2026 19:43:55 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ftrace: Do not over-allocate ftrace memory
Message-ID: <20260106194355.66cf869e@fedora>
In-Reply-To: <20260107002428.2904852-1-linux@roeck-us.net>
References: <20260107002428.2904852-1-linux@roeck-us.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 6aic6xu6nfwic8oqmh8cykqpt884o3u7
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 689208000E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+Amp2+R0DZzS9P1HVJuuBR5RmBiA/b57A=
X-HE-Tag: 1767746637-242430
X-HE-Meta: U2FsdGVkX190+KELTxXQEcLMWoeVOQmeSkPX2RwwO9+V/3Qx81FWrOWXyGxtP0JdJYK8EWpd6aiLVMaeLSo0PY1aC8rRInYhQS6wrbdefnMvSnBMcQXTDDq5+jVxMcBqPd3vh5zDkHpCeVhc1OsUintYFsDID/OesDf+XUobI1CQ3P1bZMmSCmnU/g46ZdastBOdFhJYHDNStl1lqyhnTlG+xWf5kUNlnXUblFHrunXno33fiEs0h+9/co3G8/4Lp4JpXaA7vZ0nUF8AzZwCrVwP5TTQdh7yjlBCU9N7m1nEknbNQUHyhTvTIKGZBYxsejZXfmxXRNeAnyavFlgjdashqZ8u/cYzsSPmoC6JmxnGWAu+jVIoWXzUAEBrdqg8SUI6/YGaJPtKV3o8MqwRGrMR1NmI4QUXOgaGdiF527/iD19bxDtnK7rjK6J+Ycgo

On Tue,  6 Jan 2026 16:24:28 -0800
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
> Use the actual capacity of a page group to determine the number of pages
> to allocate. Have ftrace_allocate_pages() return the number of allocated
> pages to avoid having to calculate it. Drop the code calculating the
> actual page count since it is no longer needed, and with it the warning
> backtraces. Also drop the ENTRIES_PER_PAGE definition since it is no longer
> needed either.
> 
> Fixes: 4a3efc6baff93 ("ftrace: Update the mcount_loc check of skipped entries")
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Have ftrace_allocate_pages() return the number of allocated pages,
>     and drop the page count calculation code as well as the associated
>     warnings from ftrace_process_locs().
> 
>  kernel/trace/ftrace.c | 41 +++++++++--------------------------------
>  1 file changed, 9 insertions(+), 32 deletions(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index ef2d5dca6f70..755a11f13808 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -1148,7 +1148,6 @@ struct ftrace_page {
>  };
>  
>  #define ENTRY_SIZE sizeof(struct dyn_ftrace)
> -#define ENTRIES_PER_PAGE (PAGE_SIZE / ENTRY_SIZE)
>  
>  static struct ftrace_page	*ftrace_pages_start;
>  static struct ftrace_page	*ftrace_pages;
> @@ -3834,7 +3833,8 @@ static int ftrace_update_code(struct module *mod, struct ftrace_page *new_pgs)
>  	return 0;
>  }
>  
> -static int ftrace_allocate_records(struct ftrace_page *pg, int count)
> +static int ftrace_allocate_records(struct ftrace_page *pg, int count,
> +				   unsigned long *num_pages)
>  {
>  	int order;
>  	int pages;
> @@ -3844,7 +3844,7 @@ static int ftrace_allocate_records(struct ftrace_page *pg, int count)
>  		return -EINVAL;
>  
>  	/* We want to fill as much as possible, with no empty pages */
> -	pages = DIV_ROUND_UP(count, ENTRIES_PER_PAGE);
> +	pages = DIV_ROUND_UP(count * ENTRY_SIZE, PAGE_SIZE);
>  	order = fls(pages) - 1;
>  
>   again:
> @@ -3859,6 +3859,7 @@ static int ftrace_allocate_records(struct ftrace_page *pg, int count)
>  	}
>  
>  	ftrace_number_of_pages += 1 << order;
> +	*num_pages += 1 << order;
>  	ftrace_number_of_groups++;
>  
>  	cnt = (PAGE_SIZE << order) / ENTRY_SIZE;
> @@ -3887,12 +3888,14 @@ static void ftrace_free_pages(struct ftrace_page *pages)
>  }
>  
>  static struct ftrace_page *
> -ftrace_allocate_pages(unsigned long num_to_init)
> +ftrace_allocate_pages(unsigned long num_to_init, unsigned long *pages)
>  {
>  	struct ftrace_page *start_pg;
>  	struct ftrace_page *pg;
>  	int cnt;
>  
> +	*pages = 0;
> +
>  	if (!num_to_init)
>  		return NULL;
>  
> @@ -3906,7 +3909,7 @@ ftrace_allocate_pages(unsigned long num_to_init)
>  	 * waste as little space as possible.
>  	 */
>  	for (;;) {
> -		cnt = ftrace_allocate_records(pg, num_to_init);
> +		cnt = ftrace_allocate_records(pg, num_to_init, pages);
>  		if (cnt < 0)
>  			goto free_pages;
>  
> @@ -7192,8 +7195,6 @@ static int ftrace_process_locs(struct module *mod,
>  	if (!count)
>  		return 0;
>  
> -	pages = DIV_ROUND_UP(count, ENTRIES_PER_PAGE);
> -
>  	/*
>  	 * Sorting mcount in vmlinux at build time depend on
>  	 * CONFIG_BUILDTIME_MCOUNT_SORT, while mcount loc in
> @@ -7206,7 +7207,7 @@ static int ftrace_process_locs(struct module *mod,
>  		test_is_sorted(start, count);
>  	}
>  
> -	start_pg = ftrace_allocate_pages(count);
> +	start_pg = ftrace_allocate_pages(count, &pages);
>  	if (!start_pg)
>  		return -ENOMEM;
>  
> @@ -7304,30 +7305,6 @@ static int ftrace_process_locs(struct module *mod,
>  
>  	/* We should have used all pages unless we skipped some */
>  	if (pg_unuse) {
> -		unsigned long pg_remaining, remaining = 0;
> -		unsigned long skip;
> -
> -		/* Count the number of entries unused and compare it to skipped. */
> -		pg_remaining = (ENTRIES_PER_PAGE << pg->order) - pg->index;
> -
> -		if (!WARN(skipped < pg_remaining, "Extra allocated pages for ftrace")) {
> -
> -			skip = skipped - pg_remaining;
> -
> -			for (pg = pg_unuse; pg; pg = pg->next)
> -				remaining += 1 << pg->order;
> -
> -			pages -= remaining;
> -
> -			skip = DIV_ROUND_UP(skip, ENTRIES_PER_PAGE);
> -
> -			/*
> -			 * Check to see if the number of pages remaining would
> -			 * just fit the number of entries skipped.
> -			 */
> -			WARN(skip != remaining, "Extra allocated pages for ftrace: %lu with %lu skipped",
> -			     remaining, skipped);
> -		}

Don't remove this block. It's still needed. A lot of entries are
skipped when adding the records. Weak functions and zero'd pointers
that were part of the count are skipped. This is the code that handles
that. It has nothing to do with rounding errors.

-- Steve


>  		/* Need to synchronize with ftrace_location_range() */
>  		synchronize_rcu();
>  		ftrace_free_pages(pg_unuse);

