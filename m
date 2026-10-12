Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393253ACF00;
	Mon, 12 Oct 2026 11:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791803924; cv=none; b=Dbk3uTURs8j6HcYrbY6zBJtOsMX/EFxxeADuf5F/H76wBvS1rtLak5Sz9Eq+FOd3FMpJ4SKzeFnzqcT+AUw48olv1+I53kjJPe6/rsqRmJC+m7FJbixWlUNrnmtt+jO/q0JJjOvGgi1p8r0geWZm4Nv5wvDPKlkFNxsCHJtrg/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791803924; c=relaxed/simple;
	bh=nAdH7Ezn1hA3Z0jqFEH6CXlBCot9G+tzFueguqACefk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qWOy6DoXVI3s50UnvZAoXEyzKQp2uQuAOpyyunKR7YEBNf9hzxPBBKiBLLIFqN77LS4rOzUt38HLwVJNhSE2a7Yyz77pCQDdcMjyvrJsW82kHZ9MOdsvdmdROYJv9NIDLsCMpSGGrW/EZAA46yYVAVXC6h9TW977e3lg+EyLPnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hNLnPYor; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hNLnPYor"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791803922; x=1823339922;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nAdH7Ezn1hA3Z0jqFEH6CXlBCot9G+tzFueguqACefk=;
  b=hNLnPYorTnknuesa0OyQG24Oh4Wnh/Px32SlotYWU/x7qoHqejdnxu+l
   M8HX2igThMA0c+4dKqSubHQyxl8aYECTHbYlphgLr3oSXggT3wxCOm1LK
   KG00BaZGjpPV0INxM9m9VQnMPmQNcNobLh/5Esra37CAMxGkdWcbqD3XP
   9+6xuG+A+v2uM/JUe8fOJaF05BbqTCI8/vnxqlssHqZO9vvp9VyTM/Kn2
   RIVG/eIPvvyx0lQ2cXfpAbtp2uYBYk1fRVg2cvFW9bEToN5LdbQbxaMaD
   sF1M0jJJA9SJrMYFNazGeACQG+J3pgES5jkGIw5NLJ73BFCdtD50RcTBY
   Q==;
X-CSE-ConnectionGUID: LELalK2bSMCvJHsssutfrA==
X-CSE-MsgGUID: sBUMqYNZTcOJkgb39AtP8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="416940"
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="416940"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 04:18:41 -0700
X-CSE-ConnectionGUID: 0tNLjBRmSNWq7zfcNU56Gg==
X-CSE-MsgGUID: j7AiiAnkQIqvvR5ruZMNow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="1062309"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 12 Oct 2026 04:18:40 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xGE3A-00000000BNV-2bhK;
	Mon, 12 Oct 2026 11:18:36 +0000
