Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67D7137742;
	Sat,  4 Jan 2025 06:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735973535; cv=none; b=doW8JZbogeJ7iqKJ0WNZvC9a3cYuOpUIg4ihyU8uPKjbQlO92E22Hwu3uH+4TvH84VHYRAM9Jzaqs6Lpqngk2Majaq50W2KyXt8mJaFyiMcmdGu8F7AoQKWf1GO5DXzUXptGX+gX8XURi+a6dcRWvb8dc7C7zRmJ61uGJWlxmL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735973535; c=relaxed/simple;
	bh=6l8RMlcLcA4FQZMn5PsKIYFZzTojoZI33nFpPc9Vhx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e4/atpZbMDVL/Lj6foWZda0+KjZXsRl2ssHJMsv7nIDhoTXOzKJ9OByvFg+XJHQ6lirmcdlg4k/BIyhK8CAPgW2xW/w9m84ZcLi0b+9OVZxiuTdpZI2ZqeNkLO9pnsU5q6mtXzr3hjazJQRzPCM5zyKKfZVYGbglcT29b4hm9YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZA8J7G0R; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZA8J7G0R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735973533; x=1767509533;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6l8RMlcLcA4FQZMn5PsKIYFZzTojoZI33nFpPc9Vhx4=;
  b=ZA8J7G0Rp7OXVJ6QnpEO/R2xYXuwHF1BLb5mzhkuZWZDAOPAEbdQT98D
   rXwBp9/I5XRVYPSjm3ME7woj3Ww+c5vYtMbEJPIxnH4naX2t/1c897/oN
   +ohg0JNYTMfkPcObIpI6gOeWy6Q8wc2ovg9Sa8RCA6kyXcjBD27GUMyik
   SGrG9pNj6ZyKfIHBYm1lj1z74WGPLLrlsOjyAk2uTuQrTzTv7V1KYIJk0
   gorxM6QrN9KdJZaZiMlZ2xmHpI1kQdQJfPdc8gCqAodJE0d9vFDHbCUhZ
   fyb7+t+B795KLyxfx6byMk3xZEjX7XkAprIk3UBwFtG57QQr6BTjN1PUZ
   Q==;
X-CSE-ConnectionGUID: 2Xt7JIgBS5qmO7F0RlPB5w==
X-CSE-MsgGUID: Y+m47Mi9QWWz73jznLnACg==
X-IronPort-AV: E=McAfee;i="6700,10204,11304"; a="35906178"
X-IronPort-AV: E=Sophos;i="6.12,288,1728975600"; 
   d="scan'208";a="35906178"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2025 22:52:12 -0800
X-CSE-ConnectionGUID: QWbCuNnHR9uti7bT3CiKOg==
X-CSE-MsgGUID: SWFbocZ6QBae1Lkqdkowzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,288,1728975600"; 
   d="scan'208";a="102147906"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 03 Jan 2025 22:52:08 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tTy10-000AiN-1g;
	Sat, 04 Jan 2025 06:52:06 +0000
Date: Sat, 4 Jan 2025 14:51:12 +0800
From: kernel test robot <lkp@intel.com>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
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
Message-ID: <202501041451.yG7LhbEv-lkp@intel.com>
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
config: i386-buildonly-randconfig-001-20250104 (https://download.01.org/0day-ci/archive/20250104/202501041451.yG7LhbEv-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250104/202501041451.yG7LhbEv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501041451.yG7LhbEv-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from scripts/mod/devicetable-offsets.c:3:
   In file included from include/linux/mod_devicetable.h:14:
   In file included from include/linux/uuid.h:11:
>> include/linux/string.h:315:19: error: expected identifier
     315 | DEFINE_FREE(argv, char **, argv_free(_T))
         |                   ^
>> include/linux/string.h:315:1: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
     315 | DEFINE_FREE(argv, char **, argv_free(_T))
         | ^
         | int
>> include/linux/string.h:315:12: error: a function declaration without a prototype is deprecated in all versions of C [-Werror,-Wstrict-prototypes]
     315 | DEFINE_FREE(argv, char **, argv_free(_T))
         |            ^                            
         |                                         void
>> include/linux/string.h:315:42: error: expected ';' after top level declarator
     315 | DEFINE_FREE(argv, char **, argv_free(_T))
         |                                          ^
         |                                          ;
   4 errors generated.
   make[3]: *** [scripts/Makefile.build:102: scripts/mod/devicetable-offsets.s] Error 1 shuffle=808271366
   make[3]: Target 'scripts/mod/' not remade because of errors.
   make[2]: *** [Makefile:1262: prepare0] Error 2 shuffle=808271366
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:251: __sub-make] Error 2 shuffle=808271366
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:251: __sub-make] Error 2 shuffle=808271366
   make: Target 'prepare' not remade because of errors.


vim +315 include/linux/string.h

   314	
 > 315	DEFINE_FREE(argv, char **, argv_free(_T))
   316	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
