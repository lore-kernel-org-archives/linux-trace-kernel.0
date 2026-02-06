Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422AF1C860B;
	Fri,  6 Feb 2026 22:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770417023; cv=none; b=l4H0ytk1ZklpnbqZVvSpEl0Y2rWHf9tu7kf1skhc1vrMhKtXGmEtQu/bzm2LHYyRgEziksnOWvFmt/kNkSTwVar7Tc+/5x7ja3f+RYVtaA910RTFWx/z7log1JEyHIqvjOCR6DHjZCasGwkjiLXIBI5ZS/TxUppBvaH/QuZi+7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770417023; c=relaxed/simple;
	bh=qQz1lJxbHFJYK6YEi8d1UzFeguIE8CBoKb7VxChCMhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mfhx/9xSX3oyrbK4YfnXbwxCHiotyw2cD+sAxRoDQH98aJjIcLL6y7t2Gchw1/IDI90On7HpamNKDe6M+WztqW+A4flwNkXEDIdD1CS1qbL93cQBjmCxpdeZ6eoN+mKXsE6HYqV/n8X4K1wd1hB6Ynizs20F9a9//aR0K0Y14O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TW5v44Lz; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TW5v44Lz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770417023; x=1801953023;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qQz1lJxbHFJYK6YEi8d1UzFeguIE8CBoKb7VxChCMhg=;
  b=TW5v44LzaEma1YVvftHrIAkSf2megqGt1lI1bR1hQ17Qr5lFUImJadNc
   zKVlNiLty0zALrEKmnfgSJBYX2MN/hiG7gkf16j3O31yem7XSsLvLsHko
   GCZ+ZBniwISoAhWLS6RLC/jghJgF1qDiD4TH69YzSWaka1g9yYePt5Fm6
   mUqnQKmWKRThcVPVXH5NByYzc4sMIrl+Z3DzLdl1NTdZVJKg/3W0fqvTK
   1yQB4V5kzMivUlVC0ReK6gwTP7Fzxpv8qTXksq6olICZORG1xVd5CnrHS
   mCxo9wRyxNa7bubzAHALaabbyNaT/1/VyDMXjaKDjABCEB23vuNOf1/cb
   A==;
X-CSE-ConnectionGUID: a+qqe39TRGeOOlC6gyvK6w==
X-CSE-MsgGUID: 6lVPOJmeTlurT2rcLbYdhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11693"; a="81948984"
X-IronPort-AV: E=Sophos;i="6.21,277,1763452800"; 
   d="scan'208";a="81948984"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2026 14:30:22 -0800
X-CSE-ConnectionGUID: JFpMcPPyQhunG/mdUJfDSQ==
X-CSE-MsgGUID: gDao07hrRaO4Q+Tgb2fufA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,277,1763452800"; 
   d="scan'208";a="210758584"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 06 Feb 2026 14:30:19 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1voULB-00000000lDQ-2b2C;
	Fri, 06 Feb 2026 22:30:17 +0000
