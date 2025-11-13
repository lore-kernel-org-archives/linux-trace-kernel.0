Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC07330E0C5;
	Thu, 13 Nov 2025 18:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763058837; cv=none; b=Bz8gXwipxApCG9eSgHAxMx0+xOBhJMecwSw2bIPcMCPX9Ln0T0+NUnmc0qcLC97AVtLmJmJoWOdvuGJ1fAviESDMwlIB+frVSM1RS5GwI2nbx4Pez1DcXrSoTAeYgRl4olQQxrO7Bek1ng7RF+V0U6OiIqNssg5VYjkuA7FFUr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763058837; c=relaxed/simple;
	bh=wiEF9wo+xx6AtQx8sG2sFqXFb62gXjxc2vE5YCUrU44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VtTFhXYRxuR+2LHWELSK2nzKQ7VXFqMi3R7rFBzGQtZ5rIrzJ1y/1ctAANPvsX2MldiRc+l/ynPsVRsPDzBLglQ/gWCd1TfYlQ8YNbOWtImsArkeQHcjnibzwHFxgoMV3UBELGVNwvjV3DT8Nt4lfrrtCbJfIUVfikDecZAUjOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AZ95J5cd; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AZ95J5cd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763058835; x=1794594835;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wiEF9wo+xx6AtQx8sG2sFqXFb62gXjxc2vE5YCUrU44=;
  b=AZ95J5cdXqxpK6aq4rikhMTVI1AwDHWkBzPX3Fy2rniQWY4kJmTc5b8A
   BZsgDWrDs5KtOlNzuiV+syo5P+U/X16hzVRDuhQ68tu6QXuIAUXzGv7s0
   22MrbhytxZiSAEC15GUsM4x75AKJhFyAZOfZSa1LWGGafCKfv3Vvw4DPT
   /zki7rtqr/nYrkurIT0cFQsk6/YYCXJ8oeIfhEW+MpgAOTTfvJKHkx67H
   jj1lTt6A01a90YoxxGN2m+dN9emVgI1JHxfnNkA65Z2V/dZIL9LgSMaOr
   MldSxz7fm9M5yD/HePXQHRrY9wI0BMQUBirHgB5PZgtqQfD/ZMjdwt8B4
   A==;
X-CSE-ConnectionGUID: QiKlk8E6QO2opZw5v7qdoA==
X-CSE-MsgGUID: uoKi6BmASD+EOnnGxr2rIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="64859065"
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="64859065"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 10:33:55 -0800
X-CSE-ConnectionGUID: JAy4oEsqTLm4X4+YeT2MyA==
X-CSE-MsgGUID: GGrmpuoTQayb0qj9J4AMaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="188827303"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 13 Nov 2025 10:33:52 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vJc8j-0005kN-0q;
	Thu, 13 Nov 2025 18:33:49 +0000
Date: Fri, 14 Nov 2025 02:33:38 +0800
From: kernel test robot <lkp@intel.com>
To: Donglin Peng <dolinux.peng@gmail.com>, rostedt@goodmis.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Donglin Peng <pengdonglin@xiaomi.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v5] function_graph: Enable funcgraph-args and
 funcgraph-retaddr to work simultaneously
Message-ID: <202511140224.loIXI9Us-lkp@intel.com>
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
config: sparc64-randconfig-001-20251113 (https://download.01.org/0day-ci/archive/20251114/202511140224.loIXI9Us-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251114/202511140224.loIXI9Us-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511140224.loIXI9Us-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/trace/trace_functions_graph.c:146:19: warning: variable 'args_offs' set but not used [-Wunused-but-set-variable]
     146 |         int nr_args = 0, args_offs = 0;
         |                          ^
   kernel/trace/trace_functions_graph.c:169:20: warning: variable 'retaddr' is uninitialized when used here [-Wuninitialized]
     169 |                 entry->args[0] = retaddr;
         |                                  ^~~~~~~
   kernel/trace/trace_functions_graph.c:143:23: note: initialize the variable 'retaddr' to silence this warning
     143 |         unsigned long retaddr;
         |                              ^
         |                               = 0
   2 warnings generated.


vim +/args_offs +146 kernel/trace/trace_functions_graph.c

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
 > 146		int nr_args = 0, args_offs = 0;
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
   169			entry->args[0] = retaddr;
   170			args_offs += 1;
   171		}
   172	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
