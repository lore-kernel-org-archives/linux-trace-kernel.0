Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8A813CFB7;
	Thu, 12 Sep 2024 21:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726175006; cv=none; b=pBrMQefhWFWbbbroHLskfIQnM+0SL7e7dyb0CdBmgxfXHPgj5vYk2dOVXjj3Vm461UUuqt1OmJ7Mw8lEf4G3kjcIfhxUEKJm0SEWU1j7W7y0ZfctUmJtQXUmns8WE8tO0hQOENl5PLFHq+mTO1ko5FiSfJ/8pDvOTot7lDTp7yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726175006; c=relaxed/simple;
	bh=l0M0BTQTdn4ZzXg3VfpaKLI6M9qF07AMt5X4kfEMAmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F0Qmi1Yde7eHoR/tlUESBATDYpvYCC9NfRFIaHv2iK/ADwv+cV+gp4wiWWRJIQBlgPLTx+rKrLG2NgxrG15R5w93brquIxV7AChRk6iOGZX4gV2NdNs42sKV0XhJAyM2R8eCzSqW7RxLMyXcXZJhVas3ImD7WtBFLnu+v0/TqUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E+Tna/uv; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E+Tna/uv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726175004; x=1757711004;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=l0M0BTQTdn4ZzXg3VfpaKLI6M9qF07AMt5X4kfEMAmk=;
  b=E+Tna/uvPGtZNNDUT6BC4J0oABxnD/UdRecBCvrowYO6gjqZgcHZ6cY4
   GQ3lmOKUSOWHw7zNX3X3/K5yz4rG4NgzxDEpHCNrPPsR3Qi5Ui2k4h1hE
   Dr//1WjET8WC3XYPwrRkLX7q6OksY+WKeNH/cjVdQVDVa38aU5cwaqtBL
   Rbtu0b3PZk5ZB3E+shmDxhDZniV6BIKEAgB2ny3x2LIozu3TNGhWRu0wv
   EY6iFuOWXbBWDSDbZbkc9ICuysPRZRjDwO1BGZNT4PO60hiFCA1MuZOFq
   Mr2cSBkTQYQl3Sj8CPyUMMRxlC4VHA85vJ34i+1REVOlpmb53QYrVZNUJ
   g==;
X-CSE-ConnectionGUID: BWGk7HqUSviCWpMlJ+cf+g==
X-CSE-MsgGUID: eXwsgXa2RlanorPykdOB2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="50474843"
X-IronPort-AV: E=Sophos;i="6.10,224,1719903600"; 
   d="scan'208";a="50474843"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 14:03:23 -0700
X-CSE-ConnectionGUID: HE6EROGdStyoIENWrXdAEw==
X-CSE-MsgGUID: gR2t+/evRNiAO0PTOBpCjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,224,1719903600"; 
   d="scan'208";a="72610679"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 12 Sep 2024 14:03:20 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1soqyE-0005h8-0J;
	Thu, 12 Sep 2024 21:03:18 +0000
Date: Fri, 13 Sep 2024 05:02:48 +0800
From: kernel test robot <lkp@intel.com>
To: Levi Yun <yeoreum.yun@arm.com>, peterz@infradead.org,
	mark.rutland@arm.com, james.clark@linaro.org, rostedt@goodmis.org,
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, mingo@elte.hu
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Levi Yun <yeoreum.yun@arm.com>
Subject: Re: [PATCH] trace/trace_event_perf: remove duplicate samples on the
 first tracepoint event
Message-ID: <202409130445.H7LIIGpd-lkp@intel.com>
References: <20240911122747.4168556-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911122747.4168556-1-yeoreum.yun@arm.com>

Hi Levi,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.11-rc7 next-20240912]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Levi-Yun/trace-trace_event_perf-remove-duplicate-samples-on-the-first-tracepoint-event/20240911-202917
base:   linus/master
patch link:    https://lore.kernel.org/r/20240911122747.4168556-1-yeoreum.yun%40arm.com
patch subject: [PATCH] trace/trace_event_perf: remove duplicate samples on the first tracepoint event
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20240913/202409130445.H7LIIGpd-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240913/202409130445.H7LIIGpd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409130445.H7LIIGpd-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/trace/trace_event_perf.c:360:24: error: use of undeclared identifier 'event'
     360 |         if (is_sampling_event(event)) {
         |                               ^
   1 error generated.


vim +/event +360 kernel/trace/trace_event_perf.c

   351	
   352	int perf_trace_add(struct perf_event *p_event, int flags)
   353	{
   354		struct trace_event_call *tp_event = p_event->tp_event;
   355		struct hw_perf_event *hwc = &p_event->hw;
   356	
   357		if (!(flags & PERF_EF_START))
   358			p_event->hw.state = PERF_HES_STOPPED;
   359	
 > 360		if (is_sampling_event(event)) {
   361			hwc->last_period = hwc->sample_period;
   362			perf_swevent_set_period(p_event);
   363		}
   364	
   365		/*
   366		 * If TRACE_REG_PERF_ADD returns false; no custom action was performed
   367		 * and we need to take the default action of enqueueing our event on
   368		 * the right per-cpu hlist.
   369		 */
   370		if (!tp_event->class->reg(tp_event, TRACE_REG_PERF_ADD, p_event)) {
   371			struct hlist_head __percpu *pcpu_list;
   372			struct hlist_head *list;
   373	
   374			pcpu_list = tp_event->perf_events;
   375			if (WARN_ON_ONCE(!pcpu_list))
   376				return -EINVAL;
   377	
   378			list = this_cpu_ptr(pcpu_list);
   379			hlist_add_head_rcu(&p_event->hlist_entry, list);
   380		}
   381	
   382		return 0;
   383	}
   384	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
