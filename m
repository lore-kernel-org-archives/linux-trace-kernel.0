Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476933019CD;
	Mon, 12 Oct 2026 07:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791791283; cv=none; b=SAnG5o1KoEY0dgbaLEO70f6ar8Tx3I3+NqF6lSIPsMySPOsinB2NBz5YPPtoVamWM8V/GXPy9rwlQG5TRPnzFsvrwgjhoqJ7kFhyLcFFf5Zmy6znmZBpHACLn82TVw0t49D94PU2HtGqsXnHhXMn5mIN9Mhl2jOPHvhPceiQKW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791791283; c=relaxed/simple;
	bh=Vx6oyQ4rtYbDq0/+2r8TznJfMPRzCpVdShhhC+KMg2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ekPCCXGRAPsuVsiQ9hEeduYDf9TVCYSY+Djae5jwqHJuxgYBhcXUV0QsB/yDdI7MJPO2nzpPVtQvm45/pkmOXKCnYW+E22y0H8MVU3mKdrPDotoUEzdhxmrjW1y0yb5ip8kMPOT8ZYFxZzZNr7guRAEhOxbkJP5k+LNK7OLDq4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gv+KyELq; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gv+KyELq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791791280; x=1823327280;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Vx6oyQ4rtYbDq0/+2r8TznJfMPRzCpVdShhhC+KMg2w=;
  b=Gv+KyELqif2xY7J/GAMAw8FYyRFP6Y7EirBixvX7uxyL6WglnELd8/vZ
   cnmDHNngxJc9i3fc6UnDy8saLw9pu3ZiN8VVi9b8b2nsHwnSakfEA1y6D
   M+TH+dSM1EeHppn74eKEwno2qR6+9ySSJtJh3EgEd7bcx80OJ99iH5BG8
   7HmjYdo1A6iQpOVw4MUX7hYFhrzkCqkWl7oLZ0WmvAQ1oOsBBbD/17IS+
   dpP6TkiX9mtJqQXmXjSJxqWPtnjz6XFwtVwCbvdXseeKVkq3rOONlg/r2
   SL5egT315sjsgLIlkxXoQGx590SbMXB7g7uQtu10R0YnQ915as+S8Rouw
   Q==;
X-CSE-ConnectionGUID: l3amYoQmST+AYyGnyRCgkg==
X-CSE-MsgGUID: dhClxPyUSd+/PkBfUhDeAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="507800"
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="507800"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 00:48:00 -0700
X-CSE-ConnectionGUID: G/HfIbBjRECQ5D1PUzXlxA==
X-CSE-MsgGUID: MC/ehUvyQDqTvZxSATnq3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="937205"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 12 Oct 2026 00:47:57 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xGAlH-00000000BA9-0PSb;
	Mon, 12 Oct 2026 07:47:55 +0000
