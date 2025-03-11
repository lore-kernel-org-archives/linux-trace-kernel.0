Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FCE25DD0B;
	Tue, 11 Mar 2025 15:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741705393; cv=none; b=d6JP4CgAOtH10XQBQgnW2VL8xJwF1GlZPK0M7kw+eGB/rpuQRkF0nxELwAgy6sxcA6CPEs51cqLtmzzbaRvoad4PETtd2S5eOe9RAbFZQ611OVqOgzafG+C8C5t4wAroIZztcSbZ8valfY4FysWYXj8hrxDPi2GreN6nyIOFTOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741705393; c=relaxed/simple;
	bh=bwBOhCkyfjaDBhFbEIHAcboh5OGrOLjFxjCLK/1okmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ttCPW3ztCX4rGxnsrKBgOknvQENv5kHXd5lebIV8DRpA+3VSdSz1xbps9M5USpEZyXvA23FQ1Rp51fUOtdk6vB1JNxdDkQ7Z+AQ8+4XC0OW8DfmaZtkwQz1FLTN73Pt6J0e0YoThauhUKzfhthWv/hGndR/vTmLASs86ekqXe2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dt06dy1h; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dt06dy1h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741705390; x=1773241390;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bwBOhCkyfjaDBhFbEIHAcboh5OGrOLjFxjCLK/1okmM=;
  b=dt06dy1hUTd5gg/zBYyyH5M1CI7nX4AuE4RKLKv09DzUiNdsenGiUKL1
   Rb4dHv4+Olby2SAxP4Dt9yjdiwsy3DsV41AgcX5LdPHhUxtczdvNA0MVS
   3KkIU4BFR0XaMkyEUTTxHIi/onUPVoQM2aa4IwXr4UctPMcVLIZ8k+Ejs
   bwnGcLZu57kdEctzpNt3rFoa+O9gsd6YMEbzktBZ2BsuFpzBPR6+vH+jA
   rUlU5E0PgRXldejHv9sVuW2aDfXj7KFwQtdC3dv6WF22+Rt9tPYdwxphc
   342H+DuulXCzB8yLW/P/IDtAgqJFy/dZZmZwstoVKbm+54jkmosLJrAVk
   w==;
X-CSE-ConnectionGUID: 4SCTEr+wTdyoguXyHeEv1A==
X-CSE-MsgGUID: JwN2I1NRQFuoxd7l2aQ5dg==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="42624779"
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="42624779"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 08:03:09 -0700
X-CSE-ConnectionGUID: akGYNfHzSjKvRDq8cMcw4g==
X-CSE-MsgGUID: 3L/0Tn2ZT3y63LcMfbjzgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="120835168"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 11 Mar 2025 08:03:08 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ts18K-0006k4-3B;
	Tue, 11 Mar 2025 15:03:04 +0000
Date: Tue, 11 Mar 2025 23:03:04 +0800
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
Message-ID: <202503112205.joXgt8gR-lkp@intel.com>
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
config: i386-buildonly-randconfig-004-20250311 (https://download.01.org/0day-ci/archive/20250311/202503112205.joXgt8gR-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250311/202503112205.joXgt8gR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503112205.joXgt8gR-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/trace/trace.c:6072:38: error: incomplete definition of type 'struct module'
    6072 |         entry->mod_addr = (unsigned long)mod->mem[MOD_TEXT].base;
         |                                          ~~~^
   include/linux/printk.h:394:8: note: forward declaration of 'struct module'
     394 | struct module;
         |        ^
   kernel/trace/trace.c:6072:44: error: use of undeclared identifier 'MOD_TEXT'
    6072 |         entry->mod_addr = (unsigned long)mod->mem[MOD_TEXT].base;
         |                                                   ^
   kernel/trace/trace.c:6073:30: error: incomplete definition of type 'struct module'
    6073 |         strscpy(entry->mod_name, mod->name);
         |                                  ~~~^
   include/linux/string.h:114:55: note: expanded from macro 'strscpy'
     114 |         CONCATENATE(__strscpy, COUNT_ARGS(__VA_ARGS__))(dst, src, __VA_ARGS__)
         |                                                              ^~~
   include/linux/string.h:80:21: note: expanded from macro '__strscpy0'
      80 |         sized_strscpy(dst, src, sizeof(dst) + __must_be_array(dst) +    \
         |                            ^~~
   include/linux/printk.h:394:8: note: forward declaration of 'struct module'
     394 | struct module;
         |        ^
   kernel/trace/trace.c:9411:18: error: incomplete definition of type 'struct module'
    9411 |                 if (!strcmp(mod->name, entry->mod_name)) {
         |                             ~~~^
   include/linux/printk.h:394:8: note: forward declaration of 'struct module'
     394 | struct module;
         |        ^
   kernel/trace/trace.c:9412:11: error: incomplete definition of type 'struct module'
    9412 |                         if (mod->state == MODULE_STATE_GOING)
         |                             ~~~^
   include/linux/printk.h:394:8: note: forward declaration of 'struct module'
     394 | struct module;
         |        ^
>> kernel/trace/trace.c:9412:22: error: use of undeclared identifier 'MODULE_STATE_GOING'
    9412 |                         if (mod->state == MODULE_STATE_GOING)
         |                                           ^
   kernel/trace/trace.c:9415:41: error: incomplete definition of type 'struct module'
    9415 |                                 module_delta[i] = (unsigned long)mod->mem[MOD_TEXT].base
         |                                                                  ~~~^
   include/linux/printk.h:394:8: note: forward declaration of 'struct module'
     394 | struct module;
         |        ^
   kernel/trace/trace.c:9415:47: error: use of undeclared identifier 'MOD_TEXT'
    9415 |                                 module_delta[i] = (unsigned long)mod->mem[MOD_TEXT].base
         |                                                                           ^
   8 errors generated.


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
  9411			if (!strcmp(mod->name, entry->mod_name)) {
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
