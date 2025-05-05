Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8778D2566;
	Mon,  5 May 2025 05:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746421584; cv=none; b=K2QNWte7y4CbR24MUrfhCgPmoGVZVNoL9Zouc7ufX2zKVQkEr8mT3RMSwMyqbtkxjEhQq3bE+L0eJBucry68v3e63jJmrgUW5UVuu+ne9srcPy/dZdms7rBXXrS75gpDayF6OkiKr+0pTKQ459b/g4KiLZyjX/Oyt330lRFwR+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746421584; c=relaxed/simple;
	bh=KpE9wjXlGQWl4XdN1XdPw8AuQidvNZejWAaHnQ1kP4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i8OXVIz9bDtY65079MLQqEii1MAaFGmxrz3u8A9dkOCxUzHcGum7Nhgx51GwbuP8IQS42bBiXjqhyy0Ja75a0RKmskvfgLHhu0mCD5/FPqSZ6++QYHUddaNX6lATWs+u9nR0DlshmURt2/+M6S6+MjcvVTQXUkWl9gJ/7zsKhpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LRcw6R/Y; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LRcw6R/Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746421582; x=1777957582;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KpE9wjXlGQWl4XdN1XdPw8AuQidvNZejWAaHnQ1kP4E=;
  b=LRcw6R/YvA5CoPm7b4b/2wdTU1Gi1fctaUurZLcEEKls6487oqW9Ss/M
   UQcOPfieLyHjaAVZE1voqb8X16Hc3NDGFBNkG9YuXXHOe4G56oWCnEZmg
   0LyY5H3EAxKD8d505ivLKNwvXFySlu2A2iS2+0+hkBt2Yrd6M9ACVMRU8
   1VBVAHLtZeA05O8oISCTr3gLJi+5gaXGlN1u8SSyvFwG9gRqAd6G6bKCt
   0UPUkzXY9hEuV5ZV1sp7lGY05Yu4OmAcEwG50hOpUjLUnST7UbvEVKVxd
   GpVa3ehXIPxq8vkHz3OGWSE5Mk1DF/yKly3c4HXHszGTumj8lA8y7tGLo
   g==;
X-CSE-ConnectionGUID: NUozlbiWQxqNwTZ6Hlg4JA==
X-CSE-MsgGUID: /RsP/XnIQJe+EG/Ey+b6dw==
X-IronPort-AV: E=McAfee;i="6700,10204,11423"; a="50667780"
X-IronPort-AV: E=Sophos;i="6.15,262,1739865600"; 
   d="scan'208";a="50667780"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2025 22:06:21 -0700
X-CSE-ConnectionGUID: NFbsm+nURZuK2hYFbJXcNw==
X-CSE-MsgGUID: cexH5n/4TGyvFPvJrkVySQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,262,1739865600"; 
   d="scan'208";a="135655373"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 04 May 2025 22:06:19 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uBo1v-0005ar-2S;
	Mon, 05 May 2025 05:06:15 +0000
Date: Mon, 5 May 2025 13:05:47 +0800
From: kernel test robot <lkp@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH 05/12] tracing: kdb: Use tracer_tracing_on/off() instead
 of setting per CPU disabled
Message-ID: <202505051213.exaXF8qp-lkp@intel.com>
References: <20250502205348.643055437@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250502205348.643055437@goodmis.org>

Hi Steven,

kernel test robot noticed the following build warnings:

