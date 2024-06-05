Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A8F33F7;
	Wed,  5 Jun 2024 01:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717550003; cv=none; b=fL5wRXeGaJ4g8AOfnZkj9Yu1qQDoYM66RoI2N50oJ2v3EYmLuJDIpcuwZvxl98XxMrjCfTAe+j2XIYTwtQGzNAQiwCC9SSZP8RxWBlGGKnWAbqhJ7ysHnScLkgSx127kXbZoh1+dao+0Le8a5mMrt0Y+3+siSKl4xJbNX6muFHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717550003; c=relaxed/simple;
	bh=ZnhpO+SaaVe7SfQ18lvTRbjoL1A+aSktVBV4/zdfVPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=od8GbttWhKcDTMiCrKpUl45D6pmmtLEMw5fyk6LQJZmzj9D+jEIHwFrrF5dBP5t8/3Qu1Jh0nv9zYPI2Pbp4IoF6lWF1n3lR2zpaBhYpBtaaQdFYJk+lcXJFVi6X0yLTkn2vK4cniMRYCR2UvtU2uY4hTmK/yXMNetNZ+VybNew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fw16AuQv; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fw16AuQv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717550003; x=1749086003;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZnhpO+SaaVe7SfQ18lvTRbjoL1A+aSktVBV4/zdfVPo=;
  b=fw16AuQvcKzQUPd84L5kdSB4eCqOFW3cNvXR7Y6Egg3bseltOixnIUrK
   i43VpBWDHaN0yBvlK+htKUGOIghcoJtSUJXo6yZac3TTNIDnaM+ddpQ5/
   cCwv21qxHFJXzIQi0ibd3fYr0ezGW52UZAo7rfVjRBJ48GAPuhAYAmiZL
   iGxQqrHUbxVMh3LLZrEwFZjRhiYpar1VW8fPEOlWGhyroXFK/9gZUvV6Q
   cxVV5R2up8KHO8zvw7DerLlrYholHmNcNrelIdaAAZSeNzFgjWv4jFMNm
   Z9lJRcc09Uf2wG09pOMFCIA/32W95qlc48ObgGizg9NliCQLujoeHoocw
   Q==;
X-CSE-ConnectionGUID: UIe7S29dRySJUFVzqAx+nw==
X-CSE-MsgGUID: SlJoQhqNSeudELlwSLXzOg==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="13972687"
X-IronPort-AV: E=Sophos;i="6.08,215,1712646000"; 
   d="scan'208";a="13972687"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 18:13:22 -0700
X-CSE-ConnectionGUID: /ryimpufTHep+SAbhphPnQ==
X-CSE-MsgGUID: yLBGF5lvSpK5r9LkbsI3ZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,215,1712646000"; 
   d="scan'208";a="42363945"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 04 Jun 2024 18:13:18 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sEfDH-0000k3-0x;
	Wed, 05 Jun 2024 01:13:15 +0000
Date: Wed, 5 Jun 2024 09:12:57 +0800
From: kernel test robot <lkp@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH 4/5] ftrace: Convert "filter_hash" and "inc" to bool in
 ftrace_hash_rec_update_modify()
Message-ID: <202406050838.7r32JzDI-lkp@intel.com>
References: <20240604212855.046127611@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604212855.046127611@goodmis.org>

Hi Steven,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on linus/master v6.10-rc2 next-20240604]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Steven-Rostedt/ftrace-Rename-dup_hash-and-comment-it/20240605-053138
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20240604212855.046127611%40goodmis.org
patch subject: [PATCH 4/5] ftrace: Convert "filter_hash" and "inc" to bool in ftrace_hash_rec_update_modify()
config: s390-defconfig (https://download.01.org/0day-ci/archive/20240605/202406050838.7r32JzDI-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project d7d2d4f53fc79b4b58e8d8d08151b577c3699d4a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240605/202406050838.7r32JzDI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406050838.7r32JzDI-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/trace/ftrace.c:17:
   In file included from include/linux/stop_machine.h:5:
   In file included from include/linux/cpu.h:17:
   In file included from include/linux/node.h:18:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:173:
   In file included from arch/s390/include/asm/mmu_context.h:11:
   In file included from arch/s390/include/asm/pgalloc.h:18:
   In file included from include/linux/mm.h:2245:
   include/linux/vmstat.h:484:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     484 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     485 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:491:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     491 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     492 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:498:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     498 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:503:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     503 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     504 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:512:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     512 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     513 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   In file included from kernel/trace/ftrace.c:18:
   In file included from include/linux/clocksource.h:22:
   In file included from arch/s390/include/asm/io.h:93:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     548 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
         |                                                           ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
     102 | #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
         |                                                      ^
   In file included from kernel/trace/ftrace.c:18:
   In file included from include/linux/clocksource.h:22:
   In file included from arch/s390/include/asm/io.h:93:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
         |                                                           ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
     115 | #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
         |                                                      ^
   In file included from kernel/trace/ftrace.c:18:
   In file included from include/linux/clocksource.h:22:
   In file included from arch/s390/include/asm/io.h:93:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:693:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     693 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:701:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     701 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:709:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     709 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:718:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     718 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:727:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     727 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:736:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     736 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
>> kernel/trace/ftrace.c:1961:13: error: conflicting types for 'ftrace_hash_rec_disable_modify'
    1961 | static void ftrace_hash_rec_disable_modify(struct ftrace_ops *ops,
         |             ^
   kernel/trace/ftrace.c:1384:1: note: previous declaration is here
    1384 | ftrace_hash_rec_disable_modify(struct ftrace_ops *ops, int filter_hash);
         | ^
>> kernel/trace/ftrace.c:1967:13: error: conflicting types for 'ftrace_hash_rec_enable_modify'
    1967 | static void ftrace_hash_rec_enable_modify(struct ftrace_ops *ops,
         |             ^
   kernel/trace/ftrace.c:1386:1: note: previous declaration is here
    1386 | ftrace_hash_rec_enable_modify(struct ftrace_ops *ops, int filter_hash);
         | ^
   17 warnings and 2 errors generated.


vim +/ftrace_hash_rec_disable_modify +1961 kernel/trace/ftrace.c

84261912ebee412 Steven Rostedt (Red Hat  2014-08-18  1960) 
84261912ebee412 Steven Rostedt (Red Hat  2014-08-18 @1961) static void ftrace_hash_rec_disable_modify(struct ftrace_ops *ops,
5177364f840058a Steven Rostedt (Google   2024-06-04  1962) 					   bool filter_hash)
84261912ebee412 Steven Rostedt (Red Hat  2014-08-18  1963) {
5177364f840058a Steven Rostedt (Google   2024-06-04  1964) 	ftrace_hash_rec_update_modify(ops, filter_hash, false);
84261912ebee412 Steven Rostedt (Red Hat  2014-08-18  1965) }
84261912ebee412 Steven Rostedt (Red Hat  2014-08-18  1966) 
84261912ebee412 Steven Rostedt (Red Hat  2014-08-18 @1967) static void ftrace_hash_rec_enable_modify(struct ftrace_ops *ops,
5177364f840058a Steven Rostedt (Google   2024-06-04  1968) 					  bool filter_hash)
84261912ebee412 Steven Rostedt (Red Hat  2014-08-18  1969) {
5177364f840058a Steven Rostedt (Google   2024-06-04  1970) 	ftrace_hash_rec_update_modify(ops, filter_hash, true);
84261912ebee412 Steven Rostedt (Red Hat  2014-08-18  1971) }
84261912ebee412 Steven Rostedt (Red Hat  2014-08-18  1972) 

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
