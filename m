Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD6519F10A;
	Mon,  7 Jul 2025 10:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751884241; cv=none; b=bEVLmOExH3YoB1Y5nQG+FaHPbe0kCGhA9C5tNamBNcQGWgYTvhDogdkIDjgB3TBHNOQcnKyePOFuQb7Y3+JztcZUirXx+tnwgGMajjXJArAWBvSssbM95FB0+h4u/XvckDRCja+emjaa92hZ65WJO4ibTC8s2lrwTh1J2v2z1SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751884241; c=relaxed/simple;
	bh=3xZ3C2XbqQloQMn1DRctoPeGmPKF5DG2Q0BNaKhC270=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dvtMeP7vc4GO4h232/GOzwTH/brOaaTgF+RWK6tEYyil8lRF7FgTlwIyfP+3k8+9ShnKAiUSHhYj5+tn6wTPwZOucAveay+z8OaUC4oZyLzpljsxVByFHvBZeaub5Qp5LZBFVYp/B5mx9nlFEN7EwYFZ0SGJ8Lj+vtgMm6BTLZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lRMnDoDt; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lRMnDoDt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751884239; x=1783420239;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3xZ3C2XbqQloQMn1DRctoPeGmPKF5DG2Q0BNaKhC270=;
  b=lRMnDoDtY6OwDqZArxLnyVkWAe73oWrd8klL+xdhxnNqJk6axh02UhrL
   ck6vTq21n5rOwD4d/N9N4SkMeS8M3nQxgp383vNPh/IFZi/RoZeZX4q9B
   zqzau7ig/jVCeTkDy1HxdiFVdylVUZg1qBAR16NDPnmbpVebtHaw7pYUW
   esJJmdOvWbrIh8zkhxIi8nsyLvtma5FWzjIH5ZqwB6R5CGjEqwu2bfQ45
   rT/mqd/RFhZcV+EQs/uYD5qISBWD9QTHglJ9qL6P+i8WtrlYON6q+GOIa
   N9g1/eOGexHT3B6A650ws8C5vj/8CEzYtgrnJYI2HFwzqB3pp4QP3dmP5
   w==;
X-CSE-ConnectionGUID: Lt0fxi/6R1ywTyZcCvqRYA==
X-CSE-MsgGUID: nuoCHfkAQUSm3xpi3A/XlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11486"; a="65554720"
X-IronPort-AV: E=Sophos;i="6.16,294,1744095600"; 
   d="scan'208";a="65554720"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 03:30:37 -0700
X-CSE-ConnectionGUID: cELMNLKzTDicN5BWgqNqSw==
X-CSE-MsgGUID: U8bUEGEfQLWcPe0QGPVxlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,294,1744095600"; 
   d="scan'208";a="159717452"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 07 Jul 2025 03:30:31 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uYj7E-0000LD-2C;
	Mon, 07 Jul 2025 10:30:28 +0000
Date: Mon, 7 Jul 2025 18:29:30 +0800
From: kernel test robot <lkp@intel.com>
To: Wander Lairson Costa <wander@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Clark Williams <williams@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>
Subject: Re: [PATCH v3 2/2] tracing/preemptirq: Optimize
 preempt_disable/enable() tracepoint overhead
Message-ID: <202507071800.OViM30Fr-lkp@intel.com>
References: <20250704170748.97632-3-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704170748.97632-3-wander@redhat.com>

Hi Wander,

kernel test robot noticed the following build errors:

[auto build test ERROR on trace/for-next]
[also build test ERROR on tip/sched/core linus/master v6.16-rc5 next-20250704]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wander-Lairson-Costa/trace-preemptirq-reduce-overhead-of-irq_enable-disable-tracepoints/20250705-011058
base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
patch link:    https://lore.kernel.org/r/20250704170748.97632-3-wander%40redhat.com
patch subject: [PATCH v3 2/2] tracing/preemptirq: Optimize preempt_disable/enable() tracepoint overhead
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20250707/202507071800.OViM30Fr-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250707/202507071800.OViM30Fr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507071800.OViM30Fr-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/irqflags.h:18,
                    from arch/m68k/include/asm/atomic.h:6,
                    from include/linux/atomic.h:7,
                    from include/linux/jump_label.h:257,
                    from include/linux/static_key.h:1,
                    from include/linux/tracepoint-defs.h:11,
                    from include/linux/preempt.h:13,
                    from arch/m68k/include/asm/processor.h:11,
                    from include/linux/sched.h:13,
                    from arch/m68k/kernel/asm-offsets.c:15:
   arch/m68k/include/asm/irqflags.h: In function 'arch_local_irq_enable':
>> arch/m68k/include/asm/irqflags.h:44:29: error: implicit declaration of function 'hardirq_count' [-Wimplicit-function-declaration]
      44 |         if (MACH_IS_Q40 || !hardirq_count())
         |                             ^~~~~~~~~~~~~
   make[3]: *** [scripts/Makefile.build:98: arch/m68k/kernel/asm-offsets.s] Error 1
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1274: prepare0] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:248: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:248: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/hardirq_count +44 arch/m68k/include/asm/irqflags.h

df9ee29270c11d David Howells 2010-10-07  31  
df9ee29270c11d David Howells 2010-10-07  32  static inline void arch_local_irq_enable(void)
df9ee29270c11d David Howells 2010-10-07  33  {
df9ee29270c11d David Howells 2010-10-07  34  #if defined(CONFIG_COLDFIRE)
df9ee29270c11d David Howells 2010-10-07  35  	asm volatile (
df9ee29270c11d David Howells 2010-10-07  36  		"move	%/sr,%%d0	\n\t"
df9ee29270c11d David Howells 2010-10-07  37  		"andi.l	#0xf8ff,%%d0	\n\t"
df9ee29270c11d David Howells 2010-10-07  38  		"move	%%d0,%/sr	\n"
df9ee29270c11d David Howells 2010-10-07  39  		: /* no outputs */
df9ee29270c11d David Howells 2010-10-07  40  		:
df9ee29270c11d David Howells 2010-10-07  41  		: "cc", "%d0", "memory");
df9ee29270c11d David Howells 2010-10-07  42  #else
df9ee29270c11d David Howells 2010-10-07  43  # if defined(CONFIG_MMU)
df9ee29270c11d David Howells 2010-10-07 @44  	if (MACH_IS_Q40 || !hardirq_count())
df9ee29270c11d David Howells 2010-10-07  45  # endif
df9ee29270c11d David Howells 2010-10-07  46  		asm volatile (
df9ee29270c11d David Howells 2010-10-07  47  			"andiw %0,%%sr"
df9ee29270c11d David Howells 2010-10-07  48  			:
df9ee29270c11d David Howells 2010-10-07  49  			: "i" (ALLOWINT)
df9ee29270c11d David Howells 2010-10-07  50  			: "memory");
df9ee29270c11d David Howells 2010-10-07  51  #endif
df9ee29270c11d David Howells 2010-10-07  52  }
df9ee29270c11d David Howells 2010-10-07  53  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
