Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B320A1D79B6;
	Thu, 13 Mar 2025 16:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741882088; cv=none; b=nEeswRocOgW9cWfmYoE40WJXisdSn/ZTLTrYWBwswcWtGXyd4Da5gsekG2QSmVEZT1BIvwdIniPaGKGgxjQAnYSJdS7PbzbcGToopQw9RnD7flWKmPxXI/rd49e1BxzHzCy9iLQSU/AGYHCF4xBvuHiiATWBig8YXxCiWMLMD/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741882088; c=relaxed/simple;
	bh=nYRIPFDLfTAJRGdIBTN3YC2jdFXl728Rzr1qp1OMQKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JvPDvfgR3k7mUzn85jKz0DTiSmq5K6DgwwheTlDrAXRzKspNF/a2ch43hWA4Ys8WSM4Fflp2jn1LSFaIJ3LJfU1jGr3JjJxBvVd7lNtBupQsaira4wBz7iCPV3a3PD1kzz1PcvdbNCyWHrUu8Y0R3Z5hABcAusNdrenmhZAgzq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I4OTSr7w; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I4OTSr7w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741882085; x=1773418085;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nYRIPFDLfTAJRGdIBTN3YC2jdFXl728Rzr1qp1OMQKg=;
  b=I4OTSr7wbLF+ADgwFZRHGVF9+4IA1DMcPIzTuWAO6sGU6yR8TQWzhKkC
   ws9vq2b/0IQ9aHFZRqvPYuxiPWnUiycJovIK6d7WOFfQLoxEUPNzwFBHl
   CkhpC3zNAfFmT0fLDym9o2XtoSnHuedSTi1fzFk2oNK2Y90sEMpE+/HDJ
   WPqzUpsR5x9Ny1CXvkwM65CyOlVc2ucjQaLhWOuOXDL3AwKRtzRqr5A2Q
   vZYDerZicufT11LQeLbqgV/jABzXKLPDCvomQd22zK0y68/vsPdrMBE5L
   OqpmpAb6WhRR3Y/yqTatsy/t+mplN223n1s7yVQQYNDL6EevvULB8HYGq
   w==;
X-CSE-ConnectionGUID: x496wapZSLmoDccE+IT0XQ==
X-CSE-MsgGUID: 15yUIGdGRlOh5ln7dqqjew==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="42179549"
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="42179549"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 09:08:05 -0700
X-CSE-ConnectionGUID: J8ygePnUSvyBvArfA4sFQA==
X-CSE-MsgGUID: FnfEuMhrQqySxDL4w6v9pA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="121496931"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 13 Mar 2025 09:08:03 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tsl6G-0009dA-2X;
	Thu, 13 Mar 2025 16:08:00 +0000
Date: Fri, 14 Mar 2025 00:07:56 +0800
From: kernel test robot <lkp@intel.com>
To: Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>, john.ogness@linutronix.de,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Nam Cao <namcao@linutronix.de>, Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH 02/10] rv: Let the reactors take care of buffers
Message-ID: <202503132340.zzBclxPj-lkp@intel.com>
References: <90868f1dd49680ec63c961ec8c72ceb64f1af091.1741708239.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90868f1dd49680ec63c961ec8c72ceb64f1af091.1741708239.git.namcao@linutronix.de>

Hi Nam,

kernel test robot noticed the following build warnings:

[auto build test WARNING on trace/for-next]
[also build test WARNING on tip/x86/core tip/x86/mm linus/master v6.14-rc6 next-20250313]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nam-Cao/rv-Add-undef-TRACE_INCLUDE_FILE/20250312-011043
base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
patch link:    https://lore.kernel.org/r/90868f1dd49680ec63c961ec8c72ceb64f1af091.1741708239.git.namcao%40linutronix.de
patch subject: [PATCH 02/10] rv: Let the reactors take care of buffers
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20250313/202503132340.zzBclxPj-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250313/202503132340.zzBclxPj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503132340.zzBclxPj-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/trace/rv/reactor_panic.c:19:18: warning: initialization left-hand side might be a candidate for a format attribute [-Wsuggest-attribute=format]
      19 |         .react = panic
         |                  ^~~~~


vim +19 kernel/trace/rv/reactor_panic.c

    15	
    16	static struct rv_reactor rv_panic = {
    17		.name = "panic",
    18		.description = "panic the system if an exception is found.",
  > 19		.react = panic
    20	};
    21	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
