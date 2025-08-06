Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C941227EB9;
	Wed,  6 Aug 2025 22:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754518006; cv=none; b=OaOlEpVIC3QjV24iFDmbFHs1sttYCalgt0eVK31PdvrfkPb4Jr82fLx18cVoWA55E9EFGXpBztJhjbWPbtSXIEhnbecshebsziGC8cJ0w6+ab0XdAaAl0qeA2K+bRoh7KJ7PIj1i4kR0S9BWssWqdxOA/P5/y91ngMd+IDlQdqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754518006; c=relaxed/simple;
	bh=2rUd3i6DivO+05DXaSp+LgSEmwownIpwutoceQhLjrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VPZcKrH7L4sy14tqveJTFr54sseG+/KDNalU+z1hSU+GM4hhyM3vbPDrJnDzSgamBDyNCCdUJR83bW/1nu/MeynTM4wNuXZI2R92b3gdKJaysQyEqbPI22ResKVHONROF0i/mS8O0+10UizRZLFohCzfz6w+8h6hRMuTA3pmjP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=llU+V5Iu; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="llU+V5Iu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754518004; x=1786054004;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2rUd3i6DivO+05DXaSp+LgSEmwownIpwutoceQhLjrQ=;
  b=llU+V5IuKT52XM3yeTtGXbqUrlFETJP1m6xVdwoWXwmtNNniZRau62H2
   vpaHpm5X/Gwp0DHw9UrPwmDQ/aEiV/5AwVYe00+t1fnqaEMijdjcJgFc1
   m2JvP6/2vw8oQ9xxyb2rP6QwCRYJa65f3uxde6jysdnF3GG3iaNTHjVdG
   oBhWOWuoLfMFC+gDTM3WgCrC2QqlBYjBu4OPg9elP1iro0z79+si5Pjos
   YMLme2TSgqHX/yeulG4BeXCpC5Xzyy488EVW4X6BRG26pM56P9H8ivvXK
   4XZzAOcQ2SyUpTG18d9lHwWsHSFKBoapMFPzawIWY2SMW15F30AfIiWKz
   A==;
X-CSE-ConnectionGUID: v0ftFZHzTr233ZG0MF+GnA==
X-CSE-MsgGUID: gxvI8dYVS4m8y9EpKL2Y2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="56764618"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="56764618"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 15:06:43 -0700
X-CSE-ConnectionGUID: qYezRnfIQiaHI8qbrVdEHw==
X-CSE-MsgGUID: OXzz8Kv+RN+UEkRdj15dWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="169136448"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 06 Aug 2025 15:06:40 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ujmHN-00029C-0f;
	Wed, 06 Aug 2025 22:06:37 +0000
Date: Thu, 7 Aug 2025 06:05:53 +0800
From: kernel test robot <lkp@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Takaya Saeki <takayas@google.com>, Tom Zanussi <zanussi@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ian Rogers <irogers@google.com>, aahringo@redhat.com,
	Douglas Raillard <douglas.raillard@arm.com>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH 1/7] tracing: Replace syscall RCU pointer assignment with
 READ/WRITE_ONCE()
Message-ID: <202508070546.KmEoxWkg-lkp@intel.com>
References: <20250805193234.745705874@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805193234.745705874@kernel.org>

Hi Steven,

kernel test robot noticed the following build warnings:

