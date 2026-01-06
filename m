Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC8E7E0FF
	for <linux-trace-kernel@vger.kernel.org>; Tue,  6 Jan 2026 22:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767738387; cv=none; b=Mg7epLoQkacykI33Lyb9V0KtYLbPQbytZCLVJ5AepQ3wm5fVDyo0lLssNq5CKcHj9I51WUKOTvHy6JlbrZrK+djGKt2QiPFLm/xCDn6susz5rBUp+Vc5eDJkMMMqLgPT65CA/Jtf+Gx2c3Q/BDun3JUF3CxMW+jk/UkLFjI0CIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767738387; c=relaxed/simple;
	bh=9C4xJyXOrqri6xysIJdWUvdgifHbTQD3B23s8Ss8Vlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ppZX0yv1NC189HwuQS9TZouq+VbvOmv40pdMaUPo0DxwsuPX0dxc8ztnzH8WcZw5QC22KL809v+IzvLgAn6mW84pZviygIAF2L1U2PkUo56vg3j9RL18WmvK6t9mHd0TwCUElUWrSLjWFba9VL2ZhRCS70cnnLAsdk6is6SG+vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AhB32d8Y; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AhB32d8Y"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2abf5900cd5so868098eec.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 06 Jan 2026 14:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767738384; x=1768343184; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/kjmn0Gkm53dEKwQ2oBGR8R7b9+ZNKMwT392qI9GhFo=;
        b=AhB32d8YPCvJJTmerr0ejbOL0sfhWvCW9HDeRl+myQllyZlVhpz8k0cSwOSzkA5qIQ
         FeR0kbtUQ2q92N7F68WFwaQ4LNdpwY0MiGJVddD34KQb4JQx5EVObSLDEtzZKf8FCkqx
         OAmYl0yCxT8QvUZBboGVm00XSit3G+kc2oGIVMiG41KOIFOG/o+wgdNaXY9cTPbmS6bL
         fdWBxAZ8SC8B5FTEWILnhlSdu65RULBq0uHw1UCgQl8uA8ITLvyIEMhYyFfWPA2f9wMJ
         m9XRsOn9Xhfwf+ogxCcC7+lxAsZTgGv7ggppj9KUdcIFFRkQOuIx8aw0dU3+ekEBayk0
         w0bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767738384; x=1768343184;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/kjmn0Gkm53dEKwQ2oBGR8R7b9+ZNKMwT392qI9GhFo=;
        b=LnnczAHwXOjmJFOAJcwDdsRYugXR5Byc/BAouX/U2iGuFBp1Alf3QqcSkrCGmH248Q
         U674ktPllseObU/m9Mx/Srn6IkKEeLv0bSrWn6DtsupQwvn+0pv4WLOpqPbgtjVkoL6W
         ugehPEbsFVO0bNDigrsg+lg7zggcope/W9J4Rwszxcr0OzyF9EvuupY7Z1+R3L6coVBu
         S5GKL3tn8LaYjcXekL49Zbt/uph/XXooxRTL+ZKYGuDExBGVV8jHlSOgogf3y8ig09tG
         AGMvMZWu2yi01Zn5wps789+7BKF3OLjNa7zc9aeBR3xfYmK3RSZMV8DmRgzi116n08Px
         Mm/Q==
X-Forwarded-Encrypted: i=1; AJvYcCU0Nl+BgB2kv2bohc2YBG+6HJYHzmuxXC39T/ChoBlNTKzRGoH8H0A8Uc3MZECBTsIZkwH21MZjCtCaFY5N17EiEsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWSG6Net1MunSgA+S2VMnfyjoqhgMYKRhZBe6J9cvFRwgPQg4z
	snWxVTVHrl/nCt3TOX78aeuaYjKCubrl6BohScjF1jl7CkFy4okzRInQ
