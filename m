Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B08543CED4;
	Thu, 26 Feb 2026 21:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772142545; cv=none; b=jSUiIf4h4SGfhLSObP4EpsxmHQZbLGexDuNV+9cvlpohEtyrETVahr9oMR+otnKZ9qO3vj4tVT0QDFcShY8tBSh0ZRzBRQl8YTZuqquRvnajKv+TwJfsYY2McPtpZoKIEHiQEzTfgC5iRfUkMHhpFMu13BK4tlPJiHIkrQxKW9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772142545; c=relaxed/simple;
	bh=mDdNfF4vFA9G+p7Lcuc/r/WYyaBGmUyqdhgXlIoQNSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H2fembKrs2fZCAZGvupqNMEiy7KLSp5/NHNAN9vcI4eGkIehPMJ0MwJCwhRarmb3/Y8vDJSe5GoNAHJB7+W57XCETdXt5Ktxz+LUzlMzWFfBNOY+wh1spUJ33JahYT3GgqSv8FkhYhye7uPabVeWN4ac5kpqugrNM55GbbDAn18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hRY1o3Ee; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hRY1o3Ee"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772142540; x=1803678540;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mDdNfF4vFA9G+p7Lcuc/r/WYyaBGmUyqdhgXlIoQNSE=;
  b=hRY1o3EeCJDUYVnw+P6Cxo7RRUoNG8vYz0rKSdH9udoUJGOYOTsMk/N0
   2Y7lS81EtZr3e4IMfeiHcF0FYZnZs0qVLhpdJvRQe2b/kno5mCycyS30C
   99SPNuArX0wTWh7nxOegkI1iIsQ2gtwLz7ol0WXdcOlWNYvCrX8Y9sDfb
   Vw6DcYF6FgZ3K+giC8Ok72TGBYet5/7OYyNypjSz6h9zLQOga77eY1OhW
   /SK1dkz5B/mUEVj/kQ0MmZjVy9ARSDnM25PIMQsICKFdrgWhHIoPTVTMz
   tcDPeaZN1YquGNK6S/XU/emqqZGdsgq09aAEFWJpYanfTmA21f3vjAjHx
   g==;
X-CSE-ConnectionGUID: xEkct2CnRvaJtsPUQ+IzZA==
X-CSE-MsgGUID: ZABflL2eSEmGYSoToVEoLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="72921058"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; 
   d="scan'208";a="72921058"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 13:48:59 -0800
X-CSE-ConnectionGUID: Hd6wjXKgS2SiCJxOoEzJUw==
X-CSE-MsgGUID: 6UPgMho/RmqrsOX4n+kmCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; 
   d="scan'208";a="221702877"
Received: from lkp-server02.sh.intel.com (HELO a3936d6a266d) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 26 Feb 2026 13:48:52 -0800
Received: from kbuild by a3936d6a266d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vvjE1-000000009uN-3P1V;
	Thu, 26 Feb 2026 21:48:49 +0000
Date: Fri, 27 Feb 2026 05:48:05 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Ilvokhin <d@ilvokhin.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Oscar Salvador <osalvador@suse.de>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Shakeel Butt <shakeel.butt@linux.dev>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, kernel-team@meta.com,
	Benjamin Cheatham <benjamin.cheatham@amd.com>,
	Dmitry Ilvokhin <d@ilvokhin.com>
Subject: Re: [PATCH v3 4/5] mm: rename zone->lock to zone->_lock
Message-ID: <202602270508.8MKXotxZ-lkp@intel.com>
References: <1221b8e7fa9f5694f3c4e411f01581b5aba9bc63.1772129168.git.d@ilvokhin.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1221b8e7fa9f5694f3c4e411f01581b5aba9bc63.1772129168.git.d@ilvokhin.com>

