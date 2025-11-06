Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8B63451A9;
	Thu,  6 Nov 2025 14:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762439909; cv=none; b=i9pk9kuEv5/Dd22ZjGG8rGS1HkhvMo5t8oqcfQNVe6mP541GFBFpuiX3suWjilrV2f3P1GxMxVC0l2PhdH1XnoEPvfy4AijV40ytOJFOh3sWdBFHTN0DEj2qQAiIzQaDuUc8QE0pS3P91+ek73BsKNsEc4Hf2R2m+xx+CNPxckY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762439909; c=relaxed/simple;
	bh=qjA9ze1XqObCgR5Te5hbEW9wde11R4+WtauacdBNGBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=asoofM7fjLZCz7RwXcHs0UqTg5bGHqS7fEBuO6PV7qevGnTjm1wwSqnSjOKpv2JSMv2U1ceeatl5djI1+c4APTZ5PwmUEyRoJr4tRG9cGrFTtOd3tYQZJAaugeovpcC6RSAuap8BlB2AxwxXHB9aF5nTQuQQjw4QroN5KZ1LANc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PqtkRJ2N; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PqtkRJ2N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762439908; x=1793975908;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qjA9ze1XqObCgR5Te5hbEW9wde11R4+WtauacdBNGBU=;
  b=PqtkRJ2N/cHUhQQizgwWyTARzg5buqBJhcUJVJEEhgXzsBuU0TjITIU7
   NFsbNAUzkg91BEbNPfcHpLeln/yxEowvvkBtTNfZeA0SwKYq5eDcTGsBt
   rd2MF0juIFotM/rYLy/W58BVu5W3L6RwQQDkicVlg3xXyuDK8uSgCrobS
   GvCWCKyNvuEQuXmMonL6FMapTLQY4zSeC3JXpoYOVW+Y2tIS9allM3Lbq
   b7Cr/0A2tMFHIBHQSm3SHcnyNspfvPk5V9jqBUDPiQ2W2qKXGviOJNL0X
   D1yW1t8Q9XUVIw4dsZmsREWNc8bZssJrOuvkoOcWKhiZrhfr0uj50R3J6
   w==;
X-CSE-ConnectionGUID: S3T1VbPBTj+JtYaYHWPjKg==
X-CSE-MsgGUID: Rpkh9yRGQKOP1zd21j86Ug==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="87206561"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="87206561"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 06:38:27 -0800
X-CSE-ConnectionGUID: QD+x6HneTv6Gu9i9eTzITQ==
X-CSE-MsgGUID: JYgGY/w/QwKQkjtpz9L0SQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="187716231"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 06 Nov 2025 06:38:24 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vH182-000U1I-14;
	Thu, 06 Nov 2025 14:38:22 +0000
Date: Thu, 6 Nov 2025 22:38:04 +0800
From: kernel test robot <lkp@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH 3/5] tracing: Have tracer option be instance specific
Message-ID: <202511062223.ocoUvCBI-lkp@intel.com>
References: <20251105161935.545400234@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105161935.545400234@kernel.org>

Hi Steven,

kernel test robot noticed the following build errors:

