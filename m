Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1633B7B7A;
	Wed,  8 Apr 2026 11:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775648409; cv=none; b=aUT+VPPhOVZnUl8Mg4pXInbGApaSjn4v+oi1EroRAf9asoevwf2h6ZPUh8pgDlw65WSjTYej1xPh3WDlO1IrXrp3qlPoVu6H4pkO8IDMICQRRmbGou8wUR9yg9FeLVeMt8wAwn3B+smXxCoZPIAaBUMoaRqHPn8a/kXPELxRjas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775648409; c=relaxed/simple;
	bh=M44PhwDlWKWyqOa96JhxJQdu8Mt5eTXDoByuV4Pch0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IsbDwL+mc1a2/kT7UiQh1LK6ybUjiiMce4mA63moH2Dk2yfrv3vGhma3jaiCMLzH+VIIBXdS/cU9fSlPkIUhqfwXaJzctEuvLD8Ou1Ar42EQn7jzQ1Nvni+iF2YOOOXb/DSvYlDkuEK6F5qTV61D6a1YUiizdsKyP3FG6EZ75Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IaMCoDsv; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IaMCoDsv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775648406; x=1807184406;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=M44PhwDlWKWyqOa96JhxJQdu8Mt5eTXDoByuV4Pch0s=;
  b=IaMCoDsvLCL2RGD+Dm38Vp3+MZLESjkIUDYXXdFqPc6cM6EytG+FFLhL
   yu75oPBlgnhQQ5gDabhI4p3tZW4jYg7HY0nONka2gHwFWtKzJo3M7W8VC
   KiBA8EyVcql95RIxswzfz7pQWSPpHBpG4zgJsl1QvCQzHPH3kxL7VV8DX
   g6UO0xHprnFki0JlwK6dzkdSCUXxE8b28hw6VsGIY4+J7nA6UgRrzvwtz
   5WKu/AwfRi5/o9FmMScW5Zp3R/dy9jQkJUiXn9VjDOcu2kT77xRgdbYns
   TDLWzZ2nlPry32y2NcaBiJJYxmD/MU4GeDfzF/pnBm03Vz5HrY3JoBHso
   g==;
X-CSE-ConnectionGUID: qmR5pSXTR9uNIBYVefVUlg==
X-CSE-MsgGUID: AWwOsRmeQ12/+0no7nw5Bg==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="86919990"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="86919990"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 04:39:56 -0700
X-CSE-ConnectionGUID: KWFlwwkLT9uaqbmyJtJbuQ==
X-CSE-MsgGUID: 1TqoiT1iTqu2scY79dY+Ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="230116190"
Received: from lkp-server01.sh.intel.com (HELO d00eb8a6782a) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 08 Apr 2026 04:39:53 -0700
Received: from kbuild by d00eb8a6782a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wARGA-000000001nL-3cxM;
	Wed, 08 Apr 2026 11:39:50 +0000
Date: Wed, 8 Apr 2026 19:39:37 +0800
From: kernel test robot <lkp@intel.com>
To: Shuvam Pandey <shuvampandey1@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Shuvam Pandey <shuvampandey1@gmail.com>
Subject: Re: [PATCH] seq_buf: add KUnit tests for seq_buf_putmem_hex()
Message-ID: <202604081907.Ko14RCaV-lkp@intel.com>
References: <20260406033728.25998-1-shuvampandey1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260406033728.25998-1-shuvampandey1@gmail.com>

Hi Shuvam,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-nonmm-unstable]
[also build test ERROR on akpm-mm/mm-everything linus/master v7.0-rc7 next-20260407]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shuvam-Pandey/seq_buf-add-KUnit-tests-for-seq_buf_putmem_hex/20260408-090623
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-nonmm-unstable
patch link:    https://lore.kernel.org/r/20260406033728.25998-1-shuvampandey1%40gmail.com
patch subject: [PATCH] seq_buf: add KUnit tests for seq_buf_putmem_hex()
config: arm-randconfig-002-20260408 (https://download.01.org/0day-ci/archive/20260408/202604081907.Ko14RCaV-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project c80443cd37b2e2788cba67ffa180a6331e5f0791)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260408/202604081907.Ko14RCaV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604081907.Ko14RCaV-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in arch/arm/probes/kprobes/test-kprobes.o
>> ERROR: modpost: "seq_buf_putmem_hex" [lib/tests/seq_buf_kunit.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
