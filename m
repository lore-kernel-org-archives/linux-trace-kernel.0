Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8EA18FC97;
	Sat,  7 Feb 2026 01:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770426987; cv=none; b=GJI2Zi/dHJ+tyEF4X4D/nhl80H+nSj2ZYsWqi2pM4QyykHsWeo05f5RZNdJzlItWlhLk3YL/NYsGgyg3ff+zl59+7q2IVQFypdE2wCGoQojdk3HnVkKC+TEsZbsJLep9zBv+Fzeq7qfh12v9xKDU1u7jzFTtxRFgyZDk1JsDEv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770426987; c=relaxed/simple;
	bh=2DPpUKfUaFkU+JgLYcp/JGkcpGTHiGmPy8sIqy12fFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sjGXwk/X/n7jQzk9oZyR9ky4mvTa0RYJ/2QjFsO7c7EHt3Zqdm7KxRcj60UscfsUF0oulJ1zVy0kFanaE5JtXP3SHvPhwSrKCFERACU7VH5rwEKR8QIQXOR0Iad6aDkU4KofhPp+Xfkgt+QZkJDDE6x7GNPpPykbo1+Cee6CAwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mKNrslKd; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mKNrslKd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770426987; x=1801962987;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2DPpUKfUaFkU+JgLYcp/JGkcpGTHiGmPy8sIqy12fFw=;
  b=mKNrslKd93V2QBKA/AdcYRDvsiDFSBYH54/zlke2aN2weWUFFeya2E9e
   ZiHapwKrFz+NOJCgo7rF/1gKc28I+4i/IUEs0lRneprDw70GyNilhvgA8
   U09Hriteei+oPkr45ypplI9QHejsYdpxRKTc/xWj/6OVlJ54QehuEDCdK
   rUPPXAz//XFtibKdbzfw43AyMySk9jk0D+EMtcfRtjm3PR/bD5RY/lUTO
   Ce7DzqV98PYmv4atdej0VVyq14qHW+YeqjUYlhb0buMv96K/Q30gTmizL
   biqnlUezCYdGqBVg9T8lG0cF0ZddM5fWOTVDZd91gp3RbJCKtU3F99fZ9
   Q==;
X-CSE-ConnectionGUID: w4Pejc6ASs2qFHnyelbdVQ==
X-CSE-MsgGUID: fSwG0PewTzO7kChSx770Rg==
X-IronPort-AV: E=McAfee;i="6800,10657,11693"; a="75488189"
X-IronPort-AV: E=Sophos;i="6.21,277,1763452800"; 
   d="scan'208";a="75488189"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2026 17:16:26 -0800
X-CSE-ConnectionGUID: 4qbCfSMPQQOoZJUPoraCgg==
X-CSE-MsgGUID: dqjkrlzkSiSgQ37rq8lG3Q==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 06 Feb 2026 17:16:24 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1voWvu-00000000lJE-1uRN;
	Sat, 07 Feb 2026 01:16:22 +0000
Date: Sat, 7 Feb 2026 09:15:49 +0800
From: kernel test robot <lkp@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing: Clean up use of trace_create_maxlat_file()
Message-ID: <202602070942.sq5fv24P-lkp@intel.com>
References: <20260206121242.6cb1934d@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206121242.6cb1934d@gandalf.local.home>

Hi Steven,

kernel test robot noticed the following build errors:

