Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B90D33DEC4;
	Sun,  8 Feb 2026 09:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770543004; cv=none; b=EajzY6ftF0LQijxYSkmQh9BZBAE9YNjAiNWLczu+/QM3xzlDIRPpHzS9tYoLExZnPaAM9hwWo7nu1QU14gYs0OtkmLYgmqpXIPhZXifOY4c+rOQjuijSMF804WNcgcBPvV/3H30sgXw1c6YWWIrMay/DxhgHyA0BqUDhsx+4idU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770543004; c=relaxed/simple;
	bh=Z5x2IZZZOEQASq3EeYXcIL16SOYHlah9WTR7/atJWoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pBDCKH9A0ESMwWvtaKV6sAt/a+Gh3WM1dNYbK7hyVG1UNgLDR+mdeMXX+JCyaVais9TR3b3dE9P9IdsX7ePCwAikzGupU7/q7Gqj3cpoEirC7gxrTYJBgP1NBrrBevKwO0wYVh6kQVI1ey/4R8DHQK7coKmyrZCFw+srkzleBzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TpITp/Ox; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TpITp/Ox"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770543003; x=1802079003;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z5x2IZZZOEQASq3EeYXcIL16SOYHlah9WTR7/atJWoA=;
  b=TpITp/OxvoZocIIjaHRHw/8F4Zywqr7WG8F+AEZmnlxttkUeyL3K0vjA
   a6ZVT5O4Gtnf7NPHt2KVfbbvwzQsTXOzWIHuu7tMmLqkYFaPhL3lwkWT1
   6aeOg2Z6r6zojHzuRdJQiDuKKXsfYWHA2YVmV/s/EyoscciyPj+nVLBWv
   6W0gjTTzceyRYuOsvPNiC8b9GzpN1ovKE8/3lUvdLoM9QsoeQCOXQskW4
   2YOJAc/u+yGc52HQ4Ru2WeS2BK9MV990zDdzlf1xZayzJDkHpyVLWhkkA
   VC4PaNTvlYQAFnDZOf2mFtoOi6EiBLnUyuSYOjJOEqGrMF3Tz1mQ+ZuNG
   Q==;
X-CSE-ConnectionGUID: qyCzIh5gTpKxOT6qs/zlIQ==
X-CSE-MsgGUID: cJwNDCiQQ8GJaJao31CVvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11694"; a="70701402"
X-IronPort-AV: E=Sophos;i="6.21,279,1763452800"; 
   d="scan'208";a="70701402"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2026 01:30:03 -0800
X-CSE-ConnectionGUID: VL51Pn54RSu9lSWGmdphSQ==
X-CSE-MsgGUID: OCYthuvQS6KWdfXjdZnTRQ==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 08 Feb 2026 01:29:59 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vp178-00000000m7g-4An0;
	Sun, 08 Feb 2026 09:29:58 +0000
Date: Sun, 8 Feb 2026 17:29:36 +0800
From: kernel test robot <lkp@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing: Clean up use of trace_create_maxlat_file()
Message-ID: <202602081759.QQ7Yu6SK-lkp@intel.com>
References: <20260207191101.0e014abd@robin>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260207191101.0e014abd@robin>

Hi Steven,

kernel test robot noticed the following build errors:

[auto build test ERROR on trace/for-next]
[also build test ERROR on linus/master v6.19-rc8 next-20260205]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Steven-Rostedt/tracing-Clean-up-use-of-trace_create_maxlat_file/20260208-081407
base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
patch link:    https://lore.kernel.org/r/20260207191101.0e014abd%40robin
patch subject: [PATCH] tracing: Clean up use of trace_create_maxlat_file()
config: arm-randconfig-r071-20260208 (https://download.01.org/0day-ci/archive/20260208/202602081759.QQ7Yu6SK-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.5.0
smatch version: v0.5.0-8994-gd50c5a4c
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260208/202602081759.QQ7Yu6SK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602081759.QQ7Yu6SK-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/trace/trace.c: In function 'trace_create_maxlat_file':
>> kernel/trace/trace.c:1967:13: error: 'struct trace_array' has no member named 'd_max_latency'; did you mean 'max_latency'?
    1967 |         tr->d_max_latency = trace_create_file("tracing_max_latency",
         |             ^~~~~~~~~~~~~
         |             max_latency


vim +1967 kernel/trace/trace.c

  1959	
  1960	static void trace_create_maxlat_file(struct trace_array *tr,
  1961					     struct dentry *d_tracer)
  1962	{
  1963	#ifdef LATENCY_FS_NOTIFY
  1964		INIT_WORK(&tr->fsnotify_work, latency_fsnotify_workfn);
  1965		init_irq_work(&tr->fsnotify_irqwork, latency_fsnotify_workfn_irq);
  1966	#endif
> 1967		tr->d_max_latency = trace_create_file("tracing_max_latency",
  1968						      TRACE_MODE_WRITE,
  1969						      d_tracer, tr,
  1970						      &tracing_max_lat_fops);
  1971	}
  1972	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