X-Gm-Gg: AY/fxX7gQebKOKxDx7pX2veQa5TZgvHew9wRegNypwKxm+9yYo7Nqt8DIMi7zx1V8Sr
	lQMym5/JOqW3WBVsAKndkrasa/+lkLmf66QT9KpwfKxf4PNcjNssZwZNs7fVv+AOsmFiW50yfJP
	oMyOBvMV70ON8rsNkdWxpygKYypdnPPUqiBgKkjCNrK/vGVvKVtwGgYmzIFtwTdP8FEwu4tLVmv
	yuL2g5pKpCcC4Fg+D00VvuCwgKA1nej2ZzeB8peMKesUKVmvZyXXsznF0634DxJek9wSUuQS/Y6
	ochPJTpJDf2PW/T0yncth8YlkCt1C0pSEtha+D6bZ2oQRoCmm9N9BP+zpIZCaFozZGxOvnUflN8
	gizeLc/ANjq2NCbbA3dXzLejSnOPrjTv0RHxlrWGeEZVtHfII39DwJIv9FdrCgLE3Z69Wagk1GK
	1zeJmLendBcz/FKxbIzGTto4Wy
X-Google-Smtp-Source: AGHT+IHHheezepTswBiukzyPRzPdj4aYFP9A5Xbf5sahVwHloo1EodEYskLxmT9EJp6qR8GEVUeYpg==
X-Received: by 2002:a05:7300:a14a:b0:2b0:520c:df62 with SMTP id 5a478bee46e88-2b17d235272mr481939eec.19.1767738383638;
        Tue, 06 Jan 2026 14:26:23 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b1707d7fc9sm5253730eec.35.2026.01.06.14.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 14:26:23 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 6 Jan 2026 14:26:21 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] ftrace: Do not over-allocate ftrace memory
Message-ID: <dc80ae8e-54f6-45f0-bf2f-69012c3b47aa@roeck-us.net>
References: <20260106203533.2896197-1-linux@roeck-us.net>
 <20260106161844.02ab387f@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106161844.02ab387f@gandalf.local.home>

Hi Steven,

On Tue, Jan 06, 2026 at 04:18:44PM -0500, Steven Rostedt wrote:
> On Tue,  6 Jan 2026 12:35:33 -0800
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
> > The pg_remaining calculation in ftrace_process_locs() assumes that
> > ENTRIES_PER_PAGE multiplied by 2^order equals the actual capacity of the
> > allocated page group. However, ENTRIES_PER_PAGE is PAGE_SIZE / ENTRY_SIZE
> > (integer division). When PAGE_SIZE is not a multiple of ENTRY_SIZE (e.g.
> > 4096 / 24 = 170 with remainder 16), high-order allocations (like 256 pages)
> > have significantly more capacity than 256 * 170. This leads to pg_remaining
> > being underestimated, which in turn makes skip (derived from skipped -
> > pg_remaining) larger than expected, causing the WARN(skip != remaining)
> > to trigger.
> 
> Nice catch! I guess you have a machine that allows much higher order
> allocations than I do ;-)
> 

I have actually seen the problem when the system tried to allocate 341
entries. 2 x 170 = 340, so the code allocated three pages, and things
went downhill from there.

Here is a specific example of the allocation sequence with debug
information.

ftrace_allocate_records: Requesting 52904 entries: 310 pages [order 8]. Alternate: 312 pages [order 8]
Allocated 43690 records, 9214 remaining
ftrace_allocate_records: Requesting 9214 entries: 54 pages [order 5]. Alternate: 55 pages [order 5]
Allocated 5461 records, 3753 remaining
ftrace_allocate_records: Requesting 3753 entries: 22 pages [order 4]. Alternate: 23 pages [order 4]
Allocated 2730 records, 1023 remaining
ftrace_allocate_records: Requesting 1023 entries: 6 pages [order 2]. Alternate: 7 pages [order 2]
Allocated 682 records, 341 remaining
ftrace_allocate_records: Requesting 341 entries: 2 pages [order 1]. Alternate: 3 pages [order 1]
Allocated 341 records, 0 remaining

The description above is just a more extreme example. 

