Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08ECE442390;
	Thu,  6 Aug 2026 20:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786046737; cv=none; b=aSkSHTl4pzc6yrtbNXh7q1vnkzDAj62bwJqWaBLZfXh375U2EcFWApxhsVvDBVn/Y1+vADS9RcQtv0DVCHu2sUWRjshBgDjEsFDBpG2E4bodOti52CAQQXEz/LQndZtYzTUewF0smtkv+OfdJcvUFVBgae0oHycPfCP63un9k6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786046737; c=relaxed/simple;
	bh=ECQppSPi7hZBE855UOuyJolqE0BmrFQhmS4e8OtJaJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lyR6UWBzHo8t7BcJlyC5Mbu9zctoopV5Zp3TceHrWhvItx09sJw3GhvhBUQ2Hc0y+ahvpbhwWEjhG3uufLmhbd95k8Zp4qjUAAwTCOErP/cEP/bds8BDRhqdtkGW7mIyADCXyErzD2U+fdTKInd69e6IBD3LNamqjO5rw4TfLGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gWKmf77B; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gWKmf77B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786046732; x=1817582732;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ECQppSPi7hZBE855UOuyJolqE0BmrFQhmS4e8OtJaJk=;
  b=gWKmf77BZnpyzZgXzop0ks9WrGSd61XWlMpp4lKNszd2bjRUsvQ8RTaS
   pYvYZSn/0zpDdbAVuPdXOfSBzEYiFhbI/P3GvJLUzbM+YNvcoGXuB+UL6
   g80gSW1HSh8HU/kCQS0GykvFVpsa1WOEFAkWCxNpZHnU7OZW5WWNBNckp
   CoCD3YI26HyTclXNDhdyDcCWWbxF3QQzITqC+5TajG2r/RRekj3Kl2+jZ
   4lJpRzNqMOOgal7dNwx3xC1KQUejtEMHeu6lmVzfQrSBffdrHUjHlBjfQ
   WJfzuDrwHcenWIq+v0ArOVqEMOsWgJfbjiBwRzJsg+bUU1bihtMqgnEYG
   A==;
X-CSE-ConnectionGUID: ni3ixNeaSDupyqRm/B6/3w==
X-CSE-MsgGUID: 5QKEmgP8TK2t7rHI8Tt/sA==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="97809611"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="97809611"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 13:05:26 -0700
X-CSE-ConnectionGUID: kbkXwKR2TzaaboL6xfEBgw==
X-CSE-MsgGUID: NUNlK8DoQEW2G6Lb2TqzoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="265681054"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 06 Aug 2026 13:05:23 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1ws4LA-00000000G8r-4A5R;
	Thu, 06 Aug 2026 20:05:20 +0000
Date: Fri, 7 Aug 2026 04:04:46 +0800
From: kernel test robot <lkp@intel.com>
To: Martin Weiss <martin.githubacc@gmail.com>, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Martin Weiss <Martin.weiss2410@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] trace_branch: use per-cpu counters for correct/incorrect
 stats
Message-ID: <202608070317.EiUZyapo-lkp@intel.com>
References: <20260629095838.601926-1-Martin.weiss2410@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629095838.601926-1-Martin.weiss2410@gmail.com>

