Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229E522A1D4
	for <linux-trace-kernel@vger.kernel.org>; Wed, 13 May 2026 00:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778633187; cv=none; b=hGEjwrUM2DkRbzvue/eH/Z2PBGHfWAunFyjkkN7YsO6VU06nDMauKKhcPn8rJVMOY9smY5lvEwOEsq1SkNRr+T6n2Hp/ank6nPa80HzKt/1mooiBd5RVXVumLqaeHq//XCEdVLqN0CUZUGnABo4aecHISXqVZtj1WlgDZY7rUOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778633187; c=relaxed/simple;
	bh=oq50o2jZ/FE6vpJ/bSMHOFkTcMQ+X7MiMgufB/YUPsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lgTZa0UTXmVCRt6iqjtBIH5o4BImcW/QFEwsQXcOuV8riKO4I3Gq1hRnPxwcj3G3X9x9JVLOsiaMKNoNo8u6gtowQYh/S2pLgJUrNdmUcwYkPVdrUaxt07NNzh0gRZqhMNh5h3CSGcCoiIH0yl4IwlrWGThRvXIcOB4JVxAzLzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MKfO+d2N; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MKfO+d2N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778633185; x=1810169185;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oq50o2jZ/FE6vpJ/bSMHOFkTcMQ+X7MiMgufB/YUPsU=;
  b=MKfO+d2NGh0ybhD2zo3wOYKeHn4bI/SZibKwgKcBXxb+V3Nvvn2A87d8
   yY4nNDfmDXG9wD+ECzN4cpRhX6uns/z7vuYPrRNuO6ItKftluR7e970Wf
   8H+C8htpD7f2iLfGRS/UWHTV9gvn3oSDcHNuUMqwmxmmKsMxGPhkV4foz
   G00Dm0hK1qILM3hDYN2txrdJMa8hxmgaIf/oaN1J4B3ZeKmD1r4uev6e9
   efA/gQ0EeOWYBEn9Evrl9Vt9Y2Kq/lr196tAXCXoqs1Rc87dIq0WspY9w
   FtwmJgjyO8Zw3g3z8C/iM5uiWa8oq7OZsKspD0qAX94bzaOlTAk+A6DDm
   Q==;
X-CSE-ConnectionGUID: AvIRZD0uQCiM+RitcaZcOQ==
X-CSE-MsgGUID: LNgjIYGbR4yd93KoLjpCnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="79575380"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="79575380"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 17:46:25 -0700
X-CSE-ConnectionGUID: DJ77aG+sRde05p92hl8NOA==
X-CSE-MsgGUID: kxT61vezSeWwPOhyY8Dntg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="235256383"
Received: from lkp-server01.sh.intel.com (HELO dca79079c3eb) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 12 May 2026 17:46:22 -0700
Received: from kbuild by dca79079c3eb with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wMxjv-0000000034F-1Qur;
	Wed, 13 May 2026 00:46:19 +0000
Date: Wed, 13 May 2026 08:45:49 +0800
From: kernel test robot <lkp@intel.com>
To: "qiwu.chen" <qiwuchen55@gmail.com>, rostedt@goodmis.org,
	mhiramat@kernel.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
	david@kernel.org, mhocko@kernel.org, willy@infradead.org
Cc: oe-kbuild-all@lists.linux.dev, linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org, "qiwu.chen" <qiwu.chen@transsion.com>
Subject: Re: [PATCH v2] mm: vmscan: rework lru_shrink and write_folio
 tracepoints
