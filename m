Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DDD22301;
	Sun, 11 Jan 2026 18:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768154642; cv=none; b=QjblI6QYgxHEMfQacf8WT8bKGe0Cqra4g6OlF6gHbytOLGYEDOyL0GYYBExm1X5DUHKdZ9qGnz9oUG+bz+bLoaGkFmpOLypYZl8hWdu1TjMquG6rcwPZer9z2uxdIMSBwFWKUgIWIg3a+jNGQf/iOFvYrsaK5VhIkZc/pvYVaeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768154642; c=relaxed/simple;
	bh=zbTnStaZRGXqT6TfypigN7OHnqv2DHIxSoAC5Gw88yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jJUBBr74kyoN2dhv2k56PbQFhhgdwBQa0YWa0ZsBPocAgEEI7qcA5wIKnCLpjXqtP2n2zu6XcvhpkbQ2qkpQZfa7SBWNZYC2AZowSkmv6Q51GYdagDEVsBdwWDNykuuJp/fVaFInuYpShK1xISu6AsjNABjvUe7HihBWD/m7xxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i42kBWKP; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i42kBWKP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768154638; x=1799690638;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zbTnStaZRGXqT6TfypigN7OHnqv2DHIxSoAC5Gw88yg=;
  b=i42kBWKPjkZz60wg96NQ4np0Ou2H8oiJDPekp3L8WbI8YGOVN6jSHk4/
   J3sP7evtRezLYVvL5blTP8V4PNs0WsDroUa4whMmWqDJkx6UvH9PJpHpG
   2Ch5lenerW31GfLUt0b5r1XHj0ZTgqL+7LPtdZt4NAE7eSFXbNMss6j39
   MC0d37AohG0aEur+84InF02wRnyRUC++2hxOrQglW/JRCpk0nTbhWUxSx
   9ONDI0XaeFW4R81nLJnRkCO307WQrd5L2ONY7HFIRIXcAqHeYCFppfq0a
   cXnaFx1jwSxBOoJbDCLmWwpTMlkdnTMJcs9bAqVjGmxRXCN1/S3JI3m20
   g==;
X-CSE-ConnectionGUID: kXlXjMZDQWarGkAlh5/HwA==
X-CSE-MsgGUID: 1Emfh2TmRp+H5Y0LS0wvJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="68452007"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="68452007"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 10:03:57 -0800
X-CSE-ConnectionGUID: pCRMPKXFTZmo/M3PkCS/fg==
X-CSE-MsgGUID: EucFxaScS++i9cFiaip57w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="208441509"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 11 Jan 2026 10:03:51 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vezn1-00000000CbA-48AU;
	Sun, 11 Jan 2026 18:03:47 +0000
Date: Mon, 12 Jan 2026 02:03:31 +0800
From: kernel test robot <lkp@intel.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux-foundation.org>,
	Martin Liu <liumartin@google.com>,
	David Rientjes <rientjes@google.com>, christian.koenig@amd.com,
	Shakeel Butt <shakeel.butt@linux.dev>,
	SeongJae Park <sj@kernel.org>, Michal Hocko <mhocko@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <liam.howlett@oracle.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-trace-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH v12 3/3] mm: Implement precise OOM killer task selection
Message-ID: <202601120124.RK3AWOwu-lkp@intel.com>
References: <20260111150249.1222944-4-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260111150249.1222944-4-mathieu.desnoyers@efficios.com>