Hi Martin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on trace/for-next]
[also build test WARNING on linus/master v7.2-rc6 next-20260806]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Martin-Weiss/trace_branch-use-per-cpu-counters-for-correct-incorrect-stats/20260806-093445
base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
patch link:    https://lore.kernel.org/r/20260629095838.601926-1-Martin.weiss2410%40gmail.com
patch subject: [PATCH] trace_branch: use per-cpu counters for correct/incorrect stats
config: hexagon-randconfig-002-20260807 (https://download.01.org/0day-ci/archive/20260807/202608070317.EiUZyapo-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 12df34b8469b8095359de8c249cb1b2753fadeea)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260807/202608070317.EiUZyapo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608070317.EiUZyapo-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/trace/trace_branch.c:200:1: warning: all paths through this function will call itself [-Winfinite-recursion]
     200 | {
         | ^
   1 warning generated.


vim +200 kernel/trace/trace_branch.c

52f232cb720a7b kernel/trace/trace_unlikely.c Steven Rostedt          2008-11-12  197  
134e6a034cb004 kernel/trace/trace_branch.c   Steven Rostedt (VMware  2017-01-19  198) void ftrace_likely_update(struct ftrace_likely_data *f, int val,
d45ae1f7041ac5 kernel/trace/trace_branch.c   Steven Rostedt (VMware  2017-01-17  199) 			  int expect, int is_constant)
1f0d69a9fc815d kernel/trace/trace_unlikely.c Steven Rostedt          2008-11-12 @200  {
4a6c91fbdef846 kernel/trace/trace_branch.c   Peter Zijlstra          2019-03-07  201  	unsigned long flags = user_access_save();
4a6c91fbdef846 kernel/trace/trace_branch.c   Peter Zijlstra          2019-03-07  202  
d45ae1f7041ac5 kernel/trace/trace_branch.c   Steven Rostedt (VMware  2017-01-17  203) 	/* A constant is always correct */
134e6a034cb004 kernel/trace/trace_branch.c   Steven Rostedt (VMware  2017-01-19  204) 	if (is_constant) {
134e6a034cb004 kernel/trace/trace_branch.c   Steven Rostedt (VMware  2017-01-19  205) 		f->constant++;
d45ae1f7041ac5 kernel/trace/trace_branch.c   Steven Rostedt (VMware  2017-01-17  206) 		val = expect;
134e6a034cb004 kernel/trace/trace_branch.c   Steven Rostedt (VMware  2017-01-19  207) 	}
52f232cb720a7b kernel/trace/trace_unlikely.c Steven Rostedt          2008-11-12  208  	/*
52f232cb720a7b kernel/trace/trace_unlikely.c Steven Rostedt          2008-11-12  209  	 * I would love to have a trace point here instead, but the
52f232cb720a7b kernel/trace/trace_unlikely.c Steven Rostedt          2008-11-12  210  	 * trace point code is so inundated with unlikely and likely
52f232cb720a7b kernel/trace/trace_unlikely.c Steven Rostedt          2008-11-12  211  	 * conditions that the recursive nightmare that exists is too
52f232cb720a7b kernel/trace/trace_unlikely.c Steven Rostedt          2008-11-12  212  	 * much to try to get working. At least for now.
52f232cb720a7b kernel/trace/trace_unlikely.c Steven Rostedt          2008-11-12  213  	 */
068f530b3f274d kernel/trace/trace_branch.c   Steven Rostedt (VMware  2017-01-19  214) 	trace_likely_condition(f, val, expect);
52f232cb720a7b kernel/trace/trace_unlikely.c Steven Rostedt          2008-11-12  215  
a53c1587fa9e39 kernel/trace/trace_branch.c   Martin Weiss            2026-06-29  216  	/* use per-cpu counters to avoid contention */
1f0d69a9fc815d kernel/trace/trace_unlikely.c Steven Rostedt          2008-11-12  217  	if (val == expect)
a53c1587fa9e39 kernel/trace/trace_branch.c   Martin Weiss            2026-06-29  218  		this_cpu_inc(f->data.correct);
1f0d69a9fc815d kernel/trace/trace_unlikely.c Steven Rostedt          2008-11-12  219  	else
a53c1587fa9e39 kernel/trace/trace_branch.c   Martin Weiss            2026-06-29  220  		this_cpu_inc(f->data.incorrect);
4a6c91fbdef846 kernel/trace/trace_branch.c   Peter Zijlstra          2019-03-07  221  
4a6c91fbdef846 kernel/trace/trace_branch.c   Peter Zijlstra          2019-03-07  222  	user_access_restore(flags);
1f0d69a9fc815d kernel/trace/trace_unlikely.c Steven Rostedt          2008-11-12  223  }
1f0d69a9fc815d kernel/trace/trace_unlikely.c Steven Rostedt          2008-11-12  224  EXPORT_SYMBOL(ftrace_likely_update);
1f0d69a9fc815d kernel/trace/trace_unlikely.c Steven Rostedt          2008-11-12  225  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
