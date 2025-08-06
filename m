Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DA8944F;
	Wed,  6 Aug 2025 14:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754491867; cv=none; b=rWmSIdAOsCOkVKZI9QUYmmABfysxx4UCPy32b6mFqKw8HvLPJPesSLTecUT4aQ0dcIrUgiJ4RFrLPMaGuLLxjPwM4dG3Ec/gN6MalU3/PQ44tWNcGAPrTUG7C8LWG2FAlZUB7akFipgYfGvZ6EOKgxWqiMeeydX7B7Tg+ebYZnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754491867; c=relaxed/simple;
	bh=jYOf2US5bWDo7NlujX8N73KHv16qVgm8SXDzuRBuNuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ao9/cRvyR0L8kzMqblCIFYGP6PZAOGdkzH7d2ye6hhmynw9N94o5WYjZR3syhSbsG2rjr1QG6ez1MBSvJrIzutE+kmw/LSoS1qVBF7DvUaQhOEl+c6GsSJnqBo9WzYEcNnoW3arD9pNo5NkJS7kQzTq0RBGfZSTfm1xsgkBXBvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fgY0F7ht; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fgY0F7ht"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754491866; x=1786027866;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jYOf2US5bWDo7NlujX8N73KHv16qVgm8SXDzuRBuNuI=;
  b=fgY0F7htysJ76xADQTIm37ixlrod3hVQ9/cI+9p29UyoFyJLq0idjAE3
   hga88jI70l3nKx0IlMvgYRk5SKIUhjbAFLltD+P3XmdTzFnp7IgeNFUUz
   eriv+xWb7FR9paDHPwCGe9z86IOe/pquN0+R1suWWYCVy8bDTruO4EBZ7
   nrL50ns++tJeV0NsaJ3Xw8Qa6yboOTZp0rfbHR4Y7eblutls83Dg8d3OM
   gxJgnJmtYdHevDwFNg2ebYm6UCWqk3Qu09rtR6uIxEPv7gmsbOgF3P2sW
   mmMiwFouxQNNUY0sNpyAHxE3tyh4STRUqkIIt00l9F+ezUUGP61IygEGy
   A==;
X-CSE-ConnectionGUID: lKoal4YPSYq5+U6jixQrjA==
X-CSE-MsgGUID: +Qclt1ThRCCqcQ3q98MP3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="67078669"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="67078669"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 07:51:05 -0700
X-CSE-ConnectionGUID: XH6+x08qTfGWxhF0zUB9XA==
X-CSE-MsgGUID: acmb15dRTzSsSmXqlb9RyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="165567416"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 06 Aug 2025 07:51:01 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ujfTn-0001n8-00;
	Wed, 06 Aug 2025 14:50:59 +0000
Date: Wed, 6 Aug 2025 22:50:14 +0800
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
	Ian Rogers <irogers@google.com>, aahringo@redhat.com,
	Douglas Raillard <douglas.raillard@arm.com>
Subject: Re: [PATCH 7/7] tracing: Add syscall_user_buf_size to limit amount
 written
Message-ID: <202508062211.cwYqtLu0-lkp@intel.com>
References: <20250805193235.747004484@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805193235.747004484@kernel.org>

Hi Steven,

kernel test robot noticed the following build errors:

[auto build test ERROR on trace/for-next]
[also build test ERROR on linus/master v6.16 next-20250806]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Steven-Rostedt/tracing-Replace-syscall-RCU-pointer-assignment-with-READ-WRITE_ONCE/20250806-122312
base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
patch link:    https://lore.kernel.org/r/20250805193235.747004484%40kernel.org
patch subject: [PATCH 7/7] tracing: Add syscall_user_buf_size to limit amount written
config: hexagon-randconfig-002-20250806 (https://download.01.org/0day-ci/archive/20250806/202508062211.cwYqtLu0-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 7b8dea265e72c3037b6b1e54d5ab51b7e14f328b)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250806/202508062211.cwYqtLu0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508062211.cwYqtLu0-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/trace/trace.c:11128:32: error: use of undeclared identifier 'CONFIG_TRACE_SYSCALL_BUF_SIZE_DEFAULT'
    11128 |         global_trace.syscall_buf_sz = CONFIG_TRACE_SYSCALL_BUF_SIZE_DEFAULT;
          |                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
