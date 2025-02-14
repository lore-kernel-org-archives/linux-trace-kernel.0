Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1F321CC4D;
	Fri, 14 Feb 2025 08:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739520041; cv=none; b=qViv8cbbaCRlQi5ZDlIdmmnmlP4vip1VmzHmVYjZtCwcY+hr66mJCaXO0rjMuof5ELglONN7zVf6qEQMQS48/QatZVE8YmEU/TjSIUa+oYqOKHyjSs/PY9M73q/ixMLLvXzLoB4DW0gbDfFIbha+ZpGQtmxJrIJjr9aYo03lSOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739520041; c=relaxed/simple;
	bh=v8hYqpTwAwdY3wJCEKVEjENut2Exj9ilsZyzIlA7VIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WL9nKPzWtmFxvAT0WlVUvYDyaDkpOmvO90mHHiG/SNCnsJdnQtq4HGze4Zc/ScFRUCOjCep1L4AUNypHGAtoVcuUigjmT9thSribrCmv1JI1rrjBRoRYtvm39c0nmg2z+0x2F00ULmeJF9F+PslApfMjq6KHR7m/lQc47fQMZdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ss3JsjB+; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ss3JsjB+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739520040; x=1771056040;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v8hYqpTwAwdY3wJCEKVEjENut2Exj9ilsZyzIlA7VIc=;
  b=Ss3JsjB++WvgReWc86xLGCUYXAmFR4ipiALbjNq57hdlck9iqsU2/Xzs
   kDDjB3TVZgOCzj1wGf/xuMsslseMAl8FVP3tNbzSgAx7rGy8t5SGIPNWq
   Rql87wLDOfYcNdkNSN3eSHAkAyh6ClHyAprxJgohYc0je+gdj8/FTS8vk
   Atev5Qio96me2JhA9CQ6sVlCkDVwFfXZgsn+gyCe7jf8wKfxSrtZNyegZ
   Q1LUrQIa7zPlVgKWfW6dHQI/z9km8JZOk+gFyvoCwhrCoxtiqTXtzmdD2
   IqZwT65u9z2y5/2XNMLDk4VdS17JY9TzFX0xnQ10+Q/FaRigtDW+rmyPi
   A==;
X-CSE-ConnectionGUID: D0gXEUzoQBusCVa9FPh2ug==
X-CSE-MsgGUID: bVlkWACYSWy75zlhyB+/dg==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="57666760"
X-IronPort-AV: E=Sophos;i="6.13,285,1732608000"; 
   d="scan'208";a="57666760"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 00:00:40 -0800
X-CSE-ConnectionGUID: sFldRYM+S2WPmtEdqfEVvQ==
X-CSE-MsgGUID: Eh1FUK/UQRW996/whU3rZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113253143"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 14 Feb 2025 00:00:37 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tiqck-0019FP-2J;
	Fri, 14 Feb 2025 08:00:34 +0000
Date: Fri, 14 Feb 2025 16:00:19 +0800
From: kernel test robot <lkp@intel.com>
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Gabriele Monaco <gmonaco@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH v2 03/11] sched: Add sched tracepoints for RV task model
Message-ID: <202502141516.OkUInaxw-lkp@intel.com>
References: <20250213090819.419470-4-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213090819.419470-4-gmonaco@redhat.com>

Hi Gabriele,

kernel test robot noticed the following build errors:

[auto build test ERROR on 4dc1d1bec89864d8076e5ab314f86f46442bfb02]

url:    https://github.com/intel-lab-lkp/linux/commits/Gabriele-Monaco/tracing-Fix-DECLARE_TRACE_CONDITION/20250213-171642
base:   4dc1d1bec89864d8076e5ab314f86f46442bfb02
patch link:    https://lore.kernel.org/r/20250213090819.419470-4-gmonaco%40redhat.com
patch subject: [PATCH v2 03/11] sched: Add sched tracepoints for RV task model
config: i386-buildonly-randconfig-001-20250214 (https://download.01.org/0day-ci/archive/20250214/202502141516.OkUInaxw-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250214/202502141516.OkUInaxw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502141516.OkUInaxw-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/sched/core.c: In function '__do_trace_set_current_state':
>> kernel/sched/core.c:503:9: error: implicit declaration of function '__do_trace_sched_set_state_tp'; did you mean 'trace_sched_set_state_tp'? [-Werror=implicit-function-declaration]
     503 |         __do_trace_sched_set_state_tp(current, current->__state, state_value);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |         trace_sched_set_state_tp
   cc1: some warnings being treated as errors


vim +503 kernel/sched/core.c

   496	
   497	/*
   498	 * Do not call this function directly since it won't check if the tp is enabled.
   499	 * Call the helper macro trace_set_current_state instead.
   500	 */
   501	void __do_trace_set_current_state(int state_value)
   502	{
 > 503		__do_trace_sched_set_state_tp(current, current->__state, state_value);
   504	}
   505	EXPORT_SYMBOL(__do_trace_set_current_state);
   506	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
