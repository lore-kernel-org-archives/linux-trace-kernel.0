Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C1922837F;
	Mon,  5 May 2025 12:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746447085; cv=none; b=k+QmGY9701DeKNJ1QAIuBqevs6ZaAVmdv16gE89P5DEMMXoHHpY2uz0KPmjzH5w20Uvsf5Wkj10XhxMNPiZ8rr5AVHjUlO8LPk3xa6yG1HOm5QZ5FZGmihi8EZdm2+7cxJPEksbm2LbWhRyS1xB0ZAsO+b9FpHTVTj+ljcEYnt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746447085; c=relaxed/simple;
	bh=bxaZJKzN4o4K93+jRibQUfVTUKlyCaXeSBSGun1gpoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a+F9yOY6gPJJD7IukalqrPBtssK2zf6w5hHcYgS4ldu9/XhSV6INSeheD1DkJMukThszzpYJEos71ywPrfD/tqOHWG+Mo9wPgmTlYQv8G69/H3dKOdB24E+ztl0ckbPRNV6l36h2qYA51Q9gpIV1vj77FW/qqGZDGN0iZfYi5JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SMNwABUi; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SMNwABUi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746447083; x=1777983083;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bxaZJKzN4o4K93+jRibQUfVTUKlyCaXeSBSGun1gpoI=;
  b=SMNwABUiv/8d047WG8IhnvQ3qp45KngqMjnnlq0XfBlp9iLEV5mOsryN
   LO6zP7ySPiT0NxGH+lIpULi2qXjUWynMxxwQos9sQ0su+NaeHKjVSYZk3
   KnwX7W0IXwVqFP0kd0X7SHtYQZiwY5xsQW47xYHuRcnGdfH4J06flXtQW
   Kjg8bYqmOwuyPINAYPWNIPxj9+rF4XZmaxwvk2ZuX4HIHUMmDWBIb6BUo
   Kb5J9kPXJ+U541iBrSiZyjrYgl5kSLUbmVSQ/YCyRfiPurNorqS5dtTOZ
   Tgyrfw+UHpKkUxi9kzTGxke/Ssvegq72a17/RMnCFUOYfTwPcID7OU/7U
   A==;
X-CSE-ConnectionGUID: FihaO9qrRJi0vWrePtlPzQ==
X-CSE-MsgGUID: jv0p2IxaRrKHioYkSVzL0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11423"; a="73445520"
X-IronPort-AV: E=Sophos;i="6.15,262,1739865600"; 
   d="scan'208";a="73445520"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 05:11:22 -0700
X-CSE-ConnectionGUID: O7eKqblEQhGvMWo4WbvYxw==
X-CSE-MsgGUID: VA9AJlB/RGuacaen0jP/NQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,262,1739865600"; 
   d="scan'208";a="136182857"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 05 May 2025 05:11:20 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uBufG-0005hx-0U;
	Mon, 05 May 2025 12:11:18 +0000
Date: Mon, 5 May 2025 20:11:09 +0800
From: kernel test robot <lkp@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH 09/12] tracing: branch: Use trace_tracing_is_on_cpu()
 instead of "disabled" field
Message-ID: <202505051827.xKU53TzL-lkp@intel.com>
References: <20250502205349.299144667@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250502205349.299144667@goodmis.org>

Hi Steven,

kernel test robot noticed the following build errors:

[auto build test ERROR on trace/for-next]
[also build test ERROR on linus/master v6.15-rc5 next-20250502]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Steven-Rostedt/tracing-mmiotrace-Remove-reference-to-unused-per-CPU-data-pointer/20250503-050317
base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
patch link:    https://lore.kernel.org/r/20250502205349.299144667%40goodmis.org
patch subject: [PATCH 09/12] tracing: branch: Use trace_tracing_is_on_cpu() instead of "disabled" field
config: i386-buildonly-randconfig-002-20250505 (https://download.01.org/0day-ci/archive/20250505/202505051827.xKU53TzL-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250505/202505051827.xKU53TzL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505051827.xKU53TzL-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/trace/trace_branch.c:56:36: error: call to undeclared function 'raw_smp_process_id'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      56 |         if (!tracer_tracing_is_on_cpu(tr, raw_smp_process_id()))
         |                                           ^
   kernel/trace/trace_branch.c:56:36: note: did you mean 'safe_smp_processor_id'?
   arch/x86/include/asm/smp.h:140:12: note: 'safe_smp_processor_id' declared here
     140 | extern int safe_smp_processor_id(void);
         |            ^
   1 error generated.


vim +/raw_smp_process_id +56 kernel/trace/trace_branch.c

    29	
    30	static void
    31	probe_likely_condition(struct ftrace_likely_data *f, int val, int expect)
    32	{
    33		struct trace_array *tr = branch_tracer;
    34		struct trace_buffer *buffer;
    35		struct ring_buffer_event *event;
    36		struct trace_branch *entry;
    37		unsigned long flags;
    38		unsigned int trace_ctx;
    39		const char *p;
    40	
    41		if (current->trace_recursion & TRACE_BRANCH_BIT)
    42			return;
    43	
    44		/*
    45		 * I would love to save just the ftrace_likely_data pointer, but
    46		 * this code can also be used by modules. Ugly things can happen
    47		 * if the module is unloaded, and then we go and read the
    48		 * pointer.  This is slower, but much safer.
    49		 */
    50	
    51		if (unlikely(!tr))
    52			return;
    53	
    54		raw_local_irq_save(flags);
    55		current->trace_recursion |= TRACE_BRANCH_BIT;
  > 56		if (!tracer_tracing_is_on_cpu(tr, raw_smp_process_id()))
    57			goto out;
    58	
    59		trace_ctx = tracing_gen_ctx_flags(flags);
    60		buffer = tr->array_buffer.buffer;
    61		event = trace_buffer_lock_reserve(buffer, TRACE_BRANCH,
    62						  sizeof(*entry), trace_ctx);
    63		if (!event)
    64			goto out;
    65	
    66		entry	= ring_buffer_event_data(event);
    67	
    68		/* Strip off the path, only save the file */
    69		p = f->data.file + strlen(f->data.file);
    70		while (p >= f->data.file && *p != '/')
    71			p--;
    72		p++;
    73	
    74		strscpy(entry->func, f->data.func);
    75		strscpy(entry->file, p);
    76		entry->constant = f->constant;
    77		entry->line = f->data.line;
    78		entry->correct = val == expect;
    79	
    80		trace_buffer_unlock_commit_nostack(buffer, event);
    81	
    82	 out:
    83		current->trace_recursion &= ~TRACE_BRANCH_BIT;
    84		raw_local_irq_restore(flags);
    85	}
    86	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
