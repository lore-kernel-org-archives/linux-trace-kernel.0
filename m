Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156A02DECD3;
	Thu, 26 Feb 2026 23:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772147733; cv=none; b=GAJD3NBY7cZuf84RAF4T2MgZvmTV5J645vuuhWw/E9beRTgf4pRsi2p3l9f+mrSYGse3AQYQcHwbA+Cr+ZBPk98L8ZS/GGUypsmf4M+Ih2xRY1wweb5BcF/yDWkAILILtHz2NMwK8i7y4leaKj/bJYPa45NRmq7q2rDiaQUrOo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772147733; c=relaxed/simple;
	bh=6ND260s9WILQRHkwfeaLvd30FFZogrwqcdbhvPGrCLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z02LvRCObybSw3Ov7K+uBe3o3ss11CRLry4Z+Irvcuwg/Jj0iP/33A+nnKgZV7EUdW3LNSSVaxF1iA/VGuAWMOUal2Tvpwuy5Des8WM5krilK0Us+z9844RZlS670VV/FGo2Keb+2VhIGNwgg6pFwmu3DVNVvnnc91xAgQzJYv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CKHDm/Kv; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CKHDm/Kv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772147732; x=1803683732;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6ND260s9WILQRHkwfeaLvd30FFZogrwqcdbhvPGrCLU=;
  b=CKHDm/KvW7FK80A9Oa6EJ9l6zYs6AgYikKntm85XqjWoljV5+Z0xjti3
   1cSlxrY/lGYG+bSkZv/7OaTVB4va7vTP01jOgoANDL0a+ieTVFCvH2nRo
   HdbRCTzYw+xNnjLP2yteCnhpRm+YhftxHDJa8NnsBX5jerhdrsZuwhux5
   rFX3kB4JJSEMDaH5MuYqINJ7oh2X15+nxzzBFMN1NPNgZajYCytHnZ92z
   115rNm5gY6pLfGly14esZZcmr8b9JXTDU7NOnwDjHfFEVOGTDXDdITLG9
   kc5d8BPXZHqbVlHXM0ievecgcyffy+qYwAj7InNT5N4tTF8mqOoybs2ur
   A==;
X-CSE-ConnectionGUID: Gr6OqGPhRfGdrO9UEN3d9Q==
X-CSE-MsgGUID: NQ13t34TRO+ovWCIjs2LBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="73331454"
X-IronPort-AV: E=Sophos;i="6.21,313,1763452800"; 
   d="scan'208";a="73331454"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 15:15:31 -0800
X-CSE-ConnectionGUID: 2nd7JkiIRv+7XVyRSDhPeA==
X-CSE-MsgGUID: +DW9LNsSQ6mZAAtCLcDJCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,313,1763452800"; 
   d="scan'208";a="220856206"
Received: from lkp-server02.sh.intel.com (HELO a3936d6a266d) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 26 Feb 2026 15:15:25 -0800
Received: from kbuild by a3936d6a266d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vvkZJ-000000009zN-0205;
	Thu, 26 Feb 2026 23:15:07 +0000
Date: Fri, 27 Feb 2026 07:13:01 +0800
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
Message-ID: <202602270740.0RL1uwsV-lkp@intel.com>
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
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20260227/202602270740.0RL1uwsV-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260227/202602270740.0RL1uwsV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602270740.0RL1uwsV-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/sched.h:37,
                    from include/linux/percpu.h:12,
                    from arch/x86/include/asm/msr.h:16,
                    from arch/x86/include/asm/tsc.h:11,
                    from arch/x86/include/asm/timex.h:6,
                    from include/linux/timex.h:67,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/stat.h:19,
                    from include/linux/module.h:13,
                    from kernel/power/snapshot.c:14:
   kernel/power/snapshot.c: In function 'mark_free_pages':
>> kernel/power/snapshot.c:1254:34: error: 'struct zone' has no member named 'lock'; did you mean '_lock'?
    1254 |         spin_lock_irqsave(&zone->lock, flags);
         |                                  ^~~~
   include/linux/spinlock.h:244:48: note: in definition of macro 'raw_spin_lock_irqsave'
     244 |                 flags = _raw_spin_lock_irqsave(lock);   \
         |                                                ^~~~
   kernel/power/snapshot.c:1254:9: note: in expansion of macro 'spin_lock_irqsave'
    1254 |         spin_lock_irqsave(&zone->lock, flags);
         |         ^~~~~~~~~~~~~~~~~
   kernel/power/snapshot.c:1287:39: error: 'struct zone' has no member named 'lock'; did you mean '_lock'?
    1287 |         spin_unlock_irqrestore(&zone->lock, flags);
         |                                       ^~~~
         |                                       _lock


vim +1254 kernel/power/snapshot.c