[auto build test WARNING on trace/for-next]
[also build test WARNING on linus/master v6.16 next-20250806]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Steven-Rostedt/tracing-Replace-syscall-RCU-pointer-assignment-with-READ-WRITE_ONCE/20250806-122312
base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
patch link:    https://lore.kernel.org/r/20250805193234.745705874%40kernel.org
patch subject: [PATCH 1/7] tracing: Replace syscall RCU pointer assignment with READ/WRITE_ONCE()
config: x86_64-randconfig-123-20250806 (https://download.01.org/0day-ci/archive/20250807/202508070546.KmEoxWkg-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250807/202508070546.KmEoxWkg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508070546.KmEoxWkg-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/trace/trace_syscalls.c:313:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct trace_event_file *trace_file @@     got struct trace_event_file [noderef] __rcu * @@
   kernel/trace/trace_syscalls.c:313:20: sparse:     expected struct trace_event_file *trace_file
   kernel/trace/trace_syscalls.c:313:20: sparse:     got struct trace_event_file [noderef] __rcu *
   kernel/trace/trace_syscalls.c:358:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct trace_event_file *trace_file @@     got struct trace_event_file [noderef] __rcu * @@
   kernel/trace/trace_syscalls.c:358:20: sparse:     expected struct trace_event_file *trace_file
   kernel/trace/trace_syscalls.c:358:20: sparse:     got struct trace_event_file [noderef] __rcu *
>> kernel/trace/trace_syscalls.c:394:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct trace_event_file [noderef] __rcu *volatile @@     got struct trace_event_file *file @@
   kernel/trace/trace_syscalls.c:394:17: sparse:     expected struct trace_event_file [noderef] __rcu *volatile
   kernel/trace/trace_syscalls.c:394:17: sparse:     got struct trace_event_file *file
   kernel/trace/trace_syscalls.c:432:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct trace_event_file [noderef] __rcu *volatile @@     got struct trace_event_file *file @@
   kernel/trace/trace_syscalls.c:432:17: sparse:     expected struct trace_event_file [noderef] __rcu *volatile
   kernel/trace/trace_syscalls.c:432:17: sparse:     got struct trace_event_file *file

vim +313 kernel/trace/trace_syscalls.c

   290	
   291	static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
   292	{
   293		struct trace_array *tr = data;
   294		struct trace_event_file *trace_file;
   295		struct syscall_trace_enter *entry;
   296		struct syscall_metadata *sys_data;
   297		struct trace_event_buffer fbuffer;
   298		unsigned long args[6];
   299		int syscall_nr;
   300		int size;
   301	
   302		/*
   303		 * Syscall probe called with preemption enabled, but the ring
   304		 * buffer and per-cpu data require preemption to be disabled.
   305		 */
   306		might_fault();
   307		guard(preempt_notrace)();
   308	
   309		syscall_nr = trace_get_syscall_nr(current, regs);
   310		if (syscall_nr < 0 || syscall_nr >= NR_syscalls)
   311			return;
   312	
 > 313		trace_file = READ_ONCE(tr->enter_syscall_files[syscall_nr]);
   314		if (!trace_file)
   315			return;
   316	
   317		if (trace_trigger_soft_disabled(trace_file))
   318			return;
   319	
   320		sys_data = syscall_nr_to_meta(syscall_nr);
   321		if (!sys_data)
   322			return;
   323	
   324		size = sizeof(*entry) + sizeof(unsigned long) * sys_data->nb_args;
   325	
   326		entry = trace_event_buffer_reserve(&fbuffer, trace_file, size);
   327		if (!entry)
   328			return;
   329	
   330		entry = ring_buffer_event_data(fbuffer.event);
   331		entry->nr = syscall_nr;
   332		syscall_get_arguments(current, regs, args);
   333		memcpy(entry->args, args, sizeof(unsigned long) * sys_data->nb_args);
   334	
   335		trace_event_buffer_commit(&fbuffer);
   336	}
   337	
   338	static void ftrace_syscall_exit(void *data, struct pt_regs *regs, long ret)
   339	{
   340		struct trace_array *tr = data;
   341		struct trace_event_file *trace_file;
   342		struct syscall_trace_exit *entry;
   343		struct syscall_metadata *sys_data;
   344		struct trace_event_buffer fbuffer;
   345		int syscall_nr;
   346	
   347		/*
   348		 * Syscall probe called with preemption enabled, but the ring
   349		 * buffer and per-cpu data require preemption to be disabled.
   350		 */
   351		might_fault();
   352		guard(preempt_notrace)();
   353	
   354		syscall_nr = trace_get_syscall_nr(current, regs);
   355		if (syscall_nr < 0 || syscall_nr >= NR_syscalls)
   356			return;
   357	
   358		trace_file = READ_ONCE(tr->exit_syscall_files[syscall_nr]);
   359		if (!trace_file)
   360			return;
   361	
   362		if (trace_trigger_soft_disabled(trace_file))
   363			return;
   364	
   365		sys_data = syscall_nr_to_meta(syscall_nr);
   366		if (!sys_data)
   367			return;
   368	
   369		entry = trace_event_buffer_reserve(&fbuffer, trace_file, sizeof(*entry));
   370		if (!entry)
   371			return;
   372	
   373		entry = ring_buffer_event_data(fbuffer.event);
   374		entry->nr = syscall_nr;
   375		entry->ret = syscall_get_return_value(current, regs);
   376	
   377		trace_event_buffer_commit(&fbuffer);
   378	}
   379	
   380	static int reg_event_syscall_enter(struct trace_event_file *file,
   381					   struct trace_event_call *call)
   382	{
   383		struct trace_array *tr = file->tr;
   384		int ret = 0;
   385		int num;
   386	
   387		num = ((struct syscall_metadata *)call->data)->syscall_nr;
   388		if (WARN_ON_ONCE(num < 0 || num >= NR_syscalls))
   389			return -ENOSYS;
   390		mutex_lock(&syscall_trace_lock);
   391		if (!tr->sys_refcount_enter)
   392			ret = register_trace_sys_enter(ftrace_syscall_enter, tr);
   393		if (!ret) {
 > 394			WRITE_ONCE(tr->enter_syscall_files[num], file);
   395			tr->sys_refcount_enter++;
   396		}
   397		mutex_unlock(&syscall_trace_lock);
   398		return ret;
   399	}
   400	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