Message-ID: <202605130842.zWTTtyaL-lkp@intel.com>
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
config: sh-defconfig (https://download.01.org/0day-ci/archive/20260513/202605130842.zWTTtyaL-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260513/202605130842.zWTTtyaL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605130842.zWTTtyaL-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/trace/define_trace.h:132,
                    from include/trace/events/vmscan.h:602,
                    from mm/vmscan.c:72:
   include/trace/events/vmscan.h: In function 'trace_raw_output_mm_vmscan_write_folio':
>> include/trace/events/vmscan.h:358:19: warning: format '%p' expects argument of type 'void *', but argument 3 has type 'long unsigned int' [-Wformat=]
     358 |         TP_printk("folio=%p lru=%s",
         |                   ^~~~~~~~~~~~~~~~~
   include/trace/trace_events.h:219:34: note: in definition of macro 'DECLARE_EVENT_CLASS'
     219 |         trace_event_printf(iter, print);                                \
         |                                  ^~~~~
   include/trace/trace_events.h:45:30: note: in expansion of macro 'PARAMS'
      45 |                              PARAMS(print));                   \
         |                              ^~~~~~
   include/trace/events/vmscan.h:342:1: note: in expansion of macro 'TRACE_EVENT'
     342 | TRACE_EVENT(mm_vmscan_write_folio,
         | ^~~~~~~~~~~
   include/trace/events/vmscan.h:358:9: note: in expansion of macro 'TP_printk'
     358 |         TP_printk("folio=%p lru=%s",
         |         ^~~~~~~~~
   In file included from include/trace/trace_events.h:256:
   include/trace/events/vmscan.h:358:27: note: format string is defined here
     358 |         TP_printk("folio=%p lru=%s",
         |                          ~^
         |                           |
         |                           void *
         |                          %ld
   include/trace/events/vmscan.h: In function 'do_trace_event_raw_event_mm_vmscan_write_folio':
   include/trace/events/vmscan.h:354:32: error: assignment to 'long unsigned int' from 'struct folio *' makes integer from pointer without a cast [-Wint-conversion]
     354 |                 __entry->folio = folio;
         |                                ^
   include/trace/trace_events.h:427:11: note: in definition of macro '__DECLARE_EVENT_CLASS'
     427 |         { assign; }                                                     \
         |           ^~~~~~
   include/trace/trace_events.h:435:23: note: in expansion of macro 'PARAMS'
     435 |                       PARAMS(assign), PARAMS(print))                    \
         |                       ^~~~~~
   include/trace/trace_events.h:40:9: note: in expansion of macro 'DECLARE_EVENT_CLASS'
      40 |         DECLARE_EVENT_CLASS(name,                              \
         |         ^~~~~~~~~~~~~~~~~~~
   include/trace/trace_events.h:44:30: note: in expansion of macro 'PARAMS'
      44 |                              PARAMS(assign),                   \
         |                              ^~~~~~
   include/trace/events/vmscan.h:342:1: note: in expansion of macro 'TRACE_EVENT'
     342 | TRACE_EVENT(mm_vmscan_write_folio,
         | ^~~~~~~~~~~
   include/trace/events/vmscan.h:353:9: note: in expansion of macro 'TP_fast_assign'
     353 |         TP_fast_assign(
         |         ^~~~~~~~~~~~~~
   In file included from include/trace/define_trace.h:133:
   include/trace/events/vmscan.h: In function 'do_perf_trace_mm_vmscan_write_folio':
   include/trace/events/vmscan.h:354:32: error: assignment to 'long unsigned int' from 'struct folio *' makes integer from pointer without a cast [-Wint-conversion]
     354 |                 __entry->folio = folio;
         |                                ^
   include/trace/perf.h:51:11: note: in definition of macro '__DECLARE_EVENT_CLASS'
      51 |         { assign; }                                                     \
         |           ^~~~~~
   include/trace/perf.h:67:23: note: in expansion of macro 'PARAMS'
      67 |                       PARAMS(assign), PARAMS(print))                    \
         |                       ^~~~~~
   include/trace/trace_events.h:40:9: note: in expansion of macro 'DECLARE_EVENT_CLASS'
      40 |         DECLARE_EVENT_CLASS(name,                              \
         |         ^~~~~~~~~~~~~~~~~~~
   include/trace/trace_events.h:44:30: note: in expansion of macro 'PARAMS'
      44 |                              PARAMS(assign),                   \
         |                              ^~~~~~
   include/trace/events/vmscan.h:342:1: note: in expansion of macro 'TRACE_EVENT'
     342 | TRACE_EVENT(mm_vmscan_write_folio,
         | ^~~~~~~~~~~
   include/trace/events/vmscan.h:353:9: note: in expansion of macro 'TP_fast_assign'
     353 |         TP_fast_assign(
         |         ^~~~~~~~~~~~~~


vim +358 include/trace/events/vmscan.h

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
   354			__entry->folio = folio;
   355			__entry->lru = folio_lru_list(folio);
   356		),
   357	
 > 358		TP_printk("folio=%p lru=%s",
   359			__entry->folio,
   360			__print_symbolic(__entry->lru, LRU_NAMES))
   361	);
   362	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
