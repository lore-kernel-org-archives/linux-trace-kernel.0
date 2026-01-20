Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5B63D413C;
	Tue, 20 Jan 2026 08:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768897071; cv=none; b=gvLLkhDAa2EwzNekn37Tiw4HIChZz+3f+MisxU8tt1cT0IK/PC7Hb1OJ+C995mol5r9T8Ec13bBjm1tNYaBApGgO8+wdd3k5mjmjlEOuBjJsFSIW7gSJiH2+MOKP1gkJnvnZZzJE7OZXmuiRXRYkY3r9xssKq7Zu1Cqgz166LIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768897071; c=relaxed/simple;
	bh=Xfijze/X4OkStQQaLtiCDwYKY/ckpnZZcmbaC0E09Ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mO7UKi3q9Ay/NUWHIN7AENYkj/3tfW+71wRvgzULczPHCa+YgS7QZDMOLgz22WVXpN7zQxhIU165rGZXmPUbaTL/FJZHKy1n6xTEbdguiyG+5SBVVIMzyWgK9ieKDOoAcoXl5+AUE+TZFPQGNZrxQ4OtiGt7UDLv9OMsTD4m42s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UiFjWcNa; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UiFjWcNa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768897070; x=1800433070;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Xfijze/X4OkStQQaLtiCDwYKY/ckpnZZcmbaC0E09Ks=;
  b=UiFjWcNajLRbWt6BBQNRxA/y9+H0L5L5l+re7msI4I+OaZcSSKJXe0pf
   VUQ+HAJ5LDg+lR+ODvxK2AvaEESHuHXervQ6nNYQ9gk6fIdZEYMaTR+sw
   B2mZ+g7h9jb9H0U8DyjGQGjK2nAp1BYtqKenSWmlodRGaMSdSr1KIIjYv
   EKtoEIFpcHZuf5ccMkoFTxPrpkDhWevlNC12VSWgTMPRIn3/Rvo61FQ4a
   7oxlubMKGsY/c7Uol9gI6xqKFE7DfAPkCFFZNIlqr8NosHFmlPByj5c0y
   DoIpYjp9KshTyYuOX16553nj3bI40gRqqvSFwO76ROvj4HEWbLoNcwWe6
   A==;
X-CSE-ConnectionGUID: AHMaWr2+ROGlYophiOicMg==
X-CSE-MsgGUID: pKIU1SZeQ/S/F54J3gvGxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="80732089"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="80732089"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 00:17:49 -0800
X-CSE-ConnectionGUID: b67ww9DYRQ+U7Lww9Na7Gg==
X-CSE-MsgGUID: keYR13a4SjSIRYKWOqq3jQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="205965634"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 20 Jan 2026 00:17:47 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vi6vp-00000000Oih-11Zb;
	Tue, 20 Jan 2026 08:17:45 +0000
Date: Tue, 20 Jan 2026 16:17:05 +0800
From: kernel test robot <lkp@intel.com>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: oe-kbuild-all@lists.linux.dev, Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] tracing: Make the backup instance non-reusable
Message-ID: <202601201531.ng4kqZhn-lkp@intel.com>
References: <176887137556.578403.17994205756247311821.stgit@mhiramat.tok.corp.google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176887137556.578403.17994205756247311821.stgit@mhiramat.tok.corp.google.com>

Hi Masami,

kernel test robot noticed the following build warnings:

[auto build test WARNING on trace/for-next]
[also build test WARNING on linus/master v6.19-rc6 next-20260119]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Masami-Hiramatsu-Google/tracing-Reset-last_boot_info-if-ring-buffer-is-reset/20260120-091429
base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
patch link:    https://lore.kernel.org/r/176887137556.578403.17994205756247311821.stgit%40mhiramat.tok.corp.google.com
patch subject: [PATCH v4 2/4] tracing: Make the backup instance non-reusable
config: arc-defconfig (https://download.01.org/0day-ci/archive/20260120/202601201531.ng4kqZhn-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260120/202601201531.ng4kqZhn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601201531.ng4kqZhn-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/trace/trace.c: In function 'tracing_init_tracefs_percpu':
>> kernel/trace/trace.c:9398:17: warning: variable 'writable_mode' set but not used [-Wunused-but-set-variable]
    9398 |         umode_t writable_mode = TRACE_MODE_WRITE;
         |                 ^~~~~~~~~~~~~


vim +/writable_mode +9398 kernel/trace/trace.c

  9393	
  9394	static void
  9395	tracing_init_tracefs_percpu(struct trace_array *tr, long cpu)
  9396	{
  9397		struct dentry *d_percpu = tracing_dentry_percpu(tr, cpu);
> 9398		umode_t writable_mode = TRACE_MODE_WRITE;
  9399		struct dentry *d_cpu;
  9400		char cpu_dir[30]; /* 30 characters should be more than enough */
  9401	
  9402		if (!d_percpu)
  9403			return;
  9404	
  9405		if (trace_array_is_readonly(tr))
  9406			writable_mode = TRACE_MODE_READ;
  9407	
  9408		snprintf(cpu_dir, 30, "cpu%ld", cpu);
  9409		d_cpu = tracefs_create_dir(cpu_dir, d_percpu);
  9410		if (!d_cpu) {
  9411			pr_warn("Could not create tracefs '%s' entry\n", cpu_dir);
  9412			return;
  9413		}
  9414	
  9415		/* per cpu trace_pipe */
  9416		trace_create_cpu_file("trace_pipe", TRACE_MODE_READ, d_cpu,
  9417					tr, cpu, &tracing_pipe_fops);
  9418	
  9419		/* per cpu trace */
  9420		trace_create_cpu_file("trace", TRACE_MODE_WRITE, d_cpu,
  9421					tr, cpu, &tracing_fops);
  9422	
  9423		trace_create_cpu_file("trace_pipe_raw", TRACE_MODE_READ, d_cpu,
  9424					tr, cpu, &tracing_buffers_fops);
  9425	
  9426		trace_create_cpu_file("stats", TRACE_MODE_READ, d_cpu,
  9427					tr, cpu, &tracing_stats_fops);
  9428	
  9429		trace_create_cpu_file("buffer_size_kb", TRACE_MODE_READ, d_cpu,
  9430					tr, cpu, &tracing_entries_fops);
  9431	
  9432		if (tr->range_addr_start)
  9433			trace_create_cpu_file("buffer_meta", TRACE_MODE_READ, d_cpu,
  9434					      tr, cpu, &tracing_buffer_meta_fops);
  9435	#ifdef CONFIG_TRACER_SNAPSHOT
  9436		if (!tr->range_addr_start) {
  9437			trace_create_cpu_file("snapshot", TRACE_MODE_WRITE, d_cpu,
  9438					      tr, cpu, &snapshot_fops);
  9439	
  9440			trace_create_cpu_file("snapshot_raw", TRACE_MODE_READ, d_cpu,
  9441					      tr, cpu, &snapshot_raw_fops);
  9442		}
  9443	#endif
  9444	}
  9445	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
