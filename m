Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CF91FF7B4;
	Wed,  6 Aug 2025 20:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754512258; cv=none; b=i11mTfINOx+cNKkpEyYzFkVRCQIatBmQ6+fhGfoTcjn4gzyDve9OuWgSqzLjWTnFdnp7JHR39MuadhnudiokSJ0NEBITNPbh2dC5dt9UkvRYL3Ne6efio0LyiXHhb/vadK8dxuPmg7azvylWTb3DkGwuqlERFKqCIbPBtk3wvEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754512258; c=relaxed/simple;
	bh=IUvrNEmDlCZzmuFligTjfGnRr54fRAByHqiRZrgG2+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hv4LdJOhY3T/zVvWC1ehF55veyIN2/tvhEadVNGR9WM08NpVwHFUuKrPz/3mH4g2IbvSetb2Fk4EmoIOTfPDKtWWoCAhhX6U7OwZZ5LhZIAgIglhkAtC89kO5xgQDAnRoH38RcLKoZyM5a905VHh76cPXHCN5XByphdl19KJ6po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lgwfzB8P; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lgwfzB8P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754512256; x=1786048256;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IUvrNEmDlCZzmuFligTjfGnRr54fRAByHqiRZrgG2+o=;
  b=lgwfzB8PLT7hy8+WnnjA3EP18/+lHPyU7vlu9WhkqaeqVakT8ErEnd5I
   vCELXqA3UpPnsD3AvSWSuGvvueaL8ylCCs2BuMVXsJVmFFuGIDwjVp59B
   VbyuRwJjIGysuHCoAepSqSryFdM3sfM/hV9emAtPUg11surGctcJUZvxF
   BJ68ODxQnJz2jLBVbotDO9qdR50dmXpdVWArzvbxfVMK0JEGpHgZtgYhV
   T9+1WTmZfv21Pz5lLwyRUKs6W7nqcrqZDbE6G1ltMxasvTWqZoRTOzSKn
   Bz3zJY/Rpf1qASQ9fUlbvmYNk9azCh3I6nzpP9L3kKoIlGmk6TsnftAlM
   A==;
X-CSE-ConnectionGUID: +ud1jGIdTR6HxYcinXvncw==
X-CSE-MsgGUID: wsPEi5XETF2fw4AB1v9dxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="56806106"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="56806106"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 13:30:55 -0700
X-CSE-ConnectionGUID: UsXKBFW4QpCuPgMwmiQ6lA==
X-CSE-MsgGUID: 44kMhEi7QB2iCbTDY/YqCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="165666300"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 06 Aug 2025 13:30:50 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ujkmZ-00024O-1u;
	Wed, 06 Aug 2025 20:30:45 +0000
Date: Thu, 7 Aug 2025 04:28:42 +0800
From: kernel test robot <lkp@intel.com>
To: Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Nam Cao <namcao@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH v2 5/5] rv: Add rts monitor
Message-ID: <202508070415.RDcwKpac-lkp@intel.com>
References: <88fdbeb3f2ecf3a6259f3ee8636ae5b21fa6b72d.1754466623.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88fdbeb3f2ecf3a6259f3ee8636ae5b21fa6b72d.1754466623.git.namcao@linutronix.de>

Hi Nam,

kernel test robot noticed the following build errors:

[auto build test ERROR on trace/for-next]
[also build test ERROR on linus/master next-20250806]
[cannot apply to tip/sched/core v6.16]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nam-Cao/rv-ltl-Prepare-for-other-monitor-types/20250806-160342
base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
patch link:    https://lore.kernel.org/r/88fdbeb3f2ecf3a6259f3ee8636ae5b21fa6b72d.1754466623.git.namcao%40linutronix.de
patch subject: [PATCH v2 5/5] rv: Add rts monitor
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20250807/202508070415.RDcwKpac-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250807/202508070415.RDcwKpac-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508070415.RDcwKpac-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/asm-generic/percpu.h:7,
                    from ./arch/sh/include/generated/asm/percpu.h:1,
                    from include/linux/irqflags.h:19,
                    from arch/sh/include/asm/cmpxchg-irq.h:5,
                    from arch/sh/include/asm/cmpxchg.h:21,
                    from arch/sh/include/asm/atomic.h:19,
                    from include/linux/atomic.h:7,
                    from include/asm-generic/bitops/atomic.h:5,
                    from arch/sh/include/asm/bitops.h:23,
                    from include/linux/bitops.h:67,
                    from include/linux/kernel.h:23,
                    from include/linux/interrupt.h:6,
                    from include/linux/trace_recursion.h:5,
                    from include/linux/ftrace.h:10,
                    from kernel/trace/rv/monitors/rts/rts.c:2:
   include/rv/ltl_monitor.h: In function 'ltl_get_monitor':
