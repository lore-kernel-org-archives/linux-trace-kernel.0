Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74EF2309B2;
	Thu, 13 Nov 2025 17:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763055709; cv=none; b=inum6gJgKRXOtHsu2JdYW4Y+45O1TM98Dzu9PMqwptqj6G8LEP/riakWBX+y4we4IBPGJbQr/fT4pAuvz88yhbtn+5BwksZcoPAd2D1aR8ceEVJGwW3J2bOd1UY1NTMV/2joFfVsPmvoxW31C/gssvCsvrlELHGNCoOcqTwMG+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763055709; c=relaxed/simple;
	bh=9u/9wooimg78LZNZgyo2Be9GSJ/iR3xJ38ZAqHeLh+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sAAaW5/WdVQxyndNptC481eF5hLiXM74MfyNfyNt/WnC16Ummo/nsE9cL1w87QXm0lIJBT7NyBltmJCedm8oifobkE9qptdRASJSdoxPG7yrqt2qgi+/2Lx9DcNw/gsid8C8bn1vvGckP0/OqWq1Lv8rAtjMi7oJS1GlTNlHCaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z2vw0zV2; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z2vw0zV2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763055708; x=1794591708;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9u/9wooimg78LZNZgyo2Be9GSJ/iR3xJ38ZAqHeLh+E=;
  b=Z2vw0zV2bo+Toe+12vwe9nTk7khj+L36wMvo+QGa0WBPFVijLObGL5ve
   Fi6NiED+uInccZcxNtEpj96eJ8/W2qn+HKfuUhaf+aiJicrogOaIIL4lm
   +5pctOZV4cP1cG+QE/7Gy92agl33hwP/0EMxsKHMb3p56oV4ct7SaxUjy
   w19qYEFL0DssXv8Aca82MQwb2+x6iOtra5qhs2ESbd6hPqRQhIY7z8j3S
   sSDUPbXLBghhmNl050Rl4MuI4TxNoafbdJmGmJ9IUQyqSWODZGsF3ZK2F
   8hj0e3mRc3NAIa+MBqLLHJqmzB+KNFYc8dsnom1Ku864YRcvWcLMpmaF/
   g==;
X-CSE-ConnectionGUID: sIt4NjY5R3OgCclEv1fLkg==
X-CSE-MsgGUID: 2f1PLN7OQDWYNmpNB8F7NQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="76488335"
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="76488335"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 09:41:47 -0800
X-CSE-ConnectionGUID: GdtCnl6YSxmYdb/L1VHP6Q==
X-CSE-MsgGUID: 2Vd9XJXVRSmzNxAHEaOoMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="193996578"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 13 Nov 2025 09:41:44 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vJbKI-0005fl-0d;
	Thu, 13 Nov 2025 17:41:42 +0000
Date: Fri, 14 Nov 2025 01:41:08 +0800
From: kernel test robot <lkp@intel.com>
To: Donglin Peng <dolinux.peng@gmail.com>, rostedt@goodmis.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Donglin Peng <pengdonglin@xiaomi.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v5] function_graph: Enable funcgraph-args and
 funcgraph-retaddr to work simultaneously
Message-ID: <202511140111.X1AImPQE-lkp@intel.com>
References: <20251113072938.333657-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113072938.333657-1-dolinux.peng@gmail.com>

Hi Donglin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on v6.18-rc5]
[also build test WARNING on linus/master]
[cannot apply to trace/for-next next-20251113]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Donglin-Peng/function_graph-Enable-funcgraph-args-and-funcgraph-retaddr-to-work-simultaneously/20251113-153332
base:   v6.18-rc5
patch link:    https://lore.kernel.org/r/20251113072938.333657-1-dolinux.peng%40gmail.com
patch subject: [PATCH v5] function_graph: Enable funcgraph-args and funcgraph-retaddr to work simultaneously
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20251114/202511140111.X1AImPQE-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251114/202511140111.X1AImPQE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511140111.X1AImPQE-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/trace/trace_functions_graph.c:169:20: warning: variable 'retaddr' is uninitialized when used here [-Wuninitialized]
     169 |                 entry->args[0] = retaddr;
         |                                  ^~~~~~~
   kernel/trace/trace_functions_graph.c:143:23: note: initialize the variable 'retaddr' to silence this warning
     143 |         unsigned long retaddr;
         |                              ^
         |                               = 0
   1 warning generated.


vim +/retaddr +169 kernel/trace/trace_functions_graph.c

   132	
   133	static void
   134	print_graph_duration(struct trace_array *tr, unsigned long long duration,
   135			     struct trace_seq *s, u32 flags);
   136	
   137	static int __graph_entry(struct trace_array *tr, struct ftrace_graph_ent *trace,
   138				 unsigned int trace_ctx, struct ftrace_regs *fregs)
   139	{
   140		struct ring_buffer_event *event;
   141		struct trace_buffer *buffer = tr->array_buffer.buffer;
   142		struct ftrace_graph_ent_entry *entry;
   143		unsigned long retaddr;
   144		int size = sizeof(*entry);
   145		int type = TRACE_GRAPH_ENT;
   146		int nr_args = 0, args_offs = 0;
   147	
   148		if (IS_ENABLED(CONFIG_FUNCTION_GRAPH_RETADDR) &&
   149			tracer_flags_is_set(TRACE_GRAPH_PRINT_RETADDR)) {
   150			retaddr = ftrace_graph_top_ret_addr(current);
   151			type = TRACE_GRAPH_RETADDR_ENT;
   152			nr_args += 1;
   153		}
   154	
   155		/* If fregs is defined, add FTRACE_REGS_MAX_ARGS long size words */
   156		if (!!fregs)
   157			nr_args += FTRACE_REGS_MAX_ARGS;
   158	
   159		size += nr_args * sizeof(long);
   160		event = trace_buffer_lock_reserve(buffer, type, size, trace_ctx);
   161		if (!event)
   162			return 0;
   163	
   164		entry = ring_buffer_event_data(event);
   165		entry->graph_ent = *trace;
   166	
   167		/* Store the retaddr in args[0] */
   168		if (type == TRACE_GRAPH_RETADDR_ENT) {
 > 169			entry->args[0] = retaddr;
   170			args_offs += 1;
   171		}
   172	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
