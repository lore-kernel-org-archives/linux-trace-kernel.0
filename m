Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC1921D5BC;
	Tue,  3 Feb 2026 04:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770091605; cv=none; b=laMxYQl8igq7RpEhXz6RvgBwyegHj3wyWEgbzj96s661Q8eYRFZRJ9pjBSYXJJgY0F0lRkkXmAEeb6Efsirokol81SGRGZP2/+GDwZNX2RN8p8vXOkJnLQ3W2Phasnl487e1a+ekRrGIphavNeEIiZO9Ol3dL0egwzhAPq/rwVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770091605; c=relaxed/simple;
	bh=1Fusn8F3ZQ41oFOiUxvQbehOpvikJ/VqiSSVTS8Ut0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UDiNCadY8cs8aSu7ub2W0AA4+uzfwNJvE/TRwq90ZSiWLUSZQpu7BrUTcx15K1fCSEKw3Sq+WVBxsHsGBSXaJGvd+QviD5k1IQso1lkvzAN6BgHcb0BAkBQ0xDUUcDgG89uIL7Vg6R+z9D3pS9+pcqiJblKuAG6W9SgdnfdjQFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JCkf8082; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JCkf8082"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770091604; x=1801627604;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1Fusn8F3ZQ41oFOiUxvQbehOpvikJ/VqiSSVTS8Ut0Y=;
  b=JCkf8082iVQqNuCRhybnOU8rb0qO/ug7QV8s65rT3R8IsGbWmG6pr/AR
   SfkJfaHryHBXpIDIpxP6aIEi7dcGSOABNNTmX7318YFTug7dS3rDOzHEk
   JDETL+h6LFD6F09P9wUfXMxtlbAqq6/qPAYyiMeibqclK241kKY0t9gTv
   1QfJCNNSskjroHy5mTvcLfggfYGQ2B7R8qtycaxofh2FdKRRQ1TuR9sol
   uvJArwjqXJeg2XzE7zE6H/uOT1xjDdIG4qenPuP9xKHvz53s9m/0gr04V
   vOZS7wteLQ7PKB9ZvnoZ3lGHeWGhYm7WMhDpcRo1f9WFz9cr3c2wZK0pA
   g==;
X-CSE-ConnectionGUID: WHIc80lJQUylPYg9X0XSVg==
X-CSE-MsgGUID: NUcH5f5QQ8qDzd/BK8Ak5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="70274054"
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="70274054"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2026 20:06:44 -0800
X-CSE-ConnectionGUID: XjR/6+SgS82PCkDq72YJ+g==
X-CSE-MsgGUID: HI82SjdYRGquSLqqWQAa3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="209166509"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 02 Feb 2026 20:06:42 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vn7gV-00000000gEC-2cSa;
	Tue, 03 Feb 2026 04:06:39 +0000
Date: Tue, 3 Feb 2026 12:06:03 +0800
From: kernel test robot <lkp@intel.com>
To: "jempty.liang" <imntjempty@163.com>, rostedt@goodmis.org,
	mhiramat@kernel.org, mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	"jempty.liang" <imntjempty@163.com>
Subject: Re: [PATCH v2] tracing: Fix funcgraph_exit calltime/rettime offset
 for 32-bit ARM
Message-ID: <202602031142.uHVfwxw3-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on trace/for-next]
[also build test WARNING on linus/master v6.19-rc8 next-20260202]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/jempty-liang/tracing-Fix-funcgraph_exit-calltime-rettime-offset-for-32-bit-ARM/20260202-203926
base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
patch link:    https://lore.kernel.org/r/20260202123342.2544795-1-imntjempty%40163.com
patch subject: [PATCH v2] tracing: Fix funcgraph_exit calltime/rettime offset for 32-bit ARM
config: x86_64-buildonly-randconfig-004-20260203 (https://download.01.org/0day-ci/archive/20260203/202602031142.uHVfwxw3-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260203/202602031142.uHVfwxw3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602031142.uHVfwxw3-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/trace/trace_irqsoff.c: In function 'irqsoff_graph_return':
>> kernel/trace/trace_irqsoff.c:224:13: warning: unused variable 'rettime' [-Wunused-variable]
     224 |         u64 rettime;
         |             ^~~~~~~


vim +/rettime +224 kernel/trace/trace_irqsoff.c

62b915f1060996 Jiri Olsa                 2010-04-02  214  
37238abe3cb47b Steven Rostedt (VMware    2024-06-03  215) static void irqsoff_graph_return(struct ftrace_graph_ret *trace,
2ca8c112c9676e Masami Hiramatsu (Google  2024-12-26  216) 				 struct fgraph_ops *gops,
2ca8c112c9676e Masami Hiramatsu (Google  2024-12-26  217) 				 struct ftrace_regs *fregs)
62b915f1060996 Jiri Olsa                 2010-04-02  218  {
62b915f1060996 Jiri Olsa                 2010-04-02  219  	struct trace_array *tr = irqsoff_trace;
62b915f1060996 Jiri Olsa                 2010-04-02  220  	struct trace_array_cpu *data;
62b915f1060996 Jiri Olsa                 2010-04-02  221  	unsigned long flags;
36590c50b2d072 Sebastian Andrzej Siewior 2021-01-25  222  	unsigned int trace_ctx;
a485ea9e3ef31a Steven Rostedt            2025-01-13  223  	u64 *calltime;
66611c04757096 Steven Rostedt            2025-01-21 @224  	u64 rettime;
a485ea9e3ef31a Steven Rostedt            2025-01-13  225  	int size;
62b915f1060996 Jiri Olsa                 2010-04-02  226  
12117f3307b63f Steven Rostedt (VMware    2024-06-03  227) 	ftrace_graph_addr_finish(gops, trace);
5cf99a0f3161bc Steven Rostedt (VMware    2018-11-29  228) 
5e6d2b9cfa3a6e Steven Rostedt            2010-10-05  229  	if (!func_prolog_dec(tr, &data, &flags))
62b915f1060996 Jiri Olsa                 2010-04-02  230  		return;
62b915f1060996 Jiri Olsa                 2010-04-02  231  
77a67833e830fd jempty.liang              2026-02-02  232  	trace->rettime = trace_clock_local();
a485ea9e3ef31a Steven Rostedt            2025-01-13  233  	calltime = fgraph_retrieve_data(gops->idx, &size);
c834a97962c708 Steven Rostedt            2025-10-08  234  	if (calltime) {
77a67833e830fd jempty.liang              2026-02-02  235  		trace->calltime = *calltime;
36590c50b2d072 Sebastian Andrzej Siewior 2021-01-25  236  		trace_ctx = tracing_gen_ctx_flags(flags);
77a67833e830fd jempty.liang              2026-02-02  237  		__trace_graph_return(tr, trace, trace_ctx);
c834a97962c708 Steven Rostedt            2025-10-08  238  	}
90633c34c36d0c Steven Rostedt            2025-05-05  239  	local_dec(&data->disabled);
62b915f1060996 Jiri Olsa                 2010-04-02  240  }
62b915f1060996 Jiri Olsa                 2010-04-02  241  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
