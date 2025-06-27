Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA52D280CCA;
	Fri, 27 Jun 2025 22:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751062257; cv=none; b=UqgBVuNnOVeP3tLTvU0bTTd3Au+cDjUJ0FxhGqVRW37d6OJY3sZdPjtnuOP00RKFScX+m2XoC9Z8y7Q/9zTlTyPlqveyRpXos+NxRKo4YuIQT/q0q/7ke5OfrETwQBB4FxBplOLdumynmSewMV6UHD7lwJDekKR39jjoZ92CNAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751062257; c=relaxed/simple;
	bh=9j2iOLGaZr8Hoi6wuymqoKRDc6hjkyChb8a2vuTyhTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SEG9gsYZHRPgIk40sfMimo7FVu2FClj6KYuFa+mEXTLtZ0HvZrTPX51iatPT5/xGBz0PLQHx1gCwACUxsHq5UD6VZjz86zZq98VptunzlWfIVzgjHK/Xeaog456ERPkvHCCGIZBNobCwZ5I2kd4dOx9wEgvhuYDi3HT5GiuzlnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bgD8ziro; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bgD8ziro"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751062256; x=1782598256;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9j2iOLGaZr8Hoi6wuymqoKRDc6hjkyChb8a2vuTyhTg=;
  b=bgD8zirorX6NJvAgrXi/VBDPIQYoM0T9VxB/JlQE5+oD3+D+Cnf99a9Y
   o7o1luXW4tb368Oqi/Qf6EdJcj3qb1EIYbnZX6f14/xoxaSoNJc1qYkLw
   SYSSnQ3FslMHulEq0L7h0nnjDhIOp8h4gf+D8bsGi6Spm0y+6opLWJmTa
   k0fVa6genGM0q6zrfZxDMgzR3JUJChRxqr3XN6l7iC/abUGtCaTqEsWzS
   7wbhPBFLcAwEFBMLw98MZvJux1sUR/D2z2xI2K4HJ75v/Rad4EJj3ehmd
   D2td1E7Do9Mk/QIzvEXt1X0U0GWiAhq7SILFQBdnt+KnKL0qmDEUn3aQ8
   A==;
X-CSE-ConnectionGUID: AQEUjDjwTkaJy7BTxk04/g==
X-CSE-MsgGUID: MEbtCTRbTMqSSlbnsKpOSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11477"; a="53244778"
X-IronPort-AV: E=Sophos;i="6.16,271,1744095600"; 
   d="scan'208";a="53244778"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 15:10:55 -0700
X-CSE-ConnectionGUID: JC7UNC/gQXOKOcxqBF/bog==
X-CSE-MsgGUID: cLdzcmXLTR69N+M0okxK+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,271,1744095600"; 
   d="scan'208";a="153399779"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 27 Jun 2025 15:10:51 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uVHHU-000WaA-0H;
	Fri, 27 Jun 2025 22:10:48 +0000
Date: Sat, 28 Jun 2025 06:10:00 +0800
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
	Boqun Feng <boqun.feng@gmail.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Clark Williams <williams@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>
Subject: Re: [PATCH 1/2] trace/preemptirq: reduce overhead of
 irq_enable/disable tracepoints
Message-ID: <202506280530.WX885a04-lkp@intel.com>
References: <20250626142017.26372-2-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626142017.26372-2-wander@redhat.com>

Hi Wander,

kernel test robot noticed the following build errors:

[auto build test ERROR on trace/for-next]
[also build test ERROR on tip/sched/core linus/master v6.16-rc3 next-20250627]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wander-Lairson-Costa/trace-preemptirq-reduce-overhead-of-irq_enable-disable-tracepoints/20250626-222438
base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
patch link:    https://lore.kernel.org/r/20250626142017.26372-2-wander%40redhat.com
patch subject: [PATCH 1/2] trace/preemptirq: reduce overhead of irq_enable/disable tracepoints
config: parisc-randconfig-001-20250628 (https://download.01.org/0day-ci/archive/20250628/202506280530.WX885a04-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250628/202506280530.WX885a04-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506280530.WX885a04-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

                    from include/linux/page-flags.h:10,
                    from kernel/bounds.c:10:
   include/linux/jump_label.h:299:19: error: implicit declaration of function 'atomic_try_cmpxchg'; did you mean 'raw_cpu_try_cmpxchg'? [-Werror=implicit-function-declaration]
     } while (!likely(atomic_try_cmpxchg(&key->enabled, &v, v + 1)));
                      ^~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:76:40: note: in definition of macro 'likely'
    # define likely(x) __builtin_expect(!!(x), 1)
                                           ^
   In file included from include/linux/static_key.h:1,
                    from include/linux/tracepoint-defs.h:12,
                    from include/linux/irqflags.h:20,
                    from include/asm-generic/cmpxchg-local.h:6,
                    from arch/parisc/include/asm/cmpxchg.h:87,
                    from arch/parisc/include/asm/atomic.h:10,
                    from include/linux/atomic.h:7,
                    from arch/parisc/include/asm/bitops.h:13,
                    from include/linux/bitops.h:68,
                    from include/linux/kernel.h:23,
                    from arch/parisc/include/asm/bug.h:5,
                    from include/linux/bug.h:5,
                    from include/linux/page-flags.h:10,
                    from kernel/bounds.c:10:
   include/linux/jump_label.h: In function 'static_key_slow_dec':
   include/linux/jump_label.h:307:2: error: implicit declaration of function 'atomic_dec' [-Werror=implicit-function-declaration]
     atomic_dec(&key->enabled);
     ^~~~~~~~~~
   include/linux/jump_label.h: In function 'static_key_enable':
   include/linux/jump_label.h:326:3: error: implicit declaration of function 'WARN_ON_ONCE'; did you mean 'WRITE_ONCE'? [-Werror=implicit-function-declaration]
      WARN_ON_ONCE(atomic_read(&key->enabled) != 1);
      ^~~~~~~~~~~~
      WRITE_ONCE
   include/linux/jump_label.h:329:2: error: implicit declaration of function 'atomic_set'; did you mean 'static_assert'? [-Werror=implicit-function-declaration]
     atomic_set(&key->enabled, 1);
     ^~~~~~~~~~
     static_assert
   In file included from include/linux/atomic.h:80,
                    from arch/parisc/include/asm/bitops.h:13,
                    from include/linux/bitops.h:68,
                    from include/linux/kernel.h:23,
                    from arch/parisc/include/asm/bug.h:5,
                    from include/linux/bug.h:5,
                    from include/linux/page-flags.h:10,
                    from kernel/bounds.c:10:
   include/linux/atomic/atomic-arch-fallback.h: At top level:
   include/linux/atomic/atomic-arch-fallback.h:455:1: error: static declaration of 'raw_atomic_read' follows non-static declaration
    raw_atomic_read(const atomic_t *v)
    ^~~~~~~~~~~~~~~
   In file included from include/linux/static_key.h:1,
                    from include/linux/tracepoint-defs.h:12,
                    from include/linux/irqflags.h:20,
                    from include/asm-generic/cmpxchg-local.h:6,
                    from arch/parisc/include/asm/cmpxchg.h:87,
                    from arch/parisc/include/asm/atomic.h:10,
                    from include/linux/atomic.h:7,
                    from arch/parisc/include/asm/bitops.h:13,
                    from include/linux/bitops.h:68,
                    from include/linux/kernel.h:23,
                    from arch/parisc/include/asm/bug.h:5,
                    from include/linux/bug.h:5,
                    from include/linux/page-flags.h:10,
                    from kernel/bounds.c:10:
   include/linux/jump_label.h:262:9: note: previous implicit declaration of 'raw_atomic_read' was here
     return raw_atomic_read(&key->enabled);
            ^~~~~~~~~~~~~~~
   In file included from include/linux/atomic.h:82,
                    from arch/parisc/include/asm/bitops.h:13,
                    from include/linux/bitops.h:68,
                    from include/linux/kernel.h:23,
                    from arch/parisc/include/asm/bug.h:5,
                    from include/linux/bug.h:5,
                    from include/linux/page-flags.h:10,
                    from kernel/bounds.c:10:
   include/linux/atomic/atomic-instrumented.h:30:1: error: static declaration of 'atomic_read' follows non-static declaration
    atomic_read(const atomic_t *v)
    ^~~~~~~~~~~
   In file included from include/linux/static_key.h:1,
                    from include/linux/tracepoint-defs.h:12,
                    from include/linux/irqflags.h:20,
                    from include/asm-generic/cmpxchg-local.h:6,
                    from arch/parisc/include/asm/cmpxchg.h:87,
                    from arch/parisc/include/asm/atomic.h:10,
                    from include/linux/atomic.h:7,
                    from arch/parisc/include/asm/bitops.h:13,
                    from include/linux/bitops.h:68,
                    from include/linux/kernel.h:23,
                    from arch/parisc/include/asm/bug.h:5,
                    from include/linux/bug.h:5,
                    from include/linux/page-flags.h:10,
                    from kernel/bounds.c:10:
   include/linux/jump_label.h:295:6: note: previous implicit declaration of 'atomic_read' was here
     v = atomic_read(&key->enabled);
         ^~~~~~~~~~~
   In file included from include/linux/atomic.h:82,
                    from arch/parisc/include/asm/bitops.h:13,
                    from include/linux/bitops.h:68,
                    from include/linux/kernel.h:23,
                    from arch/parisc/include/asm/bug.h:5,
                    from include/linux/bug.h:5,
                    from include/linux/page-flags.h:10,
                    from kernel/bounds.c:10:
>> include/linux/atomic/atomic-instrumented.h:65:1: warning: conflicting types for 'atomic_set'
    atomic_set(atomic_t *v, int i)
    ^~~~~~~~~~
   include/linux/atomic/atomic-instrumented.h:65:1: error: static declaration of 'atomic_set' follows non-static declaration
   In file included from include/linux/static_key.h:1,
                    from include/linux/tracepoint-defs.h:12,
                    from include/linux/irqflags.h:20,
                    from include/asm-generic/cmpxchg-local.h:6,
                    from arch/parisc/include/asm/cmpxchg.h:87,
                    from arch/parisc/include/asm/atomic.h:10,
                    from include/linux/atomic.h:7,
                    from arch/parisc/include/asm/bitops.h:13,
                    from include/linux/bitops.h:68,
                    from include/linux/kernel.h:23,
                    from arch/parisc/include/asm/bug.h:5,
                    from include/linux/bug.h:5,
                    from include/linux/page-flags.h:10,
                    from kernel/bounds.c:10:
   include/linux/jump_label.h:329:2: note: previous implicit declaration of 'atomic_set' was here
     atomic_set(&key->enabled, 1);
     ^~~~~~~~~~
   In file included from include/linux/atomic.h:82,
                    from arch/parisc/include/asm/bitops.h:13,
                    from include/linux/bitops.h:68,
                    from include/linux/kernel.h:23,
                    from arch/parisc/include/asm/bug.h:5,
                    from include/linux/bug.h:5,
                    from include/linux/page-flags.h:10,
                    from kernel/bounds.c:10:
>> include/linux/atomic/atomic-instrumented.h:590:1: warning: conflicting types for 'atomic_dec'
    atomic_dec(atomic_t *v)
    ^~~~~~~~~~
   include/linux/atomic/atomic-instrumented.h:590:1: error: static declaration of 'atomic_dec' follows non-static declaration
   In file included from include/linux/static_key.h:1,
                    from include/linux/tracepoint-defs.h:12,
                    from include/linux/irqflags.h:20,
                    from include/asm-generic/cmpxchg-local.h:6,
                    from arch/parisc/include/asm/cmpxchg.h:87,
                    from arch/parisc/include/asm/atomic.h:10,
                    from include/linux/atomic.h:7,
                    from arch/parisc/include/asm/bitops.h:13,
                    from include/linux/bitops.h:68,
                    from include/linux/kernel.h:23,
                    from arch/parisc/include/asm/bug.h:5,
                    from include/linux/bug.h:5,
                    from include/linux/page-flags.h:10,
                    from kernel/bounds.c:10:
   include/linux/jump_label.h:307:2: note: previous implicit declaration of 'atomic_dec' was here
     atomic_dec(&key->enabled);
     ^~~~~~~~~~
   In file included from include/linux/atomic.h:82,
                    from arch/parisc/include/asm/bitops.h:13,
                    from include/linux/bitops.h:68,
                    from include/linux/kernel.h:23,
                    from arch/parisc/include/asm/bug.h:5,
                    from include/linux/bug.h:5,
                    from include/linux/page-flags.h:10,
                    from kernel/bounds.c:10:
>> include/linux/atomic/atomic-instrumented.h:1275:1: error: conflicting types for 'atomic_try_cmpxchg'
    atomic_try_cmpxchg(atomic_t *v, int *old, int new)
    ^~~~~~~~~~~~~~~~~~
   In file included from include/linux/array_size.h:5,
                    from include/linux/kernel.h:16,
                    from arch/parisc/include/asm/bug.h:5,
                    from include/linux/bug.h:5,
                    from include/linux/page-flags.h:10,
                    from kernel/bounds.c:10:
   include/linux/jump_label.h:299:19: note: previous implicit declaration of 'atomic_try_cmpxchg' was here
     } while (!likely(atomic_try_cmpxchg(&key->enabled, &v, v + 1)));
                      ^~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:76:40: note: in definition of macro 'likely'
    # define likely(x) __builtin_expect(!!(x), 1)
                                           ^
   cc1: some warnings being treated as errors
   make[3]: *** [scripts/Makefile.build:98: kernel/bounds.s] Error 1 shuffle=1288049444
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1274: prepare0] Error 2 shuffle=1288049444
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:248: __sub-make] Error 2 shuffle=1288049444
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:248: __sub-make] Error 2 shuffle=1288049444
   make: Target 'prepare' not remade because of errors.


vim +/atomic_try_cmpxchg +1275 include/linux/atomic/atomic-instrumented.h

aa525d063851a9 include/asm-generic/atomic-instrumented.h  Mark Rutland 2018-09-04  1259  
ad8110706f3811 include/linux/atomic/atomic-instrumented.h Mark Rutland 2023-06-05  1260  /**
ad8110706f3811 include/linux/atomic/atomic-instrumented.h Mark Rutland 2023-06-05  1261   * atomic_try_cmpxchg() - atomic compare and exchange with full ordering
ad8110706f3811 include/linux/atomic/atomic-instrumented.h Mark Rutland 2023-06-05  1262   * @v: pointer to atomic_t
ad8110706f3811 include/linux/atomic/atomic-instrumented.h Mark Rutland 2023-06-05  1263   * @old: pointer to int value to compare with
ad8110706f3811 include/linux/atomic/atomic-instrumented.h Mark Rutland 2023-06-05  1264   * @new: int value to assign
ad8110706f3811 include/linux/atomic/atomic-instrumented.h Mark Rutland 2023-06-05  1265   *
ad8110706f3811 include/linux/atomic/atomic-instrumented.h Mark Rutland 2023-06-05  1266   * If (@v == @old), atomically updates @v to @new with full ordering.
6dfee110c6cc7a include/linux/atomic/atomic-instrumented.h Mark Rutland 2024-02-09  1267   * Otherwise, @v is not modified, @old is updated to the current value of @v,
6dfee110c6cc7a include/linux/atomic/atomic-instrumented.h Mark Rutland 2024-02-09  1268   * and relaxed ordering is provided.
ad8110706f3811 include/linux/atomic/atomic-instrumented.h Mark Rutland 2023-06-05  1269   *
ad8110706f3811 include/linux/atomic/atomic-instrumented.h Mark Rutland 2023-06-05  1270   * Unsafe to use in noinstr code; use raw_atomic_try_cmpxchg() there.
ad8110706f3811 include/linux/atomic/atomic-instrumented.h Mark Rutland 2023-06-05  1271   *
ad8110706f3811 include/linux/atomic/atomic-instrumented.h Mark Rutland 2023-06-05  1272   * Return: @true if the exchange occured, @false otherwise.
ad8110706f3811 include/linux/atomic/atomic-instrumented.h Mark Rutland 2023-06-05  1273   */
c020395b6634b7 include/asm-generic/atomic-instrumented.h  Marco Elver  2019-11-26  1274  static __always_inline bool
aa525d063851a9 include/asm-generic/atomic-instrumented.h  Mark Rutland 2018-09-04 @1275  atomic_try_cmpxchg(atomic_t *v, int *old, int new)
aa525d063851a9 include/asm-generic/atomic-instrumented.h  Mark Rutland 2018-09-04  1276  {
e87c4f6642f496 include/linux/atomic/atomic-instrumented.h Marco Elver  2021-11-30  1277  	kcsan_mb();
3570a1bcf45e9a include/asm-generic/atomic-instrumented.h  Marco Elver  2020-07-24  1278  	instrument_atomic_read_write(v, sizeof(*v));
3570a1bcf45e9a include/asm-generic/atomic-instrumented.h  Marco Elver  2020-07-24  1279  	instrument_atomic_read_write(old, sizeof(*old));
c9268ac615f9f6 include/linux/atomic/atomic-instrumented.h Mark Rutland 2023-06-05  1280  	return raw_atomic_try_cmpxchg(v, old, new);
aa525d063851a9 include/asm-generic/atomic-instrumented.h  Mark Rutland 2018-09-04  1281  }
aa525d063851a9 include/asm-generic/atomic-instrumented.h  Mark Rutland 2018-09-04  1282  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