Date: Mon, 12 Oct 2026 15:47:29 +0800
From: kernel test robot <lkp@intel.com>
To: wen.yang@linux.dev, Gabriele Monaco <gmonaco@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: Re: [PATCH v7 03/14] rv: Add a KUnit test for the HA timer underflow
Message-ID: <202610121540.5HFVLTni-lkp@intel.com>
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
config: sh-randconfig-1001-20261012 (https://download.01.org/0day-ci/archive/20261012/202610121540.5HFVLTni-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261012/202610121540.5HFVLTni-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610121540.5HFVLTni-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from include/uapi/linux/posix_types.h:5,
                    from include/uapi/linux/types.h:14,
                    from include/linux/types.h:5,
                    from include/linux/kasan-checks.h:5,
                    from include/asm-generic/rwonce.h:26,
                    from ./arch/sh/include/generated/asm/rwonce.h:1,
                    from include/linux/compiler.h:369,
                    from include/linux/err.h:5,
                    from include/kunit/assert.h:12,
                    from include/kunit/test.h:12,
                    from include/rv/kunit.h:16,
                    from kernel/trace/rv/rv_monitors_test.c:10:
>> include/linux/stddef.h:16:33: error: 'struct ha_monitor' has no member named 'da_mon'
      16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
         |                                 ^~~~~~~~~~~~~~~~~~
   include/rv/ha_monitor.h:66:16: note: in expansion of macro 'offsetof'
      66 | _Static_assert(offsetof(struct ha_monitor, da_mon) == 0,
         |                ^~~~~~~~
>> include/linux/stddef.h:16:33: error: expression in static assertion is not an integer
   include/rv/ha_monitor.h:66:16: note: in expansion of macro 'offsetof'
      66 | _Static_assert(offsetof(struct ha_monitor, da_mon) == 0,
         |                ^~~~~~~~
>> kernel/trace/rv/rv_monitors_test.c:21:23: warning: 'HA_TIMER_HRTIMER' is not defined, evaluates to '0' [-Wundef]
      21 | #define HA_TIMER_TYPE HA_TIMER_HRTIMER
         |                       ^~~~~~~~~~~~~~~~
   include/rv/ha_monitor.h:122:5: note: in expansion of macro 'HA_TIMER_TYPE'
     122 | #if HA_TIMER_TYPE == HA_TIMER_WHEEL
         |     ^~~~~~~~~~~~~
   In file included from kernel/trace/rv/rv_monitors_test.c:71:
>> include/rv/ha_monitor.h:122:22: warning: 'HA_TIMER_WHEEL' is not defined, evaluates to '0' [-Wundef]
     122 | #if HA_TIMER_TYPE == HA_TIMER_WHEEL
         |                      ^~~~~~~~~~~~~~
   In file included from include/linux/init.h:5,
                    from include/linux/printk.h:6,
                    from include/kunit/assert.h:13:
   include/rv/ha_monitor.h: In function 'ha_monitor_init_env':
>> include/linux/container_of.h:8:47: error: 'struct ha_monitor' has no member named 'da_mon'
       8 | #define typeof_member(T, m)     typeof(((T*)0)->m)
         |                                               ^~
   include/linux/build_bug.h:80:56: note: in definition of macro '__static_assert'
      80 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), typeof_member(type, member)) || \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:20:23: note: in expansion of macro '__same_type'
      20 |         static_assert(__same_type(*(ptr), typeof_member(type, member)) || \
         |                       ^~~~~~~~~~~
   include/linux/container_of.h:20:43: note: in expansion of macro 'typeof_member'
      20 |         static_assert(__same_type(*(ptr), typeof_member(type, member)) || \
         |                                           ^~~~~~~~~~~~~
   include/rv/ha_monitor.h:68:27: note: in expansion of macro 'container_of'
      68 | #define to_ha_monitor(da) container_of(da, struct ha_monitor, da_mon)
         |                           ^~~~~~~~~~~~
   include/rv/ha_monitor.h:192:37: note: in expansion of macro 'to_ha_monitor'
     192 |         struct ha_monitor *ha_mon = to_ha_monitor(da_mon);
         |                                     ^~~~~~~~~~~~~
   include/linux/compiler_types.h:610:27: error: expression in static assertion is not an integer
     610 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:80:56: note: in definition of macro '__static_assert'
      80 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), typeof_member(type, member)) || \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:20:23: note: in expansion of macro '__same_type'
      20 |         static_assert(__same_type(*(ptr), typeof_member(type, member)) || \
         |                       ^~~~~~~~~~~
   include/rv/ha_monitor.h:68:27: note: in expansion of macro 'container_of'
      68 | #define to_ha_monitor(da) container_of(da, struct ha_monitor, da_mon)
         |                           ^~~~~~~~~~~~
   include/rv/ha_monitor.h:192:37: note: in expansion of macro 'to_ha_monitor'
     192 |         struct ha_monitor *ha_mon = to_ha_monitor(da_mon);
         |                                     ^~~~~~~~~~~~~
>> include/linux/stddef.h:16:33: error: 'struct ha_monitor' has no member named 'da_mon'
      16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
         |                                 ^~~~~~~~~~~~~~~~~~
   include/linux/container_of.h:23:34: note: in expansion of macro 'offsetof'
      23 |         (type *)((void *)(ptr) - offsetof(type, member)); })
         |                                  ^~~~~~~~
   include/rv/ha_monitor.h:68:27: note: in expansion of macro 'container_of'
      68 | #define to_ha_monitor(da) container_of(da, struct ha_monitor, da_mon)
         |                           ^~~~~~~~~~~~
   include/rv/ha_monitor.h:192:37: note: in expansion of macro 'to_ha_monitor'
     192 |         struct ha_monitor *ha_mon = to_ha_monitor(da_mon);
         |                                     ^~~~~~~~~~~~~
   include/rv/ha_monitor.h: In function 'ha_monitor_reset_env':