[auto build test ERROR on trace/for-next]
[also build test ERROR on linus/master v6.19-rc8 next-20260205]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Steven-Rostedt/tracing-Clean-up-use-of-trace_create_maxlat_file/20260207-011515
base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
patch link:    https://lore.kernel.org/r/20260206121242.6cb1934d%40gandalf.local.home
patch subject: [PATCH] tracing: Clean up use of trace_create_maxlat_file()
config: arm-randconfig-001-20260207 (https://download.01.org/0day-ci/archive/20260207/202602070942.sq5fv24P-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260207/202602070942.sq5fv24P-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602070942.sq5fv24P-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/trace/trace.c: In function 'init_tracer_tracefs':
>> kernel/trace/trace.c:10685:2: error: implicit declaration of function 'trace_create_maxlat_file'; did you mean 'trace_create_eval_file'? [-Werror=implicit-function-declaration]
   10685 |  trace_create_maxlat_file(tr, d_tracer);
         |  ^~~~~~~~~~~~~~~~~~~~~~~~
         |  trace_create_eval_file
   cc1: some warnings being treated as errors


vim +10685 kernel/trace/trace.c

277ba04461c274 Steven Rostedt              2012-08-03  10622  
2b6080f28c7cc3 Steven Rostedt              2012-05-11  10623  static void
8434dc9340cd2e Steven Rostedt (Red Hat     2015-01-20  10624) init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
2b6080f28c7cc3 Steven Rostedt              2012-05-11  10625  {
121aaee7b0a826 Steven Rostedt (Red Hat     2013-03-05  10626) 	int cpu;
2b6080f28c7cc3 Steven Rostedt              2012-05-11  10627  
21ccc9cd721162 Steven Rostedt (VMware      2021-08-18  10628) 	trace_create_file("available_tracers", TRACE_MODE_READ, d_tracer,
607e2ea167e56d Steven Rostedt (Red Hat     2013-11-06  10629) 			tr, &show_traces_fops);
607e2ea167e56d Steven Rostedt (Red Hat     2013-11-06  10630) 
21ccc9cd721162 Steven Rostedt (VMware      2021-08-18  10631) 	trace_create_file("current_tracer", TRACE_MODE_WRITE, d_tracer,
607e2ea167e56d Steven Rostedt (Red Hat     2013-11-06  10632) 			tr, &set_tracer_fops);
607e2ea167e56d Steven Rostedt (Red Hat     2013-11-06  10633) 
21ccc9cd721162 Steven Rostedt (VMware      2021-08-18  10634) 	trace_create_file("tracing_cpumask", TRACE_MODE_WRITE, d_tracer,
ccfe9e42e45123 Alexander Z Lam             2013-08-08  10635  			  tr, &tracing_cpumask_fops);
ccfe9e42e45123 Alexander Z Lam             2013-08-08  10636  
21ccc9cd721162 Steven Rostedt (VMware      2021-08-18  10637) 	trace_create_file("trace_options", TRACE_MODE_WRITE, d_tracer,
2b6080f28c7cc3 Steven Rostedt              2012-05-11  10638  			  tr, &tracing_iter_fops);
2b6080f28c7cc3 Steven Rostedt              2012-05-11  10639  
21ccc9cd721162 Steven Rostedt (VMware      2021-08-18  10640) 	trace_create_file("trace", TRACE_MODE_WRITE, d_tracer,
6484c71cbc1706 Oleg Nesterov               2013-07-23  10641  			  tr, &tracing_fops);
2b6080f28c7cc3 Steven Rostedt              2012-05-11  10642  
21ccc9cd721162 Steven Rostedt (VMware      2021-08-18  10643) 	trace_create_file("trace_pipe", TRACE_MODE_READ, d_tracer,
15544209cb0b53 Oleg Nesterov               2013-07-23  10644  			  tr, &tracing_pipe_fops);
2b6080f28c7cc3 Steven Rostedt              2012-05-11  10645  
21ccc9cd721162 Steven Rostedt (VMware      2021-08-18  10646) 	trace_create_file("buffer_size_kb", TRACE_MODE_WRITE, d_tracer,
0bc392ee46d0fd Oleg Nesterov               2013-07-23  10647  			  tr, &tracing_entries_fops);
2b6080f28c7cc3 Steven Rostedt              2012-05-11  10648  
21ccc9cd721162 Steven Rostedt (VMware      2021-08-18  10649) 	trace_create_file("buffer_total_size_kb", TRACE_MODE_READ, d_tracer,
2b6080f28c7cc3 Steven Rostedt              2012-05-11  10650  			  tr, &tracing_total_entries_fops);
2b6080f28c7cc3 Steven Rostedt              2012-05-11  10651  
238ae93d699d59 Wang YanQing                2013-05-26  10652  	trace_create_file("free_buffer", 0200, d_tracer,
2b6080f28c7cc3 Steven Rostedt              2012-05-11  10653  			  tr, &tracing_free_buffer_fops);
2b6080f28c7cc3 Steven Rostedt              2012-05-11  10654  
2b6080f28c7cc3 Steven Rostedt              2012-05-11  10655  	trace_create_file("trace_marker", 0220, d_tracer,
2b6080f28c7cc3 Steven Rostedt              2012-05-11  10656  			  tr, &tracing_mark_fops);
2b6080f28c7cc3 Steven Rostedt              2012-05-11  10657  
5790b1fb3d672d Steven Rostedt (Google      2023-10-04  10658) 	tr->trace_marker_file = __find_event_file(tr, "ftrace", "print");
3dd8095368475a Steven Rostedt (VMware      2018-05-09  10659) 
fa32e8557b470f Steven Rostedt              2016-07-06  10660  	trace_create_file("trace_marker_raw", 0220, d_tracer,
fa32e8557b470f Steven Rostedt              2016-07-06  10661  			  tr, &tracing_mark_raw_fops);
fa32e8557b470f Steven Rostedt              2016-07-06  10662  
21ccc9cd721162 Steven Rostedt (VMware      2021-08-18  10663) 	trace_create_file("trace_clock", TRACE_MODE_WRITE, d_tracer, tr,
2b6080f28c7cc3 Steven Rostedt              2012-05-11  10664  			  &trace_clock_fops);
2b6080f28c7cc3 Steven Rostedt              2012-05-11  10665  
21ccc9cd721162 Steven Rostedt (VMware      2021-08-18  10666) 	trace_create_file("tracing_on", TRACE_MODE_WRITE, d_tracer,
2b6080f28c7cc3 Steven Rostedt              2012-05-11  10667  			  tr, &rb_simple_fops);
ce9bae55972b22 Steven Rostedt (Red Hat     2013-03-05  10668) 
21ccc9cd721162 Steven Rostedt (VMware      2021-08-18  10669) 	trace_create_file("timestamp_mode", TRACE_MODE_READ, d_tracer, tr,
2c1ea60b195da6 Tom Zanussi                 2018-01-15  10670  			  &trace_time_stamp_mode_fops);
2c1ea60b195da6 Tom Zanussi                 2018-01-15  10671  
a7b1d74e872a42 Steven Rostedt (VMware      2018-11-29  10672) 	tr->buffer_percent = 50;
03329f99397810 Steven Rostedt (VMware      2018-11-29  10673) 
4f94559f40ad06 Ondrej Mosnacek             2023-05-03  10674  	trace_create_file("buffer_percent", TRACE_MODE_WRITE, d_tracer,
03329f99397810 Steven Rostedt (VMware      2018-11-29  10675) 			tr, &buffer_percent_fops);
03329f99397810 Steven Rostedt (VMware      2018-11-29  10676) 
2f84b39f484766 Steven Rostedt (Google      2023-12-19  10677) 	trace_create_file("buffer_subbuf_size_kb", TRACE_MODE_WRITE, d_tracer,
2f84b39f484766 Steven Rostedt (Google      2023-12-19  10678) 			  tr, &buffer_subbuf_size_fops);
2808e31ec12e5f Tzvetomir Stoyanov (VMware  2023-12-19  10679) 
299ea67e6a2b3d Steven Rostedt              2025-10-28  10680  	trace_create_file("syscall_user_buf_size", TRACE_MODE_WRITE, d_tracer,
299ea67e6a2b3d Steven Rostedt              2025-10-28  10681  			 tr, &tracing_syscall_buf_fops);
299ea67e6a2b3d Steven Rostedt              2025-10-28  10682  
16270145ce6b90 Steven Rostedt (Red Hat     2015-09-30  10683) 	create_trace_options_dir(tr);
16270145ce6b90 Steven Rostedt (Red Hat     2015-09-30  10684) 
91edde2e6ae1dd Viktor Rosendahl (BMW       2019-10-09 @10685) 	trace_create_maxlat_file(tr, d_tracer);
6d9b3fa5e7f663 Steven Rostedt (Red Hat     2014-01-14  10686) 
591dffdade9f07 Steven Rostedt (Red Hat     2014-01-10  10687) 	if (ftrace_create_function_files(tr, d_tracer))
24589e3a20876d Steven Rostedt (VMware      2020-01-25  10688) 		MEM_FAIL(1, "Could not allocate function filter files");
591dffdade9f07 Steven Rostedt (Red Hat     2014-01-10  10689) 
7a1d1e4b9639ff Steven Rostedt (Google      2024-06-12  10690) 	if (tr->range_addr_start) {
7a1d1e4b9639ff Steven Rostedt (Google      2024-06-12  10691) 		trace_create_file("last_boot_info", TRACE_MODE_READ, d_tracer,
7a1d1e4b9639ff Steven Rostedt (Google      2024-06-12  10692) 				  tr, &last_boot_fops);
ce9bae55972b22 Steven Rostedt (Red Hat     2013-03-05  10693) #ifdef CONFIG_TRACER_SNAPSHOT
7a1d1e4b9639ff Steven Rostedt (Google      2024-06-12  10694) 	} else {
21ccc9cd721162 Steven Rostedt (VMware      2021-08-18  10695) 		trace_create_file("snapshot", TRACE_MODE_WRITE, d_tracer,
6484c71cbc1706 Oleg Nesterov               2013-07-23  10696  				  tr, &snapshot_fops);
ce9bae55972b22 Steven Rostedt (Red Hat     2013-03-05  10697) #endif
6d02eefecc5e38 Steven Rostedt              2024-07-19  10698  	}
121aaee7b0a826 Steven Rostedt (Red Hat     2013-03-05  10699) 
21ccc9cd721162 Steven Rostedt (VMware      2021-08-18  10700) 	trace_create_file("error_log", TRACE_MODE_WRITE, d_tracer,
8a062902be725f Tom Zanussi                 2019-03-31  10701  			  tr, &tracing_err_log_fops);
8a062902be725f Tom Zanussi                 2019-03-31  10702  
121aaee7b0a826 Steven Rostedt (Red Hat     2013-03-05  10703) 	for_each_tracing_cpu(cpu)
8434dc9340cd2e Steven Rostedt (Red Hat     2015-01-20  10704) 		tracing_init_tracefs_percpu(tr, cpu);
121aaee7b0a826 Steven Rostedt (Red Hat     2013-03-05  10705) 
345ddcc882d889 Steven Rostedt (Red Hat     2016-04-22  10706) 	ftrace_init_tracefs(tr, d_tracer);
2b6080f28c7cc3 Steven Rostedt              2012-05-11  10707  }
2b6080f28c7cc3 Steven Rostedt              2012-05-11  10708  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
