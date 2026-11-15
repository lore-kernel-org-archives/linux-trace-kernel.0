Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794767928;
	b=cf5tb63O6G9eKCfK9p0WdvQaCyrSk+1KoZuAl+HKc1+8e02IeK7/tDbHjeMeT7W3dgar
	 dF+QjEhwDGI5PeqYecJVNOldQEi5zm7H3vlwMCPZ7wcLN66pCpCINjDuVP3ps4FE4i1xq
	 w8Id9nb0wuL8tDaj1rL0tTEVKrJo69HDIh6nWS1kiV4iajgnA6RigJUzbFdAAFQuRTft0
	 wVDbRpKtKDeMC0JrLacsCP/54j8xffKQ8r+8P3sdkokpXQBJ23RRBC6woA2OErP08LI88
	 AwgiqaITMak9p1mY+MGRJlIflm/lPcPUEI7ET4/HXQ/fYaeFjmp0krDgGQD4OYk17bQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794767928;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=n38R8THVBERh6YX8fumxgq2SeV93NHDPiTWFfSKg6qw=;
	b=C5p5x0UX1SWJZABW4wHhAhRBPlSyZtOI6oha84x6p5T9P7TmN8tLUVCdzkkl25QLWHAP
	 yX3hsSvf6xUo+vAQziI1n7Uo87QXuysvYnVIU+y37M0P1aUuJat7BQVU4xs2Xv8vLbYk9
	 Ucg5PpBm4ZKzPqkY+nbkuVqGvtPwGAcoTVPfEoT/gLQlvh6JI651EjCt67mr3Xe5wUyUt
	 hXI56OeD+EW+qVHcJImGgPweIzvqOzIz4yVNmu3NxfUugGBzUg+TdP+Q7jLq8m1q+Z3mF
	 Cohg9fYIFi3+YS8AeQruhdeb25y9K6TNB7g0GL7xEyr9DY0ozrFQwsuKr7HjaYpAogA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PWPpc8v9;
	arc=none smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C6F606A31E;
	Sun, 15 Nov 2026 18:38:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93C6F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PWPpc8v9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794767928; x=1826303928;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ho9p6bSo8pi1QrenazGvesf4HhUNwYmhTsTzMNwIz5w=;
  b=PWPpc8v9wuWuUQd/mGlRblIC6Z39upTInKfSshMXSibsdCxMwFctkljF
   new8rJp0SjLEghvOHrv81o2O6Od4d7BVTOWWyqGS/L9w4yOvLokopvCoP
   +s19EHL9IEiVu7vNfOukaFfJMvt8f3Ai1lmFShkJP+ZE3rfcovL+Qk4Lu
   8cBEVQNruP7OfJEiz2a9imx4VB5x6mailoRjgG7es8lwNtAqxb7bWmJNn
   Gr6elVwdu8icibNdjzjqYvdWv4uc7sknbRYIy0zypFje6vWyLF1g1FiLd
   2WsL57KLKb0mWpRGBonidsJlrMe8LU1NN5hUYSqv/WCdy29RVmPUb8A9R
   g==;
X-CSE-ConnectionGUID: mFGiRjrNQFqCtcYDzXABvQ==
X-CSE-MsgGUID: bFD1NG5DS2mDRjEp3dF6Tg==
X-IronPort-AV: E=McAfee;i="6800,10657,11967"; a="3498583"
X-IronPort-AV: E=Sophos;i="6.27,215,1787036400"; 
   d="scan'208";a="3498583"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2026 10:38:47 -0800
X-CSE-ConnectionGUID: xgioXYEnTiuMMwCr8er90g==
X-CSE-MsgGUID: i+uioB1WQR2VnUR4b4a0wQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,215,1787036400"; 
   d="scan'208";a="9372476"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 15 Nov 2026 10:38:44 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xSf7g-000000017C8-1yn4;
	Sun, 15 Nov 2026 18:38:40 +0000
Date: Mon, 16 Nov 2026 02:37:57 +0800
From: kernel test robot <lkp@intel.com>
To: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, Guo Ren <guoren@kernel.org>,
	Pekka Enberg <penberg@kernel.org>,
	Patrick =?iso-8859-1?Q?St=E4hlin?= <me@packi.ch>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Subject: Re: [PATCH v4 2/3] riscv: probes: reject probes inside an LR/SC
 sequence
Message-ID: <202611160252.d58noD11-lkp@intel.com>
References: <20261115-probes-in-lrsc-v4-2-48b9b036bd1d@mobileye.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261115-probes-in-lrsc-v4-2-48b9b036bd1d@mobileye.com>

Hi Vladimir,

kernel test robot noticed the following build warnings:

[auto build test WARNING on c03c1a14507dfaf8b856c2608f9ac216021fc222]

url:    https://github.com/intel-lab-lkp/linux/commits/Vladimir-Kondratiev/riscv-kprobes-fix-out-of-bounds-read-in-riscv_probe_decode_insn/20261115-143733
base:   c03c1a14507dfaf8b856c2608f9ac216021fc222
patch link:    https://lore.kernel.org/r/20261115-probes-in-lrsc-v4-2-48b9b036bd1d%40mobileye.com
patch subject: [PATCH v4 2/3] riscv: probes: reject probes inside an LR/SC sequence
config: riscv-randconfig-1000-20261115 (https://download.01.org/0day-ci/archive/20261116/202611160252.d58noD11-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project ca14e3d05c4e63d6e8103945c86b958ed2f55d5f)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261116/202611160252.d58noD11-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611160252.d58noD11-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/riscv/kernel/probes/kprobes.c:5:
   In file included from include/linux/kprobes.h:28:
   In file included from include/linux/ftrace.h:10:
   In file included from include/linux/trace_recursion.h:5:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:12:
   In file included from arch/riscv/include/asm/io.h:148:
   include/asm-generic/io.h:1209:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
    1209 |         return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
         |                                                   ~~~~~~~~~~ ^
>> arch/riscv/kernel/probes/kprobes.c:75:4: warning: add explicit braces to avoid dangling else [-Wdangling-else]
      75 |                         else
         |                         ^
   2 warnings generated.


vim +75 arch/riscv/kernel/probes/kprobes.c

    51	
    52	/*
    53	 * Walk the instructions from the enclosing symbol up to addr to check that
    54	 * addr is an instruction boundary. Then reject a probe inside an LR/SC
    55	 * sequence: the breakpoint trap drops the reservation, so the SC would fail
    56	 * and the loop would hit the probe again on every retry. The sequence is
    57	 * recognised by a forward scan with the constrained-sequence rules, as for
    58	 * uprobes, so an lr that is not followed by an sc (as in __cmpwait()) does
    59	 * not taint the rest of the function.
    60	 */
    61	static int __kprobes arch_check_kprobe(unsigned long addr)
    62	{
    63		unsigned long tmp, offset;
    64	
    65		/* start iterating at the closest preceding symbol */
    66		if (!kallsyms_lookup_size_offset(addr, NULL, &offset))
    67			return -EILSEQ;
    68	
    69		tmp = addr - offset;
    70	
    71		while (tmp <= addr) {
    72			if (tmp == addr)
    73				if (riscv_probe_in_lrsc_body((u16 *)addr, RISCV_LRSC_SCAN_BYTES))
    74					return -EINVAL;
  > 75				else
    76					return 0;
    77	
    78			tmp += GET_INSN_LENGTH(*(u16 *)tmp);
    79		}
    80	
    81		return -EILSEQ;
    82	}
    83	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
