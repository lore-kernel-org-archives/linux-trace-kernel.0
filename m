Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1641517B421;
	Sun, 16 Feb 2025 22:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739745604; cv=none; b=ASfX65j9ApOKVazJsuWhYBA+jbKhszND4ofmrdo0ZulTa3fmokPIy0RIaFmFBeCtX2FDp9c/dP8IhZVOg36U3fs6u0zTChguvwiBOVcJkuVOczVcOGIDD1Ta7fdgaAPpy9fh+S316jcY8yC71uEt7472P3lnt9Cb4PF0hwb7ATI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739745604; c=relaxed/simple;
	bh=XDkFH1CKivV42f88DbYlsdJizxC8wr6s3JGgLIo07Dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K6vmhQy4jKK2Q0b40CoFAOdVT65ULzBFTtyxXsgHCtRyzaKAi0ArqKqa8gamAGtD7HoSrBsRNJfL3bRuuvijUspO7Oghgxcs5uQ6JYvknaJH4JAE3UW44Zm3KqMwQBHjqtdIFjdO1E5lR8yrz/OFRO3KrjZ8yb8sEcRLbsMQiu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XiMe4ITI; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XiMe4ITI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739745602; x=1771281602;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XDkFH1CKivV42f88DbYlsdJizxC8wr6s3JGgLIo07Dc=;
  b=XiMe4ITIvO3nMU7VZEXMgpfPNMFfXAlywfiCarry/d4v4ff0lSrKDNB0
   viEul9t1Gu2uKJXDSAdn7Oz7cqdq0p+AAyr1NC45OFsi2Cba3HiyWPJdw
   YP8Zo4WXv0XR82emw0c+LRHusogl+yKD+tzYKUtpgnjfYet1tELvj7MEC
   vqSEEB2wLohurYijNdnOiqhbcIuGKhOojcLkByaMa+esLrvpe8r8r2+ic
   VfcilvHSpJSzL+uBaqEiDu1ICKcCEfMxeJdMv1mddmdLtWsz+1zbKMjiS
   QpTQxmm4mIwcDpJystfNhpFKtrBWP/oGYcMqL8W4SsoKO3VHghxYXi8QZ
   A==;
X-CSE-ConnectionGUID: xa+6kdWiQ/6o9LY2m0u5eQ==
X-CSE-MsgGUID: dW508GixT7WSt+EJasopvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11347"; a="44078086"
X-IronPort-AV: E=Sophos;i="6.13,291,1732608000"; 
   d="scan'208";a="44078086"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 14:40:02 -0800
X-CSE-ConnectionGUID: dP14IB77TLO3/MsDIhTVbQ==
X-CSE-MsgGUID: tgF2EO7kStSS4QJY5R8v7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,291,1732608000"; 
   d="scan'208";a="118972905"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 16 Feb 2025 14:39:59 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tjnIr-001CHP-0w;
	Sun, 16 Feb 2025 22:39:57 +0000
Date: Mon, 17 Feb 2025 06:39:41 +0800
From: kernel test robot <lkp@intel.com>
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Gabriele Monaco <gmonaco@redhat.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH v2 04/11] rv: Add option for nested monitors and include
 sched
Message-ID: <202502170630.xSYE4cUk-lkp@intel.com>
References: <20250213090819.419470-5-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213090819.419470-5-gmonaco@redhat.com>

Hi Gabriele,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 4dc1d1bec89864d8076e5ab314f86f46442bfb02]

