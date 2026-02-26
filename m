Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8787387591;
	Thu, 26 Feb 2026 18:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772131716; cv=none; b=YEDALyTXyTuZ0lcMYkV8BtqYlLlrRI85Kh7+1Es1bAn8GLfjKGKs3mDKeI3/VwUGEdGcgD8K5kWJ2GnKvbuZvsLBn774ZoAzzvoNOP/oz6m1VeUFylT/JqOByArF2/oc2Y3vwtljsH1JH5fv9BOmkXwIcdhDqLHOnYb8rWdL96w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772131716; c=relaxed/simple;
	bh=Dsa4IPWVksq4qQJNj7lZdQ9EJHRm0dzFcpiPCh8Xsy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OPAKlc6//ulF6FQ8VdYqMOJUpOhBD971f+V3kZSlJLCXa9eEMw2BAaNhwbOtRHttCxDFAGyvUzJys0XaPNE86HkgWl0oOrrLySfKlTeD9eCH1eHlR3Z2QaWdWS6DRReB5aWED/TAXRiA0S6EXu411QXxMnprZeceY36b9DNiE/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PkkqLHA7; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PkkqLHA7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772131714; x=1803667714;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Dsa4IPWVksq4qQJNj7lZdQ9EJHRm0dzFcpiPCh8Xsy4=;
  b=PkkqLHA7BH0SCrRa1Jeji++3Re/W6WUZG6fO441815CFrxVi9ZO2FeOT
   oED1m/XPDvXjc/8csh2peDbsQYIdNE76q7cO8O1rUtKtCE0V0nZ82TjVf
   UPn+1TbOt9IkBwGS/AQDughRLL8MtxvN3WvBVptQUsvUPt5An2sx8gCiy
   lTYeEylnedheSf10GSlymKDyiG0qDeorq/RcfWFmCBTbV9+sBAskOaR5M
   tcBLKGV14lnM/7ig/F0RhXIBbgkAYWl9eMLjDRFG7vsf3m6XxuQXGRiP8
   4zDCBHwsLUaI12Jo2MRdDYamQ3MnXSWi24AYOJD16Gspgg06t0yXqp/gr
   g==;
X-CSE-ConnectionGUID: lMwN+MHOQwGQBxR+FJbTAw==
X-CSE-MsgGUID: 0SeqxvnvSR6oYwETZxWqgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="95821607"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; 
   d="scan'208";a="95821607"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 10:48:34 -0800
X-CSE-ConnectionGUID: q7KD1QjmTIGDr6jWxM07qg==
X-CSE-MsgGUID: 8cQOkpz3TUG+GaugjRhiYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; 
   d="scan'208";a="221659563"
Received: from lkp-server02.sh.intel.com (HELO a3936d6a266d) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 26 Feb 2026 10:48:33 -0800
Received: from kbuild by a3936d6a266d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vvgPV-000000009mR-4937;
	Thu, 26 Feb 2026 18:48:29 +0000
Date: Fri, 27 Feb 2026 02:48:26 +0800
From: kernel test robot <lkp@intel.com>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: oe-kbuild-all@lists.linux.dev, Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] ring-buffer: Flush and stop persistent ring
 buffer on panic
Message-ID: <202602270244.3JWhusi4-lkp@intel.com>
References: <177211311593.419230.2212568977306190482.stgit@mhiramat.tok.corp.google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177211311593.419230.2212568977306190482.stgit@mhiramat.tok.corp.google.com>

Hi Masami,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v7.0-rc1 next-20260226]
[cannot apply to trace/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Masami-Hiramatsu-Google/ring-buffer-Flush-and-stop-persistent-ring-buffer-on-panic/20260226-222418
base:   linus/master
patch link:    https://lore.kernel.org/r/177211311593.419230.2212568977306190482.stgit%40mhiramat.tok.corp.google.com
patch subject: [PATCH v5 1/3] ring-buffer: Flush and stop persistent ring buffer on panic
config: sparc-randconfig-001-20260227 (https://download.01.org/0day-ci/archive/20260227/202602270244.3JWhusi4-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260227/202602270244.3JWhusi4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602270244.3JWhusi4-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/trace/ring_buffer.c: In function 'rb_flush_buffer_cb':
>> kernel/trace/ring_buffer.c:2481:9: error: implicit declaration of function 'flush_cache_all'; did you mean 'flush_cache_page'? [-Werror=implicit-function-declaration]
    2481 |         flush_cache_all();
         |         ^~~~~~~~~~~~~~~
         |         flush_cache_page
   cc1: some warnings being treated as errors


vim +2481 kernel/trace/ring_buffer.c

  2475	
  2476	static int rb_flush_buffer_cb(struct notifier_block *nb, unsigned long event, void *data)
  2477	{
  2478		struct trace_buffer *buffer = container_of(nb, struct trace_buffer, flush_nb);
  2479	
  2480		ring_buffer_record_off(buffer);
> 2481		flush_cache_all();
  2482		return NOTIFY_DONE;
  2483	}
  2484	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
