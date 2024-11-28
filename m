Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C432714C59B;
	Thu, 28 Nov 2024 08:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732783418; cv=none; b=kzX/+zl3sRAXjwwgj3XypD/Bskh0O1S6qp3Tsmh+QAHueBC7lcWcfTwn5F0mPr7AIL0K8ggEtAE6O5yHPjnHV3t/srM+tYSoRGrtqHnBFcnUauweq2EvalUtsCWjo0PlBuF0vfdQfUNpUMcXbbDhDmav2SU3aYY4ubqz884G3K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732783418; c=relaxed/simple;
	bh=ulk0lZq8nHfFng3q6rfFKuN3jfHr4YUxzS7NVrZA34U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MTfGQYX9ucuMn8N8zDS7xGXRGRXFHE0YFYAmyo7yPuyCV2fy3NYhjLgsxH5Bf/b+0cCB/Nv7xKlQTiQj3kS+WrducSd408+ylmpYeGrSuprz+Xj+MPl9McyyAmXIxF/YGUXndGm4zP+rcaM1K2ubLnfUIXrggGLzFLBmiDi2pFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xp7//pJW; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xp7//pJW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732783417; x=1764319417;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ulk0lZq8nHfFng3q6rfFKuN3jfHr4YUxzS7NVrZA34U=;
  b=Xp7//pJWyWkDfpIo7QvxopxIKhTIwtetM/oCeYbZ8os6hhZK3zN3Lc9x
   vMfJdddie1PXC16TFQ/QCZf6gJQ8L0JjuRaP41WFf1Zob2f0/8VRIvpdk
   V/WxIDIXBoWzdA2rYq20zpmS+JRsHa2T/71pAE3l9Rm7xHdnbR8xWK+1T
   gyFplJDhUEPwfiM547FV8zUn6RFlvjVcbbYdOkMFF0xL7sdFqKNfIF/4i
   rlPOoc46RWf/eSTy8vAiMZZ/xwbBTBmOESus9RdAb4aLw+54nGRHzhw00
   TJx9//T2mlWkLUJQmie50T2DvV7GiaTIf4CqZj04SFngm3CIspSiUb9jb
   w==;
X-CSE-ConnectionGUID: EezlzC6EQ0Kuob3hqeBVaw==
X-CSE-MsgGUID: gZVDC0McSBS7yBuVj3gHqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11269"; a="43621319"
X-IronPort-AV: E=Sophos;i="6.12,192,1728975600"; 
   d="scan'208";a="43621319"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2024 00:43:32 -0800
X-CSE-ConnectionGUID: DU+78fxVTv+KspEbwt8ftg==
X-CSE-MsgGUID: wVU9ekrfQPeqYsQMX5I6sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,191,1728975600"; 
   d="scan'208";a="91990561"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 28 Nov 2024 00:43:29 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tGa7S-0009MF-2N;
	Thu, 28 Nov 2024 08:43:26 +0000
Date: Thu, 28 Nov 2024 16:42:47 +0800
From: kernel test robot <lkp@intel.com>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Naveen N Rao <naveen@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] tracing/dynevent: Adopt guard() and scoped_guard()
Message-ID: <202411281612.F29skJjy-lkp@intel.com>
References: <173262943230.8323.4595317585229847937.stgit@devnote2>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173262943230.8323.4595317585229847937.stgit@devnote2>

