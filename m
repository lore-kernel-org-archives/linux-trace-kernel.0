Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8B12B2D7;
	Tue,  3 Feb 2026 04:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770092868; cv=none; b=b35q5aRuBPXonRVOAk7Cii5SLwQUZs9Ivq6x7SYS+v6s9KNUggLj1CmSHYWIBa2/aQ55pWllV1BNVvxfBsVKh0BEOyCkH2mWhH/wCfo/mcAPnlGOipfF0mKglZe6y5TzrD7UoD/KN4g6O+tw1RJ959ZkTvaVkMdoWN5xm3tVAwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770092868; c=relaxed/simple;
	bh=dEiE0Buq6T1WVEIiuNgelMiSvc6wNdy5lX+YkgjKcQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KYZCRx5HK5uIlo2WKvPN6DPTB7CNCA/85QOziEvb9/L3gcL118ui3teYYWASySRnHHrOyHbL+pU9IWYlYtVv/bw+Do/7Ayej4gUIvaky8Jyi9TMCglnR/srSDTWGBVg94JfOzVOkHOH0ZaZWbt85NklYO4LKoStUZnzkV82uScI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XF4CQaIP; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XF4CQaIP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770092867; x=1801628867;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dEiE0Buq6T1WVEIiuNgelMiSvc6wNdy5lX+YkgjKcQw=;
  b=XF4CQaIPs11xaVNuDzrrtff/wCSlpUgB/ns6oEwu6tCAjVBt13tjVIKc
   W3UeeY0ltj0boXox59kiFop0ELxJF5Od/txOZJKS6zpprAb0dYwsYSHYn
   DQlBQwD9/t50QH2+iHoeKm4DsOpZ4uIZuzjbDOTe+TlptsELThYCeuFig
   rtPux0XjlLS5mI1pPoTB3nZnI9AwCskgRby/VofRdMsBzj8mF5lcgptrp
   ecNYcFNExAs1JKoEWKrgvrkAiGzVSYVpOGw2e68C6YoSnt0/b4O9Go7+H
   X4zDZfDLc2vqgoD8wepk9aZWPHT/qZxE/J87pGVNOWMOHjv5TLabXVMYm
   w==;
X-CSE-ConnectionGUID: BukiC4UvTMGxpUzaqn1B+A==
X-CSE-MsgGUID: JOiVBQIxRyC4Mr6xn4Z4UA==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="71240277"
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="71240277"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2026 20:27:47 -0800
X-CSE-ConnectionGUID: RQTMeRl/RcWRNC8ZiqJzgQ==
X-CSE-MsgGUID: Q4zb/xFST1WqLMtfSZjETg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="209014269"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 02 Feb 2026 20:27:44 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vn80r-00000000gFA-2bDA;
	Tue, 03 Feb 2026 04:27:41 +0000
Date: Tue, 3 Feb 2026 12:26:55 +0800
From: kernel test robot <lkp@intel.com>
To: "jempty.liang" <imntjempty@163.com>, rostedt@goodmis.org,
	mhiramat@kernel.org, mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	"jempty.liang" <imntjempty@163.com>
Subject: Re: [PATCH v2] tracing: Fix funcgraph_exit calltime/rettime offset
 for 32-bit ARM
Message-ID: <202602031258.iZkcSFA8-lkp@intel.com>
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
[also build test ERROR on linus/master v6.19-rc8 next-20260202]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/jempty-liang/tracing-Fix-funcgraph_exit-calltime-rettime-offset-for-32-bit-ARM/20260202-203926
base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
patch link:    https://lore.kernel.org/r/20260202123342.2544795-1-imntjempty%40163.com
patch subject: [PATCH v2] tracing: Fix funcgraph_exit calltime/rettime offset for 32-bit ARM
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20260203/202602031258.iZkcSFA8-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260203/202602031258.iZkcSFA8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602031258.iZkcSFA8-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/trace/trace_sched_wakeup.c: In function 'wakeup_graph_return':
>> kernel/trace/trace_sched_wakeup.c:172:17: error: too many arguments to function '__trace_graph_return'; expected 3, have 5
     172 |                 __trace_graph_return(tr, trace, trace_ctx, *calltime, rettime);
         |                 ^~~~~~~~~~~~~~~~~~~~                       ~~~~~~~~~
   In file included from kernel/trace/trace_sched_wakeup.c:20:
   kernel/trace/trace.h:969:13: note: declared here
     969 | extern void __trace_graph_return(struct trace_array *tr,
         |             ^~~~~~~~~~~~~~~~~~~~


vim +/__trace_graph_return +172 kernel/trace/trace_sched_wakeup.c

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
