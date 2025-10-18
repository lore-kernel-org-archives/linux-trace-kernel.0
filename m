Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC4A2AE68;
	Sat, 18 Oct 2025 20:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760817865; cv=none; b=EtKnshsn2ZQvTAgKZC/fJCj8flgzSihfoFprrGA3ArArL1GO7lLEpbp2tIxJrJUkiGjNfUXH6pnlyw8DxyGdlUAOvn5f3ObPufzaLdt5FkC3nfY08oMoIWQtZzlkQPDCP4njkfg4rjzQ4LTjIdeGsFESmoFAXaNcYdQAIDS6nRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760817865; c=relaxed/simple;
	bh=KSoNLWFcFrnVPT4KMvHD0bFWw0wyVpsCTrJGi3g1VFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EwxnfOgIUP2M7cr9qweilCBM6LSLojTrsnd/bPCOu8DbE+vfNPxJ6lTZ957VJCLi6xeDRTC078TiJ/ndsS0+2VLRMZCaeSXaSSzLO7y6Lk4A0kmryDdU/+9bFObrBaEkqW9btE36nqOumBWAvHNpRtpNC9q05dEBJod+Y1swhF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nHfJtdDS; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nHfJtdDS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760817864; x=1792353864;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KSoNLWFcFrnVPT4KMvHD0bFWw0wyVpsCTrJGi3g1VFc=;
  b=nHfJtdDSc4fS48uginATFywF7LwiXstTYGd2vcD/cH6atU37pjDOlPa0
   2B9RZHhMS2s3Hnh+IpLNNc67+XH9RbN7dVNbTcTVjtcD1NFb0KTShwtG6
   8cmHcBO8/MZQ8yCPPr3G42FWhZ5hL3YmIs0uvDznqv7No0AKCgA6Sgx3g
   cImA8FFGV2J4jyYRTIVNmbpl7lT0XImXp+sYSKdeJ+5rnMbZIycsDUl2s
   N4tdhWxBkXMKz5FDAuVnoa3ZRuSypeUB//iE9NM6+m8NOZcpGmqjkedRN
   hfOny5cMc3jzJVd+KdMpxw6+3MJ4LWcw+/MtN/yL2DY64/2OCl2TfcyEV
   Q==;
X-CSE-ConnectionGUID: hY+xqQmjRQW3turG2xjmaQ==
X-CSE-MsgGUID: NXi//jwXQh+/hngip6kB7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="66640839"
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="66640839"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 13:04:24 -0700
X-CSE-ConnectionGUID: 6IbWPmfCRCqpw56S4VebOA==
X-CSE-MsgGUID: mbW4M+8tT8eFk9fBkUgnCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="183014904"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 18 Oct 2025 13:04:22 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vADA3-0008ZF-16;
	Sat, 18 Oct 2025 20:04:19 +0000
Date: Sun, 19 Oct 2025 04:04:09 +0800
From: kernel test robot <lkp@intel.com>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: oe-kbuild-all@lists.linux.dev, Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] tracing: Allow tracer to add more than 32 options
Message-ID: <202510190313.fYtuvG3l-lkp@intel.com>
References: <176071774097.175601.10233017390618260565.stgit@devnote2>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176071774097.175601.10233017390618260565.stgit@devnote2>

Hi Masami,

kernel test robot noticed the following build warnings:

[auto build test WARNING on trace/for-next]
[also build test WARNING on linus/master v6.18-rc1 next-20251017]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Masami-Hiramatsu-Google/tracing-Allow-tracer-to-add-more-than-32-options/20251018-004104
base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
patch link:    https://lore.kernel.org/r/176071774097.175601.10233017390618260565.stgit%40devnote2
patch subject: [PATCH v4 1/2] tracing: Allow tracer to add more than 32 options
config: i386-randconfig-063-20251018 (https://download.01.org/0day-ci/archive/20251019/202510190313.fYtuvG3l-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251019/202510190313.fYtuvG3l-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510190313.fYtuvG3l-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   kernel/trace/rv/rv.c: note: in included file (through kernel/trace/rv/rv.h):
>> kernel/trace/rv/../trace.h:1427:27: sparse: sparse: missing identifier in declaration
   kernel/trace/rv/../trace.h:1427:27: sparse: sparse: Expected ; at the end of type declaration
   kernel/trace/rv/../trace.h:1427:27: sparse: sparse: got :

vim +1427 kernel/trace/rv/../trace.h

  1426	
> 1427	enum trace_iterator_flags : uint64_t { TRACE_FLAGS };
  1428	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
