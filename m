Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC8735AC1C;
	Mon, 12 Oct 2026 09:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791797298; cv=none; b=gkLeQYbNy1ecVEMABf9px7jiLsEDfDiqltRAy7kyHqLi+4RZS8w8/E+WPTsvt8oulTAcGixS3P2S6/he0++J8jLH67XVa6nS2Uj6RqpXGDhsi3OuMg9YCkIBgpfV72VGpwh3FATN6q6Qm1XhWK5FsqdmOtQJUu04Pr31ASRQZIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791797298; c=relaxed/simple;
	bh=6vknGO57G4Pl+QxkWddTfx/B0Cm1I5BM82EUp4W/exo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s+yPsudud8F5YFmTyLreyUvb8dI+dG78829SQonXLbWRr7zFwkUtOZnlh/d0wVibVpFNRVXHUSSZHocZxtrH+5TfsWxxgUrBJVvHqeP1fkngLM2okMjuJAwMuQ2KvoEKoFQ6d3/c/8V2/PzTBbP0+11MTWDUs3z6woCrtYOSKNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N0zGhQKg; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N0zGhQKg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791797296; x=1823333296;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6vknGO57G4Pl+QxkWddTfx/B0Cm1I5BM82EUp4W/exo=;
  b=N0zGhQKgs4xlmuAN+qbiAzuS3DC1XB/aux029JKtxkVhBgJ4yADy6Frp
   //zkRdnR2SRtgI+nzmQxLTqmUnUOgjr5VUYs5KAegfaQi3L51XHjsP2bC
   zkrJrPjFJskrhD3t0LMWSTisdEDRteV4LH3fA3WJvm76Z9gNxluO/C7oy
   u+qfurgtWIw4n9i/Evxp+3Hldajfg+WlzEuvnaVsPTQzLyODN6/+K7vS/
   AzV/0TrioyOmqBzmDukwGVMdOfPSeVDKZagERW2vLQtk0LLlS3Yo9rZ7F
   ekCY34Q9tQCMlIaCKXC+fSt9XsqvJM+5swtXhnAUgOpTxTMgQUyyudytE
   g==;
X-CSE-ConnectionGUID: W8KfnMMURc2NAOTHqzw/ow==
X-CSE-MsgGUID: KlfKnmImRDuzf288hpQT7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="598863"
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="598863"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 02:28:16 -0700
X-CSE-ConnectionGUID: KmD+OFlUQuyUtJk0GbYafg==
X-CSE-MsgGUID: /1yE7JrWQqSXkS6dS/oIdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="804553"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 12 Oct 2026 02:28:13 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xGCKI-00000000BHx-38Nr;
	Mon, 12 Oct 2026 09:28:10 +0000
