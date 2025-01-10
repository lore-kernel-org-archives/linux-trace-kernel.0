Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F48213E77;
	Fri, 10 Jan 2025 19:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736537759; cv=none; b=pv/tCfB6vqOilz9GFev7Jf5qThJ+sTQ1+SsdMxngTjIm9IFU0648SkZOL8JVATA9pgT+gswp1o0Mu+iBT2PKZwpjjuOeJx1NfGWvAacRL87zXdsZMirnuLqwL6QqERDXAPz8kPqWSS5KD/1UR0uLsjub19MEXH9XEtmh/vWfKs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736537759; c=relaxed/simple;
	bh=PIpsMswTdT020iPzqG5ntp7t7JspQE2rc/trtkI3nIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TwRYLyB5miDrJmiu37J24Yyocz9tcdxCHqAIxctABMTZ6IBYKwklGMQyaH8tyb1ztPz8PgjpW6gTDI2y+mVmhhuDJxwIMR8RyfnA4+VQeaNeflYf6huJms55eD3pnkktG8KZtlXs+wzf/bbbwGxJ4JjHtWnuQ844MUmI6jx8Ptk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gPWvZE4G; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gPWvZE4G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736537758; x=1768073758;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PIpsMswTdT020iPzqG5ntp7t7JspQE2rc/trtkI3nIo=;
  b=gPWvZE4GoHFQrVsuUpmsj0XHCxaEqwpWOQi/T1Li+LT9yJQSKieJckyG
   wjWzg9+TNDP75V+oRbVvZhgUU1gAmTHuJRRsnpmZTDep/cQfzPcchNcZF
   Q/tZTy0UdfaanATLeOmT+2I85M0MabvL+Ua4xF//HCiZjNYaq8vvTJQOx
   OJjN4OQfvbRdigbHnnlP1P9HVASt17Yt/VR4IyZl0/RwcVNwcnERKXv2U
   d292bvZBGWSZt6O2ZLstzsO9KbgSoB+ywGe2b5V/2lCbMGvthoosBmU8R
   yD+oMJfj0jfeG7TsxUyNna9hv+LXP1c+h0pvZVVTyIICEJAsoJkDxssly
   A==;
X-CSE-ConnectionGUID: 4faG/HeOSX6opdaPGI4JnA==
X-CSE-MsgGUID: lSA7tWLJSI2ZWJLq8k4jZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11311"; a="48256980"
X-IronPort-AV: E=Sophos;i="6.12,305,1728975600"; 
   d="scan'208";a="48256980"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 11:35:57 -0800
X-CSE-ConnectionGUID: 3gzyvtpoTHqJZFLPYsbUZQ==
X-CSE-MsgGUID: nyw5/AI0QoG2DQtlKXk2zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,305,1728975600"; 
   d="scan'208";a="134653766"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 10 Jan 2025 11:35:54 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tWKnQ-000Jfz-12;
	Fri, 10 Jan 2025 19:35:52 +0000
Date: Sat, 11 Jan 2025 03:35:49 +0800
From: kernel test robot <lkp@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	jochensp@jochen.sprickerhof.de
Subject: Re: [PATCH] ftrace: Implement :mod: cache filtering on kernel
 command line
Message-ID: <202501110319.xY9ltUxL-lkp@intel.com>
References: <20250109174639.32e6f43a@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109174639.32e6f43a@gandalf.local.home>

Hi Steven,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.13-rc6 next-20250110]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Steven-Rostedt/ftrace-Implement-mod-cache-filtering-on-kernel-command-line/20250110-064649
base:   linus/master
patch link:    https://lore.kernel.org/r/20250109174639.32e6f43a%40gandalf.local.home
patch subject: [PATCH] ftrace: Implement :mod: cache filtering on kernel command line
config: i386-randconfig-012-20250111 (https://download.01.org/0day-ci/archive/20250111/202501110319.xY9ltUxL-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250111/202501110319.xY9ltUxL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501110319.xY9ltUxL-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/trace/trace.c:10664:28: warning: no previous prototype for function 'trace_get_global_array' [-Wmissing-prototypes]
    10664 | __init struct trace_array *trace_get_global_array(void)
          |                            ^
   kernel/trace/trace.c:10664:8: note: declare 'static' if the function is not intended to be used outside of this translation unit
    10664 | __init struct trace_array *trace_get_global_array(void)
          |        ^
          |        static 
   1 warning generated.


vim +/trace_get_global_array +10664 kernel/trace/trace.c

 10662	
 10663	/* Used to set module cached ftrace filtering at boot up */
 10664	__init struct trace_array *trace_get_global_array(void)
 10665	{
 10666		return &global_trace;
 10667	}
 10668	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
