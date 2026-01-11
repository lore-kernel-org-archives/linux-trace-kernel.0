Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A64348884;
	Sun, 11 Jan 2026 17:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768153921; cv=none; b=Ld2jjmMPwiSwiL7xRsXiLEO6MRGwCpsvATGUm6rMx7sYQWi2Pxh3KZEzt+SZYvEG8veCjPAjN6LXXUA4RqUUNMiRvTAbxPTTsQi7sNEZq0jN+ROVGpdYi/gVFX2X1xpqg8mxAPEGbkHBZe5EDsi9YlmgnVCT2/IHMLw19ocBE0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768153921; c=relaxed/simple;
	bh=viw5OtDo1SR27nNYQb3yaEG9m7nx3g9bn+c8S3YKMHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NprfL4i2s802Pc68R8J7tY52xxnqYbGsBgWq2p2U1GoAe5AXFREMWjO6B0cXzzpw0F9p0Td0QobDsuqaNlzm1g2K/9eSEMV6f8qJ+t2C+0HXJVJyEATvOoS4LOZqNtEDSgzPTi6DP/j7OyZVfTDnzkNz6BiNYEdApE6k+XrFRbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dt1U4NLa; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dt1U4NLa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768153917; x=1799689917;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=viw5OtDo1SR27nNYQb3yaEG9m7nx3g9bn+c8S3YKMHk=;
  b=dt1U4NLaq4/lQfLLRH7k2zsRGgPN8srIr338TlWBzbOwQZ+juNo0O4WY
   xSwUeAxMFgiAt5MdrcIeooYL37KBgA2RocKVg92fXcsO4S2PCYR/WXUSb
   I3fVMuUrnlcMah+kAPDmlJ7aVUesPKUmxs1brGgGl8pLF/Fw7XFIxl/tv
   Fk7YgUMOVMedYucWMXk0/lB94zU7/+7axc9hRVxIqgU4RGQUXDqbijx1r
   kxjNHG3XOeB0HZrxbCjQkAfTs6KiMz0CZdYHzY2yvSBr4l6PenhtI7q7A
   ebBYhAvLjTcmx3T+6irA8mT0HasreY59PAl0xNsfcjptFHde6pLvYo3OW
   w==;
X-CSE-ConnectionGUID: 243mpd56REqowy6JetO55A==
X-CSE-MsgGUID: Re/d57qMRKWBL19k1jQJBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="86864394"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="86864394"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 09:51:56 -0800
X-CSE-ConnectionGUID: BnhW/eJpSvecJ7L2w8Biag==
X-CSE-MsgGUID: 4j/oD/w/Tj6xSu7Z4uxK7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="208052625"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 11 Jan 2026 09:51:49 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vezbO-00000000Cai-2yxL;
	Sun, 11 Jan 2026 17:51:46 +0000
Date: Mon, 12 Jan 2026 01:50:49 +0800
From: kernel test robot <lkp@intel.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: oe-kbuild-all@lists.linux.dev,
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
Message-ID: <202601120122.xSlEJ1AJ-lkp@intel.com>
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
config: arc-randconfig-002-20260112 (https://download.01.org/0day-ci/archive/20260112/202601120122.xSlEJ1AJ-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260112/202601120122.xSlEJ1AJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601120122.xSlEJ1AJ-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/asm-generic/bug.h:31,
                    from arch/arc/include/asm/bug.h:30,
                    from include/linux/bug.h:5,
                    from include/linux/slab.h:15,
                    from kernel/fork.c:16:
   kernel/fork.c: In function 'check_mm':
>> include/linux/kern_levels.h:5:18: warning: format '%ld' expects argument of type 'long int', but argument 4 has type 'int' [-Wformat=]
    #define KERN_SOH "\001"  /* ASCII Start Of Header */
                     ^~~~~~
   include/linux/printk.h:483:11: note: in definition of macro 'printk_index_wrap'
      _p_func(_fmt, ##__VA_ARGS__);    \
              ^~~~
   include/linux/printk.h:534:2: note: in expansion of macro 'printk'
     printk(KERN_ALERT pr_fmt(fmt), ##__VA_ARGS__)
     ^~~~~~
   include/linux/kern_levels.h:9:20: note: in expansion of macro 'KERN_SOH'
    #define KERN_ALERT KERN_SOH "1" /* action must be taken immediately */
                       ^~~~~~~~
   include/linux/printk.h:534:9: note: in expansion of macro 'KERN_ALERT'
     printk(KERN_ALERT pr_fmt(fmt), ##__VA_ARGS__)
            ^~~~~~~~~~
   kernel/fork.c:635:4: note: in expansion of macro 'pr_alert'
       pr_alert("BUG: Bad rss-counter state mm:%p type:%s val:%ld Comm:%s Pid:%d\n",
       ^~~~~~~~
   kernel/fork.c:635:61: note: format string is defined here
       pr_alert("BUG: Bad rss-counter state mm:%p type:%s val:%ld Comm:%s Pid:%d\n",
                                                              ~~^
                                                              %d


vim +5 include/linux/kern_levels.h

314ba3520e513a Joe Perches 2012-07-30  4  
04d2c8c83d0e3a Joe Perches 2012-07-30 @5  #define KERN_SOH	"\001"		/* ASCII Start Of Header */
04d2c8c83d0e3a Joe Perches 2012-07-30  6  #define KERN_SOH_ASCII	'\001'
04d2c8c83d0e3a Joe Perches 2012-07-30  7  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