>> include/linux/container_of.h:8:47: error: 'struct ha_monitor' has no member named 'da_mon'
       8 | #define typeof_member(T, m)     typeof(((T*)0)->m)
         |                                               ^~
   include/linux/build_bug.h:80:56: note: in definition of macro '__static_assert'
      80 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), typeof_member(type, member)) || \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:20:23: note: in expansion of macro '__same_type'
      20 |         static_assert(__same_type(*(ptr), typeof_member(type, member)) || \
         |                       ^~~~~~~~~~~
   include/linux/container_of.h:20:43: note: in expansion of macro 'typeof_member'
      20 |         static_assert(__same_type(*(ptr), typeof_member(type, member)) || \
         |                                           ^~~~~~~~~~~~~
   include/rv/ha_monitor.h:68:27: note: in expansion of macro 'container_of'
      68 | #define to_ha_monitor(da) container_of(da, struct ha_monitor, da_mon)
         |                           ^~~~~~~~~~~~
   include/rv/ha_monitor.h:208:37: note: in expansion of macro 'to_ha_monitor'
     208 |         struct ha_monitor *ha_mon = to_ha_monitor(da_mon);
         |                                     ^~~~~~~~~~~~~
   include/linux/compiler_types.h:610:27: error: expression in static assertion is not an integer
     610 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:80:56: note: in definition of macro '__static_assert'
      80 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), typeof_member(type, member)) || \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:20:23: note: in expansion of macro '__same_type'
      20 |         static_assert(__same_type(*(ptr), typeof_member(type, member)) || \
         |                       ^~~~~~~~~~~
   include/rv/ha_monitor.h:68:27: note: in expansion of macro 'container_of'
      68 | #define to_ha_monitor(da) container_of(da, struct ha_monitor, da_mon)
         |                           ^~~~~~~~~~~~
   include/rv/ha_monitor.h:208:37: note: in expansion of macro 'to_ha_monitor'
     208 |         struct ha_monitor *ha_mon = to_ha_monitor(da_mon);
         |                                     ^~~~~~~~~~~~~
>> include/linux/stddef.h:16:33: error: 'struct ha_monitor' has no member named 'da_mon'
      16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
         |                                 ^~~~~~~~~~~~~~~~~~
   include/linux/container_of.h:23:34: note: in expansion of macro 'offsetof'
      23 |         (type *)((void *)(ptr) - offsetof(type, member)); })
         |                                  ^~~~~~~~
   include/rv/ha_monitor.h:68:27: note: in expansion of macro 'container_of'
      68 | #define to_ha_monitor(da) container_of(da, struct ha_monitor, da_mon)
         |                           ^~~~~~~~~~~~
   include/rv/ha_monitor.h:208:37: note: in expansion of macro 'to_ha_monitor'
     208 |         struct ha_monitor *ha_mon = to_ha_monitor(da_mon);
         |                                     ^~~~~~~~~~~~~
   In file included from <command-line>:
   include/rv/ha_monitor.h: In function 'ha_monitor_env_invalid':
>> include/rv/ha_monitor.h:219:32: error: 'struct ha_monitor' has no member named 'env_store'
     219 |         return READ_ONCE(ha_mon->env_store[env]) == ENV_INVALID_VALUE;
         |                                ^~
   include/linux/compiler_types.h:682:23: note: in definition of macro '__compiletime_assert'
     682 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:702:9: note: in expansion of macro '_compiletime_assert'
     702 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/rv/ha_monitor.h:219:16: note: in expansion of macro 'READ_ONCE'
     219 |         return READ_ONCE(ha_mon->env_store[env]) == ENV_INVALID_VALUE;
         |                ^~~~~~~~~
