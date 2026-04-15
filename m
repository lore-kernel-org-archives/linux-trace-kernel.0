Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460AF33FE1F;
	Wed, 15 Apr 2026 10:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776249479; cv=none; b=S2/Q4zNE37vJhqEPr4ppRf02zqnesxHmAGGjty6R/ajNyI40D+Me+DhsfnL9T63BsG2ZfYLtl2cuYaDwB6bspscO8mIx04F2+8BUDGGvdErZf/oa+rdi/1mm1HD2xfCF1AkHIHCfM9S6W2tHUHV+9wcUOdql7so/4VdiHnQOzrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776249479; c=relaxed/simple;
	bh=l6b3SK+q03o5YL9QJb9jfzyHo1l45dSmPkSeuYkbRJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mFWT2fY9j0JslR9W4s0/XvQPArzTI2g1yUpxvWmtd6mIWvoJrTeJoh6CrGGEfjow/OKs3VtOFwC/bV0QzhkeS/c+gehfc8NEVCcqrpqy3qi+drAb6t2eq4Rcs0oLf6tcxURxqXiBbjJUZhxk/0t8ywtByb1N6gF6tCUvSzGJ61o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U/NwrhBo; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U/NwrhBo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776249478; x=1807785478;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=l6b3SK+q03o5YL9QJb9jfzyHo1l45dSmPkSeuYkbRJk=;
  b=U/NwrhBoTe3QAiOMJGwv9p8KUyHI9UDY9y65HC2CbeAX1fiejAuhDoYf
   IXnypeyeR+NuxTNSEK9dNnY5viLfXRTyk1cqAay2cA/qZAXWnppsl2k/e
   fa4GbtwhauSt03td/LQCfDOzz4K7mrh0goM8tvhTfUyM3GBXXYnk0c2Ti
   aSKOGds+rWKThZ0MtKQzMaTjRmk7UJqSPbp6SYYh2XHeGlFJEjVMdkTjw
   /gyu/uzegsQU0aJ4UcnCljjG/kBrY5iY81klr2kt9jiCZfeKnhBXvU2op
   lYnHkJdQT43kT+y+EsHo/KeAjlBKXvxZG3vGWYAbk8qTtEH10sfiGp+3r
   g==;
X-CSE-ConnectionGUID: c5v918ZuRpKhypfP+zaeBA==
X-CSE-MsgGUID: jZebY0IqTPKEpy9LUk67SQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="87529097"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="87529097"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 03:37:58 -0700
X-CSE-ConnectionGUID: XDBVv4cvRW6dAvQxSOZO3A==
X-CSE-MsgGUID: EL7WmNfKR1qPYqzqlnsfaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="229529500"
Received: from lkp-server01.sh.intel.com (HELO 7f3b36e5d6a5) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 15 Apr 2026 03:37:56 -0700
Received: from kbuild by 7f3b36e5d6a5 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wCxd3-000000000Oz-1Bod;
	Wed, 15 Apr 2026 10:37:53 +0000
Date: Wed, 15 Apr 2026 18:36:55 +0800
From: kernel test robot <lkp@intel.com>
To: Cao Ruichuang <create0818@163.com>, rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] ring-buffer: Preserve true payload lengths in long data
 events
Message-ID: <202604151837.uakVEVAS-lkp@intel.com>
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
config: arc-defconfig (https://download.01.org/0day-ci/archive/20260415/202604151837.uakVEVAS-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260415/202604151837.uakVEVAS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604151837.uakVEVAS-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: kernel/trace/ring_buffer.c:4786 function parameter 'force_long' not described in '__ring_buffer_lock_reserve'
>> Warning: kernel/trace/ring_buffer.c:4786 expecting prototype for ring_buffer_lock_reserve(). Prototype was for __ring_buffer_lock_reserve() instead

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
