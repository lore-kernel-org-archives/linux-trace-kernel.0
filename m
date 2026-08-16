Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661753D647E;
	Sun, 16 Aug 2026 22:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786918296; cv=none; b=Xzfq5V+Q77O1LNi3JOFo/nDjOauwG4EXAmd03VUGLeqz3FMrcOS+wYfZeBhd71TrhRvnP+T0gvg+6s9umlyqkoB06u+LVcvFC2rKvghxmRf778n28+YQu6pl8VM4pFnGDuLx512bTCCtSVOuQFi0lQxXLuh/FEWM6ew5YeuhnaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786918296; c=relaxed/simple;
	bh=BetprM0RdBz9U2XhwsqIZQvo/uqW/2vTiRA6sJXlsic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KhQ8tyXMxrg2gGkWk/KmYl16HrGIoRqQL9ygoepSdab8dQMPidnxHYzeTCazxSAUj5zcC6Td8EpEbg0L/00MxVIsORyMt0MVqi7adkAFrTzxdeYwi+vxo87nR/mg3wtQgq7TyoKMgVeD5CIzUrF12XesKV2UR+rQvXKTLQyuanU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IEeEd4aK; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IEeEd4aK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786918294; x=1818454294;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BetprM0RdBz9U2XhwsqIZQvo/uqW/2vTiRA6sJXlsic=;
  b=IEeEd4aKdtKrCQDAilyis9lWYadiv8FIiaDABQBpfWMc3jSxJlnN0OpG
   eFlcNfpBGEcV4+bhjJDMLOM8jB9G5IFeFMwm5AbR0/uH1eIYJvlqOfy+s
   vN56igwIbllGWLOBKvywdm7yKKiR77KGZPo8UyiwicRbXxhZLFRRUs5Et
   0H3gA7gX6ZTUFpcMnw4/OGTpqzkZ9YP6n7L5Sqnczjf6AHLNQokPRER2Z
   BFnJZ94tgj1UMPv4iyyLYYZLuHzUQhHWt996OItDWLWUpSdW7ojm4r+Vw
   m9hZsNDuJKZPg2fLv91m47ImSIa6fpVHMPUmlBA2BiWx8whAPLo5qtKON
   Q==;
X-CSE-ConnectionGUID: C25LUqHZQ5GJT1I7TjLQsg==
X-CSE-MsgGUID: fjKTFzetRwSqi9aibgkHRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="89915456"
X-IronPort-AV: E=Sophos;i="6.25,227,1779174000"; 
   d="scan'208";a="89915456"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2026 15:11:33 -0700
X-CSE-ConnectionGUID: bY3ozt2VS+uJOiiRoOwL0Q==
X-CSE-MsgGUID: 9R/KWFVPQSK71mWWEsbOZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,227,1779174000"; 
   d="scan'208";a="263415551"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 16 Aug 2026 15:11:30 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wvj4g-00000000d7m-3x14;
	Sun, 16 Aug 2026 22:11:26 +0000
Date: Mon, 17 Aug 2026 06:10:52 +0800
From: kernel test robot <lkp@intel.com>
To: Woradorn Laodhanadhaworn <woradorn.laon@gmail.com>, rostedt@goodmis.org
Cc: oe-kbuild-all@lists.linux.dev, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev, shuah@kernel.org,
	skhan@linuxfoundation.org, me@brighamcampbell.com,
	jkoolstra@xs4all.nl, woradorn.laon@gmail.com
Subject: Re: [PATCH v2] tracing: Use seq_buf for string concatenation
Message-ID: <202608170556.RyB6XrT0-lkp@intel.com>
References: <20260622094623.18469-1-woradorn.laon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622094623.18469-1-woradorn.laon@gmail.com>

Hi Woradorn,

kernel test robot noticed the following build warnings:

[auto build test WARNING on v7.2-rc7]
[also build test WARNING on linus/master]
[cannot apply to linux-review/Woradorn-Laodhanadhaworn/tracing-Use-seq_buf-for-string-concatenation/20260813-224524 trace/for-next next-20260814]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Woradorn-Laodhanadhaworn/tracing-Use-seq_buf-for-string-concatenation/20260815-195403
base:   v7.2-rc7
patch link:    https://lore.kernel.org/r/20260622094623.18469-1-woradorn.laon%40gmail.com
patch subject: [PATCH v2] tracing: Use seq_buf for string concatenation
config: hexagon-randconfig-r123-20260816 (https://download.01.org/0day-ci/archive/20260817/202608170556.RyB6XrT0-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260817/202608170556.RyB6XrT0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608170556.RyB6XrT0-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux: section mismatch in reference: seq_buf_str+0x4 (section: .text) -> bootup_event_buf (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: seq_buf_str+0x8 (section: .text) -> bootup_event_buf (section: .init.data)
>> WARNING: modpost: vmlinux: section mismatch in reference: seq_buf_str+0xe0 (section: .text) -> __TRACE_SYSTEM_ERROR_DETECTOR_KFENCE (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: seq_buf_str+0xe4 (section: .text) -> __TRACE_SYSTEM_ERROR_DETECTOR_KFENCE (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: seq_buf_str+0xfc (section: .text) -> bootup_event_buf (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: seq_buf_str+0x100 (section: .text) -> bootup_event_buf (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: seq_buf_str+0x1cc (section: .text) -> bootup_event_buf (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: seq_buf_str+0x1d0 (section: .text) -> bootup_event_buf (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: seq_buf_str+0x1f4 (section: .text) -> bootup_event_buf (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: seq_buf_str+0x1f8 (section: .text) -> bootup_event_buf (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: seq_buf_str+0x228 (section: .text) -> bootup_event_buf (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: seq_buf_str+0x22c (section: .text) -> bootup_event_buf (section: .init.data)

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
