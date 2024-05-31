Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B9316D304;
	Fri, 31 May 2024 17:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717174894; cv=none; b=WFFmRKwqO6vpp0ZnaAfyqHrBYg7dqPEtxcL307f0DflW5TPKgsRRphdCBttOjmfcRfAej4Bnsu1bxpxgBHnXQsfiRdM4xzz7dPwuKeU6B6gLfua4OYSIt/9CmwuA9jOn0HPhx2qSqrvsFIiDzpWiegaRY71uTfNGV0JrNkObLGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717174894; c=relaxed/simple;
	bh=Yjqo3hlhlx9yKevXhDT1MNENp9AFIIad+z8zrRdLuUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZmHNnTs8yfM63sRsdAiqby4yW0MxfVjWNDHk68XfBUt9mqPQNhndAp1uqzoJzf1KS+XFzyHSL7vyYHuPkCEz7bbJZFyBXZ+C7EfTXjkNZ9OGGcGGtAmiQsIdzDGLRy+Zt+kJzkwhP9QT7r4zIs09TlhNJqOOsXRUD4oW6wN/Vek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=faGKBjHC; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="faGKBjHC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717174891; x=1748710891;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Yjqo3hlhlx9yKevXhDT1MNENp9AFIIad+z8zrRdLuUs=;
  b=faGKBjHCipfYarK+ZtyukSvXvuDJ9nLLhH83jsdCuoPRrcXL4V7i0QDX
   KcQiwrp5uQyql6B0usuSccvDUAwWVCaBBp+8kNBzoa9HAFcAxmoNAT5XN
   +JJGQ08xnXTI2qFu4Y+uQ2Dg+as0/V0lfE6kIw/WdvPsxQJ6rXNmLtSKd
   lYbjN+ROiJ22MB5zzstaDoLd8qphUrMi1tg32HsiKJIfFUK6bWka5ByAN
   k2l/e+gl0Q63f2JqkE95EbNRxROzWFI3D9T3NYSGA84FCyKETVbdv6/9C
   51n3RUX6zDAQGEmL6uDNqv40pUeHcMr6GEO37OxGqQ50jZpGdD2MqFNcj
   w==;
X-CSE-ConnectionGUID: RDNgaDEyT9i9nmGA53wnEA==
X-CSE-MsgGUID: BdTQM0E6Sdu81V7bxIsj+A==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="31223123"
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="31223123"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 10:01:31 -0700
X-CSE-ConnectionGUID: kwv4Ne6VSaWer/Fbg//lww==
X-CSE-MsgGUID: UWrQa+u+SWK1A29eqgaOlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="36800309"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 31 May 2024 10:01:29 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sD5d8-000HUA-1N;
	Fri, 31 May 2024 17:01:26 +0000
Date: Sat, 1 Jun 2024 01:01:26 +0800
From: kernel test robot <lkp@intel.com>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	don <zds100@gmail.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org
Subject: Re: [PATCH] tracing/fprobe: Support raw tracepoint events on modules
Message-ID: <202406010034.fsNP9Rsq-lkp@intel.com>
References: <171714888633.198965.13093663631481169611.stgit@devnote2>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171714888633.198965.13093663631481169611.stgit@devnote2>

Hi Masami,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.10-rc1 next-20240531]
[cannot apply to rostedt-trace/for-next rostedt-trace/for-next-urgent]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Masami-Hiramatsu-Google/tracing-fprobe-Support-raw-tracepoint-events-on-modules/20240531-175013
base:   linus/master
patch link:    https://lore.kernel.org/r/171714888633.198965.13093663631481169611.stgit%40devnote2
patch subject: [PATCH] tracing/fprobe: Support raw tracepoint events on modules
config: s390-defconfig (https://download.01.org/0day-ci/archive/20240601/202406010034.fsNP9Rsq-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project bafda89a0944d947fc4b3b5663185e07a397ac30)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240601/202406010034.fsNP9Rsq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406010034.fsNP9Rsq-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/tracepoint.c:5:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:173:
   In file included from arch/s390/include/asm/mmu_context.h:11:
   In file included from arch/s390/include/asm/pgalloc.h:18:
   In file included from include/linux/mm.h:2253:
   include/linux/vmstat.h:500:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     500 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     501 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:507:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     507 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     508 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:519:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     519 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     520 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:528:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     528 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     529 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> kernel/tracepoint.c:751:34: error: no member named '__start___tracepoints_ptrs' in 'struct module'
     751 |                 for_each_tracepoint_range(mod->__start___tracepoints_ptrs,
         |                                           ~~~  ^
   5 warnings and 1 error generated.


vim +751 kernel/tracepoint.c

   738	
   739	void for_each_module_tracepoint(void (*fct)(struct tracepoint *tp, void *priv),
   740					void *priv)
   741	{
   742		struct tp_module *tp_mod;
   743		struct module *mod;
   744	
   745		if (!mod->num_tracepoints)
   746			return;
   747	
   748		mutex_lock(&tracepoint_module_list_mutex);
   749		list_for_each_entry(tp_mod, &tracepoint_module_list, list) {
   750			mod = tp_mod->mod;
 > 751			for_each_tracepoint_range(mod->__start___tracepoints_ptrs,
   752				mod->tracepoints_ptrs + mod->num_tracepoints,
   753				fct, priv);
   754		}
   755		mutex_unlock(&tracepoint_module_list_mutex);
   756	}
   757	#endif /* CONFIG_MODULES */
   758	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
