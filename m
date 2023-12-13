Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PeNtitCG"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D310BF5;
	Wed, 13 Dec 2023 05:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702474884; x=1734010884;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UHu+07MBRevDOSW1Tf5iIKC4rfKnsAW4POR/WWx6Gr0=;
  b=PeNtitCGHo6Z2DxOgHaRJwMCX92KgQ8uTtXwWfm0S4XQnWdi+sOyD1Sx
   JdwaQqEn5PQ+OAYsVTm2xWxEL6YYBH+H9dATGqP2eObOumQ5Ll7m0kWyi
   VvP6ZdyTQPFwyKumVwaBd+XfSxXiw4AmyYBoWO+xMqGsOkft6mIOXHXig
   gMxRLNIerquzOzFZbIGbDAewSWc9I7qA+3pMh40oh/jlKj3kxLiDLAUmn
   j1JqT5OhhqNEyZvfwx75VDmCebcSuM3LH1DmNjlk4zMwoEj4URqQigLSM
   4DLI3aVoIJiX+In3OZalr1Gh1RKRAl2LPLZlCaaiV3J8egsuL10FotVw6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="461439317"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="461439317"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 05:41:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="892023724"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="892023724"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 13 Dec 2023 05:41:17 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rDPUB-000Kcx-1a;
	Wed, 13 Dec 2023 13:41:15 +0000
Date: Wed, 13 Dec 2023 21:41:10 +0800
From: kernel test robot <lkp@intel.com>
To: Alexander Graf <graf@amazon.com>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org,
	linux-doc@vger.kernel.org, x86@kernel.org,
	Eric Biederman <ebiederm@xmission.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Rob Herring <robh+dt@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	James Gowans <jgowans@amazon.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	arnd@arndb.de, pbonzini@redhat.com, madvenka@linux.microsoft.com,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Usama Arif <usama.arif@bytedance.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 06/15] arm64: Add KHO support
Message-ID: <202312132139.g2NKV67G-lkp@intel.com>
References: <20231213000452.88295-7-graf@amazon.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213000452.88295-7-graf@amazon.com>

Hi Alexander,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/x86/core]
[also build test WARNING on arm64/for-next/core akpm-mm/mm-everything linus/master v6.7-rc5 next-20231213]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexander-Graf/mm-memblock-Add-support-for-scratch-memory/20231213-080941
base:   tip/x86/core
patch link:    https://lore.kernel.org/r/20231213000452.88295-7-graf%40amazon.com
patch subject: [PATCH 06/15] arm64: Add KHO support
config: microblaze-randconfig-r133-20231213 (https://download.01.org/0day-ci/archive/20231213/202312132139.g2NKV67G-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231213/202312132139.g2NKV67G-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312132139.g2NKV67G-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/of/fdt.c:1012:13: sparse: sparse: symbol 'early_init_dt_check_kho' was not declared. Should it be static?

vim +/early_init_dt_check_kho +1012 drivers/of/fdt.c

  1008	
  1009	/**
  1010	 * early_init_dt_check_kho - Decode info required for kexec handover from DT
  1011	 */
> 1012	void __init early_init_dt_check_kho(void)
  1013	{
  1014	#ifdef CONFIG_KEXEC_KHO
  1015		unsigned long node = chosen_node_offset;
  1016		u64 kho_start, scratch_start, scratch_size, mem_start, mem_size;
  1017		const __be32 *p;
  1018		int l;
  1019	
  1020		if ((long)node < 0)
  1021			return;
  1022	
  1023		p = of_get_flat_dt_prop(node, "linux,kho-dt", &l);
  1024		if (l != (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32))
  1025			return;
  1026	
  1027		kho_start = dt_mem_next_cell(dt_root_addr_cells, &p);
  1028	
  1029		p = of_get_flat_dt_prop(node, "linux,kho-scratch", &l);
  1030		if (l != (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32))
  1031			return;
  1032	
  1033		scratch_start = dt_mem_next_cell(dt_root_addr_cells, &p);
  1034		scratch_size = dt_mem_next_cell(dt_root_addr_cells, &p);
  1035	
  1036		p = of_get_flat_dt_prop(node, "linux,kho-mem", &l);
  1037		if (l != (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32))
  1038			return;
  1039	
  1040		mem_start = dt_mem_next_cell(dt_root_addr_cells, &p);
  1041		mem_size = dt_mem_next_cell(dt_root_addr_cells, &p);
  1042	
  1043		kho_populate(kho_start, scratch_start, scratch_size, mem_start, mem_size);
  1044	#endif
  1045	}
  1046	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
