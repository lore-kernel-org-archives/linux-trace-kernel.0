Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDD3B64E;
	Wed, 24 Jul 2024 01:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721785936; cv=none; b=JDgaaqtk79RHjDnwP851LBizGX6uA15sKufd5lYE7ryq9zq+Zz4WhZLX7MqoXt8YC5smvh1Z7fzZF7z9oKBknxUTByKOUugsuPTrkVoo+zdqLWWR0eSt1kVCfk6mBCsys7mYs3udRspk4Z8x8dtPxbL420aQ5MXJisZoUTGUo9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721785936; c=relaxed/simple;
	bh=k34t01LkMp1q9T6X0EjQqujZrfykOeuKZyy94bQtjQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U9WKeZ5iFoEpnYUFrmhL93nRj7Z3e95HgyT+t2I5eLjhCMJOitZvxWW9S0U4fRdJ/NVTKnRrIGVr2Q43Dte3oEDWK+yxn7D/J52+YLWqYDx/kmmxtNNlJghJ27FW3EAG/uGrMGz1rrEf6+Oln5jJXW7aJMJSeiaHI7Ftjlc0A+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EJkHbiX3; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EJkHbiX3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721785932; x=1753321932;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k34t01LkMp1q9T6X0EjQqujZrfykOeuKZyy94bQtjQI=;
  b=EJkHbiX3JDBy1dHZcwmP/m7UseIKwQ+0SUvnQy+NAaa8IdtnYPmUcilt
   it0VheQwv7ZHmWQQoyQhbpJL3eBCSU/qECqhwr/ZUHImO8H3n/Megflt9
   uTFGyNHhVAgmnvRahOTvnC199pQ85HKnqCStkp4GNpzPHRp6DFJebzqPE
   UqA7SvC9ZuRSWo+EkV04yw3/O7Xq1iwQdu5NWGN1Is2MUzy99KzjCJEm5
   Z6G5onAmYE4ZmhkVqRQq9DrJ5UpYV8bUyFsHLokfr2tKwecPhPbcLWeje
   GQKHydKKuEt09Zt86mG501fFkgc0CnkyN2ooHglb5GbOs1GWA/fx9p3Hd
   w==;
X-CSE-ConnectionGUID: XlUcYYtVRkSXPhrKhUtOjg==
X-CSE-MsgGUID: z3orSOJkTfadt2azw0Xhdw==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="19292054"
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; 
   d="scan'208";a="19292054"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 18:52:09 -0700
X-CSE-ConnectionGUID: 3M3I0rCOSS+SjcWbeTEXaw==
X-CSE-MsgGUID: AWnrr6hTQ9mfiSyDG5Uyxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; 
   d="scan'208";a="57246154"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 23 Jul 2024 18:52:01 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sWRAc-000mXw-0n;
	Wed, 24 Jul 2024 01:51:58 +0000
Date: Wed, 24 Jul 2024 09:51:56 +0800
From: kernel test robot <lkp@intel.com>
To: Zheng Yejian <zhengyejian@huaweicloud.com>, masahiroy@kernel.org,
	peterz@infradead.org, rostedt@goodmis.org, mhiramat@kernel.org,
	mark.rutland@arm.com, mpe@ellerman.id.au, npiggin@gmail.com,
	christophe.leroy@csgroup.eu, naveen.n.rao@linux.ibm.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, mcgrof@kernel.org,
	mathieu.desnoyers@efficios.com, nathan@kernel.org,
	nicolas@fjasle.eu, ojeda@kernel.org, akpm@linux-foundation.org,
	surenb@google.com, pasha.tatashin@soleen.com,
	kent.overstreet@linux.dev, james.clark@arm.com, jpoimboe@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-modules@vger.kernel.org
Subject: Re: [PATCH v2 1/5] kallsyms: Emit symbol at the holes in the text
Message-ID: <202407240921.tumLfzKa-lkp@intel.com>
References: <20240723063258.2240610-2-zhengyejian@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723063258.2240610-2-zhengyejian@huaweicloud.com>