>> include/linux/percpu-defs.h:90:40: error: section attribute cannot be specified for local variables
      90 |         extern __PCPU_DUMMY_ATTRS char __pcpu_unique_##name;            \
         |                                        ^~~~~~~~~~~~~~
   include/linux/percpu-defs.h:113:9: note: in expansion of macro 'DEFINE_PER_CPU_SECTION'
     113 |         DEFINE_PER_CPU_SECTION(type, name, "")
         |         ^~~~~~~~~~~~~~~~~~~~~~
   include/rv/ltl_monitor.h:69:16: note: in expansion of macro 'DEFINE_PER_CPU'
      69 |         static DEFINE_PER_CPU(struct ltl_monitor, ltl_monitor);
         |                ^~~~~~~~~~~~~~
   include/linux/percpu-defs.h:91:33: error: section attribute cannot be specified for local variables
      91 |         __PCPU_DUMMY_ATTRS char __pcpu_unique_##name;                   \
         |                                 ^~~~~~~~~~~~~~
   include/linux/percpu-defs.h:113:9: note: in expansion of macro 'DEFINE_PER_CPU_SECTION'
     113 |         DEFINE_PER_CPU_SECTION(type, name, "")
         |         ^~~~~~~~~~~~~~~~~~~~~~
   include/rv/ltl_monitor.h:69:16: note: in expansion of macro 'DEFINE_PER_CPU'
      69 |         static DEFINE_PER_CPU(struct ltl_monitor, ltl_monitor);
         |                ^~~~~~~~~~~~~~
>> include/linux/percpu-defs.h:91:33: error: declaration of '__pcpu_unique_ltl_monitor' with no linkage follows extern declaration
      91 |         __PCPU_DUMMY_ATTRS char __pcpu_unique_##name;                   \
         |                                 ^~~~~~~~~~~~~~
   include/linux/percpu-defs.h:113:9: note: in expansion of macro 'DEFINE_PER_CPU_SECTION'
     113 |         DEFINE_PER_CPU_SECTION(type, name, "")
         |         ^~~~~~~~~~~~~~~~~~~~~~
   include/rv/ltl_monitor.h:69:16: note: in expansion of macro 'DEFINE_PER_CPU'
      69 |         static DEFINE_PER_CPU(struct ltl_monitor, ltl_monitor);
         |                ^~~~~~~~~~~~~~
   include/linux/percpu-defs.h:90:40: note: previous declaration of '__pcpu_unique_ltl_monitor' with type 'char'
      90 |         extern __PCPU_DUMMY_ATTRS char __pcpu_unique_##name;            \
         |                                        ^~~~~~~~~~~~~~
   include/linux/percpu-defs.h:113:9: note: in expansion of macro 'DEFINE_PER_CPU_SECTION'
     113 |         DEFINE_PER_CPU_SECTION(type, name, "")
         |         ^~~~~~~~~~~~~~~~~~~~~~
   include/rv/ltl_monitor.h:69:16: note: in expansion of macro 'DEFINE_PER_CPU'
      69 |         static DEFINE_PER_CPU(struct ltl_monitor, ltl_monitor);
         |                ^~~~~~~~~~~~~~
>> include/rv/ltl_monitor.h:69:51: error: section attribute cannot be specified for local variables
      69 |         static DEFINE_PER_CPU(struct ltl_monitor, ltl_monitor);
         |                                                   ^~~~~~~~~~~
   include/linux/percpu-defs.h:92:51: note: in definition of macro 'DEFINE_PER_CPU_SECTION'
      92 |         extern __PCPU_ATTRS(sec) __typeof__(type) name;                 \
         |                                                   ^~~~
   include/rv/ltl_monitor.h:69:16: note: in expansion of macro 'DEFINE_PER_CPU'
      69 |         static DEFINE_PER_CPU(struct ltl_monitor, ltl_monitor);
         |                ^~~~~~~~~~~~~~
