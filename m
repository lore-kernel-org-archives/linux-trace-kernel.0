Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634BB21ADC7;
	Tue,  8 Apr 2025 22:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744151531; cv=none; b=cUAqWwpzn1JLKBIMDaGMmSM4JkrrUDvpnEVMPTZsNU2P0Yj42G45SiD07zACJtLTq08qqEf/PLPF8vG+t5tlpYWqtP9bbSvmYJGTfVypiyW/AlmNKE5nUO1kHUK+Qx08/UdnweDy+bkZiX+xQIn5mFVb1Dotwfv5z9CBszUhOmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744151531; c=relaxed/simple;
	bh=b0bXRgqQnmm2cNRFGm8SjalL6upzrz3+tOd/LgkS0gI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aWItn/IDsBJdcUvp/1LpyZG/6Wvr/Hxr9fVSeGA0W/NWiMz8fAYGDtvkWI8yJpFGCHpBgu4yznkmnxbxZ0qOi5VqGIBRY1v1Jnb2llQMPzkk3943rzTcewvhcnRwtaVV5ur2DEKGlncB1FdYpgNVqUTASZgcJ9rBSU/vFjyw87A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RMAsP9nQ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RMAsP9nQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744151529; x=1775687529;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b0bXRgqQnmm2cNRFGm8SjalL6upzrz3+tOd/LgkS0gI=;
  b=RMAsP9nQKdu7teYsupDcXoychgNcV5n/jEI6OwVIUljdZzeqHTAn0Z1O
   /pGtB0N972nF9cinYgU99Wz320oiwV0dwBYr2Og9lbMCn9b2iD8/mmxCI
   yuR1xmsmfn4iVy0+d/ZIJOdmC84CgPgLoPRThhIalzriDjlpblfqbCe4f
   TgzkqJOhpFeEN9YQnCIKt5xi6oIAhIFymx898m2RlfhuZXnxMnIjRPsJq
   PhKk0cA8by5Kwg+CIOwq09LmSlqFoPKTVrvSGlYRD0cd5EXdKtJcG+Hsa
   xsA7SkBvRGq1cPB7XdLA2bauCP5PSnKi7LEpwHzfkxGjdsFyzpdr3wMN6
   g==;
X-CSE-ConnectionGUID: kHUySt70TxGjNo6SRTVW5w==
X-CSE-MsgGUID: p8ATdJyIQQGv4IhrdptkkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="68085744"
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="68085744"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 15:32:09 -0700
X-CSE-ConnectionGUID: aP+z0NrzTryiGi6q0VfaUw==
X-CSE-MsgGUID: 6AYdNThmRlmvePPfHRrbKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="128935856"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 08 Apr 2025 15:32:04 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u2HU9-000827-1C;
	Tue, 08 Apr 2025 22:32:01 +0000
Date: Wed, 9 Apr 2025 06:31:49 +0800
From: kernel test robot <lkp@intel.com>
To: Andy Chiu <andybnac@gmail.com>, linux-riscv@lists.infradead.org,
	alexghiti@rivosinc.com, palmer@dabbelt.com
Cc: oe-kbuild-all@lists.linux.dev, Andy Chiu <andybnac@gmail.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Alexandre Ghiti <alex@ghiti.fr>, bjorn@rivosinc.com,
	puranjay12@gmail.com, paul.walmsley@sifive.com,
	greentime.hu@sifive.com, nick.hu@sifive.com, nylon.chen@sifive.com,
	eric.lin@sifive.com, vicent.chen@sifive.com, zong.li@sifive.com,
	yongxuan.wang@sifive.com, samuel.holland@sifive.com,
	olivia.chu@sifive.com, c2232430@gmail.com
Subject: Re: [PATCH v4 04/12] kernel: ftrace: export ftrace_sync_ipi
Message-ID: <202504090657.5fiH4UIS-lkp@intel.com>
References: <20250407180838.42877-4-andybnac@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407180838.42877-4-andybnac@gmail.com>

Hi Andy,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.15-rc1 next-20250408]
[cannot apply to trace/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Chiu/riscv-ftrace-factor-out-code-defined-by-WITH_ARG/20250408-025114
base:   linus/master
patch link:    https://lore.kernel.org/r/20250407180838.42877-4-andybnac%40gmail.com
patch subject: [PATCH v4 04/12] kernel: ftrace: export ftrace_sync_ipi
config: xtensa-randconfig-001-20250409 (https://download.01.org/0day-ci/archive/20250409/202504090657.5fiH4UIS-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250409/202504090657.5fiH4UIS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504090657.5fiH4UIS-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/trace/ftrace.c:191:6: warning: no previous prototype for 'ftrace_sync_ipi' [-Wmissing-prototypes]
     191 | void ftrace_sync_ipi(void *data)
         |      ^~~~~~~~~~~~~~~


vim +/ftrace_sync_ipi +191 kernel/trace/ftrace.c

   190	
 > 191	void ftrace_sync_ipi(void *data)
   192	{
   193		/* Probably not needed, but do it anyway */
   194		smp_rmb();
   195	}
   196	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
