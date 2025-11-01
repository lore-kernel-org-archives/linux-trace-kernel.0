Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731F830101D;
	Sat,  1 Nov 2025 18:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762021242; cv=none; b=jCzHNrxLrsE8WuBg/b0brroz89+ZJ0NcnRVTBMAD9j1+cB1MKDpHf3fjGGzjvM8ZlNsB+Wah9T/0/OTmiexz2vlC15hoZMdTot8uUt9mso8jWUVN1ZK5sxjfBg2uDU+UD9B15w47mLgy2E+EttjI2ENV0SAasvnDv5Zq/iMO6w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762021242; c=relaxed/simple;
	bh=wctQo2sQS2IeFVkzrGEKm4QgBJQP6Do/o0doA3HMcmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T9qQav1IVUTard46h/v0vxHCaWdcEuOI++pm9d5PmuRkFgySXtJN2oftDoC/ztE+OLsinqrU1pp1RYURZMsPCbraGZi/nH1ydQU4EdZP5LQ+yxvGBVTdxlqrVoTjykHGfbpYirIqrUtsIwqZtXBn+mMEujSlZhKEMaf0cZd3+jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ggX/QGSm; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ggX/QGSm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762021241; x=1793557241;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wctQo2sQS2IeFVkzrGEKm4QgBJQP6Do/o0doA3HMcmY=;
  b=ggX/QGSmWdyODOGW3XqCVSHdQw6LqbppGYLmMk1PTmf03pMCFExvsXeT
   yWh3ndnNCl/Ono+RBjod+pNOOB332OCRxEYlMbMg08h1m5u3dT7yuOa7+
   4lSfaSPGvC7dBTqiY0OGzHguEodLcZVwXI/NRKs+uLRnicoCna62OsSab
   EXBmdEVOMJoywouGFM4S1dX+l7JVidQdex3UXhFVq6HDVn1O1jDOON3+i
   2Q/Yv1F+gMwZdmEOAXIFXc67rXIhkkAu0T+0wNTkL8Ep8SmzacMdKbwTk
   f5u9KQG56yibuaE+ZahY4V9tEg0uF+juuf6yOPBDdyM78iC2FFl0SaSX7
   A==;
X-CSE-ConnectionGUID: CCecyGerTTO/SsV6riPKEg==
X-CSE-MsgGUID: SBW5DS7MTOm6i/XLUjjDxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11600"; a="64077072"
X-IronPort-AV: E=Sophos;i="6.19,272,1754982000"; 
   d="scan'208";a="64077072"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2025 11:20:40 -0700
X-CSE-ConnectionGUID: LAHlsHgkRSSwJsptzqbMEw==
X-CSE-MsgGUID: a1oY91SfQfKF7k/Jz5dtkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,272,1754982000"; 
   d="scan'208";a="186828114"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 01 Nov 2025 11:20:38 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vFGDL-000OZk-2Q;
	Sat, 01 Nov 2025 18:20:35 +0000
Date: Sun, 2 Nov 2025 02:20:05 +0800
From: kernel test robot <lkp@intel.com>
To: Menglong Dong <menglong8.dong@gmail.com>, mhiramat@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, rostedt@goodmis.org, jolsa@kernel.org,
	mathieu.desnoyers@efficios.com, jiang.biao@linux.dev,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing: fprobe: use ftrace if
 CONFIG_DYNAMIC_FTRACE_WITH_ARGS
Message-ID: <202511020220.bv169Bd9-lkp@intel.com>
References: <20251031024038.19176-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031024038.19176-1-dongml2@chinatelecom.cn>

Hi Menglong,

kernel test robot noticed the following build warnings:

[auto build test WARNING on trace/for-next]
[also build test WARNING on next-20251031]
[cannot apply to linus/master v6.18-rc3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Menglong-Dong/tracing-fprobe-use-ftrace-if-CONFIG_DYNAMIC_FTRACE_WITH_ARGS/20251031-104301
base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
patch link:    https://lore.kernel.org/r/20251031024038.19176-1-dongml2%40chinatelecom.cn
patch subject: [PATCH v2] tracing: fprobe: use ftrace if CONFIG_DYNAMIC_FTRACE_WITH_ARGS
config: loongarch-randconfig-002-20251102 (https://download.01.org/0day-ci/archive/20251102/202511020220.bv169Bd9-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251102/202511020220.bv169Bd9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511020220.bv169Bd9-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/trace/fprobe.c:340:13: warning: 'fprobe_set_ips' defined but not used [-Wunused-function]
     340 | static void fprobe_set_ips(unsigned long *ips, unsigned int cnt, int remove,
         |             ^~~~~~~~~~~~~~


vim +/fprobe_set_ips +340 kernel/trace/fprobe.c

   339	
 > 340	static void fprobe_set_ips(unsigned long *ips, unsigned int cnt, int remove,
   341				   int reset)
   342	{
   343		ftrace_set_filter_ips(&fprobe_graph_ops.ops, ips, cnt, remove, reset);
   344		ftrace_set_filter_ips(&fprobe_ftrace_ops, ips, cnt, remove, reset);
   345	}
   346	#else
   347	static int fprobe_ftrace_add_ips(unsigned long *addrs, int num)
   348	{
   349		return -ENOENT;
   350	}
   351	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
