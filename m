Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460CF37F333;
	Thu,  6 Aug 2026 16:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786035247; cv=none; b=HfFYxcFeV/BgXvJEiKxMQfgZwphyhcxjoFhEHdsA3/SjgdQYztPJbpc+U1qVGwj5iJTClvUbHie48GemCxFCBT3mgqB+MCSRI0haW/iSdIyrKWWswzNc5k4y/74N+XmpRcF9Gt9BTIx05VrB5078u46YmRpdzQGsBYQxmIBRMk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786035247; c=relaxed/simple;
	bh=ijet5q641iizCCPDbWe6qAYNPvfuSgFXgHd9tGZ1ulM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MYHd26+69gIGUSW9sfOoU3IPCLtBMZDAnGzlGIgG4mGIOzz+LVc/8LImjlsFAoGMUpjVxmt+MtIilgPZ86hUuu9BrTwQgLwJgQ9ZgWJKehXnAZ0SOT058em79SdSQb29OI2kciZcVgQpn3XLqtAuGvD4P7YsopBtoP99SNDpRAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I3rF6SYo; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I3rF6SYo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786035245; x=1817571245;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ijet5q641iizCCPDbWe6qAYNPvfuSgFXgHd9tGZ1ulM=;
  b=I3rF6SYokyoIwqQ12tXsRTR/qEnkmxCkcW8PUQZIhDBIJ8rrUk5Njh4F
   587vbZ73Qm+DIJWx8bhIsSdTGYO4plx3CkIkzWt6n97Wodl99tpG8ZeE4
   1MgNhhVvXZf8NbV4kxFy9v5vJJ5/JJ2RGYFb9voZkpwyjrQtiGELfeFn8
   Zqj2/MDVxB+JE+ZEBHToi0+pxIMfQDer/6ZR4s1WctXnErviw+zPYs7ed
   AtnLZ0j6dfnPMM+vupswvpxxLcMuLq+qIfnW0nkRAbfaLdG4RfCRWd1io
   rOyiw6PTvo2nuev4p0u8jOpxHPHfASFUdWBNCCmD6g30sJcr9URppaZyC
   w==;
X-CSE-ConnectionGUID: Tu05L2FZQ0mIEbwsryniyA==
X-CSE-MsgGUID: qHFZ6piPRDWEA6yaGLMDDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86486217"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="86486217"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 09:54:04 -0700
X-CSE-ConnectionGUID: vcG3Zu0eShq4diKcXCaeVg==
X-CSE-MsgGUID: jG606nB5SPqMIoWZuUMP9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="257853545"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 06 Aug 2026 09:54:01 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1ws1Ly-00000000Fi9-3CTs;
	Thu, 06 Aug 2026 16:53:58 +0000
Date: Fri, 7 Aug 2026 00:53:24 +0800
From: kernel test robot <lkp@intel.com>
To: Martin Weiss <martin.githubacc@gmail.com>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Martin Weiss <Martin.weiss2410@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] trace_branch: use per-cpu counters for correct/incorrect
 stats
