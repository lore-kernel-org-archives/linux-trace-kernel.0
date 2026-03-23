Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6064F366558;
	Mon, 23 Mar 2026 11:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774266613; cv=none; b=DeFbNyS1RY19wq3Ntazz8KZs5fQYD+NkxZ17U4FqNnNVVmszzmuPPJLqP3ExSM2M76JpUJ4LkoXq8gLw+YxX4LsyzOF/jxQsHHhmarFBZofkZXlA0IH+451xrlb1PbClTSd4Yrx5TmyO67uyuEToaVdft66OvM+pypDBo+TT3Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774266613; c=relaxed/simple;
	bh=2E2pCXRCjUmFwJ1p11lXSuychCLwf00vUaVSi1BRtIw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=gCp6P4MVppfp3oeIyaNRDyw1w/QAE6mGBb0leGxIo6qH5V7glh/SCIE+1DJx0NptObJOCRa5I0Aa0133KdRmN5M1aRD3X/PM2BC8VVxZY8TuwUWAWi/P0bjUOHzDvyUr0FbJn5qlYtrKUxOcmQ1cnSeWvhM3gY/1W/VRdNzk/9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sQJ4gOcY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sQJ4gOcY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35974C4CEF7;
	Mon, 23 Mar 2026 11:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774266613;
	bh=2E2pCXRCjUmFwJ1p11lXSuychCLwf00vUaVSi1BRtIw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sQJ4gOcYn5CHTLDUzJguOYEsSzHqNQ7pUN9CewGnJ7LFPD2l7Up7MJriZfedUxhMC
	 24fkswbsYdCWDHa6wAyaaif0aDEGawqXo7Y/q/z6Qfrvji2/KSe6edlhOJ3mSHupik
	 Qh6eATtzVv606HrLw7aWXR1q+I+hIvoQoN4sK3OTZ1i4IHCdPuvEdOcrAIR3sfVxzA
	 mMP023nE2ydody6P7mExHD+4mLCV3XCgjuI2I9xD/KKV8kO92A/MF3d/o2bpEFOy87
	 0SOkNOOnz8wZ/ZOxlJb9PDKRGt4cp1s7Z+iy9OslZaGXxg5cSpCUeFwhcrnWB6pRzo
	 f09h+Mrqmib/Q==
Date: Mon, 23 Mar 2026 20:50:09 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, llvm@lists.linux.dev,
 oe-kbuild-all@lists.linux.dev, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v11 4/5] ring-buffer: Skip invalid sub-buffers when
 rewinding persistent ring buffer
Message-Id: <20260323205009.2f4185f62cbd6103a0f892e1@kernel.org>
In-Reply-To: <202603230725.uMAZiKJx-lkp@intel.com>
References: <177391156211.193994.7531495945584650297.stgit@mhiramat.tok.corp.google.com>
	<202603230725.uMAZiKJx-lkp@intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Mar 2026 07:18:07 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi Masami,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on trace/for-next]