[auto build test ERROR on trace/for-next]
[cannot apply to linus/master v6.18-rc4 next-20251106]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Steven-Rostedt/tracing-Remove-dummy-options-and-flags/20251106-010511
base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
patch link:    https://lore.kernel.org/r/20251105161935.545400234%40kernel.org
patch subject: [PATCH 3/5] tracing: Have tracer option be instance specific
config: i386-buildonly-randconfig-003-20251106 (https://download.01.org/0day-ci/archive/20251106/202511062223.ocoUvCBI-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251106/202511062223.ocoUvCBI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511062223.ocoUvCBI-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   kernel/trace/trace.c: In function 'run_tracer_selftest':
>> kernel/trace/trace.c:2174:30: error: 'type' redeclared as different kind of symbol
    2174 |         struct trace_tracer *type = tracers->trace;
         |                              ^~~~
   kernel/trace/trace.c:2171:47: note: previous definition of 'type' with type 'struct tracer *'
    2171 | static int run_tracer_selftest(struct tracer *type)
         |                                ~~~~~~~~~~~~~~~^~~~
>> kernel/trace/trace.c:2174:37: error: 'tracers' undeclared (first use in this function)
    2174 |         struct trace_tracer *type = tracers->trace;
         |                                     ^~~~~~~
   kernel/trace/trace.c:2174:37: note: each undeclared identifier is reported only once for each function it appears in
>> kernel/trace/trace.c:2180:18: error: invalid use of undefined type 'struct trace_tracer'
    2180 |         if (!type->selftest || tracing_selftest_disabled)
         |                  ^~
>> kernel/trace/trace.c:2189:38: error: passing argument 1 of 'save_selftest' from incompatible pointer type [-Wincompatible-pointer-types]
    2189 |                 return save_selftest(type);
         |                                      ^~~~
         |                                      |
         |                                      struct trace_tracer *
   kernel/trace/trace.c:2158:41: note: expected 'struct tracer *' but argument is of type 'struct trace_tracer *'
    2158 | static int save_selftest(struct tracer *type)
         |                          ~~~~~~~~~~~~~~~^~~~
   In file included from include/asm-generic/bug.h:22,
                    from arch/x86/include/asm/bug.h:108,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/mm.h:6,
                    from include/linux/ring_buffer.h:5,
                    from kernel/trace/trace.c:15:
   kernel/trace/trace.c:2193:29: error: invalid use of undefined type 'struct trace_tracer'
    2193 |                         type->name);
         |                             ^~
   include/linux/printk.h:484:33: note: in definition of macro 'printk_index_wrap'
     484 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
   include/linux/printk.h:565:9: note: in expansion of macro 'printk'
     565 |         printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~
   kernel/trace/trace.c:2192:17: note: in expansion of macro 'pr_warn'
    2192 |                 pr_warn("Selftest for tracer %s skipped due to tracing disabled\n",
         |                 ^~~~~~~
>> kernel/trace/trace.c:2206:27: error: assignment to 'struct tracer *' from incompatible pointer type 'struct trace_tracer *' [-Wincompatible-pointer-types]
    2206 |         tr->current_trace = type;
         |                           ^
   kernel/trace/trace.c:2207:39: error: invalid use of undefined type 'struct trace_tracer'
    2207 |         tr->current_trace_flags = type->flags ? : type->default_flags;
         |                                       ^~
   kernel/trace/trace.c:2207:55: error: invalid use of undefined type 'struct trace_tracer'
    2207 |         tr->current_trace_flags = type->flags ? : type->default_flags;
         |                                                       ^~
   kernel/trace/trace.c:2210:17: error: invalid use of undefined type 'struct trace_tracer'
    2210 |         if (type->use_max_tr) {
         |                 ^~
   kernel/trace/trace.c:2220:44: error: invalid use of undefined type 'struct trace_tracer'
    2220 |         pr_info("Testing tracer %s: ", type->name);
         |                                            ^~
   include/linux/printk.h:484:33: note: in definition of macro 'printk_index_wrap'
     484 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
   include/linux/printk.h:585:9: note: in expansion of macro 'printk'
     585 |         printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~
   kernel/trace/trace.c:2220:9: note: in expansion of macro 'pr_info'
    2220 |         pr_info("Testing tracer %s: ", type->name);
         |         ^~~~~~~
   kernel/trace/trace.c:2221:19: error: invalid use of undefined type 'struct trace_tracer'
    2221 |         ret = type->selftest(type, tr);
         |                   ^~
   kernel/trace/trace.c:2235:17: error: invalid use of undefined type 'struct trace_tracer'
    2235 |         if (type->use_max_tr) {
         |                 ^~
>> kernel/trace/trace.c:2176:30: warning: unused variable 'flags' [-Wunused-variable]
    2176 |         struct tracer_flags *flags;
         |                              ^~~~~
   kernel/trace/trace.c: In function 'tracing_trace_options_show':
   kernel/trace/trace.c:5172:24: warning: variable 'trace' set but not used [-Wunused-but-set-variable]
    5172 |         struct tracer *trace;
         |                        ^~~~~


vim +/type +2174 kernel/trace/trace.c

  2170	
> 2171	static int run_tracer_selftest(struct tracer *type)
  2172	{
  2173		struct trace_array *tr = &global_trace;
> 2174		struct trace_tracer *type = tracers->trace;
  2175		struct tracer_flags *saved_flags = tr->current_trace_flags;
> 2176		struct tracer_flags *flags;
  2177		struct tracer *saved_tracer = tr->current_trace;
  2178		int ret;
  2179	
> 2180		if (!type->selftest || tracing_selftest_disabled)
  2181			return 0;
  2182	
  2183		/*
  2184		 * If a tracer registers early in boot up (before scheduling is
  2185		 * initialized and such), then do not run its selftests yet.
  2186		 * Instead, run it a little later in the boot process.
  2187		 */
  2188		if (!selftests_can_run)
> 2189			return save_selftest(type);
  2190	
  2191		if (!tracing_is_on()) {
> 2192			pr_warn("Selftest for tracer %s skipped due to tracing disabled\n",
  2193				type->name);
  2194			return 0;
  2195		}
  2196	
  2197		/*
  2198		 * Run a selftest on this tracer.
  2199		 * Here we reset the trace buffer, and set the current
  2200		 * tracer to be this tracer. The tracer can then run some
  2201		 * internal tracing to verify that everything is in order.
  2202		 * If we fail, we do not register this tracer.
  2203		 */
  2204		tracing_reset_online_cpus(&tr->array_buffer);
  2205	
> 2206		tr->current_trace = type;
  2207		tr->current_trace_flags = type->flags ? : type->default_flags;
  2208	
  2209	#ifdef CONFIG_TRACER_MAX_TRACE
  2210		if (type->use_max_tr) {
  2211			/* If we expanded the buffers, make sure the max is expanded too */
  2212			if (tr->ring_buffer_expanded)
  2213				ring_buffer_resize(tr->max_buffer.buffer, trace_buf_size,
  2214						   RING_BUFFER_ALL_CPUS);
  2215			tr->allocated_snapshot = true;
  2216		}
  2217	#endif
  2218	
  2219		/* the test is responsible for initializing and enabling */
> 2220		pr_info("Testing tracer %s: ", type->name);
  2221		ret = type->selftest(type, tr);
  2222		/* the test is responsible for resetting too */
  2223		tr->current_trace = saved_tracer;
  2224		tr->current_trace_flags = saved_flags;
  2225		if (ret) {
  2226			printk(KERN_CONT "FAILED!\n");
  2227			/* Add the warning after printing 'FAILED' */
  2228			WARN_ON(1);
  2229			return -1;
  2230		}
  2231		/* Only reset on passing, to avoid touching corrupted buffers */
  2232		tracing_reset_online_cpus(&tr->array_buffer);
  2233	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
