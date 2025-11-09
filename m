Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C492D274FE8;
	Sun,  9 Nov 2025 11:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762686338; cv=none; b=hnJjQo5oG7x8qEctMsKpc+gV+AXdnkg+UcpTVJ0pIwKJhNt3Lh0MBJD96wBRd0ijsRFtaucrNVxYdXJqIQXKJw2lEkn693mU7yo7B9TwZVZXXlFqitmirdw3jhdvDESl+mnwm1HlUNQBbPwMXjXbiHNqTC6qG97IYiRfpaHOzu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762686338; c=relaxed/simple;
	bh=LbQh+xSzxA3IF+wgNKPSQawE5YX+Rtz2OEaR+RSqaAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tkyFVAzfvCoBMjgehMFVHT9/IFi8sK7hm3xZybhlynblTE1zCQDOt95UyD3J3QosyDqwxKaDh2Hk6o3HNOzu55TQm8SfGoe4tb6j3xNY/SppzOG2dNDwOSrHIEdda8kpzBmWd7+C36mM3xoXEeh0pRyQujOGpQ9a2uBJLz70LaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lSqs10w5; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lSqs10w5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762686336; x=1794222336;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LbQh+xSzxA3IF+wgNKPSQawE5YX+Rtz2OEaR+RSqaAw=;
  b=lSqs10w5JEmnGYaZJ8j5YygTn4FBkJtEgSs7NlGq7stni93X1omTlR33
   v4vzhEOkRL9jYgaM55+xPz4h/kPGJk2Fi7lT/bWXflqhNl/UXe/nqjZtp
   CWowKvdItOpxG00WO+rtzSNsnYLIa7a6zRv0tp4rE5+aiI8TDWVroUxka
   lu1fmzQwo3F61XFsISUqJ2wTwm86nmJWi+FmNXs9Vp9s31zUvr9GqgmpN
   v/i7jPsP0JAw+Ddvniuapzw8TQ8QokGEhxKI/9GlJ1NHZ0YDYciFaPWnu
   Zq0iK6PTeBcAocJV9Hyujrj49N0VQBbuGOjAf+qTrw0GTI2zqtCYDIP1W
   w==;
X-CSE-ConnectionGUID: zLoR9wHdQMqw30TOG4zxHQ==
X-CSE-MsgGUID: 1o4PW84xQMK1FmnrM5c66Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11607"; a="64802050"
X-IronPort-AV: E=Sophos;i="6.19,291,1754982000"; 
   d="scan'208";a="64802050"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2025 03:05:36 -0800
X-CSE-ConnectionGUID: rnSx8d0ZRpyViNuHfq8F4A==
X-CSE-MsgGUID: YM+tXY0mQx65//3IMwaAzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,291,1754982000"; 
   d="scan'208";a="188692485"
Received: from lkp-server01.sh.intel.com (HELO 6ef82f2de774) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 09 Nov 2025 03:05:35 -0800
Received: from kbuild by 6ef82f2de774 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vI3Ei-0001x3-2c;
	Sun, 09 Nov 2025 11:05:32 +0000
Date: Sun, 9 Nov 2025 19:05:10 +0800
From: kernel test robot <lkp@intel.com>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Report wrong dynamic event command
Message-ID: <202511091817.JzD0Zi0O-lkp@intel.com>
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
config: parisc-randconfig-001-20251109 (https://download.01.org/0day-ci/archive/20251109/202511091817.JzD0Zi0O-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 9.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251109/202511091817.JzD0Zi0O-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511091817.JzD0Zi0O-lkp@intel.com/

All errors (new ones prefixed by >>):

   hppa-linux-ld: kernel/trace/trace_dynevent.o: in function `create_dyn_event':
>> (.text+0x610): undefined reference to `trace_probe_log_init'
>> hppa-linux-ld: (.text+0x61c): undefined reference to `__trace_probe_log_err'
>> hppa-linux-ld: (.text+0x624): undefined reference to `trace_probe_log_clear'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
