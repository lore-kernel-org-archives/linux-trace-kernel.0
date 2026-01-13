Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485363A1DB
	for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Jan 2026 00:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768263360; cv=none; b=ZRJuYeSv6zaGEgrOGxUj+klHGyJ8kiqeoiuV+V+OF7VPa7O4cVmLn21+9Vo/F4aHndPMkwXvGm/JCOXx2IDEBevtJtf6dj2/iakbMbxZEUnrEYXRjjvMEhiEf57uBEThSsrMiI7sBvzfLI6PWMTHRdFcCYvMSMDYtn6n6aR+tgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768263360; c=relaxed/simple;
	bh=LfLuMiuPwUZYVu+ch/6cGjOdUBBKz5uqQbaJS4eUh5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eONZwn5BLUt6uUI7nLXmEX2H0yhZui/3Bn9FkI1TbL69UtSs0HsV/eL5DPuTk+uKUZjObsmtcBG5He5V56UFGTl4Rxbyxea28qJaicyIVdL+zekOr6wi8nf9S+VlzMyyKPxrQ70QRY/cJBrIg2KmKSecsONkEiaUXXcqx6hDhK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DoQnsoML; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DoQnsoML"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2b04a410f42so6013668eec.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 12 Jan 2026 16:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768263358; x=1768868158; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=DoaG67i179CxQpHb06fKOIK1Sxs17mDYBvMBBmF2CHk=;
        b=DoQnsoMLngGGNzyysGknwe/ufBO3eA2m613a9eHVdA9Mspr2b18rsVyjjk8gOyYi2+
         Kyq6dtZ3UCX++kg1U6SmJYbMTXRfvxg/WTDf66+Jf8G4nFs54pVcLCt3c9ORH5IxL+hY
         yAZYUw0RB42EPGyR4GAwGNmcR5R1ybzJdraiBheEWx9EjtjYUM/6kpmsApS6+1sfWm4M
         wku99zA4C5bfZBzy1gi64GnaKlHSc3KmihEF/WBRMNtU/lGP9Vlj46oPKL7Hw8MjuII+
         y1ohTTktfmOfuaNl+8QahbuMHvE8GSSe0xNoxkWUGfbRcvVYBmeRwf3MT2QLbWRqvriV
         7YKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768263358; x=1768868158;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DoaG67i179CxQpHb06fKOIK1Sxs17mDYBvMBBmF2CHk=;
        b=R4T9CVabFD1DTFLeV+IZtRdAsp3vX24Bbvc2KLL7gTBt/HbzrPC3CuIZtUUjdsz/eo
         jkGFau7f5frZisnBiGyyHc149Rpu8CmN4bkx3APZkg7bd5hm67uEk+wFvMNicWNTNi9t
         QNSuuuBCFYiIYMh32DbN/BLiNERdiV4p+MeqeSRVvdmMeuBEHSffjCyH9YyoOAsiKMTV
         TEh5jKgyTUhbl0KSctHGT6s1wd53nr4zENReJcEa0Ui9KwGGy22R//oCpuSFlMNDHKN7
         AGcgGDA02qWYIHLCyp/ueVsWDvTQ0VRuSqTgjLXfu9wqm0dBLlN2JYB6KNgCvEl9R0dg
         T9/w==
X-Forwarded-Encrypted: i=1; AJvYcCX3/L7+AB5aYE1netkENUj+7sQo+xy+E2NcTaJVgh2C+SoQgAOzRsg72Ja9gq4x0BPMzHZXfTkKOuIjWvpY/9XfHVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxabmMztBMX0YEaN9lhhEmAyA/OhWR+fQVqcP/2He1pEGIXuP1F
	kqqEkapUQx/jvqzeNnUI7d9ZFswnwMWBhZ+XEAhIisEKzpVgj/5lBnYc
