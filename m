Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794090923;
	b=FqhdJN/HrKNGB0AmulyYoAl9gPh6DO9BNfUhH2+8aKYZOBks01RbCGRtDOuPI9kAkpgc
	 8eIxknrmQxf9Wda8vgRUDIiFkjHfIy3EvFr7ZyPtNys7JXIx/eAK1HGIxphliOXqq2EEo
	 7Gyd1gytDflRBGm1yGg0/IMLS4G8tiVjskX4pTGJmxR/fi5EF0yxtUj8BZ6nSeGTc3VJz
	 KZp12U9WmPX780roB4DStF3tSuWKHcv6++jofj3JvsWmqJRK79SxLx1l9WrshNd+aiQdK
	 JKGZQ+YAabgIEBzmQc9E348H0fK9gJ5d4KPFCkPEO2WTBTSAxHjEU3F6lAWqi/h8LSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794090923;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=fCU+AnXPgEumMAh4YcQYLrSJUtCBY0mNsJe/Mw2nKg4=;
	b=Wg2xmhA0MSCxSXusvzUKPSNvjflJpxJL9k4scMa2SYVG1exECJSwhDO25y/wkyntfnLJ
	 arb7IHBbx1otQ064dypFZzPE5P+aaFOnFdr5lOJlxLX4mWupCHxqGwnVTMSqZI2r5YN7K
	 WUuqChcHJqEdmPJZ+TU8q19MmHRXHfFUnmbwD/fAdP6DfklQ0ftSMo91Yqsuo8u0cxgJA
	 0W3qT2lYQkTqpaHJy05LXkik+QPU+UxyzMLX/2S15f3q8u/4MnULslcsfPNZtopAY3hJg
	 7/tTdcwVUDI2AZs1dwOvUtvquE2PXvl5iBqcm4bWnAo8vOVTbIP7DzZaow3kIIfhicg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="e3MJ/f0L";
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EBA606A32D;
	Sat,  7 Nov 2026 22:35:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0EBA606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=e3MJ/f0L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794090923; x=1825626923;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XKPddSDGRmFTP15jF36GhiF3Ao2V9Pc70VbIn1MNsig=;
  b=e3MJ/f0LA5EWkswm9yUNDq8odrbeZqadOcfnd8Bufu6kL/kHEty9Vax8
   wITBl2ezE1fnzOB3dwWjR8ZHEuGp7nMzLzocVBEFBbk0PMYFchlrQOoey
   NjawVPFM4aoUctna3TVnwNy30QHsHuH/wpfH8VQHkNr7BkgFXVx/BJHJ/
   BA8hodK+xTOHoxAM92OIgOjEaYfckqSkiiWA062WuveJoPDbE/tk0qloD
   WzXAmH38X3EqEHdAYEQMnR8iDoO4TQHFM6nrIvnurTHnAYS9MlydJELim
   Gqxg2us1p4BwqjkVhaBqUZc2onIld0eHLvOPEsTA4Bee8UGUdDlts9ZJO
   Q==;
X-CSE-ConnectionGUID: S1Tits+5SjaCKzX3FDfaWQ==
X-CSE-MsgGUID: jVzLMK++Rvun3p7grwLypQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11959"; a="2753746"
X-IronPort-AV: E=Sophos;i="6.27,200,1787036400"; 
   d="scan'208";a="2753746"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2026 14:35:22 -0800
X-CSE-ConnectionGUID: DnPjUlIZRoGuk9BZS7accg==
X-CSE-MsgGUID: D/3AICiJQqaSxkwaUn/bUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,200,1787036400"; 
   d="scan'208";a="7425429"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 07 Nov 2026 14:35:19 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xPp0F-00000000rfT-2sqR;
	Sat, 07 Nov 2026 22:35:15 +0000
Date: Sun, 8 Nov 2026 06:35:01 +0800
From: kernel test robot <lkp@intel.com>
To: Li Pengfei <ljdlns1987@gmail.com>, rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, mathieu.desnoyers@efficios.com,
	mark.rutland@arm.com, corbet@lwn.net, skhan@linuxfoundation.org,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	zhangbo56@xiaomi.com, lipengfei28@xiaomi.com, lkp@intel.com
Subject: Re: [PATCH v8 2/5] tracing: Use the stackmap from the ftrace stack
 recording path
Message-ID: <202611080654.sqFxIlwl-lkp@intel.com>
References: <20261107055139.3138633-3-lipengfei28@xiaomi.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261107055139.3138633-3-lipengfei28@xiaomi.com>

Hi Li,

kernel test robot noticed the following build errors:

[auto build test ERROR on 4539944e515183668109bdf4d0c3d7d228383d88]

