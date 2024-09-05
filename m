Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DC7194AE8;
	Thu,  5 Sep 2024 08:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725526706; cv=none; b=gwhgijZ3rLfa2iYgCefOX4dqwsILssBXov5pgMIzdODybVUx69c5ksEC0wxj88Ww2uXEYYJa0qMOsWNp4/1qtl4WEht4VIMBo0pY73kjFK51JcgApVgwzFf26LHfZ5lKPOwkXJHO2NxTLFp+rhU5j7P98f+/6Of2wFPRl+YAZKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725526706; c=relaxed/simple;
	bh=gtASPCCOLpt9xwZw3BP2/0cX0MaF3P8nY6xQev3A9po=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iZgVejHS+ibJ2wbK68ZGhlF+0rAENL2xqf71Gayqa6V1pmBl4OYxQ7aLBadSzoxkcfDAuhkjRpGvG5L9vVj9R6MbmJWNEI8cVG1XhXiiUH8Me2iWklrwm9KSPRVh2otYueNxy6OmFjbgpXIeN1ZvRr7WVqavFbC48w/UOEhGau8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FdUPKyIj; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FdUPKyIj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725526704; x=1757062704;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gtASPCCOLpt9xwZw3BP2/0cX0MaF3P8nY6xQev3A9po=;
  b=FdUPKyIjk4U3PIzCOp9mIRiSGsb+hT6AQq0lFnHB3M53tiUhZP9uFgvY
   e8erTMfzOhK2oHhdZTqeAJU13/u59Ti8R47KxM7J7CjMYq4h9CZGudws0
   hh1Rdlu7UtE5DuUQ4tFongHKjsWxp+tGrhLVhmhVMRpzAWoF0yDupdzLM
   qbAOIQqraRdSHBLirGOv7HWa8HlietAjRe2RL28cJLnXYbj41AAUG1YYy
   N18dg4odO1mlSqvNjEot+G4WRlhrF42VeoXIiuZcA0Al+Bfw8836FIeiq
   kktFGZD42i3aPQ2A/209WRT+9CTGwhBJSGDp7e/EBN964YyDl401nEfa5
   A==;
X-CSE-ConnectionGUID: tQmTW5B4S0CZ6Ls5aPEngw==
X-CSE-MsgGUID: RvFeA7GwQZCLMsgt2UYD+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="13383345"
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="13383345"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 01:58:24 -0700
X-CSE-ConnectionGUID: NH9v33D9RO65q6VCwKNZFw==
X-CSE-MsgGUID: BJo+7ka/QKCFaF62TQOahQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="70356682"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 05 Sep 2024 01:58:19 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sm8Jl-00098x-2K;
	Thu, 05 Sep 2024 08:58:17 +0000
Date: Thu, 5 Sep 2024 16:58:07 +0800
From: kernel test robot <lkp@intel.com>
To: Sven Schnelle <svens@linux.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] x86/tracing: pass ftrace_regs to
 function_graph_enter()
Message-ID: <202409051620.5YBbYREt-lkp@intel.com>
References: <20240904065908.1009086-3-svens@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904065908.1009086-3-svens@linux.ibm.com>

Hi Sven,

kernel test robot noticed the following build warnings:

[auto build test WARNING on s390/features]
[also build test WARNING on tip/x86/core linus/master v6.11-rc6 next-20240904]
[cannot apply to rostedt-trace/for-next rostedt-trace/for-next-urgent]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sven-Schnelle/tracing-add-ftrace_regs-to-function_graph_enter/20240904-150232
base:   https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git features
patch link:    https://lore.kernel.org/r/20240904065908.1009086-3-svens%40linux.ibm.com
patch subject: [PATCH 2/7] x86/tracing: pass ftrace_regs to function_graph_enter()
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20240905/202409051620.5YBbYREt-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240905/202409051620.5YBbYREt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409051620.5YBbYREt-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/ftrace.h:23,
                    from include/linux/kprobes.h:28,
                    from arch/x86/kernel/process_64.c:35:
>> arch/x86/include/asm/ftrace.h:108:64: warning: 'struct ftrace_regs' declared inside parameter list will not be visible outside of this definition or declaration
     108 |                            unsigned long frame_pointer, struct ftrace_regs *regs);
         |                                                                ^~~~~~~~~~~


vim +108 arch/x86/include/asm/ftrace.h

   106	
   107	void prepare_ftrace_return(unsigned long ip, unsigned long *parent,
 > 108				   unsigned long frame_pointer, struct ftrace_regs *regs);
   109	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