X-Gm-Gg: AY/fxX6LQ1GgQFUXyNIic3SXiv2p3kB6kcMJAEwckZ541l8JcLKt9rJF60DUfHyCSOx
	EmDq+MHMfthCylYqvvMn7TDue5tUM1EiKkrfrfD09FebL8d9yBVsq7Ezq29QBXUYkYJ6OGd0tN8
	Sl8gXMRbNF3VSl+cGA/rSHu54JTBRCZ4qO2vrR3/aC9mUjk76uSjcKn4+UtvIYh+/Xnyi/HlL/D
	4N5YnBJZZZjQkC9LOTQ3AzOQA1sscrg/0sgV0x1cV7HRcQsIeau7QwQ2UzLgdLwJL1uHEYCM9dh
	X7fLjGTbud2ImEn9ezqTm39dXxLuaxMaLj5K6CqR7bJhjDuKIAo9ZHrM992UoQvU5FPq9cJF1gn
	d1/oEkAmvnvCK7Lyah4wSFBxnDbH5Hf0MbqIYXg7oZTZ6xh6etFzNWS38kV44Kau9Kv4YfiMZZv
	VZ+nXhOui6W3XCA4N/xa40bxZT8jEI0wbgYjOhQLzRX/8grYJf8MmQ7hXIX5OT7Q818rNoDMQ=
X-Google-Smtp-Source: AGHT+IHC7v8fjzVx9ziZioQESZFtYbykwiyUNQ56LuZnPoR3xrVIkaE9krRSfMz0Aoptdh0z+EtwfA==
X-Received: by 2002:a05:7301:4301:b0:2ab:ca55:89ab with SMTP id 5a478bee46e88-2b17d357488mr13611621eec.42.1768263358289;
        Mon, 12 Jan 2026 16:15:58 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b1706c503csm20157678eec.15.2026.01.12.16.15.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 16:15:57 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <bde55f7c-7f13-4bb3-8a54-942704d4fe37@roeck-us.net>
Date: Mon, 12 Jan 2026 16:15:56 -0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ftrace: Do not over-allocate ftrace memory
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20260107022221.2907717-1-linux@roeck-us.net>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260107022221.2907717-1-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Steven,

On 1/6/26 18:22, Guenter Roeck wrote:
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
> pages to avoid having to calculate it. Use the actual page group capacity
> when validating the number of unused pages due to skipped entries.
> Drop the definition of ENTRIES_PER_PAGE since it is no longer used.
> 
> Fixes: 4a3efc6baff93 ("ftrace: Update the mcount_loc check of skipped entries")
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v3: Restore the code calculating the number of unused pages due to skipped
>      entries. Use the actual number of entries per page group when
>      calculating the number of entries in unused page groups.
> v2: Have ftrace_allocate_pages() return the number of allocated pages,
>      and drop the page count calculation code as well as the associated
>      warnings from ftrace_process_locs().

Any additional feedback / comments / suggestions ?

Thanks,
Guenter

