Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F7634D395;
	Sun,  9 Nov 2025 13:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762694931; cv=none; b=jAybVD2jPZJHvs/gykXosWV0nRVvyykGDEuINXRhtPvfwexbTcda1EGQR/BZQ2Ifrt6CBYtkbndhguPzaoZKnV60oDNiNOp6YMUDGiS/07sI85VLsIpl0EbV7a7fOG//GOvAdzV6Y/LzVvDCHEWH8RVvewEnFIoENGXAg+oGqSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762694931; c=relaxed/simple;
	bh=egy0lm8KbcMkcn9xL91cir94+bUw2s619GaDs04yNRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LrHwwEMUozUkQvtibL4G6ps4feQ6rT0afcUFTnQXHIkjdG8koHr7X3SljzrGeIsWJG7XZFLZUk591H6jHbWwjLcjGrXG/GDw4wKXgoOW7d8tvwDXR2do801WNKac6Yi3RYRb9Wagm/2WX/RdNwAQndPDFudP0R6jGi0VGiSs2Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NQYb1sLL; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NQYb1sLL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762694930; x=1794230930;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=egy0lm8KbcMkcn9xL91cir94+bUw2s619GaDs04yNRo=;
  b=NQYb1sLLzjdpqNA5yhTVzL9W4X2quOejKyzYiSvfc4hC6ZkQ4QMZnSuq
   Nkdrgq8X4K4oDOjK8ivA1KfoSBUQyBbg5eBiyIkgo7qNd31cICM7VLveo
   UCBMBy+Rz6rBPl9AkorPEqM1jQZCFnbN9BlQhRy/4sCcnB3EieXjyAcEr
   DUWy+03sJwf8uoETi7byVUnejoqQOruAQ99XCst/Z6rSS1jelfedxQOtM
   ifB/RJc9i4q92DRfVgA2Wna96QRWjlT8dDCWt+GQrGtBS+Gyqg4UntkcZ
   4h6ZCuebXDJoNM1R26ECNGwxymVxdZRJp+nsEfA1+N8OqmYRYYrNiBWjF
   w==;
X-CSE-ConnectionGUID: ILw46PiESsewQ2N8wqIJiA==
X-CSE-MsgGUID: p81YM3LdTCqbFrM8sTGCCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11607"; a="67374599"
X-IronPort-AV: E=Sophos;i="6.19,291,1754982000"; 
   d="scan'208";a="67374599"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2025 05:28:49 -0800
X-CSE-ConnectionGUID: lqI5I1TzRQ2wUbcQY3p35g==
X-CSE-MsgGUID: 1eOmrPStSNuZZaUdr7LFUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,291,1754982000"; 
   d="scan'208";a="188411309"
Received: from lkp-server01.sh.intel.com (HELO 6ef82f2de774) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 09 Nov 2025 05:28:48 -0800
Received: from kbuild by 6ef82f2de774 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vI5TJ-00021b-1e;
	Sun, 09 Nov 2025 13:28:45 +0000
Date: Sun, 9 Nov 2025 21:27:50 +0800
From: kernel test robot <lkp@intel.com>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Report wrong dynamic event command
Message-ID: <202511092149.N375MBPu-lkp@intel.com>
References: <176259938768.261465.10714633393722227911.stgit@devnote2>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176259938768.261465.10714633393722227911.stgit@devnote2>

Hi Masami,

kernel test robot noticed the following build errors:

[auto build test ERROR on trace/for-next]
[also build test ERROR on next-20251107]
[cannot apply to linus/master v6.18-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Masami-Hiramatsu-Google/tracing-Report-wrong-dynamic-event-command/20251108-185823
base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
patch link:    https://lore.kernel.org/r/176259938768.261465.10714633393722227911.stgit%40devnote2
patch subject: [PATCH] tracing: Report wrong dynamic event command
config: s390-randconfig-002-20251109 (https://download.01.org/0day-ci/archive/20251109/202511092149.N375MBPu-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251109/202511092149.N375MBPu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511092149.N375MBPu-lkp@intel.com/

All errors (new ones prefixed by >>):

   s390-linux-ld: kernel/trace/trace_dynevent.o: in function `create_dyn_event':
>> kernel/trace/trace_dynevent.c:150: undefined reference to `trace_probe_log_init'
>> s390-linux-ld: kernel/trace/trace_dynevent.c:151: undefined reference to `__trace_probe_log_err'
>> s390-linux-ld: kernel/trace/trace_dynevent.c:152: undefined reference to `trace_probe_log_clear'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for I2C_K1
   Depends on [n]: I2C [=y] && HAS_IOMEM [=y] && (ARCH_SPACEMIT || COMPILE_TEST [=y]) && OF [=n]
   Selected by [y]:
   - MFD_SPACEMIT_P1 [=y] && HAS_IOMEM [=y] && (ARCH_SPACEMIT || COMPILE_TEST [=y]) && I2C [=y]


vim +150 kernel/trace/trace_dynevent.c

   133	
   134	static int create_dyn_event(const char *raw_command)
   135	{
   136		struct dyn_event_operations *ops;
   137		int ret = -ENODEV;
   138	
   139		if (raw_command[0] == '-' || raw_command[0] == '!')
   140			return dyn_event_release(raw_command, NULL);
   141	
   142		mutex_lock(&dyn_event_ops_mutex);
   143		list_for_each_entry(ops, &dyn_event_ops_list, list) {
   144			ret = ops->create(raw_command);
   145			if (!ret || ret != -ECANCELED)
   146				break;
   147		}
   148		if (ret == -ECANCELED) {
   149			/* Wrong dynamic event. Leave an error message. */
 > 150			trace_probe_log_init("dynevent", 1, &raw_command);
 > 151			trace_probe_log_err(0, BAD_DYN_EVENT);
 > 152			trace_probe_log_clear();
   153			ret = -EINVAL;
   154		}
   155	
   156		mutex_unlock(&dyn_event_ops_mutex);
   157	
   158		return ret;
   159	}
   160	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
