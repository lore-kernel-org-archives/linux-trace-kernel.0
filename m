Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794773634;
	b=GdXIoi4dlX+M3GmkO3zzO89hF+5p8c4PC5Pm4T5bDV9DcIhJg1vBiHxmE+F9HP+tu85e
	 x/kFi6JGAidyJVXjBIygKfXFk9Kej26AuEvcW28Cb95ddrpbIW7kb1kzxUy50QVF7EFY+
	 MpwtNTYWYGmL2mgg3eA9cVfUYgr4NrHW0pZGt+YVaQ1cyHrm8bX86u/SMc4Ix+NHHmGMB
	 CYFwBKVBd5+bNBVshCWa17nEm4asH8mwRS2eL5tiK6jffw9DVzhps1td5sNMHROeafhmm
	 OHIJ+yAG0hfEwa8fXUFqW2Db4oLM2wwfm0ZpeCVfvF2PxArfIbHMM7UzEaEbogy4cdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794773634;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=f+bQpVSgDI9YHgjl3uDB+ouh3VGlh507cbkdzb6YPLM=;
	b=Sglw+87pkeE+EGIZOKeTkNejDvtfaGkvtStpzpETTKv0uWMjgIxcVQ92gBdE4DxWd7cT
	 J+a4BZs5MsFRskgoVnJFbcPa0NEaZIDxYmk7pUd3vP90C3a73ohyDrPnDRDmTBd8Nhtnr
	 Z4dQLG+wMTysGIvsVp/MvXUXt8wfh8YahgudYNLybMuriM9ObS6aMG8Ui10sgAr8Vy+o1
	 KdwxCs5Y7TDnOYwbL4kWLwtWoyCBndjwhEn+Hn9sYkDJVOTUfJQbgOFKdv+zyB7CRnZng
	 MFo1RWYAjesreEfRPrd4NsCo6pxlr7O1dKIVArIufMDMUCUBQZiNUiKZsZdMK0pnyyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=az0ETHMw;
	arc=none smtp.remote-ip=192.198.163.12
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC40D606A329;
	Sun, 15 Nov 2026 20:13:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC40D606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=az0ETHMw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794773633; x=1826309633;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4EUxz6kYyIg485rNagv9WP+UBIapCrWnWFgWZ0hpUOI=;
  b=az0ETHMw4JUUcppgmBRaODCVJYPDZTPZuHfeuBz4nDsTkDFn3Qg7NGGa
   Sdm5qZmYs6KZcC0ZeZf41OTf5PjF1/bD2gTDmNIDhH/Z9ZlL4GCmrkEzY
   sEK+kW8Kg3pnau375biOvxw8WsBFeXX31cXHG0i8LC8eaefpsIFsBqzJc
   TJguz36a4oAqUsZICzHChfwpcK6W6XPqOKQvhAzlXj/0S0IvdD9sXukG/
   DUYzRupq0yVrGYwuE2yY8e4en2jGIVZuF9almipdL9DIqkBQYmgsZijqU
   gic1SEx1YSCd67E6/rI15M6J2SPcJSqasi+AkYvVNr1On9qWgKFr1LDVN
   w==;
X-CSE-ConnectionGUID: MYThkw/USOS04RMz/6slkw==
X-CSE-MsgGUID: 4iVJ7AVnSkSHh3PqFECQxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11967"; a="3414809"
X-IronPort-AV: E=Sophos;i="6.27,215,1787036400"; 
   d="scan'208";a="3414809"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2026 12:13:52 -0800
X-CSE-ConnectionGUID: Hh+oXZIfQaK56gV3BeGD+Q==
X-CSE-MsgGUID: mU3PirwFTAe18BsffREvew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,215,1787036400"; 
   d="scan'208";a="9713891"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 15 Nov 2026 12:13:49 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xSgbh-000000017G4-2KLl;
	Sun, 15 Nov 2026 20:13:45 +0000
Date: Mon, 16 Nov 2026 04:12:52 +0800
From: kernel test robot <lkp@intel.com>
To: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, Guo Ren <guoren@kernel.org>,
	Pekka Enberg <penberg@kernel.org>,
	Patrick =?iso-8859-1?Q?St=E4hlin?= <me@packi.ch>
Cc: oe-kbuild-all@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Subject: Re: [PATCH v4 2/3] riscv: probes: reject probes inside an LR/SC
 sequence
