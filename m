Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5482DC357;
	Tue, 23 Dec 2025 23:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766532416; cv=none; b=N3WrJF9X0LLhL317cqVFPLn/BoLEILwl4eTYE3uYW/qtoStfaSyIIldQyLtsBr7maFe44NZJx0Z6QvyccnWq83em/vI6LlVH1kr0ni/SakAmqD73/4+Zug+O/xdJcD3xHUZ9SMkyoSXARF0DW4vYN4I6SHJ7X8bwplOuPCpwZ5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766532416; c=relaxed/simple;
	bh=Tw8UXfWso5ZhHWbNrvlqYW+gPtiQiCffnCLVViVVMJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DmC46+8QqA6lgEHlSVfRuujhmJKxNzxpuihLMjdSZOinxUuigo4n39G6rT4pqAPW/p7bsduIJsQmVPheOExuEpLNLsPjeox+9P2deDhe1NPC48yzjeNqnKXk/Vo8GxAPZG26SPtgJJFFncsbV00Y8uGmk0FEfxtOE/0FJOCDGCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QshJ+71f; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QshJ+71f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766532415; x=1798068415;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Tw8UXfWso5ZhHWbNrvlqYW+gPtiQiCffnCLVViVVMJA=;
  b=QshJ+71f2oqLHQwwq/nAKaqdsklP1weiG0rhQX1YRyU6kVK7uCShzC+/
   TbAUa27XBYlOp4/4UhAg8tamWePehHw/nWZQEcF3TPUl+K9Ef8QOAC6Hm
   vLFAxuZxdhfilVjSGEkGJjb0L6JYYWaOcFVocjg4p+29tVLUaGUOA3MhO
   7GnrEwEYbHHkMba1ARPXDB2OYicbzK/O/LYHy3BWGsojNvtg1KVQ4k7zv
   q61xn9DGMIAI+FU5UAU/h33q3jYi5DLBEEmTxIV4EyasOLAslWXFo0fn7
   TK6rjwD7bYWFOB7IiyJZGkLSkXibQROC/4QHPFNvWxlHmPN8NH1sRviYo
   Q==;
X-CSE-ConnectionGUID: E5hocf+tSKaI4dkhF5egvQ==
X-CSE-MsgGUID: 7+E/oEE6TzWTCUi8uyJEbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11651"; a="68262038"
X-IronPort-AV: E=Sophos;i="6.21,172,1763452800"; 
   d="scan'208";a="68262038"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2025 15:26:55 -0800
X-CSE-ConnectionGUID: Ej3pIFH8Siu+t+Ohp6Z4PQ==
X-CSE-MsgGUID: fUmbiYWtSY6SST1jNYIyPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,172,1763452800"; 
   d="scan'208";a="199639655"
Received: from lkp-server02.sh.intel.com (HELO dd3453e2b682) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 23 Dec 2025 15:26:51 -0800
Received: from kbuild by dd3453e2b682 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vYBmD-000000002Th-1WRB;
	Tue, 23 Dec 2025 23:26:49 +0000
Date: Wed, 24 Dec 2025 07:26:10 +0800
From: kernel test robot <lkp@intel.com>
To: Aaron Tomlin <atomlin@atomlin.com>, rostedt@goodmis.org,
	mhiramat@kernel.org, mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com, corbet@lwn.net
Cc: oe-kbuild-all@lists.linux.dev, atomlin@atomlin.com, sean@ashe.io,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH] tracing: Add bitmask-list option for human-readable
 bitmask display
Message-ID: <202512240709.cPAuuxFj-lkp@intel.com>
References: <20251223035622.2084081-1-atomlin@atomlin.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223035622.2084081-1-atomlin@atomlin.com>

Hi Aaron,

kernel test robot noticed the following build errors:

[auto build test ERROR on trace/for-next]
[also build test ERROR on linus/master v6.19-rc2 next-20251219]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Aaron-Tomlin/tracing-Add-bitmask-list-option-for-human-readable-bitmask-display/20251223-120923
base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
patch link:    https://lore.kernel.org/r/20251223035622.2084081-1-atomlin%40atomlin.com
patch subject: [PATCH] tracing: Add bitmask-list option for human-readable bitmask display
config: i386-randconfig-141-20251224 (https://download.01.org/0day-ci/archive/20251224/202512240709.cPAuuxFj-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251224/202512240709.cPAuuxFj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512240709.cPAuuxFj-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/trace/trace_output.c: In function 'trace_print_bitmask_seq':
   kernel/trace/trace_output.c:202:40: error: implicit declaration of function 'trace_get_global_array'; did you mean 'ftrace_init_global_array_ops'? [-Wimplicit-function-declaration]
     202 |         const struct trace_array *tr = trace_get_global_array();
         |                                        ^~~~~~~~~~~~~~~~~~~~~~
         |                                        ftrace_init_global_array_ops
>> kernel/trace/trace_output.c:202:40: error: initialization of 'const struct trace_array *' from 'int' makes pointer from integer without a cast [-Wint-conversion]


vim +202 kernel/trace/trace_output.c

   196	
   197	const char *
   198	trace_print_bitmask_seq(struct trace_seq *p, void *bitmask_ptr,
   199				unsigned int bitmask_size)
   200	{
   201		const char *ret = trace_seq_buffer_ptr(p);
 > 202		const struct trace_array *tr = trace_get_global_array();
   203		bool show_bitmask_list = tr->trace_flags &
   204					 TRACE_ITER(BITMASK_LIST);
   205	
   206		trace_seq_bitmask(p, bitmask_ptr, bitmask_size * 8,
   207				  show_bitmask_list);
   208		trace_seq_putc(p, 0);
   209	
   210		return ret;
   211	}
   212	EXPORT_SYMBOL_GPL(trace_print_bitmask_seq);
   213	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
