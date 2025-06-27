Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126501E3DF2;
	Fri, 27 Jun 2025 22:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751061657; cv=none; b=eZu53wWc+pjPi6xjNzLggpaASV35u0ZLmM+bSbVG9HY4DUvrzQWD+X0UtqecRXe3neTlS7VDHgIifrLUrjndzcpqg848As5nvgz5Ly/VSeUFFmP5AsVwmGLm/C29GSYcSJknVWzn+DIYvM73nXUjakB6WsV1xGYDM6brYyvTEkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751061657; c=relaxed/simple;
	bh=kny2SXs15smNjfH9pjMs4jOR3nHD7rU5IcbqFhZp10w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d+3FwzWOpHvJ02244Dubp2n8k5oM/3xWYPJKrjdxMbrP9QynP3R0Dibdwf8VPguC+DQtF3YDY3zUbI3N6DgJXQ/3aqvu2wPOMAxYULfdiv1W7Lt/6zz2dv5SSJB3ZL9DZQPjT8aIyy6PLiCKVfsBWBNm7aEaC89cBTUk6Yvo+HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T34kLHej; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T34kLHej"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751061655; x=1782597655;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kny2SXs15smNjfH9pjMs4jOR3nHD7rU5IcbqFhZp10w=;
  b=T34kLHejB8ewKhnm6qNbkjpDJns2uBovFNn2uoIv8QtNnNneKvE81Qf5
   8bxevKRGQjUEmJVAarflJ1nxzCU128Q2/K7S0wttrkP49XorlokoqmByU
   7M/nrFrp8OIa2TX+VePuTHx/BkaKtKg3lUYxfwlSjT1BIeuMA0r2UkK93
   NFRVXX6gF4iPKuDRKqRGw4xtTAmg62vs3iOg3FZubLpcPpwigdP1gulym
   M1ocymy2+Ltn1rhtuOqBU5UEy7sOsfCLJ4tlLOcqDY37HS3uY01IAU2Mk
   TSKWrR6P6cW4rvtFXipMA4nkNtiUb4+V3XXTM9TTSQeQSWthfetUdQO7t
   g==;
X-CSE-ConnectionGUID: Sxy18yALToaCesjtvyWnmw==
X-CSE-MsgGUID: d0HTAVO0Qs6AtwVxfVd5tw==
X-IronPort-AV: E=McAfee;i="6800,10657,11477"; a="78821555"
X-IronPort-AV: E=Sophos;i="6.16,271,1744095600"; 
   d="scan'208";a="78821555"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 15:00:54 -0700
X-CSE-ConnectionGUID: shvZSA3uQkq+ng3gytSIeA==
X-CSE-MsgGUID: wYvyKMvQQzWkl55yWsxyxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,271,1744095600"; 
   d="scan'208";a="158416385"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 27 Jun 2025 15:00:49 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uVH7n-000WZq-16;
	Fri, 27 Jun 2025 22:00:47 +0000
Date: Sat, 28 Jun 2025 05:59:47 +0800
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
Subject: Re: [PATCH 2/2] tracing/preemptirq: Optimize
 preempt_disable/enable() tracepoint overhead