>> include/rv/ltl_monitor.h:69:51: error: section attribute cannot be specified for local variables
      69 |         static DEFINE_PER_CPU(struct ltl_monitor, ltl_monitor);
         |                                                   ^~~~~~~~~~~
   include/linux/percpu-defs.h:93:51: note: in definition of macro 'DEFINE_PER_CPU_SECTION'
      93 |         __PCPU_ATTRS(sec) __weak __typeof__(type) name
         |                                                   ^~~~
   include/rv/ltl_monitor.h:69:16: note: in expansion of macro 'DEFINE_PER_CPU'
      69 |         static DEFINE_PER_CPU(struct ltl_monitor, ltl_monitor);
         |                ^~~~~~~~~~~~~~
>> include/rv/ltl_monitor.h:69:51: error: weak declaration of 'ltl_monitor' must be public
      69 |         static DEFINE_PER_CPU(struct ltl_monitor, ltl_monitor);
         |                                                   ^~~~~~~~~~~
   include/linux/percpu-defs.h:93:51: note: in definition of macro 'DEFINE_PER_CPU_SECTION'
      93 |         __PCPU_ATTRS(sec) __weak __typeof__(type) name
         |                                                   ^~~~
   include/rv/ltl_monitor.h:69:16: note: in expansion of macro 'DEFINE_PER_CPU'
      69 |         static DEFINE_PER_CPU(struct ltl_monitor, ltl_monitor);
         |                ^~~~~~~~~~~~~~
>> include/rv/ltl_monitor.h:69:51: error: declaration of 'ltl_monitor' with no linkage follows extern declaration
      69 |         static DEFINE_PER_CPU(struct ltl_monitor, ltl_monitor);
         |                                                   ^~~~~~~~~~~
   include/linux/percpu-defs.h:93:51: note: in definition of macro 'DEFINE_PER_CPU_SECTION'
      93 |         __PCPU_ATTRS(sec) __weak __typeof__(type) name
         |                                                   ^~~~
   include/rv/ltl_monitor.h:69:16: note: in expansion of macro 'DEFINE_PER_CPU'
      69 |         static DEFINE_PER_CPU(struct ltl_monitor, ltl_monitor);
         |                ^~~~~~~~~~~~~~
   include/rv/ltl_monitor.h:69:51: note: previous declaration of 'ltl_monitor' with type 'struct ltl_monitor'
      69 |         static DEFINE_PER_CPU(struct ltl_monitor, ltl_monitor);
         |                                                   ^~~~~~~~~~~
   include/linux/percpu-defs.h:92:51: note: in definition of macro 'DEFINE_PER_CPU_SECTION'
      92 |         extern __PCPU_ATTRS(sec) __typeof__(type) name;                 \
         |                                                   ^~~~
   include/rv/ltl_monitor.h:69:16: note: in expansion of macro 'DEFINE_PER_CPU'
      69 |         static DEFINE_PER_CPU(struct ltl_monitor, ltl_monitor);
         |                ^~~~~~~~~~~~~~


vim +69 include/rv/ltl_monitor.h

a9769a5b987838 Nam Cao 2025-07-09  61  
59c45d176bc0f2 Nam Cao 2025-08-06  62  static struct ltl_monitor *ltl_get_monitor(monitor_target target)
a9769a5b987838 Nam Cao 2025-07-09  63  {
59c45d176bc0f2 Nam Cao 2025-08-06  64  	return &target->rv[ltl_monitor_slot].ltl_mon;
a9769a5b987838 Nam Cao 2025-07-09  65  }
50fd6be3de4982 Nam Cao 2025-08-06  66  #elif LTL_MONITOR_TYPE == RV_MON_PER_CPU
50fd6be3de4982 Nam Cao 2025-08-06  67  static struct ltl_monitor *ltl_get_monitor(unsigned int cpu)
50fd6be3de4982 Nam Cao 2025-08-06  68  {
50fd6be3de4982 Nam Cao 2025-08-06 @69  	static DEFINE_PER_CPU(struct ltl_monitor, ltl_monitor);
50fd6be3de4982 Nam Cao 2025-08-06  70  
50fd6be3de4982 Nam Cao 2025-08-06  71  	return per_cpu_ptr(&ltl_monitor, cpu);
50fd6be3de4982 Nam Cao 2025-08-06  72  }
59c45d176bc0f2 Nam Cao 2025-08-06  73  #endif
a9769a5b987838 Nam Cao 2025-07-09  74  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