>> include/rv/ha_monitor.h:219:32: error: 'struct ha_monitor' has no member named 'env_store'
     219 |         return READ_ONCE(ha_mon->env_store[env]) == ENV_INVALID_VALUE;
         |                                ^~
   include/linux/compiler_types.h:682:23: note: in definition of macro '__compiletime_assert'
     682 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:702:9: note: in expansion of macro '_compiletime_assert'
     702 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/rv/ha_monitor.h:219:16: note: in expansion of macro 'READ_ONCE'
     219 |         return READ_ONCE(ha_mon->env_store[env]) == ENV_INVALID_VALUE;
         |                ^~~~~~~~~
>> include/rv/ha_monitor.h:219:32: error: 'struct ha_monitor' has no member named 'env_store'
     219 |         return READ_ONCE(ha_mon->env_store[env]) == ENV_INVALID_VALUE;
         |                                ^~
   include/linux/compiler_types.h:682:23: note: in definition of macro '__compiletime_assert'
     682 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:702:9: note: in expansion of macro '_compiletime_assert'
     702 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/rv/ha_monitor.h:219:16: note: in expansion of macro 'READ_ONCE'
     219 |         return READ_ONCE(ha_mon->env_store[env]) == ENV_INVALID_VALUE;
         |                ^~~~~~~~~
>> include/rv/ha_monitor.h:219:32: error: 'struct ha_monitor' has no member named 'env_store'
     219 |         return READ_ONCE(ha_mon->env_store[env]) == ENV_INVALID_VALUE;
         |                                ^~
   include/linux/compiler_types.h:682:23: note: in definition of macro '__compiletime_assert'
     682 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:702:9: note: in expansion of macro '_compiletime_assert'
     702 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/rv/ha_monitor.h:219:16: note: in expansion of macro 'READ_ONCE'
     219 |         return READ_ONCE(ha_mon->env_store[env]) == ENV_INVALID_VALUE;
         |                ^~~~~~~~~
>> include/rv/ha_monitor.h:219:32: error: 'struct ha_monitor' has no member named 'env_store'
     219 |         return READ_ONCE(ha_mon->env_store[env]) == ENV_INVALID_VALUE;
         |                                ^~
   include/linux/compiler_types.h:682:23: note: in definition of macro '__compiletime_assert'
     682 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:702:9: note: in expansion of macro '_compiletime_assert'
     702 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/rv/ha_monitor.h:219:16: note: in expansion of macro 'READ_ONCE'
     219 |         return READ_ONCE(ha_mon->env_store[env]) == ENV_INVALID_VALUE;
         |                ^~~~~~~~~
>> include/rv/ha_monitor.h:219:32: error: 'struct ha_monitor' has no member named 'env_store'
     219 |         return READ_ONCE(ha_mon->env_store[env]) == ENV_INVALID_VALUE;
         |                                ^~
   include/linux/compiler_types.h:635:53: note: in definition of macro '__unqual_scalar_typeof'
     635 | #define __unqual_scalar_typeof(x) __typeof_unqual__(x)
         |                                                     ^
   include/asm-generic/rwonce.h:50:9: note: in expansion of macro '__READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |         ^~~~~~~~~~~
   include/rv/ha_monitor.h:219:16: note: in expansion of macro 'READ_ONCE'
     219 |         return READ_ONCE(ha_mon->env_store[env]) == ENV_INVALID_VALUE;
         |                ^~~~~~~~~
>> include/rv/ha_monitor.h:219:32: error: 'struct ha_monitor' has no member named 'env_store'
     219 |         return READ_ONCE(ha_mon->env_store[env]) == ENV_INVALID_VALUE;
         |                                ^~
   include/asm-generic/rwonce.h:44:73: note: in definition of macro '__READ_ONCE'
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                                                                         ^
   include/rv/ha_monitor.h:219:16: note: in expansion of macro 'READ_ONCE'
     219 |         return READ_ONCE(ha_mon->env_store[env]) == ENV_INVALID_VALUE;
         |                ^~~~~~~~~
