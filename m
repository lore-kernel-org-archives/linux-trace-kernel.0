Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BBF2765E2;
	Wed, 24 Sep 2025 09:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758707423; cv=none; b=JVOzU+VwAE6BCdXZDCZFExyfket7aot8VhqSWM2odbsPWBY8qQ6PA0mWkmy9rYqT8/uIq9iKSf8f+GA8Y5dKoDhZzkVTHWhmsEVRPTDRxlTSeuEDKpnjs/zw5dqF9QcF6RuVDt9Rhl5mErCJEDHO0r9y74tqLWzOSRM9cDs9cbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758707423; c=relaxed/simple;
	bh=fkLjEPUde/BCOSe6yVlFN8pwS/oHwwImtIyGcjmkrfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ckmtc+naeC5XEdneK41fJfrADeKCTuOg6BaJYu7/fjtEHXLgnv+3v/E0fEgiQTBb/rjMfq28e9RfR9l08crRC7UaFq2Q4GkNjJ1yBfSmr9OpUVtKJhcubqWFDi16hr3OHVVYtGR/mbjvegalrf16O0kXBtOl0sL4RGx+LjUzSaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KHVYGEeQ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KHVYGEeQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758707418; x=1790243418;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fkLjEPUde/BCOSe6yVlFN8pwS/oHwwImtIyGcjmkrfY=;
  b=KHVYGEeQ7TevxWnSOgsoMRiONYG8VkQziiiPZmdrzZ1J//p6miZ72Z5K
   3/LM5rVpkveIVx466JR7eus0rAay6rN1Zgc0I4Xfk5B3bvYPN7Q8Sd/tW
   c2xKCDYGi/16h962D3yXqsTf+qvQWDNQABDgZQL73Qp2f5QGQuCGIgYwh
   cy4Z5SC/pw96vKGH0Le6Wt3CRX2frQ+xZUKq1kOYDClF4MTvUosqf2r7B
   3FY2LQh6NAQ/uQDjZY30shPhCCfZdTadjQIYqcMT6n6QKdCgaA7y7Av/Z
   UZG7rFWO/UQc6rAZEXNwSX6HAr9NUMOI8G3MrLJOzj+RDvgPRiOMi3YKN
   Q==;
X-CSE-ConnectionGUID: Ig+IdgCpTcyYhADU+0NALQ==
X-CSE-MsgGUID: 8QKMgtfvTEKR8iRz5RMsNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="64838716"
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="64838716"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 02:50:17 -0700
X-CSE-ConnectionGUID: FUSXk/+JSgmzq06LQGCeZw==
X-CSE-MsgGUID: ph54oh55TcehMfikD49uFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="177769371"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 24 Sep 2025 02:50:13 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v1M8R-000413-1s;
	Wed, 24 Sep 2025 09:50:08 +0000
Date: Wed, 24 Sep 2025 17:49:46 +0800
From: kernel test robot <lkp@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Takaya Saeki <takayas@google.com>, Tom Zanussi <zanussi@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ian Rogers <irogers@google.com>,
	Douglas Raillard <douglas.raillard@arm.com>
Subject: Re: [PATCH v2 7/8] tracing: Add syscall_user_buf_size to limit
 amount written
Message-ID: <202509241709.5vLMGNLe-lkp@intel.com>
References: <20250923130714.603760198@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923130714.603760198@kernel.org>

Hi Steven,

kernel test robot noticed the following build errors:

[auto build test ERROR on trace/for-next]
[also build test ERROR on linus/master v6.17-rc7 next-20250923]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Steven-Rostedt/tracing-Replace-syscall-RCU-pointer-assignment-with-READ-WRITE_ONCE/20250923-210948
base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
patch link:    https://lore.kernel.org/r/20250923130714.603760198%40kernel.org
patch subject: [PATCH v2 7/8] tracing: Add syscall_user_buf_size to limit amount written
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20250924/202509241709.5vLMGNLe-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250924/202509241709.5vLMGNLe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509241709.5vLMGNLe-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/trace/trace.c:11128:32: error: use of undeclared identifier 'CONFIG_TRACE_SYSCALL_BUF_SIZE_DEFAULT'
    11128 |         global_trace.syscall_buf_sz = CONFIG_TRACE_SYSCALL_BUF_SIZE_DEFAULT;
          |                                       ^
   1 error generated.


vim +/CONFIG_TRACE_SYSCALL_BUF_SIZE_DEFAULT +11128 kernel/trace/trace.c

 11110	
 11111		init_trace_flags_index(&global_trace);
 11112	
 11113		register_tracer(&nop_trace);
 11114	
 11115		/* Function tracing may start here (via kernel command line) */
 11116		init_function_trace();
 11117	
 11118		/* All seems OK, enable tracing */
 11119		tracing_disabled = 0;
 11120	
 11121		atomic_notifier_chain_register(&panic_notifier_list,
 11122					       &trace_panic_notifier);
 11123	
 11124		register_die_notifier(&trace_die_notifier);
 11125	
 11126		global_trace.flags = TRACE_ARRAY_FL_GLOBAL;
 11127	
 11128		global_trace.syscall_buf_sz = CONFIG_TRACE_SYSCALL_BUF_SIZE_DEFAULT;
 11129	
 11130		INIT_LIST_HEAD(&global_trace.systems);
 11131		INIT_LIST_HEAD(&global_trace.events);
 11132		INIT_LIST_HEAD(&global_trace.hist_vars);
 11133		INIT_LIST_HEAD(&global_trace.err_log);
 11134		list_add(&global_trace.marker_list, &marker_copies);
 11135		list_add(&global_trace.list, &ftrace_trace_arrays);
 11136	
 11137		apply_trace_boot_options();
 11138	
 11139		register_snapshot_cmd();
 11140	
 11141		return 0;
 11142	
 11143	out_free_pipe_cpumask:
 11144		free_cpumask_var(global_trace.pipe_cpumask);
 11145	out_free_savedcmd:
 11146		trace_free_saved_cmdlines_buffer();
 11147	out_free_temp_buffer:
 11148		ring_buffer_free(temp_buffer);
 11149	out_rm_hp_state:
 11150		cpuhp_remove_multi_state(CPUHP_TRACE_RB_PREPARE);
 11151	out_free_cpumask:
 11152		free_cpumask_var(global_trace.tracing_cpumask);
 11153	out_free_buffer_mask:
 11154		free_cpumask_var(tracing_buffer_mask);
 11155		return ret;
 11156	}
 11157	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
