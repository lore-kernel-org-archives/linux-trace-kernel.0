Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDB627380B;
	Tue,  1 Jul 2025 12:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751373398; cv=none; b=mQFccRN1Lbg89tqmNBQKvY6wLs9B22DMajvvC0lMCpsIK7LceKBuY+WVBm8HicAcnavZ98daB8ALtqtPCVdnuKEAAJdsl9m6calPTp7LFBCoL2XXu1+Iu1CriwivrieviHT3EvQ/wRYX5E05y6eRzf8LB5IJZzu6KPtP9Hp59AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751373398; c=relaxed/simple;
	bh=Nd+PoXGJseXlQ84rElI6bHZVU9EObgcACAxSth1bZ4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=an2B9AHpUf8pvLQUYxsBcU4G0NxBUQ5kBV34iJiNg9fgSPA5WJJypyYNbVygQ+BiwGUVltBrQ/LbPQO1ZaeY2y7CkgK5OQFtBE9KcPT3QkHl0Nrx4YJp5yCkNBd+PdlB5G84R5SQsKgQKmNaYXhPOTcwHtcUFRBc4zv5XLQtaK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NOU+XryH; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NOU+XryH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751373395; x=1782909395;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Nd+PoXGJseXlQ84rElI6bHZVU9EObgcACAxSth1bZ4I=;
  b=NOU+XryHgfRiXikKWf6YwbWjVFL+6jpeqjvGCabJRVplc/xvPab2FXiq
   BnNciP8bAQMnA5y10jyldH4TgV+urJ5RRSdT76CK7f43RMLaXpJrxxHPs
   SyiKJkOVKtil1mhzM/PzgLsFzzByflko0QC/tDkDf8xO77/wG6KdEVG7Z
   yHwLcCSqYtu60q5q+uVrbZTcJZuI1EJTJP3Jjvb0EVa0Sa4L4KTVq8U6d
   rByMg8tMoXxHU+8yVHkbsdO2HZVUtXx3wsdYwqhvJD4dUh7UuhmIg7yml
   9Czr3NkybJmP6QiJQt7zM5zxD2GXjRVNPsYaHULjB8Q5GUglMaxhsmt4w
   w==;
X-CSE-ConnectionGUID: aHly9T+4QgGq8lB6sHRj1w==
X-CSE-MsgGUID: 2NPFQNeFTmuHATZaY7Y32w==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="56263523"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="56263523"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 05:36:34 -0700
X-CSE-ConnectionGUID: PQWY0j4GRtyp/OtvXgyDnA==
X-CSE-MsgGUID: /mYoMBFYRiarGfuQkVN/oA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="154254176"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 01 Jul 2025 05:36:29 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uWaDq-000a9G-2H;
	Tue, 01 Jul 2025 12:36:26 +0000
Date: Tue, 1 Jul 2025 20:36:08 +0800
From: kernel test robot <lkp@intel.com>
To: Wander Lairson Costa <wander@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Boqun Feng <boqun.feng@gmail.com>,
	David Woodhouse <dwmw@amazon.co.uk>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Clark Williams <williams@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>
Subject: Re: [PATCH v2 2/2] tracing/preemptirq: Optimize
 preempt_disable/enable() tracepoint overhead
Message-ID: <202507011942.sCSGnb2M-lkp@intel.com>
References: <20250630195243.701516-3-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630195243.701516-3-wander@redhat.com>

Hi Wander,

kernel test robot noticed the following build errors:

[auto build test ERROR on trace/for-next]
[also build test ERROR on tip/sched/core linus/master v6.16-rc4 next-20250701]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wander-Lairson-Costa/trace-preemptirq-reduce-overhead-of-irq_enable-disable-tracepoints/20250701-035446
base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
patch link:    https://lore.kernel.org/r/20250630195243.701516-3-wander%40redhat.com
patch subject: [PATCH v2 2/2] tracing/preemptirq: Optimize preempt_disable/enable() tracepoint overhead
config: powerpc-randconfig-003-20250701 (https://download.01.org/0day-ci/archive/20250701/202507011942.sCSGnb2M-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project e04c938cc08a90ae60440ce22d072ebc69d67ee8)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250701/202507011942.sCSGnb2M-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507011942.sCSGnb2M-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/powerpc/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:14:
   In file included from include/linux/sem.h:5:
   In file included from include/uapi/linux/sem.h:5:
   In file included from include/linux/ipc.h:7:
   In file included from include/linux/rhashtable-types.h:12:
   In file included from include/linux/alloc_tag.h:11:
   In file included from include/linux/preempt.h:13:
   In file included from include/linux/tracepoint-defs.h:11:
   In file included from include/linux/atomic.h:7:
   In file included from arch/powerpc/include/asm/atomic.h:11:
   In file included from arch/powerpc/include/asm/cmpxchg.h:755:
   In file included from include/asm-generic/cmpxchg-local.h:6:
   include/linux/irqflags.h:201:1: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
     201 | DECLARE_TRACEPOINT(irq_enable);
         | ^
         | int
   include/linux/irqflags.h:201:20: error: a parameter list without types is only allowed in a function definition
     201 | DECLARE_TRACEPOINT(irq_enable);
         |                    ^
   include/linux/irqflags.h:202:1: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
     202 | DECLARE_TRACEPOINT(irq_disable);
         | ^
         | int
   include/linux/irqflags.h:202:20: error: a parameter list without types is only allowed in a function definition
     202 | DECLARE_TRACEPOINT(irq_disable);
         |                    ^
   include/linux/irqflags.h:277:47: error: call to undeclared function 'tracepoint_enabled'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     277 | DEFINE_LOCK_GUARD_0(irq, local_irq_disable(), local_irq_enable())
         |                                               ^
   include/linux/irqflags.h:210:7: note: expanded from macro 'local_irq_enable'
     210 |                 if (__trace_enabled(irq_enable))        \
         |                     ^
   include/linux/irqflags.h:206:3: note: expanded from macro '__trace_enabled'
     206 |          tracepoint_enabled(tp))
         |          ^
   include/linux/irqflags.h:277:47: error: use of undeclared identifier 'irq_enable'
     277 | DEFINE_LOCK_GUARD_0(irq, local_irq_disable(), local_irq_enable())
         |                                               ^~~~~~~~~~~~~~~~~~
   include/linux/irqflags.h:210:23: note: expanded from macro 'local_irq_enable'
     210 |                 if (__trace_enabled(irq_enable))        \
         |                                     ^~~~~~~~~~
   include/linux/irqflags.h:277:26: error: call to undeclared function 'tracepoint_enabled'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     277 | DEFINE_LOCK_GUARD_0(irq, local_irq_disable(), local_irq_enable())
         |                          ^
   include/linux/irqflags.h:219:7: note: expanded from macro 'local_irq_disable'
     219 |                 if (__trace_enabled(irq_disable) &&     \
         |                     ^
   include/linux/irqflags.h:206:3: note: expanded from macro '__trace_enabled'
     206 |          tracepoint_enabled(tp))
         |          ^
   include/linux/irqflags.h:277:26: error: use of undeclared identifier 'irq_disable'
     277 | DEFINE_LOCK_GUARD_0(irq, local_irq_disable(), local_irq_enable())
         |                          ^~~~~~~~~~~~~~~~~~~
   include/linux/irqflags.h:219:23: note: expanded from macro 'local_irq_disable'
     219 |                 if (__trace_enabled(irq_disable) &&     \
         |                                     ^~~~~~~~~~~
   include/linux/irqflags.h:280:7: error: call to undeclared function 'tracepoint_enabled'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     280 |                     local_irq_restore(_T->flags),
         |                     ^
   include/linux/irqflags.h:234:7: note: expanded from macro 'local_irq_restore'
     234 |                 if (__trace_enabled(irq_enable) &&      \
         |                     ^
   include/linux/irqflags.h:206:3: note: expanded from macro '__trace_enabled'
     206 |          tracepoint_enabled(tp))
         |          ^
   include/linux/irqflags.h:280:7: error: use of undeclared identifier 'irq_enable'
     280 |                     local_irq_restore(_T->flags),
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/irqflags.h:234:23: note: expanded from macro 'local_irq_restore'
     234 |                 if (__trace_enabled(irq_enable) &&      \
         |                                     ^~~~~~~~~~
   include/linux/irqflags.h:279:7: error: call to undeclared function 'tracepoint_enabled'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     279 |                     local_irq_save(_T->flags),
         |                     ^
   include/linux/irqflags.h:227:7: note: expanded from macro 'local_irq_save'
     227 |                 if (__trace_enabled(irq_disable) &&     \
         |                     ^
   include/linux/irqflags.h:206:3: note: expanded from macro '__trace_enabled'
     206 |          tracepoint_enabled(tp))
         |          ^
   include/linux/irqflags.h:279:7: error: use of undeclared identifier 'irq_disable'
     279 |                     local_irq_save(_T->flags),
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/irqflags.h:227:23: note: expanded from macro 'local_irq_save'
     227 |                 if (__trace_enabled(irq_disable) &&     \
         |                                     ^~~~~~~~~~~
   In file included from arch/powerpc/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:15:
   In file included from include/linux/socket.h:8:
   In file included from include/linux/uio.h:9:
   In file included from include/linux/mm_types.h:8:
   In file included from include/linux/kref.h:16:
   In file included from include/linux/spinlock.h:312:
>> include/linux/spinlock_api_smp.h:151:2: error: use of undeclared identifier '__tracepoint_irq_enable'; did you mean '__tracepoint_preempt_enable'?
     151 |         local_irq_restore(flags);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/irqflags.h:234:7: note: expanded from macro 'local_irq_restore'
     234 |                 if (__trace_enabled(irq_enable) &&      \
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/irqflags.h:206:3: note: expanded from macro '__trace_enabled'
     206 |          tracepoint_enabled(tp))
         |          ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/tracepoint-defs.h:92:27: note: expanded from macro 'tracepoint_enabled'
      92 |         static_branch_unlikely(&(__tracepoint_##tp).key)
         |                                  ^~~~~~~~~~~~~~~~~
   <scratch space>:103:1: note: expanded from here
     103 | __tracepoint_irq_enable
         | ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/preempt.h:202:1: note: '__tracepoint_preempt_enable' declared here
     202 | DECLARE_TRACEPOINT(preempt_enable);
         | ^
   include/linux/tracepoint-defs.h:88:27: note: expanded from macro 'DECLARE_TRACEPOINT'
      88 |         extern struct tracepoint __tracepoint_##tp
         |                                  ^
   <scratch space>:104:1: note: expanded from here
     104 | __tracepoint_preempt_enable
         | ^
   In file included from arch/powerpc/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:15:
   In file included from include/linux/socket.h:8:
   In file included from include/linux/uio.h:9:
   In file included from include/linux/mm_types.h:8:
   In file included from include/linux/kref.h:16:
   In file included from include/linux/spinlock.h:312:
>> include/linux/spinlock_api_smp.h:151:2: error: use of undeclared identifier '__tracepoint_irq_enable'; did you mean '__tracepoint_preempt_enable'?
     151 |         local_irq_restore(flags);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/irqflags.h:234:7: note: expanded from macro 'local_irq_restore'
     234 |                 if (__trace_enabled(irq_enable) &&      \
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/irqflags.h:206:3: note: expanded from macro '__trace_enabled'
     206 |          tracepoint_enabled(tp))
         |          ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/tracepoint-defs.h:92:27: note: expanded from macro 'tracepoint_enabled'
      92 |         static_branch_unlikely(&(__tracepoint_##tp).key)
         |                                  ^~~~~~~~~~~~~~~~~
   <scratch space>:103:1: note: expanded from here
     103 | __tracepoint_irq_enable
         | ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/preempt.h:202:1: note: '__tracepoint_preempt_enable' declared here
     202 | DECLARE_TRACEPOINT(preempt_enable);
         | ^
   include/linux/tracepoint-defs.h:88:27: note: expanded from macro 'DECLARE_TRACEPOINT'
      88 |         extern struct tracepoint __tracepoint_##tp
         |                                  ^
   <scratch space>:104:1: note: expanded from here
     104 | __tracepoint_preempt_enable
         | ^
   In file included from arch/powerpc/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:15:
   In file included from include/linux/socket.h:8:
   In file included from include/linux/uio.h:9:
   In file included from include/linux/mm_types.h:8:
   In file included from include/linux/kref.h:16:
   In file included from include/linux/spinlock.h:312:
>> include/linux/spinlock_api_smp.h:151:2: error: use of undeclared identifier '__tracepoint_irq_enable'; did you mean '__tracepoint_preempt_enable'?
     151 |         local_irq_restore(flags);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/irqflags.h:234:7: note: expanded from macro 'local_irq_restore'
     234 |                 if (__trace_enabled(irq_enable) &&      \
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/irqflags.h:206:3: note: expanded from macro '__trace_enabled'
     206 |          tracepoint_enabled(tp))
         |          ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/tracepoint-defs.h:92:27: note: expanded from macro 'tracepoint_enabled'
      92 |         static_branch_unlikely(&(__tracepoint_##tp).key)
         |                                  ^~~~~~~~~~~~~~~~~
   <scratch space>:103:1: note: expanded from here
     103 | __tracepoint_irq_enable
         | ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/preempt.h:202:1: note: '__tracepoint_preempt_enable' declared here
     202 | DECLARE_TRACEPOINT(preempt_enable);
         | ^
   include/linux/tracepoint-defs.h:88:27: note: expanded from macro 'DECLARE_TRACEPOINT'
      88 |         extern struct tracepoint __tracepoint_##tp
         |                                  ^
   <scratch space>:104:1: note: expanded from here
     104 | __tracepoint_preempt_enable
         | ^
   In file included from arch/powerpc/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:15:
   In file included from include/linux/socket.h:8:
   In file included from include/linux/uio.h:9:
   In file included from include/linux/mm_types.h:8:
   In file included from include/linux/kref.h:16:
   In file included from include/linux/spinlock.h:312:
>> include/linux/spinlock_api_smp.h:151:2: error: use of undeclared identifier '__tracepoint_irq_enable'; did you mean '__tracepoint_preempt_enable'?
     151 |         local_irq_restore(flags);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/irqflags.h:234:7: note: expanded from macro 'local_irq_restore'
     234 |                 if (__trace_enabled(irq_enable) &&      \
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/irqflags.h:206:3: note: expanded from macro '__trace_enabled'
     206 |          tracepoint_enabled(tp))
         |          ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/tracepoint-defs.h:92:27: note: expanded from macro 'tracepoint_enabled'
      92 |         static_branch_unlikely(&(__tracepoint_##tp).key)
         |                                  ^~~~~~~~~~~~~~~~~
   <scratch space>:103:1: note: expanded from here
     103 | __tracepoint_irq_enable
         | ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/preempt.h:202:1: note: '__tracepoint_preempt_enable' declared here
     202 | DECLARE_TRACEPOINT(preempt_enable);
         | ^
   include/linux/tracepoint-defs.h:88:27: note: expanded from macro 'DECLARE_TRACEPOINT'
      88 |         extern struct tracepoint __tracepoint_##tp
         |                                  ^
   <scratch space>:104:1: note: expanded from here
     104 | __tracepoint_preempt_enable
         | ^
   In file included from arch/powerpc/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:15:
   In file included from include/linux/socket.h:8:
   In file included from include/linux/uio.h:9:
   In file included from include/linux/mm_types.h:8:
   In file included from include/linux/kref.h:16:
   In file included from include/linux/spinlock.h:312:
   include/linux/spinlock_api_smp.h:159:2: error: use of undeclared identifier '__tracepoint_irq_enable'; did you mean '__tracepoint_preempt_enable'?
     159 |         local_irq_enable();
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/irqflags.h:210:7: note: expanded from macro 'local_irq_enable'
     210 |                 if (__trace_enabled(irq_enable))        \
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/irqflags.h:206:3: note: expanded from macro '__trace_enabled'
     206 |          tracepoint_enabled(tp))
         |          ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/tracepoint-defs.h:92:27: note: expanded from macro 'tracepoint_enabled'
      92 |         static_branch_unlikely(&(__tracepoint_##tp).key)
         |                                  ^~~~~~~~~~~~~~~~~
   <scratch space>:108:1: note: expanded from here
     108 | __tracepoint_irq_enable
         | ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/preempt.h:202:1: note: '__tracepoint_preempt_enable' declared here
     202 | DECLARE_TRACEPOINT(preempt_enable);
         | ^
   include/linux/tracepoint-defs.h:88:27: note: expanded from macro 'DECLARE_TRACEPOINT'
      88 |         extern struct tracepoint __tracepoint_##tp
         |                                  ^
   <scratch space>:104:1: note: expanded from here
     104 | __tracepoint_preempt_enable
         | ^
   In file included from arch/powerpc/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:15:
   In file included from include/linux/socket.h:8:
   In file included from include/linux/uio.h:9:
   In file included from include/linux/mm_types.h:8:
   In file included from include/linux/kref.h:16:
   In file included from include/linux/spinlock.h:312:
   include/linux/spinlock_api_smp.h:159:2: error: use of undeclared identifier '__tracepoint_irq_enable'; did you mean '__tracepoint_preempt_enable'?
     159 |         local_irq_enable();
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/irqflags.h:210:7: note: expanded from macro 'local_irq_enable'
     210 |                 if (__trace_enabled(irq_enable))        \
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/irqflags.h:206:3: note: expanded from macro '__trace_enabled'
     206 |          tracepoint_enabled(tp))
         |          ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/tracepoint-defs.h:92:27: note: expanded from macro 'tracepoint_enabled'
      92 |         static_branch_unlikely(&(__tracepoint_##tp).key)
         |                                  ^~~~~~~~~~~~~~~~~
   <scratch space>:108:1: note: expanded from here
     108 | __tracepoint_irq_enable
         | ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/preempt.h:202:1: note: '__tracepoint_preempt_enable' declared here
     202 | DECLARE_TRACEPOINT(preempt_enable);
         | ^
   include/linux/tracepoint-defs.h:88:27: note: expanded from macro 'DECLARE_TRACEPOINT'
      88 |         extern struct tracepoint __tracepoint_##tp
         |                                  ^
   <scratch space>:104:1: note: expanded from here
     104 | __tracepoint_preempt_enable
         | ^
   In file included from arch/powerpc/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:15:
   In file included from include/linux/socket.h:8:
   In file included from include/linux/uio.h:9:
   In file included from include/linux/mm_types.h:8:
   In file included from include/linux/kref.h:16:
   In file included from include/linux/spinlock.h:312:
   include/linux/spinlock_api_smp.h:159:2: error: use of undeclared identifier '__tracepoint_irq_enable'; did you mean '__tracepoint_preempt_enable'?
     159 |         local_irq_enable();
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/irqflags.h:210:7: note: expanded from macro 'local_irq_enable'
     210 |                 if (__trace_enabled(irq_enable))        \
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/irqflags.h:206:3: note: expanded from macro '__trace_enabled'
     206 |          tracepoint_enabled(tp))


vim +151 include/linux/spinlock_api_smp.h

69d0ee7377eef80 Heiko Carstens  2009-08-31  145  
9c1721aa4994f66 Thomas Gleixner 2009-12-03  146  static inline void __raw_spin_unlock_irqrestore(raw_spinlock_t *lock,
69d0ee7377eef80 Heiko Carstens  2009-08-31  147  					    unsigned long flags)
69d0ee7377eef80 Heiko Carstens  2009-08-31  148  {
5facae4f3549b5c Qian Cai        2019-09-19  149  	spin_release(&lock->dep_map, _RET_IP_);
9828ea9d75c38fe Thomas Gleixner 2009-12-03  150  	do_raw_spin_unlock(lock);
69d0ee7377eef80 Heiko Carstens  2009-08-31 @151  	local_irq_restore(flags);
69d0ee7377eef80 Heiko Carstens  2009-08-31  152  	preempt_enable();
69d0ee7377eef80 Heiko Carstens  2009-08-31  153  }
69d0ee7377eef80 Heiko Carstens  2009-08-31  154  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