>> include/rv/ha_monitor.h:217:80: warning: parameter 'env' set but not used [-Wunused-but-set-parameter=]
     217 | static inline bool ha_monitor_env_invalid(struct ha_monitor *ha_mon, enum envs env)
         |                                                                      ~~~~~~~~~~^~~
   include/rv/ha_monitor.h: In function 'ha_monitor_handle_constraint':
>> include/linux/container_of.h:8:47: error: 'struct ha_monitor' has no member named 'da_mon'
       8 | #define typeof_member(T, m)     typeof(((T*)0)->m)
         |                                               ^~
   include/linux/build_bug.h:80:56: note: in definition of macro '__static_assert'
      80 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), typeof_member(type, member)) || \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:20:23: note: in expansion of macro '__same_type'
      20 |         static_assert(__same_type(*(ptr), typeof_member(type, member)) || \
         |                       ^~~~~~~~~~~
   include/linux/container_of.h:20:43: note: in expansion of macro 'typeof_member'
      20 |         static_assert(__same_type(*(ptr), typeof_member(type, member)) || \
         |                                           ^~~~~~~~~~~~~
   include/rv/ha_monitor.h:68:27: note: in expansion of macro 'container_of'
      68 | #define to_ha_monitor(da) container_of(da, struct ha_monitor, da_mon)
         |                           ^~~~~~~~~~~~
   include/rv/ha_monitor.h:286:37: note: in expansion of macro 'to_ha_monitor'
     286 |         struct ha_monitor *ha_mon = to_ha_monitor(da_mon);
         |                                     ^~~~~~~~~~~~~
   include/linux/compiler_types.h:610:27: error: expression in static assertion is not an integer
     610 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:80:56: note: in definition of macro '__static_assert'
      80 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), typeof_member(type, member)) || \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:20:23: note: in expansion of macro '__same_type'
      20 |         static_assert(__same_type(*(ptr), typeof_member(type, member)) || \
         |                       ^~~~~~~~~~~
   include/rv/ha_monitor.h:68:27: note: in expansion of macro 'container_of'
      68 | #define to_ha_monitor(da) container_of(da, struct ha_monitor, da_mon)
         |                           ^~~~~~~~~~~~
   include/rv/ha_monitor.h:286:37: note: in expansion of macro 'to_ha_monitor'
     286 |         struct ha_monitor *ha_mon = to_ha_monitor(da_mon);
         |                                     ^~~~~~~~~~~~~
>> include/linux/stddef.h:16:33: error: 'struct ha_monitor' has no member named 'da_mon'
      16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
         |                                 ^~~~~~~~~~~~~~~~~~
   include/linux/container_of.h:23:34: note: in expansion of macro 'offsetof'
      23 |         (type *)((void *)(ptr) - offsetof(type, member)); })
         |                                  ^~~~~~~~
   include/rv/ha_monitor.h:68:27: note: in expansion of macro 'container_of'
      68 | #define to_ha_monitor(da) container_of(da, struct ha_monitor, da_mon)
         |                           ^~~~~~~~~~~~
   include/rv/ha_monitor.h:286:37: note: in expansion of macro 'to_ha_monitor'
     286 |         struct ha_monitor *ha_mon = to_ha_monitor(da_mon);
         |                                     ^~~~~~~~~~~~~
   include/rv/ha_monitor.h: In function '__ha_monitor_timer_callback':
>> include/rv/ha_monitor.h:321:46: error: 'struct ha_monitor' has no member named 'da_mon'
     321 |         curr_state = smp_load_acquire(&ha_mon->da_mon.curr_state);
         |                                              ^~
   include/linux/compiler_types.h:635:53: note: in definition of macro '__unqual_scalar_typeof'
     635 | #define __unqual_scalar_typeof(x) __typeof_unqual__(x)
         |                                                     ^
   include/rv/ha_monitor.h:321:22: note: in expansion of macro 'smp_load_acquire'
     321 |         curr_state = smp_load_acquire(&ha_mon->da_mon.curr_state);
         |                      ^~~~~~~~~~~~~~~~
