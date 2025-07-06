Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7058915ADB4;
	Sun,  6 Jul 2025 04:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751776217; cv=none; b=CEW/07xuCwOS/w/zHSkezg03XzuYVKHGJe+tLpLLTCR32wMe8F6j2hnl82DT1J0eV1JCKKXDGGc0VCOUa4BkgaMiAfRXO6JJrwKXEGmXcEAkJFz9+zea9ioL7itE9kUZwkGi/On8lmvq2UQdw/Sf+9L10KnHcHUTrXCa9N2UU8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751776217; c=relaxed/simple;
	bh=wooHoirHZtu0a5A+d2+8+BgRHGQ/MFCV+B8Pz8Sx2/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dqSVeKI/sksAlOdqhS8aMkLKV2nI/W6uy3tmvMsoqvJHogaRjHVHM1aJ7JH2dDZ8nDblvOtY5HnXNmYxxZXCTktvOthpPM3fJ/pHji3zZEmPY2w/Krp0Ge6y8gey/vmVXICfy5NG6fUtB5NyoIxiaTzTJgexard41qGZFDsXQEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I8GhsPsa; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I8GhsPsa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751776216; x=1783312216;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wooHoirHZtu0a5A+d2+8+BgRHGQ/MFCV+B8Pz8Sx2/I=;
  b=I8GhsPsa5bBSxilXEXZgPf3t+8qgnekKbzA+mtLu5oCl4pNcnuoGYJbw
   AN1al6lBbAffkryVlumbw21onG+hougSD+bFObaHtatqfyHWRekvfI+wL
   Rfphw7TveHEi9bywDNETbHkmkFD9Sz3FaLwj0drZVncymtpxZGe+QOOaP
   s2iemOGooIK6LXfj2FZBuX0Mi88QIS32IVNgR4axzwVi1AD/QbIbkdJGU
   dMWSi4MjqNKM6TSw1pbFp1iShff/Zerit/+mvvs92qbCZrFwqJqure2wu
   HawP+tE35/pkIYhDDkt0nxQXCyf6muMqaKwyJ5g3axffKRr6XNAL+1qIc
   w==;
X-CSE-ConnectionGUID: OHYwXaQQR+WSwSL7AlFcNw==
X-CSE-MsgGUID: M+b16x8BQdKpGqf0G6CCUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11485"; a="65091574"
X-IronPort-AV: E=Sophos;i="6.16,291,1744095600"; 
   d="scan'208";a="65091574"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2025 21:30:15 -0700
X-CSE-ConnectionGUID: dp3PM6/bQKuctTFEjrYzCw==
X-CSE-MsgGUID: OuBbdbJ3QhyP47pk4JZepQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,291,1744095600"; 
   d="scan'208";a="154337953"
Received: from lkp-server01.sh.intel.com (HELO 0b2900756c14) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 05 Jul 2025 21:30:10 -0700
Received: from kbuild by 0b2900756c14 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uYH0x-0004sd-1e;
	Sun, 06 Jul 2025 04:30:07 +0000
Date: Sun, 6 Jul 2025 12:29:29 +0800
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
	Boqun Feng <boqun.feng@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Clark Williams <williams@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>
Subject: Re: [PATCH v3 1/2] trace/preemptirq: reduce overhead of
 irq_enable/disable tracepoints
Message-ID: <202507061226.y7g5eBuq-lkp@intel.com>
References: <20250704170748.97632-2-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704170748.97632-2-wander@redhat.com>

Hi Wander,

kernel test robot noticed the following build errors:

[auto build test ERROR on trace/for-next]
[also build test ERROR on tip/sched/core linus/master v6.16-rc4 next-20250704]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wander-Lairson-Costa/trace-preemptirq-reduce-overhead-of-irq_enable-disable-tracepoints/20250705-011058
base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
patch link:    https://lore.kernel.org/r/20250704170748.97632-2-wander%40redhat.com
patch subject: [PATCH v3 1/2] trace/preemptirq: reduce overhead of irq_enable/disable tracepoints
config: nios2-randconfig-r123-20250706 (https://download.01.org/0day-ci/archive/20250706/202507061226.y7g5eBuq-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 8.5.0
reproduce: (https://download.01.org/0day-ci/archive/20250706/202507061226.y7g5eBuq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507061226.y7g5eBuq-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from ./arch/nios2/include/generated/asm/cmpxchg.h:1,
                    from include/asm-generic/atomic.h:12,
                    from ./arch/nios2/include/generated/asm/atomic.h:1,
                    from include/linux/atomic.h:7,
                    from include/linux/jump_label.h:257,
                    from include/linux/static_key.h:1,
                    from include/linux/tracepoint-defs.h:11,
                    from include/linux/irqflags.h:20,
                    from include/asm-generic/bitops.h:14,
                    from ./arch/nios2/include/generated/asm/bitops.h:1,
                    from include/linux/bitops.h:68,
                    from include/linux/log2.h:12,
                    from kernel/bounds.c:13:
   include/asm-generic/cmpxchg.h: In function '__generic_xchg':
>> include/asm-generic/cmpxchg.h:33:3: error: implicit declaration of function 'local_irq_save'; did you mean 'arch_local_irq_save'? [-Werror=implicit-function-declaration]
      local_irq_save(flags);
      ^~~~~~~~~~~~~~
      arch_local_irq_save
>> include/asm-generic/cmpxchg.h:36:3: error: implicit declaration of function 'local_irq_restore'; did you mean 'arch_local_irq_restore'? [-Werror=implicit-function-declaration]
      local_irq_restore(flags);
      ^~~~~~~~~~~~~~~~~
      arch_local_irq_restore
   In file included from include/asm-generic/cmpxchg.h:89,
                    from ./arch/nios2/include/generated/asm/cmpxchg.h:1,
                    from include/asm-generic/atomic.h:12,
                    from ./arch/nios2/include/generated/asm/atomic.h:1,
                    from include/linux/atomic.h:7,
                    from include/linux/jump_label.h:257,
                    from include/linux/static_key.h:1,
                    from include/linux/tracepoint-defs.h:11,
                    from include/linux/irqflags.h:20,
                    from include/asm-generic/bitops.h:14,
                    from ./arch/nios2/include/generated/asm/bitops.h:1,
                    from include/linux/bitops.h:68,
                    from include/linux/log2.h:12,
                    from kernel/bounds.c:13:
   include/asm-generic/cmpxchg-local.h: In function '__generic_cmpxchg_local':
>> include/asm-generic/cmpxchg-local.h:26:2: error: implicit declaration of function 'raw_local_irq_save'; did you mean 'arch_local_irq_save'? [-Werror=implicit-function-declaration]
     raw_local_irq_save(flags);
     ^~~~~~~~~~~~~~~~~~
     arch_local_irq_save
>> include/asm-generic/cmpxchg-local.h:47:2: error: implicit declaration of function 'raw_local_irq_restore'; did you mean 'arch_local_irq_restore'? [-Werror=implicit-function-declaration]
     raw_local_irq_restore(flags);
     ^~~~~~~~~~~~~~~~~~~~~
     arch_local_irq_restore
   cc1: some warnings being treated as errors
   make[3]: *** [scripts/Makefile.build:98: kernel/bounds.s] Error 1
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1274: prepare0] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:248: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:248: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +33 include/asm-generic/cmpxchg.h

b4816afa3986704 David Howells 2012-03-28  22  
b4816afa3986704 David Howells 2012-03-28  23  static inline
82b993e8249ae3c Mark Rutland  2021-05-25  24  unsigned long __generic_xchg(unsigned long x, volatile void *ptr, int size)
b4816afa3986704 David Howells 2012-03-28  25  {
b4816afa3986704 David Howells 2012-03-28  26  	unsigned long ret, flags;
b4816afa3986704 David Howells 2012-03-28  27  
b4816afa3986704 David Howells 2012-03-28  28  	switch (size) {
b4816afa3986704 David Howells 2012-03-28  29  	case 1:
b4816afa3986704 David Howells 2012-03-28  30  #ifdef __xchg_u8
b4816afa3986704 David Howells 2012-03-28  31  		return __xchg_u8(x, ptr);
b4816afa3986704 David Howells 2012-03-28  32  #else
b4816afa3986704 David Howells 2012-03-28 @33  		local_irq_save(flags);
b4816afa3986704 David Howells 2012-03-28  34  		ret = *(volatile u8 *)ptr;
656e9007ef58627 Arnd Bergmann 2023-03-02  35  		*(volatile u8 *)ptr = (x & 0xffu);
b4816afa3986704 David Howells 2012-03-28 @36  		local_irq_restore(flags);
b4816afa3986704 David Howells 2012-03-28  37  		return ret;
b4816afa3986704 David Howells 2012-03-28  38  #endif /* __xchg_u8 */
b4816afa3986704 David Howells 2012-03-28  39  
b4816afa3986704 David Howells 2012-03-28  40  	case 2:
b4816afa3986704 David Howells 2012-03-28  41  #ifdef __xchg_u16
b4816afa3986704 David Howells 2012-03-28  42  		return __xchg_u16(x, ptr);
b4816afa3986704 David Howells 2012-03-28  43  #else
b4816afa3986704 David Howells 2012-03-28  44  		local_irq_save(flags);
b4816afa3986704 David Howells 2012-03-28  45  		ret = *(volatile u16 *)ptr;
656e9007ef58627 Arnd Bergmann 2023-03-02  46  		*(volatile u16 *)ptr = (x & 0xffffu);
b4816afa3986704 David Howells 2012-03-28  47  		local_irq_restore(flags);
b4816afa3986704 David Howells 2012-03-28  48  		return ret;
b4816afa3986704 David Howells 2012-03-28  49  #endif /* __xchg_u16 */
b4816afa3986704 David Howells 2012-03-28  50  
b4816afa3986704 David Howells 2012-03-28  51  	case 4:
b4816afa3986704 David Howells 2012-03-28  52  #ifdef __xchg_u32
b4816afa3986704 David Howells 2012-03-28  53  		return __xchg_u32(x, ptr);
b4816afa3986704 David Howells 2012-03-28  54  #else
b4816afa3986704 David Howells 2012-03-28  55  		local_irq_save(flags);
b4816afa3986704 David Howells 2012-03-28  56  		ret = *(volatile u32 *)ptr;
656e9007ef58627 Arnd Bergmann 2023-03-02  57  		*(volatile u32 *)ptr = (x & 0xffffffffu);
b4816afa3986704 David Howells 2012-03-28  58  		local_irq_restore(flags);
b4816afa3986704 David Howells 2012-03-28  59  		return ret;
b4816afa3986704 David Howells 2012-03-28  60  #endif /* __xchg_u32 */
b4816afa3986704 David Howells 2012-03-28  61  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