> 
>   kernel/trace/ftrace.c | 29 +++++++++++++++--------------
>   1 file changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index ef2d5dca6f70..2c9692b45215 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -1148,7 +1148,6 @@ struct ftrace_page {
>   };
>   
>   #define ENTRY_SIZE sizeof(struct dyn_ftrace)
> -#define ENTRIES_PER_PAGE (PAGE_SIZE / ENTRY_SIZE)
>   
>   static struct ftrace_page	*ftrace_pages_start;
>   static struct ftrace_page	*ftrace_pages;
> @@ -3834,7 +3833,8 @@ static int ftrace_update_code(struct module *mod, struct ftrace_page *new_pgs)
>   	return 0;
>   }
>   
> -static int ftrace_allocate_records(struct ftrace_page *pg, int count)
> +static int ftrace_allocate_records(struct ftrace_page *pg, int count,
> +				   unsigned long *num_pages)
>   {
>   	int order;
>   	int pages;
> @@ -3844,7 +3844,7 @@ static int ftrace_allocate_records(struct ftrace_page *pg, int count)
>   		return -EINVAL;
>   
>   	/* We want to fill as much as possible, with no empty pages */
> -	pages = DIV_ROUND_UP(count, ENTRIES_PER_PAGE);
> +	pages = DIV_ROUND_UP(count * ENTRY_SIZE, PAGE_SIZE);
>   	order = fls(pages) - 1;
>   
>    again:
> @@ -3859,6 +3859,7 @@ static int ftrace_allocate_records(struct ftrace_page *pg, int count)
>   	}
>   
>   	ftrace_number_of_pages += 1 << order;
> +	*num_pages += 1 << order;
>   	ftrace_number_of_groups++;
>   
>   	cnt = (PAGE_SIZE << order) / ENTRY_SIZE;
> @@ -3887,12 +3888,14 @@ static void ftrace_free_pages(struct ftrace_page *pages)
>   }
>   
>   static struct ftrace_page *
> -ftrace_allocate_pages(unsigned long num_to_init)
> +ftrace_allocate_pages(unsigned long num_to_init, unsigned long *pages)
>   {
>   	struct ftrace_page *start_pg;
>   	struct ftrace_page *pg;
>   	int cnt;
>   
> +	*pages = 0;
> +
>   	if (!num_to_init)
>   		return NULL;
>   
> @@ -3906,7 +3909,7 @@ ftrace_allocate_pages(unsigned long num_to_init)
>   	 * waste as little space as possible.
>   	 */
>   	for (;;) {
> -		cnt = ftrace_allocate_records(pg, num_to_init);
> +		cnt = ftrace_allocate_records(pg, num_to_init, pages);
>   		if (cnt < 0)
>   			goto free_pages;
>   
> @@ -7192,8 +7195,6 @@ static int ftrace_process_locs(struct module *mod,
>   	if (!count)
>   		return 0;
>   
> -	pages = DIV_ROUND_UP(count, ENTRIES_PER_PAGE);
> -
>   	/*
>   	 * Sorting mcount in vmlinux at build time depend on
>   	 * CONFIG_BUILDTIME_MCOUNT_SORT, while mcount loc in
> @@ -7206,7 +7207,7 @@ static int ftrace_process_locs(struct module *mod,
>   		test_is_sorted(start, count);
>   	}
>   
> -	start_pg = ftrace_allocate_pages(count);
> +	start_pg = ftrace_allocate_pages(count, &pages);
>   	if (!start_pg)
>   		return -ENOMEM;
>   
> @@ -7305,27 +7306,27 @@ static int ftrace_process_locs(struct module *mod,
>   	/* We should have used all pages unless we skipped some */
>   	if (pg_unuse) {
>   		unsigned long pg_remaining, remaining = 0;
> -		unsigned long skip;
> +		long skip;
>   
>   		/* Count the number of entries unused and compare it to skipped. */
> -		pg_remaining = (ENTRIES_PER_PAGE << pg->order) - pg->index;
> +		pg_remaining = (PAGE_SIZE << pg->order) / ENTRY_SIZE - pg->index;
>   
>   		if (!WARN(skipped < pg_remaining, "Extra allocated pages for ftrace")) {
>   
>   			skip = skipped - pg_remaining;
>   
> -			for (pg = pg_unuse; pg; pg = pg->next)
> +			for (pg = pg_unuse; pg && skip > 0; pg = pg->next) {
>   				remaining += 1 << pg->order;
> +				skip -= (PAGE_SIZE << pg->order) / ENTRY_SIZE;
> +			}
>   
>   			pages -= remaining;
>   
> -			skip = DIV_ROUND_UP(skip, ENTRIES_PER_PAGE);
> -
>   			/*
>   			 * Check to see if the number of pages remaining would
>   			 * just fit the number of entries skipped.
>   			 */
> -			WARN(skip != remaining, "Extra allocated pages for ftrace: %lu with %lu skipped",
> +			WARN(pg || skip > 0, "Extra allocated pages for ftrace: %lu with %lu skipped",
>   			     remaining, skipped);
>   		}
>   		/* Need to synchronize with ftrace_location_range() */

