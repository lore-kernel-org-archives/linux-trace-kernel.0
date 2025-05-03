Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110C71DDC18;
	Sat,  3 May 2025 10:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746267050; cv=none; b=HIV4Z3tOscpPjDtgPV0l8F7GU8fqpPIw11u/d1htVmm5DCK98ERrwnFtbQBTXRkbykUTryVIt8IrNpNFu3HyzJQ9pTpM9RiOzJ6vpkkWVY1RL3z/GTn5gZ0zuF04BF21tx2hN5kNcUPTg1W1fV/m8ujzwLYl9js4dmr1PxZEkv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746267050; c=relaxed/simple;
	bh=xk/wEgqqIO2by4Z2qvxQ7ilU/SdwMkhsAd06Cg0FC4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TdevJW3Cp8UO6bmNZ2yzCOzkAuTFj5aSPPueBwAOG6D2Ujl9skK+rsnS+/aWmrlKeoV9LtyRtbdQjTJBisEtmnOEySUAKlvEsr7ovoPfGiHxixUU6gCWONlBc27u4TPSl8VbIY1eaVobK7iXGVEecRr4A3fLAQ0CTyjKT7/NcKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YfpvM7H/; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YfpvM7H/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746267048; x=1777803048;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xk/wEgqqIO2by4Z2qvxQ7ilU/SdwMkhsAd06Cg0FC4E=;
  b=YfpvM7H/3qN4l2C1Bfnnms9DXbxHUndcxWNIfITVwVXT2/PjVIWZr1UM
   n3lLpKTYaXYo0hdBTKmNeHDDV5YVzKMkOIf0999IMDJNLrZIR4YgeQ7Le
   927dZJJhLxDJI4DxgnMEVb8oaDYpu6kNu3ZyzPN1CdOtx7udvL+b0P3FU
   j81MSkbq07mWKks1svvSGu7kTZJmwil7vvLMmYIYVLVJWWvTVFDsjgH2c
   nJqDXarICUzjnEsZ227bBXiI7j3z4fbJ80NNtkdERMdfGuPFmKK6Kpoao
   NDSxyljgKNPakQ0OJi3in9O/R/t22MCRaOcOEaBiqVwDnMknr4KinRqbK
   g==;
X-CSE-ConnectionGUID: MXiKWX7aRYi3FHo/2bCaQA==
X-CSE-MsgGUID: Q1AyCUmUTmagDo9cMZ+Z+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11421"; a="47821848"
X-IronPort-AV: E=Sophos;i="6.15,258,1739865600"; 
   d="scan'208";a="47821848"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2025 03:10:47 -0700
X-CSE-ConnectionGUID: BNpdvW4RT16cYCbbG1zdoQ==
X-CSE-MsgGUID: Np7Cl7wiQS6yWBIt/JW9VA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,258,1739865600"; 
   d="scan'208";a="139986440"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 03 May 2025 03:10:45 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uB9pS-0005I9-1Q;
	Sat, 03 May 2025 10:10:42 +0000
Date: Sat, 3 May 2025 18:10:14 +0800
From: kernel test robot <lkp@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH 09/12] tracing: branch: Use trace_tracing_is_on_cpu()
 instead of "disabled" field
Message-ID: <202505031738.buFg2SBt-lkp@intel.com>
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
[also build test ERROR on linus/master v6.15-rc4 next-20250502]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Steven-Rostedt/tracing-mmiotrace-Remove-reference-to-unused-per-CPU-data-pointer/20250503-050317
base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
patch link:    https://lore.kernel.org/r/20250502205349.299144667%40goodmis.org
patch subject: [PATCH 09/12] tracing: branch: Use trace_tracing_is_on_cpu() instead of "disabled" field
config: arc-randconfig-001-20250503 (https://download.01.org/0day-ci/archive/20250503/202505031738.buFg2SBt-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250503/202505031738.buFg2SBt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505031738.buFg2SBt-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/trace/trace_branch.c: In function 'probe_likely_condition':
>> kernel/trace/trace_branch.c:56:43: error: implicit declaration of function 'raw_smp_process_id'; did you mean 'raw_smp_processor_id'? [-Wimplicit-function-declaration]
      56 |         if (!tracer_tracing_is_on_cpu(tr, raw_smp_process_id()))
         |                                           ^~~~~~~~~~~~~~~~~~
         |                                           raw_smp_processor_id


vim +56 kernel/trace/trace_branch.c

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