Message-ID: <202608070005.js0pMRDK-lkp@intel.com>
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
config: arm64-randconfig-r062-20260806 (https://download.01.org/0day-ci/archive/20260807/202608070005.js0pMRDK-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260807/202608070005.js0pMRDK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608070005.js0pMRDK-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/trace/trace_branch.c: In function 'ftrace_likely_update':
>> kernel/trace/trace_branch.c:198:6: warning: infinite recursion detected [-Winfinite-recursion]
     198 | void ftrace_likely_update(struct ftrace_likely_data *f, int val,
         |      ^~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/array_size.h:5,
                    from include/linux/kernel.h:16,
                    from include/linux/kallsyms.h:11,
                    from kernel/trace/trace_branch.c:7:
   include/linux/compiler.h:33:25: note: recursive call
      33 |                         ftrace_likely_update(&______f, ______r,         \
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      34 |                                              expect, is_constant);      \
         |                                              ~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:68:10: note: in definition of macro '__trace_if_value'
      68 |         (cond) ?                                        \
         |          ^~~~
   include/linux/compiler.h:55:28: note: in expansion of macro '__trace_if_var'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ^~~~~~~~~~~~~~
   include/linux/preempt.h:238:9: note: in expansion of macro 'if'
     238 |         if (unlikely(__preempt_count_dec_and_test())) \
         |         ^~
   include/linux/compiler.h:47:26: note: in expansion of macro '__branch_check__'
      47 | #  define unlikely(x)   (__branch_check__(x, 0, __builtin_constant_p(x)))
         |                          ^~~~~~~~~~~~~~~~
   include/linux/preempt.h:238:13: note: in expansion of macro 'unlikely'
     238 |         if (unlikely(__preempt_count_dec_and_test())) \
         |             ^~~~~~~~
   arch/arm64/include/asm/percpu.h:160:9: note: in expansion of macro 'preempt_enable_notrace'
     160 |         preempt_enable_notrace();                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/include/asm/percpu.h:197:9: note: in expansion of macro '_pcp_protect'
     197 |         _pcp_protect(__percpu_add_case_64, pcp, val)
         |         ^~~~~~~~~~~~
   include/linux/percpu-defs.h:372:25: note: in expansion of macro 'this_cpu_add_8'
     372 |                 case 8: stem##8(variable, __VA_ARGS__);break;           \
         |                         ^~~~
   include/linux/percpu-defs.h:501:41: note: in expansion of macro '__pcpu_size_call'
     501 | #define this_cpu_add(pcp, val)          __pcpu_size_call(this_cpu_add_, pcp, val)
         |                                         ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:511:41: note: in expansion of macro 'this_cpu_add'
     511 | #define this_cpu_inc(pcp)               this_cpu_add(pcp, 1)
         |                                         ^~~~~~~~~~~~
   kernel/trace/trace_branch.c:218:17: note: in expansion of macro 'this_cpu_inc'
     218 |                 this_cpu_inc(f->data.correct);
         |                 ^~~~~~~~~~~~
   include/linux/compiler.h:33:25: note: recursive call
      33 |                         ftrace_likely_update(&______f, ______r,         \
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      34 |                                              expect, is_constant);      \
         |                                              ~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:68:10: note: in definition of macro '__trace_if_value'
      68 |         (cond) ?                                        \
         |          ^~~~
   include/linux/compiler.h:55:28: note: in expansion of macro '__trace_if_var'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ^~~~~~~~~~~~~~
   include/linux/preempt.h:238:9: note: in expansion of macro 'if'
     238 |         if (unlikely(__preempt_count_dec_and_test())) \
         |         ^~
   include/linux/compiler.h:47:26: note: in expansion of macro '__branch_check__'
      47 | #  define unlikely(x)   (__branch_check__(x, 0, __builtin_constant_p(x)))
         |                          ^~~~~~~~~~~~~~~~
   include/linux/preempt.h:238:13: note: in expansion of macro 'unlikely'
     238 |         if (unlikely(__preempt_count_dec_and_test())) \
         |             ^~~~~~~~
   arch/arm64/include/asm/percpu.h:160:9: note: in expansion of macro 'preempt_enable_notrace'
     160 |         preempt_enable_notrace();                                       \
         |         ^~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/include/asm/percpu.h:197:9: note: in expansion of macro '_pcp_protect'
     197 |         _pcp_protect(__percpu_add_case_64, pcp, val)
         |         ^~~~~~~~~~~~
   include/linux/percpu-defs.h:372:25: note: in expansion of macro 'this_cpu_add_8'
     372 |                 case 8: stem##8(variable, __VA_ARGS__);break;           \
         |                         ^~~~
   include/linux/percpu-defs.h:501:41: note: in expansion of macro '__pcpu_size_call'
     501 | #define this_cpu_add(pcp, val)          __pcpu_size_call(this_cpu_add_, pcp, val)
         |                                         ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:511:41: note: in expansion of macro 'this_cpu_add'
     511 | #define this_cpu_inc(pcp)               this_cpu_add(pcp, 1)
         |                                         ^~~~~~~~~~~~
   kernel/trace/trace_branch.c:220:17: note: in expansion of macro 'this_cpu_inc'
     220 |                 this_cpu_inc(f->data.incorrect);
         |                 ^~~~~~~~~~~~


vim +198 kernel/trace/trace_branch.c

52f232cb720a7b kernel/trace/trace_unlikely.c Steven Rostedt          2008-11-12  197  
134e6a034cb004 kernel/trace/trace_branch.c   Steven Rostedt (VMware  2017-01-19 @198) void ftrace_likely_update(struct ftrace_likely_data *f, int val,
d45ae1f7041ac5 kernel/trace/trace_branch.c   Steven Rostedt (VMware  2017-01-17  199) 			  int expect, int is_constant)
1f0d69a9fc815d kernel/trace/trace_unlikely.c Steven Rostedt          2008-11-12  200  {
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
