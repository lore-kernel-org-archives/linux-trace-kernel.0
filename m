Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFB1142E8A;
	Wed, 22 May 2024 20:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716409611; cv=none; b=WFvnyyxq5ouwUQXxe7/8qaJsscFIiVsvbs1CsDsPG/7qBaHBDXxit9Z55WxJaEDnj5rctehVfBh6TRedmf9f2BI7BZh/nbFGI/QwU73YkNxqKbGUmZNdnhBPAG1s9w5dCschz7trUHfnTkSyIA2KFufGCeevKPfgSKc1hXaoo50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716409611; c=relaxed/simple;
	bh=PTiOczp2mzxEYJI4MT1GuN3UIP3h3LNBOO01otwTLUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pp2iYW/ELsxsEuHCdD5ig6avymY8w1adUxa70MKehnVip3jFI1Vj8gM/LZM5P2NLINjwBRfYRVuHrVRTWQMIE8sybLapRUw6xtPFpTg6WNlJXm9dOxmv2MQ3clsgjCN2FDf9w8Ozdy1n/1ApnuBu58/6pttyE2Dh4lcimDi8KHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FeyZGmPD; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FeyZGmPD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716409609; x=1747945609;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PTiOczp2mzxEYJI4MT1GuN3UIP3h3LNBOO01otwTLUY=;
  b=FeyZGmPDFtYqu8pv35V2T4fkJyyfwulbxcMMQzk+ExQsGY/c/W6Mq2m+
   GlKgSO2IoKM7kapilLqGQjD5gWS6bVDt3ItCLRpvpu4FAFyycy/lWqC4C
   nXGRJoS+bSYkJNXm0+JzqqSLznQEoLDsbSyGD9GV7sW1xr29vZbKG8pat
   b05uxjslsRwDsfKcFzCBJopPvzh5/XEHV7dXOpQaIA27evFXKVE+LcXaP
   NZ774fB9hEsVHliwbY0Ynbh+eKS+OnoxD//ncf6IlspbDT7BV8RJLkOwq
   y9eqWHPMto3U8xx8FJftAUTFT4gKGuBBT5cpOg7l2ghvFGBsnrLh28agJ
   Q==;
X-CSE-ConnectionGUID: PWXBMVWzSv2ePdL9cvJGlg==
X-CSE-MsgGUID: GbAHhUTITyyrdir4KCN1OQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="30189648"
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="30189648"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 13:26:49 -0700
X-CSE-ConnectionGUID: cgc9YBcSTqWKQMMmFJRK/Q==
X-CSE-MsgGUID: NRL6tzc+Q5KVb2a3BwNPJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="37800567"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 22 May 2024 13:26:43 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s9sXo-0001wn-10;
	Wed, 22 May 2024 20:26:40 +0000
Date: Thu, 23 May 2024 04:25:56 +0800
From: kernel test robot <lkp@intel.com>
To: Sukrit Bhatnagar <Sukrit.Bhatnagar@sony.com>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Christoph Lameter <cl@linux-foundation.org>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, Sukrit.Bhatnagar@sony.com
Subject: Re: [PATCH 1/2] mm: printk: introduce new format %pGs for slab flags
Message-ID: <202405230441.A0LFA9SY-lkp@intel.com>
References: <20240522074629.2420423-2-Sukrit.Bhatnagar@sony.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522074629.2420423-2-Sukrit.Bhatnagar@sony.com>

