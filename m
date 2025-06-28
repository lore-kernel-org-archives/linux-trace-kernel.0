Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDC6238C39;
	Sat, 28 Jun 2025 14:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751121634; cv=none; b=CDNTOcv/ihrzQ6GBRpTM1rRdsFeAlYdfx5ZY6m+0dv3snGoWq+Isy6brqFe0iJqUrFyBNlJSBqOLDZQqHmAQJIyB6Z/0JwRAq5LqwnHpdTQbpvuVfZcc0p6uFDrYnqs3ul0IrFCt633ses0WXhQGa2Fi0vDJhIjg9J1nTGdnpy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751121634; c=relaxed/simple;
	bh=4oS+7h1peoBPDGkDpNkDonVv+uRR2Pdzbr4KL3z4+Fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UDbAu+QFDt9/Tyo/56u4GmXxBjBzKqJ3lvTxk2ii9yEJ4RfGj6PQoNCI5+HSVifqT1GA/4howXzP+nbflEOAqM7VjvwPFUezduTii4X4aWhO+aIBQwfzaHP7DM0HS6TNlkrL7MHzeFhBYHy+ja5LU8qMYy/8iUPToiNyZYSdS/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ecf/jMD1; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ecf/jMD1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751121632; x=1782657632;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4oS+7h1peoBPDGkDpNkDonVv+uRR2Pdzbr4KL3z4+Fo=;
  b=ecf/jMD1mLUIBsux/6yxTHjtX/kIlArkdnyTnVOuxEOjUaY78AET9j4K
   ukvcjWJeSNxvK4mD/80wCu2bCFwR4dw1FYKyjoaj7LPsy8CAt0ROkIWoB
   VbhhsqrNiiED4XbSEu8jy72Mybj7IAt2wOxQH8lCCmT4d6AEOf7fYrjQ6
   W+/eDXCRGFp/CxKESPHyEZncX/W8rlQtSbX6aXAuaAYmCUshPvCgGLLYT
   hIErZRd92490UdaJ0vu0/HqSGIVaSF5Wd5VBZJoSueo19jb9fuFAM091H
   hvO4j5dOq6WRmeHdSyHdsyQskYGIIfFoEL8hBWV0XrEu0crRV2Vbhs43O
   w==;
X-CSE-ConnectionGUID: qp58W4ZvRkKJIbWRxWCiCA==
X-CSE-MsgGUID: JxmUKc8MT+qok950eXa3tA==
X-IronPort-AV: E=McAfee;i="6800,10657,11478"; a="57189733"
X-IronPort-AV: E=Sophos;i="6.16,273,1744095600"; 
   d="scan'208";a="57189733"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2025 07:40:31 -0700
X-CSE-ConnectionGUID: wtjJeq5vT46tOTz15Ufqrg==
X-CSE-MsgGUID: zStQ/Ns7REONv7l+P9v1lQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,273,1744095600"; 
   d="scan'208";a="176727412"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 28 Jun 2025 07:40:27 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uVWjA-000X7S-2x;
	Sat, 28 Jun 2025 14:40:24 +0000
Date: Sat, 28 Jun 2025 22:39:54 +0800
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
Cc: oe-kbuild-all@lists.linux.dev,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Clark Williams <williams@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>
Subject: Re: [PATCH 2/2] tracing/preemptirq: Optimize
 preempt_disable/enable() tracepoint overhead
Message-ID: <202506282232.13AjjGxr-lkp@intel.com>
References: <20250626142017.26372-3-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626142017.26372-3-wander@redhat.com>

Hi Wander,

kernel test robot noticed the following build warnings:

[auto build test WARNING on trace/for-next]
[also build test WARNING on tip/sched/core linus/master v6.16-rc3 next-20250627]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wander-Lairson-Costa/trace-preemptirq-reduce-overhead-of-irq_enable-disable-tracepoints/20250626-222438
base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
patch link:    https://lore.kernel.org/r/20250626142017.26372-3-wander%40redhat.com
patch subject: [PATCH 2/2] tracing/preemptirq: Optimize preempt_disable/enable() tracepoint overhead
config: sparc64-randconfig-001-20250628 (https://download.01.org/0day-ci/archive/20250628/202506282232.13AjjGxr-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250628/202506282232.13AjjGxr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506282232.13AjjGxr-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/asm-generic/cmpxchg-local.h:6,
                    from arch/sparc/include/asm/cmpxchg_64.h:111,
                    from arch/sparc/include/asm/cmpxchg.h:5,
                    from arch/sparc/include/asm/atomic_64.h:12,
                    from arch/sparc/include/asm/atomic.h:5,
                    from include/linux/atomic.h:7,
                    from include/linux/tracepoint-defs.h:11,
                    from include/linux/preempt.h:13,
                    from include/linux/spinlock.h:56,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/slab.h:16,
                    from kernel/resource.c:17:
   include/linux/irqflags.h:201:1: warning: data definition has no type or storage class
    DECLARE_TRACEPOINT(irq_enable);
    ^~~~~~~~~~~~~~~~~~
   include/linux/irqflags.h:201:1: error: type defaults to 'int' in declaration of 'DECLARE_TRACEPOINT' [-Werror=implicit-int]
>> include/linux/irqflags.h:201:1: warning: parameter names (without types) in function declaration
   include/linux/irqflags.h:202:1: warning: data definition has no type or storage class
    DECLARE_TRACEPOINT(irq_disable);
    ^~~~~~~~~~~~~~~~~~
   include/linux/irqflags.h:202:1: error: type defaults to 'int' in declaration of 'DECLARE_TRACEPOINT' [-Werror=implicit-int]
   include/linux/irqflags.h:202:1: warning: parameter names (without types) in function declaration
   In file included from include/linux/preempt.h:11,
                    from include/linux/spinlock.h:56,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/slab.h:16,
                    from kernel/resource.c:17:
   include/linux/irqflags.h: In function 'class_irq_destructor':
   include/linux/irqflags.h:206:7: error: implicit declaration of function 'tracepoint_enabled'; did you mean 'local_irq_enable'? [-Werror=implicit-function-declaration]
      if (tracepoint_enabled(irq_enable)) \
          ^~~~~~~~~~~~~~~~~~
   include/linux/cleanup.h:385:18: note: in definition of macro '__DEFINE_UNLOCK_GUARD'
     if (_T->lock) { _unlock; }     \
                     ^~~~~~~
   include/linux/irqflags.h:274:1: note: in expansion of macro 'DEFINE_LOCK_GUARD_0'
    DEFINE_LOCK_GUARD_0(irq, local_irq_disable(), local_irq_enable())
    ^~~~~~~~~~~~~~~~~~~
   include/linux/irqflags.h:274:47: note: in expansion of macro 'local_irq_enable'
    DEFINE_LOCK_GUARD_0(irq, local_irq_disable(), local_irq_enable())
                                                  ^~~~~~~~~~~~~~~~
   include/linux/irqflags.h:206:26: error: 'irq_enable' undeclared (first use in this function); did you mean 'irqs_disabled'?
      if (tracepoint_enabled(irq_enable)) \
                             ^~~~~~~~~~
   include/linux/cleanup.h:385:18: note: in definition of macro '__DEFINE_UNLOCK_GUARD'
     if (_T->lock) { _unlock; }     \
                     ^~~~~~~
   include/linux/irqflags.h:274:1: note: in expansion of macro 'DEFINE_LOCK_GUARD_0'
    DEFINE_LOCK_GUARD_0(irq, local_irq_disable(), local_irq_enable())
    ^~~~~~~~~~~~~~~~~~~
   include/linux/irqflags.h:274:47: note: in expansion of macro 'local_irq_enable'
    DEFINE_LOCK_GUARD_0(irq, local_irq_disable(), local_irq_enable())
                                                  ^~~~~~~~~~~~~~~~
   include/linux/irqflags.h:206:26: note: each undeclared identifier is reported only once for each function it appears in
      if (tracepoint_enabled(irq_enable)) \
                             ^~~~~~~~~~
   include/linux/cleanup.h:385:18: note: in definition of macro '__DEFINE_UNLOCK_GUARD'
     if (_T->lock) { _unlock; }     \
                     ^~~~~~~
   include/linux/irqflags.h:274:1: note: in expansion of macro 'DEFINE_LOCK_GUARD_0'
    DEFINE_LOCK_GUARD_0(irq, local_irq_disable(), local_irq_enable())
    ^~~~~~~~~~~~~~~~~~~
   include/linux/irqflags.h:274:47: note: in expansion of macro 'local_irq_enable'
    DEFINE_LOCK_GUARD_0(irq, local_irq_disable(), local_irq_enable())
                                                  ^~~~~~~~~~~~~~~~
   include/linux/irqflags.h: In function 'class_irq_constructor':
   include/linux/irqflags.h:215:26: error: 'irq_disable' undeclared (first use in this function); did you mean 'irqs_disabled'?
      if (tracepoint_enabled(irq_disable) && \
                             ^~~~~~~~~~~
   include/linux/cleanup.h:403:2: note: in definition of macro '__DEFINE_LOCK_GUARD_0'
     _lock;        \
     ^~~~~
   include/linux/irqflags.h:274:1: note: in expansion of macro 'DEFINE_LOCK_GUARD_0'
    DEFINE_LOCK_GUARD_0(irq, local_irq_disable(), local_irq_enable())
    ^~~~~~~~~~~~~~~~~~~
   include/linux/irqflags.h:274:26: note: in expansion of macro 'local_irq_disable'
    DEFINE_LOCK_GUARD_0(irq, local_irq_disable(), local_irq_enable())
                             ^~~~~~~~~~~~~~~~~
   include/linux/irqflags.h: In function 'class_irqsave_destructor':
   include/linux/irqflags.h:230:26: error: 'irq_enable' undeclared (first use in this function); did you mean 'irqs_disabled'?
      if (tracepoint_enabled(irq_enable) && \
                             ^~~~~~~~~~
   include/linux/cleanup.h:385:18: note: in definition of macro '__DEFINE_UNLOCK_GUARD'
     if (_T->lock) { _unlock; }     \
                     ^~~~~~~
   include/linux/irqflags.h:275:1: note: in expansion of macro 'DEFINE_LOCK_GUARD_0'
    DEFINE_LOCK_GUARD_0(irqsave,
    ^~~~~~~~~~~~~~~~~~~
   include/linux/irqflags.h:277:7: note: in expansion of macro 'local_irq_restore'
          local_irq_restore(_T->flags),
          ^~~~~~~~~~~~~~~~~
   include/linux/irqflags.h: In function 'class_irqsave_constructor':
   include/linux/irqflags.h:223:26: error: 'irq_disable' undeclared (first use in this function); did you mean 'irqs_disabled'?
      if (tracepoint_enabled(irq_disable) && \
                             ^~~~~~~~~~~
   include/linux/cleanup.h:403:2: note: in definition of macro '__DEFINE_LOCK_GUARD_0'
     _lock;        \
     ^~~~~
   include/linux/irqflags.h:275:1: note: in expansion of macro 'DEFINE_LOCK_GUARD_0'
    DEFINE_LOCK_GUARD_0(irqsave,
    ^~~~~~~~~~~~~~~~~~~
   include/linux/irqflags.h:276:7: note: in expansion of macro 'local_irq_save'
          local_irq_save(_T->flags),
          ^~~~~~~~~~~~~~
   In file included from include/linux/static_key.h:1,
                    from include/linux/tracepoint-defs.h:12,
                    from include/linux/preempt.h:13,
                    from include/linux/spinlock.h:56,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/slab.h:16,
                    from kernel/resource.c:17:
   include/linux/spinlock_api_smp.h: In function '__raw_spin_lock_irqsave':
   include/linux/tracepoint-defs.h:92:27: error: '__tracepoint_irq_disable' undeclared (first use in this function); did you mean 'raw_local_irq_disable'?
     static_branch_unlikely(&(__tracepoint_##tp).key)
                              ^~~~~~~~~~~~~
   include/linux/jump_label.h:503:43: note: in definition of macro 'static_branch_unlikely'
--
   In file included from include/asm-generic/cmpxchg-local.h:6,
                    from arch/sparc/include/asm/cmpxchg_64.h:111,
                    from arch/sparc/include/asm/cmpxchg.h:5,
                    from arch/sparc/include/asm/atomic_64.h:12,
                    from arch/sparc/include/asm/atomic.h:5,
                    from include/linux/atomic.h:7,
                    from include/linux/tracepoint-defs.h:11,
                    from include/linux/preempt.h:13,
                    from include/linux/spinlock.h:56,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/slab.h:16,
                    from kernel/fork.c:16:
   include/linux/irqflags.h:201:1: warning: data definition has no type or storage class
    DECLARE_TRACEPOINT(irq_enable);
    ^~~~~~~~~~~~~~~~~~
   include/linux/irqflags.h:201:1: error: type defaults to 'int' in declaration of 'DECLARE_TRACEPOINT' [-Werror=implicit-int]
>> include/linux/irqflags.h:201:1: warning: parameter names (without types) in function declaration
   include/linux/irqflags.h:202:1: warning: data definition has no type or storage class
    DECLARE_TRACEPOINT(irq_disable);
    ^~~~~~~~~~~~~~~~~~
   include/linux/irqflags.h:202:1: error: type defaults to 'int' in declaration of 'DECLARE_TRACEPOINT' [-Werror=implicit-int]
   include/linux/irqflags.h:202:1: warning: parameter names (without types) in function declaration
   In file included from include/linux/preempt.h:11,
                    from include/linux/spinlock.h:56,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/slab.h:16,
                    from kernel/fork.c:16:
   include/linux/irqflags.h: In function 'class_irq_destructor':
   include/linux/irqflags.h:206:7: error: implicit declaration of function 'tracepoint_enabled'; did you mean 'local_irq_enable'? [-Werror=implicit-function-declaration]
      if (tracepoint_enabled(irq_enable)) \
          ^~~~~~~~~~~~~~~~~~
   include/linux/cleanup.h:385:18: note: in definition of macro '__DEFINE_UNLOCK_GUARD'
     if (_T->lock) { _unlock; }     \
                     ^~~~~~~
   include/linux/irqflags.h:274:1: note: in expansion of macro 'DEFINE_LOCK_GUARD_0'
    DEFINE_LOCK_GUARD_0(irq, local_irq_disable(), local_irq_enable())
    ^~~~~~~~~~~~~~~~~~~
   include/linux/irqflags.h:274:47: note: in expansion of macro 'local_irq_enable'
    DEFINE_LOCK_GUARD_0(irq, local_irq_disable(), local_irq_enable())
                                                  ^~~~~~~~~~~~~~~~
   include/linux/irqflags.h:206:26: error: 'irq_enable' undeclared (first use in this function); did you mean 'irqs_disabled'?
      if (tracepoint_enabled(irq_enable)) \
                             ^~~~~~~~~~
   include/linux/cleanup.h:385:18: note: in definition of macro '__DEFINE_UNLOCK_GUARD'
     if (_T->lock) { _unlock; }     \
                     ^~~~~~~
   include/linux/irqflags.h:274:1: note: in expansion of macro 'DEFINE_LOCK_GUARD_0'
    DEFINE_LOCK_GUARD_0(irq, local_irq_disable(), local_irq_enable())
    ^~~~~~~~~~~~~~~~~~~
   include/linux/irqflags.h:274:47: note: in expansion of macro 'local_irq_enable'
    DEFINE_LOCK_GUARD_0(irq, local_irq_disable(), local_irq_enable())
                                                  ^~~~~~~~~~~~~~~~
   include/linux/irqflags.h:206:26: note: each undeclared identifier is reported only once for each function it appears in
      if (tracepoint_enabled(irq_enable)) \
                             ^~~~~~~~~~
   include/linux/cleanup.h:385:18: note: in definition of macro '__DEFINE_UNLOCK_GUARD'
     if (_T->lock) { _unlock; }     \
                     ^~~~~~~
   include/linux/irqflags.h:274:1: note: in expansion of macro 'DEFINE_LOCK_GUARD_0'
    DEFINE_LOCK_GUARD_0(irq, local_irq_disable(), local_irq_enable())
    ^~~~~~~~~~~~~~~~~~~
   include/linux/irqflags.h:274:47: note: in expansion of macro 'local_irq_enable'
    DEFINE_LOCK_GUARD_0(irq, local_irq_disable(), local_irq_enable())
                                                  ^~~~~~~~~~~~~~~~
   include/linux/irqflags.h: In function 'class_irq_constructor':
   include/linux/irqflags.h:215:26: error: 'irq_disable' undeclared (first use in this function); did you mean 'irqs_disabled'?
      if (tracepoint_enabled(irq_disable) && \
                             ^~~~~~~~~~~
   include/linux/cleanup.h:403:2: note: in definition of macro '__DEFINE_LOCK_GUARD_0'
     _lock;        \
     ^~~~~
   include/linux/irqflags.h:274:1: note: in expansion of macro 'DEFINE_LOCK_GUARD_0'
    DEFINE_LOCK_GUARD_0(irq, local_irq_disable(), local_irq_enable())
    ^~~~~~~~~~~~~~~~~~~
   include/linux/irqflags.h:274:26: note: in expansion of macro 'local_irq_disable'
    DEFINE_LOCK_GUARD_0(irq, local_irq_disable(), local_irq_enable())
                             ^~~~~~~~~~~~~~~~~
   include/linux/irqflags.h: In function 'class_irqsave_destructor':
   include/linux/irqflags.h:230:26: error: 'irq_enable' undeclared (first use in this function); did you mean 'irqs_disabled'?
      if (tracepoint_enabled(irq_enable) && \
                             ^~~~~~~~~~
   include/linux/cleanup.h:385:18: note: in definition of macro '__DEFINE_UNLOCK_GUARD'
     if (_T->lock) { _unlock; }     \
                     ^~~~~~~
   include/linux/irqflags.h:275:1: note: in expansion of macro 'DEFINE_LOCK_GUARD_0'
    DEFINE_LOCK_GUARD_0(irqsave,
    ^~~~~~~~~~~~~~~~~~~
   include/linux/irqflags.h:277:7: note: in expansion of macro 'local_irq_restore'
          local_irq_restore(_T->flags),
          ^~~~~~~~~~~~~~~~~
   include/linux/irqflags.h: In function 'class_irqsave_constructor':
   include/linux/irqflags.h:223:26: error: 'irq_disable' undeclared (first use in this function); did you mean 'irqs_disabled'?
      if (tracepoint_enabled(irq_disable) && \
                             ^~~~~~~~~~~
   include/linux/cleanup.h:403:2: note: in definition of macro '__DEFINE_LOCK_GUARD_0'
     _lock;        \
     ^~~~~
   include/linux/irqflags.h:275:1: note: in expansion of macro 'DEFINE_LOCK_GUARD_0'
    DEFINE_LOCK_GUARD_0(irqsave,
    ^~~~~~~~~~~~~~~~~~~
   include/linux/irqflags.h:276:7: note: in expansion of macro 'local_irq_save'
          local_irq_save(_T->flags),
          ^~~~~~~~~~~~~~
   In file included from include/linux/static_key.h:1,
                    from include/linux/tracepoint-defs.h:12,
                    from include/linux/preempt.h:13,
                    from include/linux/spinlock.h:56,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/slab.h:16,
                    from kernel/fork.c:16:
   include/linux/spinlock_api_smp.h: In function '__raw_spin_lock_irqsave':
   include/linux/tracepoint-defs.h:92:27: error: '__tracepoint_irq_disable' undeclared (first use in this function); did you mean 'raw_local_irq_disable'?
     static_branch_unlikely(&(__tracepoint_##tp).key)
                              ^~~~~~~~~~~~~
   include/linux/jump_label.h:503:43: note: in definition of macro 'static_branch_unlikely'
--
   In file included from include/asm-generic/cmpxchg-local.h:6,
                    from arch/sparc/include/asm/cmpxchg_64.h:111,
                    from arch/sparc/include/asm/cmpxchg.h:5,
                    from arch/sparc/include/asm/atomic_64.h:12,
                    from arch/sparc/include/asm/atomic.h:5,
                    from include/linux/atomic.h:7,
                    from include/linux/tracepoint-defs.h:11,
                    from include/linux/preempt.h:13,
                    from include/linux/alloc_tag.h:11,
                    from include/linux/rhashtable-types.h:12,
                    from include/linux/ipc.h:7,
                    from include/uapi/linux/sem.h:5,
                    from include/linux/sem.h:5,
                    from include/linux/compat.h:14,
                    from kernel/compat.c:12:
   include/linux/irqflags.h:201:1: warning: data definition has no type or storage class
    DECLARE_TRACEPOINT(irq_enable);
    ^~~~~~~~~~~~~~~~~~
   include/linux/irqflags.h:201:1: error: type defaults to 'int' in declaration of 'DECLARE_TRACEPOINT' [-Werror=implicit-int]
>> include/linux/irqflags.h:201:1: warning: parameter names (without types) in function declaration
   include/linux/irqflags.h:202:1: warning: data definition has no type or storage class
    DECLARE_TRACEPOINT(irq_disable);
    ^~~~~~~~~~~~~~~~~~
   include/linux/irqflags.h:202:1: error: type defaults to 'int' in declaration of 'DECLARE_TRACEPOINT' [-Werror=implicit-int]
   include/linux/irqflags.h:202:1: warning: parameter names (without types) in function declaration
   In file included from include/linux/jump_label.h:78,
                    from include/linux/dynamic_debug.h:6,
                    from include/linux/printk.h:616,
                    from include/asm-generic/bug.h:22,
                    from arch/sparc/include/asm/bug.h:25,
                    from include/linux/bug.h:5,
                    from include/linux/alloc_tag.h:8,
                    from include/linux/rhashtable-types.h:12,
                    from include/linux/ipc.h:7,
                    from include/uapi/linux/sem.h:5,
                    from include/linux/sem.h:5,
                    from include/linux/compat.h:14,
                    from kernel/compat.c:12:
   include/linux/irqflags.h: In function 'class_irq_destructor':
   include/linux/irqflags.h:206:7: error: implicit declaration of function 'tracepoint_enabled'; did you mean 'static_key_enabled'? [-Werror=implicit-function-declaration]
      if (tracepoint_enabled(irq_enable)) \
          ^~~~~~~~~~~~~~~~~~
   include/linux/cleanup.h:385:18: note: in definition of macro '__DEFINE_UNLOCK_GUARD'
     if (_T->lock) { _unlock; }     \
                     ^~~~~~~
   include/linux/irqflags.h:274:1: note: in expansion of macro 'DEFINE_LOCK_GUARD_0'
    DEFINE_LOCK_GUARD_0(irq, local_irq_disable(), local_irq_enable())
    ^~~~~~~~~~~~~~~~~~~
   include/linux/irqflags.h:274:47: note: in expansion of macro 'local_irq_enable'
    DEFINE_LOCK_GUARD_0(irq, local_irq_disable(), local_irq_enable())
                                                  ^~~~~~~~~~~~~~~~
   include/linux/irqflags.h:206:26: error: 'irq_enable' undeclared (first use in this function); did you mean 'ctl_table'?
      if (tracepoint_enabled(irq_enable)) \
                             ^~~~~~~~~~
   include/linux/cleanup.h:385:18: note: in definition of macro '__DEFINE_UNLOCK_GUARD'
     if (_T->lock) { _unlock; }     \
                     ^~~~~~~
   include/linux/irqflags.h:274:1: note: in expansion of macro 'DEFINE_LOCK_GUARD_0'
    DEFINE_LOCK_GUARD_0(irq, local_irq_disable(), local_irq_enable())
    ^~~~~~~~~~~~~~~~~~~
   include/linux/irqflags.h:274:47: note: in expansion of macro 'local_irq_enable'
    DEFINE_LOCK_GUARD_0(irq, local_irq_disable(), local_irq_enable())
                                                  ^~~~~~~~~~~~~~~~
   include/linux/irqflags.h:206:26: note: each undeclared identifier is reported only once for each function it appears in
      if (tracepoint_enabled(irq_enable)) \
                             ^~~~~~~~~~
   include/linux/cleanup.h:385:18: note: in definition of macro '__DEFINE_UNLOCK_GUARD'
     if (_T->lock) { _unlock; }     \
                     ^~~~~~~
   include/linux/irqflags.h:274:1: note: in expansion of macro 'DEFINE_LOCK_GUARD_0'
    DEFINE_LOCK_GUARD_0(irq, local_irq_disable(), local_irq_enable())
    ^~~~~~~~~~~~~~~~~~~
   include/linux/irqflags.h:274:47: note: in expansion of macro 'local_irq_enable'
    DEFINE_LOCK_GUARD_0(irq, local_irq_disable(), local_irq_enable())
                                                  ^~~~~~~~~~~~~~~~
   include/linux/irqflags.h: In function 'class_irq_constructor':
   include/linux/irqflags.h:215:26: error: 'irq_disable' undeclared (first use in this function); did you mean 'irqs_disabled'?
      if (tracepoint_enabled(irq_disable) && \
                             ^~~~~~~~~~~
   include/linux/cleanup.h:403:2: note: in definition of macro '__DEFINE_LOCK_GUARD_0'
     _lock;        \
     ^~~~~
   include/linux/irqflags.h:274:1: note: in expansion of macro 'DEFINE_LOCK_GUARD_0'
    DEFINE_LOCK_GUARD_0(irq, local_irq_disable(), local_irq_enable())
    ^~~~~~~~~~~~~~~~~~~
   include/linux/irqflags.h:274:26: note: in expansion of macro 'local_irq_disable'
    DEFINE_LOCK_GUARD_0(irq, local_irq_disable(), local_irq_enable())
                             ^~~~~~~~~~~~~~~~~
   include/linux/irqflags.h: In function 'class_irqsave_destructor':
   include/linux/irqflags.h:230:26: error: 'irq_enable' undeclared (first use in this function); did you mean 'ctl_table'?
      if (tracepoint_enabled(irq_enable) && \
                             ^~~~~~~~~~
   include/linux/cleanup.h:385:18: note: in definition of macro '__DEFINE_UNLOCK_GUARD'
     if (_T->lock) { _unlock; }     \
                     ^~~~~~~
   include/linux/irqflags.h:275:1: note: in expansion of macro 'DEFINE_LOCK_GUARD_0'
    DEFINE_LOCK_GUARD_0(irqsave,
    ^~~~~~~~~~~~~~~~~~~
   include/linux/irqflags.h:277:7: note: in expansion of macro 'local_irq_restore'
          local_irq_restore(_T->flags),
          ^~~~~~~~~~~~~~~~~
   include/linux/irqflags.h: In function 'class_irqsave_constructor':
   include/linux/irqflags.h:223:26: error: 'irq_disable' undeclared (first use in this function); did you mean 'irqs_disabled'?
      if (tracepoint_enabled(irq_disable) && \
                             ^~~~~~~~~~~
   include/linux/cleanup.h:403:2: note: in definition of macro '__DEFINE_LOCK_GUARD_0'
     _lock;        \
     ^~~~~
   include/linux/irqflags.h:275:1: note: in expansion of macro 'DEFINE_LOCK_GUARD_0'
    DEFINE_LOCK_GUARD_0(irqsave,
    ^~~~~~~~~~~~~~~~~~~
   include/linux/irqflags.h:276:7: note: in expansion of macro 'local_irq_save'
          local_irq_save(_T->flags),
          ^~~~~~~~~~~~~~
   In file included from include/linux/dynamic_debug.h:6,
                    from include/linux/printk.h:616,
                    from include/asm-generic/bug.h:22,
                    from arch/sparc/include/asm/bug.h:25,
                    from include/linux/bug.h:5,
                    from include/linux/alloc_tag.h:8,
..


vim +201 include/linux/irqflags.h

00b0ed2d4997af Peter Zijlstra       2020-08-12  200  
563d10fd41452f Wander Lairson Costa 2025-06-26 @201  DECLARE_TRACEPOINT(irq_enable);
563d10fd41452f Wander Lairson Costa 2025-06-26  202  DECLARE_TRACEPOINT(irq_disable);
563d10fd41452f Wander Lairson Costa 2025-06-26  203  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
