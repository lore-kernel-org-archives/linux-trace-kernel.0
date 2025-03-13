Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9162690F6;
	Thu, 13 Mar 2025 16:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741882087; cv=none; b=NjYPLUZYUsV/b3HWiUFCuKBXcQYhPw/vas+ObAIXk89+iP6RdGXVCs/nvdl4fjtVsJFjnGVWPjmX9FHTUkoZSWEv+C8vP3uUbaq1cYIrDQufVwVV7X0ABjEmPqgt5SNLAbzwcvE/vf3lvRank9OWrknTkke+jTx8zaFyDpsGTtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741882087; c=relaxed/simple;
	bh=uiO8My9dexLqKjb5e3gJbZmS4+WUeImqOrR3ZNC2bhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SvpwEpD+fgopuc/CwDzqbuQSLclFP3t+xQel5imPvZtVvVI4VLA+1wMvWVr841to3ifnprnH/D7v3KSQqbbvochT6qxnroMuqr2hcWeX/LX8oMAj+Q9i3+EdVBwFEkwd5Sk9oiQAfTrghrupjpDzMCNnp9ojgO2eMewRzYaiCAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=fail smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KYQSjbi8; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KYQSjbi8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741882086; x=1773418086;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uiO8My9dexLqKjb5e3gJbZmS4+WUeImqOrR3ZNC2bhg=;
  b=KYQSjbi8mwLs3nWVL1turjT879E7aeIhOUiSsdeLzU0R6JUs5nF1Tkon
   2iDWbwprDvWGTIU+TafzgWeZik0vLgSWjp4CrfctxOkBCQVHwm0+TPloV
   c7K5xzzMgzLpCz+0012pESPFd7t6mxxzHN0hdLSZPpqaYjkgfR5Ej7BAu
   5+gNbhrpwy8ishmVhiWqCMbDymkwuSDHd2YgYLFvJh1iu7C/leS6sUIna
   71vQfOGH2ifNrkboLir+jzF38hZg/DZwAkBygI1culiSnYFwCMilrFhCu
   08nQOAfMKROIwgYXjkR9f5h1M0WvOh4fi9N2L6FGp+hqTASFUZ1e7FHMS
   Q==;
X-CSE-ConnectionGUID: XHJz9mtKTUaagkhvg/qCkA==
X-CSE-MsgGUID: wMjsN0mESxmFmzfFeXfOMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="42919149"
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="42919149"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 09:08:05 -0700
X-CSE-ConnectionGUID: 9OOSRdT4QFGZfrX2e2lbSA==
X-CSE-MsgGUID: arr/YG9GTjSRDu2Gp79T8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="121211093"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 13 Mar 2025 09:08:03 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tsl6G-0009dC-2b;
	Thu, 13 Mar 2025 16:08:00 +0000
Date: Fri, 14 Mar 2025 00:07:57 +0800
From: kernel test robot <lkp@intel.com>
To: Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>, john.ogness@linutronix.de,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Nam Cao <namcao@linutronix.de>, Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH 02/10] rv: Let the reactors take care of buffers
Message-ID: <202503132350.aM5NZ6Vh-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on trace/for-next]
[also build test ERROR on tip/x86/core tip/x86/mm linus/master v6.14-rc6 next-20250313]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nam-Cao/rv-Add-undef-TRACE_INCLUDE_FILE/20250312-011043
base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
patch link:    https://lore.kernel.org/r/90868f1dd49680ec63c961ec8c72ceb64f1af091.1741708239.git.namcao%40linutronix.de
patch subject: [PATCH 02/10] rv: Let the reactors take care of buffers
config: parisc-randconfig-002-20250313 (https://download.01.org/0day-ci/archive/20250313/202503132350.aM5NZ6Vh-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250313/202503132350.aM5NZ6Vh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503132350.aM5NZ6Vh-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/trace/rv/reactor_printk.c: In function 'rv_printk_reaction':
>> kernel/trace/rv/reactor_printk.c:20:9: error: implicit declaration of function 'vprintk_deferred'; did you mean '_printk_deferred'? [-Wimplicit-function-declaration]
      20 |         vprintk_deferred(msg, args);
         |         ^~~~~~~~~~~~~~~~
         |         _printk_deferred


vim +20 kernel/trace/rv/reactor_printk.c

    14	
    15	static void rv_printk_reaction(const char *msg, ...)
    16	{
    17		va_list args;
    18	
    19		va_start(args, msg);
  > 20		vprintk_deferred(msg, args);
    21		va_end(args);
    22	}
    23	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
