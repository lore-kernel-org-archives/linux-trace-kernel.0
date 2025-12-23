Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD54242D9B;
	Tue, 23 Dec 2025 22:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766529284; cv=none; b=BG7PtDXIEusnSBHzPBU2dcX2MS4rq23vGkkrQoyC5ij4LcMJ7u4bevOXfgA26ZYZpgUBVELZViJfh0Cdz6zd+dldaDW40KXkyMyAhvnrrntzueMH3JtPHjqToyUEkCtqe2LHy+JF8qORFLVflzTX0InBzb40K+Boxu+1CecWZtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766529284; c=relaxed/simple;
	bh=Fes5loOBsU+mC0Ceq2TtLjtj3mpKZi3TTjEVwXp7psU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D7t8+rtOdhoYowWbuC5/xiEMy4y1o4Spc9lfCGM8nlcZP51z4/dxmHlgb2l3J2yxtk77jhyjhU+xyjjrEMZjoE53XJ144FU8SN1usNU6M/p6YtDvRF2Cf5sFw8DlsBPLkE1zDXwBrRjh4lpPmATbGRDLiAL62Zj19P7Nat/DIh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DN+8W+Dh; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DN+8W+Dh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766529283; x=1798065283;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Fes5loOBsU+mC0Ceq2TtLjtj3mpKZi3TTjEVwXp7psU=;
  b=DN+8W+DhrAHUUEqjjd2UebXZVTEg2omWxL9EjbfxVy4k+5gXyW7uTfp0
   hAGBxnCA2bDlEVVknG58dMh4NpJgPrTehu1PAIytXmQTZPgYHNs4oxrOC
   DSxnjBGovPBi1DzyZ/VeJnA1aKEbFf14rFPAjggS8HFYeAUrHaHhhAtQt
   r1PuHvnZ7hqb0DYYup2AiHg1wN/3lnO2hO3jzA3ZlTgIZqtbtH8m6t841
   CxrB7VpLiqIF1a7rp3f1FsxALEuuiRsJPWTpF748kLyiQyrzVCChiWj64
   sT18rFNpCxCo7JpMgQZp/CAsQkKMVTKsrG9o+O5Gc4SXNR2FeCTH7Kpg9
   w==;
X-CSE-ConnectionGUID: s0azDM5YTXCSSqisgF6WUA==
X-CSE-MsgGUID: mHsPy1L2SLKo+1MJ0yzjdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11651"; a="79099102"
X-IronPort-AV: E=Sophos;i="6.21,172,1763452800"; 
   d="scan'208";a="79099102"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2025 14:34:41 -0800
X-CSE-ConnectionGUID: kdb3EiWAQeqPbPvmCjRM3w==
X-CSE-MsgGUID: YKgfYRbQRqympAkXtZtTdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,172,1763452800"; 
   d="scan'208";a="204414911"
Received: from lkp-server02.sh.intel.com (HELO dd3453e2b682) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 23 Dec 2025 14:34:38 -0800
Received: from kbuild by dd3453e2b682 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vYAxg-000000002RN-0Dgu;
	Tue, 23 Dec 2025 22:34:36 +0000
Date: Wed, 24 Dec 2025 06:33:47 +0800
From: kernel test robot <lkp@intel.com>
To: Aaron Tomlin <atomlin@atomlin.com>, rostedt@goodmis.org,
	mhiramat@kernel.org, mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com, corbet@lwn.net
Cc: oe-kbuild-all@lists.linux.dev, atomlin@atomlin.com, sean@ashe.io,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH] tracing: Add bitmask-list option for human-readable
 bitmask display
Message-ID: <202512240638.SumtF5C4-lkp@intel.com>
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
config: s390-randconfig-r071-20251224 (https://download.01.org/0day-ci/archive/20251224/202512240638.SumtF5C4-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251224/202512240638.SumtF5C4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512240638.SumtF5C4-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   kernel/trace/trace_output.c: In function 'trace_print_bitmask_seq':
>> kernel/trace/trace_output.c:202:33: error: implicit declaration of function 'trace_get_global_array'; did you mean 'ftrace_init_global_array_ops'? [-Werror=implicit-function-declaration]
     const struct trace_array *tr = trace_get_global_array();
                                    ^~~~~~~~~~~~~~~~~~~~~~
                                    ftrace_init_global_array_ops
>> kernel/trace/trace_output.c:202:33: warning: initialization of 'const struct trace_array *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
   cc1: some warnings being treated as errors


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