31a1b9d7fe768d Kefeng Wang     2023-05-16  1243  
31a1b9d7fe768d Kefeng Wang     2023-05-16  1244  static void mark_free_pages(struct zone *zone)
31a1b9d7fe768d Kefeng Wang     2023-05-16  1245  {
31a1b9d7fe768d Kefeng Wang     2023-05-16  1246  	unsigned long pfn, max_zone_pfn, page_count = WD_PAGE_COUNT;
31a1b9d7fe768d Kefeng Wang     2023-05-16  1247  	unsigned long flags;
31a1b9d7fe768d Kefeng Wang     2023-05-16  1248  	unsigned int order, t;
31a1b9d7fe768d Kefeng Wang     2023-05-16  1249  	struct page *page;
31a1b9d7fe768d Kefeng Wang     2023-05-16  1250  
31a1b9d7fe768d Kefeng Wang     2023-05-16  1251  	if (zone_is_empty(zone))
31a1b9d7fe768d Kefeng Wang     2023-05-16  1252  		return;
31a1b9d7fe768d Kefeng Wang     2023-05-16  1253  
31a1b9d7fe768d Kefeng Wang     2023-05-16 @1254  	spin_lock_irqsave(&zone->lock, flags);
31a1b9d7fe768d Kefeng Wang     2023-05-16  1255  
31a1b9d7fe768d Kefeng Wang     2023-05-16  1256  	max_zone_pfn = zone_end_pfn(zone);
312eca8a14c5f5 David Woodhouse 2025-04-23  1257  	for_each_valid_pfn(pfn, zone->zone_start_pfn, max_zone_pfn) {
31a1b9d7fe768d Kefeng Wang     2023-05-16  1258  		page = pfn_to_page(pfn);
31a1b9d7fe768d Kefeng Wang     2023-05-16  1259  
31a1b9d7fe768d Kefeng Wang     2023-05-16  1260  		if (!--page_count) {
31a1b9d7fe768d Kefeng Wang     2023-05-16  1261  			touch_nmi_watchdog();
31a1b9d7fe768d Kefeng Wang     2023-05-16  1262  			page_count = WD_PAGE_COUNT;
31a1b9d7fe768d Kefeng Wang     2023-05-16  1263  		}
31a1b9d7fe768d Kefeng Wang     2023-05-16  1264  
31a1b9d7fe768d Kefeng Wang     2023-05-16  1265  		if (page_zone(page) != zone)
31a1b9d7fe768d Kefeng Wang     2023-05-16  1266  			continue;
31a1b9d7fe768d Kefeng Wang     2023-05-16  1267  
31a1b9d7fe768d Kefeng Wang     2023-05-16  1268  		if (!swsusp_page_is_forbidden(page))
31a1b9d7fe768d Kefeng Wang     2023-05-16  1269  			swsusp_unset_page_free(page);
31a1b9d7fe768d Kefeng Wang     2023-05-16  1270  	}
31a1b9d7fe768d Kefeng Wang     2023-05-16  1271  
31a1b9d7fe768d Kefeng Wang     2023-05-16  1272  	for_each_migratetype_order(order, t) {
31a1b9d7fe768d Kefeng Wang     2023-05-16  1273  		list_for_each_entry(page,
31a1b9d7fe768d Kefeng Wang     2023-05-16  1274  				&zone->free_area[order].free_list[t], buddy_list) {
31a1b9d7fe768d Kefeng Wang     2023-05-16  1275  			unsigned long i;
31a1b9d7fe768d Kefeng Wang     2023-05-16  1276  
31a1b9d7fe768d Kefeng Wang     2023-05-16  1277  			pfn = page_to_pfn(page);
31a1b9d7fe768d Kefeng Wang     2023-05-16  1278  			for (i = 0; i < (1UL << order); i++) {
31a1b9d7fe768d Kefeng Wang     2023-05-16  1279  				if (!--page_count) {
31a1b9d7fe768d Kefeng Wang     2023-05-16  1280  					touch_nmi_watchdog();
31a1b9d7fe768d Kefeng Wang     2023-05-16  1281  					page_count = WD_PAGE_COUNT;
31a1b9d7fe768d Kefeng Wang     2023-05-16  1282  				}
31a1b9d7fe768d Kefeng Wang     2023-05-16  1283  				swsusp_set_page_free(pfn_to_page(pfn + i));
31a1b9d7fe768d Kefeng Wang     2023-05-16  1284  			}
31a1b9d7fe768d Kefeng Wang     2023-05-16  1285  		}
31a1b9d7fe768d Kefeng Wang     2023-05-16  1286  	}
31a1b9d7fe768d Kefeng Wang     2023-05-16  1287  	spin_unlock_irqrestore(&zone->lock, flags);
31a1b9d7fe768d Kefeng Wang     2023-05-16  1288  }
31a1b9d7fe768d Kefeng Wang     2023-05-16  1289  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
