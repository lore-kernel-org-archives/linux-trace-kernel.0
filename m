Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC83358360
	for <linux-trace-kernel@vger.kernel.org>; Wed, 13 May 2026 01:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778635173; cv=none; b=UELR7YjvUR7uHl1a0yn78XKY3Z93WgYLSWP9VQ08ZeYTpfRqZi+W7fadfLOQcjoIXJW/j37af45TWgjUregYT3HVJFbTVwUOghgUw3ziOUVyvvjnbPjXNcG6ulv1OuX1rhpQG0fV3PkrLE/zeKP6E9zmmQ7TpqseUDTvnBt3HAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778635173; c=relaxed/simple;
	bh=xyrOPamgQ4Fkzwm6jfzJfShElBZc1B6GwVMpeHGtwkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l5zMB/NBZArfyAToZOOeClDyTiSaDpwSOwIUw5U6S70+8BvTN213oIdAdS0lEPDfpM8t1C9KLJi/VWlNw9A7/Pern31XL0DAlhUHQFEr0y41eimPOrQhC0GO01EokfMC07J3HkcH2iVIg1Wr/RhpGodgbY7UbhTTNwg6Ii0Ha3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ItVMH+eI; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ItVMH+eI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778635171; x=1810171171;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xyrOPamgQ4Fkzwm6jfzJfShElBZc1B6GwVMpeHGtwkg=;
  b=ItVMH+eIBNQuye4AVCr/wNlbyjVeStISPiTP3H5p/KX9Zy7/Ag8CUfBc
   9CLxkMT8Vm9l3uIW9EoWhO3JoJiZZqhkQeAKv6bdax8CKA94wqRg+QIlm
   XPR6N1acKCI56/ecsWgFSCVVLCOdmmpiNhFCE0E5yUD6eYPO1uxXD31KF
   D0+tNUlGFTfx2ChSjgEnAmk/LcNxjn4S5MrVSl76nl4aWswSIR0UrOZ5E
   udSn3SShXxB/5+eFXbpSRkjE8DF2jw3nC7kgqVKtO/CJlyfK9LCY6SA0i
   0WI9TNsLLg23HsAFsUvbeTK4tDbN3lNiRRLh17YfD19hOUKCQ18G17Gq7
   w==;
X-CSE-ConnectionGUID: B2zkoaPqT2+v0SB1gB6deA==
X-CSE-MsgGUID: 1F2sC/iDSSiJbdxrcdPnLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="83169941"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="83169941"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 18:19:28 -0700
X-CSE-ConnectionGUID: yvQzOIs1RfS5MfRMl3+nxw==
X-CSE-MsgGUID: M/6yLguBQL2bk213TawFxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="239740707"
Received: from lkp-server01.sh.intel.com (HELO dca79079c3eb) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 12 May 2026 18:19:25 -0700
Received: from kbuild by dca79079c3eb with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wMyFu-00000000375-1a3q;
	Wed, 13 May 2026 01:19:22 +0000
Date: Wed, 13 May 2026 09:19:07 +0800
From: kernel test robot <lkp@intel.com>
To: "qiwu.chen" <qiwuchen55@gmail.com>, rostedt@goodmis.org,
	mhiramat@kernel.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
	david@kernel.org, mhocko@kernel.org, willy@infradead.org
Cc: oe-kbuild-all@lists.linux.dev, linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org, "qiwu.chen" <qiwu.chen@transsion.com>
Subject: Re: [PATCH v2] mm: vmscan: rework lru_shrink and write_folio
 tracepoints
Message-ID: <202605130942.9wJFWm9M-lkp@intel.com>
References: <20260506083652.100160-1-qiwu.chen@transsion.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506083652.100160-1-qiwu.chen@transsion.com>

