Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041C63921C0;
	Tue,  3 Feb 2026 07:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770103130; cv=none; b=nLIPpWZGdZX+ig6u7byvvD+Zz2KGtwGtq4Xzl88LvDLJBKU+br0DmAL1nDsJJc4XO/+Leo9soB4iZC37CqvL1hNHIbquAgqKXMWKXa2Yw3TqG+pw4AGHhJFymrsf1XVFpmwh1KBdQqXmuaDOJ1jY9b77EaXCUrqr/IoosrHda68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770103130; c=relaxed/simple;
	bh=UmmKzKP//jYEA/x8V2rp0gOc9GyRn2+bHkgmmo/vYC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f01vgNk7QmhVzIGZxZnarXrMaHCvD270lXLwjqnkFMeIBEKdpU+ZcBfyLkKz4NlY7AGfR5qvc8DqH/b5+azNHzYV+6kUvLbg6ul8GjmjcEk8yPZ8gThPLcqK+F7P27phS7+b2dkMMvJ6EK0ntpywOwjNPq0n+YwqwJyF3EmOzoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kCSaEfV/; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kCSaEfV/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770103129; x=1801639129;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UmmKzKP//jYEA/x8V2rp0gOc9GyRn2+bHkgmmo/vYC8=;
  b=kCSaEfV/j28PX/GaGByA7fYNJO5oVJ7KklgOx4pmK/ITP9w42fVYLczG
   r4ta10ISfFfNMNzvIbgshggT8h7JiJW7bGwVJpjokrcXVFNs6iyV/BCT+
   KasboZsKj2VUvopbIXDex+7oC7rfcyJ5eDscPt5+fK3WpbC17ztU9kyQh
   gUbCvQn+nUCjMVOG/uZd18OIz/OL+YZ28lL75+Fge8AkPhjNdZBlYUFaR
   pdhVEVSJbp9KGN6gdZhXS4yjgAzkMVa4C5P4Yt3D45IjSbS4omX254yyT
   pqth3HXRZgs5yJngIDkepcybPQUEJCBZzxB8YW78JU3NgiFodbEMAm03q
   g==;
X-CSE-ConnectionGUID: +aQZl2XDQO+66b69SOraMQ==
X-CSE-MsgGUID: OSGx9Z/eTpuKVgkeYdXg8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="88843102"
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="88843102"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2026 23:18:48 -0800
X-CSE-ConnectionGUID: mc78C21bQ0my3OB333vq+Q==
X-CSE-MsgGUID: 27fDqFC4Q2OOWsViLU5agQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="209205152"
Received: from igk-lkp-server01.igk.intel.com (HELO afc5bfd7f602) ([10.211.93.152])
  by fmviesa007.fm.intel.com with ESMTP; 02 Feb 2026 23:18:46 -0800
Received: from kbuild by afc5bfd7f602 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vnAgO-000000003Kb-0HCn;
	Tue, 03 Feb 2026 07:18:44 +0000
Date: Tue, 3 Feb 2026 08:18:23 +0100
From: kernel test robot <lkp@intel.com>
To: "jempty.liang" <imntjempty@163.com>, rostedt@goodmis.org,
	mhiramat@kernel.org, mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	"jempty.liang" <imntjempty@163.com>
Subject: Re: [PATCH v2] tracing: Fix funcgraph_exit calltime/rettime offset
 for 32-bit ARM
Message-ID: <202602030843.MZJLItcH-lkp@intel.com>
References: <20260202123342.2544795-1-imntjempty@163.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202123342.2544795-1-imntjempty@163.com>

Hi jempty.liang,

kernel test robot noticed the following build errors:

[auto build test ERROR on trace/for-next]
[also build test ERROR on next-20260202]
[cannot apply to linus/master v6.16-rc1]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/jempty-liang/tracing-Fix-funcgraph_exit-calltime-rettime-offset-for-32-bit-ARM/20260202-203926
base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
patch link:    https://lore.kernel.org/r/20260202123342.2544795-1-imntjempty%40163.com
patch subject: [PATCH v2] tracing: Fix funcgraph_exit calltime/rettime offset for 32-bit ARM
config: i386-allnoconfig-bpf (https://download.01.org/0day-ci/archive/20260203/202602030843.MZJLItcH-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260203/202602030843.MZJLItcH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602030843.MZJLItcH-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> kernel/trace/trace_irqsoff.c:224:6: warning: unused variable 'rettime' [-Wunused-variable]
     224 |         u64 rettime;
         |             ^~~~~~~
   1 warning generated.
--
>> kernel/trace/trace_sched_wakeup.c:172:46: error: too many arguments to function call, expected 3, have 5
     172 |                 __trace_graph_return(tr, trace, trace_ctx, *calltime, rettime);
         |                 ~~~~~~~~~~~~~~~~~~~~                       ^~~~~~~~~~~~~~~~~~
   kernel/trace/trace.h:969:13: note: '__trace_graph_return' declared here
     969 | extern void __trace_graph_return(struct trace_array *tr,
         |             ^                    ~~~~~~~~~~~~~~~~~~~~~~~
     970 |                                  struct ftrace_graph_ret *trace,
         |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     971 |                                  unsigned int trace_ctx);
         |                                  ~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +172 kernel/trace/trace_sched_wakeup.c

7495a5beaa22f1 Jiri Olsa                 2010-09-23  150  
37238abe3cb47b Steven Rostedt (VMware    2024-06-03  151) static void wakeup_graph_return(struct ftrace_graph_ret *trace,
2ca8c112c9676e Masami Hiramatsu (Google  2024-12-26  152) 				struct fgraph_ops *gops,
2ca8c112c9676e Masami Hiramatsu (Google  2024-12-26  153) 				struct ftrace_regs *fregs)
7495a5beaa22f1 Jiri Olsa                 2010-09-23  154  {
7495a5beaa22f1 Jiri Olsa                 2010-09-23  155  	struct trace_array *tr = wakeup_trace;
7495a5beaa22f1 Jiri Olsa                 2010-09-23  156  	struct trace_array_cpu *data;
36590c50b2d072 Sebastian Andrzej Siewior 2021-01-25  157  	unsigned int trace_ctx;
a485ea9e3ef31a Steven Rostedt            2025-01-13  158  	u64 *calltime;
66611c04757096 Steven Rostedt            2025-01-21  159  	u64 rettime;
a485ea9e3ef31a Steven Rostedt            2025-01-13  160  	int size;
7495a5beaa22f1 Jiri Olsa                 2010-09-23  161  
12117f3307b63f Steven Rostedt (VMware    2024-06-03  162) 	ftrace_graph_addr_finish(gops, trace);
5cf99a0f3161bc Steven Rostedt (VMware    2018-11-29  163) 
36590c50b2d072 Sebastian Andrzej Siewior 2021-01-25  164  	if (!func_prolog_preempt_disable(tr, &data, &trace_ctx))
7495a5beaa22f1 Jiri Olsa                 2010-09-23  165  		return;
7495a5beaa22f1 Jiri Olsa                 2010-09-23  166  
77a67833e830fd jempty.liang              2026-02-02  167  	trace->rettime = trace_clock_local();
66611c04757096 Steven Rostedt            2025-01-21  168  
a485ea9e3ef31a Steven Rostedt            2025-01-13  169  	calltime = fgraph_retrieve_data(gops->idx, &size);
77a67833e830fd jempty.liang              2026-02-02  170  	if (calltime) {
77a67833e830fd jempty.liang              2026-02-02  171  		trace->calltime = *calltime;
66611c04757096 Steven Rostedt            2025-01-21 @172  		__trace_graph_return(tr, trace, trace_ctx, *calltime, rettime);
77a67833e830fd jempty.liang              2026-02-02  173  	}
7495a5beaa22f1 Jiri Olsa                 2010-09-23  174  
4f7bf54b07e5ac Steven Rostedt            2025-10-08  175  	local_dec(&data->disabled);
7495a5beaa22f1 Jiri Olsa                 2010-09-23  176  	preempt_enable_notrace();
7495a5beaa22f1 Jiri Olsa                 2010-09-23  177  	return;
7495a5beaa22f1 Jiri Olsa                 2010-09-23  178  }
7495a5beaa22f1 Jiri Olsa                 2010-09-23  179  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
