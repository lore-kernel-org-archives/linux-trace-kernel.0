Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF44F448384;
	Wed,  2 Sep 2026 10:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788345415; cv=none; b=i88fRo40yp3KH+NyF6LHNTPyLTGT6zJbxuhwEazIwfBpQP9Kq/DaKp3d4wECe77hMXTzMsLe0vbXz+nbrsHhhrm00L6vq0IUe6ReDVIFMKTqqEN2caq3NUW4wOPlD5tnTOFJfbdNOtFBc0mMasi6xqEjbvXzcmWkKsXKv/19JcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788345415; c=relaxed/simple;
	bh=DtiljPF8RM3CbiZNvKGav7U5lwgYYje0es0kdk5KYoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FuBpE6Tm0xoTLZ5Bppg76D5U7SuArrjMAjPFkbMGRG3mEeEBNGUXlL6QpvpZXEPE2ASky32es/atHFWaiNGKCNKJ2FxURfO/+jLTrBvhoiH/lxBCiEz6pj3nPIJ08UY5s1T67SSWdqWiDarmoIsAEeXufSQDsLLv/S6nqjATaHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kN+/lwtF; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kN+/lwtF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788345414; x=1819881414;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DtiljPF8RM3CbiZNvKGav7U5lwgYYje0es0kdk5KYoM=;
  b=kN+/lwtF96baCEs+ZZihMBz5R6r8xrm0u5y/kosOuGMZcTj2hALfXy8G
   8TOewLR1z1UGcic8k9rGso5r/N/UKfEtv7795Mxn/8lWllP/ZoK6UMGFL
   kuGmIsgljoxYK1i2TWKXO3IxrfCgGY0JIz3b9EjzKhrUcUopV32fwG6g5
   gSWW5Oh9CrAgfV8sx0uswzJrAldCJ8z54SzRBCBK/1aYjEVmOuOBvujmm
   bg24o9nraQZhss49qGxYNjrx6Wz9S7tdYeagjCw9OUTFeYJpj8hp7YAx7
   f6vCPqYjb/GNV8i3nCDYnho0f1GruQXRRgNlluIu4lJvlKGcfNLf2f53K
   g==;
X-CSE-ConnectionGUID: 8qd4xWy8RiWvRJtQBD2DKg==
X-CSE-MsgGUID: dsRGBIOaT+y/UWLS4ZWhNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="114342807"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="114342807"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 03:36:53 -0700
X-CSE-ConnectionGUID: CQ/lMKj7RZKsXUPxxDEqPQ==
X-CSE-MsgGUID: EFNWThchQvy/tpF0MEAVpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="266770023"
Received: from lkp-server01.sh.intel.com (HELO bfac249b2189) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 02 Sep 2026 03:36:51 -0700
Received: from kbuild by bfac249b2189 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x1iKm-000000002Py-3Bpi;
	Wed, 02 Sep 2026 10:36:48 +0000
Date: Wed, 2 Sep 2026 18:36:45 +0800
From: kernel test robot <lkp@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing: Take trace_array reference when opening options
 file
Message-ID: <202609021814.YH14WR0q-lkp@intel.com>
References: <20260901163620.6cbe0ada@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901163620.6cbe0ada@gandalf.local.home>

Hi Steven,

kernel test robot noticed the following build warnings:

[auto build test WARNING on trace/for-next]
[also build test WARNING on linus/master v7.3-rc1 next-20260901]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Steven-Rostedt/tracing-Take-trace_array-reference-when-opening-options-file/20260901-163620
base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
patch link:    https://lore.kernel.org/r/20260901163620.6cbe0ada%40gandalf.local.home
patch subject: [PATCH] tracing: Take trace_array reference when opening options file
config: openrisc-randconfig-r072-20260902 (https://download.01.org/0day-ci/archive/20260902/202609021814.YH14WR0q-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 14.3.0
smatch: v0.5.0-9187-g5189e3fb
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260902/202609021814.YH14WR0q-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609021814.YH14WR0q-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/trace/trace.c: In function 'trace_array_options_get':
>> kernel/trace/trace.c:7871:30: warning: comparison of distinct pointer types lacks a cast [-Wcompare-distinct-pointer-types]
    7871 |                 if (tr_index >= &tr->trace_flags_index[0] &&
         |                              ^~
   kernel/trace/trace.c:7872:30: warning: comparison of distinct pointer types lacks a cast [-Wcompare-distinct-pointer-types]
    7872 |                     tr_index < &tr->trace_flags_index[TRACE_FLAGS_MAX_SIZE])
         |                              ^


vim +7871 kernel/trace/trace.c

  7844	
  7845	/*
  7846	 * The tr_index is the address of a trace_array->trace_flags_index[]
  7847	 * element that holds the index of the trace flag. But since the
  7848	 * trace_array reference has not been taken yet, it cannot be referenced
  7849	 * as it could have been freed by a rmdir of the instance the trace_array
  7850	 * represents.
  7851	 *
  7852	 * Search the list of trace_arrays and compare the tr_index to the
  7853	 * address of the entire trace_array trace_flags_index array for each
  7854	 * trace_array in the list. If one is matched, then take the reference
  7855	 * and return it. If not, the trace_array no longer exits.
  7856	 */
  7857	static int trace_array_options_get(void *tr_index)
  7858	{
  7859		struct trace_array *tr;
  7860		int ret;
  7861	
  7862		ret = security_locked_down(LOCKDOWN_TRACEFS);
  7863		if (ret)
  7864			return ret;
  7865	
  7866		if (tracing_disabled)
  7867			return -ENODEV;
  7868	
  7869		guard(mutex)(&trace_types_lock);
  7870		list_for_each_entry(tr, &ftrace_trace_arrays, list) {
> 7871			if (tr_index >= &tr->trace_flags_index[0] &&
  7872			    tr_index < &tr->trace_flags_index[TRACE_FLAGS_MAX_SIZE])
  7873				return __trace_array_get(tr);
  7874		}
  7875		return -ENODEV;
  7876	}
  7877	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