Hi Mathieu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20260109]
[cannot apply to akpm-mm/mm-everything kees/for-next/execve tip/sched/core linus/master v6.19-rc4 v6.19-rc3 v6.19-rc2 v6.19-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mathieu-Desnoyers/lib-Introduce-hierarchical-per-cpu-counters/20260111-231206
base:   next-20260109
patch link:    https://lore.kernel.org/r/20260111150249.1222944-4-mathieu.desnoyers%40efficios.com
patch subject: [PATCH v12 3/3] mm: Implement precise OOM killer task selection
config: arm-randconfig-001-20260112 (https://download.01.org/0day-ci/archive/20260112/202601120124.RK3AWOwu-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 9b8addffa70cee5b2acc5454712d9cf78ce45710)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260112/202601120124.RK3AWOwu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601120124.RK3AWOwu-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/fork.c:637:6: warning: format specifies type 'long' but the argument has type 'int' [-Wformat]
     635 |                         pr_alert("BUG: Bad rss-counter state mm:%p type:%s val:%ld Comm:%s Pid:%d\n",
         |                                                                                ~~~
         |                                                                                %d
     636 |                                  mm, resident_page_types[i],
     637 |                                  percpu_counter_tree_precise_sum(&mm->rss_stat[i]),
         |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/printk.h:534:35: note: expanded from macro 'pr_alert'
     534 |         printk(KERN_ALERT pr_fmt(fmt), ##__VA_ARGS__)
         |                                  ~~~     ^~~~~~~~~~~
   include/linux/printk.h:511:60: note: expanded from macro 'printk'
     511 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
         |                                                     ~~~    ^~~~~~~~~~~
   include/linux/printk.h:483:19: note: expanded from macro 'printk_index_wrap'
     483 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ~~~~    ^~~~~~~~~~~
   1 warning generated.
--
>> mm/oom_kill.c:351:6: warning: variable 'points_min' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
     351 |         if (oom_task_origin(task)) {
         |             ^~~~~~~~~~~~~~~~~~~~~
   mm/oom_kill.c:392:22: note: uninitialized use occurs here
     392 |         oc->chosen_points = points_min;
         |                             ^~~~~~~~~~
   mm/oom_kill.c:351:2: note: remove the 'if' if its condition is always false
     351 |         if (oom_task_origin(task)) {
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
     352 |                 points = LONG_MAX;
         |                 ~~~~~~~~~~~~~~~~~~
     353 |                 goto select;
         |                 ~~~~~~~~~~~~
     354 |         }
         |         ~
   mm/oom_kill.c:326:25: note: initialize the variable 'points_min' to silence this warning
     326 |         long points, points_min, points_max;
         |                                ^
         |                                 = 0
   1 warning generated.


vim +637 kernel/fork.c

6af8cb80d3a9a6 David Hildenbrand    2025-03-03  625  
d70f2a14b72a4b Andrew Morton        2018-01-31  626  static void check_mm(struct mm_struct *mm)
d70f2a14b72a4b Andrew Morton        2018-01-31  627  {
d70f2a14b72a4b Andrew Morton        2018-01-31  628  	int i;
d70f2a14b72a4b Andrew Morton        2018-01-31  629  
8495f7e6732ed2 Sai Praneeth Prakhya 2019-09-25  630  	BUILD_BUG_ON_MSG(ARRAY_SIZE(resident_page_types) != NR_MM_COUNTERS,
8495f7e6732ed2 Sai Praneeth Prakhya 2019-09-25  631  			 "Please make sure 'struct resident_page_types[]' is updated as well");
8495f7e6732ed2 Sai Praneeth Prakhya 2019-09-25  632  
d70f2a14b72a4b Andrew Morton        2018-01-31  633  	for (i = 0; i < NR_MM_COUNTERS; i++) {
25d942f31cc499 Mathieu Desnoyers    2026-01-11  634  		if (unlikely(percpu_counter_tree_precise_compare_value(&mm->rss_stat[i], 0) != 0))
72456781289a6e Mathieu Desnoyers    2026-01-11  635  			pr_alert("BUG: Bad rss-counter state mm:%p type:%s val:%ld Comm:%s Pid:%d\n",
25d942f31cc499 Mathieu Desnoyers    2026-01-11  636  				 mm, resident_page_types[i],
25d942f31cc499 Mathieu Desnoyers    2026-01-11 @637  				 percpu_counter_tree_precise_sum(&mm->rss_stat[i]),
881388f3433819 Xuanye Liu           2025-07-23  638  				 current->comm,
881388f3433819 Xuanye Liu           2025-07-23  639  				 task_pid_nr(current));
881388f3433819 Xuanye Liu           2025-07-23  640  	}
d70f2a14b72a4b Andrew Morton        2018-01-31  641  
d70f2a14b72a4b Andrew Morton        2018-01-31  642  	if (mm_pgtables_bytes(mm))
d70f2a14b72a4b Andrew Morton        2018-01-31  643  		pr_alert("BUG: non-zero pgtables_bytes on freeing mm: %ld\n",
d70f2a14b72a4b Andrew Morton        2018-01-31  644  				mm_pgtables_bytes(mm));
d70f2a14b72a4b Andrew Morton        2018-01-31  645  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
