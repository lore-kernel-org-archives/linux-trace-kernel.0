Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080A33128A3;
	Tue, 10 Feb 2026 17:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770745316; cv=none; b=UZN5jNMZQNPQ3b3UWD5Q2lb66WpWREEtS0w/Lic2ICYhhrbh6k0tdq2z+RWwSfZ16MlZP9OqkDOFpAMYKCbmhnP84zJykBuruEIl0VokPYoK6fyK89byCjvNzjZEDa3pg1dfUa4FYoE4IF7Apu29PBxUJ3yVCgcxG2S9/Ye0DIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770745316; c=relaxed/simple;
	bh=5qnxxgC8X5cqDGPNVY0YKM8Zw/ErGQNi76szcrkBLmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AcuqO817nUkG5vQkuNzLwV/rJkrF9NMC8pa+lkvplUK67P/QSzF4AfrJ/YOMnzY7a0pYavG4iDaCX8kuq88vO/fdUKS6H5FY7xoQFXe6djmnYFqOY/nvSMitZqb9z5HvGf8FYbCLX3lbmEbQKKsZ+4rvgn1GtUl39fmNKZoWZR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KZaXxdXs; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KZaXxdXs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770745314; x=1802281314;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5qnxxgC8X5cqDGPNVY0YKM8Zw/ErGQNi76szcrkBLmY=;
  b=KZaXxdXsAYK4Et3C8IJVJFV6InDArY6mva7HBBSCoVeS01hjuwdbv4LF
   0RmnfdpJo+9klZH6/hONFuCC9EdCiFsJ36j+EYpO1JmGTemV5/cdcS2VG
   1393VTG+9RfSPkV5Cq2Rk2EfyEMVFOB1/8JVYhZxhIIKd/b9j4g4Ye/bY
   FJ6wxoUmTxjAVoQNyyeijwRfnwJZpvF2QqmAnPMqbHDhoEYa2FzZCv+HQ
   ZS0pvAZO9WHwUJlaedEYqw2zmm4zeJLwERgJPbhSrr99bUgAc0Yoa+6vh
   umGKkycvy9n7ZAXD73/Wy1UM8ygD3wqZ4VShyJ3whMbgJjBeb1yprCzM1
   A==;
X-CSE-ConnectionGUID: UohWJbXUR+O8+dV3an/APw==
X-CSE-MsgGUID: NUNeuVU5QJu0z6+uGhZ5ew==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="89472822"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="89472822"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 09:41:53 -0800
X-CSE-ConnectionGUID: cMEUApTrQFqBMnpKoHWOfw==
X-CSE-MsgGUID: 7B1NQzmuQwm+nDwd75HCxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="234960119"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 10 Feb 2026 09:41:51 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vprkC-00000000pGW-3bmc;
	Tue, 10 Feb 2026 17:41:48 +0000
Date: Wed, 11 Feb 2026 01:40:48 +0800
From: kernel test robot <lkp@intel.com>
To: Petr Pavlu <petr.pavlu@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Petr Pavlu <petr.pavlu@suse.com>
Subject: Re: [PATCH 1/5] tracing: Fix checking of freed trace_event_file for
 hist files
Message-ID: <202602110125.71oIfNm0-lkp@intel.com>
References: <20260210113427.1068932-2-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210113427.1068932-2-petr.pavlu@suse.com>

Hi Petr,

kernel test robot noticed the following build errors:

[auto build test ERROR on 05f7e89ab9731565d8a62e3b5d1ec206485eeb0b]

url:    https://github.com/intel-lab-lkp/linux/commits/Petr-Pavlu/tracing-Fix-checking-of-freed-trace_event_file-for-hist-files/20260210-194023
base:   05f7e89ab9731565d8a62e3b5d1ec206485eeb0b
patch link:    https://lore.kernel.org/r/20260210113427.1068932-2-petr.pavlu%40suse.com
patch subject: [PATCH 1/5] tracing: Fix checking of freed trace_event_file for hist files
config: x86_64-buildonly-randconfig-004-20260210 (https://download.01.org/0day-ci/archive/20260211/202602110125.71oIfNm0-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260211/202602110125.71oIfNm0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602110125.71oIfNm0-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/trace/trace_events.c: In function 'remove_event_file_dir':
>> kernel/trace/trace_events.c:1300:9: error: implicit declaration of function 'hist_poll_wakeup' [-Wimplicit-function-declaration]
    1300 |         hist_poll_wakeup();
         |         ^~~~~~~~~~~~~~~~


vim +/hist_poll_wakeup +1300 kernel/trace/trace_events.c

  1289	
  1290	static void remove_event_file_dir(struct trace_event_file *file)
  1291	{
  1292		eventfs_remove_dir(file->ei);
  1293		list_del(&file->list);
  1294		remove_subsystem(file->system);
  1295		free_event_filter(file->filter);
  1296		file->flags |= EVENT_FILE_FL_FREED;
  1297		event_file_put(file);
  1298	
  1299		/* Wake up hist poll waiters to notice the EVENT_FILE_FL_FREED flag. */
> 1300		hist_poll_wakeup();
  1301	}
  1302	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
