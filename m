Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C952D1F7E;
	Wed,  5 Nov 2025 07:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762327090; cv=none; b=UnjK1G+VjU3+YEcaCryQYK4WPBjDtjmBiLsi0hL6WVbTBR68XXq0XPju4nd+9wunUhRpH+89YMZfCp1fxtAhWjxjf4UdauHT1rrko6QU33Uh/DVqJefcGM5v4M9zq5gP7sFVttj1L1m/ka/0JAmYxySf3QIG8dEvJ97feJ8fNBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762327090; c=relaxed/simple;
	bh=0jENaG5TcvsOk5HG6h+5wpqjihfYR/5a1tIT6kGcv+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G3K7d9emgUJoAwFc4p/u7iG6X0fmkwSRXZTEVHNgCW/lfwpBL+hJv2utiEfGN+k/C8XzvurUVOHP8OX/BXkd9u0nj1vEDbnZDS9hZZh+Pmw1Pl+aPBKNq6YRbsv3Gl7sMaDUO3G48g1MjOveicUErhXJLyMmReZdpu+VH5CMlgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=etE+g+Z+; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="etE+g+Z+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762327088; x=1793863088;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0jENaG5TcvsOk5HG6h+5wpqjihfYR/5a1tIT6kGcv+Y=;
  b=etE+g+Z+KXRRTkkwHmktsChFYu5ZS9OVM5TKzpty0UNL2y1ZsPfundc/
   wa6OqozxqAJirgz7RFTIScO6JpAeYymp4fKsrWAgMRw+51Ao7OCHvLHE/
   hscH8Bjr8rZVJ6feIIcjYsZzWAf4KTWeRB/9BZO0bTXYLwgIkzi3okuK7
   7cxbjv/MY+I6wYrK3LEOdvDERT7P0iXleLdepAFLY66b7ppdnzuyyaCt0
   ICjv9lvkCGkUuIp/aTkW4HdlvTU0QRba5OKm3izj78KvQTa8AvmVXK6SP
   aL/9Kk4sUC8u5rDp8H5WXzcZH0AuXu1RAKKzmGSMMNy3l4X9mz08P0C+7
   A==;
X-CSE-ConnectionGUID: aLLZdPTwS+aJMZpaUXmH/A==
X-CSE-MsgGUID: up8grP8hTnSTPinCWtuP5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="75883122"
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="75883122"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 23:18:07 -0800
X-CSE-ConnectionGUID: JYKnhvvcSxGl/MfEfg0OuA==
X-CSE-MsgGUID: apvBLsFmRbqVXCV7UjNzJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="187050142"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 04 Nov 2025 23:18:05 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vGXmH-000SFo-0o;
	Wed, 05 Nov 2025 07:17:58 +0000
Date: Wed, 5 Nov 2025 15:17:54 +0800
From: kernel test robot <lkp@intel.com>
To: Huiwen He <hehuiwen@kylinos.cn>, Steven Rostedt <rostedt@goodmis.org>
Cc: oe-kbuild-all@lists.linux.dev, Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Huiwen He <hehuiwen@kylinos.cn>
Subject: Re: [PATCH] tracing/hist: make err_text array fully const
Message-ID: <202511051436.6ZUGn3Af-lkp@intel.com>
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
[also build test WARNING on linus/master v6.18-rc4 next-20251104]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Huiwen-He/tracing-hist-make-err_text-array-fully-const/20251104-125932
base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
patch link:    https://lore.kernel.org/r/20251104045558.1644671-1-hehuiwen%40kylinos.cn
patch subject: [PATCH] tracing/hist: make err_text array fully const
config: riscv-randconfig-001-20251105 (https://download.01.org/0day-ci/archive/20251105/202511051436.6ZUGn3Af-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251105/202511051436.6ZUGn3Af-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511051436.6ZUGn3Af-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/trace/trace_events_hist.c: In function 'hist_err':
>> kernel/trace/trace_events_hist.c:808:46: warning: passing argument 4 of 'tracing_log_err' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     tracing_log_err(tr, last_cmd_loc, last_cmd, err_text,
                                                 ^~~~~~~~
   In file included from kernel/trace/trace_dynevent.h:14,
                    from kernel/trace/trace_synth.h:5,
                    from kernel/trace/trace_events_hist.c:22:
   kernel/trace/trace.h:2113:21: note: expected 'const char **' but argument is of type 'const char * const*'
           const char **errs, u8 type, u16 pos);
           ~~~~~~~~~~~~~^~~~


vim +808 kernel/trace/trace_events_hist.c

4b147936fa50965 Tom Zanussi      2018-01-15  802  
edfeed318d59ff2 Tom Zanussi      2022-01-28  803  static void hist_err(struct trace_array *tr, u8 err_type, u16 err_pos)
7bbab38d07f3185 Masami Hiramatsu 2018-11-05  804  {
edfeed318d59ff2 Tom Zanussi      2022-01-28  805  	if (!last_cmd)
edfeed318d59ff2 Tom Zanussi      2022-01-28  806  		return;
edfeed318d59ff2 Tom Zanussi      2022-01-28  807  
726721a51838e39 Tom Zanussi      2020-05-28 @808  	tracing_log_err(tr, last_cmd_loc, last_cmd, err_text,
726721a51838e39 Tom Zanussi      2020-05-28  809  			err_type, err_pos);
7bbab38d07f3185 Masami Hiramatsu 2018-11-05  810  }
7bbab38d07f3185 Masami Hiramatsu 2018-11-05  811  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
