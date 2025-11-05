Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096FC2BE7C3;
	Wed,  5 Nov 2025 10:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762337166; cv=none; b=MOCqJ3jBT3Fm5LKwu98jtz+N53WXuMmxEMY1u8h/yswL7DqPhlciiFfJWUjrANEKHGq/t5VsmghyIQqm0NAp0hZ6uC+s6l5/atJBgr5ACNdkVPsfGDt5rPZwcSGwwOuI3LLw3JqS5YnA13hVNdwi5NWWx9nV+DQyFfUM9KkXI6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762337166; c=relaxed/simple;
	bh=rhnNMaNldpuuY6bLfPKspqW4HOto/k+qhHYtxszFafw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q4/wF9MhK0HDU69/huTer9YTi/wMsxtVK4J5tDZDnew+5nzqCOzKQcTxmMR/Su5/fpKWtNays9NNjUzJXwpRYFe4zPM6iWa8LA1zFtEs00n1W+KAztYfRMobOnIQsEuM9ENV0rHrP2Kd4IYdyKEImY8g/Nu6CJoV6MqZ+hjOokI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fp4OO9+7; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fp4OO9+7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762337164; x=1793873164;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rhnNMaNldpuuY6bLfPKspqW4HOto/k+qhHYtxszFafw=;
  b=fp4OO9+7zOHu4z1plVbSbxu+5Uqv4e++whK9hCJJb5GQ0WPdZfc8shmu
   j2nDkQQzxOBk192b2Z33enSBQuv1ekA5vxbOl80xaB8Wpeeo1i3z/6hCt
   nxzXLamWIK6tol2Q80wkziJfR35q9Q9cqB6aDWZK+7LA9CyDoi4PjDxG0
   sMEsZusI03TuSDMPs9FHRF4DVygXyKmrJy2iIkeEsXD3NQ8MCYmKYSwEZ
   x3lc8onwIP7Twanj0IttO0t6FSPZto9jVSFjBIduVeDOUjfmJF1Au7g/M
   cEYX5ZooRiJi/dbUr+02iTqvpymPE/ocPVSBI/hQK6AxZuPvwcvjQoEbb
   A==;
X-CSE-ConnectionGUID: Y+oPjlIeRl2QjaaNldLQFw==
X-CSE-MsgGUID: BO6ccbxzRxGnRzPFI9+mXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="87076076"
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="87076076"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 02:06:04 -0800
X-CSE-ConnectionGUID: eGsYSZUDTvuiBTUsFe/q/w==
X-CSE-MsgGUID: YEUFJmhwQw6HC3yWhgzY/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="218059658"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 05 Nov 2025 02:06:02 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vGaOt-000SP4-1E;
	Wed, 05 Nov 2025 10:05:59 +0000
Date: Wed, 5 Nov 2025 18:05:41 +0800
From: kernel test robot <lkp@intel.com>
To: Huiwen He <hehuiwen@kylinos.cn>, Steven Rostedt <rostedt@goodmis.org>
Cc: oe-kbuild-all@lists.linux.dev, Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Huiwen He <hehuiwen@kylinos.cn>
Subject: Re: [PATCH] tracing/hist: make err_text array fully const
Message-ID: <202511051755.CU1HPYCx-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on trace/for-next]
[also build test WARNING on linus/master v6.18-rc4 next-20251105]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Huiwen-He/tracing-hist-make-err_text-array-fully-const/20251104-125932
base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
patch link:    https://lore.kernel.org/r/20251104045558.1644671-1-hehuiwen%40kylinos.cn
patch subject: [PATCH] tracing/hist: make err_text array fully const
config: sh-randconfig-r121-20251105 (https://download.01.org/0day-ci/archive/20251105/202511051755.CU1HPYCx-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251105/202511051755.CU1HPYCx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511051755.CU1HPYCx-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/trace/trace_events_hist.c:808:53: sparse: sparse: incorrect type in argument 4 (different modifiers) @@     expected char const **errs @@     got char const *const * @@
   kernel/trace/trace_events_hist.c:808:53: sparse:     expected char const **errs
   kernel/trace/trace_events_hist.c:808:53: sparse:     got char const *const *

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