Message-ID: <202611160417.wVX1is4j-lkp@intel.com>
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
config: riscv-randconfig-1000-20261116 (https://download.01.org/0day-ci/archive/20261116/202611160417.wVX1is4j-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 15.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261116/202611160417.wVX1is4j-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611160417.wVX1is4j-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/riscv/kernel/probes/kprobes.c: In function 'arch_check_kprobe':
>> arch/riscv/kernel/probes/kprobes.c:72:20: warning: suggest explicit braces to avoid ambiguous 'else' [-Wdangling-else]
      72 |                 if (tmp == addr)
         |                    ^


vim +/else +72 arch/riscv/kernel/probes/kprobes.c

c22b0bcb1dd024 Guo Ren             2020-12-17  51  
c0b7e72c7a4b06 Vladimir Kondratiev 2026-11-15  52  /*
c0b7e72c7a4b06 Vladimir Kondratiev 2026-11-15  53   * Walk the instructions from the enclosing symbol up to addr to check that
c0b7e72c7a4b06 Vladimir Kondratiev 2026-11-15  54   * addr is an instruction boundary. Then reject a probe inside an LR/SC
c0b7e72c7a4b06 Vladimir Kondratiev 2026-11-15  55   * sequence: the breakpoint trap drops the reservation, so the SC would fail
c0b7e72c7a4b06 Vladimir Kondratiev 2026-11-15  56   * and the loop would hit the probe again on every retry. The sequence is
c0b7e72c7a4b06 Vladimir Kondratiev 2026-11-15  57   * recognised by a forward scan with the constrained-sequence rules, as for
c0b7e72c7a4b06 Vladimir Kondratiev 2026-11-15  58   * uprobes, so an lr that is not followed by an sc (as in __cmpwait()) does
c0b7e72c7a4b06 Vladimir Kondratiev 2026-11-15  59   * not taint the rest of the function.
c0b7e72c7a4b06 Vladimir Kondratiev 2026-11-15  60   */
c0b7e72c7a4b06 Vladimir Kondratiev 2026-11-15  61  static int __kprobes arch_check_kprobe(unsigned long addr)
87f48c7ccc73af Guo Ren             2023-01-31  62  {
9e68bd803fac49 Fabian Vogt         2025-09-10  63  	unsigned long tmp, offset;
9e68bd803fac49 Fabian Vogt         2025-09-10  64  
9e68bd803fac49 Fabian Vogt         2025-09-10  65  	/* start iterating at the closest preceding symbol */
9e68bd803fac49 Fabian Vogt         2025-09-10  66  	if (!kallsyms_lookup_size_offset(addr, NULL, &offset))
c0b7e72c7a4b06 Vladimir Kondratiev 2026-11-15  67  		return -EILSEQ;
9e68bd803fac49 Fabian Vogt         2025-09-10  68  
9e68bd803fac49 Fabian Vogt         2025-09-10  69  	tmp = addr - offset;
87f48c7ccc73af Guo Ren             2023-01-31  70  
87f48c7ccc73af Guo Ren             2023-01-31  71  	while (tmp <= addr) {
87f48c7ccc73af Guo Ren             2023-01-31 @72  		if (tmp == addr)
c0b7e72c7a4b06 Vladimir Kondratiev 2026-11-15  73  			if (riscv_probe_in_lrsc_body((u16 *)addr, RISCV_LRSC_SCAN_BYTES))
c0b7e72c7a4b06 Vladimir Kondratiev 2026-11-15  74  				return -EINVAL;
c0b7e72c7a4b06 Vladimir Kondratiev 2026-11-15  75  			else
c0b7e72c7a4b06 Vladimir Kondratiev 2026-11-15  76  				return 0;
87f48c7ccc73af Guo Ren             2023-01-31  77  
87f48c7ccc73af Guo Ren             2023-01-31  78  		tmp += GET_INSN_LENGTH(*(u16 *)tmp);
87f48c7ccc73af Guo Ren             2023-01-31  79  	}
87f48c7ccc73af Guo Ren             2023-01-31  80  
c0b7e72c7a4b06 Vladimir Kondratiev 2026-11-15  81  	return -EILSEQ;
87f48c7ccc73af Guo Ren             2023-01-31  82  }
87f48c7ccc73af Guo Ren             2023-01-31  83  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
