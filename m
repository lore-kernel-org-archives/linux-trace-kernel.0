Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47983494808;
	Thu,  6 Aug 2026 19:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786045173; cv=none; b=qG6frfTXEUFnYXuBEMb/7fOiQ5YGxceX2frtPc+hHvAZ5zLqW/ghQfu/wq6Z6S2kf6lpn4oGMVwJAfl5sIC0m+pXreew/yceQ7+LSHOgLCsGP79wewBd3DFDm03yRheTGgmOBJ5BbrvOAhuqP/Srm25Htw8tK/KsrBRxkRDFxds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786045173; c=relaxed/simple;
	bh=ANZHdTM7TN93BOTwXE42UMStode/Rb+Fv/a3OigaJ0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GYBWreziefi8uUOa2liMM3NZMEPkGD3lUwbk7fx87xCEa8Y/hV+40v4aYL03LcdJUsUZZK4QqmVmrzdovc1ERCj8oH+gKME/sF3BNmuokNydwQ4nYPBP1hpzug1IY99mdzccOdpCcHXSs/a7baX9XuZRwfGtCr4hdO6qymTvjjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SJV6XhS0; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SJV6XhS0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786045172; x=1817581172;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ANZHdTM7TN93BOTwXE42UMStode/Rb+Fv/a3OigaJ0I=;
  b=SJV6XhS0yz2hOs5bBQxyMYQyXYvTXsbATGKulX4JEfZ5DF/z29Z4M4Rc
   QUPnRzacTkXPb48DN7YCAwxybkD38uyLeOI34JwmBJGCt97njS0blnRXr
   bRmo0Jw0vjurKLcxNQod01k+Q4U3GrX6CE6Mo/gtXtufaZtUPewpu+Jf5
   /U4Jz+R2L/Ufjmcxuak3gFFWyC4roOgglVG5kkhSYc2YFfsGhhzsnriIL
   wFXb7znW5bYue9WFOhSACcllR3eVv8uoCA8YbuHFRT/4p85uyaDRrlq21
   TW8WtLgO7Jx01IXhioJ1/bGXX6zIuU296Mldko8AUe1xJeLzQlUXzpzWM
   A==;
X-CSE-ConnectionGUID: MEZn7ZaNRpeIZexTwF2n9g==
X-CSE-MsgGUID: 7/jo38Z1T86Y4kWK74Z3iQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86681334"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="86681334"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 12:39:15 -0700
X-CSE-ConnectionGUID: 0q/JnHUxTOq/4wxZaJ2hfA==
X-CSE-MsgGUID: FaM/PIf4TDSad8HX7GGsiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="266427342"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 06 Aug 2026 12:39:13 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1ws3vq-00000000G5B-0mwl;
	Thu, 06 Aug 2026 19:39:10 +0000
Date: Fri, 7 Aug 2026 03:38:25 +0800
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
Message-ID: <202608070304.QNhu3z0S-lkp@intel.com>
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
config: um-randconfig-r123-20260806 (https://download.01.org/0day-ci/archive/20260807/202608070304.QNhu3z0S-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260807/202608070304.QNhu3z0S-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608070304.QNhu3z0S-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/trace/trace_branch.c:218:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long * @@
   kernel/trace/trace_branch.c:218:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
   kernel/trace/trace_branch.c:218:17: sparse:     got unsigned long *
>> kernel/trace/trace_branch.c:218:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long * @@
   kernel/trace/trace_branch.c:218:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
   kernel/trace/trace_branch.c:218:17: sparse:     got unsigned long *
>> kernel/trace/trace_branch.c:218:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long * @@
   kernel/trace/trace_branch.c:218:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
   kernel/trace/trace_branch.c:218:17: sparse:     got unsigned long *
>> kernel/trace/trace_branch.c:218:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long * @@
   kernel/trace/trace_branch.c:218:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
   kernel/trace/trace_branch.c:218:17: sparse:     got unsigned long *
>> kernel/trace/trace_branch.c:218:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long * @@
   kernel/trace/trace_branch.c:218:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
   kernel/trace/trace_branch.c:218:17: sparse:     got unsigned long *
   kernel/trace/trace_branch.c:220:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long * @@
   kernel/trace/trace_branch.c:220:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
   kernel/trace/trace_branch.c:220:17: sparse:     got unsigned long *
   kernel/trace/trace_branch.c:220:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long * @@
   kernel/trace/trace_branch.c:220:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
   kernel/trace/trace_branch.c:220:17: sparse:     got unsigned long *
   kernel/trace/trace_branch.c:220:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long * @@
   kernel/trace/trace_branch.c:220:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
   kernel/trace/trace_branch.c:220:17: sparse:     got unsigned long *
   kernel/trace/trace_branch.c:220:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long * @@
   kernel/trace/trace_branch.c:220:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
   kernel/trace/trace_branch.c:220:17: sparse:     got unsigned long *
   kernel/trace/trace_branch.c:220:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long * @@
   kernel/trace/trace_branch.c:220:17: sparse:     expected void const [noderef] __percpu *__vpp_verify
   kernel/trace/trace_branch.c:220:17: sparse:     got unsigned long *

vim +218 kernel/trace/trace_branch.c

   197	
   198	void ftrace_likely_update(struct ftrace_likely_data *f, int val,
   199				  int expect, int is_constant)
   200	{
   201		unsigned long flags = user_access_save();
   202	
   203		/* A constant is always correct */
   204		if (is_constant) {
   205			f->constant++;
   206			val = expect;
   207		}
   208		/*
   209		 * I would love to have a trace point here instead, but the
   210		 * trace point code is so inundated with unlikely and likely
   211		 * conditions that the recursive nightmare that exists is too
   212		 * much to try to get working. At least for now.
   213		 */
   214		trace_likely_condition(f, val, expect);
   215	
   216		/* use per-cpu counters to avoid contention */
   217		if (val == expect)
 > 218			this_cpu_inc(f->data.correct);
   219		else
   220			this_cpu_inc(f->data.incorrect);
   221	
   222		user_access_restore(flags);
   223	}
   224	EXPORT_SYMBOL(ftrace_likely_update);
   225	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
