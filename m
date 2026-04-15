Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E85C25F7A5;
	Wed, 15 Apr 2026 09:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776245420; cv=none; b=Y0DXWjTytqb63vqqhK8QU85Av5HfBVhN62fr9kAmJiycdBSajPawnl0aMnUKIA7H5qi41atCfZjG5ZrlaMlVrCQPVAIytEMuFNQ4Ycd3kY4rqltlU0AYJN6jprw1As42NEpWg2b1CJMWlyxkwUjKoX7/rvMy+1NbEZTb+O61ht0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776245420; c=relaxed/simple;
	bh=O2cCcmR1LYmG6vTxtBAdqDKbf0ht7ri89RMbF0xuKP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jyCRj3hSVCjpn1xjwQLwch8CeC2hEI7YctjR8KaDvG1ji9hEWc//gnVSKkNLbX0buUQDLmnBspXbHmAZ/b9jBg2IOHiJlSC9AxwQ/blMFE6eGTL7oQ/Mv0OFei8WG2jJv5de035Tsj213DfAMBDTdpA351Yh89vyU5zqOqc7ei4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=imLNiECj; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="imLNiECj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776245419; x=1807781419;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O2cCcmR1LYmG6vTxtBAdqDKbf0ht7ri89RMbF0xuKP0=;
  b=imLNiECjbj5yVsqkreFpJtQ6dk1WXcVsayIWlRwbETWqqap7a54Ye7sn
   /0iYo/jObQK3RMxHa25XFU/RrddiEsllXOQJLzL84O40QXZnZC1pGxWKM
   pLCXYIs72+ENVyD/9d0PvRZDk6nP2mYG5d9W2gXNWitCCYXfQ7j0sOOxE
   9+Od/YTHBDQnRi2uX7tm6HhUWKD1LzZttX2RVtoNqRAXlGEWet3unhQr/
   bxg+yAJ/7bCxa3b8Y1WQf97NisZ30FeiKv8yiMm+OQ7HLE8mSCF3DS1sx
   4x/on4x7oQnuxnsGCDaY9wGGi+yUxW8gzfclUTXLueSpmMYKyz1B0STWY
   Q==;
X-CSE-ConnectionGUID: L3efuRuqRciQOlHH3ca6vw==
X-CSE-MsgGUID: N8oxEOwzS+Gb/DQrEhmw/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="88296711"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="88296711"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 02:30:18 -0700
X-CSE-ConnectionGUID: uPnI7DrNQ/ira3fR3we6Ng==
X-CSE-MsgGUID: BNC/IQO1Q5mninYRMB244Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="230595800"
Received: from igk-lkp-server01.igk.intel.com (HELO bdf09bfdbd5f) ([10.211.93.152])
  by orviesa007.jf.intel.com with ESMTP; 15 Apr 2026 02:30:17 -0700
Received: from kbuild by bdf09bfdbd5f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wCwZa-000000000hx-46OU;
	Wed, 15 Apr 2026 09:30:14 +0000
Date: Wed, 15 Apr 2026 11:29:57 +0200
From: kernel test robot <lkp@intel.com>
To: Cao Ruichuang <create0818@163.com>, rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] ring-buffer: Preserve true payload lengths in long data
 events
Message-ID: <202604151102.OQ1HyH3F-lkp@intel.com>
References: <20260407091550.67963-1-create0818@163.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407091550.67963-1-create0818@163.com>

Hi Cao,

kernel test robot noticed the following build warnings:

[auto build test WARNING on trace/for-next]
[also build test WARNING on linus/master v7.0 next-20260414]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Cao-Ruichuang/ring-buffer-Preserve-true-payload-lengths-in-long-data-events/20260415-040554
base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
patch link:    https://lore.kernel.org/r/20260407091550.67963-1-create0818%40163.com
patch subject: [PATCH] ring-buffer: Preserve true payload lengths in long data events
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260415/202604151102.OQ1HyH3F-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260415/202604151102.OQ1HyH3F-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604151102.OQ1HyH3F-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: kernel/trace/ring_buffer.c:4786 function parameter 'force_long' not described in '__ring_buffer_lock_reserve'
>> Warning: kernel/trace/ring_buffer.c:4786 expecting prototype for ring_buffer_lock_reserve(). Prototype was for __ring_buffer_lock_reserve() instead

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