Hi Sukrit,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on akpm-mm/mm-nonmm-unstable linus/master v6.9 next-20240522]
[cannot apply to vbabka-slab/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sukrit-Bhatnagar/mm-printk-introduce-new-format-pGs-for-slab-flags/20240522-154443
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20240522074629.2420423-2-Sukrit.Bhatnagar%40sony.com
patch subject: [PATCH 1/2] mm: printk: introduce new format %pGs for slab flags
config: x86_64-randconfig-123-20240522 (https://download.01.org/0day-ci/archive/20240523/202405230441.A0LFA9SY-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240523/202405230441.A0LFA9SY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405230441.A0LFA9SY-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> lib/test_printf.c:692:15: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long [addressable] [assigned] flags @@     got restricted slab_flags_t @@
   lib/test_printf.c:692:15: sparse:     expected unsigned long [addressable] [assigned] flags
   lib/test_printf.c:692:15: sparse:     got restricted slab_flags_t
   lib/test_printf.c:708:49: sparse: sparse: cast from restricted gfp_t
   lib/test_printf.c:712:58: sparse: sparse: cast from restricted gfp_t
   lib/test_printf.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/umh.h, include/linux/kmod.h, ...):
   include/linux/page-flags.h:240:46: sparse: sparse: self-comparison always evaluates to false
   include/linux/page-flags.h:240:46: sparse: sparse: self-comparison always evaluates to false

vim +692 lib/test_printf.c

   656	
   657	static void __init
   658	flags(void)
   659	{
   660		unsigned long flags;
   661		char *cmp_buffer;
   662		gfp_t gfp;
   663		unsigned int page_type;
   664	
   665		cmp_buffer = kmalloc(BUF_SIZE, GFP_KERNEL);
   666		if (!cmp_buffer)
   667			return;
   668	
   669		flags = 0;
   670		page_flags_test(0, 0, 0, 0, 0, flags, "", cmp_buffer);
   671	
   672		flags = 1UL << NR_PAGEFLAGS;
   673		page_flags_test(0, 0, 0, 0, 0, flags, "", cmp_buffer);
   674	
   675		flags |= 1UL << PG_uptodate | 1UL << PG_dirty | 1UL << PG_lru
   676			| 1UL << PG_active | 1UL << PG_swapbacked;
   677		page_flags_test(1, 1, 1, 0x1fffff, 1, flags,
   678				"uptodate|dirty|lru|active|swapbacked",
   679				cmp_buffer);
   680	
   681		flags = VM_READ | VM_EXEC | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;
   682		test("read|exec|mayread|maywrite|mayexec", "%pGv", &flags);
   683	
   684		flags = 0;
   685		scnprintf(cmp_buffer, BUF_SIZE, "%#x(%s)", (unsigned int) flags, "");
   686		test(cmp_buffer, "%pGs", &flags);
   687	
   688		flags = 1U << _SLAB_FLAGS_LAST_BIT;
   689		scnprintf(cmp_buffer, BUF_SIZE, "%#x(%s)", (unsigned int) flags, "");
   690		test(cmp_buffer, "%pGs", &flags);
   691	
 > 692		flags = SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_NO_USER_FLAGS;
   693		scnprintf(cmp_buffer, BUF_SIZE, "%#x(%s)", (unsigned int) flags,
   694			  "HWCACHE_ALIGN|PANIC|NO_USER_FLAGS");
   695		test(cmp_buffer, "%pGs", &flags);
   696	
   697		gfp = GFP_TRANSHUGE;
   698		test("GFP_TRANSHUGE", "%pGg", &gfp);
   699	
   700		gfp = GFP_ATOMIC|__GFP_DMA;
   701		test("GFP_ATOMIC|GFP_DMA", "%pGg", &gfp);
   702	
   703		gfp = __GFP_HIGH;
   704		test("__GFP_HIGH", "%pGg", &gfp);
   705	
   706		/* Any flags not translated by the table should remain numeric */
   707		gfp = ~__GFP_BITS_MASK;
   708		snprintf(cmp_buffer, BUF_SIZE, "%#lx", (unsigned long) gfp);
   709		test(cmp_buffer, "%pGg", &gfp);
   710	
   711		snprintf(cmp_buffer, BUF_SIZE, "__GFP_HIGH|%#lx",
   712								(unsigned long) gfp);
   713		gfp |= __GFP_HIGH;
   714		test(cmp_buffer, "%pGg", &gfp);
   715	
   716		page_type = ~0;
   717		page_type_test(page_type, "", cmp_buffer);
   718	
   719		page_type = 10;
   720		page_type_test(page_type, "", cmp_buffer);
   721	
   722		page_type = ~PG_buddy;
   723		page_type_test(page_type, "buddy", cmp_buffer);
   724	
   725		page_type = ~(PG_table | PG_buddy);
   726		page_type_test(page_type, "table|buddy", cmp_buffer);
   727	
   728		kfree(cmp_buffer);
   729	}
   730	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
