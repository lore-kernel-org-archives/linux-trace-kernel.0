Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07DA15AA
	for <linux-trace-kernel@vger.kernel.org>; Fri, 20 Oct 2023 03:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hKZppoOw"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61EDCD49;
	Thu, 19 Oct 2023 20:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697772529; x=1729308529;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HZK8XcaOMRdSa1/Hskxmw3lliswKEoaXNG7FZIK02ng=;
  b=hKZppoOwcYfcAEmXwl/mpNY/qR5ilElxUtr4aoCY90EmnKt9AdPrp+pG
   KksomiuauTFnHUjQtplQkkEo42CRgkZHOehHWmQDZ3tdK4x30eAcrchcL
   iJuZU0H8pnp8BXa57VpUAzvA+6snH28C37E9eVo+nJfsm27USrCuxAZZ2
   /jX0iW3IwFJCpmC+kn9gb7v5whmKD8bOjXlB+5d1HU4gWi6kBLEJDTtvl
   et4sgs68aZNuLVBL6rPyUYogG46GTZsDLnw9JQvZ3k3J9Hr3PhT4c6dUI
   4o/tCZP/uP+3RbiiAP7Q/iUTc5bKP19JXIaBcoLnz03vdMfRuHngYEj6p
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="472645899"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="472645899"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 20:28:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="827592029"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="827592029"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 19 Oct 2023 20:28:44 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qtgBm-0002vy-2Z;
	Fri, 20 Oct 2023 03:28:42 +0000
Date: Fri, 20 Oct 2023 11:27:46 +0800
From: kernel test robot <lkp@intel.com>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, quic_vbadigan@quicinc.com,
	quic_ramkri@quicinc.com, quic_nitegupt@quicinc.com,
	quic_skananth@quicinc.com, quic_parass@quicinc.com,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>
Subject: Re: [PATCH v2] bus: mhi: host: Add tracing support
Message-ID: <202310201110.S903HmeD-lkp@intel.com>
References: <20231013-ftrace_support-v2-1-6e893ce010b5@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013-ftrace_support-v2-1-6e893ce010b5@quicinc.com>

Hi Krishna,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 3006adf3be79cde4d14b1800b963b82b6e5572e0]

url:    https://github.com/intel-lab-lkp/linux/commits/Krishna-chaitanya-chundru/bus-mhi-host-Add-tracing-support/20231017-120241
base:   3006adf3be79cde4d14b1800b963b82b6e5572e0
patch link:    https://lore.kernel.org/r/20231013-ftrace_support-v2-1-6e893ce010b5%40quicinc.com
patch subject: [PATCH v2] bus: mhi: host: Add tracing support
config: i386-randconfig-002-20231020 (https://download.01.org/0day-ci/archive/20231020/202310201110.S903HmeD-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231020/202310201110.S903HmeD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310201110.S903HmeD-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/bus/mhi/host/main.c:249:12: warning: no previous declaration for 'mhi_to_physical' [-Wmissing-declarations]
    dma_addr_t mhi_to_physical(struct mhi_ring *ring, void *addr)
               ^~~~~~~~~~~~~~~


vim +/mhi_to_physical +249 drivers/bus/mhi/host/main.c

   248	
 > 249	dma_addr_t mhi_to_physical(struct mhi_ring *ring, void *addr)
   250	{
   251		return (addr - ring->base) + ring->iommu_base;
   252	}
   253	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
