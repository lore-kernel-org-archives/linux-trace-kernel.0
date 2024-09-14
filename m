Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538D31CEE87;
	Sat, 14 Sep 2024 13:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726321026; cv=none; b=ogyWg9t5oXF7XWt9hY5inQ3CrXlIlAxVYipAl/ahjfjNkd9Tk2pr3I5A/5+BpIvn1LBJJ/bVu6giqbqu7QjJKnl90JUo+dTiNqT4PhcwwEqkdk/bBmH1ySLiaygIws5otYfu93ErU6xLML3hHJ9o02g3d4DsbFRZmjO9i1Oa6Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726321026; c=relaxed/simple;
	bh=kFXHFprFgR4slCLR0FGUcGELc2KesBc1hafcDj0mvbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hIdpeYs3Eglbjaz3GyUfeyKWxEyuhNHiuCaYrXnjMIBp63cDy1ZjIs7NDmdag/M4w/ij+8SdQ3pT8lRt7OOp8Wt5cugLSW8vuCmlgiW591mlMZc1M03HwKpTkP5Qxn8/FCkzbXVn5/9kKoNm0pVpIE6qgHpIR7sUqFouk4TdDLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vf1usc5C; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vf1usc5C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726321024; x=1757857024;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kFXHFprFgR4slCLR0FGUcGELc2KesBc1hafcDj0mvbc=;
  b=Vf1usc5CizGErRr8QPcPn67tAL2YQLr+oiPzNR4Jl+nWxY78WufZ7t+d
   Ku8Tn/D8zxXFapsgcpCkpTC0jABsWEnGw/9o+1rL+istl8SdKTmO+uCaW
   FJ3ZJLSwFzpqM5+/mg/g/5VL+79SDi0zXbdKPW5vkF8o150NMs17V+gpn
   6EGrOBcyuhFL8f9eOjhB0F2CLMfA4X/8qF7VqD4rTGyo0mJM7U09yll1q
   tMd+x77AuV/y2vj6pWYCRDHv7yJzmpi+++hQKkJSezSVSqqvcw2ZL/elz
   79JGT43IbhPTgrk3TUR0QtXYGKRXWMYNMUuS3P9XZyM9ubD/FbdLxmkcI
   w==;
X-CSE-ConnectionGUID: +f9aN4OLTVqHMydGmQ4OAQ==
X-CSE-MsgGUID: R94JWIYrQ+eHWh2leLuC5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11195"; a="25310292"
X-IronPort-AV: E=Sophos;i="6.10,229,1719903600"; 
   d="scan'208";a="25310292"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2024 06:37:03 -0700
X-CSE-ConnectionGUID: COJoVwLDRmeUauPfmGWZxg==
X-CSE-MsgGUID: XzbL1QYES+SD6AiAWtM+2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,229,1719903600"; 
   d="scan'208";a="73408876"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 14 Sep 2024 06:37:01 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1spSxO-0007mu-0L;
	Sat, 14 Sep 2024 13:36:58 +0000
Date: Sat, 14 Sep 2024 21:36:52 +0800
From: kernel test robot <lkp@intel.com>
To: Donglin Peng <dolinux.peng@gmail.com>, rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com, linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Donglin Peng <dolinux.peng@gmail.com>
Subject: Re: [PATCH v1] function_graph: Support recording and printing the
 function return address
Message-ID: <202409142157.EPUFJ6zw-lkp@intel.com>
References: <20240913123456.600950-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913123456.600950-1-dolinux.peng@gmail.com>

Hi Donglin,

kernel test robot noticed the following build errors:

[auto build test ERROR on shuah-kselftest/next]
[also build test ERROR on shuah-kselftest/fixes linus/master v6.11-rc7]
[cannot apply to next-20240913]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Donglin-Peng/function_graph-Support-recording-and-printing-the-function-return-address/20240913-204403
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git next
patch link:    https://lore.kernel.org/r/20240913123456.600950-1-dolinux.peng%40gmail.com
patch subject: [PATCH v1] function_graph: Support recording and printing the function return address
config: parisc-allmodconfig (https://download.01.org/0day-ci/archive/20240914/202409142157.EPUFJ6zw-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240914/202409142157.EPUFJ6zw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409142157.EPUFJ6zw-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from kernel/trace/trace.c:8677:
>> kernel/trace/trace_selftest.c:910:51: error: initialization of 'int (*)(struct ftrace_graph_ent *, struct fgraph_ops *, struct fgraph_extras *)' from incompatible pointer type 'int (*)(struct ftrace_graph_ent *, struct fgraph_ops *)' [-Wincompatible-pointer-types]
     910 |                         .entryfunc              = store_entry,
         |                                                   ^~~~~~~~~~~
   kernel/trace/trace_selftest.c:910:51: note: (near initialization for 'store_bytes[0].gops.entryfunc')
   kernel/trace/trace_selftest.c:918:51: error: initialization of 'int (*)(struct ftrace_graph_ent *, struct fgraph_ops *, struct fgraph_extras *)' from incompatible pointer type 'int (*)(struct ftrace_graph_ent *, struct fgraph_ops *)' [-Wincompatible-pointer-types]
     918 |                         .entryfunc              = store_entry,
         |                                                   ^~~~~~~~~~~
   kernel/trace/trace_selftest.c:918:51: note: (near initialization for 'store_bytes[1].gops.entryfunc')
   kernel/trace/trace_selftest.c:926:51: error: initialization of 'int (*)(struct ftrace_graph_ent *, struct fgraph_ops *, struct fgraph_extras *)' from incompatible pointer type 'int (*)(struct ftrace_graph_ent *, struct fgraph_ops *)' [-Wincompatible-pointer-types]
     926 |                         .entryfunc              = store_entry,
         |                                                   ^~~~~~~~~~~
   kernel/trace/trace_selftest.c:926:51: note: (near initialization for 'store_bytes[2].gops.entryfunc')
   kernel/trace/trace_selftest.c:934:51: error: initialization of 'int (*)(struct ftrace_graph_ent *, struct fgraph_ops *, struct fgraph_extras *)' from incompatible pointer type 'int (*)(struct ftrace_graph_ent *, struct fgraph_ops *)' [-Wincompatible-pointer-types]
     934 |                         .entryfunc              = store_entry,
         |                                                   ^~~~~~~~~~~
   kernel/trace/trace_selftest.c:934:51: note: (near initialization for 'store_bytes[3].gops.entryfunc')
   kernel/trace/trace_selftest.c: In function 'trace_graph_entry_watchdog':
>> kernel/trace/trace_selftest.c:1029:16: error: too few arguments to function 'trace_graph_entry'
    1029 |         return trace_graph_entry(trace, gops);
         |                ^~~~~~~~~~~~~~~~~
   In file included from kernel/trace/trace.c:54:
   kernel/trace/trace.h:689:5: note: declared here
     689 | int trace_graph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
         |     ^~~~~~~~~~~~~~~~~
   kernel/trace/trace_selftest.c: At top level:
   kernel/trace/trace_selftest.c:1033:35: error: initialization of 'int (*)(struct ftrace_graph_ent *, struct fgraph_ops *, struct fgraph_extras *)' from incompatible pointer type 'int (*)(struct ftrace_graph_ent *, struct fgraph_ops *)' [-Wincompatible-pointer-types]
    1033 |         .entryfunc              = &trace_graph_entry_watchdog,
         |                                   ^
   kernel/trace/trace_selftest.c:1033:35: note: (near initialization for 'fgraph_ops.entryfunc')
   kernel/trace/trace_selftest.c: In function 'trace_graph_entry_watchdog':
>> kernel/trace/trace_selftest.c:1030:1: warning: control reaches end of non-void function [-Wreturn-type]
    1030 | }
         | ^


vim +910 kernel/trace/trace_selftest.c

dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   906) 
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   907) static struct fgraph_fixture store_bytes[4] __initdata = {
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   908) 	[0] = {
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   909) 		.gops = {
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03  @910) 			.entryfunc		= store_entry,
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   911) 			.retfunc		= store_return,
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   912) 		},
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   913) 		.store_size = 1,
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   914) 		.store_type_name = "byte",
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   915) 	},
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   916) 	[1] = {
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   917) 		.gops = {
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   918) 			.entryfunc		= store_entry,
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   919) 			.retfunc		= store_return,
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   920) 		},
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   921) 		.store_size = 2,
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   922) 		.store_type_name = "short",
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   923) 	},
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   924) 	[2] = {
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   925) 		.gops = {
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   926) 			.entryfunc		= store_entry,
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   927) 			.retfunc		= store_return,
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   928) 		},
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   929) 		.store_size = 4,
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   930) 		.store_type_name = "word",
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   931) 	},
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   932) 	[3] = {
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   933) 		.gops = {
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   934) 			.entryfunc		= store_entry,
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   935) 			.retfunc		= store_return,
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   936) 		},
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   937) 		.store_size = 8,
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   938) 		.store_type_name = "long long",
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   939) 	},
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   940) };
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   941) 
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   942) static __init int test_graph_storage_multi(void)
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   943) {
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   944) 	struct fgraph_fixture *fixture;
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   945) 	bool printed = false;
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   946) 	int i, ret;
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   947) 
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   948) 	pr_cont("PASSED\n");
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   949) 	pr_info("Testing multiple fgraph storage on a function: ");
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   950) 
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   951) 	for (i = 0; i < ARRAY_SIZE(store_bytes); i++) {
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   952) 		fixture = &store_bytes[i];
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   953) 		ret = init_fgraph_fixture(fixture);
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   954) 		if (ret && ret != -ENODEV) {
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   955) 			pr_cont("*Could not set filter* ");
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   956) 			printed = true;
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   957) 			goto out;
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   958) 		}
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   959) 
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   960) 		ret = register_ftrace_graph(&fixture->gops);
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   961) 		if (ret) {
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   962) 			pr_warn("Failed to init store_bytes fgraph tracing\n");
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   963) 			printed = true;
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   964) 			goto out;
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   965) 		}
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   966) 	}
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   967) 
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   968) 	DYN_FTRACE_TEST_NAME();
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   969) out:
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   970) 	while (--i >= 0) {
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   971) 		fixture = &store_bytes[i];
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   972) 		unregister_ftrace_graph(&fixture->gops);
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   973) 
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   974) 		if (fixture->error_str && !printed) {
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   975) 			pr_cont("*** %s ***", fixture->error_str);
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   976) 			printed = true;
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   977) 		}
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   978) 	}
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   979) 	return printed ? -1 : 0;
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   980) }
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   981) 
47c3c70aa36971 Steven Rostedt (VMware    2024-06-03   982) /* Test the storage passed across function_graph entry and return */
47c3c70aa36971 Steven Rostedt (VMware    2024-06-03   983) static __init int test_graph_storage(void)
47c3c70aa36971 Steven Rostedt (VMware    2024-06-03   984) {
47c3c70aa36971 Steven Rostedt (VMware    2024-06-03   985) 	int ret;
47c3c70aa36971 Steven Rostedt (VMware    2024-06-03   986) 
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   987) 	ret = test_graph_storage_single(&store_bytes[0]);
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   988) 	if (ret)
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   989) 		return ret;
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   990) 	ret = test_graph_storage_single(&store_bytes[1]);
47c3c70aa36971 Steven Rostedt (VMware    2024-06-03   991) 	if (ret)
47c3c70aa36971 Steven Rostedt (VMware    2024-06-03   992) 		return ret;
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   993) 	ret = test_graph_storage_single(&store_bytes[2]);
47c3c70aa36971 Steven Rostedt (VMware    2024-06-03   994) 	if (ret)
47c3c70aa36971 Steven Rostedt (VMware    2024-06-03   995) 		return ret;
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   996) 	ret = test_graph_storage_single(&store_bytes[3]);
47c3c70aa36971 Steven Rostedt (VMware    2024-06-03   997) 	if (ret)
47c3c70aa36971 Steven Rostedt (VMware    2024-06-03   998) 		return ret;
dd120af2d5f8f3 Masami Hiramatsu (Google  2024-06-03   999) 	ret = test_graph_storage_multi();
47c3c70aa36971 Steven Rostedt (VMware    2024-06-03  1000) 	if (ret)
47c3c70aa36971 Steven Rostedt (VMware    2024-06-03  1001) 		return ret;
47c3c70aa36971 Steven Rostedt (VMware    2024-06-03  1002) 	return 0;
47c3c70aa36971 Steven Rostedt (VMware    2024-06-03  1003) }
47c3c70aa36971 Steven Rostedt (VMware    2024-06-03  1004) #else
47c3c70aa36971 Steven Rostedt (VMware    2024-06-03  1005) static inline int test_graph_storage(void) { return 0; }
47c3c70aa36971 Steven Rostedt (VMware    2024-06-03  1006) #endif /* CONFIG_DYNAMIC_FTRACE */
47c3c70aa36971 Steven Rostedt (VMware    2024-06-03  1007) 
cf586b61f80229 Frederic Weisbecker       2009-03-22  1008  /* Maximum number of functions to trace before diagnosing a hang */
cf586b61f80229 Frederic Weisbecker       2009-03-22  1009  #define GRAPH_MAX_FUNC_TEST	100000000
cf586b61f80229 Frederic Weisbecker       2009-03-22  1010  
cf586b61f80229 Frederic Weisbecker       2009-03-22  1011  static unsigned int graph_hang_thresh;
cf586b61f80229 Frederic Weisbecker       2009-03-22  1012  
cf586b61f80229 Frederic Weisbecker       2009-03-22  1013  /* Wrap the real function entry probe to avoid possible hanging */
37238abe3cb47b Steven Rostedt (VMware    2024-06-03  1014) static int trace_graph_entry_watchdog(struct ftrace_graph_ent *trace,
37238abe3cb47b Steven Rostedt (VMware    2024-06-03  1015) 				      struct fgraph_ops *gops)
cf586b61f80229 Frederic Weisbecker       2009-03-22  1016  {
cf586b61f80229 Frederic Weisbecker       2009-03-22  1017  	/* This is harmlessly racy, we want to approximately detect a hang */
cf586b61f80229 Frederic Weisbecker       2009-03-22  1018  	if (unlikely(++graph_hang_thresh > GRAPH_MAX_FUNC_TEST)) {
cf586b61f80229 Frederic Weisbecker       2009-03-22  1019  		ftrace_graph_stop();
cf586b61f80229 Frederic Weisbecker       2009-03-22  1020  		printk(KERN_WARNING "BUG: Function graph tracer hang!\n");
19f0423fd55c30 Huang Yiwei               2024-02-23  1021  		if (ftrace_dump_on_oops_enabled()) {
7fe70b579c9e3d Steven Rostedt (Red Hat   2013-03-15  1022) 			ftrace_dump(DUMP_ALL);
7fe70b579c9e3d Steven Rostedt (Red Hat   2013-03-15  1023) 			/* ftrace_dump() disables tracing */
7fe70b579c9e3d Steven Rostedt (Red Hat   2013-03-15  1024) 			tracing_on();
7fe70b579c9e3d Steven Rostedt (Red Hat   2013-03-15  1025) 		}
cf586b61f80229 Frederic Weisbecker       2009-03-22  1026  		return 0;
cf586b61f80229 Frederic Weisbecker       2009-03-22  1027  	}
cf586b61f80229 Frederic Weisbecker       2009-03-22  1028  
37238abe3cb47b Steven Rostedt (VMware    2024-06-03 @1029) 	return trace_graph_entry(trace, gops);
cf586b61f80229 Frederic Weisbecker       2009-03-22 @1030  }
cf586b61f80229 Frederic Weisbecker       2009-03-22  1031  
688f7089d8851b Steven Rostedt (VMware    2018-11-15  1032) static struct fgraph_ops fgraph_ops __initdata  = {
688f7089d8851b Steven Rostedt (VMware    2018-11-15 @1033) 	.entryfunc		= &trace_graph_entry_watchdog,
688f7089d8851b Steven Rostedt (VMware    2018-11-15  1034) 	.retfunc		= &trace_graph_return,
688f7089d8851b Steven Rostedt (VMware    2018-11-15  1035) };
688f7089d8851b Steven Rostedt (VMware    2018-11-15  1036) 

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