Date: Mon, 12 Oct 2026 17:27:31 +0800
From: kernel test robot <lkp@intel.com>
To: wen.yang@linux.dev, Gabriele Monaco <gmonaco@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Wen Yang <wen.yang@linux.dev>
Subject: Re: [PATCH v7 03/14] rv: Add a KUnit test for the HA timer underflow
Message-ID: <202610121745.TCxIxDec-lkp@intel.com>
References: <cdaf33af866392428f1942cef4e442b1d106989c.1791745088.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdaf33af866392428f1942cef4e442b1d106989c.1791745088.git.wen.yang@linux.dev>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on trace/for-next]
[also build test ERROR on shuah-kselftest/next shuah-kselftest/fixes linus/master v7.3-rc6 next-20261009]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/wen-yang-linux-dev/rv-Force-environment-reset-action-on-HA-monitor-start/20261012-033907
base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
patch link:    https://lore.kernel.org/r/cdaf33af866392428f1942cef4e442b1d106989c.1791745088.git.wen.yang%40linux.dev
patch subject: [PATCH v7 03/14] rv: Add a KUnit test for the HA timer underflow
config: x86_64-randconfig-1005-20261012 (https://download.01.org/0day-ci/archive/20261012/202610121745.TCxIxDec-lkp@intel.com/config)
compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261012/202610121745.TCxIxDec-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610121745.TCxIxDec-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from kernel/trace/rv/rv_monitors_test.c:71:
>> include/rv/ha_monitor.h:66:16: error: no member named 'da_mon' in 'ha_monitor'
      66 | _Static_assert(offsetof(struct ha_monitor, da_mon) == 0,
         |                ^                           ~~~~~~
   include/linux/stddef.h:16:32: note: expanded from macro 'offsetof'
      16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
         |                                 ^                        ~~~~~~
   In file included from kernel/trace/rv/rv_monitors_test.c:71:
>> include/rv/ha_monitor.h:122:5: warning: 'HA_TIMER_HRTIMER' is not defined, evaluates to 0 [-Wundef]
     122 | #if HA_TIMER_TYPE == HA_TIMER_WHEEL
         |     ^
   kernel/trace/rv/rv_monitors_test.c:21:23: note: expanded from macro 'HA_TIMER_TYPE'
      21 | #define HA_TIMER_TYPE HA_TIMER_HRTIMER
         |                       ^
   In file included from kernel/trace/rv/rv_monitors_test.c:71:
   include/rv/ha_monitor.h:122:22: warning: 'HA_TIMER_WHEEL' is not defined, evaluates to 0 [-Wundef]
     122 | #if HA_TIMER_TYPE == HA_TIMER_WHEEL
         |                      ^
>> include/rv/ha_monitor.h:192:30: error: no member named 'da_mon' in 'struct ha_monitor'
     192 |         struct ha_monitor *ha_mon = to_ha_monitor(da_mon);
         |                                     ^~~~~~~~~~~~~~~~~~~~~
   include/rv/ha_monitor.h:68:63: note: expanded from macro 'to_ha_monitor'
      68 | #define to_ha_monitor(da) container_of(da, struct ha_monitor, da_mon)
         |                           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
   include/linux/container_of.h:20:56: note: expanded from macro 'container_of'
      20 |         static_assert(__same_type(*(ptr), typeof_member(type, member)) || \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~
      21 |                       __same_type(*(ptr), void),                        \
         |                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      22 |                       "pointer type mismatch in container_of()");       \
         |                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/container_of.h:8:45: note: expanded from macro 'typeof_member'
       8 | #define typeof_member(T, m)     typeof(((T*)0)->m)
         |                                                 ^
   include/linux/compiler_types.h:610:74: note: expanded from macro '__same_type'
     610 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                                                                          ^
   include/linux/build_bug.h:79:50: note: expanded from macro 'static_assert'
      79 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:80:56: note: expanded from macro '__static_assert'
      80 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   In file included from kernel/trace/rv/rv_monitors_test.c:71:
   include/rv/ha_monitor.h:192:30: error: no member named 'da_mon' in 'ha_monitor'
     192 |         struct ha_monitor *ha_mon = to_ha_monitor(da_mon);
         |                                     ^~~~~~~~~~~~~~~~~~~~~
   include/rv/ha_monitor.h:68:27: note: expanded from macro 'to_ha_monitor'
      68 | #define to_ha_monitor(da) container_of(da, struct ha_monitor, da_mon)
         |                           ^                                   ~~~~~~
   include/linux/container_of.h:23:27: note: expanded from macro 'container_of'
      23 |         (type *)((void *)(ptr) - offsetof(type, member)); })
         |                                  ^              ~~~~~~
   include/linux/stddef.h:16:32: note: expanded from macro 'offsetof'
      16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
         |                                 ^                        ~~~~~~
   In file included from kernel/trace/rv/rv_monitors_test.c:71:
>> include/rv/ha_monitor.h:192:21: error: initializing 'struct ha_monitor *' with an expression of incompatible type 'void'
     192 |         struct ha_monitor *ha_mon = to_ha_monitor(da_mon);
         |                            ^        ~~~~~~~~~~~~~~~~~~~~~
   include/rv/ha_monitor.h:208:30: error: no member named 'da_mon' in 'struct ha_monitor'
     208 |         struct ha_monitor *ha_mon = to_ha_monitor(da_mon);
         |                                     ^~~~~~~~~~~~~~~~~~~~~
   include/rv/ha_monitor.h:68:63: note: expanded from macro 'to_ha_monitor'
      68 | #define to_ha_monitor(da) container_of(da, struct ha_monitor, da_mon)
         |                           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
   include/linux/container_of.h:20:56: note: expanded from macro 'container_of'
      20 |         static_assert(__same_type(*(ptr), typeof_member(type, member)) || \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~
      21 |                       __same_type(*(ptr), void),                        \
         |                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      22 |                       "pointer type mismatch in container_of()");       \
         |                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/container_of.h:8:45: note: expanded from macro 'typeof_member'
       8 | #define typeof_member(T, m)     typeof(((T*)0)->m)
         |                                                 ^
   include/linux/compiler_types.h:610:74: note: expanded from macro '__same_type'
     610 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                                                                          ^
   include/linux/build_bug.h:79:50: note: expanded from macro 'static_assert'
      79 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:80:56: note: expanded from macro '__static_assert'
      80 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   In file included from kernel/trace/rv/rv_monitors_test.c:71:
   include/rv/ha_monitor.h:208:30: error: no member named 'da_mon' in 'ha_monitor'
     208 |         struct ha_monitor *ha_mon = to_ha_monitor(da_mon);
         |                                     ^~~~~~~~~~~~~~~~~~~~~
   include/rv/ha_monitor.h:68:27: note: expanded from macro 'to_ha_monitor'
      68 | #define to_ha_monitor(da) container_of(da, struct ha_monitor, da_mon)
         |                           ^                                   ~~~~~~
   include/linux/container_of.h:23:27: note: expanded from macro 'container_of'
      23 |         (type *)((void *)(ptr) - offsetof(type, member)); })
         |                                  ^              ~~~~~~
   include/linux/stddef.h:16:32: note: expanded from macro 'offsetof'
      16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
         |                                 ^                        ~~~~~~
   In file included from kernel/trace/rv/rv_monitors_test.c:71:
   include/rv/ha_monitor.h:208:21: error: initializing 'struct ha_monitor *' with an expression of incompatible type 'void'
     208 |         struct ha_monitor *ha_mon = to_ha_monitor(da_mon);
         |                            ^        ~~~~~~~~~~~~~~~~~~~~~
>> include/rv/ha_monitor.h:219:27: error: no member named 'env_store' in 'struct ha_monitor'
     219 |         return READ_ONCE(ha_mon->env_store[env]) == ENV_INVALID_VALUE;
         |                          ~~~~~~  ^
>> include/rv/ha_monitor.h:219:27: error: no member named 'env_store' in 'struct ha_monitor'
     219 |         return READ_ONCE(ha_mon->env_store[env]) == ENV_INVALID_VALUE;
         |                          ~~~~~~  ^
>> include/rv/ha_monitor.h:219:27: error: no member named 'env_store' in 'struct ha_monitor'
     219 |         return READ_ONCE(ha_mon->env_store[env]) == ENV_INVALID_VALUE;
         |                          ~~~~~~  ^
>> include/rv/ha_monitor.h:219:27: error: no member named 'env_store' in 'struct ha_monitor'
     219 |         return READ_ONCE(ha_mon->env_store[env]) == ENV_INVALID_VALUE;
         |                          ~~~~~~  ^
>> include/rv/ha_monitor.h:219:27: error: no member named 'env_store' in 'struct ha_monitor'
     219 |         return READ_ONCE(ha_mon->env_store[env]) == ENV_INVALID_VALUE;
         |                          ~~~~~~  ^
>> include/rv/ha_monitor.h:219:27: error: no member named 'env_store' in 'struct ha_monitor'
     219 |         return READ_ONCE(ha_mon->env_store[env]) == ENV_INVALID_VALUE;
         |                          ~~~~~~  ^
