Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5277318FDB1;
	Wed,  4 Dec 2024 10:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733309451; cv=none; b=DjsoQspwIa1BmMxXuM+CpFFHCwmszkILfF0fRgPPIIkIpLT7Jkm53yjLKrwPT+j6vSMwDhvtOVrz5QrzKGnUwPTpiivSvqnYqbiqy8TIClPSiqtkBuTG3igaQyFh4YN3FDldagWOql/n5/AnVlZAlFYLgS8DSZprZ3vDR4rs5sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733309451; c=relaxed/simple;
	bh=D5OnpVRS3SoGY0Tsf0LDlllwyF9hqDzqXBR3lfpMU3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QL7/vWoGjqnY5vKjCRSB7KaO/KNxwGre3v0jn8Y64/cbuP+yep9FM+PavRHqloOUx2RQFTkcdMVX73HdrhnVmkGPBXWd/wiEwwL6LKSGccvtGcIbdR3r3Xvj1DAwdc8zNwVO0NUQqXWQ746RzVg7CNKTGcC/OsojgehN1N5h3Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bIGbbruY; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bIGbbruY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733309448; x=1764845448;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=D5OnpVRS3SoGY0Tsf0LDlllwyF9hqDzqXBR3lfpMU3c=;
  b=bIGbbruYygsI8WHDobTzWJEZLlGXYPHmIEd6Q+e4ki+2UZ8GzVHb4Qol
   +OEHce2dv85Nx8O9KqlHuo2NFyFDtKvGnFgbY3GTpC5bXCmsuKrGwx4D2
   R2CBLkcLbyqoMI49zXlSD1w9oUMg1YXbeyDbN6A332GPM/buaZyzvADcG
   wVppE7ln0T7V1q/1IJRigoAbc1M6UeXoMttOwm2MpMln045TsL3xzrUut
   R8w/7HZIEsYh4RFPORV9gEHs9A+PIbESb0EKrYsFYXqf93R1PL+2Hancn
   wnpJCG91FtoVhWkP+XMR1OBlhF7un5KC9u0WwyFIIfU4YJb6XfeYFVXDt
   g==;
X-CSE-ConnectionGUID: 9KF3dIQqR8qLpIj5asuZTw==
X-CSE-MsgGUID: pJ8LDwuHQp68NVe74N9mfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="58973720"
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="58973720"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 02:50:47 -0800
X-CSE-ConnectionGUID: R/BCqj1nTRSojydC6w45jw==
X-CSE-MsgGUID: Lwn72vJCQq2UN8E1p1qzGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="93623169"
Received: from lkp-server02.sh.intel.com (HELO 1f5a171d57e2) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 04 Dec 2024 02:50:45 -0800
Received: from kbuild by 1f5a171d57e2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tImxZ-0002tl-2R;
	Wed, 04 Dec 2024 10:50:28 +0000
Date: Wed, 4 Dec 2024 18:48:49 +0800
From: kernel test robot <lkp@intel.com>
To: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	rostedt@goodmis.org,
	Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Subject: Re: [PATCH v3 2/2] arch: m68k: Add STACKTRACE support
Message-ID: <202412041842.wqwewnMc-lkp@intel.com>
References: <20241203-add-m68k-tracing-support-v3-2-4de93f6cae55@yoseli.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203-add-m68k-tracing-support-v3-2-4de93f6cae55@yoseli.org>

Hi Jean-Michel,

kernel test robot noticed the following build errors:

[auto build test ERROR on e70140ba0d2b1a30467d4af6bcfe761327b9ec95]

url:    https://github.com/intel-lab-lkp/linux/commits/Jean-Michel-Hautbois/m68k-Add-tracirqs/20241204-121927
base:   e70140ba0d2b1a30467d4af6bcfe761327b9ec95
patch link:    https://lore.kernel.org/r/20241203-add-m68k-tracing-support-v3-2-4de93f6cae55%40yoseli.org
patch subject: [PATCH v3 2/2] arch: m68k: Add STACKTRACE support
config: m68k-allnoconfig (https://download.01.org/0day-ci/archive/20241204/202412041842.wqwewnMc-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241204/202412041842.wqwewnMc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412041842.wqwewnMc-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/m68k/kernel/stacktrace.c:40:44: error: unknown type name 'stack_trace_consume_fn'
      40 | void __no_sanitize_address arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
         |                                            ^~~~~~~~~~~~~~~~~~~~~~


vim +/stack_trace_consume_fn +40 arch/m68k/kernel/stacktrace.c

    39	
  > 40	void __no_sanitize_address arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
