Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911A4332EAF;
	Wed,  5 Nov 2025 15:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762355571; cv=none; b=TAjYqr9/O9ZvCsWFvTa44KQ5rT8nvOpECyRXKa3PSU7GxBew2zR9PwJGCAaQfXXcmA90D9j+/IWpDz+HDjCm8QHjpAq5NkSnd5G33qxHFLeHT+K8ZXd8HSzA9bwzGId6wRnINgdk9zlPUxlFLTtXKXSbz/ysmSvT9KlD1NDJeq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762355571; c=relaxed/simple;
	bh=4jNzxRoMHZjr6VIuIaZcxXkpasduQGiB2dpThrzFEIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WUhZHTV2nja9LXXv4sKEhuer2HTzlXxVoOD9JZMwNMmJXjNm/GryzQjflvv9Y9ChJK//4z17pC6VTDbu8bR94F0ds0sYFrr7zjImOossfc0s4DwPmX9wfJH2dDrVuQdByeA31qEZkDSiyUSC/c8QaHdWPjEXwS6p8tYqlXqtBhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kwd49WIX; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kwd49WIX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762355570; x=1793891570;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4jNzxRoMHZjr6VIuIaZcxXkpasduQGiB2dpThrzFEIQ=;
  b=Kwd49WIXUbhK5PQdRn6FX3IFNX6OKM5Bh7jokylTb3naX1unGl/Q+rnY
   cXDwEYqpnqw4m+HUZRQsxXvB/1tygodWJ845W+KobwDgBiTgXqJdLmpxv
   XJD8m79f/pWmgCEKjnPH45F6Ds8lMG2HxtnS3LayM7wAvg0wHM7GdeXfC
   vhlqIoHJK6jioEk+ClwfUOSQgBeOzydwTYF/ahrJV1BB1jEAhL5X2kjEK
   g2DsYz7Ug3AfsI7JcLdARZDTh5bz1SNIp3d6bALYfbTtptrZRWV2NQuON
   I2hXkAMWS9JpFSF7wYb6FgWZnt8ja5rsd4pq1yn3npgQH2h03O4n2owEr
   Q==;
X-CSE-ConnectionGUID: J9bLBFlpSAOQee6t5GgdoA==
X-CSE-MsgGUID: ZbWuANQaSSyu9tSRIiZ3tA==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="64169037"
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="64169037"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 07:12:49 -0800
X-CSE-ConnectionGUID: 2/egSiv/R2eSzBr3OrgV7g==
X-CSE-MsgGUID: K3fNOto6RruvAVgYshHAeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="218123761"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 05 Nov 2025 07:12:47 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vGf9v-000Sjk-1X;
	Wed, 05 Nov 2025 15:11:12 +0000
Date: Wed, 5 Nov 2025 23:09:08 +0800
From: kernel test robot <lkp@intel.com>
To: Huiwen He <hehuiwen@kylinos.cn>, Steven Rostedt <rostedt@goodmis.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Huiwen He <hehuiwen@kylinos.cn>
Subject: Re: [PATCH] tracing/hist: make err_text array fully const
Message-ID: <202511052258.kdB9B0rI-lkp@intel.com>
References: <20251104045558.1644671-1-hehuiwen@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104045558.1644671-1-hehuiwen@kylinos.cn>

Hi Huiwen,

kernel test robot noticed the following build errors:

[auto build test ERROR on trace/for-next]
[also build test ERROR on linus/master v6.18-rc4 next-20251105]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Huiwen-He/tracing-hist-make-err_text-array-fully-const/20251104-125932
base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
patch link:    https://lore.kernel.org/r/20251104045558.1644671-1-hehuiwen%40kylinos.cn
patch subject: [PATCH] tracing/hist: make err_text array fully const
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20251105/202511052258.kdB9B0rI-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251105/202511052258.kdB9B0rI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511052258.kdB9B0rI-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/trace/trace_events_hist.c:808:46: error: passing 'const char *const[49]' to parameter of type 'const char **' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
     808 |         tracing_log_err(tr, last_cmd_loc, last_cmd, err_text,
         |                                                     ^~~~~~~~
   kernel/trace/trace.h:2113:21: note: passing argument to parameter 'errs' here
    2113 |                             const char **errs, u8 type, u16 pos);
         |                                          ^
   1 error generated.


vim +808 kernel/trace/trace_events_hist.c

4b147936fa5096 Tom Zanussi      2018-01-15  802  
edfeed318d59ff Tom Zanussi      2022-01-28  803  static void hist_err(struct trace_array *tr, u8 err_type, u16 err_pos)
7bbab38d07f318 Masami Hiramatsu 2018-11-05  804  {
edfeed318d59ff Tom Zanussi      2022-01-28  805  	if (!last_cmd)
edfeed318d59ff Tom Zanussi      2022-01-28  806  		return;
edfeed318d59ff Tom Zanussi      2022-01-28  807  
726721a51838e3 Tom Zanussi      2020-05-28 @808  	tracing_log_err(tr, last_cmd_loc, last_cmd, err_text,
726721a51838e3 Tom Zanussi      2020-05-28  809  			err_type, err_pos);
7bbab38d07f318 Masami Hiramatsu 2018-11-05  810  }
7bbab38d07f318 Masami Hiramatsu 2018-11-05  811  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