>> include/rv/ha_monitor.h:219:27: error: no member named 'env_store' in 'struct ha_monitor'
     219 |         return READ_ONCE(ha_mon->env_store[env]) == ENV_INVALID_VALUE;
         |                          ~~~~~~  ^
   include/rv/ha_monitor.h:286:30: error: no member named 'da_mon' in 'struct ha_monitor'
     286 |         struct ha_monitor *ha_mon = to_ha_monitor(da_mon);
         |                                     ^~~~~~~~~~~~~~~~~~~~~
   include/rv/ha_monitor.h:68:63: note: expanded from macro 'to_ha_monitor'
      68 | #define to_ha_monitor(da) container_of(da, struct ha_monitor, da_mon)
         |                           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
   include/linux/container_of.h:20:56: note: expanded from macro 'container_of'
      20 |         static_assert(__same_type(*(ptr), typeof_member(type, member)) || \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~
      21 |                       __same_type(*(ptr), void),                        \
         |                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      22 |                       "pointer type mismatch in container_of()");       \
         |                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/container_of.h:8:45: note: expanded from macro 'typeof_member'
       8 | #define typeof_member(T, m)     typeof(((T*)0)->m)
         |                                                 ^
   include/linux/compiler_types.h:610:74: note: expanded from macro '__same_type'
     610 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                                                                          ^
   include/linux/build_bug.h:79:50: note: expanded from macro 'static_assert'
      79 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:80:56: note: expanded from macro '__static_assert'
      80 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   In file included from kernel/trace/rv/rv_monitors_test.c:71:
   include/rv/ha_monitor.h:286:30: error: no member named 'da_mon' in 'ha_monitor'
     286 |         struct ha_monitor *ha_mon = to_ha_monitor(da_mon);
         |                                     ^~~~~~~~~~~~~~~~~~~~~
   include/rv/ha_monitor.h:68:27: note: expanded from macro 'to_ha_monitor'
      68 | #define to_ha_monitor(da) container_of(da, struct ha_monitor, da_mon)
         |                           ^                                   ~~~~~~
   include/linux/container_of.h:23:27: note: expanded from macro 'container_of'
      23 |         (type *)((void *)(ptr) - offsetof(type, member)); })
         |                                  ^              ~~~~~~
   include/linux/stddef.h:16:32: note: expanded from macro 'offsetof'
      16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
         |                                 ^                        ~~~~~~
   In file included from kernel/trace/rv/rv_monitors_test.c:71:
   include/rv/ha_monitor.h:286:21: error: initializing 'struct ha_monitor *' with an expression of incompatible type 'void'
     286 |         struct ha_monitor *ha_mon = to_ha_monitor(da_mon);
         |                            ^        ~~~~~~~~~~~~~~~~~~~~~
   include/rv/ha_monitor.h:321:41: error: no member named 'da_mon' in 'struct ha_monitor'
     321 |         curr_state = smp_load_acquire(&ha_mon->da_mon.curr_state);
         |                                        ~~~~~~  ^
   include/rv/ha_monitor.h:321:41: error: no member named 'da_mon' in 'struct ha_monitor'
     321 |         curr_state = smp_load_acquire(&ha_mon->da_mon.curr_state);
         |                                        ~~~~~~  ^
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   2 warnings and 20 errors generated.


vim +66 include/rv/ha_monitor.h