Date: Mon, 12 Oct 2026 19:18:13 +0800
From: kernel test robot <lkp@intel.com>
To: wen.yang@linux.dev, Gabriele Monaco <gmonaco@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: Re: [PATCH v7 03/14] rv: Add a KUnit test for the HA timer underflow
Message-ID: <202610121941.4v5qqs5W-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on trace/for-next]
[also build test WARNING on shuah-kselftest/next shuah-kselftest/fixes linus/master v7.3-rc6 next-20261009]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/wen-yang-linux-dev/rv-Force-environment-reset-action-on-HA-monitor-start/20261012-033907
base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
patch link:    https://lore.kernel.org/r/cdaf33af866392428f1942cef4e442b1d106989c.1791745088.git.wen.yang%40linux.dev
patch subject: [PATCH v7 03/14] rv: Add a KUnit test for the HA timer underflow
config: x86_64-rhel-9.4-kunit (https://download.01.org/0day-ci/archive/20261012/202610121941.4v5qqs5W-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261012/202610121941.4v5qqs5W-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610121941.4v5qqs5W-lkp@intel.com/

All warnings (new ones prefixed by >>):

         |                                  ^~~~~~~~
   include/rv/ha_monitor.h:430:37: note: in expansion of macro 'container_of'
     430 |         struct ha_monitor *ha_mon = container_of(timer, struct ha_monitor, timer);
         |                                     ^~~~~~~~~~~~
   include/rv/ha_monitor.h: In function 'ha_setup_timer':
   include/rv/ha_monitor.h:440:28: error: 'struct ha_monitor' has no member named 'timer'
     440 |         timer_setup(&ha_mon->timer, ha_monitor_timer_callback, mode);
         |                            ^~
   include/linux/timer.h:105:25: note: in definition of macro '__timer_init'
     105 |         timer_init_key((_timer), (_fn), (_flags), NULL, NULL)
         |                         ^~~~~~
   include/rv/ha_monitor.h:440:9: note: in expansion of macro 'timer_setup'
     440 |         timer_setup(&ha_mon->timer, ha_monitor_timer_callback, mode);
         |         ^~~~~~~~~~~
   include/rv/ha_monitor.h: In function 'ha_start_timer_jiffy':
   include/rv/ha_monitor.h:447:26: error: 'struct ha_monitor' has no member named 'timer'
     447 |         mod_timer(&ha_mon->timer,
         |                          ^~
   include/rv/ha_monitor.h: In function 'ha_cancel_timer':
   include/rv/ha_monitor.h:468:36: error: 'struct ha_monitor' has no member named 'timer'
     468 |         return timer_delete(&ha_mon->timer);
         |                                    ^~
   include/rv/ha_monitor.h: In function 'ha_cancel_timer_sync':
   include/rv/ha_monitor.h:472:34: error: 'struct ha_monitor' has no member named 'timer'
     472 |         timer_delete_sync(&ha_mon->timer);
         |                                  ^~
   kernel/trace/rv/rv_monitors_test.c: In function 'rv_test_rvtest_underflow':
   include/linux/container_of.h:8:47: error: 'struct ha_monitor' has no member named 'da_mon'
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
   kernel/trace/rv/rv_monitors_test.c:248:18: note: in expansion of macro 'to_ha_monitor'
     248 |         ha_mon = to_ha_monitor(da_mon);
         |                  ^~~~~~~~~~~~~
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
   kernel/trace/rv/rv_monitors_test.c:248:18: note: in expansion of macro 'to_ha_monitor'
     248 |         ha_mon = to_ha_monitor(da_mon);
         |                  ^~~~~~~~~~~~~
   include/linux/stddef.h:16:33: error: 'struct ha_monitor' has no member named 'da_mon'
      16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
         |                                 ^~~~~~~~~~~~~~~~~~
   include/linux/container_of.h:23:34: note: in expansion of macro 'offsetof'
      23 |         (type *)((void *)(ptr) - offsetof(type, member)); })
         |                                  ^~~~~~~~
   include/rv/ha_monitor.h:68:27: note: in expansion of macro 'container_of'
      68 | #define to_ha_monitor(da) container_of(da, struct ha_monitor, da_mon)
         |                           ^~~~~~~~~~~~
   kernel/trace/rv/rv_monitors_test.c:248:18: note: in expansion of macro 'to_ha_monitor'
     248 |         ha_mon = to_ha_monitor(da_mon);
         |                  ^~~~~~~~~~~~~
   kernel/trace/rv/rv_monitors_test.c:259:33: error: 'struct ha_monitor' has no member named 'da_mon'
     259 |         da_monitor_reset(&ha_mon->da_mon);
         |                                 ^~
   kernel/trace/rv/rv_monitors_test.c:264:67: error: 'struct ha_monitor' has no member named 'hrtimer'
     264 |                           ktime_before(hrtimer_get_expires(&ha_mon->hrtimer),
         |                                                                   ^~
   include/linux/compiler.h:76:45: note: in definition of macro 'likely'
      76 | # define likely(x)      __builtin_expect(!!(x), 1)
         |                                             ^
   include/kunit/test.h:802:9: note: in expansion of macro 'KUNIT_UNARY_ASSERTION'
     802 |         KUNIT_UNARY_ASSERTION(test,                                            \
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:998:9: note: in expansion of macro 'KUNIT_TRUE_MSG_ASSERTION'
     998 |         KUNIT_TRUE_MSG_ASSERTION(test,                                         \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:995:9: note: in expansion of macro 'KUNIT_EXPECT_TRUE_MSG'
     995 |         KUNIT_EXPECT_TRUE_MSG(test, condition, NULL)
         |         ^~~~~~~~~~~~~~~~~~~~~
   kernel/trace/rv/rv_monitors_test.c:263:9: note: in expansion of macro 'KUNIT_EXPECT_TRUE'
     263 |         KUNIT_EXPECT_TRUE(test,
         |         ^~~~~~~~~~~~~~~~~
   include/rv/ha_monitor.h: In function 'ha_cancel_timer':
>> include/rv/ha_monitor.h:469:1: warning: control reaches end of non-void function [-Wreturn-type]
     469 | }
         | ^
   include/rv/ha_monitor.h: In function 'ha_get_clk_ns':
   include/rv/ha_monitor.h:346:1: warning: control reaches end of non-void function [-Wreturn-type]
     346 | }
         | ^
   include/rv/ha_monitor.h: In function 'ha_check_invariant_ns':
   include/rv/ha_monitor.h:355:1: warning: control reaches end of non-void function [-Wreturn-type]
     355 | }
         | ^
   include/rv/ha_monitor.h: In function 'ha_monitor_env_invalid':
   include/rv/ha_monitor.h:220:1: warning: control reaches end of non-void function [-Wreturn-type]
     220 | }
         | ^