url:    https://github.com/intel-lab-lkp/linux/commits/Gabriele-Monaco/tracing-Fix-DECLARE_TRACE_CONDITION/20250213-171642
base:   4dc1d1bec89864d8076e5ab314f86f46442bfb02
patch link:    https://lore.kernel.org/r/20250213090819.419470-5-gmonaco%40redhat.com
patch subject: [PATCH v2 04/11] rv: Add option for nested monitors and include sched
config: parisc-randconfig-r112-20250217 (https://download.01.org/0day-ci/archive/20250217/202502170630.xSYE4cUk-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 14.2.0
reproduce: (https://download.01.org/0day-ci/archive/20250217/202502170630.xSYE4cUk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502170630.xSYE4cUk-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/trace/define_trace.h:119,
                    from kernel/trace/rv/rv_trace.h:130,
                    from kernel/trace/rv/rv.c:148:
>> include/trace/trace_events.h:477:13: warning: 'print_fmt_error_da_monitor' defined but not used [-Wunused-variable]
     477 | static char print_fmt_##call[] = print;                                 \
         |             ^~~~~~~~~~
   kernel/trace/rv/./rv_trace.h:39:1: note: in expansion of macro 'DECLARE_EVENT_CLASS'
      39 | DECLARE_EVENT_CLASS(error_da_monitor,
         | ^~~~~~~~~~~~~~~~~~~
>> include/trace/trace_events.h:477:13: warning: 'print_fmt_event_da_monitor' defined but not used [-Wunused-variable]
     477 | static char print_fmt_##call[] = print;                                 \
         |             ^~~~~~~~~~
   kernel/trace/rv/./rv_trace.h:12:1: note: in expansion of macro 'DECLARE_EVENT_CLASS'
      12 | DECLARE_EVENT_CLASS(event_da_monitor,
         | ^~~~~~~~~~~~~~~~~~~
>> include/trace/trace_events.h:223:37: warning: 'trace_event_type_funcs_error_da_monitor' defined but not used [-Wunused-variable]
     223 | static struct trace_event_functions trace_event_type_funcs_##call = {   \
         |                                     ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/trace/rv/./rv_trace.h:39:1: note: in expansion of macro 'DECLARE_EVENT_CLASS'
      39 | DECLARE_EVENT_CLASS(error_da_monitor,
         | ^~~~~~~~~~~~~~~~~~~
>> include/trace/trace_events.h:223:37: warning: 'trace_event_type_funcs_event_da_monitor' defined but not used [-Wunused-variable]
     223 | static struct trace_event_functions trace_event_type_funcs_##call = {   \
         |                                     ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/trace/rv/./rv_trace.h:12:1: note: in expansion of macro 'DECLARE_EVENT_CLASS'
      12 | DECLARE_EVENT_CLASS(event_da_monitor,
         | ^~~~~~~~~~~~~~~~~~~


vim +/print_fmt_error_da_monitor +477 include/trace/trace_events.h

46ac51822a6a0b Steven Rostedt (Red Hat  2015-09-23  473) 
46ac51822a6a0b Steven Rostedt (Red Hat  2015-09-23  474) #undef DECLARE_EVENT_CLASS
46ac51822a6a0b Steven Rostedt (Red Hat  2015-09-23  475) #define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
46ac51822a6a0b Steven Rostedt (Red Hat  2015-09-23  476) _TRACE_PERF_PROTO(call, PARAMS(proto));					\
46ac51822a6a0b Steven Rostedt (Red Hat  2015-09-23 @477) static char print_fmt_##call[] = print;					\
46ac51822a6a0b Steven Rostedt (Red Hat  2015-09-23  478) static struct trace_event_class __used __refdata event_class_##call = { \
46ac51822a6a0b Steven Rostedt (Red Hat  2015-09-23  479) 	.system			= TRACE_SYSTEM_STRING,			\
04ae87a52074e2 Peter Zijlstra           2019-10-24  480  	.fields_array		= trace_event_fields_##call,		\
46ac51822a6a0b Steven Rostedt (Red Hat  2015-09-23  481) 	.fields			= LIST_HEAD_INIT(event_class_##call.fields),\
46ac51822a6a0b Steven Rostedt (Red Hat  2015-09-23  482) 	.raw_init		= trace_event_raw_init,			\
46ac51822a6a0b Steven Rostedt (Red Hat  2015-09-23  483) 	.probe			= trace_event_raw_event_##call,		\
46ac51822a6a0b Steven Rostedt (Red Hat  2015-09-23  484) 	.reg			= trace_event_reg,			\
46ac51822a6a0b Steven Rostedt (Red Hat  2015-09-23  485) 	_TRACE_PERF_INIT(call)						\
46ac51822a6a0b Steven Rostedt (Red Hat  2015-09-23  486) };
46ac51822a6a0b Steven Rostedt (Red Hat  2015-09-23  487) 

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