url:    https://github.com/intel-lab-lkp/linux/commits/Li-Pengfei/tracing-Add-lock-free-stackmap-for-stack-trace-deduplication/20261107-135135
base:   4539944e515183668109bdf4d0c3d7d228383d88
patch link:    https://lore.kernel.org/r/20261107055139.3138633-3-lipengfei28%40xiaomi.com
patch subject: [PATCH v8 2/5] tracing: Use the stackmap from the ftrace stack recording path
config: powerpc-randconfig-1001-20261108 (https://download.01.org/0day-ci/archive/20261108/202611080654.sqFxIlwl-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261108/202611080654.sqFxIlwl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611080654.sqFxIlwl-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/rbtree.h:24,
                    from include/linux/mm_types.h:11,
                    from include/linux/mmzone.h:22,
                    from include/linux/gfp.h:7,
                    from include/linux/mm.h:8,
                    from include/linux/ring_buffer.h:5,
                    from kernel/trace/trace.c:15:
   kernel/trace/trace.c: In function 'record_stackmap':
>> include/linux/rcupdate.h:502:9: error: dereferencing pointer to incomplete type 'struct ftrace_stackmap'
     typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
            ^
   include/linux/rcupdate.h:684:2: note: in expansion of macro '__rcu_dereference_check'
     __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
     ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:758:34: note: in expansion of macro 'rcu_dereference_sched_check'
    #define rcu_dereference_sched(p) rcu_dereference_sched_check(p, 0)
                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/trace/trace.c:2154:9: note: in expansion of macro 'rcu_dereference_sched'
     smap = rcu_dereference_sched(tr->stackmap);
            ^~~~~~~~~~~~~~~~~~~~~


vim +502 include/linux/rcupdate.h

76c8eaafe4f061f Paul E. McKenney        2021-04-21  492  
24ba53017e188e0 Chun-Hung Tseng         2021-09-15  493  #define __rcu_access_pointer(p, local, space) \
ca5ecddfa8fcbd9 Paul E. McKenney        2010-04-28  494  ({ \
24ba53017e188e0 Chun-Hung Tseng         2021-09-15  495  	typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
423a86a610cad12 Joel Fernandes (Google  2018-12-12  496) 	rcu_check_sparse(p, space); \
24ba53017e188e0 Chun-Hung Tseng         2021-09-15  497  	((typeof(*p) __force __kernel *)(local)); \
ca5ecddfa8fcbd9 Paul E. McKenney        2010-04-28  498  })
24ba53017e188e0 Chun-Hung Tseng         2021-09-15  499  #define __rcu_dereference_check(p, local, c, space) \
ca5ecddfa8fcbd9 Paul E. McKenney        2010-04-28  500  ({ \
ac59853c06993a4 Pranith Kumar           2014-11-13  501  	/* Dependency order vs. p above. */ \
24ba53017e188e0 Chun-Hung Tseng         2021-09-15 @502  	typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
f78f5b90c4ffa55 Paul E. McKenney        2015-06-18  503  	RCU_LOCKDEP_WARN(!(c), "suspicious rcu_dereference_check() usage"); \
423a86a610cad12 Joel Fernandes (Google  2018-12-12  504) 	rcu_check_sparse(p, space); \
24ba53017e188e0 Chun-Hung Tseng         2021-09-15  505  	((typeof(*p) __force __kernel *)(local)); \
ca5ecddfa8fcbd9 Paul E. McKenney        2010-04-28  506  })
24ba53017e188e0 Chun-Hung Tseng         2021-09-15  507  #define __rcu_dereference_protected(p, local, c, space) \
ca5ecddfa8fcbd9 Paul E. McKenney        2010-04-28  508  ({ \
f78f5b90c4ffa55 Paul E. McKenney        2015-06-18  509  	RCU_LOCKDEP_WARN(!(c), "suspicious rcu_dereference_protected() usage"); \
423a86a610cad12 Joel Fernandes (Google  2018-12-12  510) 	rcu_check_sparse(p, space); \
ca5ecddfa8fcbd9 Paul E. McKenney        2010-04-28  511  	((typeof(*p) __force __kernel *)(p)); \
ca5ecddfa8fcbd9 Paul E. McKenney        2010-04-28  512  })
24ba53017e188e0 Chun-Hung Tseng         2021-09-15  513  #define __rcu_dereference_raw(p, local) \
995f1405610bd84 Paul E. McKenney        2016-07-01  514  ({ \
995f1405610bd84 Paul E. McKenney        2016-07-01  515  	/* Dependency order vs. p above. */ \
24ba53017e188e0 Chun-Hung Tseng         2021-09-15  516  	typeof(p) local = READ_ONCE(p); \
24ba53017e188e0 Chun-Hung Tseng         2021-09-15  517  	((typeof(*p) __force __kernel *)(local)); \
995f1405610bd84 Paul E. McKenney        2016-07-01  518  })
24ba53017e188e0 Chun-Hung Tseng         2021-09-15  519  #define rcu_dereference_raw(p) __rcu_dereference_raw(p, __UNIQUE_ID(rcu))
ca5ecddfa8fcbd9 Paul E. McKenney        2010-04-28  520  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