>> include/rv/ha_monitor.h:321:46: error: 'struct ha_monitor' has no member named 'da_mon'
     321 |         curr_state = smp_load_acquire(&ha_mon->da_mon.curr_state);
         |                                              ^~
   include/linux/compiler_types.h:682:23: note: in definition of macro '__compiletime_assert'
     682 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:702:9: note: in expansion of macro '_compiletime_assert'
     702 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/barrier.h:204:44: note: in expansion of macro 'READ_ONCE'
     204 |         __unqual_scalar_typeof(*p) ___p1 = READ_ONCE(*p);               \
         |                                            ^~~~~~~~~
   include/rv/ha_monitor.h:321:22: note: in expansion of macro 'smp_load_acquire'
     321 |         curr_state = smp_load_acquire(&ha_mon->da_mon.curr_state);
         |                      ^~~~~~~~~~~~~~~~
   include/rv/ha_monitor.h:321:46: error: 'struct ha_monitor' has no member named 'da_mon'
     321 |         curr_state = smp_load_acquire(&ha_mon->da_mon.curr_state);
         |                                              ^~
   include/linux/compiler_types.h:682:23: note: in definition of macro '__compiletime_assert'
     682 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:702:9: note: in expansion of macro '_compiletime_assert'
     702 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/barrier.h:204:44: note: in expansion of macro 'READ_ONCE'
     204 |         __unqual_scalar_typeof(*p) ___p1 = READ_ONCE(*p);               \
         |                                            ^~~~~~~~~
   include/rv/ha_monitor.h:321:22: note: in expansion of macro 'smp_load_acquire'
     321 |         curr_state = smp_load_acquire(&ha_mon->da_mon.curr_state);
         |                      ^~~~~~~~~~~~~~~~
   include/rv/ha_monitor.h:321:46: error: 'struct ha_monitor' has no member named 'da_mon'
     321 |         curr_state = smp_load_acquire(&ha_mon->da_mon.curr_state);
         |                                              ^~
   include/linux/compiler_types.h:682:23: note: in definition of macro '__compiletime_assert'
     682 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:702:9: note: in expansion of macro '_compiletime_assert'
     702 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/barrier.h:204:44: note: in expansion of macro 'READ_ONCE'
     204 |         __unqual_scalar_typeof(*p) ___p1 = READ_ONCE(*p);               \
         |                                            ^~~~~~~~~
   include/rv/ha_monitor.h:321:22: note: in expansion of macro 'smp_load_acquire'
     321 |         curr_state = smp_load_acquire(&ha_mon->da_mon.curr_state);
         |                      ^~~~~~~~~~~~~~~~
   include/rv/ha_monitor.h:321:46: error: 'struct ha_monitor' has no member named 'da_mon'
     321 |         curr_state = smp_load_acquire(&ha_mon->da_mon.curr_state);
         |                                              ^~
   include/linux/compiler_types.h:682:23: note: in definition of macro '__compiletime_assert'
     682 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:702:9: note: in expansion of macro '_compiletime_assert'
     702 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/barrier.h:204:44: note: in expansion of macro 'READ_ONCE'
     204 |         __unqual_scalar_typeof(*p) ___p1 = READ_ONCE(*p);               \
         |                                            ^~~~~~~~~
   include/rv/ha_monitor.h:321:22: note: in expansion of macro 'smp_load_acquire'
     321 |         curr_state = smp_load_acquire(&ha_mon->da_mon.curr_state);
         |                      ^~~~~~~~~~~~~~~~
   include/rv/ha_monitor.h:321:46: error: 'struct ha_monitor' has no member named 'da_mon'
     321 |         curr_state = smp_load_acquire(&ha_mon->da_mon.curr_state);
         |                                              ^~
   include/linux/compiler_types.h:682:23: note: in definition of macro '__compiletime_assert'
     682 |                 if (!(condition))                                       \


vim +16 include/linux/stddef.h

6e2182874324727 Richard Knutsson 2006-09-30  14  
^1da177e4c3f415 Linus Torvalds   2005-04-16  15  #undef offsetof
14e83077d55ff4b Rasmus Villemoes 2022-03-23 @16  #define offsetof(TYPE, MEMBER)	__builtin_offsetof(TYPE, MEMBER)
3876488444e7123 Denys Vlasenko   2015-03-09  17  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