Hi Masami,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.12 next-20241128]
[cannot apply to rostedt-trace/for-next rostedt-trace/for-next-urgent]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Masami-Hiramatsu-Google/tracing-eprobe-Fix-to-release-eprobe-when-failed-to-add-dyn_event/20241128-100853
base:   linus/master
patch link:    https://lore.kernel.org/r/173262943230.8323.4595317585229847937.stgit%40devnote2
patch subject: [PATCH 6/6] tracing/dynevent: Adopt guard() and scoped_guard()
config: arm-randconfig-001-20241128 (https://download.01.org/0day-ci/archive/20241128/202411281612.F29skJjy-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241128/202411281612.F29skJjy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411281612.F29skJjy-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/trace/trace_dynevent.c:11:
   In file included from include/linux/mm.h:2223:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> kernel/trace/trace_dynevent.c:105:3: error: cannot jump from this goto statement to its label
     105 |                 goto out;
         |                 ^
   kernel/trace/trace_dynevent.c:108:2: note: jump bypasses initialization of variable with __attribute__((cleanup))
     108 |         guard(mutex)(&event_mutex);
         |         ^
   include/linux/cleanup.h:315:15: note: expanded from macro 'guard'
     315 |         CLASS(_name, __UNIQUE_ID(guard))
         |                      ^
   include/linux/compiler.h:189:29: note: expanded from macro '__UNIQUE_ID'
     189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                             ^
   include/linux/compiler_types.h:84:22: note: expanded from macro '__PASTE'
      84 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^
   include/linux/compiler_types.h:83:23: note: expanded from macro '___PASTE'
      83 | #define ___PASTE(a,b) a##b
         |                       ^
   <scratch space>:162:1: note: expanded from here
     162 | __UNIQUE_ID_guard315
         | ^
   kernel/trace/trace_dynevent.c:92:4: error: cannot jump from this goto statement to its label
      92 |                         goto out;
         |                         ^
   kernel/trace/trace_dynevent.c:108:2: note: jump bypasses initialization of variable with __attribute__((cleanup))
     108 |         guard(mutex)(&event_mutex);
         |         ^
   include/linux/cleanup.h:315:15: note: expanded from macro 'guard'
     315 |         CLASS(_name, __UNIQUE_ID(guard))
         |                      ^
   include/linux/compiler.h:189:29: note: expanded from macro '__UNIQUE_ID'
     189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                             ^
   include/linux/compiler_types.h:84:22: note: expanded from macro '__PASTE'
      84 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^
   include/linux/compiler_types.h:83:23: note: expanded from macro '___PASTE'
      83 | #define ___PASTE(a,b) a##b
         |                       ^
   <scratch space>:162:1: note: expanded from here
     162 | __UNIQUE_ID_guard315
         | ^
   kernel/trace/trace_dynevent.c:85:4: error: cannot jump from this goto statement to its label
      85 |                         goto out;
         |                         ^
   kernel/trace/trace_dynevent.c:108:2: note: jump bypasses initialization of variable with __attribute__((cleanup))
     108 |         guard(mutex)(&event_mutex);
         |         ^
   include/linux/cleanup.h:315:15: note: expanded from macro 'guard'
     315 |         CLASS(_name, __UNIQUE_ID(guard))
         |                      ^
   include/linux/compiler.h:189:29: note: expanded from macro '__UNIQUE_ID'
     189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                             ^
   include/linux/compiler_types.h:84:22: note: expanded from macro '__PASTE'
      84 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^
   include/linux/compiler_types.h:83:23: note: expanded from macro '___PASTE'
      83 | #define ___PASTE(a,b) a##b
         |                       ^
   <scratch space>:162:1: note: expanded from here
     162 | __UNIQUE_ID_guard315
         | ^
   1 warning and 3 errors generated.


vim +105 kernel/trace/trace_dynevent.c

5448d44c38557f Masami Hiramatsu          2018-11-05  @11  #include <linux/mm.h>
5448d44c38557f Masami Hiramatsu          2018-11-05   12  #include <linux/mutex.h>
5448d44c38557f Masami Hiramatsu          2018-11-05   13  #include <linux/tracefs.h>
5448d44c38557f Masami Hiramatsu          2018-11-05   14  
5448d44c38557f Masami Hiramatsu          2018-11-05   15  #include "trace.h"
1d18538e6a0926 Steven Rostedt (VMware    2021-08-16   16) #include "trace_output.h"	/* for trace_event_sem */
5448d44c38557f Masami Hiramatsu          2018-11-05   17  #include "trace_dynevent.h"
5448d44c38557f Masami Hiramatsu          2018-11-05   18  
5448d44c38557f Masami Hiramatsu          2018-11-05   19  static DEFINE_MUTEX(dyn_event_ops_mutex);
5448d44c38557f Masami Hiramatsu          2018-11-05   20  static LIST_HEAD(dyn_event_ops_list);
5448d44c38557f Masami Hiramatsu          2018-11-05   21  
1d18538e6a0926 Steven Rostedt (VMware    2021-08-16   22) bool trace_event_dyn_try_get_ref(struct trace_event_call *dyn_call)
1d18538e6a0926 Steven Rostedt (VMware    2021-08-16   23) {
1d18538e6a0926 Steven Rostedt (VMware    2021-08-16   24) 	struct trace_event_call *call;
1d18538e6a0926 Steven Rostedt (VMware    2021-08-16   25) 	bool ret = false;
1d18538e6a0926 Steven Rostedt (VMware    2021-08-16   26) 
1d18538e6a0926 Steven Rostedt (VMware    2021-08-16   27) 	if (WARN_ON_ONCE(!(dyn_call->flags & TRACE_EVENT_FL_DYNAMIC)))
1d18538e6a0926 Steven Rostedt (VMware    2021-08-16   28) 		return false;
1d18538e6a0926 Steven Rostedt (VMware    2021-08-16   29) 
1d18538e6a0926 Steven Rostedt (VMware    2021-08-16   30) 	down_read(&trace_event_sem);
1d18538e6a0926 Steven Rostedt (VMware    2021-08-16   31) 	list_for_each_entry(call, &ftrace_events, list) {
1d18538e6a0926 Steven Rostedt (VMware    2021-08-16   32) 		if (call == dyn_call) {
1d18538e6a0926 Steven Rostedt (VMware    2021-08-16   33) 			atomic_inc(&dyn_call->refcnt);
1d18538e6a0926 Steven Rostedt (VMware    2021-08-16   34) 			ret = true;
1d18538e6a0926 Steven Rostedt (VMware    2021-08-16   35) 		}
1d18538e6a0926 Steven Rostedt (VMware    2021-08-16   36) 	}
1d18538e6a0926 Steven Rostedt (VMware    2021-08-16   37) 	up_read(&trace_event_sem);
1d18538e6a0926 Steven Rostedt (VMware    2021-08-16   38) 	return ret;
1d18538e6a0926 Steven Rostedt (VMware    2021-08-16   39) }
1d18538e6a0926 Steven Rostedt (VMware    2021-08-16   40) 
1d18538e6a0926 Steven Rostedt (VMware    2021-08-16   41) void trace_event_dyn_put_ref(struct trace_event_call *call)
1d18538e6a0926 Steven Rostedt (VMware    2021-08-16   42) {
1d18538e6a0926 Steven Rostedt (VMware    2021-08-16   43) 	if (WARN_ON_ONCE(!(call->flags & TRACE_EVENT_FL_DYNAMIC)))
1d18538e6a0926 Steven Rostedt (VMware    2021-08-16   44) 		return;
1d18538e6a0926 Steven Rostedt (VMware    2021-08-16   45) 
1d18538e6a0926 Steven Rostedt (VMware    2021-08-16   46) 	if (WARN_ON_ONCE(atomic_read(&call->refcnt) <= 0)) {
1d18538e6a0926 Steven Rostedt (VMware    2021-08-16   47) 		atomic_set(&call->refcnt, 0);
1d18538e6a0926 Steven Rostedt (VMware    2021-08-16   48) 		return;
1d18538e6a0926 Steven Rostedt (VMware    2021-08-16   49) 	}
1d18538e6a0926 Steven Rostedt (VMware    2021-08-16   50) 
1d18538e6a0926 Steven Rostedt (VMware    2021-08-16   51) 	atomic_dec(&call->refcnt);
1d18538e6a0926 Steven Rostedt (VMware    2021-08-16   52) }
1d18538e6a0926 Steven Rostedt (VMware    2021-08-16   53) 
1d18538e6a0926 Steven Rostedt (VMware    2021-08-16   54) bool trace_event_dyn_busy(struct trace_event_call *call)
1d18538e6a0926 Steven Rostedt (VMware    2021-08-16   55) {
1d18538e6a0926 Steven Rostedt (VMware    2021-08-16   56) 	return atomic_read(&call->refcnt) != 0;
1d18538e6a0926 Steven Rostedt (VMware    2021-08-16   57) }
1d18538e6a0926 Steven Rostedt (VMware    2021-08-16   58) 
5448d44c38557f Masami Hiramatsu          2018-11-05   59  int dyn_event_register(struct dyn_event_operations *ops)
5448d44c38557f Masami Hiramatsu          2018-11-05   60  {
5448d44c38557f Masami Hiramatsu          2018-11-05   61  	if (!ops || !ops->create || !ops->show || !ops->is_busy ||
5448d44c38557f Masami Hiramatsu          2018-11-05   62  	    !ops->free || !ops->match)
5448d44c38557f Masami Hiramatsu          2018-11-05   63  		return -EINVAL;
5448d44c38557f Masami Hiramatsu          2018-11-05   64  
5448d44c38557f Masami Hiramatsu          2018-11-05   65  	INIT_LIST_HEAD(&ops->list);
79cc5c1710963f Masami Hiramatsu (Google  2024-11-26   66) 	guard(mutex)(&dyn_event_ops_mutex);
5448d44c38557f Masami Hiramatsu          2018-11-05   67  	list_add_tail(&ops->list, &dyn_event_ops_list);
5448d44c38557f Masami Hiramatsu          2018-11-05   68  	return 0;
5448d44c38557f Masami Hiramatsu          2018-11-05   69  }
5448d44c38557f Masami Hiramatsu          2018-11-05   70  
d262271d04830e Masami Hiramatsu          2021-02-01   71  int dyn_event_release(const char *raw_command, struct dyn_event_operations *type)
5448d44c38557f Masami Hiramatsu          2018-11-05   72  {
5448d44c38557f Masami Hiramatsu          2018-11-05   73  	struct dyn_event *pos, *n;
5448d44c38557f Masami Hiramatsu          2018-11-05   74  	char *system = NULL, *event, *p;
d262271d04830e Masami Hiramatsu          2021-02-01   75  	int argc, ret = -ENOENT;
d262271d04830e Masami Hiramatsu          2021-02-01   76  	char **argv;
d262271d04830e Masami Hiramatsu          2021-02-01   77  
d262271d04830e Masami Hiramatsu          2021-02-01   78  	argv = argv_split(GFP_KERNEL, raw_command, &argc);
d262271d04830e Masami Hiramatsu          2021-02-01   79  	if (!argv)
d262271d04830e Masami Hiramatsu          2021-02-01   80  		return -ENOMEM;
5448d44c38557f Masami Hiramatsu          2018-11-05   81  
1ce25e9f6fff76 Masami Hiramatsu          2018-11-05   82  	if (argv[0][0] == '-') {
d262271d04830e Masami Hiramatsu          2021-02-01   83  		if (argv[0][1] != ':') {
d262271d04830e Masami Hiramatsu          2021-02-01   84  			ret = -EINVAL;
d262271d04830e Masami Hiramatsu          2021-02-01   85  			goto out;
d262271d04830e Masami Hiramatsu          2021-02-01   86  		}
5448d44c38557f Masami Hiramatsu          2018-11-05   87  		event = &argv[0][2];
1ce25e9f6fff76 Masami Hiramatsu          2018-11-05   88  	} else {
1ce25e9f6fff76 Masami Hiramatsu          2018-11-05   89  		event = strchr(argv[0], ':');
d262271d04830e Masami Hiramatsu          2021-02-01   90  		if (!event) {
d262271d04830e Masami Hiramatsu          2021-02-01   91  			ret = -EINVAL;
d262271d04830e Masami Hiramatsu          2021-02-01   92  			goto out;
d262271d04830e Masami Hiramatsu          2021-02-01   93  		}
1ce25e9f6fff76 Masami Hiramatsu          2018-11-05   94  		event++;
1ce25e9f6fff76 Masami Hiramatsu          2018-11-05   95  	}
1ce25e9f6fff76 Masami Hiramatsu          2018-11-05   96  
5448d44c38557f Masami Hiramatsu          2018-11-05   97  	p = strchr(event, '/');
5448d44c38557f Masami Hiramatsu          2018-11-05   98  	if (p) {
5448d44c38557f Masami Hiramatsu          2018-11-05   99  		system = event;
5448d44c38557f Masami Hiramatsu          2018-11-05  100  		event = p + 1;
5448d44c38557f Masami Hiramatsu          2018-11-05  101  		*p = '\0';
5448d44c38557f Masami Hiramatsu          2018-11-05  102  	}
95c104c378dc7d Linyu Yuan                2022-06-27  103  	if (!system && event[0] == '\0') {
8db403b9631331 Christophe JAILLET        2021-04-11  104  		ret = -EINVAL;
8db403b9631331 Christophe JAILLET        2021-04-11 @105  		goto out;
8db403b9631331 Christophe JAILLET        2021-04-11  106  	}
5448d44c38557f Masami Hiramatsu          2018-11-05  107  
79cc5c1710963f Masami Hiramatsu (Google  2024-11-26  108) 	guard(mutex)(&event_mutex);
5448d44c38557f Masami Hiramatsu          2018-11-05  109  	for_each_dyn_event_safe(pos, n) {
5448d44c38557f Masami Hiramatsu          2018-11-05  110  		if (type && type != pos->ops)
5448d44c38557f Masami Hiramatsu          2018-11-05  111  			continue;
30199137c899d7 Masami Hiramatsu          2019-06-20  112  		if (!pos->ops->match(system, event,
d262271d04830e Masami Hiramatsu          2021-02-01  113  				argc - 1, (const char **)argv + 1, pos))
cb8e7a8d55e052 Masami Hiramatsu          2019-06-20  114  			continue;
cb8e7a8d55e052 Masami Hiramatsu          2019-06-20  115  
5448d44c38557f Masami Hiramatsu          2018-11-05  116  		ret = pos->ops->free(pos);
cb8e7a8d55e052 Masami Hiramatsu          2019-06-20  117  		if (ret)
5448d44c38557f Masami Hiramatsu          2018-11-05  118  			break;
5448d44c38557f Masami Hiramatsu          2018-11-05  119  	}
4313e5a613049d Steven Rostedt (Google    2022-11-23  120) 	tracing_reset_all_online_cpus();
d262271d04830e Masami Hiramatsu          2021-02-01  121  out:
d262271d04830e Masami Hiramatsu          2021-02-01  122  	argv_free(argv);
5448d44c38557f Masami Hiramatsu          2018-11-05  123  	return ret;
5448d44c38557f Masami Hiramatsu          2018-11-05  124  }
5448d44c38557f Masami Hiramatsu          2018-11-05  125  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