Date: Sat, 7 Feb 2026 06:29:38 +0800
From: kernel test robot <lkp@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing: Clean up use of trace_create_maxlat_file()
Message-ID: <202602070646.8BvnJR99-lkp@intel.com>
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
config: hexagon-randconfig-r072-20260207 (https://download.01.org/0day-ci/archive/20260207/202602070646.8BvnJR99-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 9b8addffa70cee5b2acc5454712d9cf78ce45710)
smatch version: v0.5.0-8994-gd50c5a4c
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260207/202602070646.8BvnJR99-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602070646.8BvnJR99-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/trace/trace.c:10685:2: error: call to undeclared function 'trace_create_maxlat_file'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    10685 |         trace_create_maxlat_file(tr, d_tracer);
          |         ^
   kernel/trace/trace.c:10685:2: note: did you mean 'trace_create_eval_file'?
   kernel/trace/trace.c:5934:20: note: 'trace_create_eval_file' declared here
    5934 | static inline void trace_create_eval_file(struct dentry *d_tracer) { }
         |                    ^
   1 error generated.


vim +/trace_create_maxlat_file +10685 kernel/trace/trace.c

277ba04461c2746 Steven Rostedt              2012-08-03  10622  
2b6080f28c7cc3e Steven Rostedt              2012-05-11  10623  static void
8434dc9340cd2e1 Steven Rostedt (Red Hat     2015-01-20  10624) init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
2b6080f28c7cc3e Steven Rostedt              2012-05-11  10625  {
121aaee7b0a8260 Steven Rostedt (Red Hat     2013-03-05  10626) 	int cpu;
2b6080f28c7cc3e Steven Rostedt              2012-05-11  10627  
21ccc9cd7211628 Steven Rostedt (VMware      2021-08-18  10628) 	trace_create_file("available_tracers", TRACE_MODE_READ, d_tracer,
607e2ea167e56db Steven Rostedt (Red Hat     2013-11-06  10629) 			tr, &show_traces_fops);
607e2ea167e56db Steven Rostedt (Red Hat     2013-11-06  10630) 
21ccc9cd7211628 Steven Rostedt (VMware      2021-08-18  10631) 	trace_create_file("current_tracer", TRACE_MODE_WRITE, d_tracer,
607e2ea167e56db Steven Rostedt (Red Hat     2013-11-06  10632) 			tr, &set_tracer_fops);
607e2ea167e56db Steven Rostedt (Red Hat     2013-11-06  10633) 
21ccc9cd7211628 Steven Rostedt (VMware      2021-08-18  10634) 	trace_create_file("tracing_cpumask", TRACE_MODE_WRITE, d_tracer,
ccfe9e42e451232 Alexander Z Lam             2013-08-08  10635  			  tr, &tracing_cpumask_fops);
ccfe9e42e451232 Alexander Z Lam             2013-08-08  10636  
21ccc9cd7211628 Steven Rostedt (VMware      2021-08-18  10637) 	trace_create_file("trace_options", TRACE_MODE_WRITE, d_tracer,
2b6080f28c7cc3e Steven Rostedt              2012-05-11  10638  			  tr, &tracing_iter_fops);
2b6080f28c7cc3e Steven Rostedt              2012-05-11  10639  
21ccc9cd7211628 Steven Rostedt (VMware      2021-08-18  10640) 	trace_create_file("trace", TRACE_MODE_WRITE, d_tracer,
6484c71cbc17063 Oleg Nesterov               2013-07-23  10641  			  tr, &tracing_fops);
2b6080f28c7cc3e Steven Rostedt              2012-05-11  10642  
21ccc9cd7211628 Steven Rostedt (VMware      2021-08-18  10643) 	trace_create_file("trace_pipe", TRACE_MODE_READ, d_tracer,
15544209cb0b531 Oleg Nesterov               2013-07-23  10644  			  tr, &tracing_pipe_fops);
2b6080f28c7cc3e Steven Rostedt              2012-05-11  10645  
21ccc9cd7211628 Steven Rostedt (VMware      2021-08-18  10646) 	trace_create_file("buffer_size_kb", TRACE_MODE_WRITE, d_tracer,
0bc392ee46d0fd8 Oleg Nesterov               2013-07-23  10647  			  tr, &tracing_entries_fops);
2b6080f28c7cc3e Steven Rostedt              2012-05-11  10648  
21ccc9cd7211628 Steven Rostedt (VMware      2021-08-18  10649) 	trace_create_file("buffer_total_size_kb", TRACE_MODE_READ, d_tracer,
2b6080f28c7cc3e Steven Rostedt              2012-05-11  10650  			  tr, &tracing_total_entries_fops);
2b6080f28c7cc3e Steven Rostedt              2012-05-11  10651  
238ae93d699d598 Wang YanQing                2013-05-26  10652  	trace_create_file("free_buffer", 0200, d_tracer,
2b6080f28c7cc3e Steven Rostedt              2012-05-11  10653  			  tr, &tracing_free_buffer_fops);
2b6080f28c7cc3e Steven Rostedt              2012-05-11  10654  
2b6080f28c7cc3e Steven Rostedt              2012-05-11  10655  	trace_create_file("trace_marker", 0220, d_tracer,
2b6080f28c7cc3e Steven Rostedt              2012-05-11  10656  			  tr, &tracing_mark_fops);
2b6080f28c7cc3e Steven Rostedt              2012-05-11  10657  
5790b1fb3d672d9 Steven Rostedt (Google      2023-10-04  10658) 	tr->trace_marker_file = __find_event_file(tr, "ftrace", "print");
3dd8095368475a9 Steven Rostedt (VMware      2018-05-09  10659) 
fa32e8557b470f5 Steven Rostedt              2016-07-06  10660  	trace_create_file("trace_marker_raw", 0220, d_tracer,
fa32e8557b470f5 Steven Rostedt              2016-07-06  10661  			  tr, &tracing_mark_raw_fops);
fa32e8557b470f5 Steven Rostedt              2016-07-06  10662  
21ccc9cd7211628 Steven Rostedt (VMware      2021-08-18  10663) 	trace_create_file("trace_clock", TRACE_MODE_WRITE, d_tracer, tr,
2b6080f28c7cc3e Steven Rostedt              2012-05-11  10664  			  &trace_clock_fops);
2b6080f28c7cc3e Steven Rostedt              2012-05-11  10665  
21ccc9cd7211628 Steven Rostedt (VMware      2021-08-18  10666) 	trace_create_file("tracing_on", TRACE_MODE_WRITE, d_tracer,
2b6080f28c7cc3e Steven Rostedt              2012-05-11  10667  			  tr, &rb_simple_fops);
ce9bae55972b228 Steven Rostedt (Red Hat     2013-03-05  10668) 
21ccc9cd7211628 Steven Rostedt (VMware      2021-08-18  10669) 	trace_create_file("timestamp_mode", TRACE_MODE_READ, d_tracer, tr,
2c1ea60b195da6c Tom Zanussi                 2018-01-15  10670  			  &trace_time_stamp_mode_fops);
2c1ea60b195da6c Tom Zanussi                 2018-01-15  10671  
a7b1d74e872a429 Steven Rostedt (VMware      2018-11-29  10672) 	tr->buffer_percent = 50;
03329f993978104 Steven Rostedt (VMware      2018-11-29  10673) 
4f94559f40ad06d Ondrej Mosnacek             2023-05-03  10674  	trace_create_file("buffer_percent", TRACE_MODE_WRITE, d_tracer,
03329f993978104 Steven Rostedt (VMware      2018-11-29  10675) 			tr, &buffer_percent_fops);
03329f993978104 Steven Rostedt (VMware      2018-11-29  10676) 
2f84b39f4847661 Steven Rostedt (Google      2023-12-19  10677) 	trace_create_file("buffer_subbuf_size_kb", TRACE_MODE_WRITE, d_tracer,
2f84b39f4847661 Steven Rostedt (Google      2023-12-19  10678) 			  tr, &buffer_subbuf_size_fops);
2808e31ec12e5fb Tzvetomir Stoyanov (VMware  2023-12-19  10679) 
299ea67e6a2b3d0 Steven Rostedt              2025-10-28  10680  	trace_create_file("syscall_user_buf_size", TRACE_MODE_WRITE, d_tracer,
299ea67e6a2b3d0 Steven Rostedt              2025-10-28  10681  			 tr, &tracing_syscall_buf_fops);
299ea67e6a2b3d0 Steven Rostedt              2025-10-28  10682  
16270145ce6b907 Steven Rostedt (Red Hat     2015-09-30  10683) 	create_trace_options_dir(tr);
16270145ce6b907 Steven Rostedt (Red Hat     2015-09-30  10684) 
91edde2e6ae1dd5 Viktor Rosendahl (BMW       2019-10-09 @10685) 	trace_create_maxlat_file(tr, d_tracer);
6d9b3fa5e7f663b Steven Rostedt (Red Hat     2014-01-14  10686) 
591dffdade9f076 Steven Rostedt (Red Hat     2014-01-10  10687) 	if (ftrace_create_function_files(tr, d_tracer))
24589e3a20876dc Steven Rostedt (VMware      2020-01-25  10688) 		MEM_FAIL(1, "Could not allocate function filter files");
591dffdade9f076 Steven Rostedt (Red Hat     2014-01-10  10689) 
7a1d1e4b9639ff0 Steven Rostedt (Google      2024-06-12  10690) 	if (tr->range_addr_start) {
7a1d1e4b9639ff0 Steven Rostedt (Google      2024-06-12  10691) 		trace_create_file("last_boot_info", TRACE_MODE_READ, d_tracer,
7a1d1e4b9639ff0 Steven Rostedt (Google      2024-06-12  10692) 				  tr, &last_boot_fops);
ce9bae55972b228 Steven Rostedt (Red Hat     2013-03-05  10693) #ifdef CONFIG_TRACER_SNAPSHOT
7a1d1e4b9639ff0 Steven Rostedt (Google      2024-06-12  10694) 	} else {
21ccc9cd7211628 Steven Rostedt (VMware      2021-08-18  10695) 		trace_create_file("snapshot", TRACE_MODE_WRITE, d_tracer,
6484c71cbc17063 Oleg Nesterov               2013-07-23  10696  				  tr, &snapshot_fops);
ce9bae55972b228 Steven Rostedt (Red Hat     2013-03-05  10697) #endif
6d02eefecc5e388 Steven Rostedt              2024-07-19  10698  	}
121aaee7b0a8260 Steven Rostedt (Red Hat     2013-03-05  10699) 
21ccc9cd7211628 Steven Rostedt (VMware      2021-08-18  10700) 	trace_create_file("error_log", TRACE_MODE_WRITE, d_tracer,
8a062902be725f6 Tom Zanussi                 2019-03-31  10701  			  tr, &tracing_err_log_fops);
8a062902be725f6 Tom Zanussi                 2019-03-31  10702  
121aaee7b0a8260 Steven Rostedt (Red Hat     2013-03-05  10703) 	for_each_tracing_cpu(cpu)
8434dc9340cd2e1 Steven Rostedt (Red Hat     2015-01-20  10704) 		tracing_init_tracefs_percpu(tr, cpu);
121aaee7b0a8260 Steven Rostedt (Red Hat     2013-03-05  10705) 
345ddcc882d8896 Steven Rostedt (Red Hat     2016-04-22  10706) 	ftrace_init_tracefs(tr, d_tracer);
2b6080f28c7cc3e Steven Rostedt              2012-05-11  10707  }
2b6080f28c7cc3e Steven Rostedt              2012-05-11  10708  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
