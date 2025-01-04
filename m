Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C261487F4;
	Sat,  4 Jan 2025 06:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735972813; cv=none; b=LOXbVZLXBXbXBCoUtTkYc9eUKAE4wQZtVqE6bElYBgdAxD343tC6bk7sV0pkkot/IiIey9XcgcC6z9Q4Y9WBbhjS8VtvavRMDsfCZdTJ88vhqfI/HZJi4dypB8q6p7QliIL/Subh3/2A9O8eJUZYNx/XC5TbjyEE+coKc+aQxHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735972813; c=relaxed/simple;
	bh=QqdBhDk5Y1H58lobFVJK1A0lZ67bgL7UTTPHbLOUb0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gcl4hCpK61QU6XCLby6+tq8JvJyYL38nCCRdjPL7dl6/je4qzSPcMsQZP8vyK9wa21Z42mlDCECIrhsiLFPKIcrQWhWGQNUl3ZuLVcqeHHD+8a/bb/KLUg90s0aWCZZ6Yp7ID/d6XAIJh8JWaHzJOBHy3zbzR9+9uL78dkAX39A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=izjJES6S; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="izjJES6S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735972811; x=1767508811;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QqdBhDk5Y1H58lobFVJK1A0lZ67bgL7UTTPHbLOUb0E=;
  b=izjJES6S4Uc3beOblOeNABnz1L4i5B9vNrszVNaYR9SS5opuDiDrGsk5
   WQHdygdalTmpG4avQpfRYzoiSff4oyPO7s/gv0G9UXdKAa2hc7W3HBHZE
   qeM+xzMEoUeQyn3s+9Z9gn76Z6QlSjGpmbrOuLjefuyQrKB8GccwNtwtb
   1xfCMdZvGvd1tRwOUafAlQoLR5B4jG0pqkUQ8mUgIWaSpqa3ZOEa3Kksr
   udX/2nvpZuD7nvBGKV12MdmAdSMRSiWXwzRLiS14q+MTAeQIRBPm8JQr3
   DqPp9VD7kyg6UlgqqXJ+Ze5RpL0OJLfj1ZoEmFrBJ47R1OlQsxq/ry2ng
   Q==;
X-CSE-ConnectionGUID: iaOg1N/4T+KdBwhQWlxltA==
X-CSE-MsgGUID: fWKS5auWRQi+ZHML4rd5CQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11304"; a="53749886"
X-IronPort-AV: E=Sophos;i="6.12,288,1728975600"; 
   d="scan'208";a="53749886"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2025 22:40:11 -0800
X-CSE-ConnectionGUID: K0EqHNEPR4Wgi5JORBRm5g==
X-CSE-MsgGUID: H/O8ru6qT9yLXugQF10nVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="106003981"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 03 Jan 2025 22:40:07 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tTxpN-000AhP-0k;
	Sat, 04 Jan 2025 06:40:05 +0000
Date: Sat, 4 Jan 2025 14:39:11 +0800
From: kernel test robot <lkp@intel.com>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] Provide __free(argv) for argv_split() users
Message-ID: <202501041433.GkehPwga-lkp@intel.com>
References: <173594530753.1055889.17844868397124331132.stgit@devnote2>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173594530753.1055889.17844868397124331132.stgit@devnote2>

Hi Masami,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20241220]
[also build test ERROR on v6.13-rc5]
[cannot apply to kees/for-next/hardening linus/master rostedt-trace/for-next rostedt-trace/for-next-urgent v6.13-rc5 v6.13-rc4 v6.13-rc3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Masami-Hiramatsu-Google/tracing-kprobes-Fix-to-free-objects-when-failed-to-copy-a-symbol/20250104-070535
base:   next-20241220
patch link:    https://lore.kernel.org/r/173594530753.1055889.17844868397124331132.stgit%40devnote2
patch subject: [PATCH 2/6] Provide __free(argv) for argv_split() users
config: i386-buildonly-randconfig-002-20250104 (https://download.01.org/0day-ci/archive/20250104/202501041433.GkehPwga-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250104/202501041433.GkehPwga-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501041433.GkehPwga-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/uuid.h:11,
                    from include/linux/mod_devicetable.h:14,
                    from scripts/mod/devicetable-offsets.c:3:
>> include/linux/string.h:315:18: error: expected ')' before 'char'
     315 | DEFINE_FREE(argv, char **, argv_free(_T))
         |                  ^~~~~
         |                  )
   make[3]: *** [scripts/Makefile.build:102: scripts/mod/devicetable-offsets.s] Error 1 shuffle=943069964
   make[3]: Target 'scripts/mod/' not remade because of errors.
   make[2]: *** [Makefile:1262: prepare0] Error 2 shuffle=943069964
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:251: __sub-make] Error 2 shuffle=943069964
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:251: __sub-make] Error 2 shuffle=943069964
   make: Target 'prepare' not remade because of errors.


vim +315 include/linux/string.h

   314	
 > 315	DEFINE_FREE(argv, char **, argv_free(_T))
   316	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
