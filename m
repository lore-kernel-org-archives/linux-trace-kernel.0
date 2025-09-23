Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB03DC8E6;
	Tue, 23 Sep 2025 01:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758592090; cv=none; b=uXvCtOH6GgDqpPak+poaF2kVSB0cR/6V+sXfanpkWAXGvd4T6RCGC8DIFH3A7ysMEO84lNKLOllxvMHHZI+rkp8kqk53G5FzrDbua/cCpUa3Hc721GagwhEnBcOHC11I7jHqNeqqtZETsl/rNBPKlUd1u2ggqcC1tNQw/x3TQNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758592090; c=relaxed/simple;
	bh=8myHUdIN5Q4epyELUuZOQ8wg/LpCjirio9+cZv+8eqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oFyAwkrCHwLDm/I6G/hK8rAmDO3MitFip2uMUa2hIYKbD53p7jHIWvp6ReXrRghCwucCPLZuiGL4d9I0vC8dv0EUz5dWSI+qvKPgHoL6mv1d4FRiJNCOaPvwqeIelG2IZpRmDA9hOWTbe7e+m+faP2bVY7kuBI2DMJqBl/lMPS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q/FbY8H5; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q/FbY8H5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758592088; x=1790128088;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8myHUdIN5Q4epyELUuZOQ8wg/LpCjirio9+cZv+8eqE=;
  b=Q/FbY8H5LeakbwUnfGG0u6OAt1zjXxULhZGzZ7mLIGpDUye5eCc2oRx0
   pakrWjylXKRNCQ5QPh+oTWlYL0I1jktpmiyT2X5aDAMIKTkkAmzfbaw07
   BNdSiUQ7lBpvBJvu58tbD5T4eowxrFvgAiyH8zC0BpuvMDGSmXGYMcDsu
   QxSDEYP9JzfYPjegGNSq+U+Df8htgdN4ojHR1pH226SKL1pKRT5DOuh8T
   utdQm8EmRnY1eXcGhPKqX9D1IgoweoayvkuAsofPsGuv282pb+GGX3qhB
   WAuSsNINRx4e8mcfYbNqaxw6eIYEB2fZGKzMkFWrJjXro9dJeblD3zpwq
   A==;
X-CSE-ConnectionGUID: HZ+zdc3YS+ixs24ZG7RjVg==
X-CSE-MsgGUID: FxO6GJAPSdm4t3u40av9sQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="60981485"
X-IronPort-AV: E=Sophos;i="6.18,286,1751266800"; 
   d="scan'208";a="60981485"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 18:48:06 -0700
X-CSE-ConnectionGUID: 8/J570XZRQGHmFEx+rpvTQ==
X-CSE-MsgGUID: ODdgd9HwQSyvk+aQNCUpDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,286,1751266800"; 
   d="scan'208";a="175910976"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 22 Sep 2025 18:48:03 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v0s8E-0002dF-0I;
	Tue, 23 Sep 2025 01:47:53 +0000
Date: Tue, 23 Sep 2025 09:47:13 +0800
From: kernel test robot <lkp@intel.com>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: oe-kbuild-all@lists.linux.dev, Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] tracing: Allow tracer to add more than 32 options
Message-ID: <202509230952.UvKzcDdq-lkp@intel.com>
References: <175854517136.353182.4018685864707176851.stgit@devnote2>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175854517136.353182.4018685864707176851.stgit@devnote2>

Hi Masami,

kernel test robot noticed the following build warnings:

[auto build test WARNING on trace/for-next]
[also build test WARNING on linus/master v6.17-rc7 next-20250922]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Masami-Hiramatsu-Google/tracing-Allow-tracer-to-add-more-than-32-options/20250922-204945
base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
patch link:    https://lore.kernel.org/r/175854517136.353182.4018685864707176851.stgit%40devnote2
patch subject: [PATCH v2 1/2] tracing: Allow tracer to add more than 32 options
config: sh-randconfig-001-20250923 (https://download.01.org/0day-ci/archive/20250923/202509230952.UvKzcDdq-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250923/202509230952.UvKzcDdq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509230952.UvKzcDdq-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from kernel/trace/fgraph.c:20:
   kernel/trace/trace.h:1414:34: warning: 'TRACE_ITER_STACKTRACE' defined but not used [-Wunused-const-variable=]
    1414 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
         |                                  ^~~~~~~~~~~
   kernel/trace/trace.h:1351:17: note: in expansion of macro 'C'
    1351 |                 C(STACKTRACE,           "stacktrace")
         |                 ^
   kernel/trace/trace.h:1393:17: note: in expansion of macro 'STACK_FLAGS'
    1393 |                 STACK_FLAGS                                     \
         |                 ^~~~~~~~~~~
   kernel/trace/trace.h:1416:1: note: in expansion of macro 'TRACE_FLAGS'
    1416 | TRACE_FLAGS
         | ^~~~~~~~~~~
>> kernel/trace/trace.h:1414:34: warning: 'TRACE_ITER_DISPLAY_GRAPH' defined but not used [-Wunused-const-variable=]
    1414 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
         |                                  ^~~~~~~~~~~
   kernel/trace/trace.h:1326:17: note: in expansion of macro 'C'
    1326 |                 C(DISPLAY_GRAPH,        "display-graph")
         |                 ^
   kernel/trace/trace.h:1392:17: note: in expansion of macro 'FGRAPH_FLAGS'
    1392 |                 FGRAPH_FLAGS                                    \
         |                 ^~~~~~~~~~~~
   kernel/trace/trace.h:1416:1: note: in expansion of macro 'TRACE_FLAGS'
    1416 | TRACE_FLAGS
         | ^~~~~~~~~~~
   kernel/trace/trace.h:1414:34: warning: 'TRACE_ITER_FUNC_FORK' defined but not used [-Wunused-const-variable=]
    1414 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
         |                                  ^~~~~~~~~~~
   kernel/trace/trace.h:1341:17: note: in expansion of macro 'C'
    1341 |                 C(FUNC_FORK,            "function-fork")
         |                 ^
   kernel/trace/trace.h:1391:17: note: in expansion of macro 'FUNCTION_FLAGS'
    1391 |                 FUNCTION_FLAGS                                  \
         |                 ^~~~~~~~~~~~~~
   kernel/trace/trace.h:1416:1: note: in expansion of macro 'TRACE_FLAGS'
    1416 | TRACE_FLAGS
         | ^~~~~~~~~~~
   kernel/trace/trace.h:1414:34: warning: 'TRACE_ITER_FUNCTION' defined but not used [-Wunused-const-variable=]
    1414 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
         |                                  ^~~~~~~~~~~
   kernel/trace/trace.h:1340:17: note: in expansion of macro 'C'
    1340 |                 C(FUNCTION,             "function-trace")       \
         |                 ^
   kernel/trace/trace.h:1391:17: note: in expansion of macro 'FUNCTION_FLAGS'
    1391 |                 FUNCTION_FLAGS                                  \
         |                 ^~~~~~~~~~~~~~
   kernel/trace/trace.h:1416:1: note: in expansion of macro 'TRACE_FLAGS'
    1416 | TRACE_FLAGS
         | ^~~~~~~~~~~
   kernel/trace/trace.h:1414:34: warning: 'TRACE_ITER_HASH_PTR' defined but not used [-Wunused-const-variable=]
    1414 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
         |                                  ^~~~~~~~~~~
   kernel/trace/trace.h:1390:17: note: in expansion of macro 'C'
    1390 |                 C(HASH_PTR,             "hash-ptr")     /* Print hashed pointer */ \
         |                 ^
   kernel/trace/trace.h:1416:1: note: in expansion of macro 'TRACE_FLAGS'
    1416 | TRACE_FLAGS
         | ^~~~~~~~~~~
   kernel/trace/trace.h:1414:34: warning: 'TRACE_ITER_PAUSE_ON_TRACE' defined but not used [-Wunused-const-variable=]
    1414 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
         |                                  ^~~~~~~~~~~
   kernel/trace/trace.h:1389:17: note: in expansion of macro 'C'
    1389 |                 C(PAUSE_ON_TRACE,       "pause-on-trace")       \
         |                 ^
   kernel/trace/trace.h:1416:1: note: in expansion of macro 'TRACE_FLAGS'
    1416 | TRACE_FLAGS
         | ^~~~~~~~~~~
   kernel/trace/trace.h:1414:34: warning: 'TRACE_ITER_COPY_MARKER' defined but not used [-Wunused-const-variable=]
    1414 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
         |                                  ^~~~~~~~~~~
   kernel/trace/trace.h:1388:17: note: in expansion of macro 'C'
    1388 |                 C(COPY_MARKER,          "copy_trace_marker")\
         |                 ^
   kernel/trace/trace.h:1416:1: note: in expansion of macro 'TRACE_FLAGS'
    1416 | TRACE_FLAGS
         | ^~~~~~~~~~~
   kernel/trace/trace.h:1414:34: warning: 'TRACE_ITER_TRACE_PRINTK' defined but not used [-Wunused-const-variable=]
    1414 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
         |                                  ^~~~~~~~~~~
   kernel/trace/trace.h:1387:17: note: in expansion of macro 'C'
    1387 |                 C(TRACE_PRINTK,         "trace_printk_dest")    \
         |                 ^
   kernel/trace/trace.h:1416:1: note: in expansion of macro 'TRACE_FLAGS'
    1416 | TRACE_FLAGS
         | ^~~~~~~~~~~
   kernel/trace/trace.h:1414:34: warning: 'TRACE_ITER_EVENT_FORK' defined but not used [-Wunused-const-variable=]
    1414 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
         |                                  ^~~~~~~~~~~
   kernel/trace/trace.h:1386:17: note: in expansion of macro 'C'
    1386 |                 C(EVENT_FORK,           "event-fork")           \
         |                 ^
   kernel/trace/trace.h:1416:1: note: in expansion of macro 'TRACE_FLAGS'
    1416 | TRACE_FLAGS
         | ^~~~~~~~~~~
   kernel/trace/trace.h:1414:34: warning: 'TRACE_ITER_MARKERS' defined but not used [-Wunused-const-variable=]
    1414 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
         |                                  ^~~~~~~~~~~
   kernel/trace/trace.h:1385:17: note: in expansion of macro 'C'
    1385 |                 C(MARKERS,              "markers")              \
         |                 ^
   kernel/trace/trace.h:1416:1: note: in expansion of macro 'TRACE_FLAGS'
    1416 | TRACE_FLAGS
         | ^~~~~~~~~~~
   kernel/trace/trace.h:1414:34: warning: 'TRACE_ITER_IRQ_INFO' defined but not used [-Wunused-const-variable=]
    1414 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
         |                                  ^~~~~~~~~~~
   kernel/trace/trace.h:1384:17: note: in expansion of macro 'C'
    1384 |                 C(IRQ_INFO,             "irq-info")             \
         |                 ^
   kernel/trace/trace.h:1416:1: note: in expansion of macro 'TRACE_FLAGS'
    1416 | TRACE_FLAGS
         | ^~~~~~~~~~~
   kernel/trace/trace.h:1414:34: warning: 'TRACE_ITER_STOP_ON_FREE' defined but not used [-Wunused-const-variable=]
    1414 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
--
   In file included from kernel/trace/trace.c:58:
>> kernel/trace/trace.h:1414:34: warning: 'TRACE_ITER_DISPLAY_GRAPH' defined but not used [-Wunused-const-variable=]
    1414 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
         |                                  ^~~~~~~~~~~
   kernel/trace/trace.h:1326:17: note: in expansion of macro 'C'
    1326 |                 C(DISPLAY_GRAPH,        "display-graph")
         |                 ^
   kernel/trace/trace.h:1392:17: note: in expansion of macro 'FGRAPH_FLAGS'
    1392 |                 FGRAPH_FLAGS                                    \
         |                 ^~~~~~~~~~~~
   kernel/trace/trace.h:1416:1: note: in expansion of macro 'TRACE_FLAGS'
    1416 | TRACE_FLAGS
         | ^~~~~~~~~~~
   kernel/trace/trace.h:1414:34: warning: 'TRACE_ITER_USERSTACKTRACE' defined but not used [-Wunused-const-variable=]
    1414 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
         |                                  ^~~~~~~~~~~
   kernel/trace/trace.h:1375:17: note: in expansion of macro 'C'
    1375 |                 C(USERSTACKTRACE,       "userstacktrace")       \
         |                 ^
   kernel/trace/trace.h:1416:1: note: in expansion of macro 'TRACE_FLAGS'
    1416 | TRACE_FLAGS
         | ^~~~~~~~~~~
   {standard input}: Assembler messages:
   {standard input}:6792: Error: offset to unaligned destination
   {standard input}:24045: Error: offset to unaligned destination
   {standard input}:24422: Error: offset to unaligned destination
   {standard input}:32500: Error: offset to unaligned destination
--
   In file included from kernel/trace/trace_output.h:6,
                    from kernel/trace/trace_events.c:31:
   kernel/trace/trace.h:1414:34: warning: 'TRACE_ITER_STACKTRACE' defined but not used [-Wunused-const-variable=]
    1414 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
         |                                  ^~~~~~~~~~~
   kernel/trace/trace.h:1351:17: note: in expansion of macro 'C'
    1351 |                 C(STACKTRACE,           "stacktrace")
         |                 ^
   kernel/trace/trace.h:1393:17: note: in expansion of macro 'STACK_FLAGS'
    1393 |                 STACK_FLAGS                                     \
         |                 ^~~~~~~~~~~
   kernel/trace/trace.h:1416:1: note: in expansion of macro 'TRACE_FLAGS'
    1416 | TRACE_FLAGS
         | ^~~~~~~~~~~
>> kernel/trace/trace.h:1414:34: warning: 'TRACE_ITER_DISPLAY_GRAPH' defined but not used [-Wunused-const-variable=]
    1414 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
         |                                  ^~~~~~~~~~~
   kernel/trace/trace.h:1326:17: note: in expansion of macro 'C'
    1326 |                 C(DISPLAY_GRAPH,        "display-graph")
         |                 ^
   kernel/trace/trace.h:1392:17: note: in expansion of macro 'FGRAPH_FLAGS'
    1392 |                 FGRAPH_FLAGS                                    \
         |                 ^~~~~~~~~~~~
   kernel/trace/trace.h:1416:1: note: in expansion of macro 'TRACE_FLAGS'
    1416 | TRACE_FLAGS
         | ^~~~~~~~~~~
   kernel/trace/trace.h:1414:34: warning: 'TRACE_ITER_FUNC_FORK' defined but not used [-Wunused-const-variable=]
    1414 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
         |                                  ^~~~~~~~~~~
   kernel/trace/trace.h:1341:17: note: in expansion of macro 'C'
    1341 |                 C(FUNC_FORK,            "function-fork")
         |                 ^
   kernel/trace/trace.h:1391:17: note: in expansion of macro 'FUNCTION_FLAGS'
    1391 |                 FUNCTION_FLAGS                                  \
         |                 ^~~~~~~~~~~~~~
   kernel/trace/trace.h:1416:1: note: in expansion of macro 'TRACE_FLAGS'
    1416 | TRACE_FLAGS
         | ^~~~~~~~~~~
   kernel/trace/trace.h:1414:34: warning: 'TRACE_ITER_FUNCTION' defined but not used [-Wunused-const-variable=]
    1414 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
         |                                  ^~~~~~~~~~~
   kernel/trace/trace.h:1340:17: note: in expansion of macro 'C'
    1340 |                 C(FUNCTION,             "function-trace")       \
         |                 ^
   kernel/trace/trace.h:1391:17: note: in expansion of macro 'FUNCTION_FLAGS'
    1391 |                 FUNCTION_FLAGS                                  \
         |                 ^~~~~~~~~~~~~~
   kernel/trace/trace.h:1416:1: note: in expansion of macro 'TRACE_FLAGS'
    1416 | TRACE_FLAGS
         | ^~~~~~~~~~~
   kernel/trace/trace.h:1414:34: warning: 'TRACE_ITER_HASH_PTR' defined but not used [-Wunused-const-variable=]
    1414 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
         |                                  ^~~~~~~~~~~
   kernel/trace/trace.h:1390:17: note: in expansion of macro 'C'
    1390 |                 C(HASH_PTR,             "hash-ptr")     /* Print hashed pointer */ \
         |                 ^
   kernel/trace/trace.h:1416:1: note: in expansion of macro 'TRACE_FLAGS'
    1416 | TRACE_FLAGS
         | ^~~~~~~~~~~
   kernel/trace/trace.h:1414:34: warning: 'TRACE_ITER_PAUSE_ON_TRACE' defined but not used [-Wunused-const-variable=]
    1414 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
         |                                  ^~~~~~~~~~~
   kernel/trace/trace.h:1389:17: note: in expansion of macro 'C'
    1389 |                 C(PAUSE_ON_TRACE,       "pause-on-trace")       \
         |                 ^
   kernel/trace/trace.h:1416:1: note: in expansion of macro 'TRACE_FLAGS'
    1416 | TRACE_FLAGS
         | ^~~~~~~~~~~
   kernel/trace/trace.h:1414:34: warning: 'TRACE_ITER_COPY_MARKER' defined but not used [-Wunused-const-variable=]
    1414 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
         |                                  ^~~~~~~~~~~
   kernel/trace/trace.h:1388:17: note: in expansion of macro 'C'
    1388 |                 C(COPY_MARKER,          "copy_trace_marker")\
         |                 ^
   kernel/trace/trace.h:1416:1: note: in expansion of macro 'TRACE_FLAGS'
    1416 | TRACE_FLAGS
         | ^~~~~~~~~~~
   kernel/trace/trace.h:1414:34: warning: 'TRACE_ITER_TRACE_PRINTK' defined but not used [-Wunused-const-variable=]
    1414 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
         |                                  ^~~~~~~~~~~
   kernel/trace/trace.h:1387:17: note: in expansion of macro 'C'
    1387 |                 C(TRACE_PRINTK,         "trace_printk_dest")    \
         |                 ^
   kernel/trace/trace.h:1416:1: note: in expansion of macro 'TRACE_FLAGS'
    1416 | TRACE_FLAGS
         | ^~~~~~~~~~~
   kernel/trace/trace.h:1414:34: warning: 'TRACE_ITER_EVENT_FORK' defined but not used [-Wunused-const-variable=]
    1414 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
         |                                  ^~~~~~~~~~~
   kernel/trace/trace.h:1386:17: note: in expansion of macro 'C'
    1386 |                 C(EVENT_FORK,           "event-fork")           \
         |                 ^
   kernel/trace/trace.h:1416:1: note: in expansion of macro 'TRACE_FLAGS'
    1416 | TRACE_FLAGS
         | ^~~~~~~~~~~
   kernel/trace/trace.h:1414:34: warning: 'TRACE_ITER_MARKERS' defined but not used [-Wunused-const-variable=]
    1414 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
         |                                  ^~~~~~~~~~~
   kernel/trace/trace.h:1385:17: note: in expansion of macro 'C'
    1385 |                 C(MARKERS,              "markers")              \
         |                 ^
   kernel/trace/trace.h:1416:1: note: in expansion of macro 'TRACE_FLAGS'
    1416 | TRACE_FLAGS
         | ^~~~~~~~~~~
   kernel/trace/trace.h:1414:34: warning: 'TRACE_ITER_IRQ_INFO' defined but not used [-Wunused-const-variable=]
    1414 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
         |                                  ^~~~~~~~~~~
   kernel/trace/trace.h:1384:17: note: in expansion of macro 'C'
    1384 |                 C(IRQ_INFO,             "irq-info")             \
         |                 ^
   kernel/trace/trace.h:1416:1: note: in expansion of macro 'TRACE_FLAGS'
    1416 | TRACE_FLAGS
         | ^~~~~~~~~~~
   kernel/trace/trace.h:1414:34: warning: 'TRACE_ITER_STOP_ON_FREE' defined but not used [-Wunused-const-variable=]
    1414 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
--
   In file included from kernel/trace/ring_buffer.c:36:
   kernel/trace/trace.h:1414:34: warning: 'TRACE_ITER_STACKTRACE' defined but not used [-Wunused-const-variable=]
    1414 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
         |                                  ^~~~~~~~~~~
   kernel/trace/trace.h:1351:17: note: in expansion of macro 'C'
    1351 |                 C(STACKTRACE,           "stacktrace")
         |                 ^
   kernel/trace/trace.h:1393:17: note: in expansion of macro 'STACK_FLAGS'
    1393 |                 STACK_FLAGS                                     \
         |                 ^~~~~~~~~~~
   kernel/trace/trace.h:1416:1: note: in expansion of macro 'TRACE_FLAGS'
    1416 | TRACE_FLAGS
         | ^~~~~~~~~~~
>> kernel/trace/trace.h:1414:34: warning: 'TRACE_ITER_DISPLAY_GRAPH' defined but not used [-Wunused-const-variable=]
    1414 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
         |                                  ^~~~~~~~~~~
   kernel/trace/trace.h:1326:17: note: in expansion of macro 'C'
    1326 |                 C(DISPLAY_GRAPH,        "display-graph")
         |                 ^
   kernel/trace/trace.h:1392:17: note: in expansion of macro 'FGRAPH_FLAGS'
    1392 |                 FGRAPH_FLAGS                                    \
         |                 ^~~~~~~~~~~~
   kernel/trace/trace.h:1416:1: note: in expansion of macro 'TRACE_FLAGS'
    1416 | TRACE_FLAGS
         | ^~~~~~~~~~~
   kernel/trace/trace.h:1414:34: warning: 'TRACE_ITER_FUNC_FORK' defined but not used [-Wunused-const-variable=]
    1414 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
         |                                  ^~~~~~~~~~~
   kernel/trace/trace.h:1341:17: note: in expansion of macro 'C'
    1341 |                 C(FUNC_FORK,            "function-fork")
         |                 ^
   kernel/trace/trace.h:1391:17: note: in expansion of macro 'FUNCTION_FLAGS'
    1391 |                 FUNCTION_FLAGS                                  \
         |                 ^~~~~~~~~~~~~~
   kernel/trace/trace.h:1416:1: note: in expansion of macro 'TRACE_FLAGS'
    1416 | TRACE_FLAGS
         | ^~~~~~~~~~~
   kernel/trace/trace.h:1414:34: warning: 'TRACE_ITER_FUNCTION' defined but not used [-Wunused-const-variable=]
    1414 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
         |                                  ^~~~~~~~~~~
   kernel/trace/trace.h:1340:17: note: in expansion of macro 'C'
    1340 |                 C(FUNCTION,             "function-trace")       \
         |                 ^
   kernel/trace/trace.h:1391:17: note: in expansion of macro 'FUNCTION_FLAGS'
    1391 |                 FUNCTION_FLAGS                                  \
         |                 ^~~~~~~~~~~~~~
   kernel/trace/trace.h:1416:1: note: in expansion of macro 'TRACE_FLAGS'
    1416 | TRACE_FLAGS
         | ^~~~~~~~~~~
   kernel/trace/trace.h:1414:34: warning: 'TRACE_ITER_HASH_PTR' defined but not used [-Wunused-const-variable=]
    1414 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
         |                                  ^~~~~~~~~~~
   kernel/trace/trace.h:1390:17: note: in expansion of macro 'C'
    1390 |                 C(HASH_PTR,             "hash-ptr")     /* Print hashed pointer */ \
         |                 ^
   kernel/trace/trace.h:1416:1: note: in expansion of macro 'TRACE_FLAGS'
    1416 | TRACE_FLAGS
         | ^~~~~~~~~~~
   kernel/trace/trace.h:1414:34: warning: 'TRACE_ITER_PAUSE_ON_TRACE' defined but not used [-Wunused-const-variable=]
    1414 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
         |                                  ^~~~~~~~~~~
   kernel/trace/trace.h:1389:17: note: in expansion of macro 'C'
    1389 |                 C(PAUSE_ON_TRACE,       "pause-on-trace")       \
         |                 ^
   kernel/trace/trace.h:1416:1: note: in expansion of macro 'TRACE_FLAGS'
    1416 | TRACE_FLAGS
         | ^~~~~~~~~~~
   kernel/trace/trace.h:1414:34: warning: 'TRACE_ITER_COPY_MARKER' defined but not used [-Wunused-const-variable=]
    1414 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
         |                                  ^~~~~~~~~~~
   kernel/trace/trace.h:1388:17: note: in expansion of macro 'C'
    1388 |                 C(COPY_MARKER,          "copy_trace_marker")\
         |                 ^
   kernel/trace/trace.h:1416:1: note: in expansion of macro 'TRACE_FLAGS'
    1416 | TRACE_FLAGS
         | ^~~~~~~~~~~
   kernel/trace/trace.h:1414:34: warning: 'TRACE_ITER_TRACE_PRINTK' defined but not used [-Wunused-const-variable=]
    1414 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
         |                                  ^~~~~~~~~~~
   kernel/trace/trace.h:1387:17: note: in expansion of macro 'C'
    1387 |                 C(TRACE_PRINTK,         "trace_printk_dest")    \
         |                 ^
   kernel/trace/trace.h:1416:1: note: in expansion of macro 'TRACE_FLAGS'
    1416 | TRACE_FLAGS
         | ^~~~~~~~~~~
   kernel/trace/trace.h:1414:34: warning: 'TRACE_ITER_EVENT_FORK' defined but not used [-Wunused-const-variable=]
    1414 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
         |                                  ^~~~~~~~~~~
   kernel/trace/trace.h:1386:17: note: in expansion of macro 'C'
    1386 |                 C(EVENT_FORK,           "event-fork")           \
         |                 ^
   kernel/trace/trace.h:1416:1: note: in expansion of macro 'TRACE_FLAGS'
    1416 | TRACE_FLAGS
         | ^~~~~~~~~~~
   kernel/trace/trace.h:1414:34: warning: 'TRACE_ITER_MARKERS' defined but not used [-Wunused-const-variable=]
    1414 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
         |                                  ^~~~~~~~~~~
   kernel/trace/trace.h:1385:17: note: in expansion of macro 'C'
    1385 |                 C(MARKERS,              "markers")              \
         |                 ^
   kernel/trace/trace.h:1416:1: note: in expansion of macro 'TRACE_FLAGS'
    1416 | TRACE_FLAGS
         | ^~~~~~~~~~~
   kernel/trace/trace.h:1414:34: warning: 'TRACE_ITER_IRQ_INFO' defined but not used [-Wunused-const-variable=]
    1414 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
         |                                  ^~~~~~~~~~~
   kernel/trace/trace.h:1384:17: note: in expansion of macro 'C'
    1384 |                 C(IRQ_INFO,             "irq-info")             \
         |                 ^
   kernel/trace/trace.h:1416:1: note: in expansion of macro 'TRACE_FLAGS'
    1416 | TRACE_FLAGS
         | ^~~~~~~~~~~
   kernel/trace/trace.h:1414:34: warning: 'TRACE_ITER_STOP_ON_FREE' defined but not used [-Wunused-const-variable=]
    1414 | #define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
..


vim +/TRACE_ITER_DISPLAY_GRAPH +1414 kernel/trace/trace.h

  1348	
  1349	#ifdef CONFIG_STACKTRACE
  1350	# define STACK_FLAGS				\
> 1351			C(STACKTRACE,		"stacktrace")
  1352	#else
  1353	# define STACK_FLAGS
  1354	#endif
  1355	
  1356	/*
  1357	 * trace_iterator_flags is an enumeration that defines bit
  1358	 * positions into trace_flags that controls the output.
  1359	 *
  1360	 * NOTE: These bits must match the trace_options array in
  1361	 *       trace.c (this macro guarantees it).
  1362	 */
  1363	#define TRACE_FLAGS						\
  1364			C(PRINT_PARENT,		"print-parent")		\
  1365			C(SYM_OFFSET,		"sym-offset")		\
  1366			C(SYM_ADDR,		"sym-addr")		\
  1367			C(VERBOSE,		"verbose")		\
  1368			C(RAW,			"raw")			\
  1369			C(HEX,			"hex")			\
  1370			C(BIN,			"bin")			\
  1371			C(BLOCK,		"block")		\
  1372			C(FIELDS,		"fields")		\
  1373			C(PRINTK,		"trace_printk")	\
  1374			C(ANNOTATE,		"annotate")		\
  1375			C(USERSTACKTRACE,	"userstacktrace")	\
  1376			C(SYM_USEROBJ,		"sym-userobj")		\
  1377			C(PRINTK_MSGONLY,	"printk-msg-only")	\
  1378			C(CONTEXT_INFO,		"context-info")   /* Print pid/cpu/time */ \
  1379			C(LATENCY_FMT,		"latency-format")	\
  1380			C(RECORD_CMD,		"record-cmd")		\
  1381			C(RECORD_TGID,		"record-tgid")		\
  1382			C(OVERWRITE,		"overwrite")		\
  1383			C(STOP_ON_FREE,		"disable_on_free")	\
  1384			C(IRQ_INFO,		"irq-info")		\
  1385			C(MARKERS,		"markers")		\
  1386			C(EVENT_FORK,		"event-fork")		\
  1387			C(TRACE_PRINTK,		"trace_printk_dest")	\
  1388			C(COPY_MARKER,		"copy_trace_marker")\
  1389			C(PAUSE_ON_TRACE,	"pause-on-trace")	\
  1390			C(HASH_PTR,		"hash-ptr")	/* Print hashed pointer */ \
  1391			FUNCTION_FLAGS					\
  1392			FGRAPH_FLAGS					\
  1393			STACK_FLAGS					\
  1394			BRANCH_FLAGS
  1395	
  1396	/*
  1397	 * By defining C, we can make TRACE_FLAGS a list of bit names
  1398	 * that will define the bits for the flag masks.
  1399	 */
  1400	#undef C
  1401	#define C(a, b) TRACE_ITER_##a##_BIT,
  1402	
  1403	enum trace_iterator_bits {
  1404		TRACE_FLAGS
  1405		/* Make sure we don't go more than we have bits for */
  1406		TRACE_ITER_LAST_BIT
  1407	};
  1408	
  1409	/*
  1410	 * By redefining C, we can make TRACE_FLAGS a list of masks that
  1411	 * use the bits as defined above.
  1412	 */
  1413	#undef C
> 1414	#define C(a, b) static const u64 TRACE_ITER_##a = (1ULL << TRACE_ITER_##a##_BIT);
  1415	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
