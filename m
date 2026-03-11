Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EBE31AF14;
	Wed, 11 Mar 2026 11:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773228273; cv=none; b=keiNhIE03q5t2J1bmlFYlJ/78iVNqi5WFd9R9xM9NNQTvDSxzRc7ZoWM24f4Mav4NNlvKg53vvKwN2uZEO7ehYd+TaOTIDJrXVBMhtrxfd45+p2bMA1tPfsyWY5Qbh5hx7VUjLcbKfMlEP836p8UwGDFH3b4OsHp96UXVsyvSHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773228273; c=relaxed/simple;
	bh=MrItGMIwck97yHNleIjnWht9bi1GncmtA9PeyGCwBMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WmKNh90IABhcOhAPHUnUD4qtNfeszU4FQhcyEdSx6Lsm1DPzAj43zmHqB1uqaEPy5oPuEAtey7zY9Ea1lbEMCe4H8RBfpn6ISfsjUHjBc4HaM3ksAQnoDsMPYLRoDHCJYH8z1ccr2XVHVRsfnekKB/YdEyYT9uvrM6uEii1DRiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MYq4aiiN; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MYq4aiiN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773228270; x=1804764270;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MrItGMIwck97yHNleIjnWht9bi1GncmtA9PeyGCwBMs=;
  b=MYq4aiiNcAj5ktb+64ocsttd3c4a6hVf+QJrbRnHp9WdCeu1rugE3NK/
   7SMt82BAHNa5ILytFUEHU3Gp4s+SM5V0urn14EryCkXlXNthWR3CYrKEm
   jbibDNdWW570xIPk/7Nu6uD+fcL8sYi3pAksecEF35gMfVnD5ryUp/r4Q
   WzgOcfqu1NskvX3TIBnArsefiEnctznNtoymVl6b3ISvqMCVRf0XNOTWV
   xGdPuvBI0NaVMGPJnuZSwd1Dzk3kQIlTszicBIt8in1nYEC3nN3b4L1/y
   zHlOlpqggaV7uw7ipxat0I5t7fv7mIIyipwXK19SROWZ76Q1Kb79pBOkF
   A==;
X-CSE-ConnectionGUID: 5TMMtCu1SzSgsVMgQGuCoQ==
X-CSE-MsgGUID: ye5+/K3VTqWal0jEAvfB9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="76903766"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="76903766"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 04:24:29 -0700
X-CSE-ConnectionGUID: fw1E74arR96VolAP3q/Egw==
X-CSE-MsgGUID: gTH9KMjeTPWUWgVUI7QD2Q==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 418530b1a366) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 11 Mar 2026 04:24:25 -0700
Received: from kbuild by 418530b1a366 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w0Hfr-0000000014P-0HV2;
	Wed, 11 Mar 2026 11:24:23 +0000
Date: Wed, 11 Mar 2026 19:23:39 +0800
From: kernel test robot <lkp@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Brian Geffon <bgeffon@google.com>, John Stultz <jstultz@google.com>,
	Ian Rogers <irogers@google.com>,
	Suleiman Souhlal <suleiman@google.com>
Subject: Re: [PATCH v2 1/3] tracing: Have futex syscall trace event show
 specific user data
Message-ID: <202603111911.zAWpiGlz-lkp@intel.com>
References: <20260310201036.542627924@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310201036.542627924@kernel.org>

Hi Steven,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/locking/core]
[also build test WARNING on trace/for-next akpm-mm/mm-everything linus/master v7.0-rc3 next-20260310]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Steven-Rostedt/tracing-Have-futex-syscall-trace-event-show-specific-user-data/20260311-041422
base:   tip/locking/core
patch link:    https://lore.kernel.org/r/20260310201036.542627924%40kernel.org
patch subject: [PATCH v2 1/3] tracing: Have futex syscall trace event show specific user data
config: arc-randconfig-001-20260311 (https://download.01.org/0day-ci/archive/20260311/202603111911.zAWpiGlz-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 14.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260311/202603111911.zAWpiGlz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603111911.zAWpiGlz-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/trace/trace_syscalls.c: In function 'syscall_get_futex':
>> kernel/trace/trace_syscalls.c:807:15: warning: variable 'buf' set but not used [-Wunused-but-set-variable]
     807 |         char *buf;
         |               ^~~


vim +/buf +807 kernel/trace/trace_syscalls.c

   801	
   802	static int
   803	syscall_get_futex(unsigned long *args, char **buffer, int *size, int buf_size)
   804	{
   805		struct syscall_user_buffer *sbuf;
   806		const char __user *ptr;
 > 807		char *buf;
   808	
   809		/* buf_size of zero means user doesn't want user space read */
   810		if (!buf_size)
   811			return -1;
   812	
   813		/* If the syscall_buffer is NULL, tracing is being shutdown */
   814		sbuf = READ_ONCE(syscall_buffer);
   815		if (!sbuf)
   816			return -1;
   817	
   818		ptr = (char __user *)args[0];
   819	
   820		*buffer = trace_user_fault_read(&sbuf->buf, ptr, 4, NULL, NULL);
   821		if (!*buffer)
   822			return -1;
   823	
   824		/* Add room for the value */
   825		*size += 4;
   826	
   827		buf = *buffer;
   828	
   829		return 0;
   830	}
   831	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