Hi Zheng,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.10]
[cannot apply to mcgrof/modules-next masahiroy-kbuild/for-next masahiroy-kbuild/fixes powerpc/next powerpc/fixes tip/x86/core next-20240723]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zheng-Yejian/kallsyms-Emit-symbol-at-the-holes-in-the-text/20240723-152513
base:   linus/master
patch link:    https://lore.kernel.org/r/20240723063258.2240610-2-zhengyejian%40huaweicloud.com
patch subject: [PATCH v2 1/5] kallsyms: Emit symbol at the holes in the text
config: i386-randconfig-002-20240724 (https://download.01.org/0day-ci/archive/20240724/202407240921.tumLfzKa-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240724/202407240921.tumLfzKa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407240921.tumLfzKa-lkp@intel.com/

All warnings (new ones prefixed by >>):

   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/locking/locktorture.ko needs unknown symbol strcmp
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/locking/locktorture.ko needs unknown symbol _printk
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/locking/locktorture.ko needs unknown symbol strlen
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/locking/locktorture.ko needs unknown symbol strncmp
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/locking/locktorture.ko needs unknown symbol __kmalloc_noprof
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/locking/locktorture.ko needs unknown symbol call_rcu
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/locking/locktorture.ko needs unknown symbol sched_set_fifo
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/locking/locktorture.ko needs unknown symbol torture_sched_setaffinity
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/locking/locktorture.ko needs unknown symbol kfree
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/locking/locktorture.ko needs unknown symbol kernel_power_off
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/locking/locktorture.ko needs unknown symbol rcu_barrier
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/locking/locktorture.ko needs unknown symbol bitmap_parselist
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/locking/locktorture.ko needs unknown symbol sprintf
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/locking/locktorture.ko needs unknown symbol pcpu_hot
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/locking/locktorture.ko needs unknown symbol set_user_nice
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/locking/locktorture.ko needs unknown symbol schedule_timeout_uninterruptible
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/locking/locktorture.ko needs unknown symbol jiffies
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/locking/locktorture.ko needs unknown symbol __warn_printk
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/locking/locktorture.ko needs unknown symbol schedule_timeout_interruptible
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/locking/locktorture.ko needs unknown symbol __const_udelay
>> depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/locking/locktorture.ko needs unknown symbol __SCT__preempt_schedule
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/locking/locktorture.ko needs unknown symbol sched_set_normal
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/locking/locktorture.ko needs unknown symbol _raw_spin_lock
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/locking/locktorture.ko needs unknown symbol _raw_spin_unlock
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/locking/locktorture.ko needs unknown symbol _raw_spin_lock_irqsave
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/locking/locktorture.ko needs unknown symbol _raw_spin_unlock_irqrestore
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/locking/locktorture.ko needs unknown symbol _raw_write_lock
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/locking/locktorture.ko needs unknown symbol _raw_write_unlock
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/locking/locktorture.ko needs unknown symbol _raw_read_lock
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/locking/locktorture.ko needs unknown symbol _raw_read_unlock
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/locking/locktorture.ko needs unknown symbol _raw_write_lock_irqsave
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/locking/locktorture.ko needs unknown symbol _raw_write_unlock_irqrestore
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/locking/locktorture.ko needs unknown symbol _raw_read_lock_irqsave
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/locking/locktorture.ko needs unknown symbol _raw_read_unlock_irqrestore
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/locking/locktorture.ko needs unknown symbol __mutex_init
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/locking/locktorture.ko needs unknown symbol mutex_lock_nested
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/locking/locktorture.ko needs unknown symbol __ubsan_handle_out_of_bounds
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/locking/locktorture.ko needs unknown symbol __ubsan_handle_shift_out_of_bounds
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/locking/locktorture.ko needs unknown symbol mutex_unlock
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/locking/locktorture.ko needs unknown symbol debug_check_no_locks_freed
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/locking/locktorture.ko needs unknown symbol lockdep_init_map_type
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/locking/locktorture.ko needs unknown symbol lock_acquire
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/locking/locktorture.ko needs unknown symbol __list_add_valid_or_report
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/locking/locktorture.ko needs unknown symbol ww_mutex_lock
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/locking/locktorture.ko needs unknown symbol ww_mutex_unlock
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/locking/locktorture.ko needs unknown symbol oops_in_progress
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/locking/locktorture.ko needs unknown symbol __list_del_entry_valid_or_report
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/locking/locktorture.ko needs unknown symbol debug_locks_off
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/locking/locktorture.ko needs unknown symbol debug_locks_silent
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/locking/locktorture.ko needs unknown symbol lock_release
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/locking/locktorture.ko needs unknown symbol __rt_mutex_init
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/locking/locktorture.ko needs unknown symbol rt_mutex_lock_nested
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/locking/locktorture.ko needs unknown symbol rt_mutex_unlock
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/locking/locktorture.ko needs unknown symbol down_write
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/locking/locktorture.ko needs unknown symbol up_write
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/locking/locktorture.ko needs unknown symbol down_read
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/locking/locktorture.ko needs unknown symbol up_read
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/locking/locktorture.ko needs unknown symbol __percpu_init_rwsem
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/locking/locktorture.ko needs unknown symbol __ubsan_handle_builtin_unreachable
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/locking/locktorture.ko needs unknown symbol percpu_free_rwsem
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/locking/locktorture.ko needs unknown symbol percpu_down_write
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/locking/locktorture.ko needs unknown symbol percpu_up_write
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/locking/locktorture.ko needs unknown symbol __might_sleep
>> depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/locking/locktorture.ko needs unknown symbol __SCT__might_resched
>> depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/locking/locktorture.ko needs unknown symbol preempt_count_add
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/locking/locktorture.ko needs unknown symbol debug_lockdep_rcu_enabled
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/locking/locktorture.ko needs unknown symbol rcu_read_lock_any_held
>> depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/locking/locktorture.ko needs unknown symbol preempt_count_sub
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/locking/locktorture.ko needs unknown symbol lockdep_rcu_suspicious
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/locking/locktorture.ko needs unknown symbol __percpu_down_read
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/locking/locktorture.ko needs unknown symbol rcuwait_wake_up
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/locking/locktorture.ko needs unknown symbol start_poll_synchronize_rcu
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/locking/locktorture.ko needs unknown symbol param_ops_int
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/locking/locktorture.ko needs unknown symbol param_ops_charp
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol strcmp
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol _printk
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol srcu_check_nmi_safety
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol __srcu_read_lock
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol synchronize_srcu
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol __srcu_read_unlock
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol __ubsan_handle_out_of_bounds
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol down_read
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol up_read
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol down_write
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol up_write
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol pcpu_hot
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol rcu_trace_lock_map
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol synchronize_rcu_tasks_trace
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol rcu_read_unlock_trace_special
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol mutex_lock_nested
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol mutex_unlock
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol __warn_printk
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol __list_add_valid_or_report
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol __kmalloc_noprof
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol jiffies
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol __cpuhp_setup_state
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol kernel_power_off
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol __might_sleep
>> depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol __SCT__might_resched
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol init_wait_entry
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol prepare_to_wait_event
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol schedule
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol finish_wait
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol kfree
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol unregister_oom_notifier
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol rcu_get_gp_kthreads_prio
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol __cpuhp_remove_state
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol kmem_cache_create
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol kmem_cache_alloc_noprof
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol mem_dump_obj
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol kmem_cache_free
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol kmem_cache_destroy
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol kmalloc_caches
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol __kmalloc_cache_noprof
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol vmalloc_noprof
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol vfree
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol rcu_gp_is_expedited
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol rcu_gp_is_normal
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol _raw_spin_unlock_bh
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol _raw_spin_lock_bh
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol __udelay
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol debug_lockdep_rcu_enabled
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol rcu_read_lock_held
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol lockdep_rcu_suspicious
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol __list_del_entry_valid_or_report
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol rcu_unexpedite_gp
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol rcu_expedite_gp
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol rcu_inkernel_boot_has_ended
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol sched_set_normal
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol tracing_off
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol rcu_cpu_stall_suppress
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol ftrace_dump
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol __cpu_online_mask
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol set_user_nice
>> depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol init_timer_key
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol mod_timer
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol schedule_timeout_interruptible
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol timer_delete_sync
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol schedule_hrtimeout
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol kthread_should_stop
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol kthread_create_on_cpu
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol wake_up_process
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol __raw_spin_lock_init
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol register_oom_notifier
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol __init_waitqueue_head
>> depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol init_rcu_head_on_stack
>> depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol destroy_rcu_head_on_stack
>> depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol __rcu_read_lock
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol rcu_lock_map
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol rcu_is_watching
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol trace_clock_local
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol __const_udelay
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol do_trace_rcu_torture_read
>> depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol __SCT__preempt_schedule
>> depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol __rcu_read_unlock
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol rcu_read_lock_bh_held
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol rcu_read_lock_sched_held
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol call_rcu
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol lock_acquire
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol lock_release
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol lock_is_held_type
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol srcu_batches_completed
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol call_srcu
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol synchronize_srcu_expedited
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol get_state_synchronize_srcu
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol start_poll_synchronize_srcu
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol poll_state_synchronize_srcu
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol srcu_barrier
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol srcu_torture_stats_print
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol srcutorture_get_gp_data
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol __init_srcu_struct
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol cleanup_srcu_struct
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol call_rcu_tasks
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol __wait_rcu_gp
>> depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol preempt_count_add
>> depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol preempt_count_sub
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol call_rcu_tasks_rude
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol call_rcu_tasks_trace
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol cpu_bit_bitmap
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol torture_sched_setaffinity
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol memset
>> depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol __this_cpu_preempt_check
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol rcu_bh_lock_map
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol trace_hardirqs_off
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol rcu_sched_lock_map
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol trace_hardirqs_on
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol _raw_spin_lock_irqsave
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol _raw_spin_unlock_irqrestore
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol __local_bh_disable_ip
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol __local_bh_enable_ip
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol rcu_cpu_stall_suppress_at_boot
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol sched_show_task
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol sched_set_fifo_low
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol mutex_trylock
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol schedule_timeout_uninterruptible
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol rcu_cpu_stall_notifiers
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol rcu_gp_set_torture_wait
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol ktime_get_seconds
>> depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol preempt_schedule
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol touch_softlockup_watchdog
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol __might_resched
>> depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol __SCT__cond_resched
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol __ubsan_handle_divrem_overflow
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol rcu_fwd_progress_check
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol smp_call_on_cpu
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol __wake_up
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol kthread_create_on_node
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol kthread_stop
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol rcu_barrier
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol param_ops_int
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol param_ops_bool
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol param_ops_charp
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol delayed_work_timer_fn
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol rcu_get_gp_seq
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol synchronize_rcu
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol synchronize_rcu_expedited
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol get_state_synchronize_rcu
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol start_poll_synchronize_rcu_expedited
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol start_poll_synchronize_rcu_expedited_full
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol poll_state_synchronize_rcu
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol cond_synchronize_rcu_expedited
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol get_completed_synchronize_rcu
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol get_completed_synchronize_rcu_full
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol get_state_synchronize_rcu_full
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol start_poll_synchronize_rcu
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol start_poll_synchronize_rcu_full
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol poll_state_synchronize_rcu_full
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol cond_synchronize_rcu
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol cond_synchronize_rcu_full
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol rcu_force_quiescent_state
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol show_rcu_gp_kthreads
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol rcu_check_boost_fail
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol rcu_jiffies_till_stall_check
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol rcutorture_get_gp_data
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol rcu_gp_slow_register
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol rcu_gp_slow_unregister
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol synchronize_rcu_tasks
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol rcu_barrier_tasks
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol show_rcu_tasks_classic_gp_kthread
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol rcu_tasks_get_gp_data
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol synchronize_rcu_tasks_rude
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol rcu_barrier_tasks_rude
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol show_rcu_tasks_rude_gp_kthread
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol rcu_tasks_rude_get_gp_data
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol rcu_barrier_tasks_trace
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol show_rcu_tasks_trace_gp_kthread
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcutorture.ko needs unknown symbol rcu_tasks_trace_get_gp_data
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol strcmp
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol _printk
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol __init_waitqueue_head
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol schedule_timeout_uninterruptible
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol __kmalloc_noprof
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol __kmalloc_large_noprof
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol kernel_power_off
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol rcu_gp_is_expedited
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol rcu_gp_is_normal
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol kfree
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol show_rcu_gp_kthreads
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol __might_sleep
>> depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol __SCT__might_resched
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol init_wait_entry
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol prepare_to_wait_event
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol schedule
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol finish_wait
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol pcpu_hot
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol set_user_nice
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol trace_hardirqs_off
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol trace_hardirqs_on
>> depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol warn_bogus_irq_restore
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol sched_set_fifo_low
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol schedule_timeout_idle
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol system_state
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol ktime_get_mono_fast_ns
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol jiffies
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol __udelay
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol kmalloc_caches
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol __kmalloc_cache_noprof
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol kthread_should_stop
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol sched_set_normal
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol schedule_timeout_interruptible
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol tracing_off
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol rcu_cpu_stall_suppress
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol ftrace_dump
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol __wake_up
>> depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol __rcu_read_lock
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol rcu_lock_map
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol debug_lockdep_rcu_enabled
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol rcu_is_watching
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol lockdep_rcu_suspicious
>> depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol __rcu_read_unlock
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol call_rcu
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol lock_acquire
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol lock_release
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol srcu_check_nmi_safety
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol __srcu_read_lock
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol __srcu_read_unlock
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol srcu_batches_completed
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol call_srcu
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol srcu_barrier
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol synchronize_srcu
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol synchronize_srcu_expedited
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol __init_srcu_struct
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol cleanup_srcu_struct
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol rcu_trace_lock_map
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol rcu_read_unlock_trace_special
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol si_mem_available
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol kvfree_call_rcu
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol __might_resched
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol __SCT__cond_resched
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol rcu_tasks_trace_qs_blkd
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol rcu_trc_cmpxchg_need_qs
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol param_ops_bool
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol param_ops_int
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol param_ops_charp
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol delayed_work_timer_fn
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol rcu_get_gp_seq
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol rcu_exp_batches_completed
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol rcu_barrier
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol synchronize_rcu
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol synchronize_rcu_expedited
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol call_rcu_tasks
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol rcu_barrier_tasks
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol synchronize_rcu_tasks
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol get_rcu_tasks_gp_kthread
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol call_rcu_tasks_rude
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol rcu_barrier_tasks_rude
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol synchronize_rcu_tasks_rude
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol get_rcu_tasks_rude_gp_kthread
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol call_rcu_tasks_trace
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol rcu_barrier_tasks_trace
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol synchronize_rcu_tasks_trace
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/rcuscale.ko needs unknown symbol get_rcu_tasks_trace_gp_kthread
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/refscale.ko needs unknown symbol strcmp
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/refscale.ko needs unknown symbol _printk
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/refscale.ko needs unknown symbol kernel_power_off
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/refscale.ko needs unknown symbol __init_waitqueue_head
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/refscale.ko needs unknown symbol schedule_timeout_uninterruptible
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/refscale.ko needs unknown symbol __kmalloc_noprof
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/refscale.ko needs unknown symbol __warn_printk
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/refscale.ko needs unknown symbol kfree
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/refscale.ko needs unknown symbol __might_sleep
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/refscale.ko needs unknown symbol __SCT__might_resched
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/refscale.ko needs unknown symbol init_wait_entry
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/refscale.ko needs unknown symbol prepare_to_wait_event
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/refscale.ko needs unknown symbol schedule
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/refscale.ko needs unknown symbol finish_wait
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/refscale.ko needs unknown symbol pcpu_hot
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/refscale.ko needs unknown symbol cpu_bit_bitmap
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/refscale.ko needs unknown symbol set_user_nice
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/refscale.ko needs unknown symbol schedule_timeout_interruptible
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/refscale.ko needs unknown symbol trace_hardirqs_off
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/refscale.ko needs unknown symbol ktime_get_mono_fast_ns
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/refscale.ko needs unknown symbol trace_hardirqs_on
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/refscale.ko needs unknown symbol __wake_up
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/refscale.ko needs unknown symbol __ubsan_handle_divrem_overflow
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/refscale.ko needs unknown symbol warn_bogus_irq_restore
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/refscale.ko needs unknown symbol kmalloc_caches
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/refscale.ko needs unknown symbol __kmalloc_cache_noprof
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/refscale.ko needs unknown symbol sprintf
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/refscale.ko needs unknown symbol strlen
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/refscale.ko needs unknown symbol strcat
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/refscale.ko needs unknown symbol rcu_lock_map
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/refscale.ko needs unknown symbol __rcu_read_unlock
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/refscale.ko needs unknown symbol __rcu_read_lock
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/refscale.ko needs unknown symbol debug_lockdep_rcu_enabled
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/refscale.ko needs unknown symbol rcu_is_watching
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/refscale.ko needs unknown symbol lockdep_rcu_suspicious
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/refscale.ko needs unknown symbol __udelay
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/refscale.ko needs unknown symbol __ndelay
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/refscale.ko needs unknown symbol lock_acquire
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/refscale.ko needs unknown symbol lock_release
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/refscale.ko needs unknown symbol srcu_check_nmi_safety
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/refscale.ko needs unknown symbol __srcu_read_lock
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/refscale.ko needs unknown symbol __srcu_read_unlock
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/refscale.ko needs unknown symbol rcu_trace_lock_map
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/refscale.ko needs unknown symbol rcu_read_unlock_trace_special
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/refscale.ko needs unknown symbol __rwlock_init
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/refscale.ko needs unknown symbol _raw_read_lock
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/refscale.ko needs unknown symbol _raw_read_unlock
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/refscale.ko needs unknown symbol __init_rwsem
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/refscale.ko needs unknown symbol down_read
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/refscale.ko needs unknown symbol up_read
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/refscale.ko needs unknown symbol preempt_count_add
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/refscale.ko needs unknown symbol _raw_spin_lock
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/refscale.ko needs unknown symbol _raw_spin_unlock
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/refscale.ko needs unknown symbol preempt_count_sub
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/refscale.ko needs unknown symbol __SCT__preempt_schedule
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/refscale.ko needs unknown symbol _raw_spin_lock_irqsave
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/refscale.ko needs unknown symbol _raw_spin_unlock_irqrestore
   depmod: WARNING: /tmp/kernel/i386-randconfig-002-20240724/clang-18/dbae13ff5e8d04476cede99ca67c4be77c2a7886/lib/modules/6.10.0-12031-gdbae13ff5e8d/kernel/kernel/rcu/refscale.ko needs unknown symbol ktime_get_real_fast_ns

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
