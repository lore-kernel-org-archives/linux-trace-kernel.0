Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FFD1E4BE;
	Tue, 10 Feb 2026 18:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770749878; cv=none; b=h9fHi9wmNkRYTHX9lKIgnxQL22izkZi3ziox2sCObfXIqZuYXZYDvLAQBZnmvEsQvTxpxPS54JbAEAQkZZQHyYVD/U/Aa0XSXhhvKW1ihqdqMNe7e4z7ydUEXrp9l0aX8/bKIyoixFHfbUxI011Dxw24jrUEpt7Ab935wmS4KFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770749878; c=relaxed/simple;
	bh=ndnRyaUEXpAoWZMC4allwdMXxMR/8rO/epz3OUkXb0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N01NxzTK69jB2FW1infeuPym0YoqDyJPL5kmqHFNjrCHCvFjtZ1bIZE4nCp8om23Nerg4A+LXuYuGr2WDhiMr/uByDVzhe0UDA8yRKgpG3QxK+BsAnIn4D0Z7G4/mBnlFAdCG94x5ovt18BAbvcs1ckj5amVxEISRDSM7QisV5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IX+cRBmT; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IX+cRBmT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770749878; x=1802285878;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ndnRyaUEXpAoWZMC4allwdMXxMR/8rO/epz3OUkXb0Q=;
  b=IX+cRBmTk3DNbiHBazbiiKww9wUX/KwNvFsbFlS4hJVpWpD0BKaKFJ67
   NGjj490wJ5IaXpyFMlON0pwiNWeZSUA+YkmueYEx5zL/7OMv4iBM3Pywh
   fbPfrzSyz0iBxZMdSiIVerNqcw+iJ5KzI7H1njqt3Z4VyNHnLnZ3WYbzB
   v15UZIEl8jks6eSfzG9sz+Z+l0F/H8nY7qYe1LQH53lW9v9Plj/uz2Vue
   Ql+gFfgTNkOz6ruWXDa7RjGrS9QXHUpgXD3UeKGT6to/hQmfx6T+GMfTQ
   eEnMK6Rv+XketqLRYGKcTVbBerxOH4t5fPFpKIw/dQwD/UMk3z7r+e8xj
   Q==;
X-CSE-ConnectionGUID: r2K6zZKuTxm54Xe8wsYxNg==
X-CSE-MsgGUID: dY9K66kHRkCcuoYtMTaFbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="82618750"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="82618750"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 10:57:57 -0800
X-CSE-ConnectionGUID: PtIeTR/jRY+jT+Spna1GSA==
X-CSE-MsgGUID: 3ZsBTh6nQpaAKNUUFYRqfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="216538346"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 10 Feb 2026 10:57:55 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vpsvo-00000000pJw-1Mbo;
	Tue, 10 Feb 2026 18:57:52 +0000
Date: Wed, 11 Feb 2026 02:57:03 +0800
From: kernel test robot <lkp@intel.com>
To: Petr Pavlu <petr.pavlu@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Petr Pavlu <petr.pavlu@suse.com>
Subject: Re: [PATCH 1/5] tracing: Fix checking of freed trace_event_file for
 hist files
Message-ID: <202602110247.8HeuKXss-lkp@intel.com>
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
config: sparc64-defconfig (https://download.01.org/0day-ci/archive/20260211/202602110247.8HeuKXss-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260211/202602110247.8HeuKXss-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602110247.8HeuKXss-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/trace/trace_events.c:1300:2: error: call to undeclared function 'hist_poll_wakeup'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1300 |         hist_poll_wakeup();
         |         ^
   1 error generated.


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
