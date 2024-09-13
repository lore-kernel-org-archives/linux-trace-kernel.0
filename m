Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2441527B1;
	Fri, 13 Sep 2024 20:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726258285; cv=none; b=ruM07gbvt4hBR9P3Do1R5WAsQkDrj4mXKc8Oh23a+fjMSU2mdNrwKF2R68N8Xi3LSqDcuBB6kdpJz1q4+NN56wKzwJG7BHT5gSsTEzB7bcgeReEwTw1vDDyqXuUMz5JkHXguEUpJng/QlGtfNzUvrveRnYLVk6jBeRyPAWNInag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726258285; c=relaxed/simple;
	bh=KrbMlRrWnddy/v2g9DYSFXsxpZtGqQACNSxfRkmK8MA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a1+qLogqIGeyK9XdPodgpPhJYsep5XfruaTE3kKj8bBoNIEXfDVS+mesByzCrGPbXBVidywbLKK1oG/3mFRh0dj2WDgM23eGKqBAch9/2vd6tz62P84Y+UXOUQNaQX2wq+3qGxhyK62nikmHhb026xJnWhkHEEDLc1Ll4gtepTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ikorU5mW; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ikorU5mW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726258284; x=1757794284;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KrbMlRrWnddy/v2g9DYSFXsxpZtGqQACNSxfRkmK8MA=;
  b=ikorU5mWE80zrfEthi4LdbLQdFO52Zwthv9YiUCfk8thofBmobK95Xkt
   xPxPvPGBW1yTiajQ8xQNBtu8oEuGRz6SWDqbqxDHh5wJOFj9hmeXC5OB5
   eL0Fl2yRWBYatEQZXZH7RaXAQTUCF/0OYIZvoYWYtil1xjfs8thXqaTcC
   Sy9eo1zNMFdxdljjJ6otdEEc6dKNhSFcoGWDxNDZnrMIQfZfZ8/fzzBvw
   qFLiXCmgwxP7TejMG2CIJf0jn4JBrKW/kFhw8Zaaechkeotv7UyFUP9eR
   9BHl4tcfLN6C7Dj3HM4SFGhSWv3xgmK/qh1ml1an58p0lupRarG7kK/+p
   g==;
X-CSE-ConnectionGUID: +9OXtRWKS0WXn0CEQF1+Iw==
X-CSE-MsgGUID: ETEGM7fcTWulquKgPdTzeg==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="24712405"
X-IronPort-AV: E=Sophos;i="6.10,227,1719903600"; 
   d="scan'208";a="24712405"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 13:11:22 -0700
X-CSE-ConnectionGUID: p0m3HkP0T625lIOSnYXlsw==
X-CSE-MsgGUID: lCn4N0rjRkqcbFadFfXsKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,227,1719903600"; 
   d="scan'208";a="72774956"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 13 Sep 2024 13:11:20 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1spCdR-0006wT-2I;
	Fri, 13 Sep 2024 20:11:17 +0000
Date: Sat, 14 Sep 2024 04:10:19 +0800
From: kernel test robot <lkp@intel.com>
To: Liao Chang <liaochang1@huawei.com>, rostedt@goodmis.org,
	mhiramat@kernel.org, mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] function_graph: Simplify the initialization of fgraph
 LRU data
Message-ID: <202409140325.G1zsZ0jL-lkp@intel.com>
References: <20240912111550.1752115-1-liaochang1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912111550.1752115-1-liaochang1@huawei.com>

Hi Liao,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.11-rc7 next-20240913]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Liao-Chang/function_graph-Simplify-the-initialization-of-fgraph-LRU-data/20240912-193159
base:   linus/master
patch link:    https://lore.kernel.org/r/20240912111550.1752115-1-liaochang1%40huawei.com
patch subject: [PATCH] function_graph: Simplify the initialization of fgraph LRU data
config: arm-randconfig-004-20240913 (https://download.01.org/0day-ci/archive/20240914/202409140325.G1zsZ0jL-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project bf684034844c660b778f0eba103582f582b710c9)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240914/202409140325.G1zsZ0jL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409140325.G1zsZ0jL-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: ftrace_graph_entry_stub
   >>> referenced by arch/arm/kernel/entry-ftrace.o:(.text+0xB8) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