Message-ID: <202506280524.R4BJehMT-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on trace/for-next]
[also build test ERROR on tip/sched/core linus/master v6.16-rc3 next-20250627]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wander-Lairson-Costa/trace-preemptirq-reduce-overhead-of-irq_enable-disable-tracepoints/20250626-222438
base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
patch link:    https://lore.kernel.org/r/20250626142017.26372-3-wander%40redhat.com
patch subject: [PATCH 2/2] tracing/preemptirq: Optimize preempt_disable/enable() tracepoint overhead
config: powerpc-randconfig-002-20250628 (https://download.01.org/0day-ci/archive/20250628/202506280524.R4BJehMT-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250628/202506280524.R4BJehMT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506280524.R4BJehMT-lkp@intel.com/

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
>> include/linux/irqflags.h:201:1: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
     201 | DECLARE_TRACEPOINT(irq_enable);
         | ^
         | int
>> include/linux/irqflags.h:201:20: error: a parameter list without types is only allowed in a function definition
     201 | DECLARE_TRACEPOINT(irq_enable);
         |                    ^
   include/linux/irqflags.h:202:1: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
     202 | DECLARE_TRACEPOINT(irq_disable);
         | ^
         | int
   include/linux/irqflags.h:202:20: error: a parameter list without types is only allowed in a function definition
     202 | DECLARE_TRACEPOINT(irq_disable);
         |                    ^
>> include/linux/irqflags.h:274:47: error: call to undeclared function 'tracepoint_enabled'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     274 | DEFINE_LOCK_GUARD_0(irq, local_irq_disable(), local_irq_enable())
         |                                               ^
   include/linux/irqflags.h:206:7: note: expanded from macro 'local_irq_enable'
     206 |                 if (tracepoint_enabled(irq_enable))     \
         |                     ^
>> include/linux/irqflags.h:274:47: error: use of undeclared identifier 'irq_enable'
   include/linux/irqflags.h:206:26: note: expanded from macro 'local_irq_enable'
     206 |                 if (tracepoint_enabled(irq_enable))     \
         |                                        ^
>> include/linux/irqflags.h:274:47: error: use of undeclared identifier 'irq_enable'
   include/linux/irqflags.h:206:26: note: expanded from macro 'local_irq_enable'
     206 |                 if (tracepoint_enabled(irq_enable))     \
         |                                        ^
>> include/linux/irqflags.h:274:47: error: use of undeclared identifier 'irq_enable'
   include/linux/irqflags.h:206:26: note: expanded from macro 'local_irq_enable'
     206 |                 if (tracepoint_enabled(irq_enable))     \
         |                                        ^
   include/linux/irqflags.h:274:26: error: call to undeclared function 'tracepoint_enabled'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     274 | DEFINE_LOCK_GUARD_0(irq, local_irq_disable(), local_irq_enable())
         |                          ^
   include/linux/irqflags.h:215:7: note: expanded from macro 'local_irq_disable'
     215 |                 if (tracepoint_enabled(irq_disable) &&  \
         |                     ^
>> include/linux/irqflags.h:274:26: error: use of undeclared identifier 'irq_disable'; did you mean 'was_disabled'?
   include/linux/irqflags.h:215:26: note: expanded from macro 'local_irq_disable'
     215 |                 if (tracepoint_enabled(irq_disable) &&  \
         |                                        ^
   include/linux/irqflags.h:274:26: note: 'was_disabled' declared here
   include/linux/irqflags.h:213:8: note: expanded from macro 'local_irq_disable'
     213 |                 bool was_disabled = raw_irqs_disabled();\
         |                      ^
>> include/linux/irqflags.h:274:26: error: use of undeclared identifier 'irq_disable'; did you mean 'was_disabled'?
     274 | DEFINE_LOCK_GUARD_0(irq, local_irq_disable(), local_irq_enable())
         |                          ^
   include/linux/irqflags.h:215:26: note: expanded from macro 'local_irq_disable'
     215 |                 if (tracepoint_enabled(irq_disable) &&  \
         |                                        ^
   include/linux/irqflags.h:274:26: note: 'was_disabled' declared here
   include/linux/irqflags.h:213:8: note: expanded from macro 'local_irq_disable'
     213 |                 bool was_disabled = raw_irqs_disabled();\
         |                      ^
>> include/linux/irqflags.h:274:26: error: use of undeclared identifier 'irq_disable'; did you mean 'was_disabled'?
     274 | DEFINE_LOCK_GUARD_0(irq, local_irq_disable(), local_irq_enable())
         |                          ^
   include/linux/irqflags.h:215:26: note: expanded from macro 'local_irq_disable'
     215 |                 if (tracepoint_enabled(irq_disable) &&  \
         |                                        ^
   include/linux/irqflags.h:274:26: note: 'was_disabled' declared here
   include/linux/irqflags.h:213:8: note: expanded from macro 'local_irq_disable'
     213 |                 bool was_disabled = raw_irqs_disabled();\
         |                      ^
   include/linux/irqflags.h:277:7: error: call to undeclared function 'tracepoint_enabled'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     277 |                     local_irq_restore(_T->flags),
         |                     ^
   include/linux/irqflags.h:230:7: note: expanded from macro 'local_irq_restore'
     230 |                 if (tracepoint_enabled(irq_enable) &&   \
         |                     ^
   include/linux/irqflags.h:277:7: error: use of undeclared identifier 'irq_enable'
   include/linux/irqflags.h:230:26: note: expanded from macro 'local_irq_restore'
     230 |                 if (tracepoint_enabled(irq_enable) &&   \
         |                                        ^
   include/linux/irqflags.h:277:7: error: use of undeclared identifier 'irq_enable'
   include/linux/irqflags.h:230:26: note: expanded from macro 'local_irq_restore'
     230 |                 if (tracepoint_enabled(irq_enable) &&   \
         |                                        ^
   include/linux/irqflags.h:277:7: error: use of undeclared identifier 'irq_enable'
   include/linux/irqflags.h:230:26: note: expanded from macro 'local_irq_restore'
     230 |                 if (tracepoint_enabled(irq_enable) &&   \
         |                                        ^
   include/linux/irqflags.h:276:7: error: call to undeclared function 'tracepoint_enabled'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     276 |                     local_irq_save(_T->flags),
         |                     ^
   include/linux/irqflags.h:223:7: note: expanded from macro 'local_irq_save'
     223 |                 if (tracepoint_enabled(irq_disable) &&  \
         |                     ^
   include/linux/irqflags.h:276:7: error: use of undeclared identifier 'irq_disable'
   include/linux/irqflags.h:223:26: note: expanded from macro 'local_irq_save'
     223 |                 if (tracepoint_enabled(irq_disable) &&  \
         |                                        ^
   include/linux/irqflags.h:276:7: error: use of undeclared identifier 'irq_disable'
   include/linux/irqflags.h:223:26: note: expanded from macro 'local_irq_save'
     223 |                 if (tracepoint_enabled(irq_disable) &&  \
         |                                        ^
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   20 errors generated.
   make[3]: *** [scripts/Makefile.build:98: arch/powerpc/kernel/asm-offsets.s] Error 1 shuffle=1905180499
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1274: prepare0] Error 2 shuffle=1905180499
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:248: __sub-make] Error 2 shuffle=1905180499
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:248: __sub-make] Error 2 shuffle=1905180499
   make: Target 'prepare' not remade because of errors.


vim +/tracepoint_enabled +274 include/linux/irqflags.h

00b0ed2d4997af6 Peter Zijlstra       2020-08-12  200  
563d10fd41452f8 Wander Lairson Costa 2025-06-26 @201  DECLARE_TRACEPOINT(irq_enable);
563d10fd41452f8 Wander Lairson Costa 2025-06-26 @202  DECLARE_TRACEPOINT(irq_disable);
563d10fd41452f8 Wander Lairson Costa 2025-06-26  203  
de30a2b355ea853 Ingo Molnar          2006-07-03  204  #define local_irq_enable()				\
00b0ed2d4997af6 Peter Zijlstra       2020-08-12  205  	do {						\
563d10fd41452f8 Wander Lairson Costa 2025-06-26 @206  		if (tracepoint_enabled(irq_enable))	\
00b0ed2d4997af6 Peter Zijlstra       2020-08-12  207  			trace_hardirqs_on();		\
00b0ed2d4997af6 Peter Zijlstra       2020-08-12  208  		raw_local_irq_enable();			\
00b0ed2d4997af6 Peter Zijlstra       2020-08-12  209  	} while (0)
00b0ed2d4997af6 Peter Zijlstra       2020-08-12  210  
de30a2b355ea853 Ingo Molnar          2006-07-03  211  #define local_irq_disable()				\
00b0ed2d4997af6 Peter Zijlstra       2020-08-12  212  	do {						\
044d0d6de9f5019 Nicholas Piggin      2020-07-23  213  		bool was_disabled = raw_irqs_disabled();\
00b0ed2d4997af6 Peter Zijlstra       2020-08-12  214  		raw_local_irq_disable();		\
563d10fd41452f8 Wander Lairson Costa 2025-06-26  215  		if (tracepoint_enabled(irq_disable) &&	\
563d10fd41452f8 Wander Lairson Costa 2025-06-26  216  		    !was_disabled)			\
00b0ed2d4997af6 Peter Zijlstra       2020-08-12  217  			trace_hardirqs_off();		\
00b0ed2d4997af6 Peter Zijlstra       2020-08-12  218  	} while (0)
00b0ed2d4997af6 Peter Zijlstra       2020-08-12  219  
de30a2b355ea853 Ingo Molnar          2006-07-03  220  #define local_irq_save(flags)				\
3f307891ce0e7b0 Steven Rostedt       2008-07-25  221  	do {						\
3f307891ce0e7b0 Steven Rostedt       2008-07-25  222  		raw_local_irq_save(flags);		\
563d10fd41452f8 Wander Lairson Costa 2025-06-26  223  		if (tracepoint_enabled(irq_disable) &&	\
563d10fd41452f8 Wander Lairson Costa 2025-06-26  224  		    !raw_irqs_disabled_flags(flags))	\
3f307891ce0e7b0 Steven Rostedt       2008-07-25  225  			trace_hardirqs_off();		\
3f307891ce0e7b0 Steven Rostedt       2008-07-25  226  	} while (0)
3f307891ce0e7b0 Steven Rostedt       2008-07-25  227  
de30a2b355ea853 Ingo Molnar          2006-07-03  228  #define local_irq_restore(flags)			\
de30a2b355ea853 Ingo Molnar          2006-07-03  229  	do {						\
563d10fd41452f8 Wander Lairson Costa 2025-06-26  230  		if (tracepoint_enabled(irq_enable) &&	\
563d10fd41452f8 Wander Lairson Costa 2025-06-26  231  		    !raw_irqs_disabled_flags(flags))	\
de30a2b355ea853 Ingo Molnar          2006-07-03  232  			trace_hardirqs_on();		\
de30a2b355ea853 Ingo Molnar          2006-07-03  233  		raw_local_irq_restore(flags);		\
de30a2b355ea853 Ingo Molnar          2006-07-03  234  	} while (0)
de30a2b355ea853 Ingo Molnar          2006-07-03  235  
df9ee29270c11db David Howells        2010-10-07  236  #define safe_halt()					\
df9ee29270c11db David Howells        2010-10-07  237  	do {						\
563d10fd41452f8 Wander Lairson Costa 2025-06-26  238  		if (tracepoint_enabled(irq_enable))	\
df9ee29270c11db David Howells        2010-10-07  239  			trace_hardirqs_on();		\
df9ee29270c11db David Howells        2010-10-07  240  		raw_safe_halt();			\
df9ee29270c11db David Howells        2010-10-07  241  	} while (0)
df9ee29270c11db David Howells        2010-10-07  242  
df9ee29270c11db David Howells        2010-10-07  243  
db2dcb4f91d5fec Jan Beulich          2015-01-20  244  #else /* !CONFIG_TRACE_IRQFLAGS */
df9ee29270c11db David Howells        2010-10-07  245  
df9ee29270c11db David Howells        2010-10-07  246  #define local_irq_enable()	do { raw_local_irq_enable(); } while (0)
df9ee29270c11db David Howells        2010-10-07  247  #define local_irq_disable()	do { raw_local_irq_disable(); } while (0)
00b0ed2d4997af6 Peter Zijlstra       2020-08-12  248  #define local_irq_save(flags)	do { raw_local_irq_save(flags); } while (0)
df9ee29270c11db David Howells        2010-10-07  249  #define local_irq_restore(flags) do { raw_local_irq_restore(flags); } while (0)
df9ee29270c11db David Howells        2010-10-07  250  #define safe_halt()		do { raw_safe_halt(); } while (0)
df9ee29270c11db David Howells        2010-10-07  251  
db2dcb4f91d5fec Jan Beulich          2015-01-20  252  #endif /* CONFIG_TRACE_IRQFLAGS */
db2dcb4f91d5fec Jan Beulich          2015-01-20  253  
db2dcb4f91d5fec Jan Beulich          2015-01-20  254  #define local_save_flags(flags)	raw_local_save_flags(flags)
db2dcb4f91d5fec Jan Beulich          2015-01-20  255  
db2dcb4f91d5fec Jan Beulich          2015-01-20  256  /*
db2dcb4f91d5fec Jan Beulich          2015-01-20  257   * Some architectures don't define arch_irqs_disabled(), so even if either
db2dcb4f91d5fec Jan Beulich          2015-01-20  258   * definition would be fine we need to use different ones for the time being
db2dcb4f91d5fec Jan Beulich          2015-01-20  259   * to avoid build issues.
db2dcb4f91d5fec Jan Beulich          2015-01-20  260   */
db2dcb4f91d5fec Jan Beulich          2015-01-20  261  #ifdef CONFIG_TRACE_IRQFLAGS_SUPPORT
db2dcb4f91d5fec Jan Beulich          2015-01-20  262  #define irqs_disabled()					\
db2dcb4f91d5fec Jan Beulich          2015-01-20  263  	({						\
db2dcb4f91d5fec Jan Beulich          2015-01-20  264  		unsigned long _flags;			\
db2dcb4f91d5fec Jan Beulich          2015-01-20  265  		raw_local_save_flags(_flags);		\
db2dcb4f91d5fec Jan Beulich          2015-01-20  266  		raw_irqs_disabled_flags(_flags);	\
db2dcb4f91d5fec Jan Beulich          2015-01-20  267  	})
db2dcb4f91d5fec Jan Beulich          2015-01-20  268  #else /* !CONFIG_TRACE_IRQFLAGS_SUPPORT */
db2dcb4f91d5fec Jan Beulich          2015-01-20  269  #define irqs_disabled()	raw_irqs_disabled()
40b1f4e5113eafc Michael Neuling      2009-10-22  270  #endif /* CONFIG_TRACE_IRQFLAGS_SUPPORT */
de30a2b355ea853 Ingo Molnar          2006-07-03  271  
db2dcb4f91d5fec Jan Beulich          2015-01-20  272  #define irqs_disabled_flags(flags) raw_irqs_disabled_flags(flags)
db2dcb4f91d5fec Jan Beulich          2015-01-20  273  
54da6a0924311c7 Peter Zijlstra       2023-05-26 @274  DEFINE_LOCK_GUARD_0(irq, local_irq_disable(), local_irq_enable())
54da6a0924311c7 Peter Zijlstra       2023-05-26  275  DEFINE_LOCK_GUARD_0(irqsave,
54da6a0924311c7 Peter Zijlstra       2023-05-26  276  		    local_irq_save(_T->flags),
54da6a0924311c7 Peter Zijlstra       2023-05-26  277  		    local_irq_restore(_T->flags),
54da6a0924311c7 Peter Zijlstra       2023-05-26  278  		    unsigned long flags)
54da6a0924311c7 Peter Zijlstra       2023-05-26  279  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
