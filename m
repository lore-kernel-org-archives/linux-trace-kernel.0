Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EF2274B46;
	Thu,  6 Nov 2025 15:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762442974; cv=none; b=HtPas3g/N2waq4Slp8LKYmU0GyP+EoZIYfpScSofBakYz6AGbzKBfSFERzo2BJGLzl4JocqG8GFPOjF2NICwBqQopSZ+l0kQhW6kihFTgdPLOhm1Gv3lnKNRMWXx8JYY70f02F0Ty1ST24KF4kS9YWloM0gClUrOLP9OyKXL4AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762442974; c=relaxed/simple;
	bh=Fy5kb+xSEe8CuLReHJSiSgwCvjIGVD2dswSaWqR9TqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IOhQ+JaEJeAgorAD22zuFa5Vb1nh8wOOof/KO63wNSmpL1fBuTzKLs8FUXrusNyHqgR4jmSUb/L8BNwbU1mWjmrP2XK+aA/r0DqqvO7/0gm5RCbfouLfp9iMv+eTUjNgM1xdeJwpsUhTxsB6zftiEsm7sAnYAaadUxSecnzEUfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VAUigxDO; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VAUigxDO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762442972; x=1793978972;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Fy5kb+xSEe8CuLReHJSiSgwCvjIGVD2dswSaWqR9TqU=;
  b=VAUigxDONSSAJbxzBvT7LYmTDUgr8gucwo2MBR+WtMh63FPGrxujaT1p
   htgtG4HkDE0ZBC4srRKelBOdqhTjFtXiHVieg3qqnpEePIL58C3KMVXb6
   KYwW0rwbIvaWweMYeWoc4s/NFQlJvoTowvwZn9tqrlpX3w7qRsR5ZAIBU
   hgdjOLV5HfYTcGPM5/th8c1VM+K+8vfKFtxFy+hUIbGTX8X6sCt5XAJqJ
   8G7DdgJ2I71eJ0e7R9F5Tsvk0qk4F0wUJK509N4KO4KOkwg6FqvzeK0L6
   xwNdeu84roHYlRzIt11SFUgitYIUGMl2qB7uKBVb3pEJ9seI84CdX5O/I
   A==;
X-CSE-ConnectionGUID: NnrMhdUBQ6CJ1iZWTBN18Q==
X-CSE-MsgGUID: 3z8XjBKvTcOQy1+dAHKhbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="64465758"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="64465758"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 07:29:31 -0800
X-CSE-ConnectionGUID: sZfJMlAgRIG2UQxuqDCZKQ==
X-CSE-MsgGUID: Sny0jVoXSGuME85WdEfqVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="188502501"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 06 Nov 2025 07:29:28 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vH1vS-000U5A-0r;
	Thu, 06 Nov 2025 15:29:26 +0000
Date: Thu, 6 Nov 2025 23:29:25 +0800
From: kernel test robot <lkp@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH 3/5] tracing: Have tracer option be instance specific
Message-ID: <202511062257.TSJTBQ2c-lkp@intel.com>
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
config: i386-buildonly-randconfig-004-20251106 (https://download.01.org/0day-ci/archive/20251106/202511062257.TSJTBQ2c-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251106/202511062257.TSJTBQ2c-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511062257.TSJTBQ2c-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/trace/trace.c:2174:23: error: redefinition of 'type' with a different type: 'struct trace_tracer *' vs 'struct tracer *'
    2174 |         struct trace_tracer *type = tracers->trace;
         |                              ^
   kernel/trace/trace.c:2171:47: note: previous definition is here
    2171 | static int run_tracer_selftest(struct tracer *type)
         |                                               ^
>> kernel/trace/trace.c:2174:30: error: use of undeclared identifier 'tracers'
    2174 |         struct trace_tracer *type = tracers->trace;
         |                                     ^
   kernel/trace/trace.c:5172:17: warning: variable 'trace' set but not used [-Wunused-but-set-variable]
    5172 |         struct tracer *trace;
         |                        ^
   1 warning and 2 errors generated.


vim +2174 kernel/trace/trace.c

  2170	
  2171	static int run_tracer_selftest(struct tracer *type)
  2172	{
  2173		struct trace_array *tr = &global_trace;
> 2174		struct trace_tracer *type = tracers->trace;
  2175		struct tracer_flags *saved_flags = tr->current_trace_flags;
  2176		struct tracer_flags *flags;
  2177		struct tracer *saved_tracer = tr->current_trace;
  2178		int ret;
  2179	
  2180		if (!type->selftest || tracing_selftest_disabled)
  2181			return 0;
  2182	
  2183		/*
  2184		 * If a tracer registers early in boot up (before scheduling is
  2185		 * initialized and such), then do not run its selftests yet.
  2186		 * Instead, run it a little later in the boot process.
  2187		 */
  2188		if (!selftests_can_run)
  2189			return save_selftest(type);
  2190	
  2191		if (!tracing_is_on()) {
  2192			pr_warn("Selftest for tracer %s skipped due to tracing disabled\n",
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
  2206		tr->current_trace = type;
  2207		tr->current_trace_flags = type->flags ? : type->default_flags;
  2208	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
