Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CFB1EFFB1;
	Thu, 10 Apr 2025 15:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744299995; cv=none; b=O4Jkiyk2XvxNS3+ewhpaNa+eVH5bPVIho/d9RDB2BSCcGb6WBShsQv/mOQMp16pdIIR5FFNBVnm8YYy69H9b+GTPqLoBMXHpTJg1xWYbcxJ0IabEEPqDQeAclaChujqc+Y1PveOwSLgbUK0K37xTV9zRcqV3+uG/4+ALqJ180kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744299995; c=relaxed/simple;
	bh=gBYgW5cjW4/+rgHV13XVM72Z4tpzZbhTmwNUizykIds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HFODqAMt3gE7/3TZB1V9ufD3w8iYnBPQDQ4UOe9cjtERFH4KzByboIDd7mMzu1PGLoagNZrs4heAf1w0bxXvzD8dVDaAaEtNxWbJXwwrOeMHE2+x82QKI95ENG460+PNvCo5Zwyrwr7dlxxtddfuYvRaaC4vZVKLwBCTnnIGItg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nPOsnJ5v; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nPOsnJ5v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744299994; x=1775835994;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gBYgW5cjW4/+rgHV13XVM72Z4tpzZbhTmwNUizykIds=;
  b=nPOsnJ5voT+D8P/Y9PeDPPhh2zIjTZ+uDQ4sZS5jkXcI9gkAuKYGGUTX
   vyoPhG/c9YWi8JdUCgmJcjdNpTPXagFpeS2arcAJgEG3H/5rvOiJg2K+T
   IFZXwSo4j/66+XLWFKYttZJZLabHykR7/pLDhQ7PnHFH+OlAlHV+AEv52
   cioEQpS82yPlKY2GK1q5iDJR9cFt1NjkT55BPJKj983TK0KMLSexZWI+K
   3yu9XUv4ASz9Ko4o7+fBSjls3lmtnmQBzOaXZtJezIAr56Sy5OPpNHD7K
   KRpcLUz4BNpO99rhFHgUXSmr6lbEiqRPb0XukzArHUszgXebHAwJm7lqK
   g==;
X-CSE-ConnectionGUID: 2r2U4AKSRQOSFxMjLSHEqw==
X-CSE-MsgGUID: szWQKsBiR3KbCjHwnIg5dw==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="49630160"
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="49630160"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 08:46:33 -0700
X-CSE-ConnectionGUID: LWyx47QMR0WxgM0pCz7OXg==
X-CSE-MsgGUID: b3V+DafDQD+ER7MDfkTPqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="129892851"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 10 Apr 2025 08:46:31 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u2u6m-000AEl-2e;
	Thu, 10 Apr 2025 15:46:28 +0000
Date: Thu, 10 Apr 2025 23:45:45 +0800
From: kernel test robot <lkp@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] ftrace: Show subops in enabled_functions
Message-ID: <202504102339.KxLwdUFJ-lkp@intel.com>
References: <20250409094226.23f75293@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409094226.23f75293@gandalf.local.home>

Hi Steven,

kernel test robot noticed the following build errors:

[auto build test ERROR on trace/for-next]
[also build test ERROR on linus/master v6.15-rc1 next-20250410]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Steven-Rostedt/ftrace-Show-subops-in-enabled_functions/20250409-214345
base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
patch link:    https://lore.kernel.org/r/20250409094226.23f75293%40gandalf.local.home
patch subject: [PATCH] ftrace: Show subops in enabled_functions
config: i386-buildonly-randconfig-001-20250410 (https://download.01.org/0day-ci/archive/20250410/202504102339.KxLwdUFJ-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250410/202504102339.KxLwdUFJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504102339.KxLwdUFJ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/trace/ftrace.c:4342:11: error: incomplete definition of type 'struct fgraph_ops'
    4342 |                         gops = container_of(subops, struct fgraph_ops, ops);
         |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/container_of.h:20:47: note: expanded from macro 'container_of'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~
      21 |                       __same_type(*(ptr), void),                        \
         |                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      22 |                       "pointer type mismatch in container_of()");       \
         |                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:483:74: note: expanded from macro '__same_type'
     483 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                                                                          ^
   include/linux/build_bug.h:77:50: note: expanded from macro 'static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: expanded from macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/ftrace.h:1158:8: note: forward declaration of 'struct fgraph_ops'
    1158 | struct fgraph_ops;
         |        ^
>> kernel/trace/ftrace.c:4342:11: error: offsetof of incomplete type 'struct fgraph_ops'
    4342 |                         gops = container_of(subops, struct fgraph_ops, ops);
         |                                ^                    ~~~~~~
   include/linux/container_of.h:23:21: note: expanded from macro 'container_of'
      23 |         ((type *)(__mptr - offsetof(type, member))); })
         |                            ^        ~~~~
   include/linux/stddef.h:16:32: note: expanded from macro 'offsetof'
      16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
         |                                 ^                  ~~~~
   include/linux/ftrace.h:1158:8: note: forward declaration of 'struct fgraph_ops'
    1158 | struct fgraph_ops;
         |        ^
   kernel/trace/ftrace.c:4344:20: error: incomplete definition of type 'struct fgraph_ops'
    4344 |                                    (void *)gops->entryfunc,
         |                                            ~~~~^
   include/linux/ftrace.h:1158:8: note: forward declaration of 'struct fgraph_ops'
    1158 | struct fgraph_ops;
         |        ^
   kernel/trace/ftrace.c:4345:20: error: incomplete definition of type 'struct fgraph_ops'
    4345 |                                    (void *)gops->retfunc);
         |                                            ~~~~^
   include/linux/ftrace.h:1158:8: note: forward declaration of 'struct fgraph_ops'
    1158 | struct fgraph_ops;
         |        ^
   4 errors generated.


vim +4342 kernel/trace/ftrace.c

  4325	
  4326	static void print_subops(struct seq_file *m, struct ftrace_ops *ops, struct dyn_ftrace *rec)
  4327	{
  4328		struct ftrace_ops *subops;
  4329		bool first = true;
  4330	
  4331		list_for_each_entry(subops, &ops->subop_list, list) {
  4332			if (!((subops->flags & FTRACE_OPS_FL_ENABLED) &&
  4333			      hash_contains_ip(rec->ip, subops->func_hash)))
  4334				continue;
  4335			if (first) {
  4336				seq_printf(m, "\tsubops:");
  4337				first = false;
  4338			}
  4339			if (subops->flags & FTRACE_OPS_FL_GRAPH) {
  4340				struct fgraph_ops *gops;
  4341	
> 4342				gops = container_of(subops, struct fgraph_ops, ops);
  4343				seq_printf(m, " {ent:%pS ret:%pS}",
  4344					   (void *)gops->entryfunc,
  4345					   (void *)gops->retfunc);
  4346				continue;
  4347			}
  4348			if (subops->trampoline) {
  4349				seq_printf(m, " {%pS (%pS)}",
  4350					   (void *)subops->trampoline,
  4351					   (void *)subops->func);
  4352				add_trampoline_func(m, subops, rec);
  4353			} else {
  4354				seq_printf(m, " {%pS}",
  4355					   (void *)subops->func);
  4356			}
  4357		}
  4358	}
  4359	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