Hi qiwu.chen,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v7.1-rc3]
[cannot apply to akpm-mm/mm-everything trace/for-next next-20260508]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/qiwu-chen/mm-vmscan-rework-lru_shrink-and-write_folio-tracepoints/20260513-040720
base:   linus/master
patch link:    https://lore.kernel.org/r/20260506083652.100160-1-qiwu.chen%40transsion.com
patch subject: [PATCH v2] mm: vmscan: rework lru_shrink and write_folio tracepoints
config: xtensa-randconfig-001-20260513 (https://download.01.org/0day-ci/archive/20260513/202605130942.9wJFWm9M-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260513/202605130942.9wJFWm9M-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605130942.9wJFWm9M-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/trace/define_trace.h:132,
                    from include/trace/events/vmscan.h:602,
                    from mm/vmscan.c:72:
   include/trace/events/vmscan.h: In function 'trace_raw_output_mm_vmscan_write_folio':
   include/trace/events/vmscan.h:358:12: warning: format '%p' expects argument of type 'void *', but argument 3 has type 'long unsigned int' [-Wformat=]
     TP_printk("folio=%p lru=%s",
               ^~~~~~~~~~~~~~~~~
   include/trace/trace_events.h:219:27: note: in definition of macro 'DECLARE_EVENT_CLASS'
     trace_event_printf(iter, print);    \
                              ^~~~~
   include/trace/trace_events.h:45:9: note: in expansion of macro 'PARAMS'
            PARAMS(print));         \
            ^~~~~~
   include/trace/events/vmscan.h:342:1: note: in expansion of macro 'TRACE_EVENT'
    TRACE_EVENT(mm_vmscan_write_folio,
    ^~~~~~~~~~~
   include/trace/events/vmscan.h:358:2: note: in expansion of macro 'TP_printk'
     TP_printk("folio=%p lru=%s",
     ^~~~~~~~~
   In file included from include/trace/trace_events.h:256,
                    from include/trace/define_trace.h:132,
                    from include/trace/events/vmscan.h:602,
                    from mm/vmscan.c:72:
   include/trace/events/vmscan.h:358:20: note: format string is defined here
     TP_printk("folio=%p lru=%s",
                      ~^
                      %ld
   In file included from include/trace/define_trace.h:132,
                    from include/trace/events/vmscan.h:602,
                    from mm/vmscan.c:72:
   include/trace/events/vmscan.h: In function 'do_trace_event_raw_event_mm_vmscan_write_folio':
>> include/trace/events/vmscan.h:354:18: warning: assignment to 'long unsigned int' from 'struct folio *' makes integer from pointer without a cast [-Wint-conversion]
      __entry->folio = folio;
                     ^
   include/trace/trace_events.h:427:4: note: in definition of macro '__DECLARE_EVENT_CLASS'
     { assign; }       \
       ^~~~~~
   include/trace/trace_events.h:435:9: note: in expansion of macro 'PARAMS'
            PARAMS(assign), PARAMS(print))   \
            ^~~~~~
   include/trace/trace_events.h:40:2: note: in expansion of macro 'DECLARE_EVENT_CLASS'
     DECLARE_EVENT_CLASS(name,          \
     ^~~~~~~~~~~~~~~~~~~
   include/trace/trace_events.h:44:9: note: in expansion of macro 'PARAMS'
            PARAMS(assign),         \
            ^~~~~~
   include/trace/events/vmscan.h:342:1: note: in expansion of macro 'TRACE_EVENT'
    TRACE_EVENT(mm_vmscan_write_folio,
    ^~~~~~~~~~~
   include/trace/events/vmscan.h:353:2: note: in expansion of macro 'TP_fast_assign'
     TP_fast_assign(
     ^~~~~~~~~~~~~~


vim +354 include/trace/events/vmscan.h

   343	
   344		TP_PROTO(struct folio *folio),
   345	
   346		TP_ARGS(folio),
   347	
   348		TP_STRUCT__entry(
   349			__field(unsigned long, folio)
   350			__field(int, lru)
   351		),
   352	
   353		TP_fast_assign(
 > 354			__entry->folio = folio;
   355			__entry->lru = folio_lru_list(folio);
   356		),
   357	
   358		TP_printk("folio=%p lru=%s",
   359			__entry->folio,
   360			__print_symbolic(__entry->lru, LRU_NAMES))
   361	);
   362	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
