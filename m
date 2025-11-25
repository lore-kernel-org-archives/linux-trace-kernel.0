Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C241BC41;
	Tue, 25 Nov 2025 12:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764073064; cv=none; b=rbmsIthu72dOUKIfPRKal5FlI1pRAtnJ8E1roK/atZ+Jr4Hg5Pd9ks8GSBNl5GMK1PuzcsGNpRgYUXYPEohhzHUo1j3BPlFhyeDsDPB07MI+rFJBdKs6YXw35c/76m5iiFs+cZgJPj0m9pDeCJYyBV2T9QquwBYvsrvKN/J6yNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764073064; c=relaxed/simple;
	bh=Y04DrZuV8Osk+tUoqw7jLJ90epxMN2KK5RiZwt2Go1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ALYVba+UhLfkTtPHbpxEwluDC42tlrx3iSbq3fLjG9YZBpoIwws0WjL/dWjb7E01A4GLsODHNwpvnQFko/ANRjd7Xb5pMGrvGG2PHDmLScUx+Fdq2hxEGs+FuzOPT2VEE2R+wpkInUewggMKvKwOPNAhcP2I7AVCKYNSLFVri2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d0LQTLZQ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d0LQTLZQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764073062; x=1795609062;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y04DrZuV8Osk+tUoqw7jLJ90epxMN2KK5RiZwt2Go1U=;
  b=d0LQTLZQhqYYvnQnxUyXFdB8st0+XB1cvc1H5umb3JpchiFCUiel1wqG
   pJ2hBzOtyl05yaZQIlts7OT2OgwyCeGfSAWXR8mXt9f/b0PGhuC2lemw5
   oWHkJEOJCUx7Ggh76z10LgMiXMchvWD99QAyIiou2LDSWGyLtUS1sUz9d
   vagijfdfgr5h9ozof1wUVs3ApcU+UHp8OC62mgvY257RpvHfHefRWh+zp
   p/UtsBSitzbIRM1RzbZBjlj9StbtLi5WDqE79Fta65sLwhfaww5PmSYxa
   4LUwqJtQyZjtQkbv5zvtXqJvS56IBCU4UAlcHz0+kdv3ZOFA6rRPz8ybv
   g==;
X-CSE-ConnectionGUID: 1JgeG4TQTMintgw/DV1fpg==
X-CSE-MsgGUID: aJ33LrvfTkKwC9a9dF3/hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11623"; a="91575689"
X-IronPort-AV: E=Sophos;i="6.20,225,1758610800"; 
   d="scan'208";a="91575689"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 04:17:41 -0800
X-CSE-ConnectionGUID: l0TWK8a9TBCGpiC32UIljg==
X-CSE-MsgGUID: zvY7cKyKRY2H528tgH5Giw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,225,1758610800"; 
   d="scan'208";a="192263624"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 25 Nov 2025 04:17:40 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vNrzF-000000001lt-2zsU;
	Tue, 25 Nov 2025 12:17:37 +0000
Date: Tue, 25 Nov 2025 20:17:22 +0800
From: kernel test robot <lkp@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] ring-buffer: Add helper functions for allocations
Message-ID: <202511252040.Jny2Yxxn-lkp@intel.com>
References: <20251124140906.71a2abf6@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124140906.71a2abf6@gandalf.local.home>

Hi Steven,

kernel test robot noticed the following build warnings:

[auto build test WARNING on trace/for-next]
[also build test WARNING on linus/master v6.18-rc7 next-20251125]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Steven-Rostedt/ring-buffer-Add-helper-functions-for-allocations/20251125-031044
base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
patch link:    https://lore.kernel.org/r/20251124140906.71a2abf6%40gandalf.local.home
patch subject: [PATCH] ring-buffer: Add helper functions for allocations
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20251125/202511252040.Jny2Yxxn-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251125/202511252040.Jny2Yxxn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511252040.Jny2Yxxn-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/trace/ring_buffer.c: In function '__rb_allocate_pages':
>> kernel/trace/ring_buffer.c:2279:30: warning: unused variable 'page' [-Wunused-variable]
    2279 |                 struct page *page;
         |                              ^~~~