> > 
> > Extra allocated pages for ftrace: 2 with 654 skipped
> > WARNING: CPU: 0 PID: 0 at kernel/trace/ftrace.c:7295 ftrace_process_locs+0x5bf/0x5e0
> > 
> > A similar problem in ftrace_allocate_records() can result in allocating
> > too many pages. This can trigger the second warning in
> > ftrace_process_locs().
> > 
> > Extra allocated pages for ftrace
> > WARNING: CPU: 0 PID: 0 at kernel/trace/ftrace.c:7276 ftrace_process_locs+0x548/0x580
> > 
> > Use the actual capacity of a page group to determine if too many pages
> > have been allocated to solve the problem. Also use the actual capacity
> > of a page group to determine the number of pages needed to avoid over-
> > allocations in ftrace_allocate_records().
> > 
> > Fixes: 4a3efc6baff93 ("ftrace: Update the mcount_loc check of skipped entries")
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> >  kernel/trace/ftrace.c | 25 +++++++++++++++++--------
> >  1 file changed, 17 insertions(+), 8 deletions(-)
> > 
> > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > index ef2d5dca6f70..211ec7a04f7e 100644
> > --- a/kernel/trace/ftrace.c
> > +++ b/kernel/trace/ftrace.c
> > @@ -3844,7 +3844,7 @@ static int ftrace_allocate_records(struct ftrace_page *pg, int count)
> >  		return -EINVAL;
> >  
> >  	/* We want to fill as much as possible, with no empty pages */
> > -	pages = DIV_ROUND_UP(count, ENTRIES_PER_PAGE);
> > +	pages = DIV_ROUND_UP(count * ENTRY_SIZE, PAGE_SIZE);
> >  	order = fls(pages) - 1;
> >  
> >   again:
> > @@ -7308,24 +7308,33 @@ static int ftrace_process_locs(struct module *mod,
> >  		unsigned long skip;
> >  
> >  		/* Count the number of entries unused and compare it to skipped. */
> > -		pg_remaining = (ENTRIES_PER_PAGE << pg->order) - pg->index;
> > +		pg_remaining = (PAGE_SIZE << pg->order) / ENTRY_SIZE - pg->index;
> >  
> >  		if (!WARN(skipped < pg_remaining, "Extra allocated pages for ftrace")) {
> > +			unsigned long space = 0;
> >  
> >  			skip = skipped - pg_remaining;
> >  
> > -			for (pg = pg_unuse; pg; pg = pg->next)
> > +			for (pg = pg_unuse; pg; pg = pg->next) {
> >  				remaining += 1 << pg->order;
> > +				/*
> > +				 * The capacity of a page group is
> > +				 *     (PAGE_SIZE << order) / ENTRY_SIZE
> > +				 * Accumulate the total capacity of unused pages.
> > +				 */
> > +				space += (PAGE_SIZE << pg->order) / ENTRY_SIZE;
> > +			}
> >  
> >  			pages -= remaining;
> 
> I think pages is meaningless here, as it was set in the beginning with:
> 
> 	pages = DIV_ROUND_UP(count, ENTRIES_PER_PAGE);
> 
> Which is incorrect. I wonder if we should set it via:
> 
I know, I just didn't want to make more changes than absolutely
necessary.

> 	/*
> 	 * Use ftrace_number_of_pages to determine how many pages were
> 	 * allocated
> 	 */
> 	pages = ftrace_number_of_pages;
> 
> 	start_pg = ftrace_allocate_pages(count);
> 	if (!start_pg)
> 		return -ENOMEM;
> 
> 	/* ftrace_allocate_pages() increments ftrace_number_of_pages */
> 	pages = ftrace_number_of_pages - pages;
> 

That might work, assuming that the code updating ftrace_number_of_pages
is (mutex) protected. I don't immediately see that, and the
"mutex_lock(&ftrace_lock);" right after the above code makes me a bit
concerned.

> This will make pages equal the number of pages that were allocated. Then
> I'm not sure we need this extra logic.
> 

Which extra logic do you refer to ? Everything in "if (pg_unused)"
except for the calls to synchronize_rcu() and ftrace_free_pages() ?
If so I'll be more than happy to drop that.

Thanks,
Guenter