Hi Dmitry,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v7.0-rc1 next-20260226]
[cannot apply to akpm-mm/mm-everything rppt-memblock/for-next rppt-memblock/fixes]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dmitry-Ilvokhin/mm-introduce-zone-lock-wrappers/20260227-022914
base:   linus/master
patch link:    https://lore.kernel.org/r/1221b8e7fa9f5694f3c4e411f01581b5aba9bc63.1772129168.git.d%40ilvokhin.com
patch subject: [PATCH v3 4/5] mm: rename zone->lock to zone->_lock
config: microblaze-randconfig-r073-20260227 (https://download.01.org/0day-ci/archive/20260227/202602270508.8MKXotxZ-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.5.0
smatch version: v0.5.0-8994-gd50c5a4c
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260227/202602270508.8MKXotxZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602270508.8MKXotxZ-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/mm.h:8,
                    from mm/shuffle.c:4:
   mm/shuffle.c: In function '__shuffle_zone':
>> mm/shuffle.c:88:31: error: 'struct zone' has no member named 'lock'; did you mean '_lock'?
      88 |         spin_lock_irqsave(&z->lock, flags);
         |                               ^~~~
   include/linux/spinlock.h:244:48: note: in definition of macro 'raw_spin_lock_irqsave'
     244 |                 flags = _raw_spin_lock_irqsave(lock);   \
         |                                                ^~~~
   mm/shuffle.c:88:9: note: in expansion of macro 'spin_lock_irqsave'
      88 |         spin_lock_irqsave(&z->lock, flags);
         |         ^~~~~~~~~~~~~~~~~
   mm/shuffle.c:141:52: error: 'struct zone' has no member named 'lock'; did you mean '_lock'?
     141 |                         spin_unlock_irqrestore(&z->lock, flags);
         |                                                    ^~~~
         |                                                    _lock
   In file included from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/mm.h:8,
                    from mm/shuffle.c:4:
   mm/shuffle.c:143:47: error: 'struct zone' has no member named 'lock'; did you mean '_lock'?
     143 |                         spin_lock_irqsave(&z->lock, flags);
         |                                               ^~~~
   include/linux/spinlock.h:244:48: note: in definition of macro 'raw_spin_lock_irqsave'
     244 |                 flags = _raw_spin_lock_irqsave(lock);   \
         |                                                ^~~~
   mm/shuffle.c:143:25: note: in expansion of macro 'spin_lock_irqsave'
     143 |                         spin_lock_irqsave(&z->lock, flags);
         |                         ^~~~~~~~~~~~~~~~~
   mm/shuffle.c:146:36: error: 'struct zone' has no member named 'lock'; did you mean '_lock'?
     146 |         spin_unlock_irqrestore(&z->lock, flags);
         |                                    ^~~~
         |                                    _lock


vim +88 mm/shuffle.c

e900a918b0984e Dan Williams            2019-05-14    3  
e900a918b0984e Dan Williams            2019-05-14   @4  #include <linux/mm.h>
e900a918b0984e Dan Williams            2019-05-14    5  #include <linux/init.h>
e900a918b0984e Dan Williams            2019-05-14    6  #include <linux/mmzone.h>
e900a918b0984e Dan Williams            2019-05-14    7  #include <linux/random.h>
e900a918b0984e Dan Williams            2019-05-14    8  #include <linux/moduleparam.h>
e900a918b0984e Dan Williams            2019-05-14    9  #include "internal.h"
e900a918b0984e Dan Williams            2019-05-14   10  #include "shuffle.h"
e900a918b0984e Dan Williams            2019-05-14   11  
e900a918b0984e Dan Williams            2019-05-14   12  DEFINE_STATIC_KEY_FALSE(page_alloc_shuffle_key);
e900a918b0984e Dan Williams            2019-05-14   13  
e900a918b0984e Dan Williams            2019-05-14   14  static bool shuffle_param;
e900a918b0984e Dan Williams            2019-05-14   15  
85a34107eba913 Liu Shixin              2022-09-09   16  static __meminit int shuffle_param_set(const char *val,
e900a918b0984e Dan Williams            2019-05-14   17  		const struct kernel_param *kp)
e900a918b0984e Dan Williams            2019-05-14   18  {
85a34107eba913 Liu Shixin              2022-09-09   19  	if (param_set_bool(val, kp))
85a34107eba913 Liu Shixin              2022-09-09   20  		return -EINVAL;
85a34107eba913 Liu Shixin              2022-09-09   21  	if (*(bool *)kp->arg)
839195352d8235 David Hildenbrand       2020-08-06   22  		static_branch_enable(&page_alloc_shuffle_key);
e900a918b0984e Dan Williams            2019-05-14   23  	return 0;
e900a918b0984e Dan Williams            2019-05-14   24  }
85a34107eba913 Liu Shixin              2022-09-09   25  
85a34107eba913 Liu Shixin              2022-09-09   26  static const struct kernel_param_ops shuffle_param_ops = {
85a34107eba913 Liu Shixin              2022-09-09   27  	.set = shuffle_param_set,
85a34107eba913 Liu Shixin              2022-09-09   28  	.get = param_get_bool,
85a34107eba913 Liu Shixin              2022-09-09   29  };
85a34107eba913 Liu Shixin              2022-09-09   30  module_param_cb(shuffle, &shuffle_param_ops, &shuffle_param, 0400);
e900a918b0984e Dan Williams            2019-05-14   31  
e900a918b0984e Dan Williams            2019-05-14   32  /*
e900a918b0984e Dan Williams            2019-05-14   33   * For two pages to be swapped in the shuffle, they must be free (on a
e900a918b0984e Dan Williams            2019-05-14   34   * 'free_area' lru), have the same order, and have the same migratetype.
e900a918b0984e Dan Williams            2019-05-14   35   */
4a93025cbe4a0b David Hildenbrand       2020-08-06   36  static struct page * __meminit shuffle_valid_page(struct zone *zone,
4a93025cbe4a0b David Hildenbrand       2020-08-06   37  						  unsigned long pfn, int order)
e900a918b0984e Dan Williams            2019-05-14   38  {
4a93025cbe4a0b David Hildenbrand       2020-08-06   39  	struct page *page = pfn_to_online_page(pfn);
e900a918b0984e Dan Williams            2019-05-14   40  
e900a918b0984e Dan Williams            2019-05-14   41  	/*
e900a918b0984e Dan Williams            2019-05-14   42  	 * Given we're dealing with randomly selected pfns in a zone we
e900a918b0984e Dan Williams            2019-05-14   43  	 * need to ask questions like...
e900a918b0984e Dan Williams            2019-05-14   44  	 */
e900a918b0984e Dan Williams            2019-05-14   45  
4a93025cbe4a0b David Hildenbrand       2020-08-06   46  	/* ... is the page managed by the buddy? */
4a93025cbe4a0b David Hildenbrand       2020-08-06   47  	if (!page)
e900a918b0984e Dan Williams            2019-05-14   48  		return NULL;
e900a918b0984e Dan Williams            2019-05-14   49  
4a93025cbe4a0b David Hildenbrand       2020-08-06   50  	/* ... is the page assigned to the same zone? */
4a93025cbe4a0b David Hildenbrand       2020-08-06   51  	if (page_zone(page) != zone)
e900a918b0984e Dan Williams            2019-05-14   52  		return NULL;
e900a918b0984e Dan Williams            2019-05-14   53  
e900a918b0984e Dan Williams            2019-05-14   54  	/* ...is the page free and currently on a free_area list? */
e900a918b0984e Dan Williams            2019-05-14   55  	if (!PageBuddy(page))
e900a918b0984e Dan Williams            2019-05-14   56  		return NULL;
e900a918b0984e Dan Williams            2019-05-14   57  
e900a918b0984e Dan Williams            2019-05-14   58  	/*
e900a918b0984e Dan Williams            2019-05-14   59  	 * ...is the page on the same list as the page we will
e900a918b0984e Dan Williams            2019-05-14   60  	 * shuffle it with?
e900a918b0984e Dan Williams            2019-05-14   61  	 */
ab130f9108dcf2 Matthew Wilcox (Oracle  2020-10-15   62) 	if (buddy_order(page) != order)
e900a918b0984e Dan Williams            2019-05-14   63  		return NULL;
e900a918b0984e Dan Williams            2019-05-14   64  
e900a918b0984e Dan Williams            2019-05-14   65  	return page;
e900a918b0984e Dan Williams            2019-05-14   66  }
e900a918b0984e Dan Williams            2019-05-14   67  
e900a918b0984e Dan Williams            2019-05-14   68  /*
e900a918b0984e Dan Williams            2019-05-14   69   * Fisher-Yates shuffle the freelist which prescribes iterating through an
e900a918b0984e Dan Williams            2019-05-14   70   * array, pfns in this case, and randomly swapping each entry with another in
e900a918b0984e Dan Williams            2019-05-14   71   * the span, end_pfn - start_pfn.
e900a918b0984e Dan Williams            2019-05-14   72   *
e900a918b0984e Dan Williams            2019-05-14   73   * To keep the implementation simple it does not attempt to correct for sources
e900a918b0984e Dan Williams            2019-05-14   74   * of bias in the distribution, like modulo bias or pseudo-random number
e900a918b0984e Dan Williams            2019-05-14   75   * generator bias. I.e. the expectation is that this shuffling raises the bar
e900a918b0984e Dan Williams            2019-05-14   76   * for attacks that exploit the predictability of page allocations, but need not
e900a918b0984e Dan Williams            2019-05-14   77   * be a perfect shuffle.
e900a918b0984e Dan Williams            2019-05-14   78   */
e900a918b0984e Dan Williams            2019-05-14   79  #define SHUFFLE_RETRY 10
e900a918b0984e Dan Williams            2019-05-14   80  void __meminit __shuffle_zone(struct zone *z)
e900a918b0984e Dan Williams            2019-05-14   81  {
e900a918b0984e Dan Williams            2019-05-14   82  	unsigned long i, flags;
e900a918b0984e Dan Williams            2019-05-14   83  	unsigned long start_pfn = z->zone_start_pfn;
e900a918b0984e Dan Williams            2019-05-14   84  	unsigned long end_pfn = zone_end_pfn(z);
e900a918b0984e Dan Williams            2019-05-14   85  	const int order = SHUFFLE_ORDER;
e900a918b0984e Dan Williams            2019-05-14   86  	const int order_pages = 1 << order;
e900a918b0984e Dan Williams            2019-05-14   87  
e900a918b0984e Dan Williams            2019-05-14  @88  	spin_lock_irqsave(&z->lock, flags);
e900a918b0984e Dan Williams            2019-05-14   89  	start_pfn = ALIGN(start_pfn, order_pages);
e900a918b0984e Dan Williams            2019-05-14   90  	for (i = start_pfn; i < end_pfn; i += order_pages) {
e900a918b0984e Dan Williams            2019-05-14   91  		unsigned long j;
e900a918b0984e Dan Williams            2019-05-14   92  		int migratetype, retry;
e900a918b0984e Dan Williams            2019-05-14   93  		struct page *page_i, *page_j;
e900a918b0984e Dan Williams            2019-05-14   94  
e900a918b0984e Dan Williams            2019-05-14   95  		/*
e900a918b0984e Dan Williams            2019-05-14   96  		 * We expect page_i, in the sub-range of a zone being added
e900a918b0984e Dan Williams            2019-05-14   97  		 * (@start_pfn to @end_pfn), to more likely be valid compared to
e900a918b0984e Dan Williams            2019-05-14   98  		 * page_j randomly selected in the span @zone_start_pfn to
e900a918b0984e Dan Williams            2019-05-14   99  		 * @spanned_pages.
e900a918b0984e Dan Williams            2019-05-14  100  		 */
4a93025cbe4a0b David Hildenbrand       2020-08-06  101  		page_i = shuffle_valid_page(z, i, order);
e900a918b0984e Dan Williams            2019-05-14  102  		if (!page_i)
e900a918b0984e Dan Williams            2019-05-14  103  			continue;
e900a918b0984e Dan Williams            2019-05-14  104  
e900a918b0984e Dan Williams            2019-05-14  105  		for (retry = 0; retry < SHUFFLE_RETRY; retry++) {
e900a918b0984e Dan Williams            2019-05-14  106  			/*
e900a918b0984e Dan Williams            2019-05-14  107  			 * Pick a random order aligned page in the zone span as
e900a918b0984e Dan Williams            2019-05-14  108  			 * a swap target. If the selected pfn is a hole, retry
e900a918b0984e Dan Williams            2019-05-14  109  			 * up to SHUFFLE_RETRY attempts find a random valid pfn
e900a918b0984e Dan Williams            2019-05-14  110  			 * in the zone.
e900a918b0984e Dan Williams            2019-05-14  111  			 */
e900a918b0984e Dan Williams            2019-05-14  112  			j = z->zone_start_pfn +
e900a918b0984e Dan Williams            2019-05-14  113  				ALIGN_DOWN(get_random_long() % z->spanned_pages,
e900a918b0984e Dan Williams            2019-05-14  114  						order_pages);
4a93025cbe4a0b David Hildenbrand       2020-08-06  115  			page_j = shuffle_valid_page(z, j, order);
e900a918b0984e Dan Williams            2019-05-14  116  			if (page_j && page_j != page_i)
e900a918b0984e Dan Williams            2019-05-14  117  				break;
e900a918b0984e Dan Williams            2019-05-14  118  		}
e900a918b0984e Dan Williams            2019-05-14  119  		if (retry >= SHUFFLE_RETRY) {
e900a918b0984e Dan Williams            2019-05-14  120  			pr_debug("%s: failed to swap %#lx\n", __func__, i);
e900a918b0984e Dan Williams            2019-05-14  121  			continue;
e900a918b0984e Dan Williams            2019-05-14  122  		}
e900a918b0984e Dan Williams            2019-05-14  123  
e900a918b0984e Dan Williams            2019-05-14  124  		/*
e900a918b0984e Dan Williams            2019-05-14  125  		 * Each migratetype corresponds to its own list, make sure the
e900a918b0984e Dan Williams            2019-05-14  126  		 * types match otherwise we're moving pages to lists where they
e900a918b0984e Dan Williams            2019-05-14  127  		 * do not belong.
e900a918b0984e Dan Williams            2019-05-14  128  		 */
e900a918b0984e Dan Williams            2019-05-14  129  		migratetype = get_pageblock_migratetype(page_i);
e900a918b0984e Dan Williams            2019-05-14  130  		if (get_pageblock_migratetype(page_j) != migratetype) {
e900a918b0984e Dan Williams            2019-05-14  131  			pr_debug("%s: migratetype mismatch %#lx\n", __func__, i);
e900a918b0984e Dan Williams            2019-05-14  132  			continue;
e900a918b0984e Dan Williams            2019-05-14  133  		}
e900a918b0984e Dan Williams            2019-05-14  134  
e900a918b0984e Dan Williams            2019-05-14  135  		list_swap(&page_i->lru, &page_j->lru);
e900a918b0984e Dan Williams            2019-05-14  136  
e900a918b0984e Dan Williams            2019-05-14  137  		pr_debug("%s: swap: %#lx -> %#lx\n", __func__, i, j);
e900a918b0984e Dan Williams            2019-05-14  138  
e900a918b0984e Dan Williams            2019-05-14  139  		/* take it easy on the zone lock */
e900a918b0984e Dan Williams            2019-05-14  140  		if ((i % (100 * order_pages)) == 0) {
e900a918b0984e Dan Williams            2019-05-14  141  			spin_unlock_irqrestore(&z->lock, flags);
e900a918b0984e Dan Williams            2019-05-14  142  			cond_resched();
e900a918b0984e Dan Williams            2019-05-14  143  			spin_lock_irqsave(&z->lock, flags);
e900a918b0984e Dan Williams            2019-05-14  144  		}
e900a918b0984e Dan Williams            2019-05-14  145  	}
e900a918b0984e Dan Williams            2019-05-14  146  	spin_unlock_irqrestore(&z->lock, flags);
e900a918b0984e Dan Williams            2019-05-14  147  }
e900a918b0984e Dan Williams            2019-05-14  148  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
