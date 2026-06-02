Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582FE367B66;
	Tue,  2 Jun 2026 21:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780436496; cv=none; b=Rkn3Y+34vF6nlk901TTTmXVP5pNtPvnJbU/rq7qvTB5K10HeQLjWPYo9+ZBhku4c5kYLLmrrMAcNt9ZM2AEtxe6MKL6uwZ3MQINLUO0f7J0MA/3FB5syFISvB+vl4El0qb0ZPVlsUk0OdSwkJl0u81mPi8rmgmTWfvUQSZo+uEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780436496; c=relaxed/simple;
	bh=OwBeBWqp0ejACJmyDBhHkGtcbDVk5yk1Z81Cki0KZe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qT7QfaJM9rISQ1Pnn2k86xT6FDvLnPpDoUkOPRrgT/a1P5izcKNvN3t+fffsa8URSZGHfh4nmtT+aOqzu5w4cYHKlISrndW3kmuTPJZm32Z1san+3Nxe71qNW5g0YJYi70K1ewSonMqRJsrjW4nHYcYp5pehvT5nmVhTs7l3G6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KkOPZNE/; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KkOPZNE/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780436495; x=1811972495;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OwBeBWqp0ejACJmyDBhHkGtcbDVk5yk1Z81Cki0KZe8=;
  b=KkOPZNE/rMPn32jneKOFdhpHB4EmfhKt+3UZ67vf3tOBEVRnoGh7jUfV
   vAcB5kjoFk0LM0XkmmIvBJAJgtvr3SF+tjz6kvSN1Y5gMhCajYKmYfvr0
   43vuEmNb8Esvhd+saYb16z1R0W+2JFJvgTHdQaTvKmXA7jWcQIrFt6ali
   6z/48l2P7LXRbo9bmjn2zlKyPmu0NlnJs+/MPsJCG/Tv/FTCOFJEBBewt
   mpe4OwHsLwgHhwi3CXGBBgdk6BqbWHc2WU2bsA1294qc7ynVINuOcuV0j
   QDYLyBpfABXqM38KfX0Lv4A9Qd1n36Yr1Fs9HpiK9fpmfGDMLF5FYFbOK
   Q==;
X-CSE-ConnectionGUID: 1X10/kurQOWwItgtD+MKUQ==
X-CSE-MsgGUID: 58hExWiOQQ+NJycARke/dw==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="91546386"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="91546386"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 14:41:34 -0700
X-CSE-ConnectionGUID: H8Qi5GAyQlaMzgBpD1Kf9w==
X-CSE-MsgGUID: A5W7Rr/NS9qC/41ZTRLg5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="267893782"
Received: from igk-lkp-server01.igk.intel.com (HELO 892db79562d4) ([10.211.93.152])
  by fmviesa001.fm.intel.com with ESMTP; 02 Jun 2026 14:41:31 -0700
Received: from kbuild by 892db79562d4 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wUWrZ-000000001rh-02rS;
	Tue, 02 Jun 2026 21:41:29 +0000
Date: Tue, 2 Jun 2026 23:40:51 +0200
From: kernel test robot <lkp@intel.com>
To: Eva Kurchatova <eva.kurchatova@virtuozzo.com>, mhiramat@kernel.org,
	rostedt@goodmis.org
Cc: oe-kbuild-all@lists.linux.dev, linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
	peterz@infradead.org, jpoimboe@kernel.org, samitolvanen@google.com,
	eva.kurchatova@virtuozzo.com
Subject: Re: [PATCH v2] tracing: fix CFI violation in probestub test
Message-ID: <202606022312.7cKiQBmg-lkp@intel.com>
References: <20260602135425.542073-1-eva.kurchatova@virtuozzo.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602135425.542073-1-eva.kurchatova@virtuozzo.com>

Hi Eva,

kernel test robot noticed the following build errors:

[auto build test ERROR on trace/for-next]
[also build test ERROR on linus/master v6.16-rc1 next-20260602]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Eva-Kurchatova/tracing-fix-CFI-violation-in-probestub-test/20260602-222302
base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
patch link:    https://lore.kernel.org/r/20260602135425.542073-1-eva.kurchatova%40virtuozzo.com
patch subject: [PATCH v2] tracing: fix CFI violation in probestub test
config: x86_64-rhel-9.4-kselftests (https://download.01.org/0day-ci/archive/20260602/202606022312.7cKiQBmg-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260602/202606022312.7cKiQBmg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606022312.7cKiQBmg-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/dma-buf/sync_trace.h:10,
                    from drivers/dma-buf/sw_sync.c:18:
   include/linux/tracepoint.h:403:9: warning: data definition has no type or storage class
     403 |         CFI_NOSEAL(__probestub_##_name);                                \
         |         ^~~~~~~~~~
   include/linux/tracepoint.h:424:9: note: in expansion of macro '__DEFINE_TRACE_EXT'
     424 |         __DEFINE_TRACE_EXT(_name, NULL, PARAMS(_proto), PARAMS(_args));
         |         ^~~~~~~~~~~~~~~~~~
   include/trace/define_trace.h:28:9: note: in expansion of macro 'DEFINE_TRACE'
      28 |         DEFINE_TRACE(name, PARAMS(proto), PARAMS(args))
         |         ^~~~~~~~~~~~
   include/trace/../../drivers/dma-buf/sync_trace.h:12:1: note: in expansion of macro 'TRACE_EVENT'
      12 | TRACE_EVENT(sync_timeline,
         | ^~~~~~~~~~~
   include/linux/tracepoint.h:403:9: error: type defaults to 'int' in declaration of 'CFI_NOSEAL' [-Wimplicit-int]
     403 |         CFI_NOSEAL(__probestub_##_name);                                \
         |         ^~~~~~~~~~
   include/linux/tracepoint.h:424:9: note: in expansion of macro '__DEFINE_TRACE_EXT'
     424 |         __DEFINE_TRACE_EXT(_name, NULL, PARAMS(_proto), PARAMS(_args));
         |         ^~~~~~~~~~~~~~~~~~
   include/trace/define_trace.h:28:9: note: in expansion of macro 'DEFINE_TRACE'
      28 |         DEFINE_TRACE(name, PARAMS(proto), PARAMS(args))
         |         ^~~~~~~~~~~~
   include/trace/../../drivers/dma-buf/sync_trace.h:12:1: note: in expansion of macro 'TRACE_EVENT'
      12 | TRACE_EVENT(sync_timeline,
         | ^~~~~~~~~~~
>> include/trace/../../drivers/dma-buf/sync_trace.h:13:25: error: parameter names (without types) in function declaration [-Wdeclaration-missing-parameter-type]
      13 |         TP_PROTO(struct sync_timeline *timeline),
         |                         ^~~~~~~~~~~~~
   include/linux/tracepoint.h:394:48: note: in definition of macro '__DEFINE_TRACE_EXT'
     394 |         void __probestub_##_name(void *__data, proto)                   \
         |                                                ^~~~~
   include/linux/tracepoint.h:424:41: note: in expansion of macro 'PARAMS'
     424 |         __DEFINE_TRACE_EXT(_name, NULL, PARAMS(_proto), PARAMS(_args));
         |                                         ^~~~~~
   include/trace/define_trace.h:28:9: note: in expansion of macro 'DEFINE_TRACE'
      28 |         DEFINE_TRACE(name, PARAMS(proto), PARAMS(args))
         |         ^~~~~~~~~~~~
   include/trace/define_trace.h:28:28: note: in expansion of macro 'PARAMS'
      28 |         DEFINE_TRACE(name, PARAMS(proto), PARAMS(args))
         |                            ^~~~~~
   include/trace/../../drivers/dma-buf/sync_trace.h:12:1: note: in expansion of macro 'TRACE_EVENT'
      12 | TRACE_EVENT(sync_timeline,
         | ^~~~~~~~~~~
   include/trace/../../drivers/dma-buf/sync_trace.h:13:9: note: in expansion of macro 'TP_PROTO'
      13 |         TP_PROTO(struct sync_timeline *timeline),
         |         ^~~~~~~~
--
   In file included from include/trace/events/lock.h:9,
                    from kernel/locking/mutex.c:35:
   include/linux/tracepoint.h:403:9: warning: data definition has no type or storage class
     403 |         CFI_NOSEAL(__probestub_##_name);                                \
         |         ^~~~~~~~~~
   include/linux/tracepoint.h:424:9: note: in expansion of macro '__DEFINE_TRACE_EXT'
     424 |         __DEFINE_TRACE_EXT(_name, NULL, PARAMS(_proto), PARAMS(_args));
         |         ^~~~~~~~~~~~~~~~~~
   include/trace/define_trace.h:28:9: note: in expansion of macro 'DEFINE_TRACE'
      28 |         DEFINE_TRACE(name, PARAMS(proto), PARAMS(args))
         |         ^~~~~~~~~~~~
   include/trace/events/lock.h:24:1: note: in expansion of macro 'TRACE_EVENT'
      24 | TRACE_EVENT(lock_acquire,
         | ^~~~~~~~~~~
   include/linux/tracepoint.h:403:9: error: type defaults to 'int' in declaration of 'CFI_NOSEAL' [-Wimplicit-int]
     403 |         CFI_NOSEAL(__probestub_##_name);                                \
         |         ^~~~~~~~~~
   include/linux/tracepoint.h:424:9: note: in expansion of macro '__DEFINE_TRACE_EXT'
     424 |         __DEFINE_TRACE_EXT(_name, NULL, PARAMS(_proto), PARAMS(_args));
         |         ^~~~~~~~~~~~~~~~~~
   include/trace/define_trace.h:28:9: note: in expansion of macro 'DEFINE_TRACE'
      28 |         DEFINE_TRACE(name, PARAMS(proto), PARAMS(args))
         |         ^~~~~~~~~~~~
   include/trace/events/lock.h:24:1: note: in expansion of macro 'TRACE_EVENT'
      24 | TRACE_EVENT(lock_acquire,
         | ^~~~~~~~~~~
>> include/trace/events/lock.h:28:24: error: parameter names (without types) in function declaration [-Wdeclaration-missing-parameter-type]
      28 |                 struct lockdep_map *next_lock, unsigned long ip),
         |                        ^~~~~~~~~~~
   include/linux/tracepoint.h:394:48: note: in definition of macro '__DEFINE_TRACE_EXT'
     394 |         void __probestub_##_name(void *__data, proto)                   \
         |                                                ^~~~~
   include/linux/tracepoint.h:424:41: note: in expansion of macro 'PARAMS'
     424 |         __DEFINE_TRACE_EXT(_name, NULL, PARAMS(_proto), PARAMS(_args));
         |                                         ^~~~~~
   include/trace/define_trace.h:28:9: note: in expansion of macro 'DEFINE_TRACE'
      28 |         DEFINE_TRACE(name, PARAMS(proto), PARAMS(args))
         |         ^~~~~~~~~~~~
   include/trace/define_trace.h:28:28: note: in expansion of macro 'PARAMS'
      28 |         DEFINE_TRACE(name, PARAMS(proto), PARAMS(args))
         |                            ^~~~~~
   include/trace/events/lock.h:24:1: note: in expansion of macro 'TRACE_EVENT'
      24 | TRACE_EVENT(lock_acquire,
         | ^~~~~~~~~~~
   include/trace/events/lock.h:26:9: note: in expansion of macro 'TP_PROTO'
      26 |         TP_PROTO(struct lockdep_map *lock, unsigned int subclass,
         |         ^~~~~~~~
   include/linux/tracepoint.h:403:9: warning: data definition has no type or storage class
     403 |         CFI_NOSEAL(__probestub_##_name);                                \
         |         ^~~~~~~~~~
   include/linux/tracepoint.h:424:9: note: in expansion of macro '__DEFINE_TRACE_EXT'
     424 |         __DEFINE_TRACE_EXT(_name, NULL, PARAMS(_proto), PARAMS(_args));
         |         ^~~~~~~~~~~~~~~~~~
   include/trace/define_trace.h:61:9: note: in expansion of macro 'DEFINE_TRACE'
      61 |         DEFINE_TRACE(name, PARAMS(proto), PARAMS(args))
         |         ^~~~~~~~~~~~
   include/trace/events/lock.h:69:1: note: in expansion of macro 'DEFINE_EVENT'
      69 | DEFINE_EVENT(lock, lock_release,
         | ^~~~~~~~~~~~
   include/linux/tracepoint.h:403:9: error: type defaults to 'int' in declaration of 'CFI_NOSEAL' [-Wimplicit-int]
     403 |         CFI_NOSEAL(__probestub_##_name);                                \
         |         ^~~~~~~~~~
   include/linux/tracepoint.h:424:9: note: in expansion of macro '__DEFINE_TRACE_EXT'
     424 |         __DEFINE_TRACE_EXT(_name, NULL, PARAMS(_proto), PARAMS(_args));
         |         ^~~~~~~~~~~~~~~~~~
   include/trace/define_trace.h:61:9: note: in expansion of macro 'DEFINE_TRACE'
      61 |         DEFINE_TRACE(name, PARAMS(proto), PARAMS(args))
         |         ^~~~~~~~~~~~
   include/trace/events/lock.h:69:1: note: in expansion of macro 'DEFINE_EVENT'
      69 | DEFINE_EVENT(lock, lock_release,
         | ^~~~~~~~~~~~
   include/trace/events/lock.h:71:25: error: parameter names (without types) in function declaration [-Wdeclaration-missing-parameter-type]
      71 |         TP_PROTO(struct lockdep_map *lock, unsigned long ip),
         |                         ^~~~~~~~~~~
   include/linux/tracepoint.h:394:48: note: in definition of macro '__DEFINE_TRACE_EXT'
     394 |         void __probestub_##_name(void *__data, proto)                   \
         |                                                ^~~~~
   include/linux/tracepoint.h:424:41: note: in expansion of macro 'PARAMS'
     424 |         __DEFINE_TRACE_EXT(_name, NULL, PARAMS(_proto), PARAMS(_args));
         |                                         ^~~~~~
   include/trace/define_trace.h:61:9: note: in expansion of macro 'DEFINE_TRACE'
      61 |         DEFINE_TRACE(name, PARAMS(proto), PARAMS(args))
         |         ^~~~~~~~~~~~
   include/trace/define_trace.h:61:28: note: in expansion of macro 'PARAMS'
      61 |         DEFINE_TRACE(name, PARAMS(proto), PARAMS(args))
         |                            ^~~~~~
   include/trace/events/lock.h:69:1: note: in expansion of macro 'DEFINE_EVENT'
      69 | DEFINE_EVENT(lock, lock_release,
         | ^~~~~~~~~~~~
   include/trace/events/lock.h:71:9: note: in expansion of macro 'TP_PROTO'
      71 |         TP_PROTO(struct lockdep_map *lock, unsigned long ip),
         |         ^~~~~~~~
   include/linux/tracepoint.h:403:9: warning: data definition has no type or storage class
     403 |         CFI_NOSEAL(__probestub_##_name);                                \
         |         ^~~~~~~~~~
   include/linux/tracepoint.h:424:9: note: in expansion of macro '__DEFINE_TRACE_EXT'
     424 |         __DEFINE_TRACE_EXT(_name, NULL, PARAMS(_proto), PARAMS(_args));
         |         ^~~~~~~~~~~~~~~~~~
   include/trace/define_trace.h:28:9: note: in expansion of macro 'DEFINE_TRACE'
      28 |         DEFINE_TRACE(name, PARAMS(proto), PARAMS(args))
         |         ^~~~~~~~~~~~
   include/trace/events/lock.h:95:1: note: in expansion of macro 'TRACE_EVENT'
      95 | TRACE_EVENT(contention_begin,
         | ^~~~~~~~~~~
   include/linux/tracepoint.h:403:9: error: type defaults to 'int' in declaration of 'CFI_NOSEAL' [-Wimplicit-int]
     403 |         CFI_NOSEAL(__probestub_##_name);                                \
         |         ^~~~~~~~~~
   include/linux/tracepoint.h:424:9: note: in expansion of macro '__DEFINE_TRACE_EXT'
     424 |         __DEFINE_TRACE_EXT(_name, NULL, PARAMS(_proto), PARAMS(_args));
         |         ^~~~~~~~~~~~~~~~~~
   include/trace/define_trace.h:28:9: note: in expansion of macro 'DEFINE_TRACE'
      28 |         DEFINE_TRACE(name, PARAMS(proto), PARAMS(args))
         |         ^~~~~~~~~~~~
   include/trace/events/lock.h:95:1: note: in expansion of macro 'TRACE_EVENT'
      95 | TRACE_EVENT(contention_begin,
         | ^~~~~~~~~~~
   include/linux/tracepoint.h:380:24: error: parameter names (without types) in function declaration [-Wdeclaration-missing-parameter-type]
     380 |                 struct tracepoint_func *it_func_ptr;                    \
         |                        ^~~~~~~~~~~~~~~
   include/linux/tracepoint.h:424:9: note: in expansion of macro '__DEFINE_TRACE_EXT'
     424 |         __DEFINE_TRACE_EXT(_name, NULL, PARAMS(_proto), PARAMS(_args));
         |         ^~~~~~~~~~~~~~~~~~
   include/trace/define_trace.h:28:9: note: in expansion of macro 'DEFINE_TRACE'
      28 |         DEFINE_TRACE(name, PARAMS(proto), PARAMS(args))
         |         ^~~~~~~~~~~~
   include/trace/events/lock.h:95:1: note: in expansion of macro 'TRACE_EVENT'
      95 | TRACE_EVENT(contention_begin,


vim +13 include/trace/../../drivers/dma-buf/sync_trace.h

b699a644f82110e drivers/staging/android/trace/sync.h Erik Gilling            2013-02-28  11  
b699a644f82110e drivers/staging/android/trace/sync.h Erik Gilling            2013-02-28  12  TRACE_EVENT(sync_timeline,
b699a644f82110e drivers/staging/android/trace/sync.h Erik Gilling            2013-02-28 @13  	TP_PROTO(struct sync_timeline *timeline),
b699a644f82110e drivers/staging/android/trace/sync.h Erik Gilling            2013-02-28  14  
b699a644f82110e drivers/staging/android/trace/sync.h Erik Gilling            2013-02-28  15  	TP_ARGS(timeline),
b699a644f82110e drivers/staging/android/trace/sync.h Erik Gilling            2013-02-28  16  
b699a644f82110e drivers/staging/android/trace/sync.h Erik Gilling            2013-02-28  17  	TP_STRUCT__entry(
b699a644f82110e drivers/staging/android/trace/sync.h Erik Gilling            2013-02-28  18  			__string(name, timeline->name)
5c1401f83a16b7e drivers/staging/android/trace/sync.h Gustavo Padovan         2016-05-31  19  			__field(u32, value)
b699a644f82110e drivers/staging/android/trace/sync.h Erik Gilling            2013-02-28  20  	),
b699a644f82110e drivers/staging/android/trace/sync.h Erik Gilling            2013-02-28  21  
b699a644f82110e drivers/staging/android/trace/sync.h Erik Gilling            2013-02-28  22  	TP_fast_assign(
2c92ca849fcc6ee drivers/dma-buf/sync_trace.h         Steven Rostedt (Google  2024-05-16  23) 			__assign_str(name);
5c1401f83a16b7e drivers/staging/android/trace/sync.h Gustavo Padovan         2016-05-31  24  			__entry->value = timeline->value;
b699a644f82110e drivers/staging/android/trace/sync.h Erik Gilling            2013-02-28  25  	),
b699a644f82110e drivers/staging/android/trace/sync.h Erik Gilling            2013-02-28  26  
5c1401f83a16b7e drivers/staging/android/trace/sync.h Gustavo Padovan         2016-05-31  27  	TP_printk("name=%s value=%d", __get_str(name), __entry->value)
b699a644f82110e drivers/staging/android/trace/sync.h Erik Gilling            2013-02-28  28  );
b699a644f82110e drivers/staging/android/trace/sync.h Erik Gilling            2013-02-28  29  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
