Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E69EFC08;
	Thu, 13 Mar 2025 15:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741878949; cv=none; b=YWKxJ+csezdzhtU+SeDmke/c71S+2ZKMgN0TvwOnZK3UXFMD1S1FAoqmZdm0Vtwzgn7dnGEbyPwS40wF70WkR9urQQEl9Xs3ZNaL+eMozGz5tx8jf/oD3s2ukmL5AbLdMHv0pN6xLZcZ4oSdrsQbcoV7YbetqBgHvoNdLqaRhfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741878949; c=relaxed/simple;
	bh=DxYmwRKpDd0tnQCFVByN7y7sngics+dT8oStdDQf0DI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t4Q8KjVcNrakZjFA2FwLaEp2L0yup8h54lm4iuR4SBjAEsAdzm74bbKfuscUNFF/C1FWYWLP1K9Ve2ZNVujZyjnOF5ay4EWtdKHcIOqqC+sx3rH9M0RqDFOoRjY7YWCrmq4cg5DVDENHmNsFXv7l4IVByyGcilPXKQ0nhhHE1dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bz0tk6r4; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bz0tk6r4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741878947; x=1773414947;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DxYmwRKpDd0tnQCFVByN7y7sngics+dT8oStdDQf0DI=;
  b=Bz0tk6r4Vd//cRCV6rlE3NlMcWj9pT6sZEmjyIdfKvw/XYYxCbEyv+yP
   x29BKbjxfnq1qFiQ14mGhgkxEpgTMglDstXzaqxNn3UawFPzyI+X5iP0y
   bG6ls/UuWGl9r5Eriy2wKRZovnLSvNTI16bYNrbDkBeL6Wjo2IPoDrHwP
   wW/1Ve4JA/+1TCl4gDdd1sZQA+Yv7EIWOT48MptZR9dn0Lt3YiI5xcgfR
   W65v7lx2n7SEkmbF3e1w9AWXkyhXBac/3HWYUuxxTc6IqVnDxznMGS8eN
   9otg7C0gdufuQtn/xJnuhl7F93cVtZT7UndWFe+2NDD8akjGOnqgseQ2G
   Q==;
X-CSE-ConnectionGUID: 93Zn59xqTei1ZB6Ya8FNsw==
X-CSE-MsgGUID: OoaCOZ+OTc6UlMkZQMgMiQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="46904145"
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="46904145"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 08:15:46 -0700
X-CSE-ConnectionGUID: sj4BoNyoQW6FajNRPC0JWw==
X-CSE-MsgGUID: i4AIluP9SHGwIipTSk7DSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="121491205"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 13 Mar 2025 08:15:42 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tskHc-0009Yy-1K;
	Thu, 13 Mar 2025 15:15:40 +0000
Date: Thu, 13 Mar 2025 23:15:31 +0800
From: kernel test robot <lkp@intel.com>
To: Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>, john.ogness@linutronix.de,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Nam Cao <namcao@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 04/10] rv: Add rtapp_block monitor
Message-ID: <202503132244.Azu340js-lkp@intel.com>
References: <c8a1658c6da343b6055cbfcd6ee5ddea48335d31.1741708239.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8a1658c6da343b6055cbfcd6ee5ddea48335d31.1741708239.git.namcao@linutronix.de>

Hi Nam,

kernel test robot noticed the following build warnings:

[auto build test WARNING on trace/for-next]
[also build test WARNING on tip/x86/core tip/x86/mm linus/master v6.14-rc6 next-20250313]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nam-Cao/rv-Add-undef-TRACE_INCLUDE_FILE/20250312-011043
base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
patch link:    https://lore.kernel.org/r/c8a1658c6da343b6055cbfcd6ee5ddea48335d31.1741708239.git.namcao%40linutronix.de
patch subject: [PATCH 04/10] rv: Add rtapp_block monitor
config: hexagon-allyesconfig (https://download.01.org/0day-ci/archive/20250313/202503132244.Azu340js-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250313/202503132244.Azu340js-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503132244.Azu340js-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/trace/rv/monitors/rtapp_block/rtapp_block.c:91:53: warning: omitting the parameter name in a function definition is a C23 extension [-Wc23-extensions]
      91 | static void handle_rt_mutex_wake_waiter_begin(void *, struct task_struct *task)
         |                                                     ^
   kernel/trace/rv/monitors/rtapp_block/rtapp_block.c:96:51: warning: omitting the parameter name in a function definition is a C23 extension [-Wc23-extensions]
      96 | static void handle_rt_mutex_wake_waiter_end(void *, struct task_struct *task)
         |                                                   ^
   kernel/trace/rv/monitors/rtapp_block/rtapp_block.c:101:45: warning: omitting the parameter name in a function definition is a C23 extension [-Wc23-extensions]
     101 | static void handle_sched_kthread_stop(void *, struct task_struct *task)
         |                                             ^
   kernel/trace/rv/monitors/rtapp_block/rtapp_block.c:109:49: warning: omitting the parameter name in a function definition is a C23 extension [-Wc23-extensions]
     109 | static void handle_sched_kthread_stop_ret(void *, int)
         |                                                 ^
   kernel/trace/rv/monitors/rtapp_block/rtapp_block.c:109:54: warning: omitting the parameter name in a function definition is a C23 extension [-Wc23-extensions]
     109 | static void handle_sched_kthread_stop_ret(void *, int)
         |                                                      ^
   kernel/trace/rv/monitors/rtapp_block/rtapp_block.c:117:39: warning: omitting the parameter name in a function definition is a C23 extension [-Wc23-extensions]
     117 | static void handle_sched_wakeup(void *, struct task_struct *task)
         |                                       ^
   kernel/trace/rv/monitors/rtapp_block/rtapp_block.c:164:2: error: call to undeclared function 'check_trace_callback_type_sys_enter'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     164 |         rv_attach_trace_probe("rtapp_block", sys_enter, handle_sys_enter);
         |         ^
   include/rv/instrumentation.h:18:3: note: expanded from macro 'rv_attach_trace_probe'
      18 |                 check_trace_callback_type_##tp(rv_handler);                             \
         |                 ^
   <scratch space>:8:1: note: expanded from here
       8 | check_trace_callback_type_sys_enter
         | ^
   kernel/trace/rv/monitors/rtapp_block/rtapp_block.c:164:2: error: call to undeclared function 'register_trace_sys_enter'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
   include/rv/instrumentation.h:19:13: note: expanded from macro 'rv_attach_trace_probe'
      19 |                 WARN_ONCE(register_trace_##tp(rv_handler, NULL),                        \
         |                           ^
   <scratch space>:9:1: note: expanded from here
       9 | register_trace_sys_enter
         | ^
   kernel/trace/rv/monitors/rtapp_block/rtapp_block.c:165:2: error: call to undeclared function 'check_trace_callback_type_sys_exit'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     165 |         rv_attach_trace_probe("rtapp_block", sys_exit, handle_sys_exit);
         |         ^
   include/rv/instrumentation.h:18:3: note: expanded from macro 'rv_attach_trace_probe'
      18 |                 check_trace_callback_type_##tp(rv_handler);                             \
         |                 ^
   <scratch space>:14:1: note: expanded from here
      14 | check_trace_callback_type_sys_exit
         | ^
   kernel/trace/rv/monitors/rtapp_block/rtapp_block.c:165:2: error: call to undeclared function 'register_trace_sys_exit'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
   include/rv/instrumentation.h:19:13: note: expanded from macro 'rv_attach_trace_probe'
      19 |                 WARN_ONCE(register_trace_##tp(rv_handler, NULL),                        \
         |                           ^
   <scratch space>:15:1: note: expanded from here
      15 | register_trace_sys_exit
         | ^
   kernel/trace/rv/monitors/rtapp_block/rtapp_block.c:165:2: note: did you mean 'register_ftrace_direct'?
   include/rv/instrumentation.h:19:13: note: expanded from macro 'rv_attach_trace_probe'
      19 |                 WARN_ONCE(register_trace_##tp(rv_handler, NULL),                        \
         |                           ^
   <scratch space>:15:1: note: expanded from here
      15 | register_trace_sys_exit
         | ^
   include/linux/ftrace.h:535:19: note: 'register_ftrace_direct' declared here
     535 | static inline int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
         |                   ^
   kernel/trace/rv/monitors/rtapp_block/rtapp_block.c:180:2: error: call to undeclared function 'unregister_trace_sys_enter'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     180 |         rv_detach_trace_probe("rtapp_block", sys_enter, handle_sys_enter);
         |         ^
   include/rv/instrumentation.h:28:3: note: expanded from macro 'rv_detach_trace_probe'
      28 |                 unregister_trace_##tp(rv_handler, NULL);                                \
         |                 ^
   <scratch space>:29:1: note: expanded from here
      29 | unregister_trace_sys_enter
         | ^
   kernel/trace/rv/monitors/rtapp_block/rtapp_block.c:181:2: error: call to undeclared function 'unregister_trace_sys_exit'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     181 |         rv_detach_trace_probe("rtapp_block", sys_exit, handle_sys_exit);
         |         ^
   include/rv/instrumentation.h:28:3: note: expanded from macro 'rv_detach_trace_probe'
      28 |                 unregister_trace_##tp(rv_handler, NULL);                                \
         |                 ^
   <scratch space>:30:1: note: expanded from here
      30 | unregister_trace_sys_exit
         | ^
   kernel/trace/rv/monitors/rtapp_block/rtapp_block.c:181:2: note: did you mean 'unregister_ftrace_direct'?
   include/rv/instrumentation.h:28:3: note: expanded from macro 'rv_detach_trace_probe'
      28 |                 unregister_trace_##tp(rv_handler, NULL);                                \
         |                 ^
   <scratch space>:30:1: note: expanded from here
      30 | unregister_trace_sys_exit
         | ^
   include/linux/ftrace.h:539:19: note: 'unregister_ftrace_direct' declared here
     539 | static inline int unregister_ftrace_direct(struct ftrace_ops *ops, unsigned long addr,
         |                   ^
   6 warnings and 6 errors generated.


vim +91 kernel/trace/rv/monitors/rtapp_block/rtapp_block.c

    90	
  > 91	static void handle_rt_mutex_wake_waiter_begin(void *, struct task_struct *task)
    92	{
    93		rv_rtapp_block_atom_update(task, RT_MUTEX_WAKING_WAITER, true);
    94	}
    95	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