--
         |                                  ^~~~~~~~
   include/rv/ha_monitor.h:430:37: note: in expansion of macro 'container_of'
     430 |         struct ha_monitor *ha_mon = container_of(timer, struct ha_monitor, timer);
         |                                     ^~~~~~~~~~~~
   include/rv/ha_monitor.h: In function 'ha_setup_timer':
   include/rv/ha_monitor.h:440:28: error: 'struct ha_monitor' has no member named 'timer'
     440 |         timer_setup(&ha_mon->timer, ha_monitor_timer_callback, mode);
         |                            ^~
   include/linux/timer.h:105:25: note: in definition of macro '__timer_init'
     105 |         timer_init_key((_timer), (_fn), (_flags), NULL, NULL)
         |                         ^~~~~~
   include/rv/ha_monitor.h:440:9: note: in expansion of macro 'timer_setup'
     440 |         timer_setup(&ha_mon->timer, ha_monitor_timer_callback, mode);
         |         ^~~~~~~~~~~
   include/rv/ha_monitor.h: In function 'ha_start_timer_jiffy':
   include/rv/ha_monitor.h:447:26: error: 'struct ha_monitor' has no member named 'timer'
     447 |         mod_timer(&ha_mon->timer,
         |                          ^~
   include/rv/ha_monitor.h: In function 'ha_cancel_timer':
   include/rv/ha_monitor.h:468:36: error: 'struct ha_monitor' has no member named 'timer'
     468 |         return timer_delete(&ha_mon->timer);
         |                                    ^~
   include/rv/ha_monitor.h: In function 'ha_cancel_timer_sync':
   include/rv/ha_monitor.h:472:34: error: 'struct ha_monitor' has no member named 'timer'
     472 |         timer_delete_sync(&ha_mon->timer);
         |                                  ^~
   rv_monitors_test.c: In function 'rv_test_rvtest_underflow':
   include/linux/container_of.h:8:47: error: 'struct ha_monitor' has no member named 'da_mon'
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
   rv_monitors_test.c:248:18: note: in expansion of macro 'to_ha_monitor'
     248 |         ha_mon = to_ha_monitor(da_mon);
         |                  ^~~~~~~~~~~~~
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
   rv_monitors_test.c:248:18: note: in expansion of macro 'to_ha_monitor'
     248 |         ha_mon = to_ha_monitor(da_mon);
         |                  ^~~~~~~~~~~~~
   include/linux/stddef.h:16:33: error: 'struct ha_monitor' has no member named 'da_mon'
      16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
         |                                 ^~~~~~~~~~~~~~~~~~
   include/linux/container_of.h:23:34: note: in expansion of macro 'offsetof'
      23 |         (type *)((void *)(ptr) - offsetof(type, member)); })
         |                                  ^~~~~~~~
   include/rv/ha_monitor.h:68:27: note: in expansion of macro 'container_of'
      68 | #define to_ha_monitor(da) container_of(da, struct ha_monitor, da_mon)
         |                           ^~~~~~~~~~~~
   rv_monitors_test.c:248:18: note: in expansion of macro 'to_ha_monitor'
     248 |         ha_mon = to_ha_monitor(da_mon);
         |                  ^~~~~~~~~~~~~
   rv_monitors_test.c:259:33: error: 'struct ha_monitor' has no member named 'da_mon'
     259 |         da_monitor_reset(&ha_mon->da_mon);
         |                                 ^~
   rv_monitors_test.c:264:67: error: 'struct ha_monitor' has no member named 'hrtimer'
     264 |                           ktime_before(hrtimer_get_expires(&ha_mon->hrtimer),
         |                                                                   ^~
   include/linux/compiler.h:76:45: note: in definition of macro 'likely'
      76 | # define likely(x)      __builtin_expect(!!(x), 1)
         |                                             ^
   include/kunit/test.h:802:9: note: in expansion of macro 'KUNIT_UNARY_ASSERTION'
     802 |         KUNIT_UNARY_ASSERTION(test,                                            \
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:998:9: note: in expansion of macro 'KUNIT_TRUE_MSG_ASSERTION'
     998 |         KUNIT_TRUE_MSG_ASSERTION(test,                                         \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:995:9: note: in expansion of macro 'KUNIT_EXPECT_TRUE_MSG'
     995 |         KUNIT_EXPECT_TRUE_MSG(test, condition, NULL)
         |         ^~~~~~~~~~~~~~~~~~~~~
   rv_monitors_test.c:263:9: note: in expansion of macro 'KUNIT_EXPECT_TRUE'
     263 |         KUNIT_EXPECT_TRUE(test,
         |         ^~~~~~~~~~~~~~~~~
   include/rv/ha_monitor.h: In function 'ha_cancel_timer':
>> include/rv/ha_monitor.h:469:1: warning: control reaches end of non-void function [-Wreturn-type]
     469 | }
         | ^
   include/rv/ha_monitor.h: In function 'ha_get_clk_ns':
   include/rv/ha_monitor.h:346:1: warning: control reaches end of non-void function [-Wreturn-type]
     346 | }
         | ^
   include/rv/ha_monitor.h: In function 'ha_check_invariant_ns':
   include/rv/ha_monitor.h:355:1: warning: control reaches end of non-void function [-Wreturn-type]
     355 | }
         | ^
   include/rv/ha_monitor.h: In function 'ha_monitor_env_invalid':
   include/rv/ha_monitor.h:220:1: warning: control reaches end of non-void function [-Wreturn-type]
     220 | }
         | ^


