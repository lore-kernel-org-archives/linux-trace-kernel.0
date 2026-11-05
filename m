Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793891782;
	b=RkFMW0S33OINLzdJp7aqT6epf4hPvkZFBwftQhh5t9P6wbUEMxpTbpPMd3DEKXjM4VRu
	 i1UhyoFnGDK+Pe4P1UPTMao1ckr3ALFRKRtAEjNPVRy4eGta3mMOt4v7Hm/SjeM+LYMn2
	 8kXecsTaGBQBuuPmiG2Heqgbj2PBJ7+uhUwFQ3I168g43+Ty5svCQ9MRHLLhIcZW6FWyq
	 Bhjuf2js2gc9ArfZanRcRlzrM8zjJ46G9KkfQ6yhoi4q6PBcFhL4YQ7mc0EgOKkNhQ/22
	 ErWlP8jlAMlClrBNwOpsQvGECKdqpMwiOEADkRcjDv2ADhcjie8RRG1B7FSQcU2IXrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793891782;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=fMjn8XjiAzeUPvVw/+o83TJlFUPnqRfLNFAmNRdAxMk=;
	b=cDhAaSxam65UB9iZOqtdF/zGNnLeH/2optrS8T9ETXIy2nmAp5a9hQu0Oo5owIxtCdel
	 zsQa42889n4ZDRBo2lCjhr+v+Pdl0QQiZTQC0hodE2g29PJPuKTeNtXUibE97gN/wW1+r
	 jZ3RrvmBYjLlDNXTkBDm9p4+0nsIXgBPrPlzhcwTNbD5FmALm9tJuglTqkIDaKS9eB/0w
	 s2Lkd5ypnvXYTSfezOaHfUeXOPYU4vRvX9QXp9G/ts+OcT9V9ZGbdIM63rvAyPqXt0Xlk
	 jPZF+p2vUKH8lGqaMLn/LEdFasu9vjckjwFJNFojxV0ihdpFMU9BHw405MgwHN2Bgdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UcsOA5SI;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDD5606A32D;
	Thu,  5 Nov 2026 15:16:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECDD5606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UcsOA5SI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793891781; x=1825427781;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rU8SrDDryY+CYHj9KsFi4pCuuYIXMwEz4SCd8TjDdnI=;
  b=UcsOA5SIJead27+Zc4oqTT5SFlOp4Q9D7damZpJjDpQxtlfILNcdg2Jd
   BwKF4rGrWjM9lV55ELYbKX2k4xU7lYXfCqcBRWZcac3CIOaePf7UCggt+
   c5uk/2RLuySGresZDfSZY/IUBtg/mlNAp8GHCqFLKGfZYj9FFEdUT5KZk
   dOEo+fk1Taf6Ol6+uaO/AWgdiZdc1aexEsUz70UUTfD/aF8P3VhaAKU1k
   zu+CoX7mYK7hWG/tYSRtv/To+iO85yVmFOYnCccQ29Nso5Gvaolz+/PCT
   zYPMPJ9Oass9FcPVEzQPZqGtdX22+2Hwu1y5HcP81eRSnS0QbIhVSbeHz
   Q==;
X-CSE-ConnectionGUID: fYf6iXxeQBegxm1Xb/BY+w==
X-CSE-MsgGUID: QmnqltgRT06/nU3jCCupEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2593744"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2593744"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 07:16:21 -0800
X-CSE-ConnectionGUID: bm+wbRSvRO2M5N2cjZGNDQ==
X-CSE-MsgGUID: UJYW7TIAQwe2gmUnKJ9jBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7193564"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 05 Nov 2026 07:16:19 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xOzCJ-00000000mOh-3sHN;
	Thu, 05 Nov 2026 15:16:15 +0000
Date: Thu, 5 Nov 2026 23:15:33 +0800
From: kernel test robot <lkp@intel.com>
To: Abhishek Bapat <abhishekbapat@google.com>,
	Suren Baghdasaryan <surenb@google.com>, Hao Ge <hao.ge@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Abhishek Bapat <abhishekbapat@google.com>
Subject: Re: [PATCH v5 2/5] alloc_tag: Introduce IOCTLs to toggle allocation
 tracepoints
Message-ID: <202611052344.mDV2DB89-lkp@intel.com>
References: <37ae7dca766994d3872fcc65b623a80d5d506369.1793818636.git.abhishekbapat@google.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37ae7dca766994d3872fcc65b623a80d5d506369.1793818636.git.abhishekbapat@google.com>

Hi Abhishek,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bcc036cfa1670a64500f6d857eaa71908b79e3fb]

url:    https://github.com/intel-lab-lkp/linux/commits/Abhishek-Bapat/alloc_tag-Add-trace-events-for-tracing-allocations/20261104-190336
base:   bcc036cfa1670a64500f6d857eaa71908b79e3fb
patch link:    https://lore.kernel.org/r/37ae7dca766994d3872fcc65b623a80d5d506369.1793818636.git.abhishekbapat%40google.com
patch subject: [PATCH v5 2/5] alloc_tag: Introduce IOCTLs to toggle allocation tracepoints
config: xtensa-randconfig-1001-20261105 (https://download.01.org/0day-ci/archive/20261105/202611052344.mDV2DB89-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261105/202611052344.mDV2DB89-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611052344.mDV2DB89-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux: section mismatch in reference: alloc_tag_trace_enabled+0x2c (section: .text.unlikely) -> initcall_level_names (section: .init.data)

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
