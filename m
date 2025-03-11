Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCFE25D8FF;
	Tue, 11 Mar 2025 15:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741706731; cv=none; b=bzR7JXpXFHfzlKMDu27150hkJTukTgPJmi6CC/kpwhZe6WcZBq/M2GPRQt2Mo3XeVEM7h84m6E9vHYoxWqzM6RDT/LRfvS8do1cEUXsZYvYNMpKJ1pcYJeKCytIaYRTCYhUwJtgXLcEfvbBXDZ+9PlnMdcDzdpyD2KUiu/UWAZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741706731; c=relaxed/simple;
	bh=0d/Gu3/APzhUJteM1bMDC9zyxYeK89YVxBBNE7L0FII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LrTbooPDXo22l6Ci13NcPh9mX265TLhyJBZUVfN/XbIRn+08CT1c2GUrQGiwiQeZo6g5lgTzps2KKMMV9zzuBypBXsRGnu7T+GHIPd5NKse+cGspgdsgtqFzLqbuUOvdKI6WMgBeDfbIoHjYLS1gQLa1RgpT8QzoaNRTbYFxS7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fRjSfXde; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fRjSfXde"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741706729; x=1773242729;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0d/Gu3/APzhUJteM1bMDC9zyxYeK89YVxBBNE7L0FII=;
  b=fRjSfXdeTrGa5uq2DeWRQ2zBf8QRzdNTFHIZ79LYahSUfJV/5fNZoI8N
   z2SmiFjXf74TbGI2ayP2WS4BqV9pIT2Ly/70qjkmKoZxelO0lalfsrT/P
   h/PUKQvImWuIPyPFAH7YWgMSqXCRz0uIDjPr6D6opySE073yecp4vSAJa
   RaNsN16hgu/KU50IK+44RYbaUo6qX1Vbf5oPpYbDJiyqtqMGucht6FaKF
   RPeO9MjOA226aE3qQvzb4bP9j2X5ZoyTaPuI+bxQQISS7iXTJoy3oZor7
   KuEx0LP1hBUpzE6JAG+AmTTt2YiNbjFfu0IBE8HGF93187j3r3HkJ4Ny0
   A==;
X-CSE-ConnectionGUID: OIgVmH2XQ9CUD2Po3/Bicg==
X-CSE-MsgGUID: arf9xS36TCiqJjWyWoCylg==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="60299279"
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="60299279"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 08:25:28 -0700
X-CSE-ConnectionGUID: EL4W8WxNRSmNJGf5gIwKvQ==
X-CSE-MsgGUID: t2xX6LR3SGWu+dMe6leO0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="151295515"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 11 Mar 2025 08:25:26 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ts1Tw-00077C-1C;
	Tue, 11 Mar 2025 15:25:24 +0000
Date: Tue, 11 Mar 2025 23:24:41 +0800
From: kernel test robot <lkp@intel.com>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v3] tracing: Show last module text symbols in the
 stacktrace
Message-ID: <202503112303.D7g66VSd-lkp@intel.com>
References: <174161444691.1063601.16690699136628689205.stgit@devnote2>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174161444691.1063601.16690699136628689205.stgit@devnote2>

Hi Masami,

kernel test robot noticed the following build errors:

[auto build test ERROR on trace/for-next]
[cannot apply to linus/master v6.14-rc6 next-20250311]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Masami-Hiramatsu-Google/tracing-Show-last-module-text-symbols-in-the-stacktrace/20250310-214849
base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
patch link:    https://lore.kernel.org/r/174161444691.1063601.16690699136628689205.stgit%40devnote2
patch subject: [PATCH v3] tracing: Show last module text symbols in the stacktrace
config: i386-buildonly-randconfig-001-20250311 (https://download.01.org/0day-ci/archive/20250311/202503112303.D7g66VSd-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250311/202503112303.D7g66VSd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503112303.D7g66VSd-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/trace/trace.c: In function 'save_mod':
   kernel/trace/trace.c:6072:45: error: invalid use of undefined type 'struct module'
    6072 |         entry->mod_addr = (unsigned long)mod->mem[MOD_TEXT].base;
         |                                             ^~
   kernel/trace/trace.c:6072:51: error: 'MOD_TEXT' undeclared (first use in this function)
    6072 |         entry->mod_addr = (unsigned long)mod->mem[MOD_TEXT].base;
         |                                                   ^~~~~~~~
   kernel/trace/trace.c:6072:51: note: each undeclared identifier is reported only once for each function it appears in
   In file included from arch/x86/include/asm/page_32.h:18,
                    from arch/x86/include/asm/page.h:14,
                    from arch/x86/include/asm/thread_info.h:12,
                    from include/linux/thread_info.h:60,
                    from include/linux/spinlock.h:60,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/mm.h:7,
                    from include/linux/ring_buffer.h:5,
                    from kernel/trace/trace.c:15:
   kernel/trace/trace.c:6073:37: error: invalid use of undefined type 'struct module'
    6073 |         strscpy(entry->mod_name, mod->name);
         |                                     ^~
   include/linux/string.h:80:28: note: in definition of macro '__strscpy0'
      80 |         sized_strscpy(dst, src, sizeof(dst) + __must_be_array(dst) +    \
         |                            ^~~
   kernel/trace/trace.c:6073:9: note: in expansion of macro 'strscpy'
    6073 |         strscpy(entry->mod_name, mod->name);
         |         ^~~~~~~
   In file included from include/asm-generic/bug.h:5,
                    from arch/x86/include/asm/bug.h:99,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/mm.h:6:
   kernel/trace/trace.c:6073:37: error: invalid use of undefined type 'struct module'
    6073 |         strscpy(entry->mod_name, mod->name);
         |                                     ^~
   include/linux/compiler.h:197:79: note: in definition of macro '__BUILD_BUG_ON_ZERO_MSG'
     197 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                                               ^
   include/linux/compiler.h:211:33: note: in expansion of macro '__annotated'
     211 |         __BUILD_BUG_ON_ZERO_MSG(__annotated(p, nonstring), "must be cstr (NUL-terminated)")
         |                                 ^~~~~~~~~~~
   include/linux/string.h:81:55: note: in expansion of macro '__must_be_cstr'
      81 |                                 __must_be_cstr(dst) + __must_be_cstr(src))
         |                                                       ^~~~~~~~~~~~~~
   include/linux/args.h:25:24: note: in expansion of macro '__strscpy0'
      25 | #define __CONCAT(a, b) a ## b
         |                        ^
   kernel/trace/trace.c:6073:9: note: in expansion of macro 'strscpy'
    6073 |         strscpy(entry->mod_name, mod->name);
         |         ^~~~~~~
   kernel/trace/trace.c: In function 'make_mod_delta':
   kernel/trace/trace.c:9411:32: error: invalid use of undefined type 'struct module'
    9411 |                 if (!strcmp(mod->name, entry->mod_name)) {
         |                                ^~
   kernel/trace/trace.c:9412:32: error: invalid use of undefined type 'struct module'
    9412 |                         if (mod->state == MODULE_STATE_GOING)
         |                                ^~
>> kernel/trace/trace.c:9412:43: error: 'MODULE_STATE_GOING' undeclared (first use in this function)
    9412 |                         if (mod->state == MODULE_STATE_GOING)
         |                                           ^~~~~~~~~~~~~~~~~~
   kernel/trace/trace.c:9415:69: error: invalid use of undefined type 'struct module'
    9415 |                                 module_delta[i] = (unsigned long)mod->mem[MOD_TEXT].base
         |                                                                     ^~
   kernel/trace/trace.c:9415:75: error: 'MOD_TEXT' undeclared (first use in this function)
    9415 |                                 module_delta[i] = (unsigned long)mod->mem[MOD_TEXT].base
         |                                                                           ^~~~~~~~


vim +/MODULE_STATE_GOING +9412 kernel/trace/trace.c

  9398	
  9399	static int make_mod_delta(struct module *mod, void *data)
  9400	{
  9401		struct trace_scratch *tscratch;
  9402		struct trace_mod_entry *entry;
  9403		struct trace_array *tr = data;
  9404		long *module_delta;
  9405		int i;
  9406	
  9407		tscratch = tr->scratch;
  9408		module_delta = READ_ONCE(tscratch->module_delta);
  9409		for (i = 0; i < tscratch->nr_entries; i++) {
  9410			entry = &tscratch->entries[i];
> 9411			if (!strcmp(mod->name, entry->mod_name)) {
> 9412				if (mod->state == MODULE_STATE_GOING)
  9413					module_delta[i] = 0;
  9414				else
  9415					module_delta[i] = (unsigned long)mod->mem[MOD_TEXT].base
  9416							 - entry->mod_addr;
  9417				break;
  9418			}
  9419		}
  9420		return 0;
  9421	}
  9422	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