> [also build test ERROR on geert-m68k/for-next geert-m68k/for-linus openrisc/for-next deller-parisc/for-next powerpc/next powerpc/fixes s390/features uml/next tip/x86/core uml/fixes v7.0-rc4 next-20260320]
> [cannot apply to linus/master]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Masami-Hiramatsu-Google/ring-buffer-Fix-to-update-per-subbuf-entries-of-persistent-ring-buffer/20260322-122412
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
> patch link:    https://lore.kernel.org/r/177391156211.193994.7531495945584650297.stgit%40mhiramat.tok.corp.google.com
> patch subject: [PATCH v11 4/5] ring-buffer: Skip invalid sub-buffers when rewinding persistent ring buffer
> config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260323/202603230725.uMAZiKJx-lkp@intel.com/config)
> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260323/202603230725.uMAZiKJx-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202603230725.uMAZiKJx-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
> >> kernel/trace/ring_buffer.c:1965:15: error: use of undeclared identifier 'bpage'
>     1965 |                         local_set(&bpage->entries, 0);
>          |                                    ^
>    kernel/trace/ring_buffer.c:1966:15: error: use of undeclared identifier 'bpage'
>     1966 |                         local_set(&bpage->page->commit, 0);
>          |                                    ^
>    2 errors generated.
> 
> 
> vim +/bpage +1965 kernel/trace/ring_buffer.c
> 
>   1910	
>   1911	/* If the meta data has been validated, now validate the events */
>   1912	static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
>   1913	{
>   1914		struct ring_buffer_cpu_meta *meta = cpu_buffer->ring_meta;
>   1915		struct buffer_page *head_page, *orig_head;
>   1916		unsigned long entry_bytes = 0;
>   1917		unsigned long entries = 0;
>   1918		int discarded = 0;
>   1919		int ret;
>   1920		u64 ts;
>   1921		int i;
>   1922	
>   1923		if (!meta || !meta->head_buffer)
>   1924			return;
>   1925	
>   1926		orig_head = head_page = cpu_buffer->head_page;
>   1927	
>   1928		/* Do the reader page first */
>   1929		ret = rb_validate_buffer(cpu_buffer->reader_page, cpu_buffer->cpu, meta);
>   1930		if (ret < 0) {
>   1931			pr_info("Ring buffer meta [%d] invalid reader page detected\n",
>   1932				cpu_buffer->cpu);
>   1933			discarded++;
>   1934		} else {
>   1935			entries += ret;
>   1936			entry_bytes += rb_page_size(cpu_buffer->reader_page);
>   1937		}
>   1938	
>   1939		ts = head_page->page->time_stamp;
>   1940	
>   1941		/*
>   1942		 * Try to rewind the head so that we can read the pages which already
>   1943		 * read in the previous boot.
>   1944		 */
>   1945		if (head_page == cpu_buffer->tail_page)
>   1946			goto skip_rewind;
>   1947	
>   1948		rb_dec_page(&head_page);
>   1949		for (i = 0; i < meta->nr_subbufs + 1; i++, rb_dec_page(&head_page)) {
>   1950	
>   1951			/* Rewind until tail (writer) page. */
>   1952			if (head_page == cpu_buffer->tail_page)
>   1953				break;
>   1954	
>   1955			/* Rewind until unused page (no timestamp, no commit). */
>   1956			if (!head_page->page->time_stamp && rb_page_commit(head_page) == 0)
>   1957				break;
>   1958	
>   1959			/*
>   1960			 * Skip if the page is invalid, or its timestamp is newer than the
>   1961			 * previous valid page.
>   1962			 */
>   1963			ret = rb_validate_buffer(head_page, cpu_buffer->cpu, meta);
>   1964			if (ret >= 0 && ts < head_page->page->time_stamp) {
> > 1965				local_set(&bpage->entries, 0);
>   1966				local_set(&bpage->page->commit, 0);

Ooops, sorry, I made a copy & paste mistake. this should be head_page->entries and head_page->page_commit.
Let me send v12 on the latest tracing/fixes.

Thanks,

>   1967				head_page->page->time_stamp = ts;
>   1968				ret = -1;
>   1969			}
>   1970			if (ret < 0) {
>   1971				if (!discarded)
>   1972					pr_info("Ring buffer meta [%d] invalid buffer page detected\n",
>   1973						cpu_buffer->cpu);
>   1974				discarded++;
>   1975			} else {
>   1976				entries += ret;
>   1977				entry_bytes += rb_page_size(head_page);
>   1978				if (ret > 0)
>   1979					local_inc(&cpu_buffer->pages_touched);
>   1980				ts = head_page->page->time_stamp;
>   1981			}
>   1982		}
>   1983		if (i)
>   1984			pr_info("Ring buffer [%d] rewound %d pages\n", cpu_buffer->cpu, i);
>   1985	
>   1986		/* The last rewound page must be skipped. */
>   1987		if (head_page != orig_head)
>   1988			rb_inc_page(&head_page);
>   1989	
>   1990		/*
>   1991		 * If the ring buffer was rewound, then inject the reader page
>   1992		 * into the location just before the original head page.
>   1993		 */
>   1994		if (head_page != orig_head) {
>   1995			struct buffer_page *bpage = orig_head;
>   1996	
>   1997			rb_dec_page(&bpage);
>   1998			/*
>   1999			 * Insert the reader_page before the original head page.
>   2000			 * Since the list encode RB_PAGE flags, general list
>   2001			 * operations should be avoided.
>   2002			 */
>   2003			cpu_buffer->reader_page->list.next = &orig_head->list;
>   2004			cpu_buffer->reader_page->list.prev = orig_head->list.prev;
>   2005			orig_head->list.prev = &cpu_buffer->reader_page->list;
>   2006			bpage->list.next = &cpu_buffer->reader_page->list;
>   2007	
>   2008			/* Make the head_page the reader page */
>   2009			cpu_buffer->reader_page = head_page;
>   2010			bpage = head_page;
>   2011			rb_inc_page(&head_page);
>   2012			head_page->list.prev = bpage->list.prev;
>   2013			rb_dec_page(&bpage);
>   2014			bpage->list.next = &head_page->list;
>   2015			rb_set_list_to_head(&bpage->list);
>   2016			cpu_buffer->pages = &head_page->list;
>   2017	
>   2018			cpu_buffer->head_page = head_page;
>   2019			meta->head_buffer = (unsigned long)head_page->page;
>   2020	
>   2021			/* Reset all the indexes */
>   2022			bpage = cpu_buffer->reader_page;
>   2023			meta->buffers[0] = rb_meta_subbuf_idx(meta, bpage->page);
>   2024			bpage->id = 0;
>   2025	
>   2026			for (i = 1, bpage = head_page; i < meta->nr_subbufs;
>   2027			     i++, rb_inc_page(&bpage)) {
>   2028				meta->buffers[i] = rb_meta_subbuf_idx(meta, bpage->page);
>   2029				bpage->id = i;
>   2030			}
>   2031	
>   2032			/* We'll restart verifying from orig_head */
>   2033			head_page = orig_head;
>   2034		}
>   2035	
>   2036	 skip_rewind:
>   2037		/* If the commit_buffer is the reader page, update the commit page */
>   2038		if (meta->commit_buffer == (unsigned long)cpu_buffer->reader_page->page) {
>   2039			cpu_buffer->commit_page = cpu_buffer->reader_page;
>   2040			/* Nothing more to do, the only page is the reader page */
>   2041			goto done;
>   2042		}
>   2043	
>   2044		/* Iterate until finding the commit page */
>   2045		for (i = 0; i < meta->nr_subbufs + 1; i++, rb_inc_page(&head_page)) {
>   2046	
>   2047			/* Reader page has already been done */
>   2048			if (head_page == cpu_buffer->reader_page)
>   2049				continue;
>   2050	
>   2051			ret = rb_validate_buffer(head_page, cpu_buffer->cpu, meta);
>   2052			if (ret < 0) {
>   2053				if (!discarded)
>   2054					pr_info("Ring buffer meta [%d] invalid buffer page detected\n",
>   2055						cpu_buffer->cpu);
>   2056				discarded++;
>   2057			} else {
>   2058				/* If the buffer has content, update pages_touched */
>   2059				if (ret)
>   2060					local_inc(&cpu_buffer->pages_touched);
>   2061	
>   2062				entries += ret;
>   2063				entry_bytes += rb_page_size(head_page);
>   2064			}
>   2065			if (head_page == cpu_buffer->commit_page)
>   2066				break;
>   2067		}
>   2068	
>   2069		if (head_page != cpu_buffer->commit_page) {
>   2070			pr_info("Ring buffer meta [%d] commit page not found\n",
>   2071				cpu_buffer->cpu);
>   2072			goto invalid;
>   2073		}
>   2074	 done:
>   2075		local_set(&cpu_buffer->entries, entries);
>   2076		local_set(&cpu_buffer->entries_bytes, entry_bytes);
>   2077	
>   2078		pr_info("Ring buffer meta [%d] is from previous boot! (%d pages discarded)\n",
>   2079			cpu_buffer->cpu, discarded);
>   2080		return;
>   2081	
>   2082	 invalid:
>   2083		/* The content of the buffers are invalid, reset the meta data */
>   2084		meta->head_buffer = 0;
>   2085		meta->commit_buffer = 0;
>   2086	
>   2087		/* Reset the reader page */
>   2088		local_set(&cpu_buffer->reader_page->entries, 0);
>   2089		local_set(&cpu_buffer->reader_page->page->commit, 0);
>   2090	
>   2091		/* Reset all the subbuffers */
>   2092		for (i = 0; i < meta->nr_subbufs - 1; i++, rb_inc_page(&head_page)) {
>   2093			local_set(&head_page->entries, 0);
>   2094			rb_init_page(head_page->page);
>   2095		}
>   2096	}
>   2097	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
