Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E87A19F42D;
	Thu, 12 Sep 2024 12:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726144539; cv=none; b=afsqD5M3r38nNu9OQuLrcHEx3zs/tlipUekL0AqHwc+Y4h/diMRmKFbKiyX7J2QQtafa0mFIOJpMXgwZ8lBqiSMw//qOlROnTt1b4lHMLDTi0xm88p1WcdLUNtoi4/8Fr9UUd7CjFwFMiRAiTCbjtGASIcAvMScErTn08P3iQGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726144539; c=relaxed/simple;
	bh=QE+hZV8eqeYJlZgA/eZa43htlQUKxwyLfSsv/+3TO1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xw/Eb0B3v/g2XcZ/+BhLTySr+nxQYYmuVxr2/2VjNiARQCaVkAwCD5Mz7pnuRbEPj8BPGrkLaVdg2vp3GgRv8t5BDOzDffBMGwdr61CXA5wqoPSxfTe7q9dfr+BmD0MTFWGlLqDClmgsGDtNlpwX7Ixl8BkqBNht5CkQWmE2kq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kryV5s15; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kryV5s15"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726144537; x=1757680537;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QE+hZV8eqeYJlZgA/eZa43htlQUKxwyLfSsv/+3TO1I=;
  b=kryV5s15ARjfHSgDQB+bErv2ourO5roS1jnjBwpNRWPcabnDcqtcrfOZ
   9ItBfEbi/fEQN04k2Zd+MJ/uL73H8Hn8ZIZ3aSQA+It57p1bAhAeXGeW3
   qldi2S+opNbR0ATuK3/BTijpw8InCJk1c7W6nyi9ntJC5LbrvdtGB7KcX
   VVoxtxIfxrPMaslCv76hF3a1QHF+z20fLz5lCwGkCdCmmc6MYnb9CcHCb
   oON0pyylCJsexOgSosp1hqZEb7YmZwEpOcct8B8erIsQeGzaahISBnBIA
   Y8SAVvwsQXOuzy/dhdha4nYAkoskQvquCGyLD0GQtaEEqhIa/Ac0R5O+0
   g==;
X-CSE-ConnectionGUID: M/FemamPQBWEjm8b1a+Njg==
X-CSE-MsgGUID: dM2KcxnpTeyIuX2cVtMxaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="42508170"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="42508170"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 05:34:59 -0700
X-CSE-ConnectionGUID: zFtikUdASJy1wNYt0ML1cQ==
X-CSE-MsgGUID: fDDGsRWzRqSIrw/Ctntn8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="72483178"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 12 Sep 2024 05:34:57 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1soj2E-00059O-0A;
	Thu, 12 Sep 2024 12:34:54 +0000
Date: Thu, 12 Sep 2024 20:34:07 +0800
From: kernel test robot <lkp@intel.com>
To: Levi Yun <yeoreum.yun@arm.com>, peterz@infradead.org,
	mark.rutland@arm.com, james.clark@linaro.org, rostedt@goodmis.org,
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, mingo@elte.hu
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, Levi Yun <yeoreum.yun@arm.com>
Subject: Re: [PATCH] trace/trace_event_perf: remove duplicate samples on the
 first tracepoint event
Message-ID: <202409122013.3PMFMv8D-lkp@intel.com>
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
config: sparc64-defconfig (https://download.01.org/0day-ci/archive/20240912/202409122013.3PMFMv8D-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240912/202409122013.3PMFMv8D-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409122013.3PMFMv8D-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/trace/trace_event_perf.c: In function 'perf_trace_add':
>> kernel/trace/trace_event_perf.c:360:31: error: 'event' undeclared (first use in this function); did you mean 'p_event'?
     360 |         if (is_sampling_event(event)) {
         |                               ^~~~~
         |                               p_event
   kernel/trace/trace_event_perf.c:360:31: note: each undeclared identifier is reported only once for each function it appears in


vim +360 kernel/trace/trace_event_perf.c

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
