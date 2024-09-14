Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7631A7D405;
	Sat, 14 Sep 2024 22:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726352846; cv=none; b=q28rIqil+9jVwd0/kxFDFW5Bjyi5WR51ERmDnM9smqG3QWEulwKKVxYbn34F1eMFVdKefLEY6f0HsF8Ref+wSVxubu1FpXUC1jXHkurjTD/eCeS0FaNtK1dRsw5FxvFUlMEwNlBn4AIKODA/Dl8s6nkGw4JLvJHbzHlwlpCdoh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726352846; c=relaxed/simple;
	bh=kXHQ/nA3IGU83zXrkZOHQopDJj/qiJ+jyxnz3cPSqlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mLxWuqfvRLwrU2d6OJxwtuPNZFu+Vc0nN8TtFm7861FEBQGx8PtCkGPg4JyvHMLVKZka/ztSX+ON81574xxMf6Wigk1B2B2YevMUUX2KrUdvPXDJTG0bXHWNAxkU3/PB8PU/gu8GcMLV8p2kkBamN98JNNUUVSp1QoKEXRKwAuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FCzHAecQ; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FCzHAecQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726352845; x=1757888845;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kXHQ/nA3IGU83zXrkZOHQopDJj/qiJ+jyxnz3cPSqlo=;
  b=FCzHAecQz7YuGLJp346DqoeCXa7ykvy5t8VjVaQBenvpU2OzmLvUsm/z
   9A4xZIpsG+5dkSZgUfTsZPaxuTnsbffZUPMORXwnUWh3D/psCLAKFimvz
   FcpmeS8ls6yW20FliFUE1XDYWhMmoBMRgDXx3o+ShU2d0i4spdrWaNhXG
   N/INfymGPXzAgjjGIwRhMDCUXDDEgWyMem3g5LR5pAtwPy9hX3YjEbtUN
   dx7L/I/uP33Rm4yCVtvcGEhsCs8U9iaBexJO6r5sIoxXpeWMP3VUTyPK8
   09LTXgyAZJI1FeYmHc8sLRbUHy+pjBLfaWE5x0aPa/Rr5iqOqFX/WuVjU
   g==;
X-CSE-ConnectionGUID: gwxF1zJmTI6N+mBlBH6qQQ==
X-CSE-MsgGUID: dhTeGvLpR5W7rhLrWE8Oig==
X-IronPort-AV: E=McAfee;i="6700,10204,11195"; a="35905856"
X-IronPort-AV: E=Sophos;i="6.10,229,1719903600"; 
   d="scan'208";a="35905856"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2024 15:27:24 -0700
X-CSE-ConnectionGUID: bOCOHGs4RlSf4BIebvCY0w==
X-CSE-MsgGUID: h9cYkHMQQxij9JQJ9URGtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,229,1719903600"; 
   d="scan'208";a="72867586"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 14 Sep 2024 15:27:21 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1spbEd-0008CA-0p;
	Sat, 14 Sep 2024 22:27:19 +0000
Date: Sun, 15 Sep 2024 06:26:57 +0800
From: kernel test robot <lkp@intel.com>
To: Donglin Peng <dolinux.peng@gmail.com>, rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	mark.rutland@arm.com, mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Donglin Peng <dolinux.peng@gmail.com>
Subject: Re: [PATCH v1] function_graph: Support recording and printing the
 function return address
Message-ID: <202409150605.HgUmU8ea-lkp@intel.com>
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
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20240915/202409150605.HgUmU8ea-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240915/202409150605.HgUmU8ea-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409150605.HgUmU8ea-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/trace/trace.c:8677:
>> kernel/trace/trace_selftest.c:910:18: error: incompatible function pointer types initializing 'trace_func_graph_ent_t' (aka 'int (*)(struct ftrace_graph_ent *, struct fgraph_ops *, struct fgraph_extras *)') with an expression of type 'int (struct ftrace_graph_ent *, struct fgraph_ops *)' [-Wincompatible-function-pointer-types]
     910 |                         .entryfunc              = store_entry,
         |                                                   ^~~~~~~~~~~
   kernel/trace/trace_selftest.c:918:18: error: incompatible function pointer types initializing 'trace_func_graph_ent_t' (aka 'int (*)(struct ftrace_graph_ent *, struct fgraph_ops *, struct fgraph_extras *)') with an expression of type 'int (struct ftrace_graph_ent *, struct fgraph_ops *)' [-Wincompatible-function-pointer-types]
     918 |                         .entryfunc              = store_entry,
         |                                                   ^~~~~~~~~~~
   kernel/trace/trace_selftest.c:926:18: error: incompatible function pointer types initializing 'trace_func_graph_ent_t' (aka 'int (*)(struct ftrace_graph_ent *, struct fgraph_ops *, struct fgraph_extras *)') with an expression of type 'int (struct ftrace_graph_ent *, struct fgraph_ops *)' [-Wincompatible-function-pointer-types]
     926 |                         .entryfunc              = store_entry,
         |                                                   ^~~~~~~~~~~
   kernel/trace/trace_selftest.c:934:18: error: incompatible function pointer types initializing 'trace_func_graph_ent_t' (aka 'int (*)(struct ftrace_graph_ent *, struct fgraph_ops *, struct fgraph_extras *)') with an expression of type 'int (struct ftrace_graph_ent *, struct fgraph_ops *)' [-Wincompatible-function-pointer-types]
     934 |                         .entryfunc              = store_entry,
         |                                                   ^~~~~~~~~~~
>> kernel/trace/trace_selftest.c:1029:38: error: too few arguments to function call, expected 3, have 2
    1029 |         return trace_graph_entry(trace, gops);
         |                ~~~~~~~~~~~~~~~~~            ^
   kernel/trace/trace.h:689:5: note: 'trace_graph_entry' declared here
     689 | int trace_graph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
         |     ^                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     690 |                       struct fgraph_extras *priv);
         |                       ~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from kernel/trace/trace.c:8677:
   kernel/trace/trace_selftest.c:1033:16: error: incompatible function pointer types initializing 'trace_func_graph_ent_t' (aka 'int (*)(struct ftrace_graph_ent *, struct fgraph_ops *, struct fgraph_extras *)') with an expression of type 'int (*)(struct ftrace_graph_ent *, struct fgraph_ops *)' [-Wincompatible-function-pointer-types]
    1033 |         .entryfunc              = &trace_graph_entry_watchdog,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   6 errors generated.


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
cf586b61f80229 Frederic Weisbecker       2009-03-22  1030  }
cf586b61f80229 Frederic Weisbecker       2009-03-22  1031  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