f5587d1b6ec938 Gabriele Monaco 2026-03-30   64  
f5587d1b6ec938 Gabriele Monaco 2026-03-30   65  /* This simplifies things since da_mon and ha_mon coexist in the same union */
f5587d1b6ec938 Gabriele Monaco 2026-03-30  @66  _Static_assert(offsetof(struct ha_monitor, da_mon) == 0,
f5587d1b6ec938 Gabriele Monaco 2026-03-30   67  	       "da_mon must be the first element in an ha_mon!");
f5587d1b6ec938 Gabriele Monaco 2026-03-30   68  #define to_ha_monitor(da) container_of(da, struct ha_monitor, da_mon)
f5587d1b6ec938 Gabriele Monaco 2026-03-30   69  
f5587d1b6ec938 Gabriele Monaco 2026-03-30   70  #define ENV_MAX CONCATENATE(env_max_, MONITOR_NAME)
f5587d1b6ec938 Gabriele Monaco 2026-03-30   71  #define ENV_MAX_STORED CONCATENATE(env_max_stored_, MONITOR_NAME)
f5587d1b6ec938 Gabriele Monaco 2026-03-30   72  #define envs CONCATENATE(envs_, MONITOR_NAME)
f5587d1b6ec938 Gabriele Monaco 2026-03-30   73  
f5587d1b6ec938 Gabriele Monaco 2026-03-30   74  /* Environment storage before being reset */
f5587d1b6ec938 Gabriele Monaco 2026-03-30   75  #define ENV_INVALID_VALUE U64_MAX
f5587d1b6ec938 Gabriele Monaco 2026-03-30   76  /* Error with no event occurs only on timeouts */
f5587d1b6ec938 Gabriele Monaco 2026-03-30   77  #define EVENT_NONE EVENT_MAX
f5587d1b6ec938 Gabriele Monaco 2026-03-30   78  #define EVENT_NONE_LBL "none"
f5587d1b6ec938 Gabriele Monaco 2026-03-30   79  #define ENV_BUFFER_SIZE 64
f5587d1b6ec938 Gabriele Monaco 2026-03-30   80  
f5587d1b6ec938 Gabriele Monaco 2026-03-30   81  #ifdef CONFIG_RV_REACTORS
f5587d1b6ec938 Gabriele Monaco 2026-03-30   82  
f5587d1b6ec938 Gabriele Monaco 2026-03-30   83  /*
f5587d1b6ec938 Gabriele Monaco 2026-03-30   84   * ha_react - trigger the reaction after a failed environment constraint
f5587d1b6ec938 Gabriele Monaco 2026-03-30   85   *
f5587d1b6ec938 Gabriele Monaco 2026-03-30   86   * The transition from curr_state with event is otherwise valid, but the
f5587d1b6ec938 Gabriele Monaco 2026-03-30   87   * environment constraint is false. This function can be called also with no
f5587d1b6ec938 Gabriele Monaco 2026-03-30   88   * event from a timer (state constraints only).
f5587d1b6ec938 Gabriele Monaco 2026-03-30   89   */
f5587d1b6ec938 Gabriele Monaco 2026-03-30   90  static void ha_react(enum states curr_state, enum events event, char *env)
f5587d1b6ec938 Gabriele Monaco 2026-03-30   91  {
f5587d1b6ec938 Gabriele Monaco 2026-03-30   92  	rv_react(&rv_this,
f5587d1b6ec938 Gabriele Monaco 2026-03-30   93  		 "rv: monitor %s does not allow event %s on state %s with env %s\n",
f5587d1b6ec938 Gabriele Monaco 2026-03-30   94  		 __stringify(MONITOR_NAME),
f5587d1b6ec938 Gabriele Monaco 2026-03-30   95  		 event == EVENT_NONE ? EVENT_NONE_LBL : model_get_event_name(event),
f5587d1b6ec938 Gabriele Monaco 2026-03-30   96  		 model_get_state_name(curr_state), env);
f5587d1b6ec938 Gabriele Monaco 2026-03-30   97  }
f5587d1b6ec938 Gabriele Monaco 2026-03-30   98  
f5587d1b6ec938 Gabriele Monaco 2026-03-30   99  #else /* CONFIG_RV_REACTOR */
f5587d1b6ec938 Gabriele Monaco 2026-03-30  100  
f5587d1b6ec938 Gabriele Monaco 2026-03-30  101  static void ha_react(enum states curr_state, enum events event, char *env) { }
f5587d1b6ec938 Gabriele Monaco 2026-03-30  102  #endif
f5587d1b6ec938 Gabriele Monaco 2026-03-30  103  
f5587d1b6ec938 Gabriele Monaco 2026-03-30  104  /*
f5587d1b6ec938 Gabriele Monaco 2026-03-30  105   * model_get_state_name - return the (string) name of the given state
f5587d1b6ec938 Gabriele Monaco 2026-03-30  106   */
f5587d1b6ec938 Gabriele Monaco 2026-03-30  107  static char *model_get_env_name(enum envs env)
f5587d1b6ec938 Gabriele Monaco 2026-03-30  108  {
f5587d1b6ec938 Gabriele Monaco 2026-03-30  109  	if ((env < 0) || (env >= ENV_MAX))
f5587d1b6ec938 Gabriele Monaco 2026-03-30  110  		return "INVALID";
f5587d1b6ec938 Gabriele Monaco 2026-03-30  111  
f5587d1b6ec938 Gabriele Monaco 2026-03-30  112  	return RV_AUTOMATON_NAME.env_names[env];
f5587d1b6ec938 Gabriele Monaco 2026-03-30  113  }
f5587d1b6ec938 Gabriele Monaco 2026-03-30  114  
f5587d1b6ec938 Gabriele Monaco 2026-03-30  115  /*
f5587d1b6ec938 Gabriele Monaco 2026-03-30  116   * Monitors requiring a timer implementation need to request it explicitly.
f5587d1b6ec938 Gabriele Monaco 2026-03-30  117   */
f5587d1b6ec938 Gabriele Monaco 2026-03-30  118  #ifndef HA_TIMER_TYPE
f5587d1b6ec938 Gabriele Monaco 2026-03-30  119  #define HA_TIMER_TYPE HA_TIMER_NONE
f5587d1b6ec938 Gabriele Monaco 2026-03-30  120  #endif
f5587d1b6ec938 Gabriele Monaco 2026-03-30  121  
f5587d1b6ec938 Gabriele Monaco 2026-03-30 @122  #if HA_TIMER_TYPE == HA_TIMER_WHEEL
f5587d1b6ec938 Gabriele Monaco 2026-03-30  123  static void ha_monitor_timer_callback(struct timer_list *timer);
f5587d1b6ec938 Gabriele Monaco 2026-03-30  124  #elif HA_TIMER_TYPE == HA_TIMER_HRTIMER
f5587d1b6ec938 Gabriele Monaco 2026-03-30  125  static enum hrtimer_restart ha_monitor_timer_callback(struct hrtimer *hrtimer);
f5587d1b6ec938 Gabriele Monaco 2026-03-30  126  #endif
f5587d1b6ec938 Gabriele Monaco 2026-03-30  127  
f5587d1b6ec938 Gabriele Monaco 2026-03-30  128  /*
f5587d1b6ec938 Gabriele Monaco 2026-03-30  129   * ktime_get_ns is expensive, since we usually don't require precise accounting
f5587d1b6ec938 Gabriele Monaco 2026-03-30  130   * of changes within the same event, cache the current time at the beginning of
f5587d1b6ec938 Gabriele Monaco 2026-03-30  131   * the constraint handler and use the cache for subsequent calls.
f5587d1b6ec938 Gabriele Monaco 2026-03-30  132   * Monitors without ns clocks automatically skip this.
f5587d1b6ec938 Gabriele Monaco 2026-03-30  133   */
f5587d1b6ec938 Gabriele Monaco 2026-03-30  134  #ifdef HA_CLK_NS
f5587d1b6ec938 Gabriele Monaco 2026-03-30  135  #define ha_get_ns() ktime_get_ns()
f5587d1b6ec938 Gabriele Monaco 2026-03-30  136  #else
f5587d1b6ec938 Gabriele Monaco 2026-03-30  137  #define ha_get_ns() 0
f5587d1b6ec938 Gabriele Monaco 2026-03-30  138  #endif /* HA_CLK_NS */
f5587d1b6ec938 Gabriele Monaco 2026-03-30  139  
74e17bd6fc8ed7 Gabriele Monaco 2026-06-01  140  static bool ha_mon_destroying;
74e17bd6fc8ed7 Gabriele Monaco 2026-06-01  141  
700782ec8f6589 Gabriele Monaco 2026-06-01  142  static int ha_monitor_init(void)
700782ec8f6589 Gabriele Monaco 2026-06-01  143  {
700782ec8f6589 Gabriele Monaco 2026-06-01  144  	int ret;
700782ec8f6589 Gabriele Monaco 2026-06-01  145  
74e17bd6fc8ed7 Gabriele Monaco 2026-06-01  146  	WRITE_ONCE(ha_mon_destroying, false);
700782ec8f6589 Gabriele Monaco 2026-06-01  147  	ret = da_monitor_init();
700782ec8f6589 Gabriele Monaco 2026-06-01  148  	if (ret == 0)
700782ec8f6589 Gabriele Monaco 2026-06-01  149  		ha_monitor_enable_hook();
700782ec8f6589 Gabriele Monaco 2026-06-01  150  	return ret;
700782ec8f6589 Gabriele Monaco 2026-06-01  151  }
700782ec8f6589 Gabriele Monaco 2026-06-01  152  
700782ec8f6589 Gabriele Monaco 2026-06-01  153  static void ha_monitor_destroy(void)
700782ec8f6589 Gabriele Monaco 2026-06-01  154  {
74e17bd6fc8ed7 Gabriele Monaco 2026-06-01  155  	WRITE_ONCE(ha_mon_destroying, true);
700782ec8f6589 Gabriele Monaco 2026-06-01  156  	ha_monitor_disable_hook();
700782ec8f6589 Gabriele Monaco 2026-06-01  157  	da_monitor_destroy();
700782ec8f6589 Gabriele Monaco 2026-06-01  158  }
700782ec8f6589 Gabriele Monaco 2026-06-01  159  
f5587d1b6ec938 Gabriele Monaco 2026-03-30  160  /* Should be supplied by the monitor */
f5587d1b6ec938 Gabriele Monaco 2026-03-30  161  static u64 ha_get_env(struct ha_monitor *ha_mon, enum envs env, u64 time_ns);
a8db17cc2158f8 Gabriele Monaco 2026-10-12  162  static void ha_reset_env(struct ha_monitor *ha_mon, enum envs env, u64 time_ns);
f5587d1b6ec938 Gabriele Monaco 2026-03-30  163  static bool ha_verify_constraint(struct ha_monitor *ha_mon,
f5587d1b6ec938 Gabriele Monaco 2026-03-30  164  				 enum states curr_state,
f5587d1b6ec938 Gabriele Monaco 2026-03-30  165  				 enum events event,
f5587d1b6ec938 Gabriele Monaco 2026-03-30  166  				 enum states next_state,
f5587d1b6ec938 Gabriele Monaco 2026-03-30  167  				 u64 time_ns);
a8db17cc2158f8 Gabriele Monaco 2026-10-12  168  #ifdef HA_NO_RESET
a8db17cc2158f8 Gabriele Monaco 2026-10-12  169  static void ha_reset_env(struct ha_monitor *ha_mon, enum envs env, u64 time_ns) { }
a8db17cc2158f8 Gabriele Monaco 2026-10-12  170  #endif
f5587d1b6ec938 Gabriele Monaco 2026-03-30  171  
f5587d1b6ec938 Gabriele Monaco 2026-03-30  172  /*
f5587d1b6ec938 Gabriele Monaco 2026-03-30  173   * ha_monitor_reset_all_stored - reset all environment variables in the monitor
f5587d1b6ec938 Gabriele Monaco 2026-03-30  174   */
f5587d1b6ec938 Gabriele Monaco 2026-03-30  175  static inline void ha_monitor_reset_all_stored(struct ha_monitor *ha_mon)
f5587d1b6ec938 Gabriele Monaco 2026-03-30  176  {
a8db17cc2158f8 Gabriele Monaco 2026-10-12  177  	u64 time_ns = ha_get_ns();
a8db17cc2158f8 Gabriele Monaco 2026-10-12  178  
f5587d1b6ec938 Gabriele Monaco 2026-03-30  179  	for (int i = 0; i < ENV_MAX_STORED; i++)
a8db17cc2158f8 Gabriele Monaco 2026-10-12  180  		ha_reset_env(ha_mon, i, time_ns);
f5587d1b6ec938 Gabriele Monaco 2026-03-30  181  }
f5587d1b6ec938 Gabriele Monaco 2026-03-30  182  
f5587d1b6ec938 Gabriele Monaco 2026-03-30  183  /*
f5587d1b6ec938 Gabriele Monaco 2026-03-30  184   * ha_monitor_init_env - setup timer and reset all environment
f5587d1b6ec938 Gabriele Monaco 2026-03-30  185   *
f5587d1b6ec938 Gabriele Monaco 2026-03-30  186   * Called from a hook in the DA start functions, it supplies the da_mon
f5587d1b6ec938 Gabriele Monaco 2026-03-30  187   * corresponding to the current ha_mon.
f5587d1b6ec938 Gabriele Monaco 2026-03-30  188   * Not all hybrid automata require the timer, still set it for simplicity.
f5587d1b6ec938 Gabriele Monaco 2026-03-30  189   */
f5587d1b6ec938 Gabriele Monaco 2026-03-30  190  static inline void ha_monitor_init_env(struct da_monitor *da_mon)
f5587d1b6ec938 Gabriele Monaco 2026-03-30  191  {
f5587d1b6ec938 Gabriele Monaco 2026-03-30 @192  	struct ha_monitor *ha_mon = to_ha_monitor(da_mon);
f5587d1b6ec938 Gabriele Monaco 2026-03-30  193  
f5587d1b6ec938 Gabriele Monaco 2026-03-30  194  	ha_monitor_reset_all_stored(ha_mon);
f5587d1b6ec938 Gabriele Monaco 2026-03-30  195  	ha_setup_timer(ha_mon);
f5587d1b6ec938 Gabriele Monaco 2026-03-30  196  }
f5587d1b6ec938 Gabriele Monaco 2026-03-30  197  
f5587d1b6ec938 Gabriele Monaco 2026-03-30  198  /*
f5587d1b6ec938 Gabriele Monaco 2026-03-30  199   * ha_monitor_reset_env - stop timer and reset all environment
f5587d1b6ec938 Gabriele Monaco 2026-03-30  200   *
f5587d1b6ec938 Gabriele Monaco 2026-03-30  201   * Called from a hook in the DA reset functions, it supplies the da_mon
f5587d1b6ec938 Gabriele Monaco 2026-03-30  202   * corresponding to the current ha_mon.
f5587d1b6ec938 Gabriele Monaco 2026-03-30  203   * Not all hybrid automata require the timer, still clear it for simplicity.
713c9e1ea76238 Gabriele Monaco 2026-06-01  204   * Monitors that never started have their timer uninitialized, do not stop those.
f5587d1b6ec938 Gabriele Monaco 2026-03-30  205   */
f5587d1b6ec938 Gabriele Monaco 2026-03-30  206  static inline void ha_monitor_reset_env(struct da_monitor *da_mon)
f5587d1b6ec938 Gabriele Monaco 2026-03-30  207  {
f5587d1b6ec938 Gabriele Monaco 2026-03-30  208  	struct ha_monitor *ha_mon = to_ha_monitor(da_mon);
f5587d1b6ec938 Gabriele Monaco 2026-03-30  209  
f5587d1b6ec938 Gabriele Monaco 2026-03-30  210  	if (likely(da_monitoring(da_mon)))
f5587d1b6ec938 Gabriele Monaco 2026-03-30  211  		ha_cancel_timer(ha_mon);
f5587d1b6ec938 Gabriele Monaco 2026-03-30  212  }
f5587d1b6ec938 Gabriele Monaco 2026-03-30  213  
f5587d1b6ec938 Gabriele Monaco 2026-03-30  214  /*
f5587d1b6ec938 Gabriele Monaco 2026-03-30  215   * ha_monitor_env_invalid - return true if env has not been initialised
f5587d1b6ec938 Gabriele Monaco 2026-03-30  216   */
f5587d1b6ec938 Gabriele Monaco 2026-03-30  217  static inline bool ha_monitor_env_invalid(struct ha_monitor *ha_mon, enum envs env)
f5587d1b6ec938 Gabriele Monaco 2026-03-30  218  {
f5587d1b6ec938 Gabriele Monaco 2026-03-30 @219  	return READ_ONCE(ha_mon->env_store[env]) == ENV_INVALID_VALUE;
f5587d1b6ec938 Gabriele Monaco 2026-03-30  220  }
f5587d1b6ec938 Gabriele Monaco 2026-03-30  221  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