vim +469 include/rv/ha_monitor.h

d68b31ce9bd4dda Wen Yang        2026-10-12  417  
f5587d1b6ec938a Gabriele Monaco 2026-03-30  418  #if HA_TIMER_TYPE == HA_TIMER_WHEEL
f5587d1b6ec938a Gabriele Monaco 2026-03-30  419  /*
f5587d1b6ec938a Gabriele Monaco 2026-03-30  420   * Helper functions to handle the monitor timer.
f5587d1b6ec938a Gabriele Monaco 2026-03-30  421   * Not all monitors require a timer, in such case the timer will be set up but
f5587d1b6ec938a Gabriele Monaco 2026-03-30  422   * never armed.
f5587d1b6ec938a Gabriele Monaco 2026-03-30  423   * Timers start since the last reset of the supplied env or from now if env is
f5587d1b6ec938a Gabriele Monaco 2026-03-30  424   * not an environment variable. If env was not initialised no timer starts.
f5587d1b6ec938a Gabriele Monaco 2026-03-30  425   * Timers can expire on any CPU unless the monitor is per-cpu,
f5587d1b6ec938a Gabriele Monaco 2026-03-30  426   * where we assume every event occurs on the local CPU.
f5587d1b6ec938a Gabriele Monaco 2026-03-30  427   */
f5587d1b6ec938a Gabriele Monaco 2026-03-30  428  static void ha_monitor_timer_callback(struct timer_list *timer)
f5587d1b6ec938a Gabriele Monaco 2026-03-30  429  {
f5587d1b6ec938a Gabriele Monaco 2026-03-30  430  	struct ha_monitor *ha_mon = container_of(timer, struct ha_monitor, timer);
f5587d1b6ec938a Gabriele Monaco 2026-03-30  431  
f5587d1b6ec938a Gabriele Monaco 2026-03-30  432  	__ha_monitor_timer_callback(ha_mon);
f5587d1b6ec938a Gabriele Monaco 2026-03-30  433  }
f5587d1b6ec938a Gabriele Monaco 2026-03-30  434  static inline void ha_setup_timer(struct ha_monitor *ha_mon)
f5587d1b6ec938a Gabriele Monaco 2026-03-30  435  {
f5587d1b6ec938a Gabriele Monaco 2026-03-30  436  	int mode = 0;
f5587d1b6ec938a Gabriele Monaco 2026-03-30  437  
f5587d1b6ec938a Gabriele Monaco 2026-03-30  438  	if (RV_MON_TYPE == RV_MON_PER_CPU)
f5587d1b6ec938a Gabriele Monaco 2026-03-30  439  		mode |= TIMER_PINNED;
f5587d1b6ec938a Gabriele Monaco 2026-03-30  440  	timer_setup(&ha_mon->timer, ha_monitor_timer_callback, mode);
f5587d1b6ec938a Gabriele Monaco 2026-03-30  441  }
f5587d1b6ec938a Gabriele Monaco 2026-03-30  442  static inline void ha_start_timer_jiffy(struct ha_monitor *ha_mon, enum envs env,
f5587d1b6ec938a Gabriele Monaco 2026-03-30  443  					u64 expire, u64 time_ns)
f5587d1b6ec938a Gabriele Monaco 2026-03-30  444  {
ab2900ae252b2a3 Nam Cao         2026-06-19  445  	u64 passed = ha_invariant_passed_jiffy(ha_mon, env, time_ns);
f5587d1b6ec938a Gabriele Monaco 2026-03-30  446  
d68b31ce9bd4dda Wen Yang        2026-10-12  447  	mod_timer(&ha_mon->timer,
d68b31ce9bd4dda Wen Yang        2026-10-12  448  		  get_jiffies_64() + ha_time_left(passed, expire));
f5587d1b6ec938a Gabriele Monaco 2026-03-30  449  }
f5587d1b6ec938a Gabriele Monaco 2026-03-30  450  static inline void ha_start_timer_ns(struct ha_monitor *ha_mon, enum envs env,
f5587d1b6ec938a Gabriele Monaco 2026-03-30  451  				     u64 expire, u64 time_ns)
f5587d1b6ec938a Gabriele Monaco 2026-03-30  452  {
ab2900ae252b2a3 Nam Cao         2026-06-19  453  	u64 passed = ha_invariant_passed_ns(ha_mon, env, time_ns);
d68b31ce9bd4dda Wen Yang        2026-10-12  454  	u64 delay = ha_time_left(passed, expire);
f5587d1b6ec938a Gabriele Monaco 2026-03-30  455  
f5587d1b6ec938a Gabriele Monaco 2026-03-30  456  	ha_start_timer_jiffy(ha_mon, ENV_MAX_STORED,
d68b31ce9bd4dda Wen Yang        2026-10-12  457  			     nsecs_to_jiffies(delay + TICK_NSEC - 1), time_ns);
f5587d1b6ec938a Gabriele Monaco 2026-03-30  458  }
f5587d1b6ec938a Gabriele Monaco 2026-03-30  459  /*
f5587d1b6ec938a Gabriele Monaco 2026-03-30  460   * ha_cancel_timer - Cancel the timer
f5587d1b6ec938a Gabriele Monaco 2026-03-30  461   *
f5587d1b6ec938a Gabriele Monaco 2026-03-30  462   * Returns:
f5587d1b6ec938a Gabriele Monaco 2026-03-30  463   *  *  1 when the timer was active
f5587d1b6ec938a Gabriele Monaco 2026-03-30  464   *  *  0 when the timer was not active or running a callback
f5587d1b6ec938a Gabriele Monaco 2026-03-30  465   */
f5587d1b6ec938a Gabriele Monaco 2026-03-30  466  static inline bool ha_cancel_timer(struct ha_monitor *ha_mon)
f5587d1b6ec938a Gabriele Monaco 2026-03-30  467  {
f5587d1b6ec938a Gabriele Monaco 2026-03-30  468  	return timer_delete(&ha_mon->timer);
f5587d1b6ec938a Gabriele Monaco 2026-03-30 @469  }
700782ec8f6589c Gabriele Monaco 2026-06-01  470  static inline void ha_cancel_timer_sync(struct ha_monitor *ha_mon)
700782ec8f6589c Gabriele Monaco 2026-06-01  471  {
700782ec8f6589c Gabriele Monaco 2026-06-01  472  	timer_delete_sync(&ha_mon->timer);
700782ec8f6589c Gabriele Monaco 2026-06-01  473  }
f5587d1b6ec938a Gabriele Monaco 2026-03-30  474  #elif HA_TIMER_TYPE == HA_TIMER_HRTIMER
f5587d1b6ec938a Gabriele Monaco 2026-03-30  475  /*
f5587d1b6ec938a Gabriele Monaco 2026-03-30  476   * Helper functions to handle the monitor timer.
f5587d1b6ec938a Gabriele Monaco 2026-03-30  477   * Not all monitors require a timer, in such case the timer will be set up but
f5587d1b6ec938a Gabriele Monaco 2026-03-30  478   * never armed.
f5587d1b6ec938a Gabriele Monaco 2026-03-30  479   * Timers start since the last reset of the supplied env or from now if env is
f5587d1b6ec938a Gabriele Monaco 2026-03-30  480   * not an environment variable. If env was not initialised no timer starts.
f5587d1b6ec938a Gabriele Monaco 2026-03-30  481   * Timers can expire on any CPU unless the monitor is per-cpu,
f5587d1b6ec938a Gabriele Monaco 2026-03-30  482   * where we assume every event occurs on the local CPU.
f5587d1b6ec938a Gabriele Monaco 2026-03-30  483   */
f5587d1b6ec938a Gabriele Monaco 2026-03-30  484  static enum hrtimer_restart ha_monitor_timer_callback(struct hrtimer *hrtimer)
f5587d1b6ec938a Gabriele Monaco 2026-03-30  485  {
f5587d1b6ec938a Gabriele Monaco 2026-03-30  486  	struct ha_monitor *ha_mon = container_of(hrtimer, struct ha_monitor, hrtimer);
f5587d1b6ec938a Gabriele Monaco 2026-03-30  487  
f5587d1b6ec938a Gabriele Monaco 2026-03-30  488  	__ha_monitor_timer_callback(ha_mon);
f5587d1b6ec938a Gabriele Monaco 2026-03-30  489  	return HRTIMER_NORESTART;
f5587d1b6ec938a Gabriele Monaco 2026-03-30  490  }
f5587d1b6ec938a Gabriele Monaco 2026-03-30  491  static inline void ha_setup_timer(struct ha_monitor *ha_mon)
f5587d1b6ec938a Gabriele Monaco 2026-03-30  492  {
f5587d1b6ec938a Gabriele Monaco 2026-03-30  493  	hrtimer_setup(&ha_mon->hrtimer, ha_monitor_timer_callback,
f5587d1b6ec938a Gabriele Monaco 2026-03-30  494  		      CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
f5587d1b6ec938a Gabriele Monaco 2026-03-30  495  }
f5587d1b6ec938a Gabriele Monaco 2026-03-30  496  static inline void ha_start_timer_ns(struct ha_monitor *ha_mon, enum envs env,
f5587d1b6ec938a Gabriele Monaco 2026-03-30  497  				     u64 expire, u64 time_ns)
f5587d1b6ec938a Gabriele Monaco 2026-03-30  498  {
f5587d1b6ec938a Gabriele Monaco 2026-03-30  499  	int mode = HRTIMER_MODE_REL_HARD;
ab2900ae252b2a3 Nam Cao         2026-06-19  500  	u64 passed = ha_invariant_passed_ns(ha_mon, env, time_ns);
f5587d1b6ec938a Gabriele Monaco 2026-03-30  501  
f5587d1b6ec938a Gabriele Monaco 2026-03-30  502  	if (RV_MON_TYPE == RV_MON_PER_CPU)
f5587d1b6ec938a Gabriele Monaco 2026-03-30  503  		mode |= HRTIMER_MODE_PINNED;
d68b31ce9bd4dda Wen Yang        2026-10-12  504  	hrtimer_start(&ha_mon->hrtimer,
d68b31ce9bd4dda Wen Yang        2026-10-12  505  		      ns_to_ktime(ha_time_left(passed, expire)), mode);
f5587d1b6ec938a Gabriele Monaco 2026-03-30  506  }
f5587d1b6ec938a Gabriele Monaco 2026-03-30  507  static inline void ha_start_timer_jiffy(struct ha_monitor *ha_mon, enum envs env,
f5587d1b6ec938a Gabriele Monaco 2026-03-30  508  					u64 expire, u64 time_ns)
f5587d1b6ec938a Gabriele Monaco 2026-03-30  509  {
ab2900ae252b2a3 Nam Cao         2026-06-19  510  	u64 passed = ha_invariant_passed_jiffy(ha_mon, env, time_ns);
f5587d1b6ec938a Gabriele Monaco 2026-03-30  511  
f5587d1b6ec938a Gabriele Monaco 2026-03-30  512  	ha_start_timer_ns(ha_mon, ENV_MAX_STORED,
d68b31ce9bd4dda Wen Yang        2026-10-12  513  			  jiffies_to_nsecs(ha_time_left(passed, expire)),
d68b31ce9bd4dda Wen Yang        2026-10-12  514  			  time_ns);
f5587d1b6ec938a Gabriele Monaco 2026-03-30  515  }
f5587d1b6ec938a Gabriele Monaco 2026-03-30  516  /*
f5587d1b6ec938a Gabriele Monaco 2026-03-30  517   * ha_cancel_timer - Cancel the timer
f5587d1b6ec938a Gabriele Monaco 2026-03-30  518   *
f5587d1b6ec938a Gabriele Monaco 2026-03-30  519   * Returns:
f5587d1b6ec938a Gabriele Monaco 2026-03-30  520   *  *  1 when the timer was active
f5587d1b6ec938a Gabriele Monaco 2026-03-30  521   *  *  0 when the timer was not active or running a callback
f5587d1b6ec938a Gabriele Monaco 2026-03-30  522   */
f5587d1b6ec938a Gabriele Monaco 2026-03-30  523  static inline bool ha_cancel_timer(struct ha_monitor *ha_mon)
f5587d1b6ec938a Gabriele Monaco 2026-03-30  524  {
f5587d1b6ec938a Gabriele Monaco 2026-03-30  525  	return hrtimer_try_to_cancel(&ha_mon->hrtimer) == 1;
f5587d1b6ec938a Gabriele Monaco 2026-03-30  526  }
700782ec8f6589c Gabriele Monaco 2026-06-01  527  static inline void ha_cancel_timer_sync(struct ha_monitor *ha_mon)
700782ec8f6589c Gabriele Monaco 2026-06-01  528  {
700782ec8f6589c Gabriele Monaco 2026-06-01  529  	hrtimer_cancel(&ha_mon->hrtimer);
700782ec8f6589c Gabriele Monaco 2026-06-01  530  }
f5587d1b6ec938a Gabriele Monaco 2026-03-30  531  #else /* HA_TIMER_NONE */
f5587d1b6ec938a Gabriele Monaco 2026-03-30  532  /*
f5587d1b6ec938a Gabriele Monaco 2026-03-30  533   * Start function is intentionally not defined, monitors using timers must
f5587d1b6ec938a Gabriele Monaco 2026-03-30  534   * set HA_TIMER_TYPE to either HA_TIMER_WHEEL or HA_TIMER_HRTIMER.
f5587d1b6ec938a Gabriele Monaco 2026-03-30  535   */
f5587d1b6ec938a Gabriele Monaco 2026-03-30  536  static inline void ha_setup_timer(struct ha_monitor *ha_mon) { }
f5587d1b6ec938a Gabriele Monaco 2026-03-30  537  static inline bool ha_cancel_timer(struct ha_monitor *ha_mon)
f5587d1b6ec938a Gabriele Monaco 2026-03-30  538  {
f5587d1b6ec938a Gabriele Monaco 2026-03-30  539  	return false;
f5587d1b6ec938a Gabriele Monaco 2026-03-30  540  }
700782ec8f6589c Gabriele Monaco 2026-06-01  541  static inline void ha_cancel_timer_sync(struct ha_monitor *ha_mon) { }
f5587d1b6ec938a Gabriele Monaco 2026-03-30  542  #endif
f5587d1b6ec938a Gabriele Monaco 2026-03-30  543  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