[auto build test WARNING on trace/for-next]
[also build test WARNING on linus/master v6.15-rc4 next-20250502]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Steven-Rostedt/tracing-mmiotrace-Remove-reference-to-unused-per-CPU-data-pointer/20250503-050317
base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
patch link:    https://lore.kernel.org/r/20250502205348.643055437%40goodmis.org
patch subject: [PATCH 05/12] tracing: kdb: Use tracer_tracing_on/off() instead of setting per CPU disabled
config: arc-randconfig-002-20250503 (https://download.01.org/0day-ci/archive/20250505/202505051213.exaXF8qp-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250505/202505051213.exaXF8qp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505051213.exaXF8qp-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/trace/trace_kdb.c: In function 'kdb_ftdump':
>> kernel/trace/trace_kdb.c:101:13: warning: unused variable 'cpu' [-Wunused-variable]
     101 |         int cpu;
         |             ^~~


vim +/cpu +101 kernel/trace/trace_kdb.c

955b61e5979847 Jason Wessel     2010-08-05   91  
955b61e5979847 Jason Wessel     2010-08-05   92  /*
955b61e5979847 Jason Wessel     2010-08-05   93   * kdb_ftdump - Dump the ftrace log buffer
955b61e5979847 Jason Wessel     2010-08-05   94   */
955b61e5979847 Jason Wessel     2010-08-05   95  static int kdb_ftdump(int argc, const char **argv)
955b61e5979847 Jason Wessel     2010-08-05   96  {
dbfe67334a1767 Douglas Anderson 2019-03-19   97  	int skip_entries = 0;
19063c776fe745 Jason Wessel     2010-08-05   98  	long cpu_file;
0c10cc2435115c Yuran Pereira    2024-10-28   99  	int err;
03197fc02b3566 Douglas Anderson 2019-03-19  100  	int cnt;
03197fc02b3566 Douglas Anderson 2019-03-19 @101  	int cpu;
955b61e5979847 Jason Wessel     2010-08-05  102  
19063c776fe745 Jason Wessel     2010-08-05  103  	if (argc > 2)
955b61e5979847 Jason Wessel     2010-08-05  104  		return KDB_ARGCOUNT;
955b61e5979847 Jason Wessel     2010-08-05  105  
0c10cc2435115c Yuran Pereira    2024-10-28  106  	if (argc && kstrtoint(argv[1], 0, &skip_entries))
0c10cc2435115c Yuran Pereira    2024-10-28  107  		return KDB_BADINT;
955b61e5979847 Jason Wessel     2010-08-05  108  
19063c776fe745 Jason Wessel     2010-08-05  109  	if (argc == 2) {
0c10cc2435115c Yuran Pereira    2024-10-28  110  		err = kstrtol(argv[2], 0, &cpu_file);
0c10cc2435115c Yuran Pereira    2024-10-28  111  		if (err || cpu_file >= NR_CPUS || cpu_file < 0 ||
19063c776fe745 Jason Wessel     2010-08-05  112  		    !cpu_online(cpu_file))
19063c776fe745 Jason Wessel     2010-08-05  113  			return KDB_BADINT;
19063c776fe745 Jason Wessel     2010-08-05  114  	} else {
ae3b5093ad6004 Steven Rostedt   2013-01-23  115  		cpu_file = RING_BUFFER_ALL_CPUS;
19063c776fe745 Jason Wessel     2010-08-05  116  	}
19063c776fe745 Jason Wessel     2010-08-05  117  
955b61e5979847 Jason Wessel     2010-08-05  118  	kdb_trap_printk++;
03197fc02b3566 Douglas Anderson 2019-03-19  119  
03197fc02b3566 Douglas Anderson 2019-03-19  120  	trace_init_global_iter(&iter);
03197fc02b3566 Douglas Anderson 2019-03-19  121  	iter.buffer_iter = buffer_iter;
03197fc02b3566 Douglas Anderson 2019-03-19  122  
6a4611f6bb763d Steven Rostedt   2025-05-02  123  	tracer_tracing_off(iter.tr);
03197fc02b3566 Douglas Anderson 2019-03-19  124  
03197fc02b3566 Douglas Anderson 2019-03-19  125  	/* A negative skip_entries means skip all but the last entries */
03197fc02b3566 Douglas Anderson 2019-03-19  126  	if (skip_entries < 0) {
03197fc02b3566 Douglas Anderson 2019-03-19  127  		if (cpu_file == RING_BUFFER_ALL_CPUS)
03197fc02b3566 Douglas Anderson 2019-03-19  128  			cnt = trace_total_entries(NULL);
03197fc02b3566 Douglas Anderson 2019-03-19  129  		else
03197fc02b3566 Douglas Anderson 2019-03-19  130  			cnt = trace_total_entries_cpu(NULL, cpu_file);
03197fc02b3566 Douglas Anderson 2019-03-19  131  		skip_entries = max(cnt + skip_entries, 0);
03197fc02b3566 Douglas Anderson 2019-03-19  132  	}
03197fc02b3566 Douglas Anderson 2019-03-19  133  
dbfe67334a1767 Douglas Anderson 2019-03-19  134  	ftrace_dump_buf(skip_entries, cpu_file);
03197fc02b3566 Douglas Anderson 2019-03-19  135  
6a4611f6bb763d Steven Rostedt   2025-05-02  136  	tracer_tracing_on(iter.tr);
03197fc02b3566 Douglas Anderson 2019-03-19  137  
955b61e5979847 Jason Wessel     2010-08-05  138  	kdb_trap_printk--;
955b61e5979847 Jason Wessel     2010-08-05  139  
955b61e5979847 Jason Wessel     2010-08-05  140  	return 0;
955b61e5979847 Jason Wessel     2010-08-05  141  }
955b61e5979847 Jason Wessel     2010-08-05  142  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