>> kernel/trace/ring_buffer.c:2242:15: warning: variable 'mflags' set but not used [-Wunused-but-set-variable]
    2242 |         gfp_t mflags;
         |               ^~~~~~
   kernel/trace/ring_buffer.c: In function 'rb_allocate_cpu_buffer':
   kernel/trace/ring_buffer.c:2362:22: warning: unused variable 'page' [-Wunused-variable]
    2362 |         struct page *page;
         |                      ^~~~
   kernel/trace/ring_buffer.c: In function 'ring_buffer_alloc_read_page':
   kernel/trace/ring_buffer.c:6493:22: warning: unused variable 'page' [-Wunused-variable]
    6493 |         struct page *page;
         |                      ^~~~


vim +/page +2279 kernel/trace/ring_buffer.c

c76883f18e59b7 Steven Rostedt (Google      2024-06-12  2234) 
74e2afc6df5782 Qiujun Huang                2020-10-15  2235  static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
74e2afc6df5782 Qiujun Huang                2020-10-15  2236  		long nr_pages, struct list_head *pages)
7a8e76a3829f10 Steven Rostedt              2008-09-29  2237  {
be68d63a139bd4 Steven Rostedt (Google      2024-06-12  2238) 	struct trace_buffer *buffer = cpu_buffer->buffer;
4009cc31e7813e Steven Rostedt              2025-03-05  2239  	struct ring_buffer_cpu_meta *meta = NULL;
044fa782ebb947 Steven Rostedt              2008-12-02  2240  	struct buffer_page *bpage, *tmp;
927e56db625322 Steven Rostedt (VMware      2018-04-04  2241) 	bool user_thread = current->mm != NULL;
927e56db625322 Steven Rostedt (VMware      2018-04-04 @2242) 	gfp_t mflags;
9b94a8fba501f3 Steven Rostedt (Red Hat     2016-05-12  2243) 	long i;
3adc54fa82a68b Steven Rostedt              2009-03-30  2244  
927e56db625322 Steven Rostedt (VMware      2018-04-04  2245) 	/*
927e56db625322 Steven Rostedt (VMware      2018-04-04  2246) 	 * Check if the available memory is there first.
927e56db625322 Steven Rostedt (VMware      2018-04-04  2247) 	 * Note, si_mem_available() only gives us a rough estimate of available
927e56db625322 Steven Rostedt (VMware      2018-04-04  2248) 	 * memory. It may not be accurate. But we don't care, we just want
927e56db625322 Steven Rostedt (VMware      2018-04-04  2249) 	 * to prevent doing any allocation when it is obvious that it is
927e56db625322 Steven Rostedt (VMware      2018-04-04  2250) 	 * not going to succeed.
927e56db625322 Steven Rostedt (VMware      2018-04-04  2251) 	 */
2a872fa4e9c8ad Steven Rostedt (VMware      2018-04-02  2252) 	i = si_mem_available();
2a872fa4e9c8ad Steven Rostedt (VMware      2018-04-02  2253) 	if (i < nr_pages)
2a872fa4e9c8ad Steven Rostedt (VMware      2018-04-02  2254) 		return -ENOMEM;
2a872fa4e9c8ad Steven Rostedt (VMware      2018-04-02  2255) 
d7ec4bfed6c974 Vaibhav Nagarnaik           2011-06-07  2256  	/*
848618857d2535 Joel Fernandes              2017-07-12  2257  	 * __GFP_RETRY_MAYFAIL flag makes sure that the allocation fails
848618857d2535 Joel Fernandes              2017-07-12  2258  	 * gracefully without invoking oom-killer and the system is not
848618857d2535 Joel Fernandes              2017-07-12  2259  	 * destabilized.
d7ec4bfed6c974 Vaibhav Nagarnaik           2011-06-07  2260  	 */
927e56db625322 Steven Rostedt (VMware      2018-04-04  2261) 	mflags = GFP_KERNEL | __GFP_RETRY_MAYFAIL;
927e56db625322 Steven Rostedt (VMware      2018-04-04  2262) 
927e56db625322 Steven Rostedt (VMware      2018-04-04  2263) 	/*
927e56db625322 Steven Rostedt (VMware      2018-04-04  2264) 	 * If a user thread allocates too much, and si_mem_available()
927e56db625322 Steven Rostedt (VMware      2018-04-04  2265) 	 * reports there's enough memory, even though there is not.
927e56db625322 Steven Rostedt (VMware      2018-04-04  2266) 	 * Make sure the OOM killer kills this thread. This can happen
927e56db625322 Steven Rostedt (VMware      2018-04-04  2267) 	 * even with RETRY_MAYFAIL because another task may be doing
927e56db625322 Steven Rostedt (VMware      2018-04-04  2268) 	 * an allocation after this task has taken all memory.
927e56db625322 Steven Rostedt (VMware      2018-04-04  2269) 	 * This is the task the OOM killer needs to take out during this
927e56db625322 Steven Rostedt (VMware      2018-04-04  2270) 	 * loop, even if it was triggered by an allocation somewhere else.
927e56db625322 Steven Rostedt (VMware      2018-04-04  2271) 	 */
927e56db625322 Steven Rostedt (VMware      2018-04-04  2272) 	if (user_thread)
927e56db625322 Steven Rostedt (VMware      2018-04-04  2273) 		set_current_oom_origin();
c76883f18e59b7 Steven Rostedt (Google      2024-06-12  2274) 
c76883f18e59b7 Steven Rostedt (Google      2024-06-12  2275) 	if (buffer->range_addr_start)
c76883f18e59b7 Steven Rostedt (Google      2024-06-12  2276) 		meta = rb_range_meta(buffer, nr_pages, cpu_buffer->cpu);
c76883f18e59b7 Steven Rostedt (Google      2024-06-12  2277) 
927e56db625322 Steven Rostedt (VMware      2018-04-04  2278) 	for (i = 0; i < nr_pages; i++) {
927e56db625322 Steven Rostedt (VMware      2018-04-04 @2279) 		struct page *page;
927e56db625322 Steven Rostedt (VMware      2018-04-04  2280) 
1e3d56c5556b8d Steven Rostedt              2025-11-24  2281  		bpage = alloc_cpu_page(cpu_buffer->cpu);
044fa782ebb947 Steven Rostedt              2008-12-02  2282  		if (!bpage)
e4c2ce82ca2710 Steven Rostedt              2008-10-01  2283  			goto free_pages;
77ae365eca8950 Steven Rostedt              2009-03-27  2284  
74e2afc6df5782 Qiujun Huang                2020-10-15  2285  		rb_check_bpage(cpu_buffer, bpage);
74e2afc6df5782 Qiujun Huang                2020-10-15  2286  
be68d63a139bd4 Steven Rostedt (Google      2024-06-12  2287) 		/*
be68d63a139bd4 Steven Rostedt (Google      2024-06-12  2288) 		 * Append the pages as for mapped buffers we want to keep
be68d63a139bd4 Steven Rostedt (Google      2024-06-12  2289) 		 * the order
be68d63a139bd4 Steven Rostedt (Google      2024-06-12  2290) 		 */
be68d63a139bd4 Steven Rostedt (Google      2024-06-12  2291) 		list_add_tail(&bpage->list, pages);
e4c2ce82ca2710 Steven Rostedt              2008-10-01  2292  
c76883f18e59b7 Steven Rostedt (Google      2024-06-12  2293) 		if (meta) {
be68d63a139bd4 Steven Rostedt (Google      2024-06-12  2294) 			/* A range was given. Use that for the buffer page */
b14d032973d4e6 Steven Rostedt (Google      2024-06-12  2295) 			bpage->page = rb_range_buffer(cpu_buffer, i + 1);
be68d63a139bd4 Steven Rostedt (Google      2024-06-12  2296) 			if (!bpage->page)
be68d63a139bd4 Steven Rostedt (Google      2024-06-12  2297) 				goto free_pages;
c76883f18e59b7 Steven Rostedt (Google      2024-06-12  2298) 			/* If this is valid from a previous boot */
c76883f18e59b7 Steven Rostedt (Google      2024-06-12  2299) 			if (meta->head_buffer)
c76883f18e59b7 Steven Rostedt (Google      2024-06-12  2300) 				rb_meta_buffer_update(cpu_buffer, bpage);
be68d63a139bd4 Steven Rostedt (Google      2024-06-12  2301) 			bpage->range = 1;
b14d032973d4e6 Steven Rostedt (Google      2024-06-12  2302) 			bpage->id = i + 1;
be68d63a139bd4 Steven Rostedt (Google      2024-06-12  2303) 		} else {
1e3d56c5556b8d Steven Rostedt              2025-11-24  2304  			int order = cpu_buffer->buffer->subbuf_order;
1e3d56c5556b8d Steven Rostedt              2025-11-24  2305  			bpage->page = alloc_cpu_data(cpu_buffer->cpu, order);
1e3d56c5556b8d Steven Rostedt              2025-11-24  2306  			if (!bpage->page)
7a8e76a3829f10 Steven Rostedt              2008-09-29  2307  				goto free_pages;
be68d63a139bd4 Steven Rostedt (Google      2024-06-12  2308) 		}
f9b94daa542a8d Tzvetomir Stoyanov (VMware  2023-12-19  2309) 		bpage->order = cpu_buffer->buffer->subbuf_order;
927e56db625322 Steven Rostedt (VMware      2018-04-04  2310) 
927e56db625322 Steven Rostedt (VMware      2018-04-04  2311) 		if (user_thread && fatal_signal_pending(current))
927e56db625322 Steven Rostedt (VMware      2018-04-04  2312) 			goto free_pages;
7a8e76a3829f10 Steven Rostedt              2008-09-29  2313  	}
927e56db625322 Steven Rostedt (VMware      2018-04-04  2314) 	if (user_thread)
927e56db625322 Steven Rostedt (VMware      2018-04-04  2315) 		clear_current_oom_origin();
7a8e76a3829f10 Steven Rostedt              2008-09-29  2316  
438ced1720b584 Vaibhav Nagarnaik           2012-02-02  2317  	return 0;
438ced1720b584 Vaibhav Nagarnaik           2012-02-02  2318  
438ced1720b584 Vaibhav Nagarnaik           2012-02-02  2319  free_pages:
438ced1720b584 Vaibhav Nagarnaik           2012-02-02  2320  	list_for_each_entry_safe(bpage, tmp, pages, list) {
438ced1720b584 Vaibhav Nagarnaik           2012-02-02  2321  		list_del_init(&bpage->list);
438ced1720b584 Vaibhav Nagarnaik           2012-02-02  2322  		free_buffer_page(bpage);
438ced1720b584 Vaibhav Nagarnaik           2012-02-02  2323  	}
927e56db625322 Steven Rostedt (VMware      2018-04-04  2324) 	if (user_thread)
927e56db625322 Steven Rostedt (VMware      2018-04-04  2325) 		clear_current_oom_origin();
438ced1720b584 Vaibhav Nagarnaik           2012-02-02  2326  
438ced1720b584 Vaibhav Nagarnaik           2012-02-02  2327  	return -ENOMEM;
438ced1720b584 Vaibhav Nagarnaik           2012-02-02  2328  }
438ced1720b584 Vaibhav Nagarnaik           2012-02-02  2329  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
