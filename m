Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3BF350D6D;
	Sun, 11 Jan 2026 18:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768156621; cv=none; b=c4p4/cTlIosMZkgJHqhuBf+mKk1MnWOnUjDEat2gcHQMrIYRDHHhaxtcpLGG2pUbIk3oGZWT9gIhFGbIQ58Aw0Qj5Czb7rRPG0SSzGKf+d2eKC0gz/4LCS7DFG8gVtGr52Mc40mfP02AWSWGxfky3r7YYFGxBuOypX6NLGlXmaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768156621; c=relaxed/simple;
	bh=/w6ZMO8WXEMmm7vJ/Otra44ARG2F23kE81QbIE4Nn2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uRKxJZQqrEl+B4JqFhTnp/YGFhiDVQ9ADVLvkDFSLrXje9OFgg+0HTvnm1u6wY7ZO6Gz48IRN7ah0G8vr8WA1WjfRV31n4XG+L4gdOSHqYFSDfmQJfySGwbJXc9LMjUVUsB0ld9n7Th4cA92MU6ioaqF4XO6EklNkSDiVMi0X6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QZJtDREC; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QZJtDREC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768156620; x=1799692620;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/w6ZMO8WXEMmm7vJ/Otra44ARG2F23kE81QbIE4Nn2Y=;
  b=QZJtDRECRyxKsazIJosRfSMGRYc3hJxj7vLluCg9PzzybCGMWU9YTLXV
   KtlolX1ygSozRIS5wZrdLgJrqMuo0jk7wkjwIk4RetgsWfNTatcsKCG9s
   n43pYGiIEiUfignRYS9c0vW0QS87vn1QOLYC9LF4OYAP9o1C7XIBZLv5Q
   Kfoocj4z/hk9Cc7eC+N/tdoPkDcMJXLmw0orvXWP95XVdEVB/mh6baDsn
   M9YZbI4V5kPBSgKgmW02X0gBjWQ1MH5SkTCGIxv8rES5HZd6kD7Zb+Zd8
   V0ak1zTWGRnei6U1QHPhRbJIeJlOufhPcujfWFe+/+MEAs7yn21xJPFCh
   w==;
X-CSE-ConnectionGUID: g0I/I9PMQViL67Gq8/Nw+w==
X-CSE-MsgGUID: M6bbg0vWRACQ31W6BdaYOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="94922858"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="94922858"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 10:36:59 -0800
X-CSE-ConnectionGUID: k1tkRtkqTVqG2qXf9nkLZQ==
X-CSE-MsgGUID: DJg8LxEbT2KC/3DQ+cF+3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="208402498"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 11 Jan 2026 10:36:52 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vf0Iz-00000000CcG-3Izs;
	Sun, 11 Jan 2026 18:36:49 +0000
Date: Mon, 12 Jan 2026 02:36:32 +0800
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
Subject: Re: [PATCH v12 1/3] lib: Introduce hierarchical per-cpu counters
Message-ID: <202601120245.v2Trbgck-lkp@intel.com>
References: <20260111150249.1222944-2-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260111150249.1222944-2-mathieu.desnoyers@efficios.com>

Hi Mathieu,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20260109]
[cannot apply to akpm-mm/mm-everything kees/for-next/execve tip/sched/core linus/master v6.19-rc4 v6.19-rc3 v6.19-rc2 v6.19-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mathieu-Desnoyers/lib-Introduce-hierarchical-per-cpu-counters/20260111-231206
base:   next-20260109
patch link:    https://lore.kernel.org/r/20260111150249.1222944-2-mathieu.desnoyers%40efficios.com
patch subject: [PATCH v12 1/3] lib: Introduce hierarchical per-cpu counters
config: x86_64-randconfig-161-20260112 (https://download.01.org/0day-ci/archive/20260112/202601120245.v2Trbgck-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
smatch version: v0.5.0-8985-g2614ff1a
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260112/202601120245.v2Trbgck-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601120245.v2Trbgck-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from init/main.c:107:
>> include/linux/percpu_counter_tree.h:230:13: error: incompatible pointer types passing 'atomic_long_t *' (aka 'atomic64_t *') to parameter of type 'atomic_t *' [-Werror,-Wincompatible-pointer-types]
     230 |         atomic_set(&counter->count, v);
         |                    ^~~~~~~~~~~~~~~
   include/linux/atomic/atomic-instrumented.h:65:22: note: passing argument to parameter 'v' here
      65 | atomic_set(atomic_t *v, int i)
         |                      ^
   1 error generated.


vim +230 include/linux/percpu_counter_tree.h

   226	
   227	static inline
   228	void percpu_counter_tree_set(struct percpu_counter_tree *counter, long v)
   229	{
 > 230		atomic_set(&counter->count, v);
   231	}
   232	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
